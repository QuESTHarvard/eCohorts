* Ethiopia ECohort Data Cleaning File 
* Created by K. Wright, S. Sabwa, C. Arsenault, E. Clarke-Deedler
* Last Updated: Feb 12 2024

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES
		* STEP TW0: ADD VALUE LABELS/FORMATTING
		* STEP THREE: RECODING MISSING VALUES
		* STEP FOUR: LABELING VARIABLES
		* STEP FIVE: ORDER VARIABLES
		* STEP SIX: RESHAPE MODULE 2 TO WIDE FORM
		* STEP SEVEN: SAVE DATA

*------------------------------------------------------------------------------*
* Import Data 
clear all 

*--------------------DATA FILE:
*import delimited using "$et_data/05Jan2024.csv", clear
import delimited using "$et_data/2024-03-15.csv", clear
gen country = "Ethiopia"
*---------------------		
** Carryforward command: 

		*1) Creating order (do not edit)
		gen order_redcap = 0 if redcap_event_name =="maternal_integrate_arm_1"
		replace order_redcap = 1 if redcap_event_name == "module_1_arm_1" 
		replace order_redcap = 2 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 1
		replace order_redcap = 3 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 2
		replace order_redcap = 4 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 3
		replace order_redcap = 5 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 4
		replace order_redcap = 6 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 5
		replace order_redcap = 7 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 6
		replace order_redcap = 8 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 7
		replace order_redcap = 9 if redcap_event_name == "module_2_arm_1" & redcap_repeat_instance == 8
		replace order_redcap = 10 if redcap_event_name == "module_3_arm_1" 
		replace order_redcap = 11 if redcap_event_name == "module_4_arm_1"
		replace order_redcap = 12 if redcap_event_name == "module_5_arm_1"
		sort record_id order_redcap
	
		
		*2) Add any new vars here:
		by record_id: carryforward hiv_status_109_m2 what_was_the_result_of_hiv module_1_baseline_face_to_face_e ///
								   how_many_babies_do_you_303a is_the_respondent_eligible ///
								   module_1_baseline_face_to_face_e date_of_interview_m1, replace

*---------------------
* Filter for eligible participants only at module 1:
*recode is_the_respondent_eligible (. = .a) if redcap_event_name != "module_1_arm_1" // N =17 missing answer to eligiblity
replace module_1_baseline_face_to_face_e =2 if redcap_event_name =="maternal_integrate_arm_1"
replace is_the_respondent_eligible = 1 if redcap_event_name =="maternal_integrate_arm_1"

keep if is_the_respondent_eligible == 1 & module_1_baseline_face_to_face_e ==2

*Further cleaning of incomplete surveys:
drop if record_id == "1" | record_id == "2" | record_id == "3" | ///
		record_id == "4" | record_id == "5" | record_id == "6" | ///
		record_id == "7" | record_id == "8" | record_id == "9" | ///
		record_id == "10" | record_id == "11" | record_id == "12" | ///
		record_id == "13" | record_id == "14" | record_id == "15" | ///
		record_id == "16" | record_id == "17" | record_id == "18" | ///
		record_id == "19" | record_id == "20" | record_id == "21" | ///
		record_id == "22" | record_id == "23" | record_id == "24" | ///
		record_id == "25" | record_id == "26" | record_id == "27" | ///
		record_id == "28" | record_id == "1706-2" // 1706-2 did not finish the rest of M1			
					
*dropping incomplete module 1 surveys - 1/24
drop if module_1_baseline_face_to_face_e == 0

*drop m2_complete (not useful) and drop call tracking questions/module (also not useful) - 1/24
drop m2_attempt_avail m2_attempt_bestnumber m2_attempt_contact m2_attempt_date m2_attempt_goodtime m2_attempt_other m2_attempt_outcome m3_attempt_outcome m3_attempt_outcome_p2 m3_attempt_date m3_attempt_outcome2 module_2_phone_surveys_prenatal_

*** Dropping M5 for cleaning purposes:
drop ic_may_i_proceed_with_the-module_5_end_line_facetoface_sur	

		
*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
	
	rename record_id redcap_record_id
	rename (study_id interviewer_id date_of_interview_m1 time_of_interview_m1) ///
	       (study_id interviewer_id m1_date m1_start_time)
	rename study_site_a4 study_site
	rename other_study_site_a4 study_site_sd
	rename facility_name_a5 facility
	rename other_facility_name facility_other
	rename facility_type_a6 facility_type
	rename b1_may_we_have_your_permis permission
	rename b2_are_you_here_today_to_r care_self
	rename b3_how_old_are_you m1_enrollage
	rename b4_which_zone_district zone_live
	rename b5_are_you_here_to_receive b5anc
	rename b6_is_this_the_first_time_you b6anc_first
    rename data_collector_confirms_01 b6anc_first_conf
	rename eth_1_b_do_you_plan_to_con continuecare
	rename is_the_respondent_eligible b7eligible
	rename what_is_your_first_name_101 first_name
	rename what_is_your_family_name_102 family_name
	rename assign_respondent_id_103 respondentid
	rename do_you_have_a_mobile_phone mobile_phone
	rename what_is_your_phone_number phone_number
	rename can_i_flash_this_mobile_num flash
	rename is_the_place_kebele_you_eth_1_1 kebele_malaria
	rename eth_2_1_is_the_place_or_ke kebele_intworm
	
	rename in_general_how_would_201m1 m1_201
	rename did_you_have_diabetes_202a m1_202a
	rename (did_yo_have_hbp_202b did_you_had_cardiac_disease did_you_had_mental_disorder ///
	        did_you_had_hiv before_you_got_pregnant_202f before_you_got_pregnant_202g) ///
			(m1_202b m1_202c m1_202d m1_202e m1_202f_et m1_202g_et)
	rename (before_pregnant_diagn_203 specify_the_diagnosed_203 currently_taking_medication ///
	        which_best_describe_your_205a which_describes_your_205b which_describe_your_205c ///
			which_describe_your_205d which_describe_your_205e) ///
		   (m1_203_et m1_203_other m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e)	
	rename m1_206a phq9a
	rename m1_206b phq9b
	rename m1_206c phq9c
	rename m1_206d phq9d
	rename m1_206e phq9e
	rename m1_206f phq9f
	rename m1_206g phq9g
	rename m1_206h phq9h
	rename m1_206i phq9i
	rename health_problems_affecting_207 m1_207
	
	rename (rate_health_quality_301	overall_view_of_health_302 how_confident_are_you_303 ///
	how_confident_are_you_304 how_confident_are_you_305_a how_confident_are_you_305_b) ///
	(m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b)
	
	rename (how_did_you_travel_401 specify_other_transport_401 how_long_in_hours_or_minut_402 ///
	        do_you_know_the_distance_403a how_far_403b is_this_the_nearest_health_404 ///
			what_is_the_most_important_405 specify_other_reason_405) ///
		   (m1_401 m1_401_other m1_402 m1_403a m1_403b m1_404 m1_405 m1_405_other)
		   
	rename (what_is_your_first_languag_501 specify_other_language_501 have_you_ever_attend_502 ///
	        what_is_the_highest_level_503 can_you_read_any_part_504 what_is_your_current_marit_505 ///
			what_is_your_occupation_506 specify_other_occupation_506 what_is_your_religion_507 ///
			specify_other_religion_507 how_many_people_508) ///
			(m1_501 m1_501_other m1_502 m1_503 m1_504 m1_505 m1_506 ///
			m1_506_other m1_507 m1_507_other m1_508)
	
	rename (have_you_ever_heard_509a do_you_think_that_people_509b a_have_you_ever_heard_510a ///
	        do_you_think_that_tb_can_510b when_children_have_diarrhe_511 is_smoke_from_a_wood_burni_512) ///
	       (m1_509a m1_509b m1_510a m1_510b m1_511 m1_512)
		   
	rename (what_phone_numbers_513a___1 what_phone_numbers_513a___2 what_phone_numbers_513a___3  ///
		   what_phone_numbers_513a___4 what_phone_numbers_513a___5 what_phone_numbers_513a___6 ///
		   what_phone_numbers_513a___7 what_phone_numbers_513a___8) (m1_513a_1 m1_513a_2 m1_513a_3 ///
		   m1_513a_4 m1_513a_5 m1_513a_6 m1_513a_7 m1_513a_8)
		   
    rename (what_phone_numbers_513a___998 what_phone_numbers_513a___999 what_phone_numbers_513a___888) ///
		   (m1_513a_998 m1_513a_999 m1_513a_888)
	
	rename (primary_phone_number_513b can_i_flash_this_number_513c secondary_personal_phone_513d ///
		   spouse_or_partner_513e community_health_worker_513f close_friend_or_family_513g ///
		   close_friend_or_family_513h other_phone_number_513i) ///
		   (m1_513b m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i)
	
	rename (mobile_phone_number_514b where_is_your_town_515a where_is_your_zone_515b where_is_your_kebele_515c  ///
		    what_is_your_house_num_515d could_you_please_describe_516 is_this_a_temporary_reside_517 ///
			until_when_will_you_be_at_518  ///
			where_will_your_district_519a where_will_your_kebele_519b where_will_your_village_519c) ///
			(m1_514b m1_515a_town m1_515b_zone m1_515c_ward ///
			m1_515d_house m1_516 m1_517 m1_518 m1_519_district m1_519_ward m1_519_village)
	
	rename (i_would_like_to_know_how_601 how_likely_are_you_to_reco_602	how_long_in_minutes_did_603 ///
	        how_long_in_hours_or_minut_604 eth_1_6_1_do_you_know_how_lo eth_1_6_2_how_long_is_your) ///
			(m1_601 m1_602 m1_603 m1_604 m1_604b_et m1_604c_et) 
			
	rename (thinking_about_the_visit_605 thinking_about_the_visit_605b thinking_about_the_visit_605c ///
	        thinking_about_the_visit_605d thinking_about_the_visit_605e thinking_about_the_visit_605f ///
			thinking_about_the_visit_605g thinking_about_the_visit_605h thinking_about_the_visit_605i ///
			thinking_about_the_visit_605j thinking_about_the_visit_605k) ///
	        (m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h ///
			m1_605i_et m1_605j_et m1_605k_et)
			
	rename (measure_your_blood_pressure_700	measure_your_weight_701 measure_your_height_702 ///
	        measure_your_upper_arm_703 measure_heart_rate_704 take_urine_sample_705 take_blood_drop_706 ///
			take_blood_draw_707) ///
		   (m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707)
		   
	rename (do_hiv_test_708a share_hiv_test_result_708b medicine_for_hiv_708c explain_medicine_usage_708d do_hiv_viral_load_test_708e do_cd4_test_708f do_hiv_viral_load_test_709a do_cd4_test_709b result_of_blood_sugar_test_711b) (m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_711b)
		
	rename (how_subscription_for_713a_1 how_do_they_provide_713b_1 how_do_they_provide_713c_1 how_do_they_provide_713d_1 how_do_they_provide_713e_1 how_do_they_provide_713f_1 how_do_they_provide_713g_1 how_do_they_provide_713h_1 how_do_they_provide_713i_1 whare_you_given_injection_714a receive_tetanus_injection_714b nuber_of_tetanus_injection_714c how_many_years_ago_714d  how_many_years_ago_last_714e) (m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_714c m1_714d m1_714e)
	
	rename (provided_with_an_insecticide_715 discuss_about_diabetes_718 discuss_about_bp_719 discuss_about_cardiac_720 discuss_about_mental_health_721 discuss_about_hiv_722 discus_about_medication_723) (m1_715 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723)
	
	rename (should_come_back_724a when_did_he_tell_you_724b to_see_gynecologist_724c  to_go_to_hospital_724e to_go_for_urine_test_724f go_to_blood_test_724g go_to_do_hiv_test_724h go_to_do_ultrasound_test_724i) (m1_724a m1_724b m1_724c m1_724e m1_724f m1_724g m1_724h m1_724i)
	
	rename (estimated_date_for_delivery_801 how_many_months_weeks_803 calculate_gestational_age_804 how_many_babies_you_preg_805 ask_your_last_period_806 when_you_got_pregnant_807) (m1_801 m1_803 m1_804 m1_805 m1_806 m1_807)
	
	rename (m1_802b m1_802c m1_802d) (m1_802b_et m1_802c_et m1_802d_et)
	
	rename (m1_808___0 m1_808___1 m1_808___2 m1_808___3 m1_808___4 m1_808___5 ///
			m1_808___6 m1_808___7 m1_808___8 m1_808___9 m1_808___10 m1_808___11 ///
			m1_808___12 m1_808___96 m1_808___99 m1_808___998 m1_808___999 m1_808___888) ///
		   (m1_808_0_et m1_808_1_et m1_808_2_et m1_808_3_et m1_808_4_et m1_808_5_et ///
		   m1_808_6_et m1_808_7_et m1_808_8_et m1_808_9_et m1_808_10_et m1_808_11_et ///
		   m1_808_12_et m1_808_96_et m1_808_99_et m1_808_998_et m1_808_999_et m1_808_888_et)
	
	rename (specify_other_reason_808) (m1_808_other)
	
	rename (discuss_your_birth_plan_809 other_than_the_list_above m1_811 you_might_need_c_section_812a) ///
		   (m1_809 m1_810_other m1_811 m1_812a) 
	
	rename (m1_812b_0 m1_812b___1 m1_812b___2 m1_812b___3 m1_812b___4 m1_812b___5 ///
			m1_812b___96 m1_812b___98 m1_812b___99 m1_812b___998 m1_812b___999 ///
			m1_812b___888 other_reason_for_c_section_812) ///
		   (m1_812b_0_et m1_812b_1 m1_812b_2 m1_812b_3 m1_812b_4 m1_812b_5 ///
		   m1_812b_96 m1_812b_98 m1_812b_99 m1_812b_998_et m1_812b_999_et ///
		   m1_812b_888_et m1_812b_other) 
	
	rename (common_health_problems_813a advice_for_treatment_813b some_women_experience_813c some_women_experience_813d  during_the_visit_today_813e some_women_experience_eth_1_8a eth_1_8b_hyperemesis_gravi eth_1_8c_did_you_experienc eth_1_8d_did_you_experienc eth_1_8e_did_you_experienc eth_1_8f_did_you_experienc eth_1_8g_any_other_pregnan specify_the_feeling_eth_1_8_h eth_2_8_did_the_provider) (m1_813a m1_813b m1_813c m1_813d m1_813e m1_8a_et m1_8b_et m1_8c_et m1_8d_et m1_8e_et m1_8f_et m1_8g_et m1_8gother_et m1_2_8_et)
	
	rename (experience_headaches_814a experience_a_fever_814c experience_abdominal_pain_814d  experience_convulsions_814f experience_repeated_faint_814g exprience_biby_stop_moving_814h could_you_please_tell_814i) (m1_814a m1_814c m1_814d m1_814f m1_814g m1_814h m1_814i)
	
	rename (m1_815___0 m1_815___1 m1_815___2 m1_815___3 m1_815___4 m1_815___5 m1_815___6 ///
			m1_815___7 m1_815___96 m1_815___98 m1_815___99) (m1_815_0 m1_815_1 m1_815_2 ///
			m1_815_3 m1_815_4 m1_815_5 m1_815_6 m1_815_7 m1_815_96 m1_815_98 m1_815_99)
	
	rename (m1_815___998 m1_815___999 m1_815___888) (m1_815_998_et m1_815_999_et m1_815_888_et)
	
	rename (other_specify_kan_biroo_ib) (m1_815_other)
	
	rename (smoke_cigarettes_901 advised_to_stop_smoking_902 frequency_of_chew_khat_903 advice_to_stop_khat_904 drink_alcohol_within_30_days_905 when_you_do_drink_alcohol_906 advised_to_stop_alcohol_907) (m1_901 m1_902 m1_903 m1_904 m1_905 m1_906 m1_907)
	
	rename (no_of_pregnancies_you_had_1001 no_of_births_you_had_1002 baby_came_too_early_1005 ///
			blood_need_during_pregnancy_1006 m1_eth_1_10 had_cesarean_section_1007) ///
			(m1_1001 m1_1002 m1_1005 m1_1006 m1_1_10_et m1_1007)
			
	rename (m1_1102___1 m1_1102___2 m1_1102___3 m1_1102___4 m1_1102___5 m1_1102___6 ///
			m1_1102___7 m1_1102___8 m1_1102___9 m1_1102___10 m1_1102___96 m1_1102___98 ///
			m1_1102___99) (m1_1102_a m1_1102_b m1_1102_c m1_1102_d m1_1102_e m1_1102_f ///
			m1_1102_g m1_1102_h m1_1102_i m1_1102_j  m1_1102_96  m1_1102_98  m1_1102_99)
	
	rename (m1_1102___998 m1_1102___999 m1_1102___888) ///
		   ( m1_1102_98_et  m1_1102_99_et  m1_1102_88_et)
		   
	rename (specify_who_else_hit_1102) (m1_1102_other)
	
	rename (delivery_lasted_12_hours_1008 no_children_still_alive_1009 discuss_about_prev_pregn_1011a discuss_lost_baby_after_5m_1011b discuss_baby_born_dead_1011c discuss_baby_born_early_1011d discuss_you_had_c_section_1011e discuss_baby_die_within_1m_1011f anyone_ever_hit_kicked_1101 anyone_humiliate_you_1103) (m1_1008 m1_1009 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103)
	
	rename (m1_1104___1 m1_1104___2 m1_1104___3 m1_1104___4 m1_1104___5 m1_1104___6 ///
			m1_1104___7 m1_1104___8 m1_1104___9 m1_1104___10 m1_1104___96 m1_1104___98 ///
			m1_1104___99) (m1_1104_a m1_1104_b m1_1104_c m1_1104_d m1_1104_e ///
			m1_1104_f m1_1104_g m1_1104_h m1_1104_i m1_1104_j m1_1104_96 ///
			m1_1104_98 m1_1104_99)
	
	rename (m1_1104___998 m1_1104___999 m1_1104___888) (m1_1104_998_et m1_1104_999_et m1_1104_888_et)
	
	rename specify_who_humuliates_you m1_1104_other
	
	rename discuss_on_seek_support_1105	m1_1105
	
	rename (main_source_of_drink_water_1201 other_source_of_drink_1201 kind_of_toilet_facilities_1202 specify_other_toilet_1202 household_have_electricity_1203 household_have_radio_1204 household_have_tv_1205 household_have_telephone_1206 household_have_frige_1207 type_of_fuel_for_cook_1208 other_fuel_type_for_cook_1208) (m1_1201 m1_1201_other m1_1202 m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1208_other)
	
	rename (material_type_for_floor_1209 other_material_for_floor_1209 material_for_walls_1210 other_material_for_wall_1210 material_for_roof_1211 other_material_for_roof_1211 anyone_own_bicycle_1212 anyone_own_motor_cycle_1213 anyone_own_car_or_truck_1214 anyone_have_bank_account_1215 no_of_meals_per_day_1216 how_many_meals_per_1216_1) (m1_1209 m1_1209_other m1_1210 m1_1210_other m1_1211 m1_1211_other m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1216_1)
	
	rename money_from_pocket_for_trans_1217 m1_1217

	rename (m1_1220___1 m1_1220___2 m1_1220___3 m1_1220___4 m1_1220___5 m1_1220___6 m1_1220___96) ///
		   (m1_1220_1 m1_1220_2 m1_1220_3 m1_1220_4 m1_1220_5 m1_1220_6 m1_1220_96)
	
	rename (m1_1220___998 m1_1220___999 m1_1220___888) ///
	       (m1_1220_998_et m1_1220_999_et m1_1220_888_et)
	
	rename other_financial_source_1220 m1_1220_other
	
	rename other_health_insurance_type m1_1222_other
	
	rename (eth_1_13_muac_safartuu_naa hemoglobin_level_from_test) (muac m1_1309)
	
	rename (m1_1402___1 m1_1402___2 m1_1402___3 m1_1402___4 m1_1402___5 m1_1402___6 m1_1402___7 ///
			m1_1402___8 m1_1402___9) (m1_1402_1_et m1_1402_2_et m1_1402_3_et m1_1402_4_et m1_1402_5_et ///
			m1_1402_6_et m1_1402_7_et m1_1402_8_et m1_1402_9_et)
			
	rename (m1_1402___888 m1_1402___998 m1_1402___999) (m1_1402_888_et m1_1402_998_et m1_1402_999_et)
	
	rename (interview_end_time total_duration_of_intervie module_1_baseline_face_to_face_e) (m1_end_time m1_interview_length m1_complete)
	
	
* MODULE 2:
	
	rename (time_of_rescheduled_m2 date_of_rescheduled_m2) (m2_time_of_rescheduled m2_date_of_rescheduled)
	
	rename maternal_death_reported m2_maternal_death_reported
	
	rename (m2_iic m2_cr1 m2_102 m2_103a m2_107 m2_107b_ga hiv_status_109_m2 date_of_maternal_death ///
			how_did_you_learn_maternal_death)(m2_start m2_permission m2_date m2_time_start ///
			m2_ga m2_ga_estimate m2_hiv_status m2_date_of_maternal_death m2_maternal_death_learn)
			
	rename maternal_death_learn_other m2_maternal_death_learn_other
	
	rename date_of_maternal_death_2 m2_date_of_maternal_death_2

	rename (are_you_still_pregnant_or sever_headaches_since_last_visit viginal_bleed_since_last_visit a_fever_since_last_visit abdominal_pain_since_last_visit convulsions_since_last_visit)(m2_202 m2_203a m2_203b m2_203c m2_203d m2_203f)
	
	rename m2_death_info m2_111_other // order this ater 210

	rename (since_you_last_spoke_203i preeclapsia_eclampsia_204a bleeding_during_pregnancy_204b hyperemesis_gravidarum_204c anemia_204d cardiac_problem_204e amniotic_fluid_204f asthma_204g rh_isoimmunization_204h  specify_any_other_feeling) (m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i_other)

	rename (over_the_past_2_weeks_on_205a over_the_past_2_weeks_205b)(m2_205a m2_205b)
	
	rename (how_often_do_you_currently_206 how_often_do_you_currently_207 how_often_do_you_currently_208   health_consultation_1st health_consultation_2nd health_consultation_3rd health_consultation_4th health_consultation_5th) (m2_206 m2_207 m2_208 m2_303a m2_303b m2_303c m2_303d m2_303e)
	
	rename (other_facility_for_1st_consult other_facility_for_2nd_consult other_facility_for_3rd_consult  other_facility_for_4th_consult other_facility_for_5th_consult) (m2_304a_other m2_304b_other m2_304c_other m2_304d_other m2_304e_other)
	
	rename (m2_306_reason___1 m2_306_reason___2 m2_306_reason___3 m2_306_reason___4 ///
			m2_306_reason___5 m2_306_reason___96 m2_306_reason___998 m2_306_reason___999 ///
			m2_306_reason___888) (m2_306_1 m2_306_2 m2_306_3 m2_306_4 m2_306_5 m2_306_96 ///
			m2_306_998_et  m2_306_999_et m2_306_888_et)
	
	rename (specify_other_reason_307 other_reason_for_2nd_consult other_reason_for_3rd_consult other_reason_for_4th_consult other_reason_for_5th_consult) (m2_307_other m2_310_other m2_313_other m2_316_other m2_319_other)
		
	rename (m2_308_reason___1 m2_308_reason___2 m2_308_reason___3 m2_308_reason___4 ///
	m2_308_reason___5 m2_308_reason___96 m2_308_reason___998 m2_308_reason___999 ///
	m2_308_reason___888) (m2_308_1 m2_308_2 m2_308_3 m2_308_4 m2_308_5 m2_308_96 ///
	m2_308_998_et  m2_308_999_et m2_308_888_et)
			
	rename (m2_311_reason___1 m2_311_reason___2 m2_311_reason___3 m2_311_reason___4 ///
	m2_311_reason___5 m2_311_reason___96 m2_311_reason___998 m2_311_reason___999 ///
	m2_311_reason___888) (m2_311_1 m2_311_2 m2_311_3 m2_311_4 m2_311_5 m2_311_96 ///
	m2_311_998_et  m2_311_999_et m2_311_888_et)

	rename (m2_314_reason___1 m2_314_reason___2 m2_314_reason___3 m2_314_reason___4 ///
	m2_314_reason___5 m2_314_reason___96 m2_314_reason___998 m2_314_reason___999 ///
	m2_314_reason___888) (m2_314_1 m2_314_2 m2_314_3 m2_314_4 m2_314_5 m2_314_96 ///
	m2_314_998_et  m2_314_999_et m2_314_888_et)
	
		rename (m2_317_reason___1 m2_317_reason___2 m2_317_reason___3 m2_317_reason___4 ///
	m2_317_reason___5 m2_317_reason___96 m2_317_reason___998 m2_317_reason___999 ///
	m2_317_reason___888) (m2_317_1 m2_317_2 m2_317_3 m2_317_4 m2_317_5 m2_317_96 ///
	m2_317_998_et  m2_317_999_et m2_317_888_et)
	
	rename (m2_320___0 m2_320___1 m2_320___2 m2_320___3 m2_320___4 m2_320___5 m2_320___6 m2_320___7 ///
			m2_320___8 m2_320___9 m2_320___10 m2_320___11 m2_320___96 m2_320___99 m2_320___998 ///
			m2_320___999 m2_320___888) (m2_320_a m2_320_b m2_320_c m2_320_d m2_320_e m2_320_f ///
			m2_320_g m2_320_h m2_320_i m2_320_j m2_320_k m2_320_l m2_320_96 m2_320_99 m2_320_998_et ///
			m2_320_999_et m2_320_888_et)

	rename (quality_rate_of_care_1st_consult quality_rate_of_care_2nd_consult quality_rate_of_care_3rd_consult quality_rate_of_care_4th_consult quality_rate_of_care_5th_consult) (m2_401 m2_402 m2_403 m2_404 m2_405)
	
	rename (measured_bp_with_a_cuff_501a weight_taken_using_scale_501b taking_blook_draw_from_arm_501c blood_test_using_finger_501d urine_test_peed_container_501e ultrasound_test_501f any_other_test_501g) ///
	(m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g)
	
	rename (did_you_receive_any_results_502 which_test_result_did_you_503 have_you_received_test_503b have_you_received_test_503c have_you_received_test_503d have_you_received_test_503e have_you_received_test_503f did_you_receive_any_504 specify_other_test_result)(m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_504_other)
	
	rename (what_was_the_result_of_anemia what_was_the_result_of_hiv what_was_the_result_of_hiv_viral what_was_the_result_of_syphilis what_was_the_result_of_diabetes what_was_the_result_of_hyperten)(m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f)
	
	rename (since_you_last_discuss_sign_506a since_you_last_care_newborn_506c since_you_last_family_plan_506d ///
			session_of_psychological_508 do_you_know_the_number_session_o how_many_of_these_sessio_508b ///
			do_you_know_how_long_visit_508c how_many_minutes_did_this_508c)(m2_506a m2_506c m2_506d m2_508a ///
			m2_508b_number m2_508b_last m2_508c m2_508d)
	
	rename (a_since_we_last_spoke_did_509a since_we_last_spoke_did_509b since_we_last_spoke_did_509c since_we_last_spoke_did_601a since_we_last_spoke_did_601b since_we_last_spoke_did_601c since_we_last_spoke_did_601d since_we_last_spoke_did_601e since_we_last_spoke_did_601f since_we_last_spoke_did_601g since_we_last_spoke_did_601h since_we_last_spoke_did_601i since_we_last_spoke_did_601j since_we_last_spoke_did_601k since_we_last_spoke_did_601l since_we_last_spoke_did_601m since_we_last_spoke_did_601n specify_other_medicine_sup)(m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601n_other)
	
	rename (how_much_paid_602 in_total_how_much_did_you_602 are_you_currently_taking_603 how_often_do_you_take_604 i_would_now_like_to_ask_ab_701)(m2_602a m2_602b m2_603 m2_604 m2_701)
	
	rename (have_you_spent_money_702a how_much_money_did_you_702a have_you_spent_money_702b how_much_money_did_you_702b have_you_spent_money_702c how_much_money_did_you_702c have_you_spent_money_702d how_much_money_did_you_702d have_you_spent_money_702e how_much_money_did_you_702e so_in_total_you_spent_703 you_know_how_much_704 so_how_much_in_total_would_704)(m2_702a m2_702a_other m2_702b m2_702b_other m2_702c m2_702c_other m2_702d m2_702d_other m2_702e m2_702e_other m2_703 m2_704 m2_704_other)
	
	rename (m2_705___1 m2_705___2 m2_705___3 m2_705___4 m2_705___5 m2_705___6 m2_705___96 m2_705___998 m2_705___999 m2_705___888) (m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 m2_705_998_et m2_705_999_et m2_705_888_et)
	
	rename (specify_other_income_sourc m2_time_it_is_interru at_what_time_it_is_restart time_of_interview_end_103b total_duration_of_interv_103c)(m2_705_other m2_interupt_time m2_restart_time m2_endtime m2_int_duration)
	
	
	
* MODULE 3:

rename (iic_3 cr1_permission_granted_3 date_of_interview_m3 time_of_interview_started_3 m3_birth_or_ended m3_ga1 ga_birth_mat_estimated) ///
	   (m3_start_p1 m3_permission m3_date m3_time m3_birth_or_ended m3_ga1 m3_ga2)
	   
rename m3_303c m4_303c // moved this from module 4 cleaning so the chunk below can run  
	   
rename (how_many_babies_do_you_303a is_the_1st_baby_alive_303b is_the_2nd_baby_alive_303c is_the_3rd_baby_alive_303d what_is_the_1st_baby_name ///
		what_is_the_2nd_baby_name what_is_the_3rd_baby_name what_is_gender_of_1st_baby what_is_the_gender_of_2nd_baby what_is_the_gender_of_3rd_baby ///
		how_old_is_the_1st_baby when_the_1st_baby_born_was when_the_2nd_baby_born_w when_the_3rd_baby_born_was) (m3_303a m3_303b m3_303c m3_303d m3_baby1_name ///
		m3_baby2_name m3_baby3_name m3_baby1_gender m3_baby2_gender m3_baby3_gender m3_baby1_age m3_baby1_weight m3_baby2_weight m3_baby3_weight) 

rename (do_you_know_weight_1st_baby do_you_know_weight_2nd_baby do_you_know_weight_3rd_baby rate_1st_baby_overall_health rate_2nd_baby_overall_health ///
		rate_3rd_baby_overall_health other_specify other_specifya2  other_specifa3 /// 
		how_confiden_on_breastfeed how_often_per_day_in_eth1_3 born_alive_baby_1 as_you_know_this_survey_202 born_alive_baby_2 born_alive_baby_3 ///
		q313b_1 q313b_2) (m3_baby1_size m3_baby2_size m3_baby3_size m3_baby1_health m3_baby2_health m3_baby3_health m3_baby1_feed_other ///
	    m3_baby2_feed_other m3_baby3_feed_other m3_breastfeeding m3_breastfeeding_fx_et m3_baby1_born_alive m3_202 ///
		m3_baby2_born_alive m3_baby3_born_alive m3_313a_baby1 m3_313b_baby1)		
		
rename (how_you_feed_1st_baby___1 how_you_feed_1st_baby___2 how_you_feed_1st_baby___3 how_you_feed_1st_baby___4 how_you_feed_1st_baby___5 ///
		how_you_feed_1st_baby___6 how_you_feed_1st_baby___7 how_you_feed_1st_baby___96 how_you_feed_1st_baby___99 how_you_feed_1st_baby___998 ///
		how_you_feed_1st_baby___999 how_you_feed_1st_baby___888) (m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e ///
		m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_96 m3_baby1_feed_99 m3_baby1_feed_998 m3_baby1_feed_999 m3_baby1_feed_888)

rename (how_you_feed_2nd_baby___1 how_you_feed_2nd_baby___2 how_you_feed_2nd_baby___3 how_you_feed_2nd_baby___4 how_you_feed_2nd_baby___5 ///
		 how_you_feed_2nd_baby___7 how_you_feed_2nd_baby___96 how_you_feed_2nd_baby___99 how_you_feed_2nd_baby___998 ///
		how_you_feed_2nd_baby___999 how_you_feed_2nd_baby___888) (m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e ///
		 m3_baby2_feed_g m3_baby2_feed_96 m3_baby2_feed_99 m3_baby2_feed_998 m3_baby2_feed_999 m3_baby2_feed_888)				
		
rename (how_you_feed_3rd_baby___1 how_you_feed_3rd_baby___2 how_you_feed_3rd_baby___3 how_you_feed_3rd_baby___4 how_you_feed_3rd_baby___5 ///
		how_you_feed_3rd_baby___7 how_you_feed_3rd_baby___96 how_you_feed_3rd_baby___99 how_you_feed_3rd_baby___998 ///
		how_you_feed_3rd_baby___999 how_you_feed_3rd_baby___888) (m3_baby3_feed_a m3_baby3_feed_b m3_baby3_feed_c m3_baby3_feed_d m3_baby3_feed_e ///
		 m3_baby3_feed_g m3_baby3_feed_96 m3_baby3_feed_99 m3_baby3_feed_998 m3_baby3_feed_999 m3_baby3_feed_888)

rename (days_or_hours_die_baby_2 days_or_hours_die_baby_4 days_or_hours_die_baby_3 days_or_hours_die_baby_5) (m3_313a_baby2 m3_313b_baby2 ///
		m3_313a_baby3 m3_313b_baby3)		

rename (death_cause_baby_1___a death_cause_baby_1___b death_cause_baby_1___c death_cause_baby_1___d death_cause_baby_1___e death_cause_baby_1___f ///
		death_cause_baby_1___g death_cause_baby_1___96 death_cause_baby_1___998 death_cause_baby_1___999 death_cause_baby_1___888 other_death_case_baby_1) ///
		(m3_death_cause_baby1_a m3_death_cause_baby1_b m3_death_cause_baby1_c m3_death_cause_baby1_d m3_death_cause_baby1_e m3_death_cause_baby1_f ///
		m3_death_cause_baby1_g m3_death_cause_baby1_96 m3_death_cause_baby1_998 m3_death_cause_baby1_999 m3_death_cause_baby1_888 m3_death_cause_baby1_other)		

rename (death_cause_baby_2___a death_cause_baby_2___b death_cause_baby_2___c death_cause_baby_2___d death_cause_baby_2___e death_cause_baby_2___f ///
		death_cause_baby_2___g death_cause_baby_2___96 death_cause_baby_2___998 death_cause_baby_2___999 death_cause_baby_2___888 other_death_case_baby_2) ///
		(m3_death_cause_baby2_a m3_death_cause_baby2_b m3_death_cause_baby2_c m3_death_cause_baby2_d m3_death_cause_baby2_e m3_death_cause_baby2_f ///
		m3_death_cause_baby2_g m3_death_cause_baby2_96 m3_death_cause_baby2_998 m3_death_cause_baby2_999 m3_death_cause_baby2_888 m3_death_cause_baby2_other)	
		
rename (death_cause_baby_3___a death_cause_baby_3___b death_cause_baby_3___c death_cause_baby_3___d death_cause_baby_3___e death_cause_baby_3___f ///
		death_cause_baby_3___g death_cause_baby_3___96 death_cause_baby_3___998 death_cause_baby_3___999 death_cause_baby_3___888 other_death_case_baby_3) ///
		(m3_death_cause_baby3_a m3_death_cause_baby3_b m3_death_cause_baby3_c m3_death_cause_baby3_d m3_death_cause_baby3_e m3_death_cause_baby3_f ///
		m3_death_cause_baby3_g m3_death_cause_baby3_96 m3_death_cause_baby3_998 m3_death_cause_baby3_999 m3_death_cause_baby3_888 m3_death_cause_baby3_other)		
		
rename (when_the_miscarriage_1201 overall_how_would_you_rate_1202 did_you_go_to_a_health_fac_1203 overall_how_would_you_rate_1204 consult_before_delivery_401 ///
		number_healthcare_consult consultation_1 consultation_referral_1) (m3_1201 m3_1202 m3_1203 m3_1204 m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1)

rename (consultation_visit_1___1 consultation_visit_1___2 consultation_visit_1___3 consultation_visit_1___4 consultation_visit_1___5 consultation_visit_1___96 ///
		consultation_visit_1___998 consultation_visit_1___999 consultation_visit_1___888 specify_other_reason_for_1) (m3_consultation1_reason_a ///
		m3_consultation1_reason_b m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e m3_consultation1_reason_96 ///
		m3_consultation1_reason_998 m3_consultation1_reason_999 m3_consultation1_reason_888 m3_consultation1_reason_other)		

rename (consultation_2 consultation_referral_2 consultation_visit_2___1  consultation_visit_2___2 consultation_visit_2___3 consultation_visit_2___4 ///
		consultation_visit_2___5 consultation_visit_2___96 consultation_visit_2___998 consultation_visit_2___999 consultation_visit_2___888 ///
		list_m3) (m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason_a m3_consultation2_reason_b /// 
		m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 m3_consultation2_reason_998 ///
		m3_consultation2_reason_999 m3_consultation2_reason_888 m3_consultation2_reason_other)				
		
rename (consultation_3 consultation_visit_3 consultation_referral_3___1 consultation_referral_3___2 consultation_referral_3___3 ///
		consultation_referral_3___4 consultation_referral_3___5 consultation_referral_3___96 consultation_referral_3___998 consultation_referral_3___999 ///
		consultation_referral_3___888 other_reasons_spec) (m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason_a ///
		m3_consultation3_reason_b m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 ///
		m3_consultation3_reason_998 m3_consultation3_reason_999 m3_consultation3_reason_888 m3_consultation3_reason_other)		

		
rename (consultation_4 consultation_visit_4 consultation_referral_4___1 consultation_referral_4___2 consultation_referral_4___3 consultation_referral_4___4 ///
		consultation_referral_4___5 consultation_referral_4___96 consultation_referral_4___998 consultation_referral_4___999 consultation_referral_4___888 ///
		other_reasons_spec_2) (m3_consultation_4 m3_consultation_referral_4 m3_consultation4_reason_a m3_consultation4_reason_b m3_consultation4_reason_c  ///
		m3_consultation4_reason_d m3_consultation4_reason_e m3_consultation4_reason_96 m3_consultation4_reason_998 m3_consultation4_reason_999 ///
		m3_consultation4_reason_888 m3_consultation4_reason_other)		
		
rename (consultation_5 consultation_visit_5 consultation_referral_5___1 consultation_referral_5___2 consultation_referral_5___3 consultation_referral_5___4 ///
		consultation_referral_5___5 consultation_referral_5___96 consultation_referral_5___998 consultation_referral_5___999 consultation_referral_5___888 ///
		other_reasons_spec_3) (m3_consultation_5 m3_consultation_referral_5 m3_consultation5_reason_a m3_consultation5_reason_b m3_consultation5_reason_c m3_consultation5_reason_d ///
		m3_consultation5_reason_e m3_consultation5_reason_96 m3_consultation5_reason_998 m3_consultation5_reason_999 m3_consultation5_reason_888 ///
		m3_consultation5_reason_other)		
	
rename (bp_before_delivery_412a weight_before_delivery_412b blood_draw_before_delivery_412c blood_test_before_delivery_412d urine_test_before_delivery_412e ///
		ultrasound_before_delivery_412f other_test_before_delivery_412g m3_412g_other) (m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_412g_other)	
	
rename (deliver_health_facility_501 what_kind_of_facility_was_it name_of_the_facility_deliver other_in_the_zone other_outside_of_the_zone_sp ///
		where_was_this_facility_locate subcity_this_facility_m3 before_you_delivered_505a how_long_did_you_stay_at_505b what_day_and_time_did_the_506 ///
		what_day_and_time_did_the_507 m3_506b_98) (m3_501 m3_502 m3_503 m3_503_inside_zone_other m3_503_outside_zone_other m3_504a m3_504b m3_505a ///
		m3_505b m3_506a m3_506b m3_506b_unknown)
 
rename (time_you_leave_facility_507 time_you_leave_facility_507_unk at_any_point_during_labor_508 what_was_the_main_reason_509 ///
		specify_other_reason_for_g did_you_go_to_another_510 how_many_facilities_did_yo_511 what_kind_of_facility_was_512 other_outside_of_the_zo ///
		what_is_the_name_of_513a ther_in_the_zone_specify a_97_other_outside_of_the_zone where_was_this_facility_513b facility_located_city_m3 ///
		what_time_did_you_arriv_514 what_time_did_you_arriv_514_unk why_did_you_go_to_the_2nd_515 why_did_you_or_your_family_516 specify_other_reason_to_go) ///
		(m3_507 m3_507_unknown m3_508 m3_509 m3_509_other m3_510 m3_511 m3_512 m3_512_outside_zone_other m3_513a m3_513_inside_zone_other m3_513_outside_zone_other ///
		m3_513b1 m3_513b2 m3_514 m3_514_unknown m3_515 m3_516 m3_516_other)

rename (did_the_provider_inform_yo_517 why_did_the_provider_refer_518 other_delivery_complications other_reasons_specify what_was_the_main_reason_519 ///
		specify_m at_what_time_did_you_arriv_520 m3_520_98 once_you_got_to_facility_521 m3_521_98 date_of_rescheduled_m3_p1 ///
		time_of_rescheduled_m3_p1 module_3_first_phone_survey_afte) (m3_517 m3_518 m3_518_other_complications m3_518_other m3_519 m3_519_other m3_520 ///
		m3_520_unknown m3_521 m3_521_unknown m3_p1_date_of_rescheduled m3_p1_time_of_rescheduled m3_p1_complete)

rename (iic_4 cr1_permission_granted_4 date_of_interview_m3_2 time_of_interview_started_m3_2 baby1status baby2status baby3status once_you_were_first_checke_601a ///
		once_you_were_first_chec_601b once_you_were_first_chec_601c did_the_health_care_prov_602a did_the_health_care_prov_602b a_during_your_time_in_the_603a ///
		b_during_your_time_in_the_603b c_during_your_time_in_the_603c drink_fluid_m3) (m3_start_p2 m3_permission_p2 m3_date_p2 m3_time_p2 m3_201a m3_201b m3_201c ///
		m3_601a m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_603d)		

rename (a_while_you_were_in_labor_604a while_you_were_giving_bi_604b did_you_have_a_caesarean_605a when_was_the_decision_ma_605b) (m3_604a m3_604b ///
		m3_605a m3_605b)

rename (m3_605c___1 m3_605c___2 m3_605c___3 m3_605c___4 m3_605c___96 m3_605c___99 m3_605c___998 m3_605c___999 m3_605c___888 specify_other_reason_for_h) ///
	   (m3_605c_a m3_605c_b m3_605c_c m3_605c_d m3_605c_96 m3_605c_99 m3_605c_998 m3_605c_999 m3_605c_888 m3_605c_other)

rename (did_the_provider_perform_606 did_you_receive_stiches_607 eth_1_6_did_the_health_car eth_2_6_did_the_health_car eth_3_6_did_the_health_car ///
		eth_4_6_did_the_health_car eth_5_6_did_the_health_car immediately_after_delivery_608 immediately_after_delivery_609 was_were_the_baby_babies_610a ///
		was_were_the_baby_s_babi_610b did_a_health_care_provider_611 have_you_done_breask_feed_612) (m3_606 m3_607 m3_607a_et m3_607b_et m3_607c_et m3_607d_et ///
		m3_607e_et m3_608 m3_609 m3_610a m3_610b m3_611 m3_612)	   
	   
rename (how_long_after_delivery_di_614 did_anyone_check_on_baby_1 did_anyone_check_on_baby_2 did_anyone_check_on_baby_3 how_long_after_delivery_baby_1 ///
		how_long_after_delivery_baby_2 how_long_after_delivery_baby_3 receive_a_vaccine_baby_1 receive_a_vaccine_baby_2 receive_a_vaccine_baby_3 ///
		eth_6_6_did_your_1st_baby eth_6_6_did_your_2nd_baby eth_6_6_did_your_3rd_baby eth_7_6_did_your_baby_eye eth_7_6_did_your_baby_eye_2 ///
		eth_7_6_did_your_baby_eye_3 whay_baby_eat_619a) (m3_614 m3_615a m3_615b m3_615c m3_616a m3_616b m3_616c m3_617a m3_617b m3_617c m3_617d_et ///
		m3_617e_et m3_617f_et m3_617g_et m3_617h_et m3_617i_et m3_619a)	   

rename (umblical_cord_care_619b need_avoid_chilling_619c return_vaccination_619d hand_washing_619e danger_sign_or_symptom_619f danger_sign_in_yourself_619g ///
		before_you_left_the_faci_619h before_you_left_the_faci_619i before_you_left_the_faci_619j after_your_baby_was_born_620 who_assisted_the_delivery_621 ///
		did_someone_come_to_chec_621b how_long_after_giving_621c around_the_time_of_deliv_622a when_were_you_told_to_go_622b) (m3_619b m3_619c m3_619d m3_619e ///
		m3_619f m3_619g m3_619h m3_619i m3_619j m3_620 m3_621a m3_621b m3_621c m3_622a m3_622b)	
		
rename (regarding_sleep_1st_baby_today regarding_sleep_2nd_baby_today regarding_sleep_3rd_baby_today regarding_feeding_baby_1 regarding_feeding_baby_2 ///
		regarding_feeding_baby_3 regarding_breathing_baby_1 regarding_breathing_baby_2 regarding_breathing_baby_3 regarding_stooling_baby_5 ///
		regarding_stooling_baby_2 regarding_stooling_baby_3 regarding_their_mood_baby_1 regarding_their_mood_baby_2 regarding_their_mood_baby_3 ///
		regarding_their_skin_baby_1 regarding_their_skin_baby_2 regarding_their_skin_baby_3 regarding_interactivit_baby_1 regarding_interactivit_baby_2 ///
		regarding_interactivit_baby_3)	(m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep m3_baby1_feed m3_baby2_feed m3_baby3_feed m3_baby1_breath m3_baby2_breath ///
		m3_baby3_breath m3_baby1_stool m3_baby2_stool m3_baby3_stool m3_baby1_mood m3_baby2_mood m3_baby3_mood m3_baby1_skin m3_baby2_skin m3_baby3_skin ///
		m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity)	
	
rename (at_any_time_during_labor_701 what_health_problems_did_702 would_you_say_this_problem_703 did_you_experience_seizures did_you_experience_blurvision ///
		did_you_experience_headache did_you_experience_swelling did_you_experience_labor did_you_experience_exces did_you_experience_fever did_you_receive_a_blood_705 ///
		were_you_admitted_to_an_706 how_long_did_you_stay_at_f q707_m3_unk) (m3_701 m3_702 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 ///
		m3_706 m3_707 m3_707_unknown)	
	
rename (experience_issiues_baby_1___1 experience_issiues_baby_1___2 experience_issiues_baby_1___3 experience_issiues_baby_1___4 experience_issiues_baby_1___5 ///
		experience_issiues_baby_1___6 experience_issiues_baby_1___96 experience_issiues_baby_1___98 experience_issiues_baby_1___99 experience_issiues_baby_1___998 ///
		experience_issiues_baby_1___999 experience_issiues_baby_1___888) (m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e ///
		m3_baby1_issues_f m3_baby1_issues_96 m3_baby1_issues_98 m3_baby1_issues_99 m3_baby1_issues_998 m3_baby1_issues_999 m3_baby1_issues_888)
	
rename (experience_issiues_baby_2___1 experience_issiues_baby_2___2 experience_issiues_baby_2___3 experience_issiues_baby_2___4 experience_issiues_baby_2___5 ///
		experience_issiues_baby_2___6 experience_issiues_baby_2___96 experience_issiues_baby_2___98 experience_issiues_baby_2___99 experience_issiues_baby_2___998 ///
		experience_issiues_baby_2___999 experience_issiues_baby_2___888) (m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e ///
		m3_baby2_issues_f m3_baby2_issues_96 m3_baby2_issues_98 m3_baby2_issues_99 m3_baby2_issues_998 m3_baby2_issues_999 m3_baby2_issues_888)	
		
rename (experience_issiues_baby_3___1 experience_issiues_baby_3___2 experience_issiues_baby_3___3 experience_issiues_baby_3___4 experience_issiues_baby_3___5 ///
		experience_issiues_baby_3___6 experience_issiues_baby_3___96 experience_issiues_baby_3___98 experience_issiues_baby_3___99 experience_issiues_baby_3___998 ///
		experience_issiues_baby_3___999 experience_issiues_baby_3___888) (m3_baby3_issues_a m3_baby3_issues_b m3_baby3_issues_c m3_baby3_issues_d m3_baby3_issues_e ///
		m3_baby3_issues_f m3_baby3_issues_96 m3_baby3_issues_98 m3_baby3_issues_99 m3_baby3_issues_998 m3_baby3_issues_999 m3_baby3_issues_888)	
	
rename (q708_oth write_down_baby_name_709b write_down_baby_name_709c baby_spend_710_baby_1 baby_spend_710_baby_2 baby_spend_710_baby_3 how_long_did_711_baby_1 ///
		how_long_did_711_baby_2 how_long_did_711_baby_3 over_the_past_2_weeks_on_801a b_over_the_past_2_weeks_801b since_you_last_spoke_802a ///
		how_many_of_these_sessio_802b how_many_minutes_did_802c) (m3_708a m3_708b m3_709c m3_710a m3_710b m3_710c m3_711a m3_711b m3_711c m3_801a ///
		m3_801b m3_802a m3_802b m3_802c)	

rename (have_you_experienced_803a have_you_experienced_803b have_you_experienced_803c have_you_experienced_803d have_you_experienced_803e ///
		have_you_experienced_803f have_you_experienced_803g have_you_experienced_803h have_you_experienced_803i have_you_experienced_803j ///
		specify_any_other_health_prob since_you_gave_birth_have_805 how_many_days_after_giving_806 overall_how_much_does_807 have_you_sought_treatment_808a ///
		why_have_you_not_sought_808b specify_other_reason_not_sought did_the_treatment_stop_809) (m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g ///
		m3_803h m3_803i m3_803j m3_803j_other m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other m3_809)		

rename (since_we_last_spoke_did_901a since_we_last_spoke_901b since_we_last_spoke_did_901c since_we_last_spoke_did_901d since_we_last_spoke_did_901e ///
		since_we_last_spoke_did_901f since_we_last_spoke_did_901g since_we_last_spoke_did_901h since_we_last_spoke_did_901i since_we_last_spoke_did_901j ///
		since_we_last_spoke_did_901k since_we_last_spoke_did_901l since_we_last_spoke_did_901m since_we_last_spoke_did_901n since_we_last_spoke_did_901o ///
		since_we_last_spoke_did_901p since_we_last_spoke_did_901q since_we_last_spoke_did_901r specify_other_treatment) (m3_901a m3_901b ///
		m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_901r_other)		
		
rename (since_they_were_born_did_902a since_they_were_born_did_902a_2 since_they_were_born_did_902a_3 since_they_were_born_did_902b ///
		since_they_were_born_did_902b_3 since_they_were_born_did_902b_2 since_they_were_born_did_902c since_they_were_born_did_902c_3 ///
		since_they_were_born_did_902c_2 since_they_were_born_did_902d since_they_were_born_did_902d_2 since_they_were_born_did_902d_3 ///
		since_they_were_born_did_902e since_they_were_born_did_902e_3 since_they_were_born_did_902e_2 since_they_were_born_did_902f) ///
		(m3_902a_baby1 m3_902a_baby2 m3_902a_baby3 m3_902b_baby1 m3_902b_baby2 m3_902b_baby3 m3_902c_baby1 m3_902c_baby2 m3_902c_baby3 ///
		m3_902d_baby1 m3_902d_baby2 m3_902d_baby3 m3_902e_baby1 m3_902e_baby2 m3_902e_baby3 m3_902f_baby1)		
		
rename (since_they_were_born_did_902f_2 since_they_were_born_did_902f_3 since_they_were_born_did_902g since_they_were_born_did_902g_2 ///
		since_they_were_born_did_902g_3 since_they_were_born_did_902h since_they_were_born_did_902h_2 since_they_were_born_did_902h_3 ///
		since_they_were_born_did_902i since_they_were_born_did_902i_2 since_they_were_born_did_902i_3 since_they_were_born_did_902j ///
		q902j_oth since_they_were_born_did_902j_2 q902j_oth_2 since_they_were_born_did_902j_3 q902j_oth_3) (m3_902f_baby2 m3_902f_baby3 ///
		m3_902g_baby1 m3_902g_baby2 m3_902g_baby3 m3_902h_baby1 m3_902h_baby2 m3_902h_baby3 m3_902i_baby1 m3_902i_baby2 m3_902i_baby3 ///
		m3_902j_baby1 m3_902j_baby1_other m3_902j_baby2 m3_902j_baby2_other m3_902j_baby3 m3_902j_baby3_other)		
		
rename (overall_taking_everything_901 how_likely_are_you_to_reco_902 did_staff_suggest_or_ask_903 rate_the_knowledge_904a rate_the_equipment_904b ///
		rate_the_level_of_respect_904c rate_the_clarity_904d rate_the_degree_904e rate_the_amount_904f rate_the_amount_904a rate_the_courtesy_904h ///
		confidentiality_m3 during_labor_m4 during_labor_m3 did_you_were_pinched_905a you_were_slapped_905b you_were_physically_tied_905c you_had_forceful_905d ///
		you_were_shouted_905e you_were_scolded_905f the_health_worker_905g other_staff_threatened_905h vaginal_examination_1006a) (m3_1001 m3_1002 m3_1003 ///
		m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_1004i m3_1004j m3_1004k m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f ///
		m3_1005g m3_1005h m3_1006a)	
	
rename (ask_permission_viginal_exa_1006b were_vaginal_examination_1006c any_form_of_pain_relief_1007a did_you_request_pain_rel_1007b did_you_receive_pain_rel_1007c ///
		would_like_to_ask_you_1101 spend_money_on_reg_1102 how_much_spent_registra did_you_spend_money_on_med how_you_spent_on_medicin did_you_spend_money_on_test ///
		how_much_spend_on_test did_you_spend_money_on_transp how_much_spend_on_transp did_you_spend_on_food_an how_much_spend_on_food did_you_spend_on_other ///
		how_much_spend_on_other in_total_how_much_you_spen confirm_oop total_spent) (m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102a_amt ///
		m3_1102b m3_1102b_amt m3_1102c m3_1102c_amt m3_1102d m3_1102d_amt m3_1102e m3_1102e_amt m3_1102f m3_1102f_amt m3_1103 m3_1103_confirm m3_1104)

rename (which_of_the_following_fin_1105 other_income_source_1105 to_conclude_this_survey_1106 time_of_interview_ended_103b ///
		c_total_duration_of_interv ot1 ot1_oth date_of_rescheduled_m3_p2 time_of_rescheduled_m3_p2) (m3_1105 ///
		m3_1105_other m3_1106 m3_endtime m3_duration m3_p2_outcome m3_p2_outcome_other ///
		m3_p2_date_of_rescheduled m3_p2_time_of_rescheduled)		

		
* MODULE 4:
rename iic_m4 m4_start 
rename cr1_permission_granted_m4 m4_permission
rename date_of_rescheduled_m4 m4_date_of_rescheduled
rename time_of_rescheduled_m4 m4_time_of_reschedule
rename q102_date_int_m4 m4_102
rename q103_time_int_m4 m4_103
rename q108_hiv_status_m4 m4_108
rename maternal_death_reported_m4 m4_112
rename date_of_maternal_death_m4 m4_113
rename m3_maternal_death_learn m4_114
rename m3_maternal_death_learn_other m4_114_other
rename baby1status_m4 m4_201_1
rename baby2status_m4 m4_201_2
rename baby3status_m4 m4_201_3
rename overall_health_baby_1_m4 m4_202_1
rename overall_health_baby_2_m4 m4_202_2
rename overall_health_baby_3_m4 m4_202_3
rename feed_baby_1_m4___1 m4_203_1_1
rename feed_baby_1_m4___2 m4_203_1_2
rename feed_baby_1_m4___3 m4_203_1_3
rename feed_baby_1_m4___4 m4_203_1_4
rename feed_baby_1_m4___5 m4_203_1_5
rename feed_baby_1_m4___6 m4_203_1_6
rename feed_baby_1_m4___7 m4_203_1_7
rename feed_baby_1_m4___99 m4_203_1_99
rename feed_baby_1_m4___998 m4_203_1_998
rename feed_baby_1_m4___999 m4_203_1_999
rename feed_baby_1_m4___888 m4_203_1_888
rename feed_baby_2_m4___1 m4_203_2_1
rename feed_baby_2_m4___2 m4_203_2_2
rename feed_baby_2_m4___3 m4_203_2_3
rename feed_baby_2_m4___4 m4_203_2_4
rename feed_baby_2_m4___5 m4_203_2_5
rename feed_baby_2_m4___6 m4_203_2_6
rename feed_baby_2_m4___7 m4_203_2_7
rename feed_baby_2_m4___99 m4_203_2_99
rename feed_baby_2_m4___998 m4_203_2_998
rename feed_baby_2_m4___999 m4_203_2_999
rename feed_baby_2_m4___888 m4_203_2_888
rename feed_baby_3_m4___1 m4_203_3_1
rename feed_baby_3_m4___2 m4_203_3_2
rename feed_baby_3_m4___3 m4_203_3_3
rename feed_baby_3_m4___4 m4_203_3_4
rename feed_baby_3_m4___5 m4_203_3_5
rename feed_baby_3_m4___6 m4_203_3_6
rename feed_baby_3_m4___7 m4_203_3_7
rename feed_baby_3_m4___99 m4_203_3_99
rename feed_baby_3_m4___998 m4_203_3_998
rename feed_baby_3_m4___999 m4_203_3_999
rename feed_baby_3_m4___888 m4_203_3_888
rename number_feeds_m4 m4_203d_et
rename bf_confidence_baby_1_m4 m4_204a
rename sleep_baby_1_m4 m4_205a_1 
rename sleep_baby_2_m4 m4_205a_2
rename sleep_baby_3_m4 m4_205a_3

rename feeding_baby_1_m4 m4_205b_1
rename feeding_baby_2_m4 m4_205b_2
rename feeding_baby_3_m4 m4_205b_3

rename breathing_baby_1_m4 m4_205c_1
rename breathing_baby_2_m4 m4_205c_2
rename breathing_baby_3_m4 m4_205c_3

rename stooling_poo_baby_1_m4 m4_205d_1
rename stooling_poo_baby_2_m4 m4_205d_2
rename stooling_poo_baby_3_m4 m4_205d_3

rename mood_baby_1_m4 m4_205e_1
rename mood_baby_2_m4 m4_205e_2
rename mood_baby_3_m4 m4_205e_3

rename skin_baby_1_m4 m4_205f_1
rename skin_baby_2_m4 m4_205f_2
rename skin_baby_3_m4 m4_205f_3

rename interactivity_baby_1_m4 m4_205g_1
rename interactivity_baby_2_m4 m4_205g_2
rename interactivity_baby_3_m4 m4_205g_3

rename diarrhea_baby_1 m4_206a_1
rename diarrhea_baby_2 m4_206a_2
rename diarrhea_baby_3 m4_206a_3

rename fever_baby_1 m4_206b_1
rename fever_baby_2 m4_206b_2
rename fever_baby_3 m4_206b_3

rename low_temperature_baby_1 m4_206c_1
rename low_temperature_baby_2 m4_206c_2
rename low_temperature_baby_3 m4_206c_3

rename illness_baby_1 m4_206d_1
rename illness_baby_2 m4_206d_2
rename illness_baby_3 m4_206d_3

rename trouble_breathing_baby_1 m4_206e_1
rename trouble_breathing_baby_2 m4_206e_2
rename trouble_breathing_baby_3 m4_206e_3

rename chest_problem_baby_1 m4_206f_1
rename chest_problem_baby_2 m4_206f_2
rename chest_problem_baby_3 m4_206f_3

rename trouble_feeding_baby_1 m4_206g_1
rename trouble_feeding_baby_2 m4_206g_2
rename trouble_feeding_baby_3 m4_206g_3

rename convulsions_baby_1 m4_206h_1
rename convulsions_baby_2 m4_206h_2
rename convulsions_baby_3 m4_206h_3

rename jaundice_baby_1 m4_206i_1
rename jaundice_baby_2 m4_206i_2
rename jaundice_baby_3 m4_206i_3

rename yellow_palms_baby_1 m4_206j_1
rename yellow_palms_baby_2 m4_206j_2
rename yellow_palms_baby_3 m4_206j_3

rename lethargic_baby_1_m4 m4_206k_1
rename lethargic_baby_2_m4 m4_206k_2
rename lethargic_baby_3_m4 m4_206k_3
rename bulged_font_1_m4 m4_206l_1
rename bulged_font_2_m4 m4_206l_2
rename bulged_font_3_m4 m4_206l_3

rename other_health_problem_baby_1 m4_207a_1 
rename other_problem_baby_1 m4_207_1_other  
rename other_health_problem_baby_2 m4_207a_2 
rename other_problem_baby_2 m4_207_2_other  
rename other_health_problem_baby_3 m4_207a_3 
rename other_problem_baby_3 m4_207_3_other  

rename date_died_baby m4_208a_1  
rename date_died_baby_unk m4_208a_1_unk  

rename date_died_baby2 m4_208a_2  
rename date_died_baby_unk2 m4_208a_2_unk 

rename date_died_baby3 m4_208a_3  
rename date_died_baby_unk3 m4_208a_3_unk 

rename age_when_died_baby_1 m4_209_1
rename age_when_died_baby_2 m4_209_2
rename age_when_died_baby_3 m4_209_3

rename cause_death_baby_1___0 m4_210_1_0 
rename cause_death_baby_1___1 m4_210_1_1
rename cause_death_baby_1___2 m4_210_1_2
rename cause_death_baby_1___3 m4_210_1_3
rename cause_death_baby_1___4 m4_210_1_4
rename cause_death_baby_1___5 m4_210_1_5
rename cause_death_baby_1___6 m4_210_1_6
rename cause_death_baby_1___7 m4_210_1_7
rename cause_death_baby_1___8 m4_210_1_8
rename cause_death_baby_1___9 m4_210_1_9
rename cause_death_baby_1___96 m4_210_1_96
rename cause_death_baby_1___998 m4_210_1_998
rename cause_death_baby_1___999 m4_210_1_999
rename cause_death_baby_1___888 m4_210_1_888
rename what_other_causes_baby_1 m4_210_1_other 

rename cause_death_baby_2___0 m4_210_2_0
rename cause_death_baby_2___1 m4_210_2_1
rename cause_death_baby_2___2 m4_210_2_2
rename cause_death_baby_2___3 m4_210_2_3
rename cause_death_baby_2___4 m4_210_2_4
rename cause_death_baby_2___5 m4_210_2_5
rename cause_death_baby_2___6 m4_210_2_6
rename cause_death_baby_2___7 m4_210_2_7
rename cause_death_baby_2___8 m4_210_2_8
rename cause_death_baby_2___9 m4_210_2_9
rename cause_death_baby_2___96 m4_210_2_96
rename cause_death_baby_2___998 m4_210_2_998
rename cause_death_baby_2___999 m4_210_2_999 
rename cause_death_baby_2___888 m4_210_2_888 
rename what_other_causes_baby_2 m4_210_2_other

rename cause_death_baby_3___0 m4_210_3_0
rename cause_death_baby_3___1 m4_210_3_1
rename cause_death_baby_3___2 m4_210_3_2
rename cause_death_baby_3___3 m4_210_3_3
rename cause_death_baby_3___4 m4_210_3_4
rename cause_death_baby_3___5 m4_210_3_5
rename cause_death_baby_3___6 m4_210_3_6
rename cause_death_baby_3___7 m4_210_3_7
rename cause_death_baby_3___8 m4_210_3_8
rename cause_death_baby_3___9 m4_210_3_9
rename cause_death_baby_3___96 m4_210_3_96
rename cause_death_baby_3___998 m4_210_3_998
rename cause_death_baby_3___999 m4_210_3_999
rename cause_death_baby_3___888 m4_210_3_888
rename what_other_causes_baby_3 m4_210_3_other
rename eth_1_3 m4_1_3_et

rename before_died_baby_1 m4_211_1
rename before_died_baby_2 m4_211_2
rename before_died_baby_3 m4_211_3

rename where_died_baby_1 m4_212_1
rename where_died_baby_2 m4_212_2
rename where_died_baby_3 m4_212_3

rename rate_overall_health_women m4_301

rename bothered_by_little_interest m4_302a
rename bothered_feeling_down m4_302b

rename baby_loving_303a m4_303a
rename baby_resentful_303b m4_303b

rename baby_joyful_303d m4_303d
rename baby_dislike m4_303e
rename baby_protective m4_303f
rename baby_disappointed m4_303g
rename baby_aggressive m4_303h

rename pain_on_sex_satisfaction_304 m4_304

rename constant_urine_leakage_baby_1 m4_305 

rename how_many_days_after_giving_306 m4_306

rename how_much_does_this_problem_307 m4_307

rename have_you_sought_treatment m4_308

rename why_have_you_not_sought_treat m4_309
rename other_reason_specif m4_309_other 

rename did_the_treatment_stop_the_310 m4_310

rename since_the_delivery_did_you_401 m4_401a
rename q401b_m4 m4_401b

rename since_the_delivery_how_402 m4_402  

rename new_health_consult_1 m4_403a
rename new_health_consult_2 m4_403b 
rename new_health_consult_3_1_m4 m4_403c

rename name_new_consult_1 m4_404a
rename other_in_east_shewa m4_404a_other_1
rename other_outsidein_east_shewa m4_404a_other_2 
rename name_new_consult_2 m4_404b
rename other_in_east_shewa404b m4_404b_other_1
rename other_outside_east_shew_2 m4_404b_other_2
rename name_new_consult_3 m4_404c
rename other_in_east_shewa404c m4_404c_other_1
rename other_ourside_east_shew_3 m4_404c_other_2
rename q405_pnc_visit1_m4 m4_405

rename q406_reason_visit1_m4___1 m4_406_a
rename q406_reason_visit1_m4___2 m4_406_b
rename q406_reason_visit1_m4___3 m4_406_c
rename q406_reason_visit1_m4___4 m4_406_d
rename q406_reason_visit1_m4___5 m4_406_e
rename q406_reason_visit1_m4___6 m4_406_f
rename q406_reason_visit1_m4___7 m4_406_g
rename q406_reason_visit1_m4___8 m4_406_h
rename q406_reason_visit1_m4___9 m4_406_i
rename q406_reason_visit1_m4___10 m4_406_j
rename q406_reason_visit1_m4___96 m4_406_96
rename q406_reason_visit1_m4___998 m4_406_998
rename q406_reason_visit1_m4___999 m4_406_999
rename q406_reason_visit1_m4___888 m4_406_888
rename q406_other_visit1_m4 m4_406_other

rename q407_pnc_visit2_m4 m4_407

rename q408_reason_visit2_m4___1 m4_408_a
rename q408_reason_visit2_m4___2 m4_408_b
rename q408_reason_visit2_m4___3 m4_408_c
rename q408_reason_visit2_m4___4 m4_408_d
rename q408_reason_visit2_m4___5 m4_408_e
rename q408_reason_visit2_m4___6 m4_408_f
rename q408_reason_visit2_m4___7 m4_408_g
rename q408_reason_visit2_m4___8 m4_408_h
rename q408_reason_visit2_m4___9 m4_408_i
rename q408_reason_visit2_m4___10 m4_408_j
rename q408_reason_visit2_m4___96 m4_408_96
rename q408_reason_visit2_m4___998 m4_408_998
rename q408_reason_visit2_m4___999 m4_408_999
rename q408_reason_visit2_m4___888 m4_408_888
rename q408_other_visit2_m4 m4_408_other

rename q409_pnc_visit3_m4 m4_409

rename q410_reason_visit3_m4___1 m4_410_a
rename q410_reason_visit3_m4___2 m4_410_b
rename q410_reason_visit3_m4___3 m4_410_c
rename q410_reason_visit3_m4___4 m4_410_d
rename q410_reason_visit3_m4___5 m4_410_e
rename q410_reason_visit3_m4___6 m4_410_f
rename q410_reason_visit3_m4___7 m4_410_g
rename q410_reason_visit3_m4___8 m4_410_h
rename q410_reason_visit3_m4___9 m4_410_i
rename q410_reason_visit3_m4___10 m4_410_j
rename q410_reason_visit3_m4___96 m4_410_96
rename q410_reason_visit3_m4___998 m4_410_998
rename q410_reason_visit3_m4___999 m4_410_999
rename q410_reason_visit3_m4___888 m4_410_888

rename q410_other_visit3_m4 m4_410_other

rename on_what_day_did_the_1st_ne m4_411a
rename on_what_day_did_the_2nd_ne m4_411b
rename on_what_day_did_the_3rd_ne m4_411c

rename for_how_long_conslt_1 m4_412a
rename for_how_long_conslt_2 m4_412b
rename for_how_long_conslt_3 m4_412c

rename m4_413___0 m4_413_a
rename m4_413___1 m4_413_b
rename m4_413___2 m4_413_c
rename m4_413___3 m4_413_d
rename m4_413___4 m4_413_e
rename m4_413___5 m4_413_f
rename m4_413___6 m4_413_g
rename m4_413___7 m4_413_h
* m4_413___8 is not in the DS and in the CB
rename m4_413___9 m4_413_i
rename m4_413___10 m4_413_j
rename m4_413___11 m4_413_k
rename m4_413___96 m4_413_96
rename m4_413___99 m4_413_99
rename m4_413___998 m4_413_998
rename m4_413___999 m4_413_999
rename m4_413___888 m4_413_888

rename specify_other_reasons_that m4_413_other

rename rate_quality_of_consult_1 m4_501

rename rate_quality_of_consult_2 m4_502

rename rate_quality_of_consult_3 m4_503

rename q601_baby1_temp_m4 m4_601a_1
rename q601_baby2_temp_m4 m4_601a_2
rename q601_baby3_temp_m4 m4_601a_3
rename q601_baby1_weight_m4 m4_601b_1
rename q601_baby2_weight_m4 m4_601b_2
rename q601_baby3_weight_m4 m4_601b_3
rename q601_baby1_length_m4 m4_601c_1
rename q601_baby2_length_m4 m4_601c_2
rename q601_baby2_length_m5 m4_601c_3
rename q601_baby1_eyes_m4 m4_601d_1
rename q601_baby2_eyes_m4 m4_601d_2
rename q601_baby3_eyes_m4 m4_601d_3
rename q601_baby1_hearing_m4 m4_601e_1
rename q601_baby2_hearing_m4 m4_601e_2
rename q601_baby3_hearing_m4 m4_601e_3
rename q601_baby1_chest_m4 m4_601f_1
rename q601_baby2_chest_m4 m4_601f_2
rename q601_baby3_chest_m4 m4_601f_3
rename q601_blood_prick_baby1_m4 m4_601g_1
rename q601_blood_prick_baby2_m4 m4_601g_2
rename q601_blood_prick_baby3_m4 m4_601g_3
rename q601_malaria_baby1_m4 m4_601h_1
rename q601_malaria_baby2_m4 m4_601h_2
rename q601_malaria_baby3_m4 m4_601h_3
rename q601_othertest_baby1_m4 m4_601i_1
rename q601_testspecify_baby1_m4 m4_601i_1_other
rename q601_othertest_baby2_m4 m4_601i_2
rename q601_testspecify_baby2_m4 m4_601i_2_other
rename q601_othertest_baby3_m4 m4_601i_3
rename q601_testspecify_baby3_m4 m4_601i_3_other

rename baby1hiv m4_618a_1
rename baby_hiv_result m4_618b_1
rename given_medication_baby_1 m4_618c_1 
rename baby2hiv m4_618a_2
rename baby2_hiv_result m4_618b_2
rename given_medication_baby_2 m4_618c_2
rename given_medication_baby_4 m4_618a_3
*the variable name is given medication_4 but the question is if the baby 3 was tested for HIV 
rename given_medication_baby_5 m4_618b_3
*the variable name is given medication_4 but the question is about the result of the HIV test 
rename given_medication_baby_3 m4_618c_3

rename how_often_baby_eats_602a m4_602a
rename what_baby_should_eat_602b m4_602b
rename vaccination_for_baby_602c m4_602c
rename position_baby_sleep_602d m4_602d
rename danger_signs_you_watch_602e m4_602e
rename how_you_play_with_baby_602f m4_602f
rename take_baby_to_hospital_602g m4_602g

rename what_healthcare_provide_603___0 m4_603_1_0
rename what_healthcare_provide_603___1 m4_603_1_1
rename what_healthcare_provide_603___2 m4_603_1_2
rename what_healthcare_provide_603___3 m4_603_1_3
rename what_healthcare_provide_603___4 m4_603_1_4
rename what_healthcare_provide_603___5 m4_603_1_5
rename what_healthcare_provide_603___6 m4_603_1_6
rename what_healthcare_provide_603___96 m4_603_1_96
rename what_healthcare_provide_603___98 m4_603_1_98
rename what_healthcare_provide_603___99 m4_603_1_99
rename v1544 m4_603_1_998 
rename v1545 m4_603_1_999 
rename what_healthcare_provide_603___88 m4_603_1_888
rename other_thing_provided m4_603_1_other

rename m4_603b___0 m4_603_2_0
rename m4_603b___1 m4_603_2_1
rename m4_603b___2 m4_603_2_2
rename m4_603b___3 m4_603_2_3
rename m4_603b___4 m4_603_2_4
rename m4_603b___5 m4_603_2_5
rename m4_603b___6 m4_603_2_6
rename m4_603b___96 m4_603_2_96
rename m4_603b___98 m4_603_2_98
rename m4_603b___99 m4_603_2_99
rename m4_603b___998 m4_603_2_998
rename m4_603b___999 m4_603_2_999 
rename m4_603b___888 m4_603_2_888
rename other_thing_provided_2 m4_603_2_other

rename m4_603c___0 m4_603_3_0
rename m4_603c___1 m4_603_3_1
rename m4_603c___2 m4_603_3_2
rename m4_603c___3 m4_603_3_3
rename m4_603c___4 m4_603_3_4
rename m4_603c___5 m4_603_3_5
rename m4_603c___6 m4_603_3_6
rename m4_603c___96 m4_603_3_96
rename m4_603c___98 m4_603_3_98
rename m4_603c___99 m4_603_3_99
rename m4_603c___998 m4_603_3_998
rename m4_603c___999 m4_603_3_999
rename m4_603c___888 m4_603_3_888
rename other_thing_provided_3 m4_603_3_other

rename bp_measured_701a m4_701a
rename temperature_taken_702b m4_701b
rename vaginal_exam_701c m4_701c
rename blood_draw_701d m4_701d
rename blood_test_using_finger_701e m4_701e
rename hiv_test_701f m4_701f
rename urine_test_701g m4_701g
rename any_other_test_701h m4_701h
rename specify_any_other_test m4_701h_other
rename c_section_scar_702 m4_702

rename since_the_delivery_did_703a m4_703a
rename danger_sign_or_symptom_703b m4_703b
rename level_of_anxiety_703c m4_703c
rename family_planning_703d m4_703d
rename resuming_sexual_703e m4_703e
rename importance_of_exercise_703f m4_703f
rename sleeping_importance_703g m4_703g

rename psychological_counseling_704a m4_704a
rename how_many_of_these_sessio_704b m4_704b
rename c_how_many_minutes_did_thi m4_704c

rename iron_or_folic_acid_801a m4_801a
rename iron_injection_801b m4_801b
rename since_we_last_spoke_did_801c m4_801c
rename since_we_last_spoke_did_801d m4_801d
rename since_we_last_spoke_did_801e m4_801e
rename since_we_last_spoke_801f m4_801f
rename since_we_last_spoke_801g m4_801g
rename since_we_last_spoke_801h m4_801h
rename since_we_last_spoke_801i m4_801i
rename since_we_last_spoke_801j m4_801j
rename since_we_last_spoke_801k m4_801k
rename since_we_last_spoke_801l m4_801l
rename since_we_last_spoke_801m m4_801m
rename since_we_last_spoke_801n m4_801n
rename since_we_last_spoke_801o m4_801o
rename since_we_last_spoke_801p m4_801p
rename since_we_last_spoke_801q m4_801q
rename since_we_last_spoke_801r m4_801r
rename specify_what_you_get_801 m4_801r_other 

rename q802_baby1_iron m4_802a_1
rename q802_baby2_iron_m4 m4_802a_2
rename q802_baby3_iron_m4 m4_802a_3 

rename q802_baby1_vita_m4 m4_802b_1
rename q802_baby2_vita_m4 m4_802b_2
rename q802_baby3_vita_m4 m4_802b_3

rename q802_baby1_vitd_m4 m4_802c_1
rename q802_baby2_vitd_m4 m4_802c_2
rename q802_baby3_vitd_m4 m4_802c_3

rename q802_ors_baby1_m4 m4_802d_1
rename q802_ors_baby2_m4 m4_802d_2
rename q802_ors_baby3_m4 m4_802d_3

rename q802_baby1_antiseptic_m4 m4_802e_1
rename q802_baby2_antiseptic_m4 m4_802e_2
rename q802_baby3_antiseptic_m4 m4_802e_3

rename q802_abx_baby1_m4 m4_802f_1
rename q802_abx_baby2_m4 m4_802f_2
rename q802_abx_baby3_m4 m4_802f_3

rename q802_pneummed_baby1_m4 m4_802g_1
rename q802_pneummed_baby2_m4 m4_802g_2
rename q802_pneummed_baby3_m4 m4_802g_3

rename q802_baby1_malmed_m4 m4_802h_1
rename q802_baby2_malmed_m4 m4_802h_2
rename q802_baby3_malmed_m4 m4_802h_3

rename q802_baby1_hivmed_m4 m4_802i_1
rename q802_baby2_hivmed_m4 m4_802i_2
rename q802_baby3_hivmed_m4 m4_802i_3

rename q802_othermed_baby1_m4 m4_802j_1
rename q803_othermedspec_baby1_m4 m4_802j_1_other

rename q802_othermed_baby2_m4 m4_802j_2
rename q803_othermedspec_baby2_m4 m4_802j_2_other

rename q802_othermed_baby3_m4 m4_802j_3
rename q803_othermedspec_baby3_m4 m4_802j_3_other

rename q803_bcg_baby1_m4 m4_803a_1
rename q803_bcg_baby2_m4 m4_803a_2
rename q803_bcg_baby3_m4 m4_803a_3

rename q803_polio_baby1_m4 m4_803b_1
rename q803_polio_baby2_m4 m4_803b_2
rename q803_polio_baby3_m4 m4_803b_3

rename q803_penta_baby1_m4 m4_803c_1
rename q803_penta_baby2_m4 m4_803c_2
rename q803_penta_baby3_m4 m4_803c_3

rename q803_pneumococcal_baby1_m4 m4_803d_1
rename q803_pneumococcal_baby2_m4 m4_803d_2
rename q803_pneumococcal_baby3_m4 m4_803d_3

rename q803_rotavirus_baby1_m4 m4_803e_1
rename q803_rotavirus_baby2_m4 m4_803e_2
rename q803_rotavirus_baby3_m4 m4_803e_3

rename q803_othervax_baby1_m4 m4_803f_1
rename q803_othervax_baby2_m4 m4_803f_2
rename q803_othervax_baby3_m4 m4_803f_3

rename q804_othervaxspec_baby1_m4 m4_803g_1
rename q804_othervaxspec_baby2_m4 m4_803g_2
rename q804_othervaxspec_baby3_m4 m4_803g_3

rename q804_vaxloc_baby1_m4 m4_804_1
rename q804_vaxloc_baby2_m4 m4_804_2
rename q804_vaxloc_baby3_m4 m4_804_3 

rename in_total_how_much_did_805 m4_805
rename q901_oop_m4 m4_901 
rename q902_registration_m4 m4_902a
rename money_did_you_spend_registration m4_902a_amt
rename q902_tests_m4 m4_902b
rename how_much_money_did_903a m4_902b_amt
rename q902_transport_m4 m4_902c
rename how_much_money_did_902c m4_902c_amt
rename q902_food_m4 m4_902d
rename how_much_money_did_you_902d m4_902d_amt
rename did_you_spend_money_902e m4_902e
rename how_much_money_did_you_902e m4_902e_amt
rename so_how_much_in_total_903 m4_903
rename so_how_much_in_total_904 m4_904
rename m4_905___1 m4_905_1
rename m4_905___2 m4_905_2
rename m4_905___3 m4_905_3
rename m4_905___4 m4_905_4
rename m4_905___5 m4_905_5
rename m4_905___6 m4_905_6
rename m4_905___96 m4_905_96
rename m4_905___998 m4_905_998
rename m4_905___999 m4_905_999
rename m4_905___888 m4_905_888
rename specify_other_sources_of_905 m4_905_other 
rename outcme_of_the_phone_call m4_ot1
rename specify_other_sources_of_906 m4_ot1_oth
rename conclusion_dead_baby_m4 m4_conclusion_dead_baby
rename module_4_follow_up_phone_survey_ m4_complete


	* MATERNAL CARDS:
rename (q1501 date age gravid lmp edd para number_of_children_alive previous_stillbirth ///
		history_of_3 birthweight2500 birthweight4000 last_pregnancy previous_survey) ///
	    (mcard_consent mcard_date mcard_age mcard_gravid mcard_lmp mcard_edd mcard_para ///
		mcard_number_of_children_alive mcard_previous_stillbirth mcard_hsitory mcard_babywgt2500 ///
		mcard_babywgt4000 mcard_last_preg mcard_prev_survey)

rename (diagnosed age_less_than_16_years age_more_than_40_years isoimmunization vaginal_bleeding ///
		pelvic_mass diastolic diabetes_mellitus renal_disease chronic_hypertension substance_abuse ///
		other_medical_disease pallor jaundice chest_abn___0) (mcard_dx mcard_age16 mcard_age40 mcard_iso ///
		mcard_vag_bleed mcard_pelvic_mass mcard_diastolic mcard_dm mcard_renal mcard_htn mcard_sub_abuse ///
		mcard_other_dx mcard_pallor mcard_jaundice mcard_chest_abn_no)

rename (chest_abn___1 chest_abn___998 chest_abn___999 chest_abn___888 heart_abnormality valvar_ulcer ///
		vaginal_discharge pelvic_mass1 uterine_size cervical_lesion danger_signs_in_pregnancy ///
		delivery_advised birth_preparedness_advised mother_hiv_test_accepted hiv_test_result) ///
		(mcard_chest_abn_yes mcard_chest_abn_unk mcard_chest_abn_ref mcard_chest_abn_no_info ///
		mcard_heart_abnormality mcard_valvar_ulcer mcard_vaginal_dis mcard_pelvic_mass1_ ///
		mcard_uterine_size mcard_cervical_lesion mcard_danger_signs mcard_delivery_advised ///
		mcard_birth_prep mcard_mother_hiv_test mcard_hiv_test_result)

rename (hiv_test_result_receive counseled_infant_feeding referred_for_care partner_hiv_test_result ///
		date_of_visit gestation_age_lmp bp_systolic bp_diastolic weight_kg_v1 pallor_v1 fetal_heartbeat ///
		presentation urine_test_for_infection urine_test_for_protein rapid_syphilis_test) ///
		(mcard_hiv_counsel mcard_feed_counsel mcard_referred mcard_partner_hiv_test mcard_fu_visit ///
		mcard_ga_lmp mcard_bp_systolic mcard_bp_diastolic mcard_weight mcard_pallor2 mcard_fetal_heartbeat ///
		mcard_presentation mcard_urine_infection mcard_urine_protein mcard_syphilis_test)

rename (hemoglobin blood_group_and_rh tt_does iron_folic_acid mbendazole use_of_itn arv_px_type remarks ///
		danger_signs action_advice_counseling appointment_next maternal_integrated_cards_comple) ///
		(mcard_hemoglobin mcard_bloodgrp mcard_tt_doses mcard_iron mcard_mbendazole mcard_use_of_itn ///
		mcard_arv_px_type mcard_remarks mcard_danger_signs2 mcard_action_advice_counseling ///
		mcard_next_appt mcard_complete)
		
*------------------------------------------------------------------------------*

* dropping people with incomplete M2 surveys	
		
egen m2_drop = rowtotal(m2_201 m2_202 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_205a m2_205b m2_205c m2_205d m2_205e m2_205f m2_205g m2_205h m2_205i m2_206 m2_207 m2_208 m2_301 m2_302 m2_303a m2_303b m2_303c m2_303d m2_303e m2_304a m2_304b m2_304c m2_304d m2_304e m2_305 m2_306 m2_306_1 m2_306_2 m2_306_3 m2_306_4 m2_306_5 m2_306_96 m2_306_888_et m2_306_998_et m2_306_999_et m2_308 m2_308_1 m2_308_2 m2_308_3 m2_308_4 m2_308_5 m2_308_96 m2_308_888_et m2_308_998_et m2_308_999_et m2_309 m2_311 m2_311_1 m2_311_2 m2_311_3 m2_311_4 m2_311_5 m2_311_96 m2_311_888_et m2_311_998_et m2_311_999_et m2_312 m2_314 m2_314_1 m2_314_2 m2_314_3 m2_314_4 m2_314_5 m2_314_96 m2_314_888_et m2_314_998_et m2_314_999_et m2_315 m2_317 m2_317_1 m2_317_2 m2_317_3 m2_317_4 m2_317_5 m2_317_96 m2_317_888_et m2_317_998_et m2_317_999_et m2_318 m2_320_a m2_320_b m2_320_c m2_320_d m2_320_e m2_320_f m2_320_g m2_320_h m2_320_i m2_320_j m2_320_k m2_320_l m2_320_96 m2_320_99 m2_320_888_et m2_320_998_et m2_320_999_et m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_last m2_508b_number m2_508c m2_508d m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_602b m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_703 m2_704 m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 m2_705_888_et m2_705_998_et m2_705_999_et) 

drop if m2_drop == 0 & redcap_event_name == "module_2_arm_1"

drop m2_drop	


*===============================================================================
* Fixing gestational age:
/* Gestational age at ANC1:
			Here we should recalculate the GA based on LMP (m1_802c and self-report m1_803 */
			gen m1_ga = m1_802d_et // GA based on LNMP
			recode m1_803 98=.
			replace m1_ga = m1_803 if m1_ga == . // ga based on self report of weeks pregnant if LMP not known
			lab var m1_ga "Gestional age based on LNMP (calc)"
			
			recode m1_ga (1/12.99999 = 1) (13/26.99999= 2) (27/50=3), gen(m1_trimester)
			lab def trimester2 1"1st trimester 0-12wks" 2"2nd trimester 13-26 wks" 3 "3rd trimester 27-42 wks"
			lab val m1_trimester trimester2 	
			
			*Carryfoward:
			by redcap_record_id: carryforward m1_ga m1_803, replace
				
* Gestational age at follow-ups M2-M3:
	* First, dropping ga vars from redcap (both LNMP and maternal estimation):
	* raw var names: m2_107 m2_107b_ga m3_ga1 ga_birth_mat_estimated
	drop m2_ga m2_ga_estimate m3_ga1 m3_ga2
	
	* Recalculated gestational age (Gestational age @ ANC1 + weeks since ANC1):
		*format date vars:
		*Date of M1
		gen _m1_date_ = date(m1_date,"YMD")
		drop m1_date
		rename _m1_date_ m1_date
		format m1_date %td	
		
		*Date of M2
		gen _m2_date_ = date(m2_date,"YMD")
		drop m2_date
		rename _m2_date_ m2_date
		format m2_date %td
	
		*Date of M3
		gen _m3_date_ = date(m3_date,"YMD")
		drop m3_date
		rename _m3_date_ m3_date
		format m3_date %td
		
		*calculate weeks since ANC1:
		*M2 (need last date):
		by redcap_record_id: egen m2_lastdate = max(m2_date)
		format m2_lastdate %td
		
		generate time_between_m1m2 = (m2_lastdate - m1_date)/7
		generate time_between_m1m3 = (m3_date - m1_date)/7
		
		*New gestational age vars:
		
		generate m2_ga = m1_ga + time_between_m1m2
		generate m3_ga = m1_ga + time_between_m1m3
	
		drop time_between_m1m2 time_between_m1m3
		
		order m2_lastdate, after(m2_date)
		
		*Extra cleaning from Emma's code:
		* Recode birth dates with data entry errors
		gen _m3_birth_or_ended_ = date(m3_birth_or_ended,"YMD")
		drop m3_birth_or_ended
		rename _m3_birth_or_ended_ m3_birth_or_ended
		format m3_birth_or_ended %td
		
		replace m3_birth_or_ended = date("2023-11-29", "YMD") if redcap_record_id=="1712-65" // fixed year
		replace m3_birth_or_ended = date("2023-12-30", "YMD") if redcap_record_id=="1686-21" // fixed year
		replace m3_birth_or_ended = date("2023-12-25", "YMD") if redcap_record_id=="1697-40" // fixed year
		replace m3_birth_or_ended = date("2023-12-28", "YMD") if redcap_record_id=="1707-38" // fixed year
		replace m3_birth_or_ended = . if redcap_record_id=="1686-1" //date of birth was entered as being before the ANC1
		
*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS 
	** many of these value labels can be found in the "REDCap_STATA.do" file that can be downloaded from redcap

	** MODULE 1:
* Label study site values 

label define woreda 1 "Adama special district (town)" 2 "Dugda" 3 "Bora" 4 "Adami Tulu Jido Kombolcha" 5 "Olenchiti" 6 "Adama" 7 "Lume" 96 "Other, specify" 
label values study_site woreda
label define site 1 "Adama" 2 "East Shewa"

generate site = study_site 
recode site (1 = 1) ///
            (2 3 4 5 6 7 96 = 2)
label values site site 

* create new variable for sampling strata 
** we need to make sure we recode in the cleaning file the facility name and strata for st. fransisco
generate sampstrata = facility
recode sampstrata (2 3 4 5 6 8 9 10 11 14 16 17 19 = 1) (18 7 = 2) (22 13 15 1 12 23 96 = 3) (20 21 = 4) 
label values sampstrata strata

* Label Facility Name values 
label define FacilityLabel 1 "Meki Catholic Primary Clinic (01)" 2 "Bote Health Center (02)" 3 "Meki Health Center (03)" 4 "Adami Tulu Health Center (04)" 5 "Bulbula Health Center (05)" 6 "Dubisa Health Center (06)" 7 "Olenchiti Primary Hospital (07)" 8 "Awash Malkasa Health Center (08)" 9 "koka Health Center (09)" 10 "Biyo Health Center (10)" 11 "Ejersa Health Center (11)" 12 "Catholic Church Primary Clinic (12)" 13 "Noh Primary Clinic (13)" 14 "Adama Health Center (14)" 15 "Family Guidance Nazret Specialty Clinic (15)" 16 "Biftu (16)" 17 "Bokushenen (17)" 18 "Adama Teaching Hospital (18)" 19 "Hawas (19)" 20 "Medhanialem Hospital (20)" 21 "Sister Aklisiya Hospital (21)" 22 "Marie stopes Specialty Clinic (22)" 96 "Other in East Shewa or Adama (23)" 
label values facility FacilityLabel

* Label Sampling Strata 
label define strata 1 "Public Primary" 2 "Public Secondary" 3 "Private Primary" 4 "Private Secondary" 

* Label Facility Type values  
label define FacilityTypeLabel 1 "General Hospital" 2 "Primary Hospital" 3 "Health center" 4 "MCH Specialty Clinic/Center" 5 "Primary clinic" 
label values facility_type FacilityTypeLabel 

recode zone_live (96 = 9)
label define zone_live 1 "Adama special district (town)"  2	"Dugda" 3 "Bora" ///
					   4 "Adami Tulu Jido Kombolcha"  5	"Olenchiti" 6 "Adama" ///
					   7 "Lume" 8 "Another district in East Shewa zone" 9 "Outside of East Shewa and Adama town"
label values zone_live zone_live					   

label define reason_anc 1 "Low cost" 2 "Short distance" 3 "Short waiting time" 4 "Good healthcare provider skills" 5 "Staff shows respect" 6 "Medicines and equipment are available" 7 "Cleaner facility" 8 "Only facility available" 9 "covered by CBHI" 10 "Were referred or told to use this provider" 11 "Covered by other insurance" 96 "Other, specify" 99 "NR/RF" 
label values m1_405 reason_anc

recode flash (4 = 1) (5 = 2)
*label define flash 1 "Flash successful" 2 "Flash unsuccessful" 3 "Respondent did not give permission for flash"
label values flash flash

recode m1_203_et b5anc b6anc_first b6anc_first_conf continuecare (2 = 0)
label values m1_203_et b5anc b6anc_first b6anc_first_conf continuecare YN

* Demographic value labels 
label define language 1 "Oromiffa" 2 "Amharegna" 3 "Somaligna" 4 "Tigrigna" 5 "Sidamigna" 6 "Wolaytigna" 7 "Gurage" 8 "Afar" 9 "Hadiyya" 10 "Gamogna" 11 "Gedeo" 12 "Kafa" 96 "Other, specify" 98 "DK" 99 "NR/RF" 
label values m1_501 language

label define education 1 "Some primary" 2 "Completed primary" 3 "Some secondary" 4 "Completed secondary" 5 "Higher education" 99 "NR/RF" 
label values m1_503 education

label define literacy 1 "Cannot read at all" ///
	                  2 "Able to read only parts of sentence" 3 "Able to read whole sentence" 4 "Blind/visually impaired" ///
					  99 "NR/RF" 
label values m1_504 literacy

label define marriage 1 "Never married" 2 "Widowed" 3 "Divorced" 4 "Separated" 5 "Currently married" 6 "Living with partner as if married" 99 "NR/RF" 
label values m1_505 marriage 

label define occupation 1 "Government employee" 2 "Private employee" 3 "Non-government employee" 4 "Merchant/Trader" 5 "Farmer/farmworker/pastoralist" 6 "Homemaker/housewife" 7 "Student" 8 "Laborer" 9 "Unemployed" 96 "Other, specify" 98 "DK" 99 "NR/RF"
label values m1_506 occupation
 
label define religion 1 "Orthodox" 2 "Catholic" 3 "Protestant" 4 "Muslim" 5 "Indigenous" 96 "Other, specify" 98 "DK" 99 "RF"
label values m1_507 religion

label define eligconsent 1 "Eligible and signed consent" 2 "Eligible but did not consent" 3 "Eligible but does not understand [language spoken by interviewer" 0 "Ineligible" 
label values b7eligible eligconsent

label define modcomplete 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label values m1_complete modcomplete

label define flash 1 "Flash successful" 2 "Unsuccessful, reenter phone number" 3 "Respondent did not give permission for flash"
label values m1_513c flash

label define residence 1 "Temporary" 2 "Permanent"
label values m1_517 residence

   ** Repeated Data Value Labels 
   * Label likert scales 
     label define likert 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" ///
	 99 "Refused"
	 
     * Label values for variables with Likert values 
	   label values m1_201 m1_301 m1_601 likert 
	   label values m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_605i_et m1_605j_et m1_605k_et likert
	   	 
   * Label Yes/No 
	 label define YN 1 "Yes" 0 "No" 3 "Not applicable" 98 "DK" 99 "RF" 
	 *label define YN2 1 "Yes" 2 "No" 98 "DK" 99 "RF" 
	 label values m1_716a m1_716b m1_716c m1_716d m1_716e YN
   	 label values m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 YN 
	 label values m1_813a m1_813b m1_813c m1_813d m1_813e YN
	 label values m1_904 m1_905 m1_907 YN
	 label values permission YN
	 label values mobile_phone YN
	 label values kebele_intworm kebele_malaria YN

	 	 
	 * Label values for variables with Yes / No responses 
	 label values m1_502 m1_509a m1_509b m1_510a m1_510b m1_514a YN 
	 label values m1_204 YN
   	 label values m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g YN
	 label values m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i YN
	 label values m1_801 m1_802b_et YN
	 label values m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i YN
	 label values m1_1004 m1_1005 m1_1006 m1_1_10_et m1_1007 m1_1008 m1_1010 YN
	 label values m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f YN
	 label values m1_1101 m1_1103 YN
	 label values m1_1217 m1_1218a m1_1218b m1_1218c m1_1218d m1_1218e m1_1218f YN
	 label values m1_1221 YN
	*label values current_income savings health_insurance sold_items family_members borrowed other YN

	 
   * Labels for EQ5D  	 
     label define EQ5D 1 "I have no problems" 2 "I have some problems" 3 "I have severe problems" 99 "NR/RF" 
	 label define EQ5Dpain 1 "I have no pain" 2 "I have some pain" 3 "I have severe pain" 99 "NR/RF" 
	 label define EQ5Danxiety 1 "I have no anxiety" 2 "I have some anxiety" 3 "I have severe anxiety" 99 "NR/RF" 
	 
	 label values m1_205a m1_205b m1_205c EQ5D
	 label values m1_205d EQ5Dpain
	 label values m1_205e EQ5Danxiety
	 
* QoC labels 
	label define recommend 1 "Very likely" 2 "Somewhat likely" 3 "Not too likely" 4 "Not at all likely" 99 "NR/RF" 
	label values m1_602 recommend
   
	label define satisfaction 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" 4 "Dissatisfied" 5 "Very dissatisfied" 98 "DK" 99 "NR/RF" 
	label values m1_1223 satisfaction

	label define diarrhea  1 "Less than usual" 2 "More than usual" 3 "About the same" 4 "It doesnt matter" 98 "DK" 
	label values m1_511 diarrhea 

	label define smoke 1 "Good" 2 "Harmful" 3 "Doesnt matter" 98 "DK" 
	label values m1_512 smoke 

	label define hsview 1 "System works pretty well, minor changes" ///
	                    2 "Some good things, but major changes are needed" ///
						3 "System has so much wrong with it, completely rebuild it" ///
						98 "DK" ///
						99 "RF" 
	label values m1_302 hsview
	
	label define confidence 1 "Very confident" ///
	                        2 "Somewhat confident" ///
							3 "Not very confident" ///
							4 "Not at all confident" ///
							98 "DK" ///
							99 "NR/RF"
	label values m1_303 m1_304 m1_305a m1_305b confidence 

	label define travel_mode 1 "Walking" 2 "Bicycle" 3 "Motorcycle" 4 "Car (personal or borrowed)" 5 "Bus/train/other public transportation" 6 "Mule/horse/donkey" 7 "Bajaj" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	label values m1_401 travel_mode

	label define bypass 1 "Yes, its the nearest" 2 "No, theres another one closer" 98 "DK" 99 "NR/RF" 
	label values m1_404 bypass 
	
	label values m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 YN
	label values m1_712 YN
	label values m1_708a m1_708c m1_708d m1_708e m1_708f m1_710a m1_711a m1_712 YN
	
    label define yesnona 1 "Yes" 0 "No" 2 "Not applicable" 98 "DK" 99 "RF" 
	
	label values m1_704 yesnona
	
	label define test_result 1 "Positive" 2 "Negative" 98 "DK" 99 "RF" 
	label values m1_708b test_result
	label values m1_710b test_result
	label define bdsugartest 1 "Blood sugar was high/elevated" 2 "Blood sugar was normal" 98 "DK" 99 "NR/RF"
	label values m1_711b bdsugartest
	label values m1_708a YN 
    label values m1_711a YN
    label values m1_710a m1_710b YN
	label values m1_708a m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b YN
    label values m1_714a m1_714b YN 
	
	label define meds 1 "Provider gave it directly" 2 "Prescription, told to get it somewhere else" 3 "Neither" 98 "DK" 99 "NR/RF" 
	label values m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i meds

	label define itn 1 "Yes" 0 "No" 2 "Already have one"
	label values m1_715 itn

	label define trimester 1 "First trimester" 2 "Second trimester" 3 "Third trimester" 98 "Unknown" 
	label define numbabies 1 "One baby" 2 "Two babies (twins)" 3 "Three or more babies (triplets or higher)" 98 "DK" 99 "NR/RF"
	label values m1_805 numbabies 
	label values m1_806 m1_807 m1_809 m1_811 m1_812a YN
	label define m1_810a 1 "In your home" 2 "Someone elses home" 3 "Government hospital" 4 "Government health center" 5 "Government health post" 6 "NGO or faith-based health facility" 7 "Private hospital" 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" 10 "Private clinic" 11 "Another private medical facility (including pharmacy, shop, traditional healer)" 98 "DK" 99 "NR/RF" 
	
	label values m1_810a m1_810a

	label define smokeamt 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "NR/RF" 
		
	label values m1_901 m1_903 smokeamt

	label define water_source 1 "Piped water" 2 "Water from open well" 3 "Water from covered well or borehole" 4 "Surface water" 5 "Rain water" 6 "Bottled water" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	
	label values m1_1201 water_source
	
	label define toilet 1 "Flush or pour flush toilet" 2 "Pit toilet/latrine" 3 "No facility" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	
	label values m1_1202 toilet
	
	label values m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 YN
	
	label define cook_fuel 1 "Main electricity" 2 "Bottled gas" 3 "Paraffin/kerosene" 4 "Coal/Charcoal" 5 "Firewood" 6 "Dung" 7 "Crop residuals" 8 "Solar" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	label values m1_1208 cook_fuel
	
	label define floor 1 "Natural floor (earth, dung)" 2 "Rudimentary floor (wood planks, palm)" 3 "Finished floor (polished wood, tiles, cement, vinyl)" 96 "Other (specify)" 98 "DK" 99 "NR/RF"
	
	label values m1_1209 floor 
	
	label define walls 1 "Grass" 2 "Poles and mud" 3 "Sun-dried bricks" 4 "Baked bricks" 5 "Timber" 6 "Cement bricks" 7 "Stones" 8 "Corrugated iron" 96 "Other (specify)" 98 "DK" 99 "NR/RF"
	
	label values m1_1210 walls

	label define roof 1 "No roof" 2 "Grass/leaves/mud" 3 "Iron sheets" 4 "Tiles" 5 "Concrete" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
	label values m1_1211 roof
	
	label values m1_1212 m1_1213 m1_1214 m1_1215 YN

	label define insurance_type 1 "Community based health insurance" 2 "Employer-provided health insurance (reimbursement)" 3 "Private health insurance" 96 "Other (specify)" 98 "DK" 99 "NR/RF"
	label values m1_1221 insurance_type
	
	** MODULE 2:
	
	label define m2_attempt_relationship 1 "Family member" 2 "Friend/Neighbor" 3 "Colleague" 4 "Does not know the respondent" 5 "Other, specify"
	label values m2_attempt_relationship m2_attempt_relationship
	
	label define m2_start 1 "Yes" 0 "No" 
	label values m2_start m2_start
	
	label define m2_permission 1 "Yes" 0 "No" 
	label values m2_permission
	
	label define maternal_death_reported 1 "Yes" 0 "No" 
	label values m2_maternal_death_reported maternal_death_reported
	
	label define m2_hiv_status 1 "Positive" 2 "Negative" 3 "Unknown" 
	label values m2_hiv_status m2_hiv_status
	
	label define m2_maternal_death_learn 1 "Called respondent phone, someone else responded" ///
									  2 "Called spouse/partner phone, was informed" ///
									  3 "Called close friend or family member phone number, was informed" ///
									  4 "Called CHW phone number, was informed" 5 "Other"
	label values m2_maternal_death_learn m2_maternal_death_learn
	
	label define m2_201 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF/NR" 
	label values m2_201 m2_201

	label define m2_202 1 "Yes, still pregnant" 2 "No, delivered" 3 "No, something else happened" 
	label values m2_202 m2_202

	label define m2_203a 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203a m2_203a
	
	label define m2_203b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_203b m2_203b

	label define m2_203c 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203c m2_203c

	label define m2_203d 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203d m2_203d

	label define m2_203e 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203e m2_203e

	label define m2_203f 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203f m2_203f
	
	label define m2_203g 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203g m2_203g

	label define mx2_203h 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203h m2_203h

	label define m2_203i 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203i m2_203i

	label define m2_204a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204a m2_204a

	label define m2_204b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204b m2_204b
	
	label define m2_204c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204b m2_204b
	
	label define m2_204d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204d m2_204d

	label define m2_204e 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_204e m2_204e

	label define m2_204f 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204f m2_204f
 
	label define m2_204g 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204g m2_204g

	label define m2_204h 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204h m2_204h

	label define m2_204i 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_204i m2_204i

	label define m2_205a 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 
	label values m2_205a m2_205a

	label define m2_205b 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 
	label values m2_205b m2_205b

	label define m2_205_ 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF"
	label values m2_205c m2_205c

	label define m2_205d 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205d m2_205d

	label define m2_205e 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF"
	label values m2_205e m2_205e

	label define m2_205f 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205f m2_205f

	label define m2_205g 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205g m2_205g

	label define m2_205h 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205h m2_205h

	label define m2_205i 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "NR/RF" 
	label values m2_205i m2_205i

	label define m2_206 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF" 
	label values m2_206 m2_206

	label define m2_207 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF" 
	label values m2_207 m2_207

	label define m2_208 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "RF" 
	label values m2_208 m2_208

	label define m2_301 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_301 m2_301

	label define m2_302 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 
	label values m2_302 m2_302

	label define m2_303a 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF" 
	label values m2_303a m2_303a

	label define m2_303b 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF" 
	label values m2_303b m2_303b
					 
	label define m2_303c 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF"
	label values m2_303c m2_303c
					 
					 
	label define m2_303d 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF"
	label values m2_303d m2_303d
					 		
	label define m2_303e 1 "In your home" 2 "Someone elses home" 3 "Government hospital" ///
					 4 "Government health center" 5 "Government health post" ///
					 6 "NGO or faith-based health facility" 7 "Private hospital" ///
					 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
					 10 "Private clinic" ///
					 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					 98 "DK" 99 "RF" 
	label values m2_303e m2_303e			 
	
	label define m2_304a 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify"
	label values m2_304a m2_304a

	label define m2_304b 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify"
	label values m2_304b m2_304b

	label define m2_304c 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify"
	label values m2_304c m2_304c

	label define m2_304d 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify" 	
	label values m2_304d m2_304d

	label define m2_304e 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify" 
	label values m2_304e m2_304e

	label define m2_305 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_305 m2_305
	
	label define m2_306 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_306 m2_306

	label define m2_308 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_308 m2_308

	label define m2_309 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_309 m2_309
	
	label define m2_311 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_311 m2_311
 
	label define m2_312 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_312 m2_312

	label define m2_314 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"  
	label values m2_314 m2_314
	
	label define m2_315 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_315 m2_315

	label define m2_317 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"
	label values m2_317 m2_317

	label define m2_318 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_318 m2_318 

	label define m2_321 0 "No" 1 "Yes, by phone" 2 "Yes, by SMS" 3 "Yes, by web" 98 "DK" 99 "NR/RF" 
	label values m2_321 m2_321

	label define m2_401 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_401 m2_401

	label define m2_402 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_402 m2_402
		
	label define m2_403 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_403 m2_403
	
	label define m2_404 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF"  
	label values m2_404 m2_404
	
	label define m2_405 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF" 
	label values m2_405 m2_405
	
	label define m2_501a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501a m2_501a

	label define m2_501b 1 "Yes" 0 "No" 98 "DK" 99 "RF"  
	label values m2_501b m2_501b
	
	label define m2_501c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501c m2_501c
	
	label define m2_501d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501d m2_501d
	
	label define m2_501e 1 "Yes" 0 "No" 98 "DK" 99 "RF"  
	label values m2_501e m2_501e
	
	label define m2_501f 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_501f m2_501f
	
	label define m2_501g 1 "Yes" 0 "No" 98 "DK" 99 "RF"  
	label values m2_501g m2_501g
	
	label define m2_502 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_502 m2_502
	
	label define m2_503a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_503a m2_503a
	
	label define m2_503b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_503b m2_503b
	
	label define m2_503c 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503c m2_503c
		
	label define m2_503d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_503d m2_503d
	
	label define m2_503e 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503e m2_503e

	label define m2_503f 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503f m2_503f
	
	label define m2_504 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_504 m2_504
	
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

	label define m2_506a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_506a m2_506a
	
	label define m2_506b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_506b m2_506b
	
	label define m2_506c 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_506c m2_506c
	
	label define m2_506d 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_506d m2_506d
	
	label define m2_507 0 "Nothing I did not speak about this with a health care provider" ///
						1 "Told you to come back later" ///
						2 "Told you to get a lab test or imaging (e.g., blood tests, ultrasound, x-ray, heart echo)" ///
						3 "Told you to go to hospital or see a specialist like an obstetrician or gynecologist" ///
						4 "Told you to take painkillers like acetaminophen" ///
						5 "Told you to wait and see" ///
						96 "Other, specify" ///
						98 "DK" 99 "RF" 
	label values m2_507 m2_507
	
	label define m2_508a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508a m2_508a
	
	label define m2_508b_number 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508b_number m2_508b_number

	label define m2_508b_last 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508b_last m2_508b_last
	
	label define m2_508c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508c m2_508c

	label define m2_509a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_509a m2_509a
	
	label define m2_509b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_509b m2_509b
	
	label define m2_509c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_509c m2_509c
	
	label define m2_601a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601a m2_601a
	
	label define m2_601b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601b m2_601b
	
	label define m2_601c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601c m2_601c
	
	label define m2_601d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601d m2_601d
	
	label define m2_601e 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_601e m2_601e
	
	label define m2_601f 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601f m2_601f
	
	label define m2_601g 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601g m2_601g
	
	label define m2_601h 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601h m2_601h
	
	label define m2_601i 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601i m2_601i
	
	label define m2_601j 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601j m2_601j
	
	label define m2_601k 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601k m2_601k
	
	label define m2_601l 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601l m2_601l
	
	label define m2_601m 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601m m2_601m

	label define m2_601n 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601n m2_601n

	label define m2_602a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_602a m2_602a

	label define m2_603 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_603 m2_603
	
	label define m2_604 1 "Every day" 2 "Every other day" 3 "Once a week" 4 "Less than once a week" 98 "DK" 99 "NR/RF" 
	label values m2_604 m2_604

	label define m2_701 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_701 m2_701

	label define m2_702a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702a m2_702a

	label define m2_702b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702b m2_702b

	label define m2_702c 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702c m2_702c

	label define m2_702d 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702d m2_702d

	label define m2_702e 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_702e m2_702e

	label define m2_704 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_704 m2_704

label define m2_interview_inturrupt 1 "Yes" 0 "No" 
label values m2_interview_inturrupt m2_interview_inturrupt

label define m2_interview_restarted_ 1 "Yes" 0 "No" 
label values m2_interview_restarted m2_interview_restarted

label define m2_endstatus 1 "Active follow-up" 2 "Lost to follow-up" 3 "Decline further participation" 4 "Maternal death" 5 "No longer pregnant"
label values m2_endstatus m2_endstatus


	* MODULE 3:

label define YN_m3 1 "Yes" 0 "No"
label values m3_start_p1 m3_permission m3_baby1_born_alive m3_baby2_born_alive ///
			 m3_baby3_born_alive m3_508 m3_start_p2 m3_permission_p2 m3_803j m3_808a ///
			 m3_1103_confirm YN_m3

label define m3_303a 1 "One" 2 "Two" 3 "Three or more" 98 "Don't Know" 99 "NR/RF"
label values m3_303a m3_303a
	
label define YNRF 1 "Yes" 0 "No" 99 "NR/RF"
label values m3_303b m3_303c m3_303d m3_505a m3_517 YNRF

label define m3_gender 1 "Male" 2 "Female" 99 "NR/RF"
label values m3_baby1_gender m3_baby2_gender m3_baby3_gender m3_gender
	
label define m3_weight 1 "Very large" 2 "Larger than average" 3 "Average" ///
					   4 "Smaller than average" 5 "Very small"
label values m3_baby1_weight m3_baby2_weight m3_baby3_weight m3_weight
	
label define m3_overallhealth 1 "Excellent" 2 "Very Good" 3 "Good" ///
							  4 "Fair" 5 "Poor" 99 "NR/RF"
label values m3_baby1_health m3_baby2_health m3_baby3_health m3_1001 ///
			 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f ///
			 m3_1004g m3_1004h m3_overallhealth	

label define m3_confidence 1 "Very confident" 2 "Confident" 3 "Somewhat confident" ///
						   4 "Not very confident" 5 "Not at all confident" ///
						   96 "I do not breastfeed" 98 "DK" 99 "NR/RF"
label values m3_breastfeeding m3_confidence
	
label define m3_202	3 "Delivered with still birth" 4 "Miscarriage" 5 "Abortion"
label values m3_202 m3_202

label define YNDKRF 1 "Yes" 0 "No" 98 "Don't Know" 99 "NR/RF"
label values m3_1201 m3_1203 m3_401 m3_consultation_1 m3_consultation_referral_1 ///
			 m3_consultation_2 m3_consultation_referral_2 ///
			 m3_consultation_3 m3_consultation_referral_3 ///
			 m3_consultation_4 m3_consultation_referral_4 ///
			 m3_consultation_5 m3_consultation_referral_5 ///
			 m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f ///
			 m3_412g m3_501 m3_510 m3_601a m3_601b m3_601c ///
			 m3_602b m3_603a m3_603b m3_603c m3_603d m3_604b ///
			 m3_605a m3_605b m3_606 m3_607 m3_607a_et m3_607b_et ///
			 m3_607c_et m3_607d_et m3_607e_et m3_608 m3_609 m3_610a ///
			 m3_610b m3_611 m3_613 m3_615a m3_615b m3_615c m3_617a ///
			 m3_617b m3_617c m3_617d_et m3_617e_et m3_617f_et m3_617g_et ///
			 m3_617h_et m3_617i_et m3_619a m3_619b m3_619c m3_619d ///
			 m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620 ///
		     m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b ///
			 m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 ///
			 m3_710a m3_710b m3_710c m3_802a m3_803a m3_803b m3_803c ///
			 m3_803d m3_803e m3_803f m3_803g m3_803h m3_803i m3_805 ///
			 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g ///
			 m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n ///
			 m3_901o m3_901p m3_901q m3_901r m3_902a_baby1 m3_902a_baby2 ///
			 m3_902a_baby3 m3_902b_baby1 m3_902b_baby2 m3_902b_baby3 ///
			 m3_902c_baby1 m3_902c_baby2 m3_902c_baby3 m3_902d_baby1 ///
			 m3_902d_baby2 m3_902d_baby3 m3_902e_baby1 m3_902e_baby2 ///
			 m3_902e_baby3 m3_902f_baby1 m3_902f_baby2 m3_902f_baby3 ///
			 m3_902g_baby1 m3_902g_baby2 m3_902g_baby3 m3_902h_baby1 ///
			 m3_902h_baby2 m3_902h_baby3 m3_902i_baby1 m3_902i_baby2 ///
			 m3_902i_baby3 m3_902j_baby1 m3_902j_baby2 m3_902j_baby3 ///
			 m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e ///
			 m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c ///
			 m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102b ///
			 m3_1102c m3_1102d m3_1102e m3_1102f m3_YNDKRF

label define confidenceDKNR 1 "Excellent" 2 "Very Good" 3 "Good" ///
							4 "Fair" 5 "Poor" 98 "Don't Know" 99 "NR/RF"
label values m3_1202 m3_1204 m3_1004i m3_1004j m3_1004k confidenceDKNR
	
label define numbers_chron 1 "One" 2 "Two" 3 "Three" 4 "Four" 5 "Five"
label values m3_402 numbers_chron	

label define m3_502 1 "Government hospital" 2 "Government health center" ///
					3 "Government health post" 4 "NGO or faith-based health facility" ///
					5 "Private hospital" 6 "Private specialty maternity center" ///
					7 "Private specialty maternity clinics" 8 "Private clinic" ///
					9 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
					98 "Don't Know" 99 "NR/RF"
label values m3_502 m3_502

label define m3_503 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" ///
					6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" ///
					11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" ///
					16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" ///
					21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 96 "Other, in the zone, Specify" 97 "Other outside of zone, specify" 98 "Don't Know" 99 "NR/RF"
label values m3_503 m3_503					

label define m3_509 1 "High cost (e.g., high out of pocket payment, not covered by insurance)" 2 "Far distance (e.g., too far to walk or drive, transport not readily available)" ///
					3 "Long waiting time (e.g., long line to access facility, long wait for the provider)" 4 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" ///
					5 "Staff dont show respect (e.g., staff is rude, impolite, dismissive)" 6 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" ///
					7 "Facility not clean and/or comfortable (e.g., dirty, risk of infection)" 8 "Not necessary (e.g., able to receive enough care at home, traditional care)" 9 "COVID-19 fear" 10 "No female provider" ///
					11 "Husband/family did not allow it" 12 "Facility was closed" 13 "Delivered on the way (tried to go)" 96 "Other, specify" 99 "NR/RF" 
label values m3_509 m3_509 

label define m3_512 1 "Government hospital" 2 "Government health center" 3 "Government health post" 4 "NGO or faith-based health facility" 5 "Private hospital" ///
					6 "Private specialty maternity centers" 7 "Private specialty maternity clinics" 8 "Private clinic" ///
					9 "Another private medical facility (including pharmacy, shop, traditional healer)" 97 "Other outside of East Shewa or Adama, specify" 98 "Don't Know" 99 "NR/RF" 
label values m3_512 m3_512

label define m3_513a 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" ///
					 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "Koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" ///
					 13 "Beza Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" ///
					 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 96 "Other, in the zone, Specify" 97 "Other outside of zone, specify" 98 "Don't Know" 99 "NR/RF" 
label values m3_513a m3_513a 

label define m3_515 1 "The first facility was closed" 2 "Provider referred you to this other facility without checking you" 3 "Provider checked you but referred you to this other facility" ///
					4 "You decided to leave" 5 "A family member decided you should leave" 
label values m3_515 m3_515

label define m3_516 1 "High cost (e.g., high out of pocket payment, not covered by insurance)" 2 "Long waiting time (e.g., long line to access facility, long wait for the provider)" ///
					3 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 4 "Staff dont show respect (e.g., staff is rude, impolite, dismissive)" ///
					5 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" ///
					6 "Facility not clean and/or comfortable (e.g., dirty, risk of infection)" 7 "COVID-19 fear" 8 "No female provider" 96 "Other, specify" 99 "NR/RF" 
label values m3_516 m3_516

label define m3_518 0 "The provider did not give a reason" 1 "No space or no bed available" 2 "Facility did not provide delivery care" 3 "Prolonged labor" 4 "Obstructed labor" ///
					5 "Eclampsia/pre-eclampsia" 6 "Previous cesarean section scar" 7 "Fetal distress" 8 "Fetal presentations" 9 "No fetal movement" 10 "Bleeding" ///
					96 "Other delivery complications (specify)" 97 "Other reasons(specify)" 98 "Don't Know" 99 "NR/RF" 
label values m3_518 m3_518

label define m3_519 1 "Low cost of delivery" 2 "Close to home" 3 "Short waiting time or enough HCWs" 4 "Good healthcare provider skills" 5 "Staff are respectful/nice" ///
					6 "Medicine and equipment available" 7 "Facility is clean and/or comfortable" 8 "I delivered here before" 9 "Low risk of getting COVID-19" ///
					10 "Female providers available" 11 "I was told by family member" 12 "I was told by a health worker" 13 "Familiarity with health worker" ///
					14 "Familiarity with facility" 15 "Emergency care is available if need" 16 "Birth companion can come with me" 96 "Other, specify" 98 "Dont know" 99 "No response" 
label values m3_519 m3_519

label define m3_p1_complete 0 "Incomplete" 1 "Unverified" 2 "Complete"
label values m3_p1_complete m3_p1_complete

label define m3_status 1 "Alive" 0 "Died"
label values m3_201a m3_201b m3_201c m3_status

label define m3_602a 1 "Yes" 0 "No" 2 "I dont have a maternal health card" 98 "Don't Know" 99 "NR/RF"
label values m3_602a m3_602a

label define m3_604a 1 "My own bed" 2 "A shared bed" 3 "A mattress on the floor" 4 "The floor" 5 "A chair" 6 "I was standing" 98 "Don't Know" 99 "NR/RF"
label values m3_604a m3_604a

label define m3_621a 1 "A relative or a friend" 2 "A traditional birth attendant" 3 "A community health worker" 4 "A nurse" 5 "A midwife" 6 "A doctor" 99 "NR/RF" 
label values m3_621a m3_621a

label define sleeping 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" 4 "Severely disturbed sleep" 
label values m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep sleeping

label define feeding 1 "Normal feeding" 2 "Slight feeding problems" 3 "Moderate feeding problems" 4 "Severe feeding problems" 
label values m3_baby1_feed m3_baby2_feed m3_baby3_feed feeding

label define breathing 1 "Normal breathing" 2 "Slight breathing problems" 3 "Moderate breathing problems" 4 "Severe breathing problems" 
label values m3_baby1_breath m3_baby2_breath m3_baby3_breath

label define stooling 1 "Normal stooling/poo" 2 "Slight stooling/poo problems" 3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems" 
label values m3_baby1_stool m3_baby2_stool m3_baby3_stool stooling

label define mood 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying"
label values m3_baby1_mood m3_baby2_mood m3_baby3_mood mood

label define skin 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin" 4 "Bleeding or cracked skin" 
label values m3_baby1_skin m3_baby2_skin m3_baby3_skin skin

label define interactivity 1 "Highly playful/interactive" 2 "Playful/interactive" 3 "Less playful/less interactive" 4 "Low energy/inactive/dull" 
label values m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity interactivity

label define m3_fx 0 "None of the days" 1 "Several days" 2 "More than half the days" 3 "Nearly every day" 98 "Don't Know" 99 "NR/RF" 
label values m3_801a m3_801b m3_fx

label define m3_807 0 "Not at all" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "A great deal" 99 "NR/DK"
label values m3_807 m3_807

replace m3_808b = "1" if m3_808b == "A"
replace m3_808b = "2" if m3_808b == "B"
replace m3_808b = "3" if m3_808b == "C"
replace m3_808b = "4" if m3_808b == "D"
replace m3_808b = "5" if m3_808b == "E"
replace m3_808b = "6" if m3_808b == "F"
replace m3_808b = "7" if m3_808b == "G"
replace m3_808b = "8" if m3_808b == "H"
destring m3_808b, replace

label define m3_808b 1 "Do not know can be fixed" 2 "Do not know where to go" 3 "Too expensive" 4 "Too far" 5 "Poor quality of care" ///
					 6 "Could not get permission" 7 "Embarrassment" 8 "Problem disappeared" 96 "Other (specify)" 99 "NR/RF"
label values m3_808b m3_808b					 

label define m3_809 1 "YES, NO MORE LEAKAGE AT ALL" 2 "YES, BUT STILL SOME LEAKAGE" 3 "NO, STILL HAVE PROBLEM" 98 "Don't Know" 99 "NR/RF"
label values m3_809 m3_809

label define m3_agree 1 "Very likely" 2 "Somewhat likely" 3 "Not too likely" 4 "Not at all likely" 98 "Don't Know" 99 "NR/RF"
label values m3_1002 m3_agree

replace m3_1105 = "1" if m3_1105 == "A"
replace m3_1105 = "2" if m3_1105 == "B"
replace m3_1105 = "3" if m3_1105 == "C"
replace m3_1105 = "4" if m3_1105 == "D"
replace m3_1105 = "5" if m3_1105 == "E"
replace m3_1105 = "6" if m3_1105 == "F"
destring m3_1105, replace

label define m3_1105 1 "Current income of any household members" 2 "Savings (e.g. bank account)" ///
					 3 "Payment or reimbursement from a health insurance plan" ///
					 4 "Sold items (e.g. furniture, animals, jewelry, furniture)" ///
					 5 "Family members or friends from outside the household" ///
					 6 "Borrowed (from someone other than a friend or family)" 96 "Other (specify)"
label values m3_1105 m3_1105					 

label define m3_satisfaction 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" ///
							 4 "Dissatisfied" 5 "Very dissatisfied" 98 "Don't Know" 99 "NR/RF" 
label values m3_1106 m3_satisfaction							 
 
label define m3_p2_outcome 1 "Completed respondent" 2 "Partially completed and schedule for next time" ///
						   3 "Refused" 4 "Incomplete and no more interest to continue" ///
						   5 "Not Available via the phones" 6 "Phone doesnt work" 96 "Other reason"  
label values m3_p2_outcome m3_p2_outcome


*Formatting dates/times:	

gen double recm3_time = clock(m3_time, "hm") 
format recm3_time %tc_HH:MM

tostring m3_birth_or_ended, replace
gen _date1_ = date(m3_birth_or_ended,"YMD")
drop m3_birth_or_ended
rename _date1_ m3_birth_or_ended
format m3_birth_or_ended %dM_d,_CY

tostring m3_313a_baby1, replace
gen _date2_ = date(m3_313a_baby1,"YMD")
drop m3_313a_baby1
rename _date2_ m3_313a_baby1
format m3_313a_baby1 %dM_d,_CY

tostring m3_313a_baby2, replace
gen _date3_ = date(m3_313a_baby2,"YMD")
drop m3_313a_baby2
rename _date3_ m3_313a_baby2
format m3_313a_baby2 %dM_d,_CY

tostring m3_313a_baby3, replace
gen _date4_ = date(m3_313a_baby3,"YMD")
drop m3_313a_baby3
rename _date4_ m3_313a_baby3
format m3_313a_baby3 %dM_d,_CY

tostring m3_506a, replace
gen _date5_ = date(m3_506a,"YMD")
drop m3_506a
rename _date5_ m3_506a
format m3_506a %dM_d,_CY

/*
tostring m3_attempt_date, replace
gen _date_ = date(m3_attempt_date,"YMD")
drop m3_attempt_date
rename _date_ m3_attempt_date
format m3_attempt_date %dM_d,_CY
*/

tostring m3_p1_date_of_rescheduled, replace
gen _date7_ = date(m3_p1_date_of_rescheduled,"YMD")
drop m3_p1_date_of_rescheduled
rename _date7_ m3_p1_date_of_rescheduled
format m3_p1_date_of_rescheduled %dM_d,_CY

tostring m3_date_p2, replace
gen _date8_ = date(m3_date_p2,"YMD")
drop m3_date_p2
rename _date8_ m3_date_p2
format m3_date_p2 %dM_d,_CY

/*
tostring m3_attempt_outcome2, replace
gen _date_ = date(m3_attempt_outcome2,"YMD")
drop m3_attempt_outcome2
rename _date_ m3_attempt_outcome2
format m3_attempt_outcome2 %dM_d,_CY
*/

tostring m3_p2_date_of_rescheduled, replace
gen _date9_ = date(m3_p2_date_of_rescheduled,"YMD")
drop m3_p2_date_of_rescheduled
rename _date9_ m3_p2_date_of_rescheduled
format m3_p2_date_of_rescheduled %dM_d,_CY

gen double recm3_313b_baby1 = clock(m3_313b_baby1, "hm") 
format recm3_313b_baby1 %tc_HH:MM

*gen double recm3_313b_baby2 = clock(m3_313b_baby2, "hm") // currently numerical because of 0 obs
*format recm3_313b_baby2 %tc_HH:MM

*gen double recm3_313b_baby3 = clock(m3_313b_baby3, "hm") // currently numerical because of 0 obs
*format recm3_313b_baby3 %tc_HH:MM

gen double recm3_506b = clock(m3_506b, "hm") 
format recm3_506b %tc_HH:MM

gen double recm3_507 = clock(m3_507, "hm") 
format recm3_507 %tc_HH:MM

gen double recm3_514 = clock(m3_514, "hm") 
format recm3_514 %tc_HH:MM

gen double recm3_520 = clock(m3_520, "hm") 
format recm3_520 %tc_HH:MM

gen double recm3_time_p2 = clock(m3_time_p2, "hm") 
format recm3_time_p2 %tc_HH:MM 

gen double recm3_endtime = clock(m3_endtime, "hm") 
format recm3_endtime %tc_HH:MM 

gen double recm3_p2_time_of_rescheduled = clock(m3_p2_time_of_rescheduled, "hm") 
format recm3_p2_time_of_rescheduled %tc_HH:MM 

gen double recm3_duration = clock(m3_duration, "hm") 
format recm3_duration %tc_HH:MM 


	* MODULE 4:


label define m4_112 0 "No" 1 "Yes"
label values m4_112 m4_112 // Not sure why this is missing for 168 responses
	
label define m4_114 1 "Called respondent phone, someone else responded" ///
									  2 "Called spouse/partner phone, was informed" ///
									  3 "Called close friend or family member phone number, was informed" ///
									  4 "Called CHW phone number, was informed" 5 "Other" 

* Section 2: Health -- Baby

label define  m4_201_1 1 "Alive" 0 "Died" 
label values m4_201_1 m4_201_1

label define m4_201_2 1 "Alive" 0 "Died"
label values m4_201_2 m4_201_2
label values m4_201_3 m4_201_2

label define  m4_202_1 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair " 5 "Poor "

label values m4_202_1 m4_202_1 
label values m4_202_2 m4_202_1 
label values m4_202_3 m4_202_1 


label define  m4_203_1_1 0 "Unchecked" 1 "Checked" 


foreach var of varlist m4_203_1_1-  m4_203_3_888 {
                 label values `var' m4_203_1_1
          }



label define m4_204a 1 "Not at all confident" 2 " Not very confident" 3 "Somewhat confident" 4 "Confident" 5 " Very confident"  
label values m4_204a m4_204a

label define m4_205a_1 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" 4 "Severely disturbed sleep" 

foreach var of varlist m4_205a_1 - m4_205a_3  {
                 label values `var' m4_205a_1
          }

label define m4_205b_1 1 "Normal feeding " 2 "Slight feeding problems" 3 "Moderate feeding problems" 4 "Severe feeding problems" 

foreach var of varlist m4_205b_1 - m4_205b_3  {
                 label values `var' m4_205b_1
          }

label define m4_205c_1 1 "Normal breathing " 2 "Slight beathing problems" 3 "Moderate beathing problems" 4 "Severe beathing problems" 

foreach var of varlist m4_205c_1 - m4_205c_3  {
                 label values `var' m4_205c_1
          }

label define m4_205d_1 1 "Normal stooling/poo " 2 "Slight stooling/poo problems" 3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems" 

foreach var of varlist m4_205d_1 - m4_205d_3  {
                 label values `var' m4_205d_1
          } 

label define m4_205e_1 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying" 

foreach var of varlist m4_205e_1 - m4_205e_3  {
                 label values `var' m4_205e_1
          } 
label define m4_205f_1 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin " 4 "Bleeding or cracked skin" 
foreach var of varlist m4_205f_1 - m4_205f_3  {
                 label values `var' m4_205f_1
          } 
 

label define m4_205g_1 1 "Highly playful/interactive" 2 "Playful/interactive" 3 "Less playful/less interactive" 4 "Low energy/inactive/dull" 
foreach var of varlist m4_205g_1 - m4_205g_3  {
                 label values `var' m4_205g_1
          } 

label define m4_206a_1 1 "Yes" 0 "No" 

foreach var of varlist m4_206a_1 - m4_207a_1  {
                 label values `var' m4_206a_1
          }
label values m4_207a_2 	m4_206a_1	
label values m4_207a_3 	m4_206a_1	
* no labels for the date variables (m4_208a_1, m4_208a_2, m4_208a_3)

foreach var of varlist  m4_210_1_0 -   m4_210_3_888 {
                 label values `var' m4_203_1_1
          }

label values m4_1_3_et m4_206a_1

foreach var of varlist m4_211_1 - m4_211_3  {
                 label values `var' m4_206a_1
          }

		  
label define m4_212_1 1 "In a health facility" 2 "On the way to the health facility" 3 "Your house or someone elses house" 4 "Other, please specify " 

foreach var of varlist m4_212_1 - m4_212_3  {
                 label values `var' m4_212_1
          }


*---------------- Section 3: Health - Woman -------*
label define m4_301 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor" 
label values m4_301 m4_301

label define m4_302a 0 "None of the days" 1 "Several days" 2 "More than half the days" 3 "Nearly every day" 
foreach var of varlist m4_302a - m4_302b  {
                 label values `var' m4_302a
          }
		  
label define m4_303a 1 "Very much" 2 "A lot" 3 "A little" 4 "Not at all"
foreach var of varlist m4_303a - m4_303h  {
                 label values `var' m4_303a
          }

label define m4_304 0 "Have not had sex" 1 "Not at all" 2 "A little bit" 3 "Somewhat" 4 "Quite a bit" 5 "Very much" 
label values m4_304 m4_304

label define m4_305 1 "Yes" 0 "No" 
label values m4_305 m4_305

label define m4_307 0 "Never" 1 "Less than once per month" 2 "Less than once/week & greater than once/month" 3 "Less than once/day & greater than once/month" 4 "Once a day or more than once a day" 
label values m4_307 m4_307

label values m4_308 m4_305

replace m4_309 = "1" if m4_309=="A"
replace m4_309 = "2" if m4_309=="B"
replace m4_309 = "3" if m4_309=="C" 
replace m4_309 = "4" if m4_309=="D"
replace m4_309 = "5" if m4_309=="E" 
replace m4_309 = "6" if m4_309=="F" 
replace m4_309 = "7" if m4_309=="G" 
replace m4_309 = "8" if m4_309=="I" 
replace m4_309 = "9" if m4_309=="J" 
replace m4_309 = "10" if m4_309=="K" 
replace m4_309 = "11" if m4_309=="L" 
replace m4_309 = "12" if m4_309=="M" 
gen m4_309_numeric = real(m4_309)
drop m4_309 
rename m4_309_numeric m4_309 
label define m4_309 1 "Do not know it can be fixed" 2 "You tried but did not get treatment" 3 "High cost (e.g., high out of pocket payment, not covered by insurance)" 4 "Far distance (e.g., too far to walk or drive, transport not readily available)" 5 " Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 6 "Staff don't show respect (e.g., staff is rude,impolite, dismissive)" 7 "Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" 8 "COVID-19 fear" 9 "Don't know where to go/too complicated" 10 "Could not get permission" 11 "Embarrassment" 12 "Problem disappeared" 96 " Other (specify)" 
label values m4_309 m4_309


label define m4_310 1 "YES, No MORE LEAKAGE AT ALL" 2 "YES, BUT STILL SOME LEAKAGE" 3 "No, STILL HAVE PROBLEM" 
label values m4_310 m4_310

label define m4_401a 1 "Yes " 0 "No" 
foreach var of varlist m4_401a - m4_401b  {
                 label values `var' m4_401a
          }

label define m4_402 1 "One" 2 "Two" 3 "Three" 
label values m4_402 m4_402

label define m4_403a 1 "In your home " 2 "Someone elses home" 3 "Government hospital" 4 "Government health center" 5 "Government health post" 6 "NGO or faith-based health facility" 7 "Private hospital" 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" 10 "Private clinic" 11 "Another private medical facility (including pharmacy, shop, traditional healer)" 
foreach var of varlist m4_403a - m4_403c  {
                 label values `var' m4_403a
          }


label define m4_404a 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Beza Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 23 "Other in East Shewa or Adama, Specify" 96 "Other outside of East Shewa or Adama" 
label values m4_404a m4_404a
label values m4_404b m4_404a
label values m4_404c m4_404a
label values m4_405 m4_401a

foreach var of varlist m4_406_a - m4_406_888  {
                 label values `var' m4_203_1_1
          }

label values m4_407 m4_401a

foreach var of varlist m4_408_a - m4_408_888  {
                 label values `var' m4_203_1_1
          }

label values m4_409 m4_401a

foreach var of varlist m4_410_a - m4_410_888  {
                 label values `var' m4_203_1_1
          }

foreach var of varlist m4_413_a - m4_413_888  {
                 label values `var' m4_203_1_1
          }

foreach var of varlist m4_501 - m4_503  {
                 label values `var' m4_301
          }
		  
foreach var of varlist m4_601a_1 - m4_601i_1  {
                 label values `var' m4_401a
          }		  

label values m4_601i_2 m4_401a

label values m4_601i_3 m4_401a		  

label values m4_618a_1 m4_401a	

label define m4_618b_1 1 "Positive" 2 "Negative" 
label values m4_618b_1 m4_618b_1	
label values m4_618c_1 m4_401a

label values m4_618a_2 m4_401a	
label values m4_618b_2 m4_618b_1	
label values m4_618c_2 m4_401a

label values m4_618a_3 m4_401a	
label values m4_618b_3 m4_618b_1	
label values m4_618c_3 m4_401a

foreach var of varlist m4_602a - m4_602g  {
                 label values `var' m4_401a
          }	

foreach var of varlist m4_603_1_0 - m4_603_1_888  {
                 label values `var' m4_203_1_1
          }			  
foreach var of varlist m4_603_2_0 - m4_603_2_888  {
                 label values `var' m4_203_1_1
          }		
foreach var of varlist m4_603_3_0 - m4_603_3_888  {
                 label values `var' m4_203_1_1
          }		
foreach var of varlist m4_701a - m4_701h  {
                 label values `var' m4_401a
          }		
foreach var of varlist m4_702 - m4_704a  {
                 label values `var' m4_401a
          }	

foreach var of varlist m4_801a - m4_801r  {
                 label values `var' m4_401a
          }	

foreach var of varlist m4_802a_1 - m4_802j_1  {
                 label values `var' m4_401a
          }	
label values m4_802j_2 m4_401a
label values m4_802j_3 m4_401a

foreach var of varlist m4_803a_1 - m4_803f_3  {
                 label values `var' m4_401a
          }	

label define m4_804_1 1 "At home" 2 "At a facility" 3 "At another location" 
foreach var of varlist m4_804_1 - m4_804_3  {
                 label values `var' m4_804_1
          }	

foreach var of varlist m4_901 - m4_902a  {
                 label values `var' m4_401a
          }	
label values m4_902b m4_401a
label values m4_902c m4_401a		  
label values m4_902d m4_401a
label values m4_902e m4_401a	

foreach var of varlist m4_905_1 - m4_905_888  {
                 label values `var' m4_203_1_1
          }	

label define m4_conclusion_live_babies 1 "Yes" 2 "No, other time or place" 3 "Not at all to participate(refused)"
label values m4_conclusion_live_babies m4_conclusion_live_babies

label define m4_conclusion_dead_baby 1 "Read" 2 "Not read"
label values m4_conclusion_dead_baby conclusion_dead_baby_m4

label define m4_ot1 1 "Completed respondent" 2 "Partially completed and schedule for next time" 3 "Refused" 4 "Incomplete and no more interest to continue" 5 "Not Available via the phones" 6 "Phone doesnt work" 96 "Other reason, specify" 
label values m4_ot1 m4_ot1

label define m4_complete 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label values m4_complete m4_complete	

	
*===============================================================================
		
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)

	** MODULE 1:
	recode mobile_phone kebele_malaria kebele_intworm m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g m1_203_et m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b m1_401 m1_404 m1_405 m1_501 m1_503 m1_504 m1_505 m1_506 m1_507 m1_601 m1_602 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_605i_et m1_605j_et m1_605k_et m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_805 m1_806 m1_807 m1_810a m1_810b m1_813a m1_813b m1_813c m1_813d m1_813e m1_8a_et m1_8b_et m1_8c_et m1_8d_et m1_8e_et m1_8f_et m1_8g_et m1_2_8_et m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i m1_816 m1_901 m1_902 m1_903 m1_904 m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_1_10_et m1_1007 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1217 m1_1221 m1_1222 m1_1223 mobile_phone (99 = .r)

	recode m1_401 m1_404 m1_501 m1_506 m1_507 m1_509b m1_510b m1_511 m1_512 m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_803 m1_805 m1_806 m1_807 m1_809 m1_810a m1_810b m1_811 m1_812a m1_813a m1_813b m1_813c m1_813d m1_813e m1_8a_et m1_8b_et m1_8c_et m1_8d_et m1_8e_et m1_8f_et m1_8g_et m1_2_8_et m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i m1_816 m1_901 m1_902 m1_903 m1_904 m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_1_10_et m1_1007 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1218a m1_1218b m1_1218c m1_1218d m1_1218e m1_1218f m1_1221 m1_1223 m1_804 (98 = .d)

	** MODULE 2:
	recode m2_301 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_205c m2_205d m2_205e m2_205f m2_205g m2_205h m2_205i m2_206 m2_207 m2_208 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508c m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_704 (99 = .r)
	
	recode m2_201 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_206 m2_207 m2_208 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508c m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_704 kebele_malaria kebele_intworm (98 = .d)

	** MODULE 3:
	recode m3_303a m3_303b m3_303c m3_303d m3_baby1_gender m3_baby2_gender m3_baby3_gender m3_baby1_health m3_baby2_health m3_baby3_health m3_breastfeeding m3_505a m3_517 m3_1201 m3_1202 m3_1203 m3_1204 m3_401 m3_consultation_1 m3_consultation_referral_1 m3_consultation_2 m3_consultation_referral_2 m3_consultation_3 m3_consultation_referral_3 m3_consultation_4 m3_consultation_referral_4 m3_consultation_5 m3_consultation_referral_5 m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_501 m3_510 m3_601a m3_601b m3_601c m3_602b m3_603a m3_603b m3_603c m3_603d m3_604b m3_605a m3_605b m3_606 m3_607 m3_607a_et m3_607b_et m3_607c_et m3_607d_et m3_607e_et m3_608 m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a m3_615b m3_615c m3_617a m3_617b m3_617c m3_617d_et m3_617e_et m3_617f_et m3_617g_et m3_617h_et m3_617i_et m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620 m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_710a m3_710b m3_710c m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803i m3_805 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_902a_baby1 m3_902a_baby2 m3_902a_baby3 m3_902b_baby1 m3_902b_baby2 m3_902b_baby3 m3_902c_baby1 m3_902c_baby2 m3_902c_baby3 m3_902d_baby1 m3_902d_baby2 m3_902d_baby3 m3_902e_baby1 m3_902e_baby2 m3_902e_baby3 m3_902f_baby1 m3_902f_baby2 m3_902f_baby3 m3_902g_baby1 m3_902g_baby2 m3_902g_baby3 m3_902h_baby1 m3_902h_baby2 m3_902h_baby3 m3_902i_baby1 m3_902i_baby2 m3_902i_baby3 m3_902j_baby1 m3_902j_baby2 m3_902j_baby3 m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f m3_baby1_gender m3_baby2_gender m3_baby3_gender m3_baby1_health m3_baby2_health m3_baby3_health m3_1001 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_breastfeeding m3_1202 m3_1204 m3_1004i m3_1004j m3_1004k m3_502 m3_503 m3_509 m3_512 m3_513a m3_516 m3_518 m3_519 m3_602a m3_604a m3_621a m3_801a m3_801b m3_807 m3_808b m3_809 m3_1002 m3_1106 (99 = .r)
	
	recode m3_303a m3_baby1_weight m3_baby2_weight m3_baby3_weight m3_breastfeeding m3_1201 m3_1202 m3_1203 m3_1204 m3_401 m3_consultation_1 m3_consultation_referral_1 m3_consultation_2 m3_consultation_referral_2 m3_consultation_3 m3_consultation_referral_3 m3_consultation_4 m3_consultation_referral_4 m3_consultation_5 m3_consultation_referral_5 m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_501 m3_510 m3_601a m3_601b m3_601c m3_602b m3_603a m3_603b m3_603c m3_603d m3_604b m3_605a m3_605b m3_606 m3_607 m3_607a_et m3_607b_et m3_607c_et m3_607d_et m3_607e_et m3_608 m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a m3_615b m3_615c m3_617a m3_617b m3_617c m3_617d_et m3_617e_et m3_617f_et m3_617g_et m3_617h_et m3_617i_et m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j m3_620 m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_710a m3_710b m3_710c m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803i m3_805 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_902a_baby1 m3_902a_baby2 m3_902a_baby3 m3_902b_baby1 m3_902b_baby2 m3_902b_baby3 m3_902c_baby1 m3_902c_baby2 m3_902c_baby3 m3_902d_baby1 m3_902d_baby2 m3_902d_baby3 m3_902e_baby1 m3_902e_baby2 m3_902e_baby3 m3_902f_baby1 m3_902f_baby2 m3_902f_baby3 m3_902g_baby1 m3_902g_baby2 m3_902g_baby3 m3_902h_baby1 m3_902h_baby2 m3_902h_baby3 m3_902i_baby1 m3_902i_baby2 m3_902i_baby3 m3_902j_baby1 m3_902j_baby2 m3_902j_baby3 m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f m3_1202 m3_1204 m3_1004i m3_1004j m3_1004k m3_502 m3_503 m3_512 m3_513a m3_518 m3_519 m3_602a m3_604a m3_801a m3_801b m3_809 m3_1002 m3_1106 recm3_506b recm3_507 m3_514_unknown recm3_520 (98 = .d)
	
	recode recm3_506b recm3_507 m3_514_unknown recm3_520 m3_521 (998 = .d)
	
	** MODULE 4:	
	recode  m4_108  m4_202_1 m4_202_2  m4_202_3 m4_204a  m4_206a_1 m4_206a_2 m4_206a_3 m4_206b_1 m4_206b_2 m4_206b_3 m4_206c_1 m4_206c_2 m4_206c_3 m4_206d_1 m4_206d_2 m4_206d_3 m4_206e_1 m4_206e_2 m4_206e_3 m4_206f_1 m4_206f_2 m4_206f_3  m4_206g_1 m4_206g_2 m4_206g_3 m4_206h_1 m4_206h_2 m4_206h_3 m4_206i_1 m4_206i_2 m4_206i_3 m4_206j_1 m4_206j_2 m4_206j_3 m4_206k_1 m4_206k_2 m4_206k_3 m4_206l_1 m4_206l_2 m4_206l_3 m4_207a_1 m4_207a_2 m4_207a_3 m4_208a_2 m4_208a_3 m4_1_3_et m4_211_1 m4_211_2 m4_211_3 m4_212_1 m4_212_2 m4_212_3 (99 = .r )
 
	recode m4_108 m4_204a m4_206a_1 m4_206a_2 m4_206a_3 m4_206b_1 m4_206b_2 m4_206b_3 m4_206c_1 m4_206c_2 m4_206c_3 m4_206d_1 m4_206d_2 m4_206d_3 m4_206e_1 m4_206e_2 m4_206e_3 m4_206f_1 m4_206f_2 m4_206f_3  m4_206g_1 m4_206g_2 m4_206g_3 m4_206h_1 m4_206h_2 m4_206h_3 m4_206i_1 m4_206i_2 m4_206i_3 m4_206j_1 m4_206j_2 m4_206j_3 m4_206k_1 m4_206k_2 m4_206k_3 m4_206l_1 m4_206l_2 m4_206l_3 m4_207a_1 m4_207a_2 m4_207a_3 m4_208a_2 m4_208a_3 m4_1_3_et m4_211_1 m4_211_2 m4_211_3 m4_212_1 m4_212_2 m4_212_3 (98 = .d)

************** Recode missing values to NA for questions respondents would not have been asked due to skip patterns:

* MODULE 1:
* Kept these recode commands here even though everyone has given permission 
recode care_self (. = .a) if permission == 0
recode m1_enrollage (. = .a) if permission == 0
recode zone_live (. = .a) if m1_enrollage>15 
recode b6anc_first (. = .a) if b5anc== 2
recode b6anc_first_conf (.a = .a) if b5anc== 2
recode continuecare (. = .a) if b6anc_first_conf ==2 
recode flash (. = .a) if mobile_phone == 0 | mobile_phone == 99 | mobile_phone == .
recode phone_number (. = .a) if mobile_phone == 0 | mobile_phone == 99 | mobile_phone == .
recode m1_503 (. = .a) if m1_502 == 0 | m1_502 == .
recode m1_504 (. = .a) if m1_502 == 0 | m1_503 == 1
recode m1_509b (. = .a) if m1_509a == 0
recode m1_510b (. = .a) if m1_510a == 0
recode m1_513b m1_513c (. = .a) if m1_513a_1 == 0 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_7 == 1 | m1_513a_8 == 1 

recode m1_513d (. = .a) if m1_513a_2 == 0 | m1_513a_1 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_7 == 1 | m1_513a_8 == 1 											 

recode m1_513e (. = .a) if m1_513a_3 == 0 | m1_513a_1 == 1 | ///
	   m1_513a_2 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | m1_513a_6 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 
												 
recode m1_513f (. = .a) if m1_513a_4 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_5 == 1 | m1_513a_6 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 
												 
recode m1_513g (. = .a) if m1_513a_5 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_6 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 	
												 
recode m1_513h (. = .a) if m1_513a_6 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_7 == 1 | m1_513a_8 == 1 
												 
recode m1_513i (. = .a) if m1_513a_7 == 0 | m1_513a_1 == 1 | m1_513a_2 == 1 | ///
	   m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_8 == 1 												 

recode m1_514a (. = .a) if m1_513a_3 == 1 | m1_513a_4 == 1 | m1_513a_5 == 1 | ///
	   m1_513a_6 == 1 | m1_513a_7 == 1 | m1_513a_8 == 1	

recode m1_708b (. = .a) if m1_708a == 0 | m1_708a == . | m1_708a == .d
recode m1_708c (. = .a) if m1_708b	== 2 | m1_708b == . |	m1_708b == .d | m1_708b == .a 
recode m1_708d (. = .a) if m1_708c	== 0 | m1_708c == . | m1_708c == .d | m1_708c == .a 
recode m1_708e (. = .a) if m1_708b == 2 | m1_708b == . | m1_708b == .d | m1_708b == .a
recode m1_708f (. = .a) if m1_708b == 2 | m1_708b == . | m1_708b == .d | m1_708b == .a

recode m1_710b (. = .a) if m1_710a == 0 | m1_710a == . | m1_710a == .d
recode m1_710c (. = .a) if m1_710b == 2 | m1_710b == .a | m1_710b == .d

recode m1_711b (. = .a) if m1_711a == 0 | m1_711a == . | m1_711a == .d

recode m1_714c (. = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r

* SS confirm these with Kate
replace m1_714d = ".a" if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r
replace m1_714d = "." if m1_714d == ""
replace m1_714d = ".d" if m1_714d == "Dont know" | m1_714d == "Dont know." | m1_714d == "Dont remember"
replace m1_714d = "0" if m1_714d == "0.08"
replace m1_714d = "1" if m1_714d == "1,10/12"
replace m1_714d = "2.5" if m1_714d == "2 yr 6month"
replace m1_714d = "2.7" if m1_714d == "2yr and 8 month"
replace m1_714d = "3" if m1_714d == "3 years"
replace m1_714d = "0" if m1_714d == "3week"
encode m1_714d, generate(recm1_714d)
recode m1_714e (. = .a) if m1_714c == . | m1_714c == .r

recode m1_718 (. = .a) if m1_202a == 0 | m1_202a == .
recode m1_719 (. = .a) if m1_202b == 0 | m1_202b == .
recode m1_720 (. = .a) if m1_202c == 0 | m1_202c == .
recode m1_721 (. = .a) if m1_202d == 0 | m1_202d == .
recode m1_722 (. = .a) if m1_202e == 0 | m1_202e == .

recode m1_724b (. = .a) if m1_724a == 0 | m1_724a == .
recode m1_724f (. = .a) if m1_705 == 1 | m1_705 == . | m1_705 == .d | m1_705 == .r
recode m1_724g (. = .a) if  m1_707 == 1 | m1_707 == . | m1_707 == .d | m1_707 == .r
recode m1_724h (. = .a) if m1_708a == 1 | m1_708a == . | m1_708a == .d | m1_708a == .r
recode m1_724i (. = .a) if m1_712 == 1 | m1_712 == . | m1_712 == .d | m1_712 == .r

recode m1_804 (. = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d | m1_801 == .r) & (m1_802b_et == 0 | m1_802b_et == .) & (m1_803 == .d |  m1_803 == . |  m1_803 == .r) 

recode m1_808_0_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_1_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_2_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_3_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_4_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_5_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_6_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_7_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_8_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_9_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_10_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_11_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_12_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_96_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode m1_808_99_et (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d

* SS: Fix in redcap to add this skip pattern
recode m1_812b_0_et (. = .a) (0 = .a) if m1_812a == 0 | m1_812a ==. | m1_812a == .d 

recode m1_812b_1 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_1 (0 = .) if m1_812b_0_et == 0

recode m1_812b_2 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_2 (0 = .) if m1_812b_0_et == 0

recode m1_812b_3 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_3 (0 = .) if m1_812b_0_et == 0

recode m1_812b_4 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_4 (0 = .) if m1_812b_0_et == 0

recode m1_812b_5 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_5 (0 = .) if m1_812b_0_et == 0

recode m1_812b_96 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_96 (0 = .) if m1_812b_0_et == 0

recode m1_812b_98 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_98 (0 = .) if m1_812b_0_et == 0

recode m1_812b_99 (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_99 (0 = .) if m1_812b_0_et == 0

recode m1_812b_998_et (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_998_et (0 = .) if m1_812b_0_et == 0

recode m1_812b_999_et (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_999_et (0 = .) if m1_812b_0_et == 0

recode m1_812b_888_et (0 = .a) if m1_812b_0_et == 1 | m1_812b_0_et == 98 | m1_812b_0_et == 99
recode m1_812b_888_et (0 = .) if m1_812b_0_et == 0

replace m1_812b_other = ".a" if m1_812b_96 !=1

recode m1_813e (. = .a) if (m1_813a == 0 | m1_813a == .d | m1_813a == .r) & (m1_813b == 0 | ///
	   m1_813b == .d | m1_813b == .r) & (m1_813c == 0 | m1_813c == .d | m1_813c == .r) & ///
	   (m1_813d == 0 | m1_813d == .d | m1_813d == .r)

recode m1_2_8_et (. = .a) if (m1_8a_et == 0 | m1_8a_et == .d | m1_8a_et == .r) & ///
	   (m1_8b_et == 0 | m1_8b_et == .d | m1_8b_et == .r) & ///
	   (m1_8c_et == 0 | m1_8c_et == .d | m1_8c_et == .r) & ///
	   (m1_8d_et == 0 | m1_8d_et == .d | m1_8d_et == .r) & ///
	   (m1_8e_et == 0 | m1_8e_et == .d | m1_8e_et == .r) & ///
	   (m1_8f_et == 0 | m1_8f_et == .d | m1_8f_et == .r) & ///
	   (m1_8g_et == 0 | m1_8g_et == .d | m1_8g_et == .r)

recode m1_814h (. = .a) if m1_804 == 1	| m1_804 == 2 | m1_804 == . | m1_804 == .a | m1_804 == .d								   			   
recode m1_815_0 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
													(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
													(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
													(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
													(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
													(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
													(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
													(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
													(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
   							   
recode m1_815_0 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
												   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
												   m1_814i == 1
													
recode m1_815_1 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_1 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_2 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_2 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_3 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_3 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_4 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_4 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode m1_815_5 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_5 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode m1_815_6 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_6 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	
													
recode m1_815_7 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_7 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	
													
recode m1_815_96 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_96 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode m1_815_98 (0 = .d) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_98 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode m1_815_99 (0 = .r) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode m1_815_99(0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1

* SS: confirm why 814h "and"				
recode m1_816 (. = .a) if (m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
									m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814i == 1) & ///
									(m1_814h == 1 | m1_814h == .a | m1_814h == .)
									
recode m1_902 (. = .a) if m1_901 == 3 | m1_901 == .d | m1_901 == .r | m1_901 == .

recode m1_904 (. = .a) if m1_903 == 3 | m1_903 == .d | m1_903 == .r | m1_903 == .

recode m1_907 (. = .a) if m1_905 == 0 | m1_905 == . | m1_905 == .d | m1_905 == .r
					
recode m1_1002 (. = .a) if m1_1001 <= 1 | m1_1001 == .	

recode m1_1003 (. = .a) if m1_1002 <1 | m1_1002 == . | m1_1002 == .a	

recode m1_1004 (. = .a) if m1_1001 <= m1_1002

recode m1_1005 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1006  (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1_10_et (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1007 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1008 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1009 (. = .a) if (m1_1003 <1 | m1_1003 == .a | m1_1003 == .)

recode m1_1010 (. = .a) if (m1_1003 <= m1_1009) | m1_1003 == .a 

recode m1_1011a (. = .a) if (m1_1001 <= 1 | m1_1001 ==.)

recode m1_1011b (. = .a) if m1_1004 == 0 | m1_1004 == . | m1_1004 == .a

recode m1_1011c (. = .a) if (m1_1002 <= m1_1003)	

recode m1_1011d (. = .a) if	m1_1005 == 0 | m1_1005 == . | m1_1005 == .a

recode m1_1011e (. = .a) if m1_1007 == 0 | m1_1007 == . | m1_1007 == .a

recode m1_1011f (. = .a) if m1_1010 == 0 | m1_1010 == . | m1_1010 == .a

recode  m1_1102_a (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_a (0 = .) if m1_1101 == 1
recode  m1_1102_b (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_b (0 = .) if m1_1101 == 1
recode  m1_1102_c  (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_c  (0 = .) if m1_1101 == 1
recode  m1_1102_d (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_d (0 = .) if m1_1101 == 1
recode m1_1102_e (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode m1_1102_e (0 = .) if m1_1101 == 1
recode  m1_1102_f (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_f (0 = .) if m1_1101 == 1
recode  m1_1102_g (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_g (0 = .) if m1_1101 == 1
recode  m1_1102_h   (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_h   (0 = .) if m1_1101 == 1
recode  m1_1102_i  (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_i  (0 = .) if m1_1101 == 1
recode  m1_1102_j (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_j (0 = .) if m1_1101 == 1
recode  m1_1102_96 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_96 (0 = .) if m1_1101 == 1
recode  m1_1102_98 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_98 (0 = .) if m1_1101 == 1
recode  m1_1102_99 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode  m1_1102_99 (0 = .) if m1_1101 == 1

recode m1_1104_a (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_a (0 = .) if m1_1103 == 1
recode m1_1104_b (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_b (0 = .) if m1_1103 == 1
recode m1_1104_c (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_c (0 = .) if m1_1103 == 1
recode m1_1104_d (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_d (0 = .) if m1_1103 == 1
recode m1_1104_e (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_e (0 = .) if m1_1103 == 1
recode m1_1104_f (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_f (0 = .) if m1_1103 == 1
recode m1_1104_g (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_g (0 = .) if m1_1103 == 1
recode m1_1104_h (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_h (0 = .) if m1_1103 == 1
recode m1_1104_i (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_i (0 = .) if m1_1103 == 1
recode m1_1104_j (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_j (0 = .) if m1_1103 == 1
recode m1_1104_96 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_96 (0 = .) if m1_1103 == 1
recode m1_1104_98 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_98 (0 = .) if m1_1103 == 1
recode m1_1104_99 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode m1_1104_99 (0 = .) if m1_1103 == 1

recode m1_1105 (. = .a) if (m1_1101 == 0 | m1_1101 == . | m1_1101 == .r) & (m1_1103 == 0 | m1_1103 == . | m1_1103 == .r)

recode m1_1218a (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218a_1 (. = .a) if m1_1218a == 0 | m1_1218a == .a

replace m1_1218b_1 = ".a" if m1_1218b == 0 | m1_1218b == .a 
replace m1_1218b_1 = "." if m1_1218b_1=="Unknown"
destring m1_1218b_1, replace

recode m1_1218b (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218b_1 (. = .a) if m1_1218b == 0 | m1_1218b == .a

recode m1_1218c (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218c_1 (. = .a) if m1_1218c == 0 | m1_1218c == .a

recode m1_1218d (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218d_1 (. = .a) if m1_1218d == 0 | m1_1218d == .a

recode m1_1218e (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218e_1 (. = .a) if m1_1218e == 0 | m1_1218e == .a

recode m1_1218f (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218f_1 (. = .a) if m1_1218f == 0 | m1_1218f == .a

recode m1_1219 (. = .a) if m1_1218a_1 == .a & m1_1218b_1 == . & m1_1218c_1 ==.a & ///
						   m1_1218d_1 == .a & m1_1218e_1 == .a & m1_1218f_1 == .a
    
recode m1_1220_1 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_1 (0 = .) if m1_1217 == 1
recode m1_1220_2 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_2 (0 = .) if m1_1217 == 1
recode m1_1220_3 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_3 (0 = .) if m1_1217 == 1
recode m1_1220_4 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_4 (0 = .) if m1_1217 == 1
recode m1_1220_5 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_5 (0 = .) if m1_1217 == 1
recode m1_1220_6 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_6 (0 = .) if m1_1217 == 1
recode m1_1220_96 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1220_96 (0 = .) if m1_1217 == 1

recode m1_1222 (. = .a) if m1_1221 == 0 | m1_1221 == .

replace m1_1307 = ".a" if m1_1306 == 0 | m1_1306 == 96 | m1_1306 == .
replace m1_1307 = "." if m1_1307 == ""
replace m1_1307 = "12.6" if m1_1307 == "12.6g/d"
replace m1_1307 = "12.6" if m1_1307 == "12.6g/dl"
replace m1_1307 = "13" if m1_1307 == "13g/dl"
replace m1_1307 = "14" if m1_1307 == "14."
replace m1_1307 = "14.6" if m1_1307 == "14.6g/dl"
replace m1_1307 = "15" if m1_1307 == "15g/dl"
replace m1_1307 = "16.3" if m1_1307 == "16.3g/dl"
replace m1_1307 = "16.6" if m1_1307 == "16.6g/dl"
replace m1_1307 = "16" if m1_1307 == "16g/dl"
replace m1_1307 = "17.6" if m1_1307 == "17.6g/dl"
replace m1_1307 ="11.3" if m1_1307 == "113"
destring m1_1307, replace

recode m1_1308 (. = .a) if m1_1306 == 1 | m1_1306 == 96 | m1_1306 == .

recode m1_1309 (. = .a) if m1_1308 == 0 | m1_1308 == . | m1_1308 == .a

	** MODULE 2:

recode m2_permission (. = .a) if m2_start == 0
recode m2_maternal_death_reported (. = .a) if m2_permission==0

recode m2_hiv_status (. = .a) if m2_maternal_death_reported == 1 | m1_708b == 1

* SS: Fix in redcap? error says recode only allows numeric vars but it works below
* recode date_of_maternal_death (. = .a) if maternal_death_reported == 0 | ///
										  *maternal_death_reported == . | ///
										  *maternal_death_reported == .a

recode m2_maternal_death_learn (. = .a) if m2_maternal_death_reported == 0

recode m2_maternal_death_learn_other (. = .a) if m2_maternal_death_learn == 1 | m2_maternal_death_learn == 2 | m2_maternal_death_learn == 3 | m2_maternal_death_learn == 4

recode m2_201 m2_202 (. = .a) if m2_maternal_death_reported == 2 | m2_maternal_death_reported == 3

* SS: fix
*recode m2_date_of_maternal_death_2 (. = .a) if m2_maternal_death_reported == 0 | ///
											m2_maternal_death_reported == . | ///
											m2_maternal_death_reported == .a

recode m2_203a m2_203b m2_203c m2_203d m2_203e ///
	   m2_203f m2_203g m2_203h m2_203i m2_204a ///
	   m2_204b m2_204c m2_204d m2_204e m2_204f ///
	   m2_204g m2_204h m2_204i m2_205a m2_205b ///
	   m2_205c m2_205d m2_205e m2_205f m2_205g ///
	   m2_205h m2_205i m2_206 m2_207 m2_208 m2_301 (. = .a) if m2_202 == 0

recode m2_302 (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_303a (. = .a) if m2_302 == . | m2_302 == .a

recode m2_303b (. = .a) if m2_302 == . | m2_302 == 1 |  m2_302 == .a

recode m2_303c (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == .a

recode m2_303d (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3 | m2_302 == .a

recode m2_303e (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3 | m2_302 == 4 | m2_302 == .a

recode m2_304a (. = .a) if m2_303a == 1 | m2_303a == 2 | m2_302 == . | m2_302 == .a

recode m2_304b (. = .a) if m2_303b == 1 | m2_303b == 2 | m2_302 == . | m2_302 == 1 | m2_302 == .a

recode m2_304c (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 ==2  | m2_303c == 1 | m2_303c == 2 | m2_302 == .a

recode m2_304d (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3 | m2_303d == 1 | m2_303d == 2 | m2_302 == .a

recode m2_304e (. = .a) if m2_302 == . | m2_302 == 1 | m2_302 == 2 | m2_302 == 3  | m2_302 == 4 | m2_303e == 1 | m2_303e == 2 | m2_302 == .a

recode m2_305 (. = .a) if m2_302 == . | m2_302 == .a

recode m2_306 (. = .a) if m2_305 == 1 | m2_305 == 98 | m2_305 == 99

recode m2_306_1 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_1 (0 = .) if m2_306 == 0

recode m2_306_2 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_2 (0 = .) if m2_306 == 0

recode m2_306_3 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_3 (0 = .) if m2_306 == 0

recode m2_306_4 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_4 (0 = .) if m2_306 == 0

recode m2_306_5 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_5 (0 = .) if m2_306 == 0

recode m2_306_96 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_306_96 (0 = .) if m2_306 == 0

replace m2_307_other = ".a" if m2_306_96 ==1

recode m2_308 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a

recode m2_309 (. = .a) if m2_308 == 1 | m2_308 == 98 | m2_308 == 99

recode m2_308_1 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode m2_308_1 (0 = .) if m2_306 == 0

recode m2_308_2 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_2 (0 = .) if m2_309 == 0

recode m2_308_3 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_3 (0 = .) if m2_309 == 0

recode m2_308_4 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_4 (0 = .) if m2_309 == 0

recode m2_308_5 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_5 (0 = .) if m2_309 == 0

recode m2_308_96 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode m2_308_96 (0 = .) if m2_309 == 0

replace m2_310_other = ".a" if m2_308_96 ==1

recode m2_311 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2

recode m2_312 (. = .a) if m2_311 == 1 | m2_311 == 98 | m2_311 == 99

recode m2_311_1 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_1 (0 = .) if m2_312 == 0

recode m2_311_2 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_2 (0 = .) if m2_312 == 0

recode m2_311_3 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_3 (0 = .) if m2_312 == 0

recode m2_311_4 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_4 (0 = .) if m2_312 == 0

recode m2_311_5 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_5 (0 = .) if m2_312 == 0

recode m2_311_96 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode m2_311_96 (0 = .) if m2_312 == 0

replace m2_313_other = ".a" if m2_311_96 ==1

recode m2_314 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3

recode m2_315 (. = .a) if m2_314 == 1 | m2_314 == 98 | m2_314 == 99

recode m2_314_1 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_1 (0 = .) if m2_315 == 0

recode m2_314_2 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_2 (0 = .) if m2_315 == 0

recode m2_314_3 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_3 (0 = .) if m2_315 == 0

recode m2_314_4 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_4 (0 = .) if m2_315 == 0

recode m2_314_5 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_5 (0 = .) if m2_315 == 0

recode m2_314_96 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode m2_314_96 (0 = .) if m2_315 == 0

replace m2_316_other = ".a" if m2_314_96 ==1

recode m2_317 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3 | m2_302 == 4
recode m2_318 (. = .a) if m2_317 == 1 | m2_317 == 98 | m2_317 == 99

recode m2_317_1 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_1 (0 = .) if m2_318 == 0

recode m2_317_2 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_2 (0 = .) if m2_318 == 0

recode m2_317_3 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_3 (0 = .) if m2_318 == 0

recode m2_317_4 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_4 (0 = .) if m2_318 == 0

recode m2_317_5 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_5 (0 = .) if m2_318 == 0

recode m2_317_96 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode m2_317_96 (0 = .) if m2_318 == 0

replace m2_319_other = .a if m2_317_96 == 1

recode m2_320_a (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_a (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_b (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_b (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_c (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_c (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_d (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_d (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_e (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_e (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_f (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_f (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_g (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_g (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_h (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_h (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_i (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_i (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_j (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_j (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_k (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_k (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_l (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_l (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_96 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_96 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_320_99 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_320_99 (0 = .) if m2_202 == 1 & m2_301 == 0

recode m2_321 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
                       
recode m2_401 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == . | m2_302 == .a)

recode m2_402 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a)				   

recode m2_403 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2)	

recode m2_404 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3)			   
recode m2_405 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3 | m2_302 == 4)

recode m2_501a (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501b (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501c (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501d (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501e (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501f (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_501g (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_502 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99  | m2_301 == . | m2_301 == .a

recode m2_503a (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503b (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503c (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503d (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503e (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_503f (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99
recode m2_504 (. = .a) if m2_502 == 0 | m2_502 == 98 | m2_502 == 99

recode m2_505a (. = .a) if m2_503a == 0 | m2_503a == 98 | m2_503a == 99
recode m2_505b (. = .a) if m2_503b == 0 | m2_503b == 98 | m2_503b == 99
recode m2_506c (. = .a) if m2_503c == 0 | m2_503c == 98 | m2_503c == 99
recode m2_505d (. = .a) if m2_503d == 0 | m2_503d == 98 | m2_503d == 99
recode m2_505e (. = .a) if m2_503e == 0 | m2_503e == 98 | m2_503e == 99
recode m2_505f (. = .a) if m2_503f == 0 | m2_503f == 98 | m2_503f == 99
*recode m2_505g (. = .a) if m2_504 == 0 | m2_504 == 98 | m2_504 == 99

recode m2_506a (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506b (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506d (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_507 (. = .a) if m2_203a == 0 & m2_203b == 0 & m2_203c == 0 & m2_203d == 0 & m2_203e == 0 & m2_203f == 0 & m2_203g == 0 & m2_203h == 0 & m2_203i == 0 | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

*double check this:
recode m2_508a (. = .a) if (m2_205a+m2_205b) < 3

recode m2_508b_number (. = .a) if m2_508a == 0 | m2_508a == 98 | m2_508a == 99  | m2_508a == . | m2_508a == .a 

recode m2_508b_last (. = .a) if m2_508b_number == 0 | m2_508b_number == 98 | m2_508b_number == 99 | m2_508b_number == . | m2_508b_number == .a  

recode m2_508c (. = .a) if m2_508b_number == 0 | m2_508b_number == 98 | m2_508b_number == 99 | m2_508b_number == . | m2_508b_number == .a
 
recode m2_508d (. = .a) if m2_508c == 0 | m2_508c == 98 | m2_508c == 99 | m2_508c == . | m2_508c == .a

recode m2_509a (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_509b (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode m2_509c (. = .a) if m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_601a (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601b (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601d (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601e (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601f (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601g (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601h (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601i (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601j (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601l (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601m (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
recode m2_601n (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a

recode m2_602a (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a )| ///
						  (m2_601a !=1 & m2_601b !=1 & m2_601c !=1 & m2_601d !=1 & m2_601e !=1 & ///
						  m2_601f !=1 & m2_601g !=1 & m2_601h !=1 & m2_601i !=1 & m2_601j !=1 & ///
						  m2_601k !=1 & m2_601l !=1 & m2_601m !=1 & m2_601n !=1)
						  
recode m2_602b (. = .a) if m2_602a == 0 | m2_602a == 98 | m2_602a == 99	| m2_602a == . | m2_602a == .a

recode m2_603 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 
recode m2_604 (. = .a) if m2_603 == 2 | m2_603 == 3 | m2_603 == . | m2_603 == .a 
			
recode m2_701 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_702a (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702a_other (. = .a) if m2_702a !=1

recode m2_702b (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702b_other (. = .a) if m2_702b !=1

recode m2_702c (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702c_other (. = .a) if m2_702c !=1

recode m2_702d (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702d_other (. = .a) if m2_702d !=1

recode m2_702e (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_702e_other (. = .a) if m2_702e !=1

* SS: Ask Kate if we should add 98 into branching logic for 704_other
recode m2_703 m2_704 (. = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a

recode m2_704_other (. = .a) if m2_704 != 1 

recode m2_705_1 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_1 (0 = .) if m2_701 == 1

recode m2_705_2 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_2 (0 = .) if m2_701 == 1

recode m2_705_3 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_3 (0 = .) if m2_701 == 1

recode m2_705_4 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_4 (0 = .) if m2_701 == 1

recode m2_705_5 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_5 (0 = .) if m2_701 == 1

recode m2_705_6 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_6 (0 = .) if m2_701 == 1

recode m2_705_96 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode m2_705_96 (0 = .) if m2_701 == 1

recode m2_interview_inturrupt (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 
 
recode m2_interview_restarted (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a  | m2_interview_inturrupt == 0 | m2_interview_inturrupt == . | m2_interview_inturrupt == .a

recode m2_int_duration (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 

recode m2_endstatus (. = .a) if m2_endtime == ""

* MODULE 3:
recode m3_permission (. = .a) if m3_start_p1 !=1
recode m3_date recm3_time m3_birth_or_ended m3_303a m3_ga (. = .a) if m3_permission !=1 // SS 2-21: removed m3_ga1 m3_ga2

recode m3_303b (. = .a) if m3_303a == . | m3_303a == .a
recode m3_303c (. = .a) if m3_303a == 1 | m3_303a == . | m3_303a == .a | m3_303a == .d | m3_303a == .r
recode m3_303d (. = .a) if m3_303a == 1 |  m3_303a == 2 | m3_303a == . | m3_303a == .a | m3_303a == .d | m3_303a == .r

replace m3_baby1_name = ".a" if m3_303b == . | m3_303b == .a | m3_303b == .r // branching logic was incorrect in redcap
replace m3_baby2_name = ".a" if m3_303c == . | m3_303c == .a
replace m3_baby3_name = ".a" if m3_303d == . | m3_303d == .a

recode m3_baby1_gender (. = .a) if m3_303b !=1
recode m3_baby2_gender (. = .a) if m3_303c !=1
recode m3_baby3_gender (. = .a) if m3_303d !=1

recode m3_baby1_age (. = .a) if m3_303b !=1 & m3_303c !=1 & m3_303d !=1

recode m3_baby1_weight (. = .a) if m3_303b !=1
recode m3_baby2_weight (. = .a) if m3_303c !=1
recode m3_baby3_weight (. = .a) if m3_303d !=1

recode m3_baby1_size (. = .a) if m3_303b !=1
recode m3_baby2_size (. = .a) if m3_303c !=1
recode m3_baby3_size (. = .a) if m3_303d !=1

recode m3_baby1_health (. = .a) if m3_303b !=1 
recode m3_baby1_health (. = .a) if m3_303c !=1
recode m3_baby1_health (. = .a) if m3_303d !=1

recode m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e ///
	   m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_96 m3_baby1_feed_99 m3_baby1_feed_998 ///
	   m3_baby1_feed_999 m3_baby1_feed_888 (. = .a) if m3_303b !=1

replace m3_baby1_feed_other = ".a" if m3_baby1_feed_96 != 1

recode m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e ///
	    m3_baby2_feed_g m3_baby2_feed_96 m3_baby2_feed_99 m3_baby2_feed_998 ///
	   m3_baby2_feed_999 m3_baby2_feed_888 (. = .a) if m3_303c !=1

replace m3_baby2_feed_other = ".a" if m3_baby2_feed_96 != 1 

recode m3_baby3_feed_a m3_baby3_feed_b m3_baby3_feed_c m3_baby3_feed_d m3_baby3_feed_e ///
	   m3_baby3_feed_g m3_baby3_feed_96 m3_baby3_feed_99 m3_baby3_feed_998 ///
	   m3_baby3_feed_999 m3_baby3_feed_888 (. = .a) if m3_303d !=1

recode m3_baby3_feed_other (. = .a) if m3_baby3_feed_96 != 1 // SS: why is this numeric? will probably have to change to string once data is entered

recode m3_breastfeeding (. = .a) if (m3_303b !=1 & m3_303c !=1 & m3_303d !=1) | (m3_baby1_feed_a !=1 & m3_baby2_feed_a !=1 & m3_baby3_feed_a !=1) // SS: double check

recode m3_breastfeeding_fx_et (. = .a) if (m3_303b !=1 & m3_303c !=1 & m3_303d !=1) | (m3_baby1_feed_a !=1 & m3_baby2_feed_a !=1 & m3_baby3_feed_a !=1) // SS: double check

recode m3_baby1_born_alive (. = .a) if m3_303b !=0

recode m3_202 (. = .a) if m3_303b !=0 & m3_303c !=0 & m3_303d !=0

recode m3_baby2_born_alive (. = .a) if m3_303c !=0

recode m3_baby3_born_alive (. = .a) if m3_303d !=0

recode m3_313a_baby1 (. = .a) if m3_303b !=0 | m3_baby1_born_alive !=0

recode recm3_313b_baby1 (. = .a) if m3_303b !=0 | m3_baby1_born_alive !=0

recode m3_313a_baby2 (. = .a) if m3_303c !=0 | m3_baby2_born_alive !=0

recode m3_313b_baby2 (. = .a) if m3_303c !=0 | m3_baby2_born_alive !=0

recode m3_313a_baby3 (. = .a) if m3_303d !=0 | m3_baby3_born_alive !=0

recode m3_313b_baby3 (. = .a) if m3_303d !=0 | m3_baby3_born_alive !=0

recode m3_death_cause_baby1_a m3_death_cause_baby1_b m3_death_cause_baby1_c m3_death_cause_baby1_d ///
	   m3_death_cause_baby1_e m3_death_cause_baby1_f m3_death_cause_baby1_g m3_death_cause_baby1_96 ///
	   m3_death_cause_baby1_998 m3_death_cause_baby1_999 m3_death_cause_baby1_888 (. = .a) if ///
	   m3_303b !=0 | m3_202 == 4 | m3_202 == 5

replace m3_death_cause_baby1_other = ".a" if m3_death_cause_baby1_96 !=1	   
	   
recode m3_death_cause_baby2_a m3_death_cause_baby2_b m3_death_cause_baby2_c m3_death_cause_baby2_d ///
	   m3_death_cause_baby2_e m3_death_cause_baby2_f m3_death_cause_baby2_g m3_death_cause_baby2_96 ///
	   m3_death_cause_baby2_998 m3_death_cause_baby2_999 m3_death_cause_baby2_888 (. = .a) if ///
	   m3_303c !=0 | m3_202 == 4 | m3_202 == 5

*replace m3_death_cause_baby2_other = ".a" if m3_death_cause_baby2_96 !=1  // numeric because of 0 obs

recode m3_death_cause_baby3_a m3_death_cause_baby3_b m3_death_cause_baby3_c m3_death_cause_baby3_d ///
	   m3_death_cause_baby3_e m3_death_cause_baby3_f m3_death_cause_baby3_g m3_death_cause_baby3_96 ///
	   m3_death_cause_baby3_998 m3_death_cause_baby3_999 m3_death_cause_baby3_888 (. = .a) if ///
	   m3_303d !=0 | m3_202 == 4 | m3_202 == 5

*replace m3_death_cause_baby3_other = ".a" if m3_death_cause_baby3_96 !=1  // numeric because of 0 obs	   

recode m3_1201 (. = .a) if m3_202 !=4

recode m3_1202 (. = .a) if m3_1201 !=1

recode m3_1203 (. = .a) if m3_202 !=5

recode m3_1204 (. = .a) if m3_1203 !=1

recode m3_401 (. = .a) if (m3_303b !=1 & m3_303c !=1 & m3_303d !=1) | m3_202 !=3 | ///
						  (m3_baby1_born_alive != 1 & m3_baby2_born_alive !=1 & m3_baby3_born_alive !=1)

recode m3_402 (. = .a) if m3_401 !=1 & m3_consultation_3 !=1

recode m3_consultation_1 (. = .a) if m3_402 !=1 & m3_402 !=2 & m3_402 !=3 & m3_402 !=4 & m3_402 !=5
						  
recode m3_consultation_referral_1 (. = .a) if m3_consultation_1 !=0						  

recode m3_consultation1_reason_a m3_consultation1_reason_b m3_consultation1_reason_c ///
	   m3_consultation1_reason_d m3_consultation1_reason_e m3_consultation1_reason_96 ///
	   m3_consultation1_reason_998 m3_consultation1_reason_999 m3_consultation1_reason_888 ///
	   (. = .a) if m3_consultation_referral_1 !=0
	   
replace m3_consultation1_reason_other = ".a" if m3_consultation1_reason_96 !=1

recode m3_consultation_2 (. = .a) if m3_402 !=2 & m3_402 !=3 & m3_402 !=4 & m3_402 !=5

recode m3_consultation_referral_2 (. = .a) if m3_consultation_2 !=0
	   
recode m3_consultation2_reason_a m3_consultation2_reason_b m3_consultation2_reason_c ///
	   m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 ///
	   m3_consultation2_reason_998 m3_consultation2_reason_999 m3_consultation2_reason_888 ///
	   (. = .a) if m3_consultation_referral_2 !=0
	   
replace m3_consultation2_reason_other = ".a" if m3_consultation2_reason_96 !=1	   
	   
recode m3_consultation_3 (. = .a) if m3_402 !=3 & m3_402 !=4 & m3_402 !=5

recode m3_consultation_referral_3 (. = .a) if m3_consultation_3 !=0
	   
recode m3_consultation3_reason_a m3_consultation3_reason_b m3_consultation3_reason_c ///
	   m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 ///
	   m3_consultation3_reason_998 m3_consultation3_reason_999 m3_consultation3_reason_888 ///
	   (. = .a)	if m3_consultation_referral_3 !=0
	   
replace m3_consultation3_reason_other = ".a" if m3_consultation3_reason_96 !=1		

recode m3_consultation_4 (. = .a) if m3_402 !=4 & m3_402 !=5

recode m3_consultation_referral_4 (. = .a) if m3_consultation_4 !=0

recode m3_consultation4_reason_a m3_consultation4_reason_b m3_consultation4_reason_c ///
	   m3_consultation4_reason_d m3_consultation4_reason_e m3_consultation4_reason_96 ///
	   m3_consultation4_reason_998 m3_consultation4_reason_999 m3_consultation4_reason_888 ///
	   (. = .a) if m3_consultation_referral_4 !=0
	   
replace m3_consultation4_reason_other = ".a" if m3_consultation4_reason_96 !=1	

recode m3_consultation_5 (. = .a) if m3_402 !=5

recode m3_consultation_referral_5 (. = .a) if m3_consultation_5 !=0 

recode m3_consultation5_reason_a m3_consultation5_reason_b m3_consultation5_reason_c ///
	   m3_consultation5_reason_d m3_consultation5_reason_e m3_consultation5_reason_96 ///
	   m3_consultation5_reason_998 m3_consultation5_reason_999 m3_consultation5_reason_888 ///
	   (. = .a) if m3_consultation_referral_5 !=0
	   
*replace m3_consultation5_reason_other = ".a" if m3_consultation5_reason_96 !=1 // numeric because of 0 obs

recode m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g (. =.a) if m3_401 !=1

replace m3_412g_other = ".a" if m3_412g !=1

recode m3_501 (. = .a) if (m3_303b !=1 & m3_303c !=1 & m3_303d !=1) & (m3_baby1_born_alive !=1 & m3_baby2_born_alive !=1 & m3_baby3_born_alive !=1) & m3_202 !=3

recode m3_502 m3_503 (. = .a) if m3_501 !=1

replace m3_503_inside_zone_other = ".a" if m3_503 !=96

replace m3_503_outside_zone_other = ".a" if m3_503 !=97

replace m3_504a = ".a" if m3_503 !=97

replace m3_504b= ".a" if m3_503 !=97

recode m3_505a (. = .a) if m3_501 !=1

recode m3_505b (. = .a) if m3_505a !=1

recode m3_506a recm3_506b recm3_507 (. = .a) if m3_501 !=1

recode m3_506b_unknown (. = .a) if m3_501 !=1 & recm3_506b != . | recm3_506b != .a

recode m3_507_unknown (. = .a) if m3_501 !=1 & recm3_507 != . | recm3_507 != .a

recode m3_508 m3_509 (. = .a) if m3_501 !=0

replace m3_509_other = ".a" if m3_509 !=96

recode m3_510 (. = .a) if m3_501 !=1

recode m3_511 m3_512 (. = .a) if m3_510 !=1

*replace m3_512_outside_zone_other = ".a" if m3_512 !=97 // numeric because of 0 obs

recode m3_513a (. = .a) if m3_510 !=1

replace m3_513_inside_zone_other = ".a" if m3_513a != 96

replace m3_513_outside_zone_other = ".a" if m3_513a != 97

replace m3_513b1 = ".a" if m3_513a != 97

replace m3_513b2 = ".a" if m3_513a !=97

recode recm3_514 (. = .a) if m3_510 !=1

recode m3_514_unknown (. = .a) if m3_510 !=1 | (recm3_514 != . | recm3_514 !=.a)

recode m3_515 (. = .a) if m3_510 !=1 

recode m3_516 (. = .a) if m3_515 !=4 & m3_515 !=5

replace m3_516_other = ".a" if m3_516 !=96 

recode m3_517 (. = .a) if m3_515 !=2 & m3_515 !=3

recode m3_518 (. = .a) if m3_517 !=1

replace m3_518_other_complications = ".a" if m3_518 !=96

replace m3_518_other = ".a" if m3_518 !=97

recode m3_519 (. = .a) if m3_510 !=0

replace m3_519_other = ".a" if m3_519 !=96 

recode recm3_520 (. = .a) if m3_501 !=1 & m3_515 !=1

recode m3_520_unknown (. = .a) if m3_501 !=1 & (recm3_520 !=. | recm3_520 !=.a)

recode m3_521 (. = .a) if m3_501 !=1

recode m3_521_unknown (. = .a) if m3_501 !=1 | (m3_521 !=. | m3_521 !=.a)

*recode m3_p1_date_of_rescheduled m3_p1_time_of_rescheduled (. = .a) if m3_attempt_outcome !=6

recode m3_permission_p2 (. = .a) if m3_start_p2 !=1

recode m3_date_p2 recm3_time_p2 (. = .a) if m3_permission_p2 !=1

recode m3_201a (. = .a) if m3_permission_p2 !=1 | m3_303b !=1

recode m3_201b (. = .a) if m3_permission_p2 !=1 | m3_303c !=1

recode m3_201c (. = .a) if m3_permission_p2 !=1 | m3_303d !=1

recode m3_601a m3_601b m3_601c m3_602a m3_603a m3_603b m3_603c m3_603d ///
	   m3_604a m3_604b m3_605a (. = .a) if m3_permission_p2 !=1 | m3_501 !=1

recode m3_602b (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_602a !=0 & m3_602a !=2 & ///
						   m3_602a !=98 & m3_602a !=99)

recode m3_605b m3_605c_a m3_605c_b m3_605c_c m3_605c_d m3_605c_96 m3_605c_99 ///
	   m3_605c_998 m3_605c_999 m3_605c_888 (. = .a) if m3_605a !=1

replace m3_605c_other = ".a" if m3_605c_96 !=1

recode m3_606 m3_607 (. = .a) if m3_605a !=0

recode m3_607a_et m3_607b_et m3_607c_et m3_607d_et m3_607e_et m3_608 ///
	   (. = .a) if m3_permission_p2 !=1 | m3_501 !=1

recode m3_609 m3_610a m3_611 m3_612 (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | ///
	  (m3_303b !=1 & m3_303c !=1 & m3_303d !=1 & m3_baby1_born_alive !=1 & ///
	  m3_baby2_born_alive !=1 & m3_baby3_born_alive !=1)
	  
recode m3_610b (. = .a) if m3_610a !=1

recode m3_613 (. = .a) if m3_permission_p2 !=1 | m3_501 !=1	  

recode m3_614 (. = .a) if m3_613 !=1

recode m3_615a (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201a !=1 & m3_baby1_born_alive !=1)

recode m3_615b (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201b !=1 & m3_baby2_born_alive !=1)

recode m3_615c (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201c !=1 & m3_baby3_born_alive !=1)

recode m3_616a (. = .a) if m3_615a !=1

recode m3_616b (. = .a) if m3_615b !=1

recode m3_616c (. = .a) if m3_615c !=1

recode m3_617a (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201a !=1 & m3_baby1_born_alive !=1)

recode m3_617b (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201b !=1 & m3_baby2_born_alive !=1)

recode m3_617c (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201c !=1 & m3_baby3_born_alive !=1)

recode m3_617d_et (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201a !=1 & m3_baby1_born_alive !=1)

recode m3_617e_et (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201b !=1 & m3_baby2_born_alive !=1)

recode m3_617f_et (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201c !=1 & m3_baby3_born_alive !=1)

recode m3_617g_et (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201a !=1 & m3_baby1_born_alive !=1)

recode m3_617h_et (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201b !=1 & m3_baby2_born_alive !=1)

recode m3_617i_et (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201c !=1 & m3_baby3_born_alive !=1)

recode m3_619a m3_619b m3_619c m3_619d m3_619e m3_619f m3_619g m3_619h m3_619i m3_619j ///
	   m3_620 (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | (m3_201a !=1 & m3_201b !=1 & ///
	   m3_201c !=1 & m3_baby1_born_alive !=1 & m3_baby2_born_alive !=1 & m3_baby3_born_alive !=1)
						   
recode m3_621a m3_621b (. = .a) if m3_permission_p2 !=1 | m3_501 !=0			   
						   
recode m3_621c (. = .a) if m3_621b !=1

recode m3_622a m3_622c m3_701 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g ///
	   (. = .a) if m3_permission_p2 !=1

recode m3_622b (. = .a) if m3_622a !=1 

recode m3_baby1_sleep m3_baby1_feed m3_baby1_breath m3_baby1_stool m3_baby1_mood ///
	   m3_baby1_skin m3_baby1_interactivity (. = .a) if m3_permission_p2 !=1 | m3_201a !=1

recode m3_baby2_sleep m3_baby2_feed m3_baby2_breath m3_baby2_stool m3_baby2_mood ///
	   m3_baby2_skin m3_baby2_interactivity (. = .a) if m3_permission_p2 !=1 | m3_201b !=1

recode m3_baby3_sleep m3_baby3_feed m3_baby3_breath m3_baby3_stool m3_baby3_mood ///
	   m3_baby3_skin m3_baby3_interactivity (. = .a) if m3_permission_p2 !=1 | m3_201c !=1

replace m3_702 = ".a" if m3_701 !=1

recode m3_703 (. = .a) if m3_701 !=1

recode m3_705 m3_706 m3_707 (. = .a) if m3_permission_p2 !=1 | m3_501 !=1

recode m3_707_unknown (. = .a) if m3_permission_p2 !=1 | m3_707 != . | m3_707 != .a // SS: why is this numeric instead of string?

recode m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e ///
	   m3_baby1_issues_f m3_baby1_issues_96 m3_baby1_issues_98 m3_baby1_issues_99 m3_baby1_issues_998 ///
	   m3_baby1_issues_999 m3_baby1_issues_888 (. = .a) if m3_permission_p2 !=1 | m3_baby1_born_alive !=1
	   
recode m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e ///
	   m3_baby2_issues_f m3_baby2_issues_96 m3_baby2_issues_98 m3_baby2_issues_99 m3_baby2_issues_998 ///
	   m3_baby2_issues_999 m3_baby2_issues_888 (. = .a) if m3_permission_p2 !=1 | m3_baby2_born_alive !=1
	   
recode m3_baby3_issues_a m3_baby3_issues_b m3_baby3_issues_c m3_baby3_issues_d m3_baby3_issues_e ///
       m3_baby3_issues_f m3_baby3_issues_96 m3_baby3_issues_98 m3_baby3_issues_99 m3_baby3_issues_998 ///
	   m3_baby3_issues_999 m3_baby3_issues_888 (. = .a) if m3_permission_p2 !=1 | m3_baby3_born_alive !=1
 
replace m3_708a = ".a" if m3_baby1_issues_96 !=1

recode m3_708b (. = .a) if m3_baby2_issues_96 !=1 // numeric because of 0 obs

recode m3_709c (. = .a) if m3_baby3_issues_96 !=1 // numeric because of 0 obs
 
recode m3_710a m3_711a (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | m3_baby1_born_alive !=1

recode m3_710b m3_711b (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | m3_baby2_born_alive !=1

recode m3_710c m3_711c (. = .a) if m3_permission_p2 !=1 | m3_501 !=1 | m3_baby3_born_alive !=1

recode m3_801a m3_801b m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h ///
	   m3_803i m3_803j m3_805 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g ///
	   m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q ///
	   m3_901r (. = .a) if m3_permission_p2 !=1
 
recode m3_802a (. = .a) if (m3_801a !=0 | m3_801b !=3) & (m3_801a !=1 | m3_801b !=2) & ///
	   (m3_801a !=2 | m3_801b !=1) & (m3_801a !=3 | m3_801b !=0) & (m3_801a !=1 | m3_801b !=3) & ///
	   (m3_801a !=2 | m3_801b !=3) & (m3_801a !=2 | m3_801b !=2) & (m3_801a !=3 | m3_801b !=3) & ///
	   (m3_801a !=3 | m3_801b !=1) & (m3_801a !=3 | m3_801b !=2)
	   
recode m3_802b m3_802c (. = .a) if m3_802a !=1

replace m3_803j_other = ".a" if m3_803j !=1

recode m3_806 m3_807 m3_808a (. = .a) if m3_805 !=1

recode m3_808b (. = .a) if m3_805 !=1 | m3_808a !=0

replace m3_808b_other = ".a" if m3_808b !=96

recode m3_809 (. = .a) if m3_805 !=1 | m3_808a !=1

replace m3_901r_other = ".a" if m3_901r !=1

recode m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 (. = .a) if m3_permission_p2 !=1 | m3_201a !=1

recode m3_902a_baby2 m3_902b_baby2 m3_902c_baby2 m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 (. = .a) if m3_permission_p2 !=1 | m3_201b !=1

recode m3_902a_baby3 m3_902b_baby3 m3_902c_baby3 m3_902d_baby3 m3_902e_baby3 m3_902f_baby3 m3_902g_baby3 m3_902h_baby3 (. = .a) if m3_permission_p2 !=1 | m3_201c !=1

recode m3_902i_baby1 (. = .a) if (m3_permission_p2 !=1 | m3_201a !=1 | m1_202e !=1) & (m1_708b !=1 & m2_hiv_status !=1 & m2_505b !=1)

recode m3_902i_baby2 (. = .a) if (m3_permission_p2 !=1 | m3_201b !=1 | m1_202e !=1) & (m1_708b !=1 & m2_hiv_status !=1 & m2_505b !=1)
  
recode m3_902i_baby3 (. = .a) if (m3_permission_p2 !=1 | m3_201c !=1 | m1_202e !=1) & (m1_708b !=1 & m2_hiv_status !=1 & m2_505b !=1) 
 
recode m3_902j_baby1 (. = .a) if m3_permission_p2 !=1 | m3_201a !=1

replace m3_902j_baby1_other = ".a" if m3_902j_baby1 !=1

recode m3_902j_baby2 (. = .a) if m3_permission_p2 !=1 | m3_201b !=1
 
recode m3_902j_baby2_other (. = .a) if m3_902j_baby2 !=1 // numeric because of 0 obs

recode m3_902j_baby3 (. = .a) if m3_permission_p2 !=1 | m3_201c !=1

recode m3_902j_baby3_other (. = .a) if m3_902j_baby3 !=1 // numeric because of 0 obs

recode m3_1001 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f ///
	   m3_1004g m3_1004h m3_1004i m3_1004j m3_1004k m3_1005a m3_1005b m3_1005c m3_1005d ///
	   m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1007a m3_1007b m3_1007c m3_1101 ///
	   (. = .a) if m3_permission_p2 !=1 | m3_501 !=1
 
recode m3_1006b m3_1006c (. = .a) if m3_1006a !=1

recode m3_1102a m3_1102b m3_1102c m3_1102d m3_1102e m3_1102f m3_1103 m3_1105 (. = .a) if m3_1101 !=1

recode m3_1102a_amt (. = .a) if m3_1102a !=1

recode m3_1102b_amt (. = .a) if m3_1102b !=1

recode m3_1102c_amt (. = .a) if m3_1102c !=1

recode m3_1102d_amt (. = .a) if m3_1102d !=1

recode m3_1102e_amt (. = .a) if m3_1102e !=1

recode m3_1102f_amt (. = .a) if m3_1102f !=1

recode m3_1103_confirm (. = .a) if (m3_1103 == . |  m3_1103 == .a)

recode m3_1104 (. = .a) if m3_1103_confirm !=0

replace m3_1105_other = ".a" if m3_1105 !=96

recode m3_1106 m3_p2_outcome (. = .a) if m3_permission_p2 !=1

recode recm3_endtime recm3_duration (. = .a) if m3_permission_p2 !=1 | (m3_303b !=1  & m3_303c !=1 & m3_303d !=1 & m3_202 !=3)

*recode m3_p2_outcome_other (. = .a) if m3_p2_outcome !=96 // numeric because of 0 obs SS fix

*recode m3_p2_date_of_rescheduled recm3_p2_time_of_rescheduled (. = .a) if m3_attempt_outcome_p2 !=6

* MODULE 4:

* Variables related to the 2nd and 3rd baby should be coded as ".a" for women who only had one baby.
recode  m4_201_2 m4_201_3  m4_202_2 m4_202_3 m4_205a_2 m4_205a_3 m4_205b_2 m4_205b_3 m4_205c_2 m4_205c_3 m4_205d_2 m4_205d_3 m4_205e_2 m4_205e_3 m4_205f_2 m4_205f_3 m4_205g_2 m4_205g_3  m4_206a_2 m4_206a_3 m4_206b_2 m4_206b_3 m4_206c_2 m4_206c_3 m4_206d_2 m4_206d_3 m4_206e_2 m4_206e_3 m4_206f_2 m4_206f_3 m4_206g_2 m4_206g_3 m4_206h_2 m4_206h_3 m4_206i_2 m4_206i_3 m4_206j_2 m4_206j_3 m4_206k_2 m4_206k_3 m4_206l_2 m4_206l_3 m4_207a_2  m4_207a_3  m4_208a_2 m4_208a_2_unk m4_208a_3 m4_208a_3_unk m4_209_2 m4_209_3 m4_210_2_other m4_210_3_other m4_211_2 m4_211_3 m4_212_2 m4_212_3 (. = .a ) if m3_303a == 1

* 0 is recoded to a. for 2nd and 3rd child, if a participant has only 1 child
recode  m4_203_2_1 m4_203_2_2  m4_203_2_3 m4_203_2_4 m4_203_2_5 m4_203_2_6 m4_203_2_7 m4_203_2_99 m4_203_2_998 m4_203_2_999 m4_203_2_888  m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 m4_203_3_99 m4_203_3_998 m4_203_3_999 m4_203_3_888  m4_210_2_0 m4_210_2_1 m4_210_2_2 m4_210_2_3 m4_210_2_4 m4_210_2_5 m4_210_2_6 m4_210_2_7 m4_210_2_8 m4_210_2_9 m4_210_2_96 m4_210_2_998 m4_210_2_999 m4_210_2_888  m4_210_3_0 m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96 m4_210_3_998 m4_210_3_999 m4_210_3_888 (0 = .a ) if m3_303a == 1

recode m4_201_3 m4_202_3 m4_205a_3 m4_205b_3 m4_205c_3 m4_205d_3 m4_205e_3  m4_205f_3 m4_205g_3  m4_206a_3 m4_206b_3 m4_206c_3 m4_206d_3 m4_206e_3 m4_206f_3 m4_206g_3 m4_206h_3 m4_206i_3 m4_206j_3 m4_206k_3 m4_206l_3  m4_207a_3  m4_208a_3 m4_208a_3_unk m4_209_3 m4_210_3_other m4_211_2 m4_211_3 m4_212_2 m4_212_3  (. = .a ) if m3_303a == 2

* 0 is recoded to a. for 3rd child, if a participant has 2 children
recode m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 m4_203_3_99 m4_203_3_998 m4_203_3_999 m4_203_3_888  m4_210_3_0 m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96 m4_210_3_998 m4_210_3_999 m4_210_3_888 (0 = .a ) if m3_303a == 2
*-----------------------------------------------------*
*Breastfeeding 
recode m4_204a (. = .a) if m4_203_1_1 == 0
recode m4_204a (. = .a) if m4_203_2_1 == 0
recode m4_204a (. = .a) if m4_203_3_1 == 0
*-----------------------------------------------------*

* if baby is not alive 
recode m4_202_1  m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 m4_203_1_99 m4_203_1_998 m4_203_1_999 m4_203_1_888 m4_204a m4_205a_1 m4_205b_1 m4_205c_1 m4_205e_1 m4_205f_1 m4_205g_1 m4_206a_1 m4_206b_1 m4_206c_1 m4_206d_1 m4_206e_1 m4_206f_1 m4_206g_1 m4_206h_1 m4_206i_1 m4_206j_1 m4_206k_1 m4_206l_1 m4_207a_1  (. = .a ) if  m4_201_1 == 0 
*If the 1st baby is not alive then the questions about the first baby that have statement "Show the field ONLY if:[alive_or_died_baby_1_v2] = '1'" (in the codebook) are recoded (. = .a) 

recode  m4_202_2 m4_203_2_1 m4_203_2_2  m4_203_2_3 m4_203_2_4 m4_203_2_5 m4_203_2_6 m4_203_2_7 m4_203_2_99 m4_203_2_998 m4_203_2_999 m4_203_2_888  m4_205a_2 m4_205b_2 m4_205c_2 m4_205e_2 m4_205f_2 m4_205g_2 m4_206a_2 m4_206b_2 m4_206c_2 m4_206d_2 m4_206e_2 m4_206f_2 m4_206g_2 m4_206h_2 m4_206i_2 m4_206j_2 m4_206k_2 m4_206l_2 m4_207a_2 (. = .a) if  m4_201_2 == 0 
* the same was applied to 2nd and 3rd baby
recode m4_202_3  m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 m4_203_3_99 m4_203_3_998 m4_203_3_999 m4_203_3_888  m4_205a_3 m4_205b_3 m4_205c_3 m4_205e_3 m4_205f_3 m4_205g_3 m4_206a_3 m4_206b_3 m4_206c_3 m4_206d_3 m4_206e_3 m4_206f_3 m4_206g_3 m4_206h_3 m4_206i_3 m4_206j_3 m4_206k_3 m4_206l_3  m4_207a_3 (. = .a) if m4_201_3 == 0

*-----------------------------------------------------*
*If a baby is alive in the questions about death 
recode m4_209_1  m4_210_1_0 m4_210_1_1 m4_210_1_2 m4_210_1_3 m4_210_1_4 m4_210_1_5 m4_210_1_6 m4_210_1_7 m4_210_1_8 m4_210_1_9 m4_210_1_96 m4_210_1_998 m4_210_1_999 m4_210_1_888 m4_210_1_other m4_211_1 m4_212_1( . = .a) if  m4_201_1 == 1
**If the 1st baby is  alive then the questions about the first baby that have statement "Show the field ONLY if:[alive_or_died_baby_1_v2] = '2'" (questions about death) in the codebook are recoded (. = .a) 

recode  m4_210_1_0 m4_210_1_1 m4_210_1_2 m4_210_1_3 m4_210_1_4 m4_210_1_5 m4_210_1_6 m4_210_1_7 m4_210_1_8 m4_210_1_9 m4_210_1_96 m4_210_1_998 m4_210_1_999 m4_210_1_888  ( 0 = .a) if m4_201_1 == 1
*as above only for check box Qs

recode m4_208a_2  m4_209_2 m4_210_2_0 m4_210_2_1 m4_210_2_2 m4_210_2_3 m4_210_2_4 m4_210_2_5 m4_210_2_6 m4_210_2_7 m4_210_2_8 m4_210_2_9 m4_210_2_96 m4_210_2_998 m4_210_2_999 m4_210_2_888 m4_210_2_other m4_211_2 m4_212_2 ( . = .a) if   m4_201_2== 1

* EC: Mariia -- I added this code for the string variables:
replace m4_208a_1 = ".a" if m4_201_2==1 
replace m4_208a_1 = ".d" if m4_208a_1_unk==1 
drop m4_208a_1_unk 

gen m4_208a_2_string = string(m4_208a_2)
drop m4_208a_2 
rename m4_208a_2_string m4_208a_2
replace m4_208a_2 = ".a" if m4_201_2==1 | m3_303a==1
replace m4_208a_2 = ".d" if m4_208a_2_unk==1 
drop m4_208a_2_unk 

gen m4_208a_3_string = string(m4_208a_3)
drop m4_208a_3
rename m4_208a_3_string m4_208a_3
replace m4_208a_3 = ".a" if m4_201_3==1 | m3_303a==1 | m3_303a==2
replace m4_208a_3 = ".d" if m4_208a_3_unk==1
drop m4_208a_3_unk

recode m4_209_3 m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96 m4_210_3_998 m4_210_3_999 m4_210_3_888  m4_210_3_other m4_211_3 m4_212_2( . = .a) if m4_201_3 == 1

recode m4_210_3_0 m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96 m4_210_3_998 m4_210_3_999 m4_210_3_888 ( 0 = .a) if m4_201_3 == 1
*the same as above for the 2nd 

*---------------- Section 3: Health - Woman ----------*
*recoding of NR/RF to .r
 
recode m4_301 m4_302a m4_302b m4_303a m4_303b m4_303c m4_303d m4_303e m4_303f m4_303g m4_303h m4_304 m4_309 m4_401a m4_401b  m4_403a m4_403b m4_403c m4_405 m4_407 m4_409 m4_501 m4_502 m4_503 m4_601a_1 m4_601a_2 m4_601a_3 m4_601b_1 m4_601b_2 m4_601b_3  m4_601c_1 m4_601c_2 m4_601c_3 m4_601d_1 m4_601d_2 m4_601d_3 m4_601e_1 m4_601e_2 m4_601e_3 m4_601f_1 m4_601f_2 m4_601f_3 m4_601g_1 m4_601g_2 m4_601g_3 m4_601h_1 m4_601h_2 m4_601h_3 m4_601i_1 m4_601i_2 m4_601i_3 m4_618a_1 m4_618b_1 m4_618c_1 m4_618a_2 m4_618b_2 m4_618c_2 m4_618a_3 m4_618b_3 m4_618c_3 m4_602a m4_602b m4_602d m4_602e m4_602f m4_602g m4_701a m4_701b m4_701c m4_701d m4_701e m4_701f m4_701g m4_701h m4_702 m4_703a m4_703b m4_703c m4_703d m4_703e m4_703f m4_703g m4_704a m4_801a m4_801b m4_801c m4_801d m4_801e m4_801f m4_801g m4_801h m4_801i m4_801j m4_801k m4_801l m4_801m m4_801n m4_801o m4_801p m4_801q m4_801r  m4_802a_1 m4_802a_2 m4_802a_3 m4_802b_1 m4_802b_2 m4_802b_3 m4_802c_1 m4_802c_2 m4_802c_3 m4_802d_1 m4_802d_2 m4_802d_3 m4_802e_1 m4_802e_2 m4_802e_3 m4_802f_1 m4_802f_2 m4_802f_3 m4_802g_1 m4_802g_2 m4_802g_3 m4_802h_1 m4_802h_2 m4_802h_3 m4_802i_1 m4_802i_2 m4_802i_3 m4_802j_1 m4_802j_2 m4_802j_3 m4_803a_1 m4_803a_2 m4_803a_3 m4_803b_1 m4_803b_2 m4_803b_3 m4_803c_1 m4_803c_2 m4_803c_3 m4_803d_1 m4_803d_2 m4_803d_3 m4_803e_1 m4_803e_2 m4_803e_3 m4_803f_1 m4_803f_2 m4_803f_3 m4_901 m4_902a m4_902b m4_902c m4_902d m4_902e (99 = .r )

 
 *recoding of DK to .d
recode m4_301 m4_302a m4_302b m4_304 m4_401a m4_401b m4_403a m4_403b m4_403c m4_405 m4_407 m4_409 m4_601a_1 m4_601a_2 m4_601a_3 m4_601b_1 m4_601b_2 m4_601b_3  m4_601c_1 m4_601c_2 m4_601c_3 m4_601d_1 m4_601d_2 m4_601d_3 m4_601e_1 m4_601e_2 m4_601e_3 m4_601f_1 m4_601f_2 m4_601f_3 m4_601g_1 m4_601g_2 m4_601g_3 m4_601h_1 m4_601h_2 m4_601h_3 m4_601i_1 m4_601i_2 m4_601i_3 m4_618a_1 m4_618b_1 m4_618c_1 m4_618a_2 m4_618b_2 m4_618c_2 m4_618a_3 m4_618b_3 m4_618c_3 m4_602a m4_602b m4_602d m4_602e m4_602f m4_602g m4_701a m4_701b m4_701c m4_701d m4_701e m4_701f m4_701g m4_701h m4_702 m4_703a m4_703b m4_703c m4_703d m4_703e m4_703f m4_703g m4_704a m4_801a m4_801b m4_801c m4_801d m4_801e m4_801f m4_801g m4_801h m4_801i m4_801j m4_801k m4_801l m4_801m m4_801n m4_801o m4_801p m4_801q m4_801r  m4_802a_1 m4_802a_2 m4_802a_3 m4_802b_1 m4_802b_2 m4_802b_3 m4_802c_1 m4_802c_2 m4_802c_3 m4_802d_1 m4_802d_2 m4_802d_3 m4_802e_1 m4_802e_2 m4_802e_3 m4_802f_1 m4_802f_2 m4_802f_3 m4_802g_1 m4_802g_2 m4_802g_3 m4_802h_1 m4_802h_2 m4_802h_3 m4_802i_1 m4_802i_2 m4_802i_3 m4_802j_1 m4_802j_2 m4_802j_3 m4_803a_1 m4_803a_2 m4_803a_3 m4_803b_1 m4_803b_2 m4_803b_3 m4_803c_1 m4_803c_2 m4_803c_3 m4_803d_1 m4_803d_2 m4_803d_3 m4_803e_1 m4_803e_2 m4_803e_3 m4_803f_1 m4_803f_2 m4_803f_3 m4_901 m4_902a m4_902b m4_902c m4_902d m4_902e (99 = .r ) (98 = .d)

 *-----------------------------------------------------*
 * Variables related to the 2nd and 3rd baby are coded as ".a" for women who only had one baby.
 recode m4_403b m4_403c m4_601a_2 m4_601a_3 m4_601b_2 m4_601b_3 m4_601c_2 m4_601c_3 m4_601d_2 m4_601d_3 m4_601e_2 m4_601e_3 m4_601f_2 m4_601f_3 m4_601g_2 m4_601g_3 m4_601h_2 m4_601h_3 m4_601i_2 m4_601i_3 m4_601i_2_other m4_601i_3_other m4_618a_2 m4_618b_2 m4_618c_2 m4_618a_3 m4_618b_3 m4_618c_3   m4_603_2_other m4_603_3_other m4_802a_2 m4_802a_3 m4_802b_2 m4_802b_3 m4_802c_2 m4_802c_3 m4_802d_2 m4_802d_3 m4_802e_2 m4_802e_3 m4_802f_2 m4_802f_3 m4_802g_2 m4_802g_3 m4_802h_2 m4_802h_3 m4_802i_2 m4_802i_3 m4_802j_2 m4_802j_3 m4_802j_3_other m4_803a_2 m4_803a_3 m4_803b_2 m4_803b_3 m4_803c_2 m4_803c_3 m4_803d_2 m4_803d_3 m4_803e_2 m4_803e_3 m4_803f_2 m4_803f_3 m4_803g_3 m4_804_2 m4_804_3 (. = .a ) if m3_303a == 1


*recode m4_803g_2  m4_802j_2_other  ("" = ".a" ) if m3_303a == 1
*It doesn't work as well

recode m4_603_2_0 m4_603_2_1 m4_603_2_2 m4_603_2_3 m4_603_2_4 m4_603_2_5 m4_603_2_6 m4_603_2_96 m4_603_2_98 m4_603_2_99 m4_603_2_998 m4_603_2_999 m4_603_2_888 m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 m4_603_3_98 m4_603_3_99 m4_603_3_998 m4_603_3_999 m4_603_3_888 (0 = .a ) if m3_303a == 1
*the same for check box Qs

recode m4_403c m4_601a_3 m4_601b_3 m4_601c_3 m4_601d_3 m4_601e_3 m4_601f_3 m4_601g_3 m4_601h_3 m4_601i_3 m4_601i_3_other m4_618a_3 m4_618b_3 m4_618c_3 m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 m4_603_3_98 m4_603_3_99 m4_603_3_998 m4_603_3_999 m4_603_3_888 m4_603_3_other m4_802a_3 m4_802b_3 m4_802c_3 m4_802d_3 m4_802e_3 m4_802f_3 m4_802g_3 m4_802h_3 m4_802i_3 m4_802j_3 m4_802j_3_other m4_803a_3 m4_803b_3 m4_803c_3 m4_803d_3 m4_803e_3 m4_803f_3 m4_803g_3 m4_804_3 (. = .a ) if m3_303a == 2
 
recode m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 m4_603_3_98 m4_603_3_99 m4_603_3_998 m4_603_3_999 m4_603_3_888 (0 = .a ) if m3_303a == 2
*the same for check box Qs

*-----------------------------------------------------*
 *Qs about urine leakage (if the participants don't have leakage the next questions about symptoms and treatment are recoded to.a)
 recode m4_306 m4_307 m4_308 m4_309 m4_310  (0 = .a) if m4_305 == 0
 
  *Qs about cost of the healthcare visits (if the participants didn't pay any other extra money, the next questions about the cost are recoded to .a)
 recode  m4_902a m4_902a_amt m4_902b m4_902b_amt  m4_902c m4_902c_amt m4_902d m4_902d_amt m4_902e m4_902e_amt m4_903 m4_904 (0 = .a) if m4_901 == 0 
 
recode m4_905_1 m4_905_2 m4_905_3 m4_905_4 m4_905_5 m4_905_6 m4_905_96 (0 = .a) if m4_901 == 0

*-----------------------------------------------------*
*Qs about the number of consultation 
recode m4_402 m4_403a m4_403b m4_403c m4_404a m4_404b   m4_404c  m4_405  m4_407 m4_409 m4_412a m4_412b m4_412c m4_501 m4_502 m4_503 (. = .a) if m4_401a == 0 

recode m4_406_a  m4_406_b   m4_406_c   m4_406_d    m4_406_e   m4_406_f    m4_406_g     m4_406_h    m4_406_i m4_406_j m4_406_96 m4_406_998 m4_406_999 m4_406_888 m4_408_a m4_408_b m4_408_c m4_408_d m4_408_e m4_408_f m4_408_g m4_408_h m4_408_i m4_408_j m4_408_96 m4_408_998 m4_408_999 m4_408_888 m4_410_a m4_410_b m4_410_c m4_410_d m4_410_e m4_410_f m4_410_g m4_410_h m4_410_i m4_410_j m4_410_96 m4_410_998 m4_410_999 m4_410_888 (0 = .a) if m4_401a == 0 
* if they didn't have any consultations

recode m4_403b m4_403c m4_404b m4_404c m4_407 m4_409 m4_412b m4_412c m4_502 m4_503 (. = .a) if m4_402 == 1

recode m4_408_a m4_408_b m4_408_c m4_408_d m4_408_e m4_408_f m4_408_g m4_408_h m4_408_i m4_408_j m4_408_96 m4_408_998 m4_408_999 m4_408_888 m4_410_a m4_410_b m4_410_c m4_410_d m4_410_e m4_410_f m4_410_g m4_410_h m4_410_i m4_410_j m4_410_96 m4_410_998 m4_410_999 m4_410_888 (0 = .a) if m4_402 == 1
* if they had only 1 consultation 
recode m4_403c m4_404c m4_409 m4_412c m4_503 (. = .a) if m4_402 == 2
recode m4_410_a m4_410_b m4_410_c m4_410_d m4_410_e m4_410_f m4_410_g m4_410_h m4_410_i m4_410_j m4_410_96 m4_410_998 m4_410_999 m4_410_888 (0 = .a) if m4_402 == 2
* if they had only2 consultations 

*-----------------------------------------------------*
* if baby is not alive 
recode m4_601a_1 m4_601b_1 m4_601c_1 m4_601d_1 m4_601e_1 m4_601f_1 m4_601g_1 m4_601h_1 m4_601i_1 m4_618a_1 m4_618b_1 m4_618c_1  m4_802a_1 m4_802b_1 m4_802c_1 m4_802d_1 m4_802e_1 m4_802f_1 m4_802g_1 m4_802h_1 m4_802i_1 m4_802j_1 m4_803a_1 m4_803b_1 m4_803c_1 m4_803d_1 m4_803e_1 m4_803f_1 m4_804_1 (. = .a ) if  m4_201_1 == 0 
*If the 1st baby is not alive then the questions about the first baby are recoded (. = .a) 

recode m4_601a_2 m4_601b_2 m4_601c_2 m4_601d_2 m4_601e_2 m4_601f_2 m4_601g_2 m4_601h_2 m4_601i_2 m4_618a_2 m4_618b_2 m4_618c_2  m4_802a_2 m4_802b_2 m4_802c_2 m4_802d_2 m4_802e_2 m4_802f_2 m4_802g_2 m4_802h_2 m4_802i_2 m4_802j_2 m4_803a_2 m4_803b_2 m4_803c_2 m4_803d_2 m4_803e_2 m4_803f_2 m4_804_2 (. = .a) if  m4_201_2 == 0 
*If the 2nd baby is not alive then the questions about the 2nd baby are recoded (. = .a) 
recode m4_601a_3 m4_601b_3 m4_601c_3 m4_601d_3 m4_601e_3 m4_601f_3 m4_601g_3 m4_601h_3 m4_601i_3 m4_601i_3_other m4_618a_3 m4_618b_3 m4_618c_3 m4_802a_3 m4_802b_3 m4_802c_3 m4_802d_3 m4_802e_3 m4_802f_3 m4_802g_3 m4_802h_3 m4_802i_3 m4_802j_3 m4_803a_3 m4_803b_3 m4_803c_3 m4_803d_3 m4_803e_3 m4_803f_3 m4_804_3 (. = .a) if m4_201_3 == 0
*If the 3rd baby is not alive then the questions about the 3rd baby are recoded (. = .a) 
*-----------Check box questions-----------*  
recode m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 (0 = .r) if m4_203_1_99 == 1
recode m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 (0 = .r) if m4_203_1_999 == 1
recode m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 (0 = .d) if m4_203_1_998 == 1
recode m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 (0 = .d) if m4_203_1_888 == 1

recode m4_203_2_1 m4_203_2_2  m4_203_2_3 m4_203_2_4 m4_203_2_5 m4_203_2_6 m4_203_2_7 (0 = .r) if m4_203_2_99 == 1
recode m4_203_2_1 m4_203_2_2  m4_203_2_3 m4_203_2_4 m4_203_2_5 m4_203_2_6 m4_203_2_7 (0 = .r) if m4_203_2_999 == 1
recode m4_203_2_1 m4_203_2_2  m4_203_2_3 m4_203_2_4 m4_203_2_5 m4_203_2_6 m4_203_2_7 (0 = .d) if m4_203_2_998 == 1
recode m4_203_2_1 m4_203_2_2  m4_203_2_3 m4_203_2_4 m4_203_2_5 m4_203_2_6 m4_203_2_7 (0 = .d) if m4_203_2_888 == 1

recode  m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 (0 = .r) if m4_203_3_99 == 1
recode  m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 (0 = .r) if m4_203_3_999 == 1
recode  m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 (0 = .d) if m4_203_3_998 == 1
recode  m4_203_3_1 m4_203_3_2 m4_203_3_3 m4_203_3_4 m4_203_3_5 m4_203_3_6 m4_203_3_7 (0 = .d) if m4_203_3_888 == 1

recode m4_210_1_0 m4_210_1_1 m4_210_1_2 m4_210_1_3 m4_210_1_4 m4_210_1_5 m4_210_1_6 m4_210_1_7 m4_210_1_8 m4_210_1_9 m4_210_1_96  (0 = .d) if  m4_210_1_998 == 1
recode   m4_210_1_0 m4_210_1_1 m4_210_1_2 m4_210_1_3 m4_210_1_4 m4_210_1_5 m4_210_1_6 m4_210_1_7 m4_210_1_8 m4_210_1_9 m4_210_1_96 (0 = .r) if  m4_210_1_999== 1
recode m4_210_1_0 m4_210_1_1 m4_210_1_2 m4_210_1_3 m4_210_1_4 m4_210_1_5 m4_210_1_6 m4_210_1_7 m4_210_1_8 m4_210_1_9 m4_210_1_96  (0 = .d) if  m4_210_1_888 == 1

recode  m4_210_2_0 m4_210_2_1 m4_210_2_2 m4_210_2_3 m4_210_2_4 m4_210_2_5 m4_210_2_6 m4_210_2_7 m4_210_2_8 m4_210_2_9 m4_210_2_96 (0 = .d) if  m4_210_2_998 == 1
recode m4_210_2_0 m4_210_2_1 m4_210_2_2 m4_210_2_3 m4_210_2_4 m4_210_2_5 m4_210_2_6 m4_210_2_7 m4_210_2_8 m4_210_2_9 m4_210_2_96 (0 = .r) if  m4_210_2_999 == 1
recode  m4_210_2_0 m4_210_2_1 m4_210_2_2 m4_210_2_3 m4_210_2_4 m4_210_2_5 m4_210_2_6 m4_210_2_7 m4_210_2_8 m4_210_2_9 m4_210_2_96  (0 = .d) if  m4_210_2_888 == 1

recode m4_210_3_0 m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96  (0 = .d) if  m4_210_3_888 == 1
recode  m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96   (0 = .r) if  m4_210_3_999 == 1
recode  m4_210_3_1 m4_210_3_2 m4_210_3_3 m4_210_3_4 m4_210_3_5 m4_210_3_6 m4_210_3_7 m4_210_3_8 m4_210_3_9 m4_210_3_96  (0 = .d) if  m4_210_3_998 == 1

recode  m4_406_a m4_406_b   m4_406_c   m4_406_d    m4_406_e   m4_406_f    m4_406_g     m4_406_h    m4_406_i m4_406_j m4_406_96 (0 = .d) if  m4_406_998 == 1
recode  m4_406_a m4_406_b   m4_406_c   m4_406_d    m4_406_e   m4_406_f    m4_406_g     m4_406_h    m4_406_i m4_406_j m4_406_96 (0 = .r) if  m4_406_999 == 1
recode  m4_406_a m4_406_b   m4_406_c   m4_406_d    m4_406_e   m4_406_f    m4_406_g     m4_406_h    m4_406_i m4_406_j m4_406_96 (0 = .d) if  m4_406_888 == 1

recode m4_408_a m4_408_b m4_408_c m4_408_d m4_408_e m4_408_f m4_408_g m4_408_h m4_408_i m4_408_j m4_408_96 (0 = .d) if  m4_408_998 == 1
recode m4_408_a m4_408_b m4_408_c m4_408_d m4_408_e m4_408_f m4_408_g m4_408_h m4_408_i m4_408_j m4_408_96 (0 = .r) if  m4_408_999 == 1
recode m4_408_a m4_408_b m4_408_c m4_408_d m4_408_e m4_408_f m4_408_g m4_408_h m4_408_i m4_408_j m4_408_96 (0 = .d) if  m4_408_888 == 1

recode m4_410_a m4_410_b m4_410_c m4_410_d m4_410_e m4_410_f m4_410_g m4_410_h m4_410_i m4_410_j m4_410_96 (0 = .d) if  m4_410_998 == 1
recode m4_410_a m4_410_b m4_410_c m4_410_d m4_410_e m4_410_f m4_410_g m4_410_h m4_410_i m4_410_j m4_410_96 (0 = .r) if  m4_410_999 == 1
recode m4_410_a m4_410_b m4_410_c m4_410_d m4_410_e m4_410_f m4_410_g m4_410_h m4_410_i m4_410_j m4_410_96 (0 = .d) if  m4_410_888 == 1

recode  m4_413_a m4_413_b m4_413_c  m4_413_d  m4_413_e  m4_413_f m4_413_g  m4_413_h  m4_413_i   m4_413_j m4_413_k m4_413_96 (0 = .r) if  m4_413_99 == 1
recode  m4_413_a m4_413_b m4_413_c  m4_413_d  m4_413_e  m4_413_f m4_413_g  m4_413_h  m4_413_i   m4_413_j m4_413_k m4_413_96 (0 = .d) if  m4_413_998 == 1
recode  m4_413_a m4_413_b m4_413_c  m4_413_d  m4_413_e  m4_413_f m4_413_g  m4_413_h  m4_413_i   m4_413_j m4_413_k m4_413_96 (0 = .r) if  m4_413_999 == 1
recode  m4_413_a m4_413_b m4_413_c  m4_413_d  m4_413_e  m4_413_f m4_413_g  m4_413_h  m4_413_i   m4_413_j m4_413_k m4_413_96 (0 = .d) if  m4_413_888 == 1

recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (0 = .d) if  m4_603_1_98 == 1
recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (0 = .r) if  m4_603_1_99 == 1
recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (0 = .d) if  m4_603_1_998 == 1 
recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (0 = .r) if  m4_603_1_999 == 1
recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (0 = .d) if  m4_603_1_888 == 1

recode m4_603_2_0 m4_603_2_1 m4_603_2_2 m4_603_2_3 m4_603_2_4 m4_603_2_5 m4_603_2_6 m4_603_2_96  (0 = .d) if  m4_603_2_98 == 1
recode  m4_603_2_0 m4_603_2_1 m4_603_2_2 m4_603_2_3 m4_603_2_4 m4_603_2_5 m4_603_2_6 m4_603_2_96 (0 = .r) if  m4_603_2_99 == 1
recode  m4_603_2_0 m4_603_2_1 m4_603_2_2 m4_603_2_3 m4_603_2_4 m4_603_2_5 m4_603_2_6 m4_603_2_96 (0 = .d) if  m4_603_2_998 == 1
recode  m4_603_2_0 m4_603_2_1 m4_603_2_2 m4_603_2_3 m4_603_2_4 m4_603_2_5 m4_603_2_6 m4_603_2_96 (0 = .r) if  m4_603_2_999 == 1
recode  m4_603_2_0 m4_603_2_1 m4_603_2_2 m4_603_2_3 m4_603_2_4 m4_603_2_5 m4_603_2_6 m4_603_2_96 (0 = .d) if  m4_603_2_888 == 1

recode  m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 (0 = .d) if  m4_603_3_98 == 1
recode  m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 (0 = .r) if  m4_603_3_99 == 1
recode  m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 (0 = .d) if  m4_603_3_998 == 1
recode  m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 (0 = .r) if  m4_603_3_999 == 1
recode  m4_603_3_0 m4_603_3_1 m4_603_3_2 m4_603_3_3 m4_603_3_4 m4_603_3_5 m4_603_3_6 m4_603_3_96 (0 = .d) if  m4_603_3_888 == 1

recode  m4_905_1 m4_905_2 m4_905_3 m4_905_4 m4_905_5 m4_905_6 m4_905_96  (0 = .d) if  m4_905_998 == 1
recode  m4_905_1 m4_905_2 m4_905_3 m4_905_4 m4_905_5 m4_905_6 m4_905_96  (0 = .r) if  m4_905_999 == 1
recode  m4_905_1 m4_905_2 m4_905_3 m4_905_4 m4_905_5 m4_905_6 m4_905_96  (0 = .d) if  m4_905_888 == 1

drop m4_203_1_99 m4_203_1_999 m4_203_1_998 m4_203_1_888 m4_203_2_99 m4_203_2_999 m4_203_2_998 m4_203_2_888 m4_203_3_99 m4_203_3_998 m4_203_3_999 m4_203_3_888 m4_210_1_998 m4_210_1_999 m4_210_1_888 m4_210_2_998 m4_210_2_999 m4_210_2_888 m4_210_3_998 m4_210_3_999 m4_210_3_888 m4_406_998 m4_406_999 m4_406_888 m4_408_998 m4_408_999 m4_408_888 m4_410_998 m4_410_999 m4_410_888 m4_413_99 m4_413_998 m4_413_999 m4_413_888 m4_603_1_98 m4_603_1_99   m4_603_1_888 m4_603_2_98 m4_603_2_99 m4_603_2_998 m4_603_2_999 m4_603_2_888 m4_603_3_98 m4_603_3_99 m4_603_3_998 m4_603_3_999 m4_603_3_888 m4_905_998 m4_905_999 m4_905_888



*------------------------------------------------------------------------------*
* drop variables after recoding/renaming

drop m1_714d  module_3_second_phone_survey_aft m3_time m3_313b_baby1 m3_506b m3_507 ///
	 m3_514 m3_520 m3_time_p2 m3_endtime m3_p2_time_of_rescheduled m3_duration
ren rec* *

*===============================================================================					   
	
	* STEP FOUR: LABELING VARIABLES
label variable country "Country"
label variable site "Study site - adama/east shewa" 
label variable sampstrata "Facility type and level"
label variable redcap_record_id "Redcap Record ID"
label variable redcap_event_name "Redcap Event Name"
label variable redcap_repeat_instrument "Redcap Repeat Instrument"
label variable redcap_repeat_instance "Redcap Repeat Instance"
label variable redcap_data_access_group "Redcap Data Access Group"
label variable study_id "Study ID"
label variable interviewer_id "Interviewer ID"

	** MODULE 1:		

lab var m1_date"A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var study_site "A4. Study site"
lab var study_site_sd "A4_Other. Specify other study site"
lab var facility "A5. Facility name"
lab var facility_other "A5_Other. Specify other facility name"
lab var facility_type "A5. Facility type"
lab var interviewer_name_a7 "A7. Interviewer Name"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var m1_enrollage "B3. How old are you?"
lab var zone_live "B4. In which zone/district/ sub city are you living?"
lab var b5anc "B5. By that I mean care related to a pregnancy?"
lab var b6anc_first "B6. Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?"
lab var b6anc_first_conf "01. Data collector confirms with provider that this is the woman's first visit. Data collector confirms with maternal health card that it is the woman's first visit."
lab var continuecare "ETH-1-B. Do you plan to continue receiving care for your pregnancy in the East Shewa zone or Adama town?"
lab var b7eligible "B7. Is the respondent eligible to participate in the study AND signed a consent form?"
lab var first_name "101. What is your first name?"
lab var family_name "102. What is your family name?"
lab var respondentid "103. Assign respondent ID"
lab var mobile_phone "104. Do you have a mobile phone with you today?"
lab var phone_number "105. What is your phone number?"
lab var flash "106. Can I 'flash' this number now to make sure I have noted it correctly?"
lab var kebele_malaria "Eth-1-1 Interviewer check whether the area that the woman living is malarias or not?"
lab var kebele_intworm "Eth-2-1. Interviewer check whether the area that the woman living is endemic for intestinal worm or not?"
lab var m1_201 "201. In general, how would you rate your overall health?"
lab var m1_202a "202a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202d. BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202e. BEFORE you got pregnant, did you know that you had HIV?"
lab var m1_202f "202f. BEFORE you got pregnant, did you know that you had Hepatitis B?"
lab var m1_202g "202g. BEFORE you got pregnant, did you know that you had Renal disorder?"
lab var m1_203_et "203. Before you got pregnant, were you diagnosed with any other major health problems?"
lab var m1_203_other "203_Other. Specify the diagnosis health problem"
lab var m1_204 "204. Are you currently taking any medications?"
lab var m1_205a "205a. I am going to read three statements about your mobility, by which I mean your ability to walk around. Please indicate which statement best describe your own health state today?"
lab var m1_205b "205b. I am now going to read three statements regarding your ability to self-care, by which I mean whether you can wash and dress yourself without assistance. Please indicate which statement best describe your own health state today"
lab var m1_205c "205c. I am going to read three statements regarding your ability to perform your usual daily activities, by which I mean your ability to work, take care of your family or perform leisure activities. Please indicate which statement best describe your own health state today"
lab var m1_205d "205d. I am going to read three statements regarding your experience with physical pain or discomfort. Please indicate which statement best describe your own health state today"
lab var m1_205e "205e. I am going to read three statements regarding your experience with anxiety or depression. Please indicate which statements best describe your own health state today"
lab var phq9a "206a. Over the past 2 weeks, how many days have you been bothered by little interest or pleasure in doing things?"
lab var phq9b "206b. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless?"
lab var phq9c "206c. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
lab var phq9d "206d. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy?"
lab var phq9e "206e. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating?"
lab var phq9f "206f. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down?"
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
lab var m1_401_other "401_Other. Other specify"
lab var m1_402 "402. How long in minutes did it take you to reach this facility from your home?"
lab var m1_403a "403a. Do you know the distance from your home to the / facility?"
lab var m1_403b "403b. How far in kilometers is your home from this facility?"
lab var m1_404 "404. Is this the nearest health facility to your home that provides antenatal care for pregnant women?"
lab var m1_405 "405. What is the most important reason for choosing this facility for your visit today?"
lab var m1_405_other "405_Other. Specify other reason"
lab var m1_501 "501. What is your first language?"
lab var m1_501_other "501_Other. Specify other language"
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
lab var m1_513a_1 "513a. What phone numbers can we use to reach you in the coming months? / Primary personal phone"
lab var m1_513a_2 "513a. What phone numbers can we use to reach you in the coming months? / Secondary personal phone"
lab var m1_513a_3 "513a. What phone numbers can we use to reach you in the coming months? / Spouse or partner phone"
lab var m1_513a_4 "513a. What phone numbers can we use to reach you in the coming months? / Community health worker phone"
lab var m1_513a_5 "513a. What phone numbers can we use to reach you in the coming months? / Friend or other family member phone 1"
lab var m1_513a_6 "513a. What phone numbers can we use to reach you in the coming months? / Friend or other family member phone 2"
lab var m1_513a_7 "513a. What phone numbers can we use to reach you in the coming months? / Other phone"
lab var m1_513a_8 "513a. What phone numbers can we use to reach you in the coming months? / Does not have any phone numbers"
lab var m1_513a_999 "513a. Unknown"
lab var m1_513a_998 "513a. Refuse to answer"
lab var m1_513a_888 "513a. No information"
lab var m1_513b "513b. Primary personal phone number"
lab var m1_513c "513c. Can I flash this number now to make sure I have noted it correctly?"
lab var m1_513d "513d. Secondary personal phone number"
lab var m1_513e "513e. Spouse or partner phone number"
lab var m1_513f "513f. Community health worker phone"
lab var m1_513g "513g. Close friend or family member phone"
lab var m1_513h "513h. Close friend or family member phone number 2"
lab var m1_513i "513i. Other phone number"
lab var m1_514a "514a. We would like you to be able to participate in this study. We can give you a mobile phone for you to take home so that we can reach you. Would you like to receive a mobile phone?"
lab var m1_514b "514b. Interviewer enters the number of the phone provided. Interviewer flashes the number to ensure it is entered correctly."
lab var m1_515a "515a. Where is your town/district?"
lab var m1_515b "515b. Where is your zone or sub-city?"
lab var m1_515c "515c. Where is your Kebele you live?"
lab var m1_515d "515d. What is your village name/block"
lab var m1_516 "516. Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions"
lab var m1_517 "517. Is this a temporary residence or a permanent residence?"
lab var m1_518 "518. Until when will you be at this residence?"
lab var m1_519_district "519a. Where will your district be after this date?"
lab var m1_519_ward "519b. Where will your kebele be after this date"
lab var m1_519_village "519c. Where will your village be after this date"
lab var m1_601 "601. Overall how would you rate the quality of care you received today?"
lab var m1_602 "602. How likely are you to recommend this facility or provider to a family member or friend to receive care for their pregnancy?"
lab var m1_603 "603. How long in minutes did you spend with the health provider today?"
lab var m1_604 "604. How long in minutes did you wait between the time you arrived at this facility and the time you were able to see a provider for the consultation?"
lab var m1_604b_et "Eth-1-6-1. How long in hours did you spend at this facility today for all aspects of your care, including wait time, the consultation, and any other components of your care today?"
lab var m1_604c_et "Eth-1-6.2. How long in hours did you spend at this facility today for all aspects of your care, including wait time, the consultation, and any other components of your care today?"
lab var m1_605a "605a. How would you rate the knowledge and skills of your provider?"
lab var m1_605b "605b. How would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab?"
lab var m1_605c "605c. How would you rate the level of respect the provider showed you?"
lab var m1_605d "605d. How would you rate the clarity of the provider's explanations?"
lab var m1_605e "605e. How would you rate the degree to which the provider involved you as much as you wanted to be in decisions about your care?"
lab var m1_605f "605f. How would you rate the amount of time the provider spent with you?"
lab var m1_605g "605g. How would you rate the amount of time you waited before being seen?"
lab var m1_605h "605h. How would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider?"
lab var m1_605i_et "605i. How would you rate the confidentiality of care or diagnosis?"
lab var m1_605j_et "605j. How would you rate the privacy (Auditory or visual)?"
lab var m1_605k_et "605k. How would you rate the affordability of charge or bill to the service?"
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
lab var m1_713a "713a_1. Iron and folic acid pills?"
lab var m1_713b "713b_1. Calcium pills?"
lab var m1_713c "713c_1. The food supplement like Super Cereal or Plumpynut?"
lab var m1_713d "713d_1. Medicine for intestinal worms?"
lab var m1_713e "713e_1. Medicine for malaria (endemic only)?"
lab var m1_713f "713f_1. Medicine for your emotions, nerves, or mental health?"
lab var m1_713g "713g_1. Multivitamins?"
lab var m1_713h "713h_1. Medicine for hypertension?"
lab var m1_713i "713i_1. Medicine for diabetes, including injections of insulin?"
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
lab var m1_802b_et "802b. Do you know your last normal menstrual period?"
lab var m1_802c_et "802c. What is the date of your last normal menstrual period"
lab var m1_802d_et "802d. Gestational age in weeks based on LNMP"
lab var m1_803 "803. How many weeks pregnant do you think you are?" 
lab var m1_804 "804. Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)."
lab var m1_805 "805. How many babies are you pregnant with?"
lab var m1_806 "806. During the visit today, did the healthcare provider ask when you had your last period, or not?"
lab var m1_807 "807. When you got pregnant, did you want to get pregnant at that time?"
lab var m1_808_0_et "808. Didn't realize you were pregnant"
lab var m1_808_1_et "808. Tried to come earlier and were sent away"
lab var m1_808_2_et "808. You received care at home"
lab var m1_808_3_et "808. High cost (e.g., high out of pocket payment, not covered by insurance)"
lab var m1_808_4_et "808. Far distance (e.g., too far to walk or drive, transport not readily available)"
lab var m1_808_5_et "808. Long waiting time (e.g., long line to access facility, long wait for the provider)"
lab var m1_808_6_et "808. Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
lab var m1_808_7_et "808. Staff don't show respect (e.g., staff is rude, impolite, dismissive) "
lab var m1_808_8_et "808. Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
lab var m1_808_9_et "808. COVID-19 fear"
lab var m1_808_10_et "808. Don't know where to go (e.g., too complicated)"
lab var m1_808_11_et "808. Fear of discovering serious problems"
lab var m1_808_12_et "808. Do not know advantage of early coming"
lab var m1_808_96_et "808. Other, specify"
lab var m1_808_99_et "808. NR/RF"
lab var m1_808_888_et "808. Unknown"
lab var m1_808_998_et "808. Refuse to answer"
lab var m1_808_999_et "808. No information"
lab var m1_808_other "808_Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_810_other "810b_Other. Other than the list above, specify"
lab var m1_811 "811. Do you plan to stay at a maternity waiting home before delivering your baby?"
lab var m1_812a "812a. During the visit today, did the provider tell you that you might need a C-section?"
lab var m1_812b_0_et "812b.0. Have you told the reason why you might need a c-section?"
lab var m1_812b_1 "812b. Because I had a c-section before"
lab var m1_812b_2 "812b. Because I am pregnant with more than one baby"
lab var m1_812b_3 "812b. Because of the baby's position"
lab var m1_812b_4 "812b. Because of the position of the placenta"
lab var m1_812b_5 "812b. Because I have health problems"
lab var m1_812b_96 "812b. Other, specify"
lab var m1_812b_98 "812b. DK"
lab var m1_812b_99 "812b. NR/RF"
lab var m1_812b_888_et "812b. Unknown"
lab var m1_812b_998_et "812b. Refuse to answer"
lab var m1_812b_999_et "812b. No information"
lab var m1_812b_other "812_Other. Specify other reason for C-section"
lab var m1_813a "813a. Some women experience common health problems during pregnancy. Did you experience nausea in your pregnancy so far, or not?"
lab var m1_813b "813b. Some women experience common health problems during pregnancy. Did you experience heartburn in your pregnancy so far, or not?"
lab var m1_813c "813c. Some women experience common health problems during pregnancy. Did you experience leg cramps in your pregnancy so far, or not?"
lab var m1_813d "813d. Some women experience common health problems during pregnancy. Did you experience back pain in your pregnancy so far, or not?"
lab var m1_813e "813e. During the visit today did the provider give you treatment or advice for addressing these kinds of problems?"
lab var m1_8a_et "Eth-1-8a. Did you experience Preeclampsia / Eclampsia in your pregnancy so far, or not?"
lab var m1_8b_et "Eth-1-8b. Some women experience medical and obstetric health problems during pregnancy. Did you experience Hyperemesis gravidarum during pregnancy in your pregnancy so far, or not?"
lab var m1_8c_et "Eth-1-8c. Some women experience medical and obstetric health problems during pregnancy. Did you experience Anemia during pregnancy in your pregnancy so far, or not?"
lab var m1_8d_et "Eth-1-8d. Some women experience medical and obstetric health problems during pregnancy. Did you experience Amniotic fluid volume problems (Oligohydramnios / Polyhydramnios) during pregnancy in your pregnancy so far, or not?"
lab var m1_8e_et "Eth-1-8e. Some women experience medical and obstetric health problems during pregnancy. Did you experience Asthma during pregnancy in your pregnancy so far, or not?"
lab var m1_8f_et "Eth-1-8f. Some women experience medical and obstetric health problems during pregnancy. Did you experience RH isoimmunization during pregnancy in your pregnancy so far, or not?"
lab var m1_8g_et "Eth - 1 - 8g. Any other pregnancy problem"
lab var m1_8gother_et "Eth-1-8g_Other. Specify any other experience in your pregnancy so far"
lab var m1_2_8_et "Eth-2-8. During the visit today, did the provider give you a treatment or advice for addressing these kinds of problems?"
lab var m1_814a "814a. Could you please tell me if you have experienced Severe or persistent headaches in your pregnancy so far, or not?"
lab var m1_814b "814b. Could you please tell me if you have experienced Vaginal bleeding of any amount in your pregnancy so far, or not?"
lab var m1_814c "814c. Could you please tell me if you have experienced a fever in your pregnancy so far, or not?"
lab var m1_814d "814d. Could you please tell me if you have experienced Severe abdominal pain, not just discomfort in your pregnancy so far, or not?"
lab var m1_814e "814e. Could you please tell me if you have experienced a lot of difficulty breathing even when you are resting in your pregnancy so far, or not?"
lab var m1_814f "814f. Could you please tell me if you have experienced Convulsions or seizures in your pregnancy so far, or not?"
lab var m1_814g "814g. Could you please tell me if you have experienced repeated fainting or loss of consciousness in your pregnancy so far, or not?"
lab var m1_814h "814h. Could you please tell me if you have experienced noticing that the baby has completely stopped moving in your pregnancy so far, or not?"
lab var m1_814i "814i. Could you please tell me if you have experienced blurring of vision in your pregnancy so far, or not?"
lab var m1_815_0 "815. Nothing, we did not discuss this"
lab var m1_815_1 "815.Told me to come back to this health facility"
lab var m1_815_2 "815.They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815_3 "815.They provided a treatment in the visit"
lab var m1_815_4 "815. They prescribed a medication"
lab var m1_815_5 "815. They told you to come back to this health facility "
lab var m1_815_6 "815. They told you to go somewhere else for higher level care"
lab var m1_815_7 "815. They told you to wait and see"
lab var m1_815_96 "815. Other (specify)"
lab var m1_815_98 "815. DK"
lab var m1_815_99 "815. NR/RF"
lab var m1_815_888_et "815. Unknown"
lab var m1_815_998_et "815. Refuse to answer"
lab var m1_815_999_et "815. No information"
lab var m1_815_other "815_Other. Other (specify)"
lab var m1_816 "816. You said that you did not have any of the symptoms I just listed. Did the health provider ask you whether or not you had these symptoms, or did this topic not come up today?"
lab var m1_901 "901. How often do you currently smoke cigarettes or use any other type of tobacco? Is it every day, some days, or not at all?"
lab var m1_902 "902. During the visit today, did the health provider advise you to stop smoking or using tobacco products?"
lab var m1_903 "903. How often do you chew khat? Is it every day, some days, or not at all?"
lab var m1_904 "904. During the visit today, did the health provider advise you to stop chewing khat?"
lab var m1_905 "905. Have you consumed an alcoholic drink (i.e., Tela, Tej, Areke, Bira, Wine, Borde, Whisky) within the past 30 days?"
lab var m1_906 "906. When you do drink alcohol, how many standard drinks do you consume on average?"
lab var m1_907 "907. During the visit today, did the health provider advise you to stop drinking alcohol?"
lab var m1_1001 "1001. How many pregnancies have you had, including the current pregnancy and regardless of whether you gave birth or not?"
lab var m1_1002 "1002. How many births have you had (including babies born alive or dead)?"
lab var m1_1003 "1003. In how many of those births was the baby born alive?"
lab var m1_1004 "1004. Have you ever lost a pregnancy after 20 weeks of being pregnant?"
lab var m1_1005 "1005. Have you ever had a baby that came too early, more than 3 weeks before the due date / Small baby?"
lab var m1_1006 "1006. Have you ever bled so much in a previous pregnancy or delivery that you needed to be given blood or go back to the delivery room for an operation?"
lab var m1_1_10_et "Eth-1-10. Have you ever had a baby born with a congenital anomaly? I mean a neural tube defect"
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
lab var  m1_1102_a "1102. Current husband / partner"
lab var  m1_1102_b "1102. Parent (Mother; Father, step-parent, in-law)"
lab var  m1_1102_c  "1102. Sibling"
lab var  m1_1102_d "1102. Child"
lab var m1_1102_e "1102. Late /last / ex-husband/partner"
lab var  m1_1102_f "1102. Other relative"
lab var  m1_1102_g "1102. Friend /acquaintance/"
lab var  m1_1102_h   "1102. Teacher"
lab var  m1_1102_i  "1102. Employer"
lab var  m1_1102_j "1102. Stranger"
lab var  m1_1102_96 "1102. Other, specify"
lab var  m1_1102_98 "1102. DK"
lab var  m1_1102_99 "1102. NR/RF"
lab var  m1_1102_88_et "1102. Unknown"
lab var  m1_1102_98_et "1102. Refuse to answer"
lab var  m1_1102_99_et "1102. No information"
lab var m1_1102_other "1102_Oth. Specify who else hit, kick, slapped, ... you"
lab var m1_1103 "1103. At any point during your current pregnancy, has anyone ever said or done something to humiliate you, insulted you or made you feel bad about yourself?"
lab var m1_1104_a "1104. Current husband / partner"
lab var m1_1104_b "1104. Parent (Mother; Father, step-parent, in-law)"
lab var m1_1104_c "1104. Sibling"
lab var m1_1104_d "1104. Child"
lab var m1_1104_e "1104. Late /last / ex-husband/partner"
lab var m1_1104_f "1104. Other relative"
lab var m1_1104_g "1104. Friend /acquaintance"
lab var m1_1104_h "1104. Teacher"
lab var m1_1104_i "1104. Employer"
lab var m1_1104_j "1104. Stranger"
lab var m1_1104_96 "1104. Other (specify)"
lab var m1_1104_98 "1104. DF"
lab var m1_1104_99 "1104. NR/RF"
lab var m1_1104_888_et "1104. Unknown"
lab var m1_1104_998_et "1104. Refuse to answer"
lab var m1_1104_999_et "1104. No information"
lab var m1_1104_other "1104_Other. Specify others who humiliates you"
lab var m1_1105 "1105. During the visit today, did the health provider discuss with you where you can seek support for these things?"
lab var m1_1201 "1201. What is the main source of drinking water for members of your household?"
lab var m1_1201_other "1201_Other. Specify other source of drink water"
lab var m1_1202 "1202. What kind of toilet facilities does your household have?"
lab var m1_1202_other "1202_Other. Specify other kind of toilet facility"
lab var m1_1203 "1203. Does your household have electricity?"
lab var m1_1204 "1204. Does your household have a radio?"
lab var m1_1205 "1205. Does your household have a television?"
lab var m1_1206 "1206. Does your household have a telephone or a mobile phone?"
lab var m1_1207 "1207. Does your household have a refrigerator?"
lab var m1_1208 "1208. What type of fuel does your household mainly use for cooking?"
lab var m1_1208_other "1208_Other. Specify other fuel type for cooking"
lab var m1_1209 "1209. What is the main material of your floor?"
lab var m1_1209_other "1209_Other. Specify other fuel type for cooking"
lab var m1_1210 "1210. What is the main material your walls are made of?"
lab var m1_1210_other "1210_Other. Specify other fuel type for cooking"
lab var m1_1211 "1211. What is the main material your roof is made of?"
lab var m1_1211_other "1211_Other. Specify other fuel type for cooking"
lab var m1_1212 "1212. Does any member of your household own a bicycle?"
lab var m1_1213 "1213. Does any member of your household own a motorcycle or motor scooter?" 
lab var m1_1214 "1214. Does any member of your household own a car or truck?"
lab var m1_1215 "1215. Does any member of your household have a bank account?"
lab var m1_1216 "1216. Do you know number of meals does your household usually have per day?"
lab var m1_1216_1 "1216.1. How many meals does your household usually have per day?"
lab var m1_1217 "1217. Did you pay money out of your pocket for this visit, including for the consultation or other indirect costs like your transport to the facility?"
lab var m1_1218a "1218a. Have you spent money for registration or consultation?"
lab var m1_1218a_1 "1218a.1. How much money did you spend on Registration / Consultation?"
lab var m1_1218b "1218b. Have you spent money for Medicine/vaccines (including outside purchase)"
lab var m1_1218b_1 "1218b.1. How much money do you spent for medicine/vaccines (including outside purchase)"
lab var m1_1218c "1218c. Have you spent money for Test/investigations (x-ray, lab etc.)?"
lab var m1_1218c_1 "1218c.1. How much money have you spent on Test/investigations (x-ray, lab etc.)?"
lab var m1_1218d "1218d. Have you spent money for Transport (round trip) including that of person accompanying you?"
lab var m1_1218d_1 "1218d.1. How much money have you spent for transport (round trip) including that of person accompanying you?"
lab var m1_1218e "1218e. Have you spent money for food and accommodation including that of person accompanying you?"
lab var m1_1218e_1 "1218e.1. How much money have you spent on food and accommodation including that of the person accompanying you?"
lab var m1_1218f "1218f. Have you spent money for other purpose?"
lab var m1_1218f_1 "1218f.1. How much money have you spent for other purpose?"
lab var m1_1219 "Total amount spent"
lab var m1_1220_1 "1220. Current income of any household members"
lab var m1_1220_2 "1220. Saving(bank account"
lab var m1_1220_3 "1220. Payment or reimbursement from a health insurance plan"
lab var m1_1220_4 "1220. Sold items (e.g. furniture, animals, jewellery, furniture)"
lab var m1_1220_5 "1220. Family members or friends from outside the household"
lab var m1_1220_6 "1220. Borrowed (from someone other than a friend or family)"
lab var m1_1220_96 "1220. Other (specify)"
lab var m1_1220_888_et "1220. Unknown"
lab var m1_1220_998_et "1220. Refuse to answer"
lab var m1_1220_999_et "1220. No information"
lab var m1_1220_other "1220_Other. Specify other financial source for household use to pay for this"
lab var m1_1221 "1221. Are you covered with a health insurance?"
lab var m1_1222 "1222. What type of health insurance coverage do you have?"
lab var m1_1222_other "1222_Other. Specify other health insurance"
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
lab var muac "Measured Upper arm circumference"
lab var m1_1306 "1306. Hemoglobin level available in maternal health card"
lab var m1_1307 "1307. HEMOGLOBIN LEVEL FROM MATERNAL HEALTH CARD "
lab var m1_1308 "1308. Will you take the anemia test?"
lab var m1_1309 "1309. HEMOGLOBIN LEVEL FROM TEST PERFORMED BY DATA COLLECTOR"
lab var m1_1401 "1401. What period of the day is most convenient for you to answer the phone survey?"
lab var m1_1402_1_et "1402. Which is the best phone number to use to contact you: The phone provided for the study"
lab var m1_1402_2_et "1402. Which is the best phone number to use to contact you: Primary personal phone"
lab var m1_1402_3_et "1402. Which is the best phone number to use to contact you: Secondary personal phone"
lab var m1_1402_4_et "1402. Which is the best phone number to use to contact you: Spouse or partner phone"
lab var m1_1402_5_et "1402. Which is the best phone number to use to contact you: Community health worker phone"
lab var m1_1402_6_et "1402. Which is the best phone number to use to contact you: Friend or other family member phone 1 "
lab var m1_1402_7_et "1402. Which is the best phone number to use to contact you: Friend or other family member phone 2"
lab var m1_1402_8_et "1402. Which is the best phone number to use to contact you: Other phone"
lab var m1_1402_9_et "1402. Which is the best phone number to use to contact you: Does not have any phone numbers"
lab var m1_1402_888_et "1402. Unknown"
lab var m1_1402_998_et "1402. Refuse to answer"
lab var m1_1402_999_et "1402. No information"
lab var m1_end_time "Interview end time"
lab var m1_interview_length "Total Duration of interview"
lab var m1_complete "Complete?"


	** MODULE 2:
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
label variable m2_320_a "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? No reason or you didn't need it"
label variable m2_320_b "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? You tried but were sent away (e.g., no appointment available) "
label variable m2_320_c "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? High cost (e.g., high out of pocket payment, not covered by insurance)"
label variable m2_320_d "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Far distance (e.g., too far to walk or drive, transport not readily available)"
label variable m2_320_e "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Long waiting time (e.g., long line to access facility, long wait for the provider)"
label variable m2_320_f "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
label variable m2_320_g "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Staff don't show respect (e.g., staff is rude, impolite, dismissive)"
label variable m2_320_h "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
label variable m2_320_i "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) "
label variable m2_320_j "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 fear"
label variable m2_320_k "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Don't know where to go/too complicated"
label variable m2_320_l "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Fear of discovering serious problem"
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
label variable m3_start_p1 "IIC. May I proceed with the interview?"
label variable m3_permission "CR1. Permission granted to conduct call"
label variable m3_date "102. Date of interview (D-M-Y)"
label variable m3_time "103A. Time of interview started"
label variable m3_birth_or_ended "201a. On what date did you give birth or did the pregnancy end?"
*label variable m3_ga1 "201d. Gestational age at birth or end of pregnancy (based on LNMP)"
*label variable m3_ga2 "201e. Gestational age at birth or end of pregnancy (based on maternal estimation)"
label variable m3_303a "301. If its ok with you, I would like to now ask some questions about the baby or babies. How many babies were you pregnant with?"
label variable m3_303b "303a. Is the 1st baby alive?"
label variable m3_303c "303b. Is the 2nd baby alive?"
label variable m3_303d "303c. Is the 3rd   baby alive?"
label variable m3_baby1_name "304a. What is the 1st babys name?"
label variable m3_baby2_name "304b. What is the 2nd babys name?"
label variable m3_baby3_name "304c. What is the 3rd babys name?"
label variable m3_baby1_gender "305a. What is first baby's's gender?"
label variable m3_baby2_gender "305b. what is the second baby's gender?"
label variable m3_baby3_gender "305c. What is the third baby's gender?"
label variable m3_baby1_age "306a. How old is the baby?"
label variable m3_baby1_weight "307a. How much did the first baby weigh at birth in KG?"
label variable m3_baby2_weight "307b.How much did the second baby weigh at birth?"
label variable m3_baby3_weight "307c. How much did the third baby weigh at birth?"
label variable m3_baby1_size "308a. When the first baby was born, were they: very large, larger than average, average, smaller than average or very small?"
label variable m3_baby2_size "308b. When the second baby was born, were they: very large, larger than average, average, smaller than average or very small?"
label variable m3_baby3_size "308c. When the third baby was born, were they: very large, larger than average, average, smaller than average or very small?"
label variable m3_baby1_health "309a. In general, how would you rate the first baby's overall health?"
label variable m3_baby2_health "309b. In general, how would you rate the second baby's overall health?"
label variable m3_baby3_health "309c. In general, how would you rate the third baby's overall health?"
label variable m3_baby1_feed_a "310a.1. People feed their babies in different ways. Please indicate how you have fed the first baby in the last 7 days? Indicate all that apply. (choice=Breast milk)"
label variable m3_baby1_feed_b "310a. People feed their babies in different ways. Please indicate how you have fed the first baby in the last 7 days? Indicate all that apply. (choice=Formula/Cow milk)"
label variable m3_baby1_feed_c "310a. People feed their babies in different ways. Please indicate how you have fed the first baby in the last 7 days? Indicate all that apply. (choice=Water)"
label variable m3_baby1_feed_d "310a. People feed their babies in different ways. Please indicate how you have fed the first baby in the last 7 days? Indicate all that apply. (choice=Juice)"
label variable m3_baby1_feed_e "310a. People feed their babies in different ways. Please indicate how you have fed the first baby in the last 7 days? Indicate all that apply. (choice=Broth)"
label variable m3_baby1_feed_f "310a. People feed their babies in different ways. Please indicate how you have fed the first babyin the last 7 days? Indicate all that apply. (choice=Baby food)"
label variable m3_baby1_feed_g "310a. People feed their babies in different ways. Please indicate how you have fed [what_is_the_1st_baby_name] in the last 7 days? Indicate all that apply. (choice=Local food)"
label variable m3_baby1_feed_96 "310a. People feed their babies in different ways. Please indicate how you have fed [what_is_the_1st_baby_name] in the last 7 days? Indicate all that apply. (choice=Other, specify)"
label variable m3_baby1_feed_99 "310a. People feed their babies in different ways. Please indicate how you have fed [what_is_the_1st_baby_name] in the last 7 days? Indicate all that apply. (choice=NR/RF)"
label variable m3_baby1_feed_998 "310a. People feed their babies in different ways. Please indicate how you have fed [what_is_the_1st_baby_name] in the last 7 days? Indicate all that apply. (choice=Unknown)"
label variable m3_baby1_feed_999 "310a. People feed their babies in different ways. Please indicate how you have fed [what_is_the_1st_baby_name] in the last 7 days? Indicate all that apply. (choice=Refuse to answer)"
label variable m3_baby1_feed_888 "310a. People feed their babies in different ways. Please indicate how you have fed [what_is_the_1st_baby_name] in the last 7 days? Indicate all that apply. (choice=No Information)"
label variable m3_baby1_feed_other "310a_Oth. Other specify"
label variable m3_baby2_feed_a "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Breast milk)"
label variable m3_baby2_feed_b "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Formula/Cow milk)"
label variable m3_baby2_feed_c "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Water)"
label variable m3_baby2_feed_d "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Juice)"
label variable m3_baby2_feed_e "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply.(choice=Broth)"
*label variable m3_baby2_feed_f "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Baby food)"
label variable m3_baby2_feed_g "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Local food)"
label variable m3_baby2_feed_96 "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Other, specify)"
label variable m3_baby2_feed_99 "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=NR/RF)"
label variable m3_baby2_feed_998 "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Unknown)"
label variable m3_baby2_feed_999 "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=Refuse to answer)"
label variable m3_baby2_feed_888 "310a. People feed their babies in different ways. Please indicate how you have fed the second baby in the last 7 days? Indicate all that apply. (choice=No Information)"
label variable m3_baby2_feed_other "310a_Oth. Other specify"
label variable m3_baby3_feed_a "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Breast milk)"
label variable m3_baby3_feed_b "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Formula/Cow milk)"
label variable m3_baby3_feed_c "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Water)"
label variable m3_baby3_feed_d "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Juice)"
label variable m3_baby3_feed_e "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Broth)"
*label variable m3_baby3_feed_f "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Baby food)"
label variable m3_baby3_feed_g "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Local food/butter)"
label variable m3_baby3_feed_96 "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Other, specify)"
label variable m3_baby3_feed_99 "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=NR/RF)"
label variable m3_baby3_feed_998 "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Unknown)"
label variable m3_baby3_feed_999 "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=Refuse to answer)"
label variable m3_baby3_feed_888 "310a. People feed their babies in different ways. Please indicate how you have fed the third baby in the last 7 days? Indicate all that apply. (choice=No Information)"
label variable m3_baby3_feed_other "310a_Oth. Other specify"
label variable m3_breastfeeding "310b. As of today, how confident do you feel about breastfeeding your baby/babies?"
label variable m3_breastfeeding_fx_et "Eth 1-3. How often per day in average your baby  or babies breastfed?"
label variable m3_baby1_born_alive "312a. I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it is okay with you, I would like to ask a few more questions about the baby. Was the baby born alive? Did the baby cry, make any movement, sound, or effort to breathe, or show any other signs of life even if for a very short time?"
label variable m3_202 "202. Data collectors need to choose the status of birth based on the gestational age at death in 201d (or 201e if 201d is missing). If baby died before 28 weeks, this is a miscarriage, and the survey ends. If baby died after 28 weeks, this is a stillbirth. Continue the survey. If the woman reports getting an abortion, report it here, and end the survey."
label variable m3_baby2_born_alive "312b. I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it is okay with you, I would like to ask a few more questions about the baby. Was the baby born alive? Was the second baby born alive? Did the baby cry, make any movement, sound, or effort to breathe, or show any other signs of life even if for a very short time?"
label variable m3_baby3_born_alive "312c. I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it is okay with you, I would like to ask a few more questions about the baby.  Was the baby born alive? Was the 3rd baby born alive? Did the baby cry, make any movement, sound, effort to breathe, or show any other signs of life even if for a very short time?"
label variable m3_313a_baby1 "313a1. On what day did the first baby baby die (i.e. the date of death)?"
label variable m3_313b_baby1 "313b1. At what time did the first baby baby die?"
label variable m3_313a_baby2 "313a2. On what day did the second baby die (i.e.the date of death)?"
label variable m3_313b_baby2 "313b2. At what time did the second baby die?"
label variable m3_313a_baby3 "313a3. On what day did the third baby die?"
label variable m3_313b_baby3 "313b3. At what time did the third baby die?"
label variable m3_death_cause_baby1_a "314c.1. What were you told was the cause of death for the baby, or were you not told? (choice=Not told anything)"
label variable m3_death_cause_baby1_b "314c. What were you told was the cause of death for the baby, or were you not told? (choice=The baby was premature (born too early))"
label variable m3_death_cause_baby1_c "314c. What were you told was the cause of death for the baby, or were you not told? (choice=An infection)"
label variable m3_death_cause_baby1_d "314c. What were you told was the cause of death for the baby, or were you not told? (choice=A congenital abnormality (genetic or acquired issues with growth/ development))"
label variable m3_death_cause_baby1_e "314c. What were you told was the cause of death for the baby, or were you not told? (choice=A birth injury or asphyxia (occurring because of delivery complications))"
label variable m3_death_cause_baby1_f "314c. What were you told was the cause of death for the baby, or were you not told? (choice=Difficulties breathing)"
label variable m3_death_cause_baby1_g "314c. What were you told was the cause of death for the baby, or were you not told? (choice=Unexplained causes)"
label variable m3_death_cause_baby1_96 "314c. What were you told was the cause of death for the baby, or were you not told? (choice=Other specify)"
label variable m3_death_cause_baby1_998 "314c. What were you told was the cause of death for the baby, or were you not told? (choice=Unknown)"
label variable m3_death_cause_baby1_999 "314c. What were you told was the cause of death for the baby, or were you not told? (choice=Refuse to answer)"
label variable m3_death_cause_baby1_888 "314c. What were you told was the cause of death for the baby, or were you not told? (choice=No Information)"
label variable m3_death_cause_baby1_other "314c_Oth. Specify other death cause for 1st  baby"
label variable m3_death_cause_baby2_a "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=Not told anything)"
label variable m3_death_cause_baby2_b "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=The baby was premature (born too early))"
label variable m3_death_cause_baby2_c "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=An infection)"
label variable m3_death_cause_baby2_d "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=A congenital abnormality (genetic or acquired issues with growth/ development))"
label variable m3_death_cause_baby2_e "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=A birth injury or asphyxia (occurring because of delivery complications))"
label variable m3_death_cause_baby2_f "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=Difficulties breathing)"
label variable m3_death_cause_baby2_g "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=Unexplained causes)"
label variable m3_death_cause_baby2_96 "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=Other specify)"
label variable m3_death_cause_baby2_998 "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=Unknown)"
label variable m3_death_cause_baby2_999 "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=Refuse to answer)"
label variable m3_death_cause_baby2_888 "314c. What were you told was the cause of death for the 2nd baby, or were you not told? (choice=No Information)"
label variable m3_death_cause_baby2_other "314c_Oth. Specify other death case for the 2nd baby"
label variable m3_death_cause_baby3_a "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=Not told anything)"
label variable m3_death_cause_baby3_b "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=The baby was premature (born too early))"
label variable m3_death_cause_baby3_c "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=An infection)"
label variable m3_death_cause_baby3_d "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=A congenital abnormality (genetic or acquired issues with growth/ development))"
label variable m3_death_cause_baby3_e "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=A birth injury or asphyxia (occurring because of delivery complications))"
label variable m3_death_cause_baby3_f "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=Difficulties breathing)"
label variable m3_death_cause_baby3_g "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=Unexplained causes)"
label variable m3_death_cause_baby3_96 "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=Other specify)"
label variable m3_death_cause_baby3_998 "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=Unknown)"
label variable m3_death_cause_baby3_999 "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=Refuse to answer)"
label variable m3_death_cause_baby3_888 "314c. What were you told was the cause of death for the 3rd baby, or were you not told? (choice=No Information)"
label variable m3_death_cause_baby3_other "314c_Oth. Specify other death case for the 3rd baby"
label variable m3_1201 "1201. Im sorry to hear you had a miscarriage. If its ok with you I would like to ask a few more questions. When the miscarriage occurred, did you go to a health facility for follow-up?"
label variable m3_1202 "1202. Overall, how would you rate the quality of care that you received for your miscarriage?"
label variable m3_1203 "1203. Did you go to a health facility to receive this abortion?"
label variable m3_1204 "1204. Overall, how would you rate the quality of care that you received for your abortion?"
label variable m3_401 "401. Before we talk about the delivery, I would like to ask about any additional health care you may have received since you last spoke to us and BEFORE the delivery. We are interested in ALL NEW healthcare consultations that you may have had for yourself between the time of the last survey and the delivery.  Since you last spoke to us, did you have any new healthcare consultations for yourself before the delivery?"
label variable m3_402 "402. How many new healthcare consultations did you have?"
label variable m3_consultation_1 "403. Was the 1st consultation for a routine antenatal care visit?"
label variable m3_consultation_referral_1 "404. Was the 1st for referral from your antenatal care provider?"
label variable m3_consultation1_reason_a "405. Was the 1st visit for any of the following? Include all that apply. (choice=A new health problem, including an emergency or an injury)"
label variable m3_consultation1_reason_b "405. Was the 1st visit for any of the following? Include all that apply. (choice=An existing health problem)"
label variable m3_consultation1_reason_c "405. Was the 1st visit for any of the following? Include all that apply. (choice=A lab test, x-ray, or ultrasound)"
label variable m3_consultation1_reason_d "405. Was the 1st visit for any of the following? Include all that apply. (choice=To pick up medicine)"
label variable m3_consultation1_reason_e "405. Was the 1st visit for any of the following? Include all that apply. (choice=To get a vaccine)"
label variable m3_consultation1_reason_96 "405. Was the 1st visit for any of the following? Include all that apply. (choice=Other reasons, please specify)"
label variable m3_consultation1_reason_998 "405. Was the 1st visit for any of the following? Include all that apply. (choice=Unknown)"
label variable m3_consultation1_reason_999 "405. Was the 1st visit for any of the following? Include all that apply. (choice=Refuse to answer)"
label variable m3_consultation1_reason_888 "405. Was the 1st visit for any of the following? Include all that apply. (choice=No Information)"
label variable m3_consultation1_reason_other "405_Oth. Other reasons, please specify"
label variable m3_consultation_2 "406. Was the 2nd consultation for a routine antenatal care visit?"
label variable m3_consultation_referral_2 "407. Was the 2nd for referral from your antenatal care provider?"
label variable m3_consultation2_reason_a "408. Was the 2nd visit for any of the following? Include all that apply. (choice=A new health problem, including an emergency or an injury)"
label variable m3_consultation2_reason_b "408. Was the 2nd visit for any of the following? Include all that apply. (choice=An existing health problem)"
label variable m3_consultation2_reason_c "408. Was the 2nd visit for any of the following? Include all that apply. (choice=A lab test, x-ray, or ultrasound)"
label variable m3_consultation2_reason_d "408. Was the 2nd visit for any of the following? Include all that apply. (choice=To pick up medicine)"
label variable m3_consultation2_reason_e "408. Was the 2nd visit for any of the following? Include all that apply. (choice=To get a vaccine)"
label variable m3_consultation2_reason_96 "408. Was the 2nd visit for any of the following? Include all that apply. (choice=Other reasons, please specify)"
label variable m3_consultation2_reason_998 "408. Was the 2nd visit for any of the following? Include all that apply. (choice=Unknown)"
label variable m3_consultation2_reason_999 "408. Was the 2nd visit for any of the following? Include all that apply. (choice=Refuse to answer)"
label variable m3_consultation2_reason_888 "408. Was the 2nd visit for any of the following? Include all that apply. (choice=No Information)"
label variable m3_consultation2_reason_other "408_Oth. Other reasons, please specify"
label variable m3_consultation_3 "409. Was the 3rd consultation for a routine antenatal care visit?"
label variable m3_consultation_referral_3 "410. Was the 3rd consultation for a referral from your antenatal care provider?"
label variable m3_consultation3_reason_a "411. Was the 3rd visit for any of the following? Include all that apply. (choice=A new health problem, including an emergency or an injury)"
label variable m3_consultation3_reason_b "411. Was the 3rd visit for any of the following? Include all that apply. (choice=An existing health problem)"
label variable m3_consultation3_reason_c "411. Was the 3rd visit for any of the following? Include all that apply. (choice=A lab test, x-ray, or ultrasound)"
label variable m3_consultation3_reason_d "411. Was the 3rd visit for any of the following? Include all that apply. (choice=To pick up medicine)"
label variable m3_consultation3_reason_e "411. Was the 3rd visit for any of the following? Include all that apply. (choice=To get a vaccine)"
label variable m3_consultation3_reason_96 "411. Was the 3rd visit for any of the following? Include all that apply. (choice=Other reasons, please specify)"
label variable m3_consultation3_reason_998 "411. Was the 3rd visit for any of the following? Include all that apply. (choice=Unknown)"
label variable m3_consultation3_reason_999 "411. Was the 3rd visit for any of the following? Include all that apply. (choice=Refuse to answer)"
label variable m3_consultation3_reason_888 "411. Was the 3rd visit for any of the following? Include all that apply. (choice=No Information)"
label variable m3_consultation3_reason_other "411_Oth. Other reasons specify"
label variable m3_consultation_4 "411a. Was the 4th consultation for a routine antenatal care visit?"
label variable m3_consultation_referral_4 "411b. Was the 4th for referral from your antenatal care provider?"
label variable m3_consultation4_reason_a "411c. Was the 4th visit for any of the following? Include all that apply. (choice=A new health problem, including an emergency or an injury)"
label variable m3_consultation4_reason_b "411c. Was the 4th visit for any of the following? Include all that apply. (choice=An existing health problem)"
label variable m3_consultation4_reason_c "411c. Was the 4th visit for any of the following? Include all that apply. (choice=A lab test, x-ray, or ultrasound)"
label variable m3_consultation4_reason_d "411c. Was the 4th visit for any of the following? Include all that apply. (choice=To pick up medicine)"
label variable m3_consultation4_reason_e "411c. Was the 4th visit for any of the following? Include all that apply. (choice=To get a vaccine)"
label variable m3_consultation4_reason_96 "411c. Was the 4th visit for any of the following? Include all that apply. (choice=Other reasons, please specify)"
label variable m3_consultation4_reason_998 "411c. Was the 4th visit for any of the following? Include all that apply. (choice=Unknown)"
label variable m3_consultation4_reason_999 "411c. Was the 4th visit for any of the following? Include all that apply. (choice=Refuse to answer)"
label variable m3_consultation4_reason_888 "411c. Was the 4th visit for any of the following? Include all that apply. (choice=No Information)"
label variable m3_consultation4_reason_other "411c_Oth. Other reasons specify"
label variable m3_consultation_5 "411d . Was the 5th consultation for a routine antenatal care visit?"
label variable m3_consultation_referral_5 "411e. Was the 5th for referral from your antenatal care provider?/ Include all that apply"
label variable m3_consultation5_reason_a "411f. Was the 5th visit for any of the following? Include all that apply. (choice=A new health problem, including an emergency or an injury)"
label variable m3_consultation5_reason_b "411f. Was the 5th visit for any of the following? Include all that apply. (choice=An existing health problem)"
label variable m3_consultation5_reason_c "411f. Was the 5th visit for any of the following? Include all that apply. (choice=A lab test, x-ray, or ultrasound)"
label variable m3_consultation5_reason_d "411f. Was the 5th visit for any of the following? Include all that apply. (choice=To pick up medicine)"
label variable m3_consultation5_reason_e "411f. Was the 5th visit for any of the following? Include all that apply. (choice=To get a vaccine)"
label variable m3_consultation5_reason_96 "411f. Was the 5th visit for any of the following? Include all that apply. (choice=Other reasons, please specify)"
label variable m3_consultation5_reason_998 "411f. Was the 5th visit for any of the following? Include all that apply. (choice=Unknown)"
label variable m3_consultation5_reason_999 "411f. Was the 5th visit for any of the following? Include all that apply. (choice=Refuse to answer)"
label variable m3_consultation5_reason_888 "411f. Was the 5th visit for any of the following? Include all that apply. (choice=No Information)"
label variable m3_consultation5_reason_other "411f_Oth. Other reasons specify"
label variable m3_412a "412a. Between the time that you last spoke to us and before the delivery, did you get Your blood pressure measured (with a cuff around your arm)"
label variable m3_412b "412b. Between the time that you last spoke to us and before the delivery, did you get Your weight taken (using a scale)?"
label variable m3_412c "412c. Between the time that you last spoke to us and before the delivery, did you get a blood draw (that is, taking blood from your arm with a syringe?"
label variable m3_412d "412d. Between the time that you last spoke to us and before the delivery, did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
label variable m3_412e "412e. Between the time that you last spoke to us and before the delivery, did you get a urine test (that is, where you peed in a container)?"
label variable m3_412f "412f. Between the time that you last spoke to us and before the delivery, did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
label variable m3_412g "412g. Between the time that you last spoke to us and before the delivery, did you get any other test?"
label variable m3_412g_other "412g_Oth . Specify other tests you got between the time that you last spoke to us and before the delivery"
label variable m3_501 "501. Did you deliver in a health facility?"
label variable m3_502 "502. What kind of facility was it?"
label variable m3_503 "503. What is the name of the facility where you delivered?"
label variable m3_503_inside_zone_other "503_96. Other in the zone specify"
label variable m3_503_outside_zone_other "503_97. Other outside of the zone specify"
label variable m3_504a "504a. Where region was this facility located?"
label variable m3_504b "504b. Where was the city/sub-city/district this facility located?"
label variable m3_505a "505a. Before you delivered, did you go to a maternity waiting home to wait for labor?"
label variable m3_505b "505b. How long in days did you stay at the maternity waiting home for?"
label variable m3_506a "506a. What day did the labor start - that is, when contractions started and did not stop, or when your water broke?"
label variable m3_506b "506b. What time did the labor start - that is, when contractions started and did not stop, or when your water broke?"
label variable m3_506b_unknown "506b. If day and time not known enter (98)"
label variable m3_507 "507. At what time did you leave for the facility?"
label variable m3_507_unknown "507. If day and time not known enter (98)"
label variable m3_508 "508. At any point during labor or delivery did you try to go to a facility?"
label variable m3_509 "509. What was the main reason for giving birth at home instead of a health facility?"
label variable m3_509_other "509_Oth. Specify other reasons for giving birth at home instead of a health facility"
label variable m3_510 "510. Did you go to another health facility before going to the health facility where you delivered?"
label variable m3_511 "511. How many facilities did you go to before going the health facility where you delivered?"
label variable m3_512 "512. What kind of facility was it?"
label variable m3_512_outside_zone_other "512_97. Other outside of the zone, specify"
label variable m3_513a "513a. What is the name of the facility you went to first?"
label variable m3_513_inside_zone_other "513a_96. Other in the zone, specify"
label variable m3_513_outside_zone_other "513a_97. Other outside of the zone"
label variable m3_513b1 "513b. Where region was this facility located? (City and region)"
label variable m3_513b2 "513b. Where city/sub-city/district was this facility located?"
label variable m3_514 "514. At what time did you arrive at the facility you went to first?"
label variable m3_514_unknown "514. If time of arrival not known enter (98)"
label variable m3_515 "515. Why did you go to the facility you went to first after going to the facility you delivered at?"
label variable m3_516 "516. Why did you or your family member decide to leave the facility you went to first and come to the facility you delivered at? Select only one main reason"
label variable m3_516_other "516_Oth. Specify other reason to go to the facility you delivered at"
label variable m3_517 "517. Did the provider inform you why they referred you?"
label variable m3_518 "518. Why did the provider refer you to the facility you delivered at?"
label variable m3_518_other_complications "518_96. Other delivery complications, specify"
label variable m3_518_other "518_97. Other reasons, specify"
label variable m3_519 "519. What was the main reason you decided that you wanted to deliver at the facility you delivered at?"
label variable m3_519_other "519_Oth. Other, specify"
label variable m3_520 "520. At what time did you arrive at the facility you delivered at?"
label variable m3_520_unknown "520. If day and time not known enter (98)"
label variable m3_521 "521. Once you got to the facility you delivered at, how long in minutes did you wait until a healthcare worker checked on you?"
label variable m3_521_unknown "521. If day and time not known enter (98)"
*label variable m3_attempt_date "CALL TRACKING: What is the date of this attempt? (D-M-Y)"
*label variable m3_attempt_outcome "CALL TRACKING: What was the outcome of the call?"
label variable m3_p1_date_of_rescheduled "Date of rescheduled"
label variable m3_p1_time_of_rescheduled "Time of rescheduled"
label variable m3_p1_complete "Complete?"
label variable m3_start_p2 "IIC. May I proceed with the interview?"
label variable m3_permission_p2 "CR1. Permission granted to conduct call?"
label variable m3_date_p2 "102. Date of interview (D-M-Y)"
label variable m3_time_p2 "103A. Time of interview started"
label variable m3_201a "201a. I would like to start by asking some questions about the first baby's health since we last spoke. So that I know that I am asking the right questions, could you please confirm if the first baby is still alive, or did something else happen?"
label variable m3_201b "201b.I would like to start by asking some questions about the second baby's health since we last spoke. So that I know that I am asking the right questions, could you please confirm if the second baby is still alive, or did something else happen?"
label variable m3_201c "201c.I would like to start by asking some questions about the third baby's health since we last spoke. So that I know that I am asking the right questions, could you please confirm if the third baby is still alive, or did something else happen?"
label variable m3_601a "601a. Once you were first checked by a health care provider at the facility you delivered at, did they ask about your health status?"
label variable m3_601b "601b. Once you were first checked by a health care provider at the facility you delivered at, did the health care provider take your blood pressure (with a cuff around your arm)?"
label variable m3_601c "601c. Once you were first checked by a health care provider at the facility you delivered at, did the health care provider Explain what will happen during labor?"
label variable m3_602a "602a. Did the health care provider, look at your integrated maternal child health card?"
label variable m3_602b "602b. Did the health care provider have information about your antenatal care (e.g. your tests results) from health facility records?"
label variable m3_603a "603a. During your time in the health facility while in labor or giving birth Were you told you could walk around and move during labour?"
label variable m3_603b "603b. During your time in the health facility while in labor or giving birth Were you allowed to have a birth companion present? For example, this includes your husband, a friend, sister, mother-in-law etc.?"
label variable m3_603c "603c. During your time in the health facility while in labor or giving birth Did you have a needle inserted in your arm with a drip?"
label variable m3_603d "603d. During your time in the health facility while in labor or giving birth Did the health care provider encourage you to drink fluid?"
label variable m3_604a "604a. While you were in labor and giving birth, what were you sitting  or lying on?"
label variable m3_604b "604b. While you were giving birth, were curtains, partitions or other measures used to provide privacy from other people not involved in your care?"
label variable m3_605a "605a. Did you have a caesarean? (That means, did they cut your belly open to take the baby out?)"
label variable m3_605b "605b. When was the decision made to have the caesarean section? Was it before or after your labor pains started?"
label variable m3_605c_a "605c. What was the reason for having a caesarean? (choice=I was not told)"
label variable m3_605c_b "605c. What was the reason for having a caesarean? (choice=It was previously planned for medical reasons)"
label variable m3_605c_c "605c. What was the reason for having a caesarean? (choice=I asked for a c-section)"
label variable m3_605c_d "605c. What was the reason for having a caesarean? (choice=Problems arose during labor)"
label variable m3_605c_96 "605c. What was the reason for having a caesarean? (choice=Other, specify)"
label variable m3_605c_99 "605c. What was the reason for having a caesarean? (choice=RF/NR)"
label variable m3_605c_998 "605c. What was the reason for having a caesarean? (choice=Unknown)"
label variable m3_605c_999 "605c. What was the reason for having a caesarean? (choice=Refuse to answer)"
label variable m3_605c_888 "605c. What was the reason for having a caesarean? (choice=No Information)"
label variable m3_605c_other "605c_Oth. Specify other reason for having a caesarean"
label variable m3_606 "606. Did the provider perform a cut near your vagina to help the baby come out?"
label variable m3_607 "607. Did you receive stiches near your vagina after the delivery?"
label variable m3_607a_et "Eth-1-6. Did the health care provider frequently assess fetal heart beat?"
label variable m3_607b_et "Eth-2-6. Did the health care provider assess abdominal contraction by that I mean the HCP puts hands on your abdomen to monitor your labor frequently?"
label variable m3_607c_et "Eth-3-6. Did the health care provider frequently make vaginal examination by putting fingers inside your vagina?"
label variable m3_607d_et "Eth-4-6. Did the health care provider frequently assess BP?"
label variable m3_607e_et "Eth-5-6. Did the health care provider check your temperature frequently?"
label variable m3_608 "608. Immediately after delivery: Did a health care provider give you an injection or pill to stop the bleeding?"
label variable m3_609 "609. Immediately after delivery, did a health care provider dry the baby/babies with a towel?"
label variable m3_610a "610a. Immediately after delivery, was/were the baby/babies put on your chest?"
label variable m3_610b "610b. Immediately after delivery, was/were the babys/babies bare skin touching your bare skin?"
label variable m3_611 "611. Immediately after delivery, did a health care provider help you with breastfeeding the baby/babies?"
label variable m3_612 "612. How long in minutes after the baby/babies was born did you first breastfeed he/she/them?"
label variable m3_613 "613. I  would like to talk to you about checks on your health after the delivery, for example, someone asking you questions about your health or examining you.  Did anyone check on your health while you were still in the facility?"
label variable m3_614 "614. How long in hours after delivery did the first check take place?"
label variable m3_615a "615a. Did anyone check on the baby's health while you were still in the facility?"
label variable m3_615b "615b. Did anyone check on the second baby's health while you were still in the facility?"
label variable m3_615c "615c. Did anyone check on the baby the third baby's health while you were still in the facility?"
label variable m3_616a "616a. How long in hours after delivery was the first baby's health first checked?"
label variable m3_616b "616b. How long in hours after delivery was the second baby's health first checked?"
label variable m3_616c "616c. How long in hour after delivery was the third baby's health first checked?"
label variable m3_617a "617a. Did the first baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
label variable m3_617b "617b. Did the second baby receive a vaccine for BCG while you were still in the facility?"
label variable m3_617c "617c. Did the 3rd baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar."
label variable m3_617d_et "Eth-6-6a. Did the first baby receive an injection [vaccine] on thigh? That I mean is a vitamin K injection?"
label variable m3_617e_et "Eth-6-6b. Did the second baby receive an injection [vaccine] on thigh? That I mean is a vitamin K injection?"
label variable m3_617f_et "Eth-6-6c. Did the third baby receive an injection [vaccine] on thigh? That I mean is a vitamin K injection?"
label variable m3_617g_et "Eth-7-6a. Did the first baby receive eye ointment?"
label variable m3_617h_et "Eth-7-6b. Did the second baby receive eye ointment?"
label variable m3_617i_et "Eth-7-6c. Did the third baby receive eye ointment?"
label variable m3_619a "619a. Before you left the facility, did you receive advice on what the baby should eat (only breastmilk or No other foods)?"
label variable m3_619b "619b. Before you left the facility, did you receive advice on care of the umbilical cord?"
label variable m3_619c "619c. Before you left the facility, did you receive advice on avoid chilling of baby?"
label variable m3_619d "619d. Before you left the facility, did you receive advice on when to return for vaccinations for the baby?"
label variable m3_619e "619e. Before you left the facility, did you receive advice on hand washing with soap/water before touching the baby?"
label variable m3_619f "619f. Before you left the facility, did you receive advice on need to exposure your baby/babies for sunlight?"
label variable m3_619g "619g. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in the baby that would mean you should go to a health facility?"
label variable m3_619h "619h. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in yourself that would mean you should go to a health facility?"
label variable m3_619i "619i. Before you left the facility, did you receive advice on family planning you should look for?"
label variable m3_619j "619j. Before you left the facility, did you receive  advice on maternal nutrition that you should take?"
label variable m3_620 "620. After your baby was born, did you receive a vaccination card for the baby to take home with you?"
label variable m3_621a "621a. Who assisted you in the delivery?"
label variable m3_621b "621b. Did someone come to check on you after you gave birth? For example, someone asking you questions about  your health or examining you?"
label variable m3_621c "621c. How long after giving birth did the checkup take  place (in hours)?"
label variable m3_622a "622a. Around the time of delivery, were you told that  you will need to go to a facility for a checkup for you or your baby?"
label variable m3_622b "622b. When were you told to go to a health facility for postnatal checkups? How many days after delivery?"
label variable m3_622c "622c. Around the time of delivery, were you told that someone would come to visit you at your home to check on you or your babys health?"
label variable m3_baby1_sleep "311a. Regarding sleep, which response best describes the first baby today?"
label variable m3_baby2_sleep "311a. Regarding sleep, which response best describes the second baby today?"
label variable m3_baby3_sleep "311a. Regarding sleep, which response best describes the third baby today?"
label variable m3_baby1_feed "311b. Regarding feeding, which response best describes the first baby today?"
label variable m3_baby2_feed "311b. Regarding feeding, which response best describes the second baby today?"
label variable m3_baby3_feed "311b. Regarding feeding, which response best describes the third baby today?"
label variable m3_baby1_breath "311c. Regarding breathing, which response best describes the first baby today?"
label variable m3_baby2_breath "311c. Regarding breathing, which response best describes the second baby today?"
label variable m3_baby3_breath "311c. Regarding breathing, which response best describes the third baby today?"
label variable m3_baby1_stool "311d. Regarding stooling/poo, which response best describes the first baby today?"
label variable m3_baby2_stool "311d. Regarding stooling/poo, which response best describes the second baby today?"
label variable m3_baby3_stool "311d. Regarding stooling/poo, which response best describes the third baby today?"
label variable m3_baby1_mood "311e. Regarding their mood, which response best describes the first baby today?"
label variable m3_baby2_mood "311e. Regarding their mood, which response best describes the second baby today?"
label variable m3_baby3_mood "311e. Regarding their mood, which response best describes the third baby today?"
label variable m3_baby1_skin "311f. Regarding their skin, which response best describes the first baby today?"
label variable m3_baby2_skin "311f. Regarding their skin, which response best describes the second baby today?"
label variable m3_baby3_skin "311f. Regarding their skin, which response best describes the third baby today?"
label variable m3_baby1_interactivity "311g. Regarding interactivity, which response best describes the first baby today?"
label variable m3_baby2_interactivity "311g. Regarding interactivity, which response best describes the second baby today?"
label variable m3_baby3_interactivity "311g. Regarding interactivity, which response best describes the third baby today?"
label variable m3_701 "701. At any time during labor, delivery, or after delivery did you suffer from any health problems?"
label variable m3_702 "702. What health problems did you have?"
label variable m3_703 "703. Would you say this problem was severe?"
label variable m3_704a "704a. During your delivery, did you experience seizures, or not?"
label variable m3_704b "704b. During your delivery, did you experience blurred vision, or not?"
label variable m3_704c "704c. During your delivery, did you experience severe headaches, or not?"
label variable m3_704d "704d. Did you experience swelling in hands/feet during your delivery, or not?"
label variable m3_704e "704e. Did you experience labor over 12 hours during your delivery, or not?"
label variable m3_704f "704f. Did you experience Excessive bleeding during your delivery, or not?"
label variable m3_704g "704g. During your delivery, did you experience fever, or not?"
label variable m3_705 "705. Did you receive a blood transfusion around the time of your delivery?"
label variable m3_706 "706. Were you admitted to an intensive care unit?"
label variable m3_707 "707. How long in hours did you stay at the facility you delivered at after the delivery?"
label variable m3_707_unknown "Data Collector: If the hour and /or minute is unknown enter 98 here"
label variable m3_baby1_issues_a "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Trouble breathing)"
label variable m3_baby1_issues_b "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Fever)"
label variable m3_baby1_issues_c "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Trouble feeding)"
label variable m3_baby1_issues_d "708a. Did the baby the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
label variable m3_baby1_issues_e "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Low birth weight)"
label variable m3_baby1_issues_f "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=No complications)"
label variable m3_baby1_issues_96 "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Other)"
label variable m3_baby1_issues_98 "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=DK)"
label variable m3_baby1_issues_99 "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=NR/RF)"
label variable m3_baby1_issues_998 "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Unknown)"
label variable m3_baby1_issues_999 "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Refuse to answer)"
label variable m3_baby1_issues_888 "708a. Did the first baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=No Information)"
label variable m3_baby2_issues_a "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Trouble breathing)"
label variable m3_baby2_issues_b "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Fever, low temperature, or infection)"
label variable m3_baby2_issues_c "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Trouble feeding)"
label variable m3_baby2_issues_d "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
label variable m3_baby2_issues_e "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Low birth weight)"
label variable m3_baby2_issues_f "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=No complications)"
label variable m3_baby2_issues_96 "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Other)"
label variable m3_baby2_issues_98 "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=DK)"
label variable m3_baby2_issues_99 "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=NR/RF)"
label variable m3_baby2_issues_998 "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Unknown)"
label variable m3_baby2_issues_999 "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Refuse to answer)"
label variable m3_baby2_issues_888 "708b. Did the second baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=No Information)"
label variable m3_baby3_issues_a "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Trouble breathing)"
label variable m3_baby3_issues_b "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Fever, low temperature, or infection)"
label variable m3_baby3_issues_c "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Trouble feeding)"
label variable m3_baby3_issues_d "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
label variable m3_baby3_issues_e "708c. Did the baby the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Low birth weight)"
label variable m3_baby3_issues_f "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=No complications)"
label variable m3_baby3_issues_96 "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Other)"
label variable m3_baby3_issues_98 "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=DK)"
label variable m3_baby3_issues_99 "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=NR/RF)"
label variable m3_baby3_issues_998 "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Unknown)"
label variable m3_baby3_issues_999 "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=Refuse to answer)"
label variable m3_baby3_issues_888 "708c. Did the third baby experience any of the following issues in the first day of life? Tell me all that apply. (choice=No Information)"
label variable m3_708a "709a. Write down the first baby's experiences any other health problems in the first day of life"
label variable m3_708b "709b. Write down the second baby's experiences any other health problems in the first day of life"
label variable m3_709c "709c. Write down the third baby's experiences any other health problems in the first day of life"
label variable m3_710a "710a. Did the first baby spend time in a special care nursery or intensive care unit before discharge?"
label variable m3_710b "710b. Did the second baby spend time in a special care nursery or intensive care unit before discharge?"
label variable m3_710c "710c. Did the third baby spend time in a special care nursery or intensive care unit before discharge?"
label variable m3_711a "711a. How long in hours did the first baby stay at the health facility after being born?"
label variable m3_711b "711b. How long in hours did the second baby stay at the health facility after being born?"
label variable m3_711c "711c. How long in hours did the third baby stay at the health facility after being born?"
label variable m3_801a "801a. Over the past 2 weeks, on how many days have you been bothered little interest or pleasure in doing things?"
label variable m3_801b "801b. Over the past 2 weeks, on how many days have you been bothered feeling down, depressed, or hopeless in doing things?"
label variable m3_802a "802a. Since you last spoke to us, did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves?"
label variable m3_802b "802b. How many of these sessions did you have since you last spoke to us?"
label variable m3_802c "802c. How many minutes did this/these visit(s) last on average?"
label variable m3_803a "803a. Since giving birth, have you experienced severe or persistent headaches?"
label variable m3_803b "803b. Since giving birth, have you experienced a fever?"
label variable m3_803c "803c. Since giving birth, have you experienced severe abdominal pain, not just discomfort?"
label variable m3_803d "803d. Since giving birth, have you experienced a lot of difficulty breathing even when you are resting?"
label variable m3_803e "803e. Since giving birth, have you experienced convulsions or seizures?"
label variable m3_803f "803f. Since giving birth, have you experienced repeated fainting or loss of consciousness?"
label variable m3_803g "803g. Since giving birth, have you experienced continued heavy vaginal bleeding?"
label variable m3_803h "803h. Since giving birth, have you experienced foul smelling vaginal discharge?"
label variable m3_803i "803i. Since giving birth, have you experienced blurring of vision?"
label variable m3_803j "803j. Since giving birth, have you experienced any other major health problems since you gave birth?"
label variable m3_803j_other "803j_Oth. Specify any other major health problems since you gave birth"
label variable m3_805 "805. Sometimes a woman can have a problem such that she experiences a constant leakage of urine or stool from her vagina during the day and night. This problem can occur after a difficult childbirth. Since you gave birth have you experienced a constant leakage of urine or stool from your vagina during the day and night?"
label variable m3_806 "806. How many days after giving birth did these symptoms start?"
label variable m3_807 "807. Overall, how much does this problem interfere with your everyday life? Please select a number between 0 (not at all) and 10 (a great deal)."
label variable m3_808a "808a. Have you sought treatment for this condition?"
label variable m3_808b "808b. Why have you not sought treatment?"
label variable m3_808b_other "808b_Oth. Specify other reasons why have you not sought treatment"
label variable m3_809 "809. Did the treatment stop the problem?"
label variable m3_901a "901a. Since last spoke, did you get iron or folic acid pills for yourself?"
label variable m3_901b "901b. Since we last spoke, did you get iron injection?"
label variable m3_901c "901c. Since we last spoke, did you get calcium pills?"
label variable m3_901d "901d. Since we last spoke, did you get multivitamins?"
label variable m3_901e "901e. Since we last spoke, did you get food supplements like Super Cereal or Plumpynut?"
label variable m3_901f "901f. Since we last spoke, did you get medicine for intestinal worms [endemic areas]?"
label variable m3_901g "901g. Since we last spoke, did you get medicine for malaria [endemic areas]?"
label variable m3_901h "901h. Since we last spoke, did you get Medicine for HIV?"
label variable m3_901i "901i. Since we last spoke, did you get medicine for your emotions, nerves, depression, or mental health?"
label variable m3_901j "901j. Since we last spoke, did you get medicine for hypertension?"
label variable m3_901k "901k. Since we last spoke, did you get medicine for diabetes, including injections of insulin?"
label variable m3_901l "901l. Since we last spoke, did you get antibiotics for an infection?"
label variable m3_901m "901m. Since we last spoke, did you get aspirin?"
label variable m3_901n "901n. Since we last spoke, did you get paracetamol, or other pain relief drugs?"
label variable m3_901o "901o. Since we last spoke, did you get contraceptive pills?"
label variable m3_901p "901p. Since we last spoke, did you get contraceptive injection?"
label variable m3_901q "901q. Since we last spoke, did you get other contraception method?"
label variable m3_901r "901r. Since we last spoke, did you get any other medicine or supplement?"
label variable m3_901r_other "901s_Oth. Specify other treatment you took"
label variable m3_902a_baby1 "902a. Since they were born, did the first baby get iron supplements?"
label variable m3_902a_baby2 "902a. Since they were born, did the second baby get iron supplements?"
label variable m3_902a_baby3 "902a. Since they were born, did the third baby get iron supplements?"
label variable m3_902b_baby1 "902b. Since they were born, did the first baby get Vitamin A supplements?"
label variable m3_902b_baby2 "902b. Since they were born, did the second baby get Vitamin A supplements?"
label variable m3_902b_baby3 "902b. Since they were born, did the third baby get Vitamin A supplements?"
label variable m3_902c_baby1 "902c. Since they were born, did the first baby get Vitamin D supplements?"
label variable m3_902c_baby2 "902c. Since they were born, did the second baby get Vitamin D supplements?"
label variable m3_902c_baby3 "902c. Since they were born, did the third baby get Vitamin D supplements?"
label variable m3_902d_baby1 "902d. Since they were born, did the first baby get Oral rehydration salts?"
label variable m3_902d_baby2 "902d. Since they were born, did the second baby get Oral rehydration salts?"
label variable m3_902d_baby3 "902d. Since they were born, did the third baby get Oral rehydration salts?"
label variable m3_902e_baby1 "902e. Since they were born, did the first baby get antidiarrheal?"
label variable m3_902e_baby2 "902e. Since they were born, did the second baby get antidiarrheal?"
label variable m3_902e_baby3 "902e. Since they were born, did the third baby get antidiarrheal?"
label variable m3_902f_baby1 "902f. Since they were born, did the first baby get Antibiotics for an infection?"
label variable m3_902f_baby2 "902f. Since they were born, did the second baby get Antibiotics for an infection?"
label variable m3_902f_baby3 "902f. Since they were born, did the third baby get Antibiotics for an infection?"
label variable m3_902g_baby1 "902g. Since they were born, did the first baby get medicine to prevent pneumonia?"
label variable m3_902g_baby2 "902g. Since they were born, did the second baby get medicine to prevent pneumonia?"
label variable m3_902g_baby3 "902g. Since they were born, did the third baby get medicine to prevent pneumonia?"
label variable m3_902h_baby1 "902h. Since they were born, did the first baby get medicine for malaria [endemic areas]?"
label variable m3_902h_baby2 "902h. Since they were born, did the second baby get medicine for malaria [endemic areas]?"
label variable m3_902h_baby3 "902h. Since they were born, did the third baby get medicine for malaria [endemic areas]?"
label variable m3_902i_baby1 "902i. Since they were born, did the first baby get medicine for HIV (HIV+ mothers only)?"
label variable m3_902i_baby2 "902i. Since they were born, did the second baby get medicine for HIV (HIV+ mothers only)?"
label variable m3_902i_baby3 "902i. Since they were born, did the third baby get medicine for HIV (HIV+ mothers only)?"
label variable m3_902j_baby1 "902j. Since they were born, did the first baby get other medicine or supplement, please specify"
label variable m3_902j_baby1_other "902j_Oth. Any other medicine or supplement for the first baby please specify"
label variable m3_902j_baby2 "902j. Since they were born, did the second baby get other medicine or supplement, please specify"
label variable m3_902j_baby2_other "902j_Oth_2. Any other medicine or supplement for the second baby please specify"
label variable m3_902j_baby3 "902j_3. Since they were born, did the third baby get other medicine or supplement, please specify"
label variable m3_902j_baby3_other "902j_Oth_3. Any other medicine or supplement for the third baby please specify"
label variable m3_1001 "1001. Overall, taking everything into account, how would you rate the quality of care that you received for your delivery at the facility you delivered at?"
label variable m3_1002 "1002. How likely are you to recommend this provider to a family member or friend for childbirth?"
label variable m3_1003 "1003. Did staff suggest or ask you (or your family or friends) for a bribe, and informal payment or gift?"
label variable m3_1004a "1004a. Thinking about the care you received during labor and delivery, how would you rate the knowledge and skills of your provider?"
label variable m3_1004b "1004b. Thinking about the care you received during labor and delivery, how would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab tests?"
label variable m3_1004c "1004c. Thinking about the care you received during labor and delivery, how would you rate the level of respect the provider showed you?"
label variable m3_1004d "1004d. Thinking about the care you received during labor and delivery, how would you rate clarity of the providers explanations?"
label variable m3_1004e "1004e. Thinking about the care you received during labor and delivery, how would you rate degree to which the provider involved you as much as you wanted to be in decisions about your care?"
label variable m3_1004f "1004f. Thinking about the care you received during labor and delivery, how would you rate amount of time the provider spent with you?"
label variable m3_1004g "1004g. Thinking about the care you received during labor and delivery, how would you rate the amount of time you waited before being seen?"
label variable m3_1004h "1004h. Thinking about the care you received during labor and delivery, how would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider? "
label variable m3_1004i "1004i. Thinking about the care you received during labor and delivery, how would you rate confidentiality of care or diagnosis is there?"
label variable m3_1004j "1004j. Thinking about the care you received during labor and delivery, how would you rate the privacy (Auditory or visual) maintained?"
label variable m3_1004k "1004k. Thinking about the care you received during labor and delivery, how would you rate the cost to the service you received?"
label variable m3_1005a "1005a. During your time at the health facility for labor and delivery, were you pinched by a health worker or other staff?"
label variable m3_1005b "1005b. During your time at the health facility for labor and delivery, were slapped by a health worker or other staff?"
label variable m3_1005c "1005c. During your time at the health facility for labor and delivery, were were physically tied to the bed or held down to the bed forcefully by a health worker or other staff?"
label variable m3_1005d "1005d. During your time at the health facility for labor and delivery, had forceful downward pressure placed on your abdomen before the baby came out?"
label variable m3_1005e "1005e. During your time at the health facility for labor and delivery, were shouted or screamed at by a health worker or other staff?"
label variable m3_1005f "1005f. During your time at the health facility for labor and delivery, were scolded by a health worker or other staff?"
label variable m3_1005g "1005g. During your time at the health facility for labor and delivery, the health worker or other staff member made negative comments to you regarding your sexual activity?"
label variable m3_1005h "1005h. DDuring your time at the health facility for labor and delivery, the health worker or other staff threatened that if you did not comply, you or your baby would have a poor outcome?"
label variable m3_1006a "1006a. During labor and delivery, women sometimes receive a vaginal examination. Did you receive a vaginal examination at any point in the health facility?"
label variable m3_1006b "1006b. Did the health care provider ask permission before performing the vaginal examination?"
label variable m3_1006c "1006c. Were vaginal examinations conducted privately (in a way that other people could not see)?"
label variable m3_1007a "1007a. During your time in the facility, were you offered any form of pain relief?"
label variable m3_1007b "1007b. Did you request pain relief during your time in the facility?"
label variable m3_1007c "1007c. Did you receive pain relief during your time in the facility?"
label variable m3_1101 "1101. I would like to ask you about the cost of the delivery. Did you pay money out of your pocket for the delivery, including for the consultation or other indirect costs like your transport to the facility?"
label variable m3_1102a "1102a. Did you spend money on registration/consultation?"
label variable m3_1102a_amt "1102a_1. How much money did you spend on registration/consultation?"
label variable m3_1102b "1102b. Did you spend money on medicine/vaccines (including outside purchase)?"
label variable m3_1102b_amt "1102b. How much money did you spend on medicine/vaccines (including outside purchase)?"
label variable m3_1102c "1102c. Did you spend money test/investigations (x-ray, lab etc.)?"
label variable m3_1102c_amt "1102c.	How much money did you spend test/investigations (x-ray, lab etc.)?"
label variable m3_1102d "1102d. Did you spend money on transport (round trip) including that of person accompanying you?"
label variable m3_1102d_amt "1102d. How much money did you spend on transport (round trip) including that of person accompanying you?"
label variable m3_1102e "1102e. Did you spend money on food and accommodation including that of person accompanying you?"
label variable m3_1102e_amt "1102e. How much money did you spend money on food and accommodation including that of person accompanying you?"
label variable m3_1102f "1102f. Did you spend money on other items?"
label variable m3_1102f_amt "1102f. How much money did you spend on other items?"
label variable m3_1103 "1103. So in total you spent:_____ Is that correct?"
label variable m3_1103_confirm "Is the total you spent correct? "
label variable m3_1104 "1104. So how much in total would you say you spent?"
label variable m3_1105 "1105. Which of the following financial sources did your household use to pay for this?"
label variable m3_1105_other "1105_Oth. Other specify"
label variable m3_1106 "1106. To conclude this survey, overall, please tell me how satisfied you are  with the health services you received during labor and delivery?"
label variable m3_endtime "Time of interview ended"
label variable m3_duration "Total duration of interview"
label variable m3_p2_outcome "What is the outcome of the phone call?"
label variable m3_p2_outcome_other "Other reason, specify"
*label variable m3_attempt_outcome2 "CALL TRACKING: What is the date of this attempt? (D-M-Y)"
*label variable m3_attempt_outcome_p2 "CALL TRACKING: What was the outcome of the call?"
label variable m3_p2_date_of_rescheduled "Date of rescheduled"
label variable m3_p2_time_of_rescheduled "Time of rescheduled"

	** MODULE 4:

label variable m4_attempt_date "CALL TRACKING: What is the date of this attempt?"
label variable m4_start "CALL TRACKING: May I proceed with the interview?"
label variable m4_permission "CALL TRACKING: Permission granted to conduct call"
label variable m4_attempt_outcome  "CALL TRACKING: What was the outcome of the call?"
label variable m4_date_of_rescheduled "CALL TRACKING: Rescheduled date"
label variable m4_time_of_reschedule "CALL TRACKING: Rescheduled time"
label variable m4_attempt_relationship "CALL TRACKING: Hello, my name is [your name] and I work with EPHI, I would like to talk with [what_is_your_first_name_101] [what_is_your_family_name_102]. A6. May I Know what the relationship between you and [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m4_attempt_other  "CALL TRACKING:  Specify other relationship with the respondent"
label variable m4_attempt_avail "CALL TRACKING:  Is [what_is_your_first_name_101] [what_is_your_family_name_102] nearby and available to speak now?   Can you pass the phone to them?"
label variable m4_attempt_contact "CALL TRACKING:   Is this still the best contact to reach [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m4_attempt_bestnumber "CALL TRACKING:  Could you please share the best number to contact [what_is_your_first_name_101] [what_is_your_family_name_102]"
label variable m4_attempt_goodtime "CALL TRACKING:  Do you know when would be a good time to reach [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m4_102 "102. Date of interview"
label variable m4_103 "103. Time of interview"
label variable m4_108 "108. HIV status" 
label variable m4_112 "112. Maternal death reported"
label variable m4_113 "113. Date of maternal death"
label variable m4_114  "114. How did you learn about the maternal death?"
label variable m4_114_other "114. Other (specify)"
label variable m4_201_1 "201. I would like to start by asking some questions about 1st baby's health since we last spoke. So that I know that I am asking the right questions, could you please confirm if 1st baby is still alive, or did something else happen?"
label variable m4_201_2 "201. I would like to start by asking some questions about 2nd baby's health since we last spoke. So that I know that I am asking the right questions, could you please confirm if 2nd baby is still alive, or did something else happen?"
label variable m4_201_3 "201. I would like to start by asking some questions about 3rd baby's health since we last spoke. So that I know that I am asking the right questions, could you please confirm if 3rd baby is still alive, or did something else happen?"
label variable m4_202_1 "202. In general, how would you rate 1st baby's overall health?"
label variable m4_202_2 "202. In general, how would you rate 2nd baby's overall health?"
label variable m4_202_3 "202. In general, how would you rate 3rd baby's overall health?"
label variable m4_203_1_1 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - BREAST MILK"
label variable m4_203_1_2 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - FORMULA"
label variable m4_203_1_3 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - WATER"
label variable m4_203_1_4 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - JUICE"
label variable m4_203_1_5 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - BROTH"
label variable m4_203_1_6 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - BABY FOOD"
label variable m4_203_1_7 "203. People feed their babies in different ways. Please indicate how you have fed 1st baby in the last 7 days? Indicate all that apply - LOCAL FOOD"


label variable m4_203_2_1 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - BREAST MILK"
label variable m4_203_2_2 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - FORMULA"
label variable m4_203_2_3 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - WATER"
label variable m4_203_2_4 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - JUICE"
label variable m4_203_2_5 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - BROTH"
label variable m4_203_2_6 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - BABY FOOD"
label variable m4_203_2_7 "203. People feed their babies in different ways. Please indicate how you have fed 2nd baby in the last 7 days? Indicate all that apply - LOCAL FOOD"

label variable m4_203_3_1 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - BREAST MILK"
label variable m4_203_3_2 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - FORMULA"
label variable m4_203_3_3 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - WATER"
label variable m4_203_3_4 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - JUICE"
label variable m4_203_3_5 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - BROTH"
label variable m4_203_3_6 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - BABY FOOD"
label variable m4_203_3_7 "203. People feed their babies in different ways. Please indicate how you have fed 3rd baby in the last 7 days? Indicate all that apply - LOCAL FOOD"

label variable m4_203d_et "203. On average how frequently do you breastfeed your baby per day (Ethiopia only)" 

label variable m4_204a "204. As of today, how confident do you feel about breastfeeding your baby?" 

label variable m4_205a_1"205.Regarding sleep, which response best describes your 1st baby today?"
label variable m4_205a_2 "205.Regarding sleep, which response best describes your 2nd baby today? "
label variable m4_205a_3 "205.Regarding sleep, which response best describes your 3rd baby today? "
label variable m4_205b_1"205.Regarding feeding, which response best describes your 1st baby today?"
label variable m4_205b_2 "205.Regarding feeding, which response best describes your 2nd baby today? "
label variable m4_205b_3 "205.Regarding feeding, which response best describes your 3rd baby today? "
label variable m4_205c_1"205.Regarding breathing, which response best describes your 1st baby today?"
label variable m4_205c_2 "205.Regarding breathing, which response best describes your 2nd baby today? "
label variable m4_205c_3 "205.Regarding breathing, which response best describes your 3rd baby today? "
label variable m4_205d_1"205.Regarding stooling/poo, which response best describes your 1st baby today?"
label variable m4_205d_2 "205.Regarding stooling/poo, which response best describes your 2nd baby today? "
label variable m4_205d_3 "205.Regarding stooling/poo, which response best describes your 3rd baby today? "
label variable m4_205e_1"205.Regarding their mood, which response best describes your 1st baby today?"
label variable m4_205e_2 "205.Regarding their mood, which response best describes your 2nd baby today? "
label variable m4_205e_3 "205.Regarding their mood, which response best describes your 3rd baby today? "
label variable m4_205f_1"205.Regarding their skin, which response best describes your 1st baby today?"
label variable m4_205f_2 "205.Regarding their skin, which response best describes your 2nd baby today? "
label variable m4_205f_3 "205.Regarding their skin, which response best describes your 3rd baby today? "
label variable m4_205g_1"205.Regarding their interactivity, which response best describes your 1st baby today?"
label variable m4_205g_2 "205.Regarding their interactivity, which response best describes your 2nd baby today? "
label variable m4_205g_3 "205.Regarding their interactivity, which response best describes your 3rd baby today? "

label variable m4_206a_1 "206. Did your 1st baby experience Diarrhea with blood in the stools since you last spoke to us, or not?"
label variable m4_206a_2 "206. Did your 2nd baby experience Diarrhea with blood in the stools since you last spoke to us, or not?"
label variable m4_206a_3 "206. Did your 3nd baby experience Diarrhea with blood in the stools since you last spoke to us, or not?"

label variable m4_206b_1 "206. Did your 1st baby experience a fever (a temperature > 37.5C) since you last spoke to us, or not?"
label variable m4_206b_2 "206. Did your 2nd baby experience a fever (a temperature > 37.5C)  since you last spoke to us, or not?"
label variable m4_206b_3 "206. Did your 3nd baby experience a fever (a temperature > 37.5C) since you last spoke to us, or not?"

label variable m4_206c_1 "206. Did your 1st baby experience a low temperature(< 35.5C) since you last spoke to us, or not?"
label variable m4_206c_2 "206. Did your 2nd baby experience a low temperature(< 35.5C) since you last spoke to us, or not?"
label variable m4_206c_3 "206. Did your 3nd baby experience a low temperature(< 35.5C) since you last spoke to us, or not?"

label variable m4_206d_1 "206. Did your 1st baby experience an illness with a cough since you last spoke to us, or not?"
label variable m4_206d_2 "206. Did your 2nd baby experience an illness with a cough since you last spoke to us, or not?"
label variable m4_206d_3 "206. Did your 3nd baby experience an illness with a cough since you last spoke to us, or not?"

label variable m4_206e_1 "206. Did your 1st baby experience trouble breathing or very fast breathing with short rapid breaths since you last spoke to us, or not?"
label variable m4_206e_2 "206. Did your 2nd baby experience trouble breathing or very fast breathing with short rapid breaths since you last spoke to us, or not?"
label variable m4_206e_3 "206. Did your 3nd baby experience trouble breathing or very fast breathing with short rapid breaths since you last spoke to us, or not?"

label variable m4_206f_1 "206. Did your 1st baby experience a problem in the chest since you last spoke to us, or not?"
label variable m4_206f_2 "206. Did your 2nd baby experience a problem in the chest since you last spoke to us, or not?"
label variable m4_206f_3 "206. Did your 3nd baby experience a problem in the chest since you last spoke to us, or not?"

label variable m4_206g_1 "206. Did your 1st baby experience trouble feeding since you last spoke to us, or not?"
label variable m4_206g_2 "206. Did your 2nd baby experience trouble feeding since you last spoke to us, or not?"
label variable m4_206g_3 "206. Did your 3nd baby experience trouble feeding since you last spoke to us, or not?"

label variable m4_206h_1 "206. Did your 1st baby experience convulsions since you last spoke to us, or not?"
label variable m4_206h_2 "206. Did your 2nd baby experience convulsions since you last spoke to us, or not?"
label variable m4_206h_3 "206. Did your 3nd baby experience convulsions since you last spoke to us, or not?"

label variable m4_206i_1 "206. Did your 1st baby experience Jaundice (that is, yellow colour of the skin) since you last spoke to us, or not?"
label variable m4_206i_2 "206. Did your 2nd baby experience Jaundice (that is, yellow colour of the skin) since you last spoke to us, or not?"
label variable m4_206i_3 "206. Did your 3nd baby experience Jaundice (that is, yellow colour of the skin) since you last spoke to us, or not?"

label variable m4_206j_1 "206. Did your 1st baby experience yellow palms or soles since you last spoke to us, or not?"
label variable m4_206j_2 "206. Did your 2nd baby experience yellow palms or soles since you last spoke to us, or not?"
label variable m4_206j_3 "206. Did your 3nd baby experience yellow palms or soles since you last spoke to us, or not?"

label variable m4_206k_1 "206. Did your 1st baby experience lethargy/ unconsciousness  since you last spoke to us, or not?"
label variable m4_206k_2 "206. Did your 2nd baby experience lethargy/ unconsciousness since you last spoke to us, or not?"
label variable m4_206k_3 "206. Did your 3nd baby experience lethargy/ unconsciousness since you last spoke to us, or not?"

label variable m4_206l_1 "206. Did your 1st baby experience bulging fontanel since you last spoke to us, or not?"
label variable m4_206l_2 "206. Did your 2nd baby experience bulging fontanel since you last spoke to us, or not?"
label variable m4_206l_3 "206. Did your 3nd baby experience bulging fontanel since you last spoke to us, or not?"

label variable m4_207a_1 "207. Did your 1st baby experience any other health problems since you last spoke to us, or not?"
label variable m4_207a_2 "207. Did your 2nd baby experience any other health problems since you last spoke to us, or not?"
label variable m4_207a_3 "207. Did your 3nd baby experience any other health problems since you last spoke to us, or not?"

label variable m4_207_1_other "207. Specify any other problem on your 1st baby."
label variable m4_207_2_other "207. Specify any other problem on your 2nd baby."
label variable m4_207_3_other "207. Specify any other problem on your 3nd baby."


label variable m4_208a_1 "208. Do you know when your 1st baby died"
label variable m4_208a_2 "208. Do you know when your 2nd baby died"
label variable m4_208a_3 "208. Do you know when your 3rd baby died"

label variable m4_209_1 "209. Exactly how many days old was your 1st baby when he/she died?"
label variable m4_209_2 "209. Exactly how many days old was your 2nd baby when he/she died?"
label variable m4_209_3 "209. Exactly how many days old was your 3rd baby when he/she died?"

label variable m4_210_1_0 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_1 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_2 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_3 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_4 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_5 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_6 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_7 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_8 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_9 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_96 "210. What were you told was the cause of death for your 1st baby?"
label variable m4_210_1_other "210. What other causes you were told was the cause of death of your 1st baby death? "

label variable m4_210_2_0 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_1 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_2 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_3 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_4 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_5 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_6 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_7 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_8 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_9 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_96 "210. What were you told was the cause of death for your 2nd baby?"
label variable  m4_210_2_other "210. What other causes you were told was the cause of death of your 2nd baby death? "

label variable m4_210_3_0 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_1 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_2 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_3 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_4 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_5 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_6 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_7 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_8 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_9 "210. What were you told was the cause of death for your 3rd baby?"
label variable m4_210_3_96 "210. What were you told was the cause of death for your 3rd baby?"

label variable m4_210_3_other "210. What other causes you were told was the cause of death of your 3rd baby death? "

label variable m4_1_3_et "210. Have you experience any form of postpartum complication such as purpureal sepsis, urinary incontinence, walking problem, insomnia etc.? "

label variable m4_211_1 "211. Before your 1st baby died, did you seek advice or treatment for the illness from any source?"
label variable m4_211_2 "211. Before your 2nd baby died, did you seek advice or treatment for the illness from any source?"
label variable m4_211_3 "211. Before your 3rd baby died, did you seek advice or treatment for the illness from any source?"

label variable m4_212_1 "212. Where did your 1st baby die?"
label variable m4_212_2 "212. Where did your 2nd baby die?"
label variable m4_212_3 "212. Where did your 3rd baby die?"

*---------------- Section 3: Health - Woman -------*
label variable m4_301 "301. I would like to talk about your own health since you last spoke to us. In general, how would you rate your overall health?"

label variable m4_302a "302A. I am now going to ask some more questions about your health since you delivered. Over the past 2 weeks, on how many days have you been bothered little interest or pleasure in doing things?"

label variable m4_302b "302B. Over the past 2 weeks, on how many days have you been bothered feeling down, depressed, or hopeless in doing things?"

label variable m4_303a "303A. Please tell me what best describes how you have felt about your baby loving?"

label variable m4_303b "303B. Please tell me what best describes how you have felt about your baby resentful."

label variable m4_303c "303C. Please tell me what best describes how have felt about your baby neutral or felt nothing."

label variable m4_303d "303D. Please tell me what best describes how have you felt about your baby Joyful."

label variable m4_303e "303E. Please tell me what best describes how have felt about your baby dislike."

label variable m4_303f "303F. Please tell me what best describes how have felt about your baby protective."

label variable m4_303g "303G. Please tell me what best describes how have felt about your baby disappointed . "

label variable m4_303h "303H. Please tell me what best describes how have felt about your baby aggressive."

label variable m4_304 "304. In the past 30 days, how much has pain affected your satisfaction with your sex life?"

label variable m4_305 "305. Sometimes a woman can have a problem such that she experiences a constant leakage of urine or stool from her vagina during the day and night. This problem usually occurs after a difficult childbirth"

label variable m4_306 "306. How many days after giving birth did these symptoms start?"

label variable m4_307 "307. How much does this problem alter your lifestyle or daily activities?"

label variable m4_308 "308. Have you sought treatment for this condition?"

label variable m4_309 "309. Why have you not sought treatment? Probe and tick all that apply as any else?"

label variable m4_309_other "309-other. Other reason, specify."

label variable m4_310 "310. Did the treatment stop the problem?"

label variable m4_401a "401A. Since we last spoke, did you or your baby have any new health care consultations, or not?"

label variable m4_401b "401B. Since we last spoke, did you have any new health care consultations, or not?"

label variable m4_402 "402. Since we last spoke, how many new healthcare consultations did you have?"

label variable m4_403a "403A.1 Where did this new 1st healthcare consultation for you or your baby take place?"

label variable m4_403b "403B.1 Where did this new 2nd  healthcare consultation for you or your baby take place?"

label variable m4_403c "403C.1 Where did this new 2nd  healthcare consultation for you or your baby take place?"


label variable m4_404a "404A. What is the name of the facility (ies) where the 1st new health care consultation(s) took place?"

label variable m4_404a_other_1 "404A-other.1. Specify other facility for the 1st consultation in East Shewa or Adama?"

label variable m4_404a_other_2 "404A-other.2. Specify other facility for the 1st consultation outside East Shewa or Adama?" 

label variable m4_404b "404B. What is the name of the facility(ies) where the 2nd new health care consultation(s) took place for your 1st baby?"

label variable m4_404b_other_1 "404B-other.1. Specify other facility for the 2nd consultation in East Shewa or Adama?"

label variable m4_404b_other_2 "404B-other.2. Specify other facility for the 2nd consultation outside East Shewa or Adama?" 

label variable m4_404c "404C.1 What is the name of the facility(ies) where the 3rd new health care consultation(s) took place for your 1st baby?"

label variable m4_404c_other_1 "404C-other.1. Specify other facility for the 3rd consultation in East Shewa or Adama?"

label variable m4_404c_other_2 "404C-other.2. Specify other facility for the 3rd consultation outside East Shewa or Adama?" 

label variable m4_405 "405. Was the 1st new consultation for a routine or regular checkup after the delivery?"

label variable m4_406_a "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_b   "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_c   "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_d    "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_e   "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_f    "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_g     "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_h    "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_i "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_j "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_96 "406. Was this 1st consultation for any of the following? Please tell me all that apply."

label variable m4_406_other "406-Other.Specify other reasons why the 1st consultation was."

label variable m4_407 "407. Was the 2nd new consultation for a routine or regular checkup after the delivery?"

label variable m4_408_a "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_b "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_c "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_d "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_e "408. Was this 2nd consultation for any of the following? Please tell me all that apply."
label variable m4_408_f "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_g "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_h "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_i "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_j "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_96 "408. Was this 2nd consultation for any of the following? Please tell me all that apply."

label variable m4_408_other "408-Other. Specify other reason why the 2nd consultation was"

label variable m4_409 "409. Was the 3rd new consultation is for a routine or regular checkup after the delivery?"

label variable m4_410_a "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_b "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_c "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_d "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_e "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_f "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_g "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_h "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_i "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_j "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_96 "410. Was this 3rd consultation for any of the following? Please tell me all that apply."

label variable m4_410_other "510-Other. Specify other reason why the 3rd consultation was"

label variable m4_411a "411A. On what day did the 1st new consultation take place? (D-M-Y) ?"

label variable m4_411b "411B. On what day did the 2nd new consultation take place? (D-M-Y) ?"

label variable m4_411c "411C. On what day did the 2nd new consultation take place? (D-M-Y) ?"

label variable m4_412a "412A. Approximately how long days after the delivery did this 1st new visit take place ?"

label variable m4_412b "412B. Approximately how long days after the delivery did this 1st new visit take place ?"

label variable m4_412c "412C. Approximately how long days after the delivery did this 1st new visit take place ?"

label variable m4_413_a "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_a "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_b "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_c  "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_d  "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_e  "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_f "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_g  "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_h  "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_i   "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_j "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_k "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_96 "413. Are there any reasons that prevented you from receiving postnatal or postpartum care since the delivery? Tell me all reasons, if any, that apply. "

label variable m4_413_other "413-other. Specify other reasons that prevented you from receiving postnatal or postpartum care since the delivery."

label variable m4_501 "501. Overall, how would you rate the quality of care that you received at the 1st new healthcare consultation facility?"

label variable m4_502 "502. Overall, how would you rate the quality of care that you received at the 2nd new healthcare consultation facility?"

label variable m4_503 "503. Overall, how would you rate the quality of care that you received at the 3rd new healthcare consultation facility?"

label variable m4_601a_1 "601A.1. Since the delivery, did your 1st baby receive their temperature taken (using a thermometer)?"

label variable m4_601a_2 "601A.2. Since the delivery, did your 2nd baby receive their temperature taken (using a thermometer)?"

label variable m4_601a_3 "601A.3. Since the delivery, did your 3rd baby receive their temperature taken (using a thermometer)?"

label variable m4_601b_1 "601B.1. Since the delivery, did your 1st baby receive their weight taken (using a scale)?"

label variable m4_601b_2 "601B.2. Since the delivery, did your 2nd baby receive their weight taken (using a scale)?"

label variable m4_601b_3 "601B.3. Since the delivery, did your 3rd baby receive their weight taken (using a scale)?"

label variable m4_601c_1 "601C.1. Since the delivery, did your 1st baby receive their length measured (using a measuring tape)?"

label variable m4_601c_2 "601C.2. Since the delivery, did your 2nd baby receive their length measured (using a measuring tape)?"

label variable m4_601c_3 "601C.3. Since the delivery, did your 3rd baby receive their length measured (using a measuring tape)?"

label variable m4_601d_1 "601D.1. Since the delivery, did your 1st baby receive their eyes examined?"

label variable m4_601d_2 "601D.2. Since the delivery, did your 2nd baby receive their eyes examined?"

label variable m4_601d_3 "601D.3. Since the delivery, did your 3rd baby receive their eyes examined?"

label variable m4_601e_1 "601E.1. Since the delivery, did your 1st baby receive their hearing checked?"

label variable m4_601e_2 "601E.2. Since the delivery, did your 2nd baby receive their hearing checked?"

label variable m4_601e_3 "601E.3. Since the delivery, did your 3rd baby receive their hearing checked?"

label variable m4_601f_1 "601F.1. Since the delivery, did your 1st baby receive his/her chest listened to with a stethoscope?"

label variable m4_601f_2 "601F.2. Since the delivery, did your 2nd baby receive his/her chest listened to with a stethoscope?"

label variable m4_601f_3 "601F.3. Since the delivery, did your 3rd baby receive his/her chest listened to with a stethoscope?"

label variable m4_601g_1 "601G.1. Since the delivery, did your 1st baby receive a blood test using a finger prick (that is, taking a drop of blood from their finger)?"

label variable m4_601g_2 "601G.2. Since the delivery, did your 2nd baby receive a blood test using a finger prick (that is, taking a drop of blood from their finger)?"

label variable m4_601g_3 "601G.3. Since the delivery, did your 3rd baby receive a blood test using a finger prick (that is, taking a drop of blood from their finger)?"

label variable m4_601h_1 "601H.1. Since the delivery, did your 1st baby receive a malaria test (only asked in endemic areas)?"

label variable m4_601h_2 "601H.2. Since the delivery, did your 2nd baby receive a malaria test (only asked in endemic areas)?"

label variable m4_601h_3 "601H.3. Since the delivery, did your 3rd baby receive a malaria test (only asked in endemic areas)?"

label variable m4_601i_1 "601I.1. Since the delivery, did your 1st baby receive any other test?"

label variable m4_601i_1_other "601I.1-other. Since the delivery, please specify any other test your 1st baby receive?"

label variable m4_601i_2 "601I.2. Since the delivery, did your 2nd baby receive any other test?"

label variable m4_601i_2_other "601I.2-other. Since the delivery, please specify any other test your 2nd baby receive?"


label variable m4_601i_3 "601I.3. Since the delivery, did your 3rd baby receive any other test?"

label variable m4_601i_3_other "601I.3-other. Since the delivery, please specify any other test your 3rd baby receive?"

label variable m4_618a_1 "618A.1. Was your 1st baby tested for HIV after birth?"

label variable m4_618b_1 "618B.1. What was the result of your 1st baby's HIV test?"

label variable m4_618c_1 "618C.1 Was your 1st baby given medication to prevent HIV/AIDS?"

label variable m4_618a_2 "618A.1. Was your 2nd baby tested for HIV after birth?"

label variable m4_618b_2 "618B.1. What was the result of your 2nd baby's HIV test?"

label variable m4_618c_2 "618C.1 Was your 2nd baby given medication to prevent HIV/AIDS?"

label variable m4_618a_3 "618A.3. Was your 3rd baby tested for HIV after birth?"

label variable m4_618b_3 "618B.3. What was the result of your 3rd baby's HIV test?"

label variable m4_618c_3 "618C.3 Was your 3rd baby given medication to prevent HIV/AIDS?"

label variable m4_602a "602A. Since the delivery, did you discuss with a health care provider about how often the baby eats ?"

label variable m4_602b "602B. Since the delivery, did you discuss with a health care provider about what the baby should eat (only breast milk or other foods) ? "

label variable m4_602c "602C. Since the delivery, did you discuss with a health care provider about vaccinations for the baby? "

label variable m4_602d "602D. Since the delivery, did you discuss with a health careprovider about the position the baby should sleep in (on their back or their stomach)?"

label variable m4_602e "602E. Since the delivery, did you discuss with a health care provider about danger signs or symptoms you should watch out for in the baby that would mean you should go to a health facility? "

label variable m4_602f "602F. Since the delivery, did you discuss with a health care provider about how you should play and interact with the baby? "

label variable m4_602g "602G. Since the delivery, did you discuss with a health care provider about that you should take the baby to the hospital or to see a specialist like a pediatrician or a neonatologist?"

label variable m4_603_1_0 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply"

label variable m4_603_1_1 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply"

label variable m4_603_1_2 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply"

label variable m4_603_1_3 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply"

label variable m4_603_1_4 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply" 

label variable m4_603_1_5 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply" 

label variable m4_603_1_6 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply" 

label variable m4_603_1_96 "603.1. What did the health care provider tell you to do regarding signs of emergency for your 1st baby? Please tell me all that apply" 

label variable m4_603_1_other "603.1-other. Specify other thing your health care provider did"

label variable m4_603_2_0 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_1 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_2 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_3 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_4 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_5 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_6 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_96 "603.2. What did the health care provider tell you to do regarding signs of emergency for your 2nd baby? Please tell me all that apply" 

label variable m4_603_2_other "603.2-other. Specify other thing your health care provider did"

label variable m4_603_3_0 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_1 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_2 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_3 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_4 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_5 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_6 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply" 

label variable m4_603_3_96 "603.3. What did the health care provider tell you to do regarding signs of emergency for your 3rd baby? Please tell me all that apply"  

label variable m4_603_3_other "603.3-other. Specify other thing your health care provider did"

label variable m4_701a "701A. Since the delivery, did you receive your blood pressure measured (with a cuff around your arm)?"
label variable m4_701b "701B. Since the delivery, did you receive your temperature taken (with a thermometer)?"
label variable m4_701c "701C. Since the delivery, did you receive a vaginal exam?"
label variable m4_701d "701D. Since the delivery, did you receive a blood draw (that is, taking blood from your arm with a syringe)?"
label variable m4_701e "701E. Since the delivery, did you receive a blood test using a finger prick (that is, taking a drop of blood from your finger?"
label variable m4_701f "701F. Since the delivery, did you receive an HIV test?"
label variable m4_701g "701G. Since the delivery, did you receive a urine test (that is, where you peed in a container)?"
label variable m4_701h "701H. Since the delivery, did you receive any other test or examination?"
label variable m4_701h_other "701H-other. Specify any other test you received since the delivery."

label variable m4_702 "702. Since the delivery, did a health care provider examine your c-section scar?"

label variable m4_703a "703A. Since the delivery, did you discuss how to take care of your breasts (for example, good positioning for breastfeeding, hand expression of breast milk, or the use of warm or cold compresses) with a health care provider?"
label variable m4_703b "703B. Since the delivery, did you receive danger signs or symptoms you should watch out for in yourself that would mean you should go to a health facility?"
label variable m4_703c "703C. Since the delivery, did you receive your level of anxiety or depression?"
label variable m4_703d "703D. Since the delivery, did you receive your family planning options after the delivery?"
label variable m4_703e "703E. Since the delivery, did you receive  resuming sexual activity after birth?"
label variable m4_703f "703F. Since the delivery, did you receive  the importance of exercise or physical activity after giving birth?"
label variable m4_703g "703G. Since the delivery, did you receive the importance of sleeping under a bed net [Asked only in malaria endemic areas]?"
label variable m4_704a "704A. Since the delivery, did you have a session of psychological counseling or therapy with any type of professional? This could include seeing a mental health professional (like a psychologist, social worker, nurse, religious or spiritual advisor, or healer) for problems with your emotions or nerves."

label variable m4_704b "704B. How many of these sessions did you have since the delivery?"
label variable m4_704c "704C. How many of these sessions did you have since the delivery?"

label variable m4_801a "801A. Did you get Iron or folic acid pills for yourself?"
label variable m4_801b "801B. Did you get iron injection?"
label variable m4_801c "801C. Did you get calcium pills for yourself?"
label variable m4_801d "801D. Did you get multivitamins for yourself?"
label variable m4_801e "801E. Did you get food supplements like Super Cereal or Plumpy nut?"
label variable m4_801f "801F. Did you get medicine for intestinal worms [endemic areas]?"
label variable m4_801g "801G. Did you get medicine for malaria [endemic areas]?"
label variable m4_801h "801H. Did you get medicine for HIV?"
label variable m4_801i "801I. Did you get medicine for your emotions, nerves, or mental health?"
label variable m4_801j "801J. Did you get medicine for hypertension?"
label variable m4_801k "801K. Did you get medicine for diabetes, including injections of insulin?"
label variable m4_801l "801L. Did you get Antibiotics for an infection?"
label variable m4_801m "801M. Did you get aspirin?"
label variable m4_801n "801N. Did you get  paracetamol, or other pain relief drugs?"
label variable m4_801o "801O. Did you get contraceptive pills?"
label variable m4_801p "801P. Did you get contraceptive injection?"
label variable m4_801q "801Q. Did you get another contraceptive method?"
label variable m4_801r "801R. Did you get any other medicine or supplement?"
label variable m4_801r_other "801R. Specify any other medicine or supplement you got."

label variable m4_802a_1 "802A_1. Did your 1st baby get Iron supplements?"
label variable m4_802a_2 "802A_2. Did your 2nd baby get Iron supplements?" 
label variable m4_802a_3 "802A_3. Did your 3rd baby get Iron supplements?"

label variable m4_802b_1 "802B_1. Did your 1st baby get Vitamin A supplements?"
label variable m4_802b_2 "802B_2. Did your 2nd baby get Vitamin A supplements?" 
label variable m4_802b_3 "802B_3. Did your 3rd baby get Vitamin A supplements?"

label variable m4_802c_1 "802C_1. Did your 1st baby get Vitamin D supplements?"
label variable m4_802c_2 "802C_2. Did your 2nd baby get Vitamin D supplements?" 
label variable m4_802c_3 "802C_3. Did your 3rd baby get Vitamin D supplements?"

label variable m4_802d_1 "802D_1. Did your 1st baby get Oral rehydration salts?"
label variable m4_802d_2 "802D_2. Did your 2nd baby get Oral rehydration salts?" 
label variable m4_802d_3 "802D_3. Did your 3rd baby get Oral rehydration salts?"

label variable m4_802e_1 "802E_1. Did your 1st baby get Antiseptic ointment?"
label variable m4_802e_2 "802E_2. Did your 2nd baby get Antiseptic ointment?" 
label variable m4_802e_3 "802E_3. Did your 3rd baby get Antiseptic ointment?"

label variable m4_802f_1 "802F_1. Did your 1st baby get antibiotics ?"
label variable m4_802f_2 "802F_2. Did your 2nd baby get antibiotics ?" 
label variable m4_802f_3 "802F_3. Did your 3rd baby get antibiotics ?"

label variable m4_802g_1 "802G_1. Did your 1st baby get medicine to prevent pneumonia ?"
label variable m4_802g_2 "802G_2. Did your 2nd baby get medicine to prevent pneumonia ?" 
label variable m4_802g_3 "802G_3. Did your 3rd baby get medicine to prevent pneumonia ?"

label variable m4_802h_1 "802H_1. Did your 1st baby get Medicine for malaria [endemic areas]?"
label variable m4_802h_2 "802H_2. Did your 2nd baby get Medicine for malaria [endemic areas]?" 
label variable m4_802h_3 "802H_3. Did your 3rd baby get Medicine for malaria [endemic areas]?"

label variable m4_802i_1 "802I_1. Did your 1st baby get Medicine for HIV [HIV+ mothers only]?"
label variable m4_802i_2 "802I_2. Did your 2nd baby get Medicine for HIV [HIV+ mothers only]?" 
label variable m4_802i_3 "802I_3. Did your 3rd baby get Medicine for HIV [HIV+ mothers only]?"

label variable m4_802j_1 "802J_1. Did your 1st baby get any other medicine or supplement?"
label variable m4_802j_1_other "802J_1_other. Specify any other any other medicine or supplement for your 1st baby." 
label variable m4_802j_2 "802J_2. Did your 2nd baby get any other medicine or supplement?"
label variable m4_802j_2_other "802J_2_other. Specify any other any other medicine or supplement for your 2nd baby."
label variable m4_802j_3 "802J_3. Did your 3rd baby get any other medicine or supplement?"
label variable m4_802j_3_other "802J_3_other. Specify any other any other medicine or supplement for your 3rd baby."

label variable m4_803a_1 "803A_1. Since the delivery, did your 1st baby get a vaccine for BCG against tuberculosis (that is an injection in the arm that can sometimes cause a scar). Do not include any BCG vaccine you already told us about"
label variable m4_803a_2 "803A_2. Since the delivery, did your 2nd baby get a vaccine for BCG against tuberculosis (that is an injection in the arm that can sometimes cause a scar). Do not include any BCG vaccine you already told us about"
label variable m4_803a_3 "803A_3. Since the delivery, did your 3rd baby get a vaccine for BCG against tuberculosis (that is an injection in the arm that can sometimes cause a scar). Do not include any BCG vaccine you already told us about"

label variable m4_803b_1 "803B_1. Since the delivery, did your 1st baby get a vaccine against polio that is taken orally, usually two drops in the mouth, to prevent polio?"
label variable m4_803b_2 "803B_2. Since the delivery, did your 2nd baby get a vaccine against polio that is taken orally, usually two drops in the mouth, to prevent polio?"
label variable m4_803b_3 "803B_3. Since the delivery, did your 3rd baby get a vaccine against polio that is taken orally, usually two drops in the mouth, to prevent polio?"

label variable m4_803c_1 "803C_1. Since the delivery, did your 1st baby get a pentavalent vaccination, that is, an injection in the thigh that is sometimes given at the same time as the polio drops?"
label variable m4_803c_2 "803C_2. Since the delivery, did your 2nd baby get a pentavalent vaccination, that is, an injection in the thigh that is sometimes given at the same time as the polio drops?"
label variable m4_803c_3 "803C_3. Since the delivery, did your 3rd baby get a pentavalent vaccination, that is, an injection in the thigh that is sometimes given at the same time as the polio drops?"

label variable m4_803d_1 "803D_1. Since the delivery, did your 1st baby get a pneumococcal vaccination, that is, an injection in the thigh to prevent pneumonia?"
label variable m4_803d_2 "803D_2. Since the delivery, did your 2nd baby get a pneumococcal vaccination, that is, an injection in the thigh to prevent pneumonia?"
label variable m4_803d_3 "803D_3. Since the delivery, did your 3rd baby get a pneumococcal vaccination, that is, an injection in the thigh to prevent pneumonia?"

label variable m4_803e_1 "803E_1. Since the delivery, did your 1st baby get a rotavirus vaccination, that is, liquid in the mouth to prevent diarrhea?"
label variable m4_803e_2 "803E_2. Since the delivery, did your 2nd baby get a rotavirus vaccination, that is, liquid in the mouth to prevent diarrhea?"
label variable m4_803e_3 "803E_3. Since the delivery, did your 3rd baby get a rotavirus vaccination, that is, liquid in the mouth to prevent diarrhea?"

label variable m4_803f_1 "803F_1. Since the delivery, did your 1st baby get any other vaccines or immunizations?"
label variable m4_803f_2 "803F_2. Since the delivery, did your 2nd baby get any other vaccines or immunizations?"
label variable m4_803f_3 "803F_3. Since the delivery, did your 3rd baby get any other vaccines or immunizations?"

label variable m4_803g_1 "803G_1. Specify any other vaccine or  immunization your 1st baby got."
label variable m4_803g_2 "803G_2. Specify any other vaccine or  immunization your 1st baby got."
label variable m4_803g_3 "803G_3. Specify any other vaccine or  immunization your 1st baby got."

label variable m4_804_1 "804_1. Where did your 1st get these vaccines?"
label variable m4_804_2 "804_2. Where did your 2nd get these vaccines?"
label variable m4_804_3 "804_3. Where did your 3rd get these vaccines?"

label variable m4_805 "805. In total, how much did you pay for these new medications, supplements and vaccines for yourself or the baby(ies)?"
 
label variable m4_901 "901. Did you pay any money out of your pocket for these new visits, including for the consultation or other indirect costs like your transport to the facility? Do not include the cost of medicines that you have already told me about"

label variable m4_902a "902A. Did you spend on Registration (Consultation)?"
label variable m4_902a_amt "902A_amt. How much money did you spend on registration?"

label variable m4_902b "902B. Did you spend money on Test or investigations (lab tests, ultrasound etc.)?"
label variable m4_902b_amt "902B_amt. How much money did you spend on Test or investigations (lab tests, ultrasound etc.)?"

label variable m4_902c "902C. Did you spend on transport (round trip) including that of the person accompanying you?"
label variable m4_902c_amt "902C_amt.  How much money did you spend on Transport (round trip) including that of the person accompanying you?"

label variable m4_902d "902D.  Did you spend money on Food and accommodation including that of person accompanying you?"
label variable m4_902d_amt "902D_amt.  How much money did you spend on Food and accommodation including that of person accompanying you?"

label variable m4_902e "902E. Did you spend money on Other?"
label variable m4_902e_amt "902E_amt. How much money did you spend on other?"

label variable m4_903 "903. So how much in total would you say you spent? ____ is that correct?"

label variable m4_904 "904. So how much in total would you say you spent?"

label variable m4_905_1 "905. Which of the following financial sources did your household use to pay for this?"
label variable m4_905_2 "905. Which of the following financial sources did your household use to pay for this?"
label variable m4_905_3 "905. Which of the following financial sources did your household use to pay for this?"
label variable m4_905_4 "905. Which of the following financial sources did your household use to pay for this?"
label variable m4_905_5 "905. Which of the following financial sources did your household use to pay for this?"
label variable m4_905_6 "905. Which of the following financial sources did your household use to pay for this?"
label variable m4_905_96 "905. Which of the following financial sources did your household use to pay for this?"

label variable m4_905_other "905-other. Specify other sources of financial source."
label variable m4_conclusion_live_babies "CONCLUSION FOR WOMEN WITH LIVE BABIES"
label variable m4_conclusion_dead_baby "IF BABY DIED: THERE WILL BE NO END LINE INTERVIEW. READ THIS CONCLUSION FOR WOMEN WHO LOST THE BABY"
label variable m4_ot1 "OT1. What is the Outcome of the phone call? Interviewer should fill the outcome for each phone call at the end."
label variable m4_ot1_oth "Ot1_Oth. Specify."
label variable m4_complete "Complete?"
	
*===============================================================================
	* STEP FIVE: ORDER VARIABLES
	
* drop unncessary vars and de-identify dataset
drop first_name family_name phone_number m1_513b ///
     m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i m1_514b m1_515a_town ///
	 m1_515b_zone m1_515c_ward m1_515d_house m1_516 m1_517 m1_518 m1_519_district ///
	 m1_519_village m1_519_ward m1_714d 
	 
order m1_* m2_* m3_* m4_* mcard_*, sequential

order m2_start m2_date m2_date m2_permission m2_103 m2_time_start m2_maternal_death_reported m2_ga m2_hiv_status ///
	 m2_date_of_maternal_death m2_maternal_death_learn m2_maternal_death_learn_other m2_111 m2_111_other m2_201,after(m1_end_time)

order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3 muac m1_1306 m1_1307 m1_1309,after(m1_1223)

order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

order country redcap_record_id order_redcap study_id interviewer_name_a7 redcap_event_name redcap_repeat_instrument redcap_repeat_instance ///
	  redcap_data_access_group m1_date m1_start_time country site study_site study_site_sd facility facility_other sampstrata ///
	  facility_type permission care_self site sampstrata study_site study_site_sd facility interviewer_id permission ///
	  care_self zone_live b5anc b6anc_first b6anc_first_conf continuecare b7eligible respondentid mobile_phone ///
	  flash kebele_malaria kebele_intworm
*===============================================================================
	* SAVE A LONG FORM DATASET
save "$et_data_final/eco_m1-m4_et_long.dta", replace

*===============================================================================
	* STEP SIX: CONVERT TO A WIDE FORM DATASET
	* SPLIT THE DATASET
	preserve 
		keep if redcap_event_name =="maternal_integrate_arm_1"
		keep redcap_record_id mcard*
		save "$et_data_final/tmpcard", replace 
	restore 
	
	preserve
		keep if redcap_event_name =="module_1_arm_1"
		keep country-kebele_intworm m1*
		save "$et_data_final/tmpm1", replace 
	restore 
	
	preserve
		keep if redcap_event_name =="module_2_arm_1"
		keep redcap_record_id redcap_repeat_instance m2_*
		save "$et_data_final/tmpm2", replace 
	restore 
	
	preserve
		keep if redcap_event_name =="module_3_arm_1"
		keep redcap_record_id m3_*
		save "$et_data_final/tmpm3", replace 
	restore 
	
	preserve
		keep if redcap_event_name =="module_4_arm_1"
		keep redcap_record_id m4_*
		save "$et_data_final/tmpm4", replace 
	restore 
	
	/*preserve
		keep if redcap_event_name =="module_5_arm_1"
		keep redcap_record_id m5_*
		save "$et_data_final/tmpm5", replace 
	restore */
	
	* Reshape M2
	u "$et_data_final/tmpm2", clear
		keep redcap_record_id redcap_repeat_instance m2_start-m2_time_of_rescheduled
		reshape wide m2_start-m2_time_of_rescheduled, i(redcap_record_id) j(redcap_repeat_instance) 
	save "$et_data_final/tmpm2", replace // 969
	
	
	* Merge by redcap_record_id
	u "$et_data_final/tmpm1", clear
		merge 1:1 redcap_record_id using "$et_data_final/tmpcard" // there are 11 maternal card record_ids that are wrong!
			drop if _merge==2
			drop _merge
		merge 1:1 redcap_record_id using "$et_data_final/tmpm2"
			drop _merge
		merge 1:1 redcap_record_id using "$et_data_final/tmpm3" // need to figure out why there are so many rows in M3... only 854 women completed it 
			drop _merge 
		merge 1:1 redcap_record_id using "$et_data_final/tmpm4"
		drop _merge
		
	rm "$et_data_final/tmpcard.dta" 
	rm "$et_data_final/tmpm1.dta" 
	rm "$et_data_final/tmpm2.dta" 
	rm "$et_data_final/tmpm3.dta" 
	rm "$et_data_final/tmpm4.dta" 
		
*===============================================================================
	* STEP SEVEN: SAVE DATA TO RECODED FOLDER
	 save "$et_data_final/eco_m1-m4_et_wide.dta", replace


	** MODULE 2:
	forval i = 1/8 {
label variable m2_start`i' "IIC. May I proceed with the interview?"
label variable m2_103`i' "102. Date of interview (D-M-Y)"
label variable m2_permission`i' "CR1. Permission granted to conduct call"
label variable m2_date`i' "102. Date of interview (D-M-Y)"
label variable m2_time_start`i' "103A. Time of interview started"
label variable m2_maternal_death_reported`i' "108. Maternal death reported"
label variable m2_ga`i' "107a. Gestational age at this call based on LNMP (in weeks)"
*label variable m2_ga_estimate "107b. Gestational age based on maternal estimation (in weeks)"
label variable m2_hiv_status`i' "109. HIV status"
label variable m2_date_of_maternal_death`i' "110. Date of maternal death (D-M-Y)"
label variable m2_maternal_death_learn`i' "111. How did you learn about the maternal death?"
label variable m2_maternal_death_learn_other`i' "111-Oth. Specify other way of learning maternal death"
label variable m2_201`i' "201. I would like to start by asking about your health and how you have been feeling since you last spoke to us. In general, how would you rate your overall health?"
label variable m2_202`i' "202. As you know, this survey is about health care that women receive during pregnancy, delivery and after birth. So that I know that I am asking the right questions, I need to confirm whether you are still pregnant?"
label variable m2_date_of_maternal_death_2`i' "110. Date of maternal death (D-M-Y)"
label variable m2_203a`i' "203a. Since you last spoke to us, have you experienced severe or persistent headaches?"
label variable m2_203b`i' "203b. Since you last spoke to us, have you experienced vaginal bleeding of any amount?"
label variable m2_203c`i' "203c. Since you last spoke to us, have you experienced fever?"
label variable m2_203d`i' "203d. Since you last spoke to us, have you experiencedsevere abdominal pain, not just discomfort?"
label variable m2_203e`i' "203e. Since you last spoke to us, have you experienced a lot of difficult breathing?"
label variable m2_203f`i' "203f. Since you last spoke to us, have you experienced convulsions or seizures?"
label variable m2_203g`i' "203g. Since you last spoke to us, have you experienced fainting or loss of consciousness?"
label variable m2_203h`i' "203h. Since you last spoke to us, have you experienced that the baby has completely stopped moving?"
label variable m2_203i`i' "203i. Since you last spoke to us, have you experienced blurring of vision?"
label variable m2_204a`i' "204a. Since you last spoke to us, have you experienced Preeclapsia/eclampsia?"
label variable m2_204b`i' "204b. Since you last spoke to us, have you experienced Bleeding during pregnancy?"
label variable m2_204c`i' "204c. Since you last spoke to us, have you experienced Hyperemesis gravidarum?"
label variable m2_204d`i' "204d. Since you last spoke to us, have you experienced Anemia?"
label variable m2_204e`i' "204e. Since you last spoke to us, have you experienced Cardiac problem?"
label variable m2_204f`i' "204f. Since you last spoke to us, have you experienced Amniotic fluid volume problems(Oligohydramnios/ Polyhadramnios)?"
label variable m2_204g`i' "204g. Since you last spoke to us, have you experienced Asthma?"
label variable m2_204h`i' "204h. Since you last spoke to us, have you experienced RH isoimmunization?"
label variable m2_204i`i' "204i. Since you last spoke to us, have you experienced any other major health problems?"
label variable m2_204i_other`i' "204i-oth. Specify any other feeling since last visit"
label variable m2_205a`i' "205a. Over the past 2 weeks, on how many days have you been bothered by little interest or pleasure in doing things?"
label variable m2_205b`i' "205b. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless?"
label variable m2_205c`i' "205c. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
label variable m2_205d`i' "205d. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy?"
label variable m2_205e`i' "205e. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating?"
label variable m2_205f`i' "205f. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down?"
label variable m2_205g`i' "205g. Over the past 2 weeks, on how many days have you been bothered by trouble concentrating on things, such as your work or home duties?"
label variable m2_205h`i' "205h. Over the past 2 weeks, on how many days have you been bothered by moving or speaking so slowly that other people could have noticed? Or so fidgety or restless that you have been moving a lot more than usual?"
label variable m2_205i`i' "205i. Over the past 2 weeks, on how many days have you been bothered by Thoughts that you would be better off dead, or thoughts of hurting yourself in some way?"
label variable m2_206`i' "206. How often do you currently smoke cigarettes or use any other type of tobacco? Types of tobacco includes: Snuff tobacco, Chewing tobacco,  Cigar"
label variable m2_207`i' "207. How often do you currently chewing khat?(Interviewer: Inform that Khat is a leaf green plant use as stimulant and chewed in Ethiopia)"
label variable m2_208`i' "208. How often do you currently drink alcohol or use any other type of alcoholic?   A standard drink is any drink containing about 10g of alcohol, 1 standard drink= 1 tasa or wancha of (tella or korefe or borde or shameta), ½ birile of  Tej, 1 melekiya of Areke, 1 bottle of beer, 1 single of draft, 1 melkiya of spris(Uzo, Gine, Biheraw etc) and 1 melekiya of Apratives"
label variable m2_301`i' "301. Since we last spoke, did you have any new healthcare consultations for yourself, or not?"
label variable m2_302`i' "302. Since we last spoke, how many new healthcare consultations have you had for yourself?"
label variable m2_303a`i' "303a. Where did this/this new first healthcare consultation(s) for yourself take place?"
label variable m2_303b`i' "303b.  Where did the 2nd healthcare consultation(s) for yourself take place?"
label variable m2_303c`i' "303c. Where did the 3rd healthcare consultation(s) for yourself take place?"
label variable m2_303d`i' "303d. Where did the 4th healthcare consultation(s) for yourself take place?"
label variable m2_303e`i' "303e. Where did the 5th healthcare consultation(s) for yourself take place?"
label variable m2_304a`i' "304a. What is the name of the facility where this/this first healthcare consultation took place?"
label variable m2_304a_other`i' "304a-oth. Other facility for 1st health consultation"
label variable m2_304b`i' "304b. What is the name of the facility where this/this second healthcare consultation took place?"
label variable m2_304b_other`i' "304b-oth. Other facility for 2nd health consultation"
label variable m2_304c`i' "304c. What is the name of the facility where this/this third healthcare consultation took place?"
label variable m2_304c_other`i' "304c-oth. Other facility for 3rd health consultation"
label variable m2_304d`i' "304d. What is the name of the facility where this/this fourth healthcare consultation took place?"
label variable m2_304d_other`i' "304d-oth. Other facility for 4th health consultation"
label variable m2_304e`i' "304e. What is the name of the facility where this/this fifth healthcare consultation took place?"
label variable m2_304e_other`i' "304e-oth. Other facility for 5th health consultation"
label variable m2_305`i' "305. Was the first consultation for a routine antenatal care visit?"
label variable m2_306`i' "306. Was the first consultation for a referral from your antenatal care provider?"
label variable m2_306_1`i' "307. Was the first consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_306_2`i' "307. Was the first consultation for any of the following? An existing health problem"
label variable m2_306_3`i' "307. Was the first consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_306_4`i' "307. Was the first consultation for any of the following? To pick up medicine"
label variable m2_306_5`i' "307. Was the first consultation for any of the following? To get a vaccine"
label variable m2_306_96`i' "307. Was the first consultation for any of the following? Other reasons"
label variable m2_306_888_et`i' "307. No information"
label variable m2_306_998_et`i' "307. Unknown"
label variable m2_306_999_et`i' "307. Refuse to answer"
label variable m2_307_other`i' "307-oth. Specify other reason for the 1st visit"
label variable m2_308`i' "308. Was the second consultation is for a routine antenatal care visit?"
label variable m2_309`i' "309. Was the second consultation is for a referral from your antenatal care provider?"
label variable m2_308_1`i' "310. Was the second consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_308_2`i' "310. Was the second consultation for any of the following? An existing health problem"
label variable m2_308_3`i' "310. Was the second consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_308_4`i' "310. Was the second consultation for any of the following? To pick up medicine"
label variable m2_308_5`i' "310. Was the second consultation for any of the following? To get a vaccine"
label variable m2_308_96`i' "310. Was the second consultation for any of the following? Other reasons"
label variable m2_308_888_et`i' "310. No information"
label variable m2_308_998_et`i' "310. Unknown"
label variable m2_308_999_et`i' "310. Refuse to answer"
label variable m2_310_other`i' "310-oth. Specify other reason for second consultation"
label variable m2_311`i' "311. Was the third consultation is for a routine antenatal care visit?"
label variable m2_312`i' "312. Was the third consultation is for a referral from your antenatal care provider?"
label variable m2_311_1`i' "313. Was the third consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_311_2`i' "313. Was the third consultation for any of the following? An existing health problem"
label variable m2_311_3`i' "313. Was the third consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_311_4`i' "313. Was the third consultation for any of the following? To pick up medicine"
label variable m2_311_5`i' "313. Was the third consultation for any of the following? To get a vaccine"
label variable m2_311_96`i' "313. Was the third onsultation for any of the following? Other reasons"
label variable m2_311_888_et`i' "313. No information"
label variable m2_311_998_et`i' "313. Unknown"
label variable m2_311_999_et`i' "313. Refuse to answer"
label variable m2_313_other`i' "313-oth. Specify any other reason for the third consultation"
label variable m2_314`i' "314. Was the fourth consultation is for a routine antenatal care visit?"
label variable m2_315`i' "315. Was the fourth consultation is for a referral from your antenatal care provider?"
label variable m2_314_1`i' "316. Was the fourth consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_314_2`i' "316. Was the fourth consultation for any of the following? An existing health problem"
label variable m2_314_3`i' "316. Was the fourth consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_314_4`i' "316. Was the fourth consultation for any of the following? To pick up medicine"
label variable m2_314_5`i' "316. Was the fourth consultation for any of the following? To get a vaccine"
label variable m2_314_96`i' "316. Was the fourth onsultation for any of the following? Other reasons"
label variable m2_314_888_et`i' "316. No information"
label variable m2_314_998_et`i' "316. Unknown"
label variable m2_314_999_et`i' "316. Refuse to answer"
label variable m2_316_other`i' "316-oth. Specify other reason for the fourth consultation"
label variable m2_317`i' "317. Was the fifth consultation is for a routine antenatal care visit?"
label variable m2_318`i' "318. Was the fifth consultation is for a referral from your antenatal care provider?"
label variable m2_317_1`i' "319. Was the fifth consultation is for any of the following? A new health problem, including an emergency or an injury"
label variable m2_317_2`i' "319. Was the fifth consultation is for any of the following? An existing health problem"
label variable m2_317_3`i' "319. Was the fifth consultation is for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_317_4`i' "319. Was the fifth consultation is for any of the following? To pick up medicine"
label variable m2_317_5`i' "319. Was the fifth consultation is for any of the following? To get a vaccine"
label variable m2_317_96`i' "319. Was the fifth consultation is for any of the following? Other reasons"
label variable m2_317_888_et`i' "319. No information"
label variable m2_317_998_et`i' "319. Unknown"
label variable m2_317_999_et`i' "319. Refuse to answer"
label variable m2_319_other`i' "319-oth. Specify other reason for the fifth consultation"
label variable m2_320_a`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? No reason or you didn't need it"
label variable m2_320_b`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? You tried but were sent away (e.g., no appointment available) "
label variable m2_320_c`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? High cost (e.g., high out of pocket payment, not covered by insurance)"
label variable m2_320_d`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Far distance (e.g., too far to walk or drive, transport not readily available)"
label variable m2_320_e`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Long waiting time (e.g., long line to access facility, long wait for the provider)"
label variable m2_320_f`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
label variable m2_320_g`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Staff don't show respect (e.g., staff is rude, impolite, dismissive)"
label variable m2_320_h`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
label variable m2_320_i`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) "
label variable m2_320_j`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? COVID-19 fear"
label variable m2_320_k`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Don't know where to go/too complicated"
label variable m2_320_l`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Fear of discovering serious problem"
label variable m2_320_96`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Other, specify"
label variable m2_320_99`i' "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Refused"
label variable m2_320_888_et`i' "320. No information"
label variable m2_320_998_et`i' "320. Unknown"
label variable m2_320_999_et`i' "320. Refuse to answer"
label variable m2_320_other`i' "320-oth. Specify other reason preventing receiving more antenatal care"
label variable m2_321`i' "321. Other than in-person visits, did you have contacted with a health care provider by phone, SMS, or web regarding your pregnancy?"
label variable m2_401`i' "401. Overall, how would you rate the quality of care that you received from the health facility where you took the 1st consultation?"
label variable m2_402`i' "402. Overall, how would you rate the quality of care that you received from the health facility where you took the 2nd consultation?"
label variable m2_403`i' "403. Overall, how would you rate the quality of care that you received from the health facility where you took the 3rd consultation?"
label variable m2_404`i' "404. Overall, how would you rate the quality of care that you received from the health facility where you took the 4th consultation?"
label variable m2_405`i' "405. Overall, how would you rate the quality of care that you received from the health facility where you took the 5th consultation?"
label variable m2_501a`i' "501a. Since you last spoke to us, did you get your blood pressure measured (with a cuff around your arm)?"
label variable m2_501b`i' "501b. Since you last spoke to us, did you get your weight taken (using a scale)?"
label variable m2_501c`i' "501c.  Since you last spoke to us, did you get a blood draw (that is, taking blood from your arm with a syringe)?"
label variable m2_501d`i' "501d.  Since you last spoke to us, did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
label variable m2_501e`i' "501e.  Since you last spoke to us, did you get a urine test (that is, where you peed in a container)?"
label variable m2_501f`i' "501f. Since you last spoke to us, did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
label variable m2_501g`i' "501g.  Since you last spoke to us, did you get any other tests?"
label variable m2_501g_other`i' "501g-oth. Specify any other test you took since you last spoke to us"
label variable m2_502`i' "502. Since we last spoke, did you receive any new test results from a health care provider?   By that I mean, any result from a blood or urine sample or from blood pressure measurement.Do not include any results that were given to you during your first antenatal care visit or during the first survey, only new ones."
label variable m2_503a`i' "503a. Remember that this information will remain confidential. Did you receive a result for Anemia?"
label variable m2_503b`i' "503b. Remember that this information will remain confidential. Did you receive a result for HIV?"
label variable m2_503c`i' "503c. Remember that this information will remain confidential. Did you receive a result for HIV viral load?"
label variable m2_503d`i' "503d. Remember that this information will remain confidential. Did you receive a result for Syphilis?"
label variable m2_503e`i' "503e. Remember that this information will remain confidential. Did you receive a result for diabetes?"
label variable m2_503f`i' "503f. Remember that this information will remain confidential. Did you receive a result for Hypertension?"
label variable m2_504`i' "504. Did you receive any other new test results?"
label variable m2_504_other`i' "504-oth. Specify other test result you receive"
label variable m2_505a`i' "505a. What was the result of the test for anemia? Remember that this information will remain fully confidential."
label variable m2_505b`i' "505b. What was the result of the test for HIV? Remember that this information will remain fully confidential."
label variable m2_505c`i' "505c. What was the result of the test for HIV viral load? Remember that this information will remain fully confidential."
label variable m2_505d`i' "505d. What was the result of the test for syphilis? Remember that this information will remain fully confidential."
label variable m2_505e`i' "505e. What was the result of the test for diabetes? Remember that this information will remain fully confidential."
label variable m2_505f`i' "505f. What was the result of the test for hypertension? Remember that this information will remain fully confidential."
label variable m2_505g`i' "505g. What was the result of the test for other tests? Remember that this information will remain fully confidential."
label variable m2_506a`i' "506a. Since you last spoke to us, did you and a healthcare provider discuss about the signs of pregnancy complications that would require you to go to the health facility?"
label variable m2_506b`i' "506b. Since you last spoke to us, did you and a healthcare provider discuss about your birth plan that is, where you will deliver, how you will get there, and how you need to prepare, or didnt you?"
label variable m2_506c`i' "506c. Since you last spoke to us, did you and a healthcare provider discuss about care for the newborn when he or she is born such as warmth, hygiene, breastfeeding, or the importance of postnatal care?"
label variable m2_506d`i' "506d. Since you last spoke to us, did you and a healthcare provider discuss about family planning options for after delivery?"
label variable m2_507`i' "507. What did the health care provider tell you to do regarding these new symptoms?"
label variable m2_508a`i' "508a. Since we last spoke, did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves."
label variable m2_508b_number`i' "508b. Do you know the number of psychological counseling or therapy session you had?"
label variable m2_508b_last`i' "508b. How many of these sessions did you have since you last spoke to us?"
label variable m2_508c`i' "508c. Do you know how long this/these visits took?"
label variable m2_508d`i' "508d. How many minutes did this/these visit(s) last on average?"
label variable m2_509a`i' "509a.  Since we last spoke, did a healthcare provider tells you that you needed to go see a specialist like an obstetrician or a gynecologist?"
label variable m2_509b`i' "509b. Since we last spoke, did a healthcare provider tells you that you needed to go to the hospital for follow-up antenatal care?"
label variable m2_509c`i' "509c. Since we last spoke, did a healthcare provider tell you that you will need a C-section?"
label variable m2_601a`i' "601a. Did you get Iron or folic acid pills?"
label variable m2_601b`i' "601b. Did you get Calcium pills?"
label variable m2_601c`i' "601c. Did you get Multivitamins?"
label variable m2_601d`i' "601d. Did you get Food supplements like Super Cereal or Plumpynut?"
label variable m2_601e`i' "601e. Did you get medicine for intestinal worm?"
label variable m2_601f`i' "601f. Did you get medicine for malaria?"
label variable m2_601g`i' "601g. Did you get Medicine for HIV?"
label variable m2_601h`i' "601h. Did you get Medicine for your emotions, nerves, depression, or mental health?"
label variable m2_601i`i' "601i. Did you get Medicine for hypertension?"
label variable m2_601j`i' "601j. Did you get Medicine for diabetes, including injections of insulin?"
label variable m2_601k`i' "601k. Did you get Antibiotics for an infection?"
label variable m2_601l`i' "601l. Did you get Aspirin?"
label variable m2_601m`i' "601m. Did you get Paracetamol, or other pain relief drugs?"
label variable m2_601n`i' "601n. Did you get Any other medicine or supplement?"
label variable m2_601n_other`i' "601n-oth. Specify other medicine or supplement you took"
label variable m2_602a`i' "602a. Do you know how much in total you pay for this new medication?"
label variable m2_602b`i' "602b. In total, how much did you pay for these new medications or supplements (ETB)?"
label variable m2_603`i' "603. Are you currently taking iron and folic acid pills, or not?"
label variable m2_604`i' "604. How often do you take iron and folic acid pills?"
label variable m2_701`i' "701. I would now like to ask about the cost of these new health care visits.  Did you pay any money out of your pocket for these new visits, including for the consultation or other indirect costs like your transport to the facility?  Do not include the cost of medicines that you have already told me about."
label variable m2_702a`i' "702a. Did you spend money on Registration/Consultation?"
label variable m2_702a_other`i' "702a-oth. How much money did you spend on Registration/Consultation?"
label variable m2_702b`i' "702b. Did you spend money on Test or investigations (lab tests, ultrasound etc.?"
label variable m2_702b_other`i' "702b-oth. How much money did you spend on Test or investigations (lab tests, ultrasound etc.)"
label variable m2_702c`i' "702c. Did you spend money on Transport (round trip) including that of the person accompanying you?"
label variable m2_702c_other`i' "702c-oth. How much money did you spend on Transport (round trip) including that of the person accompanying you?"
label variable m2_702d`i' "702d. Did you spend money on Food and accommodation including that of person accompanying you?"
label variable m2_702d_other`i' "702d-oth. How much money did you spend on Food and accommodation including that of person accompanying you?"
label variable m2_702e`i' "702e. Did you spend money for other services?"
label variable m2_702e_other`i' "702e-oth. How much money did you spend on other item/service?"
label variable m2_703`i' "703. So, in total you spent"
label variable m2_704`i' "704. Is the total cost correct?"
label variable m2_704_other`i' "704-oth. So how much in total would you say you spent?"
label variable m2_705_1`i' "705. Which of the following financial sources did your household use to pay for this? Current income of any household members"
label variable m2_705_2`i' "705. Which of the following financial sources did your household use to pay for this? Savings (e.g., bank account)"
label variable m2_705_3`i' "705. Which of the following financial sources did your household use to pay for this? Payment or reimbursement from a health insurance plan"
label variable m2_705_4`i' "705. Which of the following financial sources did your household use to pay for this? Sold items (e.g., furniture, animals, jewellery, furniture)"
label variable m2_705_5`i' "705. Which of the following financial sources did your household use to pay for this? Family members or friends from outside the household"
label variable m2_705_6`i' "705. Which of the following financial sources did your household use to pay for this? Borrowed (from someone other than a friend or family)"
label variable m2_705_96`i' "705. Which of the following financial sources did your household use to pay for this? Other (please specify)"
label variable m2_705_888_et`i' "705. No information"
label variable m2_705_998_et`i' "705. Unknown"
label variable m2_705_999_et`i' "705. Refuse to answer"
label variable m2_705_other`i' "705-oth. Please specify"
label variable m2_interview_inturrupt`i' "Is the interview inturrupted?"
label variable m2_interupt_time`i' "At what time it is interrupted?"
label variable m2_interview_restarted`i' "Is the interview restarted?"
label variable m2_restart_time`i' "At what time it is restarted?"
label variable m2_endtime`i' "103B. Time of Interview end"
label variable m2_int_duration`i' "103C. Total Duration of interview (In minutes)"
label variable m2_endstatus`i' "What is this womens current status at the end of the interview?"	

	}
