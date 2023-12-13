* Kenya ECohort Data Cleaning File 
* Created by Wen-Chien Yang
* Updated: Dec 6 2023

*------------------------------------------------------------------------------*

* Import Data 
clear all  

*--------------------DATA FILE:
import excel using "$ke_data/Module 0/MNHECOHORTSModule0Fa_DATA_2023-12-07_1419 updated.xlsx", firstrow clear //new data sent DEC 7 2023

*import delimited "C:\Users\wench\Desktop\ECohort study\cleaning dataset\KenyaM0\MNHECOHORTSModule0Fa_DATA_2023-10-11_1541", clear

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 25)
		* STEP TW0: ADD VALUE LABELS (starts at: line )
		* STEP THREE: RECODING MISSING VALUES (starts at: line )
		* STEP FOUR: LABELING VARIABLES (starts at: line )
		* STEP FIVE: ORDER VARIABLES (starts at: line )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*
	* STEP ONE: RENAME VARIABLES

* Meta data 
rename (latitude longitude) (m0_latitude m0_longitude)
rename (date_time county_name interviewer_name) (m0_datetime_ke m0_a4_site m0_id)
rename (facility_kiambu facility_kitui) (m0_facility_kiambu_ke m0_facility_kitui_ke)
rename (catchment_area catchment_pop) (m0_a13 m0_a14)

egen facility=rowmax(m0_facility_kiambu_ke m0_facility_kitui_ke)
replace facility=21 if facility==9 & m0_a4_site==1 // Kiambu facility 9 is St. Teresas Nursing Home
recode facility 1=7 2=2 3=1 4=21 5=10 6=4 7=11 8=18 9=6 10=9 11=8 12=15 13=16 ///
                14=20 15=5 16=13 17=17 18=14 19=12 20=3 21=19

lab var m0_latitude "Latitude"
lab var m0_longitude "Longitude"		
lab var m0_datetime_ke "Date/time of interview"
lab var m0_a4_site "County"
lab var m0_id "Interviewer name"
lab var m0_facility_kiambu_ke "Facility"
lab var m0_facility_kitui_ke "Facility"
lab var m0_a13 "M0-A13. "
lab var m0_a14 "M0-A14. "
 
 * 1. Staffing 
rename (med_num med_pt med_vac med_onc) (m0_101a m0_101b m0_101c m0_101d)
rename (gyn_num gyn_pt gyn_vac gyn_onc) (m0_102a m0_102b m0_102c m0_102d)
rename (surg_num surg_pt surg_vac surg_onc) (m0_103a m0_103b m0_103c m0_103d)
rename (anesthe_gist_num anesthe_gist_pt anesthe_gist_vac anesthe_gist_onc) (m0_104a m0_104b m0_104c m0_104d)
rename (paed_num paed_pt paed_vac paed_onc) (m0_105a m0_105b m0_105c m0_105d)
rename (neon_num neon_pt neon_vac neon_onc) (m0_106a m0_106b m0_106c m0_106d)
rename (midwife_num midwife_pt midwife_vac midwife_onc) (m0_108a m0_108b m0_108c m0_108d)
rename (nursecert_num nursecert_pt nursecert_vac nursecert_onc) (m0_109a m0_109b m0_109c m0_109d)
rename (nursebsc_num nursebsc_pt nursebsc_vac nursebsc_onc) (m0_110a m0_110b m0_110c m0_110d)
rename (nursedip_num nursedip_pt nursedip_vac nursedip_onc) (m0_111a m0_111b m0_111c m0_111d)
rename (clinicaloff_num clinicaloff_pt clinicaloff_vac clinicaloff_onc) (m0_112a m0_112b m0_112c m0_112d)
rename (anesthetist_num anesthetist_pt anesthetist_vac anesthetist_onc) (m0_113a m0_113b m0_113c m0_113d)
rename (labtech_num labtech_pt labtech_vac labtech_onc) (m0_114a m0_114b m0_114c m0_114d)
rename (famphy_num famphy_pt famphy_vac famphy_onc) (m0_famphy_a_ke m0_famphy_b_ke m0_famphy_c_ke m0_famphy_d_ke)
rename (nutritionist_num nutritionist_pt nutritionist_vac nutritionist_onc) ///
       (m0_nutritionist_a_ke m0_nutritionist_b_ke m0_nutritionist_c_ke m0_nutritionist_d_ke)
