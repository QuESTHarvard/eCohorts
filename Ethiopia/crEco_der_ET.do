
* MNH: eCohorts derived variable creation (Ethiopia)

* Date of last update: April, 2024
* S Sabwa, K Wright, C Arsenault

* DERIVED VARIABLES: ETHIOPIA

/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-10-02		1.01	MK Trimner		Commented out u "$et_data_final/eco_m1-m5_et_wide.dta", clear
*										As this program was added to the end of crEco_cln_ET to run 
*2024-11-1		1.02	MK Trimner		Removed m1_815_1 from egen anc1danger_screen variable as this was combined with m1_815_5	
* 2024-11-05	1.03	MK Trimner		Added Module and original Var name chars	
* 2024-12-03	1.04	MK Trimner		Added value labels to derived variables						
*******************************************************************************/

*u "$et_data_final/eco_m1-m5_et_wide.dta", clear
				 
*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
			
			gen facility_own = facility
			recode facility_own (2/11 14 16/19 =1) ///
							    (1 13 15 20 21 22 96 =2)
			lab def facility_own 1 "Public" 2 "Private"
			lab val facility_own facility_own 
			char facility_own[Module] `facility[Module]'
			char facility_own[Original_ET_Varname] `facility[Original_ET_Varname]'
			
			gen facility_lvl = facility 
			recode facility_lvl (2/6 8/12 14 16 17 19  =1) (7 18 =2) ///
								(1 13 15 20 21 22 96 =3) 
			char facility_lvl[Module] `facility[Module]'
			char facility_lvl[Original_ET_Varname] `facility[Original_ET_Varname]'
					
			lab def facility_lvl 1"Public primary" 2 "Public secondary" 3 "Private"
			lab val facility_lvl facility_lvl
