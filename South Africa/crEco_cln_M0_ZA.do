* South Africa ECohort Data Cleaning File 
* Created by Wen-Chien Yang
* Updated: Dec 8 2023

*------------------------------------------------------------------------------*

* Import Data 
clear all  

*--------------------DATA FILE:
import delimited  "$za_data/SA MOD-0 - 07Dec2023", clear
*import delimited "C:\Users\wench\Desktop\ECohort study\cleaning dataset\ZAFM0\SA MOD-0 - 07Dec2023", clear

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
* did not see standardized variables to rename for the following: 
*         RESPONSE_QuestionnaireID
*         RESPONSE_QuestionnaireName
*         RESPONSE_QuestionnaireVersion
*         RESPONSE_FieldWorkerID
*         RESPONSE_FieldWorker
*         RESPONSE_StartTime
*         RESPONSE_Location
*         RESPONSE_StudyNoPrefix
*         RESPONSE_StudyNo
*         StudyNumber
drop in 23/28
rename (response_lattitude response_longitude) (m0_latitude m0_longitude)
rename (responseid mod0_meta_data_a1 mod0_meta_data_time_a1 mod0_meta_data_a4 mod0_meta_data_a5) (m0_id_za m0_a1_date m0_a1_time m0_a4_site ///
        m0_a4_subsite)
rename (mod0_meta_data_a4_a5 meta_meta_data_a6 crhid) (m0_id m0_ward_za m0_facility)
rename (mod0_meta_data_a7 mod0_meta_data_a8 mod0_meta_data_a9 mod0_meta_data_a13 mod0_meta_data_a14) (m0_facility_type m0_facility_own ///
        m0_urban m0_a13 m0_a14)
		
encode m0_facility, gen(facility) // this will match Module 1 facility codes
drop m0_facility

lab var m0_latitude "Latitude"
lab var m0_longitude "Longitude"	
lab var m0_a1_date "M0-A1. Date"
lab var m0_a4_site "M0-A1. County"
lab var m0_a4_subsite "M0-A4. Zone/subcity site"
lab var m0_id "M0-A7. Interviewer ID"
lab var facility "M0-A5. Facility name"
lab var m0_facility_type "M0-6. Facility type"
lab var m0_facility_own "M0-A8. Facilility ownership"
lab var m0_urban "M0-A9. Urban/rural"
lab var m0_a13 "M0-A13. Does this facility have a specified catchment area?"
lab var m0_a14 "M0-A14. How many people are supposed to be in the catchment area for this facility?"

 * 1. Staffing 
rename (staffing_101a staffing_101b staffing_101c staffing_101d) (m0_101a m0_101b m0_101c m0_101d)
lab var m0_101a "M0-101a. Medical doctor: How many are currently assigned, employed, or seconded?"
lab var m0_101b "M0-101b. Medical doctor: Part time?"
lab var m0_101c "M0-101c. Medical doctor: How many vacancies are there?"
lab var m0_101d "M0-101d. Medical doctor: How many currently provide obsetric and newborn care"

rename (staffing_102a staffing_102b staffing_102c staffing_102d) (m0_102a m0_102b m0_102c m0_102d)
lab var m0_102a "M0-102a. OBGYN: How many are currently assigned, employed, or seconded?"
lab var m0_102b "M0-102b. OBGYN: Part time?"
lab var m0_102c "M0-102c. OBGYN: How many vacancies are there?"
lab var m0_102d "M0-102d. OBGYN: How many currently provide obsetric and newborn care"

rename (staffing_103a staffing_103b staffing_103c staffing_103d) (m0_103a m0_103b m0_103c m0_103d)
lab var m0_103a "M0-103a. General surgeon: How many are currently assigned, employed, or seconded?"
lab var m0_103b "M0-103b. General surgeon: Part time?"
lab var m0_103c "M0-103c. General surgeon: How many vacancies are there?"
lab var m0_103d "M0-103d. General surgeon: How many currently provide obsetric and newborn care"

rename (staffing_104a staffing_104b staffing_104c staffing_104d) (m0_104a m0_104b m0_104c m0_104d)
lab var m0_104a "M0-104a. Anesthesiologist: How many are currently assigned, employed, or seconded?"
lab var m0_104b "M0-104b. Anesthesiologist: Part time?"
lab var m0_104c "M0-104c. Anesthesiologist: How many vacancies are there?"
lab var m0_104d "M0-104d. Anesthesiologist: How many currently provide obsetric and newborn care"

rename (staffing_105a staffing_105b staffing_105c staffing_105d) (m0_105a m0_105b m0_105c m0_105d)
lab var m0_105a "M0-105a. Pediatrician: How many are currently assigned, employed, or seconded?"
lab var m0_105b "M0-105b. Pediatrician: Part time?"
lab var m0_105c "M0-105c. Pediatrician: How many vacancies are there?"
lab var m0_105d "M0-105d. Pediatrician: How many currently provide obsetric and newborn care"

rename (staffing_106a staffing_106b staffing_106c staffing_106d) (m0_106a m0_106b m0_106c m0_106d)
lab var m0_106a "M0-106a. Neonatalogist: How many are currently assigned, employed, or seconded?"
lab var m0_106b "M0-106b. Neonatalogist: Part time?"
lab var m0_106c "M0-106c. Neonatalogist: How many vacancies are there?"
lab var m0_106d "M0-106d. Neonatalogist: How many currently provide obsetric and newborn care"