rename (mointern_onc cointern_onc) (m0_mointern_a_ke m0_cointern_b_ke)
rename (rad_num rad_pt rad_vac rad_onc)(m0_rad_a_ke m0_rad_b_ke m0_rad_c_ke m0_rad_d_ke)
*rename (pp_week_day oc_week_day pp_week_night oc_week_night pp_holiday_day oc_holiday_day pp_holiday_night oc_holiday_night) /// 
*	   (m0_115 m0_116 m0_117 m0_118 m0_119 m0_120 m0_121 m0_122) ///* need to check this
rename (staff_comments) (m0_staff_ke)

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

lab var m0_108a "M0-108a. Midwife BSc: How many are currently assigned, employed, or seconded?"
lab var m0_108b "M0-108b. Midwife BSc: Part time?"
lab var m0_108c "M0-108c. Midwife BSc: How many vacancies are there?"
lab var m0_108d "M0-108d. Midwife BSc: How many currently provide obsetric and newborn care"

* need to label m0_109f_ke m0_109g_ke m0_109h_ke m0_109i_ke (could not find labeling in the codebook)

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

lab var m0_famphy_a_ke "KE-specific: Family physicians: How many are currently assigned, employed, or seconded? "
lab var m0_famphy_b_ke "KE-specific: Family physicians: Part time?"
lab var m0_famphy_c_ke "KE-specific: Family physicians: How many vacancies are there?"
lab var m0_famphy_d_ke "KE-specific: Family physicians: How many currently provide obsetric and newborn care"

lab var m0_nutritionist_a_ke "KE-specific: Nutritionists: How many are currently assigned, employed, or seconded? "
lab var m0_nutritionist_b_ke "KE-specific: Nutritionists: Part time?"
lab var m0_nutritionist_c_ke "KE-specific: Nutritionists: How many vacancies are there?"
lab var m0_nutritionist_d_ke "KE-specific: Nutritionists: How many currently provide obsetric and newborn care"
  
lab var m0_rad_a_ke "KE-specific: Radiologists: How many are currently assigned, employed, or seconded? "
lab var m0_rad_b_ke "KE-specific: Radiologists: Part time?"
lab var m0_rad_c_ke "KE-specific: Radiologists: How many vacancies are there?"
lab var m0_rad_d_ke "KE-specific: Radiologists: How many currently provide obsetric and newborn care"

* Need to label vars: m0_mointern_a_ke m0_cointern_b_ke
*  (could not find labeling in the codebook)
 
*label var m0_115 "M0-115. Physically present Monday-Friday during the day"
*label var m0_116 "M0-116. On call Monday-Friday during the day"
*label var m0_117 "M0-117. Physically present Monday-Friday at night"
*label var m0_118 "M0-118. On call Monday-Friday at night"
*label var m0_119 "M0-119. Physically present Saturday, Sunday and holidays during theday"
*label var m0_120 "M0-120. On call Saturday, Sunday and holidays during the day"
*label var m0_121 "M0-121. Physically present Saturday, Sunday and holidays during atnight"
*label var m0_122 "M0-122. On call Saturday, Sunday and holidays during at night"  

* 2. Basic amenities 
rename (beds_total beds_obs beds_del labor_space post_del_space elec_grid elec_intrptn gen_solar) ///
	   (m0_201 m0_202 m0_203 m0_204 m0_205 m0_206 m0_207 m0_208)
		
rename (other_elec_src___1 other_elec_src___2 other_elec_src___3 other_elec_src___4 other_elec_src___98 other_elec) ///
       (m0_209a_et m0_209b_et m0_209c_et m0_209d_et m0_209e_et m0_209_other)  
	   
rename (water_avail water_src_now other_water_src water_onsite water_shortage toilet_onsite toilet_type) ///
	   (m0_210 m0_211 m0_211_other m0_212 m0_213 m0_214 m0_215)

rename (landline_phone celphone shortwave_radio comp_available internet_access amb_onsite num_amb amb_offsite basic_amen_comments) ///
	   (m0_216 m0_217 m0_218 m0_219 m0_220 m0_220a_ke m0_222 m0_223 m0_amenities_ke) 

lab var m0_201 "M0-201. How many beds are available for patients in this facility?"
lab var m0_202 "M0-202. How many beds are dedicated exclusively for OBGYN patients (ANC, postpartum...)?"
lab var m0_203 "M0-203. Beds dedicated exclusively to: patients in 1st/2nd stage of labor"
lab var m0_204 "M0-204. Does this facility have a separate space for women to labor?"
lab var m0_205 "M0-205. Does this facility have a space for women to recover post-delivery?"
lab var m0_206 "M0-206. Is this facility connected to the national electricity grid...?"
lab var m0_207 "M0-207. In the last 7 days, has the power from the been interrupted...?"
lab var m0_208 "M0-208. Does this facility have other sources of electricity...?"	   

