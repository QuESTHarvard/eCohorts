* MNH: ECohorts derived variable creation (Ethiopia)
* Date of last update: April 2024
* C Arsenault, S Sabwa, K Wright

/*
	This file creates derived variables for analysis from the MNH ECohorts Kenya dataset. 
*/

u "$ke_data_final/eco_m1-m4_ke.dta", clear

*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
	recode facility_name2 22=4 // 7 women from Igegania sub district hospital coded as "22"
	gen facility_lvl = 1 if facility_name2==1 ///
		| facility_name2==21 | facility_name2==10 ///
		| facility_name2==16 | facility_name2==20 ///
		| facility_name2==5 |  facility_name2==15 ///
		| facility_name2==3 | facility_name2==8 
		
	replace facility_lvl = 2 if facility_name2==2 ///
			| facility_name2==7 ///
			| facility_name2==9 ///
			| facility_name2==6
			
	replace facility_lvl=3 if facility_name2==18 ///
	| facility_name2==19 | facility_name2==4 ///
	| facility_name2==11 | facility_name2==12 ///
	| facility_name2==14 | facility_name2==17 ///
	| facility_name2==13
	
	lab def facility_lvl 1"Public primary" 2"Public secondary" 3"Private"
	lab val facility_lvl facility_lvl
*------------------------------------------------------------------------------*	
	* SECTION 2: HEALTH PROFILE
	
			egen bsl_phq9_cat = rowtotal(phq9*)
			recode bsl_phq9_cat (0/4=1) (5/9=2) (10/14=3) (15/19=4) (20/27=5)
			label define phq9_cat 1 "none-minimal 0-4" 2 "mild 5-9" 3 "moderate 10-14" ///
			                        4 "moderately severe 15-19" 5 "severe 20+" 
			label values bsl_phq9_cat phq9_cat

			egen bsl_phq2_cat= rowtotal(phq9a phq9b)
			recode bsl_phq2_cat (0/2=0) (3/6=1)
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
			recode m1_511 2=1 1=0 3/4=0 998 =., g(drink)
			recode m1_512 2=1 1=0 3=0, g(smoke)
			
			egen health_literacy=rowtotal(m1_509a mosquito m1_510a tbherb drink smoke ), m
			recode health_literacy 0/3=1 4=2 5=3 6=4
			lab def health_lit 1"Poor" 2"Fair" 3"Good" 4"Very good"
			lab val health_lit health_lit
			drop mosquito-smoke
*------------------------------------------------------------------------------*	
	* SECTION 6: USER EXPERIENCE
			foreach v in m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f ///
			             m1_605g m1_605h {
				recode `v' (2=1) (3/5=0), gen(vg`v')
			}
			egen anc1ux=rowmean(vgm1_605a-vgm1_605h) // this is different than ETH!
			drop vgm1*
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
			gen anc1calcium = m1_713b
			recode anc1calcium (2=1) (3=0)
			gen anc1deworm= m1_713d
			recode anc1deworm (2=1) (3=0)
			recode m1_715 (2=1), gen(anc1itn)
			gen anc1depression = m1_716c
			gen anc1malaria_proph =  m1_713e
			recode anc1malaria_proph (2=1) (3=0)
			gen anc1edd =  m1_801
			egen anc1tq = rowmean(anc1bp anc1weight anc1height anc1muac anc1fetal_hr anc1urine ///
								 anc1blood anc1ifa anc1tt ) // 9 items - removed ultrasound
								 
			* Counselling at first ANC visit
			gen anc1counsel_nutri =  m1_716a  
			gen anc1counsel_exer=  m1_716b
			gen anc1counsel_complic =  m1_716e
			gen anc1counsel_comeback = m1_724a
			gen anc1counsel_birthplan =  m1_809
			egen anc1counsel = rowmean(anc1counsel_nutri anc1counsel_exer anc1counsel_complic ///
								anc1counsel_comeback anc1counsel_birthplan)
										
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
			egen anc1specialist_hosp= rowmax(m1_724e m1_724c) 
