* Kenya MNH ECohort Data Cleaning File 
* Updated by S. Sabwa, K. Wright, W. Chien
* Last Updated: 13 Mar 2024

*------------------------------------------------------------------------------*
* Instructions: All steps are done by Module, search "MODULE _" to find sections
	
	
	* STEPS: 
		* STEP ONE: RENAME VARIABLES 
		* STEP TW0: ADD VALUE LABELS - NA in KENYA 
		* STEP THREE: RECODING MISSING VALUES 
		* STEP FOUR: LABELING VARIABLES
		* STEP FIVE: ORDER VARIABLES
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*
* MODULE 1:

* Import data
clear all 
use "$ke_data/Module 1/KEMRI_Module_1_ANC_2023z-9-6.dta"

* module var:
gen module = .
replace module = 1 if a4 !=.

*------------------------------------------------------------------------------*
* Create sample: (M1 = 1,007)

keep if consent == 1 // 27 ids dropped
drop if q105 == . // 3 ids dropped

gen country = "Kenya"

*------------------------------------------------------------------------------*

* STEP ONE: RENAME VARAIBLES

rename a1 interviewer_id
rename a4 study_site
rename a5 facility_name2
rename b1 permission
rename (b2 b3) (care_self enrollage)
rename (b4 b4_oth b5 b6) (zone_live zone_live_other b5anc b6anc_first)
*rename a2 device_date_ke
rename (q104 q106) (mobile_phone flash)
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
		bp_time_3_systolic bp_time_3_diastolic time_3_pulse_rate)
rename (q1306 q1307 q1308 q1309 q1401 preferred_phone_oth preferred_phone_confirm) ///
		(m1_1306 m1_1307 m1_1308 m1_1309 m1_1401 m1_1401a_ke m1_1401b_ke)		
rename noconsent_why m1_noconsent_why_ke		
rename end_comment m1_end_comment_ke	
rename (q1401_1 q1401_2 q1401_3 q1401_4) (m1_1401_1_ke m1_1401_2_ke m1_1401_3_ke m1_1401_4_ke)
rename total_cost m1_1218g
rename (q1402 q1402_0 q1402_1 q1402_2 q1402_3 q1402_4 q1402_5 q1402_6 q1402_7) ///
	   (m1_1402_ke m1_1402_0_ke m1_1402_1_ke m1_1402_2_ke m1_1402_3_ke m1_1402_4_ke ///
	   m1_1402_5_ke m1_1402_6_ke m1_1402_7_ke)

rename duration interview_length
rename gest_age_baseline gest_age_baseline_ke
rename consent b7eligible
rename starttime m1_start_time
rename time_start_full m1_date_time
rename endtime m1_end_time
rename date_survey_baseline m1_date
rename q103 respondentid

*===============================================================================

	* STEP TWO: ADD VALUE LABELS (NA in KENYA, already labeled)

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
	
	
* Formatting Dates (SS: do this for all dates in all modules)	 

* Generate new vars:

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

*------------------------------------------------------------------------------*
* recoding for skip pattern logic:	   
	   
* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns


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
 
* SS: Skip pattern for m1_513c: selected (${q513a}, '1')
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
*===============================================================================

ren rec* *	
	
	* STEP FOUR: LABELING VARIABLES
		
lab var country "Country"
lab var interviewer_id "Interviewer ID"
lab var m1_date "A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var study_site "A4. Study site"
lab var facility_name2 "A5. Facility name"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var enrollage "B3. How old are you?"
lab var zone_live "B4. In which zone/district/sub city are you living?"
lab var zone_live_other "B4_-Other. Other zone/district/subcity"
lab var b5anc "B5. By that I mean care related to a pregnancy?"
lab var b6anc_first "B6. Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?"
lab var b7eligible "B7. Is the respondent eligible to participate in the study AND signed a consent form?"
*lab var first_name "101. What is your first name?"
*lab var family_name "102. What is your family name?"
lab var respondentid "103. Respondent ID"
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
lab var m1_203_other "203_-Other. KE only: Other major health problems"
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
lab var m1_301 "301. How would you rate the overall quality of medical care in Kenya?"
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
lab var m1_401_other "401_-Other. Other specify: travel"
lab var m1_402 "402. How long in minutes did it take you to reach this facility from your home?"
lab var m1_403b "403b. How far in kilometers is your home from this facility?"
lab var m1_404 "404. Is this the nearest health facility to your home that provides antenatal care for pregnant women?"
lab var m1_405 "405. What is the most important reason for choosing this facility for your visit today?"
lab var m1_405_other "405_-Other. Specify other reason"
lab var m1_501 "501. What is your first language?"
lab var m1_501_other "501_-Other. Specify other language"
lab var m1_501_ke "501b. Besides your primary/first language, which other languages do you speak fluently?"
lab var m1_501_ke_other "501b_-Other. Specify other language spoken?"
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
lab var m1_506_other "506_-Other. Specify other occupation"
lab var m1_507 "507. What is your religion?"
lab var m1_507_other "507_-Other. Specify other religion"
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
lab var m1_515_county_other "515_-Other. Other county"
lab var m1_515_subcounty "515. Sub-county"
lab var m1_515_subcounty_other "515_-Other. Other sub-county"
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
lab var m1_808_other "808_-Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_810b_other "810_-Other. Specify other facility name where you plan to give birth."
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
lab var m1_812b_other "812b_-Other. Specify other reason why you needed a C-section"
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
lab var m1_815_other "815_-Other. Specify other advice from provider"
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
lab var m1_1102_other "1102_-Other. Specify other person"
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
lab var m1_1104_other "1104_-Other. Specify others who humiliates you"
lab var m1_1105 "1105. During the visit today, did the health provider discuss with you where you can seek support for these things?"
lab var m1_1201 "1201. What is the main source of drinking water for members of your household?"
lab var m1_1201_other "1201_-Other. Specify other source of drink water"
lab var m1_1202 "1202. What kind of toilet facilities does your household have?"
*lab var m1_1202_other "1202_-Other. Specify other kind of toilet facility"
lab var m1_1203 "1203. Does your household have electricity?"
lab var m1_1204 "1204. Does your household have a radio?"
lab var m1_1205 "1205. Does your household have a television?"
lab var m1_1206 "1206. Does your household have a telephone or a mobile phone?"
lab var m1_1207 "1207. Does your household have a refrigerator?"
lab var m1_1208 "1208. What type of fuel does your household mainly use for cooking?"
lab var m1_1208_other "1208_-Other. Specify other fuel type for cooking"
lab var m1_1209 "1209. What is the main material of your floor?"
*lab var m1_1209_other "1209_-Other. Specify other fuel type for cooking"
lab var m1_1210 "1210. What is the main material your walls are made of?"
lab var m1_1210_other "1210_-Other. Specify other fuel type for cooking"
lab var m1_1211 "1211. What is the main material your roof is made of?"
lab var m1_1211_other "1211_-Other. Specify other fuel type for cooking"
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
lab var m1_1218f_other "1218f_-Other. What are those other costs that you incurred?"
lab var m1_1218_total_ke "1218g. Total Spent"
lab var m1_1219 "1219. Total amount spent"
lab var m1_1220 "1220: Which of the following financial sources did your household use to pay for this?"
lab var m1_1220_other "1220_-Other. Specify other financial source for household use to pay for this"
lab var m1_1221 "1221. Are you covered with a health insurance?"
lab var m1_1222 "1222. What type of health insurance coverage do you have?"
lab var m1_1222_other "1222_-Other. Specify other health insurance coverage used."
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
lab var time_3_pulse_rate "Time 3 (Heart Rate)"
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

*===============================================================================

*drop first_name last_name full_name phone1 phone2 phone3 phone4 phone_combi name_baby1 name_baby2 name_baby3 name_baby4 baby_name_1 baby_label_1 baby_list baby_alive_list baby_died_list name_baby_alive1 name_baby_alive2 name_baby_alive3 name_baby_alive4 name_baby_died1 name_baby_died2 name_baby_died3 name_baby_died4	
	
order m1_*, sequential

order country module respondentid interviewer_id m1_date m1_start_time study_site ///
	  facility_name facility_name2 ///
      permission care_self enrollage dob ///
	  zone_live zone_live_other b5anc b6anc_first b7eligible m1_noconsent_why_ke ///
	  mobile_phone flash
order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate ///
	  bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic ///
	  bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)
	  
order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)
order edd_chart_ke edd gest_age_baseline_ke, after(m1_803)
order m1_1218_ke, after(m1_1218c_1)
order m1_1218_other_total_ke, after(m1_1218f_1)
order m1_1218_total_ke, after(m1_1218_other_total_ke)	
	
	* STEP SIX: ORDER/SAVE DATA TO RECODED FOLDER

	save "$ke_data_final/eco_m1_ke.dta", replace
	clear all

*===============================================================================
* MODULE 2:

* Import data
clear all 
use "$ke_data/Module 2/KEMRI_Module_2_ANC_period_SS.dta"

drop if call_status !=1 // N=3,858 obs

* module var: 
gen module = 2 if attempts != .

* ga at baseline and date_survey_baseline are duplicate vars
drop care_reason_ante_label_1 care_reason_ref_label_1 care_visit_reas_rpt_grp_count_1 ///
     care_vis_idx_1_1 care_visit_res_1_1 care_vis_idx_1_2 care_visit_res_1_2 ///
	 care_reason_other_label_pre_1 care_reason_other_label_1 care_reason_label_1 ///
	 q_303_label_2 q_304_label_2 gest_age_baseline date_survey_baseline submissiondate ///
	 q_303_label_2 q_304_label_2 gest_age_baseline date_survey_baseline submissiondate ///
	 q_307_1 q_307_2 q_307_3 q_307_4 q_307_5 q_320 q_702_discrepancy
	 
drop text_audit section6_audio mean_sound_level min_sound_level max_sound_level sd_sound_level pct_sound_between0_60 pct_sound_above80 pct_conversation q_104_calc q_105 q_106 phone1 phone2 phone3 phone4 phone_combi resp_other_name resp_worker module_2_success module_2_first module_2_freq mod_2_freq_label module_2_oth name_confirm name_full outcome_text trim_update q_203a_calc_e q_203b_calc_e q_203c_calc_e q_203d_calc_e q_203e_calc_e q_203f_calc_e q_203g_calc_e q_203h_calc_e q_203_calc_e q_203a_calc_ki q_203b_calc_ki q_203c_calc_ki q_203d_calc_ki q_203e_calc_ki q_203f_calc_ki q_203g_calc_ki q_203h_calc_ki q_203_calc_ki q_203a_calc_ka q_203b_calc_ka q_203c_calc_ka q_203d_calc_ka q_203e_calc_ka q_203f_calc_ka q_203g_calc_ka q_203h_calc_ka q_203_calc_ka q_205a_calc q_205b_calc repeat_g303 q_303_rpt_grp_count q_303_indx_1 q_303_indx_st_1 q_303_indx_nd_1 q_303_indx_rd_1 q_303_indx_x_1 q_303_label_1 q_304_label_1 q_303_indx_2 q_303_indx_st_2 q_303_indx_nd_2 q_303_indx_rd_2 q_303_indx_x_2 q_303_indx_3 q_303_indx_st_3 q_303_indx_nd_3 q_303_indx_rd_3 q_303_indx_x_3 q_303_label_3 q_304_label_3 q_303_indx_4 q_303_indx_st_4 q_303_indx_nd_4 q_303_indx_rd_4 q_303_indx_x_4 q_303_label_4 q_304_label_4 q_303_indx_5 q_303_indx_st_5 q_303_indx_nd_5 q_303_indx_rd_5 q_303_indx_x_5 q_303_label_5 q_304_label_5 user_experience_rpt_grp_count user_exp_idx_1 user_visit_reason_1 user_facility_type_1 user_facility_name_1 user_exp_idx_2 user_visit_reason_2 user_facility_type_2 user_facility_name_2 user_exp_idx_3 user_visit_reason_3 user_facility_type_3 user_facility_name_3 user_exp_idx_4 user_visit_reason_4 user_facility_type_4 user_facility_name_4 user_exp_idx_5 user_visit_reason_5 user_facility_type_5 user_facility_name_5 q_602_filter q202_oth_continue registered_phone mobile_money_name mobile_prov unavailable_reschedule reschedule_full_noavail phone_noavail phone_used phone_used_oth reschedule_resp reschedule_noavail 	 
	 
drop best_phone_resp availability care_reason_ante_label_2 care_reason_ref_label_2 care_visit_reas_rpt_grp_count_2 care_vis_idx_2_1 care_visit_res_2_1 care_vis_idx_2_2 care_visit_res_2_2 care_reason_other_label_pre_2 care_reason_other_label_2 care_reason_label_2 care_reason_ante_label_3 care_reason_ref_label_3 care_visit_reas_rpt_grp_count_3 care_vis_idx_3_1 care_visit_res_3_1 care_vis_idx_3_2 care_visit_res_3_2 care_reason_other_label_pre_3 care_reason_other_label_3 care_reason_label_3 care_reason_ante_label_4 care_reason_ref_label_4 care_visit_reas_rpt_grp_count_4 care_vis_idx_4_1 care_visit_res_4_1 care_vis_idx_4_2 care_visit_res_4_2 care_reason_other_label_pre_4 care_reason_other_label_4 care_reason_label_4 care_reason_ante_label_5 care_reason_ref_label_5 care_visit_reas_rpt_grp_count_5 care_vis_idx_5_1 care_visit_res_5_1 care_vis_idx_5_2 care_visit_res_5_2 care_reason_other_label_pre_5 care_reason_other_label_5 care_reason_label_5 

drop consent_audio full_name confirm_gestational gest_update_calc days_callback_mod3 confirm_phone end_comment enum_name_mod1 formdef_version key language_label today_date

*------------------------------------------------------------------------------*

* STEP ONE: RENAME VARAIBLES

rename attempts m2_attempt_number
rename attempts_oth m2_attempt_number_other
rename call_response m2_attempt_outcome
rename resp_language m2_resp_lang1
rename resp_language_no m2_resp_lang2
rename resp_language_no_oth m2_resp_lang_other
rename resp_other m2_attempt_relationship
rename resp_other_oth m2_attempt_relationship_other
rename resp_available m2_attempt_avail
rename best_phone_reconfirm m2_attempt_contact
*rename best_phone_resp m2_attempt_bestnumber
rename resp_available_when m2_attempt_goodtime
	   
encode reschedule_date_resp ,gen(m2_reschedule_resp)
drop reschedule_date_resp	   
	   
rename intro_yn m2_consent_recording

encode mod_2_round,generate(m2_completed_attempts)
drop mod_2_round

rename q_103 m2_time_start
rename q_101 m2_interviewer

*rename gest_age_baseline m2_baseline_ga //this was M1 ga so I dropped so it's not confusing
*rename date_survey_baseline m2_baseline_date // this is the m1 surveydate, dropped for now
rename q_109 m2_maternal_death_reported

encode q_107, gen(m2_ga)
drop q_107

encode q_108, generate(m2_hiv_status)
drop q_108

encode county, generate(m2_county)

rename (enum_name date_death_knows) /// 
       (m2_enum m2_date_of_maternal_death_yesno) 
	   
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
encode phq_score, gen(m2_phq2_ke)
drop phq_score

rename q_206 m2_206

rename (q_303_3 q_303_4 q_303_5) (m2_303c m2_303d m2_303e)
	   
rename (q_304_3 q_304_oth_3 q_304_4 ///
        q_304_oth_4 q_304_5 q_304_oth_5) ///
	   (m2_304c m2_304c_other m2_304d ///
	    m2_304d_other m2_304e m2_304e_other)

rename q_307_oth_1 m2_307_other

encode q_307_2_1,gen(m2_306_2)
drop q_307_2_1
encode q_307_3_1,gen(m2_306_3)
drop q_307_3_1
encode q_307_4_1,gen(m2_306_4)
drop q_307_4_1
encode q_307_5_1,gen(m2_306_5)
drop q_307_5_1
encode q_307__96_1,gen(m2_306_96)
drop q_307__96_1

rename q_307_oth_2 m2_310_other

encode q_307_1_2,gen(m2_308_1)
drop q_307_1_2
encode q_307_2_2,gen(m2_308_2)
drop q_307_2_2
encode q_307_3_2,gen(m2_308_3)
drop q_307_3_2
encode q_307_4_2,gen(m2_308_4)
drop q_307_4_2
encode q_307_5_2,gen(m2_308_5)
drop q_307_5_2
encode q_307__96_2, gen(m2_308_96)
drop q_307__96_2

rename (q_305_3 q_306_3 q_307_oth_3) (m2_311 m2_312 m2_313_other)

encode q_307_1_3,gen(m2_311_1)
drop q_307_1_3
encode q_307_2_3,gen(m2_311_2)
drop q_307_2_3
encode q_307_3_3,gen(m2_311_3)
drop q_307_3_3
encode q_307_4_3,gen(m2_311_4)
drop q_307_4_3
encode q_307_5_3,gen(m2_311_5)
drop q_307_5_3
encode q_307__96_3,gen(m2_311_96)
drop q_307__96_3

rename (q_305_4 q_306_4 q_307_oth_4) (m2_314 m2_315 m2_316_other) 

encode q_307_1_4,gen(m2_314_1)
drop q_307_1_4
encode q_307_2_4,gen(m2_314_2)
drop q_307_2_4
encode q_307_3_4,gen(m2_314_3)
drop q_307_3_4
encode q_307_4_4,gen(m2_314_4)
drop q_307_4_4
encode q_307_5_4,gen(m2_314_5)
drop q_307_5_4
encode q_307__96_4,gen(m2_314_96)
drop q_307__96_4

rename (q_305_5 q_306_5 q_307_oth_5) (m2_317 m2_318 m2_319_other)  

encode q_307_1_5, gen(m2_317_1)
drop q_307_1_5
encode q_307_2_5, gen(m2_317_2)
drop q_307_2_5
encode q_307_3_5, gen(m2_317_3) 
drop q_307_3_5
encode q_307_4_5, gen(m2_317_4) 
drop q_307_4_5
encode q_307_5_5, gen(m2_317_5)
drop q_307_5_5
encode q_307__96_5, gen(m2_317_96)
drop q_307__96_5


rename (q_320_0 q_320_1 q_320_2 q_320_3 q_320_4 q_320_5 q_320_6 q_320_7 q_320_8 ///
        q_320_9 q_320_10 q_320_11 q_320_12 q_320__96 q_320__99 q_320_other) ///
	   (m2_320_0 m2_320a m2_320b m2_320c m2_320d m2_320e m2_320f m2_320g /// 
	    m2_320h m2_320i m2_320j m2_320k m2_320_12_ke m2_320_96 m2_320_99 m2_320_other)
		
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
rename (q_508a q_508b q_508c) (m2_508a m2_508b_num m2_508c_time)	  
rename (q_509_1 q_509_2 q_509_3 q_509_0) (m2_509a m2_509b m2_509c m2_509_0) 

rename (q_601 q_601_1 q_601_3 q_601_4 q_601_5 q_601_6 q_601_7 q_601_8 q_601_9 ///
		q_601_10 q_601_11 q_601_12 q_601_13 q_601_14 q_601__96 q_601_2 q_601_other ///
		q_601_0) (m2_601 m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g ///
		m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601o ///
		m2_601n_other m2_601_0)
rename q_602 m2_602b 
rename q_603 m2_603 

rename (q_702a q_702b q_702c q_702d q_702e q_702e_other) ///
       (m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_702_other_ke)
	   
encode q_701_total, generate(m2_703)
drop q_701_total

rename q_702_medication m2_702_meds_ke
rename q_702_total m2_704_confirm
rename (q_705_1 q_705_2 q_705_3 q_705_4 q_705_5 q_705_6 q_705__96 q_705_other) ///
       (m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 m2_705_other)
rename call_status m2_complete
rename refused_why m2_refused_why

rename facility_name m2_site 

rename q_102 m2_date

rename starttime m2_start_time
rename date_confirm m2_date_confirm
rename time_start_full m2_date_time
rename gestational_update m2_ga_estimate
rename q_302 m2_302
rename q_301 m2_301
rename (q_303_1 q_303_2) (m2_303a m2_303b)
rename (q_304_1 q_304_oth_1 q_304_2 q_304_oth_2) ///
	   (m2_304a m2_304a_other m2_304b m2_304b_other)
rename (q_305_1 q_306_1) (m2_305 m2_306)	 
encode q_307_1_1, gen(m2_306_1)
drop q_307_1_1
  
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

*===============================================================================

	* STEP TWO: ADD VALUE LABELS (NA in KENYA, already labeled)

* Formatting Dates (SS: do this for all dates in all modules)	 

	*Date and time of M2 (SS: double check this is saving time as wells)
	gen _m2_date_time_ = date(m2_date_time,"YMDhms")
	drop m2_date_time
	rename _m2_date_time_ m2_date_time
	format m2_date_time %td  
	
	/*
	gen _m2_date_ = date(m2_date,"YMD")
	drop m2_date
	rename _m2_date_ m2_date
	format m2_date %td  */
	   
	/* SS: need to figure out how to do this without adding the "01jan1960 infront of the time" 
	*https://www.reed.edu/psychology/stata/gs/tutorials/datesandtimes.html 
	Time
	gen double _m2_time_start_ = clock(m2_time_start,"hm")
	drop m2_time_start
	rename _m2_time_start_ m2_time_start
	format m2_time_start %tc */

*===============================================================================	
	
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 

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

recode m2_ga_estimate (998 = .d) 

recode m2_602b (-999 = .r) // SS: double check with KE team

recode m2_702_meds_ke m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost  m2_704_confirm (999 = .d) // SS: double check with KE team

*------------------------------------------------------------------------------*

* recoding for skip pattern logic:	   
	   
* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns

recode m2_date_time m2_interviewer m2_county m2_attempt_number m2_attempt_number_other m2_attempt_outcome m2_resp_lang1 m2_resp_lang2 m2_attempt_relationship m2_attempt_avail m2_attempt_contact m2_reschedule_resp m2_completed_attempts m2_ga_estimate (. = .a) if module !=2

recode m2_attempt_number_other (. = .a) if m2_attempt_number !=96

recode m2_resp_lang1 (. = .a) if m2_attempt_outcome !=1

recode m2_resp_lang2 (. = .a) if m2_resp_lang1 !=0

replace m2_resp_lang_other = ".a" if m2_resp_lang2 !=-96

recode m2_attempt_relationship (. = .a) if m2_attempt_outcome !=2

replace m2_attempt_relationship_other = ".a" if m2_attempt_relationship !=96

recode m2_attempt_avail (. = .a) if m2_attempt_outcome !=2

recode m2_attempt_contact m2_attempt_goodtime (. = .a) if m2_attempt_avail !=0 | m2_maternal_death_reported ==1

recode m2_reschedule_resp (. = .a) if m2_attempt_goodtime !=1

recode m2_maternal_death_reported (. = .a) if m2_attempt_avail != 0

recode m2_date_of_maternal_death_yesno m2_date_of_maternal_death (. = .a) if m2_maternal_death_reported !=1

*SS: fix this - needs merged dataset
*recode m2_hiv_status (. = .a) if m1_202e != 0 | m1_202e != 1

recode m2_date_of_maternal_death (. = .a) if m2_maternal_death_reported !=1

recode m2_maternal_death_learn (. = .a) if m2_maternal_death_reported !=1

replace m2_maternal_death_learn_other = ".a" if m2_maternal_death_learn != -96

recode m2_201 m2_202 (. = .a) if module !=2 | m2_consent_recording !=1

replace m2_202_other = ".a" if m2_202 !=3

recode m2_ga_estimate (. = .a) if m2_ga == .

recode m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i m2_205a m2_205b m2_phq2_ke m2_206 m2_301 (. = .a) if m2_202 !=1

recode m2_302 (. = .a) if m2_301 !=1

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
recode m2_306 (. = .a) if m2_305 !=0

recode m2_306_1 (. = .a) if m2_306 !=0
recode m2_306_2 (. = .a) if m2_306 !=0
recode m2_306_3 (. = .a) if m2_306 !=0
recode m2_306_4 (. = .a) if m2_306 !=0
recode m2_306_5 (. = .a) if m2_306 !=0
recode m2_306_96 (. = .a) if m2_306 !=0
replace m2_307_other = ".a" if m2_306_96 !=2

recode m2_308 (. = .a) if m2_302 == 1 | m2_302 == . | m2_302 == .a
recode m2_309 (. = .a) if m2_308 !=0

recode m2_308_1 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_308_2 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_308_3 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_308_4 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_308_5 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_308_96 (. = .a) if m2_308 !=0 | m2_308 !=1
replace m2_310_other = ".a" if m2_308_96 !=2

recode m2_311 (. = .a) if m2_302 == 2 | m2_302 == 1 | m2_302 == . | m2_302 == .a
recode m2_312 (. = .a) if m2_311 !=0

recode m2_311_1 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_311_2 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_311_3 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_311_4 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_311_5 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_311_96 (. = .a) if m2_311 !=0 | m2_311 !=1
replace m2_313_other = ".a" if m2_311_96 !=2

recode m2_314 (. = .a) if m2_302 == 3 | m2_302 == 2 | m2_302 == 1 | m2_302 == . | m2_302 == .a
recode m2_315 (. = .a) if m2_314 !=0

recode m2_314_1 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_314_2 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_314_3 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_314_4 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_314_5 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_314_96 (. = .a) if m2_314 !=0 | m2_314 !=1
replace m2_316_other = ".a" if m2_314_96 !=2

recode m2_317 (. = .a) if m2_302 == 4 | m2_302 == 3 | m2_302 == 2 | m2_302 == 1 | m2_302 == . | m2_302 == .a
recode m2_318 (. = .a) if m2_317 !=0

recode m2_317_1 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_317_2 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_317_3 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_317_4 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_317_5 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_317_96 (0 = .a) if m2_314 !=0 | m2_314 !=1
replace m2_319_other = ".a" if m2_317_96 !=2

recode m2_320_0 (. = .a) if m2_301 !=0
recode m2_320a (. = .a) if m2_301 !=0
recode m2_320b (. = .a) if m2_301 !=0
recode m2_320c (. = .a) if m2_301 !=0
recode m2_320d (. = .a) if m2_301 !=0
recode m2_320e (. = .a) if m2_301 !=0
recode m2_320f (. = .a) if m2_301 !=0
recode m2_320g (. = .a) if m2_301 !=0
recode m2_320h (. = .a) if m2_301 !=0
recode m2_320i (. = .a) if m2_301 !=0
recode m2_320j (. = .a) if m2_301 !=0
recode m2_320k (. = .a) if m2_301 !=0
recode m2_320_96 (. = .a) if m2_301 !=0
recode m2_320_99 (. = .a) if m2_301 !=0


recode m2_321 (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a
                       
recode m2_401 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == . | m2_302 == .a)

recode m2_402 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a)				   

recode m2_403 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2)	

recode m2_404 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3)			   
recode m2_405 (. = .a) if (m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a) | (m2_302 == 1 | m2_302 == . | m2_302 == .a | m2_302 == 2 | m2_302 == 3 | m2_302 == 4)

recode m2_501a (. = .a) if m2_301 !=1
recode m2_501b (. = .a) if m2_301 !=1
recode m2_501c (. = .a) if m2_301 !=1
recode m2_501d (. = .a) if m2_301 !=1
recode m2_501e (. = .a) if m2_301 !=1
recode m2_501f (. = .a) if m2_301 !=1
recode m2_501g (. = .a) if m2_301 !=1


recode m2_503a (. = .a) if m2_502 !=1
recode m2_503b (. = .a) if m2_502 !=1
recode m2_503c (. = .a) if m2_502 !=1
recode m2_503d (. = .a) if m2_502 !=1
recode m2_503e (. = .a) if m2_502 !=1
recode m2_503f (. = .a) if m2_502 !=1
recode m2_504 (. = .a) if m2_502 !=1

replace m2_504_other = ".a" if m2_504 !=1

recode m2_505a (. = .a) if m2_503a !=1
recode m2_505b (. = .a) if m2_503b !=1
recode m2_506c (. = .a) if m2_503c !=1
recode m2_505d (. = .a) if m2_503d !=1
recode m2_505e (. = .a) if m2_503e !=1
recode m2_505f (. = .a) if m2_503f !=1
recode m2_505g (. = .a) if m2_504 !=1

