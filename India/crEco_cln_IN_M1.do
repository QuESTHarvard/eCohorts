* India MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Last Updated: 2024-08-08
*------------------------------------------------------------------------------*
/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-08-08		1.01	MK Trimner		Corrected respondent id "202310031133022010 to remove the " i the first char so it will merge with M2
* 2024-10-30	1.02	MK Trimner		Added chars with module
* 2024-11-13	1.03	MK Trimner		Corrected Char Original_Varname to be 
* 										Original_IN_Varname											
*******************************************************************************/

* Import Data 
clear all 
u "$in_data/Module1_07_06_2024.dta", clear
*------------------------------------------------------------------------------*
* Dataset was originally sent in upper cap
foreach var of varlist _all  {
  rename `var' `=strupper("`var'")'
  
}

foreach v of varlist * {
	local name `v'
	*local s1 = strpos("`v'","Q")
	*if `s1' == 1 local name = substr("`v'",2,.)
	char `v'[Original_IN_Varname] `name'
}



/* Dropping duplicate IDs (data collection problems identified in March 2024)
drop if Q103=="202311171131039696" | Q103=="202312151215032417" | Q103=="202312201759032417" | Q103=="202312201818032417" | Q103=="202401171049032417" | Q103=="202401311139032417" | Q103=="202402051039032417" | Q103=="202402051053032417" | Q103=="202402051720032417" | Q103=="202402061130032417" | Q103=="202402061524032417" | Q103=="202402071437032417"
* Additional data collection errors (May 2024)
drop if Q103=="202311171214039696" | Q103=="202311181057030996" | Q103=="202311181034030996" | Q103=="202311191400030996" | Q103=="202312131845039696" | Q103=="202311201524039696" ///
 | Q103=="202311201424039696" | | Q103=="202311212018039696" | Q103=="202312151316032417" | Q103=="202312201604032417" | Q103=="202401171411031017" |  Q103=="202401301408031017" | Q103=="202402012204032417"  ///
| Q103=="202401311531032417" | Q103=="202401311420032417" | Q103=="202402041307032417" | Q103=="202402042214032417" | Q103=="202402021142032417" | Q103=="202402051740032417" | ///
Q103=="202402051137032417" | Q103=="202402051749032417" | Q103=="202402051148032417" | Q103=="202402061028032417" | Q103=="202402061341032417" | Q103=="202402061405032417" | Q103=="202402061257032417" ///
| Q103=="202402061443032417" | Q103=="202402061109032417" | Q103=="202402071322032417" | Q103=="202402071303032417" | Q103=="202402071224032417"*/
 

gen country = "India"
*===============================================================================
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line __)
		* STEP TW0: ADD VALUE LABELS (starts at: line ___)
		* STEP THREE: RECODING MISSING VALUES (starts at: line ___)
		* STEP FOUR: LABELING VARIABLES (starts at: line ___)
		* STEP FIVE: ORDER VARIABLES (starts at: line __)
		* STEP SIX: SAVE DATA
*===============================================================================

	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
	
rename (A2 A3 A4 A5 A5_OTHER) (date_m1 m1_start_time study_site facility facility_other)

rename (B1 B2 B3 B5 B6) (permission care_self enrollage b5anc b6anc_first)
		
rename (B7 Q103 Q104 Q106) (b7eligible respondentid mobile_phone flash)

rename (Q201 Q202_A Q202_B Q202_C Q202_D Q202_E) (m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e)

rename (Q203 Q204) (m1_203 m1_204)

rename (Q205A Q205B Q205C Q205D Q205E Q206_A Q206_B Q206_C Q206_D Q206_E Q206_F Q206_G Q206_H ///
		Q206_I Q207 Q301 Q302 Q303 Q304 Q305_A Q305_B Q401 Q401_OTHER) (m1_205a m1_205b m1_205c ///
		m1_205d m1_205e phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i m1_207 m1_301 ///
		m1_302 m1_303 m1_304 m1_305a m1_305b m1_401 m1_401_other)
		
rename (Q_402 Q402_A Q402_B) (m1_402 m1_402a_in m1_402b_in)

rename (Q403 Q404 Q405 Q405_OTHER Q501 Q501_OTHER) (m1_403b m1_404 m1_405 m1_405_other ///
		m1_501 m1_501_other)

rename (Q502 Q503 Q504 Q504_A Q505 Q506 Q506_OTHER Q507 Q507_OTHER Q508 Q509A Q509B Q510A ///
		Q510B Q511 Q512) (m1_502 m1_503 m1_504 m1_504a_in m1_505 m1_506 m1_506_other ///
		m1_507 m1_507_other m1_508 m1_509a m1_509b m1_510a m1_510b m1_511 m1_512)

rename (C6 C7 Q601 Q602 Q603 Q604_1 Q604_2) (m1_c6_in m1_c7_in m1_601 m1_602 m1_603 ///
		m1_604a_in m1_604b_in)

rename (Q605_A Q605_B Q605_C Q605_D Q605_E Q605_F Q605_G Q605_H) (m1_605a m1_605b m1_605c m1_605d ///
		m1_605e m1_605f m1_605g m1_605h)

rename (Q700 Q701 Q702 Q703 Q704 Q705 Q706 Q707 Q708A Q708B Q708C Q708D Q708E Q708F) (m1_700 ///
		m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e ///
		m1_708f)

rename (Q709A Q709B) (m1_709a m1_709b)		
		
rename (Q710A Q710B Q710C Q711A Q711B Q712) (m1_710a m1_710b m1_710c m1_711a m1_711b m1_712)
		
rename (Q701_A Q701_B Q701_C Q701_E Q701_F Q701_G Q701_I Q701_D Q701_J Q701_K) (m1_713a ///
		m1_713_in_za m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i)		
		
