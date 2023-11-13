* Ethiopia ECohort M1 data analysis 
* The following code generates a megatable for all data included in the baseline module 
* Created by K. Wright, C. Arsenault, and S. Sabwa 
* Edit by Luis Garcia

*------------------------------------------------------------------------------*

* Importing clean ET dataset that was created in "crEco_cln_ET.do"

import u "$et_data_final/eco_m1m2_et.dta", clear
drop m2_iic-m2_complete

**---------summtab for enrollment data----------* 

summtab, by(site) catvars(sampstrata) total catmisstype(missnoperc) excel excelname(ET_ECohort_summtab) sheetname(Enrollment) directory("$user/$data")

**----------------------------------------------* 

**--------summtab for demographic data---------*
	
*summtab, catvars(q501language q502school q503level q504literate q505marriage q506occupation q507religion) pmiss excel excelname(ET_ECohort_summtab) sheetname(Demographics) directory("$user/$data")

summtab, by(site) catvars(q501language q502school q503level q504literate q505marriage q506occupation q507religion) catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(Demographics) directory("$user/$data") title("Ethiopia MNH ECohort Demographic Variables")

**---------------------------------------------*

**--------summtab for health literacy ---------*
	
*summtab, catvars(q509hiv q509hivtrans q510tb q510tbtrad q511diarrhea q512woodburn) excel excelname(ET_ECohort_summtab) sheetname(HealthLit) directory("$user/$data")

summtab, by(site) catvars(q509hiv q509hivtrans q510tb q510tbtrad q511diarrhea q512woodburn) total catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(HealthLit) directory("$user/$data")

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
	
summtab, catvars(q201srhealth q202diabetes q202hbp q202cardiac q202mental q202hiv q202hepb q202renal q203diagnosis q204meds q205mobility q205selfcare q205activities q205pain q205anxiety phq9 q207productive)catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(HealthProfile) directory("$user/$data")

* summtab by site 

summtab, by (site) catvars(q201srhealth q202diabetes q202hbp q202cardiac q202mental q202hiv q202hepb q202renal q203diagnosis q204meds q205mobility q205selfcare q205activities q205pain q205anxiety phq9 q207productive) catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(HealthProfile) directory("$user/$data")

* summtab by facility type 

preserve 
keep if site == 1 

summtab, by (fac_type) catvars(q201srhealth q202diabetes q202hbp q202cardiac q202mental q202hiv q202hepb q202renal q203diagnosis q204meds q205mobility q205selfcare q205activities q205pain q205anxiety phq9 q207productive) catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(HealthProfile_Adama) directory("$user/$data")

restore

preserve 
keep if site == 2 

summtab, by (fac_type) catvars(q201srhealth q202diabetes q202hbp q202cardiac q202mental q202hiv q202hepb q202renal q203diagnosis q204meds q205mobility q205selfcare q205activities q205pain q205anxiety phq9 q207productive) catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(HealthProfile_EastShewa) directory("$user/$data")

restore

**---------------------------------------------*

**--------summtab for health system ratings  ---------*
	
summtab, catvars(q301qualrate q302overallview q303confidentcare q304confidentafford q305confidentresp q305confidenttellprov) catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(HSConf) directory("$user/$data")

* summtab by site 

summtab, by (site) catvars(q301qualrate q302overallview q303confidentcare q304confidentafford q305confidentresp q305confidenttellprov) catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(HSConf) directory("$user/$data")


**----------------------------------------------------*

**--------  summtab for care pathways ---------*

replace q402time = "." in 349
destring q402time, replace
	
summtab, contvars (q402time q403distance) catvars(q401travel q404nearest) mean median range excel excelname(ET_ECohort_summtab) sheetname(CarePath) directory("$user/$data")

