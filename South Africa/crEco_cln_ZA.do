* South Africa MNH ECohort Baseline Data Cleaning File 
* Created by S. Sabwa
* Updated: Aug 17 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

import excel "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/01 raw data/27Jul2023_interimdata.xlsx", sheet("MNH_Module_1_Baseline 17Jul2023") firstrow

keep if MOD1_ELIGIBILITY_B7 == 1

gen country = "South Africa"

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 28)
		* STEP TW0: ADD VALUE LABELS (starts at: line )
		* STEP THREE: RECODING MISSING VALUES (starts at: line )
		* STEP FOUR: LABELING VARIABLES (starts at: line )
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

rename (CRHID MOD1_Identification_104 MOD1_Identification_105 MOD1_Identification_106) ///
		(respondentid mobile_phone phone_number flash)
		
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
		
rename (MOD1_Demogr_513a MOD1_Demogr_514a MOD1_Demogr_515) (m1_513a_za m1_514a m1_515_za)	
		
rename (MOD1_Demogr_516 MOD1_Demogr_517 MOD1_Demogr_518 MOD1_Demogr_519) (m1_516 m1_517 m1_518 m1_519a) 		
rename (MOD1_User_Exp_601 MOD1_User_Exp_602 MOD1_User_Exp_603 MOD1_User_Exp_604) (m1_601 m1_602 m1_603 m1_604a)		

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
		MOD1_Cont_Care_713i MOD1_Cont_Care_713d MOD1_Cont_Care_713j MOD1_Cont_Care_713k) (m1_713_za m1_713b ///
		m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i)
		
rename (MOD1_Cont_Care_713h MOD1_Cont_Care_713l MOD1_Cont_Care_714a MOD1_Cont_Care_714b MOD1_Cont_Care_714c ///
		MOD1_Cont_Care_714d MOD1_Cont_Care_714e) (m1_713m_za m1_713n_za m1_714a m1_714b m1_714c m1_714d m1_714e)	
	
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
		MOD1_Econ_Status_1218E MOD1_Econ_Status_1218F) (m1_1217 m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218_za)		

rename (MOD1_Econ_Status_1218f_Other_Amo MOD1_Econ_Status_1218G_TOTAL MOD1_Econ_Status__1219) (m1_1218g m1_1218g_za m1_1219)		

rename (MOD1_Econ_Status_1220 MOD1_Econ_Status_1220_Other MOD1_Econ_Status_1221 MOD1_Econ_Status_1222 MOD1_Econ_Status_1223 ///
		MOD1_Physical_Assessment_1301 MOD1_Physical_Assessment_1302) (m1_1220 m1_1220_other m1_1221 m1_1222 m1_1223 height_cm weight_kg)

rename (MOD1_Physical_Assessment_1303a MOD1_Physical_Assessment_1303b MOD1_Physical_Assessment_1303c MOD1_Physical_Assessment_1304a  ///
		MOD1_Physical_Assessment_1304b MOD1_Physical_Assessment_1304c MOD1_Physical_Assessment_1305a MOD1_Physical_Assessment_1305b ///
		MOD1_Physical_Assessment_1305c) (bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic ///
		time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3)
		
rename (MOD1Physical_Assessment_1306 MOD1_Physical_Assessment_1307 MOD1_Physical_Assessment_1308 MOD1_Physical_Assessment_1309 ///
		MOD1_Next_Call_1401) (m1_1306 m1_1307 m1_1308 m1_1309 m1_1401)		
		

*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS 
	** many of these value labels can be found in the "REDCap_STATA.do" file that can be downloaded from redcap
	
		
		