recode m2_506a (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506b (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506c (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

recode m2_506d (. = .a) if m2_202 == 2 | m2_202 == 3 | m2_202 == . | m2_202 == .a | m2_301 == 0 | m2_301 == 98 | m2_301 == 99 | m2_301 == . | m2_301 == .a

/* m2_507 is a multi-checkbox string
recode m2_507 (. = .a) if (m2_203a == 0 & m2_203b == 0 & m2_203c == 0 & ///
						  m2_203d == 0 & m2_203e == 0 & m2_203f == 0 & ///
						  m2_203g == 0 & m2_203h == 0) | ///
						  (m2_301 == 0 | m2_301 == . | m2_301 == .a)*/

recode m2_508a (. = .a) if (m2_205a+m2_205b) <3 | m2_202 !=1
recode m2_508b_num (. = .a) if m2_508a !=1
recode m2_508c_time (. = .a) if m2_508a !=1

recode m2_509a (. = .a) if m2_301 !=1
recode m2_509b (. = .a) if m2_301 !=1
recode m2_509c (. = .a) if m2_301 !=1

recode m2_601a (. = .a) if m2_202 !=1
recode m2_601b (. = .a) if m2_202 !=1
recode m2_601c (. = .a) if m2_202 !=1
recode m2_601c (. = .a) if m2_202 !=1
recode m2_601d (. = .a) if m2_202 !=1
recode m2_601e (. = .a) if m2_202 !=1
recode m2_601f (. = .a) if m2_202 !=1
recode m2_601g (. = .a) if m2_202 !=1
recode m2_601h (. = .a) if m2_202 !=1
recode m2_601i (. = .a) if m2_202 !=1
recode m2_601j (. = .a) if m2_202 !=1
recode m2_601l (. = .a) if m2_202 !=1
recode m2_601m (. = .a) if m2_202 !=1
recode m2_601n (. = .a) if m2_202 !=1
recode m2_601_0 (. = .a) if m2_202 !=1
replace m2_601n_other = ".a" if m2_601n !=1

egen meds = rowtotal(m2_601a m2_601o m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601_0)

recode m2_602b (. = .a) if meds==0 | meds==1
drop meds

recode m2_603 (. = .a) if m2_202 !=1 | m2_601a ==1
recode m2_701 (. = .a) if m2_202 !=1 | m2_301 !=1

recode m2_702a_cost (. = .a) if m2_701 !=1
recode m2_702b_cost (. = .a) if m2_701 !=1
recode m2_702c_cost (. = .a) if m2_701 !=1
recode m2_702d_cost (. = .a) if m2_701 !=1
recode m2_702e_cost (. = .a) if m2_701 !=1
replace m2_702_other_ke = ".a" if m2_702e_cost !=1

recode m2_703 m2_704_confirm (. = .a) if m2_701 !=1 | m2_702_meds_ke ==.

recode m2_705_1 (. = .a) if m2_701 !=1
recode m2_705_2 (. = .a) if m2_701 !=1
recode m2_705_3 (. = .a) if m2_701 !=1
recode m2_705_4 (. = .a) if m2_701 !=1
recode m2_705_5 (. = .a) if m2_701 !=1
recode m2_705_6 (. = .a) if m2_701 !=1
recode m2_705_96 (. = .a) if m2_701 !=1

replace m2_705_other = ".a" if m2_705_96 !=1

recode m2_complete (. = .a) if module !=2
*replace m2_refused_why = ".a" if m3_start_p1 !=0 

replace m2_enum = ".a" if module !=2 | m2_start_time == .
recode m2_start_time (. = .a) if module !=2

recode m2_attempt_avail (. = .a) if m2_attempt_relationship !=4
*recode m2_completed_attempts (. = .a) if m2_complete !=1 | m2_consent_recording !=1

*Note: i dropped "availability" which is the filtering var for the consent for recording so this is another way I filtered it
*recode m2_consent_recording (. = .a) if m2_attempt_avail == 0

recode m2_date (. = .a) if m2_202 !=1
recode m2_date_confirm (. = .a) if m2_date == . | m2_202 !=1

recode m2_ga (. = .a) if m2_date == . | m2_202 !=1 | m2_complete == 1
recode m2_ga_estimate (. = .a) if m2_date == . | m2_202 !=1 | q_107_trim != "NA"
drop q_107_trim

recode m2_endtime (. = .a) if m2_date == . | m2_202 != 1 | m2_complete !=1

*===============================================================================
	
	* STEP FOUR: LABELING VARIABLES
	
label variable m2_attempt_number "Which attempt is this at calling the respondent?"
label variable m2_attempt_number_other "Other, specify"
label variable m2_attempt_outcome "What was the response?"
label variable m2_resp_lang1 "Are you able to communicate with the respondent or do they speak a language foreign to you?"
label variable m2_resp_lang2 "Which language does the respondent speak?"
label variable m2_resp_lang_other "Other language, specify"
label variable m2_attempt_relationship "What is the relationship between the owner of this phone and the participant?"
label variable m2_attempt_relationship_other "Specify other relationship"
label variable m2_attempt_avail "Respondent's availability"
label variable m2_attempt_contact "Is this still the best contact to reach the participant?"
label variable m2_attempt_goodtime "Do you know when would be a good time to reach the participant"
label variable m2_reschedule_resp "Could you let me know at which date and time the participant would be available"
label variable m2_completed_attempts "Module 2 completed attempts"
label variable m2_consent_recording	"Consent to audio recording"
label variable m2_start_time "Start date and time"
label variable m2_date "102. Date of interview (D-M-Y)"
label variable m2_date_time "Start time (YYYY:MM:DD HH:MM:SS)"
label variable m2_date_confirm "The date on this device is (m2_date), is this the correct date?"
label variable m2_time_start "103. Time of interview started"
label variable m2_county "County"
label variable m2_interviewer "Interviewer name"
label variable m2_maternal_death_reported "108. Maternal death reported"
label variable m2_ga "107a. Gestational age at this call based on LNMP (in weeks)"
label variable m2_hiv_status "109. HIV status"
label variable m2_date_of_maternal_death "110. Date of maternal death (D-M-Y)"
label variable m2_maternal_death_learn "111. How did you learn about the maternal death?"
label variable m2_maternal_death_learn_other "111-Other. Specify other way of learning maternal death"
label variable m2_201 "201. In general, how would you rate your overall health?"
label variable m2_202 "202. Are you still pregnant, or did something else happen?"
label variable m2_202_other "What happened?"
label variable m2_202_delivery_date "202. KE only: On which date did you deliver?"
label variable m2_202_other_date "202. On which date did this occur?"
label variable m2_203a "203a. Have you experienced severe or persistent headaches?"
label variable m2_203b "203b. Have you experienced vaginal bleeding of any amount?"
label variable m2_203c "203c. Have you experienced fever?"
label variable m2_203d "203d. Have you experienced severe abdominal pain, not just discomfort?"
label variable m2_203e "203e. Have you experienced a lot of difficult breathing?"
label variable m2_203f "203f. Have you experienced convulsions or seizures?"
label variable m2_203g "203g. Have you experienced repeated fainting or loss of consciousness?"
label variable m2_203h "203h. Have noticed that the baby has completely stopped moving?"
label variable m2_204i "204i. Have you experienced any other major health problems?"
label variable m2_204i_other "204i-Other. Specify any other feeling since last visit"
label variable m2_205a "205a. How many days have you been bothered by little interest or pleasure in doing things?"
label variable m2_205b "205b. How many days have you been bothered by feeling down, depressed, or hopeless?"
label variable m2_205b "PHQ-2 score"
label variable m2_206 "206. How often do you currently smoke cigarettes or use any other type of tobacco?"
label variable m2_301 "301. Have you been seen or attended to by a clinician or healthcare provider for yourself?   "
label variable m2_302 "302. How many times have you been seen or attended to by a clinician or healthcare provider for yourself?"
label variable m2_303a "303a. Where did this new 1st healthcare consultation for yourself take place?"
label variable m2_303b "303b. Where did the 2nd healthcare consultation for yourself take place?"
label variable m2_303c "303c. Where did the 3rd healthcare consultation for yourself take place?"
label variable m2_303d "303d. Where did the 4th healthcare consultation for yourself take place?"
label variable m2_303e "303e. Where did the 5th healthcare consultation for yourself take place?"
label variable m2_304a "304a. What is the name of the facility where this first healthcare consultation took place?"
label variable m2_304a_other "304a-Other. Other facility for 1st health consultation"
label variable m2_304b "304b. What is the name of the facility where the second healthcare consultation took place?"
label variable m2_304b_other "304b-Other. Other facility for 2nd health consultation"
label variable m2_304c "304c. What is the name of the facility where the third healthcare consultation took place?"
label variable m2_304c_other "304c-Other. Other facility for 3rd health consultation"
label variable m2_304d "304d. What is the name of the facility where the fourth healthcare consultation took place?"
label variable m2_304d_other "304d-Other. Other facility for 4th health consultation"
label variable m2_304e "304e. What is the name of the facility where the fifth healthcare consultation took place?"
label variable m2_304e_other "304e-Other. Other facility for 5th health consultation"
label variable m2_305 "305. Was the first consultation for a routine antenatal care visit?"
label variable m2_306 "306. Was the first consultation for a referral from your antenatal care provider?"
label variable m2_306_1 "307. A new health problem, including an emergency or an injury"
label variable m2_306_2 "307. An existing health problem"
label variable m2_306_3 "307. A lab test, x-ray, or ultrasound"
label variable m2_306_4 "307. To pick up medicine"
label variable m2_306_5 "307. To get a vaccine"
label variable m2_306_96 "307. Other reasons"
label variable m2_307_other "307-Other. Specify other reason for the 1st visit"
label variable m2_308 "308. Was the second consultation is for a routine antenatal care visit?"
label variable m2_309 "309. Was the second consultation is for a referral from your antenatal care provider?"
label variable m2_308_1 "310. Was the second consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_308_2 "310. Was the second consultation for any of the following? An existing health problem"
label variable m2_308_3 "310. Was the second consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_308_4 "310. Was the second consultation for any of the following? To pick up medicine"
label variable m2_308_5 "310. Was the second consultation for any of the following? To get a vaccine"
label variable m2_308_96 "310. Was the second consultation for any of the following? Other reasons"
label variable m2_310_other "310-Other. Specify other reason for second consultation"
label variable m2_311 "311. Was the third consultation is for a routine antenatal care visit?"
label variable m2_312 "312. Was the third consultation is for a referral from your antenatal care provider?"
label variable m2_311_1 "313. Was the third consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_311_2 "313. Was the third consultation for any of the following? An existing health problem"
label variable m2_311_3 "313. Was the third consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_311_4 "313. Was the third consultation for any of the following? To pick up medicine"
label variable m2_311_5 "313. Was the third consultation for any of the following? To get a vaccine"
label variable m2_311_96 "313. Was the third onsultation for any of the following? Other reasons"
label variable m2_313_other "313-Other. Specify any other reason for the third consultation"
label variable m2_314 "314. Was the fourth consultation is for a routine antenatal care visit?"
label variable m2_315 "315. Was the fourth consultation is for a referral from your antenatal care provider?"
label variable m2_314_1 "316. Was the fourth consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_314_2 "316. Was the fourth consultation for any of the following? An existing health problem"
label variable m2_314_3 "316. Was the fourth consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_314_4 "316. Was the fourth consultation for any of the following? To pick up medicine"
label variable m2_314_5 "316. Was the fourth consultation for any of the following? To get a vaccine"
label variable m2_314_96 "316. Was the fourth onsultation for any of the following? Other reasons"
label variable m2_316_other "316-Other. Specify other reason for the fourth consultation"
label variable m2_317 "317. Was the fifth consultation is for a routine antenatal care visit?"
label variable m2_318 "318. Was the fifth consultation is for a referral from your antenatal care provider?"
label variable m2_317_1 "319. Was the fifth consultation is for any of the following? A new health problem, including an emergency or an injury"
label variable m2_317_2 "319. Was the fifth consultation is for any of the following? An existing health problem"
label variable m2_317_3 "319. Was the fifth consultation is for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_317_4 "319. Was the fifth consultation is for any of the following? To pick up medicine"
label variable m2_317_5 "319. Was the fifth consultation is for any of the following? To get a vaccine"
label variable m2_317_96 "319. Was the fifth consultation is for any of the following? Other reasons"
label variable m2_319_other "319-Other. Specify other reason for the fifth consultation"
label variable m2_320_0 "320. No reason or you didn't need it"
label variable m2_320a "320. You tried but were sent away (e.g., no appointment available) "
label variable m2_320b "320. High cost (e.g., high out of pocket payment, not covered by insurance)"
label variable m2_320c "320. Far distance (e.g., too far to walk or drive, transport not readily available)"
label variable m2_320d "320. Long waiting time (e.g., long line to access facility, long wait for the provider)"
label variable m2_320e "320. Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
label variable m2_320f "320. Staff don't show respect (e.g., staff is rude, impolite, dismissive)"
label variable m2_320g "320. Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
label variable m2_320h "320. COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) "
label variable m2_320i "320. COVID-19 fear"
label variable m2_320j "320. Don't know where to go/too complicated"
label variable m2_320k "320. Fear of discovering serious problem"
label variable m2_320_12_ke "320. KE only: Next ANC visit is scheduled"
label variable m2_320_96 "320. Other, specify"
label variable m2_320_99 "320. Refused"
label variable m2_320_other "320 Other. Specify other reason preventing receiving more antenatal care"
label variable m2_321 "321. Other than in-person visits, did you have contacs with a health care provider by phone, SMS, or web regarding your pregnancy?"
label variable m2_401 "401. How would you rate the quality of care that you received from the health facility where you took the 1st consultation?"
label variable m2_402 "402. How would you rate the quality of care that you received from the health facility where you took the 2nd consultation?"
label variable m2_403 "403. How would you rate the quality of care that you received from the health facility where you took the 3rd consultation?"
label variable m2_404 "404. How would you rate the quality of care that you received from the health facility where you took the 4th consultation?"
label variable m2_405 "405. How would you rate the quality of care that you received from the health facility where you took the 5th consultation?"
label variable m2_501 "501. Since we last spoke, did you receive any of the following diagnostic tests at least once?"
label variable m2_501_0 "501. None of the above"
label variable m2_501a "501a. Did you get your blood pressure measured (with a cuff around your arm)?"
label variable m2_501b "501b. Did you get your weight taken (using a scale)?"
label variable m2_501c "501c. Did you get a blood draw (that is, taking blood from your arm with a syringe)?"
label variable m2_501d "501d. Did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
label variable m2_501e "501e. Did you get a urine test (that is, where you peed in a container)?"
label variable m2_501f "501f. Did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
label variable m2_501g "501g. Did you get any other tests?"
label variable m2_501g_other "501g-Other. Specify any other test you took since you last spoke to us"
label variable m2_502 "502. Did you receive any new test results from a health care provider? By that I mean, any result from a blood or urine sample or from blood pressure measurement. Do not include any results that were given to you during your first antenatal care visit or during the first survey, only new ones."
label variable m2_503 "503. Did you receive a result for:"
label variable m2_503_0 "503. None of the above"
label variable m2_503a "503a. Did you receive a result for Anemia?"
label variable m2_503b "503b. Did you receive a result for HIV?"
label variable m2_503c "503c. Did you receive a result for HIV viral load?"
label variable m2_503d "503d. Did you receive a result for Syphilis?"
label variable m2_503e "503e. Did you receive a result for diabetes?"
label variable m2_503f "503f. Did you receive a result for Hypertension?"
label variable m2_504 "504. Did you receive any other new test results?"
label variable m2_504_other "504-Other. Specify other test result you receive"
label variable m2_505a "505a. What was the result of the test for anemia?"
label variable m2_505b "505b. What was the result of the test for HIV?"
label variable m2_505c "505c. What was the result of the test for HIV viral load?"
label variable m2_505d "505d. What was the result of the test for syphilis?"
label variable m2_505e "505e. What was the result of the test for diabetes?"
label variable m2_505f "505f. What was the result of the test for hypertension?"
label variable m2_505g "505g. What was the result of the test for other tests?"
label variable m2_506 "506. Did you discuss any of the following with a healthcare provider, or not?"
label variable m2_506_0 "506. None of the above"
label variable m2_506a "506a. Did you and a healthcare provider discuss about the signs of pregnancy complications that would require you to go to the health facility?"
label variable m2_506b "506b. Did you and a healthcare provider discuss about your birth plan that is, where you will deliver, how you will get there, and how you need to prepare, or didnt you?"
label variable m2_506c "506c. Did you and a healthcare provider discuss about care for the newborn when he or she is born such as warmth, hygiene, breastfeeding, or the importance of postnatal care?"
label variable m2_506d "506d. Did you and a healthcare provider discuss about family planning options for after delivery?"
label variable m2_507 "507. What did the health care provider tell you to do regarding these new symptoms?"
label variable m2_507_1_ke "507. KE only: Nothing, we did not discuss this"
label variable m2_507_2_ke "507. KE only: They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
label variable m2_507_3_ke "507. KE only: They provided a treatment in the visit"
label variable m2_507_4_ke "507. KE only: They prescribed a medication"
label variable m2_507_5_ke "507. KE only: They told you to come back to this health facility"
label variable m2_507_6_ke "507. KE only: They told you to go somewhere else for higher level care"
label variable m2_507_7_ke "507. KE only: They told you to wait and see"
label variable m2_507_96_ke "507. KE only: Other (Specify)"
label variable m2_507_other_ke "507-Other. KE only: Other advice, specify "
label variable m2_508a "508a. Did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves."
label variable m2_508b_num "508b. How many of these sessions did you have since you last spoke to us?"
label variable m2_508c_time "508d. How many minutes did this/these visit(s) last on average?"
label variable m2_509 "509. Since we last spoke, did a health care provider tell you:"
label variable m2_509_0 "509. None of the above"
label variable m2_509a "509a. Did a healthcare provider tells you that you needed to go see a specialist like an obstetrician or a gynecologist?"
label variable m2_509b "509b. Did a healthcare provider tells you that you needed to go to the hospital for follow-up antenatal care?"
label variable m2_509c "509c. Did a healthcare provider tell you that you will need a C-section?"
label variable m2_601 "601. Did you get:"
label variable m2_601_0 "601. None of the above"
label variable m2_601a "601a. Did you get iron or folic acid pills like IFAS or Pregnacare?"
label variable m2_601b "601b. Did you get calcium pills?"
label variable m2_601c "601c. Did you get multivitamins?"
label variable m2_601d "601d. Did you get food supplements like Super Cereal or Plumpynut?"
label variable m2_601e "601e. Did you get medicine for intestinal worm?"
label variable m2_601f "601f. Did you get medicine for malaria?"
label variable m2_601g "601g. Did you get medicine for HIV?"
label variable m2_601h "601h. Did you get medicine for your emotions, nerves, depression, or mental health?"
label variable m2_601i "601i. Did you get medicine for hypertension/high blood pressure?"
label variable m2_601j "601j. Did you get medicine for diabetes, including injections of insulin?"
label variable m2_601k "601k. Did you get antibiotics for an infection?"
label variable m2_601l "601l. Did you get aspirin?"
label variable m2_601m "601m. Did you get paracetamol, or other pain relief drugs?"
label variable m2_601n "601n. Did you get any other medicine or supplement?"
label variable m2_601n_other "601n-oth. Specify other medicine or supplement you took"
label variable m2_601o "601o. KE only: Iron drip/injection"
label variable m2_602b "602b. In total, how much did you pay for these new medications or supplements (in Ksh.)?"
label variable m2_603 "603. Are you currently taking iron and folic acid pills like IFAS and Pregnacare?"
label variable m2_701 "701. Did you pay any money out of your pocket for these new visits, including for the consultation or other indirect costs like your transport to the facility?"
label variable m2_702a "702a. Did you spend money on registration/consultation?"
label variable m2_702b "702b. Did you spend money on test or investigations (lab tests, ultrasound etc.)?"
label variable m2_702c "702c. Did you spend money on transport (round trip) including that of the person accompanying you?"
label variable m2_702d "702d. Did you spend money on food and accommodation including that of person accompanying you?"
label variable m2_702e "702e. Did you spend money for other services?"
label variable m2_702_meds_ke "702. KE only: Are the costs for medicine (m2_602b) you indicated in section 6 included in the total costs of (m2_704_confirm)?"
label variable m2_702_other_ke "702e. Specify other costs"
label variable m2_703 "703. So, in total you spent (m2_704_confirm), is that correct?"
label variable m2_704_confirm "704. How much money did you spend in total for these new healthcare visits, including registration, tests/investigations, transport, food and accommodation (in Ksh.)?"
label variable m2_705 "705. Which of the following financial sources did your household use to pay for this?"
label variable m2_705_1 "705. Current income of any household members"
label variable m2_705_2 "705. Savings (e.g., bank account)"
label variable m2_705_3 "705. Payment or reimbursement from a health insurance plan"
label variable m2_705_4 "705. Sold items (e.g., furniture, animals, jewellery, furniture)"
label variable m2_705_5 "705. Family members or friends from outside the household"
label variable m2_705_6 "705. Borrowed (from someone other than a friend or family)"
label variable m2_705_96 "705. Other (please specify)"
label variable m2_705_other "705-Other. Other financial sources, specify"
label variable m2_refused_why "KE only: Why are you unwilling to participate in the study?"
label variable m2_complete "Call status"
label variable m2_enum "Enumerator"
label variable m2_endtime "103B. Time of Interview end"
label variable m2_site "Facility name"	

*------------------------------------------------------------------------------*

* reshape data from long to wide

*drop if m2_attempt_outcome == 3 | m2_attempt_outcome == 4 | m2_attempt_outcome == 5

drop if m2_completed_attempts == . // SS: change to "."
drop if respondentid == "21311071736" | respondentid == "21501081229"

sort m2_date
bysort respondentid: gen round2 = _n

	
reshape wide m2_date_time m2_time_start duration m2_date m2_date_confirm m2_interviewer m2_site county m2_enum m2_attempt_number m2_attempt_number_other m2_attempt_outcome m2_resp_lang1 m2_resp_lang2 m2_resp_lang_other m2_attempt_relationship m2_attempt_relationship_other m2_attempt_avail m2_maternal_death_reported m2_date_of_maternal_death_yesno m2_maternal_death_learn m2_maternal_death_learn_other m2_attempt_contact m2_attempt_goodtime m2_consent_recording consent m2_201 m2_202 m2_202_other m2_ga_estimate m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204i m2_204i_other m2_205a m2_205b m2_206 m2_301 m2_302 m2_303a m2_304a m2_304a_other m2_305 m2_306 m2_307_other m2_303b m2_304b m2_304b_other m2_308 m2_309 m2_310_other m2_303c m2_304c m2_304c_other m2_311 m2_312 m2_313_other m2_303d m2_304d m2_304d_other m2_314 m2_315 m2_316_other m2_303e m2_304e m2_304e_other m2_317 m2_318 m2_319_other m2_320_0 m2_320a m2_320b m2_320c m2_320d m2_320e m2_320f m2_320g m2_320h m2_320i m2_320j m2_320k m2_320_12_ke m2_320_96 m2_320_99 m2_320_other m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_501_0 m2_501g_other m2_502 m2_503 m2_503a m2_503b m2_503c m2_503d m2_503e m2_503f m2_503_0 m2_505a m2_505b m2_505c m2_505d m2_505e m2_505f m2_504 m2_504_other m2_505g m2_506 m2_506a m2_506b m2_506c m2_506d m2_506_0 m2_507 m2_507_1_ke m2_507_2_ke m2_507_3_ke m2_507_4_ke m2_507_5_ke m2_507_6_ke m2_507_7_ke m2_507_96_ke m2_507_other_ke m2_508a m2_508b_num m2_508c_time m2_509 m2_509a m2_509b m2_509c m2_509_0 m2_601 m2_601a m2_601o m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n m2_601_0 m2_601n_other m2_602b m2_603 m2_701 m2_704_confirm m2_702_meds_ke m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost m2_702_other_ke m2_705 m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 m2_705_other m2_refused_why m2_complete language language_oth m2_start_time m2_endtime m2_date_of_maternal_death m2_202_delivery_date m2_202_other_date module m2_reschedule_resp m2_completed_attempts m2_ga m2_hiv_status m2_county m2_phq2_ke m2_306_2 m2_306_3 m2_306_4 m2_306_5 m2_306_96 m2_308_1 m2_308_2 m2_308_3 m2_308_4 m2_308_5 m2_308_96 m2_311_1 m2_311_2 m2_311_3 m2_311_4 m2_311_5 m2_311_96 m2_314_1 m2_314_2 m2_314_3 m2_314_4 m2_314_5 m2_314_96 m2_317_1 m2_317_2 m2_317_3 m2_317_4 m2_317_5 m2_317_96 m2_703 m2_306_1, i(respondentid) j(round2)


*------------------------------------------------------------------------------*
* merge dataset with M1

merge 1:1 respondentid using "$ke_data_final/eco_m1_ke.dta"

drop _merge  // SS 3-15: 7 in master (M2) not in using (M1), N=979 matched

*===============================================================================
	
order m1_* m2_*, sequential

* Module 1:
order country module respondentid interviewer_id m1_date m1_start_time study_site facility_name ///
      facility_name2 county* permission care_self enrollage dob language* language_oth* ///
	  zone_live zone_live_other b5anc b6anc_first b7eligible m1_noconsent_why_ke ///
	  mobile_phone flash
order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate ///
	  bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic ///
	  bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)
	  
order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)
order edd_chart_ke edd gest_age_baseline_ke, after(m1_803)
order m1_1218_ke, after(m1_1218c_1)
order m1_1218_other_total_ke, after(m1_1218f_1)
order m1_1218_total_ke, after(m1_1218_other_total_ke)	
	
* Module 2:
order m2_attempt_number* m2_attempt_number_other* m2_attempt_outcome* m2_resp_lang1* ///
	  m2_resp_lang2* m2_resp_lang_other* m2_attempt_relationship* m2_attempt_relationship_other*, after(m1_end_time) 
	  
order m2_attempt_avail* m2_attempt_contact* m2_attempt_goodtime* m2_reschedule_resp* m2_completed_attempts*  m2_consent_recording* m2_consent*, after(m2_attempt_relationship_other6)
	  
order m2_date* m2_start_time* m2_date_time* m2_time_start* m2_date_confirm* m2_interviewer* m2_enum* ///
	  m2_site* m2_county* m2_maternal_death_reported* m2_date_of_maternal_death* ///
	  m2_ga* m2_ga_estimate* gest_age_baseline* m2_hiv_status* m2_maternal_death_learn* m2_maternal_death_learn_other*, after(m2_consent_recording6)

order m2_date_of_maternal_death_yesno*, before(m2_date_of_maternal_death6)	  
order m2_refused_why* m2_complete* m2_endtime*, after(m2_705_other6)
order m2_phq2_ke*, after(m2_205b6)	

*------------------------------------------------------------------------------*
	
	* STEP SIX: ORDER/SAVE DATA TO RECODED FOLDER

	save "$ke_data_final/eco_m1m2_ke.dta", replace
	clear all
*
*===============================================================================
* MODULE 3:

* Import data
clear all 
use "$ke_data/Module 3/KEMRI_Module_3.dta"

*drop ineligible pids:
drop if consent !=1

* module var: 
gen module = 3 if consent ==1

drop today_date availability consent_audio full_name best_phone_reconfirm best_phone_resp confirm_phone  baby_repeat_count baby_index_1 baby_index_2 baby_list baby_alive_list baby_died_list baby_bornalive_list gest_age_baseline date_survey_baseline gest_age_today gest_age_delivery gest_age_ad_less28 check_continue baby_list_checks baby_repeat_checks_count baby_index_checks_1 baby_name_checks_1 baby_label_checks_1 baby_index_checks_2 baby_name_checks_2 baby_label_checks_2 baby_list_issues baby_repeat_issues_count baby_index_issues_1 baby_name_issues_1 baby_label_issues_1 baby_index_issues_2 baby_name_issues_2 baby_label_issues_2 baby_list_meds baby_index_meds_1 baby_name_meds_1 baby_label_meds_1 baby_index_meds_2 baby_name_meds_2 baby_label_meds_2 date_mod4 call_status end_comment enum_name_mod1 formdef_version key isvalidated gest_age_ad gest_age_ad_less20 language_label

drop text_audit section7_audio sd_sound_level resp_language resp_language_no resp_language_no_oth resp_other resp_other_oth resp_other_name resp_available resp_available_when reschedule_date_resp resp_worker unavailable_reschedule reschedule_full_noavail still_pregnant registered_phone refused_why survey1no_maternal_death1consent submissiondate reschedule_resp

drop q_1004_rand_order_count q_1004_rand_1 q_1004_rand_2 q_1004_rand_3 q_1004_rand_4 q_1004_rand_5 q_1004_rand_6 q_1004_rand_7 q_1004_order_count

drop v258 v619 v620 v621 v622 v238 v599 v600 v601 v602 v584 v585 v586 v587 v583 v581 v582 v520 ///
v521 v522 v523 v519 v524 // SS: confirm what these vars are?

drop mean_sound_level min_sound_level max_sound_level pct_sound_between0_60 pct_sound_above80 pct_conversation phone1 phone2 phone3 phone4 phone_combi phone_noavail name_confirm name_full outcome_text name_baby1 name_baby2 name_baby3 name_baby4 name_baby_alive1 name_baby_alive2 name_baby_alive3 name_baby_alive4 name_baby_bornalive1 name_baby_bornalive2 name_baby_bornalive3 name_baby_bornalive4 new_consultations_count new_consultations_index_1 new_consultations_index_2 new_consultations_index_3 other_facility_before_repeat_cou other_facility_before_repeat_ind mobile_money_name mobile_prov phone_used phone_used_oth 

drop q_902_o_1 q_901r_oth q_804_o q_801a_calc q_801b_calc q_107_trim q_1104_o q_314_o_1 q_1102f_oth q_605c_oth q_519_oth q_101 q_103 q_104_calc q_105 q_106 q_314_1 q_314_2 q_603_note q_704_note q_801_note q_1102b_cost q_1102c_cost q_1102d_cost q_1102e_cost q_1102f_cost q_1102a_cost

*------------------------------------------------------------------------------*	
	* STEP ONE: RENAME VARAIBLES

* Variables from M2 in this dataset:
* q_110 = m2_date_of_maternal_death
rename q_110 m2_date_of_maternal_death
* q_107 = m2_ga
rename q_107 m2_ga
* q_103 = m2_time_start (dropped)
* q_101 = m2_interviewer (dropped)
rename q_104 respondentid 
* q_105 = respondent first name (dropped)
* q_106 = respondent last name (dropped)
* q_108 = m2_hiv_status
encode q_108, gen(m2_hiv_status)
drop q_108
* q_109 = m2_maternal_death_reported
rename q_109 m2_maternal_death_reported
* q_111 = m2_maternal_death_learn
rename q_111 m2_maternal_death_learn
* q_111_oth = m2_maternal_death_learn_other
rename q_111_oth m2_maternal_death_learn_other
* q_202 = m2_202
rename q_202 m2_202
* q_601 = m2_601
rename q_601 m2_601	
	
rename call_response m3_attempt_outcome	
rename enum_name m3_enum_name
rename county m3_county
rename intro_yn m3_consent_recording
	
rename (consent q_302a q_302b gest_age_delivery_final) ///
       (m3_start_p1 m3_birth_or_ended m3_birth_or_ended_provided m3_ga_final)
	   
rename reschedule_noavail m3_datetime_rescheduled
	    
rename confirm_gestational m3_ga1_ke 
	   
encode weeks_from_outcome,gen(m3_weeks_from_outcome_ke)   
drop weeks_from_outcome
encode after2weeks_call,gen(m3_after2weeks_call_ke)
drop after2weeks_call
	   
rename q_308_1 m3_baby1_weight
rename q_308_2 m3_baby2_weight 
rename (q_307_2 q_309_1 q_309_2) (m3_baby2_size m3_baby1_health m3_baby2_health)
 
replace q_310a_1_1 = "No" if q_310a_1_1 == "0"
replace q_310a_1_1 = "Yes" if q_310a_1_1 == "1"

encode q_310a_1_1,gen(m3_baby1_feed_a)
drop q_310a_1_1
encode q_310a_2_1,gen(m3_baby1_feed_b)
drop q_310a_2_1
encode q_310a_3_1,gen(m3_baby1_feed_c)
drop q_310a_3_1
encode q_310a_4_1,gen(m3_baby1_feed_d)
drop q_310a_4_1
encode q_310a_5_1,gen(m3_baby1_feed_e)
drop q_310a_5_1
encode q_310a_6_1,gen(m3_baby1_feed_f)
drop q_310a_6_1
encode q_310a_7_1,gen(m3_baby1_feed_g)
drop q_310a_7_1
encode q_310a_8_1,gen(m3_baby1_feed_h)
drop q_310a_8_1
encode q_310a__99_1,gen(m3_baby1_feed_99)
drop q_310a__99_1

encode q_310a_1_2,gen(m3_baby2_feed_a)
drop q_310a_1_2
encode q_310a_2_2,gen(m3_baby2_feed_b)
drop q_310a_2_2
encode q_310a_3_2,gen(m3_baby2_feed_c)
drop q_310a_3_2
encode q_310a_4_2,gen(m3_baby2_feed_d)
drop q_310a_4_2
encode q_310a_5_2,gen(m3_baby2_feed_e)
drop q_310a_5_2
encode q_310a_6_2,gen(m3_baby2_feed_f)
drop q_310a_6_2
encode q_310a_7_2,gen(m3_baby2_feed_g)
drop q_310a_7_2
encode q_310a_8_2,gen(m3_baby2_feed_h)
drop q_310a_8_2
encode q_310a__99_2,gen(m3_baby2_feed_99)
drop q_310a__99_2

rename q_310a_1 m3_baby1_feeding
rename q_310a_2 m3_baby2_feeding

rename (q_310b_1 q_310b_2)(m3_breastfeeding m3_breastfeeding_2)

rename (q_312_1 q_312a_1 q_312_2 q_312a_2 q_313a_1 q_313b_1 q_313b_unit_1 q_313a_2 q_313b_2 ///
		q_313b_unit_2 q_314_oth_1 q_314_oth_2 q_1201 ///
		q_1202 q_1203 q_1204) (m3_baby1_born_alive1 m3_baby1_born_alive2 m3_baby2_born_alive1 ///
		m3_baby2_born_alive2 m3_313a_baby1 m3_313c_baby1 m3_313d_baby1 m3_313a_baby2 ///
		m3_313c_baby2 m3_313d_baby2 m3_death_cause_baby1_other /// 
		m3_death_cause_baby2_other m3_1201 m3_1202 m3_1203 m3_1204)
		
		
encode baby_death1,gen(m3_death_cause_baby1)	
drop baby_death1
encode baby_death2, gen(m3_death_cause_baby2)	
drop baby_death2
		
rename (baby_death3 baby_death4) (m3_death_cause_baby3 m3_death_cause_baby4)

rename miscarriage m3_miscarriage		
rename abortion m3_abortion
rename alive_babies m3_num_alive_babies
rename dead_babies m3_num_dead_babies
		
rename (q_401 q_402 q_403_1 q_404_1 q_405_oth_1)(m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason_other)	
rename (q_403_2 q_404_2 q_405_oth_2)(m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason_other)
rename (q_403_3 q_404_3 q_405_oth_3) ///
	   (m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason_other)	

encode q_405_1,gen(m3_consultation1_reason)
drop q_405_1
encode q_405_2,gen(m3_consultation2_reason)
drop q_405_2
encode q_405_3,gen(m3_consultation3_reason)
drop q_405_3
encode q_405_1_1,gen(m3_consultation1_reason_a)
drop q_405_1_1
encode q_405_2_1,gen(m3_consultation1_reason_b)
drop q_405_2_1
encode q_405_3_1,gen(m3_consultation1_reason_c)
drop q_405_3_1
encode q_405_4_1,gen(m3_consultation1_reason_d)
drop q_405_4_1
encode q_405_5_1,gen(m3_consultation1_reason_e)
drop q_405_5_1
encode q_405__96_1,gen(m3_consultation1_reason_96)
drop q_405__96_1

encode q_405_1_2,gen(m3_consultation2_reason_a)
drop q_405_1_2
encode q_405_2_2,gen(m3_consultation2_reason_b)
drop q_405_2_2
encode q_405_3_2,gen(m3_consultation2_reason_c)
drop q_405_3_2
encode q_405_4_2,gen(m3_consultation2_reason_d)
drop q_405_4_2
encode q_405_5_2,gen(m3_consultation2_reason_e)
drop q_405_5_2
encode q_405__96_2,gen(m3_consultation2_reason_96)
drop q_405__96_2

encode q_405_1_3,gen(m3_consultation3_reason_a)
drop q_405_1_3
encode q_405_2_3,gen(m3_consultation3_reason_b)
drop q_405_2_3
encode q_405_3_3,gen(m3_consultation3_reason_c)
drop q_405_3_3
encode q_405_4_3,gen(m3_consultation3_reason_d)
drop q_405_4_3
encode q_405_5_3,gen(m3_consultation3_reason_e)
drop q_405_5_3
encode q_405__96_3,gen(m3_consultation3_reason_96)
drop q_405__96_3

rename (q_412a_1 q_412b_1 q_412c_1 q_412d_1 q_412e_1 q_412f_1 q_412g_1 q_412g_oth_1 q_412i_1) ///
       (m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke ///
	   m3_412g_1_other m3_412i_1_ke )	

rename (q_412a_2 q_412a_3 q_412b_2 q_412b_3 q_412c_2 q_412c_3 q_412d_2 q_412d_3 q_412e_2 ///
		q_412e_3 q_412f_2 q_412f_3 q_412g_2 q_412g_3 q_412i_2 q_412i_3)(m3_412a_2_ke m3_412a_3_ke ///
		m3_412b_2_ke m3_412b_3_ke m3_412c_2_ke m3_412c_3_ke m3_412d_2_ke m3_412d_3_ke m3_412e_2_ke ///
		m3_412e_3_ke m3_412f_2_ke m3_412f_3_ke m3_412g_2_ke m3_412g_3_ke m3_412i_2_ke m3_412i_3_ke)
		
rename (q_412g_oth_2 q_412g_oth_3) (m3_412g_2_other m3_412g_3_other)		
	   
rename (q_504_n q_504_c q_504_r q_503_final q_506_pre q_506_pre_oth q_508 ///
 		q_508_oth q_513a q_513b_n q_513b_c q_513_r q_513_calc q_514 q_515 q_516 ///
		q_517 q_518_oth_del q_518_oth q_519 q_519_o q_520 q_521 q_521_unit) ///
		(m3_504a m3_504b m3_504c m3_503_final m3_506_pre m3_506_pre_oth ///
		m3_508 m3_509_other m3_513a m3_513_outside_zone_other m3_513b2 m3_513b3 ///
		m3_513_final m3_514 m3_515 m3_516 m3_517 m3_518_other_complications ///
		m3_518_other m3_519 m3_519_other m3_520 m3_521_ke m3_521_ke_unit)
		
rename (q_510 q_511 q_512_1 q_512_2) (m3_510 m3_511 m3_512_1_ke m3_512_2_ke)
		
rename (q_518 q_518_0 q_518_1 q_518_2 q_518_3 q_518_4 q_518_5 q_518_6 q_518_7 q_518_8 ///
		q_518_9 q_518_10 q_518__96 q_518__97 q_518__98 q_518__99) (m3_518 m3_518a_ke m3_518b_ke ///
		m3_518c_ke m3_518d_ke m3_518e_ke m3_518f_ke m3_518g_ke m3_518h_ke m3_518i_ke ///
		m3_518j_ke m3_518k_ke m3_518_96_ke m3_518_97_ke m3_518_98_ke m3_518_99_ke)
		
		
/* SS: q_518 answers are stored as 0/1 in q_518_0 - q_518_99
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
*/		
		
		
		
rename (q_601a q_601b q_601c q_602a q_602b q_603a q_603b q_603c q_604a q_604b q_605a q_605b q_605c q_605c_o q_606 q_607 q_608 q_609 q_610a q_610b ///
        q_611 q_612 q_612_unit q_613 q_614 q_614_unit q_615_1 q_615_2 q_616_1 q_616_unit_1 q_616_2 q_616_unit_2 q_617_1 q_617_2 q_618a_1 q_618b_1 ///
		q_618c_1 q_618a_2 q_618b_2 q_618c_2) (m3_601_hiv m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b ///
		m3_605c m3_605c_other m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_612_ke m3_612_ke_unit m3_613 m3_614_ke m3_614_ke_unit m3_615a m3_615b ///
		m3_616c_1 m3_616c_1_unit m3_616c_2 m3_616c_2_unit m3_617a m3_617b m3_618a_1 m3_618b_1 m3_618c_1 m3_618a_2 m3_618b_2 m3_618c_2)
rename (q_619a q_619b q_619c q_619d q_619e q_619f q_619g q_620_1 q_620_2 q_621b q_621c q_621c_unit q_622a q_622b q_622c)(m3_619a m3_619b m3_619c ///
        m3_619d m3_619e m3_619g m3_619h m3_620_1 m3_620_2 m3_621b m3_621c_ke m3_621c_ke_unit m3_622a m3_622b m3_622c)

/* SS: 621a is a multiple checkbox field that has the answers in "yes" and "no" in 621a_1 - 621a_99		
       ** q_621a is a string variables: use replace if and then rename (line 219 to 226)		
replace q_621a = "A relative or a friend" if q_621a == "1"
replace q_621a = "A traditional birth attendant" if q_621a == "2"
replace q_621a = "A community health worker" if q_621a == "3"
replace q_621a = "A nurse" if q_621a == "4"
replace q_621a = "A midwife" if q_621a == "5"
replace q_621a = "Don´t know [DO NOT READ]" if q_621a == "-98"
replace q_621a = "NR/RF" if q_621a == "-99"
*/

rename (q_621a q_621a_1 q_621a_2 q_621a_3 q_621a_4 q_621a_5 q_621a_6 q_621a__98 q_621a__99) ////
	   (m3_621a m3_621a_1_ke m3_621a_2_ke m3_621a_3_ke m3_621a_4_ke m3_621a_5_ke m3_621a_6_ke ///
	   m3_621a_98_ke m3_621a_99_ke)

rename (q_311a_1 q_311a_2 q_311b_1 q_311b_2 q_311c_1 q_311c_2 q_311d_1 q_311d_2 q_311e_1 q_311e_2 q_311f_1 q_311f_2 q_311g_1 q_311g_2)(m3_baby1_sleep ///
        m3_baby2_sleep m3_baby1_feed m3_baby2_feed m3_baby1_breath m3_baby2_breath m3_baby1_stool m3_baby2_stool m3_baby1_mood m3_baby2_mood ///
		m3_baby1_skin m3_baby2_skin m3_baby1_interactivity m3_baby2_interactivity)
rename (q_702 q_703 q_704a q_704b q_704c q_704d q_704e q_704f q_704g  ///
		q_706 q_707 q_707_unit q_708_1 q_708_2)(m3_702 m3_703 m3_704a ///
        m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_706 ///
		m3_707_ke m3_707_ke_unit m3_baby1_issues m3_baby2_issues)   

encode q_708_1_1,gen(m3_baby1_issues_a)
drop q_708_1_1
encode q_708_2_1,gen(m3_baby1_issues_b)
drop q_708_2_1
encode q_708_3_1,gen(m3_baby1_issues_c)
drop q_708_3_1
encode q_708_4_1,gen(m3_baby1_issues_d)
drop q_708_4_1
encode q_708_5_1,gen(m3_baby1_issues_e)
drop q_708_5_1
encode q_708_6_1,gen(m3_baby1_issues_f)
drop q_708_6_1
encode q_708__98_1,gen(m3_baby1_issues_98)
drop q_708__98_1
encode q_708__99_1,gen(m3_baby1_issues_99)
drop q_708__99_1
encode q_708_1_2,gen(m3_baby2_issues_a)
drop q_708_1_2
encode q_708_2_2,gen(m3_baby2_issues_b)
drop q_708_2_2
encode q_708_3_2,gen(m3_baby2_issues_c)
drop q_708_3_2
encode q_708_4_2,gen(m3_baby2_issues_d)
drop q_708_4_2
encode q_708_5_2,gen(m3_baby2_issues_e)
drop q_708_5_2
encode q_708_6_2,gen(m3_baby2_issues_f)
drop q_708_6_2
encode q_708__98_2,gen(m3_baby2_issues_98)
drop q_708__98_2
encode q_708__99_2,gen(m3_baby2_issues_99)
drop q_708__99_2

rename (q_709_1 q_709_o_1 q_709_2 q_709_o_2 q_710_1 q_710_2 q_711_1 q_711_unit_1 q_711_2 q_711_unit_2) (m3_708_oth_1 m3_708a m3_708_oth_2 m3_708b ///
        m3_710a m3_710b m3_711c_1 m3_711c_1_unit m3_711c_2 m3_711c_2_unit)
		
rename (q_801a q_801b q_802a q_802b q_802c q_803a q_803b q_803c q_803d q_803e q_803f q_803g q_803h q_804 q_804_oth q_805 q_806 q_807 q_808a q_808b ///
        q_808b_oth q_809)(m3_801a m3_801b m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803j m3_803j_other ///
		m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other m3_809)
		
encode phq2_score,gen(m3_phq2_score)
drop phq2_score

rename (q_901a q_901b q_901c q_901d q_901de q_901f q_901g q_901h q_901i q_901j q_901k q_901l q_901m q_901n q_901o q_901p q_901q q_901r q_901_o) ///
       (m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r ///
	    m3_901r_other)
		
rename (q_901_cost q_902_cost_1 q_902_cost_2) (m3_901_cost m3_902_1_cost m3_902_2_cost)

rename (q_902a_1 q_902a_2 q_902b_1 q_902b_2 q_902c_1 q_902c_2 q_902d_1 q_902d_2 q_902e_1 q_902e_2 q_902f_1 q_902f_2 q_902g_1 q_902g_2 q_902h_1 q_902h_2 ///
        q_902i_1 q_902i_2 q_902j_1 q_902j_oth_1 q_902j_2 q_902j_oth_2)(m3_902a_baby1 m3_902a_baby2 m3_902b_baby1 m3_902b_baby2 m3_902c_baby1 ///
		m3_902c_baby2 m3_902d_baby1 m3_902d_baby2 m3_902e_baby1 m3_902e_baby2 m3_902f_baby1 m3_902f_baby2 m3_902g_baby1 m3_902g_baby2 m3_902h_baby1 ///
		m3_902h_baby2 m3_902i_baby1 m3_902i_baby2 m3_902j_baby1 m3_902j_baby1_other m3_902j_baby2 m3_902j_baby2_other)		
		
rename baby_repeat_meds_count m3_baby_meds_count		
		
rename (q_1001 q_1002 q_1003 q_1005a q_1005b q_1005c q_1005d q_1005e q_1005f q_1005g q_1005h q_1006a q_1006b ///
		q_1006c q_1007a q_1007b q_1007c q_1101 q_1102a q_1102b q_1102c q_1102d q_1102e q_1102f q_1102f_o ///
		q_1103 q_1104 q_1104_oth q_1105)(m3_1001 m3_1002 m3_1003 m3_1005a m3_1005b m3_1005c ///
		m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b ///
		m3_1007c m3_1101 m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt ///
		m3_1102f_oth m3_1103 m3_1105 m3_1105_other m3_1106)
		
rename (q_1104_1 q_1104_2 q_1104_3 q_1104_4 q_1104_5 q_1104_6 q_1104_7 q_1104__96) ///
	   (m3_1105a_ke m3_1105b_ke m3_1105c_ke m3_1105d_ke m3_1105e_ke m3_1105f_ke ///
	   m3_1105g_ke m3_1105_96_ke)		
		
encode q_1102_total_spent,gen(m3_1102_total)
drop q_1102_total_spent	

	   ** Create q_1004b to collapse q_1004b_1 q_1004b_2 q_1004b_3 q_1004b_4 q_1004b_5 q_1004b_6 q_1004b_7
gen q_1004b = q_1004b_1 if q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_2 if q_1004b_1==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_3 if q_1004b_1==. & q_1004b_2==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_4 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_5==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_5 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_6==. & q_1004b_7==.
replace q_1004b = q_1004b_6 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_7==.
replace q_1004b = q_1004b_7 if q_1004b_1==. & q_1004b_2==. & q_1004b_3==. & q_1004b_4==. & q_1004b_5==. & q_1004b_6==.
rename (q_1004b)(m3_1004b)

drop q_1004b_1 q_1004b_2 q_1004b_3 q_1004b_4 q_1004b_5 q_1004b_6 q_1004b_7

	   ** Create q_1004c to collapse q_1004c_1 q_1004c_2 q_1004c_3 q_1004c_4 q_1004c_5 q_1004c_6 q_1004c_7
gen q_1004c = q_1004c_1 if q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_2 if q_1004c_1==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_3 if q_1004c_1==. & q_1004c_2==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_4 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_5==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_5 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_6==. & q_1004c_7==.
replace q_1004c = q_1004c_6 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_7==.
replace q_1004c = q_1004c_7 if q_1004c_1==. & q_1004c_2==. & q_1004c_3==. & q_1004c_4==. & q_1004c_5==. & q_1004c_6==.
rename (q_1004c)(m3_1004c)

drop q_1004c_1 q_1004c_2 q_1004c_3 q_1004c_4 q_1004c_5 q_1004c_6 q_1004c_7

	   ** Create q_1004d to collapse q_1004d_1 q_1004d_2 q_1004d_3 q_1004d_4 q_1004d_5 q_1004d_6 q_1004d_7
gen q_1004d = q_1004d_1 if q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_2 if q_1004d_1==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_3 if q_1004d_1==. & q_1004d_2==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_4 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_5==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_5 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_6==. & q_1004d_7==.
replace q_1004d = q_1004d_6 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_7==.
replace q_1004d = q_1004d_7 if q_1004d_1==. & q_1004d_2==. & q_1004d_3==. & q_1004d_4==. & q_1004d_5==. & q_1004d_6==.
rename (q_1004d)(m3_1004d)

drop q_1004d_1 q_1004d_2 q_1004d_3 q_1004d_4 q_1004d_5 q_1004d_6 q_1004d_7

	   ** Create q_1004e to collapse q_1004e_1 q_1004e_2 q_1004e_3 q_1004e_4 q_1004e_5 q_1004e_6 q_1004e_7
gen q_1004e = q_1004e_1 if q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_2 if q_1004e_1==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_3 if q_1004e_1==. & q_1004e_2==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_4 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_5==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_5 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_6==. & q_1004e_7==.
replace q_1004e = q_1004e_6 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_7==.
replace q_1004e = q_1004e_7 if q_1004e_1==. & q_1004e_2==. & q_1004e_3==. & q_1004e_4==. & q_1004e_5==. & q_1004e_6==.
rename (q_1004e)(m3_1004e)

drop q_1004e_1 q_1004e_2 q_1004e_3 q_1004e_4 q_1004e_5 q_1004e_6 q_1004e_7

	   ** Create q_1004f to collapse q_1004f_1 q_1004f_2 q_1004f_3 q_1004f_4 q_1004f_5 q_1004f_6 q_1004f_7
gen q_1004f = q_1004f_1 if q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_2 if q_1004f_1==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_3 if q_1004f_1==. & q_1004f_2==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_4 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_5==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_5 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_6==. & q_1004f_7==.
replace q_1004f = q_1004f_6 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_7==.
replace q_1004f = q_1004f_7 if q_1004f_1==. & q_1004f_2==. & q_1004f_3==. & q_1004f_4==. & q_1004f_5==. & q_1004f_6==.
rename (q_1004f)(m3_1004f)

drop q_1004f_1 q_1004f_2 q_1004f_3 q_1004f_4 q_1004f_5 q_1004f_6 q_1004f_7

	   ** Create q_1004g to collapse q_1004g_1 q_1004g_2 q_1004g_3 q_1004g_4 q_1004g_5 q_1004g_6 q_1004g_7
gen q_1004g = q_1004g_1 if q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_2 if q_1004g_1==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_3 if q_1004g_1==. & q_1004g_2==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_4 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_5==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_5 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_6==. & q_1004g_7==.
replace q_1004g = q_1004g_6 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_7==.
replace q_1004g = q_1004g_7 if q_1004g_1==. & q_1004g_2==. & q_1004g_3==. & q_1004g_4==. & q_1004g_5==. & q_1004g_6==.
rename (q_1004g)(m3_1004g)

drop q_1004g_1 q_1004g_2 q_1004g_3 q_1004g_4 q_1004g_5 q_1004g_6 q_1004g_7

	   ** Create q_1004h to collapse q_1004h_1 q_1004h_2 q_1004h_3 q_1004h_4 q_1004h_5 q_1004h_6 q_1004h_7 
gen q_1004h = q_1004h_1 if q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_2 if q_1004h_1==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_3 if q_1004h_1==. & q_1004h_2==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_4 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_5==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_5 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_6==. & q_1004h_7==.
replace q_1004h = q_1004h_6 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_7==.
replace q_1004h = q_1004h_7 if q_1004h_1==. & q_1004h_2==. & q_1004h_3==. & q_1004h_4==. & q_1004h_5==. & q_1004h_6==.
rename (q_1004a q_1004h)(m3_1004a m3_1004h)

drop q_1004h_1 q_1004h_2 q_1004h_3 q_1004h_4 q_1004h_5 q_1004h_6 q_1004h_7
		
rename facility_name m3_site
rename date_confirm m3_date_confirm
rename q_102 m3_date 
rename starttime m3_start_time
rename time_start_full m3_date_time
rename q_302 m3_birth_or_ended_date
rename gestational_update m3_ga2_ke
rename q_301 m3_303a
rename (q_303_1 q_303_2) (m3_303b m3_303c)
rename (q_304_1 q_304_2) (m3_baby1_name m3_baby2_name)
rename q_305_1 m3_baby1_gender
rename q_306_1 m3_baby1_age_weeks
rename q_307_1 m3_baby1_size
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
rename attempts m3_attempt_number
rename attempts_oth m3_attempt_number_other
rename language m3_language
rename language_oth m3_language_other
	
*===============================================================================

	* STEP TWO: ADD VALUE LABELS (NA in KENYA, already labeled)
/*		
label define m3_death_cause_baby2 0 "Not told anything" 1 "The baby was premature" 2 "An infection" 3 "A congenital abnormality" 4 "A birth injury or asphyxia" 5 "Difficulties breathing" 6 "Unexplained causes" 7 "You decided to have an abortion" -96 "Other (specify)",modify
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

*/

recode m3_phq2_score (1 = 0) (2 = 1) (3 = 2) (4 = 3) (5 = 4) (6 = 5)
label define m3_phq2_score 1 "1" 2 "2" 3 "3" 4 "4" 5 "5", modify
	
	
* Formatting Dates (SS: do this for all dates in all modules)	 
	*Date and time of M3
	gen _m3_date_time_ = date(m3_date_time,"YMDhms")
	drop m3_date_time
	rename _m3_date_time_ m3_date_time
	format m3_date_time %td  	
	
	*gen _m3_date_ = date(m3_date,"YMD")
	*drop m3_date
	*rename _m3_date_ m3_date
	*format m3_date %td  
	
	gen _m3_birth_or_ended_date_ = date(m3_birth_or_ended_date,"YMD")
	drop m3_birth_or_ended_date
	rename _m3_birth_or_ended_date_ m3_birth_or_ended_date
	format m3_birth_or_ended_date %td  	 


*===============================================================================	
	
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 

	   * Notes: m3_412g_2_other is the only "g other" that is string
recode m3_303a m3_303b m3_baby1_gender m3_baby1_health m3_breastfeeding m3_baby1_born_alive1 ///
	   m3_baby1_born_alive2 m3_303c m3_baby2_gender m3_baby2_health m3_breastfeeding_2 ///
	   m3_baby2_born_alive1 m3_baby2_born_alive2 m3_401 m3_consultation_1 m3_consultation_referral_1 ///
	   m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke ///
	   m3_412g_1_other m3_412g_3_other m3_412i_1_ke ///
	   m3_consultation_2 m3_consultation_referral_2 m3_412a_2_ke m3_412b_2_ke m3_412c_2_ke m3_412d_2_ke m3_412e_2_ke ///
	   m3_412f_2_ke m3_412g_2_ke m3_412i_2_ke m3_consultation_3 m3_consultation_referral_3 m3_412a_3_ke ///
	   m3_412b_3_ke m3_412c_3_ke m3_412d_3_ke ///
	   m3_412e_3_ke m3_412f_3_ke m3_412i_3_ke m3_501 m3_503 m3_502 m3_509 m3_510 m3_512_1_ke m3_512_2_ke ///
	   m3_513a m3_516 m3_517 m3_519 m3_601_hiv m3_601b m3_601c m3_602a m3_603a m3_603b m3_603c m3_604a ///
	   m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a ///
	   m3_617a m3_618a_1 m3_618b_1 m3_618c_1 m3_620_1 m3_615b m3_617b m3_618a_2 m3_618b_2 m3_618c_2 ///
	   m3_620_2 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g m3_619h m3_621b m3_622a m3_622c ///
	   m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 ///
	   m3_706 m3_708_oth_1 m3_710a m3_710b m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e ///
	   m3_803f m3_803g m3_803h m3_803j m3_805 m3_808a m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e ///
	   m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q ///
	   m3_901r m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 ///
	   m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 m3_902a_baby2 m3_902b_baby2 m3_902c_baby2 ///
	   m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 m3_902i_baby2 m3_1001 ///
	   m3_1002 m3_1003 m3_1004a m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h ///
	   m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1106 m3_1201 m3_1202 m3_1203 ///
	   m3_1204 m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt (-99 = .r)

recode m3_303a m3_baby1_gender m3_baby1_weight m3_baby2_weight m3_baby1_born_alive1 ///
	   m3_baby1_born_alive2 m3_baby2_gender m3_baby2_weight m3_baby2_born_alive1 ///
	   m3_baby2_born_alive2 m3_401 m3_consultation_1 m3_consultation_referral_1 ///
	   m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke ///
	   m3_412g_1_other m3_412g_3_other m3_412i_1_ke ///
	   m3_consultation_2 m3_consultation_referral_2 m3_412a_2_ke m3_412b_2_ke m3_412c_2_ke m3_412d_2_ke ///
	   m3_412e_2_ke m3_412f_2_ke m3_412g_2_ke m3_412i_2_ke m3_consultation_3 m3_consultation_referral_3 ///
	   m3_412a_3_ke m3_412b_3_ke m3_412c_3_ke m3_412d_3_ke m3_412e_3_ke m3_412f_3_ke m3_412i_3_ke m3_501 ///
	   m3_503 m3_502 m3_510 m3_512_1_ke m3_512_2_ke m3_513a m3_517 m3_519 m3_601_hiv m3_601b m3_601c ///
	   m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 ///
	   m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a m3_617a m3_618a_1 m3_618b_1 m3_618c_1 ///
	   m3_620_1 m3_615b m3_617b m3_618a_2 m3_618b_2 m3_618c_2 m3_620_2 m3_619a m3_619b ///
	   m3_619c m3_619d m3_619e m3_619g m3_619h m3_621b m3_622a m3_622c m3_701 m3_703 ///
	   m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_708_oth_1 ///
	   m3_710a m3_710b m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f ///
	   m3_803g m3_803h m3_803j m3_805 m3_808a m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e ///
	   m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p ///
	   m3_901q m3_901r m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 ///
	   m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 m3_902a_baby2 m3_902b_baby2 ///
	   m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 m3_902i_baby2 m3_1002 ///
	   m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a ///
	   m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1106 m3_1201 m3_1203 m3_614_ke ///
	   m3_616c_1 m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt (-98 = .d)	 

* SS: confirm m3_ga2_ke 999 = .d	   
recode m3_ga2_ke (999 = .d)	   

recode m3_901_cost (-999 = .d) // SS: confirm		

*------------------------------------------------------------------------------*


recode m3_start_p1 (. = .a) if module !=3
	
recode m3_date m3_date_confirm m3_start_time m3_date_time (. = .a) if m3_start_p1 !=1 | module !=3

recode m3_birth_or_ended m3_birth_or_ended_provided m3_birth_or_ended_date (. = .a) if m2_202 !=2 |  m2_202 !=3 | module !=3

recode m3_ga1_ke  (. = .a) if module !=3 | m2_202 !=2 |  m2_202 !=3 

recode m3_ga2_ke (. = .a) if m3_ga1_ke !=0 | m2_202 !=2 |  m2_202 !=3 

recode m3_weeks_from_outcome_ke m3_after2weeks_call_ke m3_ga_final (. = .a) if m2_202 !=2 |  m2_202 !=3 | module !=3

recode m3_303a (. = .a) if module !=3 | m2_202 !=2 |  m2_202 !=3 

recode m3_303b (. = .a) if m3_303a !=1 // SS: missing date on N=17 women?
recode m3_303c (. = .a) if m3_303a !=2 

replace m3_baby1_name = ".a" if m3_303b !=1
replace m3_baby2_name = ".a" if m3_303c !=1

recode m3_baby1_gender m3_baby1_weight m3_baby1_size m3_baby1_age_weeks m3_baby1_health (. = .a) if m3_303b !=1 // SS: fix data labels
recode m3_baby2_gender m3_baby2_weight m3_baby2_size m3_baby2_age_weeks m3_baby1_health (. = .a) if m3_303c !=1

recode m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_h m3_baby1_feed_99 (. = .a) if m3_303b !=1

recode m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e ///
	   m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_99 (. = .a) if m3_303c !=1

recode m3_breastfeeding (. = .a) if m3_303b !=1 
recode m3_breastfeeding_2 (. = .a) if m3_303c !=1

recode m3_baby1_born_alive1 (. = .a) if m3_303b !=1
recode m3_baby1_born_alive2  (. = .a) if m3_303b !=1

recode m3_baby2_born_alive1 (. = .a) if m3_303c !=2
recode m3_baby2_born_alive2 (. = .a) if m3_303c !=2

recode m3_313a_baby1 m3_313c_baby1 m3_313d_baby1 m3_death_cause_baby1 (. = .a) if m3_303b !=0 | m3_baby1_born_alive1 !=0 | m3_baby1_born_alive2 ==0

replace m3_death_cause_baby1_other = ".a" if m3_death_cause_baby1 !=1

recode m3_313a_baby2 m3_313c_baby2 m3_313d_baby2 m3_death_cause_baby2 (. = .a) if m3_303c !=0 | m3_baby2_born_alive1 !=0 | m3_baby2_born_alive2 ==0

*replace m3_death_cause_baby2_other = ".a" if m3_death_cause_baby2 !=1 // numeric bc of 0 obs

recode m3_1201 (. = .a) if m3_abortion != "1"
recode m3_1202 (. = .a) if m3_1201 !=1
recode m3_1203 (. = .a) if m3_abortion != "1"
recode m3_1204 (. = .a) if m3_1203 !=1

recode m3_401 (. = .a) if (m3_303b !=1 & m3_303c !=1) |  ///
						  (m3_baby1_born_alive1 !=1 & m3_baby1_born_alive2!=1) | ///
						  (m3_baby2_born_alive1 !=1 & m3_baby2_born_alive2 !=1)

recode m3_402 (. = .a) if m3_401 !=1 

recode m3_consultation_1 (. = .a) if m3_402 == 0 | m3_402 == . | m3_402 == .a		  
recode m3_consultation_referral_1 (. = .a) if m3_consultation_1 !=0						  

recode m3_consultation1_reason m3_consultation1_reason_a m3_consultation1_reason_b ///
		m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e ///
		m3_consultation1_reason_96 (. = .a) if m3_consultation_referral_1 !=0
	   
replace m3_consultation1_reason_other = ".a" if m3_consultation1_reason_96 !=1

recode m3_consultation_2 (. = .a) if m3_402 !=2 & m3_402 !=3 & m3_402 !=4 & m3_402 !=5
recode m3_consultation_referral_2 (. = .a) if m3_consultation_2 !=0
	   
recode m3_consultation2_reason m3_consultation2_reason_a m3_consultation2_reason_b ///
	   m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e ///
	   m3_consultation2_reason_96 (. = .a) if m3_consultation_referral_2 !=0
	   
replace m3_consultation2_reason_other = ".a" if m3_consultation2_reason_96 !=1	   
	   
recode m3_consultation_3 (. = .a) if m3_402 !=3 & m3_402 !=4 & m3_402 !=5
recode m3_consultation_referral_3 (. = .a) if m3_consultation_3 !=0

  
recode m3_consultation3_reason m3_consultation3_reason_a m3_consultation3_reason_b ///
	   m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e ///
	   m3_consultation3_reason_96 (. = .a) if m3_consultation_referral_3 !=0
	   
replace m3_consultation3_reason_other = ".a" if m3_consultation3_reason_96 !=1		

/* No consultation 4-5 in this dataset
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
*/


recode m3_412a_1_ke m3_412a_2_ke m3_412a_3_ke m3_412b_1_ke m3_412b_2_ke m3_412b_3_ke m3_412c_1_ke m3_412c_2_ke m3_412c_3_ke m3_412d_1_ke m3_412d_2_ke m3_412d_3_ke m3_412e_1_ke m3_412e_2_ke m3_412e_3_ke m3_412f_1_ke m3_412f_2_ke m3_412f_3_ke m3_412g_1_ke m3_412g_2_ke m3_412g_3_ke m3_412i_1_ke m3_412i_2_ke m3_412i_3_ke (. = .a) if m3_401 !=1
 
recode m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke m3_412i_1_ke (. = .a) if m3_402 !=1

recode m3_412i_1_ke (. = .a) if m3_412a_1_ke ==1 | m3_412b_1_ke ==1 | m3_412c_1_ke ==1 | ///
								m3_412d_1_ke ==1 | m3_412e_1_ke ==1 | m3_412f_1_ke ==1 | ///
								m3_412g_1_ke ==1 

recode m3_412g_1_other (. = .a) if m3_412g_1_ke !=1 // numeric bc of 0 obs

recode m3_412a_2_ke m3_412b_2_ke m3_412c_2_ke m3_412d_2_ke m3_412e_2_ke m3_412f_2_ke m3_412g_2_ke m3_412i_2_ke (. = .a) if m3_402 !=2

recode m3_412i_2_ke (. = .a) if m3_412a_2_ke ==1 | m3_412b_2_ke ==1 | m3_412c_2_ke ==1 | ///
								m3_412d_2_ke ==1 | m3_412e_2_ke ==1 | m3_412f_2_ke ==1 | ///
								m3_412g_2_ke ==1 

replace m3_412g_2_other = ".a" if m3_412g_2_ke !=1

recode m3_412a_3_ke m3_412b_3_ke m3_412c_3_ke m3_412d_3_ke m3_412e_3_ke m3_412f_3_ke m3_412g_3_ke m3_412i_3_ke (. = .a) if m3_402 !=3

recode m3_412i_3_ke (. = .a) if m3_412a_3_ke ==1 | m3_412b_3_ke ==1 | m3_412c_3_ke ==1 | ///
								m3_412d_3_ke ==1 | m3_412e_3_ke ==1 | m3_412f_3_ke ==1 | ///
								m3_412g_3_ke ==1 

recode m3_412g_3_other (. = .a) if m3_412g_3_ke !=1 // numeric bc of 0 obs

recode m3_501 (. = .a) if m2_202 !=2 | m2_202 !=3

recode m3_502 m3_503 (. = .a) if m3_501 !=1

replace m3_504a = ".a" if m3_503 !=-96

replace m3_504b= ".a" if m3_503 !=-96

replace m3_504c= ".a" if m3_503 !=-96

replace m3_503_final= ".a" if m3_503 !=-96
replace m3_503_final = ".d" if m3_503_final == "999"

recode m3_506_pre (. = .a) if m3_501 !=1

replace m3_506_pre_oth = ".a" if m3_506_pre != -96

recode m3_507 (. = .a) if m3_501 !=1

recode m3_508 m3_509 (. = .a) if m3_501 !=0

replace m3_509_other = ".a" if m3_509 !=-96

recode m3_510 (. = .a) if m3_501 !=1

recode m3_511 (. = .a) if m3_510 !=1

recode m3_512_1_ke m3_512_2_ke (. = .a) if m3_510 !=1

recode m3_512_1_ke (. = .a) if m3_511 !=1

recode m3_512_2_ke (. = .a) if m3_511 !=2

recode m3_513a (. = .a) if m3_510 !=1

replace m3_513_outside_zone_other = ".a" if m3_513a != -96

replace m3_513b2 = ".a" if m3_513a != -96

replace m3_513b3 = ".a" if m3_513a != -96

replace m3_513_final = ".a" if m3_513a !=-96

replace m3_514 = ".a" if m3_510 !=1

recode m3_515 (. = .a) if m3_510 !=1 

recode m3_516 (. = .a) if m3_515 !=4 & m3_515 !=5

recode m3_517 (. = .a) if m3_515 !=2 & m3_515 !=3

recode m3_518_96_ke m3_518_97_ke m3_518_98_ke m3_518_99_ke m3_518a_ke ///
	   m3_518b_ke m3_518c_ke m3_518d_ke m3_518e_ke m3_518f_ke m3_518g_ke m3_518h_ke ///
	   m3_518i_ke m3_518j_ke m3_518k_ke (. = .a) if m3_517 !=1

replace m3_518_other_complications = ".a" if m3_518_96_ke !=1

replace m3_518_other = ".a" if m3_518_97_ke !=1

recode m3_519 (. = .a) if m3_510 !=0 | m3_517 == 1

replace m3_519_other = ".a" if m3_519 !=-96 

replace m3_520 =".a" if m3_501 !=1 & m3_515 !=1

recode m3_521_ke m3_521_ke_unit (. = .a) if m3_501 !=1

recode m3_601_hiv m3_601b m3_601c m3_602a m3_603a m3_603b m3_603c ///
	   m3_604a m3_604b m3_605a (. = .a) if m3_503_final == "." | ///
	   m3_503_final == "" | m3_503_final == ".d" | m3_503_final == ".a" | m3_501 !=1 // N= 4 missings

recode m3_602b (. = .a) if m3_501 !=1 | m3_602a !=0

recode m3_605b m3_605c(. = .a) if m3_605a !=1

replace m3_605c_other = ".a" if m3_605c !=-96

recode m3_606 m3_607 (. = .a) if m3_605a !=0

recode m3_608 (. = .a) if m3_501 !=1

recode m3_609 m3_610a m3_611 m3_612_ke m3_612_ke_unit (. = .a) if m3_501 !=1 | bornalive_babies == "0"  | bornalive_babies == ""
	  
recode m3_610b (. = .a) if m3_610a !=1 | bornalive_babies == "0" | bornalive_babies == ""

recode m3_613 (. = .a) if m3_501 !=1	  

recode m3_614_ke m3_614_ke_unit (. = .a) if m3_613 !=1

recode m3_615a (. = .a) if m3_501 !=1 | (m3_baby1_born_alive1 !=1 | m3_baby1_born_alive2 !=1)

recode m3_615b (. = .a) if m3_501 !=1 | (m3_baby2_born_alive1 !=1 | m3_baby2_born_alive2 !=1)

recode m3_616c_1 m3_616c_1_unit (. = .a) if m3_615a !=1

recode m3_616c_2 m3_616c_2_unit (. = .a) if m3_615b !=1

recode m3_617a (. = .a) if m3_501 !=1 | m3_baby1_born_alive1 !=1 | m3_baby1_born_alive2 !=1

recode m3_617b (. = .a) if m3_501 !=1 | m3_baby2_born_alive1 !=1 | m3_baby2_born_alive2 !=1

recode m3_618a_1 (. = .a) if m3_501 !=1 | m3_baby1_born_alive1 !=1 | m3_baby1_born_alive2 !=1

recode m3_618a_2 (. = .a) if m3_501 !=1 | m3_baby2_born_alive1 !=1 | m3_baby2_born_alive2 !=1

recode m3_618b_1 (. = .a) if m3_618a_1 !=1

recode m3_618b_2 (. = .a) if  m3_618a_2 !=1

recode m3_618c_1 (. = .a) if m3_618b_1 !=1

recode m3_618c_2 (. = .a) if m3_618b_2 !=1

recode m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g m3_619h m3_620_1 m3_620_2 (. = .a) if ///
	   m3_501 !=1 | bornalive_babies == "0" | bornalive_babies == ""

recode m3_620_1 (. = .a) if m3_303b !=1

recode m3_620_2 (. = .a) if m3_303c !=1
	   
replace m3_621a = ".a" if m3_501 !=0			   

recode m3_621a_1_ke m3_621a_2_ke m3_621a_3_ke m3_621a_4_ke m3_621a_5_ke m3_621a_6_ke ////
	   m3_621a_98_ke m3_621a_99_ke (. = .a) if m3_501 !=0		
	   
recode m3_621b (. = .a) if m3_501 !=0   
						   
recode m3_621c_ke m3_621c_ke_unit (. = .a) if m3_621b !=1

recode m3_622a m3_622c (. = .a) if m3_501 !=0   

recode m3_622b (. = .a) if m3_622a !=1 

recode m3_701 (. = .a) if m2_202 !=2 | m2_202 !=3   

replace m3_702 = ".a" if m3_701 !=1

recode m3_703 (. = .a) if m3_701 !=1

recode m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g (. = .a) if m2_202 !=2 | m2_202 !=3   

recode m3_705 m3_706 m3_707_ke m3_707_ke_unit (. = .a) if m3_501 !=1

recode m3_baby1_sleep m3_baby1_feed m3_baby1_breath m3_baby1_stool m3_baby1_mood ///
	   m3_baby1_skin m3_baby1_interactivity (. = .a) if m3_303b !=1

recode m3_baby2_sleep m3_baby2_feed m3_baby2_breath m3_baby2_stool m3_baby2_mood ///
	   m3_baby2_skin m3_baby2_interactivity (. = .a) if m3_303c !=1
	   
recode m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e ///
	   m3_baby1_issues_f m3_baby1_issues_98 m3_baby1_issues_99 (. = .a) if ///
	   m3_baby1_born_alive1 !=1 | m3_baby1_born_alive2 !=1
	   
recode m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e ///
	   m3_baby2_issues_f m3_baby2_issues_98 m3_baby2_issues_99 (. = .a) if ///
	   m3_baby2_born_alive1 !=1 | m3_baby2_born_alive2 !=1

recode m3_708_oth_1 (.=.a) if bornalive_babies == "0" | bornalive_babies == "" 

recode m3_708_oth_2 (.=.a) if bornalive_babies == "0" | bornalive_babies == "" 
	   
replace m3_708a = ".a" if m3_708_oth_1 !=1

replace m3_708b = ".a" if m3_708_oth_2 !=1
 
recode m3_710a m3_710b m3_711c_1 m3_711c_1_unit m3_711c_2 m3_711c_2_unit (. = .a) if m3_501 !=1 | bornalive_babies == "0" | bornalive_babies == "" 

recode m3_711c_2 m3_711c_2_unit (. = .a) if m3_303c !=1

recode m3_801a m3_801b m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h ///
	   m3_803j m3_805 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g ///
	   m3_901h m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q ///
	   m3_901r (. = .a) if module !=3 | m2_202 !=2 | m2_202 !=3   
 
recode m3_802a (. = .a) if m3_phq2_score<3 | m3_phq2_score ==. | m3_phq2_score ==.a | module !=3
	   
recode m3_802b m3_802c (. = .a) if m3_802a !=1

replace m3_803j_other = ".a" if m3_803j !=1

recode m3_806 m3_807 m3_808a (. = .a) if m3_805 !=1

recode m3_808b (. = .a) if m3_805 !=1 | m3_808a !=0

recode m3_808b_other (. = .a) if m3_808b !=-96 // numeric because of 0 obs

recode m3_809 (. = .a) if m3_805 !=1 | m3_808a !=1

replace m3_901r_other = ".a" if m3_901r !=1

recode m3_901_cost (. = .a) if (m3_901a !=1 & m3_901b !=1 & m3_901c & ///
					 m3_901d !=1 & m3_901e !=1 & m3_901f !=1 & m3_901g !=1 & m3_901h !=1 & m3_901i !=1 &  ///
					 m3_901j !=1 & m3_901k !=1 & m3_901l !=1 & m3_901m !=1 & m3_901n !=1 & m3_901o !=1 &  ///
					 m3_901p !=1 & m3_901q !=1 & m3_901r !=1) | module !=3 | m2_202 !=2 | m2_202 !=3   
					 
recode m3_902_1_cost (. = .a) if m3_902a_baby1 !=1 & m3_902b_baby1 !=1 & m3_902c_baby1 !=1 &  ///
								 m3_902d_baby1 !=1 & m3_902e_baby1 !=1 & m3_902f_baby1 !=1 & ///
								 m3_902g_baby1 !=1 & m3_902h_baby1 !=1 & m3_902i_baby1 !=1 & m3_902j_baby1 !=1 
					 
recode m3_902_2_cost (. = .a) if m3_902a_baby2 !=1 & m3_902b_baby2 !=1 & m3_902c_baby2 !=1 & m3_902d_baby2 !=1 & ///
								 m3_902e_baby2 !=1 &  m3_902f_baby2 !=1 &  m3_902g_baby2 !=1 & ///
								 m3_902h_baby2 !=1 &  m3_902i_baby2 !=1 &  m3_902j_baby2 !=1					 
					 
recode m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 (. = .a) if m3_303b !=1

recode m3_902a_baby2 m3_902b_baby2 m3_902c_baby2 m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 (. = .a) if m3_303c !=1

recode m3_902i_baby1 (. = .a) if  m2_hiv_status !=1 | module !=3 | m3_303b !=1 | bornalive_babies == "0" | bornalive_babies == "" 

recode m3_902i_baby2 (. = .a) if  m2_hiv_status !=1 | module !=3 | m3_303c !=1 | bornalive_babies == "0" | bornalive_babies == "" | bornalive_babies == "1" 

recode m3_902j_baby1 (. = .a) if module !=3 | m3_303b !=1 | m3_baby1_born_alive1 !=1 | m3_baby1_born_alive2 !=1

replace m3_902j_baby1_other = ".a" if m3_902j_baby1 !=1

recode m3_902j_baby2 (. = .a) if module !=3 | m3_303c !=1 | m3_baby2_born_alive1 !=1 | m3_baby2_born_alive2 !=1

replace m3_902j_baby2_other = ".a"  if m3_902j_baby2 !=1 

recode m3_1001 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f ///
	   m3_1004g m3_1004h m3_1005a m3_1005b m3_1005c m3_1005d ///
	   m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1007a m3_1007b m3_1007c m3_1101 ///
	   (. = .a) if module !=3 | m3_501 !=1
 
recode m3_1006b m3_1006c (. = .a) if m3_1006a !=1

recode m3_1102a_amt (. = .a) if m3_1101 !=1

recode m3_1102b_amt (. = .a) if m3_1101 !=1

recode m3_1102c_amt (. = .a) if m3_1101 !=1

recode m3_1102d_amt (. = .a) if m3_1101 !=1

recode m3_1102e_amt (. = .a) if m3_1101 !=1

recode m3_1102f_amt (. = .a) if m3_1101 !=1

replace m3_1102f_oth = ".a" if m3_1102f_amt ==0 | m3_1102f_amt == . | m3_1102f_amt ==.a | m3_1102f_amt ==.d

recode m3_1102_total (. = .a) if (m3_1102a_amt ==0 | m3_1102a_amt == . | m3_1102a_amt == .a | m3_1102a_amt ==.d) & ///
								 (m3_1102b_amt ==0 | m3_1102b_amt == . | m3_1102b_amt == .a | m3_1102b_amt ==.d) & ///
								 (m3_1102c_amt ==0 | m3_1102c_amt == . | m3_1102c_amt == .a | m3_1102c_amt ==.d) & ///
								 (m3_1102d_amt ==0 | m3_1102d_amt == . | m3_1102d_amt == .a | m3_1102d_amt ==.d) & ///
							     (m3_1102e_amt ==0 | m3_1102e_amt == . | m3_1102e_amt == .a | m3_1102e_amt ==.d) & ///
								 (m3_1102f_amt ==0 | m3_1102f_amt == . | m3_1102f_amt == .a | m3_1102f_amt ==.d) | ///
								 module !=3 | m3_501 !=1
						 
recode m3_1103 m3_1105_96_ke m3_1105a_ke m3_1105b_ke m3_1105c_ke m3_1105d_ke m3_1105e_ke m3_1105f_ke m3_1105g_ke (. = .a) if (m3_1102_total == . |  m3_1102_total == .a)

replace m3_1105_other = ".a" if m3_1105_96_ke !=1

recode m3_1106 (. = .a) if module !=3 | m2_202 !=2 | m2_202 !=3   

recode m3_endtime (. = .a) if module !=3 | (m3_303b !=1  & m3_303c !=1)
	
replace m3_duration = ".a" if module !=3 | (m3_303b !=1  & m3_303c !=1)		
		
*===============================================================================
	
	* STEP FOUR: LABELING VARIABLES
lab var m3_start_p1 "May I proceed with the interview?"
lab var m3_date "102. Date of interview (D-M-Y)"
lab var m3_date_confirm "Confirm date of interview" 
lab var m3_start_time "Time of interview started"
lab var m3_date_time "Time of interview started and date of interview"
lab var m3_birth_or_ended "201a. On what date did you give birth or did the pregnancy end?"
lab var m3_birth_or_ended_provided "201a. Did the respondent provide the date?"
lab var m3_birth_or_ended_date "201a. Date of giving birth or pregnancy ended calculation."
lab var m3_ga_final "201d. Gestational age at delivery (final)"
lab var m3_303a "301. If its ok with you, I would like to now ask some questions about the baby or babies. How many babies were you pregnant with?"
lab var m3_303b "303a. Is the 1st baby alive?"
lab var m3_303c "303b. Is the 2nd baby alive?"
lab var m3_baby1_name "304a. What is the 1st babys name?"
lab var m3_baby2_name "304b. What is the 2nd babys name?"
lab var m3_baby1_gender "305a. What is 1st baby's's gender?"
lab var m3_baby2_gender "305b. what is the second baby's gender?"
lab var m3_baby1_age_weeks "306a. How old is the 1st baby in weeks?" 
lab var m3_baby2_age_weeks "306b. How old is the second baby in weeks"
lab var m3_baby1_weight "307a. How much did the 1st baby weigh at birth?"
lab var m3_baby2_weight "307b.How much did the second baby weigh at birth?"
lab var m3_baby1_size "308a. When the 1st baby was born, were they: very large, larger than average, average, smaller than average or very small?"
lab var m3_baby2_size "308b. When the second baby was born, were they: very large, larger than average, average, smaller than average or very small?"
lab var m3_baby1_health "309a. In general, how would you rate the 1st baby's overall health?"
lab var m3_baby2_health "309b. In general, how would you rate the second baby's overall health?"

lab var m3_baby1_feed_a "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Breast milk)"
lab var m3_baby1_feed_b "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Formula/Cow milk)"
lab var m3_baby1_feed_c "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Water)"
lab var m3_baby1_feed_d "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Juice)"
lab var m3_baby1_feed_e "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Broth)"
lab var m3_baby1_feed_f "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Baby food)"
lab var m3_baby1_feed_g "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Local food)"
lab var m3_baby1_feed_h "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=Fresh milk)"
lab var m3_baby1_feed_99 "310a. Please indicate how you have fed the 1st baby in the last 7 days? (choice=NR/RF)"
lab var m3_baby2_feed_a "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Breast milk)"
lab var m3_baby2_feed_b "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Formula/Cow milk)"
lab var m3_baby2_feed_c "310a. Please indicate how you have fed the 2nd aby in the last 7 days? (choice=Water)"
lab var m3_baby2_feed_d "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Juice)"
lab var m3_baby2_feed_e "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Broth)"
lab var m3_baby2_feed_f "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Baby food)"
lab var m3_baby2_feed_g "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Local food)"
lab var m3_baby2_feed_h "310a. Please indicate how you have fed the 2nd baby in the last 7 days? (choice=Fresh milk)"
lab var m3_baby2_feed_99 "310a. Please indicate how you have fed the second baby in the last 7 days? (choice=NR/RF)"
lab var m3_breastfeeding "310b. As of today, how confident do you feel about breastfeeding your 1st baby?"
lab var m3_breastfeeding_2 "310b. As of today, how confident do you feel about breastfeeding your second baby?"

lab var m3_baby1_born_alive1 "312.I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it's okay with you, I would like to ask a few more questions about the baby. Was the 1st baby born alive?"
lab var m3_baby1_born_alive2 "312a.Did the 1st baby cry, make any movement, sound, or effort to breathe, or show any other signs of life even if for a very short time?"
lab var m3_baby2_born_alive1 "312.I am very sorry to hear this. I hope that you will find the strength to deal with that event. If it's okay with you, I would like to ask a few more questions about the baby. Was the 2nd baby born alive?"
lab var m3_baby2_born_alive2 "312a.Did the 2nd baby cry, make any movement, sound, or effort to breathe, or show any other signs of life even if for a very short time?"
lab var m3_313a_baby1 "313a. On what day did the 1st baby baby die (i.e. the date of death)?"
lab var m3_313c_baby1 "313c. After how many days or hours did the baby die?"   
lab var m3_313d_baby1 "313d. The unit of time."
lab var m3_313a_baby2 "313a. On what day did the second baby baby die (i.e. the date of death)?"
lab var m3_313c_baby2 "313c. After how many days or hours did the second baby die?"   
lab var m3_313d_baby2 "313d. The unit of time."
lab var m3_death_cause_baby1 "314. What were you told was the cause of death for the 1st baby, or were you not told?"
lab var m3_death_cause_baby1_other "314-Other-1. Specify the cause of death for the 1st baby"		
lab var m3_death_cause_baby2 "314. What were you told was the cause of death for the second baby, or were you not told?"
lab var m3_death_cause_baby2_other "314-Other-2. Specify the cause of death for the second baby"

lab var m3_401 "401. Before we talk about the delivery, I would like to ask about any additional health care you may have received since you last spoke to us and BEFORE the delivery. We are interested in ALL NEW healthcare consultations that you may have had for yourself between the time of the last survey and the delivery. Since you last spoke to us, did you have any new healthcare consultations for yourself before the delivery?"
lab var m3_402 "402. How many new healthcare consultations did you have?"

lab var m3_consultation_1 "403. Was the 1st consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_1 "404. Was the 1st for referral from your antenatal care provider?"
lab var m3_consultation1_reason_a "405. Was the 1st visit for any of the following? (choice=A new health problem, including an emergency or an injury)"
lab var m3_consultation1_reason_b "405. Was the 1st visit for any of the following? (choice=An existing health problem)"
lab var m3_consultation1_reason_c "405. Was the 1st visit for any of the following? (choice=A lab test, x-ray, or ultrasound)"
lab var m3_consultation1_reason_d "405. Was the 1st visit for any of the following? (choice=To pick up medicine)"
lab var m3_consultation1_reason_e "405. Was the 1st visit for any of the following? (choice=To get a vaccine)"
lab var m3_consultation1_reason_96 "405. Was the 1st visit for any of the following? (choice=Other reasons, please specify)"
lab var m3_consultation1_reason_other "405-Other. Other reasons, please specify"

lab var m3_consultation_2 "406. Was the 2nd consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_2 "407. Was the 2nd for referral from your antenatal care provider?"
lab var m3_consultation2_reason "408. Was the 2nd visit for any of the following?"
lab var m3_consultation2_reason_a "408. Was the 2nd visit for any of the following? (choice=A new health problem, including an emergency or an injury)"
lab var m3_consultation2_reason_b "408. Was the 2nd visit for any of the following? (choice=An existing health problem)"
lab var m3_consultation2_reason_c "408. Was the 2nd visit for any of the following? (choice=A lab test, x-ray, or ultrasound)"
lab var m3_consultation2_reason_d "408. Was the 2nd visit for any of the following? (choice=To pick up medicine)"
lab var m3_consultation2_reason_e "408. Was the 2nd visit for any of the following? (choice=To get a vaccine)"
lab var m3_consultation2_reason_96 "408. Was the 2nd visit for any of the following? (choice=Other reasons, please specify)"
lab var m3_consultation2_reason_other "408-Other. Other reasons, please specify"
		
lab var m3_consultation_3 "409. Was the 3rd consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_3 "410. Was the 3rd for referral from your antenatal care provider?"
lab var m3_consultation3_reason "408. Was the 3rd visit for any of the following?"
lab var m3_consultation3_reason_a "411. Was the 3rd visit for any of the following? (choice=A new health problem, including an emergency or an injury)"
lab var m3_consultation3_reason_b "411. Was the 3rd visit for any of the following? (choice=An existing health problem)"
lab var m3_consultation3_reason_c "411. Was the 3rd visit for any of the following? (choice=A lab test, x-ray, or ultrasound)"
lab var m3_consultation3_reason_d "411. Was the 3rd visit for any of the following? (choice=To pick up medicine)"
lab var m3_consultation3_reason_e "411. Was the 3rd visit for any of the following? (choice=To get a vaccine)"
lab var m3_consultation3_reason_96 "411. Was the 3rd visit for any of the following? (choice=Other reasons, please specify)"
lab var m3_consultation3_reason_other "411-Other. Other reasons, please specify"

*lab var m3_412a "412a. Between the time that you last spoke to us and before the delivery, did you get your blood pressure measured (with a cuff around your arm)"
*lab var m3_412b "412b. Between the time that you last spoke to us and before the delivery, did you get your weight taken (using a scale)?"
*lab var m3_412c "412c. Between the time that you last spoke to us and before the delivery, did you get a blood draw (that is, taking blood from your arm with a syringe?"
*lab var m3_412d "412d. Between the time that you last spoke to us and before the delivery, did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
*lab var m3_412e "412e. Between the time that you last spoke to us and before the delivery, did you get a urine test (that is, where you peed in a container)?"
*lab var m3_412f "412f. Between the time that you last spoke to us and before the delivery, did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
*lab var m3_412g "412g. Between the time that you last spoke to us and before the delivery, did you get any other test?"
*lab var m3_412g_other "412g-Other . Specify other tests you got between the time that you last spoke to us and before the delivery"
*lab var m3_412i "412i  Between the time that you last spoke to us and before the delivery, did you get any other test? (Choice=None)"

lab var m3_501 "501. Did you deliver in a health facility?"
lab var m3_502 "502. What kind of facility was it?"
lab var m3_503 "503. What is the name of the facility where you delivered?"
lab var m3_504a "504a. Where region was this facility located?"
lab var m3_504b "504b. Where was the city/sub-city/district this facility located?"
lab var m3_504c "504c. Where was the county this facility located?"
lab var m3_503_final "503-final. What is the name of the facility where you delivered? (final)"
lab var m3_506_pre "506-pre. Are you able to name the day and time the labor started - that is, when contractions started and did not stop, or when your water broke?"
lab var m3_506_pre_oth "506-pre-Other. Other reason, specify"
lab var m3_506 "506. What day and time did the labor start – that is, when contractions started and did not stop, or when your water broke?"
lab var m3_507 "507. At what time did you leave for the facility?"
lab var m3_508 "508. At any point during labor or delivery did you try to go to a facility?"
lab var m3_509 "509. What was the main reason for giving birth at home instead of a health facility?"
lab var m3_509_other "509_Oth. Specify other reasons for giving birth at home instead of a health facility"
lab var m3_513a "513a. What is the name of the facility you went to 1st?"
lab var m3_513_outside_zone_other "513a_97. Other outside of the zone"
lab var m3_513b2 "513b2. Where city/sub-city/district was this facility located?"
lab var m3_513b3 "513b3. Which county was this facility located??"
lab var m3_513_final "513-final. What is the name of the facility you went to 1st? (final)"
lab var m3_514 "514. At what time did you arrive at the facility you went to 1st?"
lab var m3_515 "515. Why did you go to the facility you went to 1st after going to the facility you delivered at?"
lab var m3_516 "516. Why did you or your family member decide to leave the facility you went to 1st and come to the facility you delivered at? Select only one main reason"
lab var m3_517 "517. Did the provider inform you why they referred you?"
lab var m3_518 "518. Why did the provider refer you to the facility you delivered at?"
lab var m3_518_other_complications "518_96. Other delivery complications, specify"
lab var m3_518_other "518_97. Other reasons, specify"
lab var m3_519 "519. What was the main reason you decided that you wanted to deliver at the facility you delivered at?"
lab var m3_519_other "519_Oth. Other, specify"
lab var m3_520 "520. At what time did you arrive at the facility you delivered at?"
lab var m3_521_ke "521-ke. Once you got to the facility, how long did you wait until a healthcare worker checked on you?"
lab var m3_521_ke_unit "521-ke-unit. The unit of time."
lab var m3_601_hiv "601-hiv. Once you were 1st checked by a health care provider at the facility you delivered at, did the health care provider ask about your HIV status?"
lab var m3_601b "601b. Once you were 1st checked by a health care provider at the facility you delivered at, did the health care provider take your blood pressure (with a cuff around your arm)?"
lab var m3_601c "601c. Once you were 1st checked by a health care provider at the facility you delivered at, did the health care provider Explain what will happen during labor?"
lab var m3_602a "602a. Did the health care provider, look at your integrated maternal child health card?"
lab var m3_602b "602b. Did the health care provider have information about your antenatal care (e.g. your tests results) from health facility records?"
lab var m3_603a "603a. During your time in the health facility while in labor or giving birth Were you told you could walk around and move during labour?"
lab var m3_603b "603b. During your time in the health facility while in labor or giving birth Were you allowed to have a birth companion present? For example, this includes your husband, a friend, sister, mother-in-law etc.?"
lab var m3_603c "603c. During your time in the health facility while in labor or giving birth Did you have a needle inserted in your arm with a drip?"
lab var m3_604a "604a. While you were in labor and giving birth, what were you sitting or lying on?"
lab var m3_604b "604b. While you were giving birth, were curtains, partitions or other measures used to provide privacy from other people not involved in your care?"
lab var m3_605a "605a. Did you have a caesarean? (That means, did they cut your belly open to take the baby out?)"
lab var m3_605b "605b. When was the decision made to have the caesarean section? Was it before or after your labor pains started?"
lab var m3_605c "605c. What was the reason for having a caesarean? "
lab var m3_605c_other "605c-Other. Specify other reason for having a caesarean"
lab var m3_606 "606. Did the provider perform a cut near your vagina to help the baby come out?"
lab var m3_607 "607. Did you receive stiches near your vagina after the delivery?"		
lab var m3_608 "608. Immediately after delivery: Did a health care provider give you an injection or pill to stop the bleeding?"
lab var m3_609 "609. Immediately after delivery, did a health care provider dry the baby/babies with a towel?"
lab var m3_610a "610a. Immediately after delivery, was/were the baby/babies put on your chest?"
lab var m3_610b "610b. Immediately after delivery, was/were the babys/babies bare skin touching your bare skin?"
lab var m3_611 "611. Immediately after delivery, did a health care provider help you with breastfeeding the baby/babies?"
lab var m3_612_ke "612-ke. How long after the baby/babies was born did you 1st breastfeed he/she/them?"
lab var m3_612_ke_unit "612-ke-unit. The unit of time for m3_612_ke."
lab var m3_613 "613. I would like to talk to you about checks on your health after the delivery, for example, someone asking you questions about your health or examining you. Did anyone check on your health while you were still in the facility?"
lab var m3_614_ke "614-ke. How long after delivery did the 1st check take place?"
lab var m3_614_ke_unit "614-ke-unit. The unit of time for m3_614_ke"		
lab var m3_615a "615a. Did anyone check on the 1st baby's health while you were still in the facility?"
lab var m3_615b "615b. Did anyone check on the 2nd baby's health while you were still in the facility?"
lab var m3_616c_1 "616c-1. How long after delivery was the 1st baby health 1st checked? "
lab var m3_616c_1_unit "616c-1-unit. The unit of time for m3_616c_1."
lab var m3_616c_2 "616c-2. How long after delivery was the second baby health 1st checked? "
lab var m3_616c_2_unit "616c-1-unit. he unit of time for m3_616c_2."
lab var m3_617a "617a. Did the 1st baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
lab var m3_617b "617b. Did the second baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
lab var m3_618a_1 "618a-1. Was the 1st baby tested for HIV after birth?" 
lab var m3_618b_1 "618b-1. What was the result of the baby's HIV test?"
lab var m3_618c_1 "618c-1. Was the 1st baby given medication to prevent HIV/AIDS (ARVs)?"
lab var m3_618a_2 "618a-2. Was the second bay tested for HIV after birth?"
lab var m3_618b_2 "618b-2. What was the result of the baby's HIV test?"
lab var m3_618c_2 "618c-2. Was the second baby given medication to prevent HIV/AIDS (ARVs)?"
lab var m3_619a "619a. Before you left the facility, did you receive advice on what the baby should eat (only breastmilk or No other foods)?"
lab var m3_619b "619b. Before you left the facility, did you receive advice on care of the umbilical cord?"
lab var m3_619c "619c. Before you left the facility, did you receive advice on avoid chilling of baby?"
lab var m3_619d "619d. Before you left the facility, did you receive advice on when to return for vaccinations for the baby?"
lab var m3_619e "619e. Before you left the facility, did you receive advice on hand washing with soap/water before touching the baby?"
lab var m3_619g "619g. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in the baby that would mean you should go to a health facility?"
lab var m3_619h "619h. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in yourself that would mean you should go to a health facility?"
lab var m3_620_1 "620-1. During any point of your pregnancy or after birth, were you given a mother & child booklet for the 1st baby to take home with you?"
lab var m3_620_2 "620-2. During any point of your pregnancy or after birth, were you given a mother & child booklet for the 1st baby to take home with you?"
lab var m3_621a "621a. Who assisted you in the delivery?"
lab var m3_621b "621b. Did someone come to check on you after you gave birth? For example, someone asking you questions about  your health or examining you?"
lab var m3_621c_ke "621c-ke. How long after giving birth did the checkup take place?"
lab var m3_621c_ke_unit "621c-ke-unit. The unit of time for m3_621c_ke."
lab var m3_622a "622a. Around the time of delivery, were you told that  you will need to go to a facility for a checkup for you or your baby?"
lab var m3_622b "622b. When were you told to go to a health facility for postnatal checkups? How many days after delivery?"
lab var m3_622c "622c. Around the time of delivery, were you told that someone would come to visit you at your home to check on you or your babys health?"
lab var m3_baby1_sleep "311a. Regarding sleep, which response best describes the 1st baby today?"
lab var m3_baby2_sleep "311a. Regarding sleep, which response best describes the second baby today?"
lab var m3_baby1_feed "311b. Regarding feeding, which response best describes the 1st baby today?"
lab var m3_baby2_feed "311b. Regarding feeding, which response best describes the second baby today?"
lab var m3_baby1_breath "311c. Regarding breathing, which response best describes the 1st baby today?"
lab var m3_baby2_breath "311c. Regarding breathing, which response best describes the second baby today?"
lab var m3_baby1_stool "311d. Regarding stooling/poo, which response best describes the 1st baby today?"
lab var m3_baby2_stool "311d. Regarding stooling/poo, which response best describes the second baby today?"
lab var m3_baby1_mood "311e. Regarding their mood, which response best describes the 1st baby today?"
lab var m3_baby2_mood "311e. Regarding their mood, which response best describes the second baby today?"
lab var m3_baby1_skin "311f. Regarding their skin, which response best describes the 1st baby today?"
lab var m3_baby2_skin "311f. Regarding their skin, which response best describes the second baby today?"
lab var m3_baby1_interactivity "311g. Regarding interactivity, which response best describes the 1st baby today?"
lab var m3_baby2_interactivity "311g. Regarding interactivity, which response best describes the second baby today?"	
lab var m3_701 "701. At any time during labor, delivery, or after delivery did you suffer from any health problems?"
lab var m3_702 "702. What health problems did you have?"
lab var m3_703 "703. Would you say this problem was severe?"
lab var m3_704a "704a. During your delivery, did you experience seizures, or not?"
lab var m3_704b "704b. During your delivery, did you experience blurred vision, or not?"
lab var m3_704c "704c. During your delivery, did you experience severe headaches, or not?"
lab var m3_704d "704d. Did you experience swelling in hands/feet during your delivery, or not?"
lab var m3_704e "704e. Did you experience labor over 12 hours during your delivery, or not?"
lab var m3_704f "704f. Did you experience Excessive bleeding during your delivery, or not?"
lab var m3_704g "704g. During your delivery, did you experience fever, or not?"
lab var m3_705 "705. Did you receive a blood transfusion around the time of your delivery?"
lab var m3_706 "706. Were you admitted to an intensive care unit?"
lab var m3_707_ke "707-ke. How long did you stay at the facility that you delivered at after the delivery?"
lab var m3_707_ke_unit "707-ke-unit. The unit of time for m3_707_ke"
lab var m3_baby1_issues "708ba Did the 1st baby experience any of the following issues in the 1st day of life?"
lab var m3_baby1_issues_a "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble breathing)"
lab var m3_baby1_issues_b "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Fever)"
lab var m3_baby1_issues_c "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble feeding)"
lab var m3_baby1_issues_d "708a. Did the baby the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
lab var m3_baby1_issues_e "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Low birth weight)"
lab var m3_baby1_issues_f "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=No complications)"
lab var m3_baby1_issues_98 "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=DK)"
lab var m3_baby1_issues_99 "708a. Did the 1st baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=NR/RF)"
lab var m3_baby2_issues "708b. Did the second baby experience any of the following issues in the 1st day of life?"
lab var m3_baby2_issues_a "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble breathing)"
lab var m3_baby2_issues_b "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Fever, low temperature, or infection)"
lab var m3_baby2_issues_c "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Trouble feeding)"
lab var m3_baby2_issues_d "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Jaundice (yellow color of the skin))"
lab var m3_baby2_issues_e "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=Low birth weight)"
lab var m3_baby2_issues_f "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=No complications)"
lab var m3_baby2_issues_98 "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=DK)"
lab var m3_baby2_issues_99 "708b. Did the second baby experience any of the following issues in the 1st day of life? Tell me all that apply. (choice=NR/RF)"		
lab var m3_708_oth_1 "708-Other. Did the 1st baby experience any other health problems in the 1st day of life?"
lab var m3_708a "709a. Write down the 1st baby's experiences any other health problems in the 1st day of life"
lab var m3_708_oth_2 "708-Other. Did the second baby experience any other health problems in the 1st day of life?"
lab var m3_708b "709b. Write down the second baby's experiences any other health problems in the 1st day of life"
lab var m3_710a "710a. Did the 1st baby spend time in a special care nursery or intensive care unit before discharge?"
lab var m3_710b "710b. Did the second baby spend time in a special care nursery or intensive care unit before discharge?"			
lab var m3_711c_1 "711c-1. How long did the 1st baby stay at the health facility after being born?"
lab var m3_711c_1_unit "711c-1-unit. The unit of time for m3_711c_1"
lab var m3_711c_2 "711c-2. How long did the second baby stay at the health facility after being born?"
lab var m3_711c_2_unit "711c-2-unit. The unit of time for m3_711c_2"
lab var m3_801a "801a. Over the past 2 weeks, on how many days have you been bothered little interest or pleasure in doing things?"
lab var m3_801b "801b. Over the past 2 weeks, on how many days have you been bothered feeling down, depressed, or hopeless in doing things?"
lab var m3_802a "802a. Since you last spoke to us, did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves?"
lab var m3_802b "802b. How many of these sessions did you have since you last spoke to us?"
lab var m3_802c "802c. How many minutes did this/these visit(s) last on average?"
lab var m3_803a "803a. Since giving birth, have you experienced severe or persistent headaches?"
lab var m3_803b "803b. Since giving birth, have you experienced a fever?"
lab var m3_803c "803c. Since giving birth, have you experienced severe abdominal pain, not just discomfort?"
lab var m3_803d "803d. Since giving birth, have you experienced a lot of difficulty breathing even when you are resting?"
lab var m3_803e "803e. Since giving birth, have you experienced convulsions or seizures?"
lab var m3_803f "803f. Since giving birth, have you experienced repeated fainting or loss of consciousness?"
lab var m3_803g "803g. Since giving birth, have you experienced continued heavy vaginal bleeding?"
lab var m3_803h "803h. Since giving birth, have you experienced foul smelling vaginal discharge?"	
lab var m3_803j "803j. Since giving birth, have you experienced any other major health problems since you gave birth?"
lab var m3_803j_other "803j-Other. Specify any other major health problems since you gave birth"
lab var m3_805 "805. Sometimes a woman can have a problem such that she experiences a constant leakage of urine or stool from her vagina during the day and night. This problem can occur after a difficult childbirth. Since you gave birth have you experienced a constant leakage of urine or stool from your vagina during the day and night?"
lab var m3_806 "806. How many days after giving birth did these symptoms start?"
lab var m3_807 "807. Overall, how much does this problem interfere with your everyday life? Please select a number between 0 (not at all) and 10 (a great deal)."
lab var m3_808a "808a. Have you sought treatment for this condition?"
lab var m3_808b "808b. Why have you not sought treatment?"
lab var m3_808b_other "808b-Other. Specify other reasons why have you not sought treatment"
lab var m3_809 "809. Did the treatment stop the problem?"
lab var m3_901a "901a. Since last spoke, did you get iron or folic acid pills for yourself?"
lab var m3_901b "901b. Since we last spoke, did you get iron injection?"
lab var m3_901c "901c. Since we last spoke, did you get calcium pills?"
lab var m3_901d "901d. Since we last spoke, did you get multivitamins?"
lab var m3_901e "901e. Since we last spoke, did you get food supplements like Super Cereal or Plumpynut?"
lab var m3_901f "901f. Since we last spoke, did you get medicine for intestinal worms [endemic areas]?"
lab var m3_901g "901g. Since we last spoke, did you get medicine for malaria [endemic areas]?"
lab var m3_901h "901h. Since we last spoke, did you get Medicine for HIV?"
lab var m3_901i "901i. Since we last spoke, did you get medicine for your emotions, nerves, depression, or mental health?"
lab var m3_901j "901j. Since we last spoke, did you get medicine for hypertension?"
lab var m3_901k "901k. Since we last spoke, did you get medicine for diabetes, including injections of insulin?"
lab var m3_901l "901l. Since we last spoke, did you get antibiotics for an infection?"
lab var m3_901m "901m. Since we last spoke, did you get aspirin?"
lab var m3_901n "901n. Since we last spoke, did you get paracetamol, or other pain relief drugs?"
lab var m3_901o "901o. Since we last spoke, did you get contraceptive pills?"
lab var m3_901p "901p. Since we last spoke, did you get contraceptive injection?"
lab var m3_901q "901q. Since we last spoke, did you get other contraception method?"
lab var m3_901r "901r. Since we last spoke, did you get any other medicine or supplement?"
lab var m3_901r_other "901r-Other. Specify other treatment you took"
lab var m3_902a_baby1 "902a. Since they were born, did the 1st baby get iron supplements?"
lab var m3_902a_baby2 "902a. Since they were born, did the second baby get iron supplements?"
lab var m3_902b_baby1 "902b. Since they were born, did the 1st baby get Vitamin A supplements?"
lab var m3_902b_baby2 "902b. Since they were born, did the second baby get Vitamin A supplements?"
lab var m3_902c_baby1 "902c. Since they were born, did the 1st baby get Vitamin D supplements?"
lab var m3_902c_baby2 "902c. Since they were born, did the second baby get Vitamin D supplements?"
lab var m3_902d_baby1 "902d. Since they were born, did the 1st baby get Oral rehydration salts?"
lab var m3_902d_baby2 "902d. Since they were born, did the second baby get Oral rehydration salts?"
lab var m3_902e_baby1 "902e. Since they were born, did the 1st baby get antidiarrheal?"
lab var m3_902e_baby2 "902e. Since they were born, did the second baby get antidiarrheal?"
lab var m3_902f_baby1 "902f. Since they were born, did the 1st baby get Antibiotics for an infection?"
lab var m3_902f_baby2 "902f. Since they were born, did the second baby get Antibiotics for an infection?"
lab var m3_902g_baby1 "902g. Since they were born, did the 1st baby get medicine to prevent pneumonia?"
lab var m3_902g_baby2 "902g. Since they were born, did the second baby get medicine to prevent pneumonia?"
lab var m3_902h_baby1 "902h. Since they were born, did the 1st baby get medicine for malaria [endemic areas]?"
lab var m3_902h_baby2 "902h. Since they were born, did the second baby get medicine for malaria [endemic areas]?"
lab var m3_902i_baby1 "902i. Since they were born, did the 1st baby get medicine for HIV (HIV+ mothers only)?"
lab var m3_902i_baby2 "902i. Since they were born, did the second baby get medicine for HIV (HIV+ mothers only)?"
lab var m3_902j_baby1 "902j. Since they were born, did the 1st baby get other medicine or supplement, please specify"
lab var m3_902j_baby1_other "902j-Other-1. Any other medicine or supplement for the 1st baby please specify"
lab var m3_902j_baby2 "902j. Since they were born, did the second baby get other medicine or supplement, please specify"
lab var m3_902j_baby2_other "902j-Other-2. Any other medicine or supplement for the second baby please specify"		
lab var m3_1001 "1001. Overall, taking everything into account, how would you rate the quality of care that you received for your delivery at the facility you delivered at?"
lab var m3_1002 "1002. How likely are you to recommend this provider to a family member or friend for childbirth?"
lab var m3_1003 "1003. Did staff suggest or ask you (or your family or friends) for a bribe, and informal payment or gift?"
label variable m3_1004a "1004a. Thinking about the care you received during labor and delivery, how would you rate the knowledge and skills of your provider?"
label variable m3_1004b "1004b. Thinking about the care you received during labor and delivery, how would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab tests?"
label variable m3_1004c "1004c. Thinking about the care you received during labor and delivery, how would you rate the level of respect the provider showed you?"
label variable m3_1004d "1004d. Thinking about the care you received during labor and delivery, how would you rate clarity of the providers explanations?"
label variable m3_1004e "1004e. Thinking about the care you received during labor and delivery, how would you rate degree to which the provider involved you as much as you wanted to be in decisions about your care?"
label variable m3_1004f "1004f. Thinking about the care you received during labor and delivery, how would you rate amount of time the provider spent with you?"
label variable m3_1004g "1004g. Thinking about the care you received during labor and delivery, how would you rate the amount of time you waited before being seen?"
label variable m3_1004h "1004h. Thinking about the care you received during labor and delivery, how would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider? "
lab var m3_1005a "1005a. During your time at the health facility for labor and delivery, were you pinched by a health worker or other staff?"
lab var m3_1005b "1005b. During your time at the health facility for labor and delivery, were slapped by a health worker or other staff?"
lab var m3_1005c "1005c. During your time at the health facility for labor and delivery, were were physically tied to the bed or held down to the bed forcefully by a health worker or other staff?"
lab var m3_1005d "1005d. During your time at the health facility for labor and delivery, had forceful downward pressure placed on your abdomen before the baby came out?"
lab var m3_1005e "1005e. During your time at the health facility for labor and delivery, were shouted or screamed at by a health worker or other staff?"
lab var m3_1005f "1005f. During your time at the health facility for labor and delivery, were scolded by a health worker or other staff?"
lab var m3_1005g "1005g. During your time at the health facility for labor and delivery, the health worker or other staff member made negative comments to you regarding your sexual activity?"
lab var m3_1005h "1005h. DDuring your time at the health facility for labor and delivery, the health worker or other staff threatened that if you did not comply, you or your baby would have a poor outcome?"
lab var m3_1006a "1006a. During labor and delivery, women sometimes receive a vaginal examination. Did you receive a vaginal examination at any point in the health facility?"
lab var m3_1006b "1006b. Did the health care provider ask permission before performing the vaginal examination?"
lab var m3_1006c "1006c. Were vaginal examinations conducted privately (in a way that other people could not see)?"
lab var m3_1007a "1007a. During your time in the facility, were you offered any form of pain relief?"
lab var m3_1007b "1007b. Did you request pain relief during your time in the facility?"
lab var m3_1007c "1007c. Did you receive pain relief during your time in the facility?"
lab var m3_1101 "1101. I would like to ask you about the cost of the delivery. Did you pay money out of your pocket for the delivery, including for the consultation or other indirect costs like your transport to the facility?"
lab var m3_1102a_amt "1102a. How much money did you spend on registration/consultation?"
lab var m3_1102b_amt "1102b. How much money did you spend on medicine/vaccines (including outside purchase)?"
lab var m3_1102c_amt "1102c. How much money did you spend test/investigations (x-ray, lab etc.)?"
lab var m3_1102d_amt "1102d. How much money did you spend on transport (round trip) including that of person accompanying you?"
lab var m3_1102e_amt "1102e. How much money did you spend money on food and accommodation including that of person accompanying you?"
lab var m3_1102f_amt "1102f. How much money did you spend on other items?"
lab var m3_1102f_oth "1102f-Other. Specify item"
lab var m3_1103 "1103. So in total you spent:_____ Is that correct?"
lab var m3_1105 "1105. Which of the following financial sources did your household use to pay for this?"
lab var m3_1105_other "1105-Other. Other specify"
lab var m3_1106 "1106. To conclude this survey, overall, please tell me how satisfied you are with the health services you received during labor and delivery?" 
lab var m3_1201 "1201. Im sorry to hear you had a miscarriage. If its ok with you I would like to ask a few more questions. When the misrriage occurred, did you go to a health facility for follow-up?"
lab var m3_1202 "1202. Overall, how would you rate the quality of care that you received for your miscarriage?"
lab var m3_1203 "1203. Did you go to a health facility to receive this abortion?"
lab var m3_1204 "1204. Overall, how would you rate the quality of care that you received for your abortion?"
lab var m3_endtime "Time of interview ended"	

*------------------------------------------------------------------------------*
* reshape data from long to wide

drop if respondentid == "1916081238" | respondentid == "21711071310" | respondentid == "21311071736"

sort m3_date
bysort respondentid: gen round3 = _n
	
reshape wide m3_duration m3_date_confirm m3_site m3_county m3_enum_name m3_attempt_number m3_attempt_number_other m3_attempt_outcome m2_maternal_death_reported m2_maternal_death_learn m2_maternal_death_learn_other m3_consent_recording m3_start_p1 m2_202 m3_303a m3_birth_or_ended_provided m3_ga1_ke m3_ga2_ke m3_303b m3_baby1_name m3_baby1_gender m3_baby1_age_weeks m3_baby1_size m3_baby1_weight m3_baby1_health m3_baby1_feeding m3_breastfeeding m3_baby1_sleep m3_baby1_feed m3_baby1_breath m3_baby1_stool m3_baby1_mood m3_baby1_skin m3_baby1_interactivity m3_baby1_born_alive1 m3_baby1_born_alive2 m3_313c_baby1 m3_313d_baby1 m3_death_cause_baby1_other m3_303c m3_baby2_name m3_baby2_gender m3_baby2_age_weeks m3_baby2_size m3_baby2_weight m3_baby2_health m3_baby2_feeding m3_breastfeeding_2 m3_baby2_sleep m3_baby2_feed m3_baby2_breath m3_baby2_stool m3_baby2_mood m3_baby2_skin m3_baby2_interactivity m3_baby2_born_alive1 m3_baby2_born_alive2 m3_313c_baby2 m3_313d_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby4 m3_abortion m3_miscarriage m3_num_alive_babies m3_num_dead_babies bornalive_babies m3_ga_final m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason_other m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke m3_412g_1_other m3_412i_1_ke m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason_other m3_412a_2_ke m3_412b_2_ke m3_412c_2_ke m3_412d_2_ke m3_412e_2_ke m3_412f_2_ke m3_412g_2_ke m3_412g_2_other m3_412i_2_ke m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason_other m3_412a_3_ke m3_412b_3_ke m3_412c_3_ke m3_412d_3_ke m3_412e_3_ke m3_412f_3_ke m3_412g_3_ke m3_412g_3_other m3_412i_3_ke m3_501 m3_503 m3_504a m3_504b m3_504c m3_502 m3_503_final m3_506_pre m3_506_pre_oth m3_508 m3_509 m3_509_other m3_510 m3_511 m3_512_1_ke m3_512_2_ke m3_513a m3_513_outside_zone_other m3_513b2 m3_513b3 m3_513_final m3_514 m3_515 m3_516 m3_517 m3_518 m3_518a_ke m3_518b_ke m3_518c_ke m3_518d_ke m3_518e_ke m3_518f_ke m3_518g_ke m3_518h_ke m3_518i_ke m3_518j_ke m3_518k_ke m3_518_96_ke m3_518_97_ke m3_518_98_ke m3_518_99_ke m3_518_other_complications m3_518_other m3_519 m3_519_other m3_520 m3_521_ke m3_521_ke_unit m2_601 m3_601_hiv m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_605c m3_605c_other m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_612_ke m3_612_ke_unit m3_613 m3_614_ke m3_614_ke_unit m3_615a m3_616c_1 m3_616c_1_unit m3_617a m3_618a_1 m3_618b_1 m3_618c_1 m3_620_1 m3_615b m3_616c_2 m3_616c_2_unit m3_617b m3_618a_2 m3_618b_2 m3_618c_2 m3_620_2 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g m3_619h m3_621a m3_621a_1_ke m3_621a_2_ke m3_621a_3_ke m3_621a_4_ke m3_621a_5_ke m3_621a_6_ke m3_621a_98_ke m3_621a_99_ke m3_621b m3_621c_ke m3_621c_ke_unit m3_622a m3_622b m3_622c m3_701 m3_702 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_707_ke m3_707_ke_unit m3_baby1_issues m3_708_oth_1 m3_708a m3_710a m3_711c_1 m3_711c_1_unit m3_baby2_issues m3_708_oth_2 m3_708b m3_710b m3_711c_2 m3_711c_2_unit m3_801a m3_801b m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803j m3_803j_other m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_901r_other m3_901_cost m3_baby_meds_count m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 m3_902j_baby1_other m3_902_1_cost m3_902a_baby2 m3_902b_baby2 m3_902c_baby2 m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 m3_902i_baby2 m3_902j_baby2 m3_902j_baby2_other m3_902_2_cost m3_1001 m3_1002 m3_1003 m3_1004a m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt m3_1102f_oth m3_1103 m3_1105 m3_1105a_ke m3_1105b_ke m3_1105c_ke m3_1105d_ke m3_1105e_ke m3_1105g_ke m3_1105f_ke m3_1105_96_ke m3_1105_other m3_1106 m3_1201 m3_1202 m3_1203 m3_1204 m3_language m3_language_other m3_start_time m3_endtime m3_datetime_rescheduled m3_506 m3_507 m3_date m2_date_of_maternal_death m3_birth_or_ended m3_313a_baby1 m3_313a_baby2 m2_ga module m2_hiv_status m3_weeks_from_outcome_ke m3_after2weeks_call_ke m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_h m3_baby1_feed_99 m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_h m3_baby2_feed_99 m3_death_cause_baby1 m3_death_cause_baby2 m3_consultation1_reason m3_consultation2_reason m3_consultation3_reason m3_consultation1_reason_a m3_consultation1_reason_b m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e m3_consultation1_reason_96 m3_consultation2_reason_a m3_consultation2_reason_b m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 m3_consultation3_reason_a m3_consultation3_reason_b m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f m3_baby1_issues_98 m3_baby1_issues_99 m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f m3_baby2_issues_98 m3_baby2_issues_99 m3_phq2_score m3_1102_total m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_date_time m3_birth_or_ended_date, i(respondentid) j(round3)

*------------------------------------------------------------------------------*
* merge dataset with M1-M2

merge 1:1 respondentid using "$ke_data_final/eco_m1m2_ke.dta", force

drop _merge

*==============================================================================*
	
	* STEP FIVE: ORDER VARIABLES
	
*drop bornalive_babies m2_maternal_death_reported m2_maternal_death_learn m2_maternal_death_learn_other m2_202 m2_601 m2_date_of_maternal_death m2_ga m2_hiv_status	
	
order m1_* m2_* m3_*, sequential

* Module 1:
order country module respondentid interviewer_id m1_date m1_start_time study_site facility_name ///
      facility_name2 county* permission care_self enrollage dob language* language_oth* ///
	  zone_live zone_live_other b5anc b6anc_first b7eligible m1_noconsent_why_ke ///
	  mobile_phone flash
order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate ///
	  bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic ///
	  bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)
	  
