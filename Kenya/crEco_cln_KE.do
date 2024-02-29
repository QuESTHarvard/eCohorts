* Kenya MNH ECohort Data Cleaning File 
* Created by S. Sabwa, K. Wright
* Last Updated: 20 Dec 2023

*------------------------------------------------------------------------------*
	
	* STEPS: 
		* STEP ONE: RENAME VARIABLES 
		* STEP TW0: ADD VALUE LABELS - NA in KENYA 
		* STEP THREE: RECODING MISSING VALUES 
		* STEP FOUR: LABELING VARIABLES
		* STEP FIVE: ORDER VARIABLES
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

* Import Data 
clear all 

use "$ke_data/Module 1/KEMRI_Module_1_ANC_2023z-9-6.dta"

*------------------------------------------------------------------------------*
* Create sample: (M1 = 1,007)

keep if consent == 1 // 27 ids dropped
drop if q105 == . // 3 ids dropped

gen country = "Kenya"

* fixing duplicate var names
rename duration interview_length
rename gest_age_baseline gest_age_baseline_ke
rename consent b7eligible
rename starttime m1_start_time
rename time_start_full m1_date_time
rename endtime m1_end_time
rename date_survey_baseline m1_date

*------------------------------------------------------------------------------*	 
* Append module 2:

append using "$ke_data/Module 2/KEMRI_Module_2_ANC_period.dta", force

gen module = .
replace module = 1 if a4 !=.
replace module = 2 if attempts != .

* ga at baseline and date_survey_baseline are duplicate vars
drop care_reason_ante_label_1 care_reason_ref_label_1 care_visit_reas_rpt_grp_count_1 ///
     care_vis_idx_1_1 care_visit_res_1_1 care_vis_idx_1_2 care_visit_res_1_2 ///
	 care_reason_other_label_pre_1 care_reason_other_label_1 care_reason_label_1 ///
	 q_303_label_2 q_304_label_2 gest_age_baseline date_survey_baseline submissiondate 

* fixing duplicate var names
rename facility_name m2_site 
rename today_date m2_date 
rename date_confirm m2_date_confirm
rename starttime m2_start_time
rename time_start_full m2_date_time
rename gestational_update m2_ga_estimate
rename q_302 m2_302
rename q_301 m2_301
rename (q_303_1 q_303_2) (m2_303a m2_303b)
rename (q_304_1 q_304_oth_1 q_304_2 q_304_oth_2) ///
	   (m2_304a m2_304a_other m2_304b m2_304b_other)
rename (q_305_1 q_306_1 q_307_1_1) (m2_305 m2_306 m2_306_1)	   
rename q_305_2 m2_308
rename q_306_2 m2_309
rename q_501 m2_501
rename (q_502 q_503) (m2_502 m2_503)
rename q_506 m2_506
rename q_507 m2_507
rename q_509 m2_509
rename q_701 m2_701
rename q_705 m2_705
rename endtime m2_endtime

*------------------------------------------------------------------------------*	 
* Append module 3:

append using "$ke_data/Module 3/KEMRI_Module_3.dta", force

* fixing duplicate var names
rename facility_name m3_site
rename date_confirm m3_date_confirm
rename today_date m3_date 
rename starttime m3_start_time
rename time_start_full m3_date_time
rename q_302 m3_birth_or_ended_date
rename gestational_update m3_ga2_ke
rename q_301 m3_303a
rename (q_303_1 q_303_2) (m3_303b m3_303c)
rename (q_304_1 q_304_2) (m3_baby1_name m3_baby2_name)
rename (q_305_1 q_306_1 q_307_1) (m3_baby1_gender m3_baby1_age_weeks m3_baby1_size)
rename q_305_2 m3_baby2_gender
rename q_306_2 m3_baby2_age_weeks
rename q_501 m3_501
rename (q_502 q_503) (m3_502 m3_503)
rename q_506 m3_506
rename q_507 m3_507
rename q_509 m3_509
rename q_701 m3_701
rename q_705 m3_705
rename endtime m3_endtime
rename duration m3_duration


*------------------------------------------------------------------------------*
* de-identifying dataset and remove extra variables

drop q101 q102 q105 q513b q513d q513e_1 q513e_2 q513f_1 q513f_2 q513g_1 q513g_2 ///
	 q513h_1 q513h_2 q513i_1 q513i_2 text_audit mean_sound_level min_sound_level ///
	 max_sound_level sd_sound_level pct_sound_between0_60 pct_sound_above80 ///
	 pct_conversation subscriberid simid enum_name preferred_language preferred_language_1 ///
	 preferred_language_2 preferred_language_3 preferred_language_4 preferred_language__96 ///
	 preferred_language_oth formdef_version time_start_v2 username time_start deviceid today_date_d ///
     county_label agree_phone county_eligibility

drop q_102 resp_other_name resp_worker availability module_2_success ///
     module_2_first module_2_freq mod_2_freq_label module_2_oth name_confirm ///
	 name_full consent_audio section6_audio q_104_calc q_105 q_106 full_name phone1 phone2 phone3 ///
	 phone4 phone_combi 
	 
drop q_203a_calc_e q_203b_calc_e q_203c_calc_e q_203d_calc_e q_203e_calc_e ///
     q_203f_calc_e q_203g_calc_e q_203h_calc_e q_203_calc_e q_203a_calc_ki ///
	 q_203b_calc_ki q_203c_calc_ki q_203d_calc_ki q_203e_calc_ki q_203f_calc_ki ///
	 q_203g_calc_ki q_203h_calc_ki q_203_calc_ki q_203a_calc_ka q_203b_calc_ka ///
	 q_203c_calc_ka q_203d_calc_ka q_203e_calc_ka q_203f_calc_ka q_203g_calc_ka ///
	 q_203h_calc_ka q_203_calc_ka
	 
drop q_205a_calc q_205b_calc

drop repeat_g303 q_303_rpt_grp q_303_indx_1 q_303_indx_st_1 q_303_indx_nd_1 q_303_indx_rd_1 q_303_indx_x_1 q_303_indx_2 q_303_indx_st_2 q_303_indx_nd_2 q_303_indx_rd_2 q_303_indx_x_2 q_303_indx_3 q_303_indx_st_3 q_303_indx_nd_3 q_303_indx_rd_3 q_303_indx_x_3 q_303_indx_4 q_303_indx_st_4 q_303_indx_nd_4 q_303_indx_rd_4 q_303_indx_x_4 q_303_indx_5 q_303_indx_st_5 q_303_indx_nd_5 q_303_indx_rd_5 q_303_indx_x_5 care_reason_ante_label_2 care_reason_ref_label_2 care_visit_reas_rpt_grp_count_2 care_vis_idx_2_1 care_visit_res_2_1 care_vis_idx_2_2 care_visit_res_2_2 care_reason_other_label_pre_2 care_reason_other_label_2 care_reason_label_2 q_303_indx_3 q_303_indx_st_3 q_303_indx_nd_3 q_303_indx_rd_3 q_303_indx_x_3 care_reason_ante_label_3 care_reason_ref_label_3 care_visit_reas_rpt_grp_count_3 care_vis_idx_3_1 care_visit_res_3_1 care_vis_idx_3_2 care_visit_res_3_2 care_reason_other_label_pre_3 care_reason_other_label_3 care_reason_label_3 q_303_indx_4 q_303_indx_st_4 q_303_indx_nd_4 q_303_indx_rd_4 q_303_indx_x_4 q_303_label_4 q_304_label_4 care_reason_ante_label_4 care_reason_ref_label_4 care_visit_reas_rpt_grp_count_4 care_vis_idx_4_1 care_visit_res_4_1 care_vis_idx_4_2 care_visit_res_4_2 care_reason_other_label_pre_4 care_reason_other_label_4 care_reason_label_4 q_303_indx_5 q_303_indx_st_5 q_303_indx_nd_5 q_303_indx_rd_5 q_303_indx_x_5 q_304_label_5 q_303_label_5 care_reason_ante_label_5 care_reason_ref_label_5 care_visit_reas_rpt_grp_count_5 care_vis_idx_5_1 care_visit_res_5_1 care_vis_idx_5_2 care_visit_res_5_2 care_reason_other_label_pre_5 care_reason_other_label_5 care_reason_label_5

drop q814a_calc_e q814b_calc_e q814c_calc_e q814d_calc_e q814e_calc_e q814f_calc_e q814g_calc_e q814h_calc_e q814_calc_e q814a_calc_ki q814b_calc_ki q814c_calc_ki q814d_calc_ki q814e_calc_ki q814f_calc_ki q814g_calc_ki q814h_calc_ki q814_calc_ki q814a_calc_ka q814b_calc_ka q814c_calc_ka q814d_calc_ka q814e_calc_ka q814f_calc_ka q814g_calc_ka q814h_calc_ka q814_calc_ka q_107_trim q_303_label_1 q_304_label_1 q_303_label_3 q_304_label_3 a2 county_eligibility_oth key   

drop outcome_text gest_age_delivery // SS: confirm dropping outcome_text because the same data is in "m2_202_other"

drop user_experience_rpt_grp_count user_exp_idx_1 user_visit_reason_1 user_facility_type_1 user_facility_name_1 user_exp_idx_2 user_visit_reason_2 user_facility_type_2 user_facility_name_2 user_exp_idx_3 user_visit_reason_3 user_facility_type_3 user_facility_name_3 user_exp_idx_4 user_visit_reason_4 user_facility_type_4 user_facility_name_4 user_exp_idx_5 user_visit_reason_5 user_facility_type_5 user_facility_name_5

drop q_602_filter q_702_discrepancy days_callback_mod3 q202_oth_continue 

*these vars should be dropped for de-identification purposes
drop registered_phone mobile_money_name mobile_prov phone_used phone_used_oth

drop unavailable_reschedule reschedule_full_noavail confirm_phone phone_noavail unavailable_reschedule

drop baby_repeat_count baby_index_1

*------------------------------------------------------------------------------*
	
	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
rename a1 interviewer_id
rename a4 study_site
rename a5 facility_name
rename b1 permission
rename (b2 b3) (care_self enrollage)
rename (b4 b4_oth b5 b6) (zone_live zone_live_other b5anc b6anc_first)
*rename a2 device_date_ke
rename (q103 q104 q106) (respondentid mobile_phone flash)
rename q201 m1_201
rename (q202a q202b q202c q202d q202e) (m1_202a m1_202b m1_202c m1_202d m1_202e)
rename q203 m1_203
rename (q203_0 q203_1 q203_2 q203_3 q203_4 q203_5 q203_6 q203_7 q203_8 q203_9 ///
		q203_10 q203_11 q203_12 q203_13 q203_14 q203__96 q203_oth) (m1_203a_ke ///
		m1_203b_ke m1_203c_ke m1_203d_ke m1_203e_ke m1_203f_ke m1_203g_ke m1_203h_ke ///
		m1_203i_ke m1_203j_ke m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke ///
		m1_203_96_ke m1_203_other)
rename (q204 q205a q205b q205c q205d q205e) (m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e)	
rename (q206a q206b q206c q206d q206e q206f q206g q206h q206i q207 q301 q302 q303 ///
		q304) (phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i m1_207 m1_301 ///
		m1_302 m1_303 m1_304)		
rename (q305a q305b) (m1_305a m1_305b)	
rename (q401 q401_oth) (m1_401 m1_401_other)
rename (q401_1 q401_2 q401_3 q401_4 q401_5 q401__96 q401_998 q401_999) (m1_401a_ke ///
		m1_401b_ke m1_401c_ke m1_401d_ke m1_401e_ke m1_401_96_ke m1_401_998_ke ///
		m1_401_999_ke)	
rename (q402 q403 q404 q405 q405_oth) (m1_402 m1_403b m1_404 m1_405 m1_405_other)
rename (q501 q501_oth q501b q501b_oth) (m1_501 m1_501_other m1_501_ke m1_501_ke_other)
rename (q501b_1 q501b_2 q501b_3 q501b_4 q501b_5 q501b_6 q501b_7 q501b_8 q501b_9 q501b__96) ///
	   (m1_501b_ke m1_501c_ke m1_501d_ke m1_501e_ke m1_501f_ke m1_501g_ke m1_501h_ke m1_501i_ke ///
	   m1_501j_ke m1_501k_ke)
rename (q502 q503 q504) (m1_502 m1_503 m1_504)
rename (q505 q506 q506_oth q507 q507_oth q508 q509a q509b q510a q510b q511 q512 q518) ///
	   (m1_505 m1_506 m1_506_other m1_507 m1_507_other m1_508 m1_509a m1_509b m1_510a ///
	   m1_510b m1_511 m1_512 m1_518)
rename (q514a q514b_1 q514b_2) (m1_514a m1_514b m1_514c_ke)
rename (q601 q602 q603 q604) (m1_601 m1_602 m1_603 m1_604)
rename (q605a q605b q605c q605d q605e q605f q605g q605h) (m1_605a m1_605b m1_605c m1_605d ///
		m1_605e m1_605f m1_605g m1_605h)
rename (q700 q701 q702 q703 q704 q705 q706 q707 q708a q708b q708c q708d q708e q708f ///
		q709a q709b q710a q710b q710c q711a q711b q712) (m1_700 m1_701 m1_702 m1_703 ///
		m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f ///
		m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712)
rename (q713a q713c q713e q713f q713g q713i q713d q713j q713k q713b q713h q713l) ///
	   (m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713j_ke ///
	   m1_713k m1_713l)		
rename (q714a q714b q714c q714d q714e q715) (m1_714a m1_714b m1_714c m1_714d m1_714e m1_715)
rename (q716a q716b q716c q716d q716e q717 q718 q719 q720 q721 q722 q723 q724a q724b q724c ///
		q724d q724e q724f q724g q724h q724i q801 q802a q802) (m1_716a m1_716b m1_716c m1_716d ///
		m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724b m1_724c m1_724d ///
		m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_802_ke m1_802a)
rename (q803 edd_chart q804 q805 expected_babies q806 q807 q808 q808_oth) (m1_803 ///
		edd_chart_ke m1_804 m1_805 m1_805a_ke m1_806 m1_807 m1_808 m1_808_other)
rename (q809 q810a q810b q810b_oth) (m1_809 m1_810a m1_810b m1_810b_other)
rename (q812a q812b q812b_oth q813a q813b) (m1_812a m1_812b m1_812b_other m1_813a m1_813b)
rename (q812b_0 q812b_1 q812b_2 q812b_3 q812b_4 q812b_5 q812b__96 q812b_998 q812b_999) ///
	   (m1_812b_0_ke m1_812b_1 m1_812b_2 m1_812b_3 m1_812b_4 m1_812b_5 m1_812b_96 ///
	   m1_812b_98 m1_812b_99)
rename (q814a q814b q814c q814d q814e q814f q814g q814h) (m1_814a m1_814b m1_814c ///
		m1_814d m1_814e m1_814f m1_814g m1_814h)
rename (q815 q815_0 q815_1 q815_2 q815_3 q815_4 q815_5 q815_6 q815__96 q815_998 ///
		q815_999 q815_oth) (m1_815_0 m1_815_1 m1_815_2 m1_815_3 m1_815_4 m1_815_5 ///
		m1_815_6 m1_815_7 m1_815_96 m1_815_98 m1_815_99 m1_815_other)
rename (q901 q902 q903 q904 q905 q906 q907) (m1_901 m1_902 m1_903 m1_904 m1_905 ///
		m1_906 m1_907)
rename (q1001 q1002 q1003 q1004 q1005 q1006) (m1_1001 m1_1002 m1_1003 m1_1004 m1_1005 m1_1006)
rename (q1007 q1008 q1009 q1010) (m1_1007 m1_1008 m1_1009 m1_1010)
rename (q1011a q1011b q1011c q1011d q1011e q1011f q1101) (m1_1011a m1_1011b m1_1011c ///
		m1_1011d m1_1011e m1_1011f m1_1101)
rename (q1102 q1102_1 q1102_2 q1102_3 q1102_4 q1102_5 q1102_6 q1102_7 q1102_8 q1102_9 ///
		q1102_10 q1102__96 q1102_998 q1102_999 q1102_oth) (m1_1102 m1_1102_1 m1_1102_2 ///
		m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 m1_1102_7 m1_1102_8 m1_1102_9 m1_1102_10 ///
		m1_1102_96 m1_1102_98 m1_1102_99 m1_1102_other)
rename (q1103 q1104 q1104_1 q1104_2 q1104_3 q1104_4 q1104_5 q1104_6 q1104_7 q1104_8 ///
		q1104_9 q1104_10 q1104__96 q1104_998 q1104_999) (m1_1103 m1_1104 m1_1104_1 m1_1104_2 ///
		m1_1104_3 m1_1104_4 m1_1104_5 m1_1104_6 m1_1104_7 m1_1104_8 m1_1104_9 m1_1104_10 ///
		m1_1104_96 m1_1104_98 m1_1104_99)
rename (q1104_oth q1105 q1201 q1201_oth q1202 q1202_oth q1203 q1204 q1205 q1206 ///
		q1207 q1208 q1208_oth q1209 q1209_oth q1210 q1210_oth q1211 q1211_oth q1212 ///
		q1213 q1214 q1215) (m1_1104_other m1_1105 m1_1201 m1_1201_other m1_1202 ///
		m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1208_other ///
		m1_1209 m1_1209_other m1_1210 m1_1210_other m1_1211 m1_1211_other m1_1212 ///
		m1_1213 m1_1214 m1_1215)
rename (q1216 q1217 q1218 clinic_cost q1218a q1218b q1218c q1218d q1218e q1218f_2 ///
		q1218f_1 q1218f_3 q1219 other_costs q1220) (m1_1216b m1_1217 m1_1218_ke ///
		m1_clinic_cost_ke m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 ///
		m1_1218f_other m1_1218f m1_1218f_1 m1_1219 m1_other_costs_ke m1_1220)
rename (q1220_oth q1221 q1222 q1222_oth q1223) (m1_1220_other m1_1221 m1_1222 ///
		m1_1222_other m1_1223)	
rename (q513a q513a_1 q513a_2 q513a_3 q513a_4 q513a_5 q513a_6 q513a__96 q513a_0) ///
		(m1_513a m1_513a_1 m1_513a_2 m1_513a_3 m1_513a_4 m1_513a_5 m1_513a_6 ///
		m1_513a_7 m1_513a_8)		
rename q513c m1_513c

*these were dropped from the dataset above
*rename (q513d q513e_1 q513e_2 q513f_1 q513f_2 q513g_1 q513g_2 q513h_1 q513h_2 ///
		*q513i_1 q513i_2 q514a q514b_1 q514b_2) (m1_513d m1_513e_name m1_513e m1_513f_name ///
		*m1_513f m1_513g_name m1_513g m1_513h_name m1_513h m1_513i_name m1_513i m1_514a ///
		*m1_514b m1_514c_ke)	
		
rename (q515_5 q515_3 q515_4 q515_1 q515_1_oth q515_2 q515_2_oth q516 q517 q519_3 q519_4 ///
		q519_1 q519_1_oth q519_2 q519_2_oth q519_5 q519_6) (m1_515_address m1_515_ward ///
		m1_515_village m1_515_county m1_515_county_other m1_515_subcounty m1_515_subcounty_other ///
		m1_516 m1_517 m1_519_ward m1_519_village m1_519_county m1_519_county_other m1_519_subcounty ///
		m1_519_subcounty_other m1_519_address m1_519_directions)
rename (q1301 q1302 bp_count q1303a_1 q1303b_1 q1303c_1 q1303a_2 q1303b_2 q1303c_2 ///
		q1303a_3 q1303b_3 q1303c_3) (height_cm weight_kg m1_bp_count_ke bp_time_1_systolic ///
		bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate ///
		bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3)
rename (q1306 q1307 q1308 q1309 q1401 preferred_phone_oth preferred_phone_confirm) ///
		(m1_1306 m1_1307 m1_1308 m1_1309 m1_1401 m1_1401a_ke m1_1401b_ke)		
rename noconsent_why m1_noconsent_why_ke		
rename end_comment m1_end_comment_ke	
rename (q1401_1 q1401_2 q1401_3 q1401_4) (m1_1401_1_ke m1_1401_2_ke m1_1401_3_ke m1_1401_4_ke)
rename total_cost m1_1218g
rename (q1402 q1402_0 q1402_1 q1402_2 q1402_3 q1402_4 q1402_5 q1402_6 q1402_7) ///
	   (m1_1402_ke m1_1402_0_ke m1_1402_1_ke m1_1402_2_ke m1_1402_3_ke m1_1402_4_ke ///
	   m1_1402_5_ke m1_1402_6_ke m1_1402_7_ke)

/*
rename (preferred_language preferred_language_1 preferred_language_2 preferred_language_3 ///
		preferred_language_4 preferred_language__96 preferred_language_oth) (pref_language_ke ///
		pref_language_1_ke pref_language_2_ke pref_language_3_ke pref_language_4_ke pref_language_96_ke ///
		pref_language_other_ke)
*/
		
	* MODULE 2:
