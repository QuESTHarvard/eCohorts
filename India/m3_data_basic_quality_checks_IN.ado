* m3_data_basic_quality_checks Module 3 
* Created by MK Trimner
* Last Updated: 2024-0-12
* Version Number: 	1.01
*------------------------------------------------------------------------------*

/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-08-08		1.01	MK Trimner		Original M3 file
* 2024-09-12	1.02	MK Trimner		Added call to m3_data_basic_quality_checks
*									
*******************************************************************************/


capture program drop m3_data_basic_quality_checks_IN
program define m3_data_basic_quality_checks_IN

	local country = lower("$Country")
	
	local excel Module_3_Data_quality_checks.xlsx
	local output ${`country'_data} // this will be saved to the raw data folder
	
	
	* Create copies of variables
	capture clonevar m3_date = m3_102
	capture clonevar m3_hiv_status = m3_108
	
	* CD to the location that you want to save the D checks
	cd "`output'"

	* Erase the older version of this excel file
	capture erase "`excel'"

	* Set up a local with the standard assertlist values that will be used for all assertions
	local ids respondentid 
	local standard_values idlist(`ids') excel(`excel')
	
		
	/*if "${Country}" != "IN" {
		
		* Merge in the birth outcome
		preserve
		import excel "$birth_outcomes",describe
		return list
		forvalues i = 1/`r(N_worksheet)' {
			if strpos("`r(worksheet_`i')'","$Country") == 1 local sheetname `r(worksheet_`i')'
		}

			import excel "$birth_outcomes", sheet("`sheetname'") firstrow clear
		tostring respondentid, replace
		replace respondentid = trim(respondentid)
		foreach v of varlist * {
			if !inlist("`v'","respondentid","birth_outcome") rename `v' boc_`v'
		}
		
		tempfile birth_outcomes
		save `birth_outcomes', replace
		restore

		merge 1:1 respondentid using "`birth_outcomes'", nogen
	}
	*/
	if "$Country" == "IN" {
		destring m3_107, replace force
		gen birth_outcome = Q107_Result == 1 //!missing(m3_1201) if m3_303_b1 == 1 | m3_303_b1 == 2 | m3_303_b3 == 1 
	}
	**************************************************
	**************************************************
	**************************************************

	label define M1 1 "M3" 2 "M1" 3 "M1 & M3", replace
	label define M2 1 "M3" 2 "M2" 3 "M2 & M3", replace

	capture drop m2_* 

	***************************************
	***************************************
	***************************************

	local sheet_name general_information
	local org_sheet `sheet_name'


	* Bring in the m1 and m2 data
	preserve
	merge 1:1 respondentid using  "${`country'_data_final}\eco_m1_`country'", keepusing(respondentid m1_803a_in m1_803b_in date_m1 m1_802a m1_708b)
*	merge 1:1 respondentid using  "${`country'_data_final}\Archive\eco_m1_`country'", keepusing(respondentid m1_803b date_m1 m1_802a m1_708b)
	rename date_m1 m1_date
	rename _merge match_to_M1
	label value match_to_M1 M1


	assertlist match_to_M1 != 1, tag(Respondents do not have a match in M1 dataset) list(match_to_M1) `standard_values' sheet(`sheet_name')
	
	keep if match_to_M1 != 2
	tempfile m1
	
	gen t = date(m1_date,"DMY")
	format %td t
	rename m1_date org_m1_date
	rename t m1_date
	save `m1', replace
	restore


	preserve
*	merge 1:1 respondentid using  "${`country'_data_final}\eco_m2_`country'", keepusing(respondentid m2_202_r1 m2_202_r2 m2_202_r3 m2_202_r4 m2_202_r5 m2_202_r6 m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_hiv_status_r1 m2_hiv_status_r2 m2_hiv_status_r3 m2_hiv_status_r4 m2_hiv_status_r5 m2_hiv_status_r6 m2_hiv_status_r6 m2_maternal_death_reported_r1 m2_maternal_death_reported_r2 m2_maternal_death_reported_r3 m2_maternal_death_reported_r4 m2_maternal_death_reported_r5 m2_maternal_death_reported_r6 m2_date_of_maternal_death_r1 m2_date_of_maternal_death_r2 m2_date_of_maternal_death_r3 m2_date_of_maternal_death_r4 m2_date_of_maternal_death_r5 m2_date_of_maternal_death_r6  m2_maternal_death_learn_r1 m2_maternal_death_learn_r2 m2_maternal_death_learn_r3 m2_maternal_death_learn_r4 m2_maternal_death_learn_r5 m2_maternal_death_learn_r6)
	
	merge 1:1 respondentid using  "${`country'_data_final}\Archive\eco_m2_`country'_wide", keepusing(respondentid m2_202_r1 m2_202_r2 m2_202_r3 m2_202_r4 m2_202_r5 m2_202_r6 m2_202_r7 m2_202_r8 m2_202_r9 m2_202_r10 m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10  m2_hiv_status_r1 m2_hiv_status_r2 m2_hiv_status_r3 m2_hiv_status_r4 m2_hiv_status_r5 m2_hiv_status_r6 m2_hiv_status_r6 m2_hiv_status_r7 m2_hiv_status_r8 m2_hiv_status_r9 m2_hiv_status_r10 m2_maternal_death_reported_r1 m2_maternal_death_reported_r2 m2_maternal_death_reported_r3 m2_maternal_death_reported_r4 m2_maternal_death_reported_r5 m2_maternal_death_reported_r6 m2_maternal_death_reported_r7 m2_maternal_death_reported_r8 m2_maternal_death_reported_r9 m2_maternal_death_reported_r10 m2_date_of_maternal_death_r1 m2_date_of_maternal_death_r2 m2_date_of_maternal_death_r3 m2_date_of_maternal_death_r4 m2_date_of_maternal_death_r5 m2_date_of_maternal_death_r6 m2_date_of_maternal_death_r7 m2_date_of_maternal_death_r8 m2_date_of_maternal_death_r9 m2_date_of_maternal_death_r10 m2_maternal_death_learn_r1 m2_maternal_death_learn_r2 m2_maternal_death_learn_r3 m2_maternal_death_learn_r4 m2_maternal_death_learn_r5 m2_maternal_death_learn_r6 m2_maternal_death_learn_r7 m2_maternal_death_learn_r8 m2_maternal_death_learn_r9 m2_maternal_death_learn_r10)

	rename _merge match_to_M2
	label value match_to_M2 M2

	assertlist match_to_M2 != 1,  tag(Respondents do not have a match in M2 dataset) list(match_to_M2)  `standard_values' sheet(`sheet_name')
	keep if match_to_M2 != 2

	tempfile m2
	save `m2'
	restore 


	merge 1:1 respondent using `m1', nogen
	merge 1:1 respondent using `m2', nogen

	gen module_status = 1 if match_to_M1 == 1 & match_to_M2 ==1
	replace module_status = 2 if match_to_M1 == 3 &  match_to_M2 == 1
	replace module_status = 3 if match_to_M1 == 1 &  match_to_M2 == 3
	replace module_status = 4 if match_to_M1 == 3 & match_to_M2 == 3
	label define M3 1 "M3" 2 "M1 & M3" 3 "M2 & M3" 4 "M1 & M2 & M3",replace
	label value module_status M3
	
	gen max_m2_date = max(m2_date_r1,m2_date_r2,m2_date_r3,m2_date_r4,m2_date_r5,m2_date_r6, m2_date_r7, m2_date_r8, m2_date_r9, m2_date_r10 )
	format %td  max_m2_date 
	
	clonevar m3_ga = m3_107

	***************************************
	***************************************
	***************************************
	local sheet_name confirm_last_m2_values
	local org_sheet `sheet_name'

	assertlist inlist(m3_202,2,3) if m3_109 != 1,  tag(m3_202 (`m3_202[Original_${Country}_Varname]' : `:var label m3_202') should have a value of 2 or 3 if mother death not reported) list(m3_202 m3_109) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_202) if m3_109 == 1, tag(m3_202 (`m3_202[Original_${Country}_Varname]' : `:var label m3_202') should only be populated if mother death not reported) list(m3_202 m3_109) `standard_values' sheet(`sheet_name')

	* Confirm that the last M2 interview values align with the M3 values
	gen last_m2_202 = m2_202_r1
	forvalues i = 2/10 {
		replace last_m2_202 = m2_202_r`i' if !missing(m2_202_r`i')
	}

	*assertlist last_m2_202 == m3_202 if !missing(last_m2_202),  tag(m3_202 (`m3_202[Original_${Country}_Varname]' : `:var label VAR') should match the last M2 m2_202 value) list(m3_202 m2_202_r1 m2_202_r2 m2_202_r3 m2_202_r4 m2_202_r5 m2_202_r6 m2_202_r7 m2_202_r8 m2_202_r9 m2_202_r10) `standard_values' sheet(`sheet_name')

	* confirm the HIV status is the same for M2 and M3
	gen last_m2_108 = m2_hiv_status_r1
	forvalues i = 2/10 {
		replace last_m2_108 = m2_hiv_status_r`i' if !missing(m2_hiv_status_r`i')
	}

	*clonevar m3_108 = m3_hiv_status
	assertlist last_m2_108== m3_108 if !missing(last_m2_108) & !missing(m3_108),  tag(m3_108 (`m3_108[Original_${Country}_Varname]' : `:var label m3_108') should match the last M2 m2_hiv_status value) list(m3_108 m2_hiv_status_r1 m2_hiv_status_r2 m2_hiv_status_r3 m2_hiv_status_r4 m2_hiv_status_r5 m2_hiv_status_r6 m2_hiv_status_r7 m2_hiv_status_r8 m2_hiv_status_r9 m2_hiv_status_r10) `standard_values' sheet(`sheet_name')

	/* confirm that the maternal death reported matches the last M2 value
	local m2_maternal_death_reported	maternal_death_reported //109 
	local m2_date_of_maternal_death 	date_of_maternal_death //110
	local m2_maternal_death_learn 		maternal_death_learn //111
	foreach v in m2_maternal_death_reported m2_date_of_maternal_death m2_maternal_death_learn {
		gen last_m2_``v'' = `v'_r1
		forvalues i = 2/6 {
			replace last_m2_``v'' = `v'_r`i' if !missing(`v'_r`i')
		}

		assertlist last_m2_``v''== m3_``v'' if !missing(last_m2_``v'') & !missing(m3_``v''),  tag(m3_``v'' (`m3_``v''[Original_${Country}_Varname]' : `:var label VAR') should match the last M2 `v'' value) list(m3_``v'' `v'_r1-`v'_r6) `standard_values' sheet(`sheet_name')
	}*/
	**************************************************
	**************************************************
	**************************************************
	local sheet_name general_information
	local org_sheet `sheet_name'

	assertlist m3_permission == 1, tag(m3_permission (`m3_permission[Original_${Country}_Varname]' : `:var label m3_permission') should be set to yes for all respondents) list(m3_permission) `standard_values' sheet(`sheet_name')


	format %td m3_date

	assertlist !missing(m3_date), tag(m3_date (`m3_date[Original_${Country}_Varname]' : `:var label m3_date') should be popualted) list(m3_date) `standard_values' sheet(`sheet_name')

	*assertlist (m3_date >= max_m2_date) if !missing(m3_date) & !missing(max_m2_date), tag(m3_date (`m3_date[Original_${Country}_Varname]' : `:var label VAR') should be after or equal to last M2 date) list(m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10  max_m2_date m3_date) `standard_values' sheet(`sheet_name')

	assertlist (m3_date > m1_date) if !missing(m3_date) & !missing(m1_date), tag(m3_date (`m3_date[Original_${Country}_Varname]' : `:var label m3_date') should be after M1 date) list(m1_date m3_date) `standard_values' sheet(`sheet_name')

	**************************************************
	**************************************************
	**************************************************

	local viable 28
	if "${Country}" == "ZA" local viable 26
	
	gen before_viable = !missing(birth_outcome)
	gen baby_alive = m3_303_b1 == 1 | m3_303_b2 == 1 | m3_303_b3 == 1
	gen miscarriage = before_viable == 1 if baby_alive == 0
	replace miscarriage = 2 if baby_alive == 1
	
	label var miscarriage "Baby born before `viable' weeks and died"
	label define miscarriage 1 "Miscarriage - baby born before `viable' weeks" 0 "Baby not considered viable as born/loss before `viable' weeks" 2 "Baby is alive", replace
	label value miscarriage miscarriage
	capture drop m2_date* end_date diff*

	**************************************************
	**************************************************
	**************************************************	

	* The questions in the next section should all be missing if child was born before 26 weeks and had a miscarriage
	* 
	local sheet_name outcome_nb_health
	local org_sheet `sheet_name'

	assertlist inlist(m3_301,1,2,3,98,99) if inlist(m3_202,2,3) , tag(m3_301 (`m3_301[Original_${Country}_Varname]' : `:var label m3_301') should have a value of 1-3,98 or 99 if delivered or something else happened) list(m3_202 m3_301 ) `standard_values' sheet(`sheet_name')

	assertlist missing(m3_301) if !inlist(m3_202,2,3), tag(m3_301 (`m3_301[Original_${Country}_Varname]' : `:var label m3_301') should only be populated if delivered or something else happened) list(m3_202 m3_301 ) `standard_values' sheet(`sheet_name')

	assertlist missing(m3_302) if !inlist(m3_202,2,3) , tag(m3_302 (`m3_302[Original_${Country}_Varname]' : `:var label m3_302') should only be populated if delivered or something else happened) list(m3_202 m3_302 ) `standard_values' sheet(`sheet_name')

	assertlist m3_302 > m1_date if inlist(m3_202,2,3) & !missing(m3_302) & !missing(m1_date), tag(m3_302 (`m3_302[Original_${Country}_Varname]' : `:var label m3_302') should be after the M1 date) list(m3_202 m3_302 m1_date) `standard_values' sheet(`sheet_name')

	*assertlist m3_302 > max_m2_date if inlist(m3_202,2,3) & !missing(m3_302) & !missing(max_m2_date), tag(m3_302 (`m3_302[Original_${Country}_Varname]' : `:var label VAR') should be after the last M2 date) list(m3_202 m3_302 m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10 ) `standard_values' sheet(`sheet_name')

	assertlist m3_302 <= m3_date if inlist(m3_202,2,3) & !missing(m3_302) & !missing(m3_302), tag(m3_302 (`m3_302[Original_${Country}_Varname]' : `:var label m3_302') should be before or equal to M3 date) list(m3_302 m3_date) `standard_values' sheet(`sheet_name')

	*assertlist abs(m3_302 - m3_date) >= 2 if inlist(m3_202,2,3) & !missing(m3_302), tag(m3_302 (`m3_302[Original_${Country}_Varname]' : `:var label VAR') is <= 2 days before M3 date, confirm values) list(m3_302 m3_date) `standard_values' sheet(`sheet_name')

	local 1 b
	local 2 c
	local 3 d

	local 1_l  inlist(m3_301,1,2,3)
	local 2_l  inlist(m3_301,2,3)
	local 3_l  inlist(m3_301,3)

	gen age_at_interview = m3_date - m3_302 if !missing(m3_302)
	replace age_at_interview = int(m3_306_b1 * 7) if missing(age_at_interview) 

	foreach v in 1 2 3 {
		local sheet_name `org_sheet'_baby_`v'
		
		assertlist inlist(m3_303_b`v',0,1,99) if ``v'_l', tag(m3_303_b`v' (`m3_303_b`v'[Original_${Country}_Varname]' : `:var label m3_303_b`v'') should have a value of 0,1 or 99 if number of babies >= `v') list(m3_301 m3_303_b`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_303_b`v') if !``v'_l', tag(m3_303_b`v' (`m3_303_b`v'[Original_${Country}_Varname]' : `:var label m3_303_b`v'') should only be populated if number of babies >=  `v') list(m3_301 m3_303_b`v') `standard_values' sheet(`sheet_name')
				
		assertlist (m3_308_b`v' > 0 & m3_308_b`v' <= 7) | inlist(m3_308_b`v',98,99) if ``v'_l' & m3_303_b`v' == 1, tag(m3_308_b`v' (`m3_308_b`v'[Original_${Country}_Varname]' : `:var label m3_308_b`v'') should have a value of between 0 and 7kg, 98 or 99 if number of babies >= `v' and baby `v' is alive) list(m3_301  m3_303_b`v' m3_308_b`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_308_b`v') if !``v'_l' | m3_303_b`v'!= 1, tag(m3_308_b`v' (`m3_308_b`v'[Original_${Country}_Varname]' : `:var label m3_308_b`v'') should only be populated if number of babies >= `v' and baby `v' is alive) list(m3_301 m3_308_b`v' m3_303_b`v') `standard_values' sheet(`sheet_name')
		
		assertlist inlist(m3_312_b`v',0,1,98,99) if ``v'_l' & m3_303_b`v' != 1 & miscarriage == 0, tag(m3_312_b`v' (`m3_312_b`v'[Original_${Country}_Varname]' : `:var label m3_312_b`v'') should have a value of 0,1,98 or 99 if baby `v' is not alive) list(m3_312_b`v' m3_303_b`v' m3_ga) `standard_values' sheet(`sheet_name')
		
		assertlist missing(m3_312_b`v') if m3_303_b`v' == 1, tag(m3_312_b`v' (`m3_312_b`v'[Original_${Country}_Varname]' : `:var label m3_312_b`v'') should only be populated if baby `v' is not alive) list(m3_312_b`v' m3_303_b`v') `standard_values' sheet(`sheet_name')
		
		assertlist m3_313a_b`v' <= m3_date if !missing(m3_313a_b`v') & !missing(m3_date), tag(m3_313a_b`v'(`m3_313a_b`v'[Original_${Country}_Varname]' : `:var label m3_313a_b`v'') should be before or equal to m3_date) list(m3_313a_b`v' m3_date) `standard_values' sheet(`sheet_name')
		
		assertlist m3_313a_b`v' >= m3_302 if !missing(m3_313a_b`v') & !missing(m3_302), tag(m3_313a_b`v'(`m3_313a_b`v'[Original_${Country}_Varname]' : `:var label m3_313a_b`v'') should be after or equal to m3_302 (date pregnancy ended)) list(m3_313a_b`v' m3_302) `standard_values' sheet(`sheet_name')
		
		assertlist m3_313a_b`v' >= max_m2_date if !missing(m3_313a_b`v') & !missing(max_m2_date), tag(m3_313a_b`v'(`m3_313a_b`v'[Original_${Country}_Varname]' : `:var label m3_313a_b`v'') should be after or equal last m2_date) list(m3_313a_b`v' max_m2_date m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10  ) `standard_values' sheet(`sheet_name')

		assertlist m3_313a_b`v' > m1_date if !missing(m3_313a_b`v') & !missing(m1_date), tag(m3_313a_b`v'(`m3_313a_b`v'[Original_${Country}_Varname]' : `:var label m3_313a_b`v'') should be after m1_date) list(m3_313a_b`v' m1_date) `standard_values' sheet(`sheet_name')

		assertlist inlist(m3_314_b`v',0,1,2,3,4,5,6,7,96) if m3_303_b`v' == 0 & miscarriage == 0, tag(m3_314_b`v' (`m3_314_b`v'[Original_${Country}_Varname]' : `:var label m3_314_b`v'') should be populated if baby `v' was born alive but died) list(m3_303_b`v' m3_312_b`v' m3_314_b`v' miscarriage) `standard_values' sheet(`sheet_name')
		
		assertlist inlist(m3_314_b`v',.) if m3_303_b`v' != 0 & miscarriage == 1, tag(m3_314_b`v' (`m3_312_b`v'[Original_${Country}_Varname]' : `:var label m3_314_b`v'') should only be populated if baby `v' was born alive but died) list(m3_303_b`v' m3_312_b`v' m3_314_b`v' miscarriage) `standard_values' sheet(`sheet_name')
			
	}

	local sheet_name `org_sheet'


	**************************************************
	**************************************************
	**************************************************
	* For the remaining sections we want to confirm that these were skipped if said had a miscarriage
	* so we will check that all the variables are missing. 
	local sheet_name had_miscarriage
	local org_sheet `sheet_name'

	gen answered_non_miscarriage = 0 if miscarriage == 1
	local vlist
	foreach v of varlist m3_4* m3_5* m3_6* m3_7* m3_8* m3_9* m3_10* m3_11* m3_1203 m3_1204 { // m3_1205 m3_1205_other m3_1206 {
		replace answered_non_miscarriage = answered_non_miscarriage + 1 if !missing(`v') & miscarriage == 1
		count if !missing(`v') & miscarriage == 1
		if `r(N)' > 0 local vlist `vlist' `v'
	}

	assertlist answered_non_miscarriage == 0 if miscarriage == 1 , tag(Respondent had a miscarriage so they should not have answered these questions) list(m3_303_b1 m3_303_b2 m3_303_b3 m3_ga m3_1201 miscarriage `vlist') `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_1201,0,1,99) if miscarriage == 1 , tag(m3_1201 (`m3_1201[Original_${Country}_Varname]' : `:var label m3_1201') should have a value of 0,1 or 99 if pregnancy loss before `viable' weeks) list(m3_1201 m3_ga m3_303_b1 m3_303_b2 m3_303_b3 miscarriage) `standard_values' sheet(`sheet_name') 
	assertlist missing(m3_1201) if miscarriage == 0 , tag(m3_1201 (`m3_1201[Original_${Country}_Varname]' : `:var label m3_1201') should only be populated if pregnancy loss before `viable' weeks) list(m3_1201 m3_ga m3_303_b1 m3_303_b2 m3_303_b3 miscarriage) `standard_values' sheet(`sheet_name') 


	assertlist inlist(m3_1202,1,2,3,4,5,99) if m3_1201 == 1, tag(m3_1202 (`m3_1202[Original_${Country}_Varname]' : `:var label m3_1202') should have a value of 1,2,3,4,5 or 99 if ppregnancy loss before `viable' weeks and went to health facility for follow-up) list(m3_1201 m3_1202 miscarriage) `standard_values' sheet(`sheet_name') 
	assertlist missing(m3_1202) if m3_1201 != 1, tag(m3_1202 (`m3_1202[Original_${Country}_Varname]' : `:var label m3_1202') should only be populated if pregnancy loss before `viable' weeks and went to health facility for follow-up) list(m3_1201 m3_1202 miscarriage) `standard_values' sheet(`sheet_name')

	* We no longer need those that had a miscarriage for the DQ checks. 
	drop if miscarriage == 1
	**************************************************
	**************************************************
	**************************************************

	local sheet_name antenatal_care
	local org_sheet `sheet_name'

	assertlist inlist(m3_401,0,1,98,99) if inlist(m3_202,2,3), tag(m3_401 (`m3_401[Original_${Country}_Varname]' : `:var label m3_401') should have a value of 0,1,98 or 99 if delivered or something else happened) list(m3_202 m3_401) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_401) if !inlist(m3_202,2,3), tag(m3_401 (`m3_401[Original_${Country}_Varname]' : `:var label m3_401') should only be populated if delivered or something else happened) list(m3_202 m3_401) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_402,1,2,3,4,5) if m3_401 == 1, tag(m3_402 (`m3_402[Original_${Country}_Varname]' : `:var label m3_402') should have a value of 1-5 if had new healthcare consultations) list(m3_401 m3_402) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_402) if m3_401 != 1, tag(m3_402 (`m3_402[Original_${Country}_Varname]' : `:var label m3_402') should only be populated if had new healthcare consultations) list(m3_401 m3_402) `standard_values' sheet(`sheet_name')

	local 1 403
	local 2 406
	local 3 409
	forvalues i = 1/3 {
		assertlist inlist(m3_``i'',0,1,98,99) if m3_402 >= `i' & !missing(m3_402), tag(m3_``i'' (`m3_``i''[Original_${Country}_Varname]' : `:var label m3_``i''') should have a value of 0,1,98 or 99 if had at least `i' new healthcare consultations) list(m3_402 m3_``i'') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_``i'') if m3_402 < `i' | missing(m3_402), tag(m3_``i'' (`m3_``i''[Original_${Country}_Varname]' : `:var label m3_``i''') should only be populated if had at least `i' new healthcare consultations) list(m3_402 m3_``i'') `standard_values' sheet(`sheet_name')

		assertlist inlist(m3_`=``i''+1',0,1,98,99) if m3_402 >= `i' & !missing(m3_402) & m3_``i'' == 0, tag(m3_`=``i''+1' (`m3_`=``i''+1'[Original_${Country}_Varname]' : `:var label m3_`=``i''+1'') should have a value of 0,1,98 or 99 if `i' consultation was not for ANC) list(m3_402 m3_`=``i''+1' m3_``i'') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_`=``i''+1') if m3_402 < `i' | missing(m3_402) | m3_``i'' == 1, tag(m3_`=``i''+1' (`m3_`=``i''+1'[Original_${Country}_Varname]' : `:var label m3_`=``i''+1'') should only be populated if `i' consultation was not for ANC) list(m3_402 m3_`=``i''+1' m3_``i'') `standard_values' sheet(`sheet_name')

		foreach v in 1 2 3 4 5 96 {
			assertlist inlist(m3_`=``i''+2'_`v',0,1) if m3_402 >= `i' & !missing(m3_402) & m3_``i'' != 1 & m3_`=``i''+1' == 0, tag(m3_`=``i''+2'_`v' (`m3_`=``i''+2'_`v'[Original_${Country}_Varname]' : `:var label m3_`=``i''+2'_`v'') should have a value of 0 or 1 if `i' consultation`i'_reason was not for ANC) list(m3_402 m3_``i'' m3_`=``i''+1' m3_`=``i''+2'_`v') `standard_values' sheet(`sheet_name')
			assertlist missing(m3_`=``i''+2'_`v') if m3_402 < `i' | missing(m3_402) | m3_``i'' == 1 |  m3_`=``i''+1' == 1, tag(m3_`=``i''+2'_`v' (`m3_`=``i''+2'_`v'[Original_${Country}_Varname]' : `:var label m3_`=``i''+2'_`v'') should only be populated if `i'' consultation was not for ANC) list(m3_402 m3_`=``i''+2'_`v' m3_``i'' m3_`=``i''+1') `standard_values' sheet(`sheet_name')
		}
		assertlist !missing(m3_`=``i''+2'_other) if m3_`=``i''+2'_96 == 1, tag(m3_`=``i''+2'_other (`m3_`=``i''+2'_other[Original_${Country}_Varname]' : `:var label m3_`=``i''+2'_other') should be populated if selected other reasons for `i' consultation) list(m3_`=``i''+2'_96 m3_`=``i''+2'_other) `standard_values' sheet(`sheet_name')
		assertlist missing(m3_`=``i''+2'_other) if m3_`=``i''+2'_96 != 1, tag(m3_`=``i''+2'_other (`m3_`=``i''+2'_other[Original_${Country}_Varname]' : `:var label m3_`=``i''+2'_other') should only be populated if selected other reasons for `i' consultation) list(m3_`=``i''+2'_96 m3_`=``i''+2'_other) `standard_values' sheet(`sheet_name')

	}
		
	**************************************************
	**************************************************
	**************************************************
	
	local sheet_name labor_and_delivery
	local org_sheet `sheet_name'

	assertlist inlist(m3_501,0,1,98,99) if m3_202 == 2, tag(m3_501 (`m3_501[Original_${Country}_Varname]' : `:var label m3_501') should be populated for all women who delivered) list(m3_202 m3_501) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_501) if m3_202 != 2, tag(m3_501 (`m3_501[Original_${Country}_Varname]' : `:var label m3_501') should only be populated for women who delivered) list(m3_202 m3_501) `standard_values' sheet(`sheet_name')

	assertlist m3_506_date <= m3_302 if m3_501 == 1 & !inlist(m3_506_date,14245,13880,.) & !missing(m3_302), tag(m3_506_date (`m3_506_date[Original_${Country}_Varname]' : `:var label m3_506_date') should be before or equal to delivery date) list(m3_506_date m3_302) `standard_values' sheet(`sheet_name')

	assertlist m3_506_date <= m3_date if m3_501 == 1 & !inlist(m3_506_date,14245,13880,.) & !missing(m3_date), tag(m3_506_date (`m3_506_date[Original_${Country}_Varname]' : `:var label m3_506_date') should be before or equal to m3_date) list(m3_506_date m3_date) `standard_values' sheet(`sheet_name')

	*assertlist m3_506_date > max_m2_date if m3_501 == 1 & !inlist(m3_506_date,14245,13880,.) & !missing(max_m2_date) , tag(m3_506_date (`m3_506_date[Original_${Country}_Varname]' : `:var label VAR') should be after last M2 date) list(m3_506_date m2_date_r1 m2_date_r2 m2_date_r3 m2_date_r4 m2_date_r5 m2_date_r6 m2_date_r7 m2_date_r8 m2_date_r9 m2_date_r10 ) `standard_values' sheet(`sheet_name')

	assertlist m3_506_date > m1_date if m3_501 == 1 & !inlist(m3_506_date,14245,13880,.) & !missing(m1_date) , tag(m3_506_date (`m3_506_date[Original_${Country}_Varname]' : `:var label m3_506_date') should be after M1 date) list(m3_506_date m1_date) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_510,0,1,98,99) if m3_501 == 1, tag(m3_510 (`m3_510[Original_${Country}_Varname]' : `:var label m3_510') should have a value of 0,1,98,99 or 95 if delivered at a health facility) list(m3_501 m3_510) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_510) if m3_501 != 1, tag(m3_510 (`m3_510[Original_${Country}_Varname]' : `:var label m3_510') should only be populated if delivered at a health facility) list(m3_501 m3_510) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_511,1,2,3,4,5) if m3_510 == 1, tag(m3_511 (`m3_511[Original_${Country}_Varname]' : `:var label m3_511') should have a value of 1,2,3,4 or 5 if went to other facility first) list(m3_510 m3_511) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_511) if m3_510 != 1, tag(m3_511 (`m3_511[Original_${Country}_Varname]' : `:var label m3_511') should only be populated if went to other facility first) list(m3_510 m3_511) `standard_values' sheet(`sheet_name')

	assertlist m3_514_date <= m3_302 if m3_510 == 1 & !missing(m3_302) & !missing(m3_514_date), tag(m3_514_date (`m3_514_date[Original_${Country}_Varname]' : `:var label m3_514_date') should be before or equal to date pregnancy ended if went to other facility first) list(m3_510 m3_514_date m3_302) `standard_values' sheet(`sheet_name')

	assertlist m3_514_date > m1_date if m3_510 == 1 & !missing(m1_date) & !missing(m3_514_date), tag(m3_514_date (`m3_514_date[Original_${Country}_Varname]' : `:var label m3_514_date') should be after to M1 date if went to other facility first) list(m3_510 m3_514_date m3_302) `standard_values' sheet(`sheet_name')

	*assertlist m3_514_date > max_m2_date if m3_510 == 1 & !missing(max_m2_date) & !missing(m3_514_date), tag(m3_514_date (`m3_514_date[Original_${Country}_Varname]' : `:var label m3_514_date') should be after last M2 date if went to other facility first) list(m3_510 m3_514_date m3_302) `standard_values' sheet(`sheet_name')

	assertlist m3_514_date <= m3_date if m3_510 == 1 & !missing(m3_date) & !missing(m3_514_date), tag(m3_514_date (`m3_514_date[Original_${Country}_Varname]' : `:var label m3_514_date') should be before or equal to M3 date if went to other facility first) list(m3_510 m3_514_date m3_302) `standard_values' sheet(`sheet_name')

	**************************************************
	**************************************************
	**************************************************

	local sheet_name intrapartum_care
	local org_sheet `sheet_name'

	foreach v in a b c {
		assertlist inlist(m3_601`v',0,1,98,99) if m3_501 == 1, tag(m3_601`v' (`m3_601`v'[Original_${Country}_Varname]' : `:var label m3_601`v' ') should have a value of 0,1,98 or 99 if delivered at a health facility) list(m3_501 m3_601`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_601`v') if m3_501 != 1, tag(m3_601`v' (`m3_601`v'[Original_${Country}_Varname]' : `:var label m3_601`v' ') should only be populated if delivered at a health facility) list(m3_501 m3_601`v') `standard_values' sheet(`sheet_name')
	}


	assertlist inlist(m3_605b,1,2,98,99) if m3_605a == 1, tag(m3_605b (`m3_605b[Original_${Country}_Varname]' : `:var label m3_605b') should have a value of 1,2,98 or 99 if delivered at a health facility and had a caesarean) list(m3_605a m3_605b) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_605b) if m3_605a != 1, tag(m3_605b (`m3_605b[Original_${Country}_Varname]' : `:var label m3_605b') should only be populated if delivered at a health facility and had a caesarean) list(m3_605a m3_605b) `standard_values' sheet(`sheet_name')


	foreach v in 0 1 2 3 96 98 99 {
		assertlist inlist(m3_605c_`v',0,1) if m3_605a == 1, tag(m3_605c_`v' (`m3_605c_`v'[Original_${Country}_Varname]' : `:var label m3_605c_`v'') should have a value of 0,1,2,3 or 96 if delivered at a health facility and had a caesarean) list(m3_605a m3_605c_`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_605c_`v') if m3_605a != 1, tag(m3_605c_`v' (`m3_605c_`v'[Original_${Country}_Varname]' : `:var label m3_605c_`v'') should only be populated if delivered at a health facility and had a caesarean) list(m3_605a m3_605c_`v') `standard_values' sheet(`sheet_name')
	}


	local b 1

	local 1 b
	local 2 c
	local 3 d

	foreach v in a b c {
		local sheet_name `org_sheet'_baby_`b'
		
		assertlist inlist(m3_618a_b`b',0,1,98,99) if m3_501 == 1 & m3_108 == 1 & (m3_303_b`b' == 1 | m3_312_b`b' == 1), tag(m3_618a_b`b' (`m3_618a_b`b'[Original_${Country}_Varname]' : `:var label m3_618a_b`b'') should have a value of 0,1,98, or 99 if delivered at a health facility and baby/babies born alive and mother was HIV positive) list(m3_501 m3_108 m3_618a_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		assertlist inlist(m3_618a_b`b',.) if m3_501 != 1 | m3_108 != 1 | (m3_303_b`b' !=1 & m3_312_b`b' != 1), tag(m3_618a_b`b' (`m3_618a_b`b'[Original_${Country}_Varname]' : `:var label m3_618a_b`b'') should only be populated if delivered at a health facility and baby/babies born alive and mother was HIV positive) list(m3_501 m3_108 m3_618a_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		assertlist inlist(m3_618b_b`b',0,1,2,98,99) if m3_501 == 1 & m3_108 == 1 & m3_618a_b`b' == 1 & (m3_303_b`b' == 1 | m3_312_b`b' == 1), tag(m3_618b_b`b' (`m3_618b_b`b'[Original_${Country}_Varname]' : `:var label m3_618b_b`b'') should have a value of 0,1,2,98, or 99 if delivered at a health facility and baby/babies born alive and mother was HIV positive and child was tested) list(m3_501 m3_108 m3_618a_b`b' m3_618b_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		assertlist missing(m3_618b_b`b') if m3_501 != 1 | m3_108 != 1 | m3_618a_b`b' != 1 | (m3_303_b`b' !=1 & m3_312_b`b' != 1), tag(m3_618b_b`b' (`m3_618b_b`b'[Original_${Country}_Varname]' : `:var label m3_618b_b`b'') should only be populated if delivered at a health facility and baby/babies born alive and mother was HIV positive and child was tested) list(m3_501 m3_108 m3_618a_b`b' m3_618b_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		
		assertlist inlist(m3_618c_b`b',0,1,98,99) if m3_501 == 1 & m3_108 == 1 & (m3_303_b`b' == 1 | m3_312_b`b' == 1), tag(m3_618c_b`b' (`m3_618c_b`b'[Original_${Country}_Varname]' : `:var label m3_618c_b`b'') should have a value of 0,1,98, or 99 if delivered at a health facility and baby/babies born alive and mother was HIV positive) list(m3_501 m3_108 m3_618c_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		assertlist inlist(m3_618c_b`b',.) if m3_501 != 1 | m3_108 != 1 | (m3_303_b`b' !=1 & m3_312_b`b' != 1), tag(m3_618c_b`b' (`m3_618c_b`b'[Original_${Country}_Varname]' : `:var label m3_618c_b`b'') should only be populated if delivered at a health facility and baby/babies born alive and mother was HIV positive) list(m3_501 m3_108 m3_618c_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		local ++b
	}

	**************************************************
	**************************************************
	**************************************************

	local sheet_name complications
	local org_sheet `sheet_name'

	assertlist inlist(m3_701,0,1,98,99) if inlist(m3_202,2,3), tag(m3_701 (`m3_701[Original_${Country}_Varname]' : `:var label m3_701') should have a value of 0,1,98 or 99 if delivered or something else happened) list(m3_202 m3_701) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_701) if !inlist(m3_202,2,3), tag(m3_701 (`m3_701[Original_${Country}_Varname]' : `:var label m3_701') should only be populated if delivered or something else happened) list(m3_202 m3_701) `standard_values' sheet(`sheet_name')

	assertlist !missing(m3_702) if m3_701 == 1, tag(m3_702 (`m3_702[Original_${Country}_Varname]' : `:var label m3_702') should be populated if delivered or something else happened and said had a complication) list(m3_701 m3_702) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_702) if m3_701 != 1, tag(m3_702 (`m3_702[Original_${Country}_Varname]' : `:var label m3_702') should only be populated if delivered or something else happened and said had a complication) list(m3_701 m3_702) `standard_values' sheet(`sheet_name')

	local org_sheet `sheet_name'
	local b 1

	local 1 b
	local 2 c
	local 3 d
	foreach v in a b c {
		local sheet_name known_skip_logic_issues_baby_`b'
		foreach q in 1 2 3 4 5 6 98 99 {
			assertlist inlist(m3_708_`q'_b`b',0,1) if (m3_303_b`b' == 1 | m3_312_b`b' == 1), tag(m3_708_`q'_b`b' (`m3_708_`q'_b`b'[Original_${Country}_Varname]' : `:var label VAR') should have a value of 0 or 1 if baby `b' born alive) list( m3_708_`q'_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')
			
			assertlist inlist(m3_708_`q'_b`b',.) if (m3_303_b`b' !=1 & m3_312_b`b' != 1), tag(m3_708_`q'_b`b' (`m3_708_`q'_b`b'[Original_${Country}_Varname]' : `:var label VAR') should only be populated if baby `b' born alive) list(m3_708_`q'_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')
		}
		
			assertlist inlist(m3_709_b`b',0,1,98,99) if (m3_303_b`b' ==1 | m3_312_b`b' == 1), tag(m3_709_b`b' (`m3_709_b`b'[Original_${Country}_Varname]' : `:var label VAR') should have a value of 0,1,98 or 99 if baby `b' born alive) list(m3_709_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')
			
			assertlist inlist(m3_709_b`b',.) if (m3_303_b`b' !=1 & m3_312_b`b' != 1), tag(m3_709_b`b' (`m3_709_b`b'[Original_${Country}_Varname]' : `:var label VAR') should only be populated if baby `b' born alive) list(m3_709_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')
			
			assertlist !missing(m3_709_other) if m3_709_b`b' == 1, tag(m3_709_other (`m3_709_other[Original_${Country}_Varname]' : `:var label VAR') should be populated if selected other health problems for baby `b' born alive) list(m3_709_other m3_709_b`b') `standard_values' sheet(`sheet_name')
			
			assertlist missing(m3_709_other) if m3_709_b`b' != 1, tag(m3_709_other (`m3_709_other[Original_${Country}_Varname]' : `:var label VAR') should only be populated if selected other health problems for baby `b' born alive) list(m3_709_other m3_709_b`b') `standard_values' sheet(`sheet_name')
			
			assertlist inlist(m3_710_b`b',0,1,98,99) if m3_501 == 1 & (m3_303_b`b' ==1 | m3_312_b`b' == 1), tag(m3_710_b`b' (`m3_710_b`b'[Original_${Country}_Varname]' : `:var label VAR') should have a value of 0,1,98,99 if baby `b' born alive in a facility) list(m3_501 m3_710_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')
			
			assertlist inlist(m3_710_b`b',.) if m3_501 != 1 | (m3_303_b`b' !=1 & m3_312_b`b' != 1), tag(m3_710_b`b' (`m3_710_b`b'[Original_${Country}_Varname]' : `:var label VAR') should only be populated if baby `b' born alive in a facility) list(m3_501 m3_710_b`b' m3_303_b`b' m3_312_b`b') `standard_values' sheet(`sheet_name')

		local ++b
	}

	local sheet_name `org_sheet'

	**************************************************
	**************************************************
	**************************************************

	local sheet_name post_partum
	local org_sheet `sheet_name'


	assertlist inlist(m3_801_a,0,1,2,3,99) if inlist(m3_202,2,3), tag(m3_801_a (`m3_801_a[Original_${Country}_Varname]' : `:var label m3_801_a') should have a value of 0,1,2,3 or 99 if delivered or something else happened) list(m3_202 m3_801_a) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_801_a) if !inlist(m3_202,2,3), tag(m3_801_a (`m3_801_a[Original_${Country}_Varname]' : `:var label m3_801_a') should only be populated if delivered or something else happened) list(m3_202 m3_801_a) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_801_b,0,1,2,3,99) if inlist(m3_202,2,3), tag(m3_801_b (`m3_801_b[Original_${Country}_Varname]' : `:var label m3_801_b') should have a value of 0,1,2,3 or 99 if delivered or something else happened) list(m3_202 m3_801_b) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_801_b) if !inlist(m3_202,2,3), tag(m3_801_b (`m3_801_b[Original_${Country}_Varname]' : `:var label m3_801_b') should only be populated if delivered or something else happened) list(m3_202 m3_801_b) `standard_values' sheet(`sheet_name')


	capture egen m3_phq2_score = rowtotal(m3_801_a m3_801_b) if inlist(m3_202,2,3) & m3_801_a < 98 & m3_801_b < 98
	recode m3_phq2_score (. 0 = .a) if (m3_801_a == . | m3_801_a == .a | m3_801_a == 98 | m3_801_a == 99) & ///
									 (m3_801_b == . | m3_801_b == .a | m3_801_b == 98 | m3_801_b == 99) | !inlist(m3_202,2,3)


	assertlist inlist(m3_802a,0,1,98,99) if m3_phq2_score >= 3 & !missing(m3_phq2_score), tag(m3_802a (`m3_802a[Original_${Country}_Varname]' : `:var label m3_802a') should have a value of 0,1,98 or 99 if delivered or something else happened and had a psych score >= 3) list(m3_801_a m3_801_b m3_phq2_score m3_802a) `standard_values' sheet(`sheet_name')
	assertlist inlist(m3_802a,.) if m3_phq2_score < 3, tag(m3_802a (`m3_802a[Original_${Country}_Varname]' : `:var label m3_802a') should only be populated if delivered or something else happened and had a psych score >= 3) list(m3_801_a m3_801_b m3_phq2_score m3_802a) `standard_values' sheet(`sheet_name')


	foreach v in 806 807 {
		assertlist !missing(m3_`v') if m3_805 == 1, tag(m3_`v' (`m3_`v'[Original_${Country}_Varname]' : `:var label m3_`v'') should be populated if experienced constant leakage) list(m3_805 m3_`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_`v') if m3_805 != 1, tag(m3_`v' (`m3_`v'[Original_${Country}_Varname]' : `:var label m3_`v'') should only be populated if experienced constant leakage) list(m3_805 m3_`v') `standard_values' sheet(`sheet_name')
	}

	assertlist inlist(m3_808a,0,1) if m3_805 == 1, tag(m3_808a (`m3_808a[Original_${Country}_Varname]' : `:var label m3_808a') should have a value of 0 or 1 if experienced constant leakage) list(m3_805 m3_808a) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_808a) if m3_805 != 1, tag(m3_808a (`m3_808a[Original_${Country}_Varname]' : `:var label m3_808a') should only be populated if experienced constant leakage) list(m3_805 m3_808a) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_808b,1,2,3,4,5,6,7,8,96,98,99) if m3_808a == 0, tag(m3_808b (`m3_808b[Original_${Country}_Varname]' : `:var label m3_808b') should have a value of 1-8,96,98 or 99 if did not seek treatment for constant leakage) list(m3_808a m3_808b) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_808b) if m3_808a != 0, tag(m3_808b (`m3_808b[Original_${Country}_Varname]' : `:var label m3_808b') should only be populated if did not seek treatment for constant leakage) list(m3_808a m3_808b) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_809,1,2,3,98,99) if m3_808a == 1, tag(m3_809 (`m3_809[Original_${Country}_Varname]' : `:var label m3_809') should have a value of 1,2,3,98 or 99 if sought treatment for constant leakage) list(m3_808a m3_809) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_809) if m3_808a != 1, tag(m3_809 (`m3_809[Original_${Country}_Varname]' : `:var label m3_809') should only be populated if sought treatment for constant leakage) list(m3_808a m3_809) `standard_values' sheet(`sheet_name')


	**************************************************
	**************************************************
	**************************************************

	local sheet_name medications_supplements
	local org_sheet `sheet_name'

	foreach v in a b c d e f g h i j k l m n o p q r {
		assertlist inlist(m3_901`v',0,1,98,99) if inlist(m3_202,2,3), tag(m3_901`v' (`m3_901`v'[Original_${Country}_Varname]' : `:var label m3_901`v'') should have a value of 0,1,98 or 99 if delivered or something else happened) list(m3_202 m3_901`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_901`v') if !inlist(m3_202,2,3), tag(m3_901`v' (`m3_901`v'[Original_${Country}_Varname]' : `:var label m3_901`v'') should only be populated if delivered or something else happened) list(m3_202 m3_901`v') `standard_values' sheet(`sheet_name')

	}

	assertlist !missing(m3_901_other) if m3_901r == 1, tag(m3_901_other (`m3_901_other[Original_${Country}_Varname]' : `:var label m3_901_other') should be populated if selected other medication/supplement) list(m3_901r m3_901_other) `standard_values' sheet(`sheet_name')
	assertlist missing(m3_901_other) if m3_901r != 1, tag(m3_901_other (`m3_901_other[Original_${Country}_Varname]' : `:var label m3_901_other') should only be populated if selected other medication/supplement) list(m3_901r m3_901_other) `standard_values' sheet(`sheet_name')

	foreach v in a b c d e f g h i j {
		assertlist inlist(m3_903`v'_b1,0,1,98,99) if m3_303_b1 == 1 | m3_303_b2 == 1 | m3_303_b3 == 1, tag(m3_903`v'_b1 (`m3_903`v'_b1[Original_${Country}_Varname]' : `:var label m3_903`v'_b1') should have a value of 0,1,98 or 99 if baby/babies are alive) list(m3_303_b1 m3_303_b2 m3_303_b3 m3_903`v'_b1) `standard_values' sheet(`sheet_name')
		assertlist missing(m3_903`v'_b1) if m3_303_b1 != 1 & m3_303_b2 != 1 & m3_303_b3 != 1, tag(m3_903`v'_b1 (`m3_903`v'_b1[Original_${Country}_Varname]' : `:var label m3_903`v'_b1') should only be populated if baby/babies are alive) list(m3_303_b1 m3_303_b2 m3_303_b3 m3_903`v'_b1) `standard_values' sheet(`sheet_name')
		
	}


	**************************************************
	**************************************************
	**************************************************

	local sheet_name user_experience
	local org_sheet `sheet_name'

	assertlist inlist(m3_1001,1,2,3,4,5,6,98) if m3_501 == 1, tag(m3_1001 (`m3_1001[Original_${Country}_Varname]' : `:var label m3_1001') should have a value of 1-6 or 98 if delivered at a health facility ) list(m3_501  m3_1001) `standard_values' sheet(`sheet_name')
	assertlist inlist(m3_1001,.) if m3_501 != 1, tag(m3_1001 (`m3_1001[Original_${Country}_Varname]' : `:var label m3_1001') should only be populated if delivered at a health facility) list(m3_501 m3_1001) `standard_values' sheet(`sheet_name')

	foreach v in b c {
		assertlist inlist(m3_1006`v',0,1,98,99) if m3_1006a == 1, tag(m3_1006`v' (`m3_1006`v'[Original_${Country}_Varname]' : `:var label m3_1006`v'') should have a value of 0,1,98 or 99 if had vaginal exam ) list(m3_1006a  m3_1006`v') `standard_values' sheet(`sheet_name')
		assertlist missing(m3_1006`v') if m3_1006a != 1, tag(m3_1006`v' (`m3_1006`v'[Original_${Country}_Varname]' : `:var label m3_1006`v'') should only be populated if had vaginal exam) list(m3_1006a m3_1006`v') `standard_values' sheet(`sheet_name')

	}

	**************************************************
	**************************************************
	**************************************************

	local sheet_name economic_outcomes
	local org_sheet `sheet_name'

	assertlist inlist(m3_1101,0,1,99) if m3_501 == 1, tag(m3_1101 (`m3_1101[Original_${Country}_Varname]' : `:var label m3_1101') should have a value of 0,1 or 99 if delivered at a health facility) list(m3_501 m3_1101) `standard_values' sheet(`sheet_name') 
	assertlist inlist(m3_1101,.) if m3_501 != 1, tag(m3_1101 (`m3_1101[Original_${Country}_Varname]' : `:var label m3_1101') should only be populated if delivered at a health facility) list(m3_501 m3_1101) `standard_values' sheet(`sheet_name')

	foreach v in a b c d e f {
		assertlist !missing(m3_1102`v') if m3_1101 == 1, tag(`"m3_1102`v' (`m3_1102`v'[Original_${Country}_Varname]' : `:var label m3_1102`v'') should be populated if paid money out of pocket for delivery"') list(m3_1101 m3_1102`v') `standard_values' sheet(`sheet_name') 
		assertlist missing(m3_1102`v') if m3_1101 != 1, tag(`"m3_1102`v' (`m3_1102`v'[Original_${Country}_Varname]' : `:var label m3_1102`v'') should only be populated if paid money out of pocket for delivery"') list(m3_1101 m3_1102`v') `standard_values' sheet(`sheet_name')
	}

	gen m3_1102_total_calc = 0 if m3_1101 == 1
	foreach v of varlist m3_1102* {
		if !inlist("`v'", "m3_1102_other","m3_1102_total_cal")	replace m3_1102_total_calc = m3_1102_total_calc + `v' if !missing(`v') & m3_1101 == 1
	}

	assertlist m3_1102_total_calc == m3_1102_total if m3_1101 == 1,tag(m3_1102_total (`m3_1102_total[Original_${Country}_Varname]' : `:var label m3_1102_total') amount does not add up to the totals of m3_1102a-m3_1102f (`m3_1102a[Original_${Country}_Varname]', `m3_1102b[Original_${Country}_Varname]', `m3_1102c[Original_${Country}_Varname]', `m3_1102d[Original_${Country}_Varname]', `m3_1102e[Original_${Country}_Varname]', `m3_1102f[Original_${Country}_Varname]')) list(m3_1102_total_calc m3_1102_total m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f) `standard_values' sheet(`sheet_name') 

	foreach v in 1 2 3 4 5 6 96 {
		assertlist inlist(m3_1105_`v',0,1) if m3_1101 == 1, tag(m3_1105_`v' (`m3_1105_`v'[Original_${Country}_Varname]' : `:var label m3_1105_`v'') should have a value of 0 or 1 if paid money out of pocket for delivery) list(m3_1101 m3_1105_`v') `standard_values' sheet(`sheet_name') 
		assertlist missing(m3_1105_`v') if m3_1101 != 1, tag(m3_1105_`v' (`m3_1105_`v'[Original_${Country}_Varname]' : `:var label m3_1105_`v'') should only be populated if paid money out of pocket for delivery) list(m3_1101 m3_1105_`v') `standard_values' sheet(`sheet_name')
	}

	assertlist inlist(m3_1106,1,2,3,4,5,98,99) if inlist(m3_202,2,3), tag(m3_1106 (`m3_1106[Original_${Country}_Varname]' : `:var label m3_1106') should have a value of 1-5,98 or 99 if delivered at a health facility or something else happened) list(m3_202 m3_1106) `standard_values' sheet(`sheet_name') 
	assertlist missing(m3_1106) if !inlist(m3_202,2,3), tag(m3_1106 (`m3_1106[Original_${Country}_Varname]' : `:var label m3_1106') should only be populated if delivered at a health facility or something else happened) list(m3_202 m3_1106) `standard_values' sheet(`sheet_name')

	**************************************************
	**************************************************
	**************************************************

	local sheet_name abortion
	local org_sheet `sheet_name'

	assertlist inlist(m3_1203,0,1,99) if m3_314_b1 == 7 | m3_314_b2 == 7 | m3_314_b3 == 7, tag(m3_1203 (`m3_1203[Original_${Country}_Varname]' : `:var label m3_1203') should have a value of 0,1 or 99 if had an abortion) list(m3_1203 m3_314_b1  m3_314_b2 m3_314_b3) `standard_values' sheet(`sheet_name') 
	assertlist missing(m3_1203) if m3_314_b1 != 7 & m3_314_b2 != 7 & m3_314_b3 != 7, tag(m3_1203 (`m3_1203[Original_${Country}_Varname]' : `:var label m3_1203') should only be populated if had an abortion) list(m3_1203 m3_314_b1  m3_314_b2 m3_314_b3 ) `standard_values' sheet(`sheet_name')

	assertlist inlist(m3_1204,1,2,3,4,5,99) if m3_314_b1 == 7 | m3_314_b2 == 7 | m3_314_b3 == 7, tag(m3_1204 (`m3_1204[Original_${Country}_Varname]' : `:var label m3_1204') should have a value of 1-5 or 99 if had an abortion) list(m3_1204 m3_314_b1  m3_314_b2 m3_314_b3) `standard_values' sheet(`sheet_name') 
	assertlist missing(m3_1204) if m3_314_b1 != 7 & m3_314_b2 != 7 & m3_314_b3 != 7, tag(m3_1204 (`m3_1204[Original_${Country}_Varname]' : `:var label m3_1204') should only be populated if had an abortion) list(m3_1204 m3_314_b1  m3_314_b2 m3_314_b3 ) `standard_values' sheet(`sheet_name')

	****************************************************************************
	****************************************************************************
	****************************************************************************


			assertlist_cleanup, excel(`excel') 
			
			* add a single tab with all the ids in one row
			assertlist_export_ids, excel(`excel') format


end
