* Ethiopia ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Oct 24 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

*--------------------DATA FILE:

import delimited using "$et_data/M0_ET_final.csv", clear

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 29)
		* STEP TW0: ADD VALUE LABELS (starts at: line 214)
		* STEP THREE: RECODING MISSING VALUES (starts at: line 903)
		* STEP FOUR: LABELING VARIABLES (starts at: line 1688)
		* STEP FIVE: ORDER VARIABLES (starts at: line 2379)
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
 
rename (a15b_latitude_m0 a15a_longtitude_m0 a15c_altitude_m0) (m0_latitude m0_longitude m0_altitude_et)

rename (a1_date_time_of_interview_m0 a2_region_name_m0 a3_zone_sub_city_name_m0 a4_woreda_name_m0 ///
		other_woreda_name_m0 a7_interviewer_id_m0) (m0_a1_date m0_a4_site m0_a4_subsite m0_woreda_et ///
		m0_woreda_et_other m0_id)

rename (a5_facility_name_m0 specify_the_facility_name_m0) (m0_facility m0_facility_other)

rename (a6_facility_type_m0 a8_facility_ownership_m0 specify_facility_ownership_m0 a9_urban_rural_m0 ///
		a13_does_this_facility_hav_m0 a14_how_many_people_are_m0) (m0_facility_type m0_facility_own ///
		m0_facility_own_other m0_urban m0_a13 m0_a14)

rename (how_many_medical_101a_m0 how_many_medical_101b_m0 how_many_medical_101c_m0 how_many_medical_101d_m0) ///
	   (m0_101a m0_101b m0_101c m0_101d)
	   
rename (how_may_obstetrician_102a_m0 obstetrician_gyne_102b_m0 how_many_vacancies_102c_m0 how_many_currently_102d) ///
	   (m0_102a m0_102b m0_102c m0_102d)

rename (how_many_general_surgeon_103a how_many_general_surgeon_103b how_many_vacancies_are_103c ///
		how_many_currently_provi_103d) (m0_103a m0_103b m0_103c m0_103d)

rename (how_many_anesthesiologis_104a how_many_anesthesi_partime how_many_anesthesiol_vaca new_born_for_anesthesiologist) ///
	   (m0_104a m0_104b m0_104c m0_104d)

rename (how_many_pediatrician_105a how_many_are_currently_105b how_many_vacancies_105c how_many_currently_105d) (m0_105a ///
		m0_105b m0_105c m0_105d)

rename (how_many_neonatologist_106a how_many_neonatologist_106b how_many_vacancies_106c how_many_neonatologist_106d) ///
	   (m0_106a m0_106b m0_106c m0_106d)

rename (how_many_emergency_107a how_many_emergency_107b how_many_vacancies_107c how_many_emergency_107d) (m0_107a m0_107b ///
	   m0_107c m0_107d)

rename (how_many_midwife_108a how_many_are_currently_108b how_many_vacancies_108c how_many_midwife_108d) (m0_108a m0_108b ///
	   m0_108c m0_108d)

rename (how_many_midwife_109a how_many_midwife_109b how_many_vacancies_109c how_many_currently_109d) (m0_109a m0_109b ///
		m0_109c m0_109d)

rename (how_many_nurse_bsc_110a how_many_nurse_bsc_110b how_many_vacancies_110c how_many_nurse_bsc_110d) (m0_110a m0_110b ///
		m0_110c m0_110d)

rename (how_many_nurse_111a how_many_nurse_111b how_many_vacancies_111c how_many_nurse_111d) (m0_111a m0_111b m0_111c m0_111d)

rename (how_many_health_112a how_many_health_112b how_many_vacancies_112c how_many_health_112d) (m0_112a m0_112b m0_112c m0_112d)

rename (how_many_anesthetist_113a how_many_anesthetist_113b how_many_vacancies_113c how_many_anesthetist_113d) (m0_113a ///
		m0_113b m0_113c m0_113d)

rename (how_many_lab_technolo_114a how_many_lab_technol_114b how_many_vacancies_114c how_many_lab_technol_114d) (m0_114a ///
		m0_114b m0_114c m0_114d)