lab var m0_209a_et "M0-209a. What other sources of electricity does this facility have?"
lab var m0_209b_et "M0-209b. What other sources of electricity does this facility have?"
lab var m0_209c_et "M0-209c. What other sources of electricity does this facility have?"
lab var m0_209d_et "M0-209d. What other sources of electricity does this facility have?"
lab var m0_209e_et "M0-209e. What other sources of electricity does this facility have?"
lab var m0_209_other "M0-209. What other sources of electricity does this facility have?"	   
	   
lab var m0_210 "M0-210. Does this facility have water for its basic functions?"
lab var m0_211 "M0-211. What is the most commonly used source of water for the facility at this time?"
lab var m0_211_other "M0-211. Other: What is the most commonly used source of water for the facility at this time?"
lab var m0_212 "M0-212. Is the water from this source onsite, within 500 meters of the facility, or beyond 500 meters of the facility?"
lab var m0_213 "M0-213. Is there a time of the year when the facility routinely has a severe shortage or lack of water?"
lab var m0_214 "M0-214. Is there a toilet (latrine) on premises that is accessible for patient use?"
lab var m0_215 "M0-215. Toilet type"   
	   
lab var m0_216 "M0-216. Does this facility have a functioning land line telephone that is available to call outside at all times client services are offered?"
lab var m0_217 "M0-217. Does this facility have a functioning cellular telephone or a private cellular phone that is supported by the facility?"
lab var m0_218 "M0-218. Does this facility have a functioning short-wave radio for radio calls?"
lab var m0_219 "M0-219. Does this facility have a functioning computer?"
lab var m0_220 "M0-220. Is there access to email or internet within the facility today?"
lab var m0_220a_ke "M0-220a-ke. Does this facility have an ambulance or other vehicle foremergency transportation for clients that is stationed at thisfacility or operates from this facility?" 
lab var m0_222 "M0-222. How many ambulances does this facility have stationed here, or that operate from this facility?"
lab var m0_223 "M0-223. Does this facility have access to an ambulance or other vehicle for emergency transport...from another nearby facility?"
lab var m0_amenities_ke "M0-amenities-ke. Additional comments on basic amenities" 	      
	   
* 3. Available services  
rename (fam_plan routine_anc ip_anc pmtct del_nbu caesarean caes_12mon immunize pcc_under5 pnc pap_via adol_health adol_mother_clinic adol_trained_staff) ///
	   (m0_301 m0_302a_za m0_302b_za m0_303 m0_304 m0_305a m0_305b m0_306 m0_307 m0_307b m0_307c m0_308 m0_308a_ke m0_308b_ke)	   
 
rename (hiv_ct hiv_arv hivaids_care sti_trmnt tb_trmnt mal_diag) (m0_309 m0_310 m0_311 m0_312 m0_313 m0_314)		

rename (diabetes cvd crd cancer_diag cancer_trmnt mental_hs) (m0_315a m0_315b m0_315c m0_315d m0_315e m0_315f)

rename (onchocerciasis lymph_filiarsis schistosomiasis sth trachoma dracunculiasis podoconiasis leishmaniosis) ///
	   (m0_316a_ke m0_316b_ke m0_316c_ke m0_316d_ke m0_316e_ke m0_316f_ke m0_316g_ke m0_316h_ke)

rename (surgical blood_trns safe_abort post_abort_care avail_serv_comments) (m0_317 m0_318 m0_319 m0_319a_ke m0_services_ke)	  

lab var m0_301 "M0-301. FAMILY PLANNING: Does this facility offer family planning services?"
lab var m0_302a_za "m0_302a_za. ANTENATAL CARE: Does this facility off er routine outpatientantenatal care (ANC) services?" 
lab var m0_302b_za "m0_302b_za. ANTENATAL CARE: Does this facility off er inpatient antenatalcare (ANC) services?"
lab var m0_303 "M0-303. PMTCT: Does this facility offer services for the prevention of mother-to-child transmission of HIV (PMTCT)?"
lab var m0_304 "M0-304. OBSTETRIC AND NEWBORN CARE: Does this facility offer delivery (including normal delivery, basic emergency obstetric care, and/or comprehensive emergency obstetric care) and/or newborn care services?"
lab var m0_305a "M0-305a. CAESAREAN SECTION: Does this facility offer caesarean sections? "
lab var m0_305b "M0-305b. Has a caesarean section been carried out in the last 12 months by providers of delivery services as part of their work in this facility?"
lab var m0_306 "M0-306. IMMUNIZATION: Does this facility offer immunization services? "
lab var m0_307 "M0-307. CHILD PREVENTIVE AND CURATIVE CARE: Does this facility off erpreventative and curative care services for children under 5?"
lab var m0_307b "M0-307b. PNC: Does this facility provide postnatal care services for newborn? "
lab var m0_307c "M0-307c. Does this facility provide cervicalscreening (pap smear or VIA single visit approach?"
lab var m0_308 "M0-308. ADOLESCENT HEALTH: Does this facility offer adolescent health services? ?"