rename (staffing_107a staffing_107b staffing_107c staffing_107d) (m0_107a m0_107b m0_107c m0_107d)
lab var m0_107a "M0-107a. Emergency surgical officer: How many are currently assigned, employed, or seconded?"
lab var m0_107b "M0-107b. Emergency surgical officer: Part time?"
lab var m0_107c "M0-107c. Emergency surgical officer: How many vacancies are there?"
lab var m0_107d "M0-107d. Emergency surgical officer: How many currently provide obsetric and newborn care"

rename (staffing_108a staffing_108b staffing_108c staffing_108d) (m0_108a m0_108b m0_108c m0_108d)
lab var m0_108a "M0-108a. Midwife BSc: How many are currently assigned, employed, or seconded?"
lab var m0_108b "M0-108b. Midwife BSc: Part time?"
lab var m0_108c "M0-108c. Midwife BSc: How many vacancies are there?"
lab var m0_108d "M0-108d. Midwife BSc: How many currently provide obsetric and newborn care

rename (staffing_109a staffing_109b staffing_109c staffing_109d) (m0_109a m0_109b m0_109c m0_109d)
lab var m0_109a "M0-109a. Midwife diploma: How many are currently assigned, employed, or seconded?"
lab var m0_109b "M0-109b. Midwife diploma: Part time?"
lab var m0_109c "M0-109c. Midwife diploma: How many vacancies are there?"
lab var m0_109d "M0-109d. Midwife diploma: How many currently provide obsetric and newborn care"

rename (staffing_110a staffing_110b staffing_110c staffing_110d) (m0_110a m0_110b m0_110c m0_110d)
lab var m0_110a "M0-110a. Nurse BSc: How many are currently assigned, employed, or seconded?"
lab var m0_110b "M0-110b. Nurse BSc: Part time?"
lab var m0_110c "M0-110c. Nurse BSc: How many vacancies are there?"
lab var m0_110d "M0-110d. Nurse BSc: How many currently provide obsetric and newborn care"

rename (staffing_111a staffing_111b staffing_111c staffing_111d) (m0_111a m0_111b m0_111c m0_111d)
lab var m0_111a "M0-111a. Nurse diploma: How many are currently assigned, employed, or seconded?"
lab var m0_111b "M0-111b. Nurse diploma: Part time?"
lab var m0_111c "M0-111c. Nurse diploma: How many vacancies are there?"
lab var m0_111d "M0-111d. Nurse diploma: How many currently provide obsetric and newborn care"

rename (staffing_112a staffing_112b staffing_112c staffing_112d) (m0_112a m0_112b m0_112c m0_112d)
lab var m0_112a "M0-112a. Health officer: How many are currently assigned, employed, or seconded?"
lab var m0_112b "M0-112b. Health officer: Part time?"
lab var m0_112c "M0-112c. Health officer: How many vacancies are there?"
lab var m0_112d "M0-112d. Health officer: How many currently provide obsetric and newborn care"

rename (staffing_113a staffing_113b staffing_113c staffing_113d) (m0_113a m0_113b m0_113c m0_113d)
lab var m0_113a "M0-113a. Anesthesiologist: How many are currently assigned, employed, or seconded?"
lab var m0_113b "M0-113b. Anesthesiologist: Part time?"
lab var m0_113c "M0-113c. Anesthesiologist: How many vacancies are there?"
lab var m0_113d "M0-113d. Anesthesiologist: How many currently provide obsetric and newborn care"

rename (staffing_114a staffing_114b staffing_114c staffing_114d) (m0_114a m0_114b m0_114c m0_114d)
lab var m0_114a "M0-114a. Lab tech: How many are currently assigned, employed, or seconded?"
lab var m0_114b "M0-114b. Lab tech: Part time?"
lab var m0_114c "M0-114c. Lab tech: How many vacancies are there?"
lab var m0_114d "M0-114d. Lab tech: How many currently provide obsetric and newborn care"

rename (staffing_hiv_counsellor_a staffing_hiv_counsellor_b staffing_hiv_counsellor_c staffing_hiv_counsellor_d) ///
       (m0_hivstaff_a_za m0_hivstaff_b_za m0_hivstaff_c_za m0_hivstaff_d_za)
lab var m0_hivstaff_a_za "M0-115a. HIV counsellor: How many are currently assigned, employed, or seconded?"
lab var m0_hivstaff_b_za "M0-115b. HIV counsellor: Part time?"
lab var m0_hivstaff_c_za "M0-115c. HIV counsellor: How many vacancies are there?"
lab var m0_hivstaff_d_za "M0-115d. HIV counsellor: How many currently provide obsetric and newborn care"

rename (staffing_115 staffing_116 staffing_117 staffing_118 staffing_119 staffing_120 staffing_121 staffing_122 staffing_123 /// 
        staffing_124 staffing_125) (m0_115 m0_116 m0_117 m0_118 m0_119 m0_120 m0_121 m0_122 m0_123_za m0_124_za m0_125_za)
