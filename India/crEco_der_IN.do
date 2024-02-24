* MNH: ECohorts derived variable creation (India)
* Created Jan 24, 2024
* C Arsenault

/*
	This file creates derived variables for analysis from the MNH ECohorts India dataset. 
*/

u "$in_data_final/eco_m1_in.dta", clear

*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
	recode facility (8 9 10 40= 1 "JRP")(1 2 3 4 5 6 24 42=2 "JUP")(11 12 43=3 "JUS") ///
	(14 15 23 41=4 "JRS") (20 39 47=5 "SUS")(26 45=6 "SRS")(25 27 28 29 30 31 32 33 18 34 44=7 "SRP") ///
	(35 36 46=8 "SUP"), g (facility_type)
 
	recode facility_type (1 4=1 "Rural_Jodhpur") (2 3=2 "Urban_Jodhpur") ///
	(6 7=3 "Sonipath_Rural") (8 5=4 "Sonopath_Urban"), gen (residence)
	
	order facility_type, after(facility)
	
	recode facility_type (1 4 6 7=0) (2/3 5 8  =1), g(urban)
	lab def urban 1"urban" 0"rural"
	lab val urban urban
	
	recode facility (1/2 7/8=1) (3/6=2), g(facility_lvl)
	lab def facility_lvl 1"Primary" 2"Secondary"
	* There are 33 unique facilities. Subhojit to send
	
	recode study_site (2=1 "Sonipat") (3=2 "Jodhpur"), g(state)

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
			
			recode m1_509b 0=1 1=0, g(mosquito)
			recode m1_510b 0=1 1=0, g(tbherb)
			recode m1_511 1=0 2=1 3/4=0, g(drink)
			recode m1_512 1=0 2=1 3=0, g(smoke)
			
			egen m1_health_literacy=rowtotal(m1_509a mosquito m1_510a tbherb drink smoke), m
			recode m1_health_literacy 0/3=1 4=2 5=3 6=4
			lab def health_lit 1"Poor" 2"Fair" 3"Good" 4"Very good"
			lab val m1_health_lit health_lit

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
			egen m1_dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d m1_814f m1_814g)
			gen preg_intent = m1_807
			
	* THE BELOW IS NOT CORRECT!SHALOM TO ADJUST
			gen m1_ga = gest_age
			
			*recode m1_ga (0/12=1) (12.1/27=2) (27.1/40=3), g(trimester)
			g trimester=m1_804
			
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
	
			
			egen tmp = rowmax(m1_815a_0_in m1_815b_0_in m1_815c_0_in m1_815d_0_in m1_815e_0_in ///
			m1_815f_0_in m1_815g_0_in m1_815h_0_in )
			
			replace anc1danger_screen = 0 if tmp == 1 & anc1danger_screen==.
			drop tmp
				
			replace anc1danger_screen =  m1_816 if anc1danger_screen==. 
			* Programming error: 816 is missing for most women with no danger signs*/
				
*------------------------------------------------------------------------------*	
	* SECTION 10: OBSTETRIC HISTORY
			gen gravidity = m1_1001
			gen primipara=  m1_1001==1 // first pregnancy
			replace primipara = 1 if  m1_1002==0  // never gave birth
			gen nbpreviouspreg = m1_1001-1 // nb of pregnancies including current minus current pregnancy
			gen pregloss = nbpreviouspreg-m1_1002 // nb previous pregnancies not including current minus previous births
			
			gen stillbirths = m1_1002 - m1_1003 // nb of deliveries/births minus live births
			replace stillbirths = 1 if stillbirths>1 & stillbirths<.
*------------------------------------------------------------------------------*	
	* SECTION 12: ECONOMIC STATUS AND OUTCOMES
			
			*Asset variables
			recode  m1_1201 (2 4 6 96=0) (3=1), gen(safewater) // 96 is  tanker 
			recode  m1_1202 (2=1) (3=0), gen(toilet) // flush/ pour flush toilet and pit laterine =improved 
			gen electr = m1_1203
			gen radio = m1_1204
			gen tv = m1_1205
			gen phone = m1_1206
			gen refrig = m1_1207
			recode m1_1208 (2=1) (4/7=0), gen(fuel) // electricity, gas (improved) charcoal, wood, dung, crop residuals (unimproved)
			gen bicycle =  m1_1212 
			gen motorbik = m1_1213
			gen car = m1_1214 
			gen bankacc = m1_1215
			recode m1_1209 (96 1=0) (2/3=1), gen(floor) //Earth, dung (unimproved) wood planks, palm, polished wood, tiles (improved)
			recode m1_1210 (1 2 5=0) (3/4 6/8=1) (96=0), gen(wall) // Grass, timber, poles, mud  (unimproved) bricks, cement, stones (improved)
			recode m1_1211 (1/2=0) (3/5=1) (96=0), gen(roof)  // Iron sheets, Tiles, Concrete (improved) grass, leaves, mud, no roof (unimproved)
			lab def imp 1"Improved" 0"Unimproved"
			lab val safewater toilet fuel floor wall roof imp
			
			* I used the WFP's approach to create the wealth index
			// the link can be found here https://docs.wfp.org/api/documents/WFP-0000022418/download/ 
			pca safewater toilet electr radio tv phone refrig fuel bankacc car ///
			motorbik bicycle roof wall floor 
			estat kmo // all above 50
			predict wealthindex
			xtile quintile = wealthindex, nq(5)
			xtile tertile = wealthindex, nq(3)
				
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
 
 
 
 
 

