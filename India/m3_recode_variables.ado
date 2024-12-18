* m3_recode_variables - This recodes all DNK, NR and skip logic 
/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
* 2024-08-28	1.00	MK Trimner		Original Program
*******************************************************************************/
capture program drop m3_recode_variables
program define m3_recode_variables


	* Recode refused and don't know values
	* Note: .a means NA, .r means refused, .d is don't know, . is missing 
	* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)
	
	* Recode the value of 98 in the below variables to be .d (Don't Know) 
	recode m3_301 m3_302 m3_307_b1 m3_307_b2 m3_307_b3 m3_308_b1 m3_308_b2 m3_308_b3 m3_312_b1 m3_312_a_b1 m3_312_b2 m3_312_a_b2 m3_312_b3 m3_312_a_b3 m3_313a_b1 m3_313a_b2 m3_313a_b3 m3_401 m3_403 m3_404 m3_405_1 m3_405_2 m3_405_3 m3_405_4 m3_405_5 m3_405_96 m3_406 m3_407 m3_408_1 m3_408_2 m3_408_3 m3_408_4 m3_408_5 m3_408_96 m3_409 m3_410 m3_411_1 m3_411_2 m3_411_3 m3_411_4 m3_411_5 m3_411_96 m3_412_a m3_412_b m3_412_c m3_412_d m3_412_e m3_412_f m3_412_g m3_501 m3_502_ET m3_502_KE m3_502_ZA m3_502_IN m3_505a_ET m3_510  m3_601a m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_613 m3_615_b1 m3_615_b2 m3_615_b3 m3_617_b1 m3_617_b2 m3_617_b3 m3_617_vitaK_b1_ET m3_617_vitaK_b2_ET m3_617_vitaK_b3_ET m3_618a_b1 m3_618a_b2 m3_618a_b3 m3_618b_b1 m3_618b_b2 m3_618b_b3 m3_618c_b1 m3_618c_b2 m3_618c_b3 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620_b1 m3_620_b2 m3_620_b3 m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_710_b1 m3_710_b2 m3_710_b3 m3_802a m3_802b m3_802c  m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803i m3_805 m3_808b m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_903a_b1 m3_903b_b1 m3_903c_b1 m3_903d_b1 m3_903e_b1 m3_903f_b1 m3_903g_b1 m3_903h_b1 m3_903i_b1 m3_903j_b1 m3_903a_b2 m3_903b_b2 m3_903c_b2 m3_903d_b2 m3_903e_b2 m3_903f_b2 m3_903g_b2 m3_903h_b2 m3_903i_b2 m3_903j_b2 m3_903a_b3 m3_903b_b3 m3_903c_b3 m3_903d_b3 m3_903e_b3 m3_903f_b3 m3_903g_b3 m3_903h_b3 m3_903i_b3 m3_903j_b3 m3_1002 m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f m3_1103 m3_1105_1 m3_1105_2 m3_1105_3 m3_1105_4 m3_1105_5 m3_1105_6 m3_1105_96 m3_1106 m3_1201 m3_1203 (98 = .d)

	
	* Recode the value of 99 in the below variables to be .r (No response/Refused to answer)
	recode m3_201 m3_301 m3_303_b1 m3_303_b2 m3_303_b3 m3_305_b1 m3_305_b2 m3_305_b3 m3_308_b1 m3_308_b2 m3_308_b3 m3_309_b1 m3_309_b2 m3_309_b3 m3_310b m3_312_b1 m3_312_a_b1 m3_312_b2 m3_312_a_b2 m3_312_b3 m3_312_a_b3 m3_313a_b1 m3_313a_b2 m3_313a_b3 m3_401 m3_403 m3_404 m3_405_1 m3_405_2 m3_405_3 m3_405_4 m3_405_5 m3_405_96 m3_406 m3_407 m3_408_1 m3_408_2 m3_408_3 m3_408_4 m3_408_5 m3_408_96 m3_409 m3_410 m3_411_1 m3_411_2 m3_411_3 m3_411_4 m3_411_5 m3_411_96 m3_412_a m3_412_b m3_412_c m3_412_d m3_412_e m3_412_f m3_412_g m3_501 m3_502_ET m3_502_KE m3_502_ZA m3_502_IN m3_505a_ET m3_509 m3_510 m3_516 m3_517 m3_601a m3_601b m3_601c m3_602a m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_613 m3_615_b1 m3_615_b2 m3_615_b3 m3_617_b1 m3_617_b2 m3_617_b3 m3_617_vitaK_b1_ET m3_617_vitaK_b2_ET m3_617_vitaK_b3_ET m3_618a_b1 m3_618a_b2 m3_618a_b3 m3_618b_b1 m3_618b_b2 m3_618b_b3 m3_618c_b1 m3_618c_b2 m3_618c_b3 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620_b1 m3_620_b2 m3_620_b3 m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_710_b1 m3_710_b2 m3_710_b3 m3_801_a m3_801_b m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803i m3_805 m3_807 m3_808b m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_903a_b1 m3_903b_b1 m3_903c_b1 m3_903d_b1 m3_903e_b1 m3_903f_b1 m3_903g_b1 m3_903h_b1 m3_903i_b1 m3_903j_b1 m3_903a_b2 m3_903b_b2 m3_903c_b2 m3_903d_b2 m3_903e_b2 m3_903f_b2 m3_903g_b2 m3_903h_b2 m3_903i_b2 m3_903j_b2 m3_903a_b3 m3_903b_b3 m3_903c_b3 m3_903d_b3 m3_903e_b3 m3_903f_b3 m3_903g_b3 m3_903h_b3 m3_903i_b3 m3_903j_b3 m3_1001 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f m3_1103 m3_1105_1 m3_1105_2 m3_1105_3 m3_1105_4 m3_1105_5 m3_1105_6 m3_1105_96 m3_1106 m3_1201 m3_1202 m3_1203 m3_1204 (99 = .r)

	
	* Recode based on skip logic
	recode m3_110 m3_111 m3_201 m3_202 (. = .a) if m3_109 == 1
	
	foreach v of varlist m3_3* m3_4* m3_5* m3_6* m3_7* m3_8* m3_9* m3_100* m3_110* m3_120* {
		if substr("`:type `v''",1,3) != "str" recode `v' (. = .a) if !inlist(m3_202,2,3)
		if substr("`:type `v''",1,3) == "str" replace `v' = ".a" if !inlist(m3_202,2,3)
	}
	
	* Replace all missing values for the baby specific vairables to be .a if `b' number of babies <= number of babies in 301
	foreach b in 1 2 3 {
		foreach v of varlist *_b`b' *_b`b'_* {
			if substr("`:type `v''",1,3) != "str" recode `v' (. = .a) if m3_301 < `b' | missing(m3_301)
			if substr("`:type `v''",1,3) == "str" replace `v' = ".a" if m3_301 < `b' | missing(m3_301)

			
		} 
	}
	
	* Set all the variables that are contingent on the baby/babies being alive to .a if missing
	foreach b in 1 2 3 {
		foreach v in 304 305 306 307 308 309 311a 311b 311c 311d 311e 311f 311g {
			if substr("`:type m3_`v'_b`b''",1,3) != "str" recode m3_`v'_b`b' (. = .a) if m3_303_b`b' != 1
			if substr("`:type m3_`v'_b`b''",1,3) == "str" replace m3_`v'_b`b' = ".a" if m3_303_b`b' != 1

		}
		foreach v of varlist m3_310*_b`b'_* {
			if substr("`:type `v''",1,3) != "str" recode `v' (. = .a) if m3_303_b`b' != 1
			if substr("`:type `v''",1,3) == "str" recode `v' = ".a" if m3_303_b`b' != 1

		}
		recode m3_306_b`b' (. = .a) if !inlist(m3_302,98,.)
		
		recode m3_312_b`b' m3_312_a_b`b' m3_313a_b`b' m3_313b_days_b`b' m3_313b_hours_b`b' m3_314_b`b'  (. = .a) if m3_303_b`b' == 1 //m3_314_0_b`b' m3_314_1_b`b' m3_314_2_b`b' m3_314_3_b`b' m3_314_4_b`b'  m3_314_5_b`b' m3_314_6_b`b' m3_314_96_b`b'
		
		if substr("`:type m3_314_other_b`b''",1,3) != "str" recode m3_314_other_b`b' (. = .a) if m3_314_b`b' != 96 //m3_314_96_b`b' != 1
		
		recode m3_313b_days_b`b' m3_313b_hours_b`b' (. = .a) if !missing(m3_313a_b`b') | m3_312_b`b' != 1
	}
	
	recode m3_310b (.=.a) if m3_303_b1 != 1  & m3_303_b2 != 1  & m3_303_b3 != 1	
	
	recode m3_402 m3_403 m3_404 m3_405_1 m3_405_2 m3_405_3  m3_405_4 m3_405_5 m3_405_96 m3_406 m3_407 m3_408_1 m3_408_2 m3_408_3  m3_408_4 m3_408_5 m3_408_96 m3_409 m3_410 m3_411_1 m3_411_2 m3_411_3  m3_411_4 m3_411_5 m3_411_96  m3_412_a m3_412_b m3_412_c m3_412_d m3_412_e m3_412_f m3_412_g   (. = .a) if m3_401 != 1
	
	replace m3_405_other = ".a" if m3_401 != 1 | m3_402 < 1 | missing(m3_402)
	replace m3_408_other = ".a" if m3_401 != 1 | m3_402 < 2 | missing(m3_402)
	replace m3_411_other = ".a" if m3_401 != 1 | m3_402 < 3 | missing(m3_402)
	replace m3_412_other = ".a" if m3_401 != 1 | m3_412_g != 1

	recode m3_403 m3_404 (. = .a) if m3_402 < 1 | missing(m3_402)
	recode m3_404 m3_405_1 m3_405_2 m3_405_3  m3_405_4 m3_405_5 m3_405_96   (. = .a) if m3_403 == 1
	recode m3_405_1 m3_405_2 m3_405_3  m3_405_4 m3_405_5 m3_405_96 (. = .a) if m3_404 == 1
	replace m3_405_other = ".a" if m3_405_96 != 1
	
	recode m3_406 m3_407 (. = .a) if m3_402 < 1 | missing(m3_402)
	recode m3_407 m3_408_1 m3_408_2 m3_408_3  m3_408_4 m3_408_5 m3_408_96   (. = .a) if m3_406 == 1
	recode m3_408_1 m3_408_2 m3_408_3  m3_408_4 m3_408_5 m3_408_96 (. = .a) if m3_407 == 1
	replace m3_408_other = ".a" if m3_408_96 != 1

	recode m3_409 m3_410 (. = .a) if m3_402 < 1 | missing(m3_402)
	recode m3_410 m3_411_1 m3_411_2 m3_411_3  m3_411_4 m3_411_5 m3_411_96   (. = .a) if m3_409 == 1
	recode m3_411_1 m3_411_2 m3_411_3  m3_411_4 m3_411_5 m3_411_96 (. = .a) if m3_410 == 1
	replace m3_411_other = ".a" if m3_411_96 != 1
	
	recode m3_501 (. = .a) if m3_202 != 2
	
	recode m3_502_IN m3_503_IN m3_505a m3_505b_weeks m3_505b_days m3_505b_hours m3_506_date m3_506_time m3_507_time (. = .a) if m3_501 != 1
	recode m3_508 m3_509 (. = .a) if m3_501 != 0
	replace m3_509_other = ".a" if m3_501 != 0 & missing(m3_509_other)
	
	recode m3_511 m3_512_1_IN m3_512_2_IN  m3_513a_IN (. = .a) if m3_510 != 1
	recode m3_512_1_IN m3_513a_IN (. = .a) if m3_511 < 1 
	recode m3_512_2_IN (. = .a) if m3_511 < 2
	recode m3_514_time m3_514_date m3_515 (. = .a) if m3_510 != 1
	recode m3_516 (. = .a) if !inlist(m3_515,4,5)
	recode m3_517 (. = .a) if !inlist(m3_515,2,3)
	recode m3_518_0 m3_518_1 m3_518_2 m3_518_3 m3_518_4 m3_518_5 m3_518_6 m3_518_7 m3_518_8 m3_518_9 m3_518_10 m3_518_96 m3_518_97 m3_518_98 m3_518_99 (. = .a) if m3_517 != 1
	recode m3_519_1 m3_519_2 m3_519_3 m3_519_4 m3_519_5 m3_519_6 m3_519_7 m3_519_8 m3_519_9 m3_519_10 m3_519_11 m3_519_12 m3_519_13 m3_519_14 m3_519_15 m3_519_16 m3_519_17 m3_519_96 m3_519_98 m3_519_99 (. = .a) if m3_510 != 0
	recode m3_520_time m3_521_hours m3_521_minutes (. =.a) 	if m3_501 != 1 // 
	
	recode m3_601a m3_601b m3_601c m3_602a m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_607 m3_608 m3_609 m3_610a m3_613  (. = .a) if m3_501 != 1
	recode m3_602b ( . = .a) if m3_602a != 0
	recode m3_605b m3_605c_0 m3_605c_1 m3_605c_2 m3_605c_3 m3_605c_96 m3_605c_98 m3_605c_99 ( . = .a) if m3_605a != 1
	recode m3_606 m3_607 ( . = .a ) if m3_605a != 0
	recode m3_610b (. = .a) if m3_610a != 1
	recode m3_610a m3_611 m3_612_hours m3_612_days  (. = .a) if m3_501 != 1 & m3_303_b1 != 1 & m3_303_b2 != 1 & m3_303_b3 != 1 & m3_312_b1 != 1 & m3_312_b2 != 1 & m3_312_b3 != 1 
	
	recode m3_614_hours m3_614_days m3_614_weeks (. = .a) if m3_613 != 1
	
	foreach i in 1 2 3 {
		recode m3_615_b`i' m3_617_b`i' m3_617_vitaK_b`i'_ET m3_618a_b`i' m3_618b_b`i'  m3_618c_b`i' m3_620_b`i'  (. = .a) if m3_501 != 1 & m3_303_b`i' != 1 & m3_312_b`i' != 1 
		
		recode m3_618a_b`i' m3_618b_b`i' m3_618c_b`i' (. = .a) if m3_108 != 1
	
		recode m3_616_hours_b`i' m3_616_days_b`i' m3_616_weeks_b`i' (. = .a) if m3_615_b`i' != 1
	}
	
	recode m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j (. = .a) if m3_501 != 1 & m3_303_b1 != 1 & m3_312_b1 != 1 & m3_303_b2 != 1 & m3_312_b2 != 1 & m3_303_b3 != 1 & m3_312_b3 != 1
	
	recode m3_621a_1 m3_621a_2 m3_621a_3 m3_621a_4 m3_621a_5 m3_621a_6 m3_621a_98 m3_621a_99 m3_621b m3_621c_days m3_621c_hours m3_621c_weeks (. = .a) if m3_501 != 0
	
	recode m3_621c_days m3_621c_hours m3_621c_weeks (. = .a) if m3_621b != 1
	
	recode m3_622b (. = .a) if m3_622a !=1
	
	recode m3_703 (. = .a) if m3_701 != 1
	
	recode m3_705 m3_706 m3_707_days m3_707_hours m3_707_weeks (. = .a) if m3_501 != 1
	
	foreach i in 1 2 3 {
		foreach v of varlist m3_708_*_b`i' {
			recode `v' (. = .a) if m3_303_b`i' != 1 & m3_312_b`i' != 1
		}
		recode m3_710_b`i' m3_711_days_b`i' m3_711_hours_b`i' m3_711_weeks_b`i' (. = .a) if m3_501 != 1 & m3_303_b`i' != 1 & m3_312_b`i' != 1 
	}
	
	gen m3_801 = m3_801_a + m3_801_b
	recode m3_802a (. = .a) if m3_801 < 3
	drop m3_801
	recode m3_802b m3_802c (. = .a) if m3_802a != 1
	recode m3_806 m3_807 m3_808a m3_808b m3_809 (. = .a) if m3_805 != 1
	recode m3_808b m3_809 (. = .a) if  m3_808a != 0
	
	foreach i in 1 2 3 {
		recode m3_903a_b`i' m3_903b_b`i' m3_903c_b`i' m3_903d_b`i' m3_903e_b`i' m3_903f_b`i' m3_903g_b`i' m3_903h_b`i' m3_903i_b`i' m3_903j_b`i' (. = .a) if m3_303_b`i' != 1 
	}
	
	
	recode m3_1001 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c (. = .a) if m3_501 != 1
	
	recode m3_1006b m3_1006c (. = .a) if m3_1006a != 1

	recode m3_1101 m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f (. = .a) if m3_501 != 1
	recode m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f (. = .a) if m3_1101 != 1
end