* India ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault and Wen-Chien Yang 
* Update: April 25. 2024
* This is a test
clear all  
* Import Data 
u "$in_data_final/eco_m1_in_der.dta", clear

* SETTING AND DEMOGRAPHICS OF WOMEN ENROLLED
	tab residence
	
	* By residence
	mean enrollage, over(residence)
    recode enrollage 1/19=1 20/35=2 36/49=3, g(agecat)
	tab agecat residence, col
    tab primipara residence, col
	mean gest_age, over(residence)
	tab facility_lvl residence, col
	tab trimester residence, col	
	tab educ_cat residence, col
	tab tertile residence, col
	gen unemployed= m1_506==10
	tab unemployed residence, col
	recode m1_506 (1/5 = 1)(6 = 2)(7/9 = 1)(10 = 3)(96 = 1), gen (employ_cat)
	lab def employcat 1 "employed or student" 2 "homemaker or housewife" 3 "unemployed"
	lab value employ_cat employcat
 	tab employ_cat residence, col

* HIV
	gen phiv= m1_202e ==1      // m1_202e: previous dx of HIV	
    gen new_hiv = m1_708b ==1  // m1_708b: new HIV test positive at ANC1
	egen hiv=rowmax(new_hiv phiv)
	ta hiv residence, col
		
* QUALITY OF ANC1
	* By residence
			tabstat anc1tq, by(residence) stat(mean sd count)
			anova anc1tq residence
			tabstat anc1counsel, by(residence) stat(mean sd count)
			anova anc1counsel residence
	* By education level 
			tabstat anc1tq, by(educ_cat) stat(mean sd count)
			tabstat anc1counsel, by(educ_cat) stat(mean sd count)
	* By health literacy level
			gen hlit = m1_health_literacy==4
			tabstat anc1tq, by(hlit) stat(mean sd count)
			tabstat anc1counsel, by(hlit) stat(mean sd count)
	* By employment
			tabstat anc1tq, by(unemployed) stat(mean sd count)
			tabstat anc1counsel, by(unemployed) stat(mean sd count)
	* Items done the least
			tabstat anc1bp anc1weight anc1fetal_hr anc1blood anc1ultrasound anc1urine  ///
				    anc1ifa anc1tt anc1calcium anc1deworm ///  
					counsel_nutri counsel_complic counsel_comeback counsel_birthplan, ///
					stat(mean count) col(stat)
			tab anc1ultrasound if trimester==3
			tab m1_801 // m1_801: given a due date
			
			egen risk_health = rowmax(m1_901 m1_905) // m1_901: did you smoke? m1_905: did you drink? 
			egen stop_risk = rowmax(m1_902 m1_907)   // m1_902: did provider advice on stoping smoking, m1_907: did provider advice on stoping drinking?
			tab risk_health                    
			tab stop_risk
			
			egen physical_verbal_abuse = rowmax (m1_1101 m1_1103) // m1_1101: physical abuse, m1_1103: verbal abuse 
			tab m1_1105 if physical_verbal_abuse==1  // m1_1105: did provider discuss with you where you can seek support for physical/verbal abuse?
			
* GENERAL RISK FACTORS
	gen aged18 = enrollage<18
	gen aged35 = enrollage>35
	gen DM = m1_202a ==1 
	gen HTN = m1_202b ==1 
	gen cardiac = m1_202c ==1 
	gen MH = m1_202d ==1 
	gen oth_major_hp = m1_203 ==1 
	
	egen chronic = rowmax(DM HTN cardiac MH oth_major_hp)
	egen general_risk = rowmax(aged18 aged35 chronic HBP anemic)
	
* OBSTETRIC RISK FACTORS
	gen multi= m1_805>1 & m1_805<.  // m1_805: how many babies in this pregnancy 
	gen neodeath = m1_1010 ==1      // m1_1010: had a baby died within 1 month
	gen preterm = m1_1005 ==1       // m1_1005: baby came too early   
	gen PPH = m1_1006 ==1           // m1_1006: need blood transfusion  
	gen csect = m1_1007 ==1         // m1_1007: had csection 
	
	egen obst_risk = rowmax(multi stillbirth neodeath preterm PPH csect)
	egen anyrisk = rowmax(general_risk obst_risk)
	
			tab1 general_risk obst_risk anyrisk	
			