rename (Q701_H Q701_L Q714A Q714B Q714C Q714D Q714E Q715 Q716_A Q716_B Q716_C Q716_D Q716_E ///
		Q717 Q718 Q719 Q720 Q721 Q722 Q723 Q724A Q724B Q724C Q724D Q724E Q724F Q724G Q724H ///
		Q724I Q801) (m1_713k m1_713l m1_714a m1_714b m1_714c m1_714d m1_714e m1_715 m1_716a ///
		m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 ///
		m1_724a m1_724b m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801)

rename (Q802 Q803_1 Q803_2 Q805 Q806 Q807 Q808 Q808_OTHER Q809 Q810A Q810B Q812A ///
		Q812B Q812B_OTHER Q813A Q813B) (m1_802a m1_803a_in m1_803b_in m1_805 m1_806 ///
		m1_807 m1_808 m1_808_other m1_809 m1_810a m1_810b m1_812a m1_812b m1_812b_other m1_813a m1_813b)

rename (Q814_A Q814_B Q814_C Q814_D Q814_E Q814_F Q814_G Q814_H) (m1_814a m1_814b m1_814c m1_814d ///
		m1_814e m1_814f m1_814g m1_814h)		
		
rename (Q815_A Q815_A_OTHER Q815_B Q815_B_OTHER Q815_C Q815_C_OTHER Q815_D Q815_D_OTHER ///
		Q815_E Q815_E_OTHER Q815_F Q815_F_OTHER Q815_G Q815_G_OTHER Q815_H Q815_H_OTHER ///
		Q816 Q901 Q902) (m1_815a_in m1_815a_other_in m1_815b_in m1_815b_other_in m1_815c_in ///
		m1_815c_other_in m1_815d_in m1_815d_other_in m1_815e_in m1_815e_other_in m1_815f_in ///
		m1_815f_other_in m1_815g_in m1_815g_other_in m1_815h_in m1_815h_other_in m1_816 m1_901 m1_902)	
		
rename (Q905 Q906 Q907 Q1001 Q1002 Q1003 Q1004 Q1005 Q1006 Q1007 Q1008 Q1009 Q1010 Q1011_A Q1011_B ///
		Q1011_C Q1011_D Q1011_E Q1011_F Q1101 Q1102 Q1102_OTHER Q1103 Q1104) (m1_905 m1_906 m1_907 ///
		m1_1001 m1_1002 m1_1003 m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 m1_1009 m1_1010 m1_1011a ///
		m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1102 m1_1102_other m1_1103 m1_1104)		
		
rename (Q1104_OTHER Q1105 Q1201 Q1201_OTHER Q1202 Q1202_OTHER Q1203 Q1204 Q1205 Q1206 Q1207 ///
		Q1208 Q1208_OTHER Q1209 Q1209_OTHER Q1210 Q1210_OTHER Q1211 Q1211_OTHER Q1212 Q1213 ///
		Q1214 Q1215 Q1216 Q1217) (m1_1104_other m1_1105 m1_1201 m1_1201_other m1_1202 m1_1202_other ///
		m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1208_other m1_1209 m1_1209_other m1_1210 ///
		m1_1210_other m1_1211 m1_1211_other m1_1212 m1_1213 m1_1214 m1_1215 m1_1216b m1_1217)

rename (Q1218_A Q1218_B Q1218_C Q1218_D Q1218_E Q1218_6_OTHER Q1218_F Q1219 Q1220) ///
	   (m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f_other m1_1218f_1 m1_1219 m1_1220)

rename (Q1220_OTHER Q1221 Q1222 Q1222_OTHER Q1223 Q1301 Q1302) (m1_1220_other m1_1221 m1_1222 ///
		m1_1222_other m1_1223 height_cm weight_kg)

rename (Q1303A Q1303B Q1303C Q1304A Q1304B Q1304C Q1305A Q1305B Q1305C Q1306 Q1307 Q1308 Q1309 Q1401) ///
	   (bp_time_1_systolic bp_time_1_diastolic time_1_pulse_rate bp_time_2_systolic ///
	   bp_time_2_diastolic time_2_pulse_rate bp_time_3_systolic bp_time_3_diastolic pulse_rate_time_3 ///
	   m1_1306 m1_1307 m1_1308 m1_1309 m1_1401)

rename PHQ2 m1_phq2_score

rename (Q1102_1 Q1102_2 Q1102_3 Q1102_4 Q1102_5 Q1102_6 Q1102_7 Q1102_8 Q1102_9 Q1102_10 Q1102_96 ///
		Q1102_98 Q1102_99) (m1_1102_1 m1_1102_2 m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 m1_1102_7 ///
		m1_1102_8 m1_1102_9 m1_1102_10 m1_1102_96 m1_1102_98 m1_1102_99)

rename (Q1104_1 Q1104_2 Q1104_3 Q1104_4 Q1104_5 Q1104_6 Q1104_7 Q1104_8 Q1104_9 Q1104_10 Q1104_96 ///
		Q1104_98 Q1104_99) (m1_1104_1 m1_1104_2 m1_1104_3 m1_1104_4 m1_1104_5 m1_1104_6 m1_1104_7 ///
		m1_1104_8 m1_1104_9 m1_1104_10 m1_1104_96 m1_1104_98 m1_1104_99)		
		
rename (Q1220_1 Q1220_2 Q1220_3 Q1220_4 Q1220_5 Q1220_6 Q1220_96) (m1_1220_1 m1_1220_2 m1_1220_3 ///
		m1_1220_4 m1_1220_5 m1_1220_6 m1_1220_96)	
		
rename (Q405_1 Q405_2 Q405_3 Q405_4 Q405_5 Q405_6 Q405_7 Q405_8 Q405_9 Q405_10 Q405_96 Q405_99) ///
	   (m1_405a_in m1_405b_in m1_405c_in m1_405d_in m1_405e_in m1_405f_in m1_405g_in m1_405h_in ///
	   m1_405i_in m1_405j_in m1_405_96_in m1_405_99_in)		
		
rename Q802_DATE m1_802_date_in		

