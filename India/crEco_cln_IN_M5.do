

use "$in_data/Module5_29052025.dta", clear

*===============================================================================

************************* Renaming variables *************************

rename (Q104 Consent calc_start_time end duration Q102 SubmissionDate Q101 Q103 Q108) ///
	   (respondentid m5_consent m5_starttime m5_endtime m5_duration m5_dateconfirm ///
	   m5_submissiondate m5_interviewer m5_interview_time m5_hiv_status)

isid respondentid

* Check if calculated variables match their raw data counterparts
* Generate comparison variables (1 if match, 0 if different)
gen check_hiv = (Calc_HIVStatus == m5_hiv_status)
gen check_csection = (Calc_CSection == Q110)
gen check_totalbabies = (Calc_TotalBabies == Q111)
gen check_baby1alive = (Calc_Baby1Alive == Q201_1) 
gen check_baby2alive = (Calc_Baby2Alive == Q201_2)

* Tabulate the comparison results
tab1 check_*

drop Calc_HIVStatus check* start Calc_Baby3Alive id Q112_3

rename Calc* m5_calc* // do all of these calc variables need to be kept? 

rename (Q109 Q110 Q111 Q112_1 Q112_2 Q113 Q114 Q115 Q115_other) ///
	  (m5_date m5_csection m5_num_babies m5_baby1_name m5_baby2_name m5_maternal_death ///
	   m5_maternal_death_date m5_maternal_death_info m5_maternal_death_info_oth) // Delivery date

rename (Q201_1 Q202_1) (m5_baby1_alive m5_baby1_health)

rename (Q201_2 Q202_2) (m5_baby2_alive m5_baby2_health)
 
// For baby1
rename (Q203_1_1 Q203_2_1 Q203_3_1 Q203_4_1 Q203_5_1 Q203_6_1 Q203_7_1 Q203_99_1 Q204_1) ///
       (m5_baby1_feed_a m5_baby1_feed_b m5_baby1_feed_c m5_baby1_feed_d m5_baby1_feed_e m5_baby1_feed_f ///
       m5_baby1_feed_g m5_baby1_feed_99 m5_baby1_breastfeeding)

// For baby2
rename (Q203_1_2 Q203_2_2 Q203_3_2 Q203_4_2 Q203_5_2 Q203_6_2 Q203_7_2 Q203_99_2 Q204_2) ///
       (m5_baby2_feed_a m5_baby2_feed_b m5_baby2_feed_c m5_baby2_feed_d m5_baby2_feed_e m5_baby2_feed_f ///
       m5_baby2_feed_g m5_baby2_feed_99 m5_baby2_breastfeeding)

// For baby1
rename (Q205_a_1 Q205_b_1 Q205_c_1 Q205_d_1 Q205_e_1 Q205_f_1 Q205_g_1) ///
       (m5_baby1_sleep m5_baby1_feed m5_baby1_breath m5_baby1_stool m5_baby1_mood ///
       m5_baby1_skin m5_baby1_interactivity)

// For baby2
rename (Q205_a_2 Q205_b_2 Q205_c_2 Q205_d_2 Q205_e_2 Q205_f_2 Q205_g_2) ///
       (m5_baby2_sleep m5_baby2_feed m5_baby2_breath m5_baby2_stool m5_baby2_mood ///
       m5_baby2_skin m5_baby2_interactivity)		

// For baby1
rename (Q206_a_1 Q206_b_1 Q206_c_1 Q206_d_1 Q206_e_1 Q206_f_1 Q206_g_1 Q206_h_1 Q206_i_1 Q206_j_1) ///
       (m5_baby1_issue_a m5_baby1_issue_b m5_baby1_issue_c m5_baby1_issue_d m5_baby1_issue_e m5_baby1_issue_f m5_baby1_issue_g ///
       m5_baby1_issue_h m5_baby1_issue_i m5_baby1_issue_j)
	   
rename (Q207_1 Q208_Date_1 Q209_a_1 Q209_b_1) (m5_baby1_issue_oth m5_baby1_death_date ///
       m5_baby1_death_time m5_baby1_death_time_unit)