order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)
order edd_chart_ke edd gest_age_baseline_ke, after(m1_803)
order m1_1218_ke, after(m1_1218c_1)
order m1_1218_other_total_ke, after(m1_1218f_1)
order m1_1218_total_ke, after(m1_1218_other_total_ke)	
	
* Module 2:
order m2_attempt_number* m2_attempt_number_other* m2_attempt_outcome* m2_resp_lang1* ///
	  m2_resp_lang2* m2_resp_lang_other* m2_attempt_relationship* m2_attempt_relationship_other*, after(m1_end_time) 
	  
order m2_attempt_avail* m2_attempt_contact* m2_attempt_goodtime* m2_reschedule_resp* m2_completed_attempts*  m2_consent_recording* m2_consent*, after(m2_attempt_relationship_other6)
	  
order m2_date* m2_start_time* m2_date_time* m2_time_start* m2_date_confirm* m2_interviewer* m2_enum* ///
	  m2_site* m2_county* m2_maternal_death_reported* m2_date_of_maternal_death* ///
	  m2_ga* m2_ga_estimate* gest_age_baseline* m2_hiv_status* m2_maternal_death_learn* m2_maternal_death_learn_other*, after(m2_consent_recording6)

order m2_date_of_maternal_death_yesno*, before(m2_date_of_maternal_death6)	  
order m2_refused_why* m2_complete* m2_endtime*, after(m2_705_other6)
order m2_phq2_ke*, after(m2_205b6)	

