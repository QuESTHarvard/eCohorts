

use "$in_data/Module5_13052025.dta", clear

*===============================================================================

* IN renaming - copied over from KE 
* ignored some drop vars before this 

ren Q104 respondentid

rename (Consent calc_start_time end duration Q102 SubmissionDate Q101 Q108) ///
	   (m5_consent m5_starttime m5_endtime m5_duration m5_dateconfirm m5_submissiondate m5_csection hiv_status)

drop start

* NK note - need to update date/time vars 
* What are all these calc vars???
		
* NK Note - what about ID? or Q104??? 

rename (Q201 Q202) (m5_baby1_alive m5_baby1_health)

** Q201_2 Q202_2 m5_baby2_alive m5_baby2_health
 
rename (Q203_1 Q203_2 Q203_3 Q203_4 Q203_5 Q203_6 Q203_7 Q203_99 Q204) ///
       (m5_baby1_feed_a m5_baby1_feed_b m5_baby1_feed_c m5_baby1_feed_d m5_baby1_feed_e m5_baby1_feed_f ///
	   m5_baby1_feed_g m5_baby1_feed_99 m5_baby1_breastfeeding)

*rename (Q203_1_1 Q203_2_1 Q203_3_1 Q203_4_1 Q203_5_1 Q203_6_1 Q203_7_1 Q203_99_1 Q204_1) ///
       (m5_baby2_feed_a m5_baby2_feed_b m5_baby2_feed_c m5_baby2_feed_d m5_baby2_feed_e m5_baby2_feed_f ///
	   m5_baby2_feed_g m5_baby2_feed_99 m5_baby2_breastfeeding)	
	   	   
/*
encode Q203_1_2,gen(m5_baby2_feed_a)	
char m5_baby2_feed_a[Original_KE_Varname] `Q203_1_2[Original_KE_Varname]'

encode Q203_2_2,gen(m5_baby2_feed_b)	
char m5_baby2_feed_b[Original_KE_Varname] `Q203_2_2[Original_KE_Varname]'

encode Q203_3_2,gen(m5_baby2_feed_c)	
char m5_baby2_feed_c[Original_KE_Varname] `Q203_3_2[Original_KE_Varname]'

encode Q203_4_2,gen(m5_baby2_feed_d)	
char m5_baby2_feed_d[Original_KE_Varname] `Q203_4_2[Original_KE_Varname]'

encode Q203_5_2,gen(m5_baby2_feed_e)	
char m5_baby2_feed_e[Original_KE_Varname] `Q203_5_2[Original_KE_Varname]'

encode Q203_6_2,gen(m5_baby2_feed_f)	
char m5_baby2_feed_f[Original_KE_Varname] `Q203_6_2[Original_KE_Varname]'

encode Q203_7_2,gen(m5_baby2_feed_g)	
char m5_baby2_feed_g[Original_KE_Varname] `Q203_7_2[Original_KE_Varname]'

encode Q203_99_2,gen(m5_baby2_feed_99)	
char m5_baby2_feed_99[Original_KE_Varname] `Q203_99_2[Original_KE_Varname]'

drop Q203_1_2 Q203_2_2 Q203_3_2 Q203_4_2 Q203_5_2 Q203_6_2 Q203_7_2 Q203_99_2
*/

*rename Q204_2 m5_baby2_breastfeeding	   

rename (Q205_a Q205_b Q205_c Q205_d Q205_e Q205_f Q205_g) (m5_baby1_sleep m5_baby1_feed m5_baby1_breath ///
	    m5_baby1_stool m5_baby1_mood m5_baby1_skin m5_baby1_interactivity)
		
*rename (Q205a_2 Q205b_2 Q205c_2 Q205d_2 Q205e_2 Q205f_2 Q205g_2) (m5_baby2_sleep m5_baby2_feed m5_baby2_breath ///
	    m5_baby2_stool m5_baby2_mood m5_baby2_skin m5_baby2_interactivity)		

rename (Q206_a Q206_b Q206_c Q206_d Q206_e Q206_f Q206_g Q206_h Q206_i Q206_j) ///
       (m5_baby1_issue_a m5_baby1_issue_b m5_baby1_issue_c m5_baby1_issue_d m5_baby1_issue_e m5_baby1_issue_f m5_baby1_issue_g ///
	   m5_baby1_issue_h m5_baby1_issue_i m5_baby1_issues_j)
	   
rename (Q207 Q208_Date Q209_a Q209_b) (m5_baby1_issue_oth m5_baby1_death_date ///
	   m5_baby1_death_time m5_baby1_death_time_unit)
	   
* baby 2 items missing- Q207b_1
drop Q208
	   
