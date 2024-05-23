* South Africa MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Aug 17 2023 

*------------------------------------------------------------------------------*
* Instructions: All steps are done by Module, search "MODULE _" to find sections
	
	* STEPS: 
		* STEP ONE: RENAME VARIABLES 
		* STEP TW0: ADD VALUE LABELS 
		* STEP THREE: RECODING MISSING VALUES 
		* STEP FOUR: LABELING VARIABLES
		* STEP FIVE: ORDER VARIABLES
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*
* MODULE 1:

* Import data
clear all 
import excel "$za_data/Module 1/SA MOD-1 - 15 Jan 2024.xlsx", sheet("MNH_Module_1_Baseline") firstrow

* Notes from original excel:
	*9999998 = NA
	*5555555 = Did not meet the eligibility criteria
	*Blank = Missing value/Incomplete interview
	
*------------------------------------------------------------------------------*
* Create sample:
	
* keeping eligible participants:
keep if Eligible == "Yes" // 163 obs dropped
drop if MOD1_ELIGIBILITY_B3_B == 14 // per Gloria 9-22-23 email: dropping 14 year old who did not meet eligibility criteria
keep if MOD1_ELIGIBILITY_B7 == 1

gen country = "South Africa"

* De-identify dataset:
* MOD1_Identification_105, MOD1_Demogr_515, MOD1_Demogr_516, MOD1_Demogr_519 already dropped in this dataset

drop RESPONSE_QuestionnaireID RESPONSE_QuestionnaireName RESPONSE_QuestionnaireVersion RESPONSE_FieldWorkerID RESPONSE_FieldWorker RESPONSE_StartTime RESPONSE_Location RESPONSE_Lattitude RESPONSE_Longitude RESPONSE_StudyNoPrefix RESPONSE_StudyNo StudyNumber ResponseID

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES
		* STEP TW0: ADD VALUE LABELS
		* STEP THREE: RECODING MISSING VALUES 
		* STEP FOUR: LABELING VARIABLES
		* STEP FIVE: SAVE DATA/ORDER VARIABLES 

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
rename SCRNumBer pre_screening_num_za
rename (MOD1_META_DATA_A1 MOD1_META_DATA_A2 MOD1_META_DATA_A3 MOD1_META_DATA_A4 MOD1_META_DATA_A4_SD ///
		MOD1_META_DATA_A5) (interviewer_id m1_date m1_start_time ///
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
		time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic time_3_pulse_rate)
		
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
format m1_date %td

drop if recm1_802a < m1_date

* Fixing hemoglobin levels
replace m1_1307 =  m1_1307/10 if m1_1307>=44 & m1_1307<=215
replace m1_1307=. if m1_1307==891
replace m1_1307= m1_1307/100 if m1_1307>=1111 & m1_1307<=1246

replace m1_1309=. if m1_1309==0
replace m1_1309 =  m1_1309/10 if m1_1309>=37 & m1_1309<=215
replace m1_1309 =  m1_1309/100 if m1_1309==1226

replace m1_723 = ".a" if m1_723 == "NA"
destring(m1_723), generate(recm1_723)

* Data quality fixes to respondent id naming:
replace respondentid = "QEE_083" if respondentid == "QEE_O83"

*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS 
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
lab val m1_713_za_in m1_713_za_in

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
					99 "NR/RF" 95 "NA"
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
	   
* Recode missing values to NA for questions respondents would not have been asked due to skip patterns

*recode RESPONSE_Lattitude RESPONSE_Longitude (. = .a) if RESPONSE_Location == "UNKNOWN"

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
replace time_3_pulse_rate = . if time_3_pulse_rate == 9999998
replace height_cm = . if height_cm == 9999998 
replace weight_kg = . if weight_kg == 9999998 
replace m1_1306 = . if m1_1306 == 9999998 
replace m1_1308 = . if m1_1308 == 9999998 
replace m1_1401 = . if m1_1401 == 9999998 

*===============================================================================					   
	
	* STEP FOUR: LABELING VARIABLES

lab var country "Country"
lab var interviewer_id "Interviewer ID"
lab var m1_date "A2. Date of interview"
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
lab var respondentid "103. Assign respondent ID"
lab var mobile_phone "104. Do you have a mobile phone with you today?"
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
lab var time_3_pulse_rate "Time 3 (Heart Rate)"
lab var m1_1306 "1306. Hemoglobin level available in maternal health card"
lab var m1_1307 "1307. HEMOGLOBIN LEVEL FROM MATERNAL HEALTH CARD "
lab var m1_1308 "1308. Will you take the anemia test?"
lab var m1_1309 "1309. HEMOGLOBIN LEVEL FROM TEST PERFORMED BY DATA COLLECTOR"
lab var m1_1401 "1401. What period of the day is most convenient for you to answer the phone survey?"


*===============================================================================

	* STEP FIVE: SAVE DATA TO RECODED FOLDER/ ORDER VRIABLES
	
order m1_*, sequential
order country study_site study_site_sd facility interviewer_id m1_date pre_screening_num_za permission care_self enrollage_cat enrollage zone_live b5anc b6anc_first b7eligible respondentid mobile_phone flash

order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)

drop JO-N709b

save "$za_data_final/eco_m1_za.dta", replace
	

*===============================================================================
* MODULE 2:
clear all

* import data:
import excel "$za_data/Module 2/MNH-Module-2 17Apr2024 - 24Apr2024.xlsx", firstrow clear

drop RESPONSE_QuestionnaireID RESPONSE_QuestionnaireName RESPONSE_QuestionnaireVersion RESPONSE_FieldWorkerID RESPONSE_FieldWorker RESPONSE_StartTime RESPONSE_Location RESPONSE_Lattitude RESPONSE_Longitude RESPONSE_StudyNoPrefix RESPONSE_StudyNo ResponseID ER StudyNumber NoofFollowupCalls

*===============================================================================

	* STEP ONE: RENAME VARIABLES
*rename V2 m2_completed_attempts
rename MOD2_Permission_Granted m2_permission
rename MOD2_Identification_101 m2_interviewer
rename MOD2_Identification_102 m2_date
rename MOD2_Identification_103 m2_time_start
rename CRHID respondentid	
rename MOD2_Identification_107 m2_ga
rename MOD2_Identification_108 m2_hiv_status
rename MOD2_Identification_109 m2_maternal_death_reported
rename MOD2_Identification_110 m2_date_of_maternal_death
rename MOD2_Identification_111 m2_maternal_death_learn
rename MOD2_Identification_111_Other m2_maternal_death_learn_other
rename MOD2_Gen_Health_201 m2_201
rename MOD2_Gen_Health_202 m2_202

rename MOD2_Gen_Health_203A m2_203a
rename MOD2_Gen_Health_203B m2_203b
rename MOD2_Gen_Health_203C m2_203c
rename MOD2_Gen_Health_203D m2_203d
rename MOD2_Gen_Health_203E m2_203e
rename MOD2_Gen_Health_203F m2_203f
rename MOD2_Gen_Health_203G m2_203g
rename MOD2_Gen_Health_203H m2_203h
rename MOD2_Gen_Health_204 m2_204_other
rename MOD2_Gen_Health_205A m2_205a
rename MOD2_Gen_Health_205B m2_205b
rename MOD2_Gen_Health_206 m2_206
rename MOD2_Care_Pathwasy_301 m2_301
rename MOD2_Care_Pathwasy_302 m2_302
rename MOD2_Care_Pathwasy_303 m2_303
rename MOD2_Care_Pathwasy_303A m2_303a
rename MOD2_Care_Pathwasy_304A m2_304a
rename MOD2_Care_Pathwasy_303B m2_303b
rename MOD2_Care_Pathwasy_304B m2_304b
rename MOD2_Care_Pathwasy_303C m2_303c
rename MOD2_Care_Pathwasy_304C m2_304c
rename MOD2_Care_Pathwasy_303D m2_303d
rename MOD2_Care_Pathwasy_304D m2_304d
rename MOD2_Care_Pathwasy_303E m2_303e
rename MOD2_Care_Pathwasy_304E m2_304e
rename MOD2_Care_Pathwasy_305 m2_305
rename MOD2_Care_Pathwasy_306 m2_306
rename MOD2_Care_Pathwasy_307 m2_307
rename MOD2_Care_Pathwasy_307_Other m2_307_other
rename MOD2_Care_Pathwasy_308 m2_308
rename MOD2_Care_Pathwasy_309 m2_309
rename MOD2_Care_Pathwasy_310 m2_310
rename MOD2_Care_Pathwasy_310_Other m2_310_other
rename MOD2_Care_Pathwasy_311 m2_311
rename MOD2_Care_Pathwasy_312 m2_312
rename MOD2_Care_Pathwasy_313 m2_313
rename MOD2_Care_Pathwasy_313_Other m2_313_other
rename MOD2_Care_Pathwasy_314 m2_314
rename MOD2_Care_Pathwasy_315 m2_315
rename MOD2_Care_Pathwasy_316 m2_316
rename MOD2_Care_Pathwasy_316_Other m2_316_other
rename MOD2_Care_Pathwasy_317 m2_317
rename MOD2_Care_Pathwasy_318 m2_318
rename MOD2_Care_Pathwasy_319 m2_319
rename MOD2_Care_Pathwasy_319_Other m2_319_other
rename MOD2_Care_Pathwasy_320 m2_320
rename MOD2_Care_Pathwasy_320_Other m2_320_other
rename MOD2_Care_Pathwasy_321 m2_321
rename MOD2_User_Exp_401 m2_401
rename MOD2_User_Exp_402 m2_402
rename MOD2_User_Exp_403 m2_403
rename MOD2_User_Exp_404 m2_404
rename MOD2_User_Exp_405 m2_405
rename MOD2_Cont_Care_501A m2_501a
rename MOD2_Cont_Care_501B m2_501b
rename MOD2_Cont_Care_501C m2_501c
rename MOD2_Cont_Care_501D m2_501d
rename MOD2_Cont_Care_501E m2_501e
rename MOD2_Cont_Care_501F m2_501f
rename MOD2_Cont_Care_501G m2_501g
rename MOD2_Cont_Care_501G_Other m2_501g_other
rename MOD2_Cont_Care_502 m2_502
rename MOD2_Cont_Care_503A m2_503a
rename MOD2_Cont_Care_505A m2_505a
rename MOD2_Cont_Care_503B m2_503b
rename MOD2_Cont_Care_505B m2_505b
rename MOD2_Cont_Care_503C m2_503c
rename MOD2_Cont_Care_505C m2_505c
rename MOD2_Cont_Care_503D m2_503d
rename MOD2_Cont_Care_505D m2_505d
rename MOD2_Cont_Care_503E m2_503e
rename MOD2_Cont_Care_505E m2_505e
rename MOD2_Cont_Care_503F m2_503f
rename MOD2_Cont_Care_505F m2_505f
rename MOD2_Cont_Care_503G m2_503g_za
rename MOD2_Cont_Care_505H m2_505h_za
rename MOD2_Cont_Care_504 m2_504
rename MOD2_Cont_Care_504_Other m2_504_other
rename MOD2_Cont_Care_505G m2_505g
rename MOD2_Cont_Care_506A m2_506a
rename MOD2_Cont_Care_506B m2_506b
rename MOD2_Cont_Care_506C m2_506c
rename MOD2_Cont_Care_506D m2_506d
rename MOD2_Cont_Care_507 m2_507
rename MOD2_Cont_Care_508A m2_508a
rename MOD2_Cont_Care_508B m2_508b_num
rename MOD2_Cont_Care_507_Other m2_507_other
rename MOD2_Cont_Care_508C m2_508c_time
rename MOD2_Cont_Care_509A m2_509a
rename MOD2_Cont_Care_509B m2_509b
rename MOD2_Cont_Care_509C m2_509c
rename MOD3_MEDS_601A m2_601a
rename MOD3_MEDS_601B m2_601o
rename MOD3_MEDS_601C m2_601b
rename MOD3_MEDS_601D m2_601c
rename MOD3_MEDS_601E m2_601d	
		
rename MOD3_MEDS_601F m2_601e
rename MOD3_MEDS_601G m2_601f
rename MOD3_MEDS_601H m2_601g
rename MOD3_MEDS_601i m2_601h
rename MOD3_MEDS_601J m2_601i
rename MOD3_MEDS_601K m2_601j
rename MOD3_MEDS_601L m2_601k
rename MOD3_MEDS_601M m2_601l
rename MOD3_MEDS_601N m2_601m
rename MOD3_MEDS_601O m2_601n_other
rename MOD3_MEDS_602 m2_602b
rename MOD3_MEDS_603 m2_603
rename MOD2_Costs_NV_701 m2_701
rename MOD2_Costs_NV_702A m2_702a_cost
rename MOD2_Costs_NV_702B m2_702b_cost
rename MOD2_Costs_NV_702C m2_702c_cost
rename MOD2_Costs_NV_702D m2_702d_cost
rename MOD2_Costs_NV_702E_Othere m2_702_other
rename MOD2_Costs_NV_702E m2_702b_other
rename MOD2_Costs_NV_702_Total m2_703
rename MOD2_Costs_NV_703 m2_704
rename MOD2_Costs_NV_704 m2_704_confirm
rename MOD2_Costs_NV_705 m2_705
rename MOD2_Costs_NV_705_Other m2_705_other	

*Data quality: 
*dropping pids based on Londi's review:
*SS: ask why there is a mix of underscores and dashes
drop if respondentid == "BNE_013"
drop if respondentid == "MPH_015"
replace respondentid = "RCH_083" if respondentid == "CRH_083"
replace respondentid = "EUB_008" if respondentid == "EUB_,008"
replace respondentid = "EUB_003" if respondentid == "EUB_033"
replace respondentid = "IIB_024" if respondentid == "IiB_024"
replace respondentid = "KAN_017" if respondentid == "KAN_01"
replace respondentid = "KAN_014" if respondentid == "Kan_014"
replace respondentid = "KAN_032" if respondentid == "KAN_32"
replace respondentid = "KAN_009" if respondentid == "KAN-009"
replace respondentid = "MER_028" if respondentid == "MER-028"
replace respondentid = "MER_042" if respondentid == "MMER_042"
replace respondentid = "MND-011" if respondentid == "MND_011"
replace respondentid = "MND-013" if respondentid == "MND_013"
replace respondentid = "MND_010" if respondentid == "MND-010"
replace respondentid = "NEL_054" if respondentid == "NEL-054"
replace respondentid = "NWE_040" if respondentid == "NWE-040"
replace respondentid = "NWE_065" if respondentid == "NWE-065"
replace respondentid = "PAP_050" if respondentid == "PAP_50"
replace respondentid = "RCH_028" if respondentid == "RCh_028"
replace respondentid = "TOK_019" if respondentid == "TOk_019"
replace respondentid = "BXE_010" if respondentid == "BXE__010"
replace respondentid = "NOK_042" if respondentid == "NOK_42"

*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS
	label define m2_permission 1 "Yes" 0 "No" 
	label values m2_permission
	
	label define maternal_death_reported 1 "Yes" 0 "No" 
	label values m2_maternal_death_reported maternal_death_reported
	
	label define m2_hiv_status 1 "Positive" 2 "Negative" 3 "Unknown" 98 "DK" 99 "NR/RF"
	label values m2_hiv_status m2_hiv_status
	
	label define m2_maternal_death_learn 1 "Called respondent phone, someone else responded" ///
									  2 "Called spouse/partner phone, was informed" ///
									  3 "Called close friend or family member phone number, was informed" ///
									  4 "Called CHW phone number, was informed" 5 "Other"
	label values m2_maternal_death_learn m2_maternal_death_learn
	
	label define m2_201 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 98 "DK" 99 "RF/NR" 
	label values m2_201 m2_201

	label define m2_202 1 "Yes, still pregnant" 2 "No, delivered" 3 "No, something else happened" 
	label values m2_202 m2_202

	label define m2_203a 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203a m2_203a
	
	label define m2_203b 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
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

	label define m2_203h 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_203h m2_203h

	label define m2_205a 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 
	label values m2_205a m2_205a

	label define m2_206 1 "Every day" 2 "Some days" 3 "Not at all" 98 "DK" 99 "NR/RF" 
	label values m2_206 m2_206

	label define m2_301 1 "Yes" 0 "No" 98 "DK" 99 "NR/RF" 
	label values m2_301 m2_301

	* keep this var numeric
	*label define m2_302 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 
	*label values m2_302 m2_302

	label define visit_location 1 "In your home" 2 "Someone else's home" 3 "Public clinic" ///
					 4 "Public hospital" 5 "Private clinic" ///
					 6 "Private hospital" 7 "Public Community health center" ///
					 8 "Other"  98 "DK" 99 "RF" 0 "None"
	label values m2_303a m2_303b m2_303c m2_303d m2_303e visit_location

	label define m2_305 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_305 m2_305
	
	label define m2_306 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_306 m2_306
	
	*m2_307
	forval j = 1/96 {
    gen m2_307_`j' = strpos("," + m2_307 + ",", ",`j',") > 0
	}
	drop m2_307_6-m2_307_95
	drop m2_307
	
	label define m2_YN 1 "Yes" 0 "No"
	label values m2_307_1 m2_307_2 m2_307_3 m2_307_4 m2_307_5 m2_307_96 m2_YN
	
	label define m2_308 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_308 m2_308

	label define m2_309 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_309 m2_309
	
	*m2_310
	forval j = 1/96 {
    gen m2_310_`j' = strpos("," + m2_310 + ",", ",`j',") > 0
	}
	drop m2_310_6-m2_310_95
	drop m2_310
	
	label values m2_310_1 m2_310_2 m2_310_3 m2_310_4 m2_310_5 m2_310_96 m2_YN
	
	label define m2_311 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF" 
	label values m2_311 m2_311
 
	label define m2_312 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_312 m2_312
	
	*m2_313
	forval j = 1/96 {
    gen m2_313_`j' = strpos("," + m2_313 + ",", ",`j',") > 0
	}
	drop m2_313_6-m2_313_95
	drop m2_313
	
	label values m2_313_1 m2_313_2 m2_313_3 m2_313_4 m2_313_5 m2_313_96 m2_YN
	
	label define m2_314 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"  
	label values m2_314 m2_314
	
	label define m2_315 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_315 m2_315

	*m2_316
	forval j = 1/96 {
    gen m2_316_`j' = strpos("," + m2_316 + ",", ",`j',") > 0
	}
	drop m2_316_6-m2_316_95
	drop m2_316
	
	label values m2_316_1 m2_316_2 m2_316_3 m2_316_4 m2_316_5 m2_316_96 m2_YN
	
	label define m2_317 1 "Yes, for a routine antenatal care" 0 "No" 98 "DK" 99 "RF"
	label values m2_317 m2_317

	label define m2_318 1 "Yes, for a referral from your antenatal care provider" 0 "No" 98 "DK" 99 "RF" 
	label values m2_318 m2_318 
	
	*m2_319
	forval j = 1/96 {
    gen m2_319_`j' = strpos("," + m2_319 + ",", ",`j',") > 0
	}
	drop m2_319_6-m2_319_95
	
	label values m2_319_1 m2_319_2 m2_319_3 m2_319_4 m2_319_5 m2_319_96 m2_YN
	
	
	
	*m2_320
	forval j = 0/99 {
    gen m2_320_`j' = strpos("," + m2_320 + ",", ",`j',") > 0
	}
	drop m2_320_12-m2_320_95
	drop m2_320_97
	drop m2_320_98
	drop m2_320
	
	label values m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 m2_320_96 m2_320_99 ßm2_YN
	
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
	
	label define m2_503g_za 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_503g_za m2_503g_za
	
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
	
	label define m2_505g 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF" 
	label values m2_505g m2_505g
	
	label define m2_505h_za 1 "Positive" 0 "Negative" 98 "DK" 99 "NR/RF" 
	label values m2_505h_za m2_505h_za

	label define m2_506a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_506a m2_506a
	
	label define m2_506b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_506b m2_506b
	
	label define m2_506c 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_506c m2_506c
	
	label define m2_506d 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_506d m2_506d
	
	*SS: Note this is different than in other countries
	label define m2_507 1 "Nothing I did not speak about this with a health care provider" ///
						2 "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)" ///
						3 "They provided a treatment in the visit" ///
						4 "They prescribed a medication" ///
						5 "They told you to come back to this health facility" ///
						6 "They told you to go somewhere else for higher level care" ///
						7 "They told you to wait and see" ///
						96 "Other, specify" ///
						98 "DK" 99 "RF" 
	label values m2_507 m2_507
	
	label define m2_508a 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508a m2_508a
	
	label define m2_508b_num 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_508b_num m2_508b_num

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

	label define m2_601o 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_601o m2_601o

	label define m2_602b 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_602b m2_602b

	label define m2_603 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_603 m2_603

	label define m2_701 1 "Yes" 0 "No" 98 "DK" 99 "RF"
	label values m2_701 m2_701

	label define m2_704 1 "Yes" 0 "No" 98 "DK" 99 "RF" 
	label values m2_704 m2_704

	*m2_705
	forval j = 1/96 {
    gen m2_705_`j' = strpos("," + m2_705 + ",", ",`j',") > 0
	}
	drop m2_705_7-m2_705_95
	drop m2_705

