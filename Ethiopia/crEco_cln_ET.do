* Ethiopia ECohort Baseline Data Cleaning File 
* Created by K. Wright, S. Sabwa, C. Arsenault 
* Updated: July 24 2023 


*------------------------------------------------------------------------------*

* Import Data 
global data "$et_data/"

clear all 
set maxvar 15000 
import delimited using "$data/25July2023.csv", clear

*These datasets download the entire longitudinal dataset, so we have to drop the events that we're not interested in. 

*------------------------------------------------------------------------------*

* STEP ONE: change variable names 
    * this will be done in various steps / sections, because kw needs to see how the data pull into stata \
	
	
* MODULE 1:
	
	rename (record_id redcap_event_name) (record_id event)
	rename (study_id interviewer_id date_of_interview_m1 time_of_interview_m1) ///
	       (study_id interviewer_id date_m1 m1_start_time)
	rename study_site_a4 woreda
	rename other_study_site_a4 woreda_other
	rename facility_name_a5 facility
	rename other_facility_name facility_other
	rename facility_type_a6 facility_type
	rename b1_may_we_have_your_permis permission
	rename b2_are_you_here_today_to_r care_self
	rename b3_how_old_are_you age
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
			(m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g)
	rename (before_pregnant_diagn_203 specify_the_diagnosed_203 currently_taking_medication ///
	        which_best_describe_your_205a which_describes_your_205b which_describe_your_205c ///
			which_describe_your_205d which_describe_your_205e) ///
		   (m1_203 m1_203_other m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e)	
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
	
	rename (primary_phone_number_513b can_i_flash_this_number_513c secondary_personal_phone_513d ///
		   spouse_or_partner_513e community_health_worker_513f close_friend_or_family_513g ///
		   close_friend_or_family_513h other_phone_number_513i we_can_give_you_a_mobile_phone_5) ///
		   (m1_513b m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i m1_514a)
	
	rename (mobile_phone_number_514b where_is_your_town_515a where_is_your_zone_515b where_is_your_kebele_515c  ///
		    what_is_your_house_num_515d could_you_please_describe_516 is_this_a_temporary_reside_517 until_when_will_you_be_at_518  ///
			where_will_your_district_519a where_will_your_kebele_519b where_will_your_village_519c) (m1_514b m1_515a m1_515b m1_515c ///
			m1_515d m1_516 m1_517 m1_518 m1_519a m1_519b m1_519c)
	
	rename (i_would_like_to_know_how_601 how_likely_are_you_to_reco_602	how_long_in_minutes_did_603 ///
	        how_long_in_hours_or_minut_604 eth_1_6_1_do_you_know_how_lo eth_1_6_2_how_long_is_your) ///
			(m1_601 m1_602 m1_603 m1_604a m1_604b m1_604c) 
			
	rename (thinking_about_the_visit_605 thinking_about_the_visit_605b thinking_about_the_visit_605c ///
	        thinking_about_the_visit_605d thinking_about_the_visit_605e thinking_about_the_visit_605f ///
			thinking_about_the_visit_605g thinking_about_the_visit_605h thinking_about_the_visit_605i ///
			thinking_about_the_visit_605j thinking_about_the_visit_605k) ///
	        (m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h ///
			m1_605i m1_605j m1_605k)
			
	rename (measure_your_blood_pressure_700	measure_your_weight_701 measure_your_height_702 ///
	        measure_your_upper_arm_703 measure_heart_rate_704 take_urine_sample_705 take_blood_drop_706 ///
			take_blood_draw_707) ///
		   (m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707)
		   
	rename (do_hiv_test_708a share_hiv_test_result_708b medicine_for_hiv_708c explain_medicine_usage_708d do_hiv_viral_load_test_708e do_cd4_test_708f do_hiv_viral_load_test_709a do_cd4_test_709b result_of_blood_sugar_test_711b) (m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_711b)
		
	rename (how_subscription_for_713a_1 how_do_they_provide_713b_1 how_do_they_provide_713c_1 how_do_they_provide_713d_1 how_do_they_provide_713e_1 how_do_they_provide_713f_1 how_do_they_provide_713g_1 how_do_they_provide_713h_1 how_do_they_provide_713i_1 whare_you_given_injection_714a receive_tetanus_injection_714b nuber_of_tetanus_injection_714c how_many_years_ago_714d  how_many_years_ago_last_714e) (m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_714c m1_714d m1_714e)
	
	rename (provided_with_an_insecticide_715 discuss_about_feeling_depress_71 discuss_about_diabetes_718 discuss_about_bp_719 discuss_about_cardiac_720 discuss_about_mental_health_721 discuss_about_hiv_722 discus_about_medication_723) (m1_715 m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723)
	
	rename (should_come_back_724a when_did_he_tell_you_724b to_see_gynecologist_724c to_see_mental_health_provider_72 to_go_to_hospital_724e to_go_for_urine_test_724f go_to_blood_test_724g go_to_do_hiv_test_724h go_to_do_ultrasound_test_724i) (m1_724a m1_724b m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i)
	
	rename (estimated_date_for_delivery_801	 how_many_months_weeks_803 calculate_gestational_age_804 how_many_babies_you_preg_805 ask_your_last_period_806 when_you_got_pregnant_807) (m1_801 m1_803 m1_804 m1_805 m1_806 m1_807)
	
	rename (specify_other_reason_808) (m1_808_other)
	
	rename (discuss_your_birth_plan_809 other_than_the_list_above m1_811 you_might_need_c_section_812a m1_812b_0 other_reason_for_c_section_812) (m1_809 m1_810_other m1_811 m1_812a m1_812b m1_812_other) 
	
	rename (common_health_problems_813a advice_for_treatment_813b some_women_experience_813c some_women_experience_813d  during_the_visit_today_813e some_women_experience_eth_1_8a eth_1_8b_hyperemesis_gravi eth_1_8c_did_you_experienc eth_1_8d_did_you_experienc eth_1_8e_did_you_experienc eth_1_8f_did_you_experienc eth_1_8g_any_other_pregnan specify_the_feeling_eth_1_8_h eth_2_8_did_the_provider) (m1_813a m1_813b m1_813c m1_813d m1_813e m1_eth_1_8a m1_eth_1_8b m1_eth_1_8c m1_eth_1_8d m1_eth_1_8e m1_eth_1_8f m1_eth_1_8g m1_eth_1_8gother m1_eth_2_8)
	
	rename (experience_headaches_814a experience_for_vaginal_bleed_814	experience_a_fever_814c experience_abdominal_pain_814d experience_breath_difficulty_814 experience_convulsions_814f experience_repeated_faint_814g exprience_biby_stop_moving_814h could_you_please_tell_814i) (m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i)
	
	rename (other_specify_kan_biroo_ib) (m1_815_other)
	
	rename you_said_you_didn_t_have_symp_81 m1_816
	
	rename (smoke_cigarettes_901 advised_to_stop_smoking_902 frequency_of_chew_khat_903 advice_to_stop_khat_904 drink_alcohol_within_30_days_905 when_you_do_drink_alcohol_906 advised_to_stop_alcohol_907) (m1_901 m1_902 m1_903 m1_904 m1_905 m1_906 m1_907)
	
	rename (no_of_pregnancies_you_had_1001 no_of_births_you_had_1002 how_many_of_those_birth_alive_10 have_you_ever_lost_a_pregn_after baby_came_too_early_1005 blood_need_during_pregnancy_1006 m1_eth_1_10 had_cesarean_section_1007) (m1_1001 m1_1002 m1_1003 m1_1004 m1_1005 m1_1006 m1_eth_1_10 m1_1007)
	
	rename (specify_who_else_hit_1102)(m1_1102_other)
	
	rename (delivery_lasted_12_hours_1008 no_children_still_alive_1009 had_a_baby_die_within_1month_101 discuss_about_prev_pregn_1011a discuss_lost_baby_after_5m_1011b discuss_baby_born_dead_1011c discuss_baby_born_early_1011d discuss_you_had_c_section_1011e discuss_baby_die_within_1m_1011f anyone_ever_hit_kicked_1101 anyone_humiliate_you_1103) (m1_1008 m1_1009 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103)
	
	rename specify_who_humuliates_you m1_1104_other
	
	rename discuss_on_seek_support_1105	m1_1105
	
	rename (main_source_of_drink_water_1201 other_source_of_drink_1201 kind_of_toilet_facilities_1202 specify_other_toilet_1202 household_have_electricity_1203 household_have_radio_1204 household_have_tv_1205 household_have_telephone_1206 household_have_frige_1207 type_of_fuel_for_cook_1208 other_fuel_type_for_cook_1208) (m1_1201 m1_1201_other m1_1202 m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1208_other)
	
	rename (material_type_for_floor_1209 other_material_for_floor_1209 material_for_walls_1210 other_material_for_wall_1210 material_for_roof_1211 other_material_for_roof_1211 anyone_own_bicycle_1212 anyone_own_motor_cycle_1213 anyone_own_car_or_truck_1214 anyone_have_bank_account_1215 no_of_meals_per_day_1216 how_many_meals_per_1216_1) (m1_1209 m1_1209_other m1_1210 m1_1210_other m1_1211 m1_1211_other m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1216_1)
	
	rename money_from_pocket_for_trans_1217 m1_1217
	
	rename other_financial_source_1220 m1_1220_other
	
	rename other_health_insurance_type m1_1222_other
	
	rename (eth_1_13_muac_safartuu_naa hemoglobin_level_from_test) (muac m1_1309)
	
	rename (interview_end_time total_duration_of_intervie module_1_baseline_face_to_face_e) (m1_end_time interview_length m1_complete)
	
	