/*
encode Q206_1_2,gen(m5_baby2_issue_a)	
char m5_baby2_issue_a[Original_KE_Varname] `Q206_1_2[Original_KE_Varname]'

encode Q206_2_2,gen(m5_baby2_issue_b)	
char m5_baby2_issue_b[Original_KE_Varname] `Q206_2_2[Original_KE_Varname]'

encode Q206_3_2,gen(m5_baby2_issue_c)	
char m5_baby2_issue_c[Original_KE_Varname] `Q206_3_2[Original_KE_Varname]'

encode Q206_4_2,gen(m5_baby2_issue_d)	
char m5_baby2_issue_d[Original_KE_Varname] `Q206_4_2[Original_KE_Varname]'

encode Q206_5_2,gen(m5_baby2_issue_e)	
char m5_baby2_issue_e[Original_KE_Varname] `Q206_5_2[Original_KE_Varname]'

encode Q206_6_2,gen(m5_baby2_issue_f)	
char m5_baby2_issue_f[Original_KE_Varname] `Q206_6_2[Original_KE_Varname]'

encode Q206_7_2,gen(m5_baby2_issue_g)	
char m5_baby2_issue_g[Original_KE_Varname] `Q206_7_2[Original_KE_Varname]'

encode Q206_8_2,gen(m5_baby2_issue_h)	
char m5_baby2_issue_h[Original_KE_Varname] `Q206_8_2[Original_KE_Varname]'

encode Q206_9_2,gen(m5_baby2_issue_i)	   	   
char m5_baby2_issue_i[Original_KE_Varname] `Q206_9_2[Original_KE_Varname]'

encode Q206_0_2,gen(m5_baby2_issues_none)	 
char m5_baby2_issues_none[Original_KE_Varname] `Q206_0_2[Original_KE_Varname]'

drop Q206_1_2 Q206_2_2 Q206_3_2 Q206_4_2 Q206_5_2 Q206_6_2 Q206_7_2 Q206_8_2 Q206_9_2 Q206_0_2

*/

*rename (Q207a_2 Q207b_2 Q208_2 Q209_2 Q209_unit_2) (m5_baby2_issue_oth m5_baby2_issue_oth_text m5_baby2_death_date ///
	   m5_baby2_death_time m5_baby2_death_time_unit)	   
	   
*rename (Q210_0_1 Q210_1_1 Q210_2_1 Q210_3_1 Q210_4_1 Q210_5_1 Q210_6_1 Q210_7_1 Q210_8_1 ///
		Q210_9_1 Q210__96_1 Q210_98_1 Q210_99_1 Q210_oth_1 Q211_1 ///
        Q212_1 Q212_oth_1) (m5_baby1_death_cause_a m5_baby1_death_cause_b m5_baby1_death_cause_c m5_baby1_death_cause_d ///
		m5_baby1_death_cause_e m5_baby1_death_cause_f m5_baby1_death_cause_g m5_baby1_death_cause_h m5_baby1_death_cause_i ///
		m5_baby1_death_cause_j m5_baby1_death_cause_oth m5_baby1_death_cause_98 m5_baby1_death_cause_99 m5_baby1_death_cause_oth_text ///
		m5_baby1_death_tx m5_baby1_death_loc m5_baby1_death_loc_oth) 

rename (Q210 Q210_other Q211 Q212 Q212_other) ///
		(m5_baby1_death_cause m5_baby1_death_cause_oth_text m5_baby1_advice m5_baby1_death_loc m5_baby2_death_loc_oth)
		
/*				
encode Q210_0_2,gen(m5_baby2_death_cause_a)	
char m5_baby2_death_cause_a[Original_KE_Varname] `Q210_0_2[Original_KE_Varname]'

encode Q210_1_2,gen(m5_baby2_death_cause_b)	
char m5_baby2_death_cause_b[Original_KE_Varname] `Q210_1_2[Original_KE_Varname]'

encode Q210_2_2,gen(m5_baby2_death_cause_c)	
char m5_baby2_death_cause_c[Original_KE_Varname] `Q210_2_2[Original_KE_Varname]'

encode Q210_3_2,gen(m5_baby2_death_cause_d)	
char m5_baby2_death_cause_d[Original_KE_Varname] `Q210_3_2[Original_KE_Varname]'

encode Q210_4_2,gen(m5_baby2_death_cause_e)	
char m5_baby2_death_cause_e[Original_KE_Varname] `Q210_4_2[Original_KE_Varname]'

encode Q210_5_2,gen(m5_baby2_death_cause_f)	
char m5_baby2_death_cause_f[Original_KE_Varname] `Q210_5_2[Original_KE_Varname]'

encode Q210_6_2,gen(m5_baby2_death_cause_g)	
char m5_baby2_death_cause_g[Original_KE_Varname] `Q210_6_2[Original_KE_Varname]'

encode Q210_7_2,gen(m5_baby2_death_cause_h)	
char m5_baby2_death_cause_h[Original_KE_Varname] `Q210_7_2[Original_KE_Varname]'

encode Q210_8_2,gen(m5_baby2_death_cause_i)	
char m5_baby2_death_cause_i[Original_KE_Varname] `Q210_8_2[Original_KE_Varname]'

encode Q210_9_2,gen(m5_baby2_death_cause_j)
char m5_baby2_death_cause_j[Original_KE_Varname] `Q210_9_2[Original_KE_Varname]'

encode Q210__96_2,gen(m5_baby2_death_cause_oth)
char m5_baby2_death_cause_oth[Original_KE_Varname] `Q210__96_2[Original_KE_Varname]'

encode Q210_98_2,gen(m5_baby2_death_cause_98)
char m5_baby2_death_cause_98[Original_KE_Varname] `Q210_98_2[Original_KE_Varname]'

encode Q210_99_2,gen(m5_baby2_death_cause_99)	
char m5_baby2_death_cause_99[Original_KE_Varname] `Q210_99_2[Original_KE_Varname]'

rename Q210_oth_2 m5_baby2_death_cause_oth_text

drop Q210_0_2 Q210_1_2 Q210_2_2 Q210_3_2 Q210_4_2 Q210_5_2 Q210_6_2 Q210_7_2 Q210_8_2 Q210_9_2 Q210__96_2 Q210_98_2 Q210_99_2

rename Q211_2 m5_baby2_death_tx
rename Q212_2 m5_baby2_death_loc
rename Q212_oth_2 m5_baby2_death_loc_oth
*/

	
rename (Q301 Q302_a Q302_b Q302_c Q302_d Q302_e Q303_a Q303_b Q303_c Q303_d Q303_e Q303_f Q303_g Q303_h Q303_i Q304) (m5_health m5_health_a ///
        m5_health_b m5_health_c m5_health_d m5_health_e m5_depression_a m5_depression_b m5_depression_c m5_depression_d m5_depression_e ///
		m5_depression_f m5_depression_g m5_depression_h m5_depression_i m5_health_affect_scale)
		