/* SS: work on this 
* Module 3:
order m3_start_p1 m3_start_time m3_date m3_date_confirm m3_date_time m3_site  m3_datetime_rescheduled m3_birth_or_ended m3_birth_or_ended_provided m3_birth_or_ended_date,before(m3_ga1_ke)
order m3_ga1_ke m3_ga2_ke m3_ga_final m3_weeks_from_outcome_ke m3_after2weeks_call_ke, after(m3_birth_or_ended_date)

order m3_baby1_gender m3_baby2_gender, after(m3_303c)
order m3_baby1_age m3_baby1_age_weeks m3_baby2_age_weeks, after(m3_baby2_gender)
order m3_baby1_weight m3_baby2_weight m3_baby2_weight, after(m3_baby2_age_weeks)
order m3_baby1_size m3_baby2_size m3_baby2_size, after(m3_baby2_weight)
order m3_baby1_health m3_baby2_health, after(m3_baby2_size)
order m3_baby1_feeding m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_h m3_baby1_feed_99, after(m3_baby2_health) 
order m3_baby2_feeding m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_h m3_baby2_feed_99, after(m3_baby1_feed_99)
order m3_breastfeeding m3_breastfeeding_2,after(m3_baby2_feed_99)
order m3_baby1_born_alive1 m3_baby1_born_alive2 m3_baby2_born_alive1 m3_baby2_born_alive2, after(m3_breastfeeding_2)
order m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby4 m3_1201 m3_miscarriage m3_abortion m3_1202, after(m3_313d_baby2)
order m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason m3_consultation1_reason_a m3_consultation1_reason_b m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e  m3_consultation1_reason_96 m3_consultation1_reason_other, after(m3_402) 
order m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason  m3_consultation2_reason_a m3_consultation2_reason_b m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 m3_consultation2_reason_other,after(m3_consultation1_reason_other) 
order m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason  m3_consultation3_reason_a m3_consultation3_reason_b m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 m3_consultation3_reason_other,after(m3_consultation2_reason_other)

order m3_baby1_sleep m3_baby2_sleep, after(m3_622c) 
order m3_baby1_feed m3_baby2_feed, after(m3_baby2_sleep)
order m3_baby1_breath m3_baby2_breath, after(m3_baby2_feed)
order m3_baby1_stool m3_baby2_stool,after(m3_baby2_breath)
order m3_baby1_mood m3_baby2_mood, after(m3_baby2_stool)
order m3_baby1_skin m3_baby2_skin, after(m3_baby2_mood)
order m3_baby1_interactivity m3_baby2_interactivity, after(m3_baby2_skin)

order m3_baby1_issues m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f m3_baby1_issues_98 m3_baby1_issues_99, after(m3_707_ke_unit)

order m3_baby2_issues m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f m3_baby2_issues_98 m3_baby2_issues_99, after(m3_baby1_issues_99)

order m3_phq2_score, after(m3_801b)

order m3_baby_meds_count, after(m3_902j_baby2_other)                    

order m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby4,after(m3_313d_baby2)

order m3_endtime m3_duration, after(m3_1106) 

order m3_num_alive_babies m3_num_dead_babies, after(m3_miscarriage)

*/
*------------------------------------------------------------------------------*
	
	* STEP SIX: SAVE DATA TO RECODED FOLDER

	save "$ke_data_final/eco_m1-m3_ke.dta", replace
	clear all