lab var m0_115 "M0-115. During a typical week, what staff are physically present Monday to Friday during the day?"
lab var m0_116 "M0-116. During a typical week, what staff are on call Monday to Friday during the day?"
lab var m0_117 "M0-117. During a typical week, what staff are physically present Monday to Friday at night?"
lab var m0_118 "M0-118. During a typical week, what staff are on call Monday to Friday at night?"
lab var m0_119 "M0-119. During a typical week, what staff are physically present Saturday, Sunday and holidays during the day?"
lab var m0_120 "M0-120. During a typical week, what staff are on call Saturday, Sunday and holidays during the day?"
lab var m0_121 "M0-121. During a typical week, what staff are physically present Saturday, Sunday and holidays at night?"
lab var m0_122 "M0-122. During a typical week, what staff are on call Saturday, Sunday and holidays at night?"
lab var m0_123_za "M0-123-za. What are visiting health professionals - Monthly?" 
lab var m0_124_za "M0-124-za. What are visiting health professionals - Quaterly?"
lab var m0_125_za "M0-125-za. What are visiting health professionals - Yearly?" 

* 2. Basic amenities 
rename (mod0_basic_amenities_201 mod0_basic_amenities_202a mod0_basic_amenities_202b basic_amenities_204 mod0_basic_amenities_206 ///
        mod0_basic_amenities_209a mod0_basic_amenities_209b mod0_basic_amenities_210 mod0_basic_amenities_211) /// 		
	   (m0_201 m0_202 m0_203 m0_204 m0_205 m0_206 m0_207 m0_208 m0_209)
lab var m0_201 "M0-201. How many beds are available for patients in this facility?"
lab var m0_202 "M0-202. How many beds are dedicated exclusively for OBGYN patients (ANC, postpartum...)?"
lab var m0_203 "M0-203. Beds dedicated exclusively to: patients in 1st/2nd stage of labor"
lab var m0_204 "M0-204. Does this facility have a separate space for women to labor?"
lab var m0_205 "M0-205. Does this facility have a space for women to recover post-delivery?"
lab var m0_206 "M0-206. Is this facility connected to the national electricity grid...?"
lab var m0_207 "M0-207. In the last 7 days, has the power from the been interrupted...?"
lab var m0_208 "M0-208. Does this facility have other sources of electricity?"	
lab var m0_209 "M0-209. What other sources of electricity does this facility have?"

rename (mod0_basic_amenities_211other mod0_basic_amenities_212 mod0_basic_amenities_213 mod0_basic_amenities_206_other mod0_basic_amenities_214a ///
        mod0_basic_amenities_214b basic_amenities_215) (m0_209_other m0_210 m0_211 m0_211_other m0_212 m0_213 m0_215)
	   
lab var m0_209_other "M0-209-other. What other sources of electricity does this facility have? Other, specify"
lab var m0_210 "M0-210. Does this facility have water for its basic functions?"
lab var m0_211 "M0-211. What is the most commonly used source of water for the facility at this time?"	   
lab var m0_211_other "M0-211-other. What is the most commonly used source of water for the facility at this time?: Other"	   
lab var m0_212 "M0-212. Is the water from this source onsite, within 500 meters of the facility, or beyond 500 meters of the facility?"
lab var m0_213 "M0-213. Is there a time of the year when the facility routinely has a severe shortage or lack of water?"
lab var m0_215 "M0-215. What type of toilet?"  
	   
rename (mod0_basic_amenities_216 mod0_basic_amenities_217 mod0_basic_amenities_218 mod0_basic_amenities_219 mod0_basic_amenities_220 ///
        mod0_basic_amenities_221 mod0_basic_amenities_222 mod0_basic_amenities_223) (m0_216 m0_217 m0_218 m0_219 m0_220 m0_221 ///
		m0_222 m0_223) 
lab var m0_216 "M0-216. Does this facility have a functioning land line telephone that is available to call outside at all times client services are offered?"
lab var m0_217 "M0-217. Does this facility have a functioning cellular telephone or a private cellular phone that is supported by the facility?"
lab var m0_218 "M0-218. Does this facility have a functioning short-wave radio for radio calls?"
lab var m0_219 "M0-219. Does this facility have a functioning computer?"
lab var m0_220 "M0-220. Is there access to email or internet within the facility today?"
lab var m0_221 "M0-221. Does this facility have a functional ambulance or other vehicle for emergency transportation...operates from this facility"
lab var m0_222 "M0-222. How many ambulances does this facility have stationed here, or that operate from this facility?"
lab var m0_223 "M0-223. Does this facility have access to an ambulance or other vehicle for emergency transport...from another nearby facility?"	   
	   
* 3. Available services  
rename (avail_services_301 avail_services_302a avail_services_302b avail_services_303 avail_services_304 avail_services_305a avail_services_305b ///
        avail_services_306 avail_services_307a avail_services_307a_anc avail_services_307b avail_services_307b_papsmear avail_services_308 ///
		avail_services_309 avail_services_310) (m0_301 m0_302a_za m0_302b_za m0_303 m0_304 m0_305a m0_305b m0_306 m0_307 m0_307a m0_307b m0_307c ///
		m0_308 m0_309 m0_310)
		