lab var m0_309 "M0-309. HIV TESTING: Does this facility offer HIV counselling and testing services? "
lab var m0_310 "M0-310. HIV TREATMENT: Does this facility offer HIV & AIDS antiretroviral prescription or antiretroviral treatment follow-up services? "
lab var m0_311 "M0-311. HIV CARE AND SUPPORT: Does this facility offer HIV & AIDS care and support services, including treatment of opportunistic infections and provisions of palliative care?"
lab var m0_312 "M0-312. STIs: Does this facility offer diagnosis or treatment of STIs other than HIV? "
lab var m0_313 "M0-313. TB: Does this facility offer diagnosis, treatment prescription, or treatment follow-up of tuberculosis? "
lab var m0_314 "M0-314. MALARIA: Does this facility offer diagnosis or treatment of malaria?"

lab var m0_315a "M0-315a. NCDs: Does this facility offer diagnosis or management of Diabetes?"
lab var m0_315b "M0-315b. NCDs: Does this facility offer diagnosis or management of Cardiovascular disease?"
lab var m0_315c "M0-315c. NCDs: Does this facility offer diagnosis or management of Chronic respiratory disease / Does this facility offer diagnosis or management of Cardiovascular disease?"
lab var m0_315d "M0-315d. NCDs: Does this facility offer diagnosis or management of Cancer diagnosis?"
lab var m0_315e "M0-315e. NCDs: Does this facility offer diagnosis or management of Cancer treatment?"
lab var m0_315f "M0-315f. NCDs: Does this facility offer diagnosis or management of mental health?"

lab var m0_316a_ke "M0-316a-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as onchocerciasis?" 
lab var m0_316b_ke "M0-316b-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as lymphaticfi liarsis?" 
lab var m0_316c_ke "M0-316c-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as schistosomiasis?" 
lab var m0_316d_ke "M0-316d-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as soil transmitted helminthes?" 
lab var m0_316e_ke "M0-316e-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as trachoma?" 
lab var m0_316f_ke "M0-316f-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as dracunculiasis?" 
lab var m0_316g_ke "M0-316g-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as podoconiasis?"  
lab var m0_316h_ke "M0-316h-ke. NCDs: NTDs: Does this facility offer diagnosis or management of neglected tropical disease such as leishmaniosis?" 

lab var m0_317 "M0-317. SURGERY: Does this facility offer any surgical services (including minor surgery such as suturing, circumcision, wound debridement, etc.), or caesarean section?"
lab var m0_318 "M0-318. BLOOD TRANSFUSION: Does this facility offer blood transfusion services?"
lab var m0_319 "M0-319. ABORTION: Does this facility offer safe abortion care?" 
lab var m0_319a_ke "M0-319a-ke. Does this facility offer post-abortal care?"
lab var m0_services_ke "M0-services-ke. Additional comments on available services"

* 4. Basic equipment and diagnostics
rename (bp_apparatus bp_func adult_wt_scale adult_wt_func infant_wt_scale inf_wt_func measure_tape tape_func thermometer thermo_func ///
        stethoscope stetho_fun)(m0_401 m0_401a m0_402 m0_402a m0_403 m0_403a m0_404 m0_404a m0_405 m0_405a m0_406 m0_406a)

rename (diag_test rapid_mal rapid_syphylis hiv_testing urine_preg urine_protein urine_glucose urine_ketone dbs) /// 
	   (m0_407 m0_408 m0_409 m0_410 m0_411 m0_412 m0_413 m0_414 m0_415)
	   
rename (mal_rapid_kit syph_rapid_kit unigold_hiv_kit determine_hiv_kit firstresp_kit urine_preg_kit dipstick_protein dipstick_glucose ///
        dipstick_ketone filter_paper)(m0_416 m0_417 m0_420 m0_420a_ke m0_420b_ke m0_421 m0_422 m0_423 m0_424 m0_425)   

