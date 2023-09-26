* South Africa ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Created: September 21, 2023


u  "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data/eco_m1_za_der.dta", clear


* QUALITY OF ANC1
	* By facility type
			tabstat anc1tq, by(study_site_sd) stat(mean sd count)
			ttest anc1tq , by(study_site_sd)
			tabstat anc1counsel, by(study_site_sd) stat(mean sd count)
			ttest anc1counsel , by(study_site_sd)
	* By education level 
			tabstat anc1tq, by(educ_cat) stat(mean sd count)
			tabstat anc1counsel, by(educ_cat) stat(mean sd count)
	* Items done the least
			tabstat anc1bp anc1muac anc1bmi anc1fetal_hr anc1urine anc1blood ///
				    anc1ultrasound anc1ifa anc1tt counsel_nutri counsel_exer ///
					counsel_complic counsel_comeback counsel_birthplan, ///
					stat(mean count) col(stat)	
					
			ta m1_801 // given a due date
			ta risk_health
			ta stop_risk
			ta m1_1105 if physical_verbal==1
			
* GENERAL RISK FACTORS
	gen aged18 = enrollage<18
	gen aged35 = enrollage>35
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e other_major_hp )
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
			
* ECONOMIC OUTCOMES
			ta m1_1217 // any $ spent
			su m1_1218g_za
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
	* Malnutrition
	egen screen_mal = rowmax(anc1muac anc1bmi)
			ta low_BMI // 55
			ta screen_mal if low_BMI==1
			ta counsel_nutri if low_BMI==1
			ta anc1food if low_BMI==1	
	* Anemia
			ta anemic // 95
			ta anc1blood if anemic==1
			ta anc1ifa if anemic==1
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	egen depression_tx=rowmax(m1_724d anc1mental_health_drug)
			ta depression //198
			ta m1_716c if depression==1 // discussed anxiety or depression		
			ta depression_tx if depression==1
			
	*Prior chronic conditions
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

	* Prior obstetric complications
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
			ta m1_202e
			ta m1_722 if m1_202e==1
			ta m1_709a if m1_202e==1 
			ta m1_709b if m1_202e==1 
			ta anc1hiv if m1_202e==1 
			
* USER EXPERIENCE
			ta vgm1_601
			tabstat anc1ux, by(study_site_sd) stat(mean sd count)
			tabstat anc1ux, by(educ_cat) stat(mean sd count)
			tabstat vgm1_605a vgm1_605b vgm1_605c vgm1_605d vgm1_605e vgm1_605f ///
			vgm1_605g vgm1_605h  , stat(mean count) col(stat)