rename (Q808_0 Q808_1 Q808_2 Q808_3 Q808_4 Q808_5 Q808_6 Q808_7 Q808_8 Q808_10 Q808_11 Q808_12 ///
		Q808_9 Q808_96 Q808_99) (m1_808_0 m1_808_1 m1_808_2 m1_808_3 m1_808_4 m1_808_5 m1_808_6 ///
		m1_808_7 m1_808_8 m1_808_9 m1_808_10 m1_808_11 m1_808_13_in m1_808_96 m1_808_99)

rename (Q815_A_0 Q815_A_1 Q815_A_2 Q815_A_3 Q815_A_4 Q815_A_5 Q815_A_6 Q815_A_96 Q815_A_98 Q815_A_99) ///
	   (m1_815a_0_in m1_815a_1_in m1_815a_2_in m1_815a_3_in m1_815a_4_in m1_815a_5_in m1_815a_6_in ///
	   m1_815a_96_in m1_815a_98_in m1_815a_99_in)

rename (Q815_B_0 Q815_B_1 Q815_B_2 Q815_B_3 Q815_B_4 Q815_B_5 Q815_B_6 Q815_B_96 Q815_B_98 Q815_B_99) ///
       (m1_815b_0_in m1_815b_1_in m1_815b_2_in m1_815b_3_in m1_815b_4_in m1_815b_5_in m1_815b_6_in ///
	   m1_815b_96_in m1_815b_98_in m1_815b_99_in)

rename (Q815_C_0 Q815_C_1 Q815_C_2 Q815_C_3 Q815_C_4 Q815_C_5 Q815_C_6 Q815_C_96 Q815_C_98 Q815_C_99) ///
       (m1_815c_0_in m1_815c_1_in m1_815c_2_in m1_815c_3_in m1_815c_4_in m1_815c_5_in m1_815c_6_in ///
	   m1_815c_96_in m1_815c_98_in m1_815c_99_in)

rename (Q815_D_0 Q815_D_1 Q815_D_2 Q815_D_3 Q815_D_4 Q815_D_5 Q815_D_6 Q815_D_96 Q815_D_98 Q815_D_99) ///
	   (m1_815d_0_in m1_815d_1_in m1_815d_2_in m1_815d_3_in m1_815d_4_in m1_815d_5_in m1_815d_6_in ///
	   m1_815d_96_in m1_815d_98_in m1_815d_99_in)

rename (Q815_E_0 Q815_E_1 Q815_E_2 Q815_E_3 Q815_E_4 Q815_E_5 Q815_E_6 Q815_E_96 Q815_E_98 Q815_E_99) ///
       (m1_815e_0_in m1_815e_1_in m1_815e_2_in m1_815e_3_in m1_815e_4_in m1_815e_5_in m1_815e_6_in ///
	   m1_815e_96_in m1_815e_98_in m1_815e_99_in)

rename (Q815_F_0 Q815_F_1 Q815_F_2 Q815_F_3 Q815_F_4 Q815_F_5 Q815_F_6 Q815_F_96 Q815_F_98 Q815_F_99) ///
       (m1_815f_0_in m1_815f_1_in m1_815f_2_in m1_815f_3_in m1_815f_4_in m1_815f_5_in m1_815f_6_in ///
	   m1_815f_96_in m1_815f_98_in m1_815f_99_in)

rename (Q815_G_0 Q815_G_1 Q815_G_2 Q815_G_3 Q815_G_4 Q815_G_5 Q815_G_6 Q815_G_96 Q815_G_98 Q815_G_99) ///
       (m1_815g_0_in m1_815g_1_in m1_815g_2_in m1_815g_3_in m1_815g_4_in m1_815g_5_in m1_815g_6_in ///
	   m1_815g_96_in m1_815g_98_in m1_815g_99_in)

rename (Q815_H_0 Q815_H_1 Q815_H_2 Q815_H_3 Q815_H_4 Q815_H_5 Q815_H_6 Q815_H_96 Q815_H_98 Q815_H_99) ///
       (m1_815h_0_in m1_815h_1_in m1_815h_2_in m1_815h_3_in m1_815h_4_in m1_815h_5_in m1_815h_6_in ///
	   m1_815h_96_in m1_815h_98_in m1_815h_99_in)
	   
rename Q_C m1_interview_split

rename TOTAL_COST m1_totalcost_in

rename ID study_id

rename END m1_end_time

*------------------------------------------------------------------------------*

*fixing GA calculation:
//change date format
gen Date_of_interview = date(date_m1,"DMY")
format Date_of_interview %td
char Date_of_interview[Original_IN_Varname] `date_m1[Original_IN_Varname]'

gen estimated_delivery_date = date(m1_802_date_in,"DMY")
format estimated_delivery_date %td
char estimated_delivery_date[Original_IN_Varname] `m1_802_date_in[Original_IN_Varname]'

//Trimester calculation
*drop already existing vars:
drop GESTATIONAL_AGE GESTATIONAL_AGE_1 GEST_AGE GESTATIONAL_AGE_NEW