rename (bgt_glucometer haemoglobin_test wet_mounts mal_microscopy hiv_elisa) (m0_426 m0_427 m0_428 m0_429 m0_430)  

rename (diag_xray xray_machine ultrasound_eq ct_scan ecg diagnostics_comments) (m0_431 m0_432 m0_433 m0_434 m0_435 m0_diagnostics_ke)   

lab var m0_401 "M0-401. Blood pressure apparatus (may be digital or manualsphygmomanometer with stethoscope)"
lab var m0_401a "M0-401a. Blood pressure apparatus functioning?"
lab var m0_402 "M0-402. Adult weighing scale"
lab var m0_402a "M0-402a. Adult weighing scale functioning?"
lab var m0_403 "M0-403. Infant weighing scale - 100 gram gradation"
lab var m0_403a "M0-403a. Infant weighing scale - 100 gram gradation functioning?"
lab var m0_404 "M0-404. Measuring tape-height board/stadiometre"
lab var m0_404a "M0-404a. Measuring tape-height board/stadiometre functioning?"
lab var m0_405 "M0-405. Thermometer"
lab var m0_405a "M0-405a. Thermometer functioning?"
lab var m0_406 "M0-406. Stethoscope"
lab var m0_406a "M0-406a. Stethoscope functioning?"

lab var m0_407 "M0-407. Does this facility conduct any diagnostic testing including any rapid diagnostic testing?"
lab var m0_408 "M0-408. Rapid malaria testing"
lab var m0_409 "M0-409. Rapid syphilis testing"
lab var m0_410 "M0-401. HIV rapid testing"
lab var m0_411 "M0-402. Urine rapid tests for pregnancy"
lab var m0_412 "M0-403. Urine protein dipstick testing"
lab var m0_413 "M0-403. Urine glucose dipstick testing"
lab var m0_414 "M0-404. Urine ketone dipstick testing"
lab var m0_415 "M0-405. Dry Blood Spot (DBS) collection for HIV viral load or EID (Earlyinfant diagnosis)"

lab var m0_416 "M0-416. Malaria rapid diagnostic kit"
lab var m0_417 "M0-417. Syphilis rapid test kit"
lab var m0_420 "M0-420. UniGold HIV rapid test kit"
lab var m0_420a_ke "M0-420a-ke. Determine HIV rapid test kit"
lab var m0_420b_ke "M0-420b-ke. First Response HIV rapid test kit"
lab var m0_421 "M0-421. Urine pregnancy test kit"
lab var m0_422 "M0-422. Dipsticks for urine protein"
lab var m0_423 "M0-423. Dipsticks for urine glucose"
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
lab var m0_435 "M0-435. ECG machine with printer"
lab var m0_diagnostics_ke "M0-diagnostics-ke. Additional comments on basic equipment and diagnostics"

* 5. Referral system
rename (referral fac_refered transport___1 transport___2 transport___3 transport___4 transport___5 transport___6) ///
	   (m0_501 m0_502 m0_503a_et m0_503b_et m0_503c_et m0_503d_et m0_503e_et m0_503f_et)
	   
rename (referral_feedback obs_preref_guide receive_ref triage_priority mat_wait_home ref_sys_comments) ///
	   (m0_504 m0_505 m0_506 m0_507 m0_508 m0_referral_ke)

lab var m0_501 "M0-501. Does this facility ever refer a woman or newborn to another facility for care?"
lab var m0_502  "M0-502. To which facility does this facility usually refer women or newborns for care?"    
lab var m0_503a_et "M0-503a-et. Strategies transport emergency patients from this facility:Have its own means oftransportation"
lab var m0_503b_et "M0-503b-et. Strategies transport emergency patients from this facility:Use a dispatch center e.g. ocoaambulance, E-plus, AMREF,Jacaranda etc"
lab var m0_503c_et "M0-503c-et. Strategies transport emergency patients from this facility:Have agreements with privatetaxis, care, trucks or motorcycles"
lab var m0_503d_et "M0-503d-et. Strategies transport emergency patients from this facility:Use vehicles from the districthealth office"
lab var m0_503e_et "M0-503e-et. Strategies transport emergency patients from this facility:Use vehicles from the localcouncil"
lab var m0_503f_et "M0-503f-et. Strategies transport emergency patients from this facility:Assume that patients will arrangetheir own transport"	        
	   
* 6. Payment for services	   
rename (formal_pymt del_pymt obs_pymt_b4 obs_supply_buy mat_waiver_formal mat_waiver_informal fee_sch_public payment_comments) /// 
	   (m0_601 m0_602 m0_603 m0_604 m0_605 m0_606 m0_607 m0_payment_ke)   

