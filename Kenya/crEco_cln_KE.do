* Kenya MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Sep 5 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

use "$ke_data/KEMRI_Module_1_ANC_2023z-9-6.dta"

*------------------------------------------------------------------------------*
* Create sample: (M1 = 1,007)

* Confirm: are there are any PIDS we should drop? -James

keep if consent == 1 // 27 ids dropped
drop if q105 == .

gen country = "Kenya"

* recode a1 = ids and drop names

* recode facility names? - leave in for now

* de-identifying dataset and remove extra variables
drop q101 q102 q105 q513b q513d q513e_1 q513e_2 q513f_1 q513f_2 q513g_1 q513g_2 ///
	 q513h_1 q513h_2 q513i_1 q513i_2 text_audit mean_sound_level min_sound_level ///
	 max_sound_level sd_sound_level pct_sound_between0_60 pct_sound_above80 ///
	 pct_conversation subscriberid simid enum_name 

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 28)
		* STEP TW0: ADD VALUE LABELS - NA in KENYA 
		* STEP THREE: RECODING MISSING VALUES (starts at: line 496)
		* STEP FOUR: LABELING VARIABLES (starts at: line 954)
		* STEP FIVE: ORDER VARIABLES (starts at: line )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*
	
	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
rename duration interview_length
rename a1 interviewer_id
rename today_date date_m1
rename a4 study_site
rename a5 facility
rename b1 permission
rename (b2 b3) (care_self enrollage)
rename (b4 b4_oth b5 b6) (zone_live zone_live_other b5anc b6anc_first)
rename a2 device_date_ke
rename consent b7eligible
rename (q103 q104 q106) (respondentid mobile_phone flash)
rename q201 m1_201
rename (q202a q202b q202c q202d q202e) (m1_202a m1_202b m1_202c m1_202d m1_202e)
rename q203 m1_203
rename (q203_0 q203_1 q203_2 q203_3 q203_4 q203_5 q203_6 q203_7 q203_8 q203_9 ///
		q203_10 q203_11 q203_12 q203_13 q203_14 q203__96 q203_oth) (m1_203a_ke ///
		m1_203b_ke m1_203c_ke m1_203d_ke m1_203e_ke m1_203f_ke m1_203g_ke m1_203h_ke ///
		m1_203i_ke m1_203j_ke m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke ///
		m1_203_96_ke m1_203_other_ke)
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
rename (q601 q602 q603 q604) (m1_601 m1_602 m1_603 m1_604)
rename (q605a q605b q605c q605d q605e q605f q605g q605h) (m1_605a m1_605b m1_605c m1_605d ///
		m1_605e m1_605f m1_605g m1_605h)
rename (q700 q701 q702 q703 q704 q705 q706 q707 q708a q708b q708c q708d q708e q708f ///
		q709a q709b q710a q710b q710c q711a q711b q712) (m1_700 m1_701 m1_702 m1_703 ///
		m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f ///
		m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712)
rename (q713a q713b q713c q713d q713e q713f q713g q713h q713i q713j q713k q713l) (m1_713a m1_713b ///
		m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713j_ke m1_713k_ke m1_713l_ke)
rename (q714a q714b q714c q714d q714e q715) (m1_714a m1_714b m1_714c m1_714d m1_714e m1_715)
rename (q716a q716b q716c q716d q716e q717 q718 q719 q720 q721 q722 q723 q724a q724b q724c ///
		q724d q724e q724f q724g q724h q724i q801 q802a q802) (m1_716a m1_716b m1_716c m1_716d ///
		m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724b m1_724c m1_724d ///
		m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_802_ke m1_802a)
rename (q803 edd_chart gest_age_baseline q804 q805 expected_babies q806 q807 q808 q808_oth) (m1_803 ///
		edd_chart_ke gest_age_baseline_ke m1_804 m1_805 m1_805a_ke m1_806 m1_807 m1_808 m1_808_other)