* COMPETENT SYSTEMS: RISK FACTORS 
			* create risk score 
			egen riskscore = rowtotal(aged18 aged35 DM HTN cardiac MH oth_major_hp HBP anemic multi stillbirth neodeath preterm PPH csect)
			mean riskscore
			tab riskscore // 42% of women had risk_score = 0 
		    tab anyrisk // 58% of women had any_risk = 1  		
			tabstat anc1tq, by(riskscore) stat(mean sd count)
			tabstat anc1ultrasound, by(riskscore) stat(mean sd count)
			tabstat anc1counsel, by(riskscore) stat(mean sd count)
			
			tabstat anc1tq, by(anyrisk) stat(mean sd count)
			tabstat anc1counsel, by(anyrisk) stat(mean sd count)
			ttest anc1tq, by(anyrisk)
			ttest anc1counsel, by(anyrisk)
			
			tabstat m1_603, by(anyrisk) stat(mean sd count)   // m1_603: how long the consultation is (min) 
			ttest m1_603, by(anyrisk)
			tabstat anc1ultrasound, by(anyrisk) stat(mean sd count)
			
* REFERRAL CARE
			tab specialist_hosp
			tab specialist_hosp anyrisk, col chi2
			tab specialist_hosp m1_dangersigns, col chi2
			
* ECONOMIC OUTCOMES
			tab m1_1217        // any $ spent
			su m1_totalcost_in // total cost
			mean m1_totalcost_in, over(residence) 
			mean m1_totalcost_in, over(facility_lvl) 
			mean m1_totalcost_in, over(residence facility_lvl) 
            
			gen registration = m1_1218a   // m1_1218a: spend on registration 
			gen med = m1_1218b            // m1_1218b: spend on medicines and vaccines 
			gen lab = m1_1218c            // m1_1218c: spend on lab and exams  
			egen indirect = rowtotal (m1_1218d m1_1218e)  // m1_1218d: spend on transport, m1_1218e: spend on food  
			su registration   
			su med           
			su lab           
			su indirect 
			
			mean registration // only 27 women in Sonipat spent money on registration 
			mean med // only 21 women in Sonipat spent money on med 
			mean registration, over(residence)   
			mean med, over(residence)            
			mean lab, over(residence)            
			mean indirect, over(residence)  
				
* CONFIDENCE
			tab m1_302 // m1_302: confidence
			
* COMPETENT SYSTEMS: DANGER SIGNS
			tabstat anc1tq, by(m1_dangersigns) stat(mean sd count)
			ttest anc1tq, by(m1_dangersigns)
			tabstat anc1counsel, by(m1_dangersigns) stat(mean sd count)
			ttest anc1counsel, by(m1_dangersigns)
			tabstat m1_603, by(m1_dangersigns) stat(mean sd count) // m1_603: how long the consultation is (min) 
			ttest m1_603, by(m1_dangersigns)
			tabstat anc1ultrasound, by(m1_dangersigns) stat(mean sd count)
			ta anc1ultrasound m1_dangersigns, col chi2