lab var m0_601 "M0-601. Is formal payment required before receiving maternity services? "
lab var m0_602 "M0-602. Is a woman expected to pay for/buy supplies and medicines for delivery? "
lab var m0_603 "M0-603. In an obstetric emergency, is payment required before receiving care?"
lab var m0_604 "M0-604. In an obstetric emergency, is the woman or her family asked to buy medicine or supplies prior to treatment? "
lab var m0_605 "M0-605. Is there a formal system in place to have fees for maternity services waived for poor women?"
lab var m0_606 "M0-606. Is there any informal system in place to have fees for maternity services waived for poor women? "
lab var m0_607 "M0-607. Is there a fee schedule for services posted in a visible and public place? (Collect data by observation only that was posted or prepared document) "
lab var m0_payment_ke "M0-payment-ke. Additional comments on payment for services"	   
	   	   
* 7. Record keeping and HMIS	   
rename (mnh_data_system rpt_dhis2 rpt_frequency other_mnhrpt_freq mnh_dm labor_register anc_register pnc_register) ///
	   (m0_701 m0_702 m0_703 m0_703_other m0_704 m0_705 m0_706 m0_707)
	   
lab var m0_701 "M0-701. Does this facility have a system in place to regularly collect maternal and newborn health services data?"
lab var m0_702 "M0-702. Does this facility report data to the health management information system (i.e., HMIS/DHIS2)?"
lab var m0_703 "M0-703. How frequently are MNH data reported to the HMIS?"
lab var m0_703_other "703-Oth. Other"
lab var m0_704 "M0-704. Does this facility have a designated person, such as a data manager or Health Information Technologist, who is responsible for MNH services data?"
lab var m0_705 "M0-705. Is a labor and delivery ward register used at this facility?"
lab var m0_706 "M0-704. Does this facility have a designated person, such as a data manager or Health Information Technologist, who is responsible for MNH services data?"
lab var m0_707 "M0-705. Is a labor and delivery ward register used at this facility?"

* 8. Facility case summary	   
rename (anc_first_m5 anc_first_m6 anc_first_m7 anc_first_m8 anc_first_m9 anc_first_m10 anc_first_m11 anc_first_m12 anc_first_m13 anc_first_m14 ///
		anc_first_m15 anc_first_m16) (m0_802_jan m0_802_feb m0_802_mar m0_802_apr m0_802_may m0_802_jun m0_802_jul m0_802_aug m0_802_sep m0_802_oct ///
	    m0_802_nov m0_802_dec)
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
lab var m0_802_dec "M0-802.12 Number of first antenatal care visits for December"
		
rename (anc_repeat_m5 anc_repeat_m6 anc_repeat_m7 anc_repeat_m8 anc_repeat_m9 anc_repeat_m10 anc_repeat_m11 anc_repeat_m12 anc_repeat_m13 ///
        anc_repeat_m14 anc_repeat_m15 anc_repeat_m16 ) (m0_ancrepeat_jan_ke m0_ancrepeat_feb_ke m0_ancrepeat_mar_ke m0_ancrepeat_apr_ke ///
		m0_ancrepeat_may_ke m0_ancrepeat_jun_ke m0_ancrepeat_jul_ke m0_ancrepeat_aug_ke m0_ancrepeat_sep_ke m0_ancrepeat_oct_ke m0_ancrepeat_nov_ke ///
		m0_ancrepeat_dec_ke)
* could not find labing in codebook
		
rename (del_vag_m5 del_vag_m6 del_vag_m7 del_vag_m8 del_vag_m9 del_vag_m10 del_vag_m11 del_vag_m12 del_vag_m13 del_vag_m14 del_vag_m15 del_vag_m16) ///
	   (m0_803_jan m0_803_feb m0_803_mar m0_803_apr m0_803_may m0_803_jun m0_803_jul m0_803_aug m0_803_sep m0_803_oct m0_803_nov m0_803_dec)
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
	   
rename (del_ceas_m5 del_ceas_m6 del_ceas_m7 del_ceas_m8 del_ceas_m9 del_ceas_m10 del_ceas_m11 del_ceas_m12 del_ceas_m13 del_ceas_m14 del_ceas_m15 ///
		del_ceas_m16)(m0_804_jan m0_804_feb m0_804_mar m0_804_apr m0_804_may m0_804_jun m0_804_jul m0_804_aug m0_804_sep m0_804_oct m0_804_nov m0_804_dec)
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
		