rename (attempts attempts_oth call_response resp_language resp_language_no ///
       resp_language_no_oth resp_other resp_other_oth resp_available ///
	   best_phone_reconfirm best_phone_resp resp_available_when reschedule_resp ///
	   reschedule_date_resp) (m2_attempt_number m2_attempt_number_other m2_attempt_outcome ///
	   m2_resp_language m2_resp_language_no m2_resp_language_no_oth m2_attempt_relationship ///
	   m2_attempt_other m2_attempt_avail m2_attempt_contact m2_attempt_bestnumber ///
	   m2_attempt_goodtime m2_reschedule_resp m2_reschedule_date_resp) 

rename (mod_2_round intro_yn) (m2_completed_attempts m2_consent_recording)	

rename q_103 m2_time_start
rename q_101 m2_interviewer
rename q_104 m2_respondentid
*rename gest_age_baseline m2_baseline_ga //this was M1 ga so I dropped so it's not confusing
*rename date_survey_baseline m2_baseline_date // this is the m1 surveydate, dropped for now
rename q_109 m2_maternal_death_reported
rename q_107 m2_ga
rename q_108 m2_hiv_status

rename (county enum_name date_death_knows) /// 
       (m2_county m2_enum m2_date_of_maternal_death_yesno) 
	   
rename q_110 m2_date_of_maternal_death
rename q_111 m2_maternal_death_learn
rename q_111_oth m2_maternal_death_learn_other
		
rename (q_201 q_202) (m2_201 m2_202) 
rename date_delivery m2_202_delivery_date
rename q_202_oth m2_202_other
rename date_q202_oth m2_202_other_date

rename (q_203a q_203b q_203c q_203d q_203e q_203f q_203g q_203h) /// 
       (m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h)
rename (q_204 q_204_specify) (m2_204i m2_204i_other) 

rename (q_205a q_205b) (m2_205a m2_205b)
rename phq_score m2_phq2_ke 
rename  q_206 m2_206

rename (q_303_3 q_303_4 q_303_5) (m2_303 m2_303d m2_303e)
	   
rename (q_304_3 q_304_oth_3 q_304_4 ///
        q_304_oth_4 q_304_5 q_304_oth_5) ///
	   (m2_304c m2_304c_other m2_304d ///
	    m2_304d_other m2_304e m2_304e_other)

rename (q_307_2_1 q_307_3_1 q_307_4_1 q_307_5_1 q_307__96_1 q_307_oth_1) (m2_306_2 m2_306_3 m2_306_4 m2_306_5 m2_306_96 m2_307_other)

rename (q_307_1_2 q_307_2_2 q_307_3_2 q_307_4_2 q_307_5_2 q_307__96_2 q_307_oth_2) (m2_308_1 m2_308_2 m2_308_3 m2_308_4 m2_308_5 m2_308_96 m2_310_other)

rename (q_305_3 q_306_3 q_307_1_3 q_307_2_3 q_307_3_3 q_307_4_3 q_307_5_3 q_307__96_3 q_307_oth_3) (m2_311 m2_312 m2_311_1 m2_311_2 m2_311_3 m2_311_4 m2_311_5 m2_311_96 m2_313_other)

rename (q_305_4 q_306_4 q_307_1_4 q_307_2_4 q_307_3_4 q_307_4_4 q_307_5_4 q_307__96_4 q_307_oth_4) (m2_314 m2_315 m2_314_1 m2_314_2 m2_314_3 m2_314_4 m2_314_5 m2_314_96 m2_316_other)

rename (q_305_5 q_306_5 q_307_1_5 q_307_2_5 q_307_3_5 q_307_4_5 q_307_5_5 q_307__96_5 q_307_oth_5) (m2_317 m2_318 m2_317_1 m2_317_2 m2_317_3 m2_317_4 m2_317_5 m2_317_96 m2_319_other)

rename (q_320_0 q_320_1 q_320_2 q_320_3 q_320_4 q_320_5 q_320_6 q_320_7 q_320_8 ///
        q_320_9 q_320_10 q_320_11 q_320_12 q_320__96 q_320__99 q_320_other) ///
	   (m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 m2_320_6 m2_320_7 /// 
	    m2_320_8 m2_320_9 m2_320_10 m2_320_11 m2_312_ke m2_320_96 m2_320_99 m2_320_other)
		
rename q_321 m2_321

rename (q_401_1 q_401_2 q_401_3 q_401_4 q_401_5) (m2_401 m2_402 m2_403 m2_404 m2_405)
rename (q_501_1 q_501_2 q_501_3 q_501_4 q_501_5 q_501_6 q_501__96 q_501_0 q_501_other) ///
       (m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g  m2_501_0 m2_501g_other)
	   
rename (q_503_1 q_503_2 q_503_3 q_503_4 q_503_5 q_503_6 q_503_0) ///
       (m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_503_0)	   
rename (q_504 q_504_specify) (m2_504 m2_504_other)
rename (q_505a q_505b q_505c q_505d q_505e q_505f q_505g) ///
	   (m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_505g)
rename (q_506_1 q_506_2 q_506_3 q_506_4 q_506_0) ///
       (m2_506a m2_506b m2_506c m2_506d m2_506_0)
rename (q_507_1 q_507_2 q_507_3 q_507_4 q_507_5 q_507_6 q_507_7 q_507__96 ///
		q_507_other) (m2_507_1_ke m2_507_2_ke m2_507_3_ke m2_507_4_ke ///
		m2_507_5_ke m2_507_6_ke m2_507_7_ke m2_507_96_ke m2_507_other_ke)
rename (q_508a q_508b q_508c) (m2_508a m2_508b_last m2_508d)	  
rename (q_509_1 q_509_2 q_509_3 q_509_0) (m2_509a m2_509b m2_509c m2_509_0_ke) 

rename (q_601 q_601_1 q_601_3 q_601_4 q_601_5 q_601_6 q_601_7 q_601_8 q_601_9 ///
		q_601_10 q_601_11 q_601_12 q_601_13 q_601_14 q_601__96 q_601_2 q_601_other ///
		q_601_0) (m2_601 m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g ///
		m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601o ///
		m2_601n_other m2_601_0_ke)
rename q_602 m2_602b 
rename q_603 m2_603 

rename (q_702a q_702b q_702c q_702d q_702e q_702e_other) ///
       (m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_702_other_ke)
	   
rename q_701_total m2_703
rename q_702_medication m2_702_meds_ke
rename q_702_total m2_704_confirm
rename (q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705__96 q_705_other) ///
       (m2_705__1 m2_705__2 m2_705__3 m2_705__4 m2_705__5 m2_705__6 m2_705__96 m2_705_other)
rename call_status m2_complete
rename refused_why m2_refused_why


		** MODULE 3:
rename (consent q_302a q_302b gest_age_delivery_final) ///
       (m3_start_p1 m3_birth_or_ended m3_birth_or_ended_provided m3_ga_final)
	   
rename (confirm_gestational weeks_from_outcome after2weeks_call) ///
	   (m3_ga1_ke m3_weeks_from_outcome_ke m3_after2weeks_call_ke)	   
	   
rename q_308_1 m3_baby1_weight
rename q_308_2 m3_baby2_weight 
rename (q_307_2 q_309_1 q_309_2) (m3_baby2_size m3_baby1_health m3_baby2_health)
 
* SS: confirm with Wen-Chien if we can remove. doesn't seem necessary
/* 
	   ** q_308_1 q_308_2 are numeric variables (baby weight), some values are -98 or 98 
replace q_308_1 = q_308_1 if q_308_1 != 98 | q_308_1 != - 98
replace q_308_1 = -98 if q_308_1 == 98 
replace q_308_2 = q_308_2 if q_308_1 != - 98
rename (q_308_1 q_308_2) (m3_baby1_weight m3_baby2_weight)
*/
		
       ** These 16 variables are string variables: use replace if and then rename 
       ** q_310a_1_1 q_310a_2_1 q_310a_3_1 q_310a_4_1 q_310a_5_1 q_310a_6_1 q_310a_7_1 q_310a_8_1 q_310a__99_1 (line 40 to line 66)
       ** q_310a_1_2 q_310a_2_2 q_310a_3_2 q_310a_4_2 q_310a_5_2 q_310a_6_2 q_310a_7_2 q_310a_8_2 q_310a__99_2 (line 68 to line 94)
replace q_310a_1_1 = "No" if q_310a_1_1 == "0"
replace q_310a_1_1 = "Yes" if q_310a_1_1 == "1"
rename (q_310a_1_1) (m3_baby1_feed_a)
replace q_310a_2_1 = "No" if q_310a_2_1 == "0"
replace q_310a_2_1 = "Yes" if q_310a_2_1 == "1"
rename (q_310a_2_1) (m3_baby1_feed_b)
replace q_310a_3_1 = "No" if q_310a_3_1 == "0"
replace q_310a_3_1 = "Yes" if q_310a_3_1 == "1"
rename (q_310a_3_1) (m3_baby1_feed_c)
replace q_310a_4_1 = "No" if q_310a_4_1 == "0"
replace q_310a_4_1 = "Yes" if q_310a_4_1 == "1"
rename (q_310a_4_1) (m3_baby1_feed_d)
replace q_310a_5_1 = "No" if q_310a_5_1 == "0"
replace q_310a_5_1 = "Yes" if q_310a_5_1 == "1"
rename (q_310a_5_1) (m3_baby1_feed_e)
replace q_310a_6_1 = "No" if q_310a_6_1 == "0"
replace q_310a_6_1 = "Yes" if q_310a_6_1 == "1"
rename (q_310a_6_1) (m3_baby1_feed_f)
replace q_310a_7_1 = "No" if q_310a_7_1 == "0"
replace q_310a_7_1 = "Yes" if q_310a_7_1 == "1"
rename (q_310a_7_1) (m3_baby1_feed_g)
replace q_310a_8_1 = "No" if q_310a_8_1 == "0"
replace q_310a_8_1 = "Yes" if q_310a_8_1 == "1"
rename (q_310a_8_1) (m3_baby1_feed_h)
replace q_310a__99_1 = "No" if q_310a__99_1 == "0"
replace q_310a__99_1 = "Yes" if q_310a__99_1== "1"
rename (q_310a__99_1) (m3_baby1_feed_99)

replace q_310a_1_2 = "No" if q_310a_1_2 == "0"
replace q_310a_1_2 = "Yes" if q_310a_1_2 == "1"
rename (q_310a_1_2) (m3_baby2_feed_a)
replace q_310a_2_2 = "No" if q_310a_2_2 == "0"
replace q_310a_2_2 = "Yes" if q_310a_2_2 == "1"
rename (q_310a_2_2) (m3_baby2_feed_b)
replace q_310a_3_2 = "No" if q_310a_3_2 == "0"
replace q_310a_3_2 = "Yes" if q_310a_3_2 == "1"
rename (q_310a_3_2) (m3_baby2_feed_c)
replace q_310a_4_2 = "No" if q_310a_4_2 == "0"
replace q_310a_4_2 = "Yes" if q_310a_4_2 == "1"
rename (q_310a_4_2) (m3_baby2_feed_d)
replace q_310a_5_2 = "No" if q_310a_5_2 == "0"
replace q_310a_5_2 = "Yes" if q_310a_5_2 == "1"
rename (q_310a_5_2) (m3_baby2_feed_e)
replace q_310a_6_2 = "No" if q_310a_6_2 == "0"
replace q_310a_6_2 = "Yes" if q_310a_6_2 == "1"
rename (q_310a_6_2) (m3_baby2_feed_f)
replace q_310a_7_2 = "No" if q_310a_7_2 == "0"
replace q_310a_7_2 = "Yes" if q_310a_7_2 == "1"
rename (q_310a_7_2) (m3_baby2_feed_g)
replace q_310a_8_2 = "No" if q_310a_8_2 == "0"
replace q_310a_8_2 = "Yes" if q_310a_8_2 == "1"
rename (q_310a_8_2) (m3_baby2_feed_h)
replace q_310a__99_2 = "No" if q_310a__99_2 == "0"
replace q_310a__99_2 = "Yes" if q_310a__99_2 == "1"
rename (q_310a__99_2) (m3_baby2_feed_99)

rename q_310a_1 m3_baby_feeding

rename (q_310b_1 q_310b_2)(m3_breastfeeding m3_breastfeeding_2)
rename (q_312_1 q_312a_1 q_312_2 q_312a_2 q_313a_1 q_313b_1 q_313b_unit_1 q_313a_2 q_313b_2 q_313b_unit_2 q_314_1 q_314_oth_1 q_314_2 q_314_oth_2 q_1201 ///
        q_1202 q_1203 q_1204) (m3_baby1_born_alive1 m3_baby1_born_alive2 m3_baby2_born_alive1 m3_baby2_born_alive2 m3_313a_baby1 m3_313c_baby1 ///
		m3_313d_baby1 m3_313a_baby2 m3_313c_baby2 m3_313d_baby2 m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 /// 
		m3_death_cause_baby2_other m3_1201 m3_1202 m3_1203 m3_1204)
rename (q_401 q_402 q_403_1 q_404_1 q_405_oth_1)(m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason_other)	
rename (q_403_2 q_404_2 q_405_oth_2)(m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason_other)
rename (q_403_3 q_404_3 q_405_3 q_405_oth_3) (m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason m3_consultation3_reason_other)	

       ** q_405_1 q_405_2 are string variables: use replace if and then rename (line 106 to 112, line 114 to 120)
replace q_405_1 = "A new health problem, including an emergency or an injury" if q_405_1  == "1"
replace q_405_1 = "An existing health problem" if q_405_1  == "2"
replace q_405_1 = "A lab test, x-ray, or ultrasound" if q_405_1  == "3"
replace q_405_1 = "To pick up medicine" if q_405_1  == "4"
replace q_405_1 = "To get a vaccine" if q_405_1  == "5"
replace q_405_1 = "Other reasons, please specify" if q_405_1  == "-96"
rename (q_405_1) (m3_consultation1_reason)

replace q_405_2 = "A new health problem, including an emergency or an injury" if q_405_2  == "1"
replace q_405_2 = "An existing health problem" if q_405_2  == "2"
replace q_405_2 = "A lab test, x-ray, or ultrasound" if q_405_2  == "3"
replace q_405_2 = "To pick up medicine" if q_405_2 == "4"
replace q_405_2 = "To get a vaccine" if q_405_2 == "5"
replace q_405_2 = "Other reasons, please specify" if q_405_2  == "-96"
rename (q_405_2) (m3_consultation2_reason)

       ** These 16 variables are string variables: use replace if and then rename 
       ** q_405_1_1 q_405_2_1 q_405_3_1 q_405_4_1 q_405_5_1 q_405__96_1 (line 126 to 143)
       ** q_405_1_2 q_405_2_2 q_405_3_2 q_405_4_2 q_405_5_2 q_405__96_2 (line 145 to 162)
       ** q_405_1_3 q_405_2_3 q_405_3_3 q_405_4_3 q_405_5_3 q_405__96_3 (line 164 to 181)
replace q_405_1_1 = "Yes" if q_405_1_1 == "1"
replace q_405_1_1 = "No" if q_405_1_1 == "0"
rename (q_405_1_1) (m3_consultation1_reason_a)
replace q_405_2_1 = "Yes" if q_405_2_1 == "1"
replace q_405_2_1 = "No" if q_405_2_1 == "0"
rename (q_405_2_1) (m3_consultation1_reason_b)
replace q_405_3_1 = "Yes" if q_405_3_1 == "1"
replace q_405_3_1 = "No" if q_405_3_1 == "0"
rename (q_405_3_1) (m3_consultation1_reason_c)
replace q_405_4_1 = "Yes" if q_405_4_1 == "1"
replace q_405_4_1 = "No" if q_405_4_1 == "0"
rename (q_405_4_1) (m3_consultation1_reason_d)
replace q_405_5_1 = "Yes" if q_405_5_1 == "1"
replace q_405_5_1 = "No" if q_405_5_1 == "0"
rename (q_405_5_1) (m3_consultation1_reason_e)
replace q_405__96_1 = "Yes" if q_405__96_1 == "1"
replace q_405__96_1 = "No" if q_405__96_1 == "0"
rename (q_405__96_1) (m3_consultation1_reason_96)

replace q_405_1_2 = "Yes" if q_405_1_2 == "1"
replace q_405_1_2 = "No" if q_405_1_2 == "0"
rename (q_405_1_2) (m3_consultation2_reason_a)
replace q_405_2_2 = "Yes" if q_405_2_2 == "1"
replace q_405_2_2 = "No" if q_405_2_2 == "0"
rename (q_405_2_2) (m3_consultation2_reason_b)
replace q_405_3_2 = "Yes" if q_405_3_2 == "1"
replace q_405_3_2 = "No" if q_405_3_2 == "0"
rename (q_405_3_2) (m3_consultation2_reason_c)
replace q_405_4_2 = "Yes" if q_405_4_2 == "1"
replace q_405_4_2 = "No" if q_405_4_2 == "0"
rename (q_405_4_2) (m3_consultation2_reason_d)
replace q_405_5_2 = "Yes" if q_405_5_2 == "1"
replace q_405_5_2 = "No" if q_405_5_2 == "0"
rename (q_405_5_2) (m3_consultation2_reason_e)
replace q_405__96_2 = "Yes" if q_405__96_2 == "1"
replace q_405__96_2 = "No" if q_405__96_2 == "0"
rename (q_405__96_2) (m3_consultation2_reason_96)

replace q_405_1_3 = "Yes" if q_405_1_3 == "1"
replace q_405_1_3 = "No" if q_405_1_3 == "0"
rename (q_405_1_3) (m3_consultation3_reason_a)
replace q_405_2_3 = "Yes" if q_405_2_3 == "1"
replace q_405_2_3 = "No" if q_405_2_3 == "0"
rename (q_405_2_3) (m3_consultation3_reason_b)
replace q_405_3_3 = "Yes" if q_405_3_3 == "1"
replace q_405_3_3 = "No" if q_405_3_3 == "0"
rename (q_405_3_3) (m3_consultation3_reason_c)
replace q_405_4_3 = "Yes" if q_405_4_3 == "1"
replace q_405_4_3 = "No" if q_405_4_3 == "0"
rename (q_405_4_3) (m3_consultation3_reason_d)
replace q_405_5_3 = "Yes" if q_405_5_3 == "1"
replace q_405_5_3 = "No" if q_405_5_3 == "0"
rename (q_405_5_3) (m3_consultation3_reason_e)
replace q_405__96_3 = "Yes" if q_405__96_3 == "1"
replace q_405__96_3 = "No" if q_405__96_3 == "0"
rename (q_405__96_3) (m3_consultation3_reason_96)

rename (q_412a_1 q_412b_1 q_412c_1 q_412d_1 q_412e_1 q_412f_1 q_412g_1 q_412g_oth_1 q_412i_1) ///
       (m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke ///
	   m3_412g_1_other m3_412i_1_ke )	

rename (q_412a_2 q_412a_3 q_412b_2 q_412b_3 q_412c_2 q_412c_3 q_412d_2 q_412d_3 q_412e_2 ///
		q_412e_3 q_412f_2 q_412f_3 q_412g_2 q_412g_3 q_412i_2 q_412i_3)(m3_412a_2_ke m3_412a_3_ke ///
		m3_412b_2_ke m3_412b_3_ke m3_412c_2 m3_412c_3 m3_412d_2_ke m3_412d_3_ke m3_412e_2_ke ///
		m3_412e_3_ke m3_412f_2_ke m3_412f_3_ke m3_412g_2_ke m3_412g_3_ke m3_412i_2_ke m3_412i_3_ke)
		
rename (q_412g_oth_2 q_412g_oth_3) (m3_412g_2_other m3_412g_3_other)		
	   
rename (q_504_n q_504_c q_504_r q_503_final q_506_pre q_506_pre_oth q_508 ///
 		q_508_oth q_513a q_513b_n q_513b_c q_513_r q_513_calc q_514 q_515 q_516 ///
		q_517 q_518_oth_del q_518_oth q_519 q_519_oth q_520 q_521 q_521_unit) ///
		(m3_504a m3_504b m3_504c m3_503_final m3_506_pre m3_506_pre_oth ///
		m3_508 m3_509_other m3_513a m3_513_outside_zone_other m3_513b2 m3_513b3 ///
		m3_513_final m3_514 m3_515 m3_516 m3_517 m3_518_other_complications ///
		m3_518_other m3_519 m3_519_other m3_520 m3_521_ke m3_521_ke_unit)

       ** q_518 is a string variables: use replace if and then rename (line 191 to 206)
replace q_518 = "The provider did not give a reason" if q_518 == "0"
replace q_518 = "No space or no bed available" if q_518 == "1"
replace q_518 = "Facility did not provide delivery care" if q_518 == "2"
replace q_518 = "Prolonged labor" if q_518 == "3"
replace q_518 = "Obstructed labor" if q_518 == "4"
replace q_518 = "Eclampsia/pre-eclampsia" if q_518 == "5"
replace q_518 = "Previous cesarean section scar" if q_518 == "6"
replace q_518 = "Fetal distress" if q_518 == "7"
replace q_518 = "Fetal presentations" if q_518 == "8"
replace q_518 = "No fetal movement" if q_518 == "9"
replace q_518 = "Bleeding" if q_518 == "10"
replace q_518 = "Other delivery complications (s" if q_518 == "-96"
replace q_518 = "Other reasons(specify)" if q_518 == "-97"
replace q_518 = "Don't Know" if q_518 == "-98"
replace q_518 = "NR/RF" if q_518 == "-99"
rename (q_518)(m3_518)
********When tabulate q_518, there are a few strange observations (8 -97, 8 9). I did not label them.
		