* Formatting Dates (SS: do this for all dates in all modules)	 
	
	
*===============================================================================
	
	*STEP THREE: RECODING MISSING VALUES 
	* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		* Need to figure out a way to clean up string "text" only vars that have numeric entries (ex. 803)

recode m2_hiv_status m2_201 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f ///
	   m2_203g m2_203h m2_206 m2_301 m2_303a m2_303b m2_303c m2_303d ///
	   m2_303e m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_312 m2_314 ///
	   m2_317 m2_318 m2_321 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f ///
	   m2_501g m2_502 m2_503a m2_505a m2_503b m2_505b m2_503c m2_505c ///
	   m2_503d m2_505d m2_503e m2_505e m2_503f m2_505f m2_503g_za ///
	   m2_504 m2_505h_za m2_505g m2_506a m2_506b m2_506c m2_506d m2_508a m2_508b ///
	   m2_509a m2_509b m2_509c m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f ///
	   m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601o m2_603 ///
	   m2_701 m2_ga m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost ///
	   m2_704_confirm (98 = .d)

recode m2_hiv_status m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g ///
	   m2_203h m2_206 m2_301 m2_303a m2_303b m2_303c m2_303d m2_303e ///
	   m2_305 m2_306 m2_308 m2_309 m2_311 m2_312 m2_314 m2_317 m2_318 ///
	   m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d ///
	   m2_501e m2_501f m2_501g m2_502 m2_503a m2_505a m2_503c m2_505c m2_503d ///
	   m2_505d m2_503e m2_505e m2_503f m2_505f m2_503g_za m2_505h_za m2_504 m2_505g ///
	   m2_506a m2_506b m2_506c m2_506d m2_508a m2_508b m2_509a m2_509b m2_509c ///
	   m2_601a m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i ///
	   m2_601j m2_601k m2_601l m2_601m m2_601o m2_603 m2_701 m2_ga m2_702a_cost ///
	   m2_702b_cost m2_702c_cost m2_702d_cost (99 = .r)

recode m2_702a_cost m2_702b_cost m2_702c_cost (999 = .r) //SS: confirm with KE team that this is correct

*recode (95 = .d)

*------------------------------------------------------------------------------*
* recoding for skip pattern logic:	   
	   
* Recode missing values to NA for questions respondents would not have been asked due to skip patterns

*recode m2_completed_attempts m2_date m2_time_start m2_ga m2_maternal_death_reported (. = .a) if m2_permission !=1

*recode m2_hiv_status (. = .a) if m1_202e != 0 | m1_202e != 1

recode m2_date_of_maternal_death (. 9999998 = .a) if m2_maternal_death_reported !=1

recode m2_maternal_death_learn (. 9999998 = .a) if m2_maternal_death_reported !=1

recode m2_maternal_death_learn_other (. 9999998= .a) if m2_maternal_death_learn != 96 // numeric because of 0 obs

recode m2_201 m2_202 (. 9999998 = .a) if m2_maternal_death_reported ==1 | m2_permission !=1 | m2_date_of_maternal_death !=. | m2_date_of_maternal_death !=.a

recode m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_205a m2_205b m2_206 m2_301 (. 9999998 = .a) if m2_202 !=1

replace m2_204_other = ".a" if m2_202 !=1

recode m2_302 (. 9999998 = .a) if m2_301 !=1

recode m2_303a (. 9999998 = .a) if m2_302 !=1

recode m2_303b (. 9999998 = .a) if m2_302 !=2

recode m2_303c (. 9999998 = .a) if m2_302 !=3
	
recode m2_303d (. 9999998 = .a) if m2_302 !=4

recode m2_303e (. 9999998 = .a) if m2_302 !=5

replace m2_304a = ".a" if m2_303a == . | m2_303a == .a | m2_302 !=1

replace m2_304b = ".a" if m2_303b == . | m2_303b == .a | m2_302 !=2

replace m2_304c = ".a" if m2_303c == . | m2_303c == .a | m2_302 !=3

replace m2_304d = ".a" if m2_303d == . | m2_303d == .a | m2_302 !=4

*SS: remember all 5+ consultation vars will need to be edited if the number of consultations increases above 7
replace m2_304e = ".a" if m2_303e == . | m2_303e == .a | m2_302 !=5 | m2_302 !=6 | m2_302 !=7

recode m2_305 (. 9999998 = .a) if m2_302 == 0 | m2_302 == . | m2_302 == .a
recode m2_306 (. 9999998 = .a) if m2_305 !=0

/* SS: double check but it looks like these skip patterns aren't programmed into ZA 
recode m2_307_1 (. = .a) if m2_306 !=0
recode m2_307_2 (. = .a) if m2_306 !=0
recode m2_307_3 (. = .a) if m2_306 !=0
recode m2_307_4 (. = .a) if m2_306 !=0
recode m2_307_5 (. = .a) if m2_306 !=0
recode m2_307_96 (. = .a) if m2_306 !=0
recode m2_307_other (. = .a) if m2_307_96 !=2 // numeric because of 0 obs

recode m2_310_1 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_310_2 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_310_3 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_310_4 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_310_5 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_310_96 (. = .a) if m2_308 !=0 | m2_308 !=1
recode m2_310_other (. = .a) if m2_310_96 !=2 // numeric because of 0 obs

recode m2_313_1 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_313_2 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_313_3 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_313_4 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_313_5 (. = .a) if m2_311 !=0 | m2_311 !=1
recode m2_313_96 (. = .a) if m2_311 !=0 | m2_311 !=1
replace m2_313_other = ".a" if m2_313_96 !=2

recode m2_316_1 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_316_2 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_316_3 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_316_4 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_316_5 (. = .a) if m2_314 !=0 | m2_314 !=1
recode m2_316_96 (. = .a) if m2_314 !=0 | m2_314 !=1
replace m2_316_other = ".a" if m2_314_96 !=2

recode m2_319_1 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_319_2 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_319_3 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_319_4 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_319_5 (0 = .a) if m2_314 !=0 | m2_314 !=1
recode m2_319_96 (0 = .a) if m2_314 !=0 | m2_314 !=1
replace m2_319_other = ".a" if m2_317_96 !=2
*/


replace m2_307_other = ".a" if m2_307_96 !=1

recode m2_308 (. 9999998 = .a) if m2_302 == 0 | m2_302 == 1 | m2_302 == . | m2_302 == .a // SS: confirm response "95" 
recode m2_309 (. 9999998 = .a) if m2_308 !=0 // SS: confirm response "95" 

replace m2_310_other = ".a" if m2_310_96 !=1

recode m2_311 (. 9999998 = .a) if m2_302 == 2 | m2_302 == 1 | m2_302 == 0 |m2_302 == . | m2_302 == .a // SS: confirm response "95" 
recode m2_312 (. 9999998 = .a) if m2_311 !=0 // SS: confirm response "95" 

replace m2_313_other = ".a" if m2_313_96 !=1

recode m2_314 (. 9999998 = .a) if m2_302 == 3 | m2_302 == 2 | m2_302 == 1 | m2_302 == 0 | m2_302 == . | m2_302 == .a // SS: confirm response "95" 
recode m2_315 (. 9999998 = .a) if m2_314 !=0

replace m2_316_other = ".a" if m2_316_96 !=1

recode m2_317 (. 9999998 = .a) if m2_302 == 4 | m2_302 == 3 | m2_302 == 2 | m2_302 == 1 | m2_302 == 0 |  m2_302 == . | m2_302 == .a // SS: confirm response "95" 
recode m2_318 (. 9999998 = .a) if m2_317 !=0 // SS: confirm response "9" 

*recode m2_319 (9999998 . = .a) if m2_314 !=0 | m2_314 !=1
replace m2_319_other = ".a" if m2_319_96 !=1

recode m2_320_0 (. = .a) if m2_301 !=0
recode m2_320_1 (. = .a) if m2_301 !=0
recode m2_320_2 (. = .a) if m2_301 !=0
recode m2_320_3 (. = .a) if m2_301 !=0
recode m2_320_4 (. = .a) if m2_301 !=0
recode m2_320_5 (. = .a) if m2_301 !=0
recode m2_320_6 (. = .a) if m2_301 !=0
recode m2_320_7 (. = .a) if m2_301 !=0
recode m2_320_8 (. = .a) if m2_301 !=0
recode m2_320_9 (. = .a) if m2_301 !=0
recode m2_320_10 (. = .a) if m2_301 !=0
recode m2_320_11 (. = .a) if m2_301 !=0
recode m2_320_96 (. = .a) if m2_301 !=0
recode m2_320_99 (. = .a) if m2_301 !=0

replace m2_320_other = ".a" if m2_320_96 !=1

recode m2_321 (. 9999998 = .a) if m2_202 !=1 
       
recode m2_401 (. 9999998 = .a) if (m2_202 !=1) | m2_302 !=1

recode m2_402 (. 9999998 = .a) if m2_202 !=1 | m2_302 !=2			   

recode m2_403 (. 9999998 = .a) if m2_202 !=1 | m2_302 !=3

recode m2_404 (. 9999998 = .a) if m2_202 !=1 | m2_302 !=4	   

*SS: remember all 5+ consultation vars will need to be edited if the number of consultations increases above 7
recode m2_405 (. 9999998 = .a) if m2_202 !=1 | m2_302 !=5 | m2_302 !=6 | m2_302 !=7

