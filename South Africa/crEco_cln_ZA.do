* South Africa MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Aug 17 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 
import excel "$za_data/SA MOD-1 - 15 Jan 2024.xlsx", sheet("MNH_Module_1_Baseline") firstrow
*import excel "$za_data/SA MOD-1 - 28Nov2023_updated.xlsx", sheet("MNH_Module_1_Baseline") firstrow


* Notes from original excel:
	*9999998 = Not applicable
	*5555555 = Did not meet the eligibility criteria
	*Blank = Missing value/Incomplete interview

/*
drop if CRHID == "9999998" | CRHID == "EUB_001" | CRHID == "EUB_002" | CRHID == "MPH_001" | CRHID == "MPH_002" | ///
		CRHID == "NEL_001" | CRHID == "NOK_001" | CRHID == "NOK_002" | CRHID == "NWE_001" | CRHID == "NWE_002" | ///
		CRHID == "QEE_001" | CRHID == "QEE_002" | CRHID == "QEE_003" | CRHID == "QEE_005" | CRHID == "QEE_006" | ///
		CRHID == "QEE_009" | CRHID == "QEE_010" | CRHID == "QEE_011" | CRHID == "RCH_001" | CRHID == "RCH_002" | ///
		CRHID == "TOK_001" | CRHID == "TOK_002" | CRHID == "NEL_003" | CRHID == "IIB_016" | CRHID == "IIB_018" | ///
		CRHID == "IIB_019" | CRHID == "IIB_021" | CRHID == "KAN_006" | CRHID == "KAN_007" | CRHID == "KAN_011" | ///
		CRHID == "KAN_013" | CRHID == "KAN_019" | CRHID == "KAN_020" | CRHID == "KAN_033" | CRHID == "KAN_039" | ///
		CRHID == "MER_006" | CRHID == "MER_017" | CRHID == "MER_032" | CRHID == "MER_039" | CRHID == "NEL_036" | ///
		CRHID == "NEL_037" | CRHID == "NEL_038" | CRHID == "NLO_006" | CRHID == "NWE_005" | CRHID == "NWE_016" | ///
		CRHID == "RCH_034" | CRHID == "RCH_040" | CRHID == "RCH_041" | CRHID == "KAN_016" | CRHID == "MER_002" | ///
		CRHID == "MER_003" | CRHID == "MER_018" | CRHID == "MER_019" | CRHID == "MER_025" | CRHID == "MER_030" | ///
		CRHID == "MPH_015" | CRHID == "NEL_008" | CRHID == "NEL_010" | CRHID == "NEL_012" | CRHID == "NEL_057" | ///
		CRHID == "NWE_018" | CRHID == "NWE_034" | CRHID == "QEE_004" | CRHID == "RCH_005" | CRHID == "RCH_006" | ///
		CRHID == "RCH_008" | CRHID == "RCH_009" | CRHID == "RCH_011" | CRHID == "RCH_014" | CRHID == "RCH_018" | ///
		CRHID == "RCH_019" | CRHID == "RCH_023" | CRHID == "Rch_035" | CRHID == "Rch_039" | CRHID == "BNE_013" | ///
		CRHID == "QEE_008" | CRHID == "BXE_001" | CRHID == "BXE_005" | CRHID == "BXE_006" | CRHID == "BXE_008" | ///
		CRHID == "QEE_053" | CRHID == "TOK_007" | CRHID == "BNE_033" | CRHID == "BXE_035" | CRHID == ""  

			 
* List of IDs to drop
local ids_to_drop BNE_013 QEE_008 BXE_001 BXE_005 BXE_006 BXE_008 9999998 9999998 EUB_001 EUB_002 MPH_001 MPH_002 NEL_001 NOK_001 ///
	  NOK_002 NWE_001 NWE_002 9999998 9999998 QEE_001 QEE_002 QEE_003 QEE_005 QEE_006 QEE_009 QEE_010 QEE_011 RCH_001 RCH_002 TOK_001 ///
	  TOK_002 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 ///
	  9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 ///
	  9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 NEL_003 ///
	  9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 9999998 IIB_016 ///
	  IIB_018 IIB_019 IIB_021 KAN_006 KAN_007 KAN_011 KAN_013 KAN_019 KAN_020 KAN_033 KAN_039 MER_006 MER_017 MER_032 MER_039 NEL_036 ///
	  NEL_037 NEL_038 NLO_006 NWE_005 NWE_016 RCH_034 RCH_040 RCH_041 KAN_016 MER_002 MER_003 MER_018 MER_019 MER_025 MER_030 MPH_015 ///
	  NEL_008 NEL_010 NEL_012 NEL_057 NWE_018 NWE_034 QEE_004 RCH_005 RCH_006 RCH_008 RCH_009 RCH_011 RCH_014 RCH_018 RCH_019 RCH_023 ///
	  Rch_035 Rch_039 QEE_053 TOK_007 BNE_033 BXE_035

* Drop observations with IDs in the list
drop if inlist(CRHID, `ids_to_drop')
*/

* keeping eligible participants:
keep if Eligible == "Yes" // 163 obs dropped
drop if MOD1_ELIGIBILITY_B3_B == 14 // per Gloria 9-22-23 email: dropping 14 year old who did not meet eligibility criteria
keep if MOD1_ELIGIBILITY_B7 == 1

gen country = "South Africa"

* De-identify dataset:
* MOD1_Identification_105, MOD1_Demogr_515, MOD1_Demogr_516, MOD1_Demogr_519 already dropped in this dataset

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 28)
		* STEP TW0: ADD VALUE LABELS (starts at: line 158)
		* STEP THREE: RECODING MISSING VALUES (starts at: line 496)
		* STEP FOUR: LABELING VARIABLES (starts at: line 954)
		* STEP FIVE: ORDER VARIABLES (starts at: line )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:

rename SCRNumBer pre_screening_num_za
rename (MOD1_META_DATA_A1 MOD1_META_DATA_A2 MOD1_META_DATA_A3 MOD1_META_DATA_A4 MOD1_META_DATA_A4_SD ///
		MOD1_META_DATA_A5) (interviewer_id date_m1 m1_start_time ///
	   study_site study_site_sd facility)
	   
rename (MOD1_ELIGIBILITY_B1 MOD1_ELIGIBILITY_B2 MOD1_ELIGIBILITY_B3_B MOD1_ELIGIBILITY_B3_1) ///
	   (permission care_self enrollage enrollage_cat)
	   