// For baby2
rename (Q206_a_2 Q206_b_2 Q206_c_2 Q206_d_2 Q206_e_2 Q206_f_2 Q206_g_2 Q206_h_2 Q206_i_2 Q206_j_2) ///
       (m5_baby2_issue_a m5_baby2_issue_b m5_baby2_issue_c m5_baby2_issue_d m5_baby2_issue_e m5_baby2_issue_f m5_baby2_issue_g ///
       m5_baby2_issue_h m5_baby2_issue_i m5_baby2_issue_j)
	   
rename (Q207_2 Q208_Date_2 Q209_a_2 Q209_b_2) (m5_baby2_issue_oth m5_baby2_death_date ///
       m5_baby2_death_time m5_baby2_death_time_unit)
	   
drop Q208_1 Q208_2
	   
// For baby1
rename (Q210_1 Q210_other_1 Q211_1 Q212_1 Q212_other_1) ///
       (m5_baby1_death_cause m5_baby1_death_cause_oth_text m5_baby1_advice m5_baby1_death_loc m5_baby1_death_loc_oth)

// For baby2
rename (Q210_2 Q210_other_2 Q211_2 Q212_2 Q212_other_2) ///
       (m5_baby2_death_cause m5_baby2_death_cause_oth_text m5_baby2_advice m5_baby2_death_loc m5_baby2_death_loc_oth)
		
	
rename (Q301 Q302_a Q302_b Q302_c Q302_d Q302_e Q303_a Q303_b Q303_c Q303_d Q303_e Q303_f Q303_g Q303_h Q303_i Q304) (m5_health m5_health_a ///
        m5_health_b m5_health_c m5_health_d m5_health_e m5_depression_a m5_depression_b m5_depression_c m5_depression_d m5_depression_e ///
		m5_depression_f m5_depression_g m5_depression_h m5_depression_i m5_health_affect_scale)
		
rename (Q305_a Q305_b Q305_c Q305_d Q305_e Q305_f Q305_g Q305_h Q306 Q307 Q308 Q309 Q310 Q312) (m5_feeling_a m5_feeling_b m5_feeling_c ///
        m5_feeling_d m5_feeling_e m5_feeling_f m5_feeling_g m5_feeling_h m5_pain m5_leakage m5_leakage_when m5_leakage_affect m5_leakage_treatment ///
		 m5_leakage_treateffect)
		
rename (Q311 Q311_1 Q311_2 Q311_3 Q311_4 Q311_5 Q311_6 Q311_7 Q311_8 Q311_9 Q311_10 Q311_11 Q311_12 Q311_13 Q311_96 Q311_99 Q311_other) (m5_311 m5_311_1 m5_311_2 m5_311_3 m5_311_4 m5_311_5 m5_311_6 m5_311_7 m5_311_8 m5_311_9 m5_311_10 m5_311_11 m5_311_12 m5_311_13 m5_311_96 m5_311_99 m5_311_other)		
		
rename (Q401 Q402 Q403 Q404 Q405_a Q405_b Q406_a Q406_b) (m5_401 m5_402 m5_403 m5_404 m5_405a m5_405b m5_406a m5_406b)
	
		
rename (Q501_a Q501_b Q502 Q503_a Q503_a_Name Q503_b Q503_b_Name Q503_c Q503_c_Name Q504_a Q504_a_other Q504_a_Name Q504_b Q504_b_other Q504_b_Name Q504_c Q504_c_other Q504_c_Name) (m5_501a m5_501b m5_502 m5_503_1 m5_503_1_name m5_503_2 m5_503_2_name m5_503_3 m5_503_3_name m5_504_1 m5_504_1_other m5_504_1_name m5_504_2 m5_504_2_other m5_504_2_name m5_504_3 m5_504_3_other m5_504_3_name)
* First consultation variables
rename (Q505 Q506 Q506_1 Q506_2 Q506_3 Q506_4 Q506_5 Q506_6 Q506_7 Q506_8 Q506_9 Q506_10 Q506_96 Q506_other) ///
       (m5_505 m5_506 m5_506_1 m5_506_2 m5_506_3 m5_506_4 m5_506_5 m5_506_6 m5_506_7 m5_506_8 m5_506_9 m5_506_10 m5_506_96 m5_506_other)