rename (q_601a q_601b q_601c q_602a q_602b q_603a q_603b q_603c q_604a q_604b q_605a q_605b q_605c q_605c_oth q_606 q_607 q_608 q_609 q_610a q_610b ///
        q_611 q_612 q_612_unit q_613 q_614 q_614_unit q_615_1 q_615_2 q_616_1 q_616_unit_1 q_616_2 q_616_unit_2 q_617_1 q_617_2 q_618a_1 q_618b_1 ///
		q_618c_1 q_618a_2 q_618b_2 q_618c_2) (m3_601_hiv m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b ///
		m3_605c m3_605c_other m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_612_ke m3_612_ke_unit m3_613 m3_614_ke m3_614_ke_unit m3_615a m3_615b ///
		m3_616c_1 m3_616c_1_unit m3_616c_2 m3_616c_2_unit m3_617a m3_617b m3_618a_1 m3_618b_1 m3_618c_1 m3_618a_2 m3_618b_2 m3_618c_2)
rename (q_619a q_619b q_619c q_619d q_619e q_619f q_619g q_620_1 q_620_2 q_621b q_621c q_621c_unit q_622a q_622b q_622c)(m3_619a m3_619b m3_619c ///
        m3_619d m3_619e m3_619g m3_619h m3_620_1 m3_620_2 m3_621b m3_621c_ke m3_621c_ke_unit m3_622a m3_622b m3_622c)

       ** q_621a is a string variables: use replace if and then rename (line 219 to 226)		
replace q_621a = "A relative or a friend" if q_621a == "1"
replace q_621a = "A traditional birth attendant" if q_621a == "2"
replace q_621a = "A community health worker" if q_621a == "3"
replace q_621a = "A nurse" if q_621a == "4"
replace q_621a = "A midwife" if q_621a == "5"
replace q_621a = "Don´t know [DO NOT READ]" if q_621a == "-98"
replace q_621a = "NR/RF" if q_621a == "-99"
rename (q_621a)(m3_621a)

rename (q_311a_1 q_311a_2 q_311b_1 q_311b_2 q_311c_1 q_311c_2 q_311d_1 q_311d_2 q_311e_1 q_311e_2 q_311f_1 q_311f_2 q_311g_1 q_311g_2)(m3_baby1_sleep ///
        m3_baby2_sleep m3_baby1_feed m3_baby2_feed m3_baby1_breath m3_baby2_breath m3_baby1_stool m3_baby2_stool m3_baby1_mood m3_baby2_mood ///
		m3_baby1_skin m3_baby2_skin m3_baby1_interactivity m3_baby2_interactivity)
rename (q_702 q_703 q_704a q_704b q_704c q_704d q_704e q_704f q_704g  ///
		q_706 q_707 q_707_unit q_708_1 q_708_2)(m3_702 m3_703 m3_704a ///
        m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_706 ///
		m3_707_ke m3_707_ke_unit m3_baby1_issues m3_baby2_issues)   

       ** These 8 variables are string variables : use replace if and then rename (line 235 to 258)
       ** q_708_1_1 q_708_2_1 q_708_3_1 q_708_4_1 q_708_5_1 q_708_6_1 q_708__98_1 q_708__99_1 
replace q_708_1_1 = "No" if q_708_1_1 == "0"   
replace q_708_1_1 = "Yes" if q_708_1_1 == "1"
rename (q_708_1_1)(m3_baby1_issues_a)
replace q_708_2_1 = "No" if q_708_2_1 == "0"  
replace q_708_2_1 = "Yes" if q_708_2_1 == "1"
rename (q_708_2_1)(m3_baby1_issues_b)
replace q_708_3_1 = "No" if q_708_3_1 == "0"  
replace q_708_3_1 = "Yes" if q_708_3_1 == "1"
rename (q_708_3_1)(m3_baby1_issues_c)
replace q_708_4_1 = "No" if q_708_4_1 == "0"  
replace q_708_4_1 = "Yes" if q_708_4_1 == "1"
rename (q_708_4_1)(m3_baby1_issues_d)
replace q_708_5_1 = "No" if q_708_5_1 == "0"
replace q_708_5_1 = "Yes" if q_708_5_1  == "1"
rename (q_708_5_1)(m3_baby1_issues_e)
replace q_708_6_1 = "No" if q_708_6_1 == "0"  
replace q_708_6_1 = "Yes" if q_708_6_1  == "1"
rename (q_708_6_1)(m3_baby1_issues_f)
replace q_708__98_1 = "No" if q_708__98_1 == "0"
replace q_708__98_1 = "Yes" if q_708__98_1  == "1"
rename (q_708__98_1)(m3_baby1_issues_98)
replace q_708__99_1 = "No" if q_708__99_1 == "0"
replace q_708__99_1 = "Yes" if q_708__99_1 == "1"
rename (q_708__99_1)(m3_baby1_issues_99)

       ** These 8 variables are string variables : use replace if and then rename (line 2625 to 285)
       ** q_708_1_2 q_708_2_2 q_708_3_2 q_708_4_2 q_708_5_2 q_708_6_2 q_708__98_2 q_708__99_2
replace q_708_1_2 = "No" if q_708_1_2 == "0"  
replace q_708_1_2 = "Yes" if q_708_1_2 == "1"
rename (q_708_1_2)(m3_baby2_issues_a)
replace q_708_2_2 = "No" if q_708_2_2 == "0"  
replace q_708_2_2 = "Yes" if q_708_2_2 == "1"
rename (q_708_2_2)(m3_baby2_issues_b)
replace q_708_3_2 = "No" if q_708_3_2 == "0"  
replace q_708_3_2 = "Yes" if q_708_3_2 == "1"
rename (q_708_3_2)(m3_baby2_issues_c)
replace q_708_4_2 = "No" if q_708_4_2 == "0" 
replace q_708_4_2 = "Yes" if q_708_4_2 == "1"
rename (q_708_4_2)(m3_baby2_issues_d)
replace q_708_5_2 = "No" if q_708_5_2 == "0"  
replace q_708_5_2 = "Yes" if q_708_5_2  == "1"
rename (q_708_5_2)(m3_baby2_issues_e)
replace q_708_6_2 = "No" if q_708_6_2 == "0"  
replace q_708_6_2 = "Yes" if q_708_6_2  == "1"
rename (q_708_6_2)(m3_baby2_issues_f)
replace q_708__98_2 = "No" if q_708__98_2 == "0"  
replace q_708__98_2 = "Yes" if q_708__98_2  == "1"
rename (q_708__98_2)(m3_baby2_issues_98)
replace q_708__99_2 = "No" if q_708__99_2 == "0"  
replace q_708__99_2 = "Yes" if q_708__99_2 == "1"
rename (q_708__99_2)(m3_baby2_issues_99)

rename (q_709_1 q_709_o_1 q_709_2 q_709_o_2 q_710_1 q_710_2 q_711_1 q_711_unit_1 q_711_2 q_711_unit_2) (m3_708_oth_1 m3_708a m3_708_oth_2 m3_708b ///
        m3_710a m3_710b m3_711c_1 m3_711c_1_unit m3_711c_2 m3_711c_2_unit)
		
rename (q_801a q_801b q_802a q_802b q_802c q_803a q_803b q_803c q_803d q_803e q_803f q_803g q_803h q_804 q_804_oth q_805 q_806 q_807 q_808a q_808b ///
        q_808b_oth q_809)(m3_801a m3_801b m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803j m3_803j_other ///
		m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other m3_809)

rename (q_901a q_901b q_901c q_901d q_901de q_901f q_901g q_901h q_901i q_901j q_901k q_901l q_901m q_901n q_901o q_901p q_901q q_901r q_901r_oth) ///
       (m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r ///
	    m3_901r_other)

rename (q_902a_1 q_902a_2 q_902b_1 q_902b_2 q_902c_1 q_902c_2 q_902d_1 q_902d_2 q_902e_1 q_902e_2 q_902f_1 q_902f_2 q_902g_1 q_902g_2 q_902h_1 q_902h_2 ///
        q_902i_1 q_902i_2 q_902j_1 q_902j_oth_1 q_902j_2 q_902j_oth_2)(m3_902a_baby1 m3_902a_baby2 m3_902b_baby1 m3_902b_baby2 m3_902c_baby1 ///
		m3_902c_baby2 m3_902d_baby1 m3_902d_baby2 m3_902e_baby1 m3_902e_baby2 m3_902f_baby1 m3_902f_baby2 m3_902g_baby1 m3_902g_baby2 m3_902h_baby1 ///
		m3_902h_baby2 m3_902i_baby1 m3_902i_baby2 m3_902j_baby1 m3_902j_baby1_other m3_902j_baby2 m3_902j_baby2_other)		

rename (q_1001 q_1002 q_1003 q_1005a q_1005b q_1005c q_1005d q_1005e q_1005f q_1005g q_1005h q_1006a q_1006b q_1006c q_1007a q_1007b q_1007c q_1101 ///
        q_1102a q_1102b q_1102c q_1102d q_1102e q_1102f q_1102f_oth q_1103 q_1104 q_1104_oth q_1105)(m3_1001 m3_1002 m3_1003 m3_1005a m3_1005b m3_1005c ///
		m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a_amt m3_1102b_amt ///
		m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt m3_1102f_oth m3_1103 m3_1105 m3_1105_other m3_1106)

	   ** Create q_1004b to collapse q_1004b_1 q_1004b_2 q_1004b_3 q_1004b_4 q_1004b_5 q_1004b_6 q_1004b_7 (line 309 to 316)
gen q_1004b = q_1004b_1 if q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_2 if q_1004b_1==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_3 if q_1004b_1==. & q_1004b_2==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_4 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_5 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_6 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_7==.
replace q_1004b = q_1004b_7 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==.
rename (q_1004b)(m3_1004b)

	   ** Create q_1004c to collapse q_1004c_1 q_1004c_2 q_1004c_3 q_1004c_4 q_1004c_5 q_1004c_6 q_1004c_7 (line 319 to 326)
gen q_1004c = q_1004c_1 if q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_2 if q_1004c_1==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_3 if q_1004c_1==. & q_1004c_2==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_4 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_5 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_6 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_7==.
replace q_1004c = q_1004c_7 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==.
rename (q_1004c)(m3_1004c)

	   ** Create q_1004d to collapse q_1004d_1 q_1004d_2 q_1004d_3 q_1004d_4 q_1004d_5 q_1004d_6 q_1004d_7 (line 329 to 336)
gen q_1004d = q_1004d_1 if q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_2 if q_1004d_1==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_3 if q_1004d_1==. & q_1004d_2==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_4 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_5 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_6 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_7==.
replace q_1004d = q_1004d_7 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==.
rename (q_1004d)(m3_1004d)

	   ** Create q_1004e to collapse q_1004e_1 q_1004e_2 q_1004e_3 q_1004e_4 q_1004e_5 q_1004e_6 q_1004e_7 (line 339 to 346)
gen q_1004e = q_1004e_1 if q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_2 if q_1004e_1==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_3 if q_1004e_1==. & q_1004e_2==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_4 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_5 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_6 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_7==.
replace q_1004e = q_1004e_7 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==.
rename (q_1004e)(m3_1004e)

	   ** Create q_1004f to collapse q_1004f_1 q_1004f_2 q_1004f_3 q_1004f_4 q_1004f_5 q_1004f_6 q_1004f_7 (line 349 to 356)
gen q_1004f = q_1004f_1 if q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_2 if q_1004f_1==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_3 if q_1004f_1==. & q_1004f_2==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_4 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_5 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_6 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_7==.
replace q_1004f = q_1004f_7 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==.
rename (q_1004f)(m3_1004f)

	   ** Create q_1004g to collapse q_1004g_1 q_1004g_2 q_1004g_3 q_1004g_4 q_1004g_5 q_1004g_6 q_1004g_7 (line 359 to 366)
gen q_1004g = q_1004g_1 if q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_2 if q_1004g_1==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_3 if q_1004g_1==. & q_1004g_2==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_4 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_5 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_6 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_7==.
replace q_1004g = q_1004g_7 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==.
rename (q_1004g)(m3_1004g)

	   ** Create q_1004h to collapse q_1004h_1 q_1004h_2 q_1004h_3 q_1004h_4 q_1004h_5 q_1004h_6 q_1004h_7 (line 368 to 376)
gen q_1004h = q_1004h_1 if q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_2 if q_1004h_1==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_3 if q_1004h_1==. & q_1004h_2==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_4 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_5 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_6 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_7==.
replace q_1004h = q_1004h_7 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==.
rename (q_1004a q_1004h)(m3_1004a m3_1004h)


*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS (NA in KENYA, already labeled)
	
	
	** MODULE 1:
	*encode facility_name, generate(facility) // SS 2-27: looks like facility_name is already numeric
	/*
	label def facility 1 "Githunguri health centre" 2 "Igegania sub district hospital" ///
					   3 "Ikutha Sub County Hospital" 4 "Kalimoni mission hospital" ///
					   5 "Katse Health Centre" 6 "Kauwi Sub County Hospital" ///
					   7 "Kiambu County referral hospital" 8 "Kisasi Health Centre (Kitui Rural)" ///
					   9 "Kitui County Referral Hospital" 10 "Makongeni dispensary" ///
					   11 "Mercylite hospital" 12 "Mulango (AIC) Health Centre" ///
					   13 "Muthale Mission Hospital" 14 "Neema Hospital" 15 "Ngomeni Health Centre" ///
					   16 "Nuu Sub County Hospital" 17 "Our Lady of Lourdes Mutomo Hospital" ///
					   18 "Plainsview nursing home" 19 "St. Teresas Nursing Home" ///
					   20 "Waita Health Centre" 21 "Wangige Sub-County Hospital",modify	
	label define facility facility				   
 	*/
	
	label define b4 19 "Mwingi West" 20 "Kitui East", modify
	label define q515_2 20 "Kitui East", modify
	label define q519_2 20 "Kitui East", modify
	
	
	** MODULE 2:
	
	
	** MODULE 3:
label define m3_death_cause_baby2 0 "Not told anything" 1 "The baby was premature" 2 "An infection" 3 "A congenital abnormality" 4 "A birth injury or asphyxia" 5 "Difficulties breathing" 6 "Unexplained causes" 7 "You decided to have an abortion" -96 "Other (specify)"
label values m3_death_cause_baby2 m3_death_cause_baby2
		
label define m3_baby1_weight -98 "DO NOT KNOW"
label values m3_baby1_weight m3_baby1_weight
label define m3_baby2_weight -98 "DO NOT KNOW"
label values m3_baby2_weight m3_baby2_weight
	
label define YN_m3 1 "Yes" 0 "No"
label values m3_708_oth_2 m3_902j_baby2 YN_m3

label define m3_303a 1 "One" 2 "Two" 3 "Three or more" -98 "Don't Know" -99 "NR/RF"
label values m3_303a m3_303a	

label define m3_807 0 "Not at all" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "A great deal"
label values m3_807 m3_807

*===============================================================================
* Generate new vars (KE only):

destring (m1_clinic_cost_ke),replace

egen m1_1218_other_total_ke = rowtotal(m1_1218d_1 m1_1218e_1 m1_1218f_1) 
egen m1_1218_total_ke = rowtotal(m1_clinic_cost_ke m1_1218_other_total_ke) 	
	
drop m1_1218g m1_other_costs_ke m1_clinic_cost_ke

destring (gest_age_baseline_ke),replace

drop if gest_age_baseline_ke == -33 | gest_age_baseline_ke == -12 | gest_age_baseline_ke == -6 | gest_age_baseline_ke == -2

*===============================================================================
		
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 

	** MODULE 1:
recode m1_402 m1_403b m1_404 m1_506 m1_507 m1_509b m1_510b m1_511 m1_700 m1_701 ///
	   m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e ///
	   m1_708f m1_709a m1_709b m1_710a m1_710b m1_711a m1_712 ///
	   m1_714a m1_714b m1_714c m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 ///
	   m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724b m1_724c m1_724d m1_724e m1_724f ///
	   m1_724g m1_724h m1_724i m1_801 m1_802_ke m1_803 m1_805 m1_805a_ke m1_806 m1_807 ///
	   m1_809 m1_810a m1_812a m1_813a m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e ///
	   m1_814f m1_814g m1_814h m1_902 m1_904 m1_906 m1_907 m1_1004 m1_1005 m1_1006 m1_1007 ///
	   m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 ///
	   m1_1103 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 ///
	   m1_1209 m1_1210 m1_1211 m1_1216b m1_1222 m1_802_ke (998 = .d)

recode m1_711b m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h ///
	   m1_713i m1_901 (4 = .d)

recode mobile_phone m1_201 m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9a  ///
	   phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i m1_301 m1_302 ///
	   m1_303 m1_304 m1_305a m1_402 m1_404 m1_405 m1_503 m1_504 m1_505 m1_506 ///
	   m1_507 m1_509a m1_509b m1_510a m1_510b m1_601 m1_602 m1_605a m1_605b ///
	   m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_700 m1_701 m1_702 m1_703 ///
	   m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f ///
	   m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713j_ke ///
	   m1_713b m1_713g m1_713c m1_713d m1_713e m1_713k m1_713f m1_713h m1_713i m1_713l ///
	   m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 ///
	   m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h ///
	   m1_724i m1_801 m1_802_ke m1_805 m1_806 m1_807 m1_808 m1_809 m1_810a m1_812a m1_813a ///
	   m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_901 m1_903 ///
	   m1_902 m1_903 m1_904 m1_907 m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 m1_1010 ///
	   m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103 m1_1105 m1_1201 ///
	   m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 ///
	   m1_1216b m1_1222 (999 = .r)
  	
replace m1_812b=".d" if m1_812b== "998"	
replace m1_815_0=".d" if m1_815_0== "998"	
replace m1_815_0=".r" if m1_815_0== "999"	

    ** MODULE 2: 
recode m2_201 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i ///
	   m2_205a m2_205b m2_206 m2_301 m2_303a m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 ///
	   m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_502 m2_505a ///
	   m2_505b m2_505c m2_505d m2_505e m2_505f m2_504 m2_505g m2_508a m2_603 m2_701 (-99 = .r)

recode m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i m2_206 ///
       m2_301 m2_303a m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 ///
	   m2_318 m2_321 m2_502 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_504 ///
	   m2_505g m2_508a m2_603 m2_701  (-98 = .d)

recode m2_attempt_relationship (4 = .d)	   

recode m2_complete (5 = .r)

	   ** MODULE 3:
recode m3_303a m3_303b m3_baby1_gender m3_baby1_health m3_breastfeeding m3_baby1_born_alive1 ///
	   m3_baby1_born_alive2 m3_303c m3_baby2_gender m3_baby2_health m3_breastfeeding_2 ///
	   m3_baby2_born_alive1 m3_baby2_born_alive2 m3_401 m3_consultation_1 m3_consultation_referral_1 ///
	   m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_412g_other m3_412i m3_consultation_2 ///
	   m3_consultation_referral_2 m3_412a_2_ke m3_412b_2_ke m3_412c_2 m3_412d_2_ke m3_412e_2_ke m3_412f_2_ke m3_412g_2_ke ///
	   m3_412i_2_ke m3_consultation_3 m3_consultation_referral_3 m3_412a_3_ke m3_412b_3_ke m3_412c_3 m3_412d_3_ke ///
	   m3_412e_3_ke m3_412f_3_ke m3_412i_3_ke m3_501 m3_503 m3_502 m3_509 q_510 q_512_1 q_512_2 m3_513a m3_516 ///
	   m3_517 m3_519 m3_601_hiv m3_601b m3_601c m3_602a q_603_note m3_603a m3_603b m3_603c m3_604a ///
	   m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a ///
	   m3_617a m3_618a_1 m3_618b_1 m3_618c_1 m3_620_1 m3_615b m3_617b m3_618a_2 m3_618b_2 m3_618c_2 ///
	   m3_620_2 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g m3_619h m3_621b m3_622a m3_622c ///
	   m3_701 m3_703 q_704_note m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 ///
	   m3_706 m3_708_oth_1 m3_710a m3_710b q_801_note m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e ///
	   m3_803f m3_803g m3_803h m3_803j m3_805 m3_808a m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e ///
	   m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q ///
	   m3_901r m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 ///
	   m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 m3_902a_baby2 m3_902b_baby2 m3_902c_baby2 ///
	   m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 m3_902i_baby2 m3_1001 ///
	   m3_1002 m3_1003 m3_1004a q_1004b_1 q_1004c_1 q_1004d_1 q_1004e_1 q_1004f_1 q_1004g_1 q_1004h_1 ///
	   q_1004b_2 q_1004c_2 q_1004d_2 q_1004e_2 q_1004f_2 q_1004g_2 q_1004h_2 q_1004b_3 q_1004c_3 ///
	   q_1004d_3 q_1004e_3 q_1004f_3 q_1004g_3 q_1004h_3 q_1004b_4 q_1004c_4 q_1004d_4 q_1004e_4 ///
	   q_1004f_4 q_1004g_4 q_1004h_4 q_1004b_5 q_1004c_5 q_1004d_5 q_1004e_5 q_1004f_5 q_1004g_5 ///
	   q_1004h_5 q_1004b_6 q_1004c_6 q_1004d_6 q_1004e_6 q_1004f_6 q_1004g_6 q_1004h_6 q_1004b_7 ///
	   q_1004c_7 q_1004d_7 q_1004e_7 q_1004f_7 q_1004g_7 q_1004h_7 m3_1005a m3_1005b m3_1005c ///
	   m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b ///
	   m3_1007c m3_1101 m3_1106 m3_1201 m3_1202 m3_1203 m3_1204 (-99 = .r)