rename (MOD1_ELIGIBILITY_B4 MOD1_ELIGIBILITY_B5 MOD1_ELIGIBILITY_B6 MOD1_ELIGIBILITY_B7) ///
	   (zone_live b5anc b6anc_first b7eligible)

rename (CRHID MOD1_Identification_104 MOD1_Identification_106) ///
		(respondentid mobile_phone flash)
		
rename (MOD1_Health_Profile_201 MOD1_Health_Profile_202a MOD1_Health_Profile_202b ///
		MOD1_Health_Profile_202c MOD1_Health_Profile_202d MOD1_Health_Profile_202e) ///
		(m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e)
		
rename (MOD1_Health_Profile_203 MOD1_Health_Profile_204 MOD1_Health_Profile_205a ///
		MOD1_Health_Profile_205b MOD1_Health_Profile_205c MOD1_Health_Profile_205d ///
		MOD1_Health_Profile_205e) (m1_203 m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e)
		
rename (MOD1_Health_Profile_206a MOD1_Health_Profile_206b MOD1_Health_Profile_206c ///
		MOD1_Health_Profile_206d MOD1_Health_Profile_206e MOD1_Health_Profile_206f ///
		MOD1_Health_Profile_206g MOD1_Health_Profile_206h MOD1_Health_Profile_206i) ///
		(phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i)		
		
rename (MOD1_Health_Profile_207 MOD1_Health_System_Rating_301 MOD1_Health_System_Rating_302 ///
	    MOD1_Health_System_Rating_303 MOD1_Health_System_Rating_304 MOD1_Health_System_Rating_305a ///
		MOD1_Health_System_Rating_305b MOD1_Care_Pathways_401 MOD1_Care_Pathways_401_Other MOD1_Care_Pathways_402) ///
		(m1_207 m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b m1_401 m1_401_other m1_402)
		
rename (MOD1_Care_Pathways_403 MOD1_Care_Pathways_404 MOD1_Care_Pathways_405 MOD1_Care_Pathways_405_Other ///
		MOD1_Demogr_501 MOD1_Demogr_501_Other) (m1_403b m1_404 m1_405 m1_405_other m1_501 m1_501_other)

rename (MOD1_Demogr_502 MOD1_Demogr_503 MOD1_Demogr_504 MOD1_Demogr_505 MOD1_Demogr_506 MOD1_Demogr_506_Other /// 		
		MOD1_Demogr_507 MOD1_Demogr_507_Other MOD1_Demogr_508 MOD1_Demogr_509a MOD1_Demogr_509b MOD1_Demogr_510a /// 	
		MOD1_Demogr_510b MOD1_Demogr_511 MOD1_Demogr_512) (m1_502 m1_503 m1_504 m1_505 m1_506 m1_506_other m1_507 ///
		m1_507_other m1_508 m1_509a m1_509b m1_510a m1_510b m1_511 m1_512)
		
rename (MOD1_Demogr_513a MOD1_Demogr_514a) (m1_513a m1_514a)	
		
rename (MOD1_Demogr_517 MOD1_Demogr_518) (m1_517 m1_518) 		
rename (MOD1_User_Exp_601 MOD1_User_Exp_602 MOD1_User_Exp_603 MOD1_User_Exp_604) (m1_601 m1_602 m1_603 m1_604)		

rename (MOD1_User_Exp_605a MOD1_User_Exp_605b MOD1_User_Exp_605c MOD1_User_Exp_605d MOD1_User_Exp_605e MOD1_User_Exp_605f MOD1_User_Exp_605g MOD1_User_Exp_605h) (m1_605a m1_605b m1_605c m1_605d m1_605e ///
		m1_605f m1_605g m1_605h)
		
rename (MOD1_Cont_Care_700 MOD1_Cont_Care_701 MOD1_Cont_Care_702 MOD1_Cont_Care_703 MOD1_Cont_Care_704 ///
		MOD1_Cont_Care_705 MOD1_Cont_Care_706 MOD1_Cont_Care_707 MOD1_Cont_Care_708a MOD1_Cont_Care_708b ///
		MOD1_Cont_Care_708c MOD1_Cont_Care_708d) (m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 ///
		m1_708a m1_708b m1_708c m1_708d)
		
rename (MOD1_Cont_Care_708e MOD1_Cont_Care_708f MOD1_Cont_Care_709a MOD1_Cont_Care_709b MOD1_Cont_Care_710a ///
		MOD1_Cont_Care_710b MOD1_Cont_Care_710c MOD1_Cont_Care_711a MOD1_Cont_Care_711b MOD1_Cont_Care_712 ///
		MOD1_Cont_Care_713a) (m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 ///
		m1_713a)	
		
rename 	(MOD1_Cont_Care_713b MOD1_Cont_Care_713c MOD1_Cont_Care_713e MOD1_Cont_Care_713f MOD1_Cont_Care_713g ///
		MOD1_Cont_Care_713i MOD1_Cont_Care_713d MOD1_Cont_Care_713j MOD1_Cont_Care_713k) (m1_713_za_in m1_713b ///
		m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i)
		
rename (MOD1_Cont_Care_713h MOD1_Cont_Care_713l MOD1_Cont_Care_714a MOD1_Cont_Care_714b MOD1_Cont_Care_714c ///
		MOD1_Cont_Care_714d MOD1_Cont_Care_714e) (m1_713k m1_713l m1_714a m1_714b m1_714c m1_714d m1_714e)	
	
rename (MOD1_Cont_Care_715 MOD1_Cont_Care_716a MOD1_Cont_Care_716b MOD1_Cont_Care_716c MOD1_Cont_Care_716d ///
		MOD1_Cont_Care_716e MOD1_Cont_Care_717 MOD1_Cont_Care_718 MOD1_Cont_Care_719 MOD1_Cont_Care_720 MOD1_Cont_Care_721 ///
		MOD1_Cont_Care_722 MOD1_Cont_Care_723 MOD1_Cont_Care_724a MOD1_Cont_Care_724b MOD1_Cont_Care_724c MOD1_Cont_Care_724d ///
		MOD1_Cont_Care_724e MOD1_Cont_Care_724f MOD1_Cont_Care_724g MOD1_Cont_Care_724h MOD1_Cont_Care_724i MOD1_Current_Preg_801) ///
		(m1_715 m1_716a m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724b m1_724c ///
		m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801)		