*===============================================================================
* MODULE 4:	
* Created: February 6, 2024
* Author: Mariia, Emma D.Clarke

* import data
use "$ke_data/Module 4/KEMRI_Module_4_Final.dta",clear

gen module = 4 if q_102 !=. | q_102 !=.a

drop first_name last_name full_name facility_name county enum_name_mod1 enum_name best_phone_resp baby_name_1 baby_label_1 baby_list baby_alive_list baby_died_list alive_babies dead_babies baby_list_dead baby_name_care_1 baby_label_care_1 baby_list_care baby_name_med_1 baby_label_med_1 baby_list_med confirm_phone end_comment endtime

drop phone1 phone2 phone3 phone4 phone_combi name_baby1 name_baby2 name_baby3 name_baby4 reschedule_date_resp name_confirm name_full name_baby_alive1 name_baby_alive2 name_baby_alive3 name_baby_alive4 name_baby_died1 name_baby_died2 name_baby_died3 name_baby_died4 refused_why registered_phone mobile_money_name mobile_prov phone_noavail phone_used phone_used_oth survey1consented_grp1consented1s starttime 

******************************************
* STEP 1: RENAME VARIABLES
******************************************

* Section 1: Identification 
drop time_start_full  text_audit  consent_audio section8_audio mean_sound_level min_sound_level max_sound_level sd_sound_level pct_sound_between0_60 pct_sound_above80 pct_conversation date_survey_baseline today_date date_confirm q_104_calc language_label resp_other_name date_death_knows  baby_repeat_count baby_repeat_count q_203_1  q_206_1 q_603_1  baby_died_group_count new_visits_count new_visits_index_1  care_where_label_1 care_facility_name_label_1 care_reason_reg_label_1  q_406_1 q_406_2 q_406_3 q_411_a_1 q_411_a_2 q_411_a_3 q_905 care_rason_oth_label_1 care_visit_reas_rpt_grp_count_1 care_vis_idx_1_1 care_visit_res_1_1 care_vis_idx_1_2 care_visit_res_1_2 care_vis_idx_1_3 care_visit_res_1_3 care_vis_idx_1_4 care_visit_res_1_4 care_vis_idx_1_5 care_visit_res_1_5 care_vis_idx_1_6 care_visit_res_1_6 care_reason_label_1 new_visits_index_2 care_where_label_2 care_facility_name_label_2 care_reason_reg_label_2 q_406_2 care_rason_oth_label_2 care_visit_reas_rpt_grp_count_2 care_vis_idx_2_1 care_visit_res_2_1 care_vis_idx_2_2 care_visit_res_2_2 care_vis_idx_2_3 care_visit_res_2_3 care_vis_idx_2_4 care_visit_res_2_4 care_vis_idx_2_5 care_visit_res_2_5 care_vis_idx_2_6 care_visit_res_2_6 care_reason_label_2 new_visits_index_3 care_where_label_3 care_facility_name_label_3 care_reason_reg_label_3 care_rason_oth_label_3 care_visit_reas_rpt_grp_count_3 care_vis_idx_3_1 care_visit_res_3_1 care_vis_idx_3_2 care_visit_res_3_2 care_vis_idx_3_3 care_visit_res_3_3 care_vis_idx_3_4 care_visit_res_3_4 care_vis_idx_3_5 care_visit_res_3_5 care_vis_idx_3_6 care_visit_res_3_6 care_reason_label_3 user_experience_rpt_count user_exp_idx_1 user_visit_reason_1 user_facility_type_1 user_facility_name_1 user_exp_idx_2 user_visit_reason_2 user_facility_type_2 user_facility_name_2 baby_repeat_care_count baby_index_care_1 q_801_rand_order_count q_801_rand_1 q_801_rand_2 q_801_rand_3 q_801_rand_4 q_801_rand_5 q_801_rand_6 q_801_rand_7 q_801_rand_8 q_801_rand_9 q_801_rand_10 q_801_rand_11 q_801_rand_12 q_801_rand_13 q_801_rand_14 q_801_rand_15 q_801_rand_16 q_801_order_count baby_repeat_med_count baby_index_med_1 q_902a_cost q_902b_cost q_902c_cost q_902d_cost q_902e_cost total_spent date_after28days reschedule_full_noavail resp_worker availability location_endline	formdef_version key isvalidated reschedule_full_noavail v685 v686 submissiondate v629 v630 baby_index_1	 