* depression_sum m5_health_affect_scale

rename (Q305_a Q305_b Q305_c Q305_d Q305_e Q305_f Q305_g Q305_h Q306 Q307 Q308 Q309 Q310 Q312) (m5_feeling_a m5_feeling_b m5_feeling_c ///
        m5_feeling_d m5_feeling_e m5_feeling_f m5_feeling_g m5_feeling_h m5_pain m5_leakage m5_leakage_when m5_leakage_affect m5_leakage_treatment ///
		 m5_leakage_treateffect)
		
		* Q311 Q311_oth m5_leakage_no_treatment m5_leakage_no_treatment_oth

rename (Q401 Q402 Q403 Q404 Q405_a Q405_b Q406_a Q406_b) (m5_401 m5_402 m5_403 m5_404 m5_405a m5_405b m5_406a m5_406b)



* new_visits_index_1 new_visits_index_2 new_visits_index_3 m5_new_visits_index_1 m5_new_visits_index_2 m5_new_visits_index_3
* Q503_4 Q503_5 Q503_6 Q503_7 Q503_8  m5_503_4 m5_503_5 m5_503_6 m5_503_7 m5_503_8 

/*		
encode new_visits_index_4, gen(m5_new_visits_index_4)
encode new_visits_index_5, gen(m5_new_visits_index_5)
encode new_visits_index_6, gen(m5_new_visits_index_6)
encode new_visits_index_7, gen(m5_new_visits_index_7)
encode new_visits_index_8, gen(m5_new_visits_index_8)
forvalues i = 4/8 {
	char m5_new_visits_index_`i'[Original_KE_Varname] `new_visits_index_`i'[Original_KE_Varname]'
}
*/

rename (Q501_a Q501_b Q502 Q503_a Q503_b Q503_c Q505) ///
		(m5_501a m5_501b m5_502 m5_503_1 m5_503_2 m5_503_3 m5_505)

rename (Q503_a_Name Q503_b_Name Q503_c_Name) (m5_503_1_name m5_503_2_name m5_503_3_name)	