rename (q809 q810a q810b q810b_oth) (m1_809 m1_810a m1_810b m1_810_other)
rename (q812a q812b q812b_oth q813a q813b) (m1_812a m1_812b m1_812b_other m1_813a m1_813b)
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
		q1102_10 q1102__96 q1102_998 q1102_999 q1102_oth q1103) (m1_1102_1 m1_1102_2 ///
		m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 m1_1102_7 m1_1102_8 m1_1102_9 m1_1102_10 ///
		m1_1102_96 m1_1102_98 m1_1102_99 m1_1102_99_ke m1_1102_other m1_1103)
rename (q1104 q1104_1 q1104_2 q1104_3 q1104_4 q1104_5 q1104_6 q1104_7 q1104_8 ///
		q1104_9 q1104_10 q1104__96 q1104_998 q1104_999) (m1_1104_1 m1_1104_2 ///
		m1_1104_3 m1_1104_4 m1_1104_5 m1_1104_6 m1_1104_7 m1_1104_8 m1_1104_9 ///
		m1_1104_10 m1_1104_96 m1_1104_98 m1_1104_99 m1_1104_99_ke)
rename (q1104_oth q1105 q1201 q1201_oth q1202 q1202_oth q1203 q1204 q1205 q1206 ///
		q1207 q1208 q1208_oth q1209 q1209_oth q1210 q1210_oth q1211 q1211_oth q1212 ///
		q1213 q1214 q1215) (m1_1104_other m1_1105 m1_1201 m1_1201_other m1_1202 ///
		m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1208_other ///
		m1_1209 m1_1209_other m1_1210 m1_1210_other m1_1211 m1_1211_other m1_1212 ///
		m1_1213 m1_1214 m1_1215)
rename (q1216 q1217 q1218 clinic_cost q1218a q1218b q1218c q1218d q1218e q1218f_2 ///
		q1218f_1 q1218f_3 q1219 other_costs q1220) (m1_1216b m1_1217 m1_1218_ke ///
		m1_1218_1_ke m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 ///
		m1_1218f_other m1_1218f m1_1218f_1 m1_1219 m1_other_costs_ke m1_1220)
rename (q1220_oth q1221 q1222 q1222_oth q1223) (m1_1220_other m1_1221 m1_1222 ///
		m1_1222_other m1_1223)	

rename (q513a q513a_0 q513a_1 q513a_2 q513a_3 q513a_4 q513a_5 q513a_6 q513a__96) ///
		(m1_513a m1_513a_1 m1_513a_2 m1_513a_3 m1_513a_4 m1_513a_5 m1_513a_6 ///
		m1_513a_7 m1_513a_8)		

rename q513c m1_513c

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
rename (q1306 q1307 q1308 q1309 q1401 preferred_phone_oth preferred_phone_confirm q1402 endtime) ///
		(m1_1306 m1_1307 m1_1308 m1_1309 m1_1401 m1_1401_other m1_1401a_ke m1_1402 m1_end_time)		
rename preferred_language interview_language_ke
rename noconsent_why noconsent_why_ke		
rename end_comment m1_end_comment_ke	
		
*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS (NA in KENYA)

*===============================================================================

*===============================================================================
		
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 

	** MODULE 1:

recode m1_402 m1_403b m1_404 m1_506 m1_509b m1_510b  m1_700 m1_702 m1_703 m1_704 m1_705 m1_706 ///
	   m1_707 m1_708a ///
	   m1_708b m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b  m1_711a m1_712 ///
	   m1_714a m1_714b m1_714c m1_716a m1_716b m1_716c m1_716d m1_716e m1_717  ///
	   m1_719 m1_724a m1_724b m1_724c m1_724d m1_724e m1_724g m1_724i m1_801 m1_803 ////
	   m1_805 m1_805a_ke m1_806 m1_809 m1_810a m1_812a m1_813b m1_814d ///
	   m1_807 m1_810a m1_814e m1_814f m1_814g m1_814h m1_906 m1_907 ///
	   m1_1006 m1_1008 m1_1011a m1_1103 m1_1203 m1_1204 m1_1209 ///
	   m1_1210 m1_1216b m1_1222 m1_802_ke  (998 = .d)

recode m1_711b m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h ///
	   m1_713i (4 = .d)