*------------------------------------------------------------------------------*	
	* SECTION 8: CURRENT PREGNANCY
			/* Gestational age at ANC1
			Here we should recalculate the GA based on LMP (m1_802c and self-report m1_803 */
			
			egen bsl_dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d m1_814f m1_814g)
			
			gen bsl_ga = gest_age_baseline_ke
			replace bsl_ga = m1_803 if bsl_ga == . 
			
			gen bsl_trimester = bsl_ga
			recode bsl_trimester 0/12 = 1 13/26 = 2 27/42 = 3
			replace bsl_trimester = m1_804 if bsl_trimester ==.a | bsl_trimester==.d
			
			* Asked about LMP
			gen anc1lmp= m1_806
			
			gen bsl_preg_intent = m1_807
			
			/* Screened for danger signs 
			egen anc1danger_screen = rowmax(m1_815_2-m1_815_96) // addressed the issue
			replace anc1danger_screen= 0 if m1_815_1 ==1 | m1_815_98==1  | m1_815_99==1 // didn't discuss
			
			replace anc1danger_screen = 0 if m1_815_other=="Didn't discuss because it happened twice only." ///
			| m1_815_other=="Never informed the care provider" | m1_815_other=="No response given by the nurse"
			
			replace anc1danger_screen =  m1_816 if anc1danger_screen==.a | anc1danger_screen==. */
*------------------------------------------------------------------------------*	
	* SECTION 9: RISKY HEALTH BEHAVIOR
			recode  m1_901 (1/2=1) (3=0) (4=.)
			recode m1_903  (1/2=1) (3=0) (4=.)
			egen bsl_risk_health = rowmax( m1_901  m1_903  m1_905)
			egen bsl_stop_risk = rowmax( m1_902  m1_904  m1_907)
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
	* SECTION 11: IPV
	
	egen bsl_physical_verbal = rowmax(m1_1101 m1_1103)
*------------------------------------------------------------------------------*	
	* SECTION 12: ECONOMIC STATUS AND OUTCOMES
			*Asset variables
			recode  m1_1201 (2 4 6 7 -96 =0) (1 3 5  =1), gen(safewater) // piped,covered well, boreholes, rainwater (improved) open well, surface water, bottled water, river (unimproved) 
			recode  m1_1202 (2=1) (3=0), gen(toilet)
			gen electr = m1_1203
			gen radio = m1_1204
			gen tv = m1_1205
			gen phone = m1_1206
			gen refrig = m1_1207
			recode m1_1208 (1/3 -96=1) (4/5=0), gen(fuel) // electricity, gas, koko, kerosene (improved) charcoal wood (unimproved)
			gen bicycle =  m1_1212 
			gen motorbik = m1_1213
			gen car = m1_1214 
			gen bankacc = m1_1215
			recode m1_1209 (96 1=0) (2/3=1), gen(floor) // Earth, dung (unimproved) wood planks, palm, polished wood and tiles (improved)
			recode m1_1210 (1 2 5=0) (3/4 6/8=1) (-96=0), gen(wall) // Grass, timber, poles, mud  (unimproved) bricks, cement, stones (improved)
			replace wall=1 if m1_1210_other=="Cement and baked briks" | m1_1210_other=="Iron sheets"
			recode m1_1211 (1/2 -96=0) (3/5=1), gen(roof)  // Iron sheets, Tiles, Concrete (improved) grass, leaves, mud, no roof (unimproved)
			replace roof=1 if m1_1211_other=="Iron sheets with a ceiling" | m1_1211_other=="Bricks"
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
			
			lab def quintile 1"Poorest" 2"Second" 3"Third" 4"Fourth" 5"Richest"
			lab val quintile quintile
			lab def tertile 1"Poorest" 2"Second" 3"Richest"
			lab val tertile tertile 
			
			drop safewater-roof

			
			gen anc1registration_cost= m1_1218a_1 // registration
				replace anc1registration = . if anc1registr==0
			gen anc1med_vax_cost =  m1_1218b_1 // med or vax
				replace anc1med_vax_cost = . if anc1med_vax_cost==0
			gen anc1labtest_cost =  m1_1218c_1 // lab tests
				replace anc1labtest_cost= . if anc1labtest_cost==0
			egen anc1indirect_cost = rowtotal (m1_1218d_1 m1_1218e_1 m1_1218f_1 )
				replace anc1indirect = . if anc1indirect==0