rename (eth_1_a_how_many_degree_mi eth_1_1b_how_many_diplom_m eth_1_1c_how_many_degree_n eth_1_1d_how_many_diploma ///
		eth_1_1e_how_many_health_o eth_1_1f_how_many_emergenc eth_1_1g_how_many_general eth_2_1a_how_many_degree_m ///
		eth_2_1b_how_many_diploma eth_2_1c_how_many_degree_n eth_2_1d_how_many_diploma eth_2_1e_how_many_health_o ///
		eth_2_1f_how_many_emergenc eth_2_1g_how_many_general eth_3_1a_how_many_degree_m eth_3_1b_how_many_diploma ///
		eth_3_1c_how_many_degree_n eth_3_1d_how_many_diploma eth_3_1e_how_many_health_o eth_3_1f_how_many_emergenc ///
		eth_3_1f_how_many_general eth_4_1a_how_many_degree_m eth_4_1b_how_many_diploma eth_4_1c_how_many_degree_n ///
		eth_4_1d_how_many_diploma eth_4_1e_how_many_health_o eth_4_1f_how_many_emergenc eth_4_1g_how_many_general) ///
		(m0_1a_et m0_1b_et m0_1c_et m0_1d_et m0_1e_et m0_1f_et m0_1g_et m0_2a_et m0_2b_et m0_2c_et m0_2d_et m0_2e_et ///
		m0_2f_et m0_2g_et m0_3a_et m0_3b_et m0_3c_et m0_3d_et m0_3e_et m0_3f_et m0_3g_et m0_4a_et m0_4b_et m0_4c_et ///
		m0_4d_et m0_4e_et m0_4f_et m0_4g_et)

rename (during_a_typical_week_what___1 during_a_typical_week_what___2 during_a_typical_week_what___3 ///
		during_a_typical_week_what___4 during_a_typical_week_what___5 during_a_typical_week_what___6 ///
		during_a_typical_week_what___7 during_a_typical_week_what___8 during_a_typical_week_what___9) ///
		(m0_115a_et m0_115b_et m0_115c_et m0_115d_et m0_115e_et m0_115f_et m0_115g_et m0_115h_et m0_115i_et)

rename (during_a_typical_week_116___1 during_a_typical_week_116___2 during_a_typical_week_116___3 ///
		during_a_typical_week_116___4 during_a_typical_week_116___5 during_a_typical_week_116___6 ///
		during_a_typical_week_116___7 during_a_typical_week_116___8 during_a_typical_week_116___9) ///
		(m0_116a_et m0_116b_et m0_116c_et m0_116d_et m0_116e_et m0_116f_et m0_116g_et m0_116h_et m0_116i_et)

rename (during_a_typical_week_117___1 during_a_typical_week_117___2 during_a_typical_week_117___3 ///
		during_a_typical_week_117___4 during_a_typical_week_117___5 during_a_typical_week_117___6 ///
		during_a_typical_week_117___7 during_a_typical_week_117___8 during_a_typical_week_117___9) ///
		(m0_117a_et m0_117b_et m0_117c_et m0_117d_et m0_117e_et m0_117f_et m0_117g_et m0_117h_et m0_117i_et)

rename (during_a_typical_week_118___1 during_a_typical_week_118___2 during_a_typical_week_118___3 ///
		during_a_typical_week_118___4 during_a_typical_week_118___5 during_a_typical_week_118___6 ///
		during_a_typical_week_118___7 during_a_typical_week_118___8 during_a_typical_week_118___9) ///
		(m0_118a_et m0_118b_et m0_118c_et m0_118d_et m0_118e_et m0_118f_et m0_118g_et m0_118h_et m0_118i_et)

rename (during_a_typical_week_119___1 during_a_typical_week_119___2 during_a_typical_week_119___3 ///
		during_a_typical_week_119___4 during_a_typical_week_119___5 during_a_typical_week_119___6 ///
		during_a_typical_week_119___7 during_a_typical_week_119___8 during_a_typical_week_119___9) ///
		(m0_119a_et m0_119b_et m0_119c_et m0_119d_et m0_119e_et m0_119f_et m0_119g_et m0_119h_et m0_119i_et)

