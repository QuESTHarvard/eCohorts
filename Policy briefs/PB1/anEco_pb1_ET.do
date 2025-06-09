* Ethiopia ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Updated: July 27 2023


u "$et_data_final/eco_m1m2_et_der.dta", clear
			  
* Keep M1 only
keep if redcap_event_name  == "module_1_arm_1"
keep if b7eligible==1  & m1_complete==2 //SS: keeping this here only because we are not filtering out incomplete M1 surveys in the cleaning file


* SETTING AND DEMOGRAPHICS OF WOMEN ENROLLED
	* By site
	tab facility_lvl site, col
	mean enrollage, over(site)
	tab educ_cat site, col
	mean ga, over(site)
	tab m1_1001 site, col
	tab m1_501 site, col
	tab m1_1207 site, col
	
* QUALITY OF ANC1
	* By facility type
			tabstat anc1tq, by(facility_lvl) stat(mean sd count)
			tabstat anc1counsel, by(facility_lvl) stat(mean sd count)
			tabstat m1_603, by(facility_lvl) stat(mean sd count)
			ta vgm1_601 facility_lvl, col
			
	* By education level 
			tabstat anc1tq, by(educ_cat) stat(mean sd count)
			tabstat anc1counsel, by(educ_cat) stat(mean sd count)
			tabstat m1_603, by(educ_cat) stat(mean sd count)
			ta vgm1_601 educ_cat,  col
			ta anc1ultrasound educ_cat, col	
	* By site
			tabstat anc1tq, by(site) stat(mean sd count)
			tabstat anc1counsel, by(site) stat(mean sd count)
	* Items done most
			tabstat anc1bp anc1muac anc1bmi anc1fetal_hr anc1urine anc1blood ///
				    anc1ultrasound anc1ifa anc1tt counsel_nutri counsel_exer ///
					counsel_complic counsel_comeback counsel_birthplan, ///
					stat(mean count) col(stat)
			ta anc1ultrasound facility_lvl, col 
		
			
			
* GENERAL RISK FACTORS
	gen aged18 = enrollage<18
	gen aged35 = enrollage>35
	
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f_et m1_202g_et m1_203_et)
	egen general_risk = rowmax(aged18 aged35 chronic HBP anemic)
	
* OBSTETRIC RISK FACTORS
	gen multi= m1_805>1 & m1_805<.
	gen neodeath = m1_1010 ==1
	gen preterm = m1_1005 ==1
	gen PPH=m1_1006==1
	gen csect = m1_1007==1
	
	egen obst_risk = rowmax(multi stillbirth neodeath preterm PPH csect)
	egen anyrisk = rowmax (general_risk obst_risk)
	
			tab1 general_risk obst_risk anyrisk
			
* COMPETENT SYSTEMS
	* Care quality by level of risk
			ttest anc1tq, by(anyrisk)
			ttest anc1counsel, by(anyrisk)
			ttest m1_603, by(anyrisk)
			ta anc1ultrasound anyrisk, col
			ta specialist_hosp anyrisk, col chi2
			
	* Care quality by danger signs
			ttest anc1tq, by(danger)
			ttest anc1counsel, by(danger)
			ttest m1_603, by(danger)
			ta anc1ultrasound dangersigns, col chi2
			ta specialist_hosp danger, col chi2
			
* REFERRAL OF CARE:
	tab specialist_hosp
	ta specialist_hosp anyrisk

* COST OF 1st ANC VISIT
	ta m1_1217 // any $ spent
	egen totalcost= rowtotal(m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f_1)
	replace totalcost=. if totalcost==0
	
	su m1_1219
	replace registration_cost = 0 if registration_cost==.a & m1_1219>0 & m1_1219<.
	replace med_vax_cost= 0 if med_vax_cost==.a & m1_1219>0 & m1_1219<.
	replace labtest_cost= 0 if labtest_cost==.a & m1_1219>0 & m1_1219<.
	replace indirect_cost= 0 if indirect_cost==. & m1_1219>0 & m1_1219<.
			
	su m1_1219 if facility_lvl<3
	su m1_1219 if facility_lvl==3
	
	tabstat registration_cost med_vax_cost labtest_cost indirect_cost if facility_lvl<3, stat(mean) col(stat)
	tabstat registration_cost med_vax_cost labtest_cost indirect_cost if facility_lvl==3, stat(mean) col(stat)
* CONFIDENCE
		ta m1_302			
				
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
			ta depression // 247
			ta m1_716c if depression==1 // discussed anxiety or depression		
			ta depression_tx if depression==1
	* Anemia
			ta anemic // 100
			ta anc1blood if anemic==1
			ta anc1ifa if anemic==1
	
	/* Hypertension
	egen exer_nutri=rowmax(counsel_nutri counsel_exer)
			ta HBP	
			ta anc1bp if HBP==1
			ta exer_nutri if HBP==1
			ta anc1hypertension if HBP==1 // missing for all but 1. incorrect programming in RedCAP
			ta specialist_hosp if HBP==1 */
			
			
	*CASCADES: CHRONIC CONDITIONS SELF REPORTED (removing HIV because ETH did not collect info on HIV med)
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp )
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)	
			tab1 m1_202a m1_202b m1_202c m1_202d  m1_202e // 34 women with at least 1 condition
			ta m1_718 if m1_202a==1 // discussed diabetes
			ta m1_719 if m1_202b==1 // disccused HTN
			ta m1_720 if m1_202c==1 // disccused cardiac problem
			ta m1_721 if m1_202d==1 // disccused mental health problem
			ta m1_722 if m1_202e==1
			ta diabetes_tx if m1_202a==1
			ta hypertension_tx if m1_202b==1
			ta specialist_hosp if m1_202c==1
			ta depression_tx if m1_202d==1
			
	* CASCADES:OBSTETRIC RISK FACTORS
			ta m1_1004 // 51 late miscarriages
			ta m1_1011b if m1_1004==1
			ta specialist_hosp if m1_1004==1
			
			ta stillbirth // 37
			ta m1_1011c if stillbirth==1
			ta specialist_hosp if stillbirth==1
			
			ta preterm // previous preterm baby
			ta  m1_1011d if preterm==1
			ta specialist_hosp if preterm==1
			
			ta csect // previous c-section
			ta m1_1011e if csect==1
			ta specialist_hosp if csect==1
			
			ta  neodeath // previous neonatal death
			ta m1_1011f if neodeath==1
			ta specialist_hosp if neodeath==1
	
	* USER EXPERIENCE
	tabstat vgm1_605a vgm1_605b vgm1_605c vgm1_605d vgm1_605e vgm1_605f ///
			vgm1_605g vgm1_605h vgm1_605i vgm1_605j vgm1_605k , stat(mean count) col(stat)

	tabstat anc1ux, by(facility_lvl) stat(mean sd count)
	tabstat anc1ux, by(educ_cat) stat(mean sd count)
	
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
	
	lab var exer_nutri "Counselled on both nutrition and exercise at ANC1"
	
	
