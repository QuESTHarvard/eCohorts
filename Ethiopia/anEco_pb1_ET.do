* Ethiopia ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Updated: July 27 2023


u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et_der.dta", clear

* This should be removed after Shalom addresses it
drop in 1/72 // drop the test records
keep if  b7eligible ==1 // drop the non eligible.. this is also droping the other modules currently.

* Keep M1 only
drop redcap_repeat_instrument-redcap_data_access_group m2_attempt_date-m2_complete 

* COMPETENT CARE ANC1
	* By facility type
			tabstat anc1tq, by(facility_lvl) stat(mean sd count)
			tabstat anc1counsel, by(facility_lvl) stat(mean sd count)
	
* GENERAL RISK FACTORS
	gen aged18 = age<18
	gen aged35 = age>35
	recode m1_203 (2=0)
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g m1_203)
	egen general_risk = rowmax(aged18 aged35 chronic HBP anemic)
	
* OBSTETRIC RISK FACTORS
	gen multi= m1_805>1 & m1_805<.
	gen sb = m1_1003-m1_1002 // live births - deliveries
	recode sb (-5/-1=1) (0/.=0)
	gen neodeath = m1_1010 ==1
	gen preterm = m1_1005 ==1
	gen PPH=m1_1006==1
	gen csect = m1_1007==1
	
	egen obst_risk = rowmax(multi sb neodeath preterm PPH csect)
	egen anyrisk = rowmax (general_risk obst_risk)
	
			tab1 general_risk obst_risk anyrisk
	
* COMPETENT SYSTEMS
	* Care quality by level of risk
	egen specialist_hosp= rowmax(m1_724e m1_724c)
			ta specialist_hosp anyrisk, chi2 col
			ttest anc1tq, by(anyrisk)
			ttest anc1counsel, by(anyrisk)
	
	* CASCADES: CONDITIONS IDENTIFIED BY E-COHORT
	* Malnutrition
	egen screen_mal = rowmax(anc1muac anc1bmi)
			ta malnutrition // 218
			ta screen_mal if malnut==1
			ta counsel_nutri if malnut==1
			ta anc1food if malnut==1
	*Depression	
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	egen depression_tx=rowmax(m1_724d anc1mental_health_drug)
			ta depression
			ta m1_716c if depression==1 // discussed anxiety or depression		
			ta depression_tx if depression==1
	* Anemia
			ta anemic // 19
			ta anc1blood if anemic==1
			ta anc1ifa if anemic==1
	* Hypertension
	egen exer_nutri=rowmax(counsel_nutri counsel_exer)
			ta HBP	
			ta anc1bp if HBP==1
			ta exer_nutri if HBP==1
			ta anc1hypertension if HBP==1 // missing for all but 1. incorrect programming in RedCAP
			ta specialist_hosp if HBP==1
			
			ta m1_202b // previously diagnosed with HBP
			ta anc1bp if m1_202b==1
			ta m1_719 if m1_202b==1
			ta anc1hypertension if m1_202b==1
			
	*CASCADES: CONDITIONS SELF REPORTED
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp )
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)
			tab1 m1_202a m1_202b m1_202c m1_202d m1_202e
			ta m1_718 if m1_202a==1
			ta m1_719 if m1_202b==1
			ta m1_720 if m1_202c==1
			ta m1_721 if m1_202d==1
			ta m1_722 if m1_202e==1
			ta diabetes_tx if m1_202a==1
			ta hypertension_tx if m1_202b==1
			ta specialist_hosp if m1_202c==1
			ta depression_tx if m1_202d==1
	
	
	lab var aged18 "Aged less than 19"
	lab var aged40 "Aged more than 40"
	lab var chronic "Has a chronic illness"
	lab var multi "Multiple pregnancy (twins, triplets, etc.)"
	lab var sb "Had a previous stillbirth"
	lab var neodeath "Had a previous neonatal death"
	lab var preterm "Had a previous baby born early (more than 3wks before due date)"
	lab var PPH "Had a previous hemorrage at pregnancy or delivery"
	lab var general_risk "Has any of the general risk factors"
	lab var obst_risk = "Has any obstetric risk factors"
	lab var anyrisk = "Has any general or obstetric risk factors"
	lab var specialist_hosp = "Told to go see a specialist or to go to hospital for ANC"
	lab var exer_nutri "Counselled on both nutrition and exercise at ANC1"
	
	
	/*
	egen dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g)
	lab var dangersigns "Experienced a danger sign so far in pregnancy"

