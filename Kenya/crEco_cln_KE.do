* Kenya MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Sep 5 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

use "$ke_data/KEMRI_Module_1_ANC_2023z-9-6.dta"

* Confirm: are there are any PIDS we should drop?

keep if consent == 1 // 27 ids dropped

gen country = "Kenya"

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 28)
		* STEP TW0: ADD VALUE LABELS - NA in KENYA 
		* STEP THREE: RECODING MISSING VALUES (starts at: line 496)
		* STEP FOUR: LABELING VARIABLES (starts at: line 954)
		* STEP FIVE: ORDER VARIABLES (starts at: line )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

* what are these vars? no data in subscriberid, simid
drop subscriberid simid username text_audit mean_sound_level min_sound_level max_sound_level sd_sound_level pct_sound_between0_60 pct_sound_above80 pct_conversation


	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
rename duration interview_length
rename a1 interviewer_id
rename today_date date_m1
rename a4 study_site
rename a5 facility
rename b1 permission
rename (b2 b3) (care_self enrollage)
rename consent b7eligible
rename (q101 q102 q103 q104 q105 q106) (first_name family_name respondentid ///
		mobile_phone phone_number flash)
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
rename (q401_1 q401_2 q401_3 q401_4 q401_5 q401__96 q401_998 q401_999) (q401a_ke ///
		q401b_ke q401c_ke q401d_ke q401e_ke q401_96_ke q401_998_ke q401_999_ke)	
rename (q402 q403 q404 q405 q405_oth) (m1_402 m1_403b m1_404 m1_405 m1_405_other)
rename (q501 q501_oth q501b q501b_oth) (m1_501 m1_501_other m1_501_ke m1_501_ke_other)
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
		m1_1218_1_ke m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218_za ///
		m1_1218f m1_1218g m1_1219 m1_other_costs_ke m1_1220)
rename (q1220_oth q1221 q1222 q1222_oth q1223) (m1_1220_other m1_1221 m1_1222 m1_1222_other m1_1223)	
rename (q513a q513a_0 q513a_1 q513a_2 q513a_3 q513a_4 q513a_5 q513a_6 q513a__96 ///
		q513b q513c) (m1_513a m1_513a_1 m1_513a_2 m1_513a_3 m1_513a_4 m1_513a_5 ///
		m1_513a_6 m1_513a_7 m1_513a_8 m1_513b m1_513c)		
rename (q513d q513e_1 q513e_2 q513f_1 q513f_2 q513g_1 q513g_2 q513h_1 q513h_2 ///
		q513i_1 q513i_2 q514a q514b_1 q514b_2) (m1_513d m1_513e_name m1_513e m1_513f_name ///
		m1_513f m1_513g_name m1_513g m1_513h_name m1_513h m1_513i_name m1_513i m1_514a ///
		m1_514b m1_514c_ke)		
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
	   m1_1210 m1_1216b (998 = .d)

recode m1_711b m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h ///
	   m1_713i (4 = .d)

recode m1_303 m1_304 m1_305a m1_402 m1_405 m1_504 m1_505 m1_507 m1_509b m1_510b  m1_605b m1_605e ///
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

recode RESPONSE_Lattitude RESPONSE_Longitude (. = .a) if RESPONSE_Location == "UNKNOWN"

* MODULE 1:
* Kept these recode commands here even though everyone has given permission 
recode care_self (. = .a) if permission == 0
recode enrollage (. = .a) if permission == 0
*recode zone_live (. = .a) if enrollage>15 /// not in dataset
*recode zone_live (. = .a) if enrollage_cat == 0 /// string var
recode b6anc_first (. = .a) if b5anc== 2
*recode b6anc_first_conf (.a = .a) if b5anc== 2 /// not in dataset
*recode continuecare (. = .a) if b6anc_first_conf ==2 /// not in dataset
recode flash (. 9999998 = .a) if mobile_phone == 0 | mobile_phone == . 
replace phone_number = ".a" if mobile_phone == 0 | mobile_phone == . 

** SS: 401 other should be a string
replace m1_401_other = .a if m1_401 != 96
replace m1_405_other = ".a" if m1_405 != 96
replace m1_501_other = ".a" if m1_501 != 96
recode m1_503 (. 9999998 = .a) if m1_502 == 0 | m1_502 == . 

