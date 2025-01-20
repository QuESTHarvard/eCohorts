* India MNH ECohort Data Program to run all cleaning modules and create codebooks
* Created by MK Trimner
* Last Updated: 2024-08-08
* Version Number: 	1.00
*------------------------------------------------------------------------------*

/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-12-12		1.01	MK Trimner		Original 
*******************************************************************************/

* Set a global with the Country name
global Country IN

* Clean Module 1
do "${github}/India/crEco_cln_IN_M1.do"

* Clean Module 2
do "${github}/India/crEco_cln_IN_M2.do" 

* Clean Module 3
do "${github}/India/crEco_cln_IN_M3.do"


* Clean Module 4


* Clean Module 5



* Run the derived variables program
* run derived variables
* Change date_m1 to m1_date
gen m1_date = date(date_m1,"DMY")
char m1_date[Module] 1
char m1_date[Original_IN_Varname] `date_m1[Original_IN_Varname]'

label var m1_date "`:var label date_m1'"
order m1_date, after(date_m1)
drop date_m1

* Confirm that all the variables have labels and chars
	* Confirm that all variables have a module, original var number and that the labels add 
	foreach v of varlist * {
		if "``v'[Module]'" == "" di "`v'"
	}
	
	foreach v of varlist * {
		if "``v'[Original_IN_Varname]'" == "" di "`v'"
	}

  	
	* Run the derived variable code
do "${github}/India/crEco_der_IN.do"

	foreach v of varlist * {
		if "``v'[Module]'" == "" di "`v'"
	}
	
	foreach v of varlist * {
		if "``v'[Original_IN_Varname]'" == "" di "`v'"
	}


* Rename m1_802a to be m1_802 to align with KE
rename m1_802a m1_802
* Rename m1_802_date_in to be m1_802a to align with all other countries
rename m1_802_date_in m1_802a

rename enrollage m1_enrollage

rename pulse_rate_time_3 time_3_pulse_rate
foreach v in phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i height_m height_cm weight_kg  ///
	time_1_pulse_rate bp_time_1_systolic bp_time_1_diastolic ///
	time_2_pulse_rate bp_time_2_systolic  bp_time_2_diastolic ///
	time_3_pulse_rate  bp_time_3_systolic bp_time_3_diastolic  {
	if "``v'[Module]'"=="1" capture rename `v' m1_`v'
}

rename m2_maternal_death_how_other_r10 m2_maternal_death_learn_oth_r10
label var m2_maternal_death_learn_oth_r10 "R10: How learned about maternal death: Other specified"

foreach v in m2_maternal_death_how_other_r1 m2_maternal_death_how_other_r2 m2_maternal_death_how_other_r3 m2_maternal_death_how_other_r4 m2_maternal_death_how_other_r5 m2_maternal_death_how_other_r6 m2_maternal_death_how_other_r7 m2_maternal_death_how_other_r8 m2_maternal_death_how_other_r9  {
	 rename `v' `=subinstr("`v'","m2_maternal_death_how_other_","m2_maternal_death_learn_other_",1)'
}

* Drop all the variables we dont need
foreach v of varlist * {
	qui count if missing(`v')
	if "``v'[Original_IN_Varname]'" == "Not in Dataset" & `r(N)' == _N drop `v'
}


* These variables are missing for all so lets drop them
foreach v of varlist  m2_313_r* m2_316_r*  {
	assert missing(`v')
	drop `v'
}

foreach v in m3_503_IN m3_513a_IN m3_512_1_IN m3_513b_IN {
	rename `v' `=subinstr("`v'","_IN","",.)'
}

drop *_ZA *_KE *_ET 

* Add the standardized labels for codebook purposes
m1_add_shortened_labels
m2_add_shortened_labels
m3_add_shortened_labels
*m4_add_shortened_labels
*m5_add_shortened_labels


* Remove any wonky value labels
 local 98 "Don't know","Don´t know","Don't know"
 local 99 "No response/ refused","No response/refusal","No response/refusal"
 
 
foreach v of varlist * {

	local lab `:value label `v''
	if "`lab'" != "" {
		di "`v'....."
		label list `lab' 
		foreach i in 98 99 {			
			qui count if `v' == `i' 
			local value = trim("`:label `lab' `i''")
			if `r(N)' == 0  & "`value'" != "`i'" & inlist("`value'","``i''")  label define `lab' `i' "", modify
			local value = trim("`:label `lab' `i''")
			qui count if `v' == `i'
			if `r(N)' == 0 & "`value'" != "`i'" {
				di "`lab' `i' "
				label define `lab' `i' "", modify
			}
		}
	}
}


 * Save as a completed dataset