rename (during_a_typical_week_120___1 during_a_typical_week_120___2 during_a_typical_week_120___3 ///
		during_a_typical_week_120___4 during_a_typical_week_120___5 during_a_typical_week_120___6 ///
		during_a_typical_week_120___7 during_a_typical_week_120___8 during_a_typical_week_120___9) ///
		(m0_120a_et m0_120b_et m0_120c_et m0_120d_et m0_120e_et m0_120f_et m0_120g_et m0_120h_et m0_120i_et)

rename (during_a_typical_week_121___1 during_a_typical_week_121___2 during_a_typical_week_121___3 ///
		during_a_typical_week_121___4 during_a_typical_week_121___5 during_a_typical_week_121___6 ///
		during_a_typical_week_121___7 during_a_typical_week_121___8 during_a_typical_week_121___9) ///
		(m0_121a_et m0_121b_et m0_121c_et m0_121d_et m0_121e_et m0_121f_et m0_121g_et m0_121h_et m0_121i_et)

rename (during_a_typical_week_122___1 during_a_typical_week_122___2 during_a_typical_week_122___3 ///
		during_a_typical_week_122___4 during_a_typical_week_122___5 during_a_typical_week_122___6 ///
		during_a_typical_week_122___7 during_a_typical_week_122___8 during_a_typical_week_122___9) ///
		(m0_122a_et m0_122b_et m0_122c_et m0_122d_et m0_122e_et m0_122f_et m0_122g_et m0_122h_et m0_122i_et)

rename how_many_beds_are_availabl_201 m0_201

rename (how_many_beds_are_dedica_202a how_many_beds_are_dedica_202b does_facility_have_space_204 does_facility_have_205 ///
		is_this_facility_connected_206 thinking_back_over_the_207 does_this_facility_have_208) (m0_202 m0_203 m0_204 m0_205 ///
		m0_206 m0_207 m0_208)

rename (what_other_sources_of_209___1 what_other_sources_of_209___2 what_other_sources_of_209___3 ///
		what_other_sources_of_209___4 what_other_sources_of_209___98 specify_other_sources_of_209 ///
		does_this_facility_have_210 what_is_the_most_com_211 specify_other_common_213 is_the_water_from_this_212 ///
		is_there_a_time_of_the_yea is_there_a_toilet_latrine_215 what_type_of_toilet_if_mul does_this_facility_have_216 ///
		does_this_facility_have_217 does_this_facility_have_218 does_this_facility_have_219 is_there_access_to_email_220 ///
		does_this_facility_have_221 how_many_ambulances_222 does_this_facility_have_223 family_planning_does_301) ///
		(m0_209a_et m0_209b_et m0_209c_et m0_209d_et m0_209e_et m0_209_other m0_210 m0_211 m0_211_other m0_212 m0_213 ///
		m0_214 m0_215 m0_216 m0_217 m0_218 m0_219 m0_220 m0_221 m0_222 m0_223 m0_301)

rename (pmtct_does_this_facility_303 obstetric_and_newborn_304 caesarean_section_does_305a has_a_caesarean_section_305b ///
		immunization_does_this_306 child_preventive_and_307a anc_does_this_facility_pro b_pnc_does_this_facility_307b ///
		cervical_cancer_screening adolescent_health_does_308 hiv_testing_does_this_309 hiv_treatment_does_this_310 ///
		hiv_care_and_support_311 stis_does_this_facility_312 tb_does_this_facility_offe_313 malaria_does_this_facility_314) ///
		(m0_303 m0_304 m0_305a m0_305b m0_306 m0_307 m0_307a m0_307b m0_307c m0_308 m0_309 m0_310 m0_311 m0_312 m0_313 m0_314)

rename (ncds_does_this_facility_315a ncds_does_this_facility_315b ncds_does_this_facility_315c ncds_does_this_facility_316d ///
		ncds_does_this_facility_316e ncds_does_this_facility_316f ntds_does_this_facility_316 surgery_does_this_facility_317 ///
		blood_transfusion_does_318) (m0_315a m0_315b m0_315c m0_315d m0_315e m0_315f m0_316 m0_317 m0_318)

rename abortion_does_this_facilit_319 m0_319