recode m1_303 m1_304 m1_305a m1_402 m1_405 m1_504 m1_505 m1_507 m1_509a m1_509b ///
	   m1_510a m1_510b  m1_605b m1_605e ///
	   m1_605f m1_605h m1_701 m1_702 m1_708b m1_710a m1_710b ///
	   m1_716a m1_716c m1_716d m1_724c m1_805 m1_807 m1_808 m1_809 m1_810a m1_812a ///
	   m1_813a m1_813b m1_814g m1_901 m1_1004 m1_1005 m1_1010 m1_1011a m1_1209 ///
	   m1_1210 m1_1211 m1_1216b phq9f phq9g m1_301 (999 = .r)
  	
replace m1_812b=".d" if m1_812b== "998"	
replace m1_815_0=".d" if m1_815_0== "998"	
replace m1_815_0=".r" if m1_815_0== "999"	

*------------------------------------------------------------------------------*

* recoding for skip pattern logic:	   
	   
* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns

* MODULE 1:

* eligibility:
	* Kept these recode commands here even though everyone has given permission 
recode care_self (. = .a) if permission == 0

destring(enrollage), gen(recenrollage)
recode recenrollage (. = .a) if permission == 0

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
				   
replace m1_203_other_ke = ".a" if m1_203_96_ke == 0 | m1_203_96_ke == .

*replace m1_401_other = ".a" if m1_401 != "-96" // doesn't work because of checkbox data
replace m1_405_other = ".a" if m1_405 != -96

replace m1_501_ke_other = ".a" if m1_501k_ke == 0 | m1_501k_ke == .

replace m1_501_other = ".a" if m1_501 != -96

recode m1_503 (.  = .a) if m1_502 == 0 | m1_502 == . 

* please note that people who completed primary were not asked m1_504 in KE, and people who said that they have not attended school still answered m1_504
recode m1_504 (.  = .a) if m1_503 == 2 | m1_503 == 3 | m1_503 == 4 | ///
						   m1_503 == 5 | m1_503 == .a | m1_503 == .

replace m1_506_other = ".a" if m1_506 != -96	

** SS: 507 other should be a string
replace m1_507_other = ".a" if m1_507 != -96		
				  
recode m1_509b (.  = .a) if m1_509a == 0 | m1_509a == . | m1_509a == .r
recode m1_510b (.  = .a) if m1_510a == 0 | m1_510a == . | m1_510a == .r


**** 
recode q514a q514b_1 q514b_2 /// rename first 

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

* Confirm that some people are just missing this data:
recode edd_chart_ke (. = .a) if m1_801 == . | m1_801 == 0 | m1_801 == .a | m1_801 == .d | m1_801 == .r

recode m1_803 (. = .a) if m1_801 == 1 | m1_801 == . | m1_801 == .d

replace gest_age_baseline_ke = ".a" if edd_chart_ke == 0 | edd_chart_ke == . | edd_chart_ke == .a

