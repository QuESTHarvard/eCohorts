* Ethiopia ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Updated: July 27 2023


use "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et.dta", clear


drop in 1/72 // drop the test records
keep if  b7eligible ==1 // drop the non eligible.. this is also droping the other modules currently.
drop redcap_repeat_instrument-redcap_data_access_group m2_attempt_date-m2_complete // drops M2 variables

* GENERAL RISK FACTORS
	gen aged18 = age<18
	gen aged35 = age>35
	recode m1_203 (2=0)
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_202f m1_202g m1_203)
	
	* High blood pressure from measurements at ANC1
	egen systolic_bp= rowmean(bp_time_1_systolic bp_time_2_systolic bp_time_3_systolic)
	egen diastolic_bp= rowmean(bp_time_1_diastolic bp_time_2_diastolic bp_time_3_diastolic)
	gen systolic_high = 1 if systolic_bp >=140 & systolic_bp <.
	replace systolic_high = 0 if systolic_bp<140
	gen diastolic_high = 1 if diastolic_bp>=90 & diastolic_bp<.
	replace diastolic_high=0 if diastolic_high <90
	egen HBP= rowmax (systolic_high diastolic_high)
	drop systolic* diastolic*
	
	* Anemia from card or from hemocue test at baseline
	* Reference value from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8990104/
	gen Hb= m1_1309
	gen Hb_card= m1_1307 
		replace Hb_card = "12.6" if Hb_card=="12.6g/d" | Hb_card=="12.6g/dl"
		replace Hb_card = "13" if Hb_card=="13g/dl" 
		replace Hb_card= "14.6" if Hb_card=="14.6g/dl"
		replace Hb_card = "15" if Hb_card=="15g/dl"
		replace Hb_card= "16.3" if Hb_card=="16.3g/dl"
		replace Hb_card= "16.6" if Hb_card=="16.6g/dl"
		replace Hb_card= "16" if Hb_card=="16g/dl"
		replace Hb_card= "17.6" if Hb_card=="17.6g/dl"
		replace Hb_card="11.3" if Hb_card=="113"
	destring Hb_card, replace
	replace Hb = Hb_card if Hb==.a // use the card value if the test wasn't done
	gen anemic= 1 if Hb<10
	replace anemic=0 if Hb>=10 & Hb<. 
	drop Hb*
	
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
	
* 	ADVANCED ANC
	egen specialist_hosp= rowmax(m1_724e m1_724c)
	gen comeback_ANC = m1_724a
	gen wks_ANC= m1_724b
	recode wks_ANC (35/44=.) // implausible values for weeks until next ANC
	
	lab var aged18 "Aged less than 19"
	lab var aged40 "Aged more than 40"
	lab var chronic "Has a chronic illness"
	lab var HBP "High blood pressure at first ANC"
	lab var anemic "Anemic (Hb <10.0)"
	lab var multi "Multiple pregnancy (twins, triplets, etc.)"
	lab var sb "Had a previous stillbirth"
	lab var neodeath "Had a previous neonatal death"
	lab var preterm "Had a previous baby born early (more than 3wks before due date)"
	lab var PPH "Had a previous hemorrage at pregnancy or delivery"
	lab var general_risk "Has any of the general risk factors"
	lab var obst_risk = "Has any obstetric risk factors"
	lab var anyrisk = "Has any general or obstetric risk factors"
	lab var specialist_hosp = "Told to go see a specialist or to go to hospital for ANC"
	/*
	egen dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g)
	
	* BMI from health assessments
	gen height_m = height_cm/100
	gen BMI = weight_kg / (height_m^2)
	gen low_BMI= 1 if BMI<18.5 
	replace low_BMI = 0 if BMI>=18.5 & BMI<.
	
	lab var BMI "Body mass index"
	lab var low_BMI "BMI below 18.5 (low)"
	lab var height_m "Height in meters"
	lab var dangersigns "Experienced a danger sign so far in pregnancy"