summtab2, vars (q401travel q402time q403distance q404nearest q405reason) type (2 1 1 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(CarePath) directory("$user/$data") title("Ethiopia MNH ECohort Care Pathways")

* summtab by site 

summtab2, by(site) vars (q401travel q402time q403distance q404nearest q405reason) type (2 1 1 2 2) mean median range total replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(CarePath) directory("$user/$data") title("Ethiopia MNH ECohort Care Pathways")

**---------------------------------------------*

**--------  summtab for user experience ---------*
	
summtab2, vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace excel excelname(ET_ECohort_summtab) sheetname(UserExp) directory("$user/$data")

* summtab by site 

summtab2, by(site) vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(UserExp) directory("$user/$data")

* summtab by facility type 

generate fac_type = sampstrata
recode fac_type (1 = 1) (2 = 2) (3 4 = 3)
label define pubpriv 1 "Public Primary" 2 "Public Secondary" 3 "Private"
label values fac_type pubpriv


summtab2, by(fac_type) vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(UserExp_FacilityType) directory("$user/$data")

summtab2, by(site fac_type) vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(UserExp_FacilityType_site) directory("$user/$data")

summtab2, by(fac_type) [if site==1] vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(UserExp_FacilityType_Adama) directory("$user/$data")

preserve 
keep if site == 1 

summtab2, by(fac_type) vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(UserExp_FacilityType_Adama) directory("$user/$data")

restore 

preserve 
keep if site == 2 

summtab2, by(fac_type) vars (q603visitlength q604waittime q601qoc q605skills q605equip q605time q605wait q605cost q605confidentiality q605privacy q605involved q605clarity q605respect q605courtesy q602nps q1223satisfaction) type (1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(UserExp_FacilityType_EastShewa) directory("$user/$data")

restore 

**-----------------------------------------------*

**--------  summtab for content of care: investigations  ---------*
	
summtab, catvars(q700bp q701weight q702height q703muac q704babyrate q705urine q706blooddrop q706blooddraw q708hiv q710syphilis q711bloodsugar q712ultrasound) replace excel excelname(ET_ECohort_summtab) sheetname(Invest) directory("$user/$data")

* summtab by site 

summtab, by(site) catvars(q700bp q701weight q702height q703muac q704babyrate q705urine q706blooddrop q706blooddraw q708hiv q710syphilis q711bloodsugar q712ultrasound) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(Invest) directory("$user/$data")

* summtab by facility type 

preserve 
keep if site == 1 

summtab, by(fac_type) catvars(q700bp q701weight q702height q703muac q704babyrate q705urine q706blooddrop q706blooddraw q708hiv q710syphilis q711bloodsugar q712ultrasound) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_30June2023) sheetname(Invest_FacilityType_Adama) directory("$user/$data")

restore 

preserve 
keep if site == 2 

summtab, by(fac_type) catvars(q700bp q701weight q702height q703muac q704babyrate q705urine q706blooddrop q706blooddraw q708hiv q710syphilis q711bloodsugar q712ultrasound) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_30June2023) sheetname(Invest_FacilityType_EastShewa) directory("$user/$data")

restore 


**---------------------------------------------------------------*

**--------  summtab for content of care: test results  ---------*
	
summtab, catvars(q708hiv q708hivresult q710syphilis q710syphilisresult q711bloodsugar q711bloodsugarresult) replace excel excelname(ET_ECohort_summtab) sheetname(TestResult) directory("$user/$data")

* summtab by site 

summtab, by(site) catvars(q708hiv q708hivresult q710syphilis q710syphilisresult q711bloodsugar q711bloodsugarresult) catmisstype(missnoperc) total replace excel excelname(ET_ECohort_summtab) sheetname(TestResult) directory("$user/$data")


**--------------------------------------------------------------*

**--------  summtab for content of care: STI care  ---------*
	
summtab, catvars(q708hiv q708hivresult q708hivmed q708hivmedex q708hivload q708hivcd4 q709hivload q709hivdc4 q710syphilis q710syphilisresult q710syphilismed) replace excel excelname(ET_ECohort_summtab) sheetname(STIcare) directory("$user/$data")

* summtab by site 

summtab, by(site) catvars(q708hiv q708hivresult q708hivmed q708hivmedex q708hivload q708hivcd4 q709hivload q709hivdc4 q710syphilis q710syphilisresult q710syphilismed) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(STIcare) directory("$user/$data")

**----------------------------------------------------------*

**--------  summtab for content of care: medicines  ---------*
	
summtab, catvars(q713fefa q713capill q713foodsupp q713intworm q713malaria q713nerves q713multivit q713hypertension q713diabetes q714tt q714ttbefore q715itn) replace excel excelname(ET_ECohort_summtab) sheetname(Meds) directory("$user/$data")

* summtab by site 

summtab, by(site) catvars(q713fefa q713capill q713foodsupp q713intworm q713malaria q713nerves q713multivit q713hypertension q713diabetes q714tt q714ttbefore q715itn) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(Meds) directory("$user/$data")

**------------------------------------------------------------*	

**--------  summtab for content of care: counseling  ---------*
	
summtab, catvars(q716nutrition q716exercise q716mental q716itn q716complication) replace excel excelname(ET_ECohort_summtab) sheetname(Counsel) directory("$user/$data")

* summtab by site 