/*
rename (Q506_1 Q506_1_1 Q506_2_1 Q506_3_1 Q506_4_1 Q506_5_1 Q506_6_1 Q506_7_1 Q506_8_1 Q506_9_1 Q506_10_1 Q506__96_1 Q506_oth_1) (m5_consultation1 ///
        m5_consultation1_a m5_consultation1_b m5_consultation1_c m5_consultation1_d m5_consultation1_e m5_consultation1_f m5_consultation1_g ///
		m5_consultation1_h m5_consultation1_i m5_consultation1_j m5_consultation1_oth m5_consultation1_oth_text)

rename (Q506_2 Q506_1_2 Q506_2_2 Q506_3_2 Q506_4_2 Q506_5_2 Q506_6_2 Q506_7_2 Q506_8_2 Q506_9_2 Q506_10_2 Q506__96_2 Q506_oth_2) (m5_consultation2 ///
        m5_consultation2_a m5_consultation2_b m5_consultation2_c m5_consultation2_d m5_consultation2_e m5_consultation2_f m5_consultation2_g ///
		m5_consultation2_h m5_consultation2_i m5_consultation2_j m5_consultation2_oth m5_consultation2_oth_text)

rename (Q506_3 Q506_1_3 Q506_2_3 Q506_3_3 Q506_4_3 Q506_5_3 Q506_6_3 Q506_7_3 Q506_8_3 Q506_9_3 Q506_10_3 Q506__96_3 Q506_oth_3) ///
	   (m5_consultation3 m5_consultation3_a m5_consultation3_b m5_consultation3_c m5_consultation3_d m5_consultation3_e m5_consultation3_f ///
	   m5_consultation3_g m5_consultation3_h m5_consultation3_i m5_consultation3_j m5_consultation3_oth m5_consultation3_oth_text)

encode Q506_4, gen(m5_consultation4)
char m5_consultation4[Original_KE_Varname] `Q506_4[Original_KE_Varname]'

encode Q506_1_4, gen(m5_consultation4_a)
encode Q506_2_4, gen(m5_consultation4_b)
encode Q506_3_4, gen(m5_consultation4_c)
encode Q506_4_4, gen(m5_consultation4_d)
encode Q506_5_4, gen(m5_consultation4_e)
encode Q506_6_4, gen(m5_consultation4_f)
encode Q506_7_4, gen(m5_consultation4_g)
encode Q506_8_4, gen(m5_consultation4_h)
encode Q506_9_4, gen(m5_consultation4_i)
encode Q506_10_4, gen(m5_consultation4_j)
local b 1
foreach i in a b c d e f g h i j {
	char m5_consultation4_`i'[Original_KE_Varname] `Q506_`b'_4[Original_KE_Varname]'
	local ++b
}

encode Q506__96_4, gen(m5_consultation4_oth)
char m5_consultation4_oth[Original_KE_Varname] `Q506__96_4[Original_KE_Varname]'

rename Q506_oth_4 m5_consultation4_oth_text

encode Q506_5, gen(m5_consultation5)
char m5_consultation5[Original_KE_Varname] `Q506_5[Original_KE_Varname]'
encode Q506_1_5, gen(m5_consultation5_a)
encode Q506_2_5, gen(m5_consultation5_b)
encode Q506_3_5, gen(m5_consultation5_c)
encode Q506_5_5, gen(m5_consultation5_d)
encode Q506_5_5, gen(m5_consultation5_e)
encode Q506_6_5, gen(m5_consultation5_f)
encode Q506_7_5, gen(m5_consultation5_g)
encode Q506_8_5, gen(m5_consultation5_h)
encode Q506_9_5, gen(m5_consultation5_i)
encode Q506_10_5, gen(m5_consultation5_j)

local b 1
foreach i in a b c d e f g h i j {
	char m5_consultation5_`i'[Original_KE_Varname] `Q506_`b'_5[Original_KE_Varname]'
	local ++b
}

encode Q506__96_5, gen(m5_consultation5_oth)
char m5_consultation5_oth[Original_KE_Varname] `Q506__96_5[Original_KE_Varname]'

rename Q506_oth_5 m5_consultation5_oth_text

encode Q506_6, gen(m5_consultation6)
char m5_consultation6[Original_KE_Varname] `Q506_6[Original_KE_Varname]'
encode Q506_1_6, gen(m5_consultation6_a)
encode Q506_2_6, gen(m5_consultation6_b)
encode Q506_3_6, gen(m5_consultation6_c)
encode Q506_6_6, gen(m5_consultation6_d)
encode Q506_5_6, gen(m5_consultation6_e)
encode Q506_6_6, gen(m5_consultation6_f)
encode Q506_7_6, gen(m5_consultation6_g)
encode Q506_8_6, gen(m5_consultation6_h)
encode Q506_9_6, gen(m5_consultation6_i)
encode Q506_10_6, gen(m5_consultation6_j)

local b 1
foreach i in a b c d e f g h i j {
	char m5_consultation6_`i'[Original_KE_Varname] `Q506_`b'_6[Original_KE_Varname]'
	local ++b
}

encode Q506__96_6, gen(m5_consultation6_oth)
char m5_consultation6_oth[Original_KE_Varname] `Q506__96_6[Original_KE_Varname]'

rename Q506_oth_6 m5_consultation6_oth_text


encode Q506_7, gen(m5_consultation7)
char m5_consultation7[Original_KE_Varname] `Q506_7[Original_KE_Varname]'
encode Q506_1_7, gen(m5_consultation7_a)
encode Q506_2_7, gen(m5_consultation7_b)
encode Q506_3_7, gen(m5_consultation7_c)
encode Q506_7_7, gen(m5_consultation7_d)
encode Q506_5_7, gen(m5_consultation7_e)
encode Q506_6_7, gen(m5_consultation7_f)
encode Q506_7_7, gen(m5_consultation7_g)
encode Q506_8_7, gen(m5_consultation7_h)
encode Q506_9_7, gen(m5_consultation7_i)
encode Q506_10_7, gen(m5_consultation7_j)

local b 1
foreach i in a b c d e f g h i j {
	char m5_consultation7_`i'[Original_KE_Varname] `Q506_`b'_7[Original_KE_Varname]'
	local ++b
}

encode Q506__96_7, gen(m5_consultation7_oth)
char m5_consultation7_oth[Original_KE_Varname] `Q506__96_7[Original_KE_Varname]'

rename Q506_oth_7 m5_consultation7_oth_text

encode Q506_8, gen(m5_consultation8)
char m5_consultation8[Original_KE_Varname] `Q506_8[Original_KE_Varname]'
encode Q506_1_8, gen(m5_consultation8_a)
encode Q506_2_8, gen(m5_consultation8_b)
encode Q506_3_8, gen(m5_consultation8_c)
encode Q506_8_8, gen(m5_consultation8_d)
encode Q506_5_8, gen(m5_consultation8_e)
encode Q506_6_8, gen(m5_consultation8_f)
encode Q506_7_8, gen(m5_consultation8_g)
encode Q506_8_8, gen(m5_consultation8_h)
encode Q506_9_8, gen(m5_consultation8_i)
encode Q506_10_8, gen(m5_consultation8_j)

local b 1
foreach i in a b c d e f g h i j {
	char m5_consultation8_`i'[Original_KE_Varname] `Q506_`b'_8[Original_KE_Varname]'
	local ++b
}
encode Q506__96_8, gen(m5_consultation8_oth)
char m5_consultation8_oth[Original_KE_Varname] `Q506__96_8[Original_KE_Varname]'

rename Q506_oth_8 m5_consultation8_oth_text

drop Q506_4 Q506_1_4 Q506_2_4 Q506_3_4 Q506_4_4 Q506_5_4 Q506_6_4 Q506_7_4 Q506_8_4 Q506_9_4 Q506_10_4 Q506__96_4 Q506_5 Q506_1_5 Q506_2_5 Q506_3_5 Q506_4_5 Q506_5_5 Q506_6_5 Q506_7_5 Q506_8_5 Q506_9_5 Q506_10_5 Q506__96_5 Q506_6 Q506_1_6 Q506_2_6 Q506_3_6 Q506_4_6 Q506_5_6 Q506_6_6 Q506_7_6 Q506_8_6 Q506_9_6 Q506_10_6 Q506__96_6 Q506_7 Q506_1_7 Q506_2_7 Q506_3_7 Q506_4_7 Q506_5_7 Q506_6_7 Q506_7_7 Q506_8_7 Q506_9_7 Q506_10_7 Q506__96_7 Q506_8 Q506_1_8 Q506_2_8 Q506_3_8 Q506_4_8 Q506_5_8 Q506_6_8 Q506_7_8 Q506_8_8 Q506_9_8 Q506_10_8 Q506__96_8
	   
		  	  
rename (Q511 Q511_oth Q601_1 Q601_2 Q601_3 Q601_4 Q601_5 Q601_6 Q601_7 Q601_8 user_experience_rpt_count) ///
	   (m5_no_visit m5_no_visit_oth m5_consultation1_careQual m5_consultation2_careQual m5_consultation3_careQual ///
	   m5_consultation4_careQual m5_consultation5_careQual m5_consultation6_careQual m5_consultation7_careQual ///
	   m5_consultation8_careQual m5_n_consultation_careQuality)
*/

