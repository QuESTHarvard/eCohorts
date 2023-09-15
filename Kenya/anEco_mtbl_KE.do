* Kenya ECohort M1 data analysis 
* The following code generates a megatable for all data included in the baseline module 
* Created by K. Wright, C. Arsenault, and S. Sabwa 

*------------------------------------------------------------------------------*

* Importing clean KE dataset that was created in "crEco_cln_KE.do"

import u "$et_data_final/eco_m1_ke.dta", clear
use "/Users/katewright/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data/eco_m1_ke.dta"

* global user "/Users/katewright/Dropbox (Harvard University)/

* global user "/Users/katewright/Dropbox (Harvard University)/"

* global data "SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data collection/2 Kenya "

cd "/Users/katewright/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data collection/2 Kenya"


**---------summtab for enrollment data----------* 

** We need to figure out the sampling strata for Kenya, so we can create sampling strata for the enrollment

summtab, by(site) catvars(sampstrata) total catmisstype(missnoperc) excel excelname(KE_ECohort_summtab) sheetname(Enrollment) directory("$user/$data")

**----------------------------------------------* 

**--------summtab for demographic data---------*
	
summtab, by(study_site) catvars(m1_501 m1_502 m1_503 m1_504 m1_505 m1_506 m1_507) catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(Demographics) title("Kenya MNH ECohort Demographic Variables")

**---------------------------------------------*

**--------summtab for health literacy ---------*
	
summtab, by(study_site) catvars(m1_509a m1_509b m1_510a m1_510b m1_511 m1_512) total catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(HealthLit) 

**---------------------------------------------*

**--------summtab for health profile  ---------*

* generate PHQ9 variable 
		gen phq9 = phq9a + phq9b + phq9c + phq9d + phq9e + phq9f + phq9f + phq9g + phq9h + phq9i 
		
		tab phq9
		
		
		recode phq9 (0 1 2 3 4 = 1) (5 6 7 8 9 = 2) (10 11 12 13 14 = 3) (15 16 17 18 19 = 4) (20 21 22 23 24 25 26 27 = 5)
		* define labels for phq9 
		label define phq9 1 "none-minimal" 2 "mild" 3 "moderate" 4 "moderately severe" 5 "severe" 6 "error"
		label values phq9 phq9
		tab phq9
	

* summtab by site 

summtab2, by (study_site) vars (m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_203 m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9 m1_207) type (2 2 2 2 2 2 2 2 2 2 2 2 2 2 1) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(HealthProfile) 

**---------------------------------------------*

**--------summtab for health system ratings  ---------*
	
summtab, catvars(q301qualrate q302overallview q303confidentcare q304confidentafford q305confidentresp q305confidenttellprov) catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(HSConf) directory("$user/$data")

* summtab by site 

summtab, by (study_site) catvars(m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b) catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(HSConf) 


**----------------------------------------------------*

**--------  summtab for care pathways ---------*
	
