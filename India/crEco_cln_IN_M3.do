* India MNH ECohort Data Cleaning File for Module 3 
* Created by MK Trimner
* Last Updated: 2024-08-08
* Version Number: 	1.00
*------------------------------------------------------------------------------*

/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-08-08		1.01	MK Trimner		Original M3 file
* 2024-09-12	1.02	MK Trimner		Added call to m3_data_basic_quality_checks
* 2024-09-17	1.03	MK Trimner		Added code to drop the 3 respondents that did not merge back with M1 dataset
*										Saved with consistent naming convention
*										Added code to run the derived variables code and save as COMPLETE		
* 2024-10-22	1.04	MK Trimner		Added updated M3 dataset							
*******************************************************************************

										*/
* QUESTION - Gestational age - what is this supposed to be in? Why are we dropping it in ET? 

* QUESTION - what is the expected time between visits? what would be too close? too late?

* QUESTION: What are all these CALC variables calculating... looks to be based on the interview date?
* Calculate_802 Calculate_802_date Calc_weeks_remaining_1 Calculate_Q803_1 Calculate_Q803_2 Calc_weeks_remaining_2 Calc_weeks_remaining Calc_Gestational_Age

										
* Check that variables that overlap between modules are the same values
* For excample Q108 Q109 etc										
* Set a local wtih module2 file name
local module3 M3_17102024
global Country IN

* Import Data 
clear all 
u "${in_data}/`module3'.dta", clear

* Add a character with the original country specific var name
foreach v of varlist * {
	local name `v'
	char `v'[Original_IN_Varname] `name'
}

* Clean up the id variable to remove any spaces that may cause merging issues

* MKT in updated M3 dataset the identifier is not a string. We need to make it a string
rename Q104 org_Q104
clonevar Q104 = id // In the updated dataset we will use the ID variable instead
replace Q104 = trim(Q104)
replace Q104 = subinstr(Q104," ","",.)


* Per the India's team instruction we will be dropping the below respondents as they are not part of the M1
drop if inlist(Q104,"202307181044030109","202311171131039696","202311201424039696","202311212018039696")

* 
*------------------------------------------------------------------------------*

		* STEPS: 
		* STEP ONE: Code all variables that do not align perfectly with instrument
		* STEP TW0: Clonevar all variables that have a perfect 1:1 relationship with instrument 
		* STEP THREE: Check all M3 variables are in dataset
		* STEP FOUR: Add Variable labels, define and add value labels
		* STEP FIVE: Recode 99, 98 and skipped appropriatley
		* STEP SIX: Merge with m1_m2_dataset
		* STEP SEVEN: SAVE DATA
		
	*===============================================================================