*-----according to variable list 
rename q_101 m4_interviewer
rename q_102 m4_date
rename q_103 m4_103
rename  consent m4_start
rename attempts m4_attempt_number
rename attempts_oth m4_attempt_number_other
rename call_response m4_attempt_outcome
rename  resp_language m4_resp_language
rename  resp_language_no m4_resp_language_no
rename  resp_language_no_oth m4_resp_language_no_oth
rename resp_other m4_attempt_relationship
rename resp_other_oth m4_attempt_other
rename  resp_available m4_attempt_avail
rename best_phone_reconfirm m4_attempt_contact
rename resp_available_when m4_attempt_goodtime
rename  intro_yn m4_consent_recording
rename q_104 respondentid
rename  q_109 m4_112
rename  q_110 m4_113 
rename  q_111 m4_114
rename  q_111_oth m4_114_oth
rename hiv_status m4_108
rename c_section m4_c_section
rename live_babies m4_live_babies 
rename date_delivery m4_date_delivery
rename weeks_delivery_mod4 m4_weeks_delivery


* Section 2: Health -- Baby
rename q_201_1 m4_201_1
rename q_202_1 m4_202_1

rename baby_list_numbers m4_number_of_babies
*drop  q_203_1
rename q_203_1_1  m4_203_1_1
rename q_203_2_1  m4_203_1_2
rename q_203_3_1  m4_203_1_3
rename q_203_4_1  m4_203_1_4
rename q_203_5_1  m4_203_1_5
rename q_203_6_1  m4_203_1_6
rename q_203_7_1  m4_203_1_7
rename q_203_99_1  m4_203_1_99

rename q_204_1 m4_204a
rename q_205a_1 m4_205a_1 
rename q_205b_1 m4_205b_1
rename q_205c_1 m4_205c_1
rename q_205d_1 m4_205d_1
rename q_205e_1 m4_205e_1
rename q_205f_1 m4_205f_1
rename q_205g_1 m4_205g_1

*drop q_206_1
*It just combines all the answers from the qestions below, we didn't have it in the Ethiopian Ds and all information coded in the variables below 
rename  q_206_1_1 m4_206a_1
rename  q_206_2_1 m4_206b_1
rename  q_206_3_1 m4_206c_1
rename  q_206_4_1 m4_206d_1
rename  q_206_5_1 m4_206e_1
rename  q_206_6_1 m4_206f_1
rename  q_206_7_1 m4_206g_1
rename  q_206_8_1 m4_206h_1
rename  q_206_9_1 m4_206i_1
rename  q_206_0_1 m4_206none_1
rename  q_207_1 m4_207a_1 
rename  q_207_oth_1 m4_207_1_other  

* Section 3 3. HEALTH – WOMAN
rename  q_301 m4_301
rename  q_302a m4_302a
rename  q_302b m4_302b
rename  q_303a m4_303a
rename  q_303b m4_303b
rename  q_303c m4_303c
rename  q_303d m4_303d
rename  q_303e m4_303e
rename  q_303f m4_303f
rename  q_303g m4_303g
rename  q_303h m4_303h
rename  q_304 m4_304
rename  q_305 m4_305 
rename  q_306 m4_306
rename  q_307 m4_307
rename  q_308 m4_308
rename  q_309 m4_309
rename  q_309_oth m4_309_other 
rename  q_310 m4_310
rename  q_401a m4_401a
rename  q_401b m4_401b
rename  q_402 m4_402  
rename  q_403_1 m4_403a
rename  q_403_2 m4_403b 
rename  q_403_3 m4_403c
rename  q_404_1 m4_404a
rename  q_404_oth_1 m4_404a_other
*in the Ethiopian DS the question about other facilities was divided into in and outside of East Shewa m4_404a_other_1 and m4_404a_other_2. Here it is not divided, so I renamed it only m4_404a_other
rename  q_404_2 m4_404b
rename  q_404_oth_2 m4_404b_other
*in the Ethiopian DS the question about other facilities was divided into in and outside of East Shewa m4_404b_other_1 and m4_404b_other_2. Here it is not divided, so I renamed it only m4_404b_other
rename  q_404_3 m4_404c
rename  q_404_oth_3 m4_404c_other
*in the Ethiopian DS the question about other facilities was divided into in and outside of East Shewa m4_404c_other_1 and m4_404c_other_2. Here it is not divided, so I renamed it only m4_404c_other

rename  q_405_1 m4_405

*drop  q_406_1
 *It just combines all the answers from the qestions below, we didn't have it in the Ethiopian Ds and all information coded in the variables below 
rename  q_406_1_1 m4_406_1
rename  q_406_2_1 m4_406_2
rename  q_406_3_1 m4_406_3
rename  q_406_4_1 m4_406_4
rename  q_406_5_1 m4_406_5
rename  q_406_6_1 m4_406_6
rename  q_406_7_1 m4_406_7
rename  q_406_8_1 m4_406_8
rename  q_406_9_1 m4_406_9
rename  q_406_10_1 m4_406_10
rename  q_406_96_1 m4_406_96
rename  q_406_oth_1 m4_406_other

rename  q_405_2 m4_407


*drop q_406_2
 *It just combines all the answers from the qestions below, we didn't have it in the Ethiopian Ds and all information coded in the variables below
rename  q_406_1_2 m4_408_1
rename  q_406_2_2 m4_408_2
rename  q_406_3_2 m4_408_3
rename  q_406_4_2 m4_408_4
rename  q_406_5_2 m4_408_5
rename  q_406_6_2 m4_408_6
rename  q_406_7_2 m4_408_7
rename  q_406_8_2 m4_408_8
rename  q_406_9_2 m4_408_9
rename  q_406_10_2 m4_408_10
rename  q_406_96_2 m4_408_96
rename  q_406_oth_2 m4_408_other
rename  q_405_3 m4_409

*drop  q_406_3
 *It just combines all the answers from the qestions below, we didn't have it in the Ethiopian Ds and all information coded in the variables below
rename  q_406_1_3 m4_410_1
rename  q_406_2_3 m4_410_2
rename  q_406_3_3 m4_410_3
rename  q_406_4_3 m4_410_4
rename  q_406_5_3 m4_410_5
rename  q_406_6_3 m4_410_6
rename  q_406_7_3 m4_410_7
rename  q_406_8_3 m4_410_8
rename  q_406_9_3 m4_410_9
rename  q_406_10_3 m4_410_10
rename  q_406_96_3 m4_410_96
rename  q_406_oth_3 m4_410_other

rename  q_411a_1 m4_411a
rename  q_411a_2 m4_411b
rename  q_411a_3 m4_411c

rename  q_412a_1 m4_412a
rename  q_412a_2 m4_412b
rename  q_412a_3 m4_412c

rename q_412a_unit_1 m4_412a_unit 
rename q_412a_unit_2 m4_412b_unit
rename q_412a_unit_3 m4_412c_unit

rename  q_411 m4_413
*in Ethiopian DS it was a check box question.
rename  q_411_oth m4_413_other

rename  q_501_1 m4_501

rename  q_501_2 m4_502

rename  q_601a_1 m4_601a_1

rename  q_601b_1 m4_601b_1

rename  q_601c_1 m4_601c_1

rename  q_601d_1 m4_601d_1

rename  q_601e_1 m4_601e_1

rename  q_601f_1 m4_601f_1

rename  q_601g_1 m4_601g_1

rename  q_601h_1 m4_601h_1

rename  q_601i_1 m4_601i_1
rename  q_601i_oth_1 m4_601i_1_other

*Qs about HIV are missing (618)
rename  q_602a_1 m4_602a
rename  q_602b_1 m4_602b
rename  q_602c_1 m4_602c
rename  q_602d_1 m4_602d
rename  q_602e_1 m4_602e
rename  q_602f_1 m4_602f
rename  q_602g_1 m4_602g

*drop  q_603_1
rename  q_603_0_1 m4_603_1_0
rename  q_603_1_1 m4_603_1_1
rename  q_603_2_1 m4_603_1_2
rename  q_603_3_1 m4_603_1_3
rename  q_603_4_1 m4_603_1_4
rename  q_603_5_1 m4_603_1_5
rename  q_603_6_1 m4_603_1_6
rename  q_603_96_1 m4_603_1_96
rename  q_603_98_1 m4_603_1_98
rename  q_603_99_1 m4_603_1_99
rename  q_603_oth_1 m4_603_1_other


rename  q_701a m4_701a
rename  q_701b m4_701b
rename  q_701c m4_701c
rename  q_701d m4_701d
rename  q_701e m4_701e
rename  q_701f m4_701f
rename  q_701g m4_701g
rename  q_701h m4_701h
rename  q_701h_oth m4_701h_other

rename  q_702 m4_702

rename  q_703a m4_703a
rename  q_703b m4_703b
rename  q_703c m4_703c
rename  q_703d m4_703d
rename  q_703e m4_703e
rename  q_703f m4_703f
rename  q_703g m4_703g

rename  q_704a m4_704a
rename  q_704b m4_704b
rename  q_704c m4_704c

*----------create one variable for 801-----------*
 egen m4_801a = rowmax( q_801a_1 q_801a_2 q_801a_3 q_801a_4 q_801a_5 q_801a_6 q_801a_7 q_801a_8 q_801a_9 q_801a_10 q_801a_11 q_801a_12 q_801a_13 q_801a_14 q_801a_15 q_801a_16 )
egen m4_801b = rowmax( q_801b_1 q_801b_2 q_801b_3 q_801b_4 q_801b_5 q_801b_6 q_801b_7 q_801b_8 q_801b_9 q_801b_10 q_801b_11 q_801b_12 q_801b_13 q_801b_14 q_801b_15 q_801b_16)
egen m4_801c = rowmax( q_801c_1 q_801c_2 q_801c_3 q_801c_4 q_801c_5 q_801c_6 q_801c_7 q_801c_8 q_801c_9 q_801c_10 q_801c_11 q_801c_12 q_801c_13 q_801c_14 q_801c_15 q_801c_16)
egen m4_801d = rowmax( q_801d_1 q_801d_2 q_801d_3 q_801d_4 q_801d_5 q_801d_6 q_801d_7 q_801d_8 q_801d_9 q_801d_10 q_801d_11 q_801d_12 q_801d_13 q_801d_14 q_801d_15 q_801d_16)
egen m4_801e = rowmax( q_801e_1 q_801e_2 q_801e_3 q_801e_4 q_801e_5 q_801e_6 q_801e_7 q_801e_8 q_801e_9 q_801e_10 q_801e_11 q_801e_12 q_801e_13 q_801e_14 q_801e_15 q_801e_16)
egen m4_801f = rowmax( q_801f_1 q_801f_2 q_801f_3 q_801f_4 q_801f_5 q_801f_6 q_801f_7 q_801f_8 q_801f_9 q_801f_10 q_801f_11 q_801f_12 q_801f_13 q_801f_14 q_801f_15 q_801f_16)
egen m4_801g = rowmax( q_801g_1 q_801g_2 q_801g_3 q_801g_4 q_801g_5 q_801g_6 q_801g_7 q_801g_8 q_801g_9 q_801g_10 q_801g_11 q_801g_12 q_801g_13 q_801g_14 q_801g_15 q_801g_16)
egen m4_801h = rowmax( q_801h_1 q_801h_2 q_801h_3 q_801h_4 q_801h_5 q_801h_6 q_801h_7 q_801h_8 q_801h_9 q_801h_10 q_801h_11 q_801h_12 q_801h_13 q_801h_14 q_801h_15 q_801h_16)
egen m4_801i = rowmax(q_801i_1 q_801i_2 q_801i_3 q_801i_4 q_801i_5 q_801i_6 q_801i_7 q_801i_8 q_801i_9 q_801i_10 q_801i_11 q_801i_12 q_801i_13 q_801i_14 q_801i_15 q_801i_16)
egen m4_801j = rowmax(q_801j_1 q_801j_2 q_801j_3 q_801j_4 q_801j_5 q_801j_6 q_801j_7 q_801j_8 q_801j_9 q_801j_10 q_801j_11 q_801j_12 q_801j_13 q_801j_14 q_801j_15 q_801j_16)
egen m4_801k = rowmax(q_801k_1 q_801k_2 q_801k_3 q_801k_4 q_801k_5 q_801k_6 q_801k_7 q_801k_8 q_801k_9 q_801k_10 q_801k_11 q_801k_12 q_801k_13 q_801k_14 q_801k_15 q_801k_16)
egen m4_801l = rowmax(q_801l_1 q_801l_2 q_801l_3 q_801l_4 q_801l_5 q_801l_6 q_801l_7 q_801l_8 q_801l_9 q_801l_10 q_801l_11 q_801l_12 q_801l_13 q_801l_14 q_801l_15 q_801l_16)
egen m4_801m = rowmax(q_801m_1 q_801m_2 q_801m_3 q_801m_4 q_801m_5 q_801m_6 q_801m_7 q_801m_8 q_801m_9 q_801m_10 q_801m_11 q_801m_12 q_801m_13 q_801m_14 q_801m_15 q_801m_16)
egen m4_801n = rowmax(q_801n_1 q_801n_2 q_801n_3 q_801n_4 q_801n_5 q_801n_6 q_801n_7 q_801n_8 q_801n_9 q_801n_10 q_801n_11 q_801n_12 q_801n_13 q_801n_14 q_801n_15 q_801n_16)
egen m4_801o = rowmax(q_801o_1 q_801o_2 q_801o_3 q_801o_4 q_801o_5 q_801o_6 q_801o_7 q_801o_8 q_801o_9 q_801o_10 q_801o_11 q_801o_12 q_801o_13 q_801o_14 q_801o_15 q_801o_16)
egen m4_801p = rowmax(q_801p_1 q_801p_2 q_801p_3 q_801p_4 q_801p_5 q_801p_6 q_801p_7 q_801p_8 q_801p_9 q_801p_10 q_801p_11 q_801p_12 q_801p_13 q_801p_14 q_801p_15 q_801p_16)

drop q_801a_1 q_801a_2 q_801a_3 q_801a_4 q_801a_5 q_801a_6 q_801a_7 q_801a_8 q_801a_9 q_801a_10 q_801a_11 q_801a_12 q_801a_13 q_801a_14 q_801a_15 q_801a_16 q_801b_1 q_801b_2 q_801b_3 q_801b_4 q_801b_5 q_801b_6 q_801b_7 q_801b_8 q_801b_9 q_801b_10 q_801b_11 q_801b_12 q_801b_13 q_801b_14 q_801b_15 q_801b_16 q_801c_1 q_801c_2 q_801c_3 q_801c_4 q_801c_5 q_801c_6 q_801c_7 q_801c_8 q_801c_9 q_801c_10 q_801c_11 q_801c_12 q_801c_13 q_801c_14 q_801c_15 q_801c_16 q_801d_1 q_801d_2 q_801d_3 q_801d_4 q_801d_5 q_801d_6 q_801d_7 q_801d_8 q_801d_9 q_801d_10 q_801d_11 q_801d_12 q_801d_13 q_801d_14 q_801d_15 q_801d_16 q_801e_1 q_801e_2 q_801e_3 q_801e_4 q_801e_5 q_801e_6 q_801e_7 q_801e_8 q_801e_9 q_801e_10 q_801e_11 q_801e_12 q_801e_13 q_801e_14 q_801e_15 q_801e_16 q_801f_1 q_801f_2 q_801f_3 q_801f_4 q_801f_5 q_801f_6 q_801f_7 q_801f_8 q_801f_9 q_801f_10 q_801f_11 q_801f_12 q_801f_13 q_801f_14 q_801f_15 q_801f_16  q_801g_1 q_801g_2 q_801g_3 q_801g_4 q_801g_5 q_801g_6 q_801g_7 q_801g_8 q_801g_9 q_801g_10 q_801g_11 q_801g_12 q_801g_13 q_801g_14 q_801g_15 q_801g_16 q_801h_1 q_801h_2 q_801h_3 q_801h_4 q_801h_5 q_801h_6 q_801h_7 q_801h_8 q_801h_9 q_801h_10 q_801h_11 q_801h_12 q_801h_13 q_801h_14 q_801h_15 q_801h_16 q_801i_1 q_801i_2 q_801i_3 q_801i_4 q_801i_5 q_801i_6 q_801i_7 q_801i_8 q_801i_9 q_801i_10 q_801i_11 q_801i_12 q_801i_13 q_801i_14 q_801i_15 q_801i_16 q_801j_1 q_801j_2 q_801j_3 q_801j_4 q_801j_5 q_801j_6 q_801j_7 q_801j_8 q_801j_9 q_801j_10 q_801j_11 q_801j_12 q_801j_13 q_801j_14 q_801j_15 q_801j_16 q_801k_1 q_801k_2 q_801k_3 q_801k_4 q_801k_5 q_801k_6 q_801k_7 q_801k_8 q_801k_9 q_801k_10 q_801k_11 q_801k_12 q_801k_13 q_801k_14 q_801k_15 q_801k_16 q_801l_1 q_801l_2 q_801l_3 q_801l_4 q_801l_5 q_801l_6 q_801l_7 q_801l_8 q_801l_9 q_801l_10 q_801l_11 q_801l_12 q_801l_13 q_801l_14 q_801l_15 q_801l_16 q_801m_1 q_801m_2 q_801m_3 q_801m_4 q_801m_5 q_801m_6 q_801m_7 q_801m_8 q_801m_9 q_801m_10 q_801m_11 q_801m_12 q_801m_13 q_801m_14 q_801m_15 q_801m_16 q_801n_1 q_801n_2 q_801n_3 q_801n_4 q_801n_5 q_801n_6 q_801n_7 q_801n_8 q_801n_9 q_801n_10 q_801n_11 q_801n_12 q_801n_13 q_801n_14 q_801n_15 q_801n_16 q_801o_1 q_801o_2 q_801o_3 q_801o_4 q_801o_5 q_801o_6 q_801o_7 q_801o_8 q_801o_9 q_801o_10 q_801o_11 q_801o_12 q_801o_13 q_801o_14 q_801o_15 q_801o_16 q_801p_1 q_801p_2 q_801p_3 q_801p_4 q_801p_5 q_801p_6 q_801p_7 q_801p_8 q_801p_9 q_801p_10 q_801p_11 q_801p_12 q_801p_13 q_801p_14 q_801p_15 q_801p_16
*----------------------------------------------*

rename q_801q m4_801q
rename q_801r m4_801r
rename q_801r_oth m4_801r_other 

rename  q_802a_1 m4_802a_1
rename  q_802b_1 m4_802b_1
rename  q_802c_1 m4_802c_1
rename  q_802d_1 m4_802d_1
*I skipped 802e while in Ethiopian Ds this Q was about antiseptic ointment, but here the Q is about antidiarrheal drugs. 
rename  q_802f_1 m4_802f_1
rename  q_802g_1 m4_802g_1
rename  q_802h_1 m4_802h_1
rename  q_802i_1 m4_802i_1
rename  q_802j_1 m4_802j_1
rename  q_802j_oth_1 m4_802j_1_other
rename  q_802e_1 m4_802k_1

rename  q_803a_1 m4_803a_1
rename  q_803b_1 m4_803b_1
rename  q_803c_1 m4_803c_1
rename  q_803d_1 m4_803d_1
rename  q_803e_1 m4_803e_1
rename  q_803f_1 m4_803f_1
rename  q_803f_oth_1 m4_803g_1
rename  q_804_1 m4_804_1
rename   q_804_oth_1 m4_804_1_specify

rename  q_805 m4_805

rename  q_901 m4_901 

rename  q_902a m4_902a_amn
rename  q_902b m4_902b_amn
rename  q_902c m4_902c_amn
rename  q_902d m4_902d_amn
rename  q_902e m4_902e_amn
rename  q_902e_oth m4_902e_oth
rename  q_903 m4_903

rename  q_904 m4_904

*drop  q_905
*It just combines all the answers from the qestions below, we didn't have it in the Ethiopian Ds and all information coded in the variables below
rename  q_905_1 m4_905_1
rename  q_905_2 m4_905_2
rename  q_905_3 m4_905_3
rename  q_905_4 m4_905_4
rename  q_905_5 m4_905_5
rename  q_905_6 m4_905_6
rename  q_905_96 m4_905_96
rename  q_905_oth m4_905_other 

rename  final_note_alive m4_conclusion_live_babies

rename  duration m4_duration
rename language m4_language 
rename  language_oth m4_language_oth 
rename unavailable_reschedule m4_unavailable_reschedule
rename call_status m4_call_status
rename reschedule_resp m4_reschedule_resp
rename  reschedule_noavail m4_reschedule_noavail
*****************************************
* STEP 2: ADD VALUE LABELS
******************************************
* Define labels
label drop _all
label define yesno 0 "No" 1 "Yes"
* Section 1: Identification
label define call_response 1 "Answered the phone, correct respondent", add
label define call_response 2 "Answered, but not by the respondent", add
label define call_response 3 "No answer (rings but no response or line was busy)", add
label define call_response 4 "Number does not work (does not ring/connect to a phone)", add
label define call_response 5 "Phone was switched off", add
label values  m4_attempt_outcome call_response

label define communicate 1 "Yes, I can communicate" 2 "No, they speak a language foreign to me" 
label values m4_resp_language communicate
label define language 1 "English", add
label define language 2 "Kiswahili", add
label define language 3 "Kikuyu", add
label define language 4 "Kamba", add
label define language -96 "Other, specify", add
label values m4_language language
label values m4_resp_language_no language


label define respondent 1 "Family member", add
label define respondent 2 "Friend/Neighbor", add
label define respondent 3 "Colleague", add
label define respondent 4 "Doesn't know the respondent", add
label define respondent -96 "Other, specify", add
label values m4_attempt_relationship respondent 

label define status 1 "Completed", add
label define status 2 "Answered, but not completed", add
label define status 3 "Answered, but not by the respondent", add
label define status 4 "No answer/unreachable", add
label define status 5 "Refusal", add
label define status 7 "Answered, but unable to communicate with the respondent because of language barrier", add
label define status 8 "Completed with Maternal death", add
label define status 9 "Line out of service", add
label values m4_call_status status

label define resp_communicate 1 "Yes, I can communicate", add
label define resp_communicate 0 "No, they speak a language foreign to me", add
label values m4_resp_language resp_communicate

label define hiv_status 1 "Positive" 0 "Negative" 3 "Result not shared"
generate m4_108_new = real(m4_108)
drop m4_108
rename m4_108_new m4_108
label values m4_108  hiv_status

generate m4_c_section_new = real(m4_c_section)
drop m4_c_section
rename m4_c_section_new m4_c_section
label values  m4_c_section yesno
* the labels are from Ethiopian DS, not from Kenyan
*I can't find labels to this Q (was it in a different module?)
 label values m4_attempt_avail yesno
 label values  m4_112 yesno
 
 label define learn_death 1 "Called respondent phone, someone else responded" 2 "Called spouse/partner phone, was informed" 3 "Called close friend or family member phone number, was informed" 4 " Called CHW phone number, was informed " 96 "Other, specify"
label values  m4_114 learn_death
label values  m4_attempt_contact yesno
label values  m4_attempt_goodtime yesno  
label values  m4_consent_recording  yesno
label values  m4_start   yesno   

* Section 2: Health -- Baby
label define baby_now 1 "Alive" 0 "Died"
label values  m4_201_1 baby_now

label define good_bad 1 "Excellent", add
label define good_bad 2 "Very good", add
label define good_bad 3 "Good", add
label define good_bad 4 "Fair", add
label define good_bad 5 "Poor", add
label values m4_202_1 good_bad

label define checked 0 "Unchecked" 1 "Checked" 

generate m4_203_1_1_new = real(m4_203_1_1)
generate m4_203_1_2_new = real(m4_203_1_2)
generate m4_203_1_3_new = real(m4_203_1_3)
generate m4_203_1_4_new = real(m4_203_1_4)
generate m4_203_1_5_new = real(m4_203_1_5)
generate m4_203_1_6_new = real(m4_203_1_6)
generate m4_203_1_7_new = real(m4_203_1_7)
generate m4_203_1_99_new = real(m4_203_1_99)

drop m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 m4_203_1_99

rename m4_203_1_1_new m4_203_1_1
rename m4_203_1_2_new m4_203_1_2
rename m4_203_1_3_new m4_203_1_3
rename m4_203_1_4_new m4_203_1_4
rename m4_203_1_5_new m4_203_1_5
rename m4_203_1_6_new m4_203_1_6
rename m4_203_1_7_new m4_203_1_7
rename m4_203_1_99_new m4_203_1_99

