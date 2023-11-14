* Kenya ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Created: September 19, 2023



u "$ke_data_final/eco_m1_ke_der.dta", clear


* SETTING AND DEMOGRAPHICS OF WOMEN ENROLLED
	* By site
	tab facility_lvl study_site, col
	mean enrollage, over(study_site)
	tab educ_cat study_site, col
	mean ga, over(study_site)
	tab m1_1001 study_site, col
	tab m1_501 study_site, col
	tab m1_1205 study_site, col

* QUALITY OF ANC1
	* By facility type
			tabstat anc1tq, by(facility_lvl) stat(mean sd count)
			tabstat anc1counsel, by(facility_lvl) stat(mean sd count)
	* By education level 
			tabstat anc1tq, by(educ_cat) stat(mean sd count)
			tabstat anc1counsel, by(educ_cat) stat(mean sd count)
	* By study site
			tabstat anc1tq, by(study_site) stat(mean sd count)
			tabstat anc1counsel, by(study_site) stat(mean sd count)
	* Items done the least
			tabstat anc1bp anc1muac anc1bmi anc1fetal_hr anc1urine anc1blood ///
				    anc1ultrasound anc1ifa anc1tt counsel_nutri counsel_exer ///
					counsel_complic counsel_comeback counsel_birthplan, ///
					stat(mean count) col(stat)	
			*ta anc1ultrasound if trimester==3
			ta risk_health
			ta stop_risk
			ta m1_1105 if physical_verbal==1
	*Other
			tab m1_801
			tab m1_901
			tab m1_904
			tab m1_905
			tab m1_907
			tab m1_1105
			
* GENERAL RISK FACTORS
	gen aged18 = enrollage<18
	gen aged35 = enrollage>35
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_203c_ke ///
		m1_203d_ke m1_203e_ke m1_203f_ke m1_203g_ke m1_203h_ke m1_203i_ke ///
		m1_203j_ke m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke)
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
				
* REFERRAL CARE
ta specialist_hosp if facility_lvl!=2 & facility!=4 & /// "Kalimoni mission hospital"
					 facility!= 11 & ///"Mercylite hospital"
					 facility!= 17 & ///"Our Lady of Lourdes Mutomo Hospital" 
					 facility!= 13 //"Muthale Mission Hospital"
			
ta specialist_hosp anyrisk if facility_lvl!=2 & facility!=4 & /// "Kalimoni mission hospital"
					 facility!= 11 & ///"Mercylite hospital"
					 facility!= 17 & ///"Our Lady of Lourdes Mutomo Hospital" 
					 facility!= 13, col chi2 //"Muthale Mission Hospital"
					 
ta specialist_hosp dangersign if facility_lvl!=2 & facility!=4 & /// "Kalimoni mission hospital"
					 facility!= 11 & ///"Mercylite hospital"
					 facility!= 17 & ///"Our Lady of Lourdes Mutomo Hospital" 
					 facility!= 13, col chi2 //"Muthale Mission Hospital"

* ECONOMIC OUTCOMES
	ta m1_1221
	ta m1_1222 
	ta m1_1217			 
					 
* COST OF 1st ANC VISIT
	sum m1_1218_total_ke

	egen totalcost= rowtotal(m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f_1)
	replace totalcost=. if totalcost==0
	
	sum totalcost
	
	replace registration = 0 if registration==.a & m1_1218_total_ke >0 & m1_1218_total_ke <.
	replace med = 0 if med ==.a & m1_1218_total_ke >0 & m1_1218_total_ke <.
	* even with: mean med if totalcost !=0 & (med !=0 | med <.), I'm still getting the same number
	replace lab = 0 if lab ==.a & m1_1218_total_ke >0 & m1_1218_total_ke <.
	replace indirect = 0 if indirect ==. & m1_1218_total_ke >0 & m1_1218_total_ke <.
	
	su registration if m1_1218_total_ke!=0
	su med if m1_1218_total_ke!=0
	su lab if m1_1218_total_ke!=0
	su indirect	if m1_1218_total_ke!=0

	
* CONFIDENCE
		ta m1_302

* COMPETENT SYSTEMS: RISK FACTORS 
			tabstat anc1tq, by(anyrisk) stat(mean sd count)
			tabstat anc1counsel, by(anyrisk) stat(mean sd count)
			tabstat m1_603, by(anyrisk) stat(mean sd count)
			tabstat anc1ultrasound, by(anyrisk) stat(mean sd count)		
		
*COMPETENT SYSTEMS: DANGER SIGNS
			tabstat anc1tq, by(dangersign) stat(mean sd count)
			tabstat anc1counsel, by(dangersign) stat(mean sd count)
			tabstat m1_603, by(dangersign) stat(mean sd count)
			tabstat anc1ultrasound, by(dangersign) stat(mean sd count)
			ta anc1ultrasound dangersign, col chi2

* CASCADES
	* Anemia
			ta anemic // 273
			ta anc1blood if anemic==1
			ta anc1ifa if anemic==1
			
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	egen depression_tx=rowmax(m1_724d anc1mental_health_drug)
			ta depression // 196
			ta m1_716c if depression==1 // discussed anxiety or depression		
			ta depression_tx if depression==1	
			
	*Prior chronic conditions
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp)
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)
			tab1 m1_202a m1_202b m1_202c m1_202d m1_202e
			*tab1 m1_203c_ke m1_203d_ke m1_203e_ke m1_203f_ke m1_203g_ke m1_203h_ke /// added additional KE only chronic conditions
				*m1_203i_ke m1_203j_ke m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke // 
				
			tab1 m1_718 if m1_202a==1 // discussed diabetes
			tab1 m1_719 if m1_202b==1 // disccused HTN
			tab1 m1_720 if m1_202c==1 // disccused cardiac problem
			tab1 m1_721 if m1_202d==1 // disccused mental health problem
			tab1 m1_722 if m1_202e==1 // discussed HIV
			
			tab1 diabetes_tx if m1_202a==1
			tab1 hypertension_tx if m1_202b==1
			tab1 specialist_hosp if m1_202c==1
			tab1 depression_tx if m1_202d==1

	* Prior obstetric complications (miscarriage, stillbirth, preterm, neonatal death, c-section)
			tab1 m1_1004 stillbirth preterm neodeath csect
			
			tab1 m1_1011b if m1_1004==1 //miscarriage
			tab1 m1_1011c if stillbirth==1
			tab1 m1_1011d if preterm==1
			tab1 m1_1011f if neodeath==1
			tab1 m1_1011e if csect==1
		
			tab1 specialist_hosp if m1_1004==1
			tab1 specialist_hosp if stillbirth==1
			tab1 specialist_hosp if preterm==1
			tab1 specialist_hosp if neodeath==1	
			tab1 specialist_hosp if csect==1
					
	* Malnutrition
	egen screen_mal = rowmax(anc1muac anc1bmi)
			ta low_BMI // 46
			ta screen_mal if low_BMI==1
			ta counsel_nutri if low_BMI==1
			ta anc1food if low_BMI==1	
					
* USER EXPERIENCE
			tabstat anc1ux, by(facility_lvl) stat(mean sd count)
			tabstat anc1ux, by(educ_cat) stat(mean sd count)
			tabstat vgm1_605a vgm1_605b vgm1_605c vgm1_605d vgm1_605e vgm1_605f ///
			vgm1_605g vgm1_605h  , stat(mean count) col(stat)