* STEP ONE: Code any data specific variables that do not align with the original instrument from this dataset

	
		* Create a single variable from Q302_a and Q302_b
		clonevar m3_302 = Q302_a
		replace m3_302 = Q302_b if missing(m3_302)
		char m3_302[Original_IN_Varname] Q302_a and Q302_b

		
		* Variables Q314_1, Q314_2 and Q314_3 values are different than the instrument. 
		* Instrument goes from 0-7, 96 and IN dataset goes from 1-8,96
		* Align these with the Instrument
		forvalues i = 1/3 {
			gen m3_314_b`i' = Q314_`i'
			char m3_314_b`i'[Original_IN_Varname] Q314_`i'
			replace m3_314_b`i' = m3_314_b`i' -1 if m3_314_b`i' < 96
		}
		
		* generage a yes/no var from Q412_g other specified values - be sure to wipe out NO values
		rename Q412_g Q412_g_text
		gen m3_412_g = !inlist(Q412_g_text,"No") if !missing(Q412_g_text)
		char m3_412_g[Original_IN_Varname] Q412_g
		
		* We want to copy the label from the facility name variable
		label copy Q503 facility_name_IN, replace
				
		* Need to recode Q518 to be multi select
		foreach v in 0 1 2 3 4 5 6 7 8 9 10 96 97 98 99 {
			gen m3_518_`v' = Q518 == `v' if !missing(Q518)
			char m3_518_`v'[Original_IN_Varname] Q518
		}

		
		* The label for Q603_a appears to be incorrect. Was mislabeled with the label from Q603_c and Q603_c was not labeled
		* typo in the label code
		label var Q603_a "Were you told you could walk around and move during labour?"
		label def Q603_a 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF", modify
		label val Q603_a Q603_a

		label var Q603_c "Did you have a needle inserted in your arm with a drip?"
		label def Q603_c 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF", modify
		label val Q603_c Q603_c
				
		
		* Need to recode Q605c to be a multi select
		foreach v in 0 1 2 3 96 98 99 {
			gen m3_605c_`v' = Q605_c == `v' if !missing(Q605_c) //Q605_a == 1 
			char m3_605c_`v'[Original_IN_Varname] Q605_c
		}
		
		* Need to recode Q621_a to be multi select
		foreach v in 1 2 3 4 5 6 98 99 {
			gen m3_621a_`v' = Q621_a == `v' if !missing(Q621_a) //Q501 == 0
			char m3_621a_`v'[Original_IN_Varname] Q621_a

		}
		
		* Recode Q708_1 to make multi select
		foreach b in 1 2 3 {
			foreach v in 1 2 3 4 5 6 98 99 {
				gen m3_708_`v'_b`b' = Q708_`b' == `v' if !missing(Q708_`b') // Q303_1 == 1 | (Q303_1 == 0 & Q312_1 == 1) & Q402 >=1 
				char m3_708_`v'_b`b'[Original_IN_Varname] Q708_`b'
			}
		}
		
		* Need to merge Q802_b and Q802_b_a and the same for Q802_c and Q802_c_a
		foreach v in b c {
			gen m3_802`v' = Q802_`v'_a
			replace m3_802`v' = Q802_`v' if missing(m3_802`v') 
			char m3_802`v'[Original_IN_Varname] Q802_`v'_a and Q802_`v'
		}
		

	*===============================================================================
		* STEP TW0: Clonevar all variables that have a perfect 1:1 relationship with instrument 

	* The next set of variables are a simple 1:1 ratio and can be cloned		
		
clonevar m3_permission = Consent
clonevar m3_respondentid = Q104
clonevar respondentid = m3_respondentid
clonevar m3_102 = Q102
clonevar m3_date = m3_102
clonevar m3_103 = Q103
clonevar m3_104 = Q104
clonevar m3_107 = Q107
clonevar m3_108 = Q108
clonevar m3_109 = Q109
clonevar m3_111 = Q111
clonevar m3_111_other = Q111_other


clonevar m3_201 = Q201
clonevar m3_202 = Q202