* MODULE 2:
	
	rename (m2_iic m2_cr1 m2_102 m2_103a m2_107 m2_107b_ga hiv_status_109_m2 how_did_you_learn_maternal_death other_way_of_learn_maternal_deat)(m2_start m2_permission m2_date m2_time_start m2_ga m2_ga_estimate m2_hiv_status maternal_death_learn maternal_death_learn_other)

	rename (how_you_rate_ur_health_sine_last are_you_still_pregnant_or sever_headaches_since_last_visit viginal_bleed_since_last_visit a_fever_since_last_visit abdominal_pain_since_last_visit breath_difficulty_since_last_vis convulsions_since_last_visit repeated_feinting_since_last_vis baby_stoped_moving_since_last_vi)(m2_201 m2_202 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h)

	rename (since_you_last_spoke_203i preeclapsia_eclampsia_204a bleeding_during_pregnancy_204b hyperemesis_gravidarum_204c anemia_204d cardiac_problem_204e amniotic_fluid_204f asthma_204g rh_isoimmunization_204h other_health_problems_since_last specify_any_other_feeling) (m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_204i_other)

	rename (over_the_past_2_weeks_on_205a over_the_past_2_weeks_205b)(m2_205a m2_205b)
	
	rename (how_often_do_you_currently_206 how_often_do_you_currently_207 how_often_do_you_currently_208 new_healthcare_consult_since_las number_of_healthcare_consultatio health_consultation_1st health_consultation_2nd health_consultation_3rd health_consultation_4th health_consultation_5th) (m2_206 m2_207 m2_208 m2_301 m2_302 m2_303a m2_303b m2_303c m2_303d m2_303e)
	
	rename (facilty_name_and_zone_1st_consul other_facility_for_1st_consult facilty_name_and_zone_2nd_consul other_facility_for_2nd_consult facilty_name_and_zone_3rd_consul other_facility_for_3rd_consult facilty_name_and_zone_4th_consul other_facility_for_4th_consult facilty_name_and_zone_5th_consul other_facility_for_5th_consult) (m2_304a m2_304a_other m2_304b m2_304b_other m2_304c m2_304c_other m2_304d m2_304d_other m2_304e m2_304e_other)
	
	rename (routine_antenatal_care_visit_1st referal_fromantenatal_care_1st_c specify_other_reason_307 routine_antenatal_visit_2nd_cons referal_from_antenatal_2nd_consu other_reason_for_2nd_consult routine_antenatal_care_3rd_consu referral_from_antenatal_3rd_cons other_reason_for_3rd_consult routine_antenatal_care_4th_consu referral_from_antenatal_4th_cons other_reason_for_4th_consult routine_antenatal_care_5th_consu referral_from_antenatal_5th_cons other_reason_for_5th_consult) (m2_305 m2_306 m2_307_other m2_308 m2_309 m2_310_other m2_311 m2_312  m2_313_other m2_314 m2_315 m2_316_other m2_317 m2_318 m2_319_other)

	rename (other_reason_no_more_antenatal_c phone_health_care_provider_conta quality_rate_of_care_1st_consult quality_rate_of_care_2nd_consult quality_rate_of_care_3rd_consult quality_rate_of_care_4th_consult quality_rate_of_care_5th_consult)(m2_320_other m2_321 m2_401 m2_402 m2_403 m2_404 m2_405)
	
	rename (measured_bp_with_a_cuff_501a weight_taken_using_scale_501b taking_blook_draw_from_arm_501c blood_test_using_finger_501d urine_test_peed_container_501e)(m2_501a m2_501b m2_501c m2_501d m2_501e)
	
	rename (ultrasound_test_501f any_other_test_501g specify_any_other_test_taken_501 did_you_receive_any_results_502 which_test_result_did_you_503 have_you_received_test_503b have_you_received_test_503c have_you_received_test_503d have_you_received_test_503e have_you_received_test_503f did_you_receive_any_504 specify_other_test_result)(m2_501f m2_501g m2_501g_other m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_504_other)
	
	rename (what_was_the_result_of_anemia what_was_the_result_of_hiv what_was_the_result_of_hiv_viral what_was_the_result_of_syphilis what_was_the_result_of_diabetes what_was_the_result_of_hyperten what_was_the_result_of_other_tes)(m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_505g)
	
	rename (since_you_last_discuss_sign_506a since_you_last_discuss_birth_pla since_you_last_care_newborn_506c since_you_last_family_plan_506d health_care_provider_tell_new_sy session_of_psychological_508 do_you_know_the_number_session_o how_many_of_these_sessio_508b do_you_know_how_long_visit_508c how_many_minutes_did_this_508c)(m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508b_last m2_508c m2_508d)
	
	rename (a_since_we_last_spoke_did_509a since_we_last_spoke_did_509b since_we_last_spoke_did_509c since_we_last_spoke_did_601a since_we_last_spoke_did_601b since_we_last_spoke_did_601c since_we_last_spoke_did_601d since_we_last_spoke_did_601e since_we_last_spoke_did_601f since_we_last_spoke_did_601g since_we_last_spoke_did_601h since_we_last_spoke_did_601i since_we_last_spoke_did_601j since_we_last_spoke_did_601k since_we_last_spoke_did_601l since_we_last_spoke_did_601m since_we_last_spoke_did_601n specify_other_medicine_sup)(m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601n_other)
	
	rename (how_much_paid_602 in_total_how_much_did_you_602 are_you_currently_taking_603 how_often_do_you_take_604 i_would_now_like_to_ask_ab_701)(m2_602a m2_602b m2_603 m2_604 m2_701)
	
	rename (have_you_spent_money_702a how_much_money_did_you_702a have_you_spent_money_702b how_much_money_did_you_702b have_you_spent_money_702c how_much_money_did_you_702c have_you_spent_money_702d how_much_money_did_you_702d have_you_spent_money_702e how_much_money_did_you_702e so_in_total_you_spent_703 you_know_how_much_704 so_how_much_in_total_would_704)(m2_702a m2_702a_other m2_702b m2_702b_other m2_702c m2_702c_other m2_702d m2_702d_other m2_702e m2_702e_other m2_703 m2_704 m2_704_other)
	
	rename (specify_other_income_sourc m2_time_it_is_interru at_what_time_it_is_restart time_of_interview_end_103b total_duration_of_interv_103c module_2_phone_surveys_prenatal_)(m2_705_other m2_interupt_time m2_restart_time m2_endtime m2_int_duration m2_complete)
	

	* STEP TWO: add value labels 
	** many of these value labels can be found in the "REDCap_STATA.do" file saved in 
	** the same interim data folder. 

	** MODULE 1:
* Label study site values 
label define woreda 1 "Adama special district (town)" 2 "Dugda" 3 "Bora" 4 "Adami Tulu Jido Kombolcha" 5 "Olenchiti" 6 "Adama" 7 "Lume" 96 "Other, specify" 
label values woreda woreda
label define site 1 "Adama" 2 "East Shewa"

* Label Facility Name values 
label define FacilityLabel 1 "Meki Catholic Primary Clinic (01)" 2 "Bote Health Center (02)" 3 "Meki Health Center (03)" 4 "Adami Tulu Health Center (04)" 5 "Bulbula Health Center (05)" 6 "Dubisa Health Center (06)" 7 "Olenchiti Primary Hospital (07)" 8 "Awash Malkasa Health Center (08)" 9 "koka Health Center (09)" 10 "Biyo Health Center (10)" 11 "Ejersa Health Center (11)" 12 "Catholic Church Primary Clinic (12)" 13 "Noh Primary Clinic (13)" 14 "Adama Health Center (14)" 15 "Family Guidance Nazret Specialty Clinic (15)" 16 "Biftu (16)" 17 "Bokushenen (17)" 18 "Adama Teaching Hospital (18)" 19 "Hawas (19)" 20 "Medhanialem Hospital (20)" 21 "Sister Aklisiya Hospital (21)" 22 "Marie stopes Specialty Clinic (22)" 96 "Other in East Shewa or Adama (23)" 
label values facility FacilityLabel

* Label Sampling Strata 
label define strata 1 "Public Primary" 2 "Public Secondary" 3 "Private Primary" 4 "Private Secondary" 

* Label Facility Type values  
label define FacilityTypeLabel 1 "General Hospital" 2 "Primary Hospital" 3 "Health center" 4 "MCH Specialty Clinic/Center" 5 "Primary clinic" 
label values facility_type FacilityTypeLabel 