save "$in_data_final/eco_IN_Complete", replace

********************************************************************************
********************************************************************************
* Create codebooks
********************************************************************************
********************************************************************************

* Run the code to create the codebooks
capture erase "${in_data_final}/${Country}_Codebooks.xlsx"

* Create the codebooks
foreach v in 1 2 3 { //4 5 6 { 
		create_module_codebook, country(IN) outputfolder($in_data_final) codebook_folder($in_data_final/Archive/Codebook) module_number(`v') module_dataset(eco_IN_Complete) id(respondentid) special
		
}

****************************************************************************
****************************************************************************
* Clean up the folder
	
	* Now we want to clean up the output folder
	local today = today() 
	local today : di %td `today'
	di "`today'"
	
	* Put the files in a folder with today's date
	
	capture mkdir "$in_data_final/Archive/`today'"
	
	* Archive all unnecessary other files
	foreach v in eco_m1_and_m2_in eco_m1_in  eco_m1_in_der eco_m1_m2_m3_in eco_m1-m3_in eco_m2_in_long eco_m2_in_wide eco_m3_in {
		capture confirm file "$in_data_final/`v'.dta"
		if _rc == 0 {
			copy "$in_data_final/`v'.dta" "$in_data_final/Archive/`today'/`v'.dta", replace
			erase "$in_data_final/`v'.dta" 
		}
	}

********************************************************************************
********************************************************************************
* Do some basic DQ checks
********************************************************************************
********************************************************************************


	/* Confirm that all dates are sensical
	
	use "$in_data_final/eco_IN_Complete", clear
foreach i in 5 4 3  {
	local start = `i' - 1
	local loop 
	forvalues n= 1/`start' {
		if `n' != 2 local loop `n' `loop'
	}
	foreach n in `loop' {
		di "Date `i' compared to Date`n'..."
		assertlist m`i'_date > m`n'_date if !missing(m`i'_date) & !missing(m`n'_date), list(respondentid m1_date m3_date m4_date m5_date m3_202) tag(m`i' date should be after m`n'_date)
		
		assertlist !missing(m`n'_date) if !missing(m`i'_date), list(respondentid m1_date m3_date m4_date m5_date m3_202) tag(m`n'_date should be populated if m`i'_date populated)
		
		*assertlist missing(m`i'_date) if missing(m`n'_date), list(respondentid m`i'_date m`n'_date) tag(m`i'_date should be missing if missing m`n'_date populated)		
	}
	
}

*assertlist mcard_date == m1_date if !missing(m1_date) & !missing(mcard_date), list(respondentid m1_date m3_date m4_date m5_date mcard_date m3_202) tag(mcard date should be after m1_date)


* Confirm the estimated delivery date is after the first interview date
assertlist mcard_edd > m1_date, list(respondentid edd m1_date)

local i 1
foreach v in m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10 {
	
	di "Date R`i' - `v'"
	assertlist `v' > m1_date if !missing(`v'), list(respondentid m1_date m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10)
	
	di "... Compared to M3 date"
	assertlist `v' <= m3_date if !missing(`v') & !missing(m3_date), list(respondentid m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10 m3_date)
	
	di "... Compared to M4 date"
	assertlist `v' <= m4_date if !missing(`v') & !missing(m4_date), list(respondentid m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10 m4_date)
	
	di "... Compared to M5 date"
	assertlist `v' <= m4_date if !missing(`v') & !missing(m5_date), list(respondentid m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10 m5_date)
	local ++i
}

forvalues i = 1/10 {
	di "R`i' : Confirm delivery date is before the interview date"
	assertlist m2_202_delivery_date_r`i'  <= m2_date_r`i' if !missing(m2_202_delivery_date_r`i'), list(respondentid m2_202_delivery_date_r`i'   m2_date_r`i')
}
forvalues i = 1/10 {	
	di "R`i': Confirm delivery date is before M3 date"
	assertlist m2_202_delivery_date_r`i' < m3_date if !missing(m2_202_delivery_date_r`i'), list(respondentid m2_202_delivery_date_r`i' m3_date)
}

forvalues i= 1/10 {
	di "R`i': Confirm delivery date is before M4 date"
	assertlist m2_202_delivery_date_r`i' < m4_date if !missing(m2_202_delivery_date_r`i'), list(respondentid m2_202_delivery_date_r`i' m4_date)
}

forvalues i= 1/10 {
	di "R`i': Confirm delivery date is before M5 date"
	assertlist m2_202_delivery_date_r`i' < m5_date if !missing(m2_202_delivery_date_r`i'), list(respondentid m2_202_delivery_date_r`i' m5_date)
}
forvalues i= 1/10 {
	di "R`i': Confirm delivery date is the same as m3_birth_or_ended"
	assertlist m2_202_delivery_date_r`i' == m3_birth_or_ended if !missing(m2_202_delivery_date_r`i'), list(respondentid m2_202_delivery_date_r`i' m3_birth_or_ended)
}


* Confirm date labor started is before or equal to delivery date
assertlist m3_506_date >= m3_birth_or_ended if !missing(m3_506_date), list(respondentid m3_506_date m3_birth_or_ended)


* Confirm the baby death dates are after delivery dates
assertlist m3_313a_baby1 >= m3_birth_or_ended if !missing(m3_313a_baby1), list(respondentid m3_313a_baby1 m3_birth_or_ended)

* Confirm the baby death dates are after delivery dates
assertlist m3_313a_baby2 >= m3_birth_or_ended if !missing(m3_313a_baby2), list(respondentid m3_313a_baby2 m3_birth_or_ended)

* Confirm the delivery date provided in M4 is the same as the one in M3
assertlist m4_date_delivery == m3_birth_or_ended if !missing(m4_date_delivery), list(respondentid m3_birth_or_ended m4_date_delivery)


* Check all adult weights
assertlist m5_weight >= 35 & m5_weight <= 136 if !missing(m5_weight), list(respondentid m5_weight)

assertlist m1_weight_kg <= 136 & m1_weight_kg >= 35 if !missing(m1_weight_kg), list(respondentid m1_weight_kg)

* Now confirm that the two weights are relative to eachother 
*assertlist m1_weight_kg <= m5_weight if !missing(m5_weight), list(respondentid m1_weight m5_weight m1_804 m1_date m3_birth_or_ended m4_date_delivery m5_dateconfirm)

assertlist abs(m5_weight-m1_weight_kg) <=30 if !missing(m5_weight) & !missing(m1_weight_kg), list(respondentid m1_weight_kg m5_weight m1_804 m1_date m5_date)

* Confirm that the apgar scores are less than 10 and child's weight
foreach v of varlist mcard*_apgar*  mcard_b1_babywgt mcard_b2_babywgt {
	assertlist `v' <=10 if !missing(`v'), list(respondentid `v')
}

foreach v in m3_baby1_weight m3_baby2_weight {
	assertlist `v' <= 10 if !missing(`v'), list(respondentid `v')
}

foreach v in m5_baby1_weight m5_baby2_weight {
		assertlist `v' <= 10 if !missing(`v'), list(respondentid `v')
}

* Confirm that the weight in m5 is larger than m3
assertlist m3_baby1_weight < m5_baby1_weight if !missing(m3_baby1_weight), list(respondentid m3_baby1_weight m5_baby1_weight m3_date m5_date)
assertlist m3_baby2_weight < m5_baby2_weight if !missing(m3_baby2_weight), list(respondentid m3_baby2_weight m5_baby2_weight m3_date m5_date)

* The birth weight shoud be equal in both the M3 and MCARD Datsets
*assertlist  abs(m3_baby1_weight - mcard_b1_babywgt)< 5 if !missing(mcard_b1_babywgt) & !missing(m3_baby1_weight) , list(respondentid m3_baby1_weight mcard_b1_babywgt)

*assertlist  abs(m3_baby2_weight - mcard_b2_babywgt)< 5 if !missing(mcard_b2_babywgt) & !missing(m3_baby2_weight) , list(respondentid m3_baby2_weight mcard_b2_babywgt)


* Check the height variables
assertlist m1_height_cm >= 120 & m1_height_cm < 199 if !missing(m1_height_cm), list(respondentid m1_height_cm m1_enrollage)
assertlist m5_height >= 120 & m5_height < 199 if !missing(m5_height), list(respondentid m5_height m1_enrollage)
assertlist abs(m1_height_cm - m5_height) <= 5 if !missing(m5_height) & !missing(m1_height_cm), list(respondentid m1_height_cm m5_height)