clonevar m3_301 = Q301
clonevar m3_303_b1 = Q303_1
clonevar m3_303_b2 = Q303_2
clonevar m3_303_b3 = Q303_3
clonevar m3_305_b1 = Q305_1
clonevar m3_305_b2 = Q305_2
clonevar m3_305_b3 = Q305_3
clonevar m3_306_b1 = Q306_1
clonevar m3_306_b2 = Q306_2
clonevar m3_306_b3 = Q306_3
clonevar m3_307_b1 = Q307_1
clonevar m3_307_b2 = Q307_2
clonevar m3_307_b3 = Q307_3
clonevar m3_308_b1 = Q308_1
clonevar m3_308_b2 = Q308_2
clonevar m3_308_b3 = Q308_3
clonevar m3_309_b1 = Q309_1
clonevar m3_309_b2 = Q309_2
clonevar m3_309_b3 = Q309_3
clonevar m3_310a_b1_1 = Q310_a_1_1
clonevar m3_310a_b1_2 = Q310_a_1_2
clonevar m3_310a_b1_3 = Q310_a_1_3
clonevar m3_310a_b1_4 = Q310_a_1_4
clonevar m3_310a_b1_5 = Q310_a_1_5
clonevar m3_310a_b1_6 = Q310_a_1_6
clonevar m3_310a_b1_7 = Q310_a_1_7
clonevar m3_310a_b1_99 = Q310_a_1_99
clonevar m3_310a_b2_1 = Q310_a_2_1
clonevar m3_310a_b2_2 = Q310_a_2_2
clonevar m3_310a_b2_3 = Q310_a_2_3
clonevar m3_310a_b2_4 = Q310_a_2_4
clonevar m3_310a_b2_5 = Q310_a_2_5
clonevar m3_310a_b2_6 = Q310_a_2_6
clonevar m3_310a_b2_7 = Q310_a_2_7
clonevar m3_310a_b2_99 = Q310_a_2_99
clonevar m3_310a_b3_1 = Q310_a_3_1
clonevar m3_310a_b3_2 = Q310_a_3_2
clonevar m3_310a_b3_3 = Q310_a_3_3
clonevar m3_310a_b3_4 = Q310_a_3_4
clonevar m3_310a_b3_5 = Q310_a_3_5
clonevar m3_310a_b3_6 = Q310_a_3_6
clonevar m3_310a_b3_7 = Q310_a_3_7
clonevar m3_310a_b3_99 = Q310_a_3_99
clonevar m3_310b = Q310b
clonevar m3_311a_b1 = Q311_a_1
clonevar m3_311b_b1 = Q311_b_1
clonevar m3_311c_b1 = Q311_c_1
clonevar m3_311d_b1 = Q311_d_1
clonevar m3_311e_b1 = Q311_e_1
clonevar m3_311f_b1 = Q311_f_1
clonevar m3_311g_b1 = Q311_g_1
clonevar m3_311a_b2 = Q311_a_2
clonevar m3_311b_b2 = Q311_b_2
clonevar m3_311c_b2 = Q311_c_2
clonevar m3_311d_b2 = Q311_d_2
clonevar m3_311e_b2 = Q311_e_2
clonevar m3_311f_b2 = Q311_f_2
clonevar m3_311g_b2 = Q311_g_2
clonevar m3_311a_b3 = Q311_a_3
clonevar m3_311b_b3 = Q311_b_3
clonevar m3_311c_b3 = Q311_c_3
clonevar m3_311d_b3 = Q311_d_3
clonevar m3_311e_b3 = Q311_e_3
clonevar m3_311f_b3 = Q311_f_3
clonevar m3_311g_b3 = Q311_g_3
clonevar m3_312_b1 = Q312_1
clonevar m3_312_a_b1 = Q312_a_1
clonevar m3_312_b2 = Q312_2
clonevar m3_312_a_b2 = Q312_a_2
clonevar m3_312_b3 = Q312_3
clonevar m3_312_a_b3 = Q312_a_3
clonevar m3_313a_b1 = Q313_a_date_1
clonevar m3_313a_b2 = Q313_a_date_2
clonevar m3_313a_b3 = Q313_a_date_3
clonevar m3_313b_days_b1 = Q313_b_1_1
clonevar m3_313b_hours_b1 = Q313_b_2_1
clonevar m3_313b_days_b2 = Q313_b_1_2
clonevar m3_313b_hours_b2 = Q313_b_2_2
clonevar m3_313b_days_b3 = Q313_b_1_3
clonevar m3_313b_hours_b3 = Q313_b_2_3
clonevar m3_314_other_b1 = Q314_1_other
clonevar m3_314_other_b2 = Q314_2_other
clonevar m3_314_other_b3 = Q314_3_other


clonevar m3_401 = Q401
clonevar m3_402 = Q402
clonevar m3_403 = Q403
clonevar m3_404 = Q404
clonevar m3_405_1 = Q405_1
clonevar m3_405_2 = Q405_2
clonevar m3_405_3 = Q405_3
clonevar m3_405_4 = Q405_4
clonevar m3_405_5 = Q405_5
clonevar m3_405_96 = Q405_96
clonevar m3_405_other = Q405_other
* This has some values that have "." that need to be replaced as ""
capture replace m3_405_other = "" if m3_405_other == "."