label define reason_anc 1 "Low cost" 2 "Short distance" 3 "Short waiting time" 4 "Good healthcare provider skills" 5 "Staff shows respect" 6 "Medicines and equipment are available" 7 "Cleaner facility" 8 "Only facility available" 9 "covered by CBHI" 10 "Were referred or told to use this provider" 11 "Covered by other insurance" 96 "Other, specify" 99 "NR/RF" 
label values m1_405 reason_anc


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
	   label values m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_605i m1_605j m1_605k likert
	   	 
   * Label Yes/No 
	 label define YN 1 "Yes" 0 "No" 3 "not applicable" 98 "DK" 99 "RF" 
	 label define YN2 1 "Yes" 2 "No" 98 "DK" 99 "RF" 
	 label values m1_716a m1_716b m1_716c m1_716d m1_716e YN
   	 label values m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 YN 
	 label values m1_813a m1_813b m1_813c m1_813d m1_813e YN
	 label values m1_904 m1_905 m1_907 YN

	 	 
	 * Label values for varaiables with Yes / No responses 
	 label values m1_502 m1_509a m1_509b m1_510a m1_510b m1_514a YN 
	 label values m1_204 YN
	 label values m1_203 YN2
   	 label values m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g YN
	 label values m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i YN
	 label values m1_801 m1_802b YN
	 label values m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i YN
	 label values m1_1004 m1_1005 m1_1006 m1_eth_1_10 m1_1007 m1_1008 m1_1010 YN
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
	label define m2_attempt_outcome 1 "Answered the phone, correct respondent (Start survey)" 2 "Answered but not by the respondent (Go to A4)" 3 "No answer (rings but not response or line was busy)" 4 "Number does not work (does not ring/connect to a phone)" 5 "Phone was switched off"
	label values m2_attempt_outcome m2_attempt_outcome
	
	label define m2_attempt_relationship 1 "Family member" 2 "Friend/Neighbor" 3 "Colleague" 4 "Does not know the respondent" 5 "Other, specify"
	label values m2_attempt_relationship m2_attempt_relationship
	
	label define m2_attempt_avail 1 "Yes" 0 "No"
	label values m2_attempt_avail m2_attempt_avail
	
	label define m2_attempt_contact 1 "Yes" 0 "No"
	label values m2_attempt_contact m2_attempt_contact
	
	label define m2_start 1 "Yes" 0 "No" 
	label values m2_start m2_start
	
	label define m2_permission 1 "Yes" 0 "No" 
	label values m2_permission
	
	label define maternal_death_reported 1 "Yes" 0 "No" 
	label values maternal_death_reported maternal_death_reported
	
	label define m2_hiv_status 1 "Positive" 2 "Negative" 3 "Unknown" 
	label values m2_hiv_status m2_hiv_status
	
	label define maternal_death_learn 1 "Called respondent phone, someone else responded" ///
									  2 "Called spouse/partner phone, was informed" ///
									  3 "Called close friend or family member phone number, was informed" ///
									  4 "Called CHW phone number, was informed" 5 "Other"
	label values maternal_death_learn maternal_death_learn
	
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

*label define any_of_the_following_v_18_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_19_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_20_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_21_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_22_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_23_ 0 "Unchecked" 1 "Checked" 

	label define m2_308 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_308 m2_308

	label define m2_309 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_309 m2_309
	
*label define any_of_the_following_v_26_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_27_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_28_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_29_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_30_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_31_ 0 "Unchecked" 1 "Checked" 

	label define m2_311 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_311 m2_311
 
	label define m2_312 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_312 m2_312
	
*label define any_of_the_following_v_34_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_35_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_36_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_37_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_38_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_39_ 0 "Unchecked" 1 "Checked" 

	label define m2_314 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"  
	label values m2_314 m2_314
	
	label define m2_315 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_315 m2_315

*label define any_of_the_following_v_42_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_43_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_44_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_45_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_46_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_47_ 0 "Unchecked" 1 "Checked" 

	label define m2_317 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"
	label values m2_317 m2_317

	label define m2_318 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_318 m2_318 

*label define any_of_the_following_v_50_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_51_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_52_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_53_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_54_ 0 "Unchecked" 1 "Checked" 
*label define any_of_the_following_v_55_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_56_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_57_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_58_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_59_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_60_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_61_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_62_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_63_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_64_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_65_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_66_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_67_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_68_ 0 "Unchecked" 1 "Checked" 
*label define prevent_more_antenat_v_69_ 0 "Unchecked" 1 "Checked" 

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
	
*label define which_of_the_followi_v_92_ 0 "Unchecked" 1 "Checked" 
*label define which_of_the_followi_v_93_ 0 "Unchecked" 1 "Checked" 
*label define which_of_the_followi_v_94_ 0 "Unchecked" 1 "Checked" 
*label define which_of_the_followi_v_95_ 0 "Unchecked" 1 "Checked" 
*label define which_of_the_followi_v_96_ 0 "Unchecked" 1 "Checked" 
*label define which_of_the_followi_v_97_ 0 "Unchecked" 1 "Checked" 
*label define which_of_the_followi_v_98_ 0 "Unchecked" 1 "Checked" 
label define m2_interview_inturrupt 1 "Yes" 0 "No" 
label values m2_interview_inturrupt m2_interview_inturrupt

label define m2_interview_restarted_ 1 "Yes" 0 "No" 
label values m2_interview_restarted m2_interview_restarted

label define m2_endstatus 1 "Active follow-up" 2 "Lost to follow-up" 3 "Decline further participation" 4 "Maternal death" 5 "No longer pregnant"
label values m2_endstatus m2_endstatus

label define m2_complete 0 "Incomplete" 1 "Unverified" 2 "Complete" 
label values m2_complete m2_complete

	
*STEP FOUR: RECODING MISSING VALUES 
	* Recode refused and don't know values
	* Note: .a means NA, .r means refused, .d is don't know, . is missing 
	* Need to figure out a way to clean up string "text" only vars (ex. 803)

	** MODULE 1:
	recode mobile_phone kebele_malaria kebele_intworm m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g m1_203 m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b m1_401 m1_404 m1_405 m1_501 m1_503 m1_504 m1_505 m1_506 m1_507 m1_601 m1_602 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_605i m1_605j m1_605k m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_805 m1_806 m1_807 m1_810a m1_810b m1_813a m1_813b m1_813c m1_813d m1_813e m1_eth_1_8a m1_eth_1_8b m1_eth_1_8c m1_eth_1_8d m1_eth_1_8e m1_eth_1_8f m1_eth_1_8g m1_eth_2_8 m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i m1_816 m1_901 m1_902 m1_903 m1_904 m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_eth_1_10 m1_1007 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1103 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1217 m1_1221 m1_1222 m1_1223 (99 = .r)

	recode m1_401 m1_404 m1_501 m1_506 m1_507 m1_509b m1_510b m1_511 m1_512 m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_805 m1_806 m1_807 m1_809 m1_810a m1_810b m1_811 m1_812a m1_813a m1_813b m1_813c m1_813d m1_813e m1_eth_1_8a m1_eth_1_8b m1_eth_1_8c m1_eth_1_8d m1_eth_1_8e m1_eth_1_8f m1_eth_1_8g m1_eth_2_8 m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_814i m1_816 m1_901 m1_902 m1_903 m1_904 m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_eth_1_10 m1_1007 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1105 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1218a m1_1218b m1_1218c m1_1218d m1_1218e m1_1218f m1_1221 m1_1223 m1_804 (98 = .d)

	** MODULE 2:
	recode m2_301 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_205c m2_205d m2_205e m2_205f m2_205g m2_205h m2_205i m2_206 m2_207 m2_208 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508c m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_704 (99 = .r)
	
	recode m2_201 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_203i m2_204a m2_204b m2_204c m2_204d m2_204e m2_204f m2_204g m2_204h m2_204i m2_206 m2_207 m2_208 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_315 m2_317 m2_318 m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_502 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_504 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_506a m2_506b m2_506c m2_506d m2_507 m2_508a m2_508b_number m2_508c m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_602a m2_603 m2_604 m2_701 m2_702a m2_702b m2_702c m2_702d m2_702e m2_704 (98 = .d)

* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns

* MODULE 1:
* Kept these recode commands here even though everyone has given permission 
recode care_self (. = .a) if permission == 0
recode age (. = .a) if permission == 0
recode zone_live (. = .a) if age>15 
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
* SS: Fix in redcap to make a number
*recode m1_714d (. = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r
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

* SS: double check this skip pattern
* Need to recode  q803gaself text "DK" = .d
recode m1_804 (. = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d | m1_801 == .r) & (m1_802b == 0 | m1_802b == .) & (m1_803 == "98" |  m1_803 == "Dk" | m1_803 == "") 

recode there_are_many_reasons_why_808__ (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v204 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v205 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v206 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v207 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v208 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v209 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v210 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v211 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v212 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v213 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v214 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v215 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v216 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d
recode v217 (0 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a | m1_804 == .d

* SS: Fix in redcap to add this skip pattern
recode m1_812b (. = .a) (0 = .a) if m1_812a == 0 | m1_812a ==. | m1_812a == .d 

recode m1_813e (. = .a) if (m1_813a == 0 | m1_813a == .d | m1_813a == .r) & (m1_813b == 0 | ///
	   m1_813b == .d | m1_813b == .r) & (m1_813c == 0 | m1_813c == .d | m1_813c == .r) & ///
	   (m1_813d == 0 | m1_813d == .d | m1_813d == .r)

recode m1_eth_2_8 (. = .a) if (m1_eth_1_8a == 0 | m1_eth_1_8a == .d | m1_eth_1_8a == .r) & ///
	   (m1_eth_1_8b == 0 | m1_eth_1_8b == .d | m1_eth_1_8b == .r) & ///
	   (m1_eth_1_8c == 0 | m1_eth_1_8c == .d | m1_eth_1_8c == .r) & ///
	   (m1_eth_1_8d == 0 | m1_eth_1_8d == .d | m1_eth_1_8d == .r) & ///
	   (m1_eth_1_8e == 0 | m1_eth_1_8e == .d | m1_eth_1_8e == .r) & ///
	   (m1_eth_1_8f == 0 | m1_eth_1_8f == .d | m1_eth_1_8f == .r) & ///
	   (m1_eth_1_8g == 0 | m1_eth_1_8g == .d | m1_eth_1_8g == .r)

recode m1_814h (. = .a) if m1_804 == 1	| m1_804 == 2 | m1_804 == . | m1_804 == .a | m1_804 == .d								   			   
recode provider_tell_you_to_do_regardin (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
													(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
													(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
													(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
													(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
													(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
													(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
													(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
													(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
   							   
recode provider_tell_you_to_do_regardin (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
												   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
												   m1_814i == 1
													
recode v259 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v259 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode v260 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v260 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode v261 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v261 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode v262 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v262 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
													
recode v263 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v263 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode v264 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v264 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	
													
recode v265 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v265 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	
													
recode v266 (0 = .a) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v266 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode v267 (0 = .d) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v267 (0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1	

recode v268 (0 = .r) if (m1_814a == 0 | m1_814a == .d | m1_814a == .r | m1_814a == .) & ///
						(m1_814b == 0 | m1_814b == .d | m1_814b == .r | m1_814b == .) & ///
						(m1_814c == 0 | m1_814c == .d | m1_814c == .r | m1_814c == .) & ///
						(m1_814d == 0 | m1_814d == .d | m1_814d == .r | m1_814d == .) & ///
						(m1_814e == 0 | m1_814e == .d | m1_814e == .r | m1_814e == .) & ///
						(m1_814f == 0 | m1_814f == .d | m1_814f == .r | m1_814f == .) & ///
						(m1_814g == 0 | m1_814g == .d | m1_814g == .r | m1_814g == .) & ///
						(m1_814h == 0 | m1_814h == .d | m1_814h == .r | m1_814h == . | m1_814h == .a) & ///
						(m1_814i == 0 | m1_814i == .d | m1_814i == .r | m1_814i == .)
													
recode v268(0 = .) if m1_814a == 1 | m1_814b ==1 | m1_814c == 1 | m1_814d == 1 | ///
					   m1_814e == 1 | m1_814f == 1 | m1_814g == 1 | m1_814h == 1 | ///
					   m1_814i == 1
				
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

recode m1_eth_1_10 (. = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

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

recode who_has_done_these_things_1102__ (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode who_has_done_these_things_1102__ (0 = .) if m1_1101 == 1
recode v297 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v297 (0 = .) if m1_1101 == 1
recode v298 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v298 (0 = .) if m1_1101 == 1
recode v299 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v299 (0 = .) if m1_1101 == 1
recode v300 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v300 (0 = .) if m1_1101 == 1
recode v301 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v301 (0 = .) if m1_1101 == 1
recode v302 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v302 (0 = .) if m1_1101 == 1
recode v303 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v303 (0 = .) if m1_1101 == 1
recode v304 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v304 (0 = .) if m1_1101 == 1
recode v305 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v305 (0 = .) if m1_1101 == 1
recode v306 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v306 (0 = .) if m1_1101 == 1
recode v307 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v307 (0 = .) if m1_1101 == 1
recode v308 (0 = .a) if m1_1101 == 0 | m1_1101 == . | m1_1101 == .r
recode v308 (0 = .) if m1_1101 == 1

recode who_has_done_these_things_1104__ (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode who_has_done_these_things_1104__ (0 = .) if m1_1103 == 1
recode v312 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v312 (0 = .) if m1_1103 == 1
recode v313 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v313 (0 = .) if m1_1103 == 1
recode v314 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v314 (0 = .) if m1_1103 == 1
recode v315 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v315 (0 = .) if m1_1103 == 1
recode v316 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v316 (0 = .) if m1_1103 == 1
recode v317 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v317 (0 = .) if m1_1103 == 1
recode v318 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v318 (0 = .) if m1_1103 == 1
recode v319 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v319 (0 = .) if m1_1103 == 1
recode v320 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v320 (0 = .) if m1_1103 == 1
recode v321 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v321 (0 = .) if m1_1103 == 1
recode v322 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v322 (0 = .) if m1_1103 == 1
recode v323 (0 = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .r
recode v323 (0 = .) if m1_1103 == 1

recode m1_1105 (. = .a) if (m1_1101 == 0 | m1_1101 == . | m1_1101 == .r) & (m1_1103 == 0 | m1_1103 == . | m1_1103 == .r)

recode m1_1218a (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218a_1 (. = .a) if m1_1218a == 0 | m1_1218a == .a

recode m1_1218b (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r

* SS: Need to fix variable in redcap, this is a string var:
* recode m1_1218b_1 (. = .a) if m1_1218b == 0 | m1_1218b == .a 

recode m1_1218c (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218c_1 (. = .a) if m1_1218c == 0 | m1_1218c == .a

recode m1_1218d (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218d_1 (. = .a) if m1_1218d == 0 | m1_1218d == .a

recode m1_1218e (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218e_1 (. = .a) if m1_1218e == 0 | m1_1218e == .a

recode m1_1218f (. = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode m1_1218f_1 (. = .a) if m1_1218f == 0 | m1_1218f == .a

recode m1_1219 (. = .a) if m1_1218a_1 == .a & m1_1218b_1 == "" & m1_1218c_1 ==.a & ///
						   m1_1218d_1 == .a & m1_1218e_1 == .a & m1_1218f_1 == .a
    
recode financial_source_for_the_spent_1 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode financial_source_for_the_spent_1 (0 = .) if m1_1217 == 1
recode v364 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode v364 (0 = .) if m1_1217 == 1
recode v365 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode v365 (0 = .) if m1_1217 == 1
recode v366 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode v366 (0 = .) if m1_1217 == 1
recode v367 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode v367 (0 = .) if m1_1217 == 1
recode v368 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode v368 (0 = .) if m1_1217 == 1
recode v369 (0 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r
recode v369 (0 = .) if m1_1217 == 1

recode 	m1_1222 (. = .a) if m1_1221 == 0 | m1_1221 == .

* SS: Fix
* recode m1_1307 (. = .a) if m1_1306 == 0 | m1_1306 == 96 | m1_1306 == . 

recode m1_1308 (. = .a) if m1_1306 == 1 | m1_1306 == 96 | m1_1306 == .

recode m1_1309 (. = .a) if m1_1308 == 0 | m1_1308 == . | m1_1308 == .a

	** MODULE 2:
recode m2_attempt_relationship (. = .a) if m2_attempt_outcome == 1 | m2_attempt_outcome == 3 | m2_attempt_outcome == 4 | m2_attempt_outcome == 5

recode m2_attempt_avail (. = .a) if m2_attempt_relationship == 4 | m2_attempt_relationship == . | m2_attempt_relationship == .a

recode m2_attempt_contact (. = .a) if m2_attempt_avail == 0 | m2_attempt_avail == . | m2_attempt_avail == .a

recode m2_start (. = .a) if m2_attempt_outcome == 2 |  m2_attempt_outcome == 3 | m2_attempt_outcome == 4 | m2_attempt_outcome == 5 | m2_attempt_avail == 0

recode m2_permission (. = .a) if m2_start == 0
recode maternal_death_reported (. = .a) if m2_permission==0

recode m2_hiv_status (. = .a) if maternal_death_reported == 1 | m1_708b == 1

* SS: Fix
* recode date_of_maternal_death (. = .a) if maternal_death_reported == 0

recode maternal_death_learn (. = .a) if maternal_death_reported == 0

recode maternal_death_learn_other (. = .a) if maternal_death_learn == 1 | maternal_death_learn == 2 | maternal_death_learn == 3 | maternal_death_learn == 4

recode m2_201 m2_202 (. = .a) if maternal_death_reported == 2 | maternal_death_reported == 3

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

recode any_of_the_following_1st_consult (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode any_of_the_following_1st_consult (0 = .) if m2_306 == 0

recode v480 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode v480 (0 = .) if m2_306 == 0

recode v481 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode v481 (0 = .) if m2_306 == 0

recode v482 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode v482 (0 = .) if m2_306 == 0

recode v483 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode v483 (0 = .) if m2_306 == 0

recode v484 (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode v484 (0 = .) if m2_306 == 0

recode m2_308 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a

recode m2_309 (. = .a) if m2_308 == 1 | m2_308 == 98 | m2_308 == 99

recode any_of_the_following_2nd_consult (0 = .a) if m2_306 == 1 | m2_306 == 98 | m2_306 == 99
recode any_of_the_following_2nd_consult (0 = .) if m2_306 == 0

recode v489 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode v489 (0 = .) if m2_309 == 0

recode v490 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode v490 (0 = .) if m2_309 == 0

recode v491 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode v491 (0 = .) if m2_309 == 0

recode v492 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode v492 (0 = .) if m2_309 == 0

recode v493 (0 = .a) if m2_309 == 1 | m2_309 == 98 | m2_309 == 99
recode v493 (0 = .) if m2_309 == 0

* SS: Fix
* recode m2_310_other (. = .a) if v489 ==1

recode m2_311 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2

recode m2_312 (. = .a) if m2_311 == 1 | m2_311 == 98 | m2_311 == 99

recode any_of_the_following_3rd_consult (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode any_of_the_following_3rd_consult (0 = .) if m2_312 == 0

recode v498 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode v498 (0 = .) if m2_312 == 0

recode v499 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode v499 (0 = .) if m2_312 == 0

recode v500 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode v500 (0 = .) if m2_312 == 0

recode v501 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode v501 (0 = .) if m2_312 == 0

recode v502 (0 = .a) if m2_312 == 1 | m2_312 == 98 | m2_312 == 99
recode v502 (0 = .) if m2_312 == 0

recode m2_314 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3

recode m2_315 (. = .a) if m2_314 == 1 | m2_314 == 98 | m2_314 == 99

recode any_of_the_following_4th_consult (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode any_of_the_following_4th_consult (0 = .) if m2_315 == 0

recode v507 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode v507 (0 = .) if m2_315 == 0

recode v508 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode v508 (0 = .) if m2_315 == 0

recode v509 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode v509 (0 = .) if m2_315 == 0

recode v510 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode v510 (0 = .) if m2_315 == 0

recode v511 (0 = .a) if m2_315 == 1 | m2_315 == 98 | m2_315 == 99
recode v511 (0 = .) if m2_315 == 0

* SS: Fix
* recode m2_316_other (. = .a) if v507 == 1

recode m2_317 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3 | m2_302 == 4
recode m2_318 (. = .a) if m2_317 == 1 | m2_317 == 98 | m2_317 == 99

recode any_of_the_following_5th_consult (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode any_of_the_following_5th_consult (0 = .) if m2_318 == 0

recode v516 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode v516 (0 = .) if m2_318 == 0

recode v517 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode v517 (0 = .) if m2_318 == 0

recode v518 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode v518 (0 = .) if m2_318 == 0

recode v519 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode v519 (0 = .) if m2_318 == 0

recode v520 (0 = .a) if m2_318 == 1 | m2_318 == 98 | m2_318 == 99
recode v520 (0 = .) if m2_318 == 0

recode m2_319_other (. = .a) if v516 == 1

recode prevent_more_antenatal_care_320_ (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode prevent_more_antenatal_care_320_ (0 = .) if m2_202 == 1 & m2_301 == 0

recode v523 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v523 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v524 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v524 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v525 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v525 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v526 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v526 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v527 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v527 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v528 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v528 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v529 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v529 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v530 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v530 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v531 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v531 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v532 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v532 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v533 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v533 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v534 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v534 (0 = .) if m2_202 == 1 & m2_301 == 0

recode v535 (0 = .a) if m2_202 == 0 | m2_202 == 98 | m2_202 == 99 | m2_301 == 1 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a
recode v535 (0 = .) if m2_202 == 1 & m2_301 == 0


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

recode which_of_the_following_fin_705__ (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode which_of_the_following_fin_705__ (0 = .) if m2_701 == 1

recode v614 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode v614 (0 = .) if m2_701 == 1

recode v615 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode v615 (0 = .) if m2_701 == 1

recode v616 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode v616 (0 = .) if m2_701 == 1

recode v617 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode v617 (0 = .) if m2_701 == 1

recode v618 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode v618 (0 = .) if m2_701 == 1

recode v619 (0 = .a) if m2_701 == 0 | m2_701 == 98 | m2_701 == 99 | m2_701 ==. | m2_701 == .a
recode v619 (0 = .) if m2_701 == 1

recode m2_interview_inturrupt (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 
 
recode m2_interview_restarted (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a  | m2_interview_inturrupt == 0 | m2_interview_inturrupt == . | m2_interview_inturrupt == .a

recode m2_int_duration (. = .a) if m2_permission == 0 | m2_permission == . | m2_permission == .a | m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a 

recode m2_endstatus (. = .a) if m2_endtime == ""

					   
	* STEP FIVE: LABELING VARIABLES (for sumtab command)
label variable record_id "Record ID"
label variable event "Event Name"
label variable redcap_repeat_instrument "Repeat Instrument"
label variable redcap_repeat_instance "Repeat Instance"
label variable redcap_data_access_group "Data Access Group"
label variable study_id "Study ID"
label variable interviewer_id "Interviewer ID"

	** MODULE 1:		

lab var date_m1 "A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var woreda "A4. Study site"
lab var woreda_other "A4_Other. Specify other study site"
lab var facility "A5. Facility name"
lab var facility_other "A5_Other. Specify other facility name"
lab var facility_type "A5. Facility type"
lab var interviewer_name_a7 "A7. Interviewer Name"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var age "B3. How old are you?"
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
lab var kebele_malaria "Eth-1-1 Interviewer check whether the area that the woman living is malarias or not? "
lab var kebele_intworm "Eth-2-1. Interviewer check whether the area that the woman living is endemic for intestinal worm or not?"
lab var m1_201 "201. In general, how would you rate your overall health?"
lab var m1_202a "202.a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202.b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202.c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202.d BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202.e BEFORE you got pregnant, did you know that you had HIV?"
lab var m1_202f "202f. BEFORE you got pregnant, did you know that you had Hepatitis B?"
lab var m1_202g "202g. BEFORE you got pregnant, did you know that you had Renal disorder? "
lab var m1_203 "203. Before you got pregnant, were you diagnosed with any other major health problems?"
lab var m1_203_other "203_Other. Specify the diagnosis health problem"
lab var m1_204 "204. Are you currently taking any medications?"
lab var m1_205a "205A. I am going to read three statements about your mobility, by which I mean your ability to walk around. Please indicate which statement best describe your own health state today?"
lab var m1_205b "205B. I am now going to read three statements regarding your ability to self-care, by which I mean whether you can wash and dress yourself without assistance. Please indicate which statement best describe your own health state today"
lab var m1_205c "205C. I am going to read three statements regarding your ability to perform your usual daily activities, by which I mean your ability to work, take care of your family or perform leisure activities. Please indicate which statement best describe your own health state today."
lab var m1_205d "205D. I am going to read three statements regarding your experience with physical pain or discomfort. Please indicate which statement best describe your own health state today"
lab var m1_205e "205E. I am going to read three statements regarding your experience with anxiety or depression. Please indicate which statements best describe your own health state today"
lab var phq9a "206A. Over the past 2 weeks, how many days have you been bothered by little interest or pleasure in doing things?"
lab var phq9b "206B. Over the past 2 weeks, on how many days have you been bothered by feeling down, depressed, or hopeless ?"
lab var phq9c "206C. Over the past 2 weeks, on how many days have you been bothered by trouble falling or staying asleep, or sleeping too much?"
lab var phq9d "206D. Over the past 2 weeks, on how many days have you been bothered by feeling tired or having little energy"
lab var phq9e "206E. Over the past 2 weeks, on how many days have you been bothered by poor appetite or overeating"
lab var phq9f "206F. Over the past 2 weeks, on how many days have you been bothered by feeling bad about yourself or that you are a failure or have let yourself or your family down? "
lab var phq9g "206G. Over the past 2 weeks, on how many days have you been bothered by trouble concentrating on things, such as your work or home duties?"
lab var phq9h "206H. Over the past 2 weeks, on how many days have you been bothered by moving or speaking so slowly that other people could have noticed? Or so fidgety or restless that you have been moving a lot more than usual?"
lab var phq9i "206I. Over the past 2 weeks, on how many days have you been bothered by Thoughts that you would be better off dead, or thoughts of hurting yourself in some way?"
lab var m1_207 "207. Over the past 2 weeks, on how many days did health problems affect your productivity while you were working? Work may include formal employment, a business, sales or farming, but also work you do around the house, childcare, or studying. Think about days you were limited in the amount or kind of work you could do, days you accomplished less than you would like, or days you could not do your work as carefully as usual."
lab var m1_301 "301. How would you rate the overall quality of medical care in Ethiopia?"
lab var m1_302 "302. Overall view of the health care system in your country"
lab var m1_303 "303. Confidence that you would receive good quality healthcare from the health system if you got very sick?"
lab var m1_304 "304. Confidence you would be able to afford the healthcare you needed if you became very sick?"
lab var m1_305a "305.A. Confidence that you that you are the person who is responsible for managing your overall health?"
lab var m1_305b "305.B. Confidence that you that you can tell a healthcare provider concerns you have even when he or she does not ask "
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
lab var m1_519a "519a. Where will your district be after this date "
lab var m1_519b "519b. Where will your kebele be after this date"
lab var m1_519c "519c. Where will your village be after this date"
lab var m1_601 "601. Overall how would you rate the quality of care you received today?"
lab var m1_602 "602. How likely are you to recommend this facility or provider to a family member or friend to receive care for their pregnancy?"
lab var m1_603 "603. How long in minutes did you spend with the health provider today?"
lab var m1_604a "604. How long in minutes did you wait between the time you arrived at this facility and the time you were able to see a provider for the consultation?"
lab var m1_604b "Eth-1-6-1. How long in hours did you spend at this facility today for all aspects of your care, including wait time, the consultation, and any other components of your care today?"
lab var m1_604c "Eth-1-6.2. How long in hours did you spend at this facility today for all aspects of your care, including wait time, the consultation, and any other components of your care today?"
lab var m1_605a "605a. How would you rate the knowledge and skills of your provider?"
lab var m1_605b "605b. How would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab?"
lab var m1_605c "605c. How would you rate the level of respect the provider showed you?"
lab var m1_605d "605d. How would you rate the clarity of the provider's explanations?"
lab var m1_605e "605e. How would you rate the degree to which the provider involved you as much as you wanted to be in decisions about your care?"
lab var m1_605f "605f. How would you rate the amount of time the provider spent with you?"
lab var m1_605g "605g. How would you rate the amount of time you waited before being seen?"
lab var m1_605h "605h. How would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider?"
lab var m1_605i "605i. How would you rate the confidentiality of care or diagnosis?"
lab var m1_605j "605j. How would you rate the privacy (Auditory or visual)?"
lab var m1_605k "605k. How would you rate the affordability of charge or bill to the service?"
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
lab var m1_802b "802b. Do you know your last normal menstrual period?"
lab var m1_802c "802c. What is the date of your last normal menstrual period"
lab var m1_802d "802d. Gestational age in weeks based on LNMP"
lab var m1_803 "803. How many weeks pregnant do you think you are?"
lab var m1_804 "804. Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)."
lab var m1_805 "805. How many babies are you pregnant with?"
lab var m1_806 "806. During the visit today, did the healthcare provider ask when you had your last period, or not?"
lab var m1_807 "807. When you got pregnant, did you want to get pregnant at that time?"
lab var there_are_many_reasons_why_808__ "808. Didn't realize you were pregnant"
lab var v204 "808. Tried to come earlier and were sent away"
lab var v205 "808. You received care at home"
lab var v206 "808. High cost (e.g., high out of pocket payment, not covered by insurance)"
lab var v207 "808. Far distance (e.g., too far to walk or drive, transport not readily available)"
lab var v208 "808. Long waiting time (e.g., long line to access facility, long wait for the provider)"
lab var v209 "808. Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
lab var v210 "808. Staff don't show respect (e.g., staff is rude, impolite, dismissive) "
lab var v211 "808. Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
lab var v212 "808. COVID-19 fear"
lab var v213 "808. Don't know where to go (e.g., too complicated)"
lab var v214 "808. Fear of discovering serious problems"
lab var v215 "808. Do not know advantage of early coming"
lab var v216 "808. Other, specify"
lab var v217 "808. NR/RF"
lab var m1_808_other "808_Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_810_other "810b_Other. Other than the list above, specify"
lab var m1_811 "811. Do you plan to stay at a maternity waiting home before delivering your baby?"
lab var m1_812a "812a. During the visit today, did the provider tell you that you might need a C-section?"
lab var m1_812b "812b.0. Have you told the reason why you might need a c-section?"
lab var why_you_might_need_c_section_812 "812b. Because I had a c-section before"
lab var v227 "812b. Because I am pregnant with more than one baby"
lab var v228 "812b. Because of the baby's position"
lab var v229 "812b. Because of the position of the placenta"
lab var v230 "812b. Because I have health problems"
lab var v231 "812b. Other, specify"
lab var v232 "812b. DK"
lab var v233 "812b. NR/RF"
lab var m1_812_other "812_Other. Specify other reason for C-section"
lab var m1_813a "813a. Some women experience common health problems during pregnancy. Did you experience nausea in your pregnancy so far, or not?"
lab var m1_813b "813b. Some women experience common health problems during pregnancy. Did you experience heartburn in your pregnancy so far, or not?"
lab var m1_813c "813c. Some women experience common health problems during pregnancy. Did you experience leg cramps in your pregnancy so far, or not?"
lab var m1_813d "813d. Some women experience common health problems during pregnancy. Did you experience back pain in your pregnancy so far, or not?"
lab var m1_813e "813e. During the visit today did the provider give you treatment or advice for addressing these kinds of problems?"
lab var m1_eth_1_8a "Eth-1-8a. Did you experience Preeclampsia / Eclampsia in your pregnancy so far, or not?"
lab var m1_eth_1_8b "Eth-1-8b. Some women experience medical and obstetric health problems during pregnancy. Did you experience Hyperemesis gravidarum during pregnancy in your pregnancy so far, or not?"
lab var m1_eth_1_8c "Eth-1-8c. Some women experience medical and obstetric health problems during pregnancy. Did you experience Anemia during pregnancy in your pregnancy so far, or not?"
lab var m1_eth_1_8d "Eth-1-8d. Some women experience medical and obstetric health problems during pregnancy. Did you experience Amniotic fluid volume problems (Oligohydramnios / Polyhydramnios) during pregnancy in your pregnancy so far, or not?"
lab var m1_eth_1_8e "Eth-1-8e. Some women experience medical and obstetric health problems during pregnancy. Did you experience Asthma during pregnancy in your pregnancy so far, or not?"
lab var m1_eth_1_8f "Eth-1-8f. Some women experience medical and obstetric health problems during pregnancy. Did you experience RH isoimmunization during pregnancy in your pregnancy so far, or not?"
lab var m1_eth_1_8g "Eth - 1 - 8g. Any other pregnancy problem"
lab var m1_eth_1_8gother "Eth-1-8g_Other. Specify any other experience in your pregnancy so far"
lab var m1_eth_2_8 "Eth-2-8. During the visit today, did the provider give you a treatment or advice for addressing these kinds of problems?"
lab var m1_814a "814a. Could you please tell me if you have experienced Severe or persistent headaches in your pregnancy so far, or not?"
lab var m1_814b "814b. Could you please tell me if you have experienced Vaginal bleeding of any amount in your pregnancy so far, or not?"
lab var m1_814c "814c. Could you please tell me if you have experienced a fever in your pregnancy so far, or not?"
lab var m1_814d "814d. Could you please tell me if you have experienced Severe abdominal pain, not just discomfort in your pregnancy so far, or not?"
lab var m1_814e "814e. Could you please tell me if you have experienced a lot of difficulty breathing even when you are resting in your pregnancy so far, or not?"
lab var m1_814f "814f. Could you please tell me if you have experienced Convulsions or seizures in your pregnancy so far, or not?"
lab var m1_814g "814g. Could you please tell me if you have experienced repeated fainting or loss of consciousness in your pregnancy so far, or not?"
lab var m1_814h "814h. Could you please tell me if you have experienced noticing that the baby has completely stopped moving in your pregnancy so far, or not?"
lab var m1_814i "814i. Could you please tell me if you have experienced blurring of vision in your pregnancy so far, or not?"
lab var provider_tell_you_to_do_regardin "815. Nothing, we did not discuss this"
lab var v259 "815.Told me to come back to this health facility"
lab var v260 "815.They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var v261 "815.They provided a treatment in the visit"
lab var v262 "815. They prescribed a medication"
lab var v263 "815. They told you to come back to this health facility "
lab var v264 "815. They told you to go somewhere else for higher level care"
lab var v265 "815. They told you to wait and see"
lab var v266 "815. Other (specify)"
lab var v267 "815. DK"
lab var v268 "815. NR/RF"
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
lab var m1_eth_1_10 "Eth-1-10. Have you ever had a baby born with a congenital anomaly? I mean a neural tube defect"
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
lab var who_has_done_these_things_1102__ "1102. Current husband / partner"
lab var v297 "1102. Parent (Mother; Father, step-parent, in-law)"
lab var v298 "1102. Sibling"
lab var v299 "1102. Child"
lab var v300 "1102. Late /last / ex-husband/partner"
lab var v301 "1102. Other relative"
lab var v302 "1102. Friend /acquaintance/"
lab var v303 "1102. Teacher"
lab var v304 "1102. Employer"
lab var v305 "1102. Stranger"
lab var v306 "1102. Other, specify"
lab var v307 "1102. DK"
lab var v308 "1102. NR/RF"
lab var m1_1102_other "1102_Oth. Specify who else hit, kick, slapped, ... you"
lab var m1_1103 "1103. At any point during your current pregnancy, has anyone ever said or done something to humiliate you, insulted you or made you feel bad about yourself?"
lab var who_has_done_these_things_1104__ "1104. Current husband / partner"
lab var v312 "1104. Parent (Mother; Father, step-parent, in-law)"
lab var v313 "1104. Sibling"
lab var v314 "1104. Child"
lab var v315 "1104. Late /last / ex-husband/partner"
lab var v316 "1104. Other relative"
lab var v317 "1104. Friend /acquaintance"
lab var v318 "1104. Teacher"
lab var v319 "1104. Employer"
lab var v320 "1104. Stranger"
lab var v321 "1104. Other (specify)"
lab var v322 "1104. DF"
lab var v323 "1104. NR/RF"
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
lab var financial_source_for_the_spent_1 "1220. Current income of any household members"
lab var v364 "1220. Saving(bank account"
lab var v365 "1220. Payment or reimbursement from a health insurance plan"
lab var v366 "1220. Sold items (e.g. furniture, animals, jewellery, furniture)"
lab var v367 "1220. Family members or friends from outside the household"
lab var v368 "1220. Borrowed (from someone other than a friend or family)"
lab var v369 "1220. Other (specify)"
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
lab var m1_1402___1 "1402. Which is the best phone number to use to contact you: The phone provided for the study"
lab var m1_1402___2 "1402. Which is the best phone number to use to contact you: Primary personal phone"
lab var m1_1402___3 "1402. Which is the best phone number to use to contact you: Secondary personal phone"
lab var m1_1402___4 "1402. Which is the best phone number to use to contact you: Spouse or partner phone"
lab var m1_1402___5 "1402. Which is the best phone number to use to contact you: Community health worker phone"
lab var m1_1402___6 "1402. Which is the best phone number to use to contact you: Friend or other family member phone 1 "
lab var m1_1402___7 "1402. Which is the best phone number to use to contact you: Friend or other family member phone 2"
lab var m1_1402___8 "1402. Which is the best phone number to use to contact you: Other phone"
lab var m1_1402___9 "1402. Which is the best phone number to use to contact you: Does not have any phone numbers"
lab var m1_end_time "Interview end time"
lab var interview_length "Total Duration of interview"
lab var m1_complete "Complete?"


	** MODULE 2:
label variable m2_attempt_date "CALL TRACKING: What is the date of this attempt?"
label variable m2_attempt_outcome "CALL TRACKING: What was the outcome of the call?"
label variable m2_attempt_relationship "Interviewer read: Hello, my name is [your name] and I work with EPHI, I would like to talk with [what_is_your_first_name_101] [what_is_your_family_name_102]. A6. May I Know what the relationship between you and [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m2_attempt_other "CALL TRACKING:  Specify other relationship with the respondent"
label variable m2_attempt_avail "CALL TRACKING:  Is [what_is_your_first_name_101] [what_is_your_family_name_102] nearby and available to speak now?   Can you pass the phone to them?"
label variable m2_attempt_contact "CALL TRACKING:   Is this still the best contact to reach [what_is_your_first_name_101] [what_is_your_family_name_102]?"
label variable m2_attempt_bestnumber "CALL TRACKING:  Could you please share the best number to contact [what_is_your_first_name_101] [what_is_your_family_name_102]"
label variable m2_attempt_goodtime "CALL TRACKING:  Do you know when would be a good time to reach [what_is_your_first_name_101] [what_is_your_family_name_102]?"

label variable m2_start "IIC. May I proceed with the interview? "
label variable m2_permission "CR1. Permission granted to conduct call"
label variable m2_date "102. Date of interview (D-M-Y)"
label variable m2_time_start "103A. Time of interview started"
label variable maternal_death_reported "108. Maternal death reported"
label variable m2_ga "107a. Gestational age at this call based on LNMP (in weeks)"
label variable m2_ga_estimate "107b. Gestational age based on maternal estimation (in weeks)"
label variable m2_hiv_status "109. HIV status"
label variable date_of_maternal_death "110. Date of maternal death (D-M-Y)"
label variable maternal_death_learn "111. How did you learn about the maternal death?"
label variable maternal_death_learn_other "111-Oth. Specify other way of learning maternal death"

label variable m2_201 "201. I would like to start by asking about your health and how you have been feeling since you last spoke to us. In general, how would you rate your overall health?"

label variable m2_202 "202. As you know, this survey is about health care that women receive during pregnancy, delivery and after birth. So that I know that I am asking the right questions, I need to confirm whether you are still pregnant?"

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

/*
label variable any_of_the_following_v_18 "307. Was the first consultation is for any of the following? Include all that apply /  ይህ የመጀመሪያ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee (choice=A new health problem, including an emergency or an injury / አዲስ የጤና እክል፤ድንገተኛ ህመም ወይም አደጋጨምሮ / Rakkoo fayyaa haaraa, balaa tasaa yookaan miidhaa qaamaa)"
label variable any_of_the_following_v_19 "307. Was the first consultation is for any of the following? Include all that apply /  ይህ የመጀመሪያ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee (choice=An existing health problem / በፊትም የነበረ የጤና እክል / Rakkoo fayyaa jiru)"
label variable any_of_the_following_v_20 "307. Was the first consultation is for any of the following? Include all that apply /  ይህ የመጀመሪያ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee (choice=A lab test, x-ray, or ultrasound / ለላቦራቶሪ ምርመራ ፤ራጅ፤አልትራሳውንድ / Qoannoo laabiraatorii, x-reeyii yookaan altiraasaawundii)"
label variable any_of_the_following_v_21 "307. Was the first consultation is for any of the following? Include all that apply /  ይህ የመጀመሪያ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee (choice=To pick up medicine / መድሀኒት ለመውሰድ / Qoricha fudhachuuf)"
label variable any_of_the_following_v_22 "307. Was the first consultation is for any of the following? Include all that apply /  ይህ የመጀመሪያ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee (choice=To get a vaccine / ክትባት ለመውሰድ / Talaallii  fudhachuuf)"
label variable any_of_the_following_v_23 "307. Was the first consultation is for any of the following? Include all that apply /  ይህ የመጀመሪያ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee (choice=Other reasons / ሌላ ምክኒያት / Sababni biraa)"
*/

label variable m2_307_other "307-oth. Specify other reason for the 1st visit"
label variable m2_308 "308. Was the second consultation is for a routine antenatal care visit?"
label variable m2_309 "309. Was the second consultation is for a referral from your antenatal care provider?"

/*
label variable any_of_the_following_v_26 "310. Was the second consultation is for any of the following? Include all that apply. / ይህ የ2ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee?  (choice=A new health problem, including an emergency or an injury / አዲስ የጤና እክል፤ድንገተኛ ህመም ወይም አደጋጨምሮ / Rakkoo fayyaa haaraa, balaa tasaa yookaan miidhaa qaamaa)"
label variable any_of_the_following_v_27 "310. Was the second consultation is for any of the following? Include all that apply. / ይህ የ2ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee?  (choice=An existing health problem / በፊትም የነበረ የጤና እክል / Rakkoo fayyaa jiru)"
label variable any_of_the_following_v_28 "310. Was the second consultation is for any of the following? Include all that apply. / ይህ የ2ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee?  (choice=A lab test, x-ray, or ultrasound / ለላቦራቶሪ ምርመራ ፤ራጅ፤አልትራሳውንድ / Qoannoo laabiraatorii, x-reeyii yookaan altiraasaawundii)"
label variable any_of_the_following_v_29 "310. Was the second consultation is for any of the following? Include all that apply. / ይህ የ2ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee?  (choice=To pick up medicine / መድሀኒት ለመውሰድ / Qoricha fudhachuuf)"
label variable any_of_the_following_v_30 "310. Was the second consultation is for any of the following? Include all that apply. / ይህ የ2ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee?  (choice=To get a vaccine / ክትባት ለመውሰድ / Talaallii  fudhachuuf)"
label variable any_of_the_following_v_31 "310. Was the second consultation is for any of the following? Include all that apply. / ይህ የ2ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee?  (choice=Other reasons / ሌላ ምክኒያት / Sababni biraa)"
label variable m2_310_other "310-oth. Specify other reason for second consultation / ካለ ይጥቀሱ / Ibsii"
*/


label variable m2_311 "311. Was the third consultation is for a routine antenatal care visit?"
label variable m2_312 "312. Was the third consultation is for a referral from your antenatal care provider?"

/*
label variable any_of_the_following_v_34 "313. Was the third consultation is for any of the following? Include all that apply. / ይህ የ3ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=A new health problem, including an emergency or an injury / አዲስ የጤና እክል፤ድንገተኛ ህመም ወይም አደጋጨምሮ / Rakkoo fayyaa haaraa, balaa tasaa yookaan miidhaa qaamaa)"
label variable any_of_the_following_v_35 "313. Was the third consultation is for any of the following? Include all that apply. / ይህ የ3ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=An existing health problem / በፊትም የነበረ *የጤና እክል / Rakkoo fayyaa jiru)"
label variable any_of_the_following_v_36 "313. Was the third consultation is for any of the following? Include all that apply. / ይህ የ3ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=A lab test, x-ray, or ultrasound / ለላቦራቶሪ ምርመራ ፤ራጅ፤አልትራሳውንድ / Qoannoo laabiraatorii, x-reeyii yookaan altiraasaawundii)"
label variable any_of_the_following_v_37 "313. Was the third consultation is for any of the following? Include all that apply. / ይህ የ3ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=To pick up medicine / መድሀኒት ለመውሰድ / Qoricha fudhachuuf)"
label variable any_of_the_following_v_38 "313. Was the third consultation is for any of the following? Include all that apply. / ይህ የ3ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=To get a vaccine / ክትባት ለመውሰድ / Talaallii  fudhachuuf)"
label variable any_of_the_following_v_39 "313. Was the third consultation is for any of the following? Include all that apply. / ይህ የ3ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=Other reasons / ሌላ ምክኒያት / Sababni biraa)"
label variable m2_313_other "313-oth. Specify any other reason for the third consultation"
*/

label variable m2_314 "314. Was the fourth consultation is for a routine antenatal care visit?"
label variable m2_315 "315. Was the fourth consultation is for a referral from your antenatal care provider?"

/*
label variable any_of_the_following_v_42 "316. Was the fourth consultation is for any of the following? Include all that apply. / ይህ የ4ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=A new health problem, including an emergency or an injury / አዲስ የጤና እክል፤ድንገተኛ ህመም ወይም አደጋጨምሮ / Rakkoo fayyaa haaraa, balaa tasaa yookaan miidhaa qaamaa)"
label variable any_of_the_following_v_43 "316. Was the fourth consultation is for any of the following? Include all that apply. / ይህ የ4ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=An existing health problem / በፊትም የነበረ የጤና እክል / Rakkoo fayyaa jiru)"
label variable any_of_the_following_v_44 "316. Was the fourth consultation is for any of the following? Include all that apply. / ይህ የ4ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=A lab test, x-ray, or ultrasound / ለላቦራቶሪ ምርመራ ፤ራጅ፤አልትራሳውንድ / Qoannoo laabiraatorii, x-reeyii yookaan altiraasaawundii)"
label variable any_of_the_following_v_45 "316. Was the fourth consultation is for any of the following? Include all that apply. / ይህ የ4ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=To pick up medicine / መድሀኒት ለመውሰድ / Qoricha fudhachuuf)"
label variable any_of_the_following_v_46 "316. Was the fourth consultation is for any of the following? Include all that apply. / ይህ የ4ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=To get a vaccine / ክትባት ለመውሰድ / Talaallii  fudhachuuf)"
label variable any_of_the_following_v_47 "316. Was the fourth consultation is for any of the following? Include all that apply. / ይህ የ4ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? Kamiif turee? (choice=Other reasons / ሌላ ምክኒያት / Sababni biraa)"
*/

label variable m2_316_other "316-oth. Specify other reason for the fourth consultation"

label variable m2_317 "317. Was the fifth consultation is for a routine antenatal care visit?"
label variable m2_318 "318. Was the fifth consultation is for a referral from your antenatal care provider?"

/*
label variable any_of_the_following_v_50 "319. Was the fifth consultation is for any of the following? Include all that apply. / ይህ የ5ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? (choice=A new health problem, including an emergency or an injury / አዲስ የጤና እክል፤ድንገተኛ ህመም ወይም አደጋጨምሮ / Rakkoo fayyaa haaraa, balaa tasaa yookaan miidhaa qaamaa)"
label variable any_of_the_following_v_51 "319. Was the fifth consultation is for any of the following? Include all that apply. / ይህ የ5ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? (choice=An existing health problem / በፊትም የነበረ የጤና እክል / Rakkoo fayyaa jiru)"
label variable any_of_the_following_v_52 "319. Was the fifth consultation is for any of the following? Include all that apply. / ይህ የ5ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? (choice=A lab test, x-ray, or ultrasound / ለላቦራቶሪ ምርመራ ፤ራጅ፤አልትራሳውንድ / Qoannoo laabiraatorii, x-reeyii yookaan altiraasaawundii)"
label variable any_of_the_following_v_53 "319. Was the fifth consultation is for any of the following? Include all that apply. / ይህ የ5ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? (choice=To pick up medicine / መድሀኒት ለመውሰድ / Qoricha fudhachuuf)"
label variable any_of_the_following_v_54 "319. Was the fifth consultation is for any of the following? Include all that apply. / ይህ የ5ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? (choice=To get a vaccine / ክትባት ለመውሰድ / Talaallii  fudhachuuf)"
label variable any_of_the_following_v_55 "319. Was the fifth consultation is for any of the following? Include all that apply. / ይህ የ5ኛ ክትትል ለየትኛው አገልግሎት ነበር? የሚመለከተውን ሁሉ ይንገሩኝ/ንገሪኝ። / Daawwannaan kun kanneen armaan gadii keessaa tokkoof turee? (choice=Other reasons / ሌላ ምክኒያት / Sababni biraa)"
label variable m2_319_other "319-oth. Specify other reason for the fifth consultation"
*/


/*
label variable prevent_more_antenat_v_56 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=No reason or you didnt need it / ምንም ምከንያት የለም ወይም አልፈለግሽም / Sababaa hin qabu ykn si hin barbaachifne)"
label variable prevent_more_antenat_v_57 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=You tried but were sent away (e.g., no appointment available) / ሞክሬያለሁ ነበር ግን ተሰናበትኩ (ለምሳሌ፣ ምንም ቀጠሮ የለም) / Yaaltee garuu ergamte (fkn, beellama hin jiru))"
label variable prevent_more_antenat_v_58 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=High cost (e.g., high out of pocket payment, not covered by insurance) / ክፍያው ከፍያለ በመሆኑ (ከኪስ ከፍ ያለ ክፍያ፤ በጤና መድህን ስለማይሸፈን) / Baasii guddaa (fkn, kaffaltii kiisha keessaa bahu olaanaa, inshuraansiidhaan kan hin haguugamne))"
label variable prevent_more_antenat_v_59 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Far distance (e.g., too far to walk or drive, transport not readily available) / ሩቅ ስለሆነ/ርቀት (ለምሳሌ-በእግር ለመሄድ እሩቅ ስለሆነ /የመጓጓዣ አገልግሎት አለመኖር) / Fageenya fagoo (fkn, miilaan deemuuf ykn konkolaachisuuf baayee fagoo, geejjibni salphaatti hin argamne).)"
label variable prevent_more_antenat_v_60 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Long waiting time (e.g., long line to access facility, long wait for the provider) / ብዙ ስለሚያስጠብቅ (ለምሳሌ-ወረፋ ስለሚበዛ ፤ባለሙያ ለማግኘት ብዙ ሰዐት ስለሚያስጠበቅ) / Yeroo eegaa dheeraa (fkn, sarara dheeraa dhaabbata argachuuf, dhiyeessaaf eegaa dheeraa).)"
label variable prevent_more_antenat_v_61 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam) / የባለሙያዎች ክህሎት ደካማ ስለሆነ (ለምሳሌ., ለነፍሰጡር እናት ትንሽ ጊዜ ብቻ ስለሚሰጡ፤ በደንብ ምርመራ ስለማያረጉ) / Dandeettii ogeessa fayyaa gaarii hin taane (fkn, dhukkubsataa waliin yeroo xiqqoo dabarsuu, qorannoo gadi fageenya qabu hin gaggeessine).)"
label variable prevent_more_antenat_v_62 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Staff dont show respect (e.g., staff is rude, impolite, dismissive) / የተቋሙ ሰራተኞች ለእናቶች ክብር ስለማያሳዩ (ለምሳሌ. ባለሙያዎቹ ስነ-ስርዐት ስለሌላቸው፤, ጨዋነት ስለሚጎላቸው፤) / Hojjetoonni kabaja hin agarsiisan (fkn, hojjettoonni gara jabeessa, safuu kan hin qabne, kan tuffatan))"
label variable prevent_more_antenat_v_63 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable) / መድሀኒትና የህክምና መገልገያ መሳሪያዎች ስለሌሉ (ለምሳሌ-አብዛኛውን ጊዜ መድሀኒት ሰለሚያልቅ፤ ራጅን የመሳሰሉ መሳሪያዎች መበላሸት ወይም አለመኖር) / Qorichootni ykn meeshaaleen hin jiran (fkn, qorichi yeroo hunda istookii dhabamuu, meeshaaleen akka maashinii raajii X-ray cabee ykn hin argamne).)"
label variable prevent_more_antenat_v_64 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) / daangeffama COVID-19)"
label variable prevent_more_antenat_v_65 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=COVID-19 fear / ኮቪድ-19ን ፍራቻ / Sodaa COVID-19)"
label variable prevent_more_antenat_v_66 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Dont know where to go/too complicated / የት መሄድ እንዳለብኝ አላውቅም/በጣም የተወሳሰበ ነው / Eessa akka deemtu hin beeku/garmalee walxaxaa)"
label variable prevent_more_antenat_v_67 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Fear of discovering serious problem / ከባድ የሆኑ የጤና ችግሮችን ይነገረኛል ብለሽ ፍራቻ ስላደረብሽ / Rakkoo hamaa jiru argachuu sodaachuu Rakkoo hamaa jiru argachuu sodaachuu)"
label variable prevent_more_antenat_v_68 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=Other, specify / ሌላ ካለ ይጥቀሱ/ጥቀሽ / Beellama koo eeguu)"
label variable prevent_more_antenat_v_69 "320. Are there any reasons that prevented you from receiving more antenatal care since you last spoke to us? Tell me all reasons, if any, that apply. / የመጨረሻውን መጠይቅ ካደረግንልሽ/ዎት በኋላ እርግዝናሽን በተመለከተ አገልግሎቱን እንዳታገኚ ያደረገሽ ምክኒያት አለ? ካለ ሁሉንም ምክንያቶች ይጥቀሱ / Erga yeroo dhumaaf nutti dubbattanii as sababoonni kunuunsa dahumsa duraa dabalataa akka hin arganne si godhan jiruu? yoo jiraatan, Sababoota hunda kan ilaallatan natti himaa. (choice=RF/ ታቅቦ/ያልተመለሰ / DEEBII HIN KENNINE)"
*/


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
label variable m2_702e_other "702e-oth. How much money did you spend on other item/service?"
label variable m2_703 "703. So, in total you spent"
label variable m2_704 "704. Is the total cost correct?"
label variable m2_704_other "704-oth. So how much in total would you say you spent?"

/*
label variable which_of_the_followi_v_92 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Current income of any household members / ከቤተሰብ አባላት ወቅታዊ ገቢ / Galii yeroo ammaa miseensota manaa kamiyyuu)"
label variable which_of_the_followi_v_93 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Savings (e.g., bank account) / ከቁጠባ (ለምሳሌ ከባንክ ደብተር) / Qusannoo (fkn herrega baankii))"
label variable which_of_the_followi_v_94 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Payment or reimbursement from a health insurance plan / ከጤና መድህን ክፍያ ወይም ማካካሻ / Karoora inshuraansii fayyaa irraa kaffaltii yookaan bakka buusa)"
label variable which_of_the_followi_v_95 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Sold items (e.g., furniture, animals, jewellery, furniture) / ንብረት በመሸጥ (ለምሳሌ የቤት ዕቃዎች፣ እንስሳት፣ ጌጣጌጥ) / Meeshaalee gurguruun (fkn meeshaalee manaa, bineensota, faaya, meeshaalee manaa))"
label variable which_of_the_followi_v_96 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Family members or friends from outside the household / ከቤት ውጭ ካሉ የቤተሰብ አባላት ወይም ከጓደኞች / Miseensota maatii yookaan hiriyoota manaa ala jiran irraa)"
label variable which_of_the_followi_v_97 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Borrowed (from someone other than a friend or family) / ብድር (ከጓደኛ ወይም ከቤተሰብ ውጭ ከሆኑ ሰዎች) / Liqeeffannee (hiriyyaa yookaan maatii irraa kan hafe nama biraa irraa))"
label variable which_of_the_followi_v_98 "705. Which of the following financial sources did your household use to pay for this? Include all that apply (Interviewer: probe as anything else?)  ከሚከተሉት የገንዘብ ምንጮች ውስጥ ቤተሰብዎ ለእዚህ ክትትል ክፍያ ወጪ የተጠቀሙትከየትኛው ምንጭ/መንገድ ነው? ( ጠያቂ፡ ሌላስ በማለት)  Maatiin  keessan kaffaltii kana kaffaluuf maddoota gaalli keesaani  armaan gadii keessaa isa kam fayyadamtan? (choice=Other (please specify) / ሌላ (እባክዎ ይግለጹ) / Kan biroo (maaloo ibsi))"
*/


label variable m2_705_other "705-oth. Please specify"
label variable m2_interview_inturrupt "Is the interview inturrupted?"
label variable m2_interupt_time "At what time it is interrupted?"
label variable m2_interview_restarted "Is the interview restarted?"
label variable m2_restart_time "At what time it is restarted?"
label variable m2_endtime "103B. Time of Interview end"
label variable m2_int_duration "103C. Total Duration of interview (In minutes)"
label variable m2_endstatus "What is this womens current status at the end of the interview?"
label variable m2_complete "Complete?"