recode m2_501a (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
recode m2_501b (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
recode m2_501c (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
recode m2_501d (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
recode m2_501e (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
recode m2_501f (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
recode m2_501g (. 9999998 = .a) if m2_301 !=1 | m2_302 !=1 
replace m2_501g_other = ".a" if m2_501g !=1

recode m2_502 (. 9999998 = .a) if m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a

recode m2_503a (. 9999998 = .a) if m2_502 !=1 
recode m2_503b (. 9999998 = .a) if m2_502 !=1 
recode m2_503c (. 9999998 = .a) if m2_502 !=1 // SS: N=730 missing obs. what is the skip pattern?
recode m2_503d (. 9999998 = .a) if m2_502 !=1
recode m2_503e (. 9999998 = .a) if m2_502 !=1
recode m2_503f (. 9999998 = .a) if m2_502 !=1
recode m2_503g_za (. 9999998 = .a) if m2_502 !=1

recode m2_504 (. 9999998= .a) if m2_502 !=1
replace m2_504_other = ".a" if m2_504 !=1 // 0 obs so numeric

recode m2_505a (. 9999998 = .a) if m2_503a !=1
recode m2_505b (. 9999998 = .a) if m2_503b !=1
recode m2_505c (. 9999998 = .a) if m2_503c !=1
recode m2_505d (. 9999998 = .a) if m2_503d !=1
recode m2_505e (. 9999998 = .a) if m2_503e !=1
recode m2_505f (. 9999998 = .a) if m2_503f !=1
recode m2_505g (. 9999998 = .a) if m2_504 !=1
recode m2_505h_za (. 9999998 = .a) if m2_503g_za !=1

recode m2_506a m2_506b m2_506c m2_506d (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a | m2_502 !=1

recode m2_507 (. 9999998 = .a) if (m2_203a == 0 & m2_203b == 0 & m2_203c == 0 & ///
						  m2_203d == 0 & m2_203e == 0 & m2_203f == 0 & ///
						  m2_203g == 0 & m2_203h == 0) | ///
						  (m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a) // SS: confirm response "95" 

replace m2_507_other = ".a" if m2_507 !=96				  
						  						  
recode m2_508a (. 9999998 = .a) if (m2_205a+m2_205b) <3 | m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a // SS: confirm response "95", N=11 missing responses
recode m2_508b_num (. 9999998 = .a) if m2_508a !=1 // SS: confirm response of "Yes", responses are supposed to be numeric
replace m2_508c_time = ".a" if m2_508a !=1

recode m2_509a (. 9999998 = .a) if m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_509b (. 9999998 = .a) if m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_509c (. 9999998 = .a) if m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a

recode m2_601a (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601b (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601c (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601d (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601e (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601f (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601g (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601h (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601i (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601j (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601k (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601l (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601m (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_601o (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
replace m2_601n_other = ".a" if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a

recode m2_602b (. 99999998 9999998 999999 999998 99999 9999 999 = .a) if m2_202 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 == .a
recode m2_602b (. 99999998 9999998 999999 999998 99999 9999 999 = .a) if m2_601a == . & m2_601b == . & m2_601c == . & m2_601d == . & ///
																		 m2_601e == . & m2_601f == . & m2_601g == . & m2_601h == . & ///
																		 m2_601i == . & m2_601j == . & m2_601k == . & m2_601l == . & ///
																		 m2_601m == . & m2_601o == . 

recode m2_603 (. 9999998 = .a) if m2_202 !=1 | m2_601a ==1
recode m2_701 (. 9999998 = .a) if m2_202 !=1 | m2_301 !=1

* SS: there is something happening with these cost vars, extra erroneous responses. Follow up with KEMRI/Laterite
recode m2_702a_cost (. 9999998 = .a) if m2_701 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_702b_cost (. 9999998 = .a) if m2_701 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_702c_cost (. 9999998 = .a) if m2_701 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
recode m2_702d_cost (. 9999998 = .a) if m2_701 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
*recode m2_702_other (. 9999998 = .a) if m2_701 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a
*recode m2_702b_other (. 999 9998 9999 99998 99999 999998 9999998 99999988 99999998 999999999 = .a) if m2_701 !=1 | m2_301 !=1 | m2_302 ==0 | m2_302 ==. | m2_302 ==.a // SS: confirm all of these responses should be recoded as NA

recode m2_703 m2_704 m2_704_confirm (. 9999998 = .a) if m2_701 !=1 | m2_602b ==.

recode m2_704_confirm (. 9999998 = .a) if m2_704 !=0

recode m2_705_1 (. = .a) if m2_701 !=1
recode m2_705_2 (. = .a) if m2_701 !=1
recode m2_705_3 (. = .a) if m2_701 !=1
recode m2_705_4 (. = .a) if m2_701 !=1
recode m2_705_5 (. = .a) if m2_701 !=1
recode m2_705_6 (. = .a) if m2_701 !=1
recode m2_705_96 (. = .a) if m2_701 !=1

replace m2_705_other = ".a" if m2_705_96 !=1

recode m2_date (. = .a) if m2_202 !=1

recode m2_ga (. = .a) if m2_date == . | m2_202 !=1 

*===============================================================================
* reshape data from long to wide

drop if respondentid == ""

sort m2_date
bysort respondentid: gen round2 = _n

gen m2_round = ""
replace m2_round = "_r1" if round2==1
replace m2_round = "_r2" if round2==2 
replace m2_round = "_r3" if round2==3
replace m2_round = "_r4" if round2==4
replace m2_round = "_r5" if round2==5
replace m2_round = "_r6" if round2==6
replace m2_round = "_r7" if round2==7
replace m2_round = "_r8" if round2==8
			
* Use the string variable to reshape wide
drop round2
				
reshape wide m2_permission m2_interviewer m2_date m2_time_start m2_ga m2_hiv_status m2_maternal_death_reported m2_date_of_maternal_death m2_maternal_death_learn m2_maternal_death_learn_other m2_201 m2_202 m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_204_other m2_205a m2_205b m2_206 m2_301 m2_302 m2_303 m2_303a m2_304a m2_303b m2_304b m2_303c m2_304c m2_303d m2_304d m2_303e m2_304e m2_305 m2_306 m2_307_other m2_308 m2_309 m2_310_other m2_311 m2_312 m2_313_other m2_314 m2_316_other m2_317 m2_318 m2_319 m2_319_other m2_319_1 m2_319_2 m2_319_3 m2_319_4 m2_319_5 m2_319_96 m2_320_other m2_321 m2_401 m2_402 m2_403 m2_404 m2_405 m2_501a m2_501b m2_501c m2_501d m2_501e m2_501f m2_501g m2_501g_other m2_502 m2_503a m2_505a m2_503b m2_505b m2_503c m2_505c m2_503d m2_505d m2_503e m2_505e m2_503f m2_505f m2_503g_za m2_505h_za m2_504 m2_504_other m2_505g m2_506a m2_506b m2_506c m2_506d m2_507 m2_507_other m2_508a m2_508b_num m2_508c_time m2_509a m2_509b m2_509c m2_601a m2_601o m2_601b m2_601c m2_601d m2_601e m2_601f m2_601g m2_601h m2_601i m2_601j m2_601k m2_601l m2_601m m2_601n_other m2_602b m2_603 m2_701 m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702_other m2_702b_other m2_703 m2_704 m2_704_confirm m2_705_other m2_307_1 m2_307_2 m2_307_3 m2_307_4 m2_307_5 m2_307_96 m2_310_1 m2_310_2 m2_310_3 m2_310_4 m2_310_5 m2_310_96 m2_313_1 m2_313_2 m2_313_3 m2_313_4 m2_313_5 m2_313_96 m2_316_1 m2_316_2 m2_316_3 m2_316_4 m2_316_5 m2_316_96 m2_320_0 m2_320_1 m2_320_2 m2_320_3 m2_320_4 m2_320_5 m2_320_6 m2_320_7 m2_320_8 m2_320_9 m2_320_10 m2_320_11 m2_320_96 m2_320_99 m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 m2_315, i(respondentid) j(m2_round, string) 

*------------------------------------------------------------------------------*
*save M2 only dataset

save "$za_data_final/eco_m2_za.dta", replace

*------------------------------------------------------------------------------*
* merge dataset with M1

merge 1:1 respondentid using "$za_data_final/eco_m1_za.dta" // N= 8 in master only (M2) not in using (M1).

drop _merge  

*===============================================================================					   
	
	* STEP FOUR: LABELING VARIABLES	
	foreach i in _r1 _r2 _r3 _r4 _r5 _r6 {
label variable m2_permission`i'  "Permission granted to conduct call"
*label variable m2_completed_attempts`i'  "Module 2 completed attempts"
label variable m2_time_start`i'  "Start date and time"
label variable m2_date`i'  "102. Date of interview (D-M-Y)"
label variable m2_time_start`i'  "103. Time of interview started"
label variable m2_interviewer`i'  "Interviewer name"
label variable m2_maternal_death_reported`i'  "108. Maternal death reported"
label variable m2_ga`i'  "107a. Gestational age at this call based on maternal recall"
label variable m2_hiv_status`i'  "109. HIV status"
label variable m2_date_of_maternal_death`i'  "110. Date of maternal death (D-M-Y)"
label variable m2_maternal_death_learn`i'  "111. How did you learn about the maternal death?"
label variable m2_maternal_death_learn_other`i'  "111-Other. Specify other way of learning maternal death"
label variable m2_201`i'  "201. In general, how would you rate your overall health?"
label variable m2_202`i'  "202. Are you still pregnant, or did something else happen?"
label variable m2_203a`i'  "203a. Have you experienced severe or persistent headaches?"
label variable m2_203b`i'  "203b. Have you experienced vaginal bleeding of any amount?"
label variable m2_203c`i'  "203c. Have you experienced fever?"
label variable m2_203d`i'  "203d. Have you experienced severe abdominal pain, not just discomfort?"
label variable m2_203e`i'  "203e. Have you experienced a lot of difficult breathing?"
label variable m2_203f`i'  "203f. Have you experienced convulsions or seizures?"
label variable m2_203g`i'  "203g. Have you experienced repeated fainting or loss of consciousness?"
label variable m2_203h`i'  "203h. Have noticed that the baby has completely stopped moving?"
*label variable m2_204i`i'  "204i. Have you experienced any other major health problems?"
label variable m2_204_other`i' "204i-Other. Specify any other feeling since last visit"
label variable m2_205a`i' "205a. How many days have you been bothered by little interest or pleasure in doing things?"
label variable m2_205b`i' "205b. How many days have you been bothered by feeling down, depressed, or hopeless?"
label variable m2_206`i' "206. How often do you currently smoke cigarettes or use any other type of tobacco?"
label variable m2_301`i' "301. Have you been seen or attended to by a clinician or healthcare provider for yourself?   "
label variable m2_302`i' "302. How many times have you been seen or attended to by a clinician or healthcare provider for yourself?"
label variable m2_303a`i' "303a. Where did this new 1st healthcare consultation for yourself take place?"
label variable m2_303b`i' "303b. Where did the 2nd healthcare consultation for yourself take place?"
label variable m2_303c`i' "303c. Where did the 3rd healthcare consultation for yourself take place?"
label variable m2_303d`i' "303d. Where did the 4th healthcare consultation for yourself take place?"
label variable m2_303e`i' "303e. Where did the 5th healthcare consultation for yourself take place?"
label variable m2_304a`i' "304a. What is the name of the facility where this first healthcare consultation took place?"
*label variable m2_304a_other`i' "304a-Other. Other facility for 1st health consultation"
label variable m2_304b`i' "304b. What is the name of the facility where the second healthcare consultation took place?"
*label variable m2_304b_other`i' "304b-Other. Other facility for 2nd health consultation"
label variable m2_304c`i' "304c. What is the name of the facility where the third healthcare consultation took place?"
*label variable m2_304c_other`i' "304c-Other. Other facility for 3rd health consultation"
label variable m2_304d`i' "304d. What is the name of the facility where the fourth healthcare consultation took place?"
*label variable m2_304d_other`i' "304d-Other. Other facility for 4th health consultation"
label variable m2_304e`i' "304e. What is the name of the facility where the fifth healthcare consultation took place?"
*label variable m2_304e_other`i' "304e-Other. Other facility for 5th health consultation"
label variable m2_305`i' "305. Was the first consultation for a routine antenatal care visit?"
label variable m2_307_1`i' "307. A new health problem, including an emergency or an injury"
label variable m2_307_2`i' "307. An existing health problem"
label variable m2_307_3`i' "307. A lab test, x-ray, or ultrasound"
label variable m2_307_4`i' "307. To pick up medicine"
label variable m2_307_5`i' "307. To get a vaccine"
label variable m2_307_96`i' "307. Other reasons"
label variable m2_307_other`i' "307-Other. Specify other reason for the 1st visit"
label variable m2_308`i' "308. Was the second consultation is for a routine antenatal care visit?"
label variable m2_309`i' "309. Was the second consultation is for a referral from your antenatal care provider?"
label variable m2_310_1`i' "310. Was the second consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_310_2`i' "310. Was the second consultation for any of the following? An existing health problem"
label variable m2_310_3`i' "310. Was the second consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_310_4`i' "310. Was the second consultation for any of the following? To pick up medicine"
label variable m2_310_5`i' "310. Was the second consultation for any of the following? To get a vaccine"
label variable m2_310_96`i' "310. Was the second consultation for any of the following? Other reasons"
label variable m2_310_other`i' "310-Other. Specify other reason for second consultation"
label variable m2_311`i' "311. Was the third consultation is for a routine antenatal care visit?"
label variable m2_312`i' "312. Was the third consultation is for a referral from your antenatal care provider?"
label variable m2_313_1`i' "313. Was the third consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_313_2`i' "313. Was the third consultation for any of the following? An existing health problem"
label variable m2_313_3`i' "313. Was the third consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_313_4`i' "313. Was the third consultation for any of the following? To pick up medicine"
label variable m2_313_5`i' "313. Was the third consultation for any of the following? To get a vaccine"
label variable m2_313_96`i' "313. Was the third onsultation for any of the following? Other reasons"
label variable m2_313_other`i' "313-Other. Specify any other reason for the third consultation"
label variable m2_314`i' "314. Was the fourth consultation is for a routine antenatal care visit?"
label variable m2_315`i' "315. Was the fourth consultation is for a referral from your antenatal care provider?"
label variable m2_316_1`i' "316. Was the fourth consultation for any of the following? A new health problem, including an emergency or an injury"
label variable m2_316_2`i' "316. Was the fourth consultation for any of the following? An existing health problem"
label variable m2_316_3`i' "316. Was the fourth consultation for any of the following? A lab test, x-ray, or ultrasound"
label variable m2_316_4`i' "316. Was the fourth consultation for any of the following? To pick up medicine"
label variable m2_316_5`i' "316. Was the fourth consultation for any of the following? To get a vaccine"
label variable m2_316_96`i' "316. Was the fourth onsultation for any of the following? Other reasons"
label variable m2_316_other`i' "316-Other. Specify other reason for the fourth consultation"
label variable m2_317`i' "317. Was the fifth consultation is for a routine antenatal care visit?"
label variable m2_318`i' "318. Was the fifth consultation is for a referral from your antenatal care provider?"
label variable m2_319`i' "319. Was the fifth consultation is for any of the following? A new health problem, including an emergency or an injury"
label variable m2_319_other`i' "319-Other. Specify other reason for the fifth consultation"
label variable m2_320_0`i' "320. No reason or you didn't need it"
label variable m2_320_1`i' "320. You tried but were sent away (e.g., no appointment available) "
label variable m2_320_2`i' "320. High cost (e.g., high out of pocket payment, not covered by insurance)"
label variable m2_320_3`i' "320. Far distance (e.g., too far to walk or drive, transport not readily available)"
label variable m2_320_4`i' "320. Long waiting time (e.g., long line to access facility, long wait for the provider)"
label variable m2_320_5`i' "320. Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)"
label variable m2_320_6`i' "320. Staff don't show respect (e.g., staff is rude, impolite, dismissive)"
label variable m2_320_7`i' "320. Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)"
label variable m2_320_8`i' "320. COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews) "
label variable m2_320_9`i' "320. COVID-19 fear"
label variable m2_320_10`i' "320. Don't know where to go/too complicated"
label variable m2_320_11`i' "320. Fear of discovering serious problem"
label variable m2_320_96`i' "320. Other, specify"
label variable m2_320_99`i' "320. Refused"
label variable m2_320_other`i' "320 Other. Specify other reason preventing receiving more antenatal care"
label variable m2_321`i' "321. Other than in-person visits, did you have contacs with a health care provider by phone, SMS, or web regarding your pregnancy?"
label variable m2_401`i' "401. How would you rate the quality of care that you received from the health facility where you took the 1st consultation?"
label variable m2_402`i' "402. How would you rate the quality of care that you received from the health facility where you took the 2nd consultation?"
label variable m2_403`i' "403. How would you rate the quality of care that you received from the health facility where you took the 3rd consultation?"
label variable m2_404`i' "404. How would you rate the quality of care that you received from the health facility where you took the 4th consultation?"
label variable m2_405`i' "405. How would you rate the quality of care that you received from the health facility where you took the 5th consultation?"
label variable m2_501a`i' "501a. Did you get your blood pressure measured (with a cuff around your arm)?"
label variable m2_501b`i' "501b. Did you get your weight taken (using a scale)?"
label variable m2_501c`i' "501c. Did you get a blood draw (that is, taking blood from your arm with a syringe)?"
label variable m2_501d`i' "501d. Did you get a blood test using a finger prick (that is, taking a drop of blood from your finger)?"
label variable m2_501e`i' "501e. Did you get a urine test (that is, where you peed in a container)?"
label variable m2_501f`i' "501f. Did you get an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)?"
label variable m2_501g`i' "501g. Did you get any other tests?"
label variable m2_501g_other`i' "501g-Other. Specify any other test you took since you last spoke to us"
label variable m2_502`i' "502. Did you receive any new test results from a health care provider? By that I mean, any result from a blood or urine sample or from blood pressure measurement. Do not include any results that were given to you during your first antenatal care visit or during the first survey, only new ones."
label variable m2_503a`i' "503a. Did you receive a result for Anemia?"
label variable m2_503b`i' "503b. Did you receive a result for HIV?"
label variable m2_503c`i' "503c. Did you receive a result for HIV viral load?"
label variable m2_503d`i' "503d. Did you receive a result for Syphilis?"
label variable m2_503e`i' "503e. Did you receive a result for diabetes?"
label variable m2_503f`i' "503f. Did you receive a result for Hypertension?"
label variable m2_503g_za`i' "503g. Did you receive a result for TB?"
label variable m2_504`i' "504. Did you receive any other new test results?"
label variable m2_504_other`i' "504-Other. Specify other test result you receive"
label variable m2_505a`i' "505a. What was the result of the test for anemia?"
label variable m2_505b`i' "505b. What was the result of the test for HIV?"
label variable m2_505c`i' "505c. What was the result of the test for HIV viral load?"
label variable m2_505d`i' "505d. What was the result of the test for syphilis?"
label variable m2_505e`i' "505e. What was the result of the test for diabetes?"
label variable m2_505f`i' "505f. What was the result of the test for hypertension?"
label variable m2_505g`i' "505g. What was the result of the test for other tests?"
label variable m2_505h_za`i' "505h. What was the result of the test for TB? Remember that this information will remain fully confidential"
label variable m2_506a`i' "506a. Did you and a healthcare provider discuss about the signs of pregnancy complications that would require you to go to the health facility?"
label variable m2_506b`i' "506b. Did you and a healthcare provider discuss about your birth plan that is, where you will deliver, how you will get there, and how you need to prepare, or didnt you?"
label variable m2_506c`i' "506c. Did you and a healthcare provider discuss about care for the newborn when he or she is born such as warmth, hygiene, breastfeeding, or the importance of postnatal care?"
label variable m2_506d`i' "506d. Did you and a healthcare provider discuss about family planning options for after delivery?"
label variable m2_507`i' "507. What did the health care provider tell you to do regarding these new symptoms?"
label variable m2_507_other`i' "507-Other. KE only: Other advice, specify "
label variable m2_508a`i' "508a. Did you have a session of psychological counseling or therapy with any type of professional?  This could include seeing a mental health professional (like a phycologist, social worker, nurse, spiritual advisor or healer) for problems with your emotions or nerves."
label variable m2_508b_num`i' "508b. How many of these sessions did you have since you last spoke to us?"
label variable m2_508c_time`i' "508d. How many minutes did this/these visit(s) last on average?"
label variable m2_509a`i' "509a. Did a healthcare provider tells you that you needed to go see a specialist like an obstetrician or a gynecologist?"
label variable m2_509b`i' "509b. Did a healthcare provider tells you that you needed to go to the hospital for follow-up antenatal care?"
label variable m2_509c`i' "509c. Did a healthcare provider tell you that you will need a C-section?"
label variable m2_601a`i' "601a. Did you get iron or folic acid pills like IFAS or Pregnacare?"
label variable m2_601b`i' "601b. Did you get calcium pills?"
label variable m2_601c`i' "601c. Did you get multivitamins?"
label variable m2_601d`i' "601d. Did you get food supplements like Super Cereal or Plumpynut?"
label variable m2_601e`i' "601e. Did you get medicine for intestinal worm?"
label variable m2_601f`i' "601f. Did you get medicine for malaria?"
label variable m2_601g`i' "601g. Did you get medicine for HIV?"
label variable m2_601h`i' "601h. Did you get medicine for your emotions, nerves, depression, or mental health?"
label variable m2_601i`i' "601i. Did you get medicine for hypertension/high blood pressure?"
label variable m2_601j`i' "601j. Did you get medicine for diabetes, including injections of insulin?"
label variable m2_601k`i' "601k. Did you get antibiotics for an infection?"
label variable m2_601l`i' "601l. Did you get aspirin?"
label variable m2_601m`i' "601m. Did you get paracetamol, or other pain relief drugs?"
label variable m2_601o`i' "601o. Iron injection"
label variable m2_601n_other`i' "601n-oth. Specify other medicine or supplement you took"
label variable m2_602b`i' "602b. In total, how much did you pay for these new medications or supplements (in Ksh.)?"
label variable m2_603`i' "603. Are you currently taking iron and folic acid pills like IFAS and Pregnacare?"
label variable m2_701`i' "701. Did you pay any money out of your pocket for these new visits, including for the consultation or other indirect costs like your transport to the facility?"
label variable m2_702a_cost`i' "702a. Did you spend money on registration/consultation?"
label variable m2_702b_cost`i' "702b. Did you spend money on test or investigations (lab tests, ultrasound etc.)?"
label variable m2_702c_cost`i' "702c. Did you spend money on transport (round trip) including that of the person accompanying you?"
label variable m2_702d_cost`i' "702d. Did you spend money on food and accommodation including that of person accompanying you?"
label variable m2_702_other`i' "702e. Did you spend money for other services?"
label variable m2_702b_other`i' "702e: Other (specify)"
label variable m2_703`i' "702. Total amount spent"
label variable m2_704`i' "703: So, in total you spent [Interview add total from above] – is that correct?"
label variable m2_704_confirm`i' "704: So how much in total would you say you spent?"
label variable m2_705_1`i' "705. Current income of any household members"
label variable m2_705_2`i' "705. Savings (e.g., bank account)" 
label variable m2_705_3`i' "705. Payment or reimbursement from a health insurance plan"
label variable m2_705_4`i' "705. Sold items (e.g., furniture, animals, jewellery, furniture)"
label variable m2_705_5`i' "705. Family members or friends from outside the household"
label variable m2_705_6`i' "705. Borrowed (from someone other than a friend or family)"
label variable m2_705_96`i' "705. Other (please specify)"
label variable m2_705_other`i' "705-Other. Other financial sources, specify"

	}	

*===============================================================================

	* STEP FIVE: SAVE DATA TO RECODED FOLDER/ORDER VARIABLES
order m1_* m2_*, sequential

order pre_screening_num_za Eligible permission country respondentid interviewer_id m1_date m1_start_time study_site ///
      care_self enrollage enrollage_cat zone_live b5anc b6anc_first b7eligible mobile_phone flash study_site_sd facility
	  
order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate ///
	  bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic ///
	  bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)
	  
order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

order m2_permission* m2_date* m2_time_start* m2_interviewer* m2_maternal_death_reported* m2_date_of_maternal_death* ///
	  m2_ga* m2_hiv_status* m2_maternal_death_learn* ///
	  m2_maternal_death_learn_other*, after(m1_1401)

*------------------------------------------------------------------------------*

save "$za_data_final/eco_m1m2_za.dta", replace



*===============================================================================
* MODULE 3:

* Import data
import excel "$za_data/Module 3/Module 3_21Mar2024_clean.xlsx", sheet("MNH-Module-3-v0-2024321-945") firstrow clear

* SS: Dropping people who did not give permission (confirm with Catherine/ZA team)

drop if MOD3_Permission_Granted !=1 // N=9 dropped
drop if MOD3_Identification_102 == .

*------------------------------------------------------------------------------*

*dropping extra vars
drop RESPONSE_QuestionnaireID  RESPONSE_QuestionnaireName RESPONSE_QuestionnaireVersion RESPONSE_FieldWorkerID ///
	 RESPONSE_FieldWorker RESPONSE_Location RESPONSE_Lattitude RESPONSE_Longitude RESPONSE_StudyNoPrefix ///
	 RESPONSE_StudyNo StudyNumber ResponseID RESPONSE_StartTime

* de-identification	 
drop MOD3_Newborn_304_BabyName1 MOD3_Newborn_304a_BabyName2 MOD3_Newborn_304c_BabyName3	 
	 
*------------------------------------------------------------------------------*	
	* STEP ONE: RENAME VARAIBLES
	
* Variables from M2 in this dataset (keeping for skip pattern recoding in M3)
rename MOD3_Identification_101 m2_interviewer
rename CRHID respondentid
rename MOD3_Identification_107 m2_ga 
rename MOD3_Identification_108 m2_hiv_status
rename MOD3_Identification_109 m2_maternal_death_reported
rename MOD3_Identification_110 m2_date_of_maternal_death
rename MOD3_Identification_111 m2_maternal_death_learn 
rename MOD3_Identification_111_Other m2_maternal_death_learn_other
rename MOD3_Identification_201 m2_201
rename MOD3_Identification_202 m2_202 // 1 = yes still pregnant (no one in this module), 2 = no delievered, 3 = no something else happened 
	
rename MOD3_Permission_Granted m3_permission
rename MOD3_Identification_102 m3_date
rename MOD3_Identification_103 m3_time
rename MOD3_Newborn_302 m3_birth_or_ended
rename MOD3_Newborn_301 m3_303a
rename MOD3_Newborn_303_Baby1 m3_303b
rename MOD3_Newborn_303_Baby2 m3_303c
rename MOD3_Newborn_303_Baby3 m3_303d

rename MOD3_Newborn_305a_BabySex1 m3_baby1_gender
rename MOD3_Newborn_305b_BabySex2 m3_baby2_gender
rename MOD3_Newborn_305c_BabySex3 m3_baby3_gender
rename MOD3_Newborn_306 m3_baby1_age_weeks

rename (MOD3_Newborn_308a_BabyWt1 MOD3_Newborn_308b_BabyWt2 MOD3_Newborn_308c_BabyWt3 ///
		MOD3_Identification_307a_BabySiz MOD3_Newborn_307b_BabySize2 ///
		MOD3_Newborn_307c_BabySize3 MOD3_Newborn_309a_BabyHealth1 ///
		MOD3_Newborn_309b_BabyHealth2 MOD3_Newborn_309c_BabyHealth3) (m3_baby1_weight m3_baby2_weight ///
		m3_baby3_weight m3_baby1_size m3_baby2_size m3_baby3_size m3_baby1_health ///
		m3_baby2_health m3_baby3_health)
		
rename MOD3_Newborn_310b m3_breastfeeding 

rename (MOD3_Newborn_312_Baby1 MOD3_Newborn_312_Baby2 MOD3_Newborn_312_Baby3 ///
		MOD3_Newborn_312a_Baby1) (m3_baby1_deathga m3_baby2_deathga m3_baby3_deathga ///
		m3_baby1_born_alive)

rename MOD3_Newborn_312b_Baby2 m3_baby2_born_alive

rename (MOD3_Newborn_312c_Baby3 MOD3_Newborn_313a_1_Baby1) (m3_baby3_born_alive m3_313a_baby1)

rename (MOD3_Newborn_313b_1_Baby1 MOD3_Newborn_313a_2_Baby2) (m3_313e_baby1 m3_313a_baby2)

rename (MOD3_Newborn_313b_2_Baby2 MOD3_Newborn_313a_3_Baby3) (m3_313e_baby2 m3_313a_baby3)

rename MOD3_Newborn_313b_3_Baby3 m3_313e_baby3
rename MOD3_Newborn_314_1_Baby1 m3_death_cause_baby1 // SS: will likely need to pull data out from check boxes

rename MOD3_Newborn_314_1_Baby1_Other m3_death_cause_baby1_other
rename MOD3_Newborn_314_2_Baby2 m3_death_cause_baby2 // SS: will likely need to pull data out from check boxes

rename MOD3_Newborn_314_2_Baby2_Other m3_death_cause_baby2_other
rename MOD3_Newborn_314_3_Baby3 m3_death_cause_baby3 // SS: will likely need to pull data out from check boxes

rename MOD3_Newborn_314_3_Baby3_Other m3_death_cause_baby3_other
rename MOD3_AB_MC_1201 m3_1201

rename (MOD3_AB_MC_1202 MOD3_AB_MC_1203 MOD3_AB_MC_1204 MOD3_AB_MC_1205 ///
		MOD3_AB_MC_1205_Other MOD3_AB_MC_1206 MOD3_ANC_Care_401 ///
		MOD3_ANC_Care_402 MOD3_ANC_Care_403_C1 MOD3_ANC_Care_404_C1 ///
		MOD3_ANC_Care_405_C1) (m3_1202 m3_1203 m3_1204 m3_1205 m3_1205_other ///
		m3_1206 m3_401 m3_402 m3_consultation_1 m3_consultation_referral_1  ///
		m3_consultation1_reason) // SS: will likely need to pull data out from check boxes for m3_consultation1_reason

rename (MOD3_ANC_Care_405_C1Other MOD3_ANC_Care_406_C2 MOD3_ANC_Care_407_C2 ///
		MOD3_ANC_Care_408_C2) (m3_consultation1_reason_other m3_consultation_2 ///
		m3_consultation_referral_2 m3_consultation2_reason) // SS: will likely need to pull data out from check boxes for m3_consultation1_reason

rename (MOD3_ANC_Care_408_C2Other MOD3_ANC_Care_409_C3 MOD3_ANC_Care_410_C3 ///
		MOD3_ANC_Care_411_C3) (m3_consultation2_reason_other m3_consultation_3 ///
		m3_consultation_referral_3 m3_consultation3_reason)

rename MOD3_ANC_Care_411_C3_Other m3_consultation3_reason_other

rename MOD3_ANC_Care_412a m3_412a
rename MOD3_ANC_Care_412b m3_412b
rename MOD3_ANC_Care_412c m3_412c
rename MOD3_ANC_Care_412d m3_412d
rename MOD3_ANC_Care_412e m3_412e
rename MOD3_ANC_Care_412f m3_412f
rename MOD3_ANC_Care_412g m3_412g
rename MOD3_ANC_Care_412g_Other m3_412g_1_other

rename (MOD3_Care_Pathways_501 MOD3_Care_Pathways_502 MOD3_Care_Pathways_503) ///
	   (m3_501 m3_502 m3_503)

rename MOD3_Care_Pathways_504 m3_503_outside_zone_other

rename (MOD3_Care_Pathways_505a MOD3_Care_Pathways_505b) (m3_505a m3_505b)

rename (MOD3_Care_Pathways_505c_Date MOD3_Care_Pathways_505c_Time) (m3_506a m3_506b)

rename MOD3_Care_Pathways_507 m3_507

rename (MOD3_Care_Pathways_508 MOD3_Care_Pathways_509 MOD3_Care_Pathways_509_Other ///
		MOD3_Care_Pathways_510 MOD3_Care_Pathways_511 MOD3_Care_Pathways_512) ///
		(m3_508 m3_509 m3_509_other m3_510 m3_511 m3_512)

rename MOD3_Care_Pathways_513a m3_513a
rename MOD3_Care_Pathways_513b m3_513b1
rename MOD3_Care_Pathways_514 m3_514

rename (MOD3_Care_Pathways_515 MOD3_Care_Pathways_516 MOD3_Care_Pathways_516_Other ///
		MOD3_Care_Pathways_517 MOD3_Care_Pathways_518) (m3_515 m3_516 m3_516_other ///
		m3_517 m3_518)

rename (MOD3_Care_Pathways_517_97 MOD3_Care_Pathways_518_Other MOD3_Care_Pathways_519) ///
	   (m3_518_other_complications m3_518_other m3_519)

rename MOD3_Care_Pathways_520 m3_520
rename MOD3_Care_Pathways_521 m3_521

rename (MOD3_INTRAP_Care_601A MOD3_INTRAP_Care_601B MOD3_INTRAP_Care_601C ///
		MOD3_INTRAP_Care_602A MOD3_INTRAP_Care_602B MOD3_INTRAP_Care_603A ///
		MOD3_INTRAP_Care_603B MOD3_INTRAP_Care_603C) (m3_601a m3_601b m3_601c ///
	    m3_602a m3_602b m3_603a m3_603b m3_603c)

rename (MOD3_INTRAP_Care_604A MOD3_INTRAP_Care_604B MOD3_INTRAP_Care_605A ///
		MOD3_INTRAP_Care_605B MOD3_INTRAP_Care_605C) (m3_604a m3_604b m3_605a ///
		m3_605b m3_605c)

rename MOD3_INTRAP_Care_605C_Other m3_605c_other

rename (MOD3_INTRAP_Care_606 MOD3_INTRAP_Care_607) (m3_606 m3_607)

rename (MOD3_INTRAP_Care_608 MOD3_INTRAP_Care_609 MOD3_INTRAP_Care_610A ///
		MOD3_INTRAP_Care_610B MOD3_INTRAP_Care_611) (m3_608 m3_609 m3_610a ///
		m3_610b m3_611)

rename MOD3_INTRAP_Care_612 m3_612_za

rename (MOD3_INTRAP_Care_613 MOD3_INTRAP_Care_614) (m3_613 m3_614)

rename (MOD3_INTRAP_Care_615_B1 MOD3_INTRAP_Care_615_B2 MOD3_INTRAP_Care_615_B3 ///
		MOD3_INTRAP_Care_616_B1 MOD3_INTRAP_Care_616_B2 MOD3_INTRAP_Care_616_B3) ///
		(m3_615a m3_615b m3_615c m3_616a m3_616b m3_616c)

rename (MOD3_INTRAP_Care_617_B1 MOD3_INTRAP_Care_617_B2 MOD3_INTRAP_Care_617_B3) ///
		(m3_617a m3_617b m3_617c)

rename (MOD3_INTRAP_Care_618a_B1 MOD3_INTRAP_Care_618b_B1 MOD3_INTRAP_Care_618c_B1 ///
		MOD3_INTRAP_Care_618a_B2 MOD3_INTRAP_Care_618b_B2 MOD3_INTRAP_Care_618c_B2 ///
		MOD3_INTRAP_Care_618a_B3 MOD3_INTRAP_Care_618b_B3 MOD3_INTRAP_Care_618c_B3 ///
		MOD3_INTRAP_Care_619A MOD3_INTRAP_Care_619B MOD3_INTRAP_Care_619C ///
		MOD3_INTRAP_Care_619D MOD3_INTRAP_Care_619E) (m3_618a_1 m3_618b_1 m3_618c_1 ///
		m3_618a_2 m3_618b_2 m3_618c_2 m3_618a_3 m3_618b_3 m3_618c_3 m3_619a ///
		m3_619b m3_619c m3_619d m3_619e)

rename (MOD3_INTRAP_Care_619F MOD3_INTRAP_Care_619G) (m3_619g m3_619h)

rename (MOD3_INTRAP_Care_620_B1 MOD3_INTRAP_Care_620_B2 MOD3_INTRAP_Care_620_B3 ///
		MOD3_INTRAP_Care_621A) (m3_620_1 m3_620_2 m3_620_3 m3_621a)

rename (MOD3_INTRAP_Care_621B MOD3_INTRAP_Care_621C_Hrs) (m3_621b m3_621c)

rename (MOD3_INTRAP_Care_622A MOD3_INTRAP_Care_622B MOD3_INTRAP_Care_622C ///
	    MOD3_Newborn_311a_B1 MOD3_Newborn_311a_B2 MOD3_Newborn_311a_B3 ///
		MOD3_Newborn_311b_B1 MOD3_Newborn_311b_B2 MOD3_Newborn_311b_B3 ///
		MOD3_Newborn_311c_B1 MOD3_Newborn_311c_B2 MOD3_Newborn_311c_B3 ///
		MOD3_Newborn_311d_B1 MOD3_Newborn_311d_B2 MOD3_Newborn_311d_B3 ///
		MOD3_Newborn_311e_B1 MOD3_Newborn_311e_B2 MOD3_Newborn_311e_B3 ///
		MOD3_Newborn_311f_B1 MOD3_Newborn_311f_B2 MOD3_Newborn_311f_B3 ///
		MOD3_Newborn_311g_B1 MOD3_Newborn_311g_B2 MOD3_Newborn_311g_B3 ///
		MOD3_MAN_Complications_701 MOD3_MAN_Complications_702 MOD3_MAN_Complications_703) ///
		(m3_622a m3_622b m3_622c m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep ///
		m3_baby1_feeding m3_baby2_feeding m3_baby3_feeding m3_baby1_breath m3_baby2_breath ///
		m3_baby3_breath m3_baby1_stool m3_baby2_stool m3_baby3_stool m3_baby1_mood ///
		m3_baby2_mood m3_baby3_mood m3_baby1_skin m3_baby2_skin m3_baby3_skin ///
		m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity ///
		m3_701 m3_702 m3_703)

rename (MOD3_MAN_Complications_704A MOD3_MAN_Complications_704B MOD3_MAN_Complications_704C ///
		MOD3_MAN_Complications_704D MOD3_MAN_Complications_704E MOD3_MAN_Complications_704F ///
		MOD3_MAN_Complications_704G MOD3_MAN_Complications_705 MOD3_MAN_Complications_706 ///
		MOD3_MAN_Complications_707_HRS) (m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f ///
		m3_704g m3_705 m3_706 m3_707)

rename MOD3_MAN_Complications_708_B1 m3_708a

rename (MOD3_MAN_Complications_709_B1 MOD3_MAN_Complications_709_B1_Ot  ////
		MOD3_MAN_Complications_708_B2) (m3_baby1_issue_oth m3_baby1_issue_oth_text ///
		m3_708b)

rename (MOD3_MAN_Complications_709_B2 MOD3_MAN_Complications_709_B2_Ot) (m3_baby2_issue_oth m3_baby2_issue_oth_text)
tostring MOD3_MAN_Complications_708_B3, gen(m3_708c)

rename (MOD3_MAN_Complications_709_B3 MOD3_MAN_Complications_709_B3_Ot) ////
		(m3_baby3_issue_oth m3_baby3_issue_oth_text)

rename (MOD3_MAN_Complications_710_B1 MOD3_MAN_Complications_710_B2  ///
		MOD3_MAN_Complications_710_B3) (m3_baby1_710 m3_baby2_710 m3_baby3_710)
		
rename (MOD3_MAN_Complications_711_B1_HR MOD3_MAN_Complications_711_B1_DY MOD3_MAN_Complications_711_B2_HR ///
		MOD3_MAN_Complications_711_B2_DY MOD3_MAN_Complications_711_B3_HR MOD3_MAN_Complications_711_B3_DY) ///
		(m3_711a m3_711a_dys m3_711b m3_711b_dys m3_711c m3_711c_dys)

rename MOD3_MPPH_801A m3_801a
rename MOD3_MPPH_801B m3_801b

rename (MOD3_MPPH_802A MOD3_MPPH_802B MOD3_MPPH_802C MOD3_MPPH_803A MOD3_MPPH_803B ///
		MOD3_MPPH_803C MOD3_MPPH_803D MOD3_MPPH_803E MOD3_MPPH_803F MOD3_MPPH_803G ///
		MOD3_MPPH_803H) (m3_802a m3_802b m3_802c m3_803a m3_803b m3_803c m3_803d ///
		m3_803e m3_803f m3_803g m3_803h)

rename (MOD3_MPPH_804 MOD3_MPPH_804_Other) (m3_803j m3_803j_other)

rename (MOD3_MPPH_805 MOD3_MPPH_806 MOD3_MPPH_807 MOD3_MPPH_808A MOD3_MPPH_808B  ///
		MOD3_MPPH_808B_Other MOD3_MPPH_809 MOD3_MEDS_901A MOD3_MEDS_901B MOD3_MEDS_901C ///
		MOD3_MEDS_901D MOD3_MEDS_901E MOD3_MEDS_901F MOD3_MEDS_901G MOD3_MEDS_901H ///
		MOD3_MEDS_901i MOD3_MEDS_901J MOD3_MEDS_901K MOD3_MEDS_901L MOD3_MEDS_901M ///
		MOD3_MEDS_901N MOD3_MEDS_901O MOD3_MEDS_901P MOD3_MEDS_901Q MOD3_MEDS_901R ///
		MOD3_MEDS_901R_Other) (m3_805 m3_806 m3_807 m3_808a m3_808b m3_808b_other ///
		m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h ///
		m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q ///
		m3_901r m3_901r_other)

rename MOD3_MEDS_902A m3_902a_baby1
rename MOD3_MEDS_902B m3_902b_baby1
rename MOD3_MEDS_902C m3_902c_baby1
rename MOD3_MEDS_902D m3_902d_baby1
rename MOD3_MEDS_902E m3_902e_baby1
rename MOD3_MEDS_902F m3_902f_baby1
rename MOD3_MEDS_902G m3_902g_baby1
rename MOD3_MEDS_902H m3_902h_baby1
rename MOD3_MEDS_902i m3_902i_baby1

rename (MOD3_MEDS_902J MOD3_MEDS_902J_Other) (m3_902j_baby1 m3_902j_baby1_other)

rename (MOD3_User_Exp_1001 MOD3_User_Exp_1002 MOD3_User_Exp_1003 MOD3_User_Exp_1004A ///
		MOD3_User_Exp_1004B MOD3_User_Exp_1004C MOD3_User_Exp_1004D MOD3_User_Exp_1004E ///
		MOD3_User_Exp_1004F MOD3_User_Exp_1004G MOD3_User_Exp_1004H) (m3_1001 m3_1002 ///
		m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h)

rename (MOD3_User_Exp_1005A MOD3_User_Exp_1005B MOD3_User_Exp_1005C MOD3_User_Exp_1005D ///
		MOD3_User_Exp_1005E MOD3_User_Exp_1005F MOD3_User_Exp_1005G MOD3_User_Exp_1005H ///
		MOD3_User_Exp_1006A MOD3_User_Exp_1006B MOD3_User_Exp_1006C MOD3_User_Exp_1007A ///
		MOD3_User_Exp_1007B MOD3_User_Exp_1007C MOD3_Econ_OutC_1101) (m3_1005a m3_1005b ///
		m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c ///
		m3_1007a m3_1007b m3_1007c m3_1101)

rename MOD3_Econ_OutC_1102A m3_1102a_amt
rename MOD3_Econ_OutC_1102B m3_1102b_amt
rename MOD3_Econ_OutC_1102C m3_1102c_amt
rename MOD3_Econ_OutC_1102D m3_1102d_amt
rename MOD3_Econ_OutC_1102E m3_1102e_amt
rename MOD3_Econ_OutC_1102F_Other_Amoun m3_1102f_amt
rename MOD3_Econ_OutC_1102F_Other m3_1102f_oth
rename MOD3_Econ_OutC_1103 m3_1103

rename (MOD3_Econ_OutC_1102F_Total MOD3_Econ_OutC_1104) (m3_1102_total m3_1105)

rename (MOD3_Econ_OutC_1104_Other MOD3_Econ_OutC_1105) (m3_1105_other m3_1106)

* Data quality:


*==============================================================================*

	* STEP TWO: ADD VALUE LABELS
	* Will need to add data for baby 3 once that data is available 

lab def YN 1 "Yes" 0 "No" 99 "NR/RF" 98 "Don't Know" 95 "NA"
lab val m3_permission m3_303b m3_303c m3_303d YN 

lab def m3_303a 1 "1" 2 "2" 3 "3 or more" 98 "Don't Know" 99 "NR/RF"
lab val m3_303a m3_303a

lab def gender 1 "Male" 2 "Female" 3 "Indeterminate" 99 "NR/RF" 95 "NA"
lab val m3_baby1_gender m3_baby2_gender m3_baby2_gender gender 

lab def size 1 "Very large" 2 "Larger than average" 3 "Average" ///
			 4 "Smaller than average" 5 "Very small" 98 "Don't Know" 95 "NA"
lab val m3_baby1_size m3_baby2_size m3_baby3_size size

lab def health 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor" 99 "NR/RF" ///
			   95 "NA"
lab val m3_baby1_health m3_baby2_health m3_baby3_health health

*m3_baby1_feeding
	tab MOD3_Newborn_310a_1_IYCF_B1,m
	replace MOD3_Newborn_310a_1_IYCF_B1 =".a" if m3_303b !=1 | m2_202 ==3 | m2_202 ==.
	forval j = 1/99 {
    gen m3_baby1_feed_`j' = strpos("," + MOD3_Newborn_310a_1_IYCF_B1 + ",", ",`j',") > 0
	}
	drop m3_baby1_feed_8-m3_baby1_feed_94
	drop m3_baby1_feed_96-m3_baby1_feed_97
	drop MOD3_Newborn_310a_1_IYCF_B1
	
	rename (m3_baby1_feed_1 m3_baby1_feed_2 m3_baby1_feed_3 m3_baby1_feed_4 ///
			m3_baby1_feed_5 m3_baby1_feed_6 m3_baby1_feed_7) (m3_baby1_feed_a m3_baby1_feed_b ///
			m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g)
	
	label values m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d ///
				 m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_95 m3_baby1_feed_98 m3_baby1_feed_98 YN
	
*m3_baby2_feeding
	tab MOD3_Newborn_310a_2_IYCF_B2,m
	replace MOD3_Newborn_310a_2_IYCF_B2 =".a" if m3_303c !=1 | m2_202 ==3 | m2_202 ==. | m3_303a !=2 // N=1 missing, N=1 changed from 2 to .a
	forval j = 1/99 {
    gen m3_baby2_feed_`j' = strpos("," + MOD3_Newborn_310a_2_IYCF_B2 + ",", ",`j',") > 0
	}
	drop m3_baby2_feed_8-m3_baby2_feed_94
	drop m3_baby2_feed_96-m3_baby2_feed_97
	drop MOD3_Newborn_310a_2_IYCF_B2
	
	rename (m3_baby2_feed_1 m3_baby2_feed_2 m3_baby2_feed_3 m3_baby2_feed_4 ///
			m3_baby2_feed_5 m3_baby2_feed_6 m3_baby2_feed_7) (m3_baby2_feed_a m3_baby2_feed_b ///
			m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g)
	
	label values m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d ///
				 m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_95 m3_baby2_feed_98 m3_baby2_feed_99 YN


*m3_baby3_feeding - 5-20 SS: only 99998 in the data for this var
	tab MOD3_Newborn_310a_3_IYCF_B3,m
	tostring MOD3_Newborn_310a_3_IYCF_B3, replace
	replace MOD3_Newborn_310a_3_IYCF_B3 =".a" if m3_303d !=1 | m2_202 ==3 | m2_202 ==. | m3_303a !=3
	forval j = 1/99 {
    gen m3_baby3_feed_`j' = strpos("," + MOD3_Newborn_310a_3_IYCF_B3 + ",", ",`j',") > 0
	}
	drop m3_baby3_feed_8-m3_baby3_feed_94
	drop m3_baby3_feed_96-m3_baby3_feed_97
	drop MOD3_Newborn_310a_3_IYCF_B3 
	
	rename (m3_baby3_feed_1 m3_baby3_feed_2 m3_baby3_feed_3 m3_baby3_feed_4 ///
			m3_baby3_feed_5 m3_baby3_feed_6 m3_baby3_feed_7) (m3_baby3_feed_a m3_baby3_feed_b ///
			m3_baby3_feed_c m3_baby3_feed_d m3_baby3_feed_e m3_baby3_feed_f m3_baby3_feed_g)
	
	label values m3_baby3_feed_a m3_baby3_feed_b m3_baby3_feed_c m3_baby3_feed_d ///
				 m3_baby3_feed_e m3_baby3_feed_f m3_baby3_feed_g m3_baby3_feed_95 m3_baby3_feed_98 m3_baby3_feed_99 YN

lab def confidence 1 "Not at all confident" 2 "Not very confident" 3 "Somewhat confident" ///
				   4 "Confident" 5 "Very confident" 96 "I do not breastfeed" 99 "NR/RF"
lab val m3_breastfeeding confidence				   
				 
lab def sleeping 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" ///
			  4 "Severely disturbed sleep"
lab val m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep			  

lab def feeding 1 "Normal feeding" 2 "Slight feeding problems" 3 "Moderate feeeding problems" ///
				4 "Severe feeding problems" 95 "NA"
lab val m3_baby1_feeding m3_baby2_feeding m3_baby3_feeding feeding

lab def breathing 1 "Normal breathing" 2 "Slight breathing problems" ///
				  3 "Moderate breathing problems" 4 "Severe breathing problems" ///
				  95 "NA"
lab val m3_baby1_breath m3_baby2_breath m3_baby3_breath

lab def stooling 1 "Normal stooling/poo" 2 "Slight stooling/poo problems" ///
				 3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems" 
lab val m3_baby1_stool m3_baby2_stool m3_baby3_stool stooling 			 

lab def mood 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying" 95 "NA"
lab val m3_baby1_mood m3_baby2_mood m3_baby3_mood mood

lab def skin 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin" ///
			 4 "Bleeding or cracked skin"
lab val m3_baby1_skin m3_baby2_skin m3_baby3_skin skin 

lab def interactivity 1 "Highly playful/interactive" 2 "Playful/interactive" ///
					  3 "Less playful/less interactive" 4 "Low energy/inactive/dull"
lab val m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity interactivity

*SS: codebook says "NA" is = 13.1 for m3_baby3_deathga					  
lab def newborn_deathga 1 "Before 20 weeks" 2 "After 20 weeks" 95 "NA"			  
lab val m3_baby1_deathga m3_baby2_deathga m3_baby3_deathga newborn_deathga				 

lab val m3_baby1_born_alive m3_baby2_born_alive m3_baby3_born_alive YN				 

lab def cause_of_death 0 "Not told anything" 1 "The baby was premature (born too early)" ///
					   2 "An infection" ///
					   3 "A congenital abnormality (genetic or acquired issues with growth/ development)" ///
					   4 "A birth injury or asphyxia (occurring because of delivery complications)" ///
					   5 "Difficulties breathing" 6 "Unexplained causes" ///
					   7 "You decided to have an abortion" 95 "NA" 96 "Other (specify)"
					   
lab val m3_death_cause_baby1 m3_death_cause_baby2 m3_death_cause_baby3 cause_of_death				 

lab val m3_401 m3_consultation_1 m3_consultation_referral_1 m3_consultation_2 m3_consultation_referral_2 m3_consultation_3 m3_consultation_referral_3 YN

lab def reason 1 "A new health problem, including an emergency or an injury" ///
			   2 "An existing health problem" 3 "A lab test, x-ray, or ultrasound" ///
			   4 "To pick up medicine" 5 "To get a vaccine" ///
			   96 "Other reasons, please specify"
lab val m3_consultation1_reason m3_consultation2_reason m3_consultation3_reason reason 

lab val m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_501 YN 

lab def m3_502 1 "In your home" 2 "Someone else's home" 3 "Public clinic" ///
			   4 "Public hospital" 5 "Private clinic" 6 "Private hospital" ///
			   7 "Public Community health center" 8 "Other" 98 "Don't Know" ///
			   99 "NR/RF"
lab val m3_502 m3_502

lab val m3_505a m3_508 YN 

lab def m3_509 1 "High cost" 2 "Far distance" 3 "Long waiting time" ///
			   4 "Poor healthcare provider skills" 5 "Staff don't show respect" ///
			   6 "Medicines and equipment are not available" ///
			   7 "Facility not clean and/or comfortable" ///
			   8 "Not necessary (e.g., able to receive enough care at home, traditional care)" ///
			   9 "COVID-19 restrictions" 10 "COVID-19 fear" 11 "No female provider" ///
			   12 "Husband/family did not allow it" 13 "Facility was closed" ///
			   14 "Delivered on the way (tried to go)" 96 "Other, specify" ///
			   99 "NR/RF"
lab val m3_509 m3_516 m3_509

lab val m3_510 YN

lab def m3_512 1 "Public clinic" 2 "Public hospital" 3 "Private clinic" ///
			   4 "Private hospital" 5 "Public Community health center" ///
			   6 "Other" 98 "Don't Know" 99 "NR/RF"
lab val m3_512 m3_512

lab def m3_515 1 "The first facility was closed" 2 "Provider referred you to this other facility without checking you" 3 "Provider checked you but referred you to this other facility" 4 "You decided to leave" 5 "A family member decided you should leave"

lab val m3_515 m3_515 

lab val m3_517 YN 

lab def m3_518 0 "The provider did not give a reason" 1 "No space or no bed available" ///
			   2 "Facility did not provide delivery care" 3 "Prolonged labor" ///
			   4 "Obstructed labor" 5 "Eclampsia/pre-eclampsia" 6 "Previous cesarean section scar"  /// 
			   7 "Fetal distress" 8 "Fetal presentation" 9 "No fetal movement/heartbeat" 10 "Bleeding" ///
			   96 "Other delivery complications (specify" 97 "Other reasons (specify)" ///
			   98 "Don't Know" 99 "NR/RF"
lab val m3_518 m3_518

lab def m3_519 1 "Low cost of delivery" 2 "Close to home" 3 "Short waiting time or enough HCWs" ///
			   4 "Good healthcare provider skills" 5 "Staff are respectful / nice" ///
			   6 "Medicine and equipment available" 7 "Facility is clean and/or comfortable" ///
			   8 "I delivered here before" 9 "Possible within COVID restrictions" ///
			   10 "Low risk of getting COVID-19" 11 "Female providers available" ///
			   12 "I was told by family member" 13 "I was told by a health worker" ///
			   14 "Familiarity with health worker" 15 "Familiarity with facility" ///
			   16 "Emergency care is available if need" 17 "Birth companion can come with me" ///
			   96 "Other" 98 "Don't Know" 99 "No response"
lab val m3_519 m3_519 

lab val m3_601a m3_601b m3_601c m3_602a m3_602b m3_603a m3_603b m3_603c YN 

lab def m3_604a 1 "My own bed" 2 "A shared bed" 3 "A mattress on the floor" ///
				4 "The floor" 5 "A chair" 6 "I was standing" 98 "Don't Know" ///
				99 "NR/RF"
lab val m3_604a m3_604a
				
lab val m3_604b m3_605a YN
 
lab def m3_605b 1 "Before" 2 "After" 98 "Don't Know" 99 "NR/RF"
lab val m3_605b m3_605b

lab def m3_605c 0 "I was not told" 1 "It was previously planned for medical reasons" 2 "I asked for a c-section" 3 "Problems arose during labor" 96 "Other, specify"
lab val m3_605c m3_605c

lab val m3_606 m3_607 m3_608 YN

lab def m3_609 1 "Yes" 0 "No" 98 "Don't Know" 99 "NR/RF" 95 "NA - stillbirth"
lab val m3_609 m3_615a m3_609

lab val m3_610a m3_610b m3_611 m3_613 m3_615b m3_615c m3_617a m3_617b ///
		m3_617c m3_618a_1 m3_618a_2 m3_618a_3 YN 
 
lab def hiv_test_result 0 "Negative" 1 "Positive" 2 "Did not receive results" ///
						98 "Don't Know" 99 "NR/RF"		
lab val m3_618b_1 m3_618b_2 m3_618b_3 hiv_test_result
 
lab val m3_618c_1 m3_618c_2 m3_618c_3 m3_619a m3_619b m3_619c m3_619d ///
		m3_619e m3_619g m3_620_1 m3_620_2 m3_620_3 YN 
 
lab def m3_621a 1 "A relative or a friend" 2 "A traditional birth attendant" ///
				3 "A community health worker" 4 "A nurse" 5 "A midwife" ///
				6 "A doctor" 98 "Don't Know" 99 "NR/RF"
lab val m3_621a m3_621a

lab val m3_621b m3_622a YN

lab def m3_622b 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10" ///
				11 "11 days and above"
lab val m3_622b m3_622b

lab val m3_622c m3_701 m3_703 m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g YN 

lab def m3_705 1 "Yes" 0 "No" 98 "Don't Know" 99 "NR/RF" 95 "NA - home delivery"
lab val m3_705 m3_705

lab val m3_706 YN 

*m3_708a
	tab m3_708a,m 
	forval j = 1/99 {
    gen m3_baby1_issues_`j' = strpos("," + m3_708a + ",", ",`j',") > 0
	}
	drop m3_baby1_issues_7-m3_baby1_issues_94
	drop m3_baby1_issues_96-m3_baby1_issues_97 
	drop m3_708a
	
	rename (m3_baby1_issues_1 m3_baby1_issues_2 m3_baby1_issues_3 m3_baby1_issues_4 ///
			m3_baby1_issues_5 m3_baby1_issues_6) (m3_baby1_issues_a m3_baby1_issues_b ///
			m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f)
	
	label values m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d ///
				 m3_baby1_issues_e m3_baby1_issues_f YN		 

*m3_708b
	tab m3_708b,m 
	forval j = 1/99 {
    gen m3_baby2_issues_`j' = strpos("," + m3_708b + ",", ",`j',") > 0
	}
	drop m3_baby2_issues_7-m3_baby2_issues_94
	drop m3_baby2_issues_96-m3_baby2_issues_97
	drop m3_708b
	
	rename (m3_baby2_issues_1 m3_baby2_issues_2 m3_baby2_issues_3 m3_baby2_issues_4 ///
			m3_baby2_issues_5 m3_baby2_issues_6) (m3_baby2_issues_a m3_baby2_issues_b ///
			m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f)
	
	label values m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d ///
				 m3_baby2_issues_e m3_baby2_issues_f YN
 
*m3_708c
	tab m3_708c,m 
	forval j = 1/99 {
    gen m3_baby3_issues_`j' = strpos("," + m3_708c + ",", ",`j',") > 0
	}
	drop m3_baby3_issues_7-m3_baby3_issues_94
	drop m3_baby3_issues_96-m3_baby3_issues_97
	drop m3_708c
	
	rename (m3_baby3_issues_1 m3_baby3_issues_2 m3_baby3_issues_3 m3_baby3_issues_4 ///
			m3_baby3_issues_5 m3_baby3_issues_6) (m3_baby3_issues_a m3_baby3_issues_b ///
			m3_baby3_issues_c m3_baby3_issues_d m3_baby3_issues_e m3_baby3_issues_f)
	
	label values m3_baby3_issues_a m3_baby3_issues_b m3_baby3_issues_c m3_baby3_issues_d ///
				 m3_baby3_issues_e m3_baby3_issues_f YN 
 
 
lab val m3_baby1_issue_oth m3_baby2_issue_oth m3_baby3_issue_oth YN

lab def phq2 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" ///
			 3 "Nearly every day" 99 "NR/RF"
lab val m3_801a m3_801b phq2

lab val m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h ///
		m3_803j m3_805 YN  

lab def m3_807 0 "Not at all" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" ///
			   10 "A great deal (10)" 99 "NR/RF"
lab val m3_807 m3_807

lab val m3_808a YN	

lab def m3_808b 1 "Do not know can be fixed" 2 "Do not know where to go" ///
				3 "Too expensive" 4 "Too far" 5 "Poor quality of care" ///
				6 "Could not get permission" 7 "Embarrassment" 8 "Problem dissappeared" ///
				96 "Other (specify)" 98 "Don't Know" 99 "NR/RF"
lab val m3_808b m3_808b

lab def m3_809 1 "Yes, no more leakage at all" 2 "Yes, but still some leakage" ///
			   3 "No, still have problem" 98 "Don't Know" 99 "NR/RF"
lab val m3_809 m3_809 

lab val m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i ///
		m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r ///
		m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 ///
		m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 YN		   
			   
lab def m3_1001 1 "Poor" 2 "Fair" 3 "Good" 4 "Very good" 5 "Excellent" ///
				6 "NA (e.g. no antenatal tests)" 98 "NR/RF" ///
				95 "Delivered at home"
lab val m3_1001  m3_1001			
 
lab def endorse 1 "Very likely" 2 "Somewhat likely" 3 "Not too likely" ///
				4 "Not at all likely" 98 "Don't know" 99 "NR/RF"
lab val m3_1002 endorse

lab val m3_1003 YN

lab val m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h health				
lab val m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h ///
		m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1101 m3_1103 YN  

*m3_1105
	tab m3_1105 
	forval j = 1/96 {
    gen m3_1105`j' = strpos("," + m3_1105 + ",", ",`j',") > 0
	}
	drop m3_11057-m3_110595
	drop m3_1105
	
	rename (m3_11051 m3_11052 m3_11053 m3_11054 m3_11055 m3_11056 m3_110596) ///
		   (m3_1105a m3_1105b m3_1105c m3_1105d m3_1105e m3_1105f m3_1105_96)
	
	label values m3_1105a m3_1105b m3_1105c m3_1105d m3_1105e m3_1105f m3_1105_96 YN


lab def satisfaction 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" ///
					 4 "Dissatisfied" 5 "Very dissatisfied" 98 "Don't Know" 99 "NR/RF"
lab val m3_1106 satisfaction					 
				
lab val m3_1201 m3_1203 YN 

lab val m3_1202 m3_1204 health 				
				
lab def m3_1205 1 "Public clinic" 2 "Public hospital" 3 "Private clinic" ///
				4 "Private hospital" 5 "Public community health center" ///
				6 "Other" 98 "Don't Know" 99 "NR/RF"
lab val m3_1205 m3_1205 				
				
* Formatting Dates
* Dates: m3_313a_baby1,m3_313a_baby2, m3_313a_baby3, m3_506a

*==============================================================================*	
	
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		
*SS: missing vars because 0 obs or not in dataset: m3_baby3_feeding

recode m3_303a m3_baby1_size m3_baby2_size m3_baby3_size m3_baby1_born_alive ///
	   m3_baby2_born_alive m3_baby3_born_alive m3_401 m3_consultation_1  ///
	   m3_consultation_referral_1 m3_consultation_3 m3_consultation_referral_3 ///
	   m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g m3_501 m3_502 ///
	   m3_505a m3_510 m3_512 m3_518 m3_519 m3_601a m3_601b m3_601c m3_602a m3_602b ///
	   m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 ///
	   m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a m3_615b m3_615c m3_617a m3_617b ///
	   m3_617c m3_618a_1 m3_618a_2 m3_618a_3 m3_618b_1 m3_618b_2 m3_618b_3 m3_618c_1 ///
	   m3_618c_2 m3_618c_3 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g ///
	   m3_620_1 m3_620_2 m3_620_3 m3_621a m3_622a m3_622c m3_701 m3_703 m3_704a m3_704b ///
	   m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_baby1_710 m3_baby2_710 ///
	   m3_baby3_710 m3_802a m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g ///
	   m3_803h m3_803j m3_805 m3_808b m3_809 m3_901a m3_901b m3_901c m3_901d m3_901e ///
	   m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o ///
	   m3_901p m3_901q m3_901r m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 ///
	   m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 ///
	   m3_1001 m3_1002 m3_1003 m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g ///
	   m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c m3_1106 m3_1205 ///
	   m3_baby1_weight m3_baby2_weigh m3_612_za m3_614 m3_616a m3_802b m3_802c (98 = .d) // add m3_507 once it's cleaned
		
recode m3_303a m3_303b m3_303c m3_303d m3_baby1_gender m3_baby2_gender ///
	   m3_baby3_gender m3_baby1_health m3_baby2_health m3_baby3_health ///
	   m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d  ///
	   m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g m3_baby1_feed_99 ///
	   m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d ///
	   m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g m3_baby2_feed_99 ///
	   m3_breastfeeding m3_baby1_born_alive m3_baby2_born_alive ///
	   m3_baby3_born_alive m3_401 m3_consultation_1 m3_consultation_referral_1 ///
	   m3_consultation_3 m3_consultation_referral_3 m3_412a m3_412b m3_412c ///
	   m3_412d m3_412e m3_412f m3_412g m3_501 m3_502 m3_505a m3_509 m3_510 ///
	   m3_512 m3_516 m3_517 m3_518 m3_519 m3_601a m3_601b m3_601c m3_602a m3_602b ///
	   m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a m3_605b m3_606 m3_607 m3_608 ///
	   m3_609 m3_610a m3_610b m3_611 m3_613 m3_615a m3_615b m3_615c m3_617a m3_617b ///
	   m3_617c m3_618a_1 m3_618a_2 m3_618a_3 m3_618b_1 m3_618b_2 m3_618b_3 m3_618c_1 ///
	   m3_618c_2 m3_618c_3 m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g ///
	   m3_620_1 m3_620_2 m3_620_3 m3_621a m3_621b m3_622a m3_622c m3_701 m3_703 m3_704a ///
	   m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 m3_baby1_710 ///
	   m3_baby2_710 m3_baby3_710 m3_801a m3_801b m3_802a m3_803a m3_803b m3_803c m3_803d ///
	   m3_803e m3_803f m3_803g m3_803h m3_803j m3_805 m3_807 m3_808b m3_809 m3_901a ///
	   m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k ///
	   m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r m3_902a_baby1 m3_902b_baby1 ///
	   m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 ///
	   m3_902i_baby1 m3_902j_baby1 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d ///
	   m3_1004e m3_1004f m3_1004g m3_1004h m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e ///
	   m3_1005f m3_1005g m3_1005h m3_1006a m3_1006b m3_1006c m3_1007a m3_1007b m3_1007c ///
	   m3_1101 m3_1106 m3_1201 m3_1202 m3_1203 m3_1204 m3_1205 m3_612_za m3_802b m3_802c (99 = .r)
	
*SS: confirm with Catherine that she wants these to be recoded like this	
	* Also should m3_1001 be here?
	* confirm 95 in m3_507 = .a?
recode m3_303c m3_303d m3_baby2_gender m3_baby3_gender m3_baby2_size ///
	   m3_baby3_size m3_baby2_health m3_baby3_health m3_baby2_feed_a ///
	   m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e ///
	   m3_baby2_feed_f m3_baby2_feed_99 m3_baby2_sleep ///
	   m3_baby3_sleep m3_baby2_feeding m3_baby3_feeding m3_baby2_breath ///
	   m3_baby3_breath m3_baby2_stool m3_baby3_stool m3_baby2_mood ///
	   m3_baby3_mood m3_baby2_skin m3_baby3_skin m3_baby2_interactivity ///
	   m3_baby3_interactivity m3_baby1_deathga m3_baby2_deathga ///
	   m3_baby3_deathga m3_baby2_born_alive m3_baby3_born_alive m3_death_cause_baby2 ///
	   m3_death_cause_baby3 m3_consultation_3 m3_505a m3_508 m3_510 m3_517 m3_609 ///
	   m3_615a m3_615b m3_615c m3_617b m3_617c m3_618a_1 m3_618a_2 m3_618a_3 ///
	   m3_618b_2 m3_618b_3 m3_618c_2 m3_618c_3 m3_620_2 m3_620_3 m3_705 m3_baby2_710 ///
	   m3_baby3_710 m3_802a m3_902a_baby1 m3_902i_baby1 m3_614 m3_616a m3_616b (95 = .a) // add m3_507 once it's cleaned, confirm m3_614, m3_616a, and m3_616b should be here
	   
* Other
* ZA only: 01-01-1998 = .d and 01-01-1999 = .r

recode m3_birth_or_ended (13880 = .d) // double check this for all dates

recode m3_506a (12784 = .a) // jan 01 1995 = .a?

*------------------------------------------------------------------------------*
* recoding for skip pattern logic:	   
* Recode missing values to NA for questions respondents would not have been asked due to skip patterns
 
recode m3_303a (. = .a) if m2_202 !=2

recode m3_birth_or_ended m3_303b (. = .a) if m2_202 !=2 | m2_202 !=3

recode m3_303c (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=2 | m3_303a !=3

recode m3_303d (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=3

recode m3_baby1_gender m3_baby1_weight m3_baby1_health m3_baby1_sleep m3_baby1_feeding m3_baby1_breath ///
	   m3_baby1_stool m3_baby1_mood m3_baby1_skin m3_baby1_interactivity m3_baby1_size (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3

recode m3_baby2_gender m3_baby2_weight m3_baby2_health m3_baby2_sleep m3_baby2_feeding m3_baby2_breath ///
	   m3_baby2_stool m3_baby2_mood m3_baby2_skin m3_baby2_interactivity m3_baby2_size (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | ///
	   m3_303a !=2 | m3_303a !=3

recode m3_baby3_gender m3_baby3_weight m3_baby3_health m3_baby3_sleep m3_baby3_feeding m3_baby3_breath ///
	   m3_baby3_stool m3_baby3_mood m3_baby3_skin m3_baby3_interactivity m3_baby3_size (. 9999998 = .a) ///
	   if m2_202 !=2 | m2_202 !=3 | m3_303a !=3

recode m3_baby1_age_weeks (99998 999998 9999998 . = .a) if m2_202 !=2 | m2_202 !=3

recode m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f m3_baby1_feed_g ///
	   m3_baby1_feed_95 m3_baby1_feed_98 m3_baby1_feed_99 (0 = .a) if m2_202 !=2 | m2_202 !=3
	   
recode m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f m3_baby2_feed_g ///
	   m3_baby2_feed_95 m3_baby2_feed_98 m3_baby2_feed_99 (0 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=2 
	   
recode m3_baby3_feed_a m3_baby3_feed_b m3_baby3_feed_c m3_baby3_feed_d m3_baby3_feed_e m3_baby3_feed_f m3_baby3_feed_g ///
	   m3_baby3_feed_95 m3_baby3_feed_98 m3_baby3_feed_99 (0 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=3 
	   
recode m3_breastfeeding (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 	 

recode m3_baby1_deathga (. 9999998 = .a) if m3_303b !=0

recode m3_baby2_deathga (. 9999998 = .a) if m3_303c !=0

recode m3_baby3_deathga (. 9999998 = .a) if m3_303d !=0

recode m3_baby1_born_alive (. 9999998 = .a) if m3_baby1_deathga !=2

recode m3_baby2_born_alive (. 9999998 = .a) if m3_baby2_deathga !=2

recode m3_baby3_born_alive (. 9999998 = .a) if m3_baby3_deathga !=2

recode m3_313a_baby1 m3_313e_baby1 (. 9978082 9999998 = .a) if m3_baby1_born_alive !=1

recode m3_313a_baby2 m3_313e_baby2 (. 9978082 9999988 9999998 = .a) if m3_baby2_born_alive !=1

recode m3_313a_baby3 m3_313e_baby3 (. 9999998 = .a) if m3_baby3_born_alive !=1

recode m3_death_cause_baby1 (. 9999998 = .a) if m3_baby1_born_alive !=1

replace m3_death_cause_baby1_other = ".a" if m3_death_cause_baby1 !=96

recode m3_death_cause_baby2 (. 9999998 = .a) if m3_baby2_born_alive !=1

recode m3_death_cause_baby2_other (. 9999998 = .a) if m3_death_cause_baby2 !=96 // numeric bc of 0 obs

recode m3_death_cause_baby3 (. 9999998 = .a) if m3_baby3_born_alive !=1

recode m3_death_cause_baby3_other (. 9999998 = .a) if m3_death_cause_baby3 !=96 // numeric bc of 0 obs

recode m3_401 (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3

recode m3_402 (. 9999998 = .a) if m3_401 !=1

recode m3_consultation_1 (. 9999998 = .a) if m3_401 !=1 | m3_402 == . | m3_402 == .a

recode m3_consultation_referral_1 (. 9999998 = .a) if m3_401 !=1 | m3_consultation_1 !=0 

recode m3_consultation1_reason (. 9999998 = .a) if m3_401 !=1 | m3_consultation_1 !=0 | ///
	   m3_consultation_referral_1 !=0 

replace m3_consultation1_reason_other = ".a" if m3_consultation1_reason !=96	   
	   
recode m3_consultation_2 (. 9999998 = .a) if m3_401 !=1 | m3_402 == 1 | m3_402 == . | m3_402 == .a

recode m3_consultation_referral_2 (. 9999998 = .a) if m3_401 !=1 | m3_consultation_2 !=0 

recode m3_consultation2_reason (. 9999998 = .a) if m3_401 !=1 | m3_consultation_2 !=0 | ///
	   m3_consultation_referral_2 !=0 
	   
replace m3_consultation2_reason_other = ".a" if m3_consultation2_reason !=96	 
	   
recode m3_consultation_3 (. 9999998 = .a) if m3_401 !=1 | m3_402 == 2 | m3_402 == 1 | m3_402 == . | m3_402 == .a

recode m3_consultation_referral_3 (. 9999998 = .a) if m3_401 !=1 | m3_consultation_3 !=0 

recode m3_consultation3_reason (. 9999998 = .a) if m3_401 !=1 | m3_consultation_3 !=0 | ///
	   m3_consultation_referral_3 !=0 
	   
replace m3_consultation3_reason_other = ".a" if m3_consultation3_reason !=96	 

recode m3_412a m3_412b m3_412c m3_412d m3_412e m3_412f m3_412g (. 9999998 = .a) if m3_401 !=1 // N= 8 missing data 

replace m3_412g_1_other = ".a" if m3_412g !=1

recode m3_501 (. 9999998 = .a) if m3_birth_or_ended == . | m3_birth_or_ended == .a | m3_birth_or_ended == .d | ///
								  m3_303b !=1 | m3_303b ==. | m3_303b ==.a | m2_202 !=2 // N= 96 people who delivered who have no data if they delivered in a health facility?

recode m3_502 (. 9999998 = .a) if m3_501 !=1

replace m3_503 = ".a" if m3_501 !=1  // this should be a numeric var
replace m3_503 = ".d" if m3_503 == "98"
replace m3_503 = ".r" if m3_503 == "99"

replace m3_503_outside_zone_other = ".a" if m3_501 !=1 // ASK: ALL WOMEN WHO DELIVERED IN A FACILITY OUTSIDE OF ZONE/COUNTY
 
recode m3_505a (. 9999998 = .a) if m2_202 !=2 | m3_502 == . | m3_502 == .a | m3_502 == 1 // confirm people who delivered at home wouldn't have been asked this question

recode m3_505b (. 9999998 999998= .a) if m3_505a !=1

recode m3_506a m3_506b (. 9978082 9999998 998 = .a) if m3_501 !=1 | (m3_501 ==1 & m3_505a !=1) // what is 01jan199 and 21feb1995 in m3_506a? confirm 00:00 (many) and 8.621e+14 in m3_506b. add m3_507 once it's cleaned

replace m3_506b = .a if m3_501 !=1 
replace m3_506b = .a if m3_506a ==.a

*m3_507 
replace m3_507 = ".d" if m3_507 == "98"
replace m3_507 = ".a" if m3_501 !=1
replace m3_507 = "12:00" if m3_507 == "12:00_ 03 January 2024"
replace m3_507 = ".a" if m3_507 == "95"
replace m3_507 = "8:40" if m3_507 == "8;40"
replace m3_507 = "14:00" if m3_507 == "16 Dec 2023. ...14:00"
replace m3_507 = ".a" if m3_501 !=1 & m3_505a !=1
 
recode m3_508 (. 9999998 = .a) if m2_202 !=2 | m3_502 != 1

recode m3_509 (. 9999998 = .a) if m2_202 !=2 | m3_502 != 1

replace m3_509_other = ".a" if m3_509 !=96 // N=1 missing response

recode m3_510 (. 9999998 = .a) if m3_501 !=1 // N=2 with 999998 responses

recode m3_511 (. 9999998 = .a) if m3_510 !=1

recode m3_512 (. 9999998 = .a) if m3_510 !=1 | m3_511 <=1 | m3_511 == . | m3_511 == .a

replace m3_513a = ".a" if m3_510 !=1

replace m3_513b1 = ".a" if m3_510 !=1

replace m3_514 = "08:00" if m3_514 == "08:00 a.m"
replace m3_514 = "00:00" if m3_514 == "00:00:00"
replace m3_514 = ".a" if m3_511 ==.d | m3_511 ==.r | m3_511 ==.a | m3_510 == 0 
encode m3_514, gen(recm3_514) // N =4 missing data 
drop m3_514
format recm3_514 %tcHH:MM

recode m3_515 (. 9999998 = .a) if m3_510 !=1 | m3_511 ==.d | m3_511 ==.r | m3_511 ==.a

recode m3_516 (. 9999998 = .a) if m3_515 !=4 | m3_515 !=5

replace m3_516_other = ".a" if m3_516 !=96

recode m3_517 (. 9999998 = .a) if m3_515 !=2 | m3_515 !=3

recode m3_518 (. 9999998 = .a) if m3_517 !=1 | m3_517 !=.a

replace m3_518_other_complications = ".a" if m3_518 !=96

replace m3_518_other = ".a" if m3_518 !=97

recode m3_519 (. 9999998 = .a) if m3_510 == 1 | m3_510 == .a | m3_510 == 9999998 | m3_501 !=1

replace m3_520 = ".a" if m3_501 !=1
replace m3_520 = ".a" if m3_520 == "95" // SS: confirm
replace m3_520 = ".d" if m3_520 == "98" // SS: confirm
replace m3_520 = ".d" if m3_520 == "Don't remember" // SS: confirm
replace m3_520 = "." if m3_520 == "Had C-section before" // SS: confirm
replace m3_520 = "." if m3_520 == "High Risk" // SS: confirm
replace m3_520 = "." if m3_520 == "High risk" // SS: confirm
replace m3_520 = "." if m3_520 == "It was a weekend and emergency" // SS: confirm
replace m3_520 = "." if m3_520 == "Nearest clinic was not yet open" // SS: confirm
replace m3_520 = "." if m3_520 == "24.4" // SS: confirm
replace m3_520 = "11:00" if m3_520 == "11h00" // SS: confirm
replace m3_520 = "00:00" if m3_520 == "00:00:00" // SS: confirm
encode m3_520, gen(recm3_520) // N =4 missing data 
drop m3_520
format recm3_520 %tcHH:MM

recode m3_521 (. 9998 9999998= .a) if m3_501 !=1 //SS: why are there decimal numbers in this var?, who are the N=7 missing data?

recode m3_601a m3_601b m3_601c m3_602a (. 9999998 = .a) if m3_501 !=1 //N= 3 missing data

recode m3_602b (. 9999998 = .a) if m3_602a == 1 | m3_602a == .a | m3_602a == . | ///
								   m3_602a == .d | m3_602a == .r | m3_602a == 9999998
 
recode m3_603a m3_603b m3_603c m3_604a m3_604b m3_605a (. 9999998 = .a) if m3_501 !=1
 
recode m3_605b m3_605c (. 9999998 = .a) if m3_605a == 0 | m3_605a == . | m3_605a == .a
 
replace m3_605c_other = ".a" if m3_605c !=96

recode m3_606 m3_607 (. 9999998 = .a) if  m3_605a == 1 | m3_605a == .a | m3_605a == .d | m3_605a == .r

recode m3_608 (. 9999998 = .a) if m3_501 !=1 

* SS: double check: ASK: WOMEN WHO DELIVERED IN A HEALTH FACILITY & BABY WAS BORN ALIVE
recode m3_609 m3_610a m3_611 m3_613 (. 9999998 = .a) if m3_501 !=1 | (m3_303b ==0 & m3_303c ==0 & m3_303d ==0) // N=4 missing
 
recode m3_610b (. 9999998 = .a) if m3_610a !=1 

recode m3_612_za (. 9998 99998 999998 9999998 = .a) if m3_501 !=1 | (m3_303b ==0 & m3_303c ==0 & m3_303d==0)

recode m3_612_za (96 = .a) // confirm with Catherine because 96 == "I never breastfed"
 
recode m3_614 (. 998 9998 99998 9999998 = .a) if m3_613 == 0 | m3_613 == .a // confirm that 98 = .d
 
recode m3_615a (. 9999998 = .a) if m3_501 !=1 | m3_303b ==0  

recode m3_616a (. 9999998 = .a) if m3_615a == .a | m3_615a == .d | m3_615a == .r | m3_615a == 0 
 
recode m3_615b (. 9999998 = .a) if m3_501 !=1 | m3_303b ==0 | m3_303a !=2 

recode m3_616b (. 998 9998 9999998 = .a) if m3_615b == .a | m3_615a == .d | m3_615a == .r | m3_615a == 0 | m3_303a !=2

recode m3_615c (. 9999998 = .a) if m3_501 !=1 | m3_303d ==0 | m3_303a !=3

recode m3_616c (. 998 9998 9999998 = .a) if m3_615c == .a | m3_615a == .d | m3_615a == .r | m3_615a == 0 | m3_303a !=3

recode m3_617a (. 9999998 = .a) if m3_501 !=1 | m3_303b ==0  

recode m3_617b (. 9999998 = .a) if m3_501 !=1 | m3_303b ==0 | m3_303a !=2 

recode m3_617c (. 9999998 = .a) if m3_501 !=1 | m3_303d ==0 | m3_303a !=3

recode m3_618a_1 (. 9999998 = .a) if m2_hiv_status !=1 | m3_303a !=1 | m3_617b ==.a // SS:confirm

recode m3_618a_2 (. 9999998 = .a) if m2_hiv_status !=1 | m3_303a !=2 

recode m3_618a_3 (. 9999998 = .a) if m2_hiv_status !=1 | m3_303a !=3

recode m3_618b_1 (. 9999998 = .a) if m3_618a_1 !=1

recode m3_618b_2 (. 9999998 = .a) if m3_618a_2 !=1

recode m3_618b_3 (. 9999998 = .a) if m3_618a_3 !=1

recode m3_618c_1 (. 9999998 = .a) if m3_618b_1 !=1

recode m3_618c_2 (. 9999998 = .a) if m3_618b_2 !=1

recode m3_618c_3 (. 9999998 = .a) if m3_618b_3 !=1

recode m3_619a m3_619b m3_619c m3_619d m3_619e m3_619g m3_619h m3_620_1 m3_620_2 m3_620_3 (. 9999998 = .a) if m3_501 !=1 | (m3_303b ==0 & m3_303c ==0 & m3_303d ==0) 

recode m3_620_1 (. 9999998 = .a) if m3_501 !=1 | m3_303b ==0 | m3_303b ==.a // N= 5 missing data

recode m3_620_2 (. 9999998 = .a) if m3_501 !=1 | m3_303c ==0 | m3_303c ==.a

recode m3_620_3 (. 9999998 = .a) if m3_501 !=1 | m3_303d ==0 | m3_303d ==.a

recode m3_621a m3_621b (. 9999998 = .a) if m3_501 !=1

recode m3_621c (. 9999998 999998 = .a) if m3_621b !=1

recode m3_622a m3_622c m3_701 (. 9999998 = .a) if m3_501 !=1

recode m3_622b (. 9999998 = .a) if m3_622a !=1

replace m3_702 = ".a" if m3_701 !=1

recode m3_703 (. 9999998 = .a) if m3_701 !=1

recode m3_704a m3_704b m3_704c m3_704d m3_704e m3_704f m3_704g m3_705 m3_706 (. 9999998 = .a) if m3_501 !=1 // N=4-5 missing data

recode m3_707 (. 9999998 = .a) if m3_501 !=1 | m3_705 !=.a

recode m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f m3_baby1_issues_95 m3_baby1_issues_98 m3_baby1_issues_99 (0 = .a) if m2_202 !=2 | m2_202 !=3

recode m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f m3_baby2_issues_95 m3_baby2_issues_98 m3_baby2_issues_99 (0 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=2 

recode m3_baby3_issues_a m3_baby3_issues_b m3_baby3_issues_c m3_baby3_issues_d m3_baby3_issues_e m3_baby3_issues_f m3_baby3_issues_95 m3_baby3_issues_98 m3_baby3_issues_99 (0 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=3 

recode m3_baby1_issue_oth (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3
replace m3_baby1_issue_oth_text = ".a" if m3_baby1_issue_oth !=1
  
recode m3_baby2_issue_oth (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=2
recode m3_baby2_issue_oth_text (. 9999998 = .a) if m3_baby2_issue_oth !=1  

recode m3_baby3_issue_oth (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_303a !=3
recode m3_baby3_issue_oth_text (. 9999998 = .a) if m3_baby3_issue_oth !=1  

recode m3_baby1_710 (. 9999998 = .a) if m3_501 !=1 | m3_303b !=1 // N=7 missing data 
recode m3_baby2_710 (. 9999998 = .a) if m3_501 !=1 | m3_303c !=1 // N=1 missing data
recode m3_baby3_710 (. 9999998 = .a) if m3_501 !=1 | m3_303d !=1

recode m3_711a (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_501 !=1 | m3_303b !=1 
recode m3_711a_dys (. 9998 99998 999998 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_501 !=1 | m3_303b !=1 

recode m3_711b (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_501 !=1 | m3_303b !=1 | m3_303a !=2
recode m3_711b_dys (. 999998 9999998 9999998 99999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_501 !=1 | m3_303b !=1 | m3_303a !=2

recode m3_711c (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_501 !=1 | m3_303b !=1 | m3_303a !=3
recode m3_711c_dys (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 | m3_501 !=1 | m3_303b !=1 | m3_303a !=3
  
recode m3_801a (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3
recode m3_801b (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3 

egen m3_phq2_score = rowtotal(m3_801a m3_801b)
recode m3_phq2_score (0 = .a) if (m3_801a == . | m3_801a == .a | m3_801a == .d | m3_801a == .r) & ///
								 (m3_801b == . | m3_801b == .a | m3_801b == .d | m3_801b == .r)

recode m3_802a (. 9999998 = .a) if m3_phq2_score <3 | m3_phq2_score ==.a
  
recode m3_802b (. 9999998 = .a) if m3_802a !=1

recode m3_802c (. 9999998 99999998 = .a) if m3_802a !=1

recode m3_803a m3_803b m3_803c m3_803d m3_803e m3_803f m3_803g m3_803h m3_803j (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3
 
replace m3_803j_other = ".a" if m3_803j !=1

recode m3_805 (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3

recode m3_806 m3_807 m3_808a (. 9999998 = .a) if m3_805 !=1

recode m3_808b (. 9999998 = .a) if m3_808a !=0

replace m3_808b_other = ".a" if m3_808b !=96
 
recode m3_809 (. 9999998 = .a) if m3_808a !=1

recode m3_901a m3_901b m3_901c m3_901d m3_901e m3_901f m3_901g m3_901h m3_901i m3_901j m3_901k m3_901l m3_901m m3_901n m3_901o m3_901p m3_901q m3_901r (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3

replace m3_901r_other = ".a" if m3_901r !=1

recode m3_902a_baby1 m3_902b_baby1 m3_902c_baby1 m3_902d_baby1 m3_902e_baby1 m3_902f_baby1 m3_902g_baby1 m3_902h_baby1 m3_902i_baby1 m3_902j_baby1 (. 9999998 = .a) if m3_303b !=1 | m2_202 !=2 | m2_202 !=3 // need to do this for baby 2-3
   
replace m3_902j_baby1_other = ".a" if m3_902j_baby1 !=1
 
recode m3_1001 m3_1002 m3_1003 m3_1004a m3_1004b m3_1004c m3_1004d m3_1004e m3_1004f m3_1004g m3_1004h m3_1005a m3_1005b m3_1005c m3_1005d m3_1005e m3_1005f m3_1005g m3_1005h m3_1006a (. 9999998 = .a) if m3_501 !=1 | m2_202 !=2 | m2_202 !=3

recode m3_1006b m3_1006c (. 9999998 = .a) if m3_1006a !=1 // N=1 missing data

recode m3_1007a m3_1007b m3_1007c m3_1101 (. 9999998 = .a) if m3_501 !=1 | m2_202 !=2 | m2_202 !=3

recode m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt (. 9999998 = .a) if m3_1101 !=1 | m2_202 !=2 | m2_202 !=3 // SS: this line made me realize most 99998 responses are if the women as not given birth yet, double check above

replace m3_1102f_oth = ".a" if m3_1102a_amt ==.a & m3_1102b_amt ==.a & m3_1102c_amt ==.a & m3_1102d_amt ==.a & ///
							   m3_1102e_amt ==.a & m3_1102f_amt ==.a // SS: confirm, also should this var have text?

recode m3_1102_total (. 9999998 = .a) if m3_1101 !=1 | ((m3_1102a_amt ==.a | m3_1102a_amt ==0) & ///
														(m3_1102b_amt ==.a | m3_1102b_amt ==0) & ///
														(m3_1102c_amt ==.a | m3_1102c_amt ==0) & ///
														(m3_1102d_amt ==.a | m3_1102d_amt ==0) & ///
														(m3_1102e_amt ==.a | m3_1102e_amt ==0) & ///
														(m3_1102f_amt ==.a | m3_1102f_amt ==0)) // N=1 missing 			   
 
recode m3_1103 (. 9999998 = .a) if m3_1102_total == .a | m3_1102_total == . // N=1 missing

recode m3_1105a m3_1105b m3_1105c m3_1105d m3_1105e m3_1105f m3_1105_96 (0 = .a) if m3_1103 ==.a

replace m3_1105_other = ".a" if m3_1105_96 !=1 | m3_1102_total == .
 
recode m3_1106 (. 9999998 = .a) if m2_202 !=2 | m2_202 !=3

recode m3_1201 (. 9999998 = .a) if m3_baby1_deathga !=1 | m3_baby2_deathga !=1 | m3_baby3_deathga !=1
 
recode m3_1202 (. 9999998 = .a) if m3_1201 !=1

recode m3_1203 m3_1204 m3_1205 (. 9999998 = .a) if m3_death_cause_baby1 !=7  | m3_death_cause_baby2 !=7 | m3_death_cause_baby3 !=7 

recode m3_1205_other (. 9999998 = .a) if m3_1205 !=6  // numeric because of 0 obs

replace m3_1206 = ".a" if m3_1205 == .a & m3_1205_other == .a

ren rec* *

drop m2_interviewer m2_ga m2_hiv_status m2_maternal_death_reported m2_date_of_maternal_death m2_maternal_death_learn m2_maternal_death_learn_other m2_201 m2_202 MOD3_MAN_Complications_708_B3

*==============================================================================*
	
	* STEP FOUR: LABELING VARIABLES 
lab var m3_permission "Permission granted to conduct call"
lab var m3_date "Date of interview"
lab var m3_time "Time of interview (00:00)"
lab var respondentid "Respondent ID"
lab var m3_303a "301. How many babies were you pregnant with?"
lab var m3_birth_or_ended "302. On what date did you give birth/did the pregnancy end?"

lab var m3_303b "303. Is the 1st baby alive?"
lab var m3_303c "303. Is the 2nd baby alive?"
lab var m3_303d "303. Is the 3rd baby alive?"

lab var m3_baby1_gender "305. What is the first baby's gender?"
lab var m3_baby2_gender "305. what is the second baby's gender?"
lab var m3_baby3_gender "305. what is the third baby's gender?"

lab var m3_baby1_age_weeks "306. How old is the 1st baby in weeks?" 

lab var m3_baby1_size "307. When the first baby was born, were they: very large, larger than average, average, smaller than average or very small?"
lab var m3_baby2_size "307. When the second baby was born, were they: very large, larger than average, average, smaller than average or very small?"
lab var m3_baby3_size "307. When the third baby was born, were they: very large, larger than average, average, smaller than average or very small?"

lab var m3_baby1_weight "308. How much did the first baby weigh at birth?"
lab var m3_baby2_weight "308. How much did the second baby weigh at birth?"
lab var m3_baby3_weight "308. How much did the third baby weigh at birth?"

lab var m3_baby1_health "309. In general, how would you rate the first baby's overall health?"
lab var m3_baby2_health "309. In general, how would you rate the second baby's overall health?"
lab var m3_baby3_health "309. In general, how would you rate the third baby's overall health?"

lab var m3_baby1_feed_a "310a. Please indicate how you have fed the first baby in the last 7 days? Breast milk"
lab var m3_baby1_feed_b "310a. Please indicate how you have fed the first baby in the last 7 days? Formula"
lab var m3_baby1_feed_c "310a. Please indicate how you have fed the first baby in the last 7 days? Water"
lab var m3_baby1_feed_d "310a. Please indicate how you have fed the first baby in the last 7 days? Juice"
lab var m3_baby1_feed_e "310a. Please indicate how you have fed the first baby in the last 7 days? Broth"
lab var m3_baby1_feed_f "310a. Please indicate how you have fed the first baby in the last 7 days? Baby food"
lab var m3_baby1_feed_g "310a. Please indicate how you have fed the first baby in the last 7 days? Local food"
lab var m3_baby1_feed_95 "310a. Please indicate how you have fed the first baby in the last 7 days? Not applicable"
lab var m3_baby1_feed_98 "310a. Please indicate how you have fed the first baby in the last 7 days? Don't Know"
lab var m3_baby1_feed_99 "310a. Please indicate how you have fed the first baby in the last 7 days? NR/RF"

lab var m3_baby2_feed_a "310a. Please indicate how you have fed the second baby in the last 7 days? Breast milk"
lab var m3_baby2_feed_b "310a. Please indicate how you have fed the second baby in the last 7 days? Formulak"
lab var m3_baby2_feed_c "310a. Please indicate how you have fed the second aby in the last 7 days? Water"
lab var m3_baby2_feed_d "310a. Please indicate how you have fed the second baby in the last 7 days? Juice"
lab var m3_baby2_feed_e "310a. Please indicate how you have fed the second baby in the last 7 days? Broth"
lab var m3_baby2_feed_f "310a. Please indicate how you have fed the second baby in the last 7 days? Baby food"
lab var m3_baby2_feed_g "310a. Please indicate how you have fed the second baby in the last 7 days? Local food"
lab var m3_baby2_feed_95 "310a. Please indicate how you have fed the second baby in the last 7 days? Not applicable"
lab var m3_baby2_feed_98 "310a. Please indicate how you have fed the second baby in the last 7 days? Don't Know"
lab var m3_baby2_feed_99 "310a. Please indicate how you have fed the second baby in the last 7 days? NR/RF"

lab var m3_baby3_feed_a "310a. Please indicate how you have fed the third baby in the last 7 days? Breast milk"
lab var m3_baby3_feed_b "310a. Please indicate how you have fed the third baby in the last 7 days? Formulak"
lab var m3_baby3_feed_c "310a. Please indicate how you have fed the third aby in the last 7 days? Water"
lab var m3_baby3_feed_d "310a. Please indicate how you have fed the third baby in the last 7 days? Juice"
lab var m3_baby3_feed_e "310a. Please indicate how you have fed the third baby in the last 7 days? Broth"
lab var m3_baby3_feed_f "310a. Please indicate how you have fed the third baby in the last 7 days? Baby food"
lab var m3_baby3_feed_g "310a. Please indicate how you have fed the third baby in the last 7 days? Local food"
lab var m3_baby3_feed_95 "310a. Please indicate how you have fed the third baby in the last 7 days? Not applicable"
lab var m3_baby3_feed_98 "310a. Please indicate how you have fed the third baby in the last 7 days? Don't Know"
lab var m3_baby3_feed_99 "310a. Please indicate how you have fed the third baby in the last 7 days? NR/RF"

lab var m3_breastfeeding "310b. As of today, how confident do you feel about breastfeeding your baby/babies?"

lab var m3_baby1_sleep "311a. Regarding sleep, which response best describes the first baby today?"
lab var m3_baby2_sleep "311a. Regarding sleep, which response best describes the second baby today?"
lab var m3_baby3_sleep "311a. Regarding sleep, which response best describes the third baby today?"

lab var m3_baby1_feeding "311b. Regarding feeding, which response best describes the first baby today?"
lab var m3_baby2_feeding "311b. Regarding feeding, which response best describes the second baby today?"
lab var m3_baby3_feeding "311b. Regarding feeding, which response best describes the third baby today?"

lab var m3_baby1_breath "311c. Regarding breathing, which response best describes the first baby today?"
lab var m3_baby2_breath "311c. Regarding breathing, which response best describes the second baby today?"
lab var m3_baby3_breath "311c. Regarding breathing, which response best describes the third baby today?"

lab var m3_baby1_stool "311d. Regarding stooling/poo, which response best describes the first baby today?"
lab var m3_baby2_stool "311d. Regarding stooling/poo, which response best describes the second baby today?"
lab var m3_baby3_stool "311d. Regarding stooling/poo, which response best describes the third baby today?"

lab var m3_baby1_mood "311e. Regarding their mood, which response best describes the first baby today?"
lab var m3_baby2_mood "311e. Regarding their mood, which response best describes the second baby today?"
lab var m3_baby3_mood "311e. Regarding their mood, which response best describes the third baby today?"

lab var m3_baby1_skin "311f. Regarding their skin, which response best describes the first baby today?"
lab var m3_baby2_skin "311f. Regarding their skin, which response best describes the second baby today?"
lab var m3_baby3_skin "311f. Regarding their skin, which response best describes the third baby today?"

lab var m3_baby1_interactivity "311g. Regarding interactivity, which response best describes the first baby today?"
lab var m3_baby2_interactivity "311g. Regarding interactivity, which response best describes the second baby today?"
lab var m3_baby3_interactivity "311g. Regarding interactivity, which response best describes the third baby today?"	

lab var m3_baby1_deathga "312. Was this before or after 20 weeks (Baby 1)"
lab var m3_baby2_deathga "312. Was this before or after 20 weeks (Baby 2)"
lab var m3_baby3_deathga "312. Was this before or after 20 weeks (Baby 3)"

lab var m3_baby1_born_alive "312. Was the 1st baby born alive?"
lab var m3_baby2_born_alive "312. Was the 2nd baby born alive?"
lab var m3_baby3_born_alive "312. Was the 3rd baby born alive?"

lab var m3_313a_baby1 "313a. On what day did the 1st baby baby die?"
lab var m3_313a_baby2 "313a. On what day did the second baby baby die?"
lab var m3_313a_baby3 "313a. On what day did the third baby baby die?"

lab var m3_313e_baby1 "313e. After how many hours did the firt baby die? CONVERT DAYS into HOURS."
lab var m3_313e_baby2 "313e. After how many days or hours did the second baby die? CONVERT DAYS into HOURS."
lab var m3_313e_baby3 "313e. After how many days or hours did the third baby die? CONVERT DAYS into HOURS."

lab var m3_death_cause_baby1 "314. What were you told was the cause of death for the first baby, or were you not told?"
lab var m3_death_cause_baby1_other "314_Other-1. Specify the cause of death for the first baby"	
	
lab var m3_death_cause_baby2 "314. What were you told was the cause of death for the second baby, or were you not told?"
lab var m3_death_cause_baby2_other "314_Other-2. Specify the cause of death for the second baby"

lab var m3_death_cause_baby3 "314. What were you told was the cause of death for the third baby, or were you not told?"
lab var m3_death_cause_baby3_other "314_Other-3. Specify the cause of death for the third baby"

lab var m3_401 "401. Since you last spoke to us, did you have any new healthcare consultations for yourself before the delivery?"
lab var m3_402 "402. How many new healthcare consultations did you have?"

lab var m3_consultation_1 "403. Was the 1st consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_1 "404. Was the 1st for referral from your antenatal care provider?"
lab var m3_consultation1_reason "405. Was the 1st visit for any of the following?"
lab var m3_consultation1_reason_other "405-Other. Other reasons, please specify"

lab var m3_consultation_2 "406. Was the 2nd consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_2 "407. Was the 2nd for referral from your antenatal care provider?"
lab var m3_consultation2_reason "408. Was the 2nd visit for any of the following?"
lab var m3_consultation2_reason_other "408-Other. Other reasons, please specify"
		
lab var m3_consultation_3 "409. Was the 3rd consultation for a routine antenatal care visit?"
lab var m3_consultation_referral_3 "410. Was the 3rd for referral from your antenatal care provider?"
lab var m3_consultation3_reason "411. Was the 3rd visit for any of the following?"
lab var m3_consultation3_reason_other "411-Other. Other reasons, please specify"

lab var m3_412a "412a. Blood pressure measured (with a cuff around your arm)"
lab var m3_412b "412b. Your weight taken (using a scale)"
lab var m3_412c "412c. A blood draw (that is, taking blod from your arm with a syringe)"
lab var m3_412d "412d. A blood test using a finger pick (that is, taking a drop of blood from your finger)"
lab var m3_412e "412e. A urine test (that is, where you peed in a container)"
lab var m3_412f "412f. An ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)"
lab var m3_412g "412g. Any other test?"
lab var m3_412g_1_other "412g_other. Any other test, please specify"

lab var m3_501 "501. Did you deliver in a health facility?"
lab var m3_502 "502. What kind of facility was it?"
lab var m3_503 "503. What is the name of the facility where you delivered?"
lab var m3_503_outside_zone_other "504. Where was this facility located?"

lab var m3_505a "505a. Before you delivered, did you go to a maternity waiting home to wait for labor?"
lab var m3_505b "505b. How long did you stay at the maternity waiting home for? Convert days and weeks into days."
lab var m3_506a "506. What day and time did the labor start – that is, when contractions started and did not stop, or when your water broke? _Date"
lab var m3_506b "Time (24:00)"
lab var m3_507 "507. At what time did you leave for the facility?"
lab var m3_508 "508. At any point during labor or delivery did you try to go to a facility?"
lab var m3_509 "509. What was the main reason for giving birth at home instead of a health facility?"
lab var m3_509_other "509_Other. Specify other reasons for giving birth at home instead of a health facility"

lab var m3_510 "510. Did you go to another health facility before going to [facility name where she delivered from m3_503]?"
lab var m3_511 "511. How many facilities did you go to before going to [facility name where she delivered from m3_503]?"
lab var m3_512 "512. What kind of facility was it?"
lab var m3_513a "513a. What is the name of the facility you went to first?"
lab var m3_513b1 "513b. Where was this facility located? [Write city and region]"
lab var m3_514 "514. At what time did you arrive at the facility you went to 1st? [HH:MM]"
lab var m3_515 "515. Why did you go to [facility where she gave birth from m3_503] after going to [first facility visited m3_513a]?"

lab var m3_516 "516. Why did you or your family member decide to leave [first facility visited from m3_513a] and come to [facility where she gave birth from m3_503]?"
lab var m3_516_other "516_other. Other, specify"

lab var m3_517 "517. Did the provider inform you why they referred you?"
lab var m3_518 "518. Why did the provider refer you to the facility you delivered at?"
lab var m3_518_other_complications "518_96. Other delivery complications, specify"
lab var m3_518_other "518_Other. Other reasons, specify"

lab var m3_519 "519. What was the main reason you decided that you wanted to deliver at the facility you delivered at?"
lab var m3_520 "520. At what time did you arrive at the facility you delivered at? (HH:MM)"
lab var m3_521 "521. Once you got to the facility where you gave birth, how long did you wait until a healthcare worker checked on you? Convert hours into minutes"

lab var m3_601a "601a. Did the health care provider ask about your HIV status?"
lab var m3_601b "601b. Did the health care provider take your blood pressure (with a cuff around your arm)?"
lab var m3_601c "601c. ODid the health care provider explain what will happen during labor?"

lab var m3_602a "602a. Did the health care provider, look at your maternal child health card?"
lab var m3_602b "602b. Did the health care provider have information about your antenatal care (e.g. your tests results) from health facility records?"

lab var m3_603a "603a. Were you told you could walk around and move during labour?"
lab var m3_603b "603b. Were you allowed to have a birth companion present? For example, this includes your husband, a friend, sister, mother-in-law etc.?"
lab var m3_603c "603c. Did you have a needle inserted in your arm with a drip?"

lab var m3_604a "604a. While you were in labor and giving birth, what were you sitting or lying on?"
lab var m3_604b "604b. While you were giving birth, were curtains, partitions or other measures used to provide privacy from other people not involved in your care?"
lab var m3_605a "605a. Did you have a caesarean? (That means, did they cut your belly open to take the baby out?)"
lab var m3_605b "605b. When was the decision made to have the caesarean section? Was it before or after your labor pains started?"
lab var m3_605c "605c. What was the reason for having a caesarean?"
lab var m3_605c_other "605c-Other. Specify other reason for having a caesarean"

lab var m3_606 "606. Did the provider perform a cut near your vagina to help the baby come out?"
lab var m3_607 "607. Did you receive stiches near your vagina after the delivery?"		
lab var m3_608 "608. Immediately after delivery: Did a health care provider give you an injection or pill to stop the bleeding?"
lab var m3_609 "609. Immediately after delivery, did a health care provider dry the baby/babies with a towel?"
lab var m3_610a "610a. Immediately after delivery, was/were the baby/babies put on your chest?"
lab var m3_610b "610b. Immediately after delivery, was/were the babys/babies bare skin touching your bare skin?"
lab var m3_611 "611. Immediately after delivery, did a health care provider help you with breastfeeding the baby/babies?"
lab var m3_612_za "612. ZA only: How long after the baby/babies was born did you first breastfeed he/she/them? Convert days into hours."

lab var m3_613 "613. Did anyone check on your health while you were still in the facility?"
lab var m3_614 "614. How long after delivery did the first check take place? Convert days and weeks to hours."

lab var m3_615a "615. Did anyone check on the 1st baby's health while you were still in the facility?"
lab var m3_615b "615. Did anyone check on the 2nd baby's health while you were still in the facility?"
lab var m3_615c "615. Did anyone check on the 3rd baby's health while you were still in the facility?"

lab var m3_616a "616. How long after delivery was the first baby health first checked?"
lab var m3_616b "616. How long after delivery was the second baby health first checked?"
lab var m3_616c "616. How long after delivery was the third baby health first checked?"

lab var m3_617a "617. Did the first baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
lab var m3_617b "617. Did the second baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"
lab var m3_617c "617. Did the third baby receive a vaccine for BCG while you were still in the facility? That is an injection in the arm that can sometimes cause a scar"

lab var m3_618a_1 "618a Was the first baby tested for HIV after birth?" 
lab var m3_618a_2 "618a. Was the second baby tested for HIV after birth?"
lab var m3_618a_3 "618a. Was the third baby tested for HIV after birth?"

lab var m3_618b_1 "618b. What was the result of the first baby's HIV test?"
lab var m3_618b_2 "618b. What was the result of the second baby's HIV test?"
lab var m3_618b_3 "618b. What was the result of the third baby's HIV test?"

lab var m3_618c_1 "618c-1. Was the first baby given medication to prevent HIV/AIDS?"
lab var m3_618c_2 "618c-1. Was the second baby given medication to prevent HIV/AIDS?"
lab var m3_618c_3 "618c-1. Was the third baby given medication to prevent HIV/AIDS?"

lab var m3_619a "619a. Before you left the facility, did you receive advice on what the baby should eat (only breastmilk or other foods)?"
lab var m3_619b "619b. Before you left the facility, did you receive advice on care of the umbilical cord?"
lab var m3_619c "619c. Before you left the facility, did you receive advice on the need to avoid chilling of baby?"
lab var m3_619d "619d. Before you left the facility, did you receive advice on when to return for vaccinations for the baby?"
lab var m3_619e "619e. Before you left the facility, did you receive advice on hand washing with soap/water before touching the baby?"
lab var m3_619g "619g. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in the baby that would mean you should go to a health facility?"
lab var m3_619h "619h. Before you left the facility, did you receive advice on danger signs or symptoms you should watch out for in yourself that would mean you should go to a health facility?"

lab var m3_620_1 "620. During any point of your pregnancy or after birth, were you given a Road to Health card for the first baby to take home with you?"
lab var m3_620_2 "620. During any point of your pregnancy or after birth, were you given a Road to Health card for the second baby to take home with you?"
lab var m3_620_3 "620. During any point of your pregnancy or after birth, were you given a Road to Health card for the third baby to take home with you?"

lab var m3_621a "621a. Care for home births: Who assisted you in the delivery?"
lab var m3_621b "621b. Did someone come to check on you after you gave birth? For example, someone asking you questions about  your health or examining you?"
lab var m3_621c "621c. How long after giving birth did the checkup take place? Convert weeks and days into hours."

lab var m3_622a "622a. Around the time of delivery, were you told that you will need to go to a facility for a checkup for you or your baby?"
lab var m3_622b "622b. When were you told to go to a health facility for postnatal checkups? How many days after delivery?"
lab var m3_622c "622c. Around the time of delivery, were you told that someone would come to visit you at your home to check on you or your babys health?"

lab var m3_701 "701. At any time during labor, delivery, or after delivery did you suffer from any health problems?"
lab var m3_702 "702. What health problems did you have? Anything else? [Specify]"
lab var m3_703 "703. Would you say this problem was severe?"

lab var m3_704a "704a. During your delivery, did you experience seizures, or not?"
lab var m3_704b "704b. During your delivery, did you experience blurred vision, or not?"
lab var m3_704c "704c. During your delivery, did you experience severe headaches, or not?"
lab var m3_704d "704d. Did you experience swelling in hands/feet during your delivery, or not?"
lab var m3_704e "704e. Did you experience labor over 12 hours during your delivery, or not?"
lab var m3_704f "704f. Did you experience excessive bleeding during your delivery, or not?"
lab var m3_704g "704g. During your delivery, did you experience fever, or not?"
lab var m3_705 "705. Did you receive a blood transfusion around the time of your delivery?"
lab var m3_706 "706. Were you admitted to an intensive care unit?"
lab var m3_707 "707. How long did you stay at [facility name where she gave birth] after the delivery? [Hours]"

lab var m3_baby1_issues_a "708. Did the first baby experience trouble breathing in the 1st day of life?"
lab var m3_baby1_issues_b "708. Did the first baby experience fever, low temperature, or infection in the 1st day of life?"
lab var m3_baby1_issues_c "708. Did the first baby experience trouble feeding in the 1st day of life?"
lab var m3_baby1_issues_d "708. Did the baby the first baby experience jaundice in the 1st day of life?"
lab var m3_baby1_issues_e "708. Did the first baby experience low birth weight in the 1st day of life?"
lab var m3_baby1_issues_f "708. Did the first baby experience no complications in the 1st day of life?"
lab var m3_baby1_issues_95 "708. Did the first baby experience no complications in the 1st day of life? (choice = Not applicable)"
lab var m3_baby1_issues_98 "708. Did the first baby experience any of the following issues in the 1st day of life? (choice= Don't Know)"
lab var m3_baby1_issues_99 "708. Did the first baby experience any of the following issues in the 1st day of life? (choice=NR/RF)"

lab var m3_baby2_issues_a "708. Did the second baby experience trouble breathing in the 1st day of life?"
lab var m3_baby2_issues_b "708. Did the second baby experience fever, low temperature, or infection in the 1st day of life?"
lab var m3_baby2_issues_c "708. Did the second baby experience trouble feeding in the 1st day of life?"
lab var m3_baby2_issues_d "708. Did the second baby experience jaundice in the 1st day of life?"
lab var m3_baby2_issues_e "708. Did the second baby experience low birth weight in the 1st day of life?"
lab var m3_baby2_issues_f "708. Did the second baby experience no complications in the 1st day of life?"
lab var m3_baby2_issues_95 "708. Did the second baby experience any of the following issues in the 1st day of life? (choice = Not applicable)"
lab var m3_baby2_issues_98 "708. Did the second baby experience any of the following issues in the 1st day of life? (choice=DK)"
lab var m3_baby2_issues_99 "708. Did the second baby experience any of the following issues in the 1st day of life? (choice=NR/RF)"

lab var m3_baby3_issues_a "708. Did the first baby experience trouble breathing in the 1st day of life?"
lab var m3_baby3_issues_b "708. Did the first baby experience fever, low temperature, or infection in the 1st day of life?"
lab var m3_baby3_issues_c "708. Did the first baby experience trouble feeding in the 1st day of life?"
lab var m3_baby3_issues_d "708. Did the baby the first baby experience jaundice in the 1st day of life?"
lab var m3_baby3_issues_e "708. Did the first baby experience low birth weight in the 1st day of life?"
lab var m3_baby3_issues_f "708. Did the first baby experience no complications in the 1st day of life?"
lab var m3_baby3_issues_95 "708. Did the first baby experience no complications in the 1st day of life? (choice = Not applicable)"
lab var m3_baby3_issues_98 "708. Did the first baby experience any of the following issues in the 1st day of life? (choice= Don't Know)"
lab var m3_baby3_issues_99 "708. Did the first baby experience any of the following issues in the 1st day of life? (choice=NR/RF)"
		
lab var m3_baby1_issue_oth "709. Did the first baby experience any other health problems in the first day of life?"		
lab var m3_baby1_issue_oth_text "709_Other. If yes, specify"

lab var m3_baby2_issue_oth "709. Did the second baby experience any other health problems in the first day of life?"		
lab var m3_baby2_issue_oth_text "709_Other. If yes, specify"

lab var m3_baby3_issue_oth "709. Did the third baby experience any other health problems in the first day of life?"		
lab var m3_baby3_issue_oth_text "709_Other. If yes, specify"

lab var m3_baby1_710 "710. Did the first baby spend time in a special care nursery or intensive care unit before discharge?"
lab var m3_baby2_710 "710. Did the second baby spend time in a special care nursery or intensive care unit before discharge?"
lab var m3_baby3_710 "710. Did the third baby spend time in a special care nursery or intensive care unit before discharge?"
	
lab var m3_711a "711. How long did the first baby stay at the health facility after being born? [Hours]"
lab var m3_711a_dys "711. How long did the first baby stay at the health facility after being born? [Days]"
lab var m3_711b "711. How long did the second baby stay at the health facility after being born? [Hours]"
lab var m3_711b_dys "711. How long did the second baby stay at the health facility after being born? [Days]"
lab var m3_711c "711. How long did the third baby stay at the health facility after being born? [Hours]"
lab var m3_711c_dys	"711. How long did the third baby stay at the health facility after being born? [Days]"
	
lab var m3_801a "801a. Over the past 2 weeks, on how many days have you been bothered little interest or pleasure in doing things?"
lab var m3_801b "801b. Over the past 2 weeks, on how many days have you been bothered feeling down, depressed, or hopeless in doing things?"
lab var m3_phq2_score "PHQ-2 score"

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
lab var m3_803j "804. Since giving birth, have you experienced any other major health problems since you gave birth?"
lab var m3_803j_other "804_Other. Specify any other major health problems since you gave birth"
lab var m3_805 "805. Since you gave birth have you experienced a constant leakage of urine or stool from your vagina during the day and night?"
lab var m3_806 "806. How many days after giving birth did these symptoms start?"
lab var m3_807 "807. Overall, how much does this problem interfere with your everyday life? Please select a number between 0 (not at all) and 10 (a great deal)."
lab var m3_808a "808a. Have you sought treatment for this condition?"
lab var m3_808b "808b. Why have you not sought treatment?"
lab var m3_808b_other "808b_Other. Specify other reasons why have you not sought treatment"
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
lab var m3_901r_other "901r_Other. Specify other treatment you took"
lab var m3_902a_baby1 "902a. Since they were born, did the 1st baby get iron supplements?"
*lab var m3_902a_baby2 "902a. Since they were born, did the second baby get iron supplements?"
lab var m3_902b_baby1 "902b. Since they were born, did the 1st baby get Vitamin A supplements?"
*lab var m3_902b_baby2 "902b. Since they were born, did the second baby get Vitamin A supplements?"
lab var m3_902c_baby1 "902c. Since they were born, did the 1st baby get Vitamin D supplements?"
*lab var m3_902c_baby2 "902c. Since they were born, did the second baby get Vitamin D supplements?"
lab var m3_902d_baby1 "902d. Since they were born, did the 1st baby get Oral rehydration salts?"
*lab var m3_902d_baby2 "902d. Since they were born, did the second baby get Oral rehydration salts?"
lab var m3_902e_baby1 "902e. Since they were born, did the 1st baby get antidiarrheal?"
*lab var m3_902e_baby2 "902e. Since they were born, did the second baby get antidiarrheal?"
lab var m3_902f_baby1 "902f. Since they were born, did the 1st baby get antibiotics for an infection?"
*lab var m3_902f_baby2 "902f. Since they were born, did the second baby get Antibiotics for an infection?"
lab var m3_902g_baby1 "902g. Since they were born, did the 1st baby get medicine to prevent pneumonia?"
*lab var m3_902g_baby2 "902g. Since they were born, did the second baby get medicine to prevent pneumonia?"
lab var m3_902h_baby1 "902h. Since they were born, did the 1st baby get medicine for malaria [endemic areas]?"
*lab var m3_902h_baby2 "902h. Since they were born, did the second baby get medicine for malaria [endemic areas]?"
lab var m3_902i_baby1 "902i. Since they were born, did the 1st baby get medicine for HIV (HIV+ mothers only)?"
*lab var m3_902i_baby2 "902i. Since they were born, did the second baby get medicine for HIV (HIV+ mothers only)?"
lab var m3_902j_baby1 "902j. Since they were born, did the 1st baby get any other medicine or supplement, please specify"
lab var m3_902j_baby1_other "902j_Other. Any other medicine or supplement for the 1st baby please specify"
*lab var m3_902j_baby2 "902j. Since they were born, did the second baby get other medicine or supplement, please specify"
*lab var m3_902j_baby3_other "902j_Other. Any other medicine or supplement for the second baby please specify"		
lab var m3_1001 "1001. Overall, taking everything into account, how would you rate the quality of care that you received for your delivery at the facility you delivered at?"
lab var m3_1002 "1002. How likely are you to recommend this provider to a family member or friend for childbirth?"
lab var m3_1003 "1003. Did staff suggest or ask you (or your family or friends) for a bribe, and informal payment or gift?"
label variable m3_1004a "1004a. How would you rate the knowledge and skills of your provider?"
label variable m3_1004b "1004b. How would you rate the equipment and supplies that the provider had available such as medical equipment or access to lab tests?"
label variable m3_1004c "1004c. How would you rate the level of respect the provider showed you?"
label variable m3_1004d "1004d. How would you rate the clarity of the providers explanations?"
label variable m3_1004e "1004e. How would you rate the degree to which the provider involved you as much as you wanted to be in decisions about your care?"
label variable m3_1004f "1004f. How would you rate the amount of time the provider spent with you?"
label variable m3_1004g "1004g. How would you rate the amount of time you waited before being seen?"
label variable m3_1004h "1004h. How would you rate the courtesy and helpfulness of the healthcare facility staff, other than your provider?"
lab var m3_1005a "1005a. Were you pinched by a health worker or other staff?"
lab var m3_1005b "1005b. Were you slapped by a health worker or other staff?"
lab var m3_1005c "1005c. Were you physically tied to the bed or held down to the bed forcefully by a health worker or other staff?"
lab var m3_1005d "1005d. Did you have forceful downward pressure placed on your abdomen before the baby came out?"
lab var m3_1005e "1005e. Were you shouted or screamed at by a health worker or other staff?"
lab var m3_1005f "1005f. Were you scolded by a health worker or other staff?"
lab var m3_1005g "1005g. Did the health worker or other staff member make negative comments to you regarding your sexual activity?"
lab var m3_1005h "1005h. Did the health worker or other staff threaten that if you did not comply, you or your baby would have a poor outcome?"
lab var m3_1006a "1006a. Did you receive a vaginal examination at any point in the health facility?"
lab var m3_1006b "1006b. Did the health care provider ask permission before performing the vaginal examination?"
lab var m3_1006c "1006c. Were vaginal examinations conducted privately (in a way that other people could not see)?"
lab var m3_1007a "1007a. Were you offered any form of pain relief?"
lab var m3_1007b "1007b. Did you request pain relief during your time in the facility?"
lab var m3_1007c "1007c. Did you receive pain relief during your time in the facility?"
lab var m3_1101 "1101. Did you pay money out of your pocket for the delivery, including for the consultation or other indirect costs like your transport to the facility?"
lab var m3_1102a_amt "1102a. How much money did you spend on registration/consultation?"
lab var m3_1102b_amt "1102b. How much money did you spend on medicine/vaccines (including outside purchase)?"
lab var m3_1102c_amt "1102c. How much money did you spend test/investigations (x-ray, lab etc.)?"
lab var m3_1102d_amt "1102d. How much money did you spend on transport (round trip) including that of the person accompanying you?"
lab var m3_1102e_amt "1102e. How much money did you spend money on food and accommodation including that of  the person accompanying you?"
lab var m3_1102f_amt "1102f. How much money did you spend on other items?"
lab var m3_1102f_oth "1102f_Other. Specify item"
lab var m3_1102_total "1102. Total amount spent"
lab var m3_1103 "1103. So in total you spent:_____ Is that correct?"

lab var m3_1105a "1104. Did you use the current income of any household members to pay for this?"
lab var m3_1105b "1104. Did you use savings (e.g. bank account) to pay for this?"
lab var m3_1105c "1104. Did you use payment or reimbursement from a health insurance plan (medical aid) to pay for this?"
lab var m3_1105d "1104. Did you sell items (e.g. furniture, animals, jewellery, furniture)?"
lab var m3_1105e "1104. Did you use money from family members or friends from outside the household?"
lab var m3_1105f "1104. Did you borrow (from someone other than a friend or family)?"
lab var m3_1105_96 "1104. Did you use other financial sources?" 

lab var m3_1105_other "1104_Other. Other specify"
lab var m3_1106 "1106. Please tell me how satisfied you are with the health services you received during labor and delivery?" 
lab var m3_1201 "1201. When the misrriage occurred, did you go to a health facility for follow-up?"
lab var m3_1202 "1202. Overall, how would you rate the quality of care that you received for your miscarriage?"
lab var m3_1203 "1203. Did you go to a health facility to receive this abortion?"
lab var m3_1204 "1204. Overall, how would you rate the quality of care that you received for your abortion?" 
lab var m3_1205 "1205. Where did this take place?"
lab var m3_1205_other "1205_other. Other, specify"
lab var m3_1206 "1206. What is the name of the facility?"

*------------------------------------------------------------------------------*
*save M3 only dataset

save "$za_data_final/eco_m3_za.dta", replace

*------------------------------------------------------------------------------*

* merge dataset with M1-M2

*dropping duplicates (remove later after they are addressed)

drop if respondentid == "MBA_002" | respondentid == "NEL_022" | respondentid == "NEL_043" | ///
		respondentid == "NWE_044" | respondentid == "PAP_001" | respondentid == "PAP_037" | ///
		respondentid == "RCH_022" | respondentid == "RCH_084" | respondentid == "TOK_014" | ///
		respondentid == "TOK_021" | respondentid == "TOK_082"

merge 1:1 respondentid using "$za_data_final/eco_m1m2_za.dta", force

drop _merge

*==============================================================================*
	
	* STEP FIVE: ORDER VARIABLES
	
order m1_* m2_* m3_*, sequential

order pre_screening_num_za Eligible permission country respondentid interviewer_id m1_date m1_start_time study_site ///
      care_self enrollage enrollage_cat zone_live b5anc b6anc_first b7eligible mobile_phone flash study_site_sd facility
	  
order height_cm weight_kg bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate ///
	  bp_time_2_systolic bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic ///
	  bp_time_3_diastolic time_3_pulse_rate, after(m1_1223)
	  
order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

* Module 2:
order m2_permission* m2_date* m2_time_start* m2_interviewer* m2_maternal_death_reported* m2_date_of_maternal_death* ///
	  m2_ga* m2_hiv_status* m2_maternal_death_learn* ///
	  m2_maternal_death_learn_other*, after(m1_1401)

* Module 3:
order m3_permission m3_date m3_time m3_birth_or_ended, before(m3_303a)
order m3_baby1_gender m3_baby2_gender m3_baby3_gender, after(m3_303c)
order m3_baby1_age_weeks m3_baby1_weight m3_baby2_weight m3_baby3_weight, after(m3_baby3_gender)
order m3_baby1_size m3_baby2_size m3_baby2_size m3_baby3_size, after(m3_baby3_weight)
order m3_baby1_health m3_baby2_health m3_baby3_health, after(m3_baby3_size)
order m3_baby1_feeding m3_baby1_feed_a m3_baby1_feed_b m3_baby1_feed_c m3_baby1_feed_d m3_baby1_feed_e m3_baby1_feed_f   m3_baby1_feed_g m3_baby1_feed_95 m3_baby1_feed_98 m3_baby1_feed_99, after(m3_baby3_health) 
order m3_baby2_feeding m3_baby2_feed_a m3_baby2_feed_b m3_baby2_feed_c m3_baby2_feed_d m3_baby2_feed_e m3_baby2_feed_f  m3_baby2_feed_g m3_baby2_feed_95 m3_baby2_feed_98 m3_baby2_feed_99, after(m3_baby1_feed_99)
order m3_baby3_feeding m3_baby3_feed_a m3_baby3_feed_b m3_baby3_feed_c m3_baby3_feed_d m3_baby3_feed_e m3_baby3_feed_f  m3_baby3_feed_g m3_baby3_feed_95 m3_baby3_feed_98 m3_baby3_feed_99, after(m3_baby2_feed_99)
order m3_breastfeeding,after(m3_baby3_feed_99)
order m3_baby1_deathga m3_baby2_deathga m3_baby3_deathga, after(m3_breastfeeding)
order m3_baby1_born_alive m3_baby2_born_alive m3_baby3_born_alive, after(m3_breastfeeding)
order m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 m3_1201 m3_1202, after(m3_313e_baby3)
order m3_consultation_1 m3_consultation_referral_1 m3_consultation1_reason m3_consultation1_reason_other, after(m3_402) 
order m3_consultation_2 m3_consultation_referral_2 m3_consultation2_reason m3_consultation2_reason_other,after(m3_consultation1_reason_other) 
order m3_consultation_3 m3_consultation_referral_3 m3_consultation3_reason m3_consultation3_reason_other,after(m3_consultation2_reason_other) 

order m3_baby1_sleep m3_baby2_sleep m3_baby3_sleep, after(m3_622c) 
order m3_baby1_feeding m3_baby2_feeding m3_baby3_feeding, after(m3_baby3_sleep)
order m3_baby1_breath m3_baby2_breath m3_baby3_breath, after(m3_baby3_feeding)
order m3_baby1_stool m3_baby2_stool m3_baby3_stool,after(m3_baby3_breath)
order m3_baby1_mood m3_baby2_mood m3_baby3_mood, after(m3_baby3_stool)
order m3_baby1_skin m3_baby2_skin m3_baby3_skin, after(m3_baby3_mood)
order m3_baby1_interactivity m3_baby2_interactivity m3_baby3_interactivity, after(m3_baby3_skin)

order m3_baby1_issues_a m3_baby1_issues_b m3_baby1_issues_c m3_baby1_issues_d m3_baby1_issues_e m3_baby1_issues_f m3_baby1_issues_95 m3_baby1_issues_98 m3_baby1_issues_99 m3_baby1_issue_oth m3_baby1_issue_oth_text, after(m3_707)

order m3_baby2_issues_a m3_baby2_issues_b m3_baby2_issues_c m3_baby2_issues_d m3_baby2_issues_e m3_baby2_issues_f m3_baby2_issues_95 m3_baby2_issues_98 m3_baby2_issues_99 m3_baby2_issue_oth m3_baby2_issue_oth_text, after(m3_baby1_issue_oth_text)

order m3_baby3_issues_a m3_baby3_issues_b m3_baby3_issues_c m3_baby3_issues_d m3_baby3_issues_e m3_baby3_issues_f m3_baby3_issues_95 m3_baby3_issues_98 m3_baby3_issues_99 m3_baby3_issue_oth m3_baby3_issue_oth_text, after(m3_baby2_issues_99)

order m3_baby1_710 m3_baby2_710 m3_baby3_710, after(m3_baby3_issue_oth_text)

order m3_phq2_score, after(m3_801b)                 

order m3_death_cause_baby1 m3_death_cause_baby1_other m3_death_cause_baby2 m3_death_cause_baby2_other m3_death_cause_baby3 m3_death_cause_baby3_other,after(m3_313e_baby3)

*==============================================================================*
	
	* STEP SIX: SAVE DATA TO RECODED FOLDER
	
	save "$za_data_final/eco_m1-m3_za.dta", replace

*==============================================================================*
* MODULE 4:		