rename (Q701_a Q701_b Q701_c Q701_d Q701_e Q701_f Q701_g Q701_h Q701_i Q701_i_oth) (m5_baby1_701a m5_baby1_701b m5_baby1_701c ///
		m5_baby1_701d m5_baby1_701e m5_baby1_701f m5_baby1_701g m5_baby1_701h m5_baby1_701i m5_baby1_701i_other) 
		
*rename (Q701a_2 Q701b_2 Q701c_2 Q701d_2 Q701e_2 Q701f_2 Q701g_2 Q701h_2 Q701i_2 Q701_oth_2) (m5_baby2_701a m5_baby2_701b m5_baby2_701c ///
		m5_baby2_701d m5_baby2_701e m5_baby2_701f m5_baby2_701g m5_baby2_701h m5_baby2_701i m5_baby2_701i_other) 		

rename (Q702_a Q702_b Q702_c Q702_d Q702_e Q702_f Q702_g) (m5_702a m5_702b m5_702c m5_702d m5_702e m5_702f m5_702g)

rename (Q703_a Q703_a_0 Q703_a_1 Q703_a_2 Q703_a_3 Q703_a_4 Q703_a_5 Q703_a_6 Q703_a_96 Q703_a_98 Q703_a_99 Q703_a_oth) ///
	   (m5_baby1_703 m5_baby1_703a m5_baby1_703b m5_baby1_703c m5_baby1_703d ///
        m5_baby1_703e m5_baby1_703f m5_baby1_703g m5_baby1_703_96 ///
		m5_baby1_703_98 m5_baby1_703_99 m5_baby1_703_other) 
		
/*	
encode Q703_0_2,gen(m5_baby2_703a)
encode Q703_1_2,gen(m5_baby2_703b)
encode Q703_2_2,gen(m5_baby2_703c)
encode Q703_3_2,gen(m5_baby2_703d)
encode Q703_4_2,gen(m5_baby2_703e)
encode Q703_5_2,gen(m5_baby2_703f)
encode Q703_6_2,gen(m5_baby2_703g)
encode Q703__96_2,gen(m5_baby2_703h)
char m5_baby2_703h[Original_KE_Varname] `Q703__96_2[Original_KE_Varname]'

encode Q703_98_2,gen(m5_baby2_703_98)
char m5_baby2_703_98[Original_KE_Varname] `Q703_98_2[Original_KE_Varname]'

encode Q703_99_2,gen(m5_baby2_703_99)
char m5_baby2_703_99[Original_KE_Varname] `Q703_99_2[Original_KE_Varname]'

rename Q703_oth_2 m5_baby2_703_other	

local b 0
foreach i in a b c d e f g  {
	char m5_baby2_703`i'[Original_KE_Varname] `Q703_`b'_2[Original_KE_Varname]'
	local ++b
}

*/

*drop Q703_0_2 Q703_1_2 Q703_2_2 Q703_3_2 Q703_4_2 Q703_5_2 Q703_6_2 Q703__96_2 Q703_98_2 Q703_99_2

rename (Q801a Q801b Q801c Q801d Q801e Q801f Q801g Q801h Q801oth Q802 Q803a Q803b Q803c Q803d Q803e Q803f Q803g Q804a Q804b Q804c baby_repeat_med_count) ///
       (m5_801a m5_801b m5_801c m5_801d m5_801e m5_801f m5_801g m5_801h m5_801_other m5_802 m5_803a m5_803b m5_803c m5_803d m5_803e m5_803f ///
	    m5_803g m5_804a m5_804b m5_804c m5_n_baby_med)