summtab, by(site) catvars(q716nutrition q716exercise q716mental q716itn q716complication) catmisstype(missnoperc) total replace excel excelname(ET_ECohort_summtab) sheetname(Counsel) directory("$user/$data")

**-------------------------------------------------------------*	

**--------  summtab for content of care: instructions  ---------*
	
summtab2, vars (q724return q724returnwhen q724gynecologist q724mentalhealth q724hospital) type (2 1 2 2 2) mean median range replace excel excelname(ET_ECohort_summtab) sheetname(AdvCare) directory("$user/$data")

* summtab by site 

summtab2, by(site) vars (q724return q724returnwhen q724gynecologist q724mentalhealth q724hospital) type (2 1 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(AdvCare) directory("$user/$data")

**--------------------------------------------------------------*		

**--------  summtab for gestational age / pregnancy info  ---------*

destring q803gaself, replace
	
	tab q803gaself

	gen ga = trunc(q802gacalc)
	replace ga = q803gaself if ga==.
	tab ga
	
	summarize ga
	
	codebook q803gaself
	codebook ga
	codebook ga
	
	destring q803gaself, replace 
	
	** then we want to replace missing values with the self reported GA 
	replace ga = q803gaself if ga==.
	tab ga, missing 
	
	summarize ga
	
summtab2, vars (q801edd ga q804trimester q805numbbabies q806asklmp q807desired q809birthplan q810planbirthloc q811mwh q812toldcs q1001pregnancies q1002births q1003livebirths  q1004stillbirth q1005preterm q1006bloodtrans q10et1congenital  q1007cs q1008longlabor  q813neausea q813heartburn q813cramp q813backpain q814headache q814bleeding q814fever q814abpain q814breathing q814convulsions q814fainting q814babynotmoving q814blurvision) type (2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(GA_obshis) directory("$user/$data")

* summtab by site 

summtab2, by(site) vars (q801edd ga q804trimester q805numbbabies q806asklmp q807desired q809birthplan q810planbirthloc q811mwh q812toldcs q1001pregnancies q1002births q1003livebirths  q1004stillbirth q1005preterm q1006bloodtrans q10et1congenital  q1007cs q1008longlabor  q813neausea q813heartburn q813cramp q813backpain q814headache q814bleeding q814fever q814abpain q814breathing q814convulsions q814fainting q814babynotmoving q814blurvision) type (2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(GA_obshis) directory("$user/$data")

summtab2, by(fac_type) vars (q801edd ga q804trimester q805numbbabies q806asklmp q807desired q809birthplan q810planbirthloc q811mwh q812toldcs q1001pregnancies q1002births q1003livebirths  q1004stillbirth q1005preterm q1006bloodtrans q10et1congenital  q1007cs q1008longlabor  q813neausea q813heartburn q813cramp q813backpain q814headache q814bleeding q814fever q814abpain q814breathing q814convulsions q814fainting q814babynotmoving q814blurvision) type (2 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab_22June2023) sheetname(GA_obshis_Facility_Type) directory("$user/$data")

**-----------------------------------------------------------------*		
	
**--------  summtab for risky health behaviors  ---------*
	
summtab, catvars(q901smoke q902stopsmoke q903khat q904stopkhat q905alcohol q907stopalcohol) replace excel excelname(ET_ECohort_summtab) sheetname(riskybeh) directory("$user/$data")

* summtab by site 

summtab, by(site) catvars(q901smoke q902stopsmoke q903khat q904stopkhat q905alcohol q907stopalcohol) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(riskybeh) directory("$user/$data")

**-------------------------------------------------------*

**--------  summtab for experience of violence  ---------*
	
summtab, catvars(q1101physabuse phys_abuse q1103verbabuse verb_abuse) replace excel excelname(ET_ECohort_summtab) sheetname(violence) directory("$user/$data")
	
**-------------------------------------------------------* 

**--------  summtab for economic status  ---------*
	
summtab, by(site) catvars(q1201water q1202toilet q1203electricity q1204radio q1205tv q1206telephone q1207fridge q1208cookfuel q1209floor q1210walls q1211roof q1212bicycle q1213motocycle q1214car q1215bankacct) replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(econstat) directory("$user/$data")
	
**------------------------------------------------*

**--------  summtab for economic outcomes & insurance  ---------*
	
summtab2, by(site) vars (q1221insurance q1221insurancetype q1217oop q1219total) type (2 2 2 1) mean median range replace catmisstype(missnoperc) total excel excelname(ET_ECohort_summtab) sheetname(oop_ins) directory("$user/$data")

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