rename (MOD1_Current_Preg_802 MOD1_Current_Preg_803 MOD1_Current_Preg_804 MOD1_Current_Preg_805 MOD1_Current_Preg_806 ///
		MOD1_Current_Preg_807) (m1_802a m1_803 m1_804 m1_805 m1_806 m1_807)	
			
rename (MOD1_Current_Preg_808 MOD1_Current_Preg_808_Other MOD1_Current_Preg_809 MOD1_Current_Preg_810a MOD1_Current_Preg_810b) ///
		(m1_808 m1_808_other m1_809 m1_810a m1_810b)
		
rename (MOD1_Current_Preg_811 MOD1_Current_Preg_812a MOD1_Current_Preg_812b MOD1_Current_Preg_813a MOD1_Current_Preg_813b) ///
		(m1_811 m1_812a m1_812b m1_813a m1_813b)
		
rename (MOD1_Current_Preg_814a MOD1_Current_Preg_814b MOD1_Current_Preg_814c MOD1_Current_Preg_814d MOD1_Current_Preg_814e ///
		MOD1_Current_Preg_814f MOD1_Current_Preg_814g MOD1_Current_Preg_814h) (m1_814a m1_814b m1_814c m1_814d m1_814e ///
		m1_814f m1_814g m1_814h)	
		
rename (MOD1_Current_Preg_815 MOD1_Current_Preg_815_Other MOD1_Current_Preg_816 MOD1_RiskyHealth_BEH_901 MOD1_RiskyHealth_BEH_902) ///
		(m1_815 m1_815_other m1_816 m1_901 m1_902)
		
rename (MOD1_RiskyHealth_BEH_905 MOD1_RiskyHealth_BEH_906 MOD1_RiskyHealth_BEH_907 MOD1_RiskyHealth_BEH_908 MOD1_RiskyHealth_BEH_909 ///
		MOD1_RiskyHealth_BEH_910 MOD1_OBS_History_1001 MOD1_OBS_History_1002 MOD1_OBS_History_1003 MOD1_OBS_History_1004  ///
		MOD1_OBS_History_1005 MOD1_OBS_History_1006) (m1_905 m1_906 m1_907 m1_908_za m1_909_za m1_910_za m1_1001 m1_1002 ///
		m1_1003 m1_1004 m1_1005 m1_1006)
		
rename (MOD1_OBS_History_1007 MOD1_OBS_History_1008 MOD1_OBS_History_1009 MOD1_OBS_History_1010 MOD1_OBS_History_1011a  ///
		MOD1OBS_History_1011b MOD1_OBS_History_1011c MOD1_OBS_History_1011d MOD1_OBS_History_1011e MOD_OBS_History_1011f ///
		MOD1_GBV_1101 MOD1_GBV_1102 MOD1_GBV_1102_Other MOD1_GBV_1103 MOD1_GBV_1104 MOD1_GBV_1104_Other) (m1_1007 m1_1008 ///
		m1_1009 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1102 m1_1102_other m1_1103 m1_1104 m1_1104_other)
		
rename (MOD1_GBV_1105 MOD1_Econ_Status_1201 MOD1_Econ_Status_1201_Other MOD1_Econ_Status_1202 MOD1_Econ_Status_1202_Other  ///
		MOD1_Econ_Status_1203 MOD1_Econ_Status_1204 MOD1_Econ_Status_1205 MOD1_Econ_Status_1206 MOD1_Econ_Status_1207) (m1_1105 ///
		m1_1201 m1_1201_other m1_1202 m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207)
		
rename (MOD1_Econ_Status_1208 MOD1_Econ_Status_1208_Other MOD1_Econ_Status_1209 MOD1_Econ_Status_1209_Other MOD1_Econ_Status_1210  ///
		MOD1_Econ_Status_1210_Other MOD1_Econ_Status_1211 MOD1_Econ_Status_1211_Other MOD1_Econ_Status_1212 MOD1_Econ_Status_1213  ///
		MOD1_Econ_Status_1214 MOD1_Econ_Status_1215 MOD1_Econ_Status_1216) (m1_1208 m1_1208_other m1_1209 m1_1209_other m1_1210 ///
		m1_1210_other m1_1211 m1_1211_other m1_1212 m1_1213 m1_1214 m1_1215 m1_1216a)		

rename (MOD1_Econ_Status_1217 MOD1_Econ_Status_1218A MOD1_Econ_Status_1218B MOD1_Econ_Status_1218C MOD1_Econ_Status_1218D  ///
		MOD1_Econ_Status_1218E MOD1_Econ_Status_1218F) (m1_1217 m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f_other)		

rename (MOD1_Econ_Status_1218f_Other_Amo MOD1_Econ_Status_1218G_TOTAL MOD1_Econ_Status__1219) (m1_1218f_1 m1_1218g m1_1219)		

rename (MOD1_Econ_Status_1220 MOD1_Econ_Status_1220_Other MOD1_Econ_Status_1221 MOD1_Econ_Status_1222 MOD1_Econ_Status_1223 ///
		MOD1_Physical_Assessment_1301 MOD1_Physical_Assessment_1302) (m1_1220 m1_1220_other m1_1221 m1_1222 m1_1223 height_cm weight_kg)

rename (MOD1_Physical_Assessment_1303a MOD1_Physical_Assessment_1303b MOD1_Physical_Assessment_1303c MOD1_Physical_Assessment_1304a  ///
		MOD1_Physical_Assessment_1304b MOD1_Physical_Assessment_1304c MOD1_Physical_Assessment_1305a MOD1_Physical_Assessment_1305b ///
		MOD1_Physical_Assessment_1305c) (bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic ///
		time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3)
		
rename (MOD1Physical_Assessment_1306 MOD1_Physical_Assessment_1307 MOD1_Physical_Assessment_1308 MOD1_Physical_Assessment_1309 ///
		MOD1_Next_Call_1401) (m1_1306 m1_1307 m1_1308 m1_1309 m1_1401)	
		