rename (blood_pressure_apparatus_401 status_of_the_blood_preasu adult_weighing_scale_402 status_of_adult_weighing ///
		infant_weighing_scale_403 status_of_infant_weighing measuring_tape_height_404 status_of_measuring_tape ///
		thermometer_405 status_of_thermometer stethoscope_406 status_of_stethoscope does_this_facility_conduct_407) (m0_401 ///
		m0_401a m0_402 m0_402a m0_403 m0_403a m0_404 m0_404a m0_405 m0_405a m0_406 m0_406a m0_407)

rename (rapid_malaria_testing_408 rapid_syphilis_testing_409 hiv_rapid_testing_410 urine_rapid_tests_for_preg ///
		urine_protein_dipstick_tes urine_glucose_dipstick_tes urine_ketone_dipstick_test dry_blood_spot_dbs_collect) (m0_408 ///
		m0_409 m0_410 m0_411 m0_412 m0_413 m0_414 m0_415)

rename (malaria_rapid_diagnostic_416 syphilis_rapid_test_kit khb_hiv_rapid_test_kit statpack_hiv_rapid_test_ki ///
	   unigold_hiv_rapid_test_kit urine_pregnancy_test_kit dipsticks_for_urine_protei dipsticks_for_urine_glucos ///
	   dipsticks_for_urine_ketone filter_paper_for_collectin) (m0_416 m0_417 m0_418 m0_419 m0_420 m0_421 m0_422 m0_423 ///
	   m0_424 m0_425)

rename (blood_glucose_tests_using_426 haemoglobin_testing_427 general_microscopy_wet_mou malaria_microscopy_429 ///
		hiv_antibody_testing_by_430 does_this_facility_perform_431) (m0_426 m0_427 m0_428 m0_429 m0_430 m0_431)

rename (x_ray_machine_432 ultrasound_equipment_433 ct_scan_434 ecg_435 does_this_facility_ever_501 to_which_facility_does_thi) ///
	   (m0_432 m0_433 m0_434 m0_435 m0_501 m0_502)

rename (what_strategies_does_503___1 what_strategies_does_503___2 what_strategies_does_503___3 what_strategies_does_503___4 ///
		what_strategies_does_503___5 what_strategies_does_503___6 after_this_facility_refers_504 does_this_facility_have_505 ///
		does_this_facility_ever_506 is_there_a_system_for_507 does_this_facility_have_508 eth_1_5_does_the_maternal ///
		formal_payment_required_601 woman_expected_to_pay_602 in_an_obstetric_emergency_602 in_an_obstetric_emergency_603 ///
		is_there_a_formal_system_604 is_there_any_informal_syst_605 is_there_a_fee_schedule_fo does_this_facility_have_701 ///
		does_this_facility_report_702 how_frequently_are_mnh_703 oth_mnh_data_reported_frq does_this_facility_have_704 ///
		is_a_labor_and_delivery_705 is_an_antenatal_care_regis_706 is_an_postnatal_care_regis_707) (m0_503a_et m0_503b_et ///
		m0_503c_et m0_503d_et m0_503e_et m0_503f_et m0_504 m0_505 m0_506 m0_507 m0_508 m0_508a_et m0_601 m0_602 m0_603 ///
		m0_604 m0_605 m0_606 m0_607 m0_701 m0_702 m0_703 m0_703_other m0_704 m0_705 m0_706 m0_707)

rename (number_of_antenatal_jan number_of_antenatal_feb number_of_antenatal_mar number_of_antenatal_april ///
		number_of_antenatal_may number_of_antenatal_june number_of_antenatal_july number_of_antenatal_august ///
		number_of_antenatal_sept number_of_antenatal_october number_of_antenatal_novem number_of_antenatal_dec) ///
		(m0_801_jan m0_801_feb m0_801_mar m0_801_apr m0_801_may m0_801_jun m0_801_jul m0_801_aug m0_801_sep m0_801_oct ///
		m0_801_nov m0_801_dec)

rename (number_of_first_antena_jan number_of_first_anten_feb number_of_first_anten_mar number_of_first_anten_april ///
		number_of_first_anten_may number_of_first_anten_june number_of_first_anten_july number_of_first_anten_aug ///
		number_of_first_anten_sep number_of_first_anten_oct number_of_first_anten_nov number_of_first_anten_dec) ///
		(m0_802_jan m0_802_feb m0_802_mar m0_802_apr m0_802_may m0_802_jun m0_802_jul m0_802_aug m0_802_sep m0_802_oct ///
		m0_802_nov m0_802_dec)