recode m3_303a m3_baby1_gender m3_baby1_weight m3_baby2_weight m3_baby1_born_alive1 ///
	   m3_baby1_born_alive2 m3_baby2_gender m3_baby2_weight m3_baby2_born_alive1 ///
	   m3_baby2_born_alive2 m3_401 m3_consultation_1 m3_consultation_referral_1 ///
	   m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_412g_other m3_412i ///
	   m3_consultation_2 m3_consultation_referral_2 q_412a_2 q_412b_2 q_412c_2 q_412d_2 ///
	   q_412e_2 q_412f_2 q_412g_2 q_412i_2 m3_consultation_3 m3_consultation_referral_3 ///
	   q_412a_3 q_412b_3 q_412c_3 q_412d_3 q_412e_3 q_412f_3 q_412i_3 m3_501 m3_503 m3_502 ///
	   q_510 q_512_1 q_512_2 m3_513a m3_517 m3_519 m3_601_hiv m3_601b m3_601c m3_602a m3_602b ///
	   q_603_note m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 ///
	   m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a m3_617a m3_618a_1 m3_618b_1 m3_618c_1 ///
	   m3_620_1 m3_615b m3_617b m3_618a_2 m3_618b_2 m3_618c_2 m3_620_2 m3_619a m3_619b ///
	   m3_619c m3_619d m3_619e m3_619g m3_619h m3_621b m3_622a m3_622c m3_701 m3_703 q_704_note ///
	   m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_708_oth_1 ///
	   m3_710a m3_710b q_801_note m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f ///
	   m3_803g m3_803h m3_803j m3_805 m3_808a m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e ///
	   m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p ///
	   m3_901q m3_901r m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 ///
	   m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 m3_902a_baby2 m3_902b_baby2 ///
	   m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 m3_902i_baby2 m3_1002 ///
	   m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a ///
	   m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1106 m3_1201 m3_1203 (-98 = .d)	 
	   
	   
*------------------------------------------------------------------------------*

* recoding for skip pattern logic:	   
	   
* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns

* MODULE 1:

* eligibility:
	* Keep these recode commands here even though everyone has given permission 
recode care_self (. = .a) if permission == 0

destring(enrollage), gen(recenrollage)
recode recenrollage (. = .a) if permission == 0
drop enrollage

recode b6anc_first (. = .a) if b5anc== 2
recode flash (.  = .a) if mobile_phone == 0 | mobile_phone == . 
*replace phone_number = ".a" if mobile_phone == 0 | mobile_phone == . //dropped phone number from data

egen chronic_total = rowtotal(m1_203a_ke m1_203b_ke m1_203c_ke m1_203d_ke m1_203e_ke ///
							  m1_203f_ke m1_203g_ke m1_203h_ke m1_203i_ke m1_203j_ke ///
							  m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke m1_203_96_ke) 	
recode m1_204 (.  = .a) if chronic_total <=1
drop chronic_total

/*
recode m1_204 (. = .a) if (m1_203a_ke == 0 | m1_203a_ke == .) & ///
				   (m1_203b_ke == 0 | m1_203b_ke == .) & ///
				   (m1_203c_ke == 0 | m1_203c_ke == .) & ///
				   (m1_203d_ke == 0 | m1_203d_ke == .) & ///
				   (m1_203e_ke == 0 | m1_203e_ke == .) & ///
				   (m1_203f_ke == 0 | m1_203f_ke == .) & ///
				   (m1_203g_ke == 0 | m1_203g_ke == .) & ///
				   (m1_203h_ke == 0 | m1_203h_ke == .) & ///
				   (m1_203i_ke == 0 | m1_203i_ke == .) & ///
				   (m1_203j_ke == 0 | m1_203j_ke == .) & ///
				   (m1_203k_ke == 0 | m1_203k_ke == .) & ///
				   (m1_203l_ke == 0 | m1_203l_ke == .) & ///
				   (m1_203m_ke == 0 | m1_203m_ke == .) & ///
				   (m1_203n_ke == 0 | m1_203n_ke == .) & ///
				   (m1_203o_ke == 0 | m1_203o_ke == .) & ///
				   (m1_203_96_ke == 0 | m1_203_96_ke == .) 
*/
				   
replace m1_203_other = ".a" if m1_203_96_ke != 1

replace m1_401_other = ".a" if m1_401_96_ke != 1 
replace m1_405_other = ".a" if m1_405 != -96

replace m1_501_ke_other = ".a" if m1_501k_ke != 1

replace m1_501_other = ".a" if m1_501 != -96

recode m1_503 (.  = .a) if m1_502 == 0 | m1_502 == . 

* please note that people who completed primary were not asked m1_504 in KE, and people who said that they have not attended school still answered m1_504
recode m1_504 (.  = .a) if m1_503 == 2 | m1_503 == 3 | m1_503 == 4 | ///
						   m1_503 == 5 | m1_503 == .a | m1_503 == .

replace m1_506_other = ".a" if m1_506 != -96	

replace m1_507_other = ".a" if m1_507 != -96		
				  
recode m1_509b (.  = .a) if m1_509a == 0 | m1_509a == . | m1_509a == .r
recode m1_510b (.  = .a) if m1_510a == 0 | m1_510a == . | m1_510a == .r

recode m1_513c (. = .a) if m1_513a_2 != 1
 
* SS: confirm what is the skip pattern for m1_513c? Is there one?
recode m1_514a (. = .a) if m1_513c != .
recode m1_514b (. = .a) if m1_514a == . | m1_514a == .a
recode m1_514c_ke (. = .a) if m1_514a == . | m1_514a == .a

replace m1_515_county_other = ".a" if m1_515_county != -96
replace m1_515_subcounty_other = ".a" if m1_515_subcounty != -96
recode m1_517 (. = .a) if m1_516 == "" 
recode m1_518 (. = .a) if m1_517 == 2 | m1_517 == . | m1_517 == .a
recode m1_519_county (. = .a) if m1_517 == 2 | m1_517 == . | m1_517 == .a
replace m1_519_county_other = ".a" if m1_519_county != -96
recode m1_519_subcounty (. = .a) if m1_517 == 2 | m1_517 == . | m1_517 == .a
replace m1_519_subcounty_other = ".a" if m1_519_subcounty != -96
replace m1_519_ward = ".a" if m1_517 == 2 | m1_517 == . | m1_517 == .a
replace m1_519_village = ".a" if m1_517 == 2 | m1_517 == . | m1_517 == .a
replace m1_519_address = ".a" if m1_517 == 2 | m1_517 == . | m1_517 == .a
replace m1_519_directions = ".a" if m1_517 == 2 | m1_517 == . | m1_517 == .a 
	   	   