gen gestational_age = 40-((estimated_delivery_date - Date_of_interview)/7)
char gestational_age[Original_IN_Varname] 40-((`m1_802_date_in[Original_IN_Varname]' -`date_m1[Original_IN_Varname]')/7)

gen gestational_age_1 =((m1_803a_in*4)+ m1_803b_in)
char gestational_age_1[Original_IN_Varname] ((`m1_803a_in[Original_IN_Varname]'*4)+ `m1_803b_in[Original_IN_Varname]')

gen gest_age = gestational_age
char gest_age[Original_IN_Varname] gestational_age (Set to gestational_age_1 if missing gestational_age)


replace gest_age = gestational_age_1 if gestational_age==.
ta gest_age

recode gest_age (0/12.9999=1 "Trimester 1") (12/27.9999=2 "Trimester 2") (28/40=3 "Trimester 3"), gen (Gestational_age_new)
char Gestational_age_new[Original_IN_Varname] `gest_age[Original_IN_Varname]'

rename Gestational_age_new m1_804 //Q804 not in the dataset 

*------------------------------------------------------------------------------*

* dropping unncessary vars:

drop SUBMISSIONDATE CALC_START_TIME CALC_WEEKS_REMAINING_1 CALC_WEEKS_REMAINING_2 CALC_WEEKS_REMAINING ///
	 START 

*===============================================================================
	
	* STEP TWO: ADD VALUE LABELS (NA in South Africa, already labeled)	   
		
*===============================================================================
		
	*STEP THREE: RECODING MISSING VALUES 
		* Recode refused and don't know values
		* Note: .a means NA, .r means refused, .d is don't know, . is missing 
		* helpful command: codebookout "D:IN missing codebook.xls"

		** MODULE 1:

recode mobile_phone m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_203 m1_204 ///
	   m1_205a m1_205b m1_205c m1_205d m1_205e phq9a phq9b phq9c phq9d phq9e phq9f ///
	   phq9g phq9h phq9i m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b m1_401 m1_402 ///
	   m1_404 m1_501 m1_503 m1_504 m1_505 m1_506 m1_507 m1_601 m1_602 m1_605a m1_605b ///
	   m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_700 m1_701 m1_702 m1_703 m1_704 ///
	   m1_705 m1_706 m1_707 m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b ///
	   m1_710a m1_710b m1_710c m1_711a m1_711b m1_712 m1_713_in_za m1_713a m1_713b m1_713c ///
	   m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713k m1_713l m1_714a m1_714b m1_716a ///
	   m1_716b m1_716c m1_716d m1_716e m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a ///
	   m1_724c m1_724d m1_724e m1_724f m1_724g m1_724h m1_724i m1_801 m1_802a m1_805 m1_806 ///
	   m1_807 m1_809 m1_812a m1_812b m1_813a m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e ///
	   m1_814f m1_814g m1_814h m1_815a_in m1_815e_in m1_815g_in m1_815h_in m1_816 m1_901 m1_902 /// 
	   m1_905 m1_907 m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 m1_1011a m1_1011b m1_1011c m1_1011d ///
	   m1_1011e m1_1011f m1_1101 m1_1103 m1_1105 m1_1201 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 ///
	   m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215 m1_1217 ///
	   m1_1221 m1_1222 m1_1223 (99 = .r)

recode m1_401 m1_402 m1_404 m1_506 m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 ///
	   m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c ///
	   m1_711a m1_711b m1_712 m1_713_in_za m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g ///
	   m1_713h m1_713i m1_713k m1_713l m1_714a m1_714b m1_716a m1_716b m1_716c m1_716d m1_716e ///
	   m1_717 m1_718 m1_719 m1_720 m1_721 m1_722 m1_723 m1_724a m1_724c m1_724d m1_724e m1_724f ///
	   m1_724g m1_724h m1_724i m1_801 m1_802a m1_805 m1_806 m1_807 m1_809 m1_812a m1_812b m1_813a ///
	   m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h m1_815a_in m1_815e_in ///
	   m1_815g_in m1_815h_in m1_816 m1_901 m1_902 m1_907 m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 ///
	   m1_1011a m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f m1_1101 m1_1105 m1_1201 m1_1202 ///
	   m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 ///
	   m1_1214 m1_1215 m1_1222 m1_1223 m1_714c m1_714e m1_810a (98 = .d)

recode m1_509b m1_510b m1_511 (99 = .d)   

replace m1_815c_in = ".d" if m1_815c_in == "98"

replace m1_808 = ".r" if m1_808 == "99"

replace bp_time_1_systolic = . if bp_time_1_systolic==1120
replace bp_time_3_systolic= . if bp_time_3_systolic==1120
*------------------------------------------------------------------------------*

* recoding for skip pattern logic:	   
	   
* Recode missing values to NA for questions respondents would not have been asked 
* due to skip patterns

* MODULE 1:	
	*Note: A lot of the early M1 vars on data file of 1-24-24 do not have missings
	* Kept these recode commands here even though there is no missings 
	* helpful command: misstable summarize
recode care_self (. = .a) if permission == 0
recode enrollage (. = .a) if permission == 0
recode b6anc_first (. = .a) if b5anc== 2
recode flash (. = .a) if mobile_phone == 0 | mobile_phone == 99 | mobile_phone == .
	
recode m1_402a_in (. = .a) if m1_402 !=1
recode m1_402b_in (. = .a) if m1_402 !=2
	
recode m1_405_other (. = .a) if m1_405_96_in != 1 // numeric right now because of 0 obs (1-24-24)
	
recode m1_503 (. = .a) if m1_502 !=1	
recode m1_504  m1_504a_in (. = .a) if m1_503 != 2 | m1_503 != 3 | m1_503 != 4 | m1_503 != 5
	
recode m1_509b (.  = .a) if m1_509a == 0 | m1_509a == . | m1_509a == .r
recode m1_510b (.  = .a) if m1_510a == 0 | m1_510a == . | m1_510a == .r

* recode m1_c6_in m1_c7_in (. = .a) if m1_interview_split !=1 // string var in new dataset ss fix

recode m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b (. = .a) if m1_708a !=1

recode m1_708b (. = .a) if m1_708a == . | m1_708a == 0 | m1_708a == .d | m1_708a == .r
recode m1_708c (. = .a) if m1_708b	== 2 | m1_708b	== 3 | m1_708b == . |	m1_708b == .d | m1_708b == .a | m1_708b == .r
recode m1_708d (. = .a) if m1_708c	== 0 | m1_708c == . | m1_708c == .d | m1_708c == .a | m1_708c == .r
recode m1_708e (. = .a) if m1_708d == 0 | m1_708d == . | m1_708d == .d | m1_708d == .a | m1_708d == .r
recode m1_708f (. = .a) if m1_708e == 0 | m1_708e == . | m1_708e == .d | m1_708e == .a | m1_708e == .r
recode m1_709a (. = .a) if m1_708b	== 2 | m1_708b == . | m1_708b == .d | m1_708b == .a | m1_708b == .r | m1_708b == .a
recode m1_709b (. = .a) if m1_708b	== 2 | m1_708b == . | m1_708b == .d | m1_708b == .a | m1_708b == .r | m1_708b == .a

recode m1_710b (. = .a) if m1_710a !=1
recode m1_710c (. = .a) if m1_710b !=1
recode m1_711b (. = .a) if m1_711a !=1
recode m1_714c m1_714d (. = .a) if m1_714b !=1
recode m1_714e (. = .a) if m1_714c == 0 | m1_714c == 1 | m1_714c == . | m1_714c == .a | ///
						   m1_710b !=1

recode m1_717 (. = .a) if m1_202d !=1
recode m1_718 (. = .a) if m1_202a !=1
recode m1_719 (. = .a) if m1_202b !=1
recode m1_720 (. = .a) if m1_202c !=1
recode m1_721 (. = .a) if m1_202d !=1
recode m1_722 (. = .a) if m1_202e !=1
recode m1_723 (. = .a) if m1_204 !=1
recode m1_724b (. = .a) if m1_724a !=1
recode m1_724f (. = .a) if m1_705 !=0
recode m1_724g (. = .a) if  m1_707 !=0
recode m1_724h (. = .a) if m1_708a !=0 
recode m1_724i (. = .a) if m1_712 !=0
*recode m1_802_date_in m1_802a (. = .a) if m1_802a !=1 // string in new ds ss fix
recode m1_803a_in m1_803b_in (. = .a) if m1_802a ==1 
recode m1_808_0 m1_808_1 m1_808_2 m1_808_3 m1_808_4 m1_808_5 m1_808_6 m1_808_7 ///
	   m1_808_8 m1_808_13_in m1_808_9 m1_808_10 m1_808_11 m1_808_96 m1_808_99 ///
	   (. = .a) if m1_808 == ""
recode m1_810a (. = .a) if m1_809 !=1
recode m1_812b (. = .a) if m1_812a !=1
recode m1_813b (.  = .a) if m1_813a !=1
recode m1_814h (.  = .a) if m1_804 !=3
recode m1_815a_in m1_815a_0_in m1_815a_1_in m1_815a_2_in m1_815a_3_in m1_815a_4_in m1_815a_5_in m1_815a_6_in m1_815a_96_in m1_815a_98_in m1_815a_99_in (. = .a) if m1_814a !=1 

replace m1_815a_other_in = ".a" if m1_815a_96_in !=1 

replace m1_815b_in = ".a" if m1_814b !=1 

recode m1_815b_0_in m1_815b_1_in m1_815b_2_in m1_815b_3_in m1_815b_4_in m1_815b_5_in m1_815b_6_in m1_815b_96_in m1_815b_98_in m1_815b_99_in (. = .a) if m1_814b !=1 

recode m1_815b_other_in (. = .a) if m1_815b_96_in !=1 // numeric because of 0 obs

replace m1_815c_in = ".a" if m1_814c !=1 

recode m1_815c_0_in m1_815c_1_in m1_815c_2_in m1_815c_3_in m1_815c_4_in m1_815c_5_in m1_815c_6_in m1_815c_96_in m1_815c_98_in m1_815c_99_in (. = .a) if m1_814c !=1 

recode m1_815c_other_in (. = .a) if m1_815c_96_in !=1 // numeric because of 0 obs

replace m1_815d_in = ".a" if m1_814d !=1 

recode m1_815d_0_in m1_815d_1_in m1_815d_2_in m1_815d_3_in m1_815d_4_in m1_815d_5_in m1_815d_6_in m1_815d_96_in m1_815d_98_in m1_815d_99_in (. = .a) if m1_814d !=1 

recode m1_815d_other_in (. = .a) if m1_815d_96_in !=1 // numeric because of 0 obs

recode m1_815e_in m1_815e_0_in m1_815e_1_in m1_815e_2_in m1_815e_3_in m1_815e_4_in m1_815e_5_in m1_815e_6_in m1_815e_96_in m1_815e_98_in m1_815e_99_in (. = .a) if m1_814e !=1

recode m1_815e_other_in (. = .a) if m1_815e_96_in !=1 

replace m1_815f_in = .a if m1_814d !=1 

recode m1_815f_0_in m1_815f_1_in m1_815f_2_in m1_815f_3_in m1_815f_4_in m1_815f_5_in m1_815f_6_in m1_815f_96_in m1_815f_98_in m1_815f_99_in (. = .a) if m1_814f !=1

recode m1_815f_other_in (. = .a) if m1_815f_96_in !=1 

recode m1_815g_in m1_815g_0_in m1_815g_1_in m1_815g_2_in m1_815g_3_in m1_815g_4_in m1_815g_5_in m1_815g_6_in m1_815g_96_in m1_815g_98_in m1_815g_99_in (. = .a) if m1_814g !=1

replace m1_815g_other_in = ".a" if m1_815g_96_in !=1 

destring m1_815h_1_in, replace
destring  m1_815h_6_in, replace
destring m1_815h_96_in, replace
*recode m1_815h_in m1_815h_0_in m1_815h_1_in m1_815h_2_in m1_815h_3_in m1_815h_4_in m1_815h_5_in m1_815h_6_in m1_815h_96_in m1_815h_98_in m1_815h_99_in (. = .a) if m1_814h !=1 // ss fix

*recode m1_815h_other_in (. = .a) if m1_815h_96_in !=1 // ss fix

egen m1_symptoms = rowtotal(m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h)

recode m1_816 (. = .a) if m1_symptoms >0 // 111 obs still in true missing? but they responded to one of the symptoms
* response from team: Although variable Q816 is related to Q814_a…. Q814_h, but the individuals have answered it independently, whether the health facility workers have asked the individuals about various symptoms or not
						  
drop m1_symptoms

recode m1_816 (. = .a) if m1_814a !=1 &	m1_814b !=1 & m1_814c !=1 & m1_814d !=1 & ///
						  m1_814e !=1 &	m1_814f !=1 & m1_814g !=1 & m1_814h !=1 		
						  
recode m1_902 (. = .a) if m1_901 !=1 | m1_901 !=2
						  
recode m1_906 (. = .a) if m1_905 !=1

recode m1_907 (. = .a) if m1_906 !=1	

recode m1_1003 (.  = .a) if m1_1002 <1 | m1_1002 == . | m1_1002 == .a		  
				
recode m1_1004 (.  = .a) if m1_1001 <= m1_1002

recode m1_1005 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 == .)

recode m1_1006 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 == .)

recode m1_1007 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1008 (.  = .a) if (m1_1002<1 | m1_1002 ==.a | m1_1002 ==.)

recode m1_1009 (.  = .a) if (m1_1003 <1 | m1_1003 == .a | m1_1003 == .)

recode m1_1010 (.  = .a) if (m1_1003 <= m1_1009) | m1_1003 == .a 

recode m1_1011a (.  = .a) if (m1_1001 <= 1 | m1_1001 ==.)

recode m1_1011b (.  = .a) if m1_1004 !=1

recode m1_1011c (.  = .a) if (m1_1002 <= m1_1003)

recode m1_1011d (.  = .a) if m1_1005 !=1 

recode m1_1011e (.  = .a) if m1_1007 !=1

recode m1_1011f (.  = .a) if m1_1010 !=1

replace m1_1102 = ".a" if m1_1101 !=1
				
recode m1_1102_1 m1_1102_2 m1_1102_3 m1_1102_4 m1_1102_5 m1_1102_6 m1_1102_7 ///
	   m1_1102_8 m1_1102_9 m1_1102_10 m1_1102_96 m1_1102_98 m1_1102_99 (.  = .a) if ///
	   m1_1101 !=1
	   
recode m1_1102_other (. = .a) if m1_1102_96 != 1 // numeric bc of 0 observations 
	   
replace m1_1104 = ".a" if m1_1103 !=1

recode m1_1104_1 m1_1104_2 m1_1104_3 m1_1104_4 m1_1104_5 m1_1104_6 m1_1104_7 m1_1104_8 m1_1104_9 m1_1104_10 m1_1104_96 m1_1104_98 m1_1104_99 (. = .a) if m1_1103 !=1
	
recode m1_1104_other (. = .a) if m1_1104_96 != 1 // numeric bc of 0 observations 

recode m1_1202_other (.  = .a) if m1_1202 !=96 // numeric bc of 0 observations 

recode m1_1208_other (.  = .a) if m1_1208 !=96 // numeric bc of 0 observations  

recode m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_totalcost_in ///
	   m1_1219 m1_1220_1 m1_1220_2 m1_1220_3 m1_1220_4 m1_1220_5 m1_1220_6 ///
	   m1_1220_96 (. = .a) if m1_1217 !=1

replace m1_1218f_other = ".a" if m1_1218f_1 !=1	   

recode m1_1220_other (. = .a) if m1_1220_96 !=1 // numeric bc of 0 observations  
	   
recode m1_1222 (. = .a) if m1_1221 !=1	   

recode m1_1222_other (. = .a) if m1_1222 !=96

recode m1_1307 (. = .a) if m1_1306 !=1
	
recode m1_1308 (.  = .a) if m1_1306 == 1 | m1_1306 == .a | m1_1306 == .d | m1_1306 == .r

recode m1_1309 (.  = .a) if m1_1308 !=1		

*===============================================================================					   
	
	* STEP FOUR: LABELING VARIABLES
*ren rec* *
	
	** MODULE 1:		
lab var country "Country"
*lab var interviewer_id "Interviewer ID"
lab var date_m1 "A2. Date of interview"
lab var m1_start_time "A3. Time of interview"
lab var study_site "A4. Study site"
lab var facility "A5. Facility name"
lab var permission "B1. May we have your permission to explain why we are here today, and to ask some questions?"
lab var care_self "B2. Are you here today to receive care for yourself or someone else?"
lab var enrollage "B3. How old are you?"
*lab var zone_live "B4. In which zone/district/sub city are you living?"
*lab var zone_live_other "B4_Other. Other zone/district/subcity"
lab var b5anc "B5. By that I mean care related to a pregnancy?"
lab var b6anc_first "B6. Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?"
lab var b7eligible "B7. Is the respondent eligible to participate in the study AND signed a consent form?"
lab var respondentid "103. Assign respondent ID"
lab var mobile_phone "104. Do you have a mobile phone with you today?"
lab var flash "106. Can I 'flash' this number now to make sure I have noted it correctly?"
lab var m1_201 "201. In general, how would you rate your overall health?"
lab var m1_202a "202a. BEFORE you got pregnant, did you know that you had Diabetes?"
lab var m1_202b "202b. BEFORE you got pregnant, did you know that you had High blood pressure or hypertension?"
lab var m1_202c "202c. BEFORE you got pregnant, did you know that you had a cardiac disease or problem with your heart?"
lab var m1_202d "202d BEFORE you got pregnant, did you know that you had A mental health disorder such as depression, anxiety, bipolar disorder, or schizophrenia?"
lab var m1_202e "202e BEFORE you got pregnant, did you know that you had HIV?"
lab var m1_203 "203. Before you got pregnant, were you diagnosed with any other major health problems?"
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
lab var m1_301 "301. How would you rate the overall quality of medical care in Ethiopia?"
lab var m1_302 "302. Overall view of the health care system in your country"
lab var m1_303 "303. Confidence that you would receive good quality healthcare from the health system if you got very sick?"
lab var m1_304 "304. Confidence you would be able to afford the healthcare you needed if you became very sick?"
lab var m1_305a "305a. Confidence that you that you are the person who is responsible for managing your overall health?"
lab var m1_305b "305b. Confidence that you that you can tell a healthcare provider concerns you have even when he or she does not ask "
lab var m1_401 "401. How did you travel to the facility today?"
lab var m1_401_other "401_Other. Other specify: travel"
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
lab var m1_504a_in "IF RESPONDENT CANNOT READ WHOLE SENTENCE, PROBE: Can you read any part of the sentence to me?"
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
lab var m1_601 "601. Overall how would you rate the quality of care you received today?"
lab var m1_602 "602. How likely are you to recommend this facility or provider to a family member or friend to receive care for their pregnancy?"
lab var m1_603 "603. How long in minutes did you spend with the health provider today?"
lab var m1_604a "604a.  How long in hours did you wait see a provider for the consultation?"
lab var m1_604b "604b.  How long in minutes did you wait see a provider for the consultation?"
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
lab var m1_713_in_za "713. IN/ZA only: Iron injection"
lab var m1_713a "713a. Iron or folic acid pills, e.g., IFAS or Pregnacare?"
lab var m1_713b "713b. Calcium pills?"
lab var m1_713c "713c. The food supplement like Super Cereal or Plumpynut?"
lab var m1_713d "713d. Medicine for intestinal worms?"
lab var m1_713e "713e. Medicine for malaria (endemic only)?"
lab var m1_713f "713f. Medicine for your emotions, nerves, or mental health?"
lab var m1_713g "713g. Multivitamins?"
lab var m1_713h "713h. Medicine for hypertension?"
lab var m1_713i "713i. Medicine for diabetes, including injections of insulin?"
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
lab var m1_802_date_in "802. IN only: Estimated date of delivery"
lab var m1_803a_in "803. How many months pregnant do you think you are?"
lab var m1_803b_in "803. How many weeks pregnant do you think you are?"
lab var m1_804 "804. Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)."
lab var m1_805 "805. How many babies are you pregnant with?"
lab var m1_806 "806. During the visit today, did the healthcare provider ask when you had your last period, or not?"
lab var m1_807 "807. When you got pregnant, did you want to get pregnant at that time?"
lab var m1_808 "808: There are many reasons why some women may not get antenatal care earlier in their pregnancy. Which, ifany, of the following, are reasons you did not receive care earlier in your pregnancy?"
lab var m1_808_other "808_Other. Specify other reason not to receive care earlier in your pregnancy."
lab var m1_809 "809. During the visit today, did you and the provider discuss your birth plan?"
lab var m1_810a "810a. Where do you plan to give birth?"
lab var m1_810b "810b. What is the name of the [facility type from 810a] where you plan to give birth?"
lab var m1_812a "812a. During the visit today, did the provider tell you that you might need a C-section?"
lab var m1_812b "812b. Have you told the reason why you might need a c-section?"
lab var m1_812b_other "812b_Other. Specify other reason why you needed a C-section"
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
lab var m1_815a_in "815a. During the visit today, what did the provider tell you to do regarding the 'Severe or persistent headaches?'"
lab var m1_815a_other_in "815a-oth. Other (Please specify)"
lab var m1_815b_in "815.b. During the visit today, what did the provider tell you to do regarding the 'Vaginal bleeding of any amount'?"
lab var m1_815b_other_in "815b-oth. Other (Please specify)"
lab var m1_815c_in "815c. During the visit today, what did the provider tell you to do regarding the 'fever'?"
lab var m1_815c_other_in "815c-oth. Other (Please specify)"
lab var m1_815d_in "815d. During the visit today, what did the provider tell you to do regarding the 'Severe abdominal pain, not just discomfort'?"
lab var m1_815d_other_in "815d-oth. Other (Please specify)"
lab var m1_815e_in "815e. During the visit today, what did the provider tell you to do regarding 'A lot of difficulty breathing even when you are resting'?"
lab var m1_815e_other_in "815e-oth. Other (Please specify)"
lab var m1_815f_in "815f. During the visit today, what did the provider tell you to do regarding the 'Convulsions or seizures'?"
lab var m1_815f_other_in "815f-oth. Other (Please specify)"
lab var m1_815g_in "815g. During the visit today, what did the provider tell you to do regarding the 'Repeated fainting or loss of consciousness'?"
lab var m1_815g_other_in "815g-oth. Other (Please specify)"
lab var m1_815h_in "815h. During the visit today, what did the provider tell you to do regarding the 'Noticing that the baby has completely stopped moving'?"
lab var m1_815h_other_in "815h-oth. Other (Please specify)"
lab var m1_815a_0_in "Nothing, we did not discuss this"
lab var m1_815a_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815a_2_in "They provided a treatment in the visit"
lab var m1_815a_3_in "They prescribed a medication"
lab var m1_815a_4_in "They told you to come back to this health facility"
lab var m1_815a_5_in "They told you to go somewhere else for higher level care"
lab var m1_815a_6_in "They told you to wait and see"
lab var m1_815a_96_in "Other"
lab var m1_815a_98_in "Don't Know"
lab var m1_815a_99_in "NR/RF"
lab var m1_815b_0_in "Nothing, we did not discuss this"
lab var m1_815b_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815b_2_in "They provided a treatment in the visit"
lab var m1_815b_3_in "They prescribed a medication"
lab var m1_815b_4_in "They told you to come back to this health facility"
lab var m1_815b_5_in "They told you to go somewhere else for higher level care"
lab var m1_815b_6_in "They told you to wait and see"
lab var m1_815b_96_in "Other"
lab var m1_815b_98_in "Don't Know"
lab var m1_815b_99_in "NR/RF"
lab var m1_815c_0_in "Nothing, we did not discuss this"
lab var m1_815c_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815c_2_in "They provided a treatment in the visit"
lab var m1_815c_3_in "They prescribed a medication"
lab var m1_815c_4_in "They told you to come back to this health facility"
lab var m1_815c_5_in "They told you to go somewhere else for higher level care"
lab var m1_815c_6_in "They told you to wait and see"
lab var m1_815c_96_in "Other"
lab var m1_815c_98_in "Don't Know"
lab var m1_815c_99_in "NR/RF"
lab var m1_815d_0_in "Nothing, we did not discuss this"
lab var m1_815d_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815d_2_in "They provided a treatment in the visit"
lab var m1_815d_3_in "They prescribed a medication"
lab var m1_815d_4_in "They told you to come back to this health facility"
lab var m1_815d_5_in "They told you to go somewhere else for higher level care"
lab var m1_815d_6_in "They told you to wait and see"
lab var m1_815d_96_in "Other"
lab var m1_815d_98_in "Don't Know"
lab var m1_815d_99_in "NR/RF"
lab var m1_815e_0_in "Nothing, we did not discuss this"
lab var m1_815e_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815e_2_in "They provided a treatment in the visit"
lab var m1_815e_3_in "They prescribed a medication"
lab var m1_815e_4_in "They told you to come back to this health facility"
lab var m1_815e_5_in "They told you to go somewhere else for higher level care"
lab var m1_815e_6_in "They told you to wait and see"
lab var m1_815e_96_in "Other"
lab var m1_815e_98_in "Don't Know"
lab var m1_815e_99_in "NR/RF"
lab var m1_815f_0_in "Nothing, we did not discuss this"
lab var m1_815f_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815f_2_in "They provided a treatment in the visit"
lab var m1_815f_3_in "They prescribed a medication"
lab var m1_815f_4_in "They told you to come back to this health facility"
lab var m1_815f_5_in "They told you to go somewhere else for higher level care"
lab var m1_815f_6_in "They told you to wait and see"
lab var m1_815f_96_in "Other"
lab var m1_815f_98_in "Don't Know"
lab var m1_815f_99_in "NR/RF"
lab var m1_815g_0_in "Nothing, we did not discuss this"
lab var m1_815g_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815g_2_in "They provided a treatment in the visit"
lab var m1_815g_3_in "They prescribed a medication"
lab var m1_815g_4_in "They told you to come back to this health facility"
lab var m1_815g_5_in "They told you to go somewhere else for higher level care"
lab var m1_815g_6_in "They told you to wait and see"
lab var m1_815g_96_in "Other"
lab var m1_815g_98_in "Don't Know"
lab var m1_815g_99_in "NR/RF"
lab var m1_815h_0_in "Nothing, we did not discuss this"
lab var m1_815h_1_in "They told you to get a lab test or imaging (e.g., ultrasound, blood tests, x-ray, heart echo)"
lab var m1_815h_2_in "They provided a treatment in the visit"
lab var m1_815h_3_in "They prescribed a medication"
lab var m1_815h_4_in "They told you to come back to this health facility"
lab var m1_815h_5_in "They told you to go somewhere else for higher level care"
lab var m1_815h_6_in "They told you to wait and see"
lab var m1_815h_96_in "Other"
lab var m1_815h_98_in "Don't Know"
lab var m1_815h_99_in "NR/RF"
lab var m1_816 "816. You said that you did not have any of the symptoms I just listed. Did the health provider ask you whether or not you had these symptoms, or did this topic not come up today?"
lab var m1_901 "901. How often do you currently smoke cigarettes or use any other type of tobacco? Is it every day, some days, or not at all?"
lab var m1_902 "902. During the visit today, did the health provider advise you to stop smoking or using tobacco products?"
lab var m1_905 "905. Have you consumed an alcoholic drink within the past 30 days?"
lab var m1_906 "906. When you do drink alcohol, how many drinks do you consume on average?"
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
lab var m1_1102_other "1102_Other. Specify other person"
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
lab var m1_1216b "1216: How many meals does your household usually have per day?"
lab var m1_1217 "1217. Did you pay money out of your pocket for this visit, including for the consultation or other indirect costs like your transport to the facility?"
lab var m1_1218a_1 "1218a. How much money did you spend on Registration / Consultation?"
lab var m1_1218b_1 "1218b. How much money do you spent for medicine/vaccines (including outside purchase)"
lab var m1_1218c_1 "1218c. How much money have you spent on Test/investigations (x-ray, lab etc.)?"
lab var m1_1218d_1 "1218d. How much money have you spent for transport (round trip) including that of person accompanying you?"
lab var m1_1218e_1 "1218e. How much money have you spent on food and accommodation including that of the person accompanying you?"
lab var m1_1218f_1 "1218f. How much were these other costs?"
lab var m1_1218f_other "1218f_Other. What are those other costs that you incurred?"
lab var m1_1219 "1219. Total amount spent"
lab var m1_1220 "1220: Which of the following financial sources did your household use to pay for this?"
lab var m1_1220_1 "Current income of any household members"
lab var m1_1220_2 "Savings (e.g. bank account)"
lab var m1_1220_3 "Payment or reimbursement from a health insurance plan"
lab var m1_1220_4 "Sold items (e.g. furniture, animals, jewellery, furniture)"
lab var m1_1220_5 "Family members or friends from outside the household"
lab var m1_1220_6 "Borrowed (from someone other than a friend or family)"
lab var m1_1220_96 "Other"
lab var m1_1220_other "1220_Other. Specify other financial source for household use to pay for this"
lab var m1_1221 "1221. Are you covered with a health insurance?"
lab var m1_1222 "1222. What type of health insurance coverage do you have?"
lab var m1_1222_other "1222_Other. Specify other health insurance coverage used."
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
lab var m1_c6_in "Date of interview, if survey was split after ANC visit"
lab var m1_c7_in "Time of interview, if survey was split after ANC visit"
lab var m1_end_time "Module 1 end date and time"

*===============================================================================

	* STEP FIVE: ORDER VARIABLES
order m1_*, sequential
order country date_m1 m1_start_time study_site facility facility_other ///
      permission care_self enrollage b5anc b6anc_first b7eligible  ///
	  respondentid mobile_phone flash

order phq9a phq9b phq9c phq9d phq9e phq9f phq9g phq9h phq9i, after(m1_205e)

*===============================================================================
	* STEP SIX: SAVE DATA TO RECODED FOLDER

	* We need to trim the respondentid variables and strip any "
	replace respondentid = subinstr(respondentid,`"""',"",.)
	replace respondentid = trim(respondentid)
	
	* Add a character with the module number for codebook purposes
	foreach v of varlist * {
		char `v'[Module] 1
	}
	
	save "$in_data_final/eco_m1_in.dta", replace

*===============================================================================