rename (number_of_vaginal_jan number_of_vaginal_feb number_of_vaginal_mar number_of_vaginal_april number_of_vaginal_may ///
		number_of_vaginal_june number_of_vaginal_july number_of_vaginal_august number_of_vaginal_sep number_of_vaginal_oct ///
		number_of_vaginal_nov number_of_vaginal_dec) (m0_803_jan m0_803_feb m0_803_mar m0_803_apr m0_803_may m0_803_jun ///
		m0_803_jul m0_803_aug m0_803_sep m0_803_oct m0_803_nov m0_803_dec)

rename (number_of_caesarean_jan number_of_caesarean_feb number_of_caesarean_mar number_of_caesarean_april ///
		number_of_caesarean_may number_of_caesarean_jun number_of_caesarean_july number_of_caesarean_august ///
		number_of_caesarean_sep number_of_caesarean_oct number_of_caesarean_nov number_of_caesarean_dec) (m0_804_jan ///
		m0_804_feb m0_804_mar m0_804_apr m0_804_may m0_804_jun m0_804_jul m0_804_aug m0_804_sep m0_804_oct m0_804_nov m0_804_dec)

rename (postpartum_haemorr_jan postpartum_haemorr_feb postpartum_haemorr_mar postpartum_haemorrhage_cas postpartum_haemorr_may ///
		postpartum_haemorr_june postpartum_haemorr_july postpartum_haemorr_aug postpartum_haemorr_sep postpartum_haemorr_oct ///
		postpartum_haemorr_nov postpartum_haemorr_dec) (m0_805_jan m0_805_feb m0_805_mar m0_805_apr m0_805_may m0_805_jun ///
		m0_805_jul m0_805_aug m0_805_sep m0_805_oct m0_805_nov m0_805_dec)

rename (prolonged_obstructed_jan prolonged_obstructed_feb prolonged_obstructed_mar prolonged_obstructed_apr ///
		prolonged_obstructed_may prolonged_obstructed_june prolonged_obstructed_july prolonged_obstructed_agu ///
		prolonged_obstructed_sep prolonged_obstructed_oct prolonged_obstructed_nov prolonged_obstructed_dec) (m0_806_jan ///
		m0_806_feb m0_806_mar m0_806_apr m0_806_may m0_806_jun m0_806_jul m0_806_aug m0_806_sep m0_806_oct m0_806_nov m0_806_dec)

rename (severe_pre_eclampsia_jan severe_pre_eclampsia_feb severe_pre_eclampsia_mar severe_pre_eclampsia_april ///
		severe_pre_eclampsia_may severe_pre_eclampsia_june severe_pre_eclampsia_july severe_pre_eclampsia_aug ///
		severe_pre_eclampsia_sep severe_pre_eclampsia_oct severe_pre_eclampsia_nov severe_pre_eclampsia_dec) (m0_807_jan ///
		m0_807_feb m0_807_mar m0_807_apr m0_807_may m0_807_jun m0_807_jul m0_807_aug m0_807_sep m0_807_oct m0_807_nov m0_807_dec)

rename (maternal_deaths_for_jan maternal_deaths_for_feb maternal_deaths_for_mar maternal_deaths_for_april ///
		maternal_deaths_for_may maternal_deaths_for_june maternal_deaths_for_july maternal_deaths_for_august ///
		maternal_deaths_for_sep maternal_deaths_for_oct maternal_deaths_for_nov maternal_deaths_for_dec) (m0_808_jan ///
		m0_808_feb m0_808_mar m0_808_apr m0_808_may m0_808_jun m0_808_jul m0_808_aug m0_808_sep m0_808_oct m0_808_nov m0_808_dec)

rename (stillbirths_for_january stillbirths_for_february stillbirths_for_march stillbirths_for_april stillbirths_for_may ///
		stillbirths_for_june stillbirths_for_july stillbirths_for_august stillbirths_for_september stillbirths_for_october ///
		stillbirths_for_november stillbirths_for_december) (m0_809_jan m0_809_feb m0_809_mar m0_809_apr m0_809_may
m0_809_jun
m0_809_jul
m0_809_aug
m0_809_sep
m0_809_oct
m0_809_nov
m0_809_dec)