rename (N202a N202b N202c N202d N202e Specify ) (m1_202a_2_za m1_202b_2_za m1_202c_2_za m1_202d_2_za m1_202e_2_za m1_203_2_za ) // recollected HIV Qs
		encode N204a , g(m1_204_2_za)  
		encode N204b , g(m1_204b_za)
		encode N708a , g(m1_708a_2_za)
		encode N708b , g(m1_708b_2_za)
		encode N708c , g(m1_708c_2_za)
		encode N708d , g(m1_708d_2_za)
		encode N708e , g(m1_708e_2_za)
		encode N708f , g(m1_708f_2_za)
		encode N709a , g(m1_709a_2_za)
		encode N709b , g(m1_709b_2_za)
		
		recode m1_204_2_za 1=0 2=1 3=.
		recode m1_204b_za 1=0 2=1 3/5=.
		recode m1_708a_2_za 1=0 2=1 3/5=.
		recode m1_708b_2_za 1=. 2=1 3=2 4/5=. 
		recode m1_708c_2_za 1=0 2=1 3/5=.
		recode m1_708d_2_za 1=0 2=1 3/5=.
		recode m1_708e_2_za 1=0 2=1 3/5=.
		recode m1_708f_2_za 1=0 2=1 3/5=.
		recode m1_709a_2_za 1=0 2=1 3/5=.
		recode m1_709b_2_za 1=0 2=1 3/5=.
	
* Fix variables:
replace m1_714d = "21" if m1_714d == "2002"
replace m1_714d = "6" if m1_714d == "2017"
destring(m1_714d), generate(recm1_714d)

destring(m1_714c), generate(recm1_714c)

replace m1_714e = "17" if m1_714e == "2006"
replace m1_714e = "15" if m1_714e == "2008"
replace m1_714e = "14" if m1_714e == "2009"
replace m1_714e = "12" if m1_714e == "2011"
replace m1_714e = "11" if m1_714e == "2012"
replace m1_714e = "9" if m1_714e == "2014"
replace m1_714e = "8" if m1_714e == "2015"
replace m1_714e = "7" if m1_714e == "2016"
replace m1_714e = "6" if m1_714e == "2017"
replace m1_714e = "5" if m1_714e == "2018"
replace m1_714e = "4" if m1_714e == "2019"
replace m1_714e = "3" if m1_714e == "2020"
replace m1_714e = "2" if m1_714e == "2021"
replace m1_714e = "1" if m1_714e == "2022"
destring(m1_714e), generate(recm1_714e)

replace m1_604 = "." if m1_604 == ""
replace m1_604 = "1" if m1_604 == "1 hour"
destring(m1_604), generate(recm1_604)

replace facility = "TOK" if facility == "ROK"

replace m1_802a = "12/13/2023" if m1_802a == "12-/13/2023"
replace m1_802a = ".d" if m1_802a == "98"

replace m1_909_za = "." if m1_909_za == ""


gen recm1_802a = date(m1_802a, "MDY")
format recm1_802a %td
format date_m1 %td

drop if recm1_802a < date_m1

* Fixing hemoglobin levels
replace m1_1307 =  m1_1307/10 if m1_1307>=44 & m1_1307<=215
replace m1_1307=. if m1_1307==891
replace m1_1307= m1_1307/100 if m1_1307>=1111 & m1_1307<=1246

replace m1_1309=. if m1_1309==0
replace m1_1309 =  m1_1309/10 if m1_1309>=37 & m1_1309<=215
replace m1_1309 =  m1_1309/100 if m1_1309==1226

replace m1_723 = ".a" if m1_723 == "NA"
destring(m1_723), generate(recm1_723)

*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS 
	
	** MODULE 1:
* Label district values 
encode study_site, generate(recstudy_site)
label define study_site 1 "D1: King Cetshwayo District" 2 "D2: Zululand District"  
label values recstudy_site study_site


* Label sub-district values - confirm because SD1 is second choice on pdf
encode study_site_sd, generate(recstudy_site_sd)
label define study_site_sd 1 "SD1: uMhlathuze Local Municipality" 2 "SD2: Nongoma Local Municipality"  
label values recstudy_site_sd study_site_sd


* Label Facility Name values -confirm with the next install of data
** no data for BNH? in data dictionary
** what is ROK?
encode facility, generate(recfacility)
label define facility 1 "Buchanana Clinic (BCH)" 2 "Benedictine Gateway Clinic (BNE)" ///
					  3 "Buxedene Clinic (BXE)" 4 "Ekubungazeleni Clinic (EUB)" 5 "Isiboniso Clinic (IIB)" ///
					  6 "Khandisa Clinic (KAN)" 7 "Mabamba Clinic (MBA)" 8 "Meerensee Clinic (MER)" ///
					  9 "Mandlanzini Clinic (MND)" 10 "Maphophoma Clinic (MPH)" 11 "Nseleni CHC (NEL)" ///
					  12 "Ndlozana Clinic (NLO)" 13 "Njoko Clinic (NOK)" 14 "Nkunzana Clinic (NUN)" ///
					  15 "Ntuze Clinic (NUZ)" 16 "Ngwelezana Clinic (NWE)" 17 "Phaphamani Clinic (PAP)" ///
					  18 "Queen Nolonolo Clinic (QEE)" 19 "Richards Bay Clinic (RCH)" ///
					  20 "Thokozani Clinic (TOK)" 21 "Umkhontokayise Clinic (UKH)" 22 "Usuthu Clinic (UUT)"
label values recfacility facility


* eligiblity vars:
label define permission 1 "Yes" 0 "No"
label values permission permission 

label define care_self 1 "For myself" 0 "For someone else"
label values care_self care_self 

label define enrollage_cat 1 "Yes" 0 "No"
label values enrollage_cat enrollage_cat

label define b5anc 1 "Yes" 0 "No"
label values b5anc b5anc

label define b6anc_first 1 "Yes" 0 "No"
label values b6anc_first b6anc_first

label define b7eligible 1 "Eligible and signed consent" 2 "Eligible but did not consent - STOP, end survey" ///
						3 "Eligible but does not understand [language spoken by interviewer] - STOP, end survey" ///
						0 "Ineligible - STOP, end survey"
label values b7eligible b7eligible

label define mobile_phone 1 "Yes" 0 "No" 99 "NR/RF"
label values mobile_phone mobile_phone

label define flash 1 "Flash successful" 2 "Unsuccessful, reenter phone number" ///
				   3 "Respondent did not give permission for flash"
label values flash flash


 ** Repeated Data Value Labels 
   * Label likert scales 
label define likert 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" ///
	 99 "NR/RF"
	 
     * Label values for variables with Likert values 
