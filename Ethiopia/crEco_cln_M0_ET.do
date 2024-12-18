* Ethiopia ECohort Data Cleaning File 
* Created by S. Sabwa & N. Kapoor
* Updated: Oct 24 2023 

*------------------------------------------------------------------------------*

* Import Data 
clear all 

*--------------------DATA FILE:

import delimited using "$et_data/M0_ET_final.csv", clear
keep if  a5_facility_name_m0==96 // St Francis 
save "$et_data_final/eco_m0_et.dta", replace

import delimited using "$et_data/Module0Report_DATA_2023-04-03_0740_Full_Dec.07csv.csv", clear
drop if nameoffacility=="Catholic Church Primary Clinic" // no women recruited
append using "$et_data_final/eco_m0_et.dta", force

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 29)
		* STEP TW0: ADD VALUE LABELS (starts at: )
		* STEP THREE: RECODING MISSING VALUES (starts at: )
		* STEP FOUR: LABELING VARIABLES (starts at: )
		* STEP FIVE: ORDER VARIABLES (starts at: )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

foreach v of varlist * {
	char `v'[Original_ET_Varname] `v'
	char `v'[Module] 0
}

drop a10_name_of_the_person_m0 a11_landline_phone_number_m0 a12_personal_phone_of_the_m0 nameoffacility specify_facility_ownership_m0 

	* STEP ONE: RENAME VARAIBLES
 
rename (a15b_latitude_m0 a15a_longtitude_m0 a15c_altitude_m0) (m0_a6a_lat m0_a6b_long m0_a6c_alt)

rename (a1_date_time_of_interview_m0 a2_region_name_m0 a3_zone_sub_city_name_m0 a4_woreda_name_m0 ///
		other_woreda_name_m0 a7_interviewer_id_m0) (m0_a1_date m0_a2_site m0_a3_subsite m0_a4_woreda_et ///
		m0_a4_woreda_et_oth m0_id)

rename (a5_facility_name_m0 specify_the_facility_name_m0) (m0_a5_fac m0_a5_fac_oth)
		
rename (a6_facility_type_m0 a8_facility_ownership_m0 a9_urban_rural_m0 ///
		a13_does_this_facility_hav_m0 a14_how_many_people_are_m0) (m0_a6_fac_type m0_a8_fac_own ///
		m0_a9_urban m0_a13 m0_a14)
		
* NOTE - in the main M0 tool on dropbox, numbering is off for A4-A8 (there's duplicate A4-A6), and differs from Ethiopia tool
* Because of the issues in the main tool, I used the numbering in the Ethiopia tool for var names
* These var names and labeling should be double checked 
		
lab var record_id "Record ID"
lab var redcap_data_access_group "Redcap data access group"
lab var m0_a1_date "M0-A1. Date"
lab var m0_a2_site "M0-A2. Region"
lab var m0_a3_subsite "M0-A3. Zone/subcity site"
lab var m0_a4_woreda_et "M0-A4. Woreda name"
lab var m0_a4_woreda_et_oth "M0-A4. Woreda name (other, specify)"
lab var m0_id "M0-A7. Interviewer ID"
lab var m0_a5_fac "M0-A5. Facility name"
lab var m0_a5_fac_oth "M0-A5. Facility name (other)"
lab var m0_a6_fac_type "M0-6. Facility type"
lab var m0_a8_fac_own "M0-A8. Facilility ownership"
lab var m0_a9_urban "M0-A9. Urban/rural"
lab var m0_a13 "M0-A13. Does this facility have a specified catchment area?"
lab var m0_a14 "M0-A14. How many people are supposed to be in the catchment area for this fac..?"
lab var m0_a6b_long "M0-A6b. Longitude"
lab var m0_a6a_lat "M0-A6a. Latitude"
lab var m0_a6c_alt "M0-A6c. Altitude"


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

rename (how_many_beds_are_availabl_201 how_many_beds_are_dedica_202a how_many_beds_are_dedica_202b does_facility_have_space_204 does_facility_have_205 ///
		is_this_facility_connected_206 thinking_back_over_the_207 does_this_facility_have_208) (m0_201 m0_202a m0_202b m0_204 m0_205 ///
		m0_206 m0_207 m0_208)

rename (what_other_sources_of_209___1 what_other_sources_of_209___2 what_other_sources_of_209___3 ///
		what_other_sources_of_209___4 what_other_sources_of_209___98 specify_other_sources_of_209 ///
		does_this_facility_have_210 what_is_the_most_com_211 specify_other_common_213 is_the_water_from_this_212 ///
		is_there_a_time_of_the_yea is_there_a_toilet_latrine_215 what_type_of_toilet_if_mul does_this_facility_have_216 ///
		does_this_facility_have_217 does_this_facility_have_218 does_this_facility_have_219 is_there_access_to_email_220 ///
		does_this_facility_have_221 how_many_ambulances_222 does_this_facility_have_223 family_planning_does_301) ///
		(m0_209a_et m0_209b_et m0_209c_et m0_209d_et m0_209_dk_et m0_209_oth_et m0_210 m0_211 m0_211_oth m0_212 m0_213 ///
		m0_214 m0_215 m0_216 m0_217 m0_218 m0_219 m0_220 m0_221 m0_222 m0_223 m0_301)

* In 200's there's a mismatch between var name # and q #. I went with how Shalom had it coded before (var number after 215).

rename (pmtct_does_this_facility_303 obstetric_and_newborn_304 caesarean_section_does_305a has_a_caesarean_section_305b ///
		immunization_does_this_306 child_preventive_and_307a anc_does_this_facility_pro b_pnc_does_this_facility_307b ///
		cervical_cancer_screening adolescent_health_does_308 hiv_testing_does_this_309 hiv_treatment_does_this_310 ///
		hiv_care_and_support_311 stis_does_this_facility_312 tb_does_this_facility_offe_313 malaria_does_this_facility_314) ///
		(m0_303 m0_304 m0_305a m0_305b m0_306 m0_307a m0_307b m0_307c m0_307d m0_308 m0_309 m0_310 m0_311 m0_312 m0_313 m0_314)

rename (ncds_does_this_facility_315a ncds_does_this_facility_315b ncds_does_this_facility_315c ncds_does_this_facility_316d ///
		ncds_does_this_facility_316e ncds_does_this_facility_316f ntds_does_this_facility_316 surgery_does_this_facility_317 ///
		blood_transfusion_does_318 abortion_does_this_facilit_319) (m0_315a m0_315b m0_315c m0_315d m0_315e m0_315f m0_316 m0_317 m0_318 m0_319)

rename (blood_pressure_apparatus_401 status_of_the_blood_preasu adult_weighing_scale_402 status_of_adult_weighing ///
		infant_weighing_scale_403 status_of_infant_weighing measuring_tape_height_404 status_of_measuring_tape ///
		thermometer_405 status_of_thermometer stethoscope_406 status_of_stethoscope does_this_facility_conduct_407) ///
		(m0_401 m0_401a m0_402 m0_402a m0_403 m0_403a m0_404 m0_404a m0_405 m0_405a m0_406 m0_406a m0_407)

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
		m0_503c_et m0_503d_et m0_503e_et m0_503f_et m0_504 m0_505 m0_506 m0_507 m0_508 m0_508a_et m0_601 m0_601a m0_602 ///
		m0_603 m0_604 m0_605 m0_605a m0_701 m0_702 m0_703 m0_703_other m0_704 m0_705 m0_706 m0_707)
		

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

rename (prolonged_obstructed_jan prolonged_obstructed_feb prolonged_obstructed_mar postpartum_haemorrhage_apr ///
		prolonged_obstructed_may prolonged_obstructed_june prolonged_obstructed_july prolonged_obstructed_agu ///
		prolonged_obstructed_sep prolonged_obstructed_oct prolonged_obstructed_nov prolonged_obstructed_dec) (m0_806_jan ///
		m0_806_feb m0_806_mar m0_806_apr m0_806_may m0_806_jun m0_806_jul m0_806_aug m0_806_sep m0_806_oct m0_806_nov m0_806_dec)
		
* CHECK postpartum_haemorrhage_apr - there is also postpartum_haemorrhage_cas - this looks right based on Redcap PDF 

rename (severe_pre_eclampsia_jan severe_pre_eclampsia_feb severe_pre_eclampsia_mar ///
		severe_pre_eclampsia_eclam_apr severe_pre_eclampsia_may severe_pre_eclampsia_jun ///
		severe_pre_eclampsia_jul severe_pre_eclampsia_aug severe_pre_eclampsia_sep ///
		severe_pre_eclampsia_oct severe_pre_eclampsia_nov severe_pre_eclampsia_dec) ///
		(m0_807_jan m0_807_feb m0_807_mar m0_807_apr m0_807_may m0_807_jun m0_807_jul m0_807_aug ///
		m0_807_sep m0_807_oct m0_807_nov m0_807_dec)

rename (maternal_deaths_for_jan maternal_deaths_for_feb maternal_deaths_for_mar maternal_deaths_for_april ///
		maternal_deaths_for_may maternal_deaths_for_june maternal_deaths_for_july maternal_deaths_for_august ///
		maternal_deaths_for_sep maternal_deaths_for_oct maternal_deaths_for_nov maternal_deaths_for_dec) (m0_808_jan ///
		m0_808_feb m0_808_mar m0_808_apr m0_808_may m0_808_jun m0_808_jul m0_808_aug m0_808_sep m0_808_oct m0_808_nov m0_808_dec)

rename (stillbirths_for_january stillbirths_for_february stillbirths_for_march stillbirths_for_april stillbirths_for_may ///
		stillbirths_for_june stillbirths_for_july stillbirths_for_august stillbirths_for_september stillbirths_for_october ///
		stillbirths_for_november stillbirths_for_december) ///
		(m0_809_jan m0_809_feb m0_809_mar m0_809_apr m0_809_may m0_809_jun m0_809_jul ///
		m0_809_aug m0_809_sep m0_809_oct m0_809_nov m0_809_dec)

rename (severe_pre_eclampsia_cases severe_pre_eclampsia_cases_feb severe_pre_eclampsia_cases_mar ///
		severe_pre_eclampsia_cases_apr severe_pre_eclampsia_cases_may severe_pre_eclampsia_cases_jun ///
		severe_pre_eclampsia_cases_jul severe_pre_eclampsia_cases_aug severe_pre_eclampsia_cases_sept ///
		severe_pre_eclampsia_cases_oct severe_pre_eclampsia_cases_nov severe_pre_eclampsia_cases_dec) ///
		(m0_810_jan m0_810_feb m0_810_mar m0_810_apr m0_810_may m0_810_jun m0_810_jul ///
		m0_810_aug m0_810_sep m0_810_oct m0_810_nov m0_810_dec)

rename (early_neonatal_deaths_jan early_neonatal_deaths_feb early_neonatal_deaths_mar ///
		early_neonatal_deaths_firs early_neonatal_deaths_may early_neonatal_deaths_june ///
		early_neonatal_deaths_july early_neonatal_deaths_aug early_neonatal_deaths_sep ///
		early_neonatal_deaths_oct early_neonatal_deaths_nov early_neonatal_deaths_dec) ///
		(m0_811_jan m0_811_feb m0_811_mar m0_811_apr m0_811_may m0_811_jun m0_811_jul ///
		m0_811_aug m0_811_sep m0_811_oct m0_811_nov m0_811_dec)

rename (referrals_out_of_this_jan referrals_out_of_this_feb referrals_out_of_this_mar ///
		referrals_out_of_this_april referrals_out_of_this_may referrals_out_of_this_june ///
		referrals_out_of_this_july referrals_out_of_this_aug referrals_out_of_this_sep ///
		referrals_out_of_this_oct referrals_out_of_this_nov referrals_out_of_this_dec) ///
		(m0_812_jan m0_812_feb m0_812_mar m0_812_apr m0_812_may m0_812_jun m0_812_jul ///
		m0_812_aug m0_812_sep m0_812_oct m0_812_nov m0_812_dec)

rename (number_of_postnatal_jan number_of_postnatal_feb number_of_postnatal_mar ///
		number_of_postnatal_april number_of_postnatal_may number_of_postnatal_june ///
		number_of_postnatal_july number_of_postnatal_aug number_of_postnatal_sep ///
		number_of_postnatal_oct number_of_postnatal_nov number_of_postnatal_dec) ///
		(m0_813_jan m0_813_feb m0_813_mar m0_813_apr m0_813_may m0_813_jun m0_813_jul ///
		m0_813_aug m0_813_sep m0_813_oct m0_813_nov m0_813_dec)

rename (january_instrumental_deliveries february_instrumental_deliveries march_instrumental_deliveries ///
		april_instrumental_deliveries may_instrumental_deliveries june_instrumental_deliveries ///
		july_instrumental_deliveries august_instrumental_deliveries september_instrumental_deliverie ///
		october_instrumental_deliveries november_instrumental_deliveries december_instrumental_deliveries ///
		january_early_neonatal_death february_early_neonatal_death march_early_neonatal_death ///
		april_early_neonatal_death may_early_neonatal_death june_early_neonatal_death ///
		july_early_neonatal_death august_early_neonatal_death september_early_neonatal_death ///
		october_early_neonatal_death november_early_neonatal_death december_early_neonatal_death ///
		module_0_facility_assessment_com) (m0_814_jan_et m0_814_feb_et m0_814_mar_et m0_814_apr_et ///
		m0_814_may_et m0_814_jun_et m0_814_jul_et m0_814_aug_et m0_814_sep_et m0_814_oct_et m0_814_nov_et ///
		m0_814_dec_et m0_815_jan_et m0_815_feb_et m0_815_mar_et m0_815_apr_et m0_815_may_et m0_815_jun_et ///
		m0_815_jul_et m0_815_aug_et m0_815_sep_et m0_815_oct_et m0_815_nov_et m0_815_dec_et m0_complete_et)

* STEP TWO: ADD VALUE LABELS		                  
	gen facility = m0_a5_fac
	char facility[Original_ET_Varname] `m0_a5_fac[Original_ET_Varname]'
	char facility[Module] 0
	
	lab def facility 1"Meki Catholic Primary Clinic (01)" 2"Bote Health Center (02)" ///
	3"Meki Health Center (03)" 4"Adami Tulu Health Center (04)" 5"Bulbula Health Center (05)" ///
	6"Dubisa Health Center (06)" 7"Olenchiti Primary Hospital (07)" 8"Awash Malkasa Health Center (08)" ///
	9"koka Health Center (09)" 10"Biyo Health Center (10)" 11"Ejersa Health Center (11)" ///
	13"Noh Primary Clinic (13)" 14"Adama Health Center (14)" 15"Family Guidance Nazret Specialty Clinic" ///
	16"Biftu (16)" 17"Bokushenen (17)" 18"Adama Teaching Hospital (18)" 19"Hawas (19)" ///
	20"Medhanialem Hospital (20)" 21"Sister Aklisiya Hospital (21)" 22"Marie stopes Specialty Clinic (22)" 96"St. Francis Catholic Health Center (23)"
	lab val facility facility 
	
	lab def  m0_a8_fac_own 1"GOVERNMENT/PUBLIC" 2"NGO/NOT-FOR-PROFIT" 3"PRIVATE-FOR-PROFIT" 4"MISSION/FAITH-BASED"
	lab val m0_a8_fac_own m0_a8_fac_own

	lab def m0_a6_fac_type 1"General hospital" 2"Primary hospital" 3"Health center" 4"MCH Specialty Clinic/Center" 
	lab val m0_a6_fac_type m0_a6_fac_type

* STEP FOUR: LABELING VARIABLES
lab var facility "Facility name and ID"
lab var m0_101a "M0-101a. Medical doctor: How many are currently assigned, employed, or seconded?"
lab var m0_101b "M0-101b. Medical doctor: Part time?"
lab var m0_101c "M0-101c. Medical doctor: How many vacancies are there?"
lab var m0_101d "M0-101d. Medical doctor: How many currently provide obsetric and newborn care"

lab var m0_102a "M0-102a. OBGYN: How many are currently assigned, employed, or seconded?"
lab var m0_102b "M0-102b. OBGYN: Part time?"
lab var m0_102c "M0-102c. OBGYN: How many vacancies are there?"
lab var m0_102d "M0-102d. OBGYN: How many currently provide obsetric and newborn care"

lab var m0_103a "M0-103a. General surgeon: How many are currently assigned, employed, or seconded?"
lab var m0_103b "M0-103b. General surgeon: Part time?"
lab var m0_103c "M0-103c. General surgeon: How many vacancies are there?"
lab var m0_103d "M0-103d. General surgeon: How many currently provide obsetric and newborn care"

lab var m0_104a "M0-104a. Anesthesiologist: How many are currently assigned, employed, or seconded?"
lab var m0_104b "M0-104b. Anesthesiologist: Part time?"
lab var m0_104c "M0-104c. Anesthesiologist: How many vacancies are there?"
lab var m0_104d "M0-104d. Anesthesiologist: How many currently provide obsetric and newborn care"

lab var m0_105a "M0-105a. Pediatrician: How many are currently assigned, employed, or seconded?"
lab var m0_105b "M0-105b. Pediatrician: Part time?"
lab var m0_105c "M0-105c. Pediatrician: How many vacancies are there?"
lab var m0_105d "M0-105d. Pediatrician: How many currently provide obsetric and newborn care"

lab var m0_106a "M0-106a. Neonatalogist: How many are currently assigned, employed, or seconded?"
lab var m0_106b "M0-106b. Neonatalogist: Part time?"
lab var m0_106c "M0-106c. Neonatalogist: How many vacancies are there?"
lab var m0_106d "M0-106d. Neonatalogist: How many currently provide obsetric and newborn care"

lab var m0_107a "M0-107a. Emergency surgical officer: How many are currently assigned, employed, or seconded?"
lab var m0_107b "M0-107b. Emergency surgical officer: Part time?"
lab var m0_107c "M0-107c. Emergency surgical officer: How many vacancies are there?"
lab var m0_107d "M0-107d. Emergency surgical officer: How many currently provide obsetric and newborn care"

lab var m0_108a "M0-108a. Midwife BSc: How many are currently assigned, employed, or seconded?"
lab var m0_108b "M0-108b. Midwife BSc: Part time?"
lab var m0_108c "M0-108c. Midwife BSc: How many vacancies are there?"
lab var m0_108d "M0-108d. Midwife BSc: How many currently provide obsetric and newborn care"

lab var m0_109a "M0-109a. Midwife diploma: How many are currently assigned, employed, or seconded?"
lab var m0_109b "M0-109b. Midwife diploma: Part time?"
lab var m0_109c "M0-109c. Midwife diploma: How many vacancies are there?"
lab var m0_109d "M0-109d. Midwife diploma: How many currently provide obsetric and newborn care"

lab var m0_110a "M0-110a. Nurse BSc: How many are currently assigned, employed, or seconded?"
lab var m0_110b "M0-110b. Nurse BSc: Part time?"
lab var m0_110c "M0-110c. Nurse BSc: How many vacancies are there?"
lab var m0_110d "M0-110d. Nurse BSc: How many currently provide obsetric and newborn care"

lab var m0_111a "M0-111a. Nurse diploma: How many are currently assigned, employed, or seconded?"
lab var m0_111b "M0-111b. Nurse diploma: Part time?"
lab var m0_111c "M0-111c. Nurse diploma: How many vacancies are there?"
lab var m0_111d "M0-111d. Nurse diploma: How many currently provide obsetric and newborn care"

lab var m0_112a "M0-112a. Health officer: How many are currently assigned, employed, or seconded?"
lab var m0_112b "M0-112b. Health officer: Part time?"
lab var m0_112c "M0-112c. Health officer: How many vacancies are there?"
lab var m0_112d "M0-112d. Health officer: How many currently provide obsetric and newborn care"

lab var m0_113a "M0-113a. Anesthetist: How many are currently assigned, employed, or seconded?"
lab var m0_113b "M0-113b. Anesthetist: Part time?"
lab var m0_113c "M0-113c. Anesthetist: How many vacancies are there?"
lab var m0_113d "M0-113d. Anesthetist: How many currently provide obsetric and newborn care"

lab var m0_114a "M0-114a. Lab tech: How many are currently assigned, employed, or seconded?"
lab var m0_114b "M0-114b. Lab tech: Part time?"
lab var m0_114c "M0-114c. Lab tech: How many vacancies are there?"
lab var m0_114d "M0-114d. Lab tech: How many currently provide obsetric and newborn care"

lab var m0_115a_et "M0-115a. Medical doctor: Physically present M-F during day?"
lab var m0_115b_et "M0-115b. Specialist: Physically present M-F during day?"
lab var m0_115c_et "M0-115c: Emergency surgical officer: Physically present M-F during day?"
lab var m0_115d_et "M0-115d. Health officer: Physically present M-F during day?"
lab var m0_115e_et "M0-115e. Midwife: Physically present M-F during day?"
lab var m0_115f_et "M0-115f. Nurse: Physically present M-F during day?"
lab var m0_115g_et "M0-115g. Anesthesiologist: Physically present M-F during day?"
lab var m0_115h_et "M0-115h. Lab tech: Physically present M-F during day?"
lab var m0_115i_et "M0-115i. None of the above: Physically present M-F during day?"

lab var m0_116a_et "M0-116a. Medical doctor: On call M-F during the day"
lab var m0_116b_et "M0-116b. Specialist: On call M-F during the day"
lab var m0_116c_et "M0-116c. Emergency surgical officer: On call M-F during the day"
lab var m0_116d_et "M0-116d. Health officer: On call M-F during the day"
lab var m0_116e_et "M0-116e. Midwife: On call M-F during the day"
lab var m0_116f_et "M0-116f. Nurse: On call M-F during the day"
lab var m0_116g_et "M0-116g. Anesthesiologist: On call M-F during the day"
lab var m0_116h_et "M0-116h. Lab tech: On call M-F during the day"
lab var m0_116i_et "M0-116i. None of the above: On call M-F during the day"

lab var m0_117a_et "M0-117a. Medical doctor: Physically present M-F at night"
lab var m0_117b_et "M0-117b. Specialist: Physically present M-F at night"
lab var m0_117c_et "M0-117c. Emergency surgical officer: Physically present M-F at night"
lab var m0_117d_et "M0-117d. Health officer: Physically present M-F at night"
lab var m0_117e_et "M0-117e. Midwife: Physically present M-F at night"
lab var m0_117f_et "M0-117f. Nurse: Physically present M-F at night"
lab var m0_117g_et "M0-117g. Anesthesiologist: Physically present M-F at night"
lab var m0_117h_et "M0-117h. Lab tech: Physically present M-F at night"
lab var m0_117i_et "M0-117i. None of the above: Physically present M-F at night"


lab var m0_118a_et "M0-118a. Medical doctor: On call M-F at night"
lab var m0_118b_et "M0-118b. Specialist: On call M-F at night"
lab var m0_118c_et "M0-118c. Emergency surgical officer: On call M-F at night"
lab var m0_118d_et "M0-118d. Health officer: On call M-F at night"
lab var m0_118e_et "M0-118e. Midwife: On call M-F at night"
lab var m0_118f_et "M0-118f. Nurse: On call M-F at night"
lab var m0_118g_et "M0-118g. Anesthesiologist: On call M-F at night"
lab var m0_118h_et "M0-118h. Lab tech: On call M-F at night"
lab var m0_118i_et "M0-118i. None of the above: On call M-F at night"

lab var m0_119a_et "M0-119a. Medical doctor: Physically present Sat, Sun and holidays during day"
lab var m0_119b_et "M0-119c. Specialist:  Physically present Sat, Sun and holidays during day"
lab var m0_119c_et "M0-119d. Emerg surg officer:  Physically present Sat, Sun and holidays..."
lab var m0_119d_et "M0-119d. Health officer:  Physically present Sat, Sun and holidays during day"
lab var m0_119e_et "M0-119e. Midwife:  Physically present Sat, Sun and holidays during day"
lab var m0_119f_et "M0-119f. Nurse:  Physically present Sat, Sun and holidays during day"
lab var m0_119g_et "M0-119g. Anesthesiologist:  Physically present Sat, Sun and holidays during day"
lab var m0_119h_et "M0-119h. Lab tech: Physically present Sat, Sun and holidays during day"
lab var m0_119i_et "M0-119i. None of the above: Physically present Sat, Sun and holidays during day"             

lab var m0_120a_et "M0-120a. Medical doctor: On call Sat, Sun, and holidays during day"
lab var m0_120b_et "M0-120b. Specialist: On call Sat, Sun, and holidays during day"
lab var m0_120c_et "M0-120c. Emergency surgical officer: On call Sat, Sun, and holidays during day"
lab var m0_120d_et "M0-120d. Health officer: On call Sat, Sun, and holidays during day"
lab var m0_120e_et "M0-120e. Midwife: On call Sat, Sun, and holidays during day"
lab var m0_120f_et "M0-120f. Nurse: On call Sat, Sun, and holidays during day"
lab var m0_120g_et "M0-120g. Anesthesiologist: On call Sat, Sun, and holidays during day"
lab var m0_120h_et "M0-120h. Lab tech: On call Sat, Sun, and holidays during day"
lab var m0_120i_et "M0-120i. None of the above: On call Sat, Sun, and holidays during day"

lab var m0_121a_et "M0-121a. Medical doctor: Physically present Sat, Sun and holidays at night"
lab var m0_121b_et "M0-121b. Specialist: Physically present Sat, Sun and holidays at night"
lab var m0_121c_et "M0-121c. Emergency surgical officer: Physically present Sat, Sun and holidays at night"
lab var m0_121d_et "M0-121d. Health officer: Physically present Sat, Sun and holidays at night"
lab var m0_121e_et "M0-121e. Midwife: Physically present Sat, Sun and holidays at night"
lab var m0_121f_et "M0-121f. Nurse: Physically present Sat, Sun and holidays at night"
lab var m0_121g_et "M0-121g. Anesthesiologist: Physically present Sat, Sun and holidays at night"
lab var m0_121h_et "M0-121h. Lab tech: Physically present Sat, Sun and holidays at night"
lab var m0_121i_et "M0-121i. None of the above: Physically present Sat, Sun and holidays at night"

lab var m0_122a_et "M0-122a. Medical doctor: On call Sat, Sun and holidays at night"
lab var m0_122b_et "M0-122b. Specialist: On call Sat, Sun and holidays at night"
lab var m0_122c_et "M0-122c. Emergency surgical officer: On call Sat, Sun and holidays at night"
lab var m0_122d_et "M0-122d. Health officer: On call Sat, Sun and holidays at night"
lab var m0_122e_et "M0-122e. Midwife: On call Sat, Sun and holidays at night"
lab var m0_122f_et "M0-122f. Nurse: On call Sat, Sun and holidays at night"
lab var m0_122g_et "M0-122g. Anesthesiologist: On call Sat, Sun and holidays at night"
lab var m0_122h_et "M0-122h. Lab tech: On call Sat, Sun and holidays at night"
lab var m0_122i_et "M0-122i. None of the above:"
  
lab var m0_1a_et "M0-Eth-1-a. How many degree midwives are currently providing ANCservices?"
lab var m0_1b_et "M0-Eth-1-1b. How many diploma midwives are currently providing ANCservices?"
lab var m0_1c_et "M0-Eth-1-1c. How many degree nurses are currently providing ANCservices?"
lab var m0_1d_et "M0-Eth-1-1d. How many diploma nurses are currently providing ANCservices?"
lab var m0_1e_et "M0-Eth-1-1e. How many health offi cer are currently providing ANCservices?"
lab var m0_1f_et "M0-Eth-1-1f. How many emergency surgical offi cer are currentlyproviding ANC services?"
lab var m0_1g_et "M0-Eth-1-1g. How many general practitioner are currently providingANC services?"
lab var m0_2a_et "M0-Eth- 2-1a. How many degree midwives are currently providingdelivery service?"
lab var m0_2b_et "M0-Eth- 2-1b. How many diploma midwives are currently providingdelivery service?"
lab var m0_2c_et "M0-Eth- 2-1c. How many degree nurse are currently providing deliveryservice?"
lab var m0_2d_et "M0-Eth- 2-1d. How many diploma nurse are currently providing deliveryservice?"
lab var m0_2e_et "M0-Eth- 2-1e. How many health offi cer are currently providing deliveryservice?"
lab var m0_2f_et "M0-Eth- 2-1f. How many emergency surgical offi cer are currentlyproviding delivery service?"
lab var m0_2g_et "M0-Eth- 2-1g. How many general practitioner are currently providingdelivery service?"
lab var m0_3a_et "M0-ETh-3-1a. How many degree midwives are currently providingPostnatal Care (PNC)?"
lab var m0_3b_et "M0-ETh-3-1b. How many diploma midwives are currently providingPostnatal Care (PNC)?"
lab var m0_3c_et "M0-ETh-3-1c. How many degree nurse are currently providing PostnatalCare (PNC)?"
lab var m0_3d_et "M0-ETh-3-1d. How many diploma nurse are currently providingPostnatal Care (PNC)?"
lab var m0_3e_et "M0-ETh-3-1e. How many health offi cer are currently providing PostnatalCare (PNC)?"
lab var m0_3f_et "M0-ETh-3-1f. How many emergency surgical offi cer are currentlyproviding Postnatal Care (PNC)?"
lab var m0_3g_et "M0-ETh-3-1g. How many general practitioner are currently providingPostnatal Care (PNC)?"
lab var m0_4a_et "M0-ETh-4-1a. How many degree midwives are currently providingEPI/Immunization service?"
lab var m0_4b_et "M0-ETh-4-1b. How many diploma midwives are currently providingEPI/Immunization service?"
lab var m0_4c_et "M0-ETh-4-1c. How many degree nurses are currently providingEPI/Immunization service?"
lab var m0_4d_et "M0-ETh-4-1d. How many diploma nurses are currently providingEPI/Immunization service?"
lab var m0_4e_et "M0-ETh-4-1e. How many health offi cers are currently providingEPI/Immunization service?"
lab var m0_4f_et "M0-ETh-4-1f. How many emergency surgical offi cer are currentlyproviding EPI/Immunization service?"
lab var m0_4g_et "M0-ETh-4-1g. How many general practitioner are currently providingEPI/Immunization service?"

lab var m0_201 "M0-201. How many beds are available for patients in this facility?"
lab var m0_202a "M0-202. How many beds are dedicated exclusively for OBGYN patients (ANC, postpartum...)?"
lab var m0_202b "M0-203. Beds dedicated exclusively to: patients in 1st/2nd stage of labor"

lab var m0_204 "M0-204. Does this facility have a separate space for women to labor?"
lab var m0_205 "M0-205. Does this facility have a space for women to recover post-delivery?"
lab var m0_206 "M0-206. Is this facility connected to the national electricity grid...?"
lab var m0_207 "M0-207. In the last 7 days, has the power from the been interrupted...?"
lab var m0_208 "M0-208.Does this facility have other sources of electricity...?"

lab var m0_209a_et "M0-209a. What other sources of electricity does this facility have?: Fuel-operated generator"
lab var m0_209b_et "M0-209b. What other sources of electricity does this facility have?: Battery-operated generator"
lab var m0_209c_et "M0-209c. What other sources of electricity does this facility have?: Solar system"
lab var m0_209d_et "M0-209d. What other sources of electricity does this facility have?: Other"
lab var m0_209_dk_et "M0-209e. What other sources of electricity does this facility have?: Don't know'"
lab var m0_209_oth_et "M0-209. What other sources of electricity does this facility have?: Other, specify"
lab var m0_210 "M0-210. Does this facility have water for its basic functions? "
lab var m0_211 "M0-211. What is the most commonly used source of water for the facility at this time?"
lab var m0_211_oth "M0-211. What is the most commonly used source of water for the facility at this time?: Other"
lab var m0_212 "M0-212. Is the water from this source onsite, within 500 meters of the facility, or beyond 500 meters of the facility?"
lab var m0_213 "M0-213. Is there a time of the year when the facility routinely has a severe shortage or lack of water?"
lab var m0_214 "M0-214. Is there a toilet (latrine) on premises that is accessible for patient use? "
lab var m0_215 "M0-215. What type of toilet?"
lab var m0_216 "M0-216. Does this facility have a functioning land line telephone that is available to call outside at all times client services are offered? "
lab var m0_217 "M0-217. Does this facility have a functioning cellular telephone or a private cellular phone that is supported by the facility?"
lab var m0_218 "M0-218. Does this facility have a functioning short-wave radio for radio calls?"
lab var m0_219 "M0-219. Does this facility have a functioning computer?"
lab var m0_220 "M0-220. Is there access to email or internet within the facility today?"
lab var m0_221 "M0-221. Does this facility have a functional ambulance or other vehicle for emergency transportation...operates from this facility?"
lab var m0_222 "M0-222. How many ambulances does this facility have stationed here, or that operate from this facility?"
lab var m0_223 "M0-223. Does this facility have access to an ambulance or other vehicle for emergency transport...from another nearby facility?"

lab var m0_301 "M0-301. FAMILY PLANNING:   Does this facility offer family planning services? "
lab var m0_303 "M0-303. PMTCT:   Does this facility offer services for the prevention of mother-to-child transmission of HIV (PMTCT)?"
lab var m0_304 "M0-304. OBSTETRIC AND NEWBORN CARE:   Does this facility offer delivery (including normal delivery, basic emergency obstetric care, and/or comprehensive emergency obstetric care) and/or newborn care services?"
lab var m0_305a "M0-305a. CAESAREAN SECTION:   Does this facility offer caesarean sections? "
lab var m0_305b "M0-305b. Has a caesarean section been carried out in the last 12 months by providers of delivery services as part of their work in this facility?"
lab var m0_306 "M0-306. IMMUNIZATION:   Does this facility offer immunization services? "

lab var m0_307a "M0-307a. CHILD PREVENTIVE AND CURATIVE CARE: Does this facility offer preventative and curative care services for children under 5?"
lab var m0_307b "M0-307b. ANC: Does this facility provide antenatal care? "
lab var m0_307c "M0-307c. PNC: Does this facility off er postnatal care services for newborns?"
lab var m0_307d "M0-307d. Cervical cancer screening: Does this facility provide cervical screening (pap smear or VIA singlevisit approach)"
lab var m0_308 "M0-308. ADOLESCENT HEALTH: Does this facility offer adolescent health services? ?"
lab var m0_309 "M0-309. HIV TESTING: Does this facility offer HIV counselling and testing services? "
lab var m0_310 "M0-310. HIV TREATMENT: Does this facility offer HIV & AIDS antiretroviral prescription or antiretroviral treatment follow-up services? "
lab var m0_311 "M0-311. HIV CARE AND SUPPORT:   Does this facility offer HIV & AIDS care and support services, including treatment of opportunistic infections and provisions of palliative care?"
lab var m0_312 "M0-312. STIs:   Does this facility offer diagnosis or treatment of STIs other than HIV? "
lab var m0_313 "M0-313. TB:   Does this facility offer diagnosis, treatment prescription, or treatment follow-up of tuberculosis? "
lab var m0_314 "M0-314. MALARIA:   Does this facility offer diagnosis or treatment of malaria?"
lab var m0_315a "M0-315a. NCDs:   Does this facility offer diagnosis or management of Diabetes "
lab var m0_315b "M0-315b. NCDs:   Does this facility offer diagnosis or management of Cardiovascular disease"
lab var m0_315c "M0-315c. NCDs:   Does this facility offer diagnosis or management of Chronic respiratory disease / Does this facility offer diagnosis or management of Cardiovascular disease "
lab var m0_315d "M0-315d. NCDs:   Does this facility offer diagnosis or management of Cancer diagnosis"
lab var m0_315e "M0-315e. NCDs:   Does this facility offer diagnosis or management of Cancer treatment"
lab var m0_315f "M0-315f. NCDs: Does this facility off er diagnosis or management of Mental healthservices"
lab var m0_316 "M0-316. NTDs:   Does this facility offer diagnosis or management of neglected tropical diseases, such as onchocerciasis, lymphatic Fili arsis, schistosomiasis, soil transmitted helminths, trachoma, dracunculiasis, podoconiosis, or leishmaniosis?"
lab var m0_317 "M0-317. SURGERY:   Does this facility offer any surgical services (including minor surgery such as suturing, circumcision, wound debridement, etc.), or caesarean section?"
lab var m0_318 "M0-318. BLOOD TRANSFUSION:   Does this facility offer blood transfusion services? "
lab var m0_319 "M0-319. ABORTION:   Does this facility offer safe abortion care?"

lab var m0_401 "M0-401. Blood pressure apparatus (may be digital or manualsphygmomanometer with stethoscope)"
lab var m0_401a "M0-401a. Status of the blood pressure apparatus"
lab var m0_402 "M0-402. Adult weighing scale"
lab var m0_402a "M0-402a. Status of Adult weighing scale radio"
lab var m0_403 "M0-403. Infant weighing scale - 100-gram gradation"
lab var m0_403a "M0-403a. Status of Infant weighing scale - 100 gram gradation"
lab var m0_404 "M0-404. Measuring tape-height board/stadiometer"
lab var m0_404a "M0-404a. Status of Measuring tape-height board/stadiometre"
lab var m0_405 "M0-405. Thermometer"
lab var m0_405a "M0-405a. Status of Thermometer"
lab var m0_406 "M0-406. Stethoscope"
lab var m0_406a "M0-406a. Status of Stethoscope"
lab var m0_407 "M0-407.Does this facility conduct any diagnostic testing including anyrapid diagnostic testing?"
lab var m0_408 "M0-408. Rapid malaria testing"
lab var m0_409 "M0-409. Rapid syphilis testing"
lab var m0_410 "M0-410. HIV rapid testing"
lab var m0_411 "M0-411. Urine rapid tests for pre gnancy"
lab var m0_412 "M0-412. Urine protein dipstick testing"
lab var m0_413 "M0-413. Urine glucose dipstick testing"
lab var m0_414 "M0-414. Urine ketone dipstick testi"
lab var m0_415 "M0-415. Dry Blood Spot (DBS) collection for HIV viral load or EID (Earlyinfant diagnosis"
lab var m0_416 "M0-416. Malaria rapid diagnostic kit"
lab var m0_417 "M0-417. Syphilis rapid test kit"
lab var m0_418 "M0-418. SD BIOLIN HIV rapid test kit"
lab var m0_419 "M0-419. STATPACK HIV rapid test kit"
lab var m0_420 "M0-420. ABON HIV rapid test kit"
lab var m0_421 "M0-421. Urine pregnancy test kit"
lab var m0_422 "M0-422. Dipsticks for urine protein"
lab var m0_423 "M0-423. Dipsticks for urine"
lab var m0_424 "M0-424. Dipsticks for urine ketone bodies"
lab var m0_425 "M0-425. Filter paper for collecting DBS"
lab var m0_426 "M0-426. Blood glucose tests using a glucometer"
lab var m0_427 "M0-427. Haemoglobin testing"
lab var m0_428 "M0-428. General microscopy/wet-mounts"
lab var m0_429 "M0-429. Malaria microscopy"
lab var m0_430 "M0-430. HIV antibody testing by ELISA"
lab var m0_431 "M0-431. Does this facility perform diagnostic x-rays, ultrasound, orcomputerized tomography?"
lab var m0_432 "M0-432. X-ray machine"
lab var m0_433 "M0-433. Ultrasound equipment"
lab var m0_434 "M0-434. CT scan"
lab var m0_435 "M0-435. ECG"


lab var m0_501 "M0-501. Does this facility ever refer a woman or newborn to another facility for care? "
lab var m0_502  "M0-502. To which facility does this facility usually refer women or newborns for care?"    

lab var m0_503a_et "M0-503. What strategies does this facility use to transport emergency patients from this facility? "
lab var m0_503b_et "M0-503. What strategies does this facility use to transport emergency patients from this facility? "
lab var m0_503c_et "M0-503. What strategies does this facility use to transport emergency patients from this facility? "
lab var m0_503d_et "M0-503. What strategies does this facility use to transport emergency patients from this facility? "
lab var m0_503e_et "M0-503. What strategies does this facility use to transport emergency patients from this facility? "
lab var m0_503f_et "M0-503. What strategies does this facility use to transport emergency patients from this facility? "
lab var m0_504 "M0-504. After this facility refers a patient, how often do you receive feedback about the treatment or outcomes of that patient?"
lab var m0_505 "M0-505. Does this facility have explicit written guidelines or protocols for the pre-referral management of major obstetric and newborn complications? "
lab var m0_506 "M0-506. Does this facility ever receive women or newborns who have been referred here from a different facility?"
lab var m0_507 "M0-507. Is there a system for staff to determine the priority of need and proper place of treatment of patients, what we call triage?"
lab var m0_508 "M0-508. Does this facility have a maternity waiting home? "
lab var m0_508a_et "M0-508a. Does the maternal waiting home currently functional"

lab var m0_601 "M0-601. Is formal payment required before receiving maternity services? "
lab var m0_601a "M0-601a. Is a woman expected to pay for/buy supplies and medicines for delivery? "
lab var m0_602 "M0-602. In an obstetric emergency, is payment required before receiving care?"
lab var m0_603 "M0-603. In an obstetric emergency, is the woman or her family asked to buy medicine or supplies prior to treatment? "
lab var m0_604 "M0-604. Is there a formal system in place to have fees for maternity services waived for poor women?"
lab var m0_605 "M0-605. Is there any informal system in place to have fees for maternity services waived for poor women? "
lab var m0_605a "M0-605a. Is there a fee schedule for services posted in a visible and public place? (Collect data by observation only that was posted or prepared document)"

lab var m0_701 "M0-701. Does this facility have a system in place to regularly collect maternal and newborn health services data? "
lab var m0_702 "M0-702. Does this facility report data to the health management information system (i.e., HMIS/DHIS2)? "
lab var m0_703 "M0-703. How frequently are MNH data reported to the HMIS?"
lab var m0_703_other "M0-703_Oth. Other"
lab var m0_704 "M0-704. Does this facility have a designated person, such as a data manager or Health Information Technologist, who is responsible for MNH services data?"
lab var m0_705 "M0-705.Is a labor and delivery ward register used at this facility?"
lab var m0_706 "M0-706. Does this facility have a designated person, such as a data manager or Health Information Technologist, who is responsible for MNH services data?"
lab var m0_707 "M0-705.Is a labor and delivery ward register used at this facility?"

lab var m0_801_jan "M0-801.1. Number of antenatal care visits (repeat visits) for January"
lab var m0_801_feb "M0-801.2. Number of antenatal care visits (repeat visits) for February"
lab var m0_801_mar "M0-801.3. Number of antenatal care visits (repeat visits) for March"
lab var m0_801_apr "M0-801.4. Number of antenatal care visits (repeatvisits) for April"
lab var m0_801_may "M0-801.5. Number of antenatal care visits (repeat visits) for May"
lab var m0_801_jun "M0-801.6. Number of antenatal care visits (repeat visits) for June"
lab var m0_801_jul "M0-801.7. Number of antenatal care visits (repeat visits) for July"
lab var m0_801_aug "M0-801.8. Number of antenatal care visits (repeat visits) for August"
lab var m0_801_sep "M0-801.9. Number of antenatal care visits (repeat visits) for September"
lab var m0_801_oct "M0-801.10. Number of antenatal care visits (repeat visits) for October"
lab var m0_801_nov "M0-801.11. Number of antenatal care visits (repeat visits) for November"
lab var m0_801_dec "M0-801.12. Number of antenatal care visits (repeat visits) for December"

lab var m0_802_jan "M0-802.1 Number of first antenatal care visits for January"
lab var m0_802_feb "M0-802.2 Number of first antenatal care visits for February "
lab var m0_802_mar "M0-802.3 Number of first antenatal care visits for March"
lab var m0_802_apr "M0-802.4 Number of first antenatal care visits for April"
lab var m0_802_may "M0-802.5 Number of first antenatal care visits for May"
lab var m0_802_jun "M0-802.6 Number of first antenatal care visits for June"
lab var m0_802_jul "M0-802.7 Number of first antenatal care visits for July"
lab var m0_802_aug "M0-802.8 Number of first antenatal care visits for August"
lab var m0_802_sep "M0-802.9 Number of first antenatal care visits for September"
lab var m0_802_oct "M0-802.10 Number of first antenatal care visits for October"
lab var m0_802_nov "M0-802.11 Number of first antenatal care visits for November"
lab var m0_802_dec "M0-802.12 Number of first antenatal care visits for December "

lab var m0_803_jan "M0-803.1. Number of vaginal deliveries for January"
lab var m0_803_feb "M0-803.2. Number of vaginal deliveries for February"
lab var m0_803_mar "M0-803.3. Number of vaginal deliveries for March"
lab var m0_803_apr "M0-803.4. Number of vaginal deliveries for April"
lab var m0_803_may "M0-803.5. Number of vaginal deliveries for May"
lab var m0_803_jun "M0-803.6. Number of vaginal deliveries for June"
lab var m0_803_jul "M0-803.7. Number of vaginal deliveries for July"
lab var m0_803_aug "M0-803.8. Number of vaginal deliveries for August"
lab var m0_803_sep "M0-803.9. Number of vaginal deliveries for September"
lab var m0_803_oct "M0-803.10. Number of vaginal deliveries for October"
lab var m0_803_nov "M0-803.11. Number of vaginal deliveries for November"
lab var m0_803_dec "M0-803.12. Number of vaginal deliveries for December"

lab var m0_804_jan "M0-804.1 Number of caesarean deliveries for January"
lab var m0_804_feb "M0-804.2 Number of caesarean deliveries for February"
lab var m0_804_mar "M0-804.3 Number of caesarean deliveries for March"
lab var m0_804_apr "M0-804.4 Number of caesarean deliveries for April"
lab var m0_804_may "M0-804.5 Number of caesarean deliveries for May"
lab var m0_804_jun "M0-804.6 Number of caesarean deliveries for June"
lab var m0_804_jul "M0-804.7 Number of caesarean deliveries for July"
lab var m0_804_aug "M0-804.8 Number of caesarean deliveries for August"
lab var m0_804_sep "M0-804.9 Number of caesarean deliveries for September"
lab var m0_804_oct "M0-804.10 Number of caesarean deliveries for October"
lab var m0_804_nov "M0-804.11 Number of caesarean deliveries for November"
lab var m0_804_dec "M0-804.12 Number of caesarean deliveries for December"

lab var m0_805_jan "M0-805.1. Postpartum haemorrhage cases for January"
lab var m0_805_feb "M0-805.2. Postpartum haemorrhage cases for February"
lab var m0_805_mar "M0-805.3. Postpartum haemorrhage cases for March"
lab var m0_805_apr "M0-805.4. Postpartum haemorrhage cases for April"
lab var m0_805_may "M0-805.5. Postpartum haemorrhage cases for May"
lab var m0_805_jun "M0-805.6. Postpartum haemorrhage cases for June"
lab var m0_805_jul "M0-805.7. Postpartum haemorrhage cases for July"
lab var m0_805_aug "M0-805.8. Postpartum haemorrhage cases for August"
lab var m0_805_sep "M0-805.9. Postpartum haemorrhage cases for September"
lab var m0_805_oct "M0-805.10. Postpartum haemorrhage cases for October"
lab var m0_805_nov "M0-805.11. Postpartum haemorrhage cases for November"
lab var m0_805_dec "M0-805.12. Postpartum haemorrhage cases for December"

lab var m0_806_jan "M0-806.1. Prolonged/obstructed labor cases for January"
lab var m0_806_feb "M0-806.2. Prolonged/obstructed labor cases for February"
lab var m0_806_mar "M0-806.3. Prolonged/obstructed labor cases for March"
lab var m0_806_apr "M0-806.4. Prolonged/obstructed labor cases for April"
lab var m0_806_may "M0-806.5. Prolonged/obstructed labor cases for May"
lab var m0_806_jun "M0-806.6. Prolonged/obstructed labor cases for June"
lab var m0_806_jul "M0-806.7. Prolonged/obstructed labor cases for July"
lab var m0_806_aug "M0-806.8. Prolonged/obstructed labor cases for August"
lab var m0_806_sep "M0-806.9. Prolonged/obstructed labor cases for September"
lab var m0_806_oct "M0-806.10. Prolonged/obstructed labor cases for October"
lab var m0_806_nov "M0-806.11. Prolonged/obstructed labor cases for November"
lab var m0_806_dec "M0-806.12. Prolonged/obstructed labor cases for December"

lab var m0_807_jan "M0-807.1. Severe pre-eclampsia cases for January"
lab var m0_807_feb "M0-807.2. Severe pre-eclampsia cases for February"
lab var m0_807_mar "M0-807.3. Severe pre-eclampsia cases for March"
lab var m0_807_apr "M0-807.4. Severe pre-eclampsia cases for April"
lab var m0_807_may "M0-807.5. Severe pre-eclampsia cases for May"
lab var m0_807_jun "M0-807.6. Severe pre-eclampsia cases for June"
lab var m0_807_jul "M0-807.7. Severe pre-eclampsia cases for July"
lab var m0_807_aug "M0-807.8. Severe pre-eclampsia cases for August"
lab var m0_807_sep "M0-807.9. Severe pre-eclampsia cases for September"
lab var m0_807_oct "M0-807.10. Severe pre-eclampsia cases for October"
lab var m0_807_nov "M0-807.11. Severe pre-eclampsia cases for November"
lab var m0_807_dec "M0-807.12. Severe pre-eclampsia cases for December"

lab var m0_808_jan "M0-808.1. Maternal deaths for January"
lab var m0_808_feb "M0-808.2. Maternal deaths for February"
lab var m0_808_mar "M0-808.3. Maternal deaths for March"
lab var m0_808_apr "M0-808.4. Maternal deaths for April"
lab var m0_808_may "M0-808.5. Maternal deaths for May"
lab var m0_808_jun "M0-808.6. Maternal deaths for June"
lab var m0_808_jul "M0-808.7. Maternal deaths for July"
lab var m0_808_aug "M0-808.8. Maternal deaths for August"
lab var m0_808_sep "M0-808.9. Maternal deaths for September"
lab var m0_808_oct "M0-808.10. Maternal deaths for October"
lab var m0_808_nov "M0-808.11. Maternal deaths for November"
lab var m0_808_dec "M0-808.12. Maternal deaths for December"

lab var m0_809_jan "M0-809.1. Stillbirths for January"
lab var m0_809_feb "M0-809.2. Stillbirths for February"
lab var m0_809_mar "M0-809.3. Stillbirths for March"
lab var m0_809_apr "M0-809.4. Stillbirths for April"
lab var m0_809_may "M0-809.5. Stillbirths for May"
lab var m0_809_jun "M0-809.6. Stillbirths for June"
lab var m0_809_jul "M0-809.7. Stillbirths for July"
lab var m0_809_aug "M0-809.8. Stillbirths for August"
lab var m0_809_sep "M0-809.9. Stillbirths for September"
lab var m0_809_oct "M0-809.10. Stillbirths for October"
lab var m0_809_nov "M0-809.11. Stillbirths for November"
lab var m0_809_dec "M0-809.12. Stillbirths for December"

lab var m0_810_jan "M0-810.1. Eclampsia cases for January"
lab var m0_810_feb "M0-810.2. Eclampsia cases for February"
lab var m0_810_mar "M0-810.3. Eclampsia cases for March"
lab var m0_810_apr "M0-810.4. Eclampsia cases for April"
lab var m0_810_may "M0-810.5. Eclampsia cases for May"
lab var m0_810_jun "M0-810.6. Eclampsia cases for June"
lab var m0_810_jul "M0-810.7. Eclampsia cases for July"
lab var m0_810_aug "M0-810.8. Eclampsia cases for August"
lab var m0_810_sep "M0-810.9. Eclampsia cases for September"
lab var m0_810_oct "M0-810.10. Eclampsia cases for December"
lab var m0_810_nov "M0-810.11. Eclampsia cases for November"
lab var m0_810_dec "M0-810.12. Eclampsia cases for December"

lab var m0_811_jan "M0-811.1. All Neonatal deaths (before 28 days) for January"
lab var m0_811_feb "M0-811.2. All Neonatal deaths (before 28 days) for February"
lab var m0_811_mar "M0-811.3. All Neonatal deaths (before 28 days) for March"
lab var m0_811_apr "M0-811.4. All Neonatal deaths (before 28 days) for April"
lab var m0_811_may "M0-811.5. All Neonatal deaths (before 28 days) for May"
lab var m0_811_jun "M0-811.6. All Neonatal deaths (before 28 days) for June"
lab var m0_811_jul "M0-811.7. All Neonatal deaths (before 28 days) for July"
lab var m0_811_aug "M0-811.8. All Neonatal deaths (before 28 days) for August"
lab var m0_811_sep "M0-811.9. All Neonatal deaths (before 28 days) for September"
lab var m0_811_oct "M0-811.10. All Neonatal deaths (before 28 days) for October"
lab var m0_811_nov "M0-811.11. All Neonatal deaths (before 28 days) for November"
lab var m0_811_dec "M0-811.12. All Neonatal deaths (before 28 days) for December"

lab var m0_812_jan "M0-812.1. Referrals out of this facility due to obstetric indications for January"
lab var m0_812_feb "M0-812.2. Referrals out of this facility due to obstetric indications for February"
lab var m0_812_mar "M0-812.3. Referrals out of this facility due to obstetric indications for March"
lab var m0_812_apr "M0-812.4. Referrals out of this facility due to obstetric indications for April"
lab var m0_812_may "M0-812.5. Referrals out of this facility due to obstetric indications for May"
lab var m0_812_jun "M0-812.6. Referrals out of this facility due to obstetric indications for June"
lab var m0_812_jul "M0-812.7. Referrals out of this facility due to obstetric indications for July"
lab var m0_812_aug "M0-812.8. Referrals out of this facility due to obstetric indications for August"
lab var m0_812_sep "M0-812.9. Referrals out of this facility due to obstetric indications for September"
lab var m0_812_oct "M0-812.10. Referrals out of this facility due to obstetric indications for October"
lab var m0_812_nov "M0-812.11. Referrals out of this facility due to obstetric indications for November"
lab var m0_812_dec "M0-812.12. Referrals out of this facility due to obstetric indications for December"

lab var m0_813_jan "M0-813.1. Number of postnatal care visits for January"
lab var m0_813_feb "M0-813.2. Number of postnatal care visits for February"
lab var m0_813_mar "M0-813.3. Number of postnatal care visits for March"
lab var m0_813_apr "M0-813.4. Number of postnatal care visits for April"
lab var m0_813_may "M0-813.5. Number of postnatal care visits for May"
lab var m0_813_jun "M0-813.6. Number of postnatal care visits for June"
lab var m0_813_jul "M0-813.7. Number of postnatal care visits for July"
lab var m0_813_aug "M0-813.8. Number of postnatal care visits for August"
lab var m0_813_sep "M0-813.9. Number of postnatal care visits for September"
lab var m0_813_oct "M0-813.10. Number of postnatal care visits for October"
lab var m0_813_nov "M0-813.11. Number of postnatal care visits for November"
lab var m0_813_dec "M0-813.12. Number of postnatal care visits for December"        

lab var m0_814_jan_et "M0-814.1. Number of instrumental deliveries for January"
lab var m0_814_feb_et "M0-814.2. Number of instrumental deliveries for February"
lab var m0_814_mar_et "M0-814.3. Number of instrumental deliveries for March"
lab var m0_814_apr_et "M0-814.4. Number of instrumental deliveries for April"
lab var m0_814_may_et "M0-814.5. Number of instrumental deliveries for May"
lab var m0_814_jun_et "M0-814.6. Number of instrumental deliveries for June"
lab var m0_814_jul_et "M0-814.7. Number of instrumental deliveries for July"
lab var m0_814_aug_et "M0-814.8. Number of instrumental deliveries for August"
lab var m0_814_sep_et "M0-814.9. Number of instrumental deliveries for September"
lab var m0_814_oct_et "M0-814.10. Number of instrumental deliveries for October"
lab var m0_814_nov_et "M0-814.11. Number of instrumental deliveries for November"
lab var m0_814_dec_et "M0-814.12. Number of instrumental deliveries for December"

lab var m0_815_jan_et "M0-815.1. Number of early neonatal death (first 24 hours) for January"
lab var m0_815_feb_et "M0-815.2. Number of early neonatal death (first 24 hours) for February"
lab var m0_815_mar_et "M0-815.3. Number of early neonatal death (first 24 hours) for March"
lab var m0_815_apr_et "M0-815.4. Number of early neonatal death (first 24 hours) for April"
lab var m0_815_may_et "M0-815.5. Number of early neonatal death (first 24 hours) for May"
lab var m0_815_jun_et "M0-815.6. Number of early neonatal death (first 24 hours) for June"
lab var m0_815_jul_et "M0-815.7. Number of early neonatal death (first 24 hours) for July"
lab var m0_815_aug_et "M0-815.8. Number of early neonatal death (first 24 hours) for August"
lab var m0_815_sep_et "M0-815.9. Number of early neonatal death (first 24 hours) for September"
lab var m0_815_oct_et "M0-815.10. Number of early neonatal death (first 24 hours) for October"
lab var m0_815_nov_et "M0-815.11. Number of early neonatal death (first 24 hours) for November"
lab var m0_815_dec_et "M0-815.12. Number of early neonatal death (first 24 hours) for December"

* STEP FIVE: ORDER VARIABLES

order m0_*, sequential
order record_id redcap_event_name m0_a1_date m0_a2_site m0_a3_subsite m0_a4_woreda_et m0_a4_woreda_et_oth m0_a5_fac facility ///
m0_a5_fac_oth m0_a6_fac_type m0_a6a_lat m0_a6b_long m0_a6c_alt m0_a8_fac_own m0_a9_urban m0_a13 m0_a14 m0_complete_et m0_id nameofdc redcap_data_access_group

* STEP THREE: RECODING MISSING VALUES


save "$et_data_final/eco_m0_et.dta", replace




