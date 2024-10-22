* m3_value_labels - This adds the variable labels to all M3 variables
/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
* 2024-08-27	1.00	MK Trimner		Original Program
*******************************************************************************/
capture program drop m3_value_labels
program define m3_value_labels

	* Define all the value labels for M3 dataset
	label define yes_no_dnk_nr 0 "No" 1 "Yes" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define yesno 0 "No" 1 "Yes", replace

	label define gender 1 "Male" 2 "Female" 3 "Inderterminate" 99 "No Response/Refused to answer", replace

	label define hcw_had_card 0 "No" 1 "Yes" 3 "I don't have a maternal health card" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define how_gave_birth 1 "My own bed" 2 "A shared bed" 3 "A mattress on the floor" 4 "The floor" 5 "A chair" 6 "I was standing" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define skin 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin" 4 "Bleeding or cracked skin", replace

	label define sleep 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" 4 "Severely disturbed sleep", replace

	label define stool 1 "Normal stooling/poo" 2 "Slight stooling/poo problems" 3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems", replace

	label define activity 1 "Highly playful/interactive" 2 "Playful/interactive" 3 "Less playful/less interactive" 4 "Low energy/inactive/dull", replace

	label define baby_size 1 "Very large" 2 "Larger than average" 3 "Average" 4 "Smaller than average" 5 "Very small" 98 "Don't Know", replace

	label define breathing 1 "Normal breathing" 2 "Slight breathing problems" 3 "Moderate breathing problems" 4 "Severe breathing problems", replace

	label define feeding 1 "Normal feeding" 2 "Slight feeding problems" 3 "Moderate feeding problems" 4 "Severe feeding problems", replace

	label define before_after 1 "Before" 2 "After" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define confidence 1 "Not at all confident" 2 "Not very confident" 3 "Somewhat confident" 4 "Confident" 5 "Very confident" 96 "I do not breastfeed" 99 "No Response/Refused to answer", replace

	label define date 98 "Don't Know", replace

	label define days 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "No Response/Refused to answer", replace

	label define effective 1 "Yes, no more leakage at all" 2 "Yes, but still some leakage" 3 "No, still have problem" 98 "Don't know" 99 "No response/refused to answer", replace

	label define facility_type_ET 3 "Government hospital" 4 "Government health center" 5 "Government health post" 6 "NGO or faith-based health facility" 7 "Private hospital" 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" 10 "Private clinic" 11 "Another private medical facility (including pharmacy, shop, traditional healer)" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define facility_type_IN 1 "Sub center" 2 "Primary health center" 3 "Community health center" 4 "District hospital" 5 "Public tertiary care hospital (medical college)" 6 "Private clinic" 7 "Private hospital" 8 "Charity hospital" 9 "RMP (informal provider)" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define facility_type_KE 3 "Government hospital" 4 "Government health center" 5 "Government dispensary" 6 "Other public facility" 7 "NGO or faith-based health facility" 8 "Private hospital" 9 "Private clinic" 10 "Another private medical facility (including pharmacy, shop, traditional healer)" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define facility_type_ZA 1 "Public clinic" 2 "Public hospital" 3 "Private clinic" 4 "Private hospital" 5 "Public Community health center" 6 "Other" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define interfere 0 "0 (Not at all)" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10 (A great deal)" 99 "No Response/Refused to answer", replace

	label define likelihood 1 "Very likely" 2 "Somewhat likely" 3 "Not too likely" 4 "Not at all likely" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define maternal_death 1 "Called respondent phone, someone else responded" 2 "Called spouse/partner phone, was informed " 3 "Called close friend or family member phone number, was informed" 4 "Called CHW phone number, was informed " 96 "Other (specify)", replace

	label define mood 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying", replace

	label define number 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define number_babies 1 "1" 2 "2" 3 "3 or more" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define pregnant 1 "Yes, still pregnant" 2 "No, delivered" 3 "No, something else happened ", replace

	label define quality_care 1 "Poor" 2 "Fair" 3 "Good" 4 "Very good" 5 "Excellent" 6 "Not applicable (e.g. no antenatal tests)" 99 "No Response/Refused to answer", replace

	label define rate 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor" 99 "No Response/Refused to answer", replace

	label define rsn_for_death 0 "Not told anything" 1 "The baby was premature (born too early)" 2 "An infection" 3 "A congenital abnormality (genetic or acquired issues with growth/development)" 4 "A birth injury or asphyxia (occurring because of delivery complications)" 5 "Difficulties breathing" 6 "Unexplained causes" 7 "You decided to have an abortion" 96 "Other", replace

	label define rsn_home_birth 1 "High cost (e.g., high out of pocket payment, not covered by insurance)" 2 "Far distance (e.g., too far to walk or drive, transport not readily available)" 3 "Long waiting time (e.g., long line to access facility, long wait for the provider)" 4 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 5 "Staff don't show respect (e.g., staff is rude, impolite, dismissive)" 6 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" 7 "Facility not clean and/or comfortable (e.g., dirty, risk of infection)" 8 "Not necessary (e.g., able to receive enough care at home, traditional care)" 9 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)" 10 "COVID-19 fear" 11 "No female provider" 12 "Husband/family did not allow it" 13 "Facility was closed" 14 "Delivered on the way (tried to go)" 96 "Other" 99 "No Response/Refused to answer", replace

	label define rsn_left_facility 1 "High cost (e.g., high out of pocket payment, not covered by insurance)" 2 "Long waiting time (e.g., long line to access facility, long wait for the provider)" 3 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 4 "Staff don't show respect (e.g., staff is rude, impolite, dismissive)" 5 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" 6 "Facility not clean and/or comfortable (e.g., dirty, risk of infection)" 7 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)" 8 "COVID-19 fear" 9 "No female provider" 96 "Other" 99 "No Response/Refused to answer", replace

	label define rsn_no_treatment 1 "Do not know can be fixed" 2 "Do not know where to go" 3 "Too expensive" 4 "Too far" 5 "Poor quality of care" 6 "Could not get permission" 7 "Embarrassment" 8 "Problem disappeared" 96 "Other" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define rsn_went_other_facility 1 "The first facility was closed" 2 "Provider referred you to this other facility without checking you" 3 "Provider checked you but referred you to this other facility" 4 "You decided to leave" 5 "A family member decided you should leave", replace

	label define satisfied 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" 4 "Dissatisfied" 5 "Very dissatisfied" 98 "Don't Know" 99 "No Response/Refused to answer", replace

	label define hiv_status 0 "Negative" 1	"Positive" 2 "Did not receive result" 98 "Don't Know" 99 "No Response/Refused to answer", replace


	**********************************************************
	**********************************************************
	**********************************************************

	* Add the value labels to the variables
	label value m3_605b before_after
	label value m3_809 effective
	label value m3_310b confidence
	label value m3_302 date
	label value m3_602a hcw_had_card
	label value m3_604a how_gave_birth
	label value m3_807 interfere
	label value m3_1002 likelihood
	label value m3_111 maternal_death 
	label value m3_301 number_babies
	label value m3_202 pregnant
	label value m3_1001 quality_care
	label value m3_509 rsn_home_birth
	label value m3_516 rsn_left_facility
	label value m3_808b rsn_no_treatment
	label value m3_515 rsn_went_other_facility
	label value m3_1106 satisfied

	* the next section applies the same labels to multiple variables
	foreach v in m3_311g_b3 m3_311g_b1 m3_311g_b2 {
		label value `v' activity
	}

	foreach v in m3_307_b1 m3_307_b3 m3_307_b2 {
		label value `v' baby_size
	}

	foreach v in m3_311c_b2 m3_311c_b1 m3_311c_b3 {
		label value `v' breathing
	}

	foreach v in m3_801_b m3_801_a {
		label value `v' days
	}

	/*foreach v in m3_513b_ET m3_503_ET m3_513a_ET {
		label value `v' facility_name_ET
	}

	foreach v in m3_503_IN m3_513b_IN m3_513a_IN {
		label value `v' facility_name_IN
	}

	foreach v in m3_513a_KE m3_503_KE m3_513b_KE {
		label value `v' facility_name_KE
	}

	foreach v in m3_503_ZA m3_513a_ZA m3_513b_ZA {
		label value `v' facility_name_ZA
	}
	*/

	foreach v in m3_512_2_ET m3_512_1_ET m3_502_ET {
		label value `v' facility_type_ET
	}

	foreach v in m3_512_1_IN m3_502_IN m3_512_2_IN {
		label value `v' facility_type_IN
	}


	foreach v in m3_512_2_KE m3_512_1_KE m3_502_KE {
		label value `v' facility_type_KE
	}


	foreach v in m3_512_2_ZA m3_502_ZA m3_512_1_ZA {
		label value `v' facility_type_ZA
	}

	foreach v in m3_311b_b1 m3_311b_b3 m3_311b_b2 {
		label value `v' feeding
	}

	foreach v in m3_305_b2 m3_305_b3 m3_305_b1 {
		label value `v' gender
	}

	foreach v in m3_618b_b3 m3_618b_b1 m3_618b_b2 {
		label value `v' hiv_status
	}

	foreach v in m3_311e_b2 m3_311e_b1 m3_311e_b3 {
		label value `v' mood
	}

	foreach v in m3_1102a m3_308_b1 m3_802c m3_1102b m3_1102f m3_802b m3_1102e m3_308_b3 m3_1102c m3_308_b2 m3_1102d {
		label value `v' number
	}

	foreach v in m3_309_b2 m3_1004h m3_309_b1 m3_201 m3_1202 m3_1004e m3_1004g m3_309_b3 m3_1004d m3_1004a m3_1004b m3_1004f m3_1004c m3_1204 {
		label value `v' rate
	}

	foreach v in m3_314_b1 m3_314_b2 m3_314_b3 {
		label value `v'  rsn_for_death
	}


	foreach v in m3_311f_b2 m3_311f_b3 m3_311f_b1 {
		label value `v' skin
	}

	foreach v in m3_311a_b3 m3_311a_b1 m3_311a_b2 {
		label value `v' sleep
	}
	foreach v in m3_311d_b3 m3_311d_b2 m3_311d_b1 {
		label value `v' stool
	}


	foreach v in m3_406 m3_313a_b2 m3_903b_b2 m3_901d m3_901h m3_312_b2 m3_617_vitaK_b2_ET m3_901g m3_901i m3_619e m3_1201 m3_619c m3_408_1 m3_1005b m3_903i_b2 m3_411_4 m3_615_b1 m3_613 m3_617_b2 m3_603b m3_405_2 m3_411_5 m3_903f_b1 m3_412_a m3_312_a_b2 m3_903c_b1 m3_619b m3_903j_b1 m3_312_b3 m3_617_b1 m3_313a_b1 m3_411_96 m3_704d m3_401 m3_408_2 m3_619j m3_617_b3 m3_903d_b1 m3_620_b1 m3_903a_b1 m3_803f m3_1007b m3_710_b1 m3_408_5 m3_601a m3_303_b3 m3_705 m3_619a m3_1005g m3_1105_4 m3_803g m3_903a_b2 m3_803i m3_510 m3_618c_b3 m3_411_3 m3_405_3 m3_1105_3 m3_901m m3_903h_b1 m3_903e_b2 m3_901o m3_620_b2 m3_1006c m3_903f_b2 m3_619h m3_411_1 m3_408_96 m3_312_b1 m3_618a_b1 m3_619g m3_601c m3_901j m3_901r m3_404 m3_903h_b3 m3_706 m3_901n m3_703 m3_903j_b2 m3_615_b2 m3_903g_b1 m3_405_4 m3_704g m3_803c m3_622c m3_610b m3_621b m3_618a_b3 m3_603a m3_704c m3_409 m3_903e_b3 m3_1105_96 m3_405_5 m3_411_2 m3_618c_b2 m3_618c_b1 m3_619d m3_618a_b2 m3_603c m3_903c_b2 m3_610a m3_901e m3_803a m3_704e m3_1203 m3_1101 m3_601b m3_903a_b3 m3_1105_1 m3_602b m3_313a_b3 m3_617_vitaK_b3_ET m3_903d_b3 m3_604b m3_517 m3_903i_b1 m3_303_b2 m3_405_96 m3_408_4 m3_609 m3_901c m3_611 m3_803e m3_620_b3 m3_1007c m3_312_a_b1 m3_903b_b1 m3_901f m3_605a m3_901k m3_903j_b3 m3_903e_b1 m3_608 m3_901a m3_805 m3_408_3 m3_1005a m3_710_b2 m3_803h m3_704b m3_1006a m3_903g_b3 m3_617_vitaK_b1_ET m3_901q m3_701 m3_410 m3_1003 m3_1007a m3_803d m3_903d_b2 m3_1005e m3_405_1 m3_501 m3_1105_6 m3_1105_5 m3_407 m3_901p m3_607 m3_1103 m3_312_a_b3 m3_710_b3 m3_1005h m3_901l m3_903h_b2 m3_606 m3_1006b m3_505a_ET m3_403 m3_704a m3_1005c m3_615_b3 m3_622a m3_903b_b3 m3_901b m3_1005d m3_903f_b3 m3_903c_b3 m3_802a m3_704f m3_803b m3_903g_b2 m3_619f m3_903i_b3 m3_1105_2 m3_1005f m3_303_b1 {

		label value `v' yes_no_dnk_nr
	}


	foreach v in m3_621a_4 m3_519_7 m3_621a_1 m3_519_1 m3_621a_99 m3_519_2 m3_310a_b1_3 m3_518_0 m3_310a_b2_7 m3_518_6 m3_708_1_b2 m3_518_4 m3_310a_b1_2 m3_708_1_b1 m3_310a_b3_2 m3_518_1 m3_310a_b3_3 m3_708_4_b1 m3_310a_b2_5 m3_708_3_b3 m3_310a_b1_7 m3_310a_b2_4 m3_708_2_b1 m3_519_11 m3_708_6_b2 m3_310a_b3_99 m3_310a_b2_6 m3_508 m3_518_2 m3_519_3 m3_708_99_b2 m3_permission m3_518_97 m3_621a_98 m3_518_9 m3_708_3_b2 m3_518_99 m3_708_5_b2 m3_808a m3_310a_b1_99 m3_310a_b3_1 m3_310a_b3_4 m3_605c_99 m3_605c_98 m3_605c_96 m3_310a_b2_3 m3_310a_b1_4 m3_708_2_b2 m3_519_6 m3_518_7 m3_519_99 m3_621a_2 m3_519_12 m3_310a_b3_5 m3_708_5_b3 m3_708_98_b1 m3_518_5 m3_519_8 m3_518_8 m3_519_15 m3_605c_3 m3_708_1_b3 m3_708_3_b1 m3_518_98 m3_519_17 m3_518_3 m3_310a_b3_7 m3_519_14 m3_605c_2 m3_708_2_b3 m3_519_96 m3_605c_0 m3_519_16 m3_708_4_b3 m3_519_5 m3_708_4_b2 m3_519_9 m3_519_98 m3_708_5_b1 m3_708_6_b1 m3_621a_3 m3_518_96 m3_708_98_b2 m3_708_6_b3 m3_310a_b3_6 m3_310a_b1_1 m3_708_98_b3 m3_109 m3_708_99_b3 m3_310a_b1_5 m3_518_10 m3_708_99_b1 m3_519_13 m3_310a_b2_1 m3_310a_b2_2 m3_519_4 m3_621a_5 m3_621a_6 m3_310a_b2_99 m3_310a_b1_6 m3_605c_1 m3_519_10 {
		label value `v' yesno
	}

end