clonevar m3_406 = Q406
clonevar m3_407 = Q407
clonevar m3_408_1 = Q408_1
clonevar m3_408_2 = Q408_2
clonevar m3_408_3 = Q408_3
clonevar m3_408_4 = Q408_4
clonevar m3_408_5 = Q408_5
clonevar m3_408_96 = Q408_96
clonevar m3_408_other = Q408_other
clonevar m3_409 = Q409
clonevar m3_410 = Q410
clonevar m3_411_1 = Q411_1
clonevar m3_411_2 = Q411_2
clonevar m3_411_3 = Q411_3
clonevar m3_411_4 = Q411_4
clonevar m3_411_5 = Q411_5
clonevar m3_411_96 = Q411_96
clonevar m3_411_other = Q411_other
clonevar m3_412_a = Q412_a
clonevar m3_412_b = Q412_b
clonevar m3_412_c = Q412_c
clonevar m3_412_d = Q412_d
clonevar m3_412_e = Q412_e
clonevar m3_412_f = Q412_f
clonevar m3_412_other = Q412_g_text


clonevar m3_501 = Q501
clonevar m3_502_IN = Q502
clonevar m3_503_IN = Q503
clonevar m3_503_other = Q503_other
clonevar m3_504 = Q504
clonevar m3_506_date = Q506_a
clonevar m3_506_time = Q506_b
clonevar m3_507_time = Q507
clonevar m3_508 = Q508
clonevar m3_509 = Q509
clonevar m3_509_other = Q509_other
clonevar m3_510 = Q510
clonevar m3_511 = Q511
clonevar m3_512_1_IN = Q512
clonevar m3_513a_IN = Q513_a
clonevar m3_513b_IN = Q513_b
clonevar m3_514_time = Q514
clonevar m3_515 = Q515
clonevar m3_516 = Q516
clonevar m3_517 = Q517
clonevar m3_518_other_complications = Q518_other_complications
clonevar m3_518_other = Q518_other
clonevar m3_519_1 = Q519_1
clonevar m3_519_2 = Q519_2
clonevar m3_519_3 = Q519_3
clonevar m3_519_4 = Q519_4
clonevar m3_519_5 = Q519_5
clonevar m3_519_6 = Q519_6
clonevar m3_519_7 = Q519_7
clonevar m3_519_8 = Q519_8
clonevar m3_519_9 = Q519_9
clonevar m3_519_10 = Q519_10
clonevar m3_519_11 = Q519_11
clonevar m3_519_12 = Q519_12
clonevar m3_519_13 = Q519_13
clonevar m3_519_14 = Q519_14
clonevar m3_519_15 = Q519_15
clonevar m3_519_16 = Q519_16
clonevar m3_519_17 = Q519_17
clonevar m3_519_96 = Q519_96
clonevar m3_519_98 = Q519_98
clonevar m3_519_99 = Q519_99
clonevar m3_519_other = Q519_other
clonevar m3_520_time = Q520
clonevar m3_521_hours = Q521_a
clonevar m3_521_minutes = Q521_b


