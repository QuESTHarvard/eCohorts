* India MNH ECohort Data Cleaning File for Module 2 
* Created by MK Trimner
* Last Updated: 2024-08-28
* Version Number: 	1.03
*------------------------------------------------------------------------------*

/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-07-22		1.01	MK Trimner		Original M2 file
2024-08-07		1.02	MK Trimner		Made corrections per Shalom's 7-31-2024 email
*										Aligned m2_hiv_status with 0, 1 & 99 values and added it to the recoding for 99 = .r
*										Removed m2_203i as it is not in the IN dataset																
*2024-08-28		1.03	MK Trimner		Renamed _merge variable to identify where it came from		
* 2024-10-23	1.04	MK Trimner		Changed the way this merges so we can retain the already ordered variables
*										Added a character with the module number	
* 2024-11-13	1.05	MK Trimner		Corrected Char Original_Varname to be 
* 										Original_IN_Varname						
*******************************************************************************

										*/
* QUESTION - Gestational age - what is this supposed to be in? Why are we dropping it in ET? 

* QUESTION - what is the expected time between visits? what would be too close? too late?

* QUESTION: What are all these CALC variables calculating... looks to be based on the interview date?
* Calculate_802 Calculate_802_date Calc_weeks_remaining_1 Calculate_Q803_1 Calculate_Q803_2 Calc_weeks_remaining_2 Calc_weeks_remaining Calc_Gestational_Age

										
										
* Set a local wtih module2 file name
local module2 Module_2_24062024										


* Import Data 
clear all 
u "$in_data/`module2'.dta", clear


* Add a character with the original var name
foreach v of varlist * {
	local name `v'
	*local s1 = strpos("`v'","Q")
	*if `s1' == 1 local name = substr("`v'",2,.)
	char `v'[Original_IN_Varname] `name'
}

* Clean up the id variable to remove any spaces that may cause merging issues
replace q103 = trim(q103)
replace q103 = subinstr(q103," ","",.)


* STEP 00 - Conduct data quality checks 
* check to make sure interview date is valid
* Date is not the same for a person