lab var m0_301 "M0-301. FAMILY PLANNING: Does this facility offer family planning services?"
lab var m0_302a_za "m0_302a_za. ANTENATAL CARE: Does this facility off er routine outpatientantenatal care (ANC) services?" 
lab var m0_302b_za "m0_302b_za. ANTENATAL CARE: Does this facility off er inpatient antenatalcare (ANC) services?"
lab var m0_303 "M0-303. PMTCT: Does this facility offer services for the prevention of mother-to-child transmission of HIV (PMTCT)?"
lab var m0_304 "M0-304. OBSTETRIC AND NEWBORN CARE: Does this facility offer delivery (including normal delivery, basic emergency obstetric care, and/or comprehensive emergency obstetric care) and/or newborn care services?"
lab var m0_305a "M0-305a. CAESAREAN SECTION: Does this facility offer caesarean sections? "
lab var m0_305b "M0-305b. Has a caesarean section been carried out in the last 12 months by providers of delivery services as part of their work in this facility?"
lab var m0_306 "M0-306. IMMUNIZATION: Does this facility offer immunization services? "
lab var m0_307 "M0-307. CHILD PREVENTIVE AND CURATIVE CARE: Does this facility off erpreventative and curative care services for children under 5?"
lab var m0_307a "M0-307a. CHILD PREVENTIVE AND CURATIVE CARE: Does this facility offer preventative and curative care services for children under 5?"
lab var m0_307b "M0-307b. PNC: Does this facility provide postnatal care services for newborn? "
lab var m0_307c "M0-307c. Does this facility provide cervicalscreening (pap smear or VIA single visit approach?"
lab var m0_308 "M0-308. ADOLESCENT HEALTH: Does this facility offer adolescent health services?"
lab var m0_309 "M0-309. HIV TESTING: Does this facility offer HIV counselling and testing services? "
lab var m0_310 "M0-310. HIV TREATMENT: Does this facility offer HIV & AIDS antiretroviral prescription or antiretroviral treatment follow-up services?"

rename (avail_services_311 avail_services_312 avail_services_313 avail_services_314 avail_services_315a avail_services_315b avail_services_315c ///
        avail_services_315d avail_services_315e avail_services_315f avail_services_316 avail_services_317 avail_services_318 avail_services_319) ///
	   (m0_311 m0_312 m0_313 m0_314 m0_315a m0_315b m0_315c m0_315d m0_315e m0_315f m0_316 m0_317 m0_318 m0_319)
lab var m0_311 "M0-311. HIV CARE AND SUPPORT:   Does this facility offer HIV & AIDS care and support services, including treatment of opportunistic infections and provisions of palliative care?"
lab var m0_312 "M0-312. STIs: Does this facility offer diagnosis or treatment of STIs other than HIV?"
lab var m0_313 "M0-313. TB: Does this facility offer diagnosis, treatment prescription, or treatment follow-up of tuberculosis?"
lab var m0_314 "M0-314. MALARIA: Does this facility offer diagnosis or treatment of malaria?"
lab var m0_315a "M0-315a. NCDs: Does this facility offer diagnosis or management of Diabetes"
lab var m0_315b "M0-315b. NCDs: Does this facility offer diagnosis or management of Cardiovascular disease"
lab var m0_315c "M0-315c. NCDs: Does this facility offer diagnosis or management of Chronic respiratory disease / Does this facility offer diagnosis or management of Cardiovascular disease"
lab var m0_315d "M0-315d. NCDs: Does this facility offer diagnosis or management of Cancer diagnosis"
lab var m0_315e "M0-315e. NCDs: Does this facility offer diagnosis or management of Cancer treatment"
lab var m0_315f "M0-315f. NCDs: Does this facility off er diagnosis or management of Mental healthservices"
lab var m0_316 "M0-316. NTDs:  Does this facility offer diagnosis or management of neglected tropical diseases, such as onchocerciasis, lymphatic Fili arsis, schistosomiasis, soil transmitted helminths, trachoma, dracunculiasis, podoconiosis, or leishmaniosis?"
lab var m0_317 "M0-317. SURGERY: Does this facility offer any surgical services (including minor surgery such as suturing, circumcision, wound debridement, etc.), or caesarean section?"
lab var m0_318 "M0-318. BLOOD TRANSFUSION:   Does this facility offer blood transfusion services?"
lab var m0_319 "M0-319. ABORTION: Does this facility offer safe abortion care?"

* 4. Basic equipment and diagnostics
rename (mod0_basic_equip_401a mod0_basic_equip_401b mod0_basic_equip_402a mod0_basic_equip_402b mod0_basic_equip_403a mod0_basic_equip_403b ///
        mod0_basic_equip_404a mod0_basic_equip_404b mod0_basic_equip_405a mod0_basic_equip_405b mod0_basic_equip_406a mod0_basic_equip_406b) ///
		(m0_401 m0_401a m0_402 m0_402a m0_403 m0_403a m0_404 m0_404a m0_405 m0_405a m0_406 m0_406a)
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

rename (mod0_basic_equip_407 mod0_basic_equip_408 mod0_basic_equip_409 mod0_basic_equip_410 mod0_basic_equip_411 mod0_basic_equip_412 ///
        mod0_basic_equip_413 mod0_basic_equip_414 mod0_basic_equip_415) (m0_407 m0_408 m0_409 m0_410 m0_411 m0_412 m0_413 m0_414 m0_415)