clonevar m3_601a = Q601_a
clonevar m3_601b = Q601_b
clonevar m3_601c = Q601_c
clonevar m3_602a = Q602_a
clonevar m3_602b = Q602_b
clonevar m3_603a = Q603_a
clonevar m3_603b = Q603_b
clonevar m3_603c = Q603_c
clonevar m3_604a = Q604_a
clonevar m3_604b = Q604_b
clonevar m3_605a = Q605_a
clonevar m3_605b = Q605_b
clonevar m3_605c_other = Q605_c_other
clonevar m3_606 = Q606
clonevar m3_607 = Q607
clonevar m3_608 = Q608
clonevar m3_609 = Q609
clonevar m3_610a = Q610_a
clonevar m3_610b = Q610_b
clonevar m3_611 = Q611
clonevar m3_612_hours = Q612_a
clonevar m3_612_days = Q612_b
clonevar m3_613 = Q613
clonevar m3_614_hours = Q614_a 
clonevar m3_614_days = Q614_b 
clonevar m3_614_weeks = Q614_c
clonevar m3_615_b1 = Q615_a
clonevar m3_615_b2 = Q615_b
clonevar m3_615_b3 = Q615_c
clonevar m3_616_hours_b1 = Q616_1_a
clonevar m3_616_days_b1 = Q616_1_b
clonevar m3_616_weeks_b1 = Q616_1_c
clonevar m3_616_hours_b2 = Q616_2_a
clonevar m3_616_days_b2 = Q616_2_b
clonevar m3_616_weeks_b2 = Q616_2_c
clonevar m3_616_hours_b3 = Q616_3_a
clonevar m3_616_days_b3 = Q616_3_b
clonevar m3_616_weeks_b3 = Q616_3_c
clonevar m3_617_b1 = Q617_1
clonevar m3_617_b2 = Q617_2
clonevar m3_617_b3 = Q617_3
clonevar m3_618a_b1 = Q618a_1
clonevar m3_618a_b2 = Q618a_2
clonevar m3_618a_b3 = Q618a_3
clonevar m3_618b_b1 = Q618a_1
clonevar m3_618b_b2 = Q618a_2
clonevar m3_618b_b3 = Q618a_3
clonevar m3_618c_b1 = Q618c_1
clonevar m3_618c_b2 = Q618c_2
clonevar m3_618c_b3 = Q618c_3
clonevar m3_619a = Q619_a
clonevar m3_619b = Q619_b
clonevar m3_619c = Q619_c
clonevar m3_619d = Q619_d
clonevar m3_619e = Q619_e
clonevar m3_619f = Q619_f
clonevar m3_619g = Q619_g
clonevar m3_620_b1 = Q620
clonevar m3_621b = Q621_b
clonevar m3_621c_hours = Q621c_a
clonevar m3_621c_days = Q621c_b
clonevar m3_621c_weeks = Q621c_c
clonevar m3_622a = Q622_a
clonevar m3_622b = Q622_b
clonevar m3_622c = Q622_c

clonevar m3_701 = Q701
clonevar m3_702 = Q702
clonevar m3_703 = Q703
clonevar m3_704a = Q704_a
clonevar m3_704b = Q704_b
clonevar m3_704c = Q704_c
clonevar m3_704d = Q704_d
clonevar m3_704e = Q704_e
clonevar m3_704f = Q704_f
clonevar m3_704g = Q704_g
clonevar m3_705 = Q705
clonevar m3_706 = Q706
clonevar m3_707_hours = Q707_a
clonevar m3_707_days = Q707_b
clonevar m3_707_weeks = Q707_c
clonevar m3_709_b1 = Q709_1
clonevar m3_709_b2 = Q709_2
clonevar m3_709_b3 = Q709_3
clonevar m3_710_b1 = Q710_1
clonevar m3_710_b2 = Q710_2
clonevar m3_710_b3 = Q710_3
clonevar m3_711_hours_b1 = Q711_1_a
clonevar m3_711_days_b1 = Q711_1_b
clonevar m3_711_weeks_b1 = Q711_1_c
clonevar m3_711_hours_b2 = Q711_2_a
clonevar m3_711_days_b2 = Q711_2_b
clonevar m3_711_weeks_b2 = Q711_2_c
clonevar m3_711_hours_b3 = Q711_3_a
clonevar m3_711_days_b3 = Q711_3_b
clonevar m3_711_weeks_b3 = Q711_3_c

clonevar m3_801_a = Q801_a
clonevar m3_801_b = Q801_b
clonevar m3_802a = Q802_a
clonevar m3_803a = Q803_a
clonevar m3_803b = Q803_b
clonevar m3_803c = Q803_c
clonevar m3_803d = Q803_d
clonevar m3_803e = Q803_e
clonevar m3_803f = Q803_f
clonevar m3_803g = Q803_g
clonevar m3_803h = Q803_h
clonevar m3_804 = Q804
clonevar m3_805 = Q805
clonevar m3_806 = Q806
clonevar m3_807 = Q807
clonevar m3_808a = Q808_a
clonevar m3_808b = Q808_b
clonevar m3_808b_other = Q808_b_other
clonevar m3_809 = Q809

