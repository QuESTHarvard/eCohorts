* South Africa ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Created: September 21, 2023


* u "$za_data_final/eco_m1_za_der.dta", clear
	u  "$za_data_final/eco_m1-m3_za_der.dta", clear
* Demographics
	rename study_site_sd site
	recode enrollage 1/19=1 20/35=2 36/49=3, g(agecat)
	ta agecat site, col nofreq
	recode educ_cat 1=2, g(educ3)
	ta educ3 site, col nofreq
	table site, stat(mean ga)
	g unemployed= m1_506==10
	ta unemployed site, col nofreq
	ta trimester site, col nofreq
	
* HIV
	egen new_hiv=anymatch(m1_708b m1_708b_2_za), values(1) // new HIV+ test at ANC1
	egen phiv=rowmax(m1_202e m1_202e_2_za) // previous dx of HIV
	egen hiv=rowmax(new_hiv phiv)
	
	ta hiv site, nofreq col
* QUALITY OF ANC1
	* By site
			tabstat anc1tq, by(site) stat(mean sd count)
			ttest anc1tq , by(site)
			tabstat anc1counsel, by(site) stat(mean sd count)
			ttest anc1counsel , by(site)
	* By education level 
			tabstat anc1tq, by(educ_cat) stat(mean sd count)
			tabstat anc1counsel, by(educ_cat) stat(mean sd count)
	* By health literacy level
			g hlit = health_lit==4
			tabstat anc1tq, by(hlit) stat(mean sd count)
			tabstat anc1counsel, by(hlit) stat(mean sd count)
	* By employment
			tabstat anc1tq, by(unemployed) stat(mean sd count)
			tabstat anc1counsel, by(unemployed) stat(mean sd count)
	* Items done the least
			tabstat anc1bp anc1muac anc1bmi anc1fetal_hr anc1urine anc1blood ///
				    anc1ifa anc1depression anc1tt counsel_nutri counsel_exer ///
					counsel_complic counsel_comeback counsel_birthplan, ///
					stat(mean count) col(stat)
					
			ta  anc1ultrasound if trimester==3
					
			ta m1_801 // given a due date
			ta risk_health
			ta stop_risk
			ta m1_1105 if physical_verbal==1
			
* GENERAL RISK FACTORS
	gen aged18 = enrollage<18
	gen aged35 = enrollage>35
	egen DM=rowmax(m1_202a m1_202a_2_za  )
	egen HTN=rowmax(m1_202b m1_202b_2_za)
	egen cardiac=rowmax(m1_202c m1_202c_2_za)
	egen MH=rowmax(m1_202d m1_202d_2_za)
	

	egen chronic = rowmax(DM HTN cardiac MH hiv other_major_hp )
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
			
* COMPETENT SYSTEMS: RISK FACTORS 
			tabstat anc1tq, by(anyrisk) stat(mean sd count)
			tabstat anc1counsel, by(anyrisk) stat(mean sd count)
			ttest anc1tq, by(anyrisk)
			ttest anc1counsel, by(anyrisk)
			
			tabstat m1_603, by(anyrisk) stat(mean sd count)
			ttest m1_603, by(anyrisk)
			tabstat anc1ultrasound, by(anyrisk) stat(mean sd count)
			
* REFERRAL CARE
			ta specialist_hosp
			ta specialist_hosp anyrisk, col chi2
			ta specialist_hosp danger, col chi2
			
* ECONOMIC OUTCOMES
			ta m1_1217 // any $ spent
			su m1_1218g
			su registration
			su med
			su lab
			su indirect	
* CONFIDENCE
			ta m1_302
			
*COMPETENT SYSTEMS: DANGER SIGNS
			tabstat anc1tq, by(dangersign) stat(mean sd count)
			ttest anc1tq, by(dangersign)
			tabstat anc1counsel, by(dangersign) stat(mean sd count)
			ttest anc1counsel, by(dangersign)
			tabstat m1_603, by(dangersign) stat(mean sd count)
			ttest m1_603, by(dangersign)
			tabstat anc1ultrasound, by(dangersign) stat(mean sd count)
			ta anc1ultrasound dangersign, col chi2
* CASCADES
	* Anemia
			ta anemic // 95
			ta anc1blood if anemic==1
			ta anc1ifa if anemic==1
	/* Malnutrition
	egen screen_mal = rowmax(anc1muac anc1bmi)
			ta low_BMI // 55
			ta screen_mal if low_BMI==1
			ta counsel_nutri if low_BMI==1
			ta anc1food if low_BMI==1	*/
	
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	egen depression_tx=rowmax(m1_724d anc1mental_health_drug)
			ta depression // 370
			ta m1_716c if depression==1 // discussed anxiety or depression		
			ta depression_tx if depression==1
			
	*Prior chronic conditions
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp )
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)
			tab1 DM HTN cardiac MH
			egen complic4=rowmax(DM HTN cardiac MH)
			ta m1_718 if DM==1
			ta m1_719 if HTN==1
			ta m1_720 if cardiac==1
			ta m1_721 if MH==1
			*ta m1_722 if hiv==1
			
			ta diabetes_tx if DM==1
			ta hypertension_tx if HTN==1
			ta specialist_hosp if cardiac==1
			ta depression_tx if MH==1

	* Prior obstetric complications
	egen complic5=rowmax(m1_1004 stillbirth preterm neodeat csect)
			ta m1_1004 // nb late miscarriages
			ta m1_1011b if m1_1004==1
			ta specialist_hosp if m1_1004==1
			
			ta stillbirth 
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

* HIV CASCADE
			ta hiv // new or previous hiv dx
			*ta m1_722 if hiv==1 // discussed HIV
			egen viralload=rowmax(m1_709a m1_709a_2_za m1_708e m1_708e_2_za)
			ta viralload if hiv 
			egen cd4=rowmax(m1_709b m1_709b_2_za m1_708f m1_708f_2_za)
			ta cd4 if hiv
			egen med_hiv= rowmax(m1_204b_za m1_204 m1_204_2_za m1_708c m1_708c_2_za )
			ta med_hiv if hiv
			
			
* USER EXPERIENCE
			ta vgm1_601
			tabstat anc1ux, by(site) stat(mean sd count)
			ttest anc1ux, by(site)
			tabstat anc1ux, by(educ_cat) stat(mean sd count)
			tabstat vgm1_605a vgm1_605b vgm1_605c vgm1_605d vgm1_605e vgm1_605f ///
			vgm1_605g vgm1_605h  , stat(mean count) col(stat)