foreach var of varlist m4_203_1_1 -  m4_203_1_99  {
                 label values `var' checked
          }

label define confident 1 "Not at all confident", add
label define confident 2 "Not very confident", add
label define confident 3 "Somewhat confident", add
label define confident 4 "Confident", add
label define confident 5 "Very confident", add
label values  m4_204a  confident

label define sleep 1 "Sleeps well", add
label define sleep 2 "Slightly affected sleep", add
label define sleep 3 "Moderately affected sleep", add
label define sleep 4 "Severely disturbed sleep", add
label values  m4_205a_1 sleep

label define feeding 1 "Normal feeding", add
label define feeding 2 "Slight feeding problems", add
label define feeding 3 "Moderate feeding problems", add
label define feeding 4 "Severe feeding problems", add
label values  m4_205b_1 feeding 

label define breathing 1 "Normal breathing", add
label define breathing 2 "Slight breathing problems", add
label define breathing 3 "Moderate breathing problems", add
label define breathing 4 "Severe breathing problems", add
label values  m4_205c_1 breathing

label define stooling 1 "Normal stooling/poo", add
label define stooling 2 "Slight stooling/poo problems", add
label define stooling 3 "Moderate stooling/poo problems", add
label define stooling 4 "Severe stooling/poo problems", add
label values  m4_205d_1 stooling

label define mood 1 "Happy/content", add
label define mood 2 "Fussy/irritable", add
label define mood 3 "Crying", add
label define mood 4 "Inconsolable crying", add
label values  m4_205e_1 mood

label define skin 1 "Normal skin", add
label define skin 2 "Dry or red skin", add
label define skin 3 "Irritated or itchy skin", add
label define skin 4 "Bleeding or cracked skin", add
label values  m4_205f_1 skin

label define interactivity 1 "Highly playful/interactive", add
label define interactivity 2 "Playful/interactive", add
label define interactivity 3 "Less playful/less interactive", add
label define interactivity 4 "Low energy/inactive/dull", add
label values  m4_205g_1 interactivity

generate m4_206a_1_new = real(m4_206a_1)
generate m4_206b_1_new = real(m4_206b_1)
generate m4_206c_1_new = real(m4_206c_1)
generate m4_206d_1_new = real(m4_206d_1)
generate m4_206e_1_new = real(m4_206e_1)
generate m4_206f_1_new = real(m4_206f_1)
generate m4_206g_1_new = real(m4_206g_1)
generate m4_206h_1_new = real(m4_206h_1)
generate m4_206i_1_new = real(m4_206i_1)
generate m4_206none_1_new = real(m4_206none_1)
generate m4_603_1_0_new = real(m4_603_1_0)
generate m4_603_1_1_new = real(m4_603_1_1)
generate m4_603_1_2_new = real(m4_603_1_2)
generate m4_603_1_3_new = real(m4_603_1_3)
generate m4_603_1_4_new = real(m4_603_1_4)
generate m4_603_1_5_new = real(m4_603_1_5)
generate m4_603_1_6_new = real(m4_603_1_6)
generate m4_603_1_96_new = real(m4_603_1_96)
generate m4_603_1_98_new = real(m4_603_1_98)
generate m4_603_1_99_new = real(m4_603_1_99)

drop m4_206a_1 m4_206b_1 m4_206c_1 m4_206d_1 m4_206e_1 m4_206f_1 m4_206g_1 m4_206h_1 m4_206i_1 m4_206none_1 m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 m4_603_1_98 m4_603_1_99

rename m4_206a_1_new m4_206a_1
rename m4_206b_1_new m4_206b_1
rename m4_206c_1_new m4_206c_1
rename  m4_206d_1_new m4_206d_1
rename  m4_206e_1_new m4_206e_1
rename  m4_206f_1_new m4_206f_1
rename  m4_206g_1_new m4_206g_1
rename  m4_206h_1_new m4_206h_1
rename  m4_206i_1_new m4_206i_1
rename  m4_206none_1_new m4_206none_1
rename  m4_603_1_0_new m4_603_1_0
rename  m4_603_1_1_new m4_603_1_1
rename  m4_603_1_2_new m4_603_1_2
rename  m4_603_1_3_new m4_603_1_3
rename  m4_603_1_4_new m4_603_1_4
rename  m4_603_1_5_new m4_603_1_5 
rename  m4_603_1_6_new m4_603_1_6
rename  m4_603_1_96_new m4_603_1_96
rename  m4_603_1_98_new m4_603_1_98
rename  m4_603_1_99_new m4_603_1_99

foreach var of varlist m4_206a_1 -   m4_603_1_99   {
                 label values `var' checked
          }

label values  m4_207a_1 yesno

*- Can't find this variables,  there were no cases of death and maybe that's why they are not in ths DS
label define cause_death 0 "Not told anything ", add
label define cause_death 1 "The baby was premature (born too early)", add
label define cause_death 2 "A birth injury or asphyxia (occuring because of delivery complication)", add
label define cause_death 3 "A congenital abnomality (genetic or acquired issues with growth/development)", add
label define cause_death 4 "Malaria", add
label define cause_death 5 "An acute respiratory infection", add
label define cause_death 6 "Diarrhea", add
label define cause_death 7 "Another type of infection", add
label define cause_death 8 "Severe acute malnutrition", add
label define cause_death 9 "An accident or injury", add
label define cause_death 96 "Another cause (specify)", add

label define death_location 1 "In a health facility", add
label define death_location 2 "On the way to the health facility ", add
label define death_location 3 "Your house or someone else's house ", add
label define death_location 4 "Other, please specify", add
*--------------Section 2: Women health---------------*
label define good_bad_2 1 "Excellent", add
label define good_bad_2 2 "Very good", add
label define good_bad_2 3 "Good", add
label define good_bad_2 4 "Fair", add
label define good_bad_2 5 "Poor", add
label values  m4_301 good_bad_2

label define howmanydays 0 "None of the days", add
label define howmanydays 1 "Several days", add
label define howmanydays 2 "More than half the days (>7)", add
label define howmanydays 3 "Nearly every day ", add
label values m4_302a howmanydays
label values  m4_302b howmanydays

label define extent 1 "Very much", add
label define extent 2 "A lot", add
label define extent 3 "A little", add
label define extent 4 "Not at all", add
foreach var of varlist m4_303a -   m4_303h   {
                 label values `var' extent
          }

label define how_much 0 "Have not had sex", add
label define how_much 1 "Not at all", add
label define how_much 2 "A little bit", add
label define how_much 3 "Somewhat", add
label define how_much 4 "Quite a bit", add
label define how_much 5 "Very much", add
label values  m4_304 how_much
label values m4_305 yesno

label define how_often 0 "Never", add
label define how_often 1 "Less than once per month", add
label define how_often 2 "Less than once/week & greater than once/month", add
label define how_often 3 "Less than once/day & greater than once/month", add
label define how_often 4 "Once a day or more than once a day", add
label values  m4_307 how_often
label values  m4_308 yesno

label define no_treatment 1 "Do not know it can be fixed", add
label define no_treatment 2 "You tried but were sent away (e.g., no appointment available)", add
label define no_treatment 3 "High cost (e.g., high out of pocket payment, not covered by insurance)", add
label define no_treatment 4 "Far distance (e.g., too far to walk or drive, transport not readily available)", add
label define no_treatment 5 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)", add
label define no_treatment 6 "Staff don't show respect (e.g., staff is rude, impolite, dismissive)", add
label define no_treatment 7 "Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)", add
label define no_treatment 8 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)", add
label define no_treatment 9 "COVID-19 fear", add
label define no_treatment 10 "Don't know where to go/too complicated", add
label define no_treatment 11 "Could not get permission", add
label define no_treatment 12 "Embarrassment", add
label define no_treatment 13 "Problem disappeared", add
label define no_treatment 96 "Other (specify)", add
label values  m4_309 no_treatment

label define yesno_leak 1 "Yes, no more leakage at all", add
label define yesno_leak 2 "Yes, but still some leakage", add
label define yesno_leak 3 "No, still have problem", add
label values  m4_310 yesno_leak

label values  m4_401a  yesno
label values  m4_401b  yesno

label define m4_402 1 "One" 2 "Two" 3 "Three" 
label values m4_402 m4_402

replace m4_403a = 12 if m4_403a== 5
replace m4_403a = 13 if m4_403a== 6 
replace m4_403a = 6 if m4_403a== 7 
replace m4_403a = 7 if m4_403a== 8
replace m4_403a = 10 if m4_403a== 9 

replace m4_403b = 12 if m4_403b== 5
replace m4_403b = 13 if m4_403b== 6 
replace m4_403b = 6 if m4_403b== 7 
replace m4_403b = 7 if m4_403b== 8
replace m4_403b = 10 if m4_403b== 9 

replace m4_403c = 12 if m4_403c== 5
replace m4_403c = 13 if m4_403c== 6 
replace m4_403c = 6 if m4_403c== 7 
replace m4_403c = 7 if m4_403c== 8
replace m4_403c = 10 if m4_403c== 9 

label define facility 1 "In your home ", add
label define facility 2 "Someone else's home ", add
label define facility 3 "Government hospital", add
label define facility 4 "Government health center", add
label define facility 5 "Government health post", add
label define facility 6 " NGO or faith-based health facility", add
label define facility 7 "Private hospital", add
label define facility 8 " Private specialty maternity center", add
label define facility 9 "Private specialty maternity clinic", add
label define facility 10 "Private clinic", add
label define facility 11 "Another private medical facility (including pharmacy, shop, traditional healer) ", add
label define facility 12 "Goverment dispensary", add
label define facility 13 "Other public ficility", add
label values m4_403a facility
label values m4_403b facility
label values m4_403c facility

* It was changed according to Ethiopian DS 

replace m4_404a = 24 if m4_404a== 1
replace m4_404a = 25 if m4_404a== 2 
replace m4_404a = 26 if m4_404a== 3 
replace m4_404a = 27 if m4_404a== 4
replace m4_404a = 28 if m4_404a== 5 
replace m4_404a = 29 if m4_404a== 6
replace m4_404a = 30 if m4_404a== 7 
replace m4_404a = 31 if m4_404a== 8 
replace m4_404a = 32 if m4_404a== 9
replace m4_404a = 33 if m4_404a== 10 
replace m4_404a = 34 if m4_404a== 11
replace m4_404a = 35 if m4_404a== 12 
replace m4_404a = 36 if m4_404a== 13 
replace m4_404a = 37 if m4_404a== 14
replace m4_404a = 38 if m4_404a== 15 
replace m4_404a = 39 if m4_404a== 16
replace m4_404a = 40 if m4_404a== 17 
replace m4_404a = 41 if m4_404a== 18 
replace m4_404a = 42 if m4_404a== 19
replace m4_404a = 43 if m4_404a== 20 
replace m4_404a = 44 if m4_404a== 21
replace m4_404a = 45 if m4_404a== 22 

replace m4_404b = 24 if m4_404b== 1
replace m4_404b = 25 if m4_404b== 2 
replace m4_404b = 26 if m4_404b== 3 
replace m4_404b = 27 if m4_404b== 4
replace m4_404b = 28 if m4_404b== 5 
replace m4_404b = 29 if m4_404b== 6
replace m4_404b = 30 if m4_404b== 7 
replace m4_404b = 31 if m4_404b== 8 
replace m4_404b = 32 if m4_404b== 9
replace m4_404b = 33 if m4_404b== 10 
replace m4_404b = 34 if m4_404b== 11
replace m4_404b = 35 if m4_404b== 12 
replace m4_404b = 36 if m4_404b== 13 
replace m4_404b = 37 if m4_404b== 14
replace m4_404b = 38 if m4_404b== 15 
replace m4_404b = 39 if m4_404b== 16
replace m4_404b = 40 if m4_404b== 17 
replace m4_404b = 41 if m4_404b== 18 
replace m4_404b = 42 if m4_404b== 19
replace m4_404b = 43 if m4_404b== 20 
replace m4_404b = 44 if m4_404b== 21
replace m4_404b = 45 if m4_404b== 22 

replace m4_404c = 24 if m4_404c== 1
replace m4_404c = 25 if m4_404c== 2 
replace m4_404c = 26 if m4_404c== 3 
replace m4_404c = 27 if m4_404c== 4
replace m4_404c = 28 if m4_404c== 5 
replace m4_404c = 29 if m4_404c== 6
replace m4_404c = 30 if m4_404c== 7 
replace m4_404c = 31 if m4_404c== 8 
replace m4_404c = 32 if m4_404c== 9
replace m4_404c = 33 if m4_404c== 10 
replace m4_404c = 34 if m4_404c== 11
replace m4_404c = 35 if m4_404c== 12 
replace m4_404c = 36 if m4_404c== 13 
replace m4_404c = 37 if m4_404c== 14
replace m4_404c = 38 if m4_404c== 15 
replace m4_404c = 39 if m4_404c== 16
replace m4_404c = 40 if m4_404c== 17 
replace m4_404c = 41 if m4_404c== 18 
replace m4_404c = 42 if m4_404c== 19
replace m4_404c = 43 if m4_404c== 20 
replace m4_404c = 44 if m4_404c== 21
replace m4_404c = 45 if m4_404c== 22 

label define facility_name 24 "Githunguri health centre", add
label define facility_name 25 "Wangige Sub-County Hospital", add
label define facility_name 26 "Makongeni dispensary", add
label define facility_name 27 "Igegania sub district hospital", add
label define facility_name 28 "Kiambu County referral hospital", add
label define facility_name 29 "Plainsview nursing home", add
label define facility_name 30 "Sunview maternity and nursing home", add
label define facility_name 31 "Kalimoni mission hospital", add
label define facility_name 32 "Mercylite hospital", add
label define facility_name 33 "Mulango (AIC) Health Centre", add
label define facility_name 34 "Kitui County Referral Hospital", add
label define facility_name 35 "Neema Hospital", add
label define facility_name 36 "Kisasi Health Centre (Kitui Rural)", add
label define facility_name 37 "Ikutha Sub County Hospital", add
label define facility_name 38 "Our Lady of Lourdes Mutomo Hospital", add
label define facility_name 39 "Kauwi Sub County Hospital", add
label define facility_name 40 "Muthale Mission Hospital", add
label define facility_name 41 "Nuu Sub County Hospital", add
label define facility_name 42 "Waita Health Centre", add
label define facility_name 43 "Katse Health Centre", add
label define facility_name 44 "Ngomeni Health Centre", add
label define facility_name 45 "St. Teresas Nursing Home", add
label define facility_name 96 "Other (specify)", add
label values  m4_404a facility_name
label values  m4_404b facility_name
label values  m4_404c facility_name
label values  m4_405 yesno
* It was changed according to Ethiopian DS

generate m4_406_1_destr = real(m4_406_1)
generate m4_406_2_destr = real(m4_406_2)
generate m4_406_3_destr = real(m4_406_3)
generate m4_406_4_destr = real(m4_406_4)
generate m4_406_5_destr = real(m4_406_5)
generate m4_406_6_destr = real(m4_406_6)
generate m4_406_7_destr = real(m4_406_7)
generate m4_406_8_destr = real(m4_406_8)
generate m4_406_9_destr = real(m4_406_9)
generate m4_406_10_destr = real(m4_406_10)
generate m4_406_96_destr = real(m4_406_96)

drop m4_406_1 m4_406_2 m4_406_3 m4_406_4 m4_406_5 m4_406_6 m4_406_7 m4_406_8 m4_406_9 m4_406_10 m4_406_96

rename m4_406_1_destr  m4_406_1
rename  m4_406_2_destr m4_406_2
rename  m4_406_3_destr m4_406_3
rename  m4_406_4_destr m4_406_4
rename  m4_406_5_destr m4_406_5
rename m4_406_6_destr  m4_406_6
rename  m4_406_7_destr m4_406_7
rename  m4_406_8_destr m4_406_8
rename  m4_406_9_destr m4_406_9
rename  m4_406_10_destr m4_406_10
rename m4_406_96_destr m4_406_96

foreach var of varlist  m4_406_1 - m4_406_96  {
                 label values `var' checked
				 }
	 			 
label values  m4_407 yesno				 
			 
generate m4_408_1_destr = real(m4_408_1)
generate m4_408_2_destr = real(m4_408_2)
generate m4_408_3_destr = real(m4_408_3)
generate m4_408_4_destr = real(m4_408_4)
generate m4_408_5_destr = real(m4_408_5)
generate m4_408_6_destr = real(m4_408_6)
generate m4_408_7_destr = real(m4_408_7)
generate m4_408_8_destr = real(m4_408_8)
generate m4_408_9_destr = real(m4_408_9)
generate m4_408_10_destr = real(m4_408_10)
generate m4_408_96_destr = real(m4_408_96)

drop m4_408_1 m4_408_2 m4_408_3 m4_408_4 m4_408_5 m4_408_6 m4_408_7 m4_408_8 m4_408_9 m4_408_10 m4_408_96

rename m4_408_1_destr  m4_408_1
rename  m4_408_2_destr m4_408_2
rename  m4_408_3_destr m4_408_3
rename  m4_408_4_destr m4_408_4
rename  m4_408_5_destr m4_408_5
rename m4_408_6_destr  m4_408_6
rename  m4_408_7_destr m4_408_7
rename  m4_408_8_destr m4_408_8
rename  m4_408_9_destr m4_408_9
rename  m4_408_10_destr m4_408_10
rename m4_408_96_destr m4_408_96
				 
foreach var of varlist  m4_408_1 -  m4_408_96  {
                 label values `var' checked
				 }				 
			 
label values m4_409 yesno

generate m4_410_1_destr = real(m4_410_1)
generate m4_410_2_destr = real(m4_410_2)
generate m4_410_3_destr = real(m4_410_3)
generate m4_410_4_destr = real(m4_410_4)
generate m4_410_5_destr = real(m4_410_5)
generate m4_410_6_destr = real(m4_410_6)
generate m4_410_7_destr = real(m4_410_7)
generate m4_410_8_destr = real(m4_410_8)
generate m4_410_9_destr = real(m4_410_9)
generate m4_410_10_destr = real(m4_410_10)
generate m4_410_96_destr = real(m4_410_96)
drop  m4_410_1 m4_410_2 m4_410_3 m4_410_4 m4_410_5 m4_410_6 m4_410_7 m4_410_8 m4_410_9 m4_410_10 m4_410_96

rename m4_410_1_destr m4_410_1
rename m4_410_2_destr m4_410_2
rename m4_410_3_destr m4_410_3
rename m4_410_4_destr  m4_410_4
rename m4_410_5_destr m4_410_5
rename m4_410_6_destr m4_410_6
rename m4_410_7_destr m4_410_7
rename m4_410_8_destr m4_410_8
rename m4_410_9_destr m4_410_9
rename m4_410_10_destr m4_410_10
rename m4_410_96_destr m4_410_96
			 
foreach var of varlist  m4_410_1 -  m4_410_96  {
                 label values `var' checked
				 }				 	

label define unit 1 "Weeks", add
label define unit 2 "Days", add
label values m4_412a_unit unit 
label values m4_412b_unit unit
label values m4_412c_unit unit

label define no_care 0 "No reason or the baby and I didn't need it", add
label define no_care 1 "You tried but were sent away (e.g., no appointment available)", add
label define no_care 2 "High cost (e.g., high out of pocket payment, not covered by insurance)", add
label define no_care 3 "Far distance (e.g., too far to walk or drive, transport not readily available)", add
label define no_care 4 "Long waiting time (e.g., long line to access facility, long wait for the provider)", add
label define no_care 5 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)", add
label define no_care 6 "Staff don't show respect (e.g., staff is rude, impolite, dismissive)", add
label define no_care 7 "Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)", add
label define no_care 8 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)", add
label define no_care 9 "COVID-19 fear", add
label define no_care 10 "Don't know where to go/too complicated", add
label define no_care 11 "Fear of discovering serious problem", add
label define no_care 12 "Next PNC visit is scheduled", add
label define no_care 96 "Other", add
label values  m4_413 no_care

label values m4_501 good_bad_2
label values m4_502 good_bad_2

foreach var of varlist  m4_601a_1 -  m4_601i_1  {
                 label values `var' yesno 
				 }	


foreach var of varlist  m4_602a  -  m4_602g   {
                 label values `var' yesno 
				 }	

foreach var of varlist  m4_701a  -  m4_701h   {
                 label values `var' yesno 
				 }

foreach var of varlist  m4_702  -  m4_704a   {
                 label values `var' yesno 
				 }				 

foreach var of varlist  m4_801a  -  m4_801p   {
                 label values `var' yesno 
				 }
label values  m4_801q yesno
label values  m4_801r yesno	
foreach var of varlist  m4_802a_1  -  m4_802j_1   {
                 label values `var' yesno 
				 }	
foreach var of varlist  m4_803a_1  -  m4_803f_1   {
                 label values `var' yesno 
				 }					 

label define where 1 "At home", add
label define where 2 "At a facility *****", add
label define where 3 "At another location", add
label values  m4_804_1 where
label values  m4_901 yesno
label values  m4_903 yesno

foreach var of varlist   m4_905_1  -  m4_905_96    {
                 label values `var' yesno 
				 }		

label values m4_conclusion_live_babies yesno
label values m4_reschedule_resp yesno
label values m4_unavailable_reschedule yesno

******************************************
* STEP 3: RECODE MISSING VARIABLES
******************************************

*recoding of NR/RF to .r
 
recode m4_202_1 m4_204a  m4_206a_1 m4_206b_1  m4_206c_1 m4_206d_1 m4_206e_1 m4_206f_1  m4_206g_1 m4_206h_1 m4_206i_1 m4_206none_1 m4_207a_1  (99 = .r )

recode m4_204a (96 = .a) if m4_204a == 96

*recoding of DK to .d
recode m4_204a m4_206a_1 m4_206b_1 m4_206c_1 m4_206d_1 m4_206e_1 m4_206f_1 m4_206g_1 m4_206h_1 m4_206i_1 m4_206none_1 m4_207a_1 ( 98 = .d)
* 0 changes made 

*Check box questions  
recode m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 ( . = .r) if m4_203_1_99 == 1
* 0 changes made 
drop m4_203_1_99

*---------- Section 3: Health - Woman ----------*
*recoding of NR/RF to .r
recode m4_301 m4_302a m4_302b m4_303a m4_303b m4_303c m4_303d m4_303e m4_303f m4_303g m4_303h m4_304 m4_309 m4_310 m4_401a m4_401b m4_402  m4_403a m4_403b m4_403c m4_404a m4_404b m4_404c m4_405 m4_407 m4_409 m4_413 m4_501 m4_502 m4_601a_1 m4_601b_1 m4_601c_1 m4_601d_1 m4_601e_1 m4_601f_1 m4_601g_1 m4_601h_1 m4_601i_1 m4_602a m4_602b m4_602c m4_602d m4_602e m4_602f m4_602g m4_701a m4_701b m4_701c m4_701d m4_701e m4_701f m4_701g m4_701h m4_702 m4_703a m4_703b m4_703c m4_703d m4_703e m4_703f m4_703g m4_704a m4_801a m4_801b m4_801c m4_801d m4_801e m4_801f m4_801g m4_801h m4_801i m4_801j m4_801k m4_801l m4_801m m4_801n m4_801o m4_801p m4_801q m4_801r  m4_802a_1 m4_802b_1 m4_802c_1 m4_802d_1 m4_802f_1 m4_802g_1 m4_802h_1 m4_802i_1 m4_802j_1 m4_803a_1 m4_803b_1 m4_803c_1 m4_803d_1 m4_803e_1 m4_803f_1 m4_901 (99 = .r )

 *recoding of DK to .d
recode m4_301 m4_302a m4_302b  m4_303a m4_303b m4_303c m4_303d m4_303e m4_303f m4_303g m4_303h m4_304 m4_401a m4_401b m4_403a m4_403b m4_403c m4_404a m4_404b m4_404c m4_405 m4_407 m4_409 m4_501 m4_502 m4_601a_1 m4_601b_1 m4_601c_1 m4_601d_1 m4_601e_1 m4_601f_1 m4_601g_1 m4_601h_1 m4_601i_1 m4_602a m4_602b m4_602c m4_602d m4_602e m4_602f m4_602g m4_701a m4_701b m4_701c m4_701d m4_701e m4_701f m4_701g m4_701h m4_702 m4_703a m4_703b m4_703c m4_703d m4_703e m4_703f m4_703g m4_704a m4_801a m4_801b m4_801c m4_801d m4_801e m4_801f m4_801g m4_801h m4_801i m4_801j m4_801k m4_801l m4_801m m4_801n m4_801o m4_801p m4_801q m4_801r m4_802a_1 m4_802b_1 m4_802c_1 m4_802d_1 m4_802f_1 m4_802g_1 m4_802h_1 m4_802i_1 m4_802j_1 m4_803a_1 m4_803b_1 m4_803c_1 m4_803d_1 m4_803e_1 m4_803f_1 m4_901 (98 = .d)
*-Check box questions 
recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (. = .d) if  m4_603_1_98 == 1
recode  m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3 m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96 (. = .r) if  m4_603_1_99 == 1
drop m4_603_1_98 m4_603_1_99