recode m1_708b (. = .a) if m1_708a == . | m1_708a == 0 | m1_708a == .d | m1_708a == .r
recode m1_708c (. = .a) if m1_708b	== 2 | m1_708b == . |	m1_708b == .d | m1_708b == .a | m1_708b == .r
recode m1_708d (. = .a) if m1_708c	== 0 | m1_708c == . | m1_708c == .d | m1_708c == .a | m1_708c == .r
recode m1_708e (. = .a) if m1_708d == 0 | m1_708d == . | m1_708d == .d | m1_708d == .a | m1_708d == .r
recode m1_708f (. = .a) if m1_708e == 0 | m1_708e == . | m1_708e == .d | m1_708e == .a | m1_708e == .r
recode m1_709a (. = .a) if m1_708b	== 2 | m1_708b == . | m1_708b == .d | m1_708b == .a | m1_708b == .r | m1_708b == .a
recode m1_709b (. = .a) if m1_708b	== 2 | m1_708b == . | m1_708b == .d | m1_708b == .a | m1_708b == .r | m1_708b == .a
recode m1_710b (. = .a) if m1_710a == 0 | m1_710a == . | m1_710a == .d | m1_710a == .a | m1_710a == .r
recode m1_710c (. = .a) if m1_710b == 2 | m1_710b == .a | m1_710b == .d | m1_710b == .r | m1_710b == .
recode m1_711b (.= .a) if m1_711a == 0 | m1_711a == . | m1_711a == .d | m1_711a == .r | m1_711a == .a
recode m1_714c (. = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r | m1_714b == .a 

recode m1_714d (. = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r | ///
						   m1_714b == .a | m1_714c == . | m1_714c == 0 | m1_714c == .a | m1_714c == .d

recode m1_714e (. = .a) if m1_714c == 0 | m1_714c == 1 | m1_714c == . | m1_714c == .a | ///
						   m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r | m1_714b == .a

recode m1_717 (. = .a) if m1_202d == 0 | m1_202d == . 
recode m1_718 (. = .a) if m1_202a == 0 | m1_202a == .
recode m1_719 (. = .a) if m1_202b == 0 | m1_202b == .
recode m1_720 (. = .a) if m1_202c == 0 | m1_202c == .
recode m1_721 (. = .a) if m1_202d == 0 | m1_202d == .
recode m1_722 (. = .a) if m1_202e == 0 | m1_202e == . | m1_202e == .r
recode m1_723 (. = .a) if m1_204 == 0 | m1_204 == . | m1_204 == .r
recode m1_724b (. = .a) if m1_724a == 0 | m1_724a == . | m1_724a == .d
recode m1_724c (. = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724d (. = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724e (. = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724f (. = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724g (. = .a) if  m1_707 == 1 | m1_707 == . 
recode m1_724h (. = .a) if m1_708a == 1 | m1_708a == . 
recode m1_724i (. = .a) if m1_712 == 1 | m1_712 == . | m1_712 == .d
recode m1_802a (. = .a) if m1_801 == . | m1_801 ==0 | m1_801 ==.a | m1_801 ==.d | m1_801 == .r

recode m1_802_ke (. = .a) if m1_801 == . | m1_801 == 0 | m1_801 == .a | m1_801 == .d | m1_801 == .r

* 9/15: Laura confirmed : For edd_chart, there is no skip pattern. It´s asked to all respondents. However, it was added during the survey (you can check the variable "formdef_version" and you´ll notice that edd_chart is only missing for the form versions 2307030539 (July 3rd, 2023, 05:39am) and earlier), and is therefore missing for the earlier submissions. 

recode edd_chart_ke (. = .a) if m1_801 == . | m1_801 == 0 | m1_801 == .a | m1_801 == .d | m1_801 == .r

recode m1_803 (. = .a) if m1_801 == 1 | m1_801 == . | m1_801 == .d

*replace gest_age_baseline_ke = ".a" if edd_chart_ke == 0 | edd_chart_ke == . | edd_chart_ke == .a

recode m1_804 (.  = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d) & (m1_802a == . | m1_802a == .a) & (m1_803 == . | m1_803 == .d | m1_803 == .r)
recode m1_808 (.  = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a 
replace m1_808_other = ".a" if m1_808 != -96
	
replace m1_810b = .a if m1_810a == 1 | m1_810a == 2 | m1_810a == .d | m1_810a == . | m1_810a == .r
replace m1_810b_other = ".a" if m1_810b != -96

replace m1_812b = ".a" if m1_812a == 0 | m1_812a ==. | m1_812a == .d | m1_812a == .r

recode m1_812b_0_ke m1_812b_1 m1_812b_2 m1_812b_3 m1_812b_4 m1_812b_5 m1_812b_96 ///
	   m1_812b_99 (. = .a) if m1_812b == ".a"

replace m1_812b_other = ".a" if m1_812b_96 !=1
	   
recode m1_813b (.  = .a) if m1_813a == 0 | m1_813a == . | m1_813a == .d
recode m1_814h (.  = .a) if m1_804 == 1	| m1_804 == 2 | m1_804 == . | m1_804 == .a | m1_804 == .d		
						   			   
replace m1_815_0 = ".a" if (m1_814a == 0 | m1_814a == .) ///
	   & (m1_814b == 0 | m1_814b == .) & (m1_814c == 0 | m1_814c == .d | m1_814c == .) & ///
	   (m1_814d == 0 | m1_814d == .d | m1_814d == .) & ///
	   (m1_814e == 0 | m1_814e == . | m1_814e == .d) & ///
	   (m1_814f == 0 | m1_814f == .d | m1_814f == .) & ///
	   (m1_814g == 0 | m1_814g == . | m1_814g == .d | m1_814g == .r) & ///
	   (m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == .a | m1_814h == .)

recode m1_815_1 m1_815_2 m1_815_3 m1_815_4 m1_815_5 m1_815_6 m1_815_7 ///
	   m1_815_96 m1_815_98 m1_815_99 (.  = .a) if (m1_814a == 0 | m1_814a == .) ///
	   & (m1_814b == 0 | m1_814b == .) & (m1_814c == 0 | m1_814c == .d | m1_814c == .) & ///
	   (m1_814d == 0 | m1_814d == .d | m1_814d == .) & ///
	   (m1_814e == 0 | m1_814e == . | m1_814e == .d) & ///
	   (m1_814f == 0 | m1_814f == .d | m1_814f == .) & ///
	   (m1_814g == 0 | m1_814g == . | m1_814g == .d | m1_814g == .r) & ///
	   (m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == .a | m1_814h == .)
						   
replace m1_815_other = ".a" if m1_815_96 != 1 
									
recode m1_902 (.  = .a) if m1_901 == 3 | m1_901 == .d | m1_901 == .r | m1_901 == .

recode m1_904 (.  = .a) if m1_901 == 3 | m1_901 == .d | m1_901 == .r | m1_901 == .

recode m1_906 (.  = .a) if m1_905 == 0 | m1_905 == . | m1_905 == .r

recode m1_907 (.  = .a) if m1_905 == 0 | m1_905 == . | m1_905 == .d | m1_905 == .r
					
recode m1_1002 (.  = .a) if m1_1001 <= 1 | m1_1001 == .	

recode m1_1003 (.  = .a) if m1_1002 <1 | m1_1002 == . | m1_1002 == .a	

recode m1_1004 (.  = .a) if m1_1001 <= m1_1002

recode m1_1005 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 == .)

recode m1_1006 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 == .)

recode m1_1007 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1008 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1009 (.  = .a) if (m1_1003 <1 | m1_1003 == .a | m1_1003 == .)

recode m1_1010 (.  = .a) if (m1_1003 <= m1_1009) | m1_1003 == .a 

recode m1_1011a (.  = .a) if (m1_1001 <= 1 | m1_1001 ==.)

recode m1_1011b (.  = .a) if m1_1004 == 0 | m1_1004 == . | m1_1004 == .a

recode m1_1011c (.  = .a) if (m1_1002 <= m1_1003)	

recode m1_1011d (.  = .a) if	m1_1005 == 0 | m1_1005 == . | m1_1005 == .a

recode m1_1011e (.  = .a) if m1_1007 == 0 | m1_1007 == . | m1_1007 == .a

recode m1_1011f (.  = .a) if m1_1010 == 0 | m1_1010 == . | m1_1010 == .a

replace m1_1102 = ".a" if m1_1101 == 0 | m1_1101 == . 

recode m1_1102_2 m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 m1_1102_7 m1_1102_8 ///
	   m1_1102_9 m1_1102_10 m1_1102_96 m1_1102_98 m1_1102_99 (.  = .a) if ///
	   m1_1101 == 0 | m1_1101 == . 

replace m1_1102_other = ".a" if m1_1102_96 != 1

replace m1_1104 = ".a" if m1_1103 == 0 | m1_1103 == . | m1_1103 == .d

recode m1_1104_1 m1_1104_2 m1_1104_3 m1_1104_4 m1_1104_5 m1_1104_6 m1_1104_7 m1_1104_8 m1_1104_9 m1_1104_10 m1_1104_96 m1_1104_98 m1_1104_99 (.  = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .d

replace m1_1104_other = ".a" if m1_1104_96 != 1 

recode m1_1105 (.  = .a) if (m1_1103 == 0 | m1_1103 == . | m1_1103 == .d)

replace m1_1201_other = ".a" if m1_1201 != -96	

* where is the "other value"- doesn't exist in dataset because no one selected other, will drop
*replace m1_1202_other = ".a" if m1_1202 != 96	
drop m1_1202_other

replace m1_1208_other = ".a" if m1_1208 != -96	

* where is the "other value" - doesn't exist in dataset because no one selected other, will drop
*replace m1_1209_other = ".a" if m1_1209 != 96	
drop m1_1209_other

replace m1_1210_other = ".a" if m1_1210 != -96	

replace m1_1211_other = ".a" if m1_1211 != -96	

recode m1_1218_ke m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f m1_1218f_1 (. = .a) if m1_1217 == 0 | m1_1217 == .

replace m1_1218_total_ke = .a if m1_1217 == 0 | m1_1217 == .

*replace m1_clinic_cost_ke = .a if m1_1217 == 0 | m1_1217 == .

replace m1_1218f_other = ".a" if m1_1218f == 0 | m1_1218f == .a | m1_1218f == .

recode m1_1218_total_ke (. = .a) if m1_1217 == 0 | m1_1217 == .

* delete after drop:
*replace m1_1218g = ".a" if m1_1217 == 0 | m1_1217 == .

recode m1_1219 (.  = .a) if (m1_1218_ke == .a) & ///
						   (m1_1218a_1 == .a | m1_1218a_1 ==.) & ///
						   (m1_1218b_1 == .a | m1_1218b_1 == .) & ///
						   (m1_1218c_1 == .a | m1_1218c_1 == .) & ///
						   (m1_1218d_1 == .a | m1_1218c_1 == .) & ///
						   (m1_1218e_1 == .a | m1_1218e_1 == .) & ///
						   (m1_1218f_1 == .a | m1_1218f_1 == .) // & 
						   *(m1_clinic_cost_ke == .a)

* delete after drop:						   
*replace m1_other_costs_ke = ".a" if m1_1217 == 0 | m1_1217 == .

recode m1_1218_other_total_ke (. = .a) if m1_1217 == 0 | m1_1217 == . 						   
						   
recode m1_1220 (.  = .a) if m1_1217 == 0 | m1_1217 == . 

replace m1_1220_other = ".a" if m1_1220 != -96	

replace m1_1222 = .a if m1_1221 == 0 | m1_1221 == .

replace m1_1222_other = ".a" if m1_1222 != -96

recode m1_1307 (.  = .a) if m1_1306 == 0 | m1_1306 == . 

recode m1_1308 (.  = .a) if m1_1306 == 1 | m1_1306 == .

recode m1_1309 (.  = .a) if m1_1308 == 0 | m1_1308 == . | m1_1308 == .a	  

*replace pref_language_other_ke = ".a" if pref_language_96_ke != 1

	** MODULE 2 (EDIT FOR KE!!):
	
	** MODULE 3 (EDIT FOR KE!!):

*===============================================================================					   
	
	* STEP FOUR: LABELING VARIABLES
ren rec* *
	
	** MODULE 1:		
lab var country "Country"
lab var interviewer_id "Interviewer ID"
lab var m1_date "A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var study_site "A4. Study site"
lab var facility "A5. Facility name"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var enrollage "B3. How old are you?"
lab var zone_live "B4. In which zone/district/sub city are you living?"
lab var zone_live_other "B4_Other. Other zone/district/subcity"
lab var b5anc "B5. By that I mean care related to a pregnancy?"
lab var b6anc_first "B6. Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?"
lab var b7eligible "B7. Is the respondent eligible to participate in the study AND signed a consent form?"
*lab var first_name "101. What is your first name?"
*lab var family_name "102. What is your family name?"
lab var respondentid "103. Assign respondent ID"
lab var mobile_phone "104. Do you have a mobile phone with you today?"
*lab var phone_number "105. What is your phone number?"
lab var flash "106. Can I 'flash' this number now to make sure I have noted it correctly?"
lab var m1_201 "201. In general, how would you rate your overall health?"
lab var m1_202a "202a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202d BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202e BEFORE you got pregnant, did you know that you had HIV?"
lab var m1_203 "203. Before you got pregnant, were you diagnosed with any other major health problems?"
lab var m1_203a_ke "203a. KE only: No major health problems"
lab var m1_203b_ke "203b. KE only: Sexually Transmitted Diseases (STDs)"
lab var m1_203c_ke "203c. KE only: Renal disorders"
lab var m1_203d_ke "203d. KE only: Thyroid disorders"
lab var m1_203e_ke "203e. KE only: Autoimmune diseases"
lab var m1_203f_ke "203f. KE only: Acute surgical problems"
lab var m1_203g_ke "203g. KE only: Genital tract abnormalities"
lab var m1_203h_ke "203h. KE only: Obesity"
lab var m1_203i_ke "203i. KE only: Hemoglobianopathies"
lab var m1_203j_ke "203j. KE only: Severe anemia"
lab var m1_203k_ke "203k. KE only: Cancer"
lab var m1_203l_ke "203l. KE only: TB"
lab var m1_203m_ke "203m. KE only: Kidney failure"
lab var m1_203n_ke "203n. KE only: Asthma"
lab var m1_203o_ke "203o. KE only: Chronic obstructive pulmonary disease (COPD)"
lab var m1_203_96_ke "203. KE only: Other, specify"
lab var m1_203_other "203_Other. KE only: Other major health problems"
lab var m1_204 "204. Are you currently taking any medications?"
lab var m1_205a "205a. I am going to read three statements about your mobility, by which I mean your ability to walk around. Please indicate which statement best describe your own health state today?"
lab var m1_205b "205b. I am now going to read three statements regarding your ability to self-care, by which I mean whether you can wash and dress yourself without assistance. Please indicate which statement best describe your own health state today"
lab var m1_205c "205c. I am going to read three statements regarding your ability to perform your usual daily activities, by which I mean your ability to work, take care of your family or perform leisure activities. Please indicate which statement best describe your own health state today."
lab var m1_205d "205d. I am going to read three statements regarding your experience with physical pain or discomfort. Please indicate which statement best describe your own health state today"
lab var m1_205e "205e. I am going to read three statements regarding your experience with anxiety or depression. Please indicate which statements best describe your own health state today"
lab var phq9a "206a. Over the past 2 weeks, how many days have you been bothered by little interest or pleasure in doing things?"
lab var phq9b "206b. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless ?"
lab var phq9c "206c. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
lab var phq9d "206d. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy"
lab var phq9e "206e. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating"
lab var phq9f "206f. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down? "
lab var phq9g "206g. Over the past 2 weeks, on how many days have you been bothered by trouble concentrating on things, such as your work or home duties?"
lab var phq9h "206h. Over the past 2 weeks, on how many days have you been bothered by moving or speaking so slowly that other people could have noticed? Or so fidgety or restless that you have been moving a lot more than usual?"
lab var phq9i "206i. Over the past 2 weeks, on how many days have you been bothered by Thoughts that you would be better off dead, or thoughts of hurting yourself in some way?"
lab var m1_207 "207. Over the past 2 weeks, on how many days did health problems affect your productivity while you were working? Work may include formal employment, a business, sales or farming, but also work you do around the house, childcare, or studying. Think about days you were limited in the amount or kind of work you could do, days you accomplished less than you would like, or days you could not do your work as carefully as usual."
lab var m1_301 "301. How would you rate the overall quality of medical care in Ethiopia?"
lab var m1_302 "302. Overall view of the health care system in your country"
lab var m1_303 "303. Confidence that you would receive good quality healthcare from the health system if you got very sick?"
lab var m1_304 "304. Confidence you would be able to afford the healthcare you needed if you became very sick?"
lab var m1_305a "305a. Confidence that you that you are the person who is responsible for managing your overall health?"
lab var m1_305b "305b. Confidence that you that you can tell a healthcare provider concerns you have even when he or she does not ask "
lab var m1_401 "401. How did you travel to the facility today?"
lab var m1_401a_ke "401a. KE only: Walking"
lab var m1_401b_ke "401b. KE only: Bicycle"
lab var m1_401c_ke "401c. KE only: Motorcycle"
lab var m1_401d_ke "401d. KE only: Car (personal or borrowed)"
lab var m1_401e_ke "401e. KE only: Bus/train/other public transportation"
lab var m1_401_96_ke "401. KE only: Other, specify"
lab var m1_401_998_ke "401. KE only: Don't Know"
lab var m1_401_999_ke "401. KE only: NR/RF"
lab var m1_401_other "401_Other. Other specify: travel"
lab var m1_402 "402. How long in minutes did it take you to reach this facility from your home?"
lab var m1_403b "403b. How far in kilometers is your home from this facility?"
lab var m1_404 "404. Is this the nearest health facility to your home that provides antenatal care for pregnant women?"
lab var m1_405 "405. What is the most important reason for choosing this facility for your visit today?"
lab var m1_405_other "405_Other. Specify other reason"
lab var m1_501 "501. What is your first language?"
lab var m1_501_other "501_Other. Specify other language"
lab var m1_501_ke "501b. Besides your primary/first language, which other languages do you speak fluently?"
lab var m1_501_ke_other "501b_Other. Specify other language spoken?"
lab var m1_501b_ke "501b. KE only: English"
lab var m1_501c_ke "501b. KE only: Kiswahili"
lab var m1_501d_ke "501b. KE only: Kikuyu"
lab var m1_501e_ke "501b. KE only: Kikamba"
lab var m1_501f_ke "501b. KE only: Kimeru"
lab var m1_501g_ke "501b. KE only: Kalenjin"
lab var m1_501h_ke "501b. KE only: Dholuo"
lab var m1_501i_ke "501b. KE only: Luhya"
lab var m1_501j_ke "501b. KE only: Kisii"
lab var m1_501k_ke"501b. KE only: Other, specify"
lab var m1_502 "502. Have you ever attended school?"
lab var m1_503 "503. What is the highest level of education you have completed?"
lab var m1_504 "504. Now I would like you to read this sentence to me. 1. PARENTS LOVE THEIR CHILDREN. 3. THE CHILD IS READING A BOOK. 4. CHILDREN WORK HARD AT SCHOOL."
lab var m1_505 "505. What is your current marital status?"
lab var m1_506 "506. What is your occupation, that is, what kind of work do you mainly do?"
lab var m1_506_other "506_Other. Specify other occupation"
lab var m1_507 "507. What is your religion?"
lab var m1_507_other "507_Other. Specify other religion"
lab var m1_508 "508. How many people do you have near you that you can readily count on for help in times of difficulty such as to watch over children, bring you to the hospital or store, or help you when you are sick?"
lab var m1_509a "509a. Now I would like to talk about something else. Have you ever heard of an illness called HIV/AIDS?"
lab var m1_509b "509b. Do you think that people can get the HIV virus from mosquito bites?"
lab var m1_510a "510a. Have you ever heard of an illness called tuberculosis or TB?"
lab var m1_510b "510b. Do you think that TB can be treated using herbal or traditional medicine made from plants?"
lab var m1_511 "511. When children have diarrhea, do you think that they should be given less to drink than usual, more to drink than usual, about the same or it doesn't matter?"
lab var m1_512 "512. Is smoke from a wood burning traditional stove good for health, harmful for health or do you think it doesn't really matter?"
lab var m1_513a "513a. What phone numbers can we use to reach you in the coming months?"
lab var m1_513a_1 "513a. Does not have any phone numbers "
lab var m1_513a_2 "513a. Primary personal phone"
lab var m1_513a_3 "513a. Secondary personal phone"
lab var m1_513a_4 "513a. Spouse or partner phone"
lab var m1_513a_5 "513a. Community health worker phone"
lab var m1_513a_6 "513a. Friend or other family member phone 1"
lab var m1_513a_7 "513a. Friend or other family member phone 2"
lab var m1_513a_8 "513a. Other phone"
lab var m1_513c "513c. Can I flash this number?"
lab var m1_514a "514a. We would like you to be able to participate in this study. We can give you a mobile phone for you to take home so that we can reach you. Would you like to receive a mobile phone?"
lab var m1_514b "514b. New mobile phone number"
lab var m1_514c_ke "514c. KE only: Flash this number now to make sure its noted it correctly"
lab var m1_515_address "515. Can you please tell me where you live? What is your address?"
lab var m1_515_county "515. County"
lab var m1_515_county_other "515_other. Other county"
lab var m1_515_subcounty "515. Sub-county"
lab var m1_515_subcounty_other "515_other. Other sub-county"
lab var m1_515_village "515. Village"
lab var m1_515_ward "515. Ward"
lab var m1_516 "516. Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions"
lab var m1_517 "517. Is this a temporary residence or a permanent residence?"
lab var m1_518 "518. Until when will you be at this residence?"
lab var m1_519_address "Address/Street name + house number"
lab var m1_519_county "519. County"
lab var m1_519_county_other "519. Other county"
lab var m1_519_directions "519. Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions."
lab var m1_519_subcounty "519. Sub-county"
lab var m1_519_subcounty_other "519. Other sub-county"
lab var m1_519_village "519. Village"
lab var m1_519_ward "519. Ward"
lab var m1_601 "601. Overall how would you rate the quality of care you received today?"
lab var m1_602 "602. How likely are you to recommend this facility or provider to a family member or friend to receive care for their pregnancy?"
lab var m1_603 "603. How long in minutes did you spend with the health provider today?"
lab var m1_604 "604. How long in minutes did you wait between the time you arrived at this facility and the time you were able to see a provider for the consultation?"
lab var m1_605a "605a. How would you rate the knowledge and skills of your provider?"
lab var m1_605b "605b. How would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab?"
lab var m1_605c "605c. How would you rate the level of respect the provider showed you?"
lab var m1_605d "605d. How would you rate the clarity of the provider's explanations?"
lab var m1_605e "605e. How would you rate the degree to which the provider involved you as much as you wanted to be in decisions about your care?"
lab var m1_605f "605f. How would you rate the amount of time the provider spent with you?"
lab var m1_605g "605g. How would you rate the amount of time you waited before being seen?"
lab var m1_605h "605h. How would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider?"
lab var m1_700 "700. Measure your blood pressure?"
lab var m1_701 "701. Measure your weight?"
lab var m1_702 "702. Measure your height?"
lab var m1_703 "703. Measure your upper arm?"
lab var m1_704 "704. Listen to the heart rate of the baby (that is, where the provider places a listening device against your belly to hear the baby's heart beating)?"
lab var m1_705 "705. Take a urine sample (that is, you peed in a container)?"
lab var m1_706 "706. Take a blood drop using a finger prick (that is, taking a drop of blood from your finger)"
lab var m1_707 "707. Take a blood draw (that is, taking blood from your arm with a syringe)"
lab var m1_708a "708a. Do an HIV test?"
lab var m1_708b "708b. Would you please share with me the result of the HIV test? Remember this information will remain confidential."
lab var m1_708c "708c. Did the provider give you medicine for HIV?"
lab var m1_708d "708d. Did the provider explain how to take the medicine for HIV?"
lab var m1_708e "708e. Did the provider do an HIV viral load test?"
lab var m1_708f "708f. Did the provider do a CD4 test?"
lab var m1_709a "709a. Did the provider do an HIV viral load test?"
lab var m1_709b "709b. Did the provider do a CD4 test?"
lab var m1_710a "710a. Did they do a syphilis test?"
lab var m1_710b "710b. Would you please share with me the result of the syphilis test?"
lab var m1_710c "710c. Did the provider give you medicine for syphilis directly, gave you a prescription or told you to get it somewhere else, or neither?"
lab var m1_711a "711a. Did they do a blood sugar test for diabetes?"
lab var m1_711b "711b. Do you know the result of your blood sugar test?"
lab var m1_712 "712. Did they do an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)"
lab var m1_713a "713a. Iron or folic acid pills, e.g., IFAS or Pregnacare?"
lab var m1_713b "713b. Calcium pills?"
lab var m1_713c "713c. The food supplement like Super Cereal or Plumpynut?"
lab var m1_713d "713d. Medicine for intestinal worms?"
lab var m1_713e "713e. Medicine for malaria (endemic only)?"
lab var m1_713f "713f. Medicine for your emotions, nerves, or mental health?"
lab var m1_713g "713g. Multivitamins?"
lab var m1_713h "713h. Medicine for hypertension?"
lab var m1_713i "713i. Medicine for diabetes, including injections of insulin?"
lab var m1_713j_ke "713j. KE only: Iron drip/injection?"
lab var m1_713k "713l: Medicine for HIV/ ARVs?"
lab var m1_713l "713l: Antibiotics for an infection?"
lab var m1_714a "714a. During the visit today, were you given an injection in the arm to prevent the baby from getting tetanus, that is, convulsions after birth?"
lab var m1_714b "714b. At any time BEFORE the visit today, did you receive any tetanus injections?"
lab var m1_714c "714c. Before today, how many times did you receive a tetanus injection?"
lab var m1_714d "714d. How many years ago did you receive that tetanus injection?"
lab var m1_714e "714e. How many years ago did you receive the last tetanus injection?"
lab var m1_715 "715. Were you provided with an insecticide treated bed net to prevent malaria?"
lab var m1_716a "716a. Did you discuss about Nutrition or what is you to be eating during your pregnancy?"
lab var m1_716b "716b. Did you discuss about Exercise or physical activity during your pregnancy?"
lab var m1_716c "716c. Did you discuss about Your level of anxiety or depression?"
lab var m1_716d "716d. Did you discuss about how to use a mosquito net that has been treated with an insecticide? (Malaria endemic zones only)?"
lab var m1_716e "716e. Did you discuss about Signs of pregnancy complications that would require you to go to the health facility?"
lab var m1_717 "717. Did you discuss that you were feeling down or depressed, or had little interest in doing things?"
lab var m1_718 "718. Did you discuss your diabetes, or not?"
lab var m1_719 "719. Did you discuss your high blood pressure or hypertension, or not?"
lab var m1_720 "720. Did you discuss your cardiac problems or problems with your heart, or not?"
lab var m1_721 "721. During the visit today, did you and the healthcare provider discuss your mental health disorder, or not?"
lab var m1_722 "722. Did you discuss your HIV, or not?"
lab var m1_723 "723. Did you discuss the medications you are currently taking, or not?"
lab var m1_724a "724a. Were you told you should come back for another antenatal care visit at this facility?"
lab var m1_724b "724b. When did he tell you to come back? In how many weeks?"
lab var m1_724c "724c. Were you told to go see a specialist like an obstetrician or a gynecologist?"
lab var m1_724d "724d. That you should see a mental health provider like a psychologist?"
lab var m1_724e "724e. To go to the hospital for follow-up antenatal care?"
lab var m1_724f "724f. To go somewhere else to do a urine test such as a lab or another health facility?"
lab var m1_724g "724g. To go somewhere else to do a blood test such as a lab or another health facility?"
lab var m1_724h "724h. To go somewhere else to do an HIV test such as a lab or another health facility?"
lab var m1_724i "724i. Were you told to go somewhere else to do an ultrasound such as a hospital or another health facility?"
lab var m1_801 "801. Did the healthcare provider tell you the estimated date of delivery, or not?"
lab var m1_802a "802a. What is the estimated date of delivery the provider told you?"
lab var m1_802_ke "802. KE only: Do you know the estimated date of delivery?"
lab var m1_803 "803. How many weeks pregnant do you think you are?"
lab var m1_804 "804. Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)."
lab var m1_805 "805. How many babies are you pregnant with?"
lab var m1_805a_ke "805a. KE only: Please refer to the chart to confirm the number of babies that the respondent is expecting."
lab var m1_806 "806. During the visit today, did the healthcare provider ask when you had your last period, or not?"
lab var m1_807 "807. When you got pregnant, did you want to get pregnant at that time?"
lab var m1_808 "808: There are many reasons why some women may not get antenatal care earlier in their pregnancy. Which, ifany, of the following, are reasons you did not receive care earlier in your pregnancy?"
lab var m1_808_other "808_Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_810b_other "810_Other. Specify other facility name where you plan to give birth."
lab var m1_812a "812a. During the visit today, did the provider tell you that you might need a C-section?"
lab var m1_812b "812b. Have you told the reason why you might need a c-section?"
lab var m1_812b_0_ke "812b. KE only: I was not told why "
lab var m1_812b_1 "812b. Because I had a c-section before"
lab var m1_812b_2 "812b. Because I am pregnant with more than one baby"
lab var m1_812b_3 "812b. Because of the baby's position"
lab var m1_812b_4 "812b. Because of the position of the placenta"
lab var m1_812b_5 "812b. Because I have health problems"
lab var m1_812b_96 "812b. Other (specify)"
lab var m1_812b_98 "812b. Don't Know"
lab var m1_812b_99 "812b. NR/RF"
lab var m1_812b_other "812b_Other. Specify other reason why you needed a C-section"
lab var m1_813a "813a. Did you experience nausea in your pregnancy so far, or not?"
lab var m1_813b "813b. Did you experience heartburn in your pregnancy so far, or not?"
lab var m1_814a "814a. Did you experience severe or persistent headaches in your pregnancy so far, or not?"
lab var m1_814b "814b. Did you experience vaginal bleeding of any amount in your pregnancy so far, or not?"
lab var m1_814c "814c. Did you experience a fever in your pregnancy so far, or not?"
lab var m1_814d "814d. Did you experience severe abdominal pain, not just discomfort in your pregnancy so far, or not?"
lab var m1_814e "814e. Did you experience a lot of difficulty breathing even when you are resting in your pregnancy so far, or not?"
lab var m1_814f "814f. Did you experience convulsions or seizures in your pregnancy so far, or not?"
lab var m1_814g "814g. Did you experience repeated fainting or loss of consciousness in your pregnancy so far, or not?"
lab var m1_814h "814h. Did you experience noticing that the baby has completely stopped moving in your pregnancy so far, or not?"
lab var m1_815_0 "815: During the visit today, what did the provider tell you to do regarding the [symptom(s) experienced in 814a-814h]?"
lab var m1_815_1 "815. Nothing, we did not discuss this"
lab var m1_815_2 "815. They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815_3 "815. They provided a treatment in the visit"
lab var m1_815_4 "815. They prescribed a medication"
lab var m1_815_5 "815. They told you to come back to this health facility"
lab var m1_815_6 "815. They told you to go somewhere else for higher level care"
lab var m1_815_7 "815. They told you to wait and see"
lab var m1_815_96 "815. Other (specify)"
lab var m1_815_98 "815. Don't know"
lab var m1_815_99 "815. NR/RF"
lab var m1_815_other "815_Other. Specify other advice from provider"
lab var m1_901 "901. How often do you currently smoke cigarettes or use any other type of tobacco? Is it every day, some days, or not at all?"
lab var m1_902 "902. During the visit today, did the health provider advise you to stop smoking or using tobacco products?"
lab var m1_903 "903. How often do you chew 'Miraa'? Is it every day, some days, or not at all?"
lab var m1_904 "904. During the visit today, did the health provider advise you to stop chewing 'Miraa'?"
lab var m1_905 "905. Have you consumed an alcoholic drink (i.e., Tela, Tej, Areke, Bira, Wine, Borde, Whisky) within the past 30 days?"
lab var m1_906 "906. When you do drink alcohol, how many standard drinks do you consume on average?"
lab var m1_907 "907. During the visit today, did the health provider advise you to stop drinking alcohol?"
lab var m1_1001 "1001. How many pregnancies have you had, including the current pregnancy and regardless of whether you gave birth or not?"
lab var m1_1002 "1002. How many births have you had (including babies born alive or dead)?"
lab var m1_1003 "1003. In how many of those births was the baby born alive?"
lab var m1_1004 "1004. Have you ever lost a pregnancy after 20 weeks of being pregnant?"
lab var m1_1005 "1005. Have you ever had a baby that came too early, more than 3 weeks before the due date / Small baby?"
lab var m1_1006 "1006. Have you ever bled so much in a previous pregnancy or delivery that you needed to be given blood or go back to the delivery room for an operation?"
lab var m1_1007 "1007. Have you ever had cesarean section?"
lab var m1_1008 "1008. Have you ever had a delivery that lasted more than 12 hours of you pushing?"
lab var m1_1009 "1009. How many of your children are still alive?"
lab var m1_1010 "1010. Have you ever had a baby die within the first month of their life?"
lab var m1_1011a "1011a. Did you discuss about your previous pregnancies, or not?"
lab var m1_1011b "1011b. Did you discuss about that you lost a baby after 5 months of pregnancy, or not?"
lab var m1_1011c "1011c. Did you discuss about that you had a baby who was born dead before, or not?"
lab var m1_1011d "1011d. Did you discuss about that you had a baby born early before, or not?"
lab var m1_1011e "1011e. Did you discuss about that you had a c-section before, or not?"
lab var m1_1011f "1011f. Did you discuss about that you had a baby die within their first month of life?"
lab var m1_1101 "1101. At any point during your current pregnancy, has anyone ever hit, slapped, kicked, or done anything else to hurt you physically?"
lab var m1_1102 "1102: Who has done these things to you while you were pregnant?"
lab var m1_1102_1 "1102. Current husband / partner"
lab var m1_1102_2 "1102. Parent (mother, father, step-parent, in-law)"
lab var m1_1102_3 "1102. Sibling"
lab var m1_1102_4 "1102. Child"
lab var m1_1102_5 "1102. Late /last / ex-husband/partner"
lab var m1_1102_6 "1102. Other relative"
lab var m1_1102_7 "1102. Friend/acquaintance"
lab var m1_1102_8 "1102. Teacher"
lab var m1_1102_9 "1102. Employer"
lab var m1_1102_10 "1102. Stranger"
lab var m1_1102_96 "1102. Other (specify)"
lab var m1_1102_98 "1102. Don't know "
lab var m1_1102_99 "1102. NR/RF"
lab var m1_1102_other "1102_Other. Specify other person"
lab var m1_1103 "1103. At any point during your current pregnancy, has anyone ever said or done something to humiliate you, insulted you or made you feel bad about yourself?"
lab var m1_1104 "1104: Who has done these things to you while you were pregnant?"
lab var m1_1104_1 "1104. Current husband / partner"
lab var m1_1104_2 "1104. Parent (mother, father, step-parent, in-law)"
lab var m1_1104_3 "1104. Sibling"
lab var m1_1104_4 "1104. Child"
lab var m1_1104_5 "1104. Late /last / ex-husband/partner"
lab var m1_1104_6 "1104. Other relative"
lab var m1_1104_7 "1104. Friend/acquaintance"
lab var m1_1104_8 "1104. Teacher"
lab var m1_1104_9 "1104. Employer"
lab var m1_1104_10 "1104. Stranger"
lab var m1_1104_96 "1104. Other (specify)"
lab var m1_1104_98 "1104. Don't know"
lab var m1_1104_99 "1104. NR/RF"
lab var m1_1104_other "1104_Other. Specify others who humiliates you"
lab var m1_1105 "1105. During the visit today, did the health provider discuss with you where you can seek support for these things?"
lab var m1_1201 "1201. What is the main source of drinking water for members of your household?"
lab var m1_1201_other "1201_Other. Specify other source of drink water"
lab var m1_1202 "1202. What kind of toilet facilities does your household have?"
*lab var m1_1202_other "1202_Other. Specify other kind of toilet facility"
lab var m1_1203 "1203. Does your household have electricity?"
lab var m1_1204 "1204. Does your household have a radio?"
lab var m1_1205 "1205. Does your household have a television?"
lab var m1_1206 "1206. Does your household have a telephone or a mobile phone?"
lab var m1_1207 "1207. Does your household have a refrigerator?"
lab var m1_1208 "1208. What type of fuel does your household mainly use for cooking?"
lab var m1_1208_other "1208_Other. Specify other fuel type for cooking"
lab var m1_1209 "1209. What is the main material of your floor?"
*lab var m1_1209_other "1209_Other. Specify other fuel type for cooking"
lab var m1_1210 "1210. What is the main material your walls are made of?"
lab var m1_1210_other "1210_Other. Specify other fuel type for cooking"
lab var m1_1211 "1211. What is the main material your roof is made of?"
lab var m1_1211_other "1211_Other. Specify other fuel type for cooking"
lab var m1_1212 "1212. Does any member of your household own a bicycle?"
lab var m1_1213 "1213. Does any member of your household own a motorcycle or motor scooter?" 
lab var m1_1214 "1214. Does any member of your household own a car or truck?"
lab var m1_1215 "1215. Does any member of your household have a bank account?"
lab var m1_1216b "1216: How many meals does your household usually have per day?"
lab var m1_1217 "1217. Did you pay money out of your pocket for this visit, including for the consultation or other indirect costs like your transport to the facility?"
*lab var m1_clinic_cost_ke "1218. KE only: Total clinic costs"
lab var m1_1218_ke "1218. KE only: How much (in Ksh.) in total did you spend at the clinic?"
lab var m1_1218a_1 "1218a. How much money did you spend on Registration / Consultation?"
lab var m1_1218b_1 "1218b. How much money do you spent for medicine/vaccines (including outside purchase)"
lab var m1_1218c_1 "1218c. How much money have you spent on Test/investigations (x-ray, lab etc.)?"
lab var m1_1218d_1 "1218d. How much money have you spent for transport (round trip) including that of person accompanying you?"
lab var m1_1218e_1 "1218e. How much money have you spent on food and accommodation including that of the person accompanying you?"
lab var m1_1218f "1218f. Are there any other costs that you incurred during your visit?"
lab var m1_1218f_1 "1218f. How much were these other costs?"
lab var m1_1218f_other "1218f_Other. What are those other costs that you incurred?"
lab var m1_1218_total_ke "1218g. Total Spent"
lab var m1_1219 "1219. Total amount spent"
lab var m1_1220 "1220: Which of the following financial sources did your household use to pay for this?"
lab var m1_1220_other "1220_Other. Specify other financial source for household use to pay for this"
lab var m1_1221 "1221. Are you covered with a health insurance?"
lab var m1_1222 "1222. What type of health insurance coverage do you have?"
lab var m1_1222_other "1222_Other. Specify other health insurance coverage used."
lab var m1_1223 "1223. To conclude this survey, overall, please tell me how satisfied you are with the health services you received at this establishment today?"
lab var height_cm "Height in centimeters"
lab var weight_kg "Weight in kilograms"
lab var bp_time_1_systolic "Time 1 (Systolic)"
lab var bp_time_1_diastolic "Time 1 (Diastolic)"
lab var time_1_pulse_rate "Time 1 (Pulse Rate)"
lab var bp_time_2_systolic "Time 2 (Systolic)"
lab var bp_time_2_diastolic "Time 2 (Diastolic)"
lab var time_2_pulse_rate "Time 2 (Heart Rate)"
lab var bp_time_3_systolic "Time 3 (Systolic)"
lab var bp_time_3_diastolic "Time 3 (Diastolic)"
lab var pulse_rate_time_3 "Time 3 (Heart Rate)"
lab var m1_1306 "1306. Hemoglobin level available in maternal health card"
lab var m1_1307 "1307. HEMOGLOBIN LEVEL FROM MATERNAL HEALTH CARD "
lab var m1_1308 "1308. Will you take the anemia test?"
lab var m1_1309 "1309. HEMOGLOBIN LEVEL FROM TEST PERFORMED BY DATA COLLECTOR"
lab var m1_1401 "1401. What period of the day is most convenient for you to answer the phone survey?"
lab var m1_1401a_ke "1401a. KE only: Which phone number should we call you on?"
lab var m1_1401b_ke "1401a. KE only: Is this the preferred phone number that we should call you on?"
lab var m1_1401_1 "1401. KE only: Morning"
lab var m1_1401_2 "1401. KE only: Midday"
lab var m1_1401_3 "1401. KE only: Afternoon"
lab var m1_1401_4 "1401. KE only: Evening"
lab var m1_1402_ke "1402. KE only: Is there a specific day in the week that you do not want to be called?"
lab var m1_1402_0_ke "1402. KE only: None"
lab var m1_1402_1_ke "1402. KE only: Monday"
lab var m1_1402_2_ke "1402. KE only: Tuesday"
lab var m1_1402_3_ke "1402. KE only: Wednesday"
lab var m1_1402_4_ke "1402. KE only: Thursday"
lab var m1_1402_5_ke "1402. KE only: Friday"
lab var m1_1402_6_ke "1402. KE only: Saturday"
lab var m1_1402_7_ke "1402. KE only: Sunday"
lab var m1_bp_count_ke "KE only: Blood pressure count"
lab var m1_end_comment_ke "KE only: Enumerator: Add any comments you may have on the survey that affect data quality. Leave empty if no comments."
lab var m1_end_time "Endtime"
lab var m1_1218_other_total_ke "Transport, Food and other costs"
lab var interview_length "Interview length"
lab var gest_age_baseline_ke "KE only: Calculated gestational age"
lab var edd_chart_ke "KE only: Data collector: Check from the chart, is the expected delivery date recorded?"
lab var edd "KE only: Check from the chart, what is the expected delivery date recorded?"
/*
lab var pref_language_ke "KE only: In which language(s) do you feel most comfortable for the follow-up interviews?"
lab var pref_language_1_ke "KE only: English"
lab var pref_language_2_ke "KE only: Kiswahili"
lab var pref_language_3_ke "KE only: Kikuyu"
lab var pref_language_4_ke "KE only: Kamba"
lab var pref_language_96_ke "KE only: Other (specify)"
lab var pref_language_other_ke "KE only: Specify other preferred language"

*/

	** MODULE 2 (EDIT FOR KE!!):
	label variable m2_start "IIC. May I proceed with the interview?"
label variable m2_103 "102. Date of interview (D-M-Y)"
label variable m2_permission "CR1. Permission granted to conduct call"
label variable m2_date "102. Date of interview (D-M-Y)"
label variable m2_time_start "103A. Time of interview started"
label variable m2_maternal_death_reported "108. Maternal death reported"
label variable m2_ga "107a. Gestational age at this call based on LNMP (in weeks)"
*label variable m2_ga_estimate "107b. Gestational age based on maternal estimation (in weeks)"
label variable m2_hiv_status "109. HIV status"
label variable m2_date_of_maternal_death "110. Date of maternal death (D-M-Y)"
label variable m2_maternal_death_learn "111. How did you learn about the maternal death?"
label variable m2_maternal_death_learn_other "111-Oth. Specify other way of learning maternal death"
label variable m2_201 "201. I would like to start by asking about your health and how you have been feeling since you last spoke to us. In general, how would you rate your overall health?"
label variable m2_202 "202. As you know, this survey is about health care that women receive during pregnancy, delivery and after birth. So that I know that I am asking the right questions, I need to confirm whether you are still pregnant?"
label variable m2_date_of_maternal_death_2 "110. Date of maternal death (D-M-Y)"
label variable m2_203a "203a. Since you last spoke to us, have you experienced severe or persistent headaches?"
label variable m2_203b "203b. Since you last spoke to us, have you experienced vaginal bleeding of any amount?"
label variable m2_203c "203c. Since you last spoke to us, have you experienced fever?"
label variable m2_203d "203d. Since you last spoke to us, have you experiencedsevere abdominal pain, not just discomfort?"
label variable m2_203e "203e. Since you last spoke to us, have you experienced a lot of difficult breathing?"
label variable m2_203f "203f. Since you last spoke to us, have you experienced convulsions or seizures?"
label variable m2_203g "203g. Since you last spoke to us, have you experienced fainting or loss of consciousness?"
label variable m2_203h "203h. Since you last spoke to us, have you experienced that the baby has completely stopped moving?"
label variable m2_203i "203i. Since you last spoke to us, have you experienced blurring of vision?"
label variable m2_204a "204a. Since you last spoke to us, have you experienced Preeclapsia/eclampsia?"
label variable m2_204b "204b. Since you last spoke to us, have you experienced Bleeding during pregnancy?"
label variable m2_204c "204c. Since you last spoke to us, have you experienced Hyperemesis gravidarum?"
label variable m2_204d "204d. Since you last spoke to us, have you experienced Anemia?"
label variable m2_204e "204e. Since you last spoke to us, have you experienced Cardiac problem?"
label variable m2_204f "204f. Since you last spoke to us, have you experienced Amniotic fluid volume problems(Oligohydramnios/ Polyhadramnios)?"
label variable m2_204g "204g. Since you last spoke to us, have you experienced Asthma?"
label variable m2_204h "204h. Since you last spoke to us, have you experienced RH isoimmunization?"
label variable m2_204i "204i. Since you last spoke to us, have you experienced any other major health problems?"
label variable m2_204i_other "204i-oth. Specify any other feeling since last visit"
label variable m2_205a "205a. Over the past 2 weeks, on how many days have you been bothered by little interest or pleasure in doing things?"
label variable m2_205b "205b. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless?"
label variable m2_205c "205c. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
label variable m2_205d "205d. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy?"
label variable m2_205e "205e. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating?"
label variable m2_205f "205f. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down?"
label variable m2_205g "205g. Over the past 2 weeks, on how many days have you been bothered by trouble concentrating on things, such as your work or home duties?"
label variable m2_205h "205h. Over the past 2 weeks, on how many days have you been bothered by moving or speaking so slowly that other people could have noticed? Or so fidgety or restless that you have been moving a lot more than usual?"
label variable m2_205i "205i. Over the past 2 weeks, on how many days have you been bothered by Thoughts that you would be better off dead, or thoughts of hurting yourself in some way?"
label variable m2_206 "206. How often do you currently smoke cigarettes or use any other type of tobacco? Types of tobacco includes: Snuff tobacco, Chewing tobacco,  Cigar"
label variable m2_207 "207. How often do you currently chewing khat?(Interviewer: Inform that Khat is a leaf green plant use as stimulant and chewed in Ethiopia)"
label variable m2_208 "208. How often do you currently drink alcohol or use any other type of alcoholic?   A standard drink is any drink containing about 10g of alcohol, 1 standard drink= 1 tasa or wancha of (tella or korefe or borde or shameta), ½ birile of  Tej, 1 melekiya of Areke, 1 bottle of beer, 1 single of draft, 1 melkiya of spris(Uzo, Gine, Biheraw etc) and 1 melekiya of Apratives"
label variable m2_301 "301. Since we last spoke, did you have any new healthcare consultations for yourself, or not?"
label variable m2_302 "302. Since we last spoke, how many new healthcare consultations have you had for yourself?"
label variable m2_303a "303a. Where did this/this new first healthcare consultation(s) for yourself take place?"
label variable m2_303b "303b.  Where did the 2nd healthcare consultation(s) for yourself take place?"
label variable m2_303c "303c. Where did the 3rd healthcare consultation(s) for yourself take place?"
label variable m2_303d "303d. Where did the 4th healthcare consultation(s) for yourself take place?"
label variable m2_303e "303e. Where did the 5th healthcare consultation(s) for yourself take place?"
label variable m2_304a "304a. What is the name of the facility where this/this first healthcare consultation took place?"
label variable m2_304a_other "304a-oth. Other facility for 1st health consultation"
label variable m2_304b "304b. What is the name of the facility where this/this second healthcare consultation took place?"
label variable m2_304b_other "304b-oth. Other facility for 2nd health consultation"
label variable m2_304c "304c. What is the name of the facility where this/this third healthcare consultation took place?"
label variable m2_304c_other "304c-oth. Other facility for 3rd health consultation"
label variable m2_304d "304d. What is the name of the facility where this/this fourth healthcare consultation took place?"
label variable m2_304d_other "304d-oth. Other facility for 4th health consultation"
label variable m2_304e "304e. What is the name of the facility where this/this fifth healthcare consultation took place?"
label variable m2_304e_other "304e-oth. Other facility for 5th health consultation"
label variable m2_305 "305. Was the first consultation for a routine antenatal care visit?"
label variable m2_306 "306. Was the first consultation for a referral from your antenatal care provider?"
label variable m2_306_1 "307. Was the first consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_306_2 "307. Was the first consultation for any of the following? An existing health problem"
label variable m2_306_3 "307. Was the first consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_306_4 "307. Was the first consultation for any of the following? To pick up medicine"
label variable m2_306_5 "307. Was the first consultation for any of the following? To get a vaccine"
label variable m2_306_96 "307. Was the first consultation for any of the following? Other reasons"
label variable m2_306_888_et "307. No information"
label variable m2_306_998_et "307. Unknown"
label variable m2_306_999_et "307. Refuse to answer"
label variable m2_307_other "307-oth. Specify other reason for the 1st visit"
label variable m2_308 "308. Was the second consultation is for a routine antenatal care visit?"
label variable m2_309 "309. Was the second consultation is for a referral from your antenatal care provider?"
label variable m2_308_1 "310. Was the second consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_308_2 "310. Was the second consultation for any of the following? An existing health problem"
label variable m2_308_3 "310. Was the second consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_308_4 "310. Was the second consultation for any of the following? To pick up medicine"
label variable m2_308_5 "310. Was the second consultation for any of the following? To get a vaccine"
label variable m2_308_96 "310. Was the second consultation for any of the following? Other reasons"
label variable m2_308_888_et "310. No information"
label variable m2_308_998_et "310. Unknown"
label variable m2_308_999_et "310. Refuse to answer"
label variable m2_310_other "310-oth. Specify other reason for second consultation"
label variable m2_311 "311. Was the third consultation is for a routine antenatal care visit?"
label variable m2_312 "312. Was the third consultation is for a referral from your antenatal care provider?"
label variable m2_311_1 "313. Was the third consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_311_2 "313. Was the third consultation for any of the following? An existing health problem"
label variable m2_311_3 "313. Was the third consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_311_4 "313. Was the third consultation for any of the following? To pick up medicine"
label variable m2_311_5 "313. Was the third consultation for any of the following? To get a vaccine"
label variable m2_311_96 "313. Was the third onsultation for any of the following? Other reasons"
label variable m2_311_888_et "313. No information"
label variable m2_311_998_et "313. Unknown"
label variable m2_311_999_et "313. Refuse to answer"
label variable m2_313_other "313-oth. Specify any other reason for the third consultation"
label variable m2_314 "314. Was the fourth consultation is for a routine antenatal care visit?"
label variable m2_315 "315. Was the fourth consultation is for a referral from your antenatal care provider?"
label variable m2_314_1 "316. Was the fourth consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_314_2 "316. Was the fourth consultation for any of the following? An existing health problem"
label variable m2_314_3 "316. Was the fourth consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_314_4 "316. Was the fourth consultation for any of the following? To pick up medicine"
label variable m2_314_5 "316. Was the fourth consultation for any of the following? To get a vaccine"
label variable m2_314_96 "316. Was the fourth onsultation for any of the following? Other reasons"
label variable m2_314_888_et "316. No information"
label variable m2_314_998_et "316. Unknown"
label variable m2_314_999_et "316. Refuse to answer"
label variable m2_316_other "316-oth. Specify other reason for the fourth consultation"
label variable m2_317 "317. Was the fifth consultation is for a routine antenatal care visit?"
label variable m2_318 "318. Was the fifth consultation is for a referral from your antenatal care provider?"
label variable m2_317_1 "319. Was the fifth consultation is for any of the following? A new health problem, including an emergency or an injury"
label variable m2_317_2 "319. Was the fifth consultation is for any of the following? An existing health problem"
label variable m2_317_3 "319. Was the fifth consultation is for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_317_4 "319. Was the fifth consultation is for any of the following? To pick up medicine"
label variable m2_317_5 "319. Was the fifth consultation is for any of the following? To get a vaccine"
label variable m2_317_96 "319. Was the fifth consultation is for any of the following? Other reasons"
label variable m2_317_888_et "319. No information"
label variable m2_317_998_et "319. Unknown"
label variable m2_317_999_et "319. Refuse to answer"
label variable m2_319_other "319-oth. Specify other reason for the fifth consultation"
label variable m2_320_0 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? No reason or you didn't need it"
label variable m2_320_1 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? You tried but were sent away (e.g., no appointment available) "
label variable m2_320_2 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? High cost (e.g., high out of pocket payment, not covered by insurance)"
label variable m2_320_3 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Far distance (e.g., too far to walk or drive, transport not readily available)"
label variable m2_320_4 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Long waiting time (e.g., long line to access facility, long wait for the provider)"
label variable m2_320_5 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
label variable m2_320_6 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Staff don't show respect (e.g., staff is rude, impolite, dismissive)"
label variable m2_320_7 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
label variable m2_320_8 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) "
label variable m2_320_9 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 fear"
label variable m2_320_10 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Don't know where to go/too complicated"
label variable m2_320_11 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Fear of discovering serious problem"
label variable m2_320_96 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Other, specify"
label variable m2_320_99 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Refused"
label variable m2_320_888_et "320. No information"
label variable m2_320_998_et "320. Unknown"
label variable m2_320_999_et "320. Refuse to answer"
label variable m2_320_other "320-oth. Specify other reason preventing receiving more antenatal care"
label variable m2_321 "321. Other than in-person visits, did you have contacted with a health care provider by phone, SMS, or web regarding your pregnancy?"
label variable m2_401 "401. Overall, how would you rate the quality of care that you received from the health facility where you took the 1st consultation?"
label variable m2_402 "402. Overall, how would you rate the quality of care that you received from the health facility where you took the 2nd consultation?"
label variable m2_403 "403. Overall, how would you rate the quality of care that you received from the health facility where you took the 3rd consultation?"
label variable m2_404 "404. Overall, how would you rate the quality of care that you received from the health facility where you took the 4th consultation?"
label variable m2_405 "405. Overall, how would you rate the quality of care that you received from the health facility where you took the 5th consultation?"
label variable m2_501a "501a. Since you last spoke to us, did you get your blood pressure measured (with a cuff around your arm)?"
label variable m2_501b "501b. Since you last spoke to us, did you get your weight taken (using a scale)?"
label variable m2_501c "501c.  Since you last spoke to us, did you get a blood draw (that is, taking blood from your arm with a syringe)?"
label variable m2_501d "501d.  Since you last spoke to us, did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
label variable m2_501e "501e.  Since you last spoke to us, did you get a urine test (that is, where you peed in a container)?"
label variable m2_501f "501f. Since you last spoke to us, did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
label variable m2_501g "501g.  Since you last spoke to us, did you get any other tests?"
label variable m2_501g_other "501g-oth. Specify any other test you took since you last spoke to us"
label variable m2_502 "502. Since we last spoke, did you receive any new test results from a health care provider?   By that I mean, any result from a blood or urine sample or from blood pressure measurement.Do not include any results that were given to you during your first antenatal care visit or during the first survey, only new ones."
label variable m2_503a "503a. Remember that this information will remain confidential. Did you receive a result for Anemia?"
label variable m2_503b "503b. Remember that this information will remain confidential. Did you receive a result for HIV?"
label variable m2_503c "503c. Remember that this information will remain confidential. Did you receive a result for HIV viral load?"
label variable m2_503d "503d. Remember that this information will remain confidential. Did you receive a result for Syphilis?"
label variable m2_503e "503e. Remember that this information will remain confidential. Did you receive a result for diabetes?"
label variable m2_503f "503f. Remember that this information will remain confidential. Did you receive a result for Hypertension?"
label variable m2_504 "504. Did you receive any other new test results?"
label variable m2_504_other "504-oth. Specify other test result you receive"
label variable m2_505a "505a. What was the result of the test for anemia? Remember that this information will remain fully confidential."
label variable m2_505b "505b. What was the result of the test for HIV? Remember that this information will remain fully confidential."
label variable m2_505c "505c. What was the result of the test for HIV viral load? Remember that this information will remain fully confidential."
label variable m2_505d "505d. What was the result of the test for syphilis? Remember that this information will remain fully confidential."
label variable m2_505e "505e. What was the result of the test for diabetes? Remember that this information will remain fully confidential."
label variable m2_505f "505f. What was the result of the test for hypertension? Remember that this information will remain fully confidential."
label variable m2_505g "505g. What was the result of the test for other tests? Remember that this information will remain fully confidential."
label variable m2_506a "506a. Since you last spoke to us, did you and a healthcare provider discuss about the signs of pregnancy complications that would require you to go to the health facility?"
label variable m2_506b "506b. Since you last spoke to us, did you and a healthcare provider discuss about your birth plan that is, where you will deliver, how you will get there, and how you need to prepare, or didnt you?"
label variable m2_506c "506c. Since you last spoke to us, did you and a healthcare provider discuss about care for the newborn when he or she is born such as warmth, hygiene, breastfeeding, or the importance of postnatal care?"
label variable m2_506d "506d. Since you last spoke to us, did you and a healthcare provider discuss about family planning options for after delivery?"
label variable m2_507 "507. What did the health care provider tell you to do regarding these new symptoms?"
label variable m2_508a "508a. Since we last spoke, did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves."
label variable m2_508b_number "508b. Do you know the number of psychological counseling or therapy session you had?"
label variable m2_508b_last "508b. How many of these sessions did you have since you last spoke to us?"
label variable m2_508c "508c. Do you know how long this/these visits took?"
label variable m2_508d "508d. How many minutes did this/these visit(s) last on average?"
label variable m2_509a "509a.  Since we last spoke, did a healthcare provider tells you that you needed to go see a specialist like an obstetrician or a gynecologist?"
label variable m2_509b "509b. Since we last spoke, did a healthcare provider tells you that you needed to go to the hospital for follow-up antenatal care?"
label variable m2_509c "509c. Since we last spoke, did a healthcare provider tell you that you will need a C-section?"
label variable m2_601a "601a. Did you get Iron or folic acid pills?"
label variable m2_601b "601b. Did you get Calcium pills?"
label variable m2_601c "601c. Did you get Multivitamins?"
label variable m2_601d "601d. Did you get Food supplements like Super Cereal or Plumpynut?"
label variable m2_601e "601e. Did you get medicine for intestinal worm?"
label variable m2_601f "601f. Did you get medicine for malaria?"
label variable m2_601g "601g. Did you get Medicine for HIV?"
label variable m2_601h "601h. Did you get Medicine for your emotions, nerves, depression, or mental health?"
label variable m2_601i "601i. Did you get Medicine for hypertension?"
label variable m2_601j "601j. Did you get Medicine for diabetes, including injections of insulin?"
label variable m2_601k "601k. Did you get Antibiotics for an infection?"
label variable m2_601l "601l. Did you get Aspirin?"
label variable m2_601m "601m. Did you get Paracetamol, or other pain relief drugs?"
label variable m2_601n "601n. Did you get Any other medicine or supplement?"
label variable m2_601n_other "601n-oth. Specify other medicine or supplement you took"
label variable m2_602a "602a. Do you know how much in total you pay for this new medication?"
label variable m2_602b "602b. In total, how much did you pay for these new medications or supplements (ETB)?"
label variable m2_603 "603. Are you currently taking iron and folic acid pills, or not?"
label variable m2_604 "604. How often do you take iron and folic acid pills?"
label variable m2_701 "701. I would now like to ask about the cost of these new health care visits.  Did you pay any money out of your pocket for these new visits, including for the consultation or other indirect costs like your transport to the facility?  Do not include the cost of medicines that you have already told me about."
label variable m2_702a "702a. Did you spend money on Registration/Consultation?"
label variable m2_702a_other "702a-oth. How much money did you spend on Registration/Consultation?"
label variable m2_702b "702b. Did you spend money on Test or investigations (lab tests, ultrasound etc.?"
label variable m2_702b_other "702b-oth. How much money did you spend on Test or investigations (lab tests, ultrasound etc.)"
label variable m2_702c "702c. Did you spend money on Transport (round trip) including that of the person accompanying you?"
label variable m2_702c_other "702c-oth. How much money did you spend on Transport (round trip) including that of the person accompanying you?"
label variable m2_702d "702d. Did you spend money on Food and accommodation including that of person accompanying you?"
label variable m2_702d_other "702d-oth. How much money did you spend on Food and accommodation including that of person accompanying you?"
label variable m2_702e "702e. Did you spend money for other services?"
label variable m2_702e_other "702e-oth. How much money did you spend on other item/service?"
label variable m2_703 "703. So, in total you spent"
label variable m2_704 "704. Is the total cost correct?"
label variable m2_704_other "704-oth. So how much in total would you say you spent?"
label variable m2_705_1 "705. Which of the following financial sources did your household use to pay for this? Current income of any household members"
label variable m2_705_2 "705. Which of the following financial sources did your household use to pay for this? Savings (e.g., bank account)"
label variable m2_705_3 "705. Which of the following financial sources did your household use to pay for this? Payment or reimbursement from a health insurance plan"
label variable m2_705_4 "705. Which of the following financial sources did your household use to pay for this? Sold items (e.g., furniture, animals, jewellery, furniture)"
label variable m2_705_5 "705. Which of the following financial sources did your household use to pay for this? Family members or friends from outside the household"
label variable m2_705_6 "705. Which of the following financial sources did your household use to pay for this? Borrowed (from someone other than a friend or family)"
label variable m2_705_96 "705. Which of the following financial sources did your household use to pay for this? Other (please specify)"
label variable m2_705_888_et "705. No information"
label variable m2_705_998_et "705. Unknown"
label variable m2_705_999_et "705. Refuse to answer"
label variable m2_705_other "705-oth. Please specify"
label variable m2_interview_inturrupt "Is the interview inturrupted?"
label variable m2_interupt_time "At what time it is interrupted?"
label variable m2_interview_restarted "Is the interview restarted?"
label variable m2_restart_time "At what time it is restarted?"
label variable m2_endtime "103B. Time of Interview end"
label variable m2_int_duration "103C. Total Duration of interview (In minutes)"
label variable m2_endstatus "What is this womens current status at the end of the interview?"

	
	** MODULE 3:

lab var m3_start_p1 "M3-IIC. May I proceed with the interview?"
lab var m3_date "M3-102. Date of interview (D-M-Y)"
lab var m3_date_confirm "M3-102-confirm. Confirm date of interview" 
lab var m3_start_time "M3-102-time. Time of interview started"
lab var m3_date_time "M3-102-date-time. Time of interview started and date of interview"
lab var m3_birth_or_ended "M3-201a. On what date did you give birth or did the pregnancy end?"
lab var m3_birth_or_ended_provided "M3-201a-YN. Did the respondent provide the date?"
lab var m3_birth_or_ended_date "M3-201a-date. Date of giving birth or pregnancy ended calculation."
lab var m3_ga_final "M3-201d. Gestational age at delivery (final)"

lab var m3_303a "M3-301. If its ok with you, I would like to now ask some questions about the baby or babies. How many babies were you pregnant with?"
lab var m3_303b "M3-303a. Is the 1st baby alive?"
lab var m3_303c "M3-303b. Is the 2nd baby alive?"
lab var m3_baby1_name "M3-304a. What is the 1st babys name?"
lab var m3_baby2_name "M3-304b. What is the 2nd babys name?"
lab var m3_baby1_gender "M3-305a. What is 1st baby's's gender?"
lab var m3_baby2_gender "M3-305b. what is the second baby's gender?"
lab var m3_baby1_age_weeks "M3-306a. How old is the 1st baby in weeks?" 
lab var m3_baby2_age_weeks "M3-306b. How old is the second baby in weeks"
lab var m3_baby1_weight "M3-307a. How much did the 1st baby weigh at birth?"
lab var m3_baby2_weight "M3-307b.How much did the second baby weigh at birth?"
lab var m3_baby1_size "M3-308a. When the 1st baby was born, were they: very large, larger than average, average, smaller than average or very small?"
lab var m3_baby2_size "M3-308b. When the second baby was born, were they: very large, larger than average, average, smaller than average or very small?"
lab var m3_baby1_health "M3-309a. In general, how would you rate the 1st baby's overall health?"
lab var m3_baby2_health "M3-309b. In general, how would you rate the second baby's overall health?"

lab var m3_baby1_feed_a "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Breast milk)"
lab var m3_baby1_feed_b "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Formula/Cow milk)"
lab var m3_baby1_feed_c "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Water)"
lab var m3_baby1_feed_d "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Juice)"
lab var m3_baby1_feed_e "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Broth)"
lab var m3_baby1_feed_f "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Baby food)"
lab var m3_baby1_feed_g "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Local food)"
lab var m3_baby1_feed_h "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Fresh milk)"
lab var m3_baby1_feed_99 "M3-310a-1. Please indicate how you have fed the 1st baby in the last 7 days? (choice=NR/RF)"
lab var m3_baby2_feed_a "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Breast milk)"
lab var m3_baby2_feed_b "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Formula/Cow milk)"
lab var m3_baby2_feed_c "M3-310a-2. Please indicate how you have fed the 2nd aby in the last 7 days? (choice=Water)"
lab var m3_baby2_feed_d "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Juice)"
lab var m3_baby2_feed_e "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Broth)"
lab var m3_baby2_feed_f "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Baby food)"
lab var m3_baby2_feed_g "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Local food)"
lab var m3_baby2_feed_h "M3-310a-2. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Fresh milk)"
lab var m3_baby2_feed_99 "M3-310a-2. Please indicate how you have fed the second baby in the last 7 days? (choice=NR/RF)"
lab var m3_breastfeeding "M3-310b. As of today, how confident do you feel about breastfeeding your 1st baby?"
lab var m3_breastfeeding_2 "M3-310b. As of today, how confident do you feel about breastfeeding your second baby?"

lab var m3_baby1_born_alive1 "M3-312-1.I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it's okay with you, I would like to ask a few more questions about the baby. Was the 1st baby born alive?"
lab var m3_baby1_born_alive2 "M3-312a-1.Did the 1st baby cry, make any movement, sound, or effort to breathe, or show any other signs of life even if for a very short time?"
lab var m3_baby2_born_alive1 "M3-312-2.I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it's okay with you, I would like to ask a few more questions about the baby. Was the 2nd baby born alive?"
lab var m3_baby2_born_alive2 "M3-312a-2.Did the 2nd baby cry, make any movement, sound, or effort to breathe, or show any other signs of life even if for a very short time?"
lab var m3_313a_baby1 "M3-313a-1. On what day did the 1st baby baby die (i.e. the date of death)?"
lab var m3_313c_baby1 "M3-313c-1. After how many days or hours did the baby die?"   
lab var m3_313d_baby1 "M3-313d-1. The unit of time."
lab var m3_313a_baby2 "M3-313a-2. On what day did the second baby baby die (i.e. the date of death)?"
lab var m3_313c_baby2 "M3-313c-2. After how many days or hours did the second baby die?"   
lab var m3_313d_baby2 "M3-313d-2. The unit of time."
lab var m3_death_cause_baby1 "M3-314-1. What were you told was the cause of death for the 1st baby, or were you not told?"
lab var m3_death_cause_baby1_other "M3-314-oth-1. Specify the cause of death for the 1st baby"		
lab var m3_death_cause_baby2 "M3-314-2. What were you told was the cause of death for the second baby, or were you not told?"
lab var m3_death_cause_baby2_other "M3-314-oth-2. Specify the cause of death for the second baby"

lab var m3_401 "M3-401. Before we talk about the delivery, I would like to ask about any additional health care you may have received since you last spoke to us and BEFORE the delivery. We are interested in ALL NEW healthcare consultations that you may have had for yourself between the time of the last survey and the delivery. Since you last spoke to us, did you have any new healthcare consultations for yourself before the delivery?"
lab var m3_402 "M3-402. How many new healthcare consultations did you have?"

lab var m3_consultation_1 "M3-403. Was the 1st consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_1 "M3-404. Was the 1st for referral from your antenatal care provider?"
lab var m3_consultation1_reason_a "M3-405. Was the 1st visit for any of the following? (choice=A new health problem, including an emergency or an injury)"
lab var m3_consultation1_reason_b "M3-405. Was the 1st visit for any of the following? (choice=An existing health problem)"
lab var m3_consultation1_reason_c "M3-405. Was the 1st visit for any of the following? (choice=A lab test, x-ray, or ultrasound)"
lab var m3_consultation1_reason_d "M3-405. Was the 1st visit for any of the following? (choice=To pick up medicine)"
lab var m3_consultation1_reason_e "M3-405. Was the 1st visit for any of the following? (choice=To get a vaccine)"
lab var m3_consultation1_reason_96 "M3-405. Was the 1st visit for any of the following? (choice=Other reasons, please specify)"
lab var m3_consultation1_reason_other "M3-405-oth. Other reasons, please specify"

lab var m3_consultation_2 "M3-406. Was the 2nd consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_2 "M3-407. Was the 2nd for referral from your antenatal care provider?"
lab var m3_consultation2_reason "M3-408. Was the 2nd visit for any of the following?"
lab var m3_consultation2_reason_a "M3-408. Was the 2nd visit for any of the following? (choice=A new health problem, including an emergency or an injury)"
lab var m3_consultation2_reason_b "M3-408. Was the 2nd visit for any of the following? (choice=An existing health problem)"
lab var m3_consultation2_reason_c "M3-408. Was the 2nd visit for any of the following? (choice=A lab test, x-ray, or ultrasound)"
lab var m3_consultation2_reason_d "M3-408. Was the 2nd visit for any of the following? (choice=To pick up medicine)"
lab var m3_consultation2_reason_e "M3-408. Was the 2nd visit for any of the following? (choice=To get a vaccine)"
lab var m3_consultation2_reason_96 "M3-408. Was the 2nd visit for any of the following? (choice=Other reasons, please specify)"
lab var m3_consultation2_reason_other "M3-408-oth. Other reasons, please specify"
		
lab var m3_consultation_3 "M3-409. Was the 3rd consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_3 "M3-410. Was the 3rd for referral from your antenatal care provider?"
lab var m3_consultation3_reason "M3-408. Was the 3rd visit for any of the following?"
lab var m3_consultation3_reason_a "M3-411. Was the 3rd visit for any of the following? (choice=A new health problem, including an emergency or an injury)"
lab var m3_consultation3_reason_b "M3-411. Was the 3rd visit for any of the following? (choice=An existing health problem)"
lab var m3_consultation3_reason_c "M3-411. Was the 3rd visit for any of the following? (choice=A lab test, x-ray, or ultrasound)"
lab var m3_consultation3_reason_d "M3-411. Was the 3rd visit for any of the following? (choice=To pick up medicine)"
lab var m3_consultation3_reason_e "M3-411. Was the 3rd visit for any of the following? (choice=To get a vaccine)"
lab var m3_consultation3_reason_96 "M3-411. Was the 3rd visit for any of the following? (choice=Other reasons, please specify)"
lab var m3_consultation3_reason_other "M3-411-oth. Other reasons, please specify"

lab var m3_412a "M3-412a. Between the time that you last spoke to us and before the delivery, did you get your blood pressure measured (with a cuff around your arm)"
lab var m3_412b "M3-412b. Between the time that you last spoke to us and before the delivery, did you get your weight taken (using a scale)?"
lab var m3_412c "M3-412c. Between the time that you last spoke to us and before the delivery, did you get a blood draw (that is, taking blood from your arm with a syringe?"
lab var m3_412d "M3-412d. Between the time that you last spoke to us and before the delivery, did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
lab var m3_412e "M3-412e. Between the time that you last spoke to us and before the delivery, did you get a urine test (that is, where you peed in a container)?"
lab var m3_412f "M3-412f. Between the time that you last spoke to us and before the delivery, did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
lab var m3_412g "M3-412g. Between the time that you last spoke to us and before the delivery, did you get any other test?"
lab var m3_412g_other "M3-412g-oth . Specify other tests you got between the time that you last spoke to us and before the delivery"
lab var m3_412i "M3-412i  Between the time that you last spoke to us and before the delivery, did you get any other test? (Choice=None)"

lab var m3_501 "M3-501. Did you deliver in a health facility?"
lab var m3_502 "M3-502. What kind of facility was it?"
lab var m3_503 "M3-503. What is the name of the facility where you delivered?"
lab var m3_504a "M3-504a. Where region was this facility located?"
lab var m3_504b "M3-504b. Where was the city/sub-city/district this facility located?"
lab var m3_504c "M3-504c. Where was the county this facility located?"
lab var m3_503_final "M3-503-final. What is the name of the facility where you delivered? (final)"
lab var m3_506_pre "M3-506-pre. Are you able to name the day and time the labor started - that is, when contractions started and did not stop, or when your water broke?"
lab var m3_506_pre_oth "M3-506-pre-oth. Other reason, specify"
lab var m3_506 "M3-506. What day and time did the labor start – that is, when contractions started and did not stop, or when your water broke?"
lab var m3_507 "M3-507. At what time did you leave for the facility?"
lab var m3_508 "M3-508. At any point during labor or delivery did you try to go to a facility?"
lab var m3_509 "M3-509. What was the main reason for giving birth at home instead of a health facility?"
lab var m3_509_other "M3-509_Oth. Specify other reasons for giving birth at home instead of a health facility"

lab var m3_513a "M3-513a. What is the name of the facility you went to 1st?"
lab var m3_513_outside_zone_other "M3-513a_97. Other outside of the zone"
lab var m3_513b2 "M3-513b2. Where city/sub-city/district was this facility located?"
lab var m3_513b3 "M3-513b3. Which county was this facility located??"
lab var m3_513_final "M3-513-final. What is the name of the facility you went to 1st? (final)"
lab var m3_514 "M3-514. At what time did you arrive at the facility you went to 1st?"
lab var m3_515 "M3-515. Why did you go to the facility you went to 1st after going to the facility you delivered at?"
lab var m3_516 "M3-516. Why did you or your family member decide to leave the facility you went to 1st and come to the facility you delivered at? Select only one main reason"
lab var m3_517 "M3-517. Did the provider inform you why they referred you?"
lab var m3_518 "M3-518. Why did the provider refer you to the facility you delivered at?"
lab var m3_518_other_complications "M3-518_96. Other delivery complications, specify"
lab var m3_518_other "M3-518_97. Other reasons, specify"
lab var m3_519 "M3-519. What was the main reason you decided that you wanted to deliver at the facility you delivered at?"
lab var m3_519_other "M3-519_Oth. Other, specify"
lab var m3_520 "M3-520. At what time did you arrive at the facility you delivered at?"
lab var m3_521_ke "M3-521-ke. Once you got to the facility, how long did you wait until a healthcare worker checked on you?"
lab var m3_521_ke_unit "M3-521-ke-unit. The unit of time."

lab var m3_601_hiv "M3-601-hiv. Once you were 1st checked by a health care provider at the facility you delivered at, did the health care provider ask about your HIV status?"
lab var m3_601b "M3-601b. Once you were 1st checked by a health care provider at the facility you delivered at, did the health care provider take your blood pressure (with a cuff around your arm)?"
lab var m3_601c "M3-601c. Once you were 1st checked by a health care provider at the facility you delivered at, did the health care provider Explain what will happen during labor?"
lab var m3_602a "M3-602a. Did the health care provider, look at your integrated maternal child health card?"
lab var m3_602b "M3-602b. Did the health care provider have information about your antenatal care (e.g. your tests results) from health facility records?"
lab var m3_603a "M3-603a. During your time in the health facility while in labor or giving birth Were you told you could walk around and move during labour?"
lab var m3_603b "M3-603b. During your time in the health facility while in labor or giving birth Were you allowed to have a birth companion present? For example, this includes your husband, a friend, sister, mother-in-law etc.?"
lab var m3_603c "M3-603c. During your time in the health facility while in labor or giving birth Did you have a needle inserted in your arm with a drip?"
lab var m3_604a "M3-604a. While you were in labor and giving birth, what were you sitting or lying on?"
lab var m3_604b "M3-604b. While you were giving birth, were curtains, partitions or other measures used to provide privacy from other people not involved in your care?"
lab var m3_605a "M3-605a. Did you have a caesarean? (That means, did they cut your belly open to take the baby out?)"
lab var m3_605b "M3-605b. When was the decision made to have the caesarean section? Was it before or after your labor pains started?"
lab var m3_605c "M3-605c. What was the reason for having a caesarean? "
lab var m3_605c_other "M3-605c-oth. Specify other reason for having a caesarean"

lab var m3_606 "M3-606. Did the provider perform a cut near your vagina to help the baby come out?"
lab var m3_607 "M3-607. Did you receive stiches near your vagina after the delivery?"		
lab var m3_608 "M3-608. Immediately after delivery: Did a health care provider give you an injection or pill to stop the bleeding?"
lab var m3_609 "M3-609. Immediately after delivery, did a health care provider dry the baby/babies with a towel?"
lab var m3_610a "M3-610a. Immediately after delivery, was/were the baby/babies put on your chest?"
lab var m3_610b "M3-610b. Immediately after delivery, was/were the babys/babies bare skin touching your bare skin?"
lab var m3_611 "M3-611. Immediately after delivery, did a health care provider help you with breastfeeding the baby/babies?"
lab var m3_612_ke "M3-612-ke. How long after the baby/babies was born did you 1st breastfeed he/she/them?"
lab var m3_612_ke_unit "M3-612-ke-unit. The unit of time for m3_612_ke."
lab var m3_613 "M3-613. I would like to talk to you about checks on your health after the delivery, for example, someone asking you questions about your health or examining you. Did anyone check on your health while you were still in the facility?"
lab var m3_614_ke "M3-614-ke. How long after delivery did the 1st check take place?"
lab var m3_614_ke_unit "M3-614-ke-unit. The unit of time for m3_614_ke"		
lab var m3_615a "M3-615a. Did anyone check on the 1st baby's health while you were still in the facility?"
lab var m3_615b "M3-615b. Did anyone check on the 2nd baby's health while you were still in the facility?"
lab var m3_616c_1 "M3-616c-1. How long after delivery was the 1st baby health 1st checked? "
lab var m3_616c_1_unit "M3-616c-1-unit. The unit of time for m3_616c_1."
lab var m3_616c_2 "M3-616c-2. How long after delivery was the second baby health 1st checked? "
lab var m3_616c_2_unit "M3-616c-1-unit. he unit of time for m3_616c_2."
lab var m3_617a "M3-617a. Did the 1st baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
lab var m3_617b "M3-617b. Did the second baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
lab var m3_618a_1 "M3-618a-1. Was the 1st baby tested for HIV after birth?" 
lab var m3_618b_1 "M3-618b-1. What was the result of the baby's HIV test?"
lab var m3_618c_1 "M3-618c-1. Was the 1st baby given medication to prevent HIV/AIDS (ARVs)?"
lab var m3_618a_2 "M3-618a-2. Was the second bay tested for HIV after birth?"
lab var m3_618b_2 "M3-618b-2. What was the result of the baby's HIV test?"
lab var m3_618c_2 "M3-618c-2. Was the second baby given medication to prevent HIV/AIDS (ARVs)?"
	
lab var m3_619a "M3-619a. Before you left the facility, did you receive advice on what the baby should eat (only breastmilk or No other foods)?"
lab var m3_619b "M3-619b. Before you left the facility, did you receive advice on care of the umbilical cord?"
lab var m3_619c "M3-619c. Before you left the facility, did you receive advice on avoid chilling of baby?"
lab var m3_619d "M3-619d. Before you left the facility, did you receive advice on when to return for vaccinations for the baby?"
lab var m3_619e "M3-619e. Before you left the facility, did you receive advice on hand washing with soap/water before touching the baby?"
lab var m3_619g "M3-619g. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in the baby that would mean you should go to a health facility?"
lab var m3_619h "M3-619h. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in yourself that would mean you should go to a health facility?"
lab var m3_620_1 "M3-620-1. During any point of your pregnancy or after birth, were you given a mother & child booklet for the 1st baby to take home with you?"
lab var m3_620_2 "M3-620-2. During any point of your pregnancy or after birth, were you given a mother & child booklet for the 1st baby to take home with you?"
lab var m3_621a "M3-621a. Who assisted you in the delivery?"
lab var m3_621b "M3-621b. Did someone come to check on you after you gave birth? For example, someone asking you questions about  your health or examining you?"
lab var m3_621c_ke "M3-621c-ke. How long after giving birth did the checkup take place?"
lab var m3_621c_ke_unit "M3-621c-ke-unit. The unit of time for m3_621c_ke."
lab var m3_622a "M3-622a. Around the time of delivery, were you told that  you will need to go to a facility for a checkup for you or your baby?"
lab var m3_622b "M3-622b. When were you told to go to a health facility for postnatal checkups? How many days after delivery?"
lab var m3_622c "M3-622c. Around the time of delivery, were you told that someone would come to visit you at your home to check on you or your babys health?"

lab var m3_baby1_sleep "M3-311a. Regarding sleep, which response best describes the 1st baby today?"
lab var m3_baby2_sleep "M3-311a. Regarding sleep, which response best describes the second baby today?"
lab var m3_baby1_feed "M3-311b. Regarding feeding, which response best describes the 1st baby today?"
lab var m3_baby2_feed "M3-311b. Regarding feeding, which response best describes the second baby today?"
lab var m3_baby1_breath "M3-311c. Regarding breathing, which response best describes the 1st baby today?"
lab var m3_baby2_breath "M3-311c. Regarding breathing, which response best describes the second baby today?"
lab var m3_baby1_stool "M3-311d. Regarding stooling/poo, which response best describes the 1st baby today?"
lab var m3_baby2_stool "M3-311d. Regarding stooling/poo, which response best describes the second baby today?"
lab var m3_baby1_mood "M3-311e. Regarding their mood, which response best describes the 1st baby today?"
lab var m3_baby2_mood "M3-311e. Regarding their mood, which response best describes the second baby today?"
lab var m3_baby1_skin "M3-311f. Regarding their skin, which response best describes the 1st baby today?"
lab var m3_baby2_skin "M3-311f. Regarding their skin, which response best describes the second baby today?"
lab var m3_baby1_interactivity "M3-311g. Regarding interactivity, which response best describes the 1st baby today?"
lab var m3_baby2_interactivity "M3-311g. Regarding interactivity, which response best describes the second baby today?"	

lab var m3_701 "M3-701. At any time during labor, delivery, or after delivery did you suffer from any health problems?"
lab var m3_702 "M3-702. What health problems did you have?"
lab var m3_703 "M3-703. Would you say this problem was severe?"
lab var m3_704a "M3-704a. During your delivery, did you experience seizures, or not?"
lab var m3_704b "M3-704b. During your delivery, did you experience blurred vision, or not?"
lab var m3_704c "M3-704c. During your delivery, did you experience severe headaches, or not?"
lab var m3_704d "M3-704d. Did you experience swelling in hands/feet during your delivery, or not?"
lab var m3_704e "M3-704e. Did you experience labor over 12 hours during your delivery, or not?"
lab var m3_704f "M3-704f. Did you experience Excessive bleeding during your delivery, or not?"
lab var m3_704g "M3-704g. During your delivery, did you experience fever, or not?"
lab var m3_705 "M3-705. Did you receive a blood transfusion around the time of your delivery?"
lab var m3_706 "M3-706. Were you admitted to an intensive care unit?"

lab var m3_707_ke "M3-707-ke. How long did you stay at the facility that you delivered at after the delivery?"
lab var m3_707_ke_unit "M3-707-ke-unit. The unit of time for m3_707_ke"
lab var m3_baby1_issues "M3-708ba Did the 1st baby experience any of the following issues in the 1st day of life?"
lab var m3_baby1_issues_a "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble breathing)"
lab var m3_baby1_issues_b "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Fever)"
lab var m3_baby1_issues_c "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble feeding)"
lab var m3_baby1_issues_d "M3-708a. Did the baby the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
lab var m3_baby1_issues_e "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Low birth weight)"
lab var m3_baby1_issues_f "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=No complications)"
lab var m3_baby1_issues_98 "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=DK)"
lab var m3_baby1_issues_99 "M3-708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=NR/RF)"
lab var m3_baby2_issues "M3-708b. Did the second baby experience any of the following issues in the 1st day of life?"
lab var m3_baby2_issues_a "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble breathing)"
lab var m3_baby2_issues_b "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Fever, low temperature, or infection)"
lab var m3_baby2_issues_c "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble feeding)"
lab var m3_baby2_issues_d "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
lab var m3_baby2_issues_e "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Low birth weight)"
lab var m3_baby2_issues_f "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=No complications)"
lab var m3_baby2_issues_98 "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=DK)"
lab var m3_baby2_issues_99 "M3-708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=NR/RF)"		

lab var m3_708_oth_1 "M3-708-oth-1. Did the 1st baby experience any other health problems in the 1st day of life?"
lab var m3_708a "M3-709a. Write down the 1st baby's experiences any other health problems in the 1st day of life"
lab var m3_708_oth_2 "M3-708-oth-2. Did the second baby experience any other health problems in the 1st day of life?"
lab var m3_708b "M3-709b. Write down the second baby's experiences any other health problems in the 1st day of life"
lab var m3_710a "M3-710a. Did the 1st baby spend time in a special care nursery or intensive care unit before discharge?"
lab var m3_710b "M3-710b. Did the second baby spend time in a special care nursery or intensive care unit before discharge?"			
lab var m3_711c_1 "M3-711c-1. How long did the 1st baby stay at the health facility after being born?"
lab var m3_711c_1_unit "M3-711c-1-unit. The unit of time for m3_711c_1"
lab var m3_711c_2 "M3-711c-2. How long did the second baby stay at the health facility after being born?"
lab var m3_711c_2_unit "M3-711c-2-unit. The unit of time for m3_711c_2"

lab var m3_801a "M3-801a. Over the past 2 weeks, on how many days have you been bothered little interest or pleasure in doing things?"
lab var m3_801b "M3-801b. Over the past 2 weeks, on how many days have you been bothered feeling down, depressed, or hopeless in doing things?"
lab var m3_802a "M3-802a. Since you last spoke to us, did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves?"
lab var m3_802b "M3-802b. How many of these sessions did you have since you last spoke to us?"
lab var m3_802c "M3-802c. How many minutes did this/these visit(s) last on average?"
lab var m3_803a "M3-803a. Since giving birth, have you experienced severe or persistent headaches?"
lab var m3_803b "M3-803b. Since giving birth, have you experienced a fever?"
lab var m3_803c "M3-803c. Since giving birth, have you experienced severe abdominal pain, not just discomfort?"
lab var m3_803d "M3-803d. Since giving birth, have you experienced a lot of difficulty breathing even when you are resting?"
lab var m3_803e "M3-803e. Since giving birth, have you experienced convulsions or seizures?"
lab var m3_803f "M3-803f. Since giving birth, have you experienced repeated fainting or loss of consciousness?"
lab var m3_803g "M3-803g. Since giving birth, have you experienced continued heavy vaginal bleeding?"
lab var m3_803h "M3-803h. Since giving birth, have you experienced foul smelling vaginal discharge?"	
lab var m3_803j "M3-803j. Since giving birth, have you experienced any other major health problems since you gave birth?"
lab var m3_803j_other "M3-803j-oth. Specify any other major health problems since you gave birth"
lab var m3_805 "M3-805. Sometimes a woman can have a problem such that she experiences a constant leakage of urine or stool from her vagina during the day and night. This problem can occur after a difficult childbirth. Since you gave birth have you experienced a constant leakage of urine or stool from your vagina during the day and night?"
lab var m3_806 "M3-806. How many days after giving birth did these symptoms start?"
lab var m3_807 "M3-807. Overall, how much does this problem interfere with your everyday life? Please select a number between 0 (not at all) and 10 (a great deal)."
lab var m3_808a "M3-808a. Have you sought treatment for this condition?"
lab var m3_808b "M3-808b. Why have you not sought treatment?"
lab var m3_808b_other "M3-808b-oth. Specify other reasons why have you not sought treatment"
lab var m3_809 "M3-809. Did the treatment stop the problem?"

lab var m3_901a "M3-901a. Since last spoke, did you get iron or folic acid pills for yourself?"
lab var m3_901b "M3-901b. Since we last spoke, did you get iron injection?"
lab var m3_901c "M3-901c. Since we last spoke, did you get calcium pills?"
lab var m3_901d "M3-901d. Since we last spoke, did you get multivitamins?"
lab var m3_901e "M3-901e. Since we last spoke, did you get food supplements like Super Cereal or Plumpynut?"
lab var m3_901f "M3-901f. Since we last spoke, did you get medicine for intestinal worms [endemic areas]?"
lab var m3_901g "M3-901g. Since we last spoke, did you get medicine for malaria [endemic areas]?"
lab var m3_901h "M3-901h. Since we last spoke, did you get Medicine for HIV?"
lab var m3_901i "M3-901i. Since we last spoke, did you get medicine for your emotions, nerves, depression, or mental health?"
lab var m3_901j "M3-901j. Since we last spoke, did you get medicine for hypertension?"
lab var m3_901k "M3-901k. Since we last spoke, did you get medicine for diabetes, including injections of insulin?"
lab var m3_901l "M3-901l. Since we last spoke, did you get antibiotics for an infection?"
lab var m3_901m "M3-901m. Since we last spoke, did you get aspirin?"
lab var m3_901n "M3-901n. Since we last spoke, did you get paracetamol, or other pain relief drugs?"
lab var m3_901o "M3-901o. Since we last spoke, did you get contraceptive pills?"
lab var m3_901p "M3-901p. Since we last spoke, did you get contraceptive injection?"
lab var m3_901q "M3-901q. Since we last spoke, did you get other contraception method?"
lab var m3_901r "M3-901r. Since we last spoke, did you get any other medicine or supplement?"
lab var m3_901r_other "M3-901r-oth. Specify other treatment you took"

lab var m3_902a_baby1 "M3-902a. Since they were born, did the 1st baby get iron supplements?"
lab var m3_902a_baby2 "M3-902a. Since they were born, did the second baby get iron supplements?"
lab var m3_902b_baby1 "M3-902b. Since they were born, did the 1st baby get Vitamin A supplements?"
lab var m3_902b_baby2 "M3-902b. Since they were born, did the second baby get Vitamin A supplements?"
lab var m3_902c_baby1 "M3-902c. Since they were born, did the 1st baby get Vitamin D supplements?"
lab var m3_902c_baby2 "M3-902c. Since they were born, did the second baby get Vitamin D supplements?"
lab var m3_902d_baby1 "M3-902d. Since they were born, did the 1st baby get Oral rehydration salts?"
lab var m3_902d_baby2 "M3-902d. Since they were born, did the second baby get Oral rehydration salts?"
lab var m3_902e_baby1 "M3-902e. Since they were born, did the 1st baby get antidiarrheal?"
lab var m3_902e_baby2 "M3-902e. Since they were born, did the second baby get antidiarrheal?"
lab var m3_902f_baby1 "M3-902f. Since they were born, did the 1st baby get Antibiotics for an infection?"
lab var m3_902f_baby2 "M3-902f. Since they were born, did the second baby get Antibiotics for an infection?"
lab var m3_902g_baby1 "M3-902g. Since they were born, did the 1st baby get medicine to prevent pneumonia?"
lab var m3_902g_baby2 "M3-902g. Since they were born, did the second baby get medicine to prevent pneumonia?"
lab var m3_902h_baby1 "M3-902h. Since they were born, did the 1st baby get medicine for malaria [endemic areas]?"
lab var m3_902h_baby2 "M3-902h. Since they were born, did the second baby get medicine for malaria [endemic areas]?"
lab var m3_902i_baby1 "M3-902i. Since they were born, did the 1st baby get medicine for HIV (HIV+ mothers only)?"
lab var m3_902i_baby2 "M3-902i. Since they were born, did the second baby get medicine for HIV (HIV+ mothers only)?"
lab var m3_902j_baby1 "M3-902j. Since they were born, did the 1st baby get other medicine or supplement, please specify"
lab var m3_902j_baby1_other "M3-902j-oth-1. Any other medicine or supplement for the 1st baby please specify"
lab var m3_902j_baby2 "M3-902j. Since they were born, did the second baby get other medicine or supplement, please specify"
lab var m3_902j_baby2_other "M3-902j-oth-2. Any other medicine or supplement for the second baby please specify"		

lab var m3_1001 "M3-1001. Overall, taking everything into account, how would you rate the quality of care that you received for your delivery at the facility you delivered at?"
lab var m3_1002 "M3-1002. How likely are you to recommend this provider to a family member or friend for childbirth?"
lab var m3_1003 "M3-1003. Did staff suggest or ask you (or your family or friends) for a bribe, and informal payment or gift?"
label variable m3_1004a "1004a. Thinking about the care you received during labor and delivery, how would you rate the knowledge and skills of your provider?"
label variable m3_1004b "1004b. Thinking about the care you received during labor and delivery, how would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab tests?"
label variable m3_1004c "1004c. Thinking about the care you received during labor and delivery, how would you rate the level of respect the provider showed you?"
label variable m3_1004d "1004d. Thinking about the care you received during labor and delivery, how would you rate clarity of the providers explanations?"
label variable m3_1004e "1004e. Thinking about the care you received during labor and delivery, how would you rate degree to which the provider involved you as much as you wanted to be in decisions about your care?"
label variable m3_1004f "1004f. Thinking about the care you received during labor and delivery, how would you rate amount of time the provider spent with you?"
label variable m3_1004g "1004g. Thinking about the care you received during labor and delivery, how would you rate the amount of time you waited before being seen?"
label variable m3_1004h "1004h. Thinking about the care you received during labor and delivery, how would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider? "
lab var m3_1005a "M3-1005a. During your time at the health facility for labor and delivery, were you pinched by a health worker or other staff?"
lab var m3_1005b "M3-1005b. During your time at the health facility for labor and delivery, were slapped by a health worker or other staff?"
lab var m3_1005c "M3-1005c. During your time at the health facility for labor and delivery, were were physically tied to the bed or held down to the bed forcefully by a health worker or other staff?"
lab var m3_1005d "M3-1005d. During your time at the health facility for labor and delivery, had forceful downward pressure placed on your abdomen before the baby came out?"
lab var m3_1005e "M3-1005e. During your time at the health facility for labor and delivery, were shouted or screamed at by a health worker or other staff?"
lab var m3_1005f "M3-1005f. During your time at the health facility for labor and delivery, were scolded by a health worker or other staff?"
lab var m3_1005g "M3-1005g. During your time at the health facility for labor and delivery, the health worker or other staff member made negative comments to you regarding your sexual activity?"
lab var m3_1005h "M3-1005h. DDuring your time at the health facility for labor and delivery, the health worker or other staff threatened that if you did not comply, you or your baby would have a poor outcome?"
lab var m3_1006a "M3-1006a. During labor and delivery, women sometimes receive a vaginal examination. Did you receive a vaginal examination at any point in the health facility?"
lab var m3_1006b "M3-1006b. Did the health care provider ask permission before performing the vaginal examination?"
lab var m3_1006c "M3-1006c. Were vaginal examinations conducted privately (in a way that other people could not see)?"
lab var m3_1007a "M3-1007a. During your time in the facility, were you offered any form of pain relief?"
lab var m3_1007b "M3-1007b. Did you request pain relief during your time in the facility?"
lab var m3_1007c "M3-1007c. Did you receive pain relief during your time in the facility?"

lab var m3_1101 "M3-1101. I would like to ask you about the cost of the delivery. Did you pay money out of your pocket for the delivery, including for the consultation or other indirect costs like your transport to the facility?"
lab var m3_1102a_amt "M3-1102a_1. How much money did you spend on registration/consultation?"
lab var m3_1102b_amt "M3-1102b. How much money did you spend on medicine/vaccines (including outside purchase)?"
lab var m3_1102c_amt "M3-1102c.	How much money did you spend test/investigations (x-ray, lab etc.)?"
lab var m3_1102d_amt "M3-1102d. How much money did you spend on transport (round trip) including that of person accompanying you?"
lab var m3_1102e_amt "M3-1102e. How much money did you spend money on food and accommodation including that of person accompanying you?"
lab var m3_1102f_amt "M3-1102f. How much money did you spend on other items?"
lab var m3_1102f_oth "M3-1102f-oth. Specify item"
lab var m3_1103 "M3-1103. So in total you spent:_____ Is that correct?"
lab var m3_1105 "M3-1105. Which of the following financial sources did your household use to pay for this?"
lab var m3_1105_other "M3-1105-oth. Other specify"
lab var m3_1106 "M3-1106. To conclude this survey, overall, please tell me how satisfied you are  with the health services you received during labor and delivery?" 

lab var m3_1201 "M3-1201. Im sorry to hear you had a miscarriage. If its ok with you I would like to ask a few more questions. When the miscarriage occurred, did you go to a health facility for follow-up?"
lab var m3_1202 "M3-1202. Overall, how would you rate the quality of care that you received for your miscarriage?"
lab var m3_1203 "M3-1203. Did you go to a health facility to receive this abortion?"
lab var m3_1204 "M3-1204. Overall, how would you rate the quality of care that you received for your abortion?"
			
lab var m3_endtime "Time of interview ended"
lab var m3_duration "Total duration of interview"

*===============================================================================

	* STEP FIVE: ORDER VARIABLES
order m1_* m2_* m3_*, sequential
order country module interviewer_id m1_date m1_start_time study_site facility ///
      permission care_self enrollage dob ///
	  zone_live zone_live_other b5anc b6anc_first b7eligible m1_noconsent_why_ke ///
	  respondentid mobile_phone flash

order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)
order edd_chart_ke edd gest_age_baseline_ke, after(m1_803)
order m1_1218_ke, after(m1_1218c_1)
*order m1_clinic_cost_ke, after(m1_1218_ke)
order m1_1218_other_total_ke, after(m1_1218f_1)
order m1_1218_total_ke, after(m1_1218_other_total_ke)


*===============================================================================
	* STEP SIX: SAVE DATA TO RECODED FOLDER

	*save "$ke_data_final/eco_m1-m3_ke.dta", replace

*===============================================================================