clonevar m3_901a = Q901_a
clonevar m3_901b = Q901_b
clonevar m3_901c = Q901_c
clonevar m3_901d = Q901_d
clonevar m3_901e = Q901_e
clonevar m3_901f = Q901_f
clonevar m3_901g = Q901_g
clonevar m3_901h = Q901_h
clonevar m3_901i = Q901_i
clonevar m3_901j = Q901_j
clonevar m3_901k = Q901_k
clonevar m3_901l = Q901_l
clonevar m3_901m = Q901_m
clonevar m3_901n = Q901_n
clonevar m3_901o = Q901_o
clonevar m3_901p = Q901_p
clonevar m3_901q = Q901_q
clonevar m3_901r = Q901_r
clonevar m3_901_other = Q901_r_specify
clonevar m3_903a_b1 = Q902_a
clonevar m3_903b_b1 = Q902_b
clonevar m3_903c_b1 = Q902_c
clonevar m3_903d_b1 = Q902_d
clonevar m3_903e_b1 = Q902_e
clonevar m3_903f_b1 = Q902_f
clonevar m3_903g_b1 = Q902_g
clonevar m3_903h_b1 = Q902_h
clonevar m3_903i_b1 = Q902_i
clonevar m3_903j_b1 = Q902_j
clonevar m3_903_other_b1 = Q902_j_specify

clonevar m3_1001 = Q1001
clonevar m3_1002 = Q1002
clonevar m3_1003 = Q1003
clonevar m3_1004a = Q1004_a
clonevar m3_1004b = Q1004_b
clonevar m3_1004c = Q1004_c
clonevar m3_1004d = Q1004_d
clonevar m3_1004e = Q1004_e
clonevar m3_1004f = Q1004_f
clonevar m3_1004g = Q1004_g
clonevar m3_1004h = Q1004_h
clonevar m3_1005a = Q1005_a
clonevar m3_1005b = Q1005_b
clonevar m3_1005c = Q1005_c
clonevar m3_1005d = Q1005_d
clonevar m3_1005e = Q1005_e
clonevar m3_1005f = Q1005_f
clonevar m3_1005g = Q1005_g
clonevar m3_1005h = Q1005_h
clonevar m3_1006a = Q1006_a
clonevar m3_1006b = Q1006_b
clonevar m3_1006c = Q1006_c
clonevar m3_1007a = Q1007_a
clonevar m3_1007b = Q1007_b
clonevar m3_1007c = Q1007_c

clonevar m3_1101 = Q1101
clonevar m3_1102a = Q1102_a
clonevar m3_1102b = Q1102_b
clonevar m3_1102c = Q1102_c
clonevar m3_1102d = Q1102_d
clonevar m3_1102e = Q1102_e
clonevar m3_1102f = Q1102_f
clonevar m3_1102_other = Q1102_f_other
clonevar m3_1103 = Q1103
clonevar m3_1105_1 = Q1104_1
clonevar m3_1105_2 = Q1104_2
clonevar m3_1105_3 = Q1104_3
clonevar m3_1105_4 = Q1104_4
clonevar m3_1105_5 = Q1104_5
clonevar m3_1105_6 = Q1104_6
clonevar m3_1105_96 = Q1104_96
clonevar m3_1105_other = Q1104_other
clonevar m3_1106 = Q1105

clonevar m3_1201 = Q1201
clonevar m3_1202 = Q1202
clonevar m3_1203 = Q1203
clonevar m3_1204 = Q1204