lab var m0_407 "M0-407. Does this facility conduct any diagnostic testing including any rapid diagnostic testing?"
lab var m0_408 "M0-408. Rapid malaria testing"
lab var m0_409 "M0-409. Rapid syphilis testing"
lab var m0_410 "M0-401. HIV rapid testing"
lab var m0_411 "M0-402. Urine rapid tests for pregnancy"
lab var m0_412 "M0-403. Urine protein dipstick testing"
lab var m0_413 "M0-403. Urine glucose dipstick testing"
lab var m0_414 "M0-404. Urine ketone dipstick testing"
lab var m0_415 "M0-405. Dry Blood Spot (DBS) collection for HIV viral load or EID (Earlyinfant diagnosis)"	   
	   
rename (mod0_basic_equip_416 mod0_basic_equip_417 mod0_basic_equip_418 mod0_basic_equip_419 mod0_basic_equip_420 mod0_basic_equip_421 ///
        mod0_basic_equip_422 mod0_basic_equip_423 mod0_basic_equip_424 mod0_basic_equip_425)(m0_416 m0_417 m0_418 m0_419 m0_420 m0_421 ///
		m0_422 m0_423 m0_424 m0_425)   
lab var m0_416 "M0-416. Malaria rapid diagnostic kit"
lab var m0_417 "M0-417. Syphilis rapid test kit"
lab var m0_418 "M0-418. SD BIOLIN HIV rapid test kit"
lab var m0_419 "M0-419. STATPACK HIV rapid test kit"
lab var m0_420 "M0-420. UniGold HIV rapid test kit"
lab var m0_421 "M0-421. Urine pregnancy test kit"
lab var m0_422 "M0-422. Dipsticks for urine protein"
lab var m0_423 "M0-423. Dipsticks for urine glucose"
lab var m0_424 "M0-424. Dipsticks for urine ketone bodies"
lab var m0_425 "M0-425. Filter paper for collecting DBS"

rename (mod0_basic_equip_426 mod0_basic_equip_427 mod0_basic_equip_428 mod0_basic_equip_429 mod0_basic_equip_430 mod0_basic_equip_431 ///
        mod0_basic_equip_432 mod0_basic_equip_433 mod0_basic_equip_434 basic_equip_435) (m0_426 m0_427 m0_428 m0_429 m0_430 m0_431 m0_432 ///
		m0_433 m0_434 m0_435)   
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

* 5. Referral system
rename (ref_system_501 ref_system_502 ref_system_503 ref_system_504 ref_system_505 ref_system_506 ref_system_507 ref_system_508) ///
	   (m0_501 m0_502 m0_503 m0_504 m0_505 m0_506 m0_507 m0_508)
lab var m0_501 "M0-501. Does this facility ever refer a woman or newborn to another facility for care?"
lab var m0_502 "M0-502. To which facility does this facility usually refer women or newborns for care?" 
lab var m0_503 "M0-503. What strategies does this facility use to transport emergency patients from this facility?"   
lab var m0_504 "M0-504. After this facility refers a patient, how often do you receive feedback about the treatment or outcomes of that patient?"
lab var m0_505 "M0-505. Does this facility have explicit written guidelines or protocols for the pre-referral management of major obstetric and newborn complications? "
lab var m0_506 "M0-506. Does this facility ever receive women or newborns who have been referred here from a different facility?"
lab var m0_507 "M0-507. Is there a system for staff to determine the priority of need and proper place of treatment of patients, what we call triage?"
lab var m0_508 "M0-508. Does this facility have a maternity waiting home?" 
	   
* 6. Payment for services	   
rename (mod0_pay_services_601 mod0_pay_services_601a mod0_pay_services_602 mod0_pay_services_603 mod0_pay_services_604 mod0_pay_services_605 ///
        mod0_pay_services_605a) (m0_601 m0_602 m0_603 m0_604 m0_605 m0_606 m0_607)   

lab var m0_601 "M0-601. Is formal payment required before receiving maternity services? "
lab var m0_602 "M0-602. Is a woman expected to pay for/buy supplies and medicines for delivery? "
lab var m0_603 "M0-603. In an obstetric emergency, is payment required before receiving care?"
lab var m0_604 "M0-604. In an obstetric emergency, is the woman or her family asked to buy medicine or supplies prior to treatment? "
lab var m0_605 "M0-605. Is there a formal system in place to have fees for maternity services waived for poor women?"
lab var m0_606 "M0-606. Is there any informal system in place to have fees for maternity services waived for poor women? "
lab var m0_607 "M0-607. Is there a fee schedule for services posted in a visible and public place? (Collect data by observation only that was posted or prepared document) "

* 7. Record keeping and HMIS	   
rename (mod0_rec_hmis_701 mod0_rec_hmis_702 mod0_rec_hmis_703 mod0_rec_hmis_703_other mod0_rec_hmis_704 mod0_rec_hmis_705 mod0_rec_hmis_706 ///
        mod0_rec_hmis_707) (m0_701 m0_702 m0_703 m0_703_other m0_704 m0_705 m0_706 m0_707)
	   