label values m1_201 m1_301 m1_601 likert 
label values m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h likert
	   	 
* Label Yes/No 
	 label define YN 1 "Yes" 0 "No" 98 "Don't know" 99 "NF/RF" 
	 label define YN2 1 "Yes" 0 "No" 
	 label define YN3 1 "Yes" 0 "No" 3 "Don't Know"
	 label define YN4 1 "Yes" 0 "No" 99 "Don't Know"
	 
	 label values m1_202a m1_202b m1_202c m1_202d m1_202e m1_204 m1_202a_2_za m1_202b_2_za m1_202c_2_za m1_202d_2_za m1_202e_2_za m1_204_2_za m1_204b_za YN 	 
	 label values m1_502 m1_509a m1_510a m1_514a YN2 
	 label values m1_509b YN3
	 label values m1_510b YN4
	 
	 label values m1_700 m1_701 m1_702 m1_703 m1_705 m1_706 m1_707 m1_708a m1_708a_2_za YN
	 label values m1_708c  m1_708c_2_za m1_708d  m1_708d_2_za m1_708e  m1_708e_2_za  m1_708f m1_708f_2_za  m1_709a m1_709a_2_za m1_709b  m1_709b_2_za m1_710a YN 
	 label values m1_711a m1_712 m1_714a m1_714b YN 
	 label values m1_716a m1_716b m1_716c m1_716d m1_716e YN
   	 label values m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 recm1_723 YN 
	 label values m1_724a m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i YN
	 label values m1_801 m1_806 m1_809 m1_811 m1_812a YN
	 label values m1_813a m1_813b m1_816 YN
	 label values m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h YN
	 label values m1_905 m1_907 YN

	 label values m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 m1_1010 YN
	 label values m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f YN
	 label values m1_1101 m1_1103 m1_1105 YN
	 label values m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1212 m1_1213 m1_1214 m1_1215 YN 
	 label values m1_1217 YN
	 label values m1_1219 YN2
	 label values m1_1221 YN
	 label values m1_1308 YN2

* Labels for EQ5D - copied from ET	 
     label define EQ5D 1 "I have no problems" 2 "I have some problems" ///
					   3 "I have severe problems" 99 "NR/RF" 
	 label define EQ5Dpain 1 "I have no pain" 2 "I have some pain" ///
						   3 "I have severe pain" 99 "NR/RF" 
	 label define EQ5Danxiety 1 "I have no anxiety" 2 "I have some anxiety" ///
							  3 "I have severe anxiety" 99 "NR/RF" 
	 
	 label values m1_205a m1_205b m1_205c EQ5D
	 label values m1_205d EQ5Dpain
	 label values m1_205e EQ5Danxiety
	
* Labels for PHQ9
	label define phq 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" ///
				 3 "Nearly every day" 99 "NR/RF"
	label values phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i phq


	label define hsview 1 "System works pretty well, minor changes" ///
	                    2 "Some good things, but major changes are needed" ///
						3 "System has so much wrong with it, completely rebuild it" 
	label values m1_302 hsview

	label define confidence 1 "Very confident" ///
	                        2 "Somewhat confident" ///
							3 "Not very confident" ///
							4 "Not at all confident" ///
							99 "NR/RF"
	label values m1_303 m1_304 m1_305a m1_305b confidence 


* QoC labels 
	label define recommend 1 "Very likely" 2 "Somewhat likely" 3 "Not too likely" ///
						   4 "Not at all likely" 99 "NR/RF" 
	label values m1_602 recommend
   
	label define satisfaction 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" ///
							  4 "Dissatisfied" 5 "Very dissatisfied" 98 "DK" 99 "NR/RF" 
	label values m1_1223 satisfaction

label define travel_mode 1 "Walking" 2 "Bicycle" 3 "Motorcycle" 4 "Car (personal or borrowed)" ///
						 5 "Bus/train/other public transportation" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
label values m1_401 travel_mode

label define bypass 1 "Yes, its the nearest" 2 "No, theres another one closer" 98 "DK" 99 "NR/RF" 
label values m1_404 bypass 

label define reason_anc 1 "Low cost" 2 "Short distance" 3 "Short waiting time" ///
					    4 "Good healthcare provider skills" 5 "Staff shows respect" ///
						6 "Medicines and equipment are available" 7 "Cleaner facility" ///
						8 "Only facility available" 9 "Covered by insurance" ///
						10 "Were referred or told to use this provider" 96 "Other, specify" 99 "NR/RF" 
label values m1_405 reason_anc

* Demographic value labels 
label define language 1 "IsiZulu" 2 "IsiXhosa" 3 "English" 4 "Afrikaans" 5 "Setswana" 6 "IsiNdebele" ///
						7 "Siswati" 8 "Nothern Sotho (Sepedi)" 9 "Southern Sotho (Sesotho)" 10 "Tshivenda" ///
						11 "Xitsonga" 96 "Other, specify" 99 "NR/RF" 
label values m1_501 language

label define education 1 "Some primary" 2 "Completed primary" 3 "Some secondary" 4 "Completed secondary" 5 "Higher education" 
label values m1_503 education

label define literacy 1 "Cannot read at all" 2 "Able to read only parts of sentence" ///
					  3 "Able to read whole sentence" 4 "Blind/visually impaired" ///
					  99 "NR/RF" 
label values m1_504 literacy

label define marriage 1 "Never married" 2 "Widowed" 3 "Divorced" 4 "Separated" 5 "Currently married" 6 "Living with partner as if married" 99 "NR/RF" 
label values m1_505 marriage 

label define occupation 1 "Government employee" 2 "Private employee" 3 "Non-government employee" ///
						4 "Merchant/Trader" 5 "Farmer/farmworker/pastoralist" 6 "Homemaker/housewife" ///
						7 "Student" 8 "Laborer" 9 "Domestic worker" 10 "Unemployed" 96 "Other, specify" ///
						98 "DK" 99 "NR/RF"
label values m1_506 occupation

label define religion 1 "Christian" 2 "Muslim" 3 "Hindu" 4 "Buddhism" 5 "African religion" ///
					  6 "No religion" 96 "Other, specify" 98 "DK" 99 "RF"
label values m1_507 religion



label define diarrhea  1 "Less than usual" 2 "More than usual" 3 "About the same" 4 "It doesnt matter" 99 "DK" 
label values m1_511 diarrhea 