* drop all the variables used to create the above variabels
* Drop all the original variables
drop Consent Q102 Q103 Q104 Q107 Q108 Q109 Q111 Q111_other Q201 Q202 Q301 Q302_a Q302_b Q303_1 Q303_2 Q303_3 Q305_1 Q305_2 Q305_3 Q306_1 Q306_2 Q306_3 Q307_1 Q307_2 Q307_3 Q308_1 Q308_2 Q308_3 Q309_1 Q309_2 Q309_3 Q310_a_1_1 Q310_a_1_2 Q310_a_1_3 Q310_a_1_4 Q310_a_1_5 Q310_a_1_6 Q310_a_1_7 Q310_a_1_99 Q310_a_2_1 Q310_a_2_2 Q310_a_2_3 Q310_a_2_4 Q310_a_2_5 Q310_a_2_6 Q310_a_2_7 Q310_a_2_99 Q310_a_3_1 Q310_a_3_2 Q310_a_3_3 Q310_a_3_4 Q310_a_3_5 Q310_a_3_6 Q310_a_3_7 Q310_a_3_99 Q310b Q311_a_1 Q311_b_1 Q311_c_1 Q311_d_1 Q311_e_1 Q311_f_1 Q311_g_1 Q311_a_2 Q311_b_2 Q311_c_2 Q311_d_2 Q311_e_2 Q311_f_2 Q311_g_2 Q311_a_3 Q311_b_3 Q311_c_3 Q311_d_3 Q311_e_3 Q311_f_3 Q311_g_3 Q312_1 Q312_a_1 Q312_2 Q312_a_2 Q312_3 Q312_a_3 Q313_a_date_1 Q313_a_date_2 Q313_a_date_3 Q313_b_1_1 Q313_b_2_1 Q313_b_1_2 Q313_b_2_2 Q313_b_1_3 Q313_b_2_3 Q314_1 Q314_1_other Q314_2 Q314_2_other Q314_3 Q314_3_other Q401 Q402 Q403 Q404 Q405_1 Q405_2 Q405_3 Q405_4 Q405_5 Q405_96 Q405_other Q406 Q407 Q408_1 Q408_2 Q408_3 Q408_4 Q408_5 Q408_96 Q408_other Q409 Q410 Q411_1 Q411_2 Q411_3 Q411_4 Q411_5 Q411_96 Q411_other Q412_a Q412_b Q412_c Q412_d Q412_e Q412_f Q412_g Q412_g Q501 Q502 Q503 Q503_other Q504 Q506_a Q506_b Q507 Q508 Q509 Q509_other Q510 Q511 Q512 Q513_a Q513_b Q514 Q515 Q516 Q517 Q518 Q518_other_complications Q518_other Q519_1 Q519_2 Q519_3 Q519_4 Q519_5 Q519_6 Q519_7 Q519_8 Q519_9 Q519_10 Q519_11 Q519_12 Q519_13 Q519_14 Q519_15 Q519_16 Q519_17 Q519_96 Q519_98 Q519_99 Q519_other Q520 Q521_a Q521_b Q601_a Q601_b Q601_c Q602_a Q602_b Q603_a Q603_b Q603_c Q604_a Q604_b Q605_a Q605_b Q605_c Q605_c_other Q606 Q607 Q608 Q609 Q610_a Q610_b Q611 Q612_a Q612_b Q613 Q614_a  Q614_b  Q614_c Q615_a Q615_b Q615_c Q616_1_a Q616_1_b Q616_1_c Q616_2_a Q616_2_b Q616_2_c Q616_3_a Q616_3_b Q616_3_c Q617_1 Q617_2 Q617_3 Q618a_1 Q618a_2 Q618a_3 Q618a_1 Q618a_2 Q618a_3 Q618c_1 Q618c_2 Q618c_3 Q619_a Q619_b Q619_c Q619_d Q619_e Q619_f Q619_g Q620 Q621_a Q621_b Q621c_a Q621c_b Q621c_c Q622_a Q622_b Q622_c Q701 Q702 Q703 Q704_a Q704_b Q704_c Q704_d Q704_e Q704_f Q704_g Q705 Q706 Q707_a Q707_b Q707_c Q708_1 Q708_2 Q708_3 Q709_1 Q709_2 Q709_3 Q710_1 Q710_2 Q710_3 Q711_1_a Q711_1_b Q711_1_c Q711_2_a Q711_2_b Q711_2_c Q711_3_a Q711_3_b Q711_3_c Q801_a Q801_b Q802_a Q802_b_a Q802_b Q802_c_a Q802_c Q803_a Q803_b Q803_c Q803_d Q803_e Q803_f Q803_g Q803_h Q804 Q805 Q806 Q807 Q808_a Q808_b Q808_b_other Q809 Q901_a Q901_b Q901_c Q901_d Q901_e Q901_f Q901_g Q901_h Q901_i Q901_j Q901_k Q901_l Q901_m Q901_n Q901_o Q901_p Q901_q Q901_r Q901_r_specify Q902_a Q902_b Q902_c Q902_d Q902_e Q902_f Q902_g Q902_h Q902_i Q902_j Q902_j_specify Q1001 Q1002 Q1003 Q1004_a Q1004_b Q1004_c Q1004_d Q1004_e Q1004_f Q1004_g Q1004_h Q1005_a Q1005_b Q1005_c Q1005_d Q1005_e Q1005_f Q1005_g Q1005_h Q1006_a Q1006_b Q1006_c Q1007_a Q1007_b Q1007_c Q1101 Q1102_a Q1102_b Q1102_c Q1102_d Q1102_e Q1102_f Q1102_f_other Q1103 Q1104_1 Q1104_2 Q1104_3 Q1104_4 Q1104_5 Q1104_6 Q1104_96 Q1104_other Q1105 Q1201 Q1202 Q1203 Q1204 