*------------------------------------------------------------------------------*	
	* SECTION 2: HEALTH PROFILE
	
			egen m1_phq9_cat = rowtotal(m1_phq9*)
			
			foreach v of varlist m1_phq9* {
				char m1_phq9_cat[Module] 1
				char m1_phq9_cat[Original_ET_Varname] `m1_phq9_cat[Original_ET_Varname]' & ``v'[Original_ET_Varname]'
			}
			
			recode m1_phq9_cat (0/4=1) (5/9=2) (10/14=3) (15/19=4) (20/27=5)
			
			label define phq9_cat 1 "none-minimal 0-4" 2 "mild 5-9" 3 "moderate 10-14" ///
			                        4 "moderately severe 15-19" 5 "severe 20+" 
			label values m1_phq9_cat phq9_cat

			egen m1_phq2_cat= rowtotal(m1_phq9a m1_phq9b)
			char m1_phq2_cat[Module] 1
			char m1_phq2_cat[Original_ET_Varname] `m1_phq9a[Original_ET_Varname]' & `m1_phq9b[Original_ET_Varname]'

			recode m1_phq2_cat (0/2=0) (3/6=1)
			
*------------------------------------------------------------------------------*	
	* SECTION 3: CONFIDENCE AND TRUST HEALTH SYSTEM
			recode m1_302 (98=.) // this shuold be fixed in cleaning do file
	
*------------------------------------------------------------------------------*	
	* SECTION 5: BASIC DEMOGRAPHICS
	
			gen educ_cat=m1_503
			replace educ_cat = 1 if m1_502==0
			recode educ_cat (3=2) (4/5=3) 
			lab def educ_cat 1 "No education or some primary" 2 "Complete primary" 3 "Complete secondary or higher"  
			lab val educ_cat educ_cat
			char educ_cat[Module] 1
			char educ_cat[Original_ET_Varname] `m1_503[Original_ET_Varname]' (Set to 1 if `m1_502[Original_ET_Varname]' is 0)

			recode m1_505 (1/4=0) (5/6=1), gen(marriedp) 
			label define recoded_marriage 0 "Not married" 1 "Currently married/Living with partner", replace
			label value marriedp recoded_marriage
			char marriedp[Original_ET_Varname] `m1_505[Original_ET_Varname]'
			char marriedp[Module] 1

			recode m1_509b 0=1 1=0, g(mosquito)
			char mosquito[Original_ET_Varname] `m1_509b[Original_ET_Varname]'

			recode m1_510b 0=1 1=0, g(tbherb)
			char tbherb[Original_ET_Varname] `m1_510b[Original_ET_Varname]'

			recode m1_511 2=1 1=0 3/4=0, g(drink)
			char drink[Original_ET_Varname] `m1_511[Original_ET_Varname]'

			recode m1_512 2=1 1=0 3=0, g(smoke)
			char smoke[Original_ET_Varname] `m1_512[Original_ET_Varname]'
			
			egen m1_health_literacy=rowtotal(m1_509a mosquito m1_510a tbherb drink smoke), m
			char m1_health_literacy[Module] 1
			char m1_health_literacy[Original_ET_Varname] Total of `m1_509a[Original_ET_Varname]' + `mosquito[Original_ET_Varname]' + `m1_510a[Original_ET_Varname]' + `tbherb[Original_ET_Varname]' + `drink[Original_ET_Varname]' + `smoke[Original_ET_Varname]'

			recode m1_health_literacy 0/3=1 4=2 5=3 6=4
			lab def health_lit 1"Poor" 2"Fair" 3"Good" 4"Very good"
			lab val m1_health_lit health_lit
			drop mosquito tbherb drink smoke
*------------------------------------------------------------------------------*	
	* SECTION 6: USER EXPERIENCE
			label define good_poor 0 "Poor" 1 "Good",replace
			
			local vlist
			foreach v in m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f ///
			             m1_605g m1_605h m1_605i m1_605j m1_605k {
				recode `v' (2=1) (3/5=0), gen(vg`v')
				label value vg`v' good_poor
				
				char vg`v'[Module] 1
				
				local v2 `v'
				if inlist("`v'","m1_605i","m1_605j","m1_605k") local v2 `v'_et
				char vg`v'[Original_ET_Varname] ``v2'[Original_ET_Varname]'
				local vlist `vlist' & ``v2'[Original_ET_Varname]'
			}
			
			egen anc1ux=rowmean(vgm1_605a-vgm1_605k)
			char anc1ux[Module] 1
			char anc1ux[Original_ET_Varname] Mean of `vlist'

			*drop vgm1_605a-vgm1_605k
*------------------------------------------------------------------------------*	
	* SECTION 7: VISIT TODAY: CONTENT OF CARE
	
			* Technical quality of first ANC visit
			gen anc1bp = m1_700 
			char anc1bp[Original_ET_Varname] `m1_700[Original_ET_Varname]'

			gen anc1weight = m1_701 
			char anc1weight[Original_ET_Varname] `m1_701[Original_ET_Varname]'

			gen anc1height = m1_702
			char anc1height[Original_ET_Varname] `m1_702[Original_ET_Varname]'

			egen anc1bmi = rowtotal(m1_701 m1_702)
			char anc1bmi[Original_ET_Varname] `m1_701[Original_ET_Varname]' + `m1_702[Original_ET_Varname]' (Set to 0 if total = 1, Set to 1 if total = 2)
			recode anc1bmi (1=0) (2=1)
			
			gen anc1muac = m1_703
			char anc1muac[Original_ET_Varname] `m1_703[Original_ET_Varname]'
			

			gen anc1fetal_hr = m1_704
			char anc1fetal_hr[Original_ET_Varname] `m1_704[Original_ET_Varname]' (Set to missing if `m1_804[Original_ET_Varname]' set to 1 because it only applies in the 2nd or 3rd trimester)
			recode anc1fetal_hr  (2=.) 
			replace anc1fetal_hr=. if m1_804==1 // only applies to those in 2nd or 3rd trimester
			
			label define anc1fetal_hr 1 "Yes" 0 "No" 2 "Not applicable" 98 "Don't know" 99 "NR/RF", replace
			label value anc1fetal_hr  anc1fetal_hr 
			
			gen anc1urine = m1_705
			char anc1urine[Original_ET_Varname] `m1_705[Original_ET_Varname]'
			
			egen anc1blood = rowmax(m1_706 m1_707) // finger prick or blood draw
			char anc1blood[Original_ET_Varname] Max of `m1_706[Original_ET_Varname]' & `m1_707[Original_ET_Varname]'

			gen anc1hiv_test =  m1_708a
			char anc1hiv_test[Original_ET_Varname] `m1_708a[Original_ET_Varname]'

			gen anc1syphilis_test = m1_710a
			char anc1syphilis_test[Original_ET_Varname] `m1_710a[Original_ET_Varname]'

			gen anc1blood_sugar_test = m1_711a
			char anc1blood_sugar_test[Original_ET_Varname] `m1_711a[Original_ET_Varname]'

			gen anc1ultrasound = m1_712
			char anc1ultrasound[Original_ET_Varname] `m1_712[Original_ET_Varname]'

			gen anc1ifa =  m1_713a
			char anc1ifa[Original_ET_Varname] `m1_713a[Original_ET_Varname]'
			recode anc1ifa (2=1) (3=0)

			gen anc1tt = m1_714a
			char anc1tt[Original_ET_Varname] `m1_714a[Original_ET_Varname]'

			recode m1_713b (2=1) (3=0), gen(anc1calcium)
			char anc1calcium[Original_ET_Varname] `m1_713b[Original_ET_Varname]'
			label define anc1calcium 0 ""

			recode m1_713d (2=1) (3=0), gen(anc1deworm)
			char anc1deworm[Original_ET_Varname] `m1_713d[Original_ET_Varname]'

			recode m1_715 (2=.), gen(anc1itn) // ITN provision, among women who dont already have one, in kebele with malaria
			char anc1itn[Original_ET_Varname] `m1_715[Original_ET_Varname]'
			label define anc1itn 1 "Yes" 0 "No", replace
			label value anc1itn anc1itn 
			label var anc1itn "Recoded `:var label m1_715'"
			
			gen anc1depression = m1_716c // screened for depression
			char anc1depression[Original_ET_Varname] `m1_716c[Original_ET_Varname]'
			
			gen anc1edd =  m1_801
			char anc1edd[Original_ET_Varname] `m1_801[Original_ET_Varname]'
			

			egen anc1tq = rowmean(anc1bp anc1weight anc1height anc1muac anc1fetal_hr anc1urine ///
								 anc1blood anc1ultrasound anc1ifa anc1tt ) // 10 items
			char anc1tq[Original_ET_Varname] Mean of `anc1bp[Original_ET_Varname]' ///
									& `anc1weight[Original_ET_Varname]' ///
									& `anc1height[Original_ET_Varname]' ///
									& `anc1muac[Original_ET_Varname]'  ///
									& `anc1fetal_hr[Original_ET_Varname]'  ///
									& `anc1urine[Original_ET_Varname]'  ///
									& `anc1blood[Original_ET_Varname]'  ///
									& `anc1ultrasound[Original_ET_Varname]'  ///
									& `anc1ifa[Original_ET_Varname]'  ///
									& `anc1tt[Original_ET_Varname]'  
					  
			* Counselling at first ANC visit
			gen m1_counsel_nutri =  m1_716a  
			char m1_counsel_nutri[Original_ET_Varname] `m1_716a[Original_ET_Varname]'

			gen m1_counsel_exer=  m1_716b
			char m1_counsel_exer[Original_ET_Varname] `m1_716b[Original_ET_Varname]'

			gen m1_counsel_complic =  m1_716e
			char m1_counsel_complic[Original_ET_Varname] `m1_716e[Original_ET_Varname]'

			gen m1_counsel_comeback = m1_724a
			char m1_counsel_comeback[Original_ET_Varname] `m1_724a[Original_ET_Varname]'

			gen m1_counsel_birthplan =  m1_809
			char m1_counsel_birthplan[Original_ET_Varname] `m1_809[Original_ET_Varname]'

			egen anc1counsel = rowmean(m1_counsel_nutri m1_counsel_exer m1_counsel_complic ///
								m1_counsel_comeback m1_counsel_birthplan)
			
			char anc1counsel[Original_ET_Varname] Mean of `m1_counsel_nutri[Original_ET_Varname]' ///
													& `m1_counsel_exer[Original_ET_Varname]' ///
													& `m1_counsel_complic[Original_ET_Varname]' ///
													& `m1_counsel_comeback[Original_ET_Varname]' ///
													& `m1_counsel_birthplan[Original_ET_Varname]'
			
			* Q713 Other treatments/medicine at first ANC visit 
			gen anc1food_supp = m1_713c 
			char anc1food_supp[Original_ET_Varname] `m1_713c[Original_ET_Varname]'

			gen anc1mental_health_drug = m1_713f
			char anc1mental_health_drug[Original_ET_Varname] `m1_713f[Original_ET_Varname]'

			gen anc1hypertension = m1_713h
			char anc1hypertension[Original_ET_Varname] `m1_713h[Original_ET_Varname]'

			gen anc1diabetes = m1_713i
			char anc1diabetes[Original_ET_Varname] `m1_713i[Original_ET_Varname]'

			foreach v in anc1food_supp anc1mental_health_drug anc1hypertension ///
						 anc1diabetes {
					recode `v' (3=0) (2=1)
			}
			
			* Instructions and advanced care
			egen m1_specialist_hosp= rowmax(m1_724e m1_724c) 
			char m1_specialist_hosp[Original_ET_Varname] Max of `m1_724e[Original_ET_Varname]' & `m1_724c[Original_ET_Varname]'

			
			foreach v in anc1bp anc1weight anc1height anc1bmi anc1muac anc1fetal_hr anc1urine anc1blood anc1hiv_test anc1hiv_test anc1syphilis_test anc1blood_sugar_test anc1ultrasound anc1ifa anc1tt anc1tt anc1calcium anc1deworm anc1itn anc1depression anc1edd anc1edd anc1tq m1_counsel_nutri m1_counsel_exer m1_counsel_complic m1_counsel_comeback m1_counsel_birthplan anc1counsel anc1food_supp anc1mental_health_drug anc1hypertension anc1diabetes m1_specialist_hosp {
				char `v'[Module] 1
			}
			

*------------------------------------------------------------------------------*	
	* SECTION 8: CURRENT PREGNANCY
			
			gen preg_intent = m1_807
			char preg_intent[Original_ET_Varname] `m1_807[Original_ET_Varname]' 
			* Reports danger signs
			egen m1_dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d  m1_814f m1_814g)
			char m1_dangersigns[Original_ET_Varname] Max of `m1_814a[Original_ET_Varname]' ///
													& `m1_814b[Original_ET_Varname]' ///
													& `m1_814c[Original_ET_Varname]' ///
													& `m1_814d[Original_ET_Varname]' ///
													& `m1_814f[Original_ET_Varname]' ///
													& `m1_814g[Original_ET_Varname]' 

			* Asked about LMP
			gen anc1lmp= m1_806
			char anc1lmp[Original_ET_Varname] `m1_806[Original_ET_Varname]' 

			* Screened for danger signs 
			egen anc1danger_screen = rowmax(m1_815_2-m1_815_96) 
			char anc1danger_screen[Original_ET_Varname] Max of `m1_815_2[Original_ET_Varname]' `m1_815_3[Original_ET_Varname]' `m1_815_4[Original_ET_Varname]' `m1_815_5[Original_ET_Varname]' `m1_815_6[Original_ET_Varname]' `m1_815_7[Original_ET_Varname]' `m1_815_96[Original_ET_Varname]'

			replace anc1danger_screen = 0 if m1_815_other=="I told her the problem but she said nothing"
			replace anc1danger_screen= 0 if  m1_815_0==1 // did not discuss the danger sign 
			replace anc1danger_screen =  m1_816 if anc1danger_screen==.a | anc1danger_screen==.
			
			foreach v in preg_intent m1_dangersigns anc1lmp anc1danger_screen {
				char `v'[Module] 1
			}
			
*------------------------------------------------------------------------------*	
	* SECTION 9: RISKY HEALTH BEHAVIOR
			recode m1_901 (1/2=1) (3=0)
			recode m1_903  (1/2=1) (3=0)
			egen m1_risk_health = rowmax( m1_901  m1_903  m1_905)
			char m1_risk_health[Module] 1 
			char m1_risk_health[Original_ET_Varname] Max of `m1_901[Original_ET_Varname]' & `m1_903[Original_ET_Varname]' & `m1_905[Original_ET_Varname]'
			label define m1_risk_health 1 "Every day" 2 "Some days" 3 "Not at all" 98 "Don't know" 99 "NR/RF", replace
			label value m1_risk_health m1_risk_health
			
			egen m1_stop_risk = rowmax( m1_902  m1_904  m1_907)
			char m1_stop_risk[Module] 1
			char m1_stop_risk[Original_ET_Varname] Max of `m1_902[Original_ET_Varname]' & `m1_904[Original_ET_Varname]' & `m1_907[Original_ET_Varname]'

*------------------------------------------------------------------------------*	
	* SECTION 10: OBSTETRIC HISTORY
			gen nbpreviouspreg = m1_1001-1 // nb of pregnancies including current minus current pregnancy
			char nbpreviouspreg[Original_ET_Varname] `m1_1001[Original_ET_Varname]' - 1
		
			gen gravidity = m1_1001
			char gravidity[Original_ET_Varname] `m1_1001[Original_ET_Varname]' 
			
			gen primipara=  m1_1001==1 // first pregnancy
			char primipara[Original_ET_Varname] `m1_1001[Original_ET_Varname]' == 1 or `m1_1002[Original_ET_Varname]' == 0
			replace primipara = 1 if  m1_1002==0  // never gave birth
			
			gen pregloss = nbpreviouspreg-m1_1002 // nb previous pregnancies not including current minus previous births
			char pregloss[Original_ET_Varname] `nbpreviouspreg[Original_ET_Varname]' - `m1_1002[Original_ET_Varname]'
			replace pregloss =. if pregloss<0 // 6 women had more births than pregnancies
			
			gen stillbirths = m1_1002 - m1_1003 // nb of deliveries/births minus live births
			char stillbirths[Original_ET_Varname] `m1_1002[Original_ET_Varname]' - `m1_1003[Original_ET_Varname]' (Set to missing if < 0 and set to 1 if > 1 but not missing)
			replace stillbirths=. if stillbirths<0 // 6 women had more livebirths than pregnancies
			replace stillbirths = 1 if stillbirths>1 & stillbirths<.
			
			foreach v in nbpreviouspreg gravidity primipara pregloss stillbirths {
				char `v'[Module] 1
			}

*------------------------------------------------------------------------------*	
	* SECTION 12: ECONOMIC STATUS AND OUTCOMES
			
			*Asset variables
			recode  m1_1201 (2 4 6 96=0) (3=1), gen(safewater) // 96 is Roto tanks or tanker 
			recode  m1_1202 (2=1) (3=0), gen(toilet) // flush/ pour flush toilet and pit laterine =improved 
			gen electr = m1_1203
			gen radio = m1_1204
			gen tv = m1_1205
			gen phone = m1_1206
			gen refrig = m1_1207
			recode m1_1208 (3=1) (4/5=0), gen(fuel) // electricity, kerosene (improved) charcoal wood (unimproved)
			gen bicycle =  m1_1212 
			gen motorbik = m1_1213
			gen car = m1_1214 
			gen bankacc = m1_1215
			recode m1_1209 (96 1=0) (2/3=1), gen(floor) // Earth, dung (unimproved) wood planks, palm, polished wood and tiles (improved)
			recode m1_1210 (1 2 5=0) (3/4 6/8=1) (96=0), gen(wall) // Grass, timber, poles, mud  (unimproved) bricks, cement, stones (improved)
			recode m1_1211 (1/2=0) (3/5=1) (96=.), gen(roof)  // Iron sheets, Tiles, Concrete (improved) grass, leaves, mud, no roof (unimproved)
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
			
			foreach v in wealthindex quintile tertile {
				char `v'[Original_ET_Varname] `m1_1201[Original_ET_Varname]' /// 
											& `m1_1202[Original_ET_Varname]' /// 
											& `m1_1203[Original_ET_Varname]' /// 
											& `m1_1204[Original_ET_Varname]' /// 
											& `m1_1205[Original_ET_Varname]' /// 
											& `m1_1206[Original_ET_Varname]' /// 
											& `m1_1207[Original_ET_Varname]' /// 
											& `m1_1208[Original_ET_Varname]' /// 
											& `m1_1212[Original_ET_Varname]' /// 
											& `m1_1213[Original_ET_Varname]' /// 
											& `m1_1214[Original_ET_Varname]' /// 
											& `m1_1215[Original_ET_Varname]' /// 
											& `m1_1209[Original_ET_Varname]' /// 
											& `m1_1210[Original_ET_Varname]' /// 
											& `m1_1211[Original_ET_Varname]'
			}
			
			gen m1_registration_cost= m1_1218a_1 // registration
				replace m1_registration = . if m1_registr==0
				char m1_registration_cost[Original_ET_Varname] `m1_1218a_1[Original_ET_Varname]' (Set to missing if `m1_1218a_1[Original_ET_Varname]' is 0)

			gen m1_med_vax_cost =  m1_1218b_1 // med or vax
				replace m1_med_vax_cost = . if m1_med_vax_cost==0
				char m1_med_vax_cost[Original_ET_Varname] `m1_1218b_1[Original_ET_Varname]' (Set to missing if `m1_1218b_1[Original_ET_Varname]' is 0)

			gen m1_labtest_cost =  m1_1218c_1 // lab tests
				replace m1_labtest_cost= . if m1_labtest_cost==0
				char m1_labtest_cost[Original_ET_Varname] `m1_1218c_1[Original_ET_Varname]' (Set to missing if `m1_1218c_1[Original_ET_Varname]' is 0)

			egen m1_indirect_cost = rowtotal (m1_1218d_1 m1_1218e_1 m1_1218f_1 )
				replace m1_indirect = . if m1_indirect==0
				char m1_indirect_cost[Original_ET_Varname] `m1_1218d_1[Original_ET_Varname]' ///
															+ `m1_1218e_1[Original_ET_Varname]' ///
															+ `m1_1218f_1[Original_ET_Varname]' ///
															(Set to missing if total is 0)

				
			foreach v in m1_registration_cost m1_med_vax_cost m1_labtest_cost m1_indirect_cost tertile quintile wealthindex {
				char `v'[Module] 1
			}
	
*------------------------------------------------------------------------------*	
	* SECTION 13: HEALTH ASSESSMENTS AT BASELINE

			* High blood pressure (HBP)
			egen systolic_bp= rowmean(m1_bp_time_1_systolic m1_bp_time_2_systolic m1_bp_time_3_systolic)
			egen diastolic_bp= rowmean(m1_bp_time_1_diastolic m1_bp_time_2_diastolic m1_bp_time_3_diastolic)
			gen systolic_high = 1 if systolic_bp >=140 & systolic_bp <.
			replace systolic_high = 0 if systolic_bp<140
			gen diastolic_high = 1 if diastolic_bp>=90 & diastolic_bp<.
			replace diastolic_high=0 if diastolic_high <90
			egen m1_HBP= rowmax (systolic_high diastolic_high)
			char m1_HBP[Original_ET_Varname] max of the mean of (`m1_bp_time_1_systolic[Original_ET_Varname]', `m1_bp_time_2_systolic[Original_ET_Varname]', `m1_bp_time_3_systolic[Original_ET_Varname]') and mean of (`m1_bp_time_1_diastolic[Original_ET_Varname]', `m1_bp_time_2_diastolic[Original_ET_Varname]', `m1_bp_time_3_diastolic[Original_ET_Varname]') 

			drop systolic* diastolic*
			
			* Anemia 
			gen m1_Hb= m1_1309 // test done by E-Cohort data collector
			char m1_Hb[Original_ET_Varname] `m1_1309[Original_ET_Varname]'
			
			gen Hb_card= m1_1307 // hemoglobin value taken from the card
			replace Hb_card=11.3 if Hb_card==113
			replace m1_Hb = Hb_card if m1_Hb==.a // use the card value if the test wasn't done
				// Reference value of 11 from: 2022 Ethiopian ANC guidelines ≥ 11 gm/dl is normal.
			char Hb_card[Original_ET_Varname] `m1_1309[Original_ET_Varname]' (If test was not completed uses `m1_1307[Original_ET_Varname]') 
	
				
			recode m1_Hb (0/10.9999=1) (11/30=0), gen(m1_anemic_11)
			drop Hb_card
			recode m1_Hb (0/6.9999=1) (7/30=0), gen(m1_anemic_7)
			char m1_anemic_11[Original_ET_Varname] `m1_Hb[Original_ET_Varname]' 
			char m1_anemic_7[Original_ET_Varname] `m1_Hb[Original_ET_Varname]' 
		
		

			* MUAC
			recode m1_muac (999=.)
			gen m1_malnutrition = 1 if m1_muac<23
			replace m1_malnutrition = 0 if m1_muac>=23 & m1_muac<.
			char m1_malnutrition[Original_ET_Varname] `m1_muac[Original_ET_Varname]' 

			* BMI 
			gen m1_height_m = m1_height_cm/100
			char m1_height_m[Original_ET_Varname] `m1_height_cm[Original_ET_Varname]'/100 

			gen m1_BMI = m1_weight_kg / (m1_height_m^2)
			char m1_BMI[Original_ET_Varname] `m1_weight_kg[Original_ET_Varname]' / (`m1_height_m[Original_ET_Varname]' ^2)

			gen m1_low_BMI= 1 if m1_BMI<18.5 
			replace m1_low_BMI = 0 if m1_BMI>=18.5 & m1_BMI<.
			char m1_low_BMI[Original_ET_Varname] Set to 1 if `m1_BMI[Original_ET_Varname]' < 18.5 (Set to 0 if m1_BMI >= 18.5 and not missing)


			foreach v in m1_HBP m1_Hb m1_malnutrition m1_height_m m1_BMI m1_low_BMI m1_anemic_11 m1_anemic_7 {
				char `v'[Module] 1
			}
			
