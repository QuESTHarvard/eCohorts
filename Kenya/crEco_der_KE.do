* MNH: ECohorts derived variable creation (Ethiopia)
* Date of last update: September 2023
* C Arsenault, S Sabwa, K Wright

/*

	This file creates derived variables for analysis from the MNH ECohorts Kenya dataset. 

*/
*u "$ke_data_final/eco_m1_ke.dta", clear
u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data/eco_m1_ke.dta", clear

*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
	gen facility_lvl = 1 if facility=="Githunguri health centre" ///
		| facility=="Wangige Sub-County Hospital" | facility=="Makongeni dispensary" ///
		| facility=="Nuu Sub County Hospital" | facility=="Waita Health Centre" ///
		| facility=="Katse Health Centre" |  facility=="Ngomeni Health Centre" ///
		| facility=="Ikutha Sub County Hospital" | facility=="Kisasi Health Centre (Kitui Rural)" 
		
	replace facility_lvl = 2 if facility=="Igegania sub district hospital" ///
			| facility=="Kiambu County referral hospital" ///
			| facility=="Kitui County Referral Hospital" ///
			| facility=="Kauwi Sub County Hospital"
			
	replace facility_lvl=3 if facility=="Plainsview nursing home" ///
	| facility=="St. Teresas Nursing Home" | facility=="Kalimoni mission hospital" ///
	| facility=="Mercylite hospital" | facility=="Mulango (AIC) Health Centre" ///
	| facility=="Neema Hospital" | facility=="Our Lady of Lourdes Mutomo Hospital" ///
	| facility=="Muthale Mission Hospital"
	
	lab def facility_lvl 1"Public primary" 2"Public secondary" 3"Private"
	lab val facility_lvl facility_lvl
*------------------------------------------------------------------------------*	
	* SECTION 2: HEALTH PROFILE
	
			egen phq9_cat = rowtotal(phq9*)
			recode phq9_cat (0/4=1) (5/9=2) (10/14=3) (15/19=4) (20/27=5)
			label define phq9_cat 1 "none-minimal 0-4" 2 "mild 5-9" 3 "moderate 10-14" ///
			                        4 "moderately severe 15-19" 5 "severe 20+" 
			label values phq9_cat phq9_cat

			egen phq2_cat= rowtotal(phq9a phq9b)
			recode phq2_cat (0/2=0) (3/6=1)
*------------------------------------------------------------------------------*	
	* SECTION 3: CONFIDENCE AND TRUST HEALTH SYSTEM
			recode m1_302 (999=.)
	
*------------------------------------------------------------------------------*	
	* SECTION 5: BASIC DEMOGRAPHICS
			gen educ_cat=m1_503
			replace educ_cat = 1 if m1_502==0
			recode educ_cat (3=2) (4=3) (5=4)
			lab def educ_cat 1 "None or some primary" 2 "Completed primary or some secondary" ///
							 3 "Completed secondary" 4"Higher education"	 
			lab val educ_cat educ_cat
*------------------------------------------------------------------------------*	
	* SECTION 6: USER EXPERIENCE
			foreach v in m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f ///
			             m1_605g m1_605h {
				recode `v' (2=1) (3/5=0), gen(vg`v')
			}
			egen anc1ux=rowmean(vgm1_605a-vgm1_605h) // this is different than ETH!
			drop vgm1_605a-vgm1_605h
*------------------------------------------------------------------------------*	
	* SECTION 7: VISIT TODAY: CONTENT OF CARE
	
			* Technical quality of first ANC visit
			gen anc1bp = m1_700 
			gen anc1weight = m1_701 
			gen anc1height = m1_702
			egen anc1bmi = rowtotal(m1_701 m1_702)
			recode anc1bmi (1=0) (2=1)
			gen anc1muac = m1_703
			gen anc1fetal_hr = m1_704
			recode anc1fetal_hr  (2=.) 
			replace anc1fetal_hr=. if m1_804==1 // only applies to those in 2nd or 3rd trimester
			gen anc1urine = m1_705
			egen anc1blood = rowmax(m1_706 m1_707) // finger prick or blood draw
			gen anc1hiv_test =  m1_708a
			gen anc1syphilis_test = m1_710a
			gen anc1blood_sugar_test = m1_711a
			gen anc1ultrasound = m1_712
			gen anc1ifa =  m1_713a
			recode anc1ifa (2=1) (3=0)
			gen anc1tt = m1_714a

			egen anc1tq = rowmean(anc1bp anc1weight anc1height anc1muac anc1fetal_hr anc1urine ///
								 anc1blood anc1ultrasound anc1ifa anc1tt ) // 10 items
								 
			* Counselling at first ANC visit
			gen counsel_nutri =  m1_716a  
			gen counsel_exer=  m1_716b
			gen counsel_complic =  m1_716e
			gen counsel_comeback = m1_724a
			gen counsel_birthplan =  m1_809
			egen anc1counsel = rowmean(counsel_nutri counsel_exer counsel_complic ///
								counsel_comeback counsel_birthplan)
										
			* Q713 Other treatments/medicine at first ANC visit 
			gen anc1food_supp = m1_713c
			gen anc1mental_health_drug = m1_713f
			gen anc1hypertension = m1_713h
			gen anc1diabetes = m1_713i
			foreach v in anc1food_supp anc1mental_health_drug anc1hypertension ///
						 anc1diabetes {
			recode `v' (3=0) (2=1)
			}
			
			
			* Instructions and advanced care
			egen specialist_hosp= rowmax(m1_724e m1_724c) 
								 
save "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data/eco_m1_ke_der.dta", replace
	