* Create a mini dataset that shows the variables from the dataset that were not used so we can confirm these should not be used
preserve
drop m3_* 
save "C:\Users\MaryKayTrimner\Biostat Global Dropbox\Mary Kay Trimner\Harvard - eCohorts\MKT Working Folder\M3\m3_vars_not_used", replace
restore

	*===============================================================================

		* STEP THREE: Check all M3 variables are in dataset

* Now we want to call the program to confirm all the M3 variables are present in the dataset
m3_check_variables


	*===============================================================================

		* STEP FOUR: Add Variable labels, define and add value labels

* Call the program to add the variable labels
m3_variable_labels

* Call program to define value labels and add them to the variables
m3_value_labels

	* Add a character with the module number for codebook purposes
	foreach v of varlist * {
		char `v'[Module] 3
	}
	
	* Order the variables
	order m3_* , sequential
	order respondentid m3_respondentid m3_date m3_permission 



	*===============================================================================

		* STEP FIVE: Data quality checks
		* save a clean version of the dataset that will be used for DQ checks before the recoding occurs
		save "${in_data_final}/eco_m3_in", replace // 969

* Run the data quality check program
*m3_data_basic_quality_checks_IN



use  "${in_data_final}/eco_m3_in", clear
	*===============================================================================

	* STEP SIX: Recode 99, 98 and skipped appropriatley 
	* Recode refused and don't know values
	* Note: .a means NA, .r means refused, .d is don't know, . is missing 
	* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)

	
* Run the program to recode the M3 variables
m3_recode_variables

	*===============================================================================

	* STEP SEVEN: Merge with m1_m2_dataset and SAVE DATA

	* Only keep the M3 variables we are using 
	keep respondentid m3_* 
	* confirm there is 1 row per respondent
bysort respondentid: assert _N == 1
replace respondentid = trim(respondentid)

tempfile mkt
save `mkt'

use "${in_data_final}\eco_m1_and_m2_in.dta"
*merge 1:1 respondentid using "${in_data_final}\eco_m1_and_m2_in.dta"
merge 1:1 respondentid using  `mkt'

* all those from M3 should be in M1
assertlist _merge != 2, list(respondentid) 

rename _merge merge_m3_to_m2_m1 
label var merge_m3_to_m2_m1 "Match between M3 dataset and M1 and M2 dataset"
label define m3 1 "M1 Only" 2 "M3 only" 3 "Both M1 & M3"
label value merge_m3_to_m2_m1 m3

* We want to drop those that do not merge back to main dataset
* Per India team these 3 ids should not be included
/*202307181044030109 
202311171131039696 
202311201424039696 
202311212018039696
*/


drop if merge_m3_to_m2_m1 == 2 // this is 3 ids

*save "${in_data_final}/eco_m1_m2_m3_in.dta", replace

order respondentid country
save "$in_data_final/eco_m1-m3_in.dta", replace

*==============================================================================*
* run derived variables
  	
	* Run the derived variable code
do "${github}\India\crEco_der_IN.do"

* Change date_m1 to m1_date
gen m1_date = date(date_m1,"DMY")
label var m1_date "`:var label date_m1'"
order m1_date, after(date_m1)
drop date_m1
 * Save as a completed dataset
save "$in_data_final/eco_IN_Complete", replace