rename (post_ptm_m5 post_ptm_m6 post_ptm_m7 post_ptm_m8 post_ptm_m9 post_ptm_m10 post_ptm_m11 post_ptm_m12 post_ptm_m13 post_ptm_m14 post_ptm_m15 post_ptm_m16) ///
	   (m0_805_jan m0_805_feb m0_805_mar m0_805_apr m0_805_may m0_805_jun m0_805_jul m0_805_aug m0_805_sep m0_805_oct m0_805_nov m0_805_dec)
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
	   
rename (obs_labor_m5 obs_labor_m6 obs_labor_m7 obs_labor_m8 obs_labor_m9 obs_labor_m10 obs_labor_m11 obs_labor_m12 obs_labor_m13 obs_labor_m14 obs_labor_m15 obs_labor_m16) ///	
		(m0_806_jan m0_806_feb m0_806_mar m0_806_apr m0_806_may m0_806_jun m0_806_jul m0_806_aug m0_806_sep m0_806_oct m0_806_nov m0_806_dec)
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
	   
rename (eclampsia_m5 eclampsia_m6 eclampsia_m7 eclampsia_m8 eclampsia_m9 eclampsia_m10 eclampsia_m11 eclampsia_m12 eclampsia_m13 eclampsia_m14 ///
		eclampsia_m15 eclampsia_m16) (m0_807_jan m0_807_feb m0_807_mar m0_807_apr m0_807_may m0_807_jun m0_807_jul m0_807_aug m0_807_sep m0_807_oct ///
	    m0_807_nov m0_807_dec)
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
	   
rename (mat_death_m5 mat_death_m6 mat_death_m7 mat_death_m8 mat_death_m9 mat_death_m10 mat_death_m11 mat_death_m12 mat_death_m13 mat_death_m14 ///
		mat_death_m15 mat_death_m16) (m0_808_jan m0_808_feb m0_808_mar m0_808_apr m0_808_may m0_808_jun m0_808_jul m0_808_aug m0_808_sep m0_808_oct ///
	    m0_808_nov m0_808_dec)
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

rename (fstill_birth_m5 fstill_birth_m6 fstill_birth_m7 fstill_birth_m8 fstill_birth_m9 fstill_birth_m10 fstill_birth_m11 fstill_birth_m12 ///
		fstill_birth_m13 fstill_birth_m14 fstill_birth_m15 fstill_birth_m16) (m0_809_jan m0_809_feb m0_809_mar m0_809_apr m0_809_may m0_809_jun ///
	    m0_809_jul m0_809_aug m0_809_sep m0_809_oct m0_809_nov m0_809_dec)	   	   
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
		
rename (mstill_birth_m5 mstill_birth_m6 mstill_birth_m7 mstill_birth_m8 mstill_birth_m9 mstill_birth_m10 mstill_birth_m11 mstill_birth_m12 ///
		mstill_birth_m13 mstill_birth_m14 mstill_birth_m15 mstill_birth_m16) (m0_mstill_jan_ke m0_mstill_feb_ke m0_mstill_mar_ke m0_mstill_apr_ke ///
	    m0_mstill_may_ke m0_mstill_jun_ke m0_mstill_jul_ke m0_mstill_aug_ke m0_mstill_sep_ke m0_mstill_oct_ke m0_mstill_nov_ke m0_mstill_dec_ke)
* could not find labing in codebook
		
rename (day1_neo_death_m5 day1_neo_death_m6 day1_neo_death_m7 day1_neo_death_m8 day1_neo_death_m9 day1_neo_death_m10 day1_neo_death_m11 ///
		day1_neo_death_m12 day1_neo_death_m13 day1_neo_death_m14 day1_neo_death_m15 day1_neo_death_m16) (m0_811_jan m0_811_feb m0_811_mar m0_811_apr ///
	    m0_811_may m0_811_jun m0_811_jul m0_811_aug m0_811_sep m0_811_oct m0_811_nov m0_811_dec)
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
		
rename (day28_neo_death_m5 day28_neo_death_m6 day28_neo_death_m7 day28_neo_death_m8 day28_neo_death_m9 day28_neo_death_m10 day28_neo_death_m11 ///
		day28_neo_death_m12 day28_neo_death_m13 day28_neo_death_m14 day28_neo_death_m15 day28_neo_death_m16) (m0_day28_neodeath_jan_ke ///
		m0_day28_neodeath_feb_ke m0_day28_neodeath_mar_ke m0_day28_neodeath_apr_ke m0_day28_neodeath_may_ke m0_day28_neodeath_jun_ke ///
		m0_day28_neodeath_jul_ke m0_day28_neodeath_aug_ke m0_day28_neodeath_sep_ke m0_day28_neodeath_oct_ke m0_day28_neodeath_nov_ke ///
		m0_day28_neodeath_dec_ke)