lab var m0_701 "M0-701. Does this facility have a system in place to regularly collect maternal and newborn health services data?"
lab var m0_702 "M0-702. Does this facility report data to the health management information system (i.e., HMIS/DHIS2)?"
lab var m0_703 "M0-703. How frequently are MNH data reported to the HMIS?"
lab var m0_703_other "703-Oth. Other"
lab var m0_704 "M0-704. Does this facility have a designated person, such as a data manager or Health Information Technologist, who is responsible for MNH services data?"
lab var m0_705 "M0-705. Is a labor and delivery ward register used at this facility?"
lab var m0_706 "M0-704. Does this facility have a designated person, such as a data manager or Health Information Technologist, who is responsible for MNH services data?"
lab var m0_707 "M0-705. Is a labor and delivery ward register used at this facility?"

* 8. Facility case summary	   
rename (mod0_fac_case_sum_801_jan mod0_fac_case_sum_801_feb mod0_fac_case_sum_801_mar mod0_fac_case_sum_801_apr mod0_fac_case_sum_801_may /// 
        mod0_fac_case_sum_801_jun mod0_fac_case_sum_801_jul mod0_fac_case_sum_801_aug mod0_fac_case_sum_801_sep mod0_fac_case_sum_801_oct ///
		mod0_fac_case_sum_801_nov mod0_fac_case_sum_801_dec mod0_fac_case_sum_801_total) (m0_801_jan m0_801_feb m0_801_mar m0_801_apr m0_801_may ///
		m0_801_jun m0_801_jul m0_801_aug m0_801_sep m0_801_oct m0_801_nov m0_801_dec m0_801_total)
lab var m0_801_jan "M0-801.1. Number of antenatal care visits (all visits) for January"
lab var m0_801_feb "M0-801.2. Number of antenatal care visits (all visits) for February"
lab var m0_801_mar "M0-801.3. Number of antenatal care visits (all visits) for March"
lab var m0_801_apr "M0-801.4. Number of antenatal care visits (all visits) for April"
lab var m0_801_may "M0-801.5. Number of antenatal care visits (all visits) for May"
lab var m0_801_jun "M0-801.6. Number of antenatal care visits (all visits) for June"
lab var m0_801_jul "M0-801.7. Number of antenatal care visits (all visits) for July"
lab var m0_801_aug "M0-801.8. Number of antenatal care visits (all visits) for August"
lab var m0_801_sep "M0-801.9. Number of antenatal care visits (all visits) for September"
lab var m0_801_oct "M0-801.10. Number of antenatal care visits (all visits) for October"
lab var m0_801_nov "M0-801.11. Number of antenatal care visits (all visits) for November"
lab var m0_801_dec "M0-801.12. Number of antenatal care visits (all visits) for December"
lab var m0_801_total "M0-801.total. Total number of antenatal care visits (all visits)"

rename (mod0_fac_case_sum_802_jan mod0_fac_case_sum_802_feb mod0_fac_case_sum_802_mar mod0_fac_case_sum_802_apr mod0_fac_case_sum_802_may ///
        mod0_fac_case_sum_802_jun mod0_fac_case_sum_802_jul mod0_fac_case_sum_802_aug mod0_fac_case_sum_802_sep mod0_fac_case_sum_802_oct ///
		mod0_fac_case_sum_802_nov mod0_fac_case_sum_802_dec mod0_fac_case_sum_802_total) (m0_802_jan m0_802_feb m0_802_mar m0_802_apr m0_802_may ///
		m0_802_jun m0_802_jul m0_802_aug m0_802_sep m0_802_oct m0_802_nov m0_802_dec m0_802_total)
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
lab var m0_802_total "M0-801.total. Total number of first antenatal care visits"
		
rename (mod0_fac_case_sum_803_jan mod0_fac_case_sum_803_feb mod0_fac_case_sum_803_mar mod0_fac_case_sum_803_apr mod0_fac_case_sum_803_may ///
        mod0_fac_case_sum_803_jun mod0_fac_case_sum_803_jul mod0_fac_case_sum_803_aug mod0_fac_case_sum_803_sep mod0_fac_case_sum_803_oct ///
		mod0_fac_case_sum_803_nov mod0_fac_case_sum_803_dec mod0_fac_case_sum_803_total) (m0_803_jan m0_803_feb m0_803_mar m0_803_apr m0_803_may ///
		m0_803_jun m0_803_jul m0_803_aug m0_803_sep m0_803_oct m0_803_nov m0_803_dec m0_803_total)
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
lab var m0_803_total "M0-803.total. Total number of vaginal deliveries"	
	   
rename (mod0_fac_case_sum_804_jan mod0_fac_case_sum_804_feb mod0_fac_case_sum_804_mar mod0_fac_case_sum_804_apr mod0_fac_case_sum_804_may ///
        mod0_fac_case_sum_804_jun mod0_fac_case_sum_804_jul mod0_fac_case_sum_804_aug mod0_fac_case_sum_804_sep mod0_fac_case_sum_804_oct ///
		mod0_fac_case_sum_804_nov mod0_fac_case_sum_804_dec mod0_fac_case_sum_804_total)(m0_804_jan m0_804_feb m0_804_mar m0_804_apr m0_804_may ///
		m0_804_jun m0_804_jul m0_804_aug m0_804_sep m0_804_oct m0_804_nov m0_804_dec m0_804_total)