rename (severe_pre_eclampsia_cases
severe_pre_eclampsia_cases_feb
severe_pre_eclampsia_cases_mar
severe_pre_eclampsia_cases_apr
severe_pre_eclampsia_cases_may
severe_pre_eclampsia_cases_jun
severe_pre_eclampsia_cases_jul
severe_pre_eclampsia_cases_aug
severe_pre_eclampsia_cases_sept
severe_pre_eclampsia_cases_oct
severe_pre_eclampsia_cases_nov
severe_pre_eclampsia_cases_dec) (m0_810_jan
m0_810_feb
m0_810_mar
m0_810_apr
m0_810_may
m0_810_jun
m0_810_jul
m0_810_aug
m0_810_sep
m0_810_oct
m0_810_nov
m0_810_dec)

rename (early_neonatal_deaths_jan
early_neonatal_deaths_feb
early_neonatal_deaths_mar
early_neonatal_deaths_firs
early_neonatal_deaths_may
early_neonatal_deaths_june
early_neonatal_deaths_july
early_neonatal_deaths_aug
early_neonatal_deaths_sep
early_neonatal_deaths_oct
early_neonatal_deaths_nov
early_neonatal_deaths_dec) (m0_811_jan
m0_811_feb
m0_811_mar
m0_811_apr
m0_811_may
m0_811_jun
m0_811_jul
m0_811_aug
m0_811_sep
m0_811_oct
m0_811_nov
m0_811_dec)

rename (referrals_out_of_this_jan
referrals_out_of_this_feb
referrals_out_of_this_mar
referrals_out_of_this_april
referrals_out_of_this_may
referrals_out_of_this_june
referrals_out_of_this_july
referrals_out_of_this_aug
referrals_out_of_this_sep
referrals_out_of_this_oct
referrals_out_of_this_nov
referrals_out_of_this_dec) (m0_812_jan
m0_812_feb
m0_812_mar
m0_812_apr
m0_812_may
m0_812_jun
m0_812_jul
m0_812_aug
m0_812_sep
m0_812_oct
m0_812_nov
m0_812_dec)

rename (number_of_postnatal_jan
number_of_postnatal_feb
number_of_postnatal_mar
number_of_postnatal_april
number_of_postnatal_may
number_of_postnatal_june
number_of_postnatal_july
number_of_postnatal_aug
number_of_postnatal_sep
number_of_postnatal_oct
number_of_postnatal_nov
number_of_postnatal_dec) (m0_813_jan
m0_813_feb
m0_813_mar
m0_813_apr
m0_813_may
m0_813_jun
m0_813_jul
m0_813_aug
m0_813_sep
m0_813_oct
m0_813_nov
m0_813_dec)

rename (january_instrumental_deliveries
february_instrumental_deliveries
march_instrumental_deliveries
april_instrumental_deliveries
may_instrumental_deliveries
june_instrumental_deliveries
july_instrumental_deliveries
august_instrumental_deliveries
september_instrumental_deliveries
october_instrumental_deliveries
november_instrumental_deliveries
december_instrumental_deliveries
january_early_neonatal_death
february_early_neonatal_death
march_early_neonatal_death
april_early_neonatal_death
may_early_neonatal_death
june_early_neonatal_death
july_early_neonatal_death
august_early_neonatal_death
september_early_neonatal_death
october_early_neonatal_death
november_early_neonatal_death
december_early_neonatal_death
module_0_facility_assessment_complete) (m0_814_jan_et
m0_814_feb_et
m0_814_mar_et
m0_814_apr_et
m0_814_may_et
m0_814_jun_et
m0_814_jul_et
m0_814_aug_et
m0_814_sep_et
m0_814_oct_et
m0_814_nov_et
m0_814_dec_et
m0_815_jan_et
m0_815_feb_et
m0_815_mar_et
m0_815_apr_et
m0_815_may_et
m0_815_jun_et
m0_815_jul_et
m0_815_aug_et
m0_815_sep_et
m0_815_oct_et
m0_815_nov_et
m0_815_dec_et
m0_complete_et)