recode m1_804 (.  = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d) & (m1_802a == . | m1_802a == .a) & (m1_803 == . | m1_803 == .d | m1_803 == .r)
recode m1_808 (.  = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a 
replace m1_808_other = ".a" if m1_808 != 96	
replace m1_810b = .a if m1_810a == 1 | m1_810a == 2 | m1_810a == .d | m1_810a == . | m1_810a == .r
replace m1_812b = ".a" if m1_812a == 0 | m1_812a ==. | m1_812a == .d | m1_812a == .r

*******
recode q812b_0 q812b_1 q812b_2 q812b_3 q812b_4 q812b_5 q812b__96 q812b_998 q812b_999 // rename first

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
						   
replace m1_815_other = ".a" if m1_815_0 != "-96" // Need to figure out how to code this better because not picking up picking who selected other and another choice

* m1_816 not in this dataset
*egen symp_total = rowtotal(m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h) 	
*recode m1_815 (.  = .a) if symp_total >= 1
*drop symp_total
									
recode m1_902 (.  = .a) if m1_901 == 3 | m1_901 == .d | m1_901 == .r | m1_901 == .

**** 
recode m1_904



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

replace m1_1102_1 = ".a" if m1_1101 == 0 | m1_1101 == . 

recode m1_1102_2 m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 m1_1102_7 m1_1102_8 ///
	   m1_1102_9 m1_1102_10 m1_1102_96 m1_1102_98 m1_1102_99 m1_1102_99_ke (.  = .a) if ///
	   m1_1101 == 0 | m1_1101 == . 

* SS: change all checkboxes to match this:
replace m1_1102_other = ".a" if m1_1102_96 == 0 | m1_1102_96 == .a

replace m1_1104_1 = ".a" if m1_1103 == 0 | m1_1103 == . | m1_1103 == .d

recode m1_1104_2 m1_1104_3 m1_1104_4 m1_1104_5 m1_1104_6 m1_1104_7 m1_1104_8 m1_1104_9 m1_1104_10 m1_1104_96 m1_1104_98 m1_1104_99 m1_1104_99_ke (.  = .a) if m1_1103 == 0 | m1_1103 == . | m1_1103 == .d

replace m1_1104_other = ".a" if m1_1104_96 == 0 | m1_1104_96 == .a	 

recode m1_1105 (.  = .a) if (m1_1103 == 0 | m1_1103 == . | m1_1103 == .d)

replace m1_1201_other = ".a" if m1_1201 != -96	

* where is the "other value"
*replace m1_1202_other = ".a" if m1_1202 != 96	

replace m1_1208_other = ".a" if m1_1208 != -96	

* where is the "other value"
*replace m1_1209_other = ".a" if m1_1209 != 96	

replace m1_1210_other = ".a" if m1_1210 != -96	

replace m1_1211_other = ".a" if m1_1211 != -96	

recode m1_1218_ke m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f m1_1218f_1 (. = .a) if m1_1217 == 0 | m1_1217 == .

replace m1_1218_1_ke = ".a" if m1_1217 == 0 | m1_1217 == .

replace m1_1218f_other = ".a" if m1_1218f == 0 | m1_1218f == .a | m1_1218f == .

recode m1_1219 (.  = .a) if (m1_1218_ke == .a) & ///
						   (m1_1218a_1 == .a | m1_1218a_1 ==.) & ///
						   (m1_1218b_1 == .a | m1_1218b_1 == .) & ///
						   (m1_1218c_1 == .a | m1_1218c_1 == .) & ///
						   (m1_1218d_1 == .a | m1_1218c_1 == .) & ///
						   (m1_1218e_1 == .a | m1_1218e_1 == .) & ///
						   (m1_1218f_1 == .a | m1_1218f_1 == .) & ///
						   (m1_1218_1_ke == ".a")

replace m1_other_costs_ke = ".a" if m1_1218f_1  == .a | m1_1218f_1 == .						   
						   
recode m1_1220 (.  = .a) if m1_1217 == 0 | m1_1217 == . 

replace m1_1220_other = ".a" if m1_1220 != -96	

replace m1_1222 = .a if m1_1221 == 0 | m1_1221 == .

recode m1_1307 (.  = .a) if m1_1306 == 0 | m1_1306 == . 

recode m1_1308 (.  = .a) if m1_1306 == 1 | m1_1306 == .

recode m1_1309 (.  = .a) if m1_1308 == 0 | m1_1308 == . | m1_1308 == .a	  


*===============================================================================					   

	
	* STEP FOUR: LABELING VARIABLES

lab var country "Country"
	
	** MODULE 1:		
lab var interviewer_id "Interviewer ID"
lab var date_m1 "A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var pre_screening_num_za "Pre-Screening Number"
lab var study_site "A4. Study site"
lab var facility "A5. Facility name"
lab var study_site_sd "A4_Other. Specify other study site"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var enrollage "B3. How old are you?"
lab var enrollage_cat "B3.A: Are you 15 years or older?"
lab var zone_live "B4. In which zone/district/ sub city are you living?"
lab var b5anc "B5. By that I mean care related to a pregnancy?"
lab var b6anc_first "B6. Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?"
lab var b7eligible "B7. Is the respondent eligible to participate in the study AND signed a consent form?"
*lab var first_name "101. What is your first name?"
*lab var family_name "102. What is your family name?"
lab var respondentid "103. Assign respondent ID"
lab var mobile_phone "104. Do you have a mobile phone with you today?"
lab var phone_number "105. What is your phone number?"
lab var flash "106. Can I 'flash' this number now to make sure I have noted it correctly?"
lab var m1_201 "201. In general, how would you rate your overall health?"
lab var m1_202a "202.a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202.b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202.c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202.d BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202.e BEFORE you got pregnant, did you know that you had HIV?"
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
lab var m1_401a_ke "401a. KE only: "
lab var m1_401b_ke "401b. KE only: "
lab var m1_401c_ke "401c. KE only: "
lab var m1_401d_ke "401d. KE only: "
lab var m1_401e_ke "401e. KE only: "
lab var m1_401_96_ke "401-other. KE only: Other, specify"
lab var m1_401_998_ke "401. KE only: Don't Know"
lab var m1_401_999_ke "401. KE only: NR/RF"
lab var m1_401_other "401_Other. Other specify"
lab var m1_402 "402. How long in minutes did it take you to reach this facility from your home?"
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
lab var m1_513a_za "513a. What phone numbers can we use to reach you in the coming months?"
lab var m1_514a "514a. We would like you to be able to participate in this study. We can give you a mobile phone for you to take home so that we can reach you. Would you like to receive a mobile phone?"
lab var m1_515_address "515. Can you please tell me where you live? What is your address?"
lab var m1_516 "516. Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions"
lab var m1_517 "517. Is this a temporary residence or a permanent residence?"
lab var m1_518 "518. Until when will you be at this residence?"
lab var m1_519a "519a. Where will your district be after this date "
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
lab var m1_713a "713a_1. Iron and folic acid pills?"
lab var m1_713_za "713b: Iron injection"
lab var m1_713b "713b_1. Calcium pills?"
lab var m1_713c "713c_1. The food supplement like Super Cereal or Plumpynut?"
lab var m1_713d "713d_1. Medicine for intestinal worms?"
lab var m1_713e "713e_1. Medicine for malaria (endemic only)?"
lab var m1_713m_za "713h: Medicine for HIV"
lab var m1_713f "713f_1. Medicine for your emotions, nerves, or mental health?"
lab var m1_713g "713g_1. Multivitamins?"
lab var m1_713h "713h_1. Medicine for hypertension?"
lab var m1_713i "713i_1. Medicine for diabetes, including injections of insulin?"
lab var m1_713n_za "713l: Antibiotics for an infection"
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
lab var m1_803 "803. How many weeks pregnant do you think you are?"
lab var m1_804 "804. Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)."
lab var m1_805 "805. How many babies are you pregnant with?"
lab var m1_806 "806. During the visit today, did the healthcare provider ask when you had your last period, or not?"
lab var m1_807 "807. When you got pregnant, did you want to get pregnant at that time?"
lab var m1_808 "808: There are many reasons why some women may not get antenatal care earlier in their pregnancy. Which, ifany, of the following, are reasons you did not receive care earlier in your pregnancy?"
lab var m1_808_other "808_Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_811 "811. Do you plan to stay at a maternity waiting home before delivering your baby?"
lab var m1_812a "812a. During the visit today, did the provider tell you that you might need a C-section?"
lab var m1_812b "812b.0. Have you told the reason why you might need a c-section?"
lab var m1_813a "813a. Some women experience common health problems during pregnancy. Did you experience nausea in your pregnancy so far, or not?"
lab var m1_813b "813b. Some women experience common health problems during pregnancy. Did you experience heartburn in your pregnancy so far, or not?"
lab var m1_814a "814a. Could you please tell me if you have experienced Severe or persistent headaches in your pregnancy so far, or not?"
lab var m1_814b "814b. Could you please tell me if you have experienced Vaginal bleeding of any amount in your pregnancy so far, or not?"
lab var m1_814c "814c. Could you please tell me if you have experienced a fever in your pregnancy so far, or not?"
lab var m1_814d "814d. Could you please tell me if you have experienced Severe abdominal pain, not just discomfort in your pregnancy so far, or not?"
lab var m1_814e "814e. Could you please tell me if you have experienced a lot of difficulty breathing even when you are resting in your pregnancy so far, or not?"
lab var m1_814f "814f. Could you please tell me if you have experienced Convulsions or seizures in your pregnancy so far, or not?"
lab var m1_814g "814g. Could you please tell me if you have experienced repeated fainting or loss of consciousness in your pregnancy so far, or not?"
lab var m1_814h "814h. Could you please tell me if you have experienced noticing that the baby has completely stopped moving in your pregnancy so far, or not?"
lab var m1_815 "815: During the visit today, what did the provider tell you to do regarding the [symptom(s) experienced in 814a-814h]?"
lab var m1_815_other "815_Other. Other (specify)"
lab var m1_816 "816. You said that you did not have any of the symptoms I just listed. Did the health provider ask you whether or not you had these symptoms, or did this topic not come up today?"
lab var m1_901 "901. How often do you currently smoke cigarettes or use any other type of tobacco? Is it every day, some days, or not at all?"
lab var m1_902 "902. During the visit today, did the health provider advise you to stop smoking or using tobacco products?"
lab var m1_905 "905. Have you consumed an alcoholic drink (i.e., Tela, Tej, Areke, Bira, Wine, Borde, Whisky) within the past 30 days?"
lab var m1_906 "906. When you do drink alcohol, how many standard drinks do you consume on average?"
lab var m1_907 "907. During the visit today, did the health provider advise you to stop drinking alcohol?"
lab var m1_908_za "908: What is the age of your partner or father of the baby? (Interviewer allows the participant to write down theanswer)"
lab var m1_909_za "909: Have you ever given oral, anal, or vaginal sex to someone because you expected to get or got any of thesethings?"
lab var m1_910_za "910: In the past 12 months, have you started or stayed in a relationship with a man or boy so that you couldreceive any of the following?"
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
lab var m1_1102_other "1102_Oth. Specify who else hit, kick, slapped, ... you"
lab var m1_1103 "1103. At any point during your current pregnancy, has anyone ever said or done something to humiliate you, insulted you or made you feel bad about yourself?"
lab var m1_1104 "1104: Who has done these things to you while you were pregnant?"
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
lab var m1_1216a "1216: How many meals does your household usually have per day?"
lab var m1_1217 "1217. Did you pay money out of your pocket for this visit, including for the consultation or other indirect costs like your transport to the facility?"
lab var m1_1218a_1 "1218a.1. How much money did you spend on Registration / Consultation?"
lab var m1_1218b_1 "1218b.1. How much money do you spent for medicine/vaccines (including outside purchase)"
lab var m1_1218c_1 "1218c.1. How much money have you spent on Test/investigations (x-ray, lab etc.)?"
lab var m1_1218d_1 "1218d.1. How much money have you spent for transport (round trip) including that of person accompanying you?"
lab var m1_1218e_1 "1218e.1. How much money have you spent on food and accommodation including that of the person accompanying you?"
lab var m1_1218_za "1218f: Other (specify)"
lab var m1_1218g "1218f: If other, please specify - Amount"
lab var m1_1218g_za "1218g: Total Spent"
lab var m1_1219 "Total amount spent"
lab var m1_1220 "1220: Which of the following financial sources did your household use to pay for this?"
lab var m1_1220_other "1220_Other. Specify other financial source for household use to pay for this"
lab var m1_1221 "1221. Are you covered with a health insurance?"
lab var m1_1222 "1222. What type of health insurance coverage do you have?"
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


*===============================================================================

	* STEP FIVE: ORDER VARIABLES
	
*===============================================================================

	* STEP SIX: SAVE DATA TO RECODED FOLDER
drop time_start_full time_start time_start_v2 deviceid	
 
order m1_*, sequential
order country study_site study_site_sd facility interviewer_id date_m1 pre_screening_num_za permission care_self enrollage_cat enrollage zone_live b5anc b6anc_first b7eligible respondentid mobile_phone phone_number flash

order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

*save "$ke_data_final/eco_m1_ke.dta", replace
	