* 
*------------------------------------------------------------------------------*

		* STEPS: 
		* STEP ONE: Clonevar or rename VARIABLES & Recode any one off values
		* STEP TW0: ADD VALUE LABELS/FORMATTING
		* STEP THREE: RECODING MISSING VALUES
		* STEP FOUR: LABELING VARIABLES
		* STEP FIVE: ORDER VARIABLES
		* STEP SIX: SPLIT, RESHARE M2 AND MERGE TO OBTAIN A WIDE DATASET
		* STEP SEVEN: SAVE DATA

	* MODULE 2: STEP ONE - RENAME VARIABLES
	clonevar m2_date = Q102
	*char m2_date[Original_Varname] Q102
	
	clonevar m2_respondentid = q103
	*char m2_respondentid[Original_Varname] q103
	
	clonevar m2_time_start = Q103
	*char m2_respondentid[Original_Varname] q103

	clonevar m2_ga = Q107
	
	* This contains some strings so we can convert this to a numeric value
	replace m2_ga = subinstr(m2_ga,"weeks","",.)
	replace m2_ga = subinstr(m2_ga,"wks","",.)
	replace m2_ga = subinstr(m2_ga,"w","",.)
	* There is one persone who responded with months and weeks so we will replace these to be just the week values
	* replace it to be 15 weeks (3 months = int(3*4.5) + 2
	replace m2_ga = subinstr(m2_ga,"3months 2","15",.)
	
	* Replace to be a string variable
	destring m2_ga, replace

	* Need to adjust this to align with m2_hiv_status label definition
	clonevar m2_hiv_status = Q108
		
	clonevar m2_maternal_death_reported = Q109
	clonevar m2_date_of_maternal_death = Q110
	
	clonevar m2_maternal_death_learn = Q111
	
	* This survey has a different value for other, so we want to clean this up so it aligns with other surveys
	recode m2_maternal_death_learn (96 = 5) if m2_maternal_death_reported == 96
	
	clonevar m2_maternal_death_learn_other = Q111_other
	
	clonevar m2_permission = Consent

	************************************************************
	************************************************************
	clonevar m2_201 = Q201
	clonevar m2_202 = Q202
	
	foreach v in a b c d e f g h {
		clonevar m2_203`v' = Q203_`v'
	}
	
	clonevar m2_204i = Q204
	clonevar m2_204_other = Q204_a
	
	* We need to recode those values in Q204_a to populate any valid m2_203<letters> variables
	gen other_health = trim(upper(Q204_a))
	replace other_health = subinstr(other_health, "  "," ",.)
	
	local a ECLAMPSIA
	local b BLEEDING
	local c HYPEREMSIS
	local d ANENIA
	local e CARDIAC
	local f AMNIOTIC
	local g ASTHMA
	local h RH
	
	foreach v in a b c d e f g h  {
		gen m2_204`v' = strpos(other_health,"``v''") > 0 if !missing(other_health)
		char m2_204`v'[Original_IN_Varname] 204_a
		
		list m2_204`v' other_health if m2_204`v' == 1
		label var m2_204`v' "Other problems: `=proper("``v''")'"
	}
	
	replace m2_204b = 1 if strpos(other_health,"BP") > 0 & strpos(other_health,"HIGH") > 0
	
	replace m2_203a = 1 if strpos(other_health,"HEADACHE") > 0
	replace other_health = subinstr(other_health,"HEADACHE","",.)
	
	replace m2_203b = 1 if strpos(other_health,"VAGINAL BLEEDING") > 0
	replace other_health = subinstr(other_health,"VAGINAL BLEEDING","",.)
	
	replace m2_203c = 1 if strpos(other_health,"FEVER") > 0
	replace other_health = subinstr(other_health,"FEVER","",.)
	
	replace m2_203d = 1 if strpos(other_health,"ABDOMINAL PAIN") > 0 | strpos(other_health,"STOMACH PAIN") > 0
	replace other_health = subinstr(other_health,"ABDOMINAL PAIN","",.)
	replace other_health = subinstr(other_health,"STOMACH PAIN","",.)
	
	replace m2_203e = 1 if strpos(other_health,"BREATHING") > 0
	replace other_health = subinstr(other_health,"BREATHING","",.)
	
	replace m2_203f = 1 if strpos(other_health,"CONVULS") > 0 | strpos(other_health,"SEIZURE") > 0 
	replace other_health = subinstr(other_health,"CONVULS","",.)
	replace other_health = subinstr(other_health,"SEIZURE","",.)
	
	replace m2_203g = 1 if strpos(other_health,"FAINT") > 0 | strpos(other_health,"CONSCIOUS") > 0 
	replace other_health = subinstr(other_health,"FAINT","",.)
	replace other_health = subinstr(other_health,"CONSCIOUS","",.)
	
	replace m2_203h = 1 if strpos(other_health,"STOPPED MOVING") > 0
	replace other_health = subinstr(other_health,"STOPPED MOVING","",.)
	
	replace other_health = trim(other_health)
	replace other_health = subinstr(other_health,"  "," ",.)

	clonevar m2_205a = Q205_a
	clonevar m2_205b = Q205_b
	clonevar m2_206 = Q206
	
	***************************************************************************
	* CARE PATHWAYS
	clonevar m2_301 = Q301
	clonevar m2_302 = Q302
		
	* Create the variables that show the location for each consultation visit
	* Note : we are using the variables Q303a-Q303e instead of Q303
	* But we have added quality checks to make sure that these values are represented in the dataset
	
	* Create the variables that show the facility for each consultaiton visit will use Q304a-Q304e and the other specified values
	foreach v in a b c d e {
		clonevar m2_303`v' = Q303_`v'
		label var m2_303`v' "Location for "
		clonevar m2_304`v' = Q304_`v'
		
		clonevar m2_304`v'_other = Q304_`v'_other 
	}
	
	* There are 5 sets of variables for the different reasons for the visit
	* Clone each one
	
	* Set locals with the different corresponding variables for each visit
	local 1 05 06 07
	local 2 08 09 10
	local 3 11 12 13
	local 4 14 15 16
	local 5 17 18 19
	foreach n in 1 2 3 4 5 { // begin visit number loop
		foreach v in ``n'' { // loop through the 3 variables associated with that visit
		
			* Clone the basic vars
			clonevar m2_3`v' = Q3`v' 
			
			* set a local with the last value
			local last `v'
		} // end theloop through the 3 vars
		
		* note the last one contains the string numbers
		* This only used in the M2 data quality check and not actually passed through in the individual values
		
		* For the specific reasons for the first non ANC visit 
		* Clone the original variable Q3##_# variables
		
		foreach i in 1 2 3 4 5 96 { // loop through the different reasons
			clonevar m2_3`last'_`i' = Q3`last'_`i'
		} // end different reasons loop
		
		clonevar m2_3`last'_other = Q3`last'_other
	} // end the visit loop

	* Reasons that prevented respondent from ANC 
	clonevar m2_320 = Q320
	
	clonevar m2_320_0 = Q320_0

	gen total_320 = 0
	foreach v in 1 2 3 4 5 6 7 8 9 10 11 96 99 {
		clonevar m2_320_`v' = Q320_`v'
		replace total_320 = total_320 + 1 if m2_320_`v' == 1
	}
	
	clonevar m2_320_other = Q320_other

	clonevar m2_321_org = Q321
	gen m2_321 = 0 if Q321 == "0"
	char m2_321[Original_IN_Varname] 321
	
	replace m2_321 = 1 if Q321 == "1" & !missing(Q321)
	replace m2_321 = 2 if Q321 == "2" & !missing(Q321)
	replace m2_321 = 3 if Q321 == "3" & !missing(Q321)
	replace m2_321 = 98 if Q321 == "98" & !missing(Q321)
	replace m2_321 = 99 if Q321 == "99" & !missing(Q321)
	replace m2_321 = 12 if Q321 == "1 2" & !missing(Q321)	 
	
	foreach v in 0 1 2 3 98 99 {
		clonevar m2_321_`v' = Q321_`v' 
		replace m2_321_`v' = . if m2_321_`v' == 0 & m2_202 != 1
	}
	
	forvalues v = 1/5 {
		clonevar m2_40`v' = Q40`v'
	}

	foreach v in a b c d e f  {
		clonevar m2_501`v' = Q501_`v'
	}
	
	gen m2_501g = !missing(Q501_g) if m2_301 == 1
	char m2_501g[Original_IN_Varname] 501_g
	
	clonevar m2_501g_other = Q501_g
	
	clonevar m2_502 = Q502
	
	foreach v in a b c d e f {
		clonevar m2_503`v' = Q503_`v'
		
		clonevar m2_505`v' = Q505_`v'
	}
	
	clonevar m2_505g = Q505_g
	
	clonevar m2_504 = Q504
	clonevar m2_504_other = Q504_a
	
	foreach v in a b c d {
		clonevar m2_506`v' = Q506_`v'
	}
	
	foreach v in 1 2 3 4 5 6 7 96 98 99 other {
		clonevar m2_507_`v' = Q507_`v'
	}	
	
	clonevar m2_508a = Q508_a 
	clonevar m2_508b_num = Q508_b
	clonevar m2_508c_time = Q508_c
	
	foreach v in a b c {
		clonevar m2_509`v' = Q509_`v'
	}

	* Cleaning these up to align with other datasets
	clonevar m2_601a = Q601_a
	clonevar m2_601b = Q601_c
	clonevar m2_601c = Q601_d
	clonevar m2_601d = Q601_e
	clonevar m2_601e = Q601_f
	clonevar m2_601f = Q601_g
	clonevar m2_601g = Q601_h
	clonevar m2_601h = Q601_i
	clonevar m2_601i = Q601_j
	clonevar m2_601j = Q601_k
	clonevar m2_601k = Q601_l
	clonevar m2_601l = Q601_m
	clonevar m2_601m = Q601_n
	clonevar m2_601n_other = Q601_o
	clonevar m2_601o = Q601_b
	
	replace Q601_o = trim(upper(Q601_o)) 
	gen m2_601n = !inlist(Q601_o,"NO","NO COMMENTS","NO.","NOO","N0","NA") if m2_202 == 1 
	char m2_601n[Original_IN_Varname] 601_o
	
	/*foreach v in a b c d e f g h i j k l m n  {
		clonevar m2_601`v' = Q601_`v'
	}
	
	gen m2_601o = !inlist(Q601_o,"NO","NO COMMENTS","NO.","NOO","N0","NA") if m2_202 == 1 
	char m2_601o[Original_IN_Varname] 601_o
	
	clonevar m2_601o_other = Q601_o
*/
	
	clonevar m2_602b = Q602
	clonevar m2_603 = Q603
	
	clonevar m2_701 = Q701
	
	foreach v in a b c d e {
		clonevar m2_702`v'_cost = Q702_`v'
	}
	
	clonevar m2_702_other = Q702_e_other
	label var m2_702_other "Other specified"
	
	clonevar m2_703 = Q703
	clonevar m2_704_confirm = Q704
	
	clonevar m2_705 = Q705
	
	foreach v in 1 2 3 4 5 6 96 other {
		clonevar m2_705_`v' = Q705_`v'
	}	
	
	clonevar m2_int_duration = duration
	
	* Drop the variables that are not necessary
	drop SubmissionDate start 

	
	
	****************************************************************************
	****************************************************************************
	****************************************************************************
	
	* MODULE 2: STEP TW0 - ADD VALUE LABELS/FORMATTING		
	label define m2_permission 1 "Yes" 0 "No" 
	label values m2_permission m2_permission
	
	label define maternal_death_reported 1 "Yes" 0 "No" 
	label values m2_maternal_death_reported maternal_death_reported
	
	label define m2_hiv_status 1 "Positive" 0 "Negative" 99 "NR/RF" 
	label values m2_hiv_status m2_hiv_status
	
	label define m2_maternal_death_learn 1 "Called respondent phone, someone else responded" ///
									  2 "Called spouse/partner phone, was informed" ///
									  3 "Called close friend or family member phone number, was informed" ///
									  4 "Called CHW phone number, was informed" 5 "Other"
	label values m2_maternal_death_learn m2_maternal_death_learn
	
	
	* Create a single label for all the variables that use the below rating scale
	label define rating 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "NR/RF" , replace
	foreach v in m2_201 m2_401 m2_402 m2_403 m2_404 m2_405 {
		label values `v' rating
	}
		
	* Create a single label for all variables that use Yes, No , DK, and NR/NF
	label define yes_no_dnk_nr 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF", replace
	 
	local m2_203 a b c d e f g h 
	local m2_204 a b c d e f g h i
	local m2_501 a b c d e f g 
	local m2_502 
	local m2_503 a b c d e f 
	local m2_504 
	local m2_301
	local m2_506 a b c d
	local m2_507_ 1 2 3 4 5 6 7 96 98 99
	local m2_508 a b_number b_last c 
	local m2_509 a b c 
	local m2_601 a b c d e f g h i j k l m n
	local m2_603
	local m2_701
	//local m2_702 a b c d e 
	local m2_704
	
	foreach v in m2_203 m2_204 m2_501 m2_502 m2_504 m2_301 m2_305 m2_506 m2_507_ m2_508a m2_509 m2_601 m2_603 m2_701 { //m2_702 {
		foreach i in ``v'' {
			label values `v'`i' yes_no_dnk_nr
		}
	}
	
	label define frequency1 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF", replace
	
	foreach v in m2_205 {
		foreach i in a b {
			label values `v'`i' frequency1
		}
	}

	
	label define frequency2 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF", replace
	label values m2_206 frequency2

	label define still_preg 1 "Yes, still pregnant" 2 "No, delivered" 3 "No, something else happened", replace 
	label values m2_202 still_preg
	
	label define consultation_location 1 "In your home" ///
					2 "Someone elses home" ///
					3 "Government Hospital" ///
					31 "Sub Center / Health & Wellness Center" ///
					32 "Primary Health Centre" ///
					33 "Community Health Center" ///
					34 "Sub-division Hospital" ///
					35 "Don't know, any Government hospital listed above" ///
					4 "District Hospital" ///
					5 "Public Tertiary Care Hospital (Medical College)" ///
					 6 "Private Clinic" ///
					 7 "Private hospital" ///
					 8 "Charity hospital" ///
					 9 "RMP (informal provider)" ///
					 98 "DK" ///
					 99 "NR/RF", replace 
			 
	label define consultation_facility ///
			1 "UPHC BJS" ///
			2 "UPHC Balsamand" ///
			3 "UPHC Junimandi" ///
			4 "UPHC Bagarchawk" ///
			5 "UPHC Chandpole" ///
			6 "UPHC Chandna Bhakar" ///
			7 "UPHC Keshav Nagar Phalodi" ///
			8 "PHC Gangani" ///
			9 "PHC Kuri Bhagtasni" ///
			10 "PHC Guda Bishnoi" ///
			11 "UCHC Chopasani" ///
			12 "UCHC Fidusar" ///
			13 "CHC Bap" ///
			14 "CHC Balesar" ///
			15 "SDH Osian" ///
			16 "CHC Kharkhoda" ///
			17 "HWC Silana" ///
			18 "PHC Khanda" ///
			19 "PHC Sisana" ///
			20 "SDH Kharkhoda" ///
			21 "PHC Bidhlan" ///
			22 "PHC Silana" ///
			23 "CHC Dechu" ///
			24 "UPHC KK Colony" ///
			25 "Turakpur (PHC-Rohat)" ///
			26 "Turakpur (CHC-Firozpur Bangar)" ///
			27 "Thana Kalan (PHC-Rohat)" ///
			28 "Rampur (CHC-Firozpur Bangar)" ///
			29 "Jatola (CHC-Firozpur Bangar)" ///
			30 "Barona (CHC Kharkhoda)" ///
			31 "Farmana (PHC Farmana)" ///
			32 "Gorar (PHC Farmana)" ///
			33 "Khanda (PHC Khanda)" ///
			34 "Nakloi (PHC Bidhlan)" ///
			35 "Lahrara UPHC Kailash Colony (Patel Nagar)" ///
			36 "Lahrara UHC Mahavir Colony" ///
			37 "Gannaur 1 Associated CHC(CHC Gannaur) UPHC Jatwara" ///
			38 "Kharkhoda 2 Associated PHC(PHC Khanda) RHC Sonipat(Kakroi road)" ///
			39 "PPC Gohana Associated SDH (SDH Gohana)" ///
			40 "UPHC Jatwara" ///
			96 "Other" ///	label values m2_304a m2_304a
	
	
	foreach v in a b c d e {
		forvalues i = 1/5 {
			replace m2_303`v' = 3`i' if m2_303`v' == 3.`i'
		}
		
		label values m2_303`v' consultation_location
		label values m2_304`v' consultation_facility
	}
	
	
	label define anc 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 

	foreach v in m2_305 m2_308 m2_311 m2_314 m2_317 {
		label value `v' anc
	}
	
	label define referral 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	
	foreach v in m2_306 m2_309 m2_312 m2_315 m2_318 {
		label value `v' referral
	}
	
	label define m2_321 0 "No" 1 "Yes, by phone" 2 "Yes, by SMS" 3 "Yes, by web" 12 "Yes by phone and SMS" 98 "DK" 99 "NR/RF", replace
	label values m2_321 m2_321
	
	label define m2_505a 1 "Anemic" 0 "Not anemic" 98 "DK" 99 "NR/RF" 
	label values m2_505a m2_505a
	
	label define m2_505b 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF"
	label values m2_505b m2_505b
	
	label define m2_505c 1 "Viral load not suppressed" 0 "Viral load is suppressed" 98 "DK" 99 "NR/RF"
	label values m2_505c m2_505c
	
	label define m2_505d 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF" 
	label values m2_505d m2_505d

	label define m2_505e 1 "Diabetic" 0 "Not diabetic" 98 "DK" 99 "NR/RF" 
	label values m2_505e m2_505e

	label define m2_505f 1 "Hypertensive" 0 "Not hypertensive" 98 "DK" 99 "NR/RF" 
	label values m2_505f m2_505f

	label define m2_505g 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF" 
	label values m2_505g m2_505g

	
	label define symptoms 0 "Nothing I did not speak about this with a health care provider" ///
						1 "Told you to come back later" ///
						2 "Told you to get a lab test or imaging (e.g., blood tests, ultrasound, x-ray, heart echo)" ///
						3 "Told you to go to hospital or see a specialist like an obstetrician or gynecologist" ///
						4 "Told you to take painkillers like acetaminophen" ///
						5 "Told you to wait and see" ///
						96 "Other, specify" ///
						98 "DK" ///
						99 "RF" 
	
	
	* Only keep the variables necessary for the dataset & data quality checks
	keep m2_* total_* Q303* Q301
	
	drop Q303_12 Q303_11
	

	preserve
	* Run the M2 DQ checks on the long dataset.	
	*do "${github}\India\m2_data_quality_checks.do" 

	restore

	drop total_* Q303* Q301
	
	* save a long version of the dataset that will be used for DQ checks before the recoding occurs
	save "${in_data_final}/eco_m2_in_long", replace // 969
	
	

	****************************************************************************
	****************************************************************************
	****************************************************************************
		* MODULE 2: STEP THREE - RECODING MISSING VALUES
		
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)
		
		* All questions should be missing if the the mother was reported to have died
		
		* If the mother did not die, then the variables around her death should be missing
		recode m2_date_of_maternal_death m2_maternal_death_learn m2_maternal_death_learn_other m2_permission (. = .a) if m2_maternal_death_reported == 0
		recode m2_maternal_death_learn_other (. = .a) if m2_maternal_death_learn != 5
		
		* permission should be missing if maternal death reported
		recode m2_permission (. = .a) if m2_maternal_death_reported == 1
		
		* If permission was not granted all other questions should have been skipped
		recode m2_201 m2_202 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i  m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_205a m2_205b m2_206 m2_301 m2_302 m2_303a m2_304a m2_303b m2_304b m2_303c m2_304c m2_303d m2_304d m2_303e m2_304e  m2_305 m2_306  m2_307_1 m2_307_2 m2_307_3 m2_307_4 m2_307_5 m2_307_96  m2_308 m2_309  m2_310_1 m2_310_2 m2_310_3 m2_310_4 m2_310_5 m2_310_96  m2_311 m2_312 m2_313 m2_313_1 m2_313_2 m2_313_3 m2_313_4 m2_313_5 m2_313_96  m2_314 m2_315 m2_316 m2_316_1 m2_316_2 m2_316_3 m2_316_4 m2_316_5 m2_316_96 m2_317 m2_318 m2_319 m2_319_1 m2_319_2 m2_319_3 m2_319_4 m2_319_5 m2_319_96  m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 m2_320_6 m2_320_7 m2_320_8 m2_320_9 m2_320_10 m2_320_11 m2_320_96 m2_320_99 m2_321 m2_321_0 m2_321_1 m2_321_2 m2_321_3 m2_321_98 m2_321_99 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g  m2_502 m2_503a m2_505a m2_503b m2_505b m2_503c m2_505c m2_503d m2_505d m2_503e m2_505e m2_503f m2_505f m2_505g m2_504 m2_506a m2_506b m2_506c m2_506d m2_507_1 m2_507_2 m2_507_3 m2_507_4 m2_507_5 m2_507_6 m2_507_7 m2_507_96 m2_507_98 m2_507_99 m2_508a m2_508b_num m2_508c_time m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601o m2_602b m2_603 m2_701 m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_703 m2_704_confirm  m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 (. = .a) if m2_permission != 1

		// m2_204_other 304a_other m2_304b_other m2_304c_other m2_304d_other m2_304e_other m2_307_other m2_310_other m2_313_other m2_316_other m2_319_other m2_320_other m2_321_org m2_501g_other m2_504_other m2_507_other m2_601o_other m2_705_other m2_307 m2_320 m2_705 m2_310
		
		* If the pregnancy has ended all remaining questions should be missing
		recode m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_205a m2_205b m2_206 m2_301 m2_302 m2_303a m2_304a m2_303b m2_304b  m2_303c m2_304c m2_303d m2_304d m2_303e m2_304e m2_305 m2_306 m2_307_1 m2_307_2 m2_307_3 m2_307_4 m2_307_5 m2_307_96 m2_308 m2_309 m2_310_1 m2_310_2 m2_310_3 m2_310_4 m2_310_5 m2_310_96 m2_311 m2_312 m2_313 m2_313_1 m2_313_2 m2_313_3 m2_313_4 m2_313_5 m2_313_96 m2_314 m2_315 m2_316 m2_316_1 m2_316_2 m2_316_3 m2_316_4 m2_316_5 m2_316_96 m2_317 m2_318 m2_319 m2_319_1 m2_319_2 m2_319_3 m2_319_4 m2_319_5 m2_319_96  m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 m2_320_6 m2_320_7 m2_320_8 m2_320_9 m2_320_10 m2_320_11 m2_320_96 m2_320_99 m2_321 m2_321_0 m2_321_1 m2_321_2 m2_321_3 m2_321_98 m2_321_99 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_505a m2_503b m2_505b m2_503c m2_505c m2_503d m2_505d m2_503e m2_505e m2_503f m2_505f m2_505g m2_504 m2_506a m2_506b m2_506c m2_506d m2_507_1 m2_507_2 m2_507_3 m2_507_4 m2_507_5 m2_507_6 m2_507_7 m2_507_96 m2_507_98 m2_507_99 m2_508a m2_508b_num m2_508c_time m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601o m2_602b m2_603 m2_701 m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_703 m2_704_confirm  m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96  (. = .a) if m2_202 != 1


		//m2_204_other m2_304a_other m2_304b_other m2_304c_other m2_304d_other m2_304e_other m2_307_other m2_310_other m2_313_other m2_316_other m2_319_other m2_320_other m2_321_org m2_501g_other m2_504_other m2_507_other m2_601o_other m2_705_other m2_307 m2_320 m2_705 m2_310
		* If there were no additional consultations these questions should be missing
		recode m2_302 m2_303a m2_304a m2_303b m2_304b m2_303c m2_304c m2_303d m2_304d  m2_303e m2_304e m2_305 m2_306 m2_307_1 m2_307_2 m2_307_3 m2_307_4 m2_307_5 m2_307_96 m2_308 m2_309 m2_310_1 m2_310_2 m2_310_3 m2_310_4 m2_310_5 m2_310_96 m2_311 m2_312 m2_313 m2_313_1 m2_313_2 m2_313_3 m2_313_4 m2_313_5 m2_313_96 m2_314 m2_315 m2_316 m2_316_1 m2_316_2 m2_316_3 m2_316_4 m2_316_5 m2_316_96 m2_317 m2_318 m2_319 m2_319_1 m2_319_2 m2_319_3 m2_319_4 m2_319_5 m2_319_96 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_505g m2_506a m2_506b m2_506c m2_506d m2_507_1 m2_507_2 m2_507_3 m2_507_4 m2_507_5 m2_507_6 m2_507_7 m2_507_96 m2_507_98 m2_507_99 m2_508a m2_508b_num m2_508c_time m2_509a m2_509b m2_509c (. = .a) if m2_301 != 1
		
		// m2_304a_other m2_304b_other m2_304c_other m2_304d_other m2_304e_other m2_307_other m2_310_other m2_313_other m2_316_other m2_319_other m2_504_other m2_501g_other m2_507_other m2_310 m2_307
		
		recode m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h (. = .a) if m2_204i != 1
		* These questions should be missing if there was a consultation
		recode m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 m2_320_6 m2_320_7 m2_320_8 m2_320_9 m2_320_10 m2_320_11 m2_320_96 m2_320_99  (. = .a) if m2_301 != 0
				//m2_320 m2_320_other
				
		* These are appropriately missing if the number of consultations is less than the number
		local n 1
		foreach v in a b c d e {
			recode m2_303`v' m2_304`v' (. = .a) if m2_302 < `n' //m2_304`v'_other
			recode m2_304`v' (. = .a) if inlist(m2_303`v',1,2)
			*recode m2_304`v'_other (. = .a) if m2_304`v' != 96
			local ++n
		}
		
		local 1 05 06 07
		local 2 08 09 10
		local 3 11 12 13
		local 4 14 15 16
		local 5 17 18 19
		foreach n in 1 2 3 4 5 { // begin visit number loop
			local first m2_3`=word("``n''",1)'
			local second m2_3`=word("``n''",2)'
			local third m2_3`=word("``n''",3)'

			recode `first' `second' (99 = .r)
			recode `first' `second'  (98 = .d)
			recode `first' `second'  (. = .a) if m2_302 < `n'
			
			recode `second'  (. = .a) if `first' == 1
			
			foreach i in 1 2 3 4 5 96 { // loop through the different reasons
				recode `third'_`i' (. = .a) if `first' == 1 | `second' == 1 | m2_302 < `n'
			} // end different reasons loop
			
			
		} // end the visit loop


		foreach n in 1 2 3 4 5 {
			recode m2_40`n' (. = .a) if m2_302 < `n'
			recode m2_40`n' (99 = .r)
		}
		
		recode m2_201 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i m2_205a m2_205b m2_206 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_321 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_506a m2_506b m2_506c m2_506d m2_507_1 m2_507_2 m2_507_3 m2_507_4 m2_507_5 m2_507_6 m2_507_7 m2_507_96 m2_507_98 m2_507_99 m2_508a m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601o m2_603 m2_701 m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_hiv_status (99 = .r)
		
		//m2_501g_other m2_507_other
		
		recode m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_206 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_321 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g  m2_502 m2_506a m2_506b m2_506c m2_506d m2_507_1 m2_507_2 m2_507_3 m2_507_4 m2_507_5 m2_507_6 m2_507_7 m2_507_96 m2_507_98 m2_507_99  m2_508a m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601o m2_603 m2_701 m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost (98 = .d)
		
		//m2_501g_other m2_507_other
		
		recode m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504  (. = .a) if m2_502 != 1 //m2_504_other
		
		foreach v in a b c d e f {
			recode m2_505`v' (. = .a) if m2_503`v' != 1
			recode m2_503`v' m2_505`v' (99 = .r)
			recode m2_503`v' m2_505`v' (98 = .d)
		}
		
		recode m2_505g (. = .a) if m2_504 != 1
		recode m2_504 m2_505g (99 = .r)
		recode m2_504 m2_505g (98 = .d)

		recode m2_507_1 m2_507_2 m2_507_3 m2_507_4 m2_507_5 m2_507_6 m2_507_7 m2_507_96 m2_507_98 m2_507_99 (. = .a) if (m2_203a != 1 & m2_203b != 1 & m2_203c != 1 & m2_203d != 1 & m2_203e != 1 & m2_203f != 1 & m2_203g != 1 & m2_203h != 1)
		
		gen depression = 0
		replace depression = m2_205a + m2_205b if !missing(m2_205a) & !missing(m2_205b)
		
		recode m2_508a m2_508b_num m2_508c_time (. = .a) if depression < 3 
		drop depression
		
		recode m2_508b_num m2_508c_time (. = .a) if m2_508a != 1
		
		recode m2_602b (. = .a) if (m2_601a != 1 & m2_601b != 1 & m2_601c != 1 & m2_601d != 1 & m2_601e != 1 & m2_601f != 1 & m2_601g != 1 & m2_601h != 1 & m2_601i != 1 & m2_601j != 1 & m2_601k != 1 & m2_601l != 1 & m2_601m != 1 & m2_601n != 1 & m2_601o != 1 ) 
		
		recode m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_703 m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 (. = .a) if m2_701 != 1
		recode m2_704 (. = .a) if m2_703 != 0

	****************************************************************************
	****************************************************************************
	****************************************************************************
	
		* MODULE 2: STEP FOUR - LABELING VARIABLES
		
		** MODULE 2:

		* MODULE 2: STEP FIVE - ORDER VARIABLES		
		order m2_date m2_date m2_permission m2_time_start m2_maternal_death_reported m2_ga m2_hiv_status ///
	 m2_date_of_maternal_death m2_maternal_death_learn m2_maternal_death_learn_other m2_201
	 
		* Add labels to all vars missing the labels
		label var m2_hiv_status "HIV status"
		label var m2_202 "Still pregnant"
		
		foreach v in a b c d e f g h {
			local name `:var label m2_203`v''
			label var m2_203`v' "Experienced: `name'"
		}
		
		label var m2_204i "Experienced: Other major health problems"
		label var m2_204_other "Experienced: Other major health problems specified"
		
		local a preeclapsia eclampsia
		local b bleeding during pregnancy
		local c hyperemesis gravidarum
		local d anemia
		local e cardiac problem
		local f amniotic fluid
		local g asthma
		local h rh isoimmunization
		foreach v in a b c d e f g h {
			label var m2_204`v' "Other health probelems: `=proper("``v''")'"
		}
		
		label var m2_206 "Frequency smoke cigarettes or use any other type of tobacco"
		
		label var m2_301 "New healthcare consultations"
		label var m2_302 "Number new healthcare consulatations"
		
		local 1 st
		local 2 nd
		local 3 rd
		local 4 th
		local 5 th

		local n 1
		foreach v in a b c d e {
			lab var m2_303`v' "`n'``n'' consultation: Location"
			label var m2_304`v' "`n'``n'' consultation: Facility name"
			label var m2_304`v'_other "`n'``n'' consultation: Other specified facility name"
			local ++n
		}
		
		local 1 05 06 07
		local 2 08 09 10
		local 3 11 12 13
		local 4 14 15 16
		local 5 17 18 19
		
		* Set locals to be used in output strings
		local 1_rsn 1st
		local 2_rsn 2nd
		local 3_rsn 3rd 
		local 4_rsn 4th 
		local 5_rsn 5th 
		
		local first_desc this was a routine ANC visit
		local second_desc this was a referral from ANC provider if not for a routine ANC visit
		local third_desc this was not an ANC visit or a referral from ANC provider
		
		local first_type Routine ANC 
		local second_type Refferal from ANC provider
		local third_type Non ANC or refferal
		
		foreach n in 1 2 3 4 5 { // begin visit number loop
			local first m2_3`=word("``n''",1)'
			local second m2_3`=word("``n''",2)'
			local third m2_3`=word("``n''",3)'
			
			label var `first' "``n'_rsn' visit: `first_type'"
			label var `second' "``n'_rsn' visit: `second_type'"
			label var `third' "``n'_rsn' visit: `third_type'"
			
			foreach i in 1 2 3 4 5 96 {
				local name `:var label `third'_`i''
				label var `third'_`i' "``n'_rsn' visit: `name'"
			}
			
			label var `third'_other "``n'_rsn' visit: Other specified"
		}
		
		label var m2_320 "Any Reasons prevented from receiving ANC"
		foreach v in 0 1 2 3 4 5 6 7 8 9 10 11 96 99 {
			local name `:var label m2_320_`v''
			local s1 = strpos("`name'","(")
			if `s1' > 0	local name = substr("`name'",1,`=`s1'-1')
			label var m2_320_`v' "Reason no ANC: `name'"
		
		}
		
		label var m2_320_other "Reason no ANC: Other specified"
		label var m2_321_org "Have contact with HC provider by phone, SMS, or web about pregnancy?"
		label var m2_321 "Contact with a HC provider by phone, SMS, or web about pregnancy"
		foreach v in 0 1 2 3 98 99 {
			local name `:var label m2_321_`v''
			label var m2_321_`v' "Contact with HC provider by: `name'"
		}
		
		forvalues v = 1/5 {
			label var m2_40`v' "Rate quality of care for ``v'_rsn' visit"
		}
		
		label var m2_501g "Other tests"
		foreach v in a b c d e f g {
			local name `:var label m2_501`v''
			local s1 = strpos("`name'","(")
			if `s1' > 0 local name = substr("`name'",1,`=`s1'-1')
			label var m2_501`v' "Done at consultation: `name'"
		}
		label var m2_501g_other "Done at consultation: Other specified"
		
		label var m2_502 "New test results"
		local a Anemia
		local b HIV
		local c HIV viral load
		local d Syphilis
		local e Diabetes
		local f Hypertension
		foreach v in a b c d e f {
			label var m2_503`v' "New test result: ``v''"
			label var m2_505`v' "Result of test: ``v''"
		}
		
		label var m2_504 "Any other tests"
		label var m2_504_other "Other tests specified"
		
		local a Signs of pregnancy complications
		local b Birth plan
		local c Care for the newborn
		local d Family planning options
		foreach v in a b c d {
			label var m2_506`v' "Discussed with provider: ``v''"
		}
		
		local 1 Nothing, did not discuss this
		local 2 Told to get a lab test or imaging
		local 3 Provided a treatment in the visit
		local 4 Prescribed a medication
		local 5 Told to come back to this health facility
		local 6 Told to go somewhere else for higher level care
		local 7 Told to wait and see
		local 96 Other
		local 98 DK 
		local 99 NR/RF
		
		foreach v in 1 2 3 4 5 6 7 96 98 99 {
			label var m2_507_`v' "Healthcare advice: ``v''"
		}
		label var m2_507_other "Healthcare advice: Other specified"

		label var m2_508a "Had a session of psychological counseling or therapy"
		label var m2_508b_num "Number of psychological counseling or therapy sessions"
		label var m2_508c_time "Average number of minutes for each session"
		
		label var m2_509a "Instructed to go see a specialist like OB or GYB" 
		label var m2_509b "Instructed to go the hospital for follow-up ANC"
		label var m2_509c "Instructed will need a c-section"

		*label var m2_601o "Other medicines or supplements"
		label var m2_601i "Medicine for emotions/nerves/depression/mental health"
		
		foreach v in a b c d e f g h i j k l m n o {
			local name `:var label m2_601`v''
			local name =subinstr("`name'","Medicine for","Meds for",.)
			local name = subinstr("`name'", "[endemic areas]","",.)
			label var m2_601`v' "Received or bought: `name'"
		}
		
		*label var m2_601o_other "Other specified medicines or supplements"
		
		label var m2_602b "Total amount spent on medicines or supplements"
		label var m2_603 "Currently taking iron and folic acid pills"
		label var m2_701 "Pay money out of pocket for new visits"
		
		label var m2_702b_cost "Test or investigations (lab tests/ultrasound)"
		label var m2_702c_cost "Transport (round trip) for all on visit"
		label var m2_702d_cost "Food and accommodation for all on visit"
		foreach v in a b c d e {
			local name `:var label m2_702`v'_cost'
			label var m2_702`v'_cost "Total amount spent: `name'"
		}
		
		label var m2_703 "Agree sum of m2_702a-m2_702e is total amount spent"
		label var m2_704_confirm "Total amount spent if not the sume of m2_702a-m2_702e"
		
		label var m2_705 "Financial sources household used to pay for this"
		label var m2_705_3 "Payment/reimbursement health insurance plan"
		label var m2_705_4 "Sold items (furniture, animals, jewellery, furniture)"
		label var m2_705_5 "Family members/friends outside household"
		label var m2_705_6 "Borrowed (from non-friend or family)"

		
		foreach v in 1 2 3 4 5 6 96 {
			local name `:var label m2_705_`v''
			local s1 = strpos("`name'","(")
			if `s1' > 0 local name = substr("`name'",1,`=`s1'-1')
			label var m2_705_`v' "Method of payment: `name'"
		}	
		
		label var m2_705_other "Method of payment: Other specified"
		label var m2_int_duration "Interview Duration"
		
		* Add the original question number to the variable name
		foreach v of varlist * {
			local name1 ``v'[Original_IN_Varname]'
			local name2 `:var label `v''
		
			local name `name1': `name2'
			label var `v' "`name'"
		}
			
		save "${in_data_final}/eco_m2_in_long", replace // 969

		rename m2_maternal_death_learn_other m2_maternal_death_how_other
		* Save the variable labels in a local
		foreach v of varlist * {
			local `v' `:var label `v''
		}

	****************************************************************************
	****************************************************************************
	****************************************************************************

		* MODULE 2: STEP SIX - SPLIT, RESHARE M2 AND MERGE TO OBTAIN A WIDE DATASET
		
		* Tag cases where there is no redcap_repeat_instance==1
			
		bysort m2_respondentid: gen num_M2_surveys = _N
		label var num_M2_surveys "Number of times Respondent appears in M2 dataset"
		
		bysort m2_respondentid m2_date: gen num_M2_surveys_by_date = _N
		label var num_M2_surveys_by_date "Number of times Respondent appears in M2 dataset with m2_date"
		
		sort m2_respondentid m2_date		
		by m2_respondentid : gen repeat_instance = _n
		
		sum repeat_instance
		local num_repeats = `r(max)'
		
		* Create a string variable for M2 round
		gen m2_round = ""
		sum num_M2_surveys
		forvalues i = 1/`r(max)' {
			replace m2_round = "_r`i'" if repeat_instance ==`i'
		}
		
		* Use the string variable to reshape wide
		drop repeat_instance num_M2_surveys num_M2_surveys_by_date	
		
		* Put the ID variables first
		order m2_respondentid m2_round
		
		reshape wide m2_date-m2_int_duration , i(m2_respondentid) j(m2_round, string) 	
		
*===============================================================================
	* RE-LABELING M2 VARS

	** MODULE 2:
	local orderlist 
	forvalues n = 1/`num_repeats' {
		local i _r`n'
		foreach v of varlist *`i' {
			local name2 = subinstr("`v'","`i'","",.)
			local name1 = subinstr("`i'","_r","R",.)
			label var `v' "``name2'' `name1'"
			
			local orderlist `orderlist' `v'
		}
	}
	
	order m2_respondentid `orderlist'

*===============================================================================
* STEP SEVEN: SAVE DATA TO RECODED FOLDER
* add this respondentid variable for merging purposes
clonevar respondentid = m2_respondentid

* Add a character with the module number for codebook purposes
	foreach v of varlist * {
		char `v'[Module] 2
	}
	
save "${in_data_final}/eco_m2_in_wide.dta", replace


		* MODULE 2: STEP SEVEN - SAVE DATA

*===============================================================================
* STEP EIGHT: MERGE with M1 data
use "${in_data_final}/eco_m1_in", clear
merge 1:1 respondentid using "${in_data_final}/eco_m2_in_wide.dta"
*merge 1:1 respondentid using "${in_data_final}/eco_m1_in"

rename _merge merge_m2_to_m1
label var merge_m2_to_m1 "Match between M2 dataset and M1 and M2 dataset"
label define m2 1 "M1 Only" 2 "M2 only" 3 "Both M1 & M2"
label value merge_m2_to_m1 m2
save "${in_data_final}/eco_m1_and_m2_in.dta", replace

* all those from M2 should be in M1
assert merge_m2_to_m1 != 2 