*----------------------------------------------*
 *Qs about urine leakage (if the participants don't have leakage the next questions about symptoms and treatment are recoded to.a)
 recode m4_306 m4_307 m4_308 m4_309 m4_310  (. = .a) if m4_305 == 0
 
  *Qs about cost of the healthcare visits (if the participants didn't pay any other extra money, the next questions about the cost are recoded to .a)
 recode  m4_902a_amn m4_902b_amn  m4_902c_amn m4_902d_amn m4_902e_amn m4_903 m4_904 (. = .a) if m4_901 == 0 
 
recode m4_905_1 m4_905_2 m4_905_3 m4_905_4 m4_905_5 m4_905_6 m4_905_96 (. = .a) if m4_901==0
*---------------------------------------------*
*Qs about the number of consultation 
recode m4_402 m4_403a m4_403b m4_403c m4_404a m4_404b   m4_404c  m4_405  m4_407 m4_409 m4_412a m4_412a_unit m4_412b m4_412b_unit m4_412c m4_412c_unit m4_501 m4_502 (. = .a) if m4_401a == 0 

recode m4_406_1  m4_406_2 m4_406_3 m4_406_4 m4_406_5 m4_406_6 m4_406_7 m4_406_8 m4_406_9 m4_406_10 m4_406_96 m4_408_1 m4_408_2 m4_408_3 m4_408_4 m4_408_5 m4_408_6 m4_408_7 m4_408_8 m4_408_9 m4_408_10 m4_408_96 m4_410_1 m4_410_2 m4_410_3 m4_410_4 m4_410_5 m4_410_6 m4_410_7 m4_410_8 m4_410_9 m4_410_10 m4_410_96 (. = .a) if m4_401a == 0 
* if they didn't have any consultations

recode m4_403b m4_403c m4_404b m4_404c m4_407 m4_409 m4_412b m4_412c m4_502 (. = .a) if m4_402 == 1
*if they had only 1 consultation, questions about 2 nd and 3rd consultation will be recoded to .a
recode m4_408_1 m4_408_2 m4_408_3 m4_408_4 m4_408_5 m4_408_6 m4_408_7 m4_408_8 m4_408_9 m4_408_10 m4_408_96 m4_410_1 m4_410_2 m4_410_3 m4_410_4 m4_410_5 m4_410_6 m4_410_7 m4_410_8 m4_410_9 m4_410_10 m4_410_96 (. = .a) if m4_402 == 1
* if they had only 1 consultation questions about 2 nd and 3rd consultation will be recoded to .a

recode m4_403c m4_404c m4_409 m4_412c  (.=.a) if m4_402 == 2
recode m4_410_1 m4_410_2 m4_410_3 m4_410_4 m4_410_5 m4_410_6 m4_410_7 m4_410_8 m4_410_9 m4_410_10 m4_410_96 (. = .a) if m4_402 == 2
* if they had only2 consultations 
*-----------------------------------------------*
******************************************
* STEP 4: LABEL VARIABLES
******************************************
*---------------------Identification-------------------------*
label variable m4_date "102. Date of interview"
label variable m4_103 "103. Time of interview"
label variable m4_duration "Total Survey Duration"
label variable m4_interviewer "Enumerator's name"
label variable respondentid "Module 4: Record ID"
label variable m4_108 "108. HIV status" 
label variable  m4_c_section "Cesarean section"
label variable  m4_live_babies "Number of alive babies"
label variable  m4_date_delivery "Date of delivery"
label variable m4_weeks_delivery "Weeks between delivery date and today"
label variable m4_attempt_number "Which attempt is this at calling the respondent "
label variable m4_attempt_number_other "Other attempt. Specify"
label variable m4_attempt_outcome  "CALL TRACKING: What was the outcome of the call?"
label variable m4_resp_language "Are you able to communicate with the respondent(language)?"
label variable m4_resp_language_no "CALL TRACKING:Which language does the respondent speak?"
label variable m4_resp_language_no_oth "Other language, specify"
label variable m4_attempt_relationship "CALL TRACKING:What is the relationship between the owner of this phone and ___ ?"
label variable m4_attempt_other  "CALL TRACKING:  Specify other relationship with the respondent"
label variable m4_attempt_avail "CALL TRACKING: Can you pass the phone to the respondent?"
label variable m4_112 "112. Maternal death reported"
label variable m4_113 "113. Date of maternal death"
label variable m4_114  "114. How did you learn about the maternal death?"
label variable m4_114_oth "114. Other ways of learning about meternal death (specify)"
label variable m4_attempt_contact "CALL TRACKING:Is this still the best contact to reach a respondent?"
label variable m4_attempt_goodtime "CALL TRACKING:Do you know when would be a good time to reach a respondent?"
label variable  m4_start "May I proceed with the interview?"
label variable m4_reschedule_resp "Would you let me know at which date and time the respondent will be available?"
label variable  m4_number_of_babies "Please indicate how many babies do you have"

*----------Child health---------------*
label variable m4_201_1 "201. Is the 1st baby still alive, or did something else happen?"
label variable m4_202_1 "202. How would you rate 1st baby's overall health?"
label variable m4_203_1_1 "203.Did you feed your baby breast milk in the last 7 days?"
label variable m4_203_1_2 "203. Did you feed your baby FORMULA in the last 7 days?"
label variable m4_203_1_3 "203.Did you feed your baby WATER in the last 7 days?"
label variable m4_203_1_4 "203.Did you feed your baby JUICE in the last 7 days?"
label variable m4_203_1_5 "203.Did you feed your baby BROTH in the last 7 days?"
label variable m4_203_1_6 "203.Did you feed your baby BABY FOOD in the last 7 days?"
label variable m4_203_1_7 "203.Did you feed your baby LOCAL FOOD in the last 7 days?"
label variable m4_204a "204. How confident do you feel about breastfeeding your baby?" 
label variable m4_205a_1"205.Regarding sleep, which response best describes your 1st baby today?"
label variable m4_205b_1"205.Regarding feeding, which response best describes your 1st baby today?"
label variable m4_205c_1"205.Regarding breathing, which response best describes your 1st baby today?"
label variable m4_205d_1"205.Regarding stooling/poo, which response best describes your 1st baby today?"
label variable m4_205e_1"205.Regarding their mood, which response best describes your 1st baby today?"
label variable m4_205f_1"205.Regarding their skin, which response best describes your 1st baby today?"
label variable m4_205g_1"205.Regarding their interactivity, which response best describes your 1st baby today?"

label variable m4_206a_1 "206.Did your 1st baby experience Diarrhea with blood in the stools?"
label variable m4_206b_1 "206. Did your 1st baby experience a fever (a temperature > 37.5C)?"
label variable m4_206c_1 "206. Did your 1st baby experience a low temperature(< 35.5C)?"
label variable m4_206d_1 "206. Did your 1st baby experience an illness with a cough?"
label variable m4_206e_1 "206.Did 1st baby experience trouble or fast breathing with short rapid breaths?"
label variable m4_206f_1 "206. Did your 1st baby experience a problem in the chest?"
label variable m4_206g_1 "206. Did your 1st baby experience trouble feeding?"
label variable m4_206h_1 "206. Did your 1st baby experience convulsions?"
label variable m4_206i_1 "206. Did your 1st baby experience Jaundice (that is, yellow colour of the skin)?"
label variable  m4_206none_1 "206.Did your 1st baby experience none of the above? "
label variable m4_207a_1 "207. Did your 1st baby experience any other health problems?"
label variable m4_207_1_other "207. Specify any other problem on your 1st baby."
*---------------- Section 3: Health - Woman -------*
label variable m4_301 "301. In general, how would you rate your overall health?"
label variable m4_302a "302A.How long were you bothered little interest or pleasure in doing things?"
label variable m4_302b "302B.How long were you bothered feeling down,depressed,hopeless in doing things?"
label variable m4_303a "303A.What best describes how you have felt about your baby loving?"
label variable m4_303b "303B.How you have felt about your baby resentful?"
label variable m4_303c "303C.How have felt about your baby neutral or felt nothing?"
label variable m4_303d "303D.How have you felt about your baby joyful?"
label variable m4_303e "303E. How have felt about your baby dislike?"
label variable m4_303f "303F. How have felt about your baby protective?"
label variable m4_303g "303G. How have felt about your baby disappointed?"
label variable m4_303h "303H. How have felt about your baby aggressive?"
label variable m4_304 "304.How much has pain affected your satisfaction with your sex life?"
label variable m4_305 "305.Have you experienced a constant leakage of urine or stool?"
 label variable m4_306 "306. How many days after giving birth did these symptoms start?"
label variable m4_307 "307. How much does this problem alter your lifestyle or daily activities?"
label variable m4_308 "308. Have you sought treatment for this condition?"
label variable m4_309 "309. Why have you not sought treatment?  tick all that apply"
label variable m4_309_other "309-other. Other reason, specify."
label variable m4_310 "310. Did the treatment stop the problem?"
label variable m4_401a "401A.Did you or your baby have any new health care consultations?"
label variable m4_401b "401B.Did you have any new health care consultations?"
label variable m4_402 "402.How many new healthcare consultations did you have?"
label variable m4_403a "403A.Where did this new 1st healthcare consultation for 1st baby take place?"
label variable m4_403b "403B.Where did this new 2nd  healthcare consultation for 1st baby take place?"
label variable m4_403c "403C.Where did this new 3rd  healthcare consultation for 1st baby take place?"
label variable m4_404a "404A.What is the name of the facility for the 1st consultation for 1st baby?"
label variable m4_404a_other "404A-other. Specify other facility for the 1st consultation for your 1st baby?"
label variable m4_404b "404B. What is the name of the facility for the 2nd consultation for 1st baby?"
label variable m4_404b_other "404B-other. Specify other facility for the 2nd consultation for 1st baby?"
label variable m4_404c "404C.What is the name of the facility for the 3rd consultation for your 1st baby?"
label variable m4_404c_other "404C-other. Specify other facility for the 3rd consultation for your 1st baby?"
label variable m4_405 "405.Was the 1st consultation for a routine/regular checkup after the delivery?"
label variable m4_406_1 "406.Was the 1st consultation a new health problem for the baby,emergency/injury?"
label variable m4_406_2 "406.Was the 1st consultation a new health problem for yourself,emergency/injury?"
label variable m4_406_3 "406.Was the 1st consultation for an existing health problem for the baby?"
label variable m4_406_4 "406.Was this 1st consultation for an existing health problem for yourself?"
label variable m4_406_5 "406.Was this 1st consultation for a lab test, x-ray, ultrasound for yourself?"
label variable m4_406_6 "406. Was this 1st consultation for a lab test, x-ray, ultrasound for the baby?"
label variable m4_406_7 "406.Was this 1st consultation for getting a vaccine for the baby?"
label variable m4_406_8 "406.Was this 1st consultation for getting a vaccine for yourself?"
label variable m4_406_9 "406.Was this 1st consultation for getting medicine for yourself?"
label variable m4_406_10 "406.Was this 1st consultation for  getting medicine for the baby?"
label variable m4_406_96 "406. Was this 1st consultation for any other reasons?"
label variable m4_406_other "406-Other.Specify other reasons why the 1st consultation was."
label variable m4_407 "407.Was the 2nd consultation for a routine or regular checkup after the delivery?"
label variable m4_408_1 "408.Was the 2 consultation for new health problem for the baby,emergency/injury"
label variable m4_408_2 "408.Was 2nd consultation for a new health problem for yourself,emergency/injury?"
label variable m4_408_3 "408. Was the 2nd consultation for an existing health problem for the baby?"
label variable m4_408_4 "408. Was this 2nd consultation for an existing health problem for yourself?"
label variable m4_408_5 "408. Was this 2nd consultation for a lab test, x-ray,ultrasound for yourself?"
label variable m4_408_6 "408. Was this 2nd consultation for a lab test, x-ray,ultrasound for the baby?"
label variable m4_408_7 "408. Was this 2nd consultation for getting a vaccine for the baby?"
label variable m4_408_8 "408. Was this 2nd consultation for getting a vaccine for yourself?"
label variable m4_408_9 "408. Was this 2nd consultation for  getting medicine for yourself?"
label variable m4_408_10 "408. Was this 2nd consultation for  getting medicine for the baby?"
label variable m4_408_96 "408. Was this 2nd consultation for any other reasons?"
label variable m4_408_other "408-Other. Specify other reason why the 2nd consultation was"
label variable m4_409 "409.Was the 3rd new consultation for a routine/regular checkup after thedelivery?"
label variable m4_410_1 "410.Was 3rd consultation for a new health problem for the baby,emergency/injury?"
label variable m4_410_2 "410. Was 3rd consultation for a new health problem for yourself,emergency/injury?"
label variable m4_410_3 "410.Was the 3rd consultation for an existing health problem for the baby?"
label variable m4_410_4 "410.Was this 3rd consultation for an existing health problem for yourself?"
label variable m4_410_5 "410. Was this 3rd consultation for a lab test, x-ray,ultrasound for yourself?"
label variable m4_410_6 "410. Was this 3rd consultation for a lab test, x-ray,ultrasound for the baby?"
label variable m4_410_7 "410. Was this 3rd consultation for for getting a vaccine for the baby?"
label variable m4_410_8 "410. Was this 3rd consultation for for getting a vaccine for yourself?"
label variable m4_410_9 "410. Was this 3rd consultation for getting medicine for yourself?"
label variable m4_410_10 "410. Was this 3rd consultation for getting medicine for the baby?"
label variable m4_410_96 "410. Was this 3rd consultation for any other reasons? "
label variable m4_410_other "510-Other. Specify other reason why the 3rd consultation was"

label variable m4_411a "411A. On what day did the 1st new consultation take place? (D-M-Y) ?"
label variable m4_411b "411B. On what day did the 2nd new consultation take place? (D-M-Y) ?"
label variable m4_411c "411C. On what day did the 3rd new consultation take place? (D-M-Y) ?"

label variable m4_412a "412A. How long after the delivery did this 1st new visit take place?"
label variable m4_412b "412B. How long after the delivery did this 2nd new visit take place?"
label variable m4_412c "412C. How long after the delivery did this 3rd new visit take place?"
label variable m4_412a_unit "412A. Please specify unit for the 1st new consultation?"
label variable m4_412b_unit "412B. Please specify unit for the 2nd new consultation?"
label variable m4_412c_unit "412C. Please specify unit for the 3rd new consultation?"

label variable m4_413 "413.Reasons that prevented you from receiving postnatal/postpartum care?"
label variable m4_413_other "413-O.Specify what prevented you from receiving postnatal/postpartum care."
label variable m4_501 "501. Rate the quality of care that you received at the 1st consultation"
label variable m4_502 "502. Rate the quality of care that you received at the 2nd new consultation"

label variable m4_601a_1 "601A.1. Did your 1st baby receive their temperature taken(using a thermometer)?"
label variable m4_601b_1 "601B.1. Did your 1st baby receive their weight taken (with a scale)?"
label variable m4_601c_1 "601C.1. Did your 1st baby receive their length measured (using a measuring tape)?"
label variable m4_601d_1 "601D.1. Did your 1st baby receive their eyes examined?"
label variable m4_601e_1 "601E.1. Did your 1st baby receive their hearing checked?"
label variable m4_601f_1 "601F.1.Did your 1st baby receive his/her chest listened to with a stethoscope?"
label variable m4_601g_1 "601G.1.Did your 1st baby receive a blood test using a finger prick?"
label variable m4_601h_1 "601H.1. Did your 1st baby receive a malaria test?"
label variable m4_601i_1 "601I.1. Did your 1st baby receive any other test?"
label variable m4_601i_1_other "601I.1-other.Please specify any other test your 1st baby receive?"
label variable m4_602a "602A. Did you discuss with a health care provider about how often the baby eats?"
label variable m4_602b "602B.Did you discuss with a health care provider about what the baby should eat?"
label variable m4_602c "602C. Did you discuss with a health care provider about vaccinations for baby?"
label variable m4_602d "602D. Did you discuss with a health careprovider position the baby should sleep in?"
label variable m4_602e "602E.Did you discuss about danger signs you should watch out for/go to hospital?"
label variable m4_602f "602F.Did you discuss with a HCP about how you should play and interact with baby?"
label variable m4_602g "602G.Did you discuss with HCP about that you should take the baby to the hospital?"
label variable m4_603_1_0 "603.1. I did not speak about signs of emergency with a health care provider"
label variable m4_603_1_1 "603.1.Provider said that signs of emergency were not serious,nothing can be done"
label variable m4_603_1_2 "603.1. Provider said to monitor the baby and come back if it gets worse"
label variable m4_603_1_3 "603.1.Provider told you to get medication"
label variable m4_603_1_4 "603.1.Provider gave you advice on feeding" 
label variable m4_603_1_5 "603.1.Provider told you to get a lab test or imaging for the baby (blood tests,ultrasound,x-ray, heart echo)" 
label variable m4_603_1_6 "603.1.Provider said to go to hospital to see specialist,pediatrician/neonatologist" 
label variable m4_603_1_96 "603.1. Other, specify" 
label variable m4_603_1_other "603.1-other. Specify other thing your health care provider did"
label variable m4_701a "701A. Did you receive your blood pressure measured (with a cuff around your arm)?"
label variable m4_701b "701B.Did you receive your temperature taken (with a thermometer)?"
label variable m4_701c "701C. Since the delivery, did you receive a vaginal exam?"
label variable m4_701d "701D. Since the delivery, did you receive a blood draw?"
label variable m4_701e "701E. Since the delivery, did you receive a blood test using a finger prick?"
label variable m4_701f "701F. Since the delivery, did you receive an HIV test?"
label variable m4_701g "701G. Since the delivery, did you receive a urine test?"
label variable m4_701h "701H. Since the delivery, did you receive any other test or examination?"
label variable m4_701h_other "701H-other. Specify any other test you received since the delivery."
label variable m4_702 "702. Since the delivery, did a health care provider examine your c-section scar?"
label variable m4_703a "703A.Did you discuss how to take care of your breasts with healthcare provider?"
label variable m4_703b "703B.Did you receive danger signs you should watch out for in yourself?"
label variable m4_703c "703C. Since the delivery, did you receive your level of anxiety or depression?"
label variable m4_703d "703D.Did you receive your family planning options after the delivery?"
label variable m4_703e "703E.Did you receive  resuming sexual activity after birth?"
label variable m4_703f "703F.Did you receive the importance of exercise after giving birth?"
label variable m4_703g "703G.Did you receive the importance of sleeping under a bed net?"
label variable m4_704a "704A.Did you have a session of psychological counseling or therapy?"
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
label variable m4_802b_1 "802B_1. Did your 1st baby get Vitamin A supplements?"
label variable m4_802c_1 "802C_1. Did your 1st baby get Vitamin D supplements?"
label variable m4_802d_1 "802D_1. Did your 1st baby get Oral rehydration salts?"
label variable m4_802k_1 "802E_1. Did your 1st baby get Antidiarrheal medicine?"
label variable m4_802f_1 "802F_1. Did your 1st baby get antibiotics ?"
label variable m4_802g_1 "802G_1. Did your 1st baby get medicine to prevent pneumonia ?"
label variable m4_802h_1 "802H_1. Did your 1st baby get Medicine for malaria [endemic areas]?"
label variable m4_802i_1 "802I_1. Did your 1st baby get Medicine for HIV [HIV+ mothers only]?"
label variable m4_802j_1 "802J_1. Did your 1st baby get any other medicine or supplement?"
label variable m4_802j_1_other "802J_1_other.Specify any other medicine/supplement for your 1st baby." 
label variable m4_803a_1 "803A_1. Did your 1st baby get a vaccine for BCG against tuberculosis"
label variable m4_803b_1 "803B_1.Did your 1st baby get a vaccine against polio that is taken orally?"
label variable m4_803c_1 "803C_1.Did your 1st baby get a pentavalent vaccination?"
label variable m4_803d_1 "803D_1.Did your 1st baby get a pneumococcal vaccination?"
label variable m4_803e_1 "803E_1.Did your 1st baby get a rotavirus vaccination?"
label variable m4_803f_1 "803F_1. Did your 1st baby get any other vaccines or immunizations?"
label variable m4_803g_1 "803G_1. Specify any other vaccine or  immunization your 1st baby got."
label variable m4_804_1 "804_1. Where did your 1st get these vaccines?"
label variable  m4_804_1_specify "804_1. Please specify where did your 1st baby get them"
label variable m4_805 "805. In total, how much did you pay for medications/supplements/vaccines?"
label variable m4_901 "901. Did you pay any money out of your pocket for these new visits?"
label variable m4_902a_amn "902A_amn. How much money did you spend on registration?"
label variable m4_902b_amn "902B_amn. How much money did you spend on investigations(lab tests,ultrasound)?"
label variable m4_902c_amn "902C_amn. How much money did you spend on Transport?"
label variable m4_902d_amn "902D_amn. How much money did you spend on Food and accommodation?"
label variable m4_902e_amn "902E_amn. How much money did you spend on other things?"
label variable m4_902e_oth "902E. Please specify what other services or products you spent money on"
label variable m4_903 "903. So how much in total would you say you spent? ___is that correct?"
label variable m4_904 "904. So how much in total would you say you spent?"
label variable m4_905_1 "905. Did you use current income of any household members to pay for this ?"
label variable m4_905_2 "905. Did you use savings to pay for this?"
label variable m4_905_3 "905. Did you use payment/reimbursement from a health insurance plan?"
label variable m4_905_4 "905. Did you sold items to pay for this?"
label variable m4_905_5 "905.Did you use family members/friends from outside the household to pay for it?"
label variable m4_905_6 "905. Did you use borrowed money(from someone other than a friend or family)?"
label variable m4_905_96 "905. Other financial sources to pay for this?"
label variable m4_905_other "905-other. Specify other sources of financial source."

label variable m4_conclusion_live_babies "CONCLUSION FOR WOMEN WITH LIVE BABIES"
label variable  place "Enter place for the endline in-person survey."
*label variable  refused_why "Why are you unwilling to participate in the study?" // SS: rename m3_refused_why
label variable  m4_call_status "Enumerator's report of the call'"
label variable  m4_language "In which language was most of the survey conducted?"
label variable  m4_language_oth "Other language, specify:"
label variable m4_reschedule_noavail "When would you like to reschedule the survey?"
label variable  m4_unavailable_reschedule "Would you be interested in rescheduling this survey to another day and time?"

*------------------------------------------------------------------------------*
* reshape data from long to wide

drop if respondentid == "1916081238" | respondentid == "21711071310" | respondentid == "21311071736"

sort m4_date
bysort respondentid: gen round4 = _n
	
reshape wide m3_duration m3_date_confirm m3_site m3_county m3_enum_name m3_attempt_number m3_attempt_number_other m3_attempt_outcome m2_maternal_death_reported m2_maternal_death_learn m2_maternal_death_learn_other m3_consent_recording m3_start_p1 m2_202 m3_303a m3_birth_or_ended_provided m3_ga1_ke m3_ga2_ke m3_303b m3_baby1_name m3_baby1_gender m3_baby1_age_weeks m3_baby1_size m3_baby1_weight m3_baby1_health m3_baby1_feeding m3_breastfeeding m3_baby1_sleep m3_baby1_feed m3_baby1_breath m3_baby1_stool m3_baby1_mood m3_baby1_skin m3_baby1_interactivity m3_baby1_born_alive1 m3_baby1_born_alive2 m3_313c_baby1 m3_313d_baby1 m3_death_cause_baby1_other m3_303c m3_baby2_name m3_baby2_gender m3_baby2_age_weeks m3_baby2_size m3_baby2_weight m3_baby2_health m3_baby2_feeding m3_breastfeeding_2 m3_baby2_sleep m3_baby2_feed m3_baby2_breath m3_baby2_stool m3_baby2_mood m3_baby2_skin m3_baby2_interactivity m3_baby2_born_alive1 m3_baby2_born_alive2 m3_313c_baby2 m3_313d_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby4 m3_abortion m3_miscarriage m3_num_alive_babies m3_num_dead_babies bornalive_babies m3_ga_final m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason_other m3_412a_1_ke m3_412b_1_ke m3_412c_1_ke m3_412d_1_ke m3_412e_1_ke m3_412f_1_ke m3_412g_1_ke m3_412g_1_other m3_412i_1_ke m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason_other m3_412a_2_ke m3_412b_2_ke m3_412c_2_ke m3_412d_2_ke m3_412e_2_ke m3_412f_2_ke m3_412g_2_ke m3_412g_2_other m3_412i_2_ke m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason_other m3_412a_3_ke m3_412b_3_ke m3_412c_3_ke m3_412d_3_ke m3_412e_3_ke m3_412f_3_ke m3_412g_3_ke m3_412g_3_other m3_412i_3_ke m3_501 m3_503 m3_504a m3_504b m3_504c m3_502 m3_503_final m3_506_pre m3_506_pre_oth m3_508 m3_509 m3_509_other m3_510 m3_511 m3_512_1_ke m3_512_2_ke m3_513a m3_513_outside_zone_other m3_513b2 m3_513b3 m3_513_final m3_514 m3_515 m3_516 m3_517 m3_518 m3_518a_ke m3_518b_ke m3_518c_ke m3_518d_ke m3_518e_ke m3_518f_ke m3_518g_ke m3_518h_ke m3_518i_ke m3_518j_ke m3_518k_ke m3_518_96_ke m3_518_97_ke m3_518_98_ke m3_518_99_ke m3_518_other_complications m3_518_other m3_519 m3_519_other m3_520 m3_521_ke m3_521_ke_unit m2_601 m3_601_hiv m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_605c m3_605c_other m3_606 m3_607 m3_608 m3_609 m3_610a m3_610b m3_611 m3_612_ke m3_612_ke_unit m3_613 m3_614_ke m3_614_ke_unit m3_615a m3_616c_1 m3_616c_1_unit m3_617a m3_618a_1 m3_618b_1 m3_618c_1 m3_620_1 m3_615b m3_616c_2 m3_616c_2_unit m3_617b m3_618a_2 m3_618b_2 m3_618c_2 m3_620_2 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g m3_619h m3_621a m3_621a_1_ke m3_621a_2_ke m3_621a_3_ke m3_621a_4_ke m3_621a_5_ke m3_621a_6_ke m3_621a_98_ke m3_621a_99_ke m3_621b m3_621c_ke m3_621c_ke_unit m3_622a m3_622b m3_622c m3_701 m3_702 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_707_ke m3_707_ke_unit m3_baby1_issues m3_708_oth_1 m3_708a m3_710a m3_711c_1 m3_711c_1_unit m3_baby2_issues m3_708_oth_2 m3_708b m3_710b m3_711c_2 m3_711c_2_unit m3_801a m3_801b m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803j m3_803j_other m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_901r_other m3_901_cost m3_baby_meds_count m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 m3_902j_baby1_other m3_902_1_cost m3_902a_baby2 m3_902b_baby2 m3_902c_baby2 m3_902d_baby2 m3_902e_baby2 m3_902f_baby2 m3_902g_baby2 m3_902h_baby2 m3_902i_baby2 m3_902j_baby2 m3_902j_baby2_other m3_902_2_cost m3_1001 m3_1002 m3_1003 m3_1004a m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt m3_1102f_oth m3_1103 m3_1105 m3_1105a_ke m3_1105b_ke m3_1105c_ke m3_1105d_ke m3_1105e_ke m3_1105g_ke m3_1105f_ke m3_1105_96_ke m3_1105_other m3_1106 m3_1201 m3_1202 m3_1203 m3_1204 m3_language m3_language_other m3_start_time m3_endtime m3_datetime_rescheduled m3_506 m3_507 m3_date m2_date_of_maternal_death m3_birth_or_ended m3_313a_baby1 m3_313a_baby2 m2_ga module m2_hiv_status m3_weeks_from_outcome_ke m3_after2weeks_call_ke m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_h m3_baby1_feed_99 m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_h m3_baby2_feed_99 m3_death_cause_baby1 m3_death_cause_baby2 m3_consultation1_reason m3_consultation2_reason m3_consultation3_reason m3_consultation1_reason_a m3_consultation1_reason_b m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e m3_consultation1_reason_96 m3_consultation2_reason_a m3_consultation2_reason_b m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 m3_consultation3_reason_a m3_consultation3_reason_b m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f m3_baby1_issues_98 m3_baby1_issues_99 m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f m3_baby2_issues_98 m3_baby2_issues_99 m3_phq2_score m3_1102_total m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_date_time m3_birth_or_ended_date, i(respondentid) j(round4)

*------------------------------------------------------------------------------*
* merge dataset with M1-M2

merge 1:1 respondentid using "$ke_data_final/eco_m1-m3_ke.dta", force

drop _merge

*==============================================================================*
	
	* STEP FIVE: ORDER VARIABLES
	
*drop bornalive_babies m2_maternal_death_reported m2_maternal_death_learn m2_maternal_death_learn_other m2_202 m2_601 m2_date_of_maternal_death m2_ga m2_hiv_status	
	
order m1_* m2_* m3_*, sequential

* Module 1:
order country module respondentid interviewer_id m1_date m1_start_time study_site facility_name ///
      facility_name2 county* permission care_self enrollage dob language* language_oth* ///
	  zone_live zone_live_other b5anc b6anc_first b7eligible m1_noconsent_why_ke ///
	  mobile_phone flash
order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate ///
	  bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic ///
	  bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)
	  
order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)
order edd_chart_ke edd gest_age_baseline_ke, after(m1_803)
order m1_1218_ke, after(m1_1218c_1)
order m1_1218_other_total_ke, after(m1_1218f_1)
order m1_1218_total_ke, after(m1_1218_other_total_ke)	
	
* Module 2:
order m2_attempt_number* m2_attempt_number_other* m2_attempt_outcome* m2_resp_lang1* ///
	  m2_resp_lang2* m2_resp_lang_other* m2_attempt_relationship* m2_attempt_relationship_other*, after(m1_end_time) 
	  
order m2_attempt_avail* m2_attempt_contact* m2_attempt_goodtime* m2_reschedule_resp* m2_completed_attempts*  m2_consent_recording* m2_consent*, after(m2_attempt_relationship_other6)
	  
order m2_date* m2_start_time* m2_date_time* m2_time_start* m2_date_confirm* m2_interviewer* m2_enum* ///
	  m2_site* m2_county* m2_maternal_death_reported* m2_date_of_maternal_death* ///
	  m2_ga* m2_ga_estimate* gest_age_baseline* m2_hiv_status* m2_maternal_death_learn* m2_maternal_death_learn_other*, after(m2_consent_recording6)

order m2_date_of_maternal_death_yesno*, before(m2_date_of_maternal_death6)	  
order m2_refused_why* m2_complete* m2_endtime*, after(m2_705_other6)
order m2_phq2_ke*, after(m2_205b6)	

/* SS: work on this 
* Module 3:
order m3_start_p1 m3_start_time m3_date m3_date_confirm m3_date_time m3_site  m3_datetime_rescheduled m3_birth_or_ended m3_birth_or_ended_provided m3_birth_or_ended_date,before(m3_ga1_ke)
order m3_ga1_ke m3_ga2_ke m3_ga_final m3_weeks_from_outcome_ke m3_after2weeks_call_ke, after(m3_birth_or_ended_date)

order m3_baby1_gender m3_baby2_gender, after(m3_303c)
order m3_baby1_age m3_baby1_age_weeks m3_baby2_age_weeks, after(m3_baby2_gender)
order m3_baby1_weight m3_baby2_weight m3_baby2_weight, after(m3_baby2_age_weeks)
order m3_baby1_size m3_baby2_size m3_baby2_size, after(m3_baby2_weight)
order m3_baby1_health m3_baby2_health, after(m3_baby2_size)
order m3_baby1_feeding m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_h m3_baby1_feed_99, after(m3_baby2_health) 
order m3_baby2_feeding m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_h m3_baby2_feed_99, after(m3_baby1_feed_99)
order m3_breastfeeding m3_breastfeeding_2,after(m3_baby2_feed_99)
order m3_baby1_born_alive1 m3_baby1_born_alive2 m3_baby2_born_alive1 m3_baby2_born_alive2, after(m3_breastfeeding_2)
order m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby4 m3_1201 m3_miscarriage m3_abortion m3_1202, after(m3_313d_baby2)
order m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason m3_consultation1_reason_a m3_consultation1_reason_b m3_consultation1_reason_c m3_consultation1_reason_d m3_consultation1_reason_e  m3_consultation1_reason_96 m3_consultation1_reason_other, after(m3_402) 
order m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason  m3_consultation2_reason_a m3_consultation2_reason_b m3_consultation2_reason_c m3_consultation2_reason_d m3_consultation2_reason_e m3_consultation2_reason_96 m3_consultation2_reason_other,after(m3_consultation1_reason_other) 
order m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason  m3_consultation3_reason_a m3_consultation3_reason_b m3_consultation3_reason_c m3_consultation3_reason_d m3_consultation3_reason_e m3_consultation3_reason_96 m3_consultation3_reason_other,after(m3_consultation2_reason_other)

order m3_baby1_sleep m3_baby2_sleep, after(m3_622c) 
order m3_baby1_feed m3_baby2_feed, after(m3_baby2_sleep)
order m3_baby1_breath m3_baby2_breath, after(m3_baby2_feed)
order m3_baby1_stool m3_baby2_stool,after(m3_baby2_breath)
order m3_baby1_mood m3_baby2_mood, after(m3_baby2_stool)
order m3_baby1_skin m3_baby2_skin, after(m3_baby2_mood)
order m3_baby1_interactivity m3_baby2_interactivity, after(m3_baby2_skin)

order m3_baby1_issues m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f m3_baby1_issues_98 m3_baby1_issues_99, after(m3_707_ke_unit)

order m3_baby2_issues m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f m3_baby2_issues_98 m3_baby2_issues_99, after(m3_baby1_issues_99)

order m3_phq2_score, after(m3_801b)

order m3_baby_meds_count, after(m3_902j_baby2_other)                    

order m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby4,after(m3_313d_baby2)

order m3_endtime m3_duration, after(m3_1106) 

order m3_num_alive_babies m3_num_dead_babies, after(m3_miscarriage)

* Module 4:
order starttime endtime m4_date m4_103 m4_duration m4_interviewer respondentid m4_consent_recording m4_108 m4_c_section m4_live_babies m4_date_delivery m4_weeks_delivery m4_number_of_babies m4_attempt_number m4_attempt_number_other m4_attempt_outcome m4_resp_language m4_resp_language_no m4_resp_language_no_oth m4_attempt_relationship m4_attempt_other  m4_attempt_avail m4_attempt_contact  m4_attempt_goodtime m4_resp_language m4_resp_language_no m4_resp_language_no_oth   m4_112 m4_113 m4_114 m4_114_oth m4_start m4_201_1 m4_202_1 m4_203_1_1 m4_203_1_2 m4_203_1_3 m4_203_1_4 m4_203_1_5 m4_203_1_6 m4_203_1_7 m4_204a m4_205a_1 m4_205b_1  m4_205c_1 m4_205d_1 m4_205e_1 m4_205f_1 m4_205g_1 m4_206a_1 m4_206b_1 m4_206c_1 m4_206d_1 m4_206e_1 m4_206f_1 m4_206g_1 m4_206h_1 m4_206i_1 m4_206none_1 m4_207a_1 m4_207_1_other m4_301 m4_302a m4_302b m4_303a m4_303b m4_303c m4_303d m4_303e m4_303f m4_303g m4_303h m4_304 m4_305 m4_306 m4_307 m4_308 m4_309 m4_309_other m4_310 m4_401a m4_401b m4_402 m4_403a m4_403b m4_403c m4_404a m4_404a_other m4_404b m4_404b_other m4_404c m4_404c_other m4_405 m4_406_1 m4_406_2 m4_406_3 m4_406_4 m4_406_5 m4_406_6 m4_406_7 m4_406_8 m4_406_9 m4_406_10 m4_406_96 m4_406_other m4_407 m4_408_1 m4_408_2 m4_408_3 m4_408_4 m4_408_5 m4_408_6 m4_408_7 m4_408_8 m4_408_9 m4_408_10 m4_408_96 m4_408_other m4_409 m4_410_1 m4_410_2 m4_410_3 m4_410_4 m4_410_5 m4_410_6 m4_410_7 m4_410_8 m4_410_9 m4_410_10 m4_410_96 m4_410_other m4_411a m4_411b m4_411c m4_412a m4_412a_unit m4_412b m4_412b_unit m4_412c m4_412c_unit m4_413 m4_413_other m4_501 m4_502 m4_601a_1 m4_601b_1 m4_601c_1 m4_601d_1 m4_601e_1 m4_601f_1 m4_601g_1 m4_601h_1 m4_601i_1 m4_601i_1_other m4_602a m4_602b m4_602c m4_602d m4_602e m4_602f m4_602g m4_603_1_0 m4_603_1_1 m4_603_1_2 m4_603_1_3  m4_603_1_4 m4_603_1_5 m4_603_1_6 m4_603_1_96  m4_603_1_other m4_701a m4_701b m4_701c m4_701d m4_701e m4_701f m4_701g m4_701h m4_701h_other m4_702 m4_703a m4_703b m4_703c m4_703d m4_703e m4_703f m4_703g m4_704a m4_704b m4_704c m4_801a m4_801b m4_801c m4_801d m4_801e m4_801f m4_801g m4_801h m4_801i m4_801j m4_801k m4_801l m4_801m m4_801n m4_801o m4_801p m4_801q m4_801r m4_801r_other m4_802a_1  m4_802b_1 m4_802c_1 m4_802d_1 m4_802f_1 m4_802g_1 m4_802h_1 m4_802i_1 m4_802j_1 m4_802j_1_other m4_802k_1 m4_803a_1 m4_803b_1  m4_803c_1 m4_803d_1 m4_803e_1 m4_803f_1 m4_803g_1 m4_804_1 m4_804_1_specify  m4_805 m4_901 m4_902a_amn m4_902b_amn m4_902c_amn m4_902d_amn m4_902e_amn m4_902e_oth m4_903 m4_904 m4_905_1 m4_905_2 m4_905_3 m4_905_4 m4_905_5 m4_905_6 m4_905_96 m4_905_other m4_conclusion_live_babies place refused_why m4_language m4_language_oth m4_reschedule_resp m4_unavailable_reschedule m4_reschedule_noavail m4_call_status

*/

*Leave only participants if attempt outcome was " Answered the phone, correct respondent"		
keep if m4_attempt_outcome == 1	

*==============================================================================*
	
	* STEP SIX: SAVE DATA TO RECODED FOLDER

	save "$ke_data_final\eco_m1-m4_ke.dta", replace
	clear all

*==============================================================================*	
