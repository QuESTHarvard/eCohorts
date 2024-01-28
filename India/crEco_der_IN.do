* MNH: ECohorts derived variable creation (India)
* Created Jan 24, 2024
* C Arsenault

/*
	This file creates derived variables for analysis from the MNH ECohorts Kenya dataset. 
*/

u "$in_data_final/eco_m1_in.dta", clear

*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
	recode facility (8 9 10 = 1 "JRP")(1 2 3 4 5 6 24=2 "JUP")(11 12=3 "JUS") ///
	(14 15 23=4 "JRS") (20=5 "SUS")(26=6 "SRS")(25 27 28 29 30 31 32 33 34=7 "SRP") ///
	(35 36 39=8 "SUP"), g (facility_type)

	recode facility_type (1 4=1 "Rural_Jodhpur") (2 3=2 "Urban_Jodhpur") ///
	(6 7=3 "Sonipath_Rural") (8 5=4 "Sonopath_Urban"), gen (residence)

	* THIS IS NOT CORRECT, PHFI TO SEND URBAN/RURAL categories for remaining 211 women
	
	/*g site=study_site
	replace site = 1 if site==3 & residence==2
	replace site = 2 if site==3 & residence==1
	recode site 3=.
	
	lab def site 1"India Urban" 2"India Rural"
	lab val site site */
	
	recode study_site (2=1 "Sonipat") (3=2 "Jodhpur"), g(state)
	
	
	recode facility_type 1=1 2=1 3=2 4=2 5=2 6=2 7=1 8=1 18/96=. , g(facility_lvl)
	lab def facility_lvl 1"Primary" 2"Secondary"
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
			lab def educ_cat 1 "No education or some primary" 2 "Complete primary" 3 "Complete secondary" ///
							 4 "Higher education"	 
			lab val educ_cat educ_cat
			
			recode m1_505 (1/4=0) (5/6=1), gen(marriedp) 

*------------------------------------------------------------------------------*	
	* SECTION 6: USER EXPERIENCE
			foreach v in m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f ///
			             m1_605g m1_605h {
				recode `v' (2=1) (3/5=0), gen(vg`v')
			}
			egen anc1ux=rowmean(vgm1_605a-vgm1_605h) // this is different than ETH!
			
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
			replace anc1fetal_hr=. if m1_804==1 | m1_804==. // only applies to those in 2nd or 3rd trimester
			gen anc1urine = m1_705
			egen anc1blood = rowmax(m1_706 m1_707) // finger prick or blood draw
			gen anc1hiv_test =  m1_708a
			gen anc1syphilis_test = m1_710a
			gen anc1blood_sugar_test = m1_711a
			gen anc1ultrasound = m1_712

			gen anc1ifa =  m1_713a
			recode anc1ifa (2=1) (3=0)
			gen anc1tt = m1_714a
			gen anc1calcium = m1_713b
			recode anc1calcium (2=1) (3=0)
			gen anc1deworm= m1_713d
			recode anc1deworm (2=1) (3=0)
			recode m1_715 (2=1), gen(anc1itn)
			gen anc1depression = m1_716c
			gen anc1malaria_proph =  m1_713e
			recode anc1malaria_proph (2=1) (3=0)
			gen anc1edd =  m1_801
			egen anc1tq = rowmean(anc1bp anc1weight anc1urine anc1blood anc1ultrasound anc1ifa anc1tt anc1calcium ) // 9 items - removed ultrasound
								 
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
			
*------------------------------------------------------------------------------*	
	* SECTION 8: CURRENT PREGNANCY
			
			gen ga = gest_age
			replace ga = . if gest_age<1 | gest_age> 40
			
			gen trimester = m1_804
			replace trimester =. if trimester<1 | trimester >3

			* Asked about LMP
			gen anc1lmp= m1_806
			
			/* Screened for danger signs 
			egen anc1danger_screen = rowmax(m1_815a_1_in m1_815a_2_in m1_815a_3_in ///
			m1_815a_4_in m1_815a_5_in m1_815a_6_in m1_815a_96_in m1_815b_1_in m1_815b_2_in m1_815b_3_in ///
			m1_815b_4_in m1_815b_5_in m1_815b_6_in m1_815b_96_in m1_815c_1_in m1_815c_2_in ///
			m1_815c_3_in m1_815c_4_in m1_815c_5_in m1_815c_6_in m1_815c_96_in m1_815d_1_in ///
			m1_815d_2_in m1_815d_3_in m1_815d_4_in m1_815d_5_in m1_815d_6_in m1_815d_96_in ///
			m1_815e_1_in m1_815e_2_in m1_815e_3_in m1_815e_4_in m1_815e_5_in m1_815e_6_in ///
			m1_815e_96_in m1_815f_1_in m1_815f_2_in m1_815f_3_in m1_815f_4_in m1_815f_5_in ///
			m1_815f_6_in m1_815f_96_in m1_815g_1_in m1_815g_2_in m1_815g_3_in m1_815g_4_in ///
			m1_815g_5_in m1_815g_6_in m1_815g_96_in m1_815h_1_in m1_815h_2_in m1_815h_3_in ///
			m1_815h_4_in m1_815h_5_in m1_815h_6_in m1_815h_96_in) 
	
			replace anc1danger_screen= 0 if m1_815a_0_in==1 | m1_815b_0_in==1 |  ///
				m1_815c_0_in==1 |  m1_815d_0_in==1 |  m1_815e_0_in==1 |  m1_815f_0_in==1 ///
				| m1_815g_0_in==1 | m1_815h_0_in==1 
			replace anc1danger_screen =  m1_816 if anc1danger_screen==.a | ///
				anc1danger_screen==. | anc1danger_screen==.d */
				
*------------------------------------------------------------------------------*	
	* SECTION 13: HEALTH ASSESSMENTS AT BASELINE

			* High blood pressure (HBP)
			egen systolic_bp= rowmean(bp_time_1_systolic bp_time_2_systolic bp_time_3_systolic)
			egen diastolic_bp= rowmean(bp_time_1_diastolic bp_time_2_diastolic bp_time_3_diastolic)
			
			recode systolic_bp 50/139.999=0 140/160=1, gen(systolic_high)
			
			recode diastolic_bp 50/89.999=0 90/160=1, gen(diastolic_high)
			
			egen HBP= rowmax (systolic_high diastolic_high)
			drop systolic* diastolic*
			
			* Anemia 
			gen Hb= m1_1307 // hemoglobin value taken from the card
			gen Hb2= m1_1309 // test done by E-Cohort data collector
			replace Hb = Hb2 if Hb==.a // use the card value if the test wasn't done
			drop Hb2

			// Reference value of 11 from Ethiopian 2022 guidelines. Should check if relevant in KE
			recode Hb 0/10.9999=1 11/20=0, g(anemic)
			
			* BMI 
			gen height_m = height_cm/100 // need to fix height values under 10cm!!!
			replace height_m=. if height_m<1
			gen BMI = weight_kg / (height_m^2)
			gen low_BMI= 1 if BMI<18.5 
			replace low_BMI = 0 if BMI>=18.5 & BMI<.

			
							

 save "$in_data_final/eco_m1_in_der.dta", replace
 
 
 
 
 