lab var m0_804_jan "M0-804.1. Number of caesarean deliveries for January"
lab var m0_804_feb "M0-804.2. Number of caesarean deliveries for February"
lab var m0_804_mar "M0-804.3. Number of caesarean deliveries for March"
lab var m0_804_apr "M0-804.4. Number of caesarean deliveries for April"
lab var m0_804_may "M0-804.5. Number of caesarean deliveries for May"
lab var m0_804_jun "M0-804.6. Number of caesarean deliveries for June"
lab var m0_804_jul "M0-804.7. Number of caesarean deliveries for July"
lab var m0_804_aug "M0-804.8. Number of caesarean deliveries for August"
lab var m0_804_sep "M0-804.9. Number of caesarean deliveries for September"
lab var m0_804_oct "M0-804.10. Number of caesarean deliveries for October"
lab var m0_804_nov "M0-804.11. Number of caesarean deliveries for November"
lab var m0_804_dec "M0-804.12. Number of caesarean deliveries for December"
lab var m0_804_total "M0-804.total. Total number of caesarean deliveries"

rename (mod0_fac_case_sum_805_jan mod0_fac_case_sum_805_feb mod0_fac_case_sum_805_mar mod0_fac_case_sum_805_apr mod0_fac_case_sum_805_may ///
        mod0_fac_case_sum_805_jun mod0_fac_case_sum_805_jul mod0_fac_case_sum_805_aug mod0_fac_case_sum_805_sep mod0_fac_case_sum_805_oct ///
		mod0_fac_case_sum_805_nov mod0_fac_case_sum_805_dec mod0_fac_case_sum_805_total)(m0_805_jan m0_805_feb m0_805_mar m0_805_apr m0_805_may ///
		m0_805_jun m0_805_jul m0_805_aug m0_805_sep m0_805_oct m0_805_nov m0_805_dec m0_805_total)
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
lab var m0_805_total "M0-805.total. Total postpartum haemorrhage cases"
		
rename (mod0_fac_case_sum_806_jan mod0_fac_case_sum_806_feb mod0_fac_case_sum_806_mar mod0_fac_case_sum_806_apr mod0_fac_case_sum_806_may ///
        mod0_fac_case_sum_806_jun mod0_fac_case_sum_806_jul mod0_fac_case_sum_806_aug mod0_fac_case_sum_806_sep mod0_fac_case_sum_806_oct ///
		mod0_fac_case_sum_806_nov mod0_fac_case_sum_806_dec mod0_fac_case_sum_806_total) (m0_806_jan m0_806_feb m0_806_mar m0_806_apr m0_806_may ///
		m0_806_jun m0_806_jul m0_806_aug m0_806_sep m0_806_oct m0_806_nov m0_806_dec m0_806_total)
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
lab var m0_806_total "M0-806.total. Total prolonged/obstructed labor cases"
	   
rename (mod0_fac_case_sum_807_jan mod0_fac_case_sum_807_feb mod0_fac_case_sum_807_mar mod0_fac_case_sum_807_apr mod0_fac_case_sum_807_may ///
        mod0_fac_case_sum_807_jun mod0_fac_case_sum_807_jul mod0_fac_case_sum_807_aug mod0_fac_case_sum_807_sep mod0_fac_case_sum_807_oct ///
		mod0_fac_case_sum_807_nov mod0_fac_case_sum_807_dec mod0_fac_case_sum_807_total) (m0_807_jan m0_807_feb m0_807_mar m0_807_apr m0_807_may ///
		m0_807_jun m0_807_jul m0_807_aug m0_807_sep m0_807_oct m0_807_nov m0_807_dec m0_807_total)
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
lab var m0_807_total "M0-807.total. Total severe pre-eclampsia cases"
	   
rename (mod0_fac_case_sum_808_jan mod0_fac_case_sum_808_feb mod0_fac_case_sum_808_mar mod0_fac_case_sum_808_apr mod0_fac_case_sum_808_may ///
        mod0_fac_case_sum_808_jun mod0_fac_case_sum_808_jul mod0_fac_case_sum_808_aug mod0_fac_case_sum_808_sep mod0_fac_case_sum_808_oct ///
		mod0_fac_case_sum_808_nov mod0_fac_case_sum_808_dec mod0_fac_case_sum_808_total) (m0_808_jan m0_808_feb m0_808_mar m0_808_apr m0_808_may ///
		m0_808_jun m0_808_jul m0_808_aug m0_808_sep m0_808_oct m0_808_nov m0_808_dec m0_808_total)
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
lab var m0_808_total "M0-808.total. Total maternal deaths"

rename (mod0_fac_case_sum_809_jan mod0_fac_case_sum_809_feb mod0_fac_case_sum_809_mar mod0_fac_case_sum_809_apr mod0_fac_case_sum_809_may ///
        mod0_fac_case_sum_809_jun mod0_fac_case_sum_809_jul mod0_fac_case_sum_809_aug mod0_fac_case_sum_809_sep mod0_fac_case_sum_809_oct ///
		mod0_fac_case_sum_809_nov mod0_fac_case_sum_809_dec mod0_fac_case_sum_809_total) (m0_809_jan m0_809_feb m0_809_mar m0_809_apr m0_809_may ///
		m0_809_jun m0_809_jul m0_809_aug m0_809_sep m0_809_oct m0_809_nov m0_809_dec m0_809_total)	   	   
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
lab var m0_809_total "M0-809.total. Total stillbirths"
		