* Second consultation variables
rename (Q507 Q508 Q508_1 Q508_2 Q508_3 Q508_4 Q508_5 Q508_6 Q508_7 Q508_8 Q508_9 Q508_10 Q508_96 Q508_other) ///
       (m5_507 m5_508 m5_508_1 m5_508_2 m5_508_3 m5_508_4 m5_508_5 m5_508_6 m5_508_7 m5_508_8 m5_508_9 m5_508_10 m5_508_96 m5_508_other)

* Third consultation variables
rename (Q509 Q510 Q510_1 Q510_2 Q510_3 Q510_4 Q510_5 Q510_6 Q510_7 Q510_8 Q510_9 Q510_10 Q510_96 Q510_other) ///
       (m5_509 m5_510 m5_510_1 m5_510_2 m5_510_3 m5_510_4 m5_510_5 m5_510_6 m5_510_7 m5_510_8 m5_510_9 m5_510_10 m5_510_96 m5_510_other)

* Reasons that prevent seeking care variables
rename (Q511 Q511_0 Q511_1 Q511_2 Q511_3 Q511_4 Q511_5 Q511_6 Q511_7 Q511_8 Q511_9 Q511_10 Q511_11 Q511_96 Q511_99 Q511_other) ///
       (m5_511 m5_511_0 m5_511_1 m5_511_2 m5_511_3 m5_511_4 m5_511_5 m5_511_6 m5_511_7 m5_511_8 m5_511_9 m5_511_10 m5_511_11 m5_511_96 m5_511_99 m5_511_other)

* Quality of care rating variables
rename (Q601 Q602 Q603) (m5_consultation1_carequal m5_consultation2_carequal m5_consultation3_carequal)
rename (Q701_a Q701_b Q701_c Q701_d Q701_e Q701_f Q701_g Q701_h Q701_i Q701_i_oth) (m5_baby1_701a m5_baby1_701b m5_baby1_701c ///
		m5_baby1_701d m5_baby1_701e m5_baby1_701f m5_baby1_701g m5_baby1_701h m5_baby1_701i m5_baby1_701i_other) 
		

rename (Q702_a Q702_b Q702_c Q702_d Q702_e Q702_f Q702_g) (m5_702a m5_702b m5_702c m5_702d m5_702e m5_702f m5_702g)

rename (Q703_a Q703_a_0 Q703_a_1 Q703_a_2 Q703_a_3 Q703_a_4 Q703_a_5 Q703_a_6 Q703_a_96 Q703_a_98 Q703_a_99 Q703_a_oth) ///
       (m5_703_a m5_703_a_0 m5_703_a_1 m5_703_a_2 m5_703_a_3 ///
        m5_703_a_4 m5_703_a_5 m5_703_a_6 m5_703_a_96 ///
        m5_703_a_98 m5_703_a_99 m5_703_a_other) 
        