*------------------------------------------------------------------------------*	
	* SECTION 13: HEALTH ASSESSMENTS AT BASELINE

			* High blood pressure (HBP)
			egen systolic_bp= rowmean(bp_time_1_systolic bp_time_2_systolic bp_time_3_systolic)
			egen diastolic_bp= rowmean(bp_time_1_diastolic bp_time_2_diastolic bp_time_3_diastolic)
			
			gen systolic_high = 1 if systolic_bp >=140 & systolic_bp <.
			replace systolic_high = 0 if systolic_bp<140
			gen diastolic_high = 1 if diastolic_bp>=90 & diastolic_bp<.
			replace diastolic_high=0 if diastolic_high <90
			
			egen bsl_HBP= rowmax (systolic_high diastolic_high)
			drop systolic* diastolic*
			
			* Anemia 
			gen bsl_Hb= m1_1309 // test done by E-Cohort data collector
			gen bsl_Hb_card= m1_1307 // hemoglobin value taken from the card
			replace bsl_Hb = bsl_Hb_card if bsl_Hb==.a // use the card value if the test wasn't done


			// Reference value of 11 from Ethiopian 2022 guidelines. Should check if relevant in KE
			gen bsl_anemic= 0 if bsl_Hb>=11 & bsl_Hb<. 
			replace bsl_anemic=1 if bsl_Hb<11
			drop bsl_Hb_card

			
			* BMI 
			gen bsl_height_m = height_cm/100
			gen bsl_BMI = weight_kg / (bsl_height_m^2)
			gen bsl_low_BMI= 1 if bsl_BMI<18.5 
			replace bsl_low_BMI = 0 if bsl_BMI>=18.5 & bsl_BMI<.

					
			
