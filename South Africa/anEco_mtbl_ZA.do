* South Africa ECohort M1 data analysis 
* The following code generates a megatable for all data included in the baseline module 
* Created by K. Wright, C. Arsenault, and S. Sabwa 

*------------------------------------------------------------------------------*

* This .do file should be used only after the data has been cleaned, using the crEco_cln_ZA.do file

global user "/Users/katewright/Dropbox (Harvard University)/"

global data "SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data collection/4 South Africa/Analyses"

use "/Users/katewright/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data/eco_m1_za.dta"

*------------------------------------------------------------------------------*

**---------summtab for enrollment data----------* 

summtab2, by(study_site) vars(facility m1_803) type(2 1) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Enrollment) directory("$user/$data")

**----------------------------------------------* 

**--------summtab for demographic data----------*

summtab2, by(study_site) vars(enrollage m1_501 m1_501_other m1_502 m1_503 m1_504 m1_505 m1_506 m1_506_other m1_507 m1_508) type (1 2 2 2 2 2 2 2 2 2 1) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Demographics) directory("$user/$data")

**---------------------------------------------*

**--------summtab for health literacy ---------*

summtab, by(study_site) catvars(m1_509a m1_509b m1_510a m1_510b m1_511 m1_512) total catmisstype(missnoperc) excel excelname(ZA_ECohort_summtab) sheetname(Health Literacy) directory("$user/$data")

**---------------------------------------------*

**--------summtab for health profile  ---------*

** need to move the phq9 variables to a derived variable file. but keeping here for now for ease ** 

* generate PHQ9 variable 
		gen phq9 = phq9a + phq9b + phq9c + phq9d + phq9e + phq9f + phq9f + phq9g + phq9h + phq9i 
		
		tab phq9
		
		
		recode phq9 (0 1 2 3 4 = 1) (5 6 7 8 9 = 2) (10 11 12 13 14 = 3) (15 16 17 18 19 = 4) (20 21 22 23 24 25 26 27 = 5)
		* define labels for phq9 
		label define phq9 1 "none-minimal" 2 "mild" 3 "moderate" 4 "moderately severe" 5 "severe" 6 "error"
		label values phq9 phq9
		tab phq9
		
summtab2, by (study_site) vars(m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_203 m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9 m1_207) type (2 2 2 2 2 2 2 2 2 2 2 2 2 2 1) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Health Profile) directory("$user/$data")

**---------------------------------------------*

**--------summtab for health system ratings  ---------*

summtab, by(study_site) catvars(m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b) total catmisstype(missnoperc) excel excelname(ZA_ECohort_summtab) sheetname(HS Ratings) directory("$user/$data")

**----------------------------------------------------*

**--------  summtab for care pathways ---------*

summtab2, by (study_site) vars(m1_401 m1_402 m1_403b m1_404 m1_405) type (2 1 1 2 2) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Care Pathways) directory("$user/$data")

**---------------------------------------------*

**--------  summtab for user experience ---------*

summtab2, by(study_site) vars (m1_603 m1_604 m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_602 m1_1223) type (1 1 2 2 2 2 2 2 2 2 2 2 2) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(User Experience) directory("$user/$data")

**-----------------------------------------------*

**--------  summtab for content of care: investigations  ---------*

summtab, by(study_site) catvars (m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_710a m1_711a m1_712) replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Content. Investigations) directory("$user/$data")

**---------------------------------------------------------------*

**--------  summtab for content of care: test results  ---------*

summtab, by(study_site) catvars(m1_708a m1_708b m1_710a m1_710b m1_711a m1_711b) replace excel excelname(ZA_ECohort_summtab) sheetname(TestResult) directory("$user/$data")

**--------------------------------------------------------------*

**--------  summtab for content of care: STI care  ---------*

summtab, by(study_site) catvars(m1_708a m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c) replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(STIcare) directory("$user/$data")

**----------------------------------------------------------*

**--------  summtab for content of care: medicines  ---------*

summtab, by(study_site) catvars(m1_713_za_in m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713m_za m1_713n_za m1_714a m1_715) replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Meds) directory("$user/$data")

**------------------------------------------------------------*	

**--------  summtab for content of care: counseling  ---------*
	
summtab, by(study_site) catvars(m1_716a m1_716b m1_716c m1_716d m1_716e) catmisstype(missnoperc) total replace excel excelname(ZA_ECohort_summtab) sheetname(Counsel) directory("$user/$data")

**-------------------------------------------------------------*	

**--------  summtab for content of care: instructions  ---------*

summtab2, by(study_site) vars (m1_724a m1_724b m1_724c m1_724d m1_724e) type (2 1 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(AdvCare) directory("$user/$data")

**--------------------------------------------------------------*		

**--------  summtab for gestational age / pregnancy info  ---------*

summtab2, by(study_site) vars (m1_801 m1_803 m1_804 m1_805 m1_806 m1_807 m1_809 m1_810a m1_811 m1_812a m1_813a m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h) type (2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(GA_perginfo) directory("$user/$data")
  
**-----------------------------------------------------------------*		

**--------  summtab for obstetric history  ---------*

summtab, by (study_site) catvars(m1_1001 m1_1002 m1_1003 m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 m1_1009 m1_1010) catmisstype(missnoperc) total replace excel excelname(ZA_ECohort_summtab) sheetname(ObsHistory) directory("$user/$data")

**--------------------------------------------------*

**--------  summtab for risky health behaviors  ---------*
	
summtab2, by(study_site) vars(m1_901 m1_902 m1_905 m1_906 m1_907 m1_908_za m1_909_za m1_910_za) type (2 2 2 1 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(riskybeh) directory("$user/$data")

**-------------------------------------------------------*

**--------  summtab for experience of violence  ---------*
	
summtab, by(study_site) catvars(m1_1101 m1_1102 m1_1102_other m1_1103 m1_1104 m1_1104_other m1_1105) replace excel excelname(ZA_ECohort_summtab) sheetname(violence) directory("$user/$data")
	
**-------------------------------------------------------* 

**--------  summtab for economic status  ---------*
	
summtab, by(study_site) catvars(m1_1201 m1_1201_other m1_1202 m1_1202_other m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1210_other m1_1211 m1_1211_other m1_1212 m1_1213 m1_1214 m1_1215 m1_1216a) replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(econstat) directory("$user/$data")
	
**------------------------------------------------*

**--------  summtab for cost of visit & insurance  ---------*

summtab2, by(study_site) vars (m1_1217 m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1219 m1_1220 m1_1221) type(2 1 1 1 1 1 1 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(visit cost) directory("$user/$data")

**----------------------------------------------------------*