* CASCADES
	* Anemia
			*absolute number 
			tab anemic // 486 women are anemic
			tab anc1blood if anemic==1
			tab anc1ifa if anemic==1
			*percentage	
			tabstat anemic if anemic==1
			tabstat anc1blood if anemic==1
			tabstat anc1ifa if anemic==1			
			
	* Malnutrition
	egen screen_mal = rowmax(anc1muac anc1bmi)
			*absolute number 
	        tab low_BMI // 158 women had low BMI
			tab screen_mal if low_BMI==1
			tab counsel_nutri if low_BMI==1
			tab anc1food if low_BMI==1
			*percentage	
	        tabstat low_BMI if low_BMI==1
			tabstat screen_mal if low_BMI==1
			tabstat counsel_nutri if low_BMI==1
			tabstat anc1food if low_BMI==1		
	
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	egen depression_tx=rowmax(m1_724d anc1mental_health_drug) 
	        // m1_724d: Provider told that you should see a mental health provider likw a psychologist
			
			*absolute number 			
			tab depression // 89 women had depression
			tab m1_716c if depression==1        // m1_716c: discussed anxiety or depression		
			tab depression_tx if depression==1
			*percentage	
			tabstat depression if depression==1 
			tabstat m1_716c if depression==1     // m1_716c: discussed anxiety or depression		
			tabstat depression_tx if depression==1			
				
	* Prior chronic conditions	
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp)
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)
			tab1 DM HTN cardiac MH hiv
			egen complic=rowmax(DM HTN cardiac MH hiv)
			ta m1_718 if DM==1
			ta m1_719 if HTN==1
			ta m1_720 if cardiac==1
			ta m1_721 if MH==1
			ta m1_722 if hiv==1
			ta diabetes_tx if DM==1
			ta hypertension_tx if HTN==1
			ta specialist_hosp if cardiac==1
			ta depression_tx if MH==1
			ta m1_708c if hiv==1 // m1_708c: did the provider give you medicine for HIV? 
    *note: I used line 188-202 for the cascade figure in excel and word doc.
    
	* alternate way for prior chronic conditions
	egen ch_complic = rowmax(DM HTN cardiac MH hiv)                       // var indicating at least one prior chronic conditions
	egen discuss_ch_complic = rowmax(m1_718 m1_719 m1_720 m1_721 m1_722)  // var indicating discussing least one prior chronic conditions
	egen tx_ch_complic = rowmax(diabetes_tx hypertension_tx specialist_hosp depression_tx m1_708c)  // var indicating tx for chronic conditions 
			*absolute number 
			tab ch_complic
			tab discuss_ch_complic
			tab tx_ch_complic
			*percentage
	        tabstat ch_complic if ch_complic==1 
			tabstat discuss_ch_complic if ch_complic==1
			tabstat tx_ch_complic if ch_complic==1		

	* Prior obstetric complications
	egen ob_complic=rowmax(m1_1004 stillbirth preterm neodeat csect)             // ob_complic indicating at least one prior obstetric complications 
	egen discuss_ob_complic=rowmax(m1_1011b m1_1011c m1_1011d m1_1011e m1_1011f) // discuss_ob_complic indicating discussing at least one prior obstetric complications
			tab m1_1004                    // m1_1004: nb late miscarriages
			tab m1_1011b if m1_1004==1     // m1_1011b: Did the provider discuss that you lost a baby after 5 months of pregnancy?
			tab specialist_hosp if m1_1004==1
			
			tab stillbirth 
			tab m1_1011c if stillbirth==1  // m1_1011c: Did the provider discuss that you had a baby who was born dead before?
			tab specialist_hosp if stillbirth==1
			
			tab preterm                    // previous preterm baby
			tab m1_1011d if preterm==1     // m1_1011d: Did the provider discuss that you had a baby born early before?
			tab specialist_hosp if preterm==1
			
			tab csect                      // previous c-section
			tab m1_1011e if csect==1       // m1_1011e: Did the provider discuss that you had c section before?
			tab specialist_hosp if csect==1
			
			tab neodeath                   // previous neonatal death
			tab m1_1011f if neodeath==1    // m1_1011f: Did the provider discuss that you had a baby die wihtin their first month of life?
			tab specialist_hosp if neodeath==1
	        
			*absolute number
			tab ob_complic //187 women had at least one prior obstetric complications
			tab discuss_ob_complic
			tab specialist_hosp
			*percentage
			tabstat ob_complic if ob_complic==1 
			tabstat discuss_ob_complic if ob_complic==1 
			tabstat specialist_hosp if ob_complic==1

/* HIV CASCADE (India only has 5 cases of HIV)
			ta hiv // new or previous hiv dx
			*ta m1_722 if hiv==1 // discussed HIV
			egen viralload=rowmax(m1_709a m1_709a_2_za m1_708e m1_708e_2_za)
			ta viralload if hiv 
			egen cd4=rowmax(m1_709b m1_709b_2_za m1_708f m1_708f_2_za)
			ta cd4 if hiv
			egen med_hiv= rowmax(m1_204b_za m1_204 m1_204_2_za m1_708c m1_708c_2_za )
			ta med_hiv if hiv*/
	
* USER EXPERIENCE
			tab vgm1_601 //vgm1_601: rate overall quality of care
			
			*by site 
			tabstat anc1ux, by(residence) stat(mean sd count)
			anova anc1ux residence
			*by facility level
			tabstat anc1ux, by(facility_lvl) stat(mean sd count)
	        ttest anc1ux, by(facility_lvl)
			*by education
			tabstat anc1ux, by(educ_cat) stat(mean sd count)
			anova anc1ux educ_cat

			tabstat vgm1_605a vgm1_605b vgm1_605c vgm1_605d vgm1_605e vgm1_605f ///
			vgm1_605g vgm1_605h, stat(mean count) col(stat)