rename Q901Q m5_901Q
rename Q901r m5_901s
rename Q901r_oth m5_901s_other

foreach v in a b c d e f g h i j k l m n o p {
	egen m5_901`v' = rowtotal(Q901`v'_1 Q901`v'_2 Q901`v'_3 Q901`v'_4 Q901`v'_5 Q901`v'_6 Q901`v'_7 Q901`v'_8 Q901`v'_9 Q901`v'_10 Q901`v'_11 Q901`v'_12 Q901`v'_13 Q901`v'_14 Q901`v'_15 Q901`v'_16)
	char m5_901`v'[Module] 5
	char m5_901`v'[Original_KE_Varname] Q901`v' (Whichever variable had a populated value from Q901`v'_1-Q901`v'_16)
	
	
	drop Q901`v'*_*
}

drop Q901_rand_* Q901_order_count


rename (Q902a_1 Q902b_1 Q902c_1 Q902d_1 Q902e_1 Q902f_1 Q902g_1 Q902h_1 Q902i_1 Q902j_1 Q902_oth_1) (m5_baby1_902a ///
        m5_baby1_902b m5_baby1_902c m5_baby1_902d m5_baby1_902e m5_baby1_902f m5_baby1_902g m5_baby1_902h ///
		m5_baby1_902i m5_baby1_902j m5_baby1_902_other) 
		
rename (Q902a_2 Q902b_2 Q902c_2 Q902d_2 Q902e_2 Q902f_2 Q902g_2 Q902h_2 Q902i_2 Q902j_2 Q902_oth_2) (m5_baby2_902a ///
        m5_baby2_902b m5_baby2_902c m5_baby2_902d m5_baby2_902e m5_baby2_902f m5_baby2_902g m5_baby2_902h m5_baby2_902i ///
		m5_baby2_902j m5_baby2_902_other)
		
rename (Q903a_1 Q903b_1 Q903c_1 Q903d_1 Q903e_1 Q903f_1 Q903_oth_1) (m5_baby1_903a m5_baby1_903b m5_baby1_903c m5_baby1_903d ///
	    m5_baby1_903e m5_baby1_903f m5_baby1_903_other) 

rename (Q903a_2 Q903b_2 Q903c_2 Q903d_2 Q903e_2 Q903f_2 Q903_oth_2) (m5_baby2_903a m5_baby2_903b m5_baby2_903c m5_baby2_903d ///
	    m5_baby2_903e m5_baby2_903f m5_baby2_903_other) 		
	
rename (Q904_1 Q904_oth_1 Q904_2 Q904_oth_2 Q905) (m5_baby1_904 m5_baby1_904_other m5_baby2_904 m5_baby2_904_other m5_905)	

rename (Q905 Q1202) (m5_905 m5_1202)

rename (Q1001 Q1002a Q1002b Q1002c Q1002d Q1002e Q1002_oth Q1003 Q1004 Q1005 Q1005_1 Q1005_2 Q1005_3 Q1005_4 Q1005_5 Q1005_6 Q1005__96 Q1005_oth) ///
       (m5_1001 m5_1002a m5_1002b m5_1002c m5_1002d m5_1002e m5_1002_other m5_1003 m5_1004 m5_1005 m5_1005a m5_1005b m5_1005c m5_1005d m5_1005e ///
	    m5_1005f m5_1005_other m5_1005_other_text)	
		
rename (Q1001 Q1002_a Q1002_b Q1002_c Q1002_d Q1002_e Q1002_e_other ///
		Q1003 Q1004 Q1005 Q1005_1 Q1005_2 Q1005_3 Q1005_4 Q1005_5 Q1005_6 Q1005_96 Q1005_other) ///
       (m5_1001 m5_1002a m5_1002b m5_1002c m5_1002d m5_1002e m5_1002_other m5_1003 m5_1004 ///
	   m5_1005 m5_1005a m5_1005b m5_1005c m5_1005d m5_1005e ///
	    m5_1005f m5_1005_other m5_1005_other_text)		


rename (Q1101 Q1102 Q1102_1 Q1102_2 Q1102_3 Q1102_4 Q1102_5 Q1102_6 Q1102_7 Q1102_8 Q1102_9 Q1102_10 Q1102__96 Q1102_98 Q1102_99) (m5_1101 m5_1102 ///
        m5_1102a m5_1102b m5_1102c m5_1102d m5_1102e m5_1102f m5_1102g m5_1102h m5_1102i m5_1102j m5_1102_other m5_1102_98 m5_1102_99)

rename (Q1103 Q1104 Q1104_1 Q1104_2 Q1104_3 Q1104_4 Q1104_5 Q1104_6 Q1104_7 Q1104_8 Q1104_9 Q1104_10 Q1104__96 Q1104_98 Q1104_99 Q1105) (m5_1103 ///
        m5_1104 m5_1104a m5_1104b m5_1104c m5_1104d m5_1104e m5_1104f m5_1104g m5_1104h m5_1104i m5_1104j m5_1104_other m5_1104_98 m5_1104_99 ///
		m5_1105)

rename (Q1201 Q1202 Q1202_v2 Q1301 Q1302 Q1303a Q1303b Q1303c Q1304a Q1304b Q1304c Q1305a Q1305b Q1305c Q1306 Q1307) (m5_1201 m5_1202a m5_1202b ///
        m5_height m5_weight m5_sbp1 m5_dbp1 m5_pr1 m5_sbp2 m5_dbp2 m5_pr2 m5_sbp3 m5_dbp3 m5_pr3 m5_anemiatest m5_hb_level)
		
rename (Q1401_1 Q1401_2 Q1402_1 Q1402_2 Q1403_1 Q1403_2) (m5_baby1_weight m5_baby2_weight m5_baby1_length m5_baby2_length m5_baby1_hc m5_baby2_hc)

/*
	* MATERNAL CARDS:
rename Q15101a mcard_available_ke
rename Q15101b mcard_edition_ke
rename Q15101b_other mcard_edition_oth_ke

rename Q15102_1 mcard_b1_mode
rename Q15103_1 mcard_b1_hivtest
rename Q15104a_1 mcard_b1_apgar_1min
rename Q15104b_1 mcard_b1_apgar_5min
rename Q15104c_1 mcard_b1_apgar_10min
rename Q15105_1 mcard_b1_resuscitation
rename Q15106_1 mcard_b1_pre_eclamp
rename Q15107_1 mcard_b1_eclamp
rename Q15108_1 mcard_b1_pph 
rename Q15109_1 mcard_b1_bloodloss
rename Q15110_1 mcard_b1_obs_labor
rename Q15111_1 mcard_b1_mothercondition
rename Q15112_1 mcard_b1_babywgt
rename Q15113_1 mcard_b1_babycondition

rename Q15114a_1 mcard_b1_birthabn
rename Q15114b_1 mcard_b1_birthabn_y

rename Q15102_2 mcard_b2_mode
rename Q15103_2 mcard_b2_hivtest
rename Q15104a_2 mcard_b2_apgar_1min
rename Q15104b_2 mcard_b2_apgar_5min
rename Q15104c_2 mcard_b2_apgar_10min
rename Q15105_2 mcard_b2_resuscitation
rename Q15106_2 mcard_b2_pre_eclamp
rename Q15107_2 mcard_b2_eclamp
rename Q15108_2 mcard_b2_pph
rename Q15109_2 mcard_b2_bloodloss
rename Q15110_2 mcard_b2_obs_labor
rename Q15111_2 mcard_b2_mothercondition
rename Q15112_2 mcard_b2_babywgt
rename Q15113_2 mcard_b2_babycondition

rename Q15114a_2 mcard_b2_birthabn
rename Q15114b_2 mcard_b2_birthabn_y

rename Q15201 mcard_pnc_48h
rename Q15202 mcard_pnc_1w
rename Q15203 mcard_pnc_4w

rename Q15204 mcard_m_bp_48h
rename Q15205 mcard_m_temp_48h
rename Q15206 mcard_m_pr_48h
rename Q15207 mcard_m_rr_48h
rename Q15208 mcard_m_cond_48h
rename Q15209 mcard_m_breast_48h
rename Q15210 mcard_m_cs_scar_48h
rename Q15211 mcard_m_pelvic_exam_48h
rename Q15212 mcard_m_epis_48h
rename Q15213 mcard_m_hb_48h
rename Q15214 mcard_m_hiv_status_48h
rename Q15215 mcard_m_fp_48h
rename Q15216 mcard_m_mentalscr_48h
rename Q15223 mcard_m_bp_1w
rename Q15224 mcard_m_temp_1w
rename Q15225 mcard_m_pr_1w
rename Q15226 mcard_m_rr_1w
rename Q15227 mcard_m_cond_1w
rename Q15228 mcard_m_breast_1w
rename Q15229 mcard_m_cs_scar_1w
rename Q15230 mcard_m_pelvic_exam_1w
rename Q15231 mcard_m_epis_1w
rename Q15232 mcard_m_hb_1w
rename Q15233 mcard_m_hiv_status_1w
rename Q15234 mcard_m_fp_1w
rename Q15235 mcard_m_mentalscr_1w
rename Q15242 mcard_m_bp_4w
rename Q15243 mcard_m_temp_4w
rename Q15244 mcard_m_pr_4w
rename Q15245 mcard_m_rr_4w
rename Q15246 mcard_m_cond_4w
rename Q15247 mcard_m_breast_4w
rename Q15248 mcard_m_cs_scar_4w
rename Q15249 mcard_m_pelvic_exam_4w
rename Q15250 mcard_m_epis_4w
rename Q15251 mcard_m_hb_4w
rename Q15252 mcard_m_hiv_status_4w
rename Q15253 mcard_m_fp_4w
rename Q15254 mcard_m_mentalscr_4w

rename Q15217_1 mcard_b1_cond_48h
rename Q15217_other_1 mcard_b1_cond_48h_oth
rename Q15218_1 mcard_b1_temp_48h
rename Q15219_1 mcard_b1_bbm_48h
rename Q15220_1 mcard_b1_feed_48h
rename Q15221_1 mcard_b1_breastpos_48h
rename Q15222_1 mcard_b1_umb_48h
rename Q15222b_1 mcard_b1_imm_48h
rename Q15236_1 mcard_b1_cond_1w
rename Q15236_other_1 mcard_b1_cond_1w_oth
rename Q15237_1 mcard_b1_temp_1w
rename Q15238_1 mcard_b1_bbm_1w
rename Q15239_1 mcard_b1_feed_1w
rename Q15240_1 mcard_b1_breastpos_1w
rename Q15241_1 mcard_b1_umb_1w
rename Q15255_1 mcard_b1_cond_4w
rename Q15255_other_1 mcard_b1_cond_4w_oth
rename Q15256_1 mcard_b1_temp_4w
rename Q15257_1 mcard_b1_bbm_4w
rename Q15258_1 mcard_b1_feed_4w
rename Q15259_1 mcard_b1_breastpos_4w
rename Q15260_1 mcard_b1_umb_4w
rename Q15217_2 mcard_b2_cond_48h
rename Q15217_other_2 mcard_b2_cond_48h_oth
rename Q15218_2 mcard_b2_temp_48h
rename Q15219_2 mcard_b2_bbm_48h
rename Q15220_2 mcard_b2_feed_48h
rename Q15221_2 mcard_b2_breastpos_48h
rename Q15222_2 mcard_b2_umb_48h
rename Q15222b_2 mcard_b2_imm_48h
rename Q15236_2 mcard_b2_cond_1w
rename Q15236_other_2 mcard_b2_cond_1w_oth
rename Q15237_2 mcard_b2_temp_1w
rename Q15238_2 mcard_b2_bbm_1w
rename Q15239_2 mcard_b2_feed_1w
rename Q15240_2 mcard_b2_breastpos_1w
rename Q15241_2 mcard_b2_umb_1w
rename Q15255_2 mcard_b2_cond_4w
rename Q15255_other_2 mcard_b2_cond_4w_oth
rename Q15256_2 mcard_b2_temp_4w
rename Q15257_2 mcard_b2_bbm_4w
rename Q15258_2 mcard_b2_feed_4w
rename Q15259_2 mcard_b2_breastpos_4w
rename Q15260_2 mcard_b2_umb_4w
rename Q15261_1 mcard_b1_specialcare
rename Q15262_1 mcard_b1_specialcare_reason
rename Q15262_1_1 mcard_b1_reason1
rename Q15262_2_1 mcard_b1_reason2
rename Q15262_3_1 mcard_b1_reason3
rename Q15262_4_1 mcard_b1_reason4
rename Q15262_5_1 mcard_b1_reason5
rename Q15262_6_1 mcard_b1_reason6
rename Q15262_7_1 mcard_b1_reason7
rename Q15262_8_1 mcard_b1_reason8
rename Q15262_9_1 mcard_b1_reason9
rename Q15262_10_1 mcard_b1_reason10
rename Q15262_11_1 mcard_b1_reason11
rename Q15262_12_1 mcard_b1_reason12
rename Q15262_13_1 mcard_b1_reason13
rename Q15262_14_1 mcard_b1_reason14
rename Q15262__96_1 mcard_b1_reason15
rename Q15263_1 mcard_b1_reason_oth
rename Q15264_1 mcard_b1_bcg
rename Q15265_1 mcard_b1_polio
rename Q15265a_1 mcard_b1_polio1
rename Q15265b_1 mcard_b1_polio2
rename Q15266a_1 mcard_b1_dtap1
rename Q15266b_1 mcard_b1_dtap2
rename Q15267a_1 mcard_b1_pvac1
rename Q15267b_1 mcard_b1_pvac2
rename Q15268a_1 mcard_b1_rota1
rename Q15268b_1 mcard_b1_rota2
rename Q15261_2 mcard_b2_specialcare
rename Q15262_2 mcard_b2_specialcare_reason
rename Q15262_1_2 mcard_b2_reason1
rename Q15262_2_2 mcard_b2_reason2
rename Q15262_3_2 mcard_b2_reason3
rename Q15262_4_2 mcard_b2_reason4
rename Q15262_5_2 mcard_b2_reason5
rename Q15262_6_2 mcard_b2_reason6
rename Q15262_7_2 mcard_b2_reason7
rename Q15262_8_2 mcard_b2_reason8
rename Q15262_9_2 mcard_b2_reason9
rename Q15262_10_2 mcard_b2_reason10
rename Q15262_11_2 mcard_b2_reason11
rename Q15262_12_2 mcard_b2_reason12
rename Q15262_13_2 mcard_b2_reason13
rename Q15262_14_2 mcard_b2_reason14
rename Q15262__96_2 mcard_b2_reason15 
rename Q15263_2 mcard_b2_reason_oth
rename Q15264_2 mcard_b2_bcg
rename Q15265_2 mcard_b2_polio
rename Q15265a_2 mcard_b2_polio1
rename Q15265b_2 mcard_b2_polio2
rename Q15266a_2 mcard_b2_dtap1
rename Q15266b_2 mcard_b2_dtap2
rename Q15267a_2 mcard_b2_pvac1
rename Q15267b_2 mcard_b2_pvac2
rename Q15268a_2 mcard_b2_rota1
rename Q15268b_2 mcard_b2_rota2

* NK NOTE - add 504, i think it's baby2
* 505s ? 	
*/

duplicates drop respondentid, force

keep respondentid m5*

merge 1:1 respondentid using "$in_data_final/eco_IN_Complete_0411.dta" 

rename _merge merge_m5_to_m4_m3_m2_m1

save "$in_data_final/eco_IN_Complete_0424.dta", replace