* Rename Q703 series for all symptoms (b through j)
foreach letter in b c d e f g h i j {
    rename Q703_`letter' m5_703_`letter'
    foreach num in 0 1 2 3 4 5 6 96 98 99 {
        capture rename Q703_`letter'_`num' m5_703_`letter'_`num'
    }
    capture rename Q703_`letter'_other m5_703_`letter'_other
}

rename (Q801_a Q801_b Q801_c Q801_d Q801_e Q801_f Q801_g Q801_h Q801_h_specify Q802 Q803_a Q803_b Q803_c Q803_d Q803_e ///
		Q803_f Q803_g Q804_a Q804_b Q804_c ) ///
       (m5_801a m5_801b m5_801c m5_801d m5_801e m5_801f m5_801g m5_801h m5_801_other m5_802 m5_803a m5_803b m5_803c m5_803d m5_803e m5_803f ///
	    m5_803g m5_804a m5_804b m5_804c )

rename (Q901_a Q901_b Q901_c Q901_d Q901_e Q901_f Q901_g Q901_h Q901_i Q901_j Q901_k Q901_l Q901_m Q901_n Q901_o Q901_p Q901_q Q901_r Q901_r_specify) (m5_901a m5_901b m5_901c m5_901d m5_901e m5_901f m5_901g m5_901h m5_901i m5_901j m5_901k m5_901l m5_901m m5_901n m5_901o m5_901p m5_901q m5_901s m5_901s_other)

rename (Q1101 Q1102 Q1102_1 Q1102_2 Q1102_3 Q1102_4 Q1102_5 Q1102_6 Q1102_7 Q1102_8 Q1102_9 Q1102_10 Q1102_11 Q1102_12 Q1102_13 Q1102_14 Q1102_15 Q1102_16 Q1102_17 Q1102_18 Q1102_19 Q1102_20 Q1102_21 Q1102_96 Q1102_other Q1103) (m5_1101 m5_1102 m5_1102a m5_1102b m5_1102c m5_1102d m5_1102e m5_1102f m5_1102g m5_1102h m5_1102i m5_1102j m5_1102k m5_1102l m5_1102m m5_1102n m5_1102o m5_1102p m5_1102q m5_1102r m5_1102s m5_1102t m5_1102u m5_1102_other m5_1102_other_text m5_1103)

rename (Q1104 Q1104_1 Q1104_2 Q1104_3 Q1104_4 Q1104_5 Q1104_6 Q1104_7 Q1104_8 Q1104_9 Q1104_10 Q1104_11 Q1104_12 Q1104_13 Q1104_14 Q1104_15 Q1104_16 Q1104_17 Q1104_18 Q1104_19 Q1104_20 Q1104_21 Q1104_96 Q1104_other) (m5_1104 m5_1104a m5_1104b m5_1104c m5_1104d m5_1104e m5_1104f m5_1104g m5_1104h m5_1104i m5_1104j m5_1104k m5_1104l m5_1104m m5_1104n m5_1104o m5_1104p m5_1104q m5_1104r m5_1104s m5_1104t m5_1104u m5_1104_other m5_1104_other_text)

rename (Q1105 Q1201 Q1202 Q1301 Q1302 Q1303_a Q1303_b Q1303_c Q1304_a Q1304_b Q1304_c Q1305_a Q1305_b Q1305_c Q1306 Q1307 Q1401 Q1402 Q1403) (m5_1105 m5_1201 m5_1202 m5_1301 m5_1302 m5_1303a m5_1303b m5_1303c m5_1304a m5_1304b m5_1304c m5_1305a m5_1305b m5_1305c m5_1306 m5_1307 m5_baby1_1401 m5_baby1_1402 m5_baby1_1403)

* NK Note - missing for baby2? 

rename (Q902_a Q902_b Q902_c Q902_d Q902_e Q902_f Q902_g Q902_h Q902_i Q902_j Q902_j_specify) (m5_902a ///
        m5_902b m5_902c m5_902d m5_902e m5_902f m5_902g m5_902h ///
        m5_902i m5_902j m5_902_other)
        
rename (Q903_a Q903_b Q903_c Q903_d Q903_e Q903_f Q903_g) (m5_903a m5_903b m5_903c m5_903d ///
        m5_903e m5_903f m5_903_other)

rename (Q904 Q905) (m5_904 m5_905)

rename (Q1001 Q1002_a Q1002_b Q1002_c Q1002_d Q1002_e Q1002_e_other Q1003 Q1004 Q1005 Q1005_1 ///
		Q1005_2 Q1005_3 Q1005_4 Q1005_5 Q1005_6 Q1005_96 Q1005_oth) ///
       (m5_1001 m5_1002a m5_1002b m5_1002c m5_1002d m5_1002e m5_1002_other ///
	   m5_1003 m5_1004 m5_1005 m5_1005a m5_1005b m5_1005c m5_1005d m5_1005e ///
	    m5_1005f m5_1005_other m5_1005_other_text)	


************************* Labeling variables *************************

run "$github/m5_add_shortened_labels.ado"


************************* Merge *************************

merge 1:1 respondentid using "$in_data_final/eco_IN_m1_m4.dta" // 170 not matched

rename _merge merge_m5_to_m4_m3_m2_m1

save "$in_data_final/eco_m1-m5_in.dta", replace
