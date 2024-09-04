* m3_check_variables - This defines all M3 value labels and applies them to the appropriate variables
/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
* 2024-08-28	1.00	MK Trimner		Original Program
*******************************************************************************/

capture program drop m3_check_variables
program define m3_check_variables


	* This program checks to make sure all the M3 variables from the original instrument are present in the cleaned up dataset. 
	* If they are not, they are created as missing and a character is added to identify these variables as not being part of the original dataset


	* Confirm the string variables are all created
	di as text "Confirm all String variables are in dataset ..."
	foreach v in m3_respondentid m3_105 m3_106 m3_111_other m3_304_b1 m3_304_b2 m3_304_b3 m3_314_other_b1 m3_314_other_b2 m3_314_other_b3 m3_405_other m3_408_other m3_411_other m3_412_other m3_503_other m3_504 m3_509_other m3_518_other m3_518_other_complications m3_519_other m3_605c_other m3_702 m3_709_b1 m3_709_b2 m3_709_b3 m3_808b_other m3_901_other m3_903_other_b1 m3_903_other_b2 m3_903_other_b3 m3_1102_other m3_1105_other m3_804 m3_513b_ET m3_513b_IN m3_513b_KE m3_513b_ZA {
		capture confirm var `v'
		if _rc != 0 {
			di as error "Variable `v' is not in ${Country} dataset, creating as missing ..."
			qui gen `v' = ""
			char `v'[Original_${Country}_Varname] Not in Dataset
		}
		if _rc == 0 {
			capture confirm numeric variable `v'
			if _rc == 0 {
				di as error "Variable `v' should be a string variable, it is a numeric in ${Country} Dataset. Switching it to string ..."
				tostring `v', replace
			}
		}
	}
	
	di ""
	di as text "Confirm all Numeric variables are in dataset ..."
	* Confirm the numeric variables are all created
	foreach v in m3_permission  m3_101 m3_102 m3_103 m3_104 m3_107 m3_108 m3_109 m3_110 m3_1106 m3_111 m3_1201 m3_1202 m3_1203 m3_1204 m3_201 m3_202 m3_301 m3_302 m3_303_b1 m3_303_b2 m3_303_b3 m3_305_b1 m3_305_b2 m3_305_b3 m3_306_b1 m3_306_b2 m3_306_b3 m3_307_b1 m3_307_b2 m3_307_b3 m3_308_b1 m3_308_b2 m3_308_b3 m3_309_b1 m3_309_b2 m3_309_b3 m3_310a_b1_1 m3_310a_b1_2 m3_310a_b1_3 m3_310a_b1_4 m3_310a_b1_5 m3_310a_b1_6 m3_310a_b1_7 m3_310a_b1_99 m3_310a_b2_1 m3_310a_b2_2 m3_310a_b2_3 m3_310a_b2_4 m3_310a_b2_5 m3_310a_b2_6 m3_310a_b2_7 m3_310a_b2_99 m3_310a_b3_1 m3_310a_b3_2 m3_310a_b3_3 m3_310a_b3_4 m3_310a_b3_5 m3_310a_b3_6 m3_310a_b3_7 m3_310a_b3_99 m3_310b m3_311a_b1 m3_311a_b2 m3_311a_b3 m3_311b_b1 m3_311b_b2 m3_311b_b3 m3_311c_b1 m3_311c_b2 m3_311c_b3 m3_311d_b1 m3_311d_b2 m3_311d_b3 m3_311e_b1 m3_311e_b2 m3_311e_b3 m3_311f_b1 m3_311f_b2 m3_311f_b3 m3_311g_b1 m3_311g_b2 m3_311g_b3 m3_312_a_b1 m3_312_a_b2 m3_312_a_b3 m3_312_b1 m3_312_b2 m3_312_b3 m3_313a_b1 m3_313a_b2 m3_313a_b3 m3_313b_days_b1 m3_313b_days_b2 m3_313b_days_b3 m3_313b_hours_b1 m3_313b_hours_b2 m3_313b_hours_b3 m3_314_b1 m3_314_b2 m3_314_b3 m3_401 m3_402 m3_403 m3_404 m3_405_1 m3_405_2 m3_405_3 m3_405_4 m3_405_5 m3_405_96 m3_406 m3_407 m3_408_1 m3_408_2 m3_408_3 m3_408_4 m3_408_5 m3_408_96 m3_409 m3_410 m3_411_1 m3_411_2 m3_411_3 m3_411_4 m3_411_5 m3_411_96 m3_412_a m3_412_b m3_412_c m3_412_d m3_412_e m3_412_f m3_412_g m3_501 m3_502_ET m3_502_IN m3_502_KE m3_502_ZA m3_503_ET m3_503_IN m3_503_KE m3_503_ZA m3_505a_ET m3_505b_days m3_505b_hours m3_505b_weeks m3_506_date m3_506_time m3_507_time m3_508 m3_509 m3_510 m3_511 m3_512_1_ET m3_512_1_IN m3_512_1_KE m3_512_1_ZA m3_512_2_ET m3_512_2_IN m3_512_2_KE m3_512_2_ZA m3_513a_ET m3_513a_IN m3_513a_KE m3_513a_ZA m3_514_date m3_514_time m3_515 m3_516 m3_517 m3_518_0 m3_518_1 m3_518_10 m3_518_2 m3_518_3 m3_518_4 m3_518_5 m3_518_6 m3_518_7 m3_518_8 m3_518_9 m3_518_96 m3_518_97 m3_518_98 m3_518_99 m3_519_1 m3_519_10 m3_519_11 m3_519_12 m3_519_13 m3_519_14 m3_519_15 m3_519_16 m3_519_17 m3_519_2 m3_519_3 m3_519_4 m3_519_5 m3_519_6 m3_519_7 m3_519_8 m3_519_9 m3_519_96 m3_519_98 m3_519_99 m3_520_time m3_521_hours m3_521_minutes m3_601a m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_605c_0 m3_605c_1 m3_605c_2 m3_605c_3 m3_605c_96 m3_605c_98 m3_605c_99 m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_612_days m3_612_hours m3_612_minutes m3_613 m3_614_days m3_614_hours m3_614_weeks m3_615_b1 m3_615_b2 m3_615_b3 m3_616_days_b1 m3_616_days_b2 m3_616_days_b3 m3_616_hours_b1 m3_616_hours_b2 m3_616_hours_b3 m3_616_weeks_b1 m3_616_weeks_b2 m3_616_weeks_b3 m3_617_b1 m3_617_b2 m3_617_b3 m3_617_vitaK_b1_ET m3_617_vitaK_b2_ET m3_617_vitaK_b3_ET m3_618a_b1 m3_618a_b2 m3_618a_b3 m3_618b_b1 m3_618b_b2 m3_618b_b3 m3_618c_b1 m3_618c_b2 m3_618c_b3 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620_b1 m3_620_b2 m3_620_b3 m3_621a_1 m3_621a_2 m3_621a_3 m3_621a_4 m3_621a_5 m3_621a_6 m3_621a_98 m3_621a_99 m3_621b m3_621c_days m3_621c_hours m3_621c_weeks m3_622a m3_622b m3_622c m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_707_days  m3_707_hours m3_707_weeks m3_708_1_b1 m3_708_1_b2 m3_708_1_b3 m3_708_2_b1 m3_708_2_b2 m3_708_2_b3 m3_708_3_b1 m3_708_3_b2 m3_708_3_b3 m3_708_4_b1 m3_708_4_b2 m3_708_4_b3 m3_708_5_b1 m3_708_5_b2 m3_708_5_b3 m3_708_6_b1 m3_708_6_b2 m3_708_6_b3 m3_708_98_b1 m3_708_98_b2 m3_708_98_b3 m3_708_99_b1 m3_708_99_b2 m3_708_99_b3 m3_710_b1 m3_710_b2 m3_710_b3 m3_711_days_b1 m3_711_days_b2 m3_711_days_b3 m3_711_hours_b1 m3_711_hours_b2 m3_711_hours_b3 m3_711_weeks_b1 m3_711_weeks_b2 m3_711_weeks_b3 m3_801_a m3_801_b m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803i m3_805 m3_806 m3_807 m3_808a m3_808b m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_902 m3_903a_b1 m3_903a_b2 m3_903a_b3 m3_903b_b1 m3_903b_b2 m3_903b_b3 m3_903c_b1 m3_903c_b2 m3_903c_b3 m3_903d_b1 m3_903d_b2 m3_903d_b3 m3_903e_b1 m3_903e_b2 m3_903e_b3 m3_903f_b1 m3_903f_b2 m3_903f_b3 m3_903g_b1 m3_903g_b2 m3_903g_b3 m3_903h_b1 m3_903h_b2 m3_903h_b3 m3_903i_b1 m3_903i_b2 m3_903i_b3 m3_903j_b1 m3_903j_b2 m3_903j_b3 m3_904 m3_1001 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f m3_1103 m3_1104 m3_1105_1 m3_1105_2 m3_1105_3 m3_1105_4 m3_1105_5 m3_1105_6 m3_1105_96 {
		
		capture confirm var `v'
		if _rc != 0 {
			di as error "Variable `v' is not in ${Country} dataset, creating as missing ..."
			qui gen `v' = .
			char `v'[Original_${Country}_Varname] Not in Dataset
		}
		if _rc == 0 {
			capture confirm numeric variable `v'
			if _rc != 0 {
				di as error "Variable `v' should be a numeric variable, it is a string in ${Country} Dataset. Switching it to numeric ..."
				destring `v', replace
			}
		}
	}
	
	di ""
	di as text "Confirm each M3 variable has the character holding the original dataset variable name"
	foreach v of varlist m3_* {
		capture assert "``v'[Original_${Country}_Varname]'" != ""
		if _rc != 0 {
			di as error "Variable `v' is missing the link to the original ${Country} variable"
		}
	}


end