*------------------------------------------------------------------------------*	
* Labelling new variables 
	
	lab var bsl_phq9_cat "PHQ9 Depression level Based on sum of all 9 items at baseline"
	lab var anc1bp "Blood pressure taken at ANC1"
	lab var anc1weight "Weight taken at ANC1"
	lab var anc1height "Height measured at ANC1"
	lab var anc1bmi "Both Weight and Height measured at ANC1"
	lab var anc1muac "Upper arm measured at ANC1"
	lab var anc1urine "Urine test done at ANC1"
	lab var anc1blood "Blood test done at ANC1 (finger prick or blood draw)"
	lab var anc1hiv_test "HIV test done at ANC1"
	lab var anc1syphilis_test "Syphilis test done at ANC1"
	lab var anc1ultrasound "Ultrasound done at ANC1"
	lab var anc1food_supp "Received food supplement directly or a prescription at ANC1"
	lab var anc1ifa "Received iron and folic acid pills directly or a prescription at ANC1"
	lab var anc1tq "Technical quality score 1st ANC based on 9 items"
	lab var anc1counsel_nutri "Counselled about proper nutrition at ANC1"
	lab var anc1counsel_exer "Counselled about exercise at ANC1"
	lab var anc1counsel_complic  "Counselled about signs of pregnancy complications"
	lab var anc1counsel_birthplan "Counselled on birth plan at ANC1"
	lab var anc1counsel "Counselling quality score 1st ANC"
	lab var anc1specialist_hosp  "Told to go see a specialist or to go to hospital for ANC at ANC1"
	lab var bsl_dangersigns "Experienced at least one danger sign so far in pregnancy"
	lab var pregloss "Number of pregnancy losses (Nb pregnancies > Nb births)"
	lab var bsl_HBP "High blood pressure at baseline"
	lab var bsl_anemic "Anemic (Hb <11.0)"
	lab var bsl_height_m "Height in meters at baseline"
	lab var bsl_BMI "Body mass index at baseline"
	lab var bsl_low_BMI "BMI below 18.5 (low) at baseline"
	lab var marriedp "Is married or lives with partner at baseline"
	lab var educ_cat "Education level category"
	lab var bsl_risk_health "Risky behaviors such as smoking or drinking alcohol"
	lab var bsl_stop_risk "Did the provider advise on stopping smoking or drinking alcohol at 1st ANC visit?"
	lab var anc1fetal_hr "Fetal heart rate measured at 1st ANC visit"
	lab var anc1blood_sugar_test "Blood sugar test taken at 1st ANC visit"
	lab var anc1edd "Estimated due date told by provider at 1st ANC visit"
	lab var anc1tt "TT vaccination given at 1st ANC visit"
	lab var anc1depression "Anxiety or depression discussed at 1st ANC visit"
	lab var anc1diabetes "Medicines for diabetes given at 1st ANC visit"
	lab var anc1mental_health_drug "Mental health drug given at 1st ANC visit"
	lab var anc1hypertension "Medicines for hypertension given at 1st ANC visit"
	lab var anc1hiv "Medicines for HIV given at 1st ANC visit"
	lab var anc1lmp "Last menstrual perioid asked by provider at 1st ANC visit"
	lab var anc1ux "User experience score at 1st ANC visit based on 8 items"
    lab var anc1registration_cost "The amount of money spent on registration / consultation"
	lab var anc1med_vax_cost "The amount of money spent for medicine/vaccines"
	lab var anc1labtest_cost "The amounr of money spent on Test/investigations (x-ray, lab, etc)"
	lab var anc1indirect_cost "Indirect cost, including transport, accommodation, and other"
	lab var bsl_physical_verbal "Reported experiencing physical or verbal abuse during pregnancy at baseline"
	lab var nbpreviouspreg "Number of previous pregnancies, excluding the current"
	lab var gravidity "Number of previous pregnancies including the current pregnancy"
	lab var primipara "First time pregnancy"
	lab var stillbirths "Had a prior stillbirth"
	lab var anc1counsel_comeback "Counselled about coming back for ANC visit"
	lab var anc1tt "TT vaccination given at 1st ANC visit"
	lab var anc1diabetes "Medicines for diabetes given at 1st ANC visit"
	lab var anc1mental_health_drug "Mental health drug given at 1st ANC visit"
	lab var anc1hypertension "Medicines for hypertension given at 1st ANC visit"
	lab var anc1hiv "Medicines for HIV given at 1st ANC visit"
	lab var anc1lmp "Last menstrual perioid asked by provider at 1st ANC visit"
	lab var anc1fetal_hr "Fetal heart rate measured at 1st ANC visit"
	lab var anc1edd "Estimated due date told by provider at 1st ANC visit"	
	lab var anc1depression "Anxiety or depression discussed at 1st ANC visit"
	lab var anc1calcium "Calcium given at 1st ANC"
	lab var anc1deworm "Dewormning medicines given at 1st ANC"
	lab var anc1malaria_proph "Malaria medicines given at 1st ANC"
	lab var health_literacy "Health literacy score at baseline"
	lab var bsl_preg_intent "The pregnancy was intended or not"
	lab var bsl_phq2_cat "PHQ2 depression level based on sum of 2 items"
	lab var bsl_Hb "Hemoglobin level at baseline"
	lab var bsl_trimester "Trimester at 1st ANC visit"
	lab var bsl_ga "Gestational age at baseline"
	lab var quintile "Quintiles according to wealth index calculated at baseline"
	lab var tertile "Tertiles according to wealth index calculated at baseline"

		
	order facility_lvl, after(facility_name2)
	order wealthindex quintile tertile bsl_phq9_cat bsl_phq2_cat, after(health_lit)
	order anc1* , after(bsl_low_BMI)
	
save "$ke_data_final/eco_m1-m3_ke_der.dta", replace