label define smoke 1 "Good" 2 "Harmful" 3 "Doesnt matter"  
label values m1_512 smoke 

label define residence 1 "Temporary" 2 "Permanent"
label values m1_517 residence

label define test_result 1 "Positive" 2 "Negative" 98 "DK" 99 "RF" 
label values m1_708b  m1_708b_2_za m1_710b test_result

recode m1_704 (2 = 0)
lab values m1_704 YN

label define m1_710c 1 "Provider gave it directly" ///
					 2 "Provider gave a prescription or told you to get it somewhere else" ///
					 3 "Neither" 98 "Don't Know" 88 "NR/RF"
label values m1_710c m1_710c

label define bdsugartest 1 "Blood sugar was high/elevated" 2 "Blood sugar was normal" 98 "DK" 99 "NR/RF"
label values m1_711b bdsugartest

label define meds 1 "Provider gave it directly" ///
				  2 "Provider gave a prescription or told you to get it somewhere else" ///
				  3 "Neither" 98 "DK" 99 "NR/RF" 
label values m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713k m1_713l meds

lab def m1_713_za_in 0 "Provider gave it directly" 1 "Provider gave a prescription or told you to get it somewhere else" 2 "Neither" 3 "Don't know" 4 "NR/RF"
lab var m1_713_za_in m1_713_za_in

label define itn 1 "Yes" 0 "No" 2 "Already have one"
label values m1_715 itn

label define trimester 1 "First trimester" 2 "Second trimester" 3 "Third trimester"
label values m1_804 trimester

label define numbabies 1 "One baby" 2 "Two babies (twins)" ///
					   3 "Three or more babies (triplets or higher)" 98 "DK" 99 "NR/RF"
label values m1_805 numbabies 

recode m1_807 (2 = 0)
label define m1_807 1 "Yes" 0 "No" 99 "NR/RF"
label values m1_807 m1_807

label define m1_808 0 "Didn't realize you were pregnant" 1 "Tried to come earlier and were sent away" ///
					2 "You received care at home" ///
					3 "High cost (e.g., high out of pocket payment, not covered by insurance)" ///
					4 "Far distance (e.g., too far to walk or drive, transport not readily available)" ///
					5 "Long waiting time (e.g., long line to access facility, long wait for the provider)" ///
					6 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" ///
					7 "Staff don't show respect (e.g., staff is rude, impolite, dismissive" ///
					8 "Medicines and equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machinesbroken or unavailable)" ///
					9 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)" ///
					10 "COVID-19 fear" 11 "Don't know where to go (e.g., too complicated" ///
					12 "Fear of discovering serious problems" 96 "Other, specify" ///
					99 "NR/RF" 95 "Not applicable"
label values m1_808 m1_808					

label define m1_810a 1 "In your home" 2 "Someone elses home" 3 "Public clinic" ///
					 4 "Public hospital" 5 "Private clinic" ///
					 6 "Private hospital" 7 "Public Community health center" ///
					 8 "Other" 98 "DK" 99 "NR/RF" 
	
label values m1_810a m1_810a

label define m1_812b 1 "I was not told why" 2 "Because I had a c-section before" ///
			 3 "Because I am pregnant with more than one baby" ///
			 4 "Because of the baby's position" 5 "Because of the position of the placenta" ///
			 6 "Because I have health problems" 96 "Other, specify" 98 "Don't know" 99 "NR/RF"
label values m1_812b m1_812b

* confirm
label define m1_815 1 "Nothing, we did not discuss this" ///
					2 "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)" ///
					3 "They provided a treatment in the visit" 4 "They prescribed a medication" ///
					5 "They told you to come back to this health facility" 6 "They told you to go somewhere else for higher level care" ///
					7 "They told you to wait and see" 96 "Other, specify" 98 "Don't Know" 99 "NR/RF"
label values m1_815 m1_815
					
label define smokeamt 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "NR/RF" 
label values m1_901 smokeamt	

recode m1_902 (2 = 0)
lab values m1_902 YN				

* confirm value "12"					
label define m1_1102 1 "Current husband/partner" 2 "Mother/Father" 3 "Step-mother" ///
					 4 "Step-father" 5 "Sister" 6 "Brother" 7 "Daughter" 8 "Son" ///
					 9 "Late /last / ex-husband/partner" 10 "Current boyfriend" ///
					 11 "Former boyfriend" 12 "Mother-in-law/Father-in-law" ///
					 13 "Other female relative/in-law" 14 "Other male relative/in-law" ///
					 15 "Female friend / acquaintance" 16 "Male friend / acquaintance" ///
					 17 "Teacher" 18 "Employer" 19 "Stranger" 96 "Other, specify"
label values m1_1102 m1_1102					
					
					
label define m1_1104 1 "Current husband/partner" 2 "Mother/Father" 3 "Step-mother" ///
					 4 "Step-father" 5 "Sister" 6 "Brother" 7 "Daughter" 8 "Son" ///
					 9 "Late /last / ex-husband/partner" 10 "Current boyfriend" ///
					 11 "Former boyfriend" 12 "Mother-in-law/Father-in-law" ///
					 13 "Other female relative/in-law" 14 "Other male relative/in-law" ///
					 15 "Female friend / acquaintance" 16 "Male friend / acquaintance" ///
					 17 "Teacher" 18 "Employer" 19 "Stranger" 96 "Other, specify"
label values m1_1104 m1_1104					 
					
label define water_source 1 "Piped water" 2 "Water from open well" ///
						  3 "Water from covered well or borehole" 4 "Surface water" ///
						  5 "Rain water" 6 "Bottled water" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 	
label values m1_1201 water_source

label define toilet 1 "Flush or pour flush toilet" 2 "Pit toilet/latrine" ///
					3 "No facility" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
label values m1_1202 toilet	

label define cook_fuel 1 "Main electricity" 2 "Bottled gas" 3 "Paraffin/kerosene" ///
					   4 "Coal/Charcoal" 5 "Firewood" 6 "Dung" 7 "Crop residuals" ///
					   8 "Solar" 96 "Other (specify)" 98 "DK" 99 "NR/RF" 
label values m1_1208 cook_fuel

label define floor 1 "Natural floor (earth, dung)" 2 "Rudimentary floor (wood planks, palm)" ///
				   3 "Finished floor (polished wood, tiles, cement, vinyl)" ///
				   96 "Other (specify)" 98 "DK" 99 "NR/RF"	