rename (mod0_fac_case_sum_810_jan mod0_fac_case_sum_810_feb mod0_fac_case_sum_810_mar mod0_fac_case_sum_810_apr mod0_fac_case_sum_810_may ///
        mod0_fac_case_sum_810_jun mod0_fac_case_sum_810_jul mod0_fac_case_sum_810_aug mod0_fac_case_sum_810_sep mod0_fac_case_sum_810_oct ///
		mod0_fac_case_sum_810_nov mod0_fac_case_sum_810_dec mod0_fac_case_sum_810_total) (m0_810_jan m0_810_feb m0_810_mar m0_810_apr m0_810_may ///
		m0_810_jun m0_810_jul m0_810_aug m0_810_sep m0_810_oct m0_810_nov m0_810_dec m0_810_total)
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
lab var m0_810_total "M0-810.total. Total eclampsia cases"		
		
rename (mod0_fac_case_sum_811_jan mod0_fac_case_sum_811_feb mod0_fac_case_sum_811_mar mod0_fac_case_sum_811_apr mod0_fac_case_sum_811_may ///
        mod0_fac_case_sum_811_jun mod0_fac_case_sum_811_jul mod0_fac_case_sum_811_aug mod0_fac_case_sum_811_sep mod0_fac_case_sum_811_oct ///
		mod0_fac_case_sum_811_nov mod0_fac_case_sum_811_dec mod0_fac_case_sum_811_total) (m0_811_jan m0_811_feb m0_811_mar m0_811_apr m0_811_may ///
		m0_811_jun m0_811_jul m0_811_aug m0_811_sep m0_811_oct m0_811_nov m0_811_dec m0_811_total)
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
lab var m0_811_total "M0-811.total. Total all Neonatal deaths (before 28 days)"
		
rename (mod0_fac_case_sum_812_jan mod0_fac_case_sum_812_feb mod0_fac_case_sum_812_mar mod0_fac_case_sum_812_apr mod0_fac_case_sum_812_may ///
        mod0_fac_case_sum_812_jun mod0_fac_case_sum_812_jul mod0_fac_case_sum_812_aug mod0_fac_case_sum_812_sep mod0_fac_case_sum_812_nov ///
		mod0_fac_case_sum_812_dec mod0_fac_case_sum_812_total) (m0_812_jan m0_812_feb m0_812_mar m0_812_apr m0_812_may m0_812_jun m0_812_jul ///
		m0_812_aug m0_812_sep m0_812_nov m0_812_dec m0_812_total) 
lab var m0_812_jan "M0-812.1. Referrals out of this facility due to obstetric indications for January"
lab var m0_812_feb "M0-812.2. Referrals out of this facility due to obstetric indications for February"
lab var m0_812_mar "M0-812.3. Referrals out of this facility due to obstetric indications for March"
lab var m0_812_apr "M0-812.4. Referrals out of this facility due to obstetric indications for April"
lab var m0_812_may "M0-812.5. Referrals out of this facility due to obstetric indications for May"
lab var m0_812_jun "M0-812.6. Referrals out of this facility due to obstetric indications for June"
lab var m0_812_jul "M0-812.7. Referrals out of this facility due to obstetric indications for July"
lab var m0_812_aug "M0-812.8. Referrals out of this facility due to obstetric indications for August"
lab var m0_812_sep "M0-812.9. Referrals out of this facility due to obstetric indications for September"
lab var m0_812_nov "M0-812.11. Referrals out of this facility due to obstetric indications for November"
lab var m0_812_dec "M0-812.12. Referrals out of this facility due to obstetric indications for December"
lab var m0_812_total "M0-812.total. Total referrals out of this facility due to obstetric indications"
*For 812, could not find mod0_fac_case_sum_812_oct in the dataset
		
rename (mod0_fac_case_sum_813_jan mod0_fac_case_sum_813_feb mod0_fac_case_sum_813_mar mod0_fac_case_sum_813_apr mod0_fac_case_sum_813_may ///
        mod0_fac_case_sum_813_jun mod0_fac_case_sum_813_jul mod0_fac_case_sum_813_aug mod0_fac_case_sum_813_sep mod0_fac_case_sum_813_oct ///
		mod0_fac_case_sum_813_nov mod0_fac_case_sum_813_dec mod0_fac_case_sum_813_total) (m0_813_jan m0_813_feb m0_813_mar m0_813_apr m0_813_may ///
		m0_813_jun m0_813_jul m0_813_aug m0_813_sep m0_813_oct m0_813_nov m0_813_dec m0_813_total)
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
lab var m0_813_total "M0-813.total. Total number of postnatal care visits" 	

	* STEP FOUR: LABELING VARIABLES (starts at: line )
	
	
	* STEP FIVE: ORDER VARIABLES (starts at: line )
	
	order m0_*, sequential
	
	order facility m0_latitude m0_longitude m0_id_za m0_a1_date m0_a1_time ///
	m0_a4_site m0_a4_subsite m0_id m0_ward_za m0_facility_type m0_facility_own m0_urban m0_a13 response*
	
save "$za_data_final/eco_m0_za.dta", replace
		