* could not find labing in codebook
		
rename (obs_ref_m5 obs_ref_m6 obs_ref_m7 obs_ref_m8 obs_ref_m9 obs_ref_m10 obs_ref_m11 obs_ref_m12 obs_ref_m13 obs_ref_m14 obs_ref_m15 obs_ref_m16) ///
	   (m0_812_jan m0_812_feb m0_812_mar m0_812_apr m0_812_may m0_812_jun m0_812_jul m0_812_aug m0_812_sep m0_812_oct m0_812_nov m0_812_dec)
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
 	   
rename (pnc_visits_m5 pnc_visits_m6 pnc_visits_m7 pnc_visits_m8 pnc_visits_m9 pnc_visits_m10 pnc_visits_m11 pnc_visits_m12 pnc_visits_m13 pnc_visits_m14 ///
		pnc_visits_m15 pnc_visits_m16) (m0_813_jan m0_813_feb m0_813_mar m0_813_apr m0_813_may m0_813_jun m0_813_jul m0_813_aug m0_813_sep m0_813_oct ///
		m0_813_nov m0_813_dec)
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
	
rename (add_comments facility_case_summary_complete) (m0_additionalcomments_ke m0_complete_et)
lab var m0_additionalcomments_ke "M0-additionalcomments-ke. Additional comments and observations"
lab var m0_complete_et "M0-complete-et. Complete?"

* STEP TW0: ADD VALUE LABELS

lab def m0_a4_site 1"Kiambu" 2"Kitui"
lab val m0_a4_site m0_a4_site

lab def facility 1"Githunguri health centre" 2"Igegania sub district hospital" 3"Ikutha Sub County Hospital" ///
				 4"Kalimoni mission hospital" 5"Katse Health Centre" 6"Kauwi Sub County Hospital" ///
				 7"Kiambu County referral hospital" 8"Kisasi Health Centre (Kitui Rural)" ///
				 9"Kitui County Referral Hospital" 10"Makongeni dispensary" 11"Mercylite hospital" ///
				 12"Mulango (AIC) Health Centre" 13"Muthale Mission Hospital" 14"Neema Hospital" ///
				 15"Ngomeni Health Centre" 16"Nuu Sub County Hospital" 17"Our Lady of Lourdes Mutomo Hospital" ///
				 18 "Plainsview nursing home" 19 "St. Teresas Nursing Home" 20"Waita Health Centre" ///
				 21 "Wangige Sub-County Hospital"
lab val facility facility

gen m0_facility_own = facility 
recode m0_facility_own (18 19 12 14 4 11 17 13 = 2) (1	21	10	16	20	5	15	3	8	2	7	9	6 = 1)
lab def m0_facility_own  1"Public" 2"Private"
lab val m0_facility_own  m0_facility_own 

gen m0_facility_type = facility 
recode m0_facility_type (18	19	12	14	1	21	10	16	20	5	15	3	8=1) (4	11	17	13	2	7	9	6=2)
lab def m0_facility_type 1"Primary" 2"Secondary"
lab val m0_facility_type m0_facility_type 


* STEP FIVE: ORDER VARIABLES

order m0_*, sequential
order m0_a4_site facility m0_facility_own m0_facility_type 
order m0_famphy_a_ke-m0_rad_d_ke, after(m0_114d) 

* STEP THREE: RECODING MISSING VALUES

foreach v in  m0_101a m0_101b m0_101c m0_101d m0_102a m0_102b m0_102c m0_102d m0_103a ///
	m0_103b m0_103c m0_103d m0_104a m0_104b m0_104c m0_104d m0_105a m0_105b m0_105c m0_105d ///
	m0_106a m0_106b m0_106c m0_106d m0_108a m0_108b m0_108c m0_108d m0_109a m0_109b m0_109c ///
	m0_109d m0_110a m0_110b m0_110c m0_110d m0_111a m0_111b m0_111c m0_111d m0_112a m0_112b ///
	m0_112c m0_112d m0_113a m0_113b m0_113c m0_113d m0_114a m0_114b m0_114c m0_114d m0_201 ///
	m0_202 m0_203 {
	recode `v' 999=.
}

replace m0_201 = m0_202 + m0_203 if m0_201==. // beds total was missing in 1 facility 

save "$ke_data_final/eco_m0_ke.dta", replace

		