label values m1_1209 floor

label define walls 1 "Grass" 2 "Poles and mud" 3 "Sun-dried bricks" 4 "Baked bricks" ///
				   5 "Timber" 6 "Cement bricks" 7 "Stones" 8 "Corrugated iron" ///
				   96 "Other (specify)" 98 "DK" 99 "NR/RF"
label values m1_1210 walls

label define roof 1 "No roof" 2 "Grass/leaves/mud" 3 "Iron sheets" 4 "Tiles" 5 "Concrete" ///
				  96 "Other (specify)" 98 "DK" 99 "NR/RF" 
label values m1_1211 roof

label define DK_NR_RF 98 "Don't Know" 99 "NR/RF"
label values m1_1216 DK_NR_RF

label define m1_1220 1 "Current income of any household members" 2 "Savings (e.g. bank account)" ///
					 3 "Payment or reimbursement from a health insurance plan" ///
					 4 "Sold items (e.g. furniture, animals, jewellery)" ///
					 5 "Family members or friends from outside the household" /// 
					 6 "Borrowed (from someone other than a friend or family)" ///
					 96 "Other, specify"
label values m1_1220 m1_1220

label define m1_1306 1 "Yes" 0 "No" 96 "Women does not have a maternal health card"
label values m1_1306 m1_1306

label define m1_1401 1 "Morning" 2 "Midday" 3 "Afternoon" 4 "Evening"
label values m1_1401 m1_1401

*------------------------------------------------------------------------------*
* drop variables after recoding/renaming

drop study_site study_site_sd facility m1_604 m1_802a m1_714c m1_714d m1_714e m1_723
ren rec* *

*===============================================================================
		
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)

	** MODULE 1:

recode m1_404 m1_506 m1_507 m1_700 m1_701 m1_702 m1_703 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c ///
	  m1_708d m1_708e m1_708f m1_709a m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713c ///
	  m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713k m1_713l m1_714a m1_714b m1_714c m1_716a m1_716b ///
	  m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d ///
	  m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_803 m1_805 m1_806 m1_809 m1_810a m1_811 m1_812a m1_812b  ///
	  m1_813a m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_815 m1_816 m1_901 ///
	  m1_902 m1_907 m1_908_za m1_1004 m1_1005 m1_1006 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e ///
	  m1_1011f m1_1201 m1_1202 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 ///
	  m1_1213 m1_1214 m1_1215 m1_1216 m1_1223 (98 = .d)

recode mobile_phone m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_204 m1_205a m1_205b m1_205c ///
	   m1_205d m1_205e phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i ///
	   m1_301 m1_303 m1_304 m1_305a m1_305b m1_401 m1_404 m1_405 m1_501 m1_503 m1_504 m1_505 ///
	   m1_506 m1_507 m1_601 m1_602 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h ///
	   m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e ///
	   m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713a m1_713c m1_713d ///
	   m1_713e m1_713f m1_713g m1_713h m1_713i m1_713k m1_713l m1_714a m1_714b m1_716a m1_716b ///
	   m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d ///
	   m1_724e m1_724f m1_724g m1_724h m1_724i m1_803 m1_805 m1_807 m1_808 m1_810a m1_812b m1_813a m1_813b ///
	   m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_815 m1_816 m1_901 m1_902 m1_905 ///
	   m1_907 m1_1004 m1_1005 m1_1006 m1_1008 m1_1010 m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f ///
	   m1_1101 m1_1103 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 ///
	   m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1216 m1_1217 m1_1221 (99 = .r)

	   
recode m1_509b m1_713b (3 = .d)	

recode m1_510b m1_1105 (99 = .d)   

recode m1_713b (4 = .r)

recode m1_808 (95 = .a)

recode m1_1223 (96 = .r)
	   
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
*replace phone_number = ".a" if mobile_phone == 0 | mobile_phone == . 

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

*recode m1_517 (. = .a) if m1_516 == "." | m1_516 == "9999998" | m1_516 == ""
recode m1_518 (. 9978082 = .a) if m1_517 == 2 | m1_517 == . | m1_517 == .a
*replace m1_519a = ".a" if m1_517 == 2 | m1_517 == . | m1_517 == .a

* confirm how to add skip patterns here since there are multiple answers seperated by a comma
* also 513b-513i are not in the dataset
*recode m1_513b m1_513c m1_513d m1_513e m1_513f m1_513g m1_513h m1_513i if m1_513a == . 

* SS: it looks like this question is asked to women with no personal phone mq_513a_za>2 but this is a checkbox var
*recode m1_514a (. = .a) if m1_513a == "." 
	   	   
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
replace m1_802a = .a if m1_801 == . | m1_801 ==0 | m1_801 ==.a | m1_801 ==.d
recode m1_804 (. 9999998 = .a) if (m1_801 == 0 | m1_801 == . | m1_801 == .d) & (m1_802a == . | m1_802a == .a) & (m1_803 == . | m1_803 == .d | m1_803 == .r)
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

replace m1_1209_other = ".a" if m1_1209 != 96	

replace m1_1210_other = ".a" if m1_1210 != 96	

replace m1_1211_other = ".a" if m1_1211 != 96	

recode m1_1218a_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == .

recode m1_1218b_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218c_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218d_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218e_1 (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218f_other (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == .

recode m1_1218f_1 (. 9999998= .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1218g (. 9999998 = .a) if m1_1217 == 0 | m1_1217 == . 

recode m1_1219 (. 9999998 = .a) if (m1_1218a_1 == .a | m1_1218a_1 == .) & ///
						   (m1_1218b_1 == .a | m1_1218b_1 == .) & ///
						   (m1_1218c_1 ==.a | m1_1218c_1 == .) & ///
						   (m1_1218d_1 == .a | m1_1218c_1 == .) & ///
						   (m1_1218e_1 == .a | m1_1218e_1 == .) & ///
						   (m1_1218f_other == .a | m1_1218f_other == .) & ///
						   (m1_1218f_1 == .a | m1_1218f_1 == .) & ///
						   (m1_1218g == .a | m1_1218g ==.)
    
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
*replace phone_number = "." if phone_number == "9999998"
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
replace m1_513a = "." if m1_513a == ""
replace m1_513a = "." if m1_513a == "9999998"

* SS: this could change once we figure out how to use checkbox data. Technically women with a personal phone wouldn't have been asked this question
replace m1_514a = . if m1_514a == 9999998 
*replace m1_515_address = "." if m1_515_address == "9999998"
*replace m1_516 = "." if m1_516 == "9999998"
replace m1_517 = . if m1_517 == 9999998
*replace m1_519a = ".a" if m1_519a == "9999998"
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
replace m1_713_za_in = . if m1_713_za_in == 9999998
replace m1_713b = . if m1_713b == 9999998
replace m1_713c = . if m1_713c == 9999998
replace m1_713d = . if m1_713d == 9999998
replace m1_713e = . if m1_713e == 9999998
replace m1_713f = . if m1_713f == 9999998
replace m1_713h = . if m1_713h == 9999998
replace m1_713i = . if m1_713i == 9999998
replace m1_713l = . if m1_713l == 9999998
replace m1_713k = . if m1_713k == 9999998
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

* SS: due to skip patterns, only people who answered "yes" to 204 were asked 723… but nearly everyone has 9999998 as an answer 
replace m1_723 = . if m1_723 == 9999998

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
replace m1_802a = . if m1_802a == 9999998
replace m1_803 = . if m1_803 == 9999998
replace m1_804 = . if m1_804 == 9999998
replace m1_805 = . if m1_805 == 9999998
replace m1_806 = . if m1_806 == 9999998
replace m1_807 = . if m1_807 == 9999998

* SS: N=306 people in 2nd and 3rd trimester have 9999998 in data for 808
replace m1_808 = . if m1_808 == 9999998

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

* SS: N=459 people with no symptoms reported "9999998"
replace m1_816 = . if m1_816 == 9999998

replace m1_901 = . if m1_901 == 9999998
replace m1_902 = . if m1_902 == 9999998
replace m1_905 = . if m1_905 == 9999998
replace m1_906 = . if m1_906 == 9999998
replace m1_907 = . if m1_907 == 9999998
replace m1_908_za = . if m1_908_za == 9999998 | m1_908_za == 99999998
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
replace m1_1209_other = "." if m1_1209_other == "9999998"
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
replace m1_1218f_other = . if m1_1218f_other == 9999998
replace m1_1218f_1 = . if m1_1218f_1 == 9999998
replace m1_1218g = . if m1_1218g == 9999998
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
lab var enrollage_cat "B3a. Are you 15 years or older?"
lab var zone_live "B4. In which zone/district/ sub city are you living?"
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
lab var m1_202a "202.a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202.b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202.c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202.d BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202.e BEFORE you got pregnant, did you know that you had HIV?"
lab var m1_202a_2_za "Recollected 202.a Diabetes"
lab var m1_202b_2_za "Recollected 202.b HBP"
lab var m1_202c_2_za "Recollected 202.c Cardia problem"
lab var m1_202d_2_za "Recollected 202.d Mental health disorder"
lab var m1_202e_2_za "Recollected 202.e HIV"
lab var m1_203_2_za "Recollected 203. Other major health problem"
lab var m1_203 "203. Before you got pregnant, were you diagnosed with any other major health problems?"
lab var m1_204 "204. Are you currently taking any medications?"
lab var m1_204_2_za "204. Recollected medications"
lab var m1_204b_za "204b. Were you taking ARV medication before pregnancy?"
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
lab var m1_513a "513a. What phone numbers can we use to reach you in the coming months?"
lab var m1_514a "514a. We would like you to be able to participate in this study. We can give you a mobile phone for you to take home so that we can reach you. Would you like to receive a mobile phone?"
*lab var m1_515_address "515. Can you please tell me where you live? What is your address?"
*lab var m1_516 "516. Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions"
lab var m1_517 "517. Is this a temporary residence or a permanent residence?"
lab var m1_518 "518. Until when will you be at this residence?"
*lab var m1_519a "519a. Where will your district be after this date "
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
lab var m1_708a_2_za "Recollected 708a HIV test"
lab var m1_708b_2_za "Recollected 708b. Result of HIV test"
lab var m1_708c_2_za "Recollected 708c. Medicine for HIV"
lab var m1_708d_2_za "Recollected 708d. Explained how to the medicine for HIV"
lab var m1_708e_2_za "Recollected 708e. IV viral load test"
lab var m1_708f_2_za "Recollected 708f. CD4 test"
lab var m1_709a_2_za "Recollected 709a HIV viral load test"
lab var m1_709b_2_za "Recollected 709b CD4 test"
lab var m1_710a "710a. Did they do a syphilis test?"
lab var m1_710b "710b. Would you please share with me the result of the syphilis test?"
lab var m1_710c "710c. Did the provider give you medicine for syphilis directly, gave you a prescription or told you to get it somewhere else, or neither?"
lab var m1_711a "711a. Did they do a blood sugar test for diabetes?"
lab var m1_711b "711b. Do you know the result of your blood sugar test?"
lab var m1_712 "712. Did they do an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)"
lab var m1_713a "713a_1. Iron and folic acid pills?"
lab var m1_713_za_in "713b: Iron injection"
lab var m1_713b "713b_1. Calcium pills?"
lab var m1_713c "713c_1. The food supplement like Super Cereal or Plumpynut?"
lab var m1_713d "713d_1. Medicine for intestinal worms?"
lab var m1_713e "713e_1. Medicine for malaria (endemic only)?"
lab var m1_713k "713h: Medicine for HIV"
lab var m1_713f "713f_1. Medicine for your emotions, nerves, or mental health?"
lab var m1_713g "713g_1. Multivitamins?"
lab var m1_713h "713h_1. Medicine for hypertension?"
lab var m1_713i "713i_1. Medicine for diabetes, including injections of insulin?"
lab var m1_713l "713l: Antibiotics for an infection"
lab var m1_713_za_in "713b: Iron injection"
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
lab var m1_1218f_other "1218f: Other (specify)"
lab var m1_1218f_1 "1218f: If other, please specify - Amount"
lab var m1_1218g "1218g: Total Spent"
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
	

order m1_*, sequential
order country study_site study_site_sd facility interviewer_id date_m1 pre_screening_num_za permission care_self enrollage_cat enrollage zone_live b5anc b6anc_first b7eligible respondentid mobile_phone flash

order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3, after(m1_1223)

drop JO-N709b

save "$za_data_final/eco_m1_za.dta", replace
	