summtab2, vars (q401travel m1_401a_ke m1_401b_ke m1_401c_ke m1_401d_ke m1_401e_ke q402time q403distance q404nearest q405reason) type (2 2 2 2 2 2 1 1 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(CarePath) directory("$user/$data") title("Ethiopia MNH ECohort Care Pathways")

* summtab by site 

summtab2, by(study_site) vars (m1_401a_ke m1_401b_ke m1_401c_ke m1_401d_ke m1_401e_ke m1_401_96_ke m1_401_998_ke m1_401_999_ke m1_402 m1_403b m1_404 m1_405) type (2 2 2 2 2 2 2 2 1 1 2 2) mean median range total replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(CarePath) 

**---------------------------------------------*

**--------  summtab for user experience ---------*
	
summtab2, vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace excel excelname(KE_ECohort_summtab) sheetname(UserExp) directory("$user/$data")

* summtab by site 

summtab2, by(study_site) vars (m1_603 m1_604 m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f m1_605g m1_605h m1_602 m1_1223) type (1 1 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(UserExp) 

* again, interesting to see summtab by facility type if applicable in KE 

**-----------------------------------------------*

**--------  summtab for content of care: investigations  ---------*
	
summtab, catvars(m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_710a m1_711a m1_712) replace excel excelname(KE_ECohort_summtab) sheetname(Invest) 

* summtab by site 

summtab, by(study_site) catvars(m1_700 m1_701 m1_702 m1_703 m1_704 m1_705 m1_706 m1_707 m1_708a m1_710a m1_711a m1_712) replace excel excelname(KE_ECohort_summtab) sheetname(Invest) replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(Invest) 

**---------------------------------------------------------------*

**--------  summtab for content of care: test results  ---------*
	

* summtab by site 

summtab, by(study_site) catvars(m1_708a m1_708b m1_710a m1_710b m1_711a m1_711b) catmisstype(missnoperc) total replace excel excelname(KE_ECohort_summtab) sheetname(TestResult)


**--------------------------------------------------------------*

**--------  summtab for content of care: STI care  ---------*
	
* summtab by site 

summtab, by(study_site) catvars(m1_708a m1_708b m1_708c m1_708d m1_708e m1_708f m1_709a m1_709b m1_710a m1_710b m1_710c) replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(STIcare) 

**----------------------------------------------------------*

**--------  summtab for content of care: medicines  ---------*
	
* summtab by site 

summtab, by(study_site) catvars(m1_713a m1_713b m1_713c m1_713d m1_713e m1_713f m1_713g m1_713h m1_713i m1_713j_ke m1_713k m1_713l m1_714a m1_714b m1_715) replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(Meds) 

**------------------------------------------------------------*	

**--------  summtab for content of care: counseling  ---------*
	
* summtab by site 

summtab, by(study_site) catvars(m1_716a m1_716b m1_716c m1_716d m1_716e ) catmisstype(missnoperc) total replace excel excelname(KE_ECohort_summtab) sheetname(Counsel) 

**-------------------------------------------------------------*	

**--------  summtab for content of care: instructions  ---------*
	

* summtab by site 

summtab2, by(study_site) vars (m1_724a m1_724b m1_724c m1_724d m1_724e) type (2 1 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(AdvCare) 

**--------------------------------------------------------------*		

**--------  summtab for gestational age / pregnancy info  ---------*

* summtab by site 

summtab2, by(study_site) vars (m1_803 gest_age_baseline_ke m1_801 m1_804 m1_805 m1_806 m1_807 m1_809 m1_810a m1_812a m1_812b_0_ke m1_812b_1 m1_812b_2 m1_812b_3 m1_812b_4 m1_812b_5 m1_812b_96 m1_812b_98 m1_812b_99 m1_812b_other m1_813a m1_813b m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g m1_814h) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(GA_preg info)

* summtab by facility type when we can get it 



**-----------------------------------------------------------------*	

**--------- summtab for obstetric history ---------*

summtab2, by(study_site) vars (m1_1001 m1_1002 m1_1004 m1_1005 m1_1006 m1_1007 m1_1008 m1_1009 m1_1010) type(2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(obs history)

**-------------------------------------------------*
	
**--------  summtab for risky health behaviors  ---------*
	
* summtab by site 

summtab2, by(study_site) vars(m1_901 m1_902 m1_903 m1_904 m1_905 m1_906 m1_907) type (2 2 2 2 2 1 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(riskybeh) 

**-------------------------------------------------------*

**--------  summtab for experience of violence  ---------*
	
summtab, catvars(q1101physabuse phys_abuse q1103verbabuse verb_abuse) replace excel excelname(KE_ECohort_summtab) sheetname(violence) directory("$user/$data")
	
**-------------------------------------------------------* 

**--------  summtab for economic status  ---------*
	
summtab, by(study_site) catvars(m1_1201 m1_1201 m1_1202 m1_1203 m1_1204 m1_1205 m1_1206 m1_1207 m1_1208 m1_1209 m1_1210 m1_1211 m1_1212 m1_1213 m1_1214 m1_1215) replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(econstat) 
	
**------------------------------------------------*

**--------  summtab for economic outcomes & insurance  ---------*
	
summtab2, by(study_site) vars (m1_1217 m1_1218_ke m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218_total_ke m1_1219 m1_1220 m1_1221 m1_1222) type (2 1 1 1 1 1 1 1 1 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(KE_ECohort_summtab) sheetname(oop_ins) 

**---------------------------------------------------------------*

**--------  summtab for physical assessments  ---------*

* generate new height variable for use in BMI 

generate height_m = height_cm if height_cm < 2
replace height_m = height_cm/100 if height_m==.
generate height = height_m^2

drop height_m 

generate bmi = weight_kg/height
replace bmi = round(bmi, .1)

summarize bmi

tab bmi

list study_id height_cm weight_kg bmi

* https://jphysiolanthropol.biomedcentral.com/articles/10.1186/s40101-019-0205-2 
* https://www.who.int/news-room/fact-sheets/detail/obesity-and-overweight 


generate bmiclass = 1 if bmi <18.5 
replace bmiclass = 2 if bmi >= 18.5 & bmi <= 24.9 
replace bmiclass = 3 if bmi >= 25.0 & bmi < 35
replace bmiclass = 4 if bmi >= 35

label define bmiclass 1 "underweight" 2 "normal" 3 "overweight/obese" 4 "error"
label values bmiclass bmiclass 

tab bmiclass

egen SBP = rmean(bp_time_1_systolic bp_time_2_systolic bp_time_3_systolic)
replace SBP = round(SBP)

egen DBP = rmean(bp_time_1_diastolic bp_time_2_diastolic bp_time_3_diastolic)
replace DBP = round(DBP)

label define bpclass 1 "normal" 2 "prehypertension" 3 "stage 1 hypertension" 4 "stage 2 hypertension" 

/// https://www.ncbi.nlm.nih.gov/books/NBK9633/table/A32/ 
label values 

generate bpclass = 1 if SBP < 120 & DBP < 80
replace bpclass = 2 if SBP >= 120 & SBP < 140 | DBP >= 80 & DBP < 90
replace bpclass = 3 if SBP >= 140 & SBP < 160 | DBP >= 90 & DBP < 100
replace bpclass = 4 if SBP >=160 | DBP >=100

label values bpclass bpclass

tab bpclass

destring q1307hgbcard, replace  
generate hgb = q1307hgbcard
replace hgb = q1309hgbtest if hgb==.
tab hgb, missing

*  https://www.merckmanuals.com/professional/gynecology-and-obstetrics/pregnancy-complicated-by-disease/anemia-in-pregnancy#:~:text=The%20following%20hemoglobin%20(Hb)%20and,%2FdL%3B%20Hct%20%3C%2033%25 

label values q1306hgbcard YN

generate hgbclass = 0 if hgb !=. 
replace hgbclass = 1 if hgb < 11 & q804trimester==1 
replace hgbclass = 1 if hgb < 10.5 & q804trimester==2
replace hgbclass = 1 if hgb < 11 & q804trimester==3

list study_id q804trimester hgb hgbclass

label define hgbclass 1 "anemia" 0 "no anemia" 
label values hgbclass hgbclass

tab hgbclass, mis 


	
summtab2, by(site) vars (height_cm weight_kg bmi bmiclass SBP DBP bpclass q1306hgbcard hgb hgbclass) type (1 1 1 2 1 1 2 2 1 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(physass) directory("$user/$data")

**-----------------------------------------------------*

save "$data/ET_06142023.dta", replace 


save "/Users/katewright/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/1 Ethiopia/Interim data/Data/ET_06222023.dta