recode m1_504 (. 9999998 = .a) if m1_502 == 0 | m1_503 == 3 | m1_503 == 4 | ///
					      m1_503 == 5 | m1_503 == .a | m1_503 == .

replace m1_506_other = ".a" if m1_506 != 96	

** SS: 507 other should be a string
replace m1_507_other = .a if m1_507 != 96		
				  
recode m1_509b (. 9999998 = .a) if m1_509a == 0 | m1_509a == .
recode m1_510b (. 9999998 = .a) if m1_510a == 0 | m1_510a == .

recode m1_517 (. = .a) if m1_516 == "." | m1_516 == "9999998" | m1_516 == ""
recode m1_518 (. 9978082 = .a) if m1_517 == 2 | m1_517 == . | m1_517 == .a
replace m1_519a = ".a" if m1_517 == 2 | m1_517 == . | m1_517 == .a

* confirm how to add skip patterns here since there are multiple answers seperated by a comma
* also 513b-513i are not in the dataset
*recode m1_513b m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i if m1_513a_za == . 

* SS: it looks like this question is asked to women with no personal phone mq_513a_za>2 but this is a checkbox var
*recode m1_514a (. = .a) if m1_513a_za == "." 
	   	   
recode m1_708b (. 9999998 = .a) if m1_708a == . | m1_708a == 0 | m1_708a == .d | m1_708a == .r
recode m1_708c (. 9999998 = .a) if m1_708b	== 2 | m1_708b == . |	m1_708b == .d | m1_708b == .a | m1_708b == .r
recode m1_708d (. 9999998 = .a) if m1_708c	== 0 | m1_708c == . | m1_708c == .d | m1_708c == .a | m1_708c == .r
recode m1_708e (. 9999998 = .a) if m1_708d == 0 | m1_708d == . | m1_708d == .d | m1_708d == .a | m1_708d == .r
recode m1_708f (. 9999998 = .a) if m1_708e == 0 | m1_708e == . | m1_708e == .d | m1_708e == .a | m1_708e == .r
recode m1_709a (. = .a) if m1_708b	== 2 | m1_708b == . | m1_708b == .d | m1_708b == .a | m1_708b == .r | m1_708b == .a
recode m1_709b (. = .a) if m1_708b	== 2 | m1_708b == . | m1_708b == .d | m1_708b == .a | m1_708b == .r | m1_708b == .a
recode m1_710b (. 9999998 = .a) if m1_710a == 0 | m1_710a == . | m1_710a == .d | m1_710a == .a | m1_710a == .r
recode m1_710c (. 9999998= .a) if m1_710b == 2 | m1_710b == .a | m1_710b == .d | m1_710b == .r | m1_710b == .
recode m1_711b (. 9999998 = .a) if m1_711a == 0 | m1_711a == . | m1_711a == .d | m1_711a == .r | m1_711a == .a
recode m1_714c (. 9999998 999999 9999998 9999999 = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r | m1_714b == .a 
recode m1_714d (. 9999998 9999999 99999998 99999988 999999 = .a) if m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r | m1_714b == .a | m1_714c == .
recode m1_714e (. 9999998 9999998 9999999 99999998 999999 = .a) if m1_714c == . | m1_714c == .a | m1_714b == 0 | m1_714b == . | m1_714b == .d | m1_714b == .r | m1_714b == .a
recode m1_717 (. 9999998 = .a) if m1_202d == 0 | m1_202d == . 
recode m1_718 (. 9999998 = .a) if m1_202a == 0 | m1_202a == .
recode m1_719 (. 9999998 = .a) if m1_202b == 0 | m1_202b == .
recode m1_720 (. 9999998 = .a) if m1_202c == 0 | m1_202c == .
recode m1_721 (. 9999998 = .a) if m1_202d == 0 | m1_202d == .
recode m1_722 (. 9999998 = .a) if m1_202e == 0 | m1_202e == . | m1_202e == .r
recode m1_723 (. 9999998 = .a) if m1_204 == 0 | m1_204 == . | m1_204 == .r
recode m1_724b (. 9999998 = .a) if m1_724a == 0 | m1_724a == . | m1_724a == .d
recode m1_724c (. 9999998 = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724d (. 9999998 = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724e (. 9999998 = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724f (. 9999998 = .a) if m1_705 == 1 | m1_705 == . 
recode m1_724g (. 9999998 = .a) if  m1_707 == 1 | m1_707 == . 
recode m1_724h (. 9999998 = .a) if m1_708a == 1 | m1_708a == . 
recode m1_724i (. 9999998 = .a) if m1_712 == 1 | m1_712 == . | m1_712 == .d
replace m1_802a = ".a" if m1_801 == . | m1_801 ==0 | m1_801 ==.a | m1_801 ==.d
recode m1_804 (. 9999998 = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d) & (m1_802a == "." | m1_802a == "" | m1_802a == ".a") & (m1_803 == . | m1_803 == .d | m1_803 == .r)
recode m1_808 (. 9999998 = .a) if m1_804 == 1 | m1_804 == . | m1_804 == .a 
replace m1_808_other = ".a" if m1_808 != 96	
replace m1_810b = ".a" if m1_810a == 1 | m1_810a == 2 | m1_810a == .d | m1_810a == .
recode m1_812b (. 9999998 = .a) if m1_812a == 0 | m1_812a ==. | m1_812a == .d 
recode m1_813b (. 9999998 = .a) if m1_813a == 0 | m1_813a == . | m1_813a == .d
recode m1_814h (. 9999998 = .a) if m1_804 == 1	| m1_804 == 2 | m1_804 == . | m1_804 == .a | m1_804 == .d		
						   			   
recode m1_815 (. 9999998 = .a) if (m1_814a == 0 | m1_814a == .) & (m1_814b == 0 | m1_814b == .) ///
						   & (m1_814c == 0 | m1_814c == .d | m1_814c == .) & ///
						   (m1_814d == 0 | m1_814d == .d | m1_814d == .) & ///
						   (m1_814e == 0 | m1_814e == .) & ///
						   (m1_814f == 0 | m1_814f == .d | m1_814f == .) & ///
						   (m1_814g == 0 | m1_814g == .) & ///
						   (m1_814h == 0 | m1_814h == .d | m1_814h == .r | ///
						   m1_814h == . | m1_814h == .a) 
						   
replace m1_815_other = ".a" if m1_815 != 96	 	

recode m1_816 (. 9999998 = .a) if (m1_814a == . | m1_814a == .a | m1_814a == .d | m1_814a == .r) & ///
								  (m1_814b == . | m1_814b == .a | m1_814b == .d | m1_814b == .r) & ///
								  (m1_814c == . | m1_814c == .a | m1_814c == .d | m1_814c == .r) & ///
							      (m1_814d == . | m1_814d == .a | m1_814d == .d | m1_814d == .r) & ///
								  (m1_814e == . | m1_814e == .a | m1_814e == .d | m1_814e == .r) & ///
								  (m1_814f == . | m1_814f == .a | m1_814f == .d | m1_814f == .r) & ///
								  (m1_814g == . | m1_814g == .a | m1_814g == .d | m1_814g == .r) & ///
								  (m1_814h == . | m1_814h == .a | m1_814h == .d | m1_814h == .r) 

egen symp_total = rowtotal(m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h) 	
recode m1_816 (. 9999998 = .a) if symp_total >= 1
drop symp_total
									
recode m1_902 (. 9999998 = .a) if m1_901 == 3 | m1_901 == .d | m1_901 == .r | m1_901 == .

recode m1_906 (. 9999998 = .a) if m1_905 == 0 | m1_905 == . | m1_905 == .r

recode m1_907 (. 9999998 = .a) if m1_905 == 0 | m1_905 == . | m1_905 == .d | m1_905 == .r
					
recode m1_1002 (. 9999998 = .a) if m1_1001 <= 1 | m1_1001 == .	

recode m1_1003 (. 9999998 = .a) if m1_1002 <1 | m1_1002 == . | m1_1002 == .a	

recode m1_1004 (. 9999998 = .a) if m1_1001 <= m1_1002

recode m1_1005 (. 9999998 = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 == .)

recode m1_1006 (. 9999998 = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 == .)

recode m1_1007 (. 9999998 = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1008 (. 9999998 = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1009 (. 9999998 = .a) if (m1_1003 <1 | m1_1003 == .a | m1_1003 == .)

recode m1_1010 (. 9999998 = .a) if (m1_1003 <= m1_1009) | m1_1003 == .a 

recode m1_1011a (. 9999998 = .a) if (m1_1001 <= 1 | m1_1001 ==.)

recode m1_1011b (. 9999998 = .a) if m1_1004 == 0 | m1_1004 == . | m1_1004 == .a

recode m1_1011c (. 9999998 = .a) if (m1_1002 <= m1_1003)	

recode m1_1011d (. 9999998 = .a) if	m1_1005 == 0 | m1_1005 == . | m1_1005 == .a

recode m1_1011e (. 9999998 = .a) if m1_1007 == 0 | m1_1007 == . | m1_1007 == .a

recode m1_1011f (. 9999998 = .a) if m1_1010 == 0 | m1_1010 == . | m1_1010 == .a

recode m1_1102 (. 9999998 = .a) if m1_1101 == 0 | m1_1101 == . 

replace m1_1102_other = .a if m1_1102 != 96	

recode m1_1104 (. 9999998 = .a) if m1_1103 == 0 | m1_1103 == .

replace m1_1104_other = ".a" if m1_1104 != 96	 

recode m1_1105 (. 9999998 = .a) if (m1_1101 == 0 | m1_1101 == .) & (m1_1103 == 0 | m1_1103 == .)

replace m1_1201_other = ".a" if m1_1201 != 96	

replace m1_1202_other = ".a" if m1_1202 != 96	

replace m1_1208_other = .a if m1_1208 != 96	

replace m1_1209_other = .a if m1_1209 != 96	

replace m1_1210_other = ".a" if m1_1210 != 96	

replace m1_1211_other = ".a" if m1_1211 != 96	

recode m1_1218a_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == .

recode m1_1218b_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218c_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218d_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218e_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218_za (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == .

recode m1_1218g (. 9999998= .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218g_za (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1219 (. 9999998 = .a) if (m1_1218a_1 == .a | m1_1218a_1 == .) & ///
						   (m1_1218b_1 == .a | m1_1218b_1 == .) & ///
						   (m1_1218c_1 ==.a | m1_1218c_1 == .) & ///
						   (m1_1218d_1 == .a | m1_1218c_1 == .) & ///
						   (m1_1218e_1 == .a | m1_1218e_1 == .) & ///
						   (m1_1218_za == .a | m1_1218_za == .) & ///
						   (m1_1218g == .a | m1_1218g == .) & ///
						   (m1_1218g_za == .a | m1_1218g_za ==.)
    
recode m1_1220 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . | m1_1217 == .r

replace m1_1220_other = ".a" if m1_1220 != 96	

replace m1_1222 = ".a" if m1_1221 == 0 | m1_1221 == .

recode m1_1307 (. 9999998 = .a) if m1_1306 == 0 | m1_1306 == 96 | m1_1306 == . 

recode m1_1308 (. 9999998 = .a) if m1_1306 == 1 | m1_1306 == 96 | m1_1306 == .

recode m1_1309 (. 9999998 = .a) if m1_1308 == 0 | m1_1308 == . | m1_1308 == .a	  


*------------------------------------------------------------------------------* 

* Per 8/29 email from Londiwe: 9999998 is system generated if;
	* The questionnaire is incomplete, i.e. the participant decided not to continue with the interview
	*There was a skip from the previous question. e.g. 513a=8, then the following questions will appear as 9999998
* recoding to make "9999998" into "."

replace flash = . if flash == 9999998
replace phone_number = "." if phone_number == "9999998"
replace m1_401_other = . if m1_401_other == 9999998
replace m1_405_other = "." if m1_405_other == "9999998"
replace m1_501_other = "." if m1_501_other == "9999998"
replace m1_502 = . if m1_502 == 9999998
replace m1_503 = . if m1_503 == 9999998
replace m1_504 = . if m1_504 == 9999998
replace m1_505 = . if m1_505 == 9999998
replace m1_506 = . if m1_506 == 9999998
replace m1_506_other = "." if m1_506_other == "9999998"
replace m1_507 = . if m1_507 == 9999998
replace m1_507_other = . if m1_507_other == 9999998
replace m1_508 = . if m1_508 == 9999998
replace m1_509a = . if m1_509a == 9999998
replace m1_509b = . if m1_509b == 9999998
replace m1_510a = . if m1_510a == 9999998
replace m1_510b = . if m1_510b == 9999998
replace m1_511 = . if m1_511 == 9999998
replace m1_512 = . if m1_512 == 9999998
replace m1_513a_za = "." if m1_513a_za == ""
replace m1_513a_za = "." if m1_513a_za == "9999998"

* SS: this coud change once we figure out how to use checkbox data. Technically women with a personal phone wouldn't have been asked this question
replace m1_514a = . if m1_514a == 9999998 
replace m1_515_address = "." if m1_515_address == "9999998"
replace m1_516 = "." if m1_516 == "9999998"
replace m1_517 = . if m1_517 == 9999998
replace m1_519a = ".a" if m1_519a == "9999998"
replace m1_601 = . if m1_601 == 9999998
replace m1_602 = . if m1_602 == 9999998
replace m1_603 = . if m1_603 == 9999998
replace m1_604 = . if m1_604 == 9999998
replace m1_605a = . if m1_605a == 9999998
replace m1_605b = . if m1_605b == 9999998
replace m1_605c = . if m1_605c == 9999998
replace m1_605d = . if m1_605d == 9999998
replace m1_605e = . if m1_605e == 9999998
replace m1_605f = . if m1_605f == 9999998
replace m1_605g = . if m1_605g == 9999998
replace m1_605h = . if m1_605h == 9999998
replace m1_700 = . if m1_700 == 9999998
replace m1_701 = . if m1_701 == 9999998
replace m1_702 = . if m1_702 == 9999998
replace m1_703 = . if m1_703 == 9999998
replace m1_704 = . if m1_704 == 9999998
replace m1_705 = . if m1_705 == 9999998
replace m1_706 = . if m1_706 == 9999998
replace m1_707 = . if m1_707 == 9999998
replace m1_708a = . if m1_708a == 9999998
replace m1_708b = . if m1_708b == 9999998
replace m1_708c = . if m1_708c == 9999998
replace m1_708d = . if m1_708d == 9999998
replace m1_708e = . if m1_708e == 9999998
replace m1_708f = . if m1_708f == 9999998
replace m1_709a = . if m1_709a == 9999998
replace m1_709b = . if m1_709b == 9999998
replace m1_710a = . if m1_710a == 9999998
replace m1_710b = . if m1_710b == 9999998
replace m1_710c = . if m1_710c == 9999998
replace m1_711a = . if m1_711a == 9999998
replace m1_711b = . if m1_711b == 9999998
replace m1_712 = . if m1_712 == 9999998
replace m1_713a = . if m1_713a == 9999998
replace m1_713_za = . if m1_713_za == 9999998
replace m1_713b = . if m1_713b == 9999998
replace m1_713c = . if m1_713c == 9999998
replace m1_713d = . if m1_713d == 9999998
replace m1_713e = . if m1_713e == 9999998
replace m1_713f = . if m1_713f == 9999998
replace m1_713h = . if m1_713h == 9999998
replace m1_713i = . if m1_713i == 9999998
replace m1_713n_za = . if m1_713n_za == 9999998
replace m1_713m_za = . if m1_713m_za == 9999998
replace m1_713g = . if m1_713g == 9999998
replace m1_714a = . if m1_714a == 9999998
replace m1_714b = . if m1_714b == 9999998
replace m1_714c = . if m1_714c == 9999998
replace m1_714c = . if m1_714c == 9999999
replace m1_714c = . if m1_714c == 99999998
replace m1_714c = . if m1_714c == 999999
replace m1_714d = . if m1_714d == 9999998
replace m1_714d = . if m1_714d == 9999999
replace m1_714d = . if m1_714d == 99999998
replace m1_714d = . if m1_714d == 99999988
replace m1_714d = . if m1_714d == 999999
replace m1_714e = . if m1_714e == 9999998
replace m1_714e = . if m1_714e == 9999999
replace m1_714e = . if m1_714e == 99999998
replace m1_714e = . if m1_714e == 999999
replace m1_715 = . if m1_715 == 9999998
replace m1_716a = . if m1_716a == 9999998
replace m1_716b = . if m1_716b == 9999998
replace m1_716c = . if m1_716c == 9999998
replace m1_716d = . if m1_716d == 9999998
replace m1_716e = . if m1_716e == 9999998
replace m1_717 = . if m1_717 == 9999998
replace m1_718 = . if m1_718 == 9999998
replace m1_719 = . if m1_719 == 9999998
replace m1_720 = . if m1_720 == 9999998
replace m1_721 = . if m1_721 == 9999998
replace m1_722 = . if m1_722 == 9999998

* SS: due. skip patterns, only people who answered "yes" to 204 were asked 723… but nearly everyone has 9999998 as an answer 
*replace m1_723 = . if m1_723 == 9999998

replace m1_724a = . if m1_724a == 9999998
replace m1_724b = . if m1_724b == 9999998
replace m1_724c = . if m1_724c == 9999998
replace m1_724d = . if m1_724d == 9999998
replace m1_724e = . if m1_724e == 9999998
replace m1_724f = . if m1_724f == 9999998
replace m1_724g = . if m1_724g == 9999998
replace m1_724h = . if m1_724h == 9999998
replace m1_724i = . if m1_724i == 9999998
replace m1_801 = . if m1_801 == 9999998
replace m1_802a = "." if m1_802a == "9999998"
replace m1_803 = . if m1_803 == 9999998
replace m1_804 = . if m1_804 == 9999998
replace m1_805 = . if m1_805 == 9999998
replace m1_806 = . if m1_806 == 9999998
replace m1_807 = . if m1_807 == 9999998

* SS: N=306 peeople in 2nd and 3rd trimester have 9999998 in data for 808
*replace m1_808 = . if m1_808 == 9999998

replace m1_808_other = "." if m1_808_other == "9999998"
replace m1_809 = . if m1_809 == 9999998
replace m1_810a = . if m1_810a == 9999998
replace m1_810b = "." if m1_810b == "9999998"
replace m1_811 = . if m1_811 == 9999998
replace m1_812a = . if m1_812a == 9999998
replace m1_812b = . if m1_812b == 9999998
replace m1_813a = . if m1_813a == 9999998
replace m1_813b = . if m1_813b == 9999998
replace m1_814a = . if m1_814a == 9999998
replace m1_814b = . if m1_814b == 9999998
replace m1_814c = . if m1_814c == 9999998
replace m1_814d = . if m1_814d == 9999998
replace m1_814e = . if m1_814e == 9999998
replace m1_814f = . if m1_814f == 9999998
replace m1_814g = . if m1_814g == 9999998
replace m1_814h = . if m1_814h == 9999998
replace m1_815 = . if m1_815 == 9999998
replace m1_815_other = "." if m1_815_other == "9999998"
replace m1_815_other = "." if m1_815_other == "9999999"

* SS: N=400 people with no symptoms reported "9999998"
*replace m1_816 = . if m1_816 == 9999998

replace m1_901 = . if m1_901 == 9999998
replace m1_902 = . if m1_902 == 9999998
replace m1_905 = . if m1_905 == 9999998
replace m1_906 = . if m1_906 == 9999998
replace m1_907 = . if m1_907 == 9999998
replace m1_908_za = . if m1_908_za == 9999998
replace m1_909_za = "." if m1_909_za == "9999998"
replace m1_910_za = "." if m1_910_za == "9999998"
replace m1_1001 = . if m1_1001 == 9999998
replace m1_1002 = . if m1_1002 == 9999998
replace m1_1003 = . if m1_1003 == 9999998
replace m1_1004 = . if m1_1004 == 9999998
replace m1_1005 = . if m1_1005 == 9999998
replace m1_1006 = . if m1_1006 == 9999998
replace m1_1007 = . if m1_1007 == 9999998
replace m1_1008 = . if m1_1008 == 9999998
replace m1_1009 = . if m1_1009 == 9999998
replace m1_1010 = . if m1_1010 == 9999998
replace m1_1011a = . if m1_1011a == 9999998
replace m1_1011b = . if m1_1011b == 9999998
replace m1_1011c = . if m1_1011c == 9999998
replace m1_1011d = . if m1_1011d == 9999998
replace m1_1011e = . if m1_1011e == 9999998
replace m1_1011f = . if m1_1011f == 9999998
replace m1_1101 = . if m1_1101 == 9999998
replace m1_1102 = . if m1_1102 == 9999998
replace m1_1102_other = .a if m1_1102_other == 9999998
replace m1_1103 = . if m1_1103 == 9999998
replace m1_1104 = . if m1_1104 == 9999998
replace m1_1104_other = "." if m1_1104_other == "9999998"
replace m1_1105 = . if m1_1105 == 9999998
replace m1_1201 = . if m1_1201 == 9999998
replace m1_1201_other = "." if m1_1201_other == "9999998"
replace m1_1202 = . if m1_1202 == 9999998
replace m1_1202_other = "." if m1_1202_other == "9999998"
replace m1_1203 = . if m1_1203 == 9999998
replace m1_1204 = . if m1_1204 == 9999998
replace m1_1205 = . if m1_1205 == 9999998
replace m1_1206 = . if m1_1206 == 9999998
replace m1_1207 = . if m1_1207 == 9999998
replace m1_1208 = . if m1_1208 == 9999998
replace m1_1208_other = . if m1_1208_other == 9999998
replace m1_1209 = . if m1_1209 == 9999998
replace m1_1209_other = . if m1_1209_other == 9999998
replace m1_1210 = . if m1_1210 == 9999998
replace m1_1210_other = "." if m1_1210_other == "9999998"
replace m1_1211 = . if m1_1211 == 9999998
replace m1_1211_other = "." if m1_1211_other == "9999998"
replace m1_1212 = . if m1_1212 == 9999998
replace m1_1213 = . if m1_1213 == 9999998
replace m1_1214 = . if m1_1214 == 9999998
replace m1_1215 = . if m1_1215 == 9999998
replace m1_1216a = . if m1_1216a == 9999998
replace m1_1217 = . if m1_1217 == 9999998
replace m1_1218a_1 = . if m1_1218a_1 == 9999998
replace m1_1218b_1 = . if m1_1218b_1 == 9999998
replace m1_1218c_1 = . if m1_1218c_1 == 9999998
replace m1_1218d_1 = . if m1_1218d_1 == 9999998
replace m1_1218e_1 = . if m1_1218e_1 == 9999998
replace m1_1218_za = . if m1_1218_za == 9999998
replace m1_1218g = . if m1_1218g == 9999998
replace m1_1218g_za = . if m1_1218g_za == 9999998
replace m1_1219 = . if m1_1219 == 9999998
replace m1_1220 = . if m1_1220 == 9999998
replace m1_1220_other = "." if m1_1220_other == "9999998"
replace m1_1221 = . if m1_1221 == 9999998
replace m1_1222 = "." if m1_1222 == "9999998"
replace m1_1223 = . if m1_1223 == 9999998
replace m1_1307 = . if m1_1307 == 9999998
replace m1_1309 = . if m1_1309 == 9999998
replace bp_time_1_systolic = . if bp_time_1_systolic == 9999998
replace bp_time_1_diastolic = . if bp_time_1_diastolic == 9999998
replace time_1_pulse_rate = . if time_1_pulse_rate == 9999998
replace bp_time_2_systolic = . if bp_time_2_systolic == 9999998
replace bp_time_2_diastolic = . if bp_time_2_diastolic == 9999998
replace time_2_pulse_rate = . if time_2_pulse_rate == 9999998
replace bp_time_3_systolic = . if bp_time_3_systolic == 9999998
replace bp_time_3_diastolic = . if bp_time_3_diastolic == 9999998
replace pulse_rate_time_3 = . if pulse_rate_time_3 == 9999998
replace height_cm = . if height_cm == 9999998 
replace weight_kg = . if weight_kg == 9999998 
replace m1_1306 = . if m1_1306 == 9999998 
replace m1_1308 = . if m1_1308 == 9999998 
replace m1_1401 = . if m1_1401 == 9999998 

*===============================================================================					   


	