*------------------------------------------------------------------------------*
   * SECTION 14 : M3 M4 M5 birth outcome development

		* 1. Create new variables 
			* Create pregnancyend_ga to indicate GA at the end of pregnancy
			gen time_between_m1_birth = (m3_birth_or_ended - m1_date)/7
			gen pregnancyend_ga = m1_ga + time_between_m1_birth          
			char time_between_m1_birth[Module]  3
			char pregnancyend_ga[Module] 3
			char time_between_m1_birth[Original_ET_Varname] (`m3_birth_or_ended[Original_ET_Varname]' - `m1_date[Original_ET_Varname]') / 7  
			char pregnancyend_ga[Original_ET_Varname] (`m1_ga[Original_ET_Varname]' + `time_between_m1_birth[Original_ET_Varname]')  

			* Create preterm birth to indicate birth before GA 37 
			gen preterm_birth = 1 if pregnancyend_ga <37 
			replace preterm_birth = 0 if pregnancyend_ga >=37 & pregnancyend_ga <.
			char preterm_birth[Module] 3 
			char preterm_birth[Original_ET_Varname] `pregnancyend_ga[Original_ET_Varname]'  < 37 
			* Create m3_deathage_dys_baby1, m3_deathage_dys_baby2, m3_deathage_dys_baby3 to indicate newborn death age (days). m3_313a_baby1, m3_313a_baby2, m3_313a_baby3: death dates for baby1 baby2 baby3
			
			gen m3_deathage_dys_baby1 = m3_313a_baby1 - m3_birth_or_ended if m3_baby1_born_alive==1 
			char m3_deathage_dys_baby1[Original_ET_Varname] `m3_313a_baby1[Original_ET_Varname]' - `m3_birth_or_ended[Original_ET_Varname]' (if `m3_baby1_born_alive[Original_ET_Varname]' is 1)
			char m3_deathage_dys_baby1[Module] 3
			label var m3_deathage_dys_baby1  "Baby 1: Age at death in days (m3_313a_baby1 - m3_birth_or_ended if m3_baby1_born_alive == 1)"

			
			gen m3_deathage_dys_baby2 = m3_313a_baby2 - m3_birth_or_ended if m3_baby2_born_alive==1 
			label var m3_deathage_dys_baby2 "Baby 2: Age at death in days (m3_313a_baby2 - m3_birth_or_ended if m3_baby2_born_alive == 1)"

			char m3_deathage_dys_baby2[Original_ET_Varname] `m3_313a_baby2[Original_ET_Varname]' - `m3_birth_or_ended[Original_ET_Varname]' (if `m3_baby2_born_alive[Original_ET_Varname]' is 1)
			char m3_deathage_dys_baby2[Module] 3

			gen m3_deathage_dys_baby3 = m3_313a_baby3 - m3_birth_or_ended if m3_baby3_born_alive==1
			char m3_deathage_dys_baby3[Original_ET_Varname] `m3_313a_baby3[Original_ET_Varname]' - `m3_birth_or_ended[Original_ET_Varname]' (if `m3_baby3_born_alive[Original_ET_Varname]' is 1)
			char m3_deathage_dys_baby3[Module] 3
			
			label var m3_deathage_dys_baby3 "Baby 3: Age at death in days (m3_313a_baby3 - m3_birth_or_ended if m3_baby3_born_alive == 1)"
		
		
		* 2. Create birth outcome variable
			gen birth_outcome = .
			char birth_outcome[Original_ET_Varname] Based if completed entire survey and when pregnancy ends
			char birth_outcome[Module] 3

			replace birth_outcome = 1 if m2_date_r1 ==. & (m3_date ==.a | m3_date ==.)                             			  // LTFU after M1 
			replace birth_outcome = 2 if m2_date_r1 !=. & (m3_date ==.a | m3_date ==.)                      		          // LTFU after M2, these m3_date for these two id (1690-45, 1707-30) should be .1 not . 
			replace birth_outcome = 3 if (m3_303b==1 & m3_303c==.a & m3_303d ==.a)                             				  // live birth singletone  
			replace birth_outcome = 4 if (m3_303b==1 & m3_303c==1  & m3_303d ==.a)                             				  // live birth twin  
			replace birth_outcome = 5 if (m3_303b==1 & m3_303c==1  & m3_303d ==1)                                			  // live birth triplet
			replace birth_outcome = 6 if m3_baby1_born_alive==0 & pregnancyend_ga <13                             			  // early miscarraige       
			replace birth_outcome = 7 if m3_baby1_born_alive==0 & (pregnancyend_ga <28 & pregnancyend_ga >=13)                // late miscarraige 
			replace birth_outcome = 8 if m3_baby1_born_alive==0 & (pregnancyend_ga >= 28 & pregnancyend_ga <.)                // stillbirth 
			replace birth_outcome = 9 if m3_deathage_dys_baby1 <28                                                            // neonatal death  
			replace birth_outcome = 10 if m3_deathage_dys_baby1 >=28 & m3_deathage_dys_baby1 !=.                              // infant death
			replace birth_outcome = 11 if (m3_303b==1 & m3_303c==0) & (m3_baby2_born_alive == 1 & m3_deathage_dys_baby2 < 28) // twin set (1 alive 1 neonatal death)
			replace birth_outcome = 11 if (m3_303b==0 & m3_303c==1) & (m3_baby1_born_alive == 1 & m3_deathage_dys_baby1 < 28) // twin set (1 alive 1 neonatal death) 
			
			* Mannually edited outcome 
			replace birth_outcome = 2 if redcap_record_id == "1707-4"   // 1707-4: LTFU after M2 (based on email from Tefera on July 25) 	
			replace birth_outcome = 6 if redcap_record_id == "1702-12"  // 1702-12: m2_202_r1 = something happened but not move to m3. m1_ga = 7. no m3_birth_or_ended,no pregnancyend_ga.m1_date m2_date_r1:6 wks apart,fetal loss must happen<GA13(7+6)  
			replace birth_outcome = 7 if redcap_record_id == "1701-48"  // 1701-48, missing m3_birth_or_ended, m1_ga = 19.1, m1_date 04may2023 m3_date 09jun2023 (around 5 weeks) 19.1 + 5 = 24.1. Outcome should be late miscarriage 
			replace birth_outcome = 7 if redcap_record_id == "1700-14"  // 1701-14, missing m1_ga, mcard_ga_lmp = 12, time_between_m1_birth = 11 weeks, 12 + 11 = 23 weeks. Outcome should be late miscarrigae 
			replace birth_outcome = 9 if redcap_record_id == "1708-36"  // 1708-36: m3_birth_or_ended: 11/23/2023. Baby was born alive but is not alive. Based on Tefera (July 25), this case died on 11/26/2023. Outcome is early neonatal death.  
			replace birth_outcome = 7 if redcap_record_id == "1701-40"  // 1701-40: could not decide early or late miscarraige, for now assign this id to late miscarraige 
			replace birth_outcome = 11 if redcap_record_id == "1709-57" // 1709-57, one of the twin died in M3 part 2 but alive in M3 part 1. (m3_birth_or_ended: 9/17/2023, m3_date: 9/25/2023, m3_date_p2: 10/10/2023, died between 1 to 3 weeks)

			* Label birth_outcome 
			label define birth_outcome 1 "LTFU after M1" 2 "LTFU after M2" 3 "LB singleton" 4 "LB twin" 5 "LB triplet" 6 "early miscarriage" 7 "late miscarraige" ///
									   8 "stillbirth" 9 "neonatal death" 10 "infant death" 11 "twin 1 alive 1 neonatal death" 12  "twin 1 alive 1 stillbirth" 13 "twin both neonatal death"  
			label values birth_outcome birth_outcome
			lab var birth_outcome "Birth outcome at M3"
			tab birth_outcome, missing  

		* 3. Create M3_maternal_outcome 
			gen M3_maternal_outcome = . 
			char M3_maternal_outcome[Original_ET_Varname] Based on birth outcome
			char M3_maternal_outcome[Module] 3
			
			replace M3_maternal_outcome = 1 if birth_outcome == 1 
			replace M3_maternal_outcome = 2 if birth_outcome == 2 
			replace M3_maternal_outcome = 4 if birth_outcome == 3 | birth_outcome == 4 | birth_outcome == 5 | birth_outcome == 6 | birth_outcome == 7 | birth_outcome == 8 | ///
											   birth_outcome == 9 | birth_outcome == 10 | birth_outcome == 11  | birth_outcome == 12 | birth_outcome == 13   
			replace M3_maternal_outcome = 3 if redcap_record_id == "1711-24" // based on email from Tefera on Oct 1, maternal death happened in M2 
			replace M3_maternal_outcome = 3 if redcap_record_id == "1692-18" // based on email from Tefera on Oct 1, maternal death identified in second part of M3 

			* Label M3_maternal_outcome 
			label define m3_maternal_outcome  1 "LTFU after M1" 2 "LTFU after M2" 3 "Maternal death" 4 "Maternal alive"
			label values M3_maternal_outcome m3_maternal_outcome  
			lab var M3_maternal_outcome "Maternal outcome at M3"
			tab M3_maternal_outcome , missing  
			
		* 4. Create M4 outcome
			gen M4_outcome =.
			char M4_outcome[Module] 4
			char M4_outcome[Original_ET_Varname] Based on birth outcome and baby status
			replace M4_outcome = 1 if birth_outcome == 1                                                   // LTFU after M1
			replace M4_outcome = 2 if birth_outcome == 2                                                   // LTFU after M2
			replace M4_outcome = 5 if m4_baby1_status == 1 & m4_baby2_status == .a & m4_baby3_status == .a // live birth singleton
			replace M4_outcome = 6 if m4_baby1_status == 1 & m4_baby2_status ==  1 & m4_baby3_status == .a // live birth twin
			replace M4_outcome = 7 if m4_baby1_status == 1 & m4_baby2_status ==  1 & m4_baby3_status == 1  // live birth triplet 
			replace M4_outcome = 8 if birth_outcome ==11 & (m4_baby1_status==0 & m4_baby2_status ==1)      // twin set with 1 neonatal death and 1 alive (same as M3 outcome)
			replace M4_outcome = 8 if birth_outcome ==11 & (m4_baby1_status==1 & m4_baby2_status ==0)      // twin set with 1 neonatal death and 1 alive (same as M3 outcome) 
			replace M4_outcome = 3 if (birth_outcome == 3 | birth_outcome == 4 | birth_outcome == 5 | birth_outcome == 11) & m4_baby1_status ==.                     // LTFU afte M3 
			replace M4_outcome = 4 if birth_outcome == 6 | birth_outcome == 7 | birth_outcome == 8 | birth_outcome == 9 | birth_outcome == 10 | birth_outcome == 13  // survey ended 		
			replace M4_outcome = 3 if redcap_record_id == "1710-3" 										   // LTFU after M3, based on email from Tefera on July 25
			replace M4_outcome = 12 if redcap_record_id == "1686-16"                                       // infant death (M3 birth_outcome = live birth singleton) but died at 50 days old 

			* Label M4_outcome 							
			label define m4_outcome 1 "LTFU after M1" 2 "LTFU after M2" 3 "LTFU after M3" 4 "survey ended" 5 "LB singleton" 6 "LB twin" 7 "LB triplet" 8 "twin 1 alive 1 neonatal death" ///
									9 "twin 1 alive 1 stillbirth" 10 "twin both neonatal death" 11 "neonatal death" 12 "infant death" 
								
			label values M4_outcome m4_outcome
			lab var M4_outcome "Birth outcome at M4"
			tab M4_outcome, missing  
			
		* 5. Create M5 outcome
			* Create m5_deathage_dys_baby1, m5_deathage_dys_baby2, m5_deathage_dys_baby3 to indicate newborn death age (days) for baby1 baby2 baby3    
			gen m5_deathage_dys_baby1 = m5_baby1_death_date - m3_birth_or_ended 
			gen m5_deathage_dys_baby2 = m5_baby2_death_date - m3_birth_or_ended 
			gen m5_deathage_dys_baby3 = m5_baby3_death_date - m3_birth_or_ended 
			
			label var m5_deathage_dys_baby1  "Baby 1: Age at death in days (m5_baby1_death_date - m3_birth_or_ended)"
			char m5_deathage_dys_baby1[Original_ET_Varname] `m5_baby1_death_date[Original_ET_Varname]' - `m3_birth_or_ended[Original_ET_Varname]'
			char m5_deathage_dys_baby1[Module] 5

			label var m5_deathage_dys_baby2  "Baby 2: Age at death in days (m5_baby2_death_date - m3_birth_or_ended)"
			char m5_deathage_dys_baby2[Original_ET_Varname] `m5_baby2_death_date[Original_ET_Varname]' - `m3_birth_or_ended[Original_ET_Varname]'
			char m5_deathage_dys_baby2[Module] 5

			label var m5_deathage_dys_baby3  "Baby 3: Age at death days (m5_baby3_death_date - m3_birth_or_ended)"
			char m5_deathage_dys_baby3[Original_ET_Varname] `m5_baby3_death_date[Original_ET_Varname]' - `m3_birth_or_ended[Original_ET_Varname]'
			char m5_deathage_dys_baby3[Module] 5

			* Create M5_outcome
			gen M5_outcome =.
			char M5_outcome[Module] 5
			char M5_outcome[Original_ET_Varname] Based on M4 outcome, baby alive, death age in days and M5 date.
			replace M5_outcome = 1 if M4_outcome == 1                                                                      // LTFU after M1
			replace M5_outcome = 2 if M4_outcome == 2                                                                      // LTFU after M2
			replace M5_outcome = 3 if M4_outcome == 3 & (m5_date ==. | m5_date ==.a)                                       // LTFU after M3
			replace M5_outcome = 3 if M4_outcome == 3 & (redcap_record_id == "1710-3")                                     // LTFU after M3, based on email from Tefera on July 25
			replace M5_outcome = 4 if (M4_outcome == 5 | M4_outcome == 6 | M4_outcome == 7) & (m5_date ==. | m5_date ==.a) // LTFU after M4 
			replace M5_outcome = 5 if M4_outcome == 4 | M4_outcome == 12                                                   // survey ended 
			replace M5_outcome = 6 if m5_baby1_alive==1 & m5_baby2_alive==.a & m5_baby3_alive ==.a                         // live baby singleton
			replace M5_outcome = 7 if m5_baby1_alive==1 & m5_baby2_alive== 1 & m5_baby3_alive ==.a                         // live babies twin 
			replace M5_outcome = 8 if m5_baby1_alive==1 & m5_baby2_alive== 1 & m5_baby3_alive == 1                         // live babies triplet
			replace M5_outcome = 9 if M4_outcome == 8 & (m5_baby1_alive==1 & m5_baby2_alive== 0 & m5_baby3_alive ==.a)     // twin set 1 alive 1 neonatal death 
			replace M5_outcome = 9 if M4_outcome == 8 & (m5_baby1_alive==0 & m5_baby2_alive== 1 & m5_baby3_alive ==.a)     // twin set 1 alive 1 neonatal death  
			replace M5_outcome = 12 if m5_baby1_alive==0 & (m5_deathage_dys_baby1 >=28 & m5_deathage_dys_baby1 !=.)        // infant death 
			
			* Label M5_outcome 						
			label define m5_outcome 1 "LTFU after M1" 2 "LTFU after M2" 3 "LTFU after M3" 4 "LTFU after M4" 5 "survey ended" 6 "LB singleton" 7 "LB twin" 8 "LB triplet" /// 
									9 "twin 1 alive 1 neonatal death" 10 "twin 1 alive 1 stillbirth" 11 "twin both neonatal death" 12 "infant death"					
			
			label values M5_outcome m5_outcome
			lab var M5_outcome "Birth outcome at M5"
			tab M5_outcome, missing 

		* 6. Create M5_maternal_outcome 
			gen M5_maternal_outcome = .  
			char M5_maternal_outcome[Module] 5
			char M5_maternal_outcome[Original_ET_Varname] Based on M5_outcome and M3_maternal_outcome
			replace M5_maternal_outcome = 1 if M5_outcome == 1 
			replace M5_maternal_outcome = 2 if M5_outcome == 2 
			replace M5_maternal_outcome = 3 if M5_outcome == 3 
			replace M5_maternal_outcome = 4 if M5_outcome == 4 
			replace M5_maternal_outcome = 5 if M5_outcome == 5 
			replace M5_maternal_outcome = 7 if M5_outcome == 6 | M5_outcome == 7 | M5_outcome == 8 | M5_outcome == 9 | M5_outcome == 10  | M5_outcome == 11 | M5_outcome == 12          
			replace M5_maternal_outcome = 6 if redcap_record_id == "1707-16" // based on email from Tefera on Oct 1, maternal death identified in M5  
			replace M5_maternal_outcome = 6 if M3_maternal_outcome == 3 
			
			* Label M5_maternal_outcome 
			label define m5_maternal_outcome 1 "LTFU after M1" 2 "LTFU after M2" 3 "LTFU after M3" 4 "LTFU after M4" 5 "survey ended" 6 "Maternal death" 7 "Maternal alive"
			label values M5_maternal_outcome m5_maternal_outcome  
			lab var M5_maternal_outcome "Maternal outcome at M5"
			tab M5_maternal_outcome, missing  

*------------------------------------------------------------------------------*	
* Labelling new variables 
	lab var facility_own "Facility ownership"
	lab var m1_phq9_cat "PHQ9 Depression level Based on sum of all 9 items"
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
	lab var anc1tq "Technical quality score 1st ANC"
	lab var m1_counsel_nutri "Counselled about proper nutrition at ANC1"
	lab var m1_counsel_exer "Counselled about exercise at ANC1"
	lab var m1_counsel_complic  "Counselled about signs of pregnancy complications"
	lab var m1_counsel_birthplan "Counselled on birth plan at ANC1"
	lab var anc1counsel "Counselling quality score 1st ANC"
	lab var m1_specialist_hosp  "Told to go see a specialist or to go to hospital for ANC"
	lab var m1_dangersigns "Experienced at least one danger sign so far in pregnancy"
	lab var pregloss "Number of pregnancy losses (Nb pregnancies > Nb births)"
	lab var m1_HBP "High blood pressure at 1st ANC"
	lab var m1_anemic_11 "Anemic (Hb <11.0)"
	*lab var anemic_12 "Anemic (Hb <12.0)"
	lab var m1_height_m "Height in meters"
	lab var m1_malnutrition "Acute malnutrition MUAC<23"
	lab var m1_BMI "Body mass index"
	lab var m1_low_BMI "BMI below 18.5 (low)"
	lab var anc1depression "Screened for depression during ANC1"
	lab var anc1mental_health_drug "Given or prescribed SSRIs during ANC1"
	lab var anc1hypertension "Given or prescribed hypertension medicine during ANC1"
	lab var anc1diabetes "Given or prescribed diabetes medicine during ANC1" 
	lab var anc1lmp "Asked about date of last menstrual period"
	lab var anc1ux "User experience score during 1st ANC visit"
	*** labeled by Wen-Chien (April 19)
	lab var educ_cat "Education level category"
	lab var facility_lvl "Facility level"
	lab var facility_own "Facility ownership (public versus private)"
	lab var m1_phq2_cat "PHQ2 depression level based on sum of 2 items"
	lab var m1_phq9_cat "PHQ9 depression level based on sum of 9 items"
	lab var anc1bp "BP measured at 1st ANC visit"
	lab var anc1weight "Weight measured at 1st ANC visit"
	lab var anc1height "Height measured at 1st ANC visit"
	lab var anc1bmi "BMI measured at 1st ANC visit"
	lab var anc1muac "MUAC measured at 1st ANC visit"
	lab var anc1fetal_hr "Fetal heart rate measured at 1st ANC visit"
	lab var anc1urine "Urine test taken at 1st ANC visit"
	lab var anc1blood "Blood test taken at 1st ANC visit"
	lab var anc1hiv_test "HIV test taken at 1st ANC visit"
	lab var anc1syphilis_test "Syphilis test taken at 1st ANC visit"
	lab var anc1blood_sugar_test "Blood sugar test taken at 1st ANC visit"
	lab var anc1ultrasound "Ultrasound performed at 1st ANC visit (11 items)"
	lab var anc1ifa "IFA given at 1st ANC visit" 
	lab var anc1tt "TT vaccination given at 1st ANC visit"
	lab var anc1depression "Anxiety or depression discussed at 1st ANC visit"
	lab var anc1edd "Estimated due date told by provider at 1st ANC visit"
	lab var anc1food_supp "Food supplement given at 1st ANC visit" 
	lab var anc1mental_health_drug "Mental health drug given at 1st ANC visit"
	lab var anc1hypertension "Medicines for hypertension given at 1st ANC visit"
	lab var anc1diabetes "Medicines for diabetes given at 1st ANC visit"
	lab var anc1lmp "Last menstrual perioid asked by provider at 1st ANC visit"
	lab var anc1danger_screen "Danger signs screened at 1st ANC visit"
	lab var m1_health_literacy "Health literacy score"
	lab var nbpreviouspreg "The number of previous pregnancies"
	lab var gravidity "How many pregnancies have you had, including the current pregnancy?"
	lab var primipara "First time pregnancy"
	lab var stillbirths "The number of stillbirths"
	lab var preg_intent "The pregnancy was intended"
	lab var m1_Hb "Hemoglobin level from test performed by data collector"
	lab var m1_registration_cost "The amount of money spent on registration / consultation"
	lab var m1_med_vax_cost "The amount of money spent for medicine/vaccines"
	lab var m1_labtest_cost "The amounr of money spent on test/investigations (x-ray, lab, etc.)"
	lab var m1_indirect_cost "Indirect cost, including transport, accommodation, and other"
	lab var m1_counsel_comeback "Counselled about coming back for ANC visit"
	
	order facility_own facility_lvl, after(facility)
	
	order order m1_phq9_cat-m1_low_BMI, after(m1_trimester)
	
save "$et_data_final/eco_m1-m5_et_wide_der.dta", replace
	