* MNH: ECohorts derived variable creation (India)
* Updated April, 2024
* C Arsenault

/*
	This file creates derived variables for analysis from the MNH ECohorts India dataset. 
*/


/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
* 2024-09-17	1.01	MK Trimner		Commented out the file to use and saving command so that it can be called by the latest module
* 2024-11-13	1.02	MK Trimner		Added code to add the appropriate modules for codebook purposes
********************************************************************************/

*u "$in_data_final/eco_m1_in.dta", clear

*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
	recode facility (8 9 10 = 1 "JRP")(1 2 3 4 5 6 24=2 "JUP")(11 12=3 "JUS")(14 15 23=4 "JRS") ///
	(20 38 39 =5 "SUS")(26=6 "SRS")(25 27 28 29 30 31 32 33 18 34=7 "SRP")(35 36 37 = 8 "SUP"), g (facility_type)
 
	char facility_type[Module] `facility[Module]'
	char facility_type[Original_IN_Varname] `facility[Original_IN_Varname]'

	recode facility_type (1 4=1 "Rural_Jodhpur") (2 3=2 "Urban_Jodhpur") (6 7=3 "Sonipath_Rural") ///
	(8 5=4 "Sonipath_Urban"), gen (residence)
	
	char residence[Module] `facility_type[Module]'
	char residence[Original_IN_Varname] `facility_type[Original_IN_Varname]'

		
	order facility_type, after(facility)
	
	recode facility_type (1 4 6 7=0) (2/3 5 8  =1), g(urban)
	lab def urban 1"urban" 0"rural" 
	lab val urban urban
	
	char urban[Module] `facility_type[Module]'
	char urban[Original_IN_Varname] `facility_type[Original_IN_Varname]'

	
	recode facility_type (1/2 7/8=1) (3/6=2), g(facility_lvl)
	lab def facility_lvl 1"Primary" 2"Secondary"
	lab val facility_lvl facility_lvl 
	
	char facility_lvl[Module] `facility_type[Module]'
	char facility_lvl[Original_IN_Varname] `facility_type[Original_IN_Varname]'

	recode study_site (2=1 "Sonipat") (3=2 "Jodhpur"), g(state)
	char state[Module] `study_site[Module]'
	char state[Original_IN_Varname] `study_site[Original_IN_Varname]'

*------------------------------------------------------------------------------*	
	* SECTION 2: HEALTH PROFILE
			egen phq9_cat = rowtotal(phq9*)
			recode phq9_cat (0/4=1) (5/9=2) (10/14=3) (15/19=4) (20/27=5)
			label define phq9_cat 1 "none-minimal 0-4" 2 "mild 5-9" 3 "moderate 10-14" ///
			                        4 "moderately severe 15-19" 5 "severe 20+" 
			label values phq9_cat phq9_cat
			
			char phq9_cat[Module] 1
			foreach v of varlist phq9* {
				char phq9_cat[Original_IN_Varname] `phq9_cat[Original_IN_Varname]' & ``v'[Original_IN_Varname]'
			}

			egen phq2_cat= rowtotal(phq9a phq9b)
			recode phq2_cat (0/2=0) (3/6=1)	
			char phq2_cat[Module] 1
			char phq2_cat[Original_IN_Varname] `phq9a[Original_IN_Varname]' & `phq9b[Original_IN_Varname]'

			
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
			
			char educ_cat[Module] `m1_503[Module]'
			char educ_cat[Original_IN_Varname]  `m1_503[Original_IN_Varname]' (Set to 1 if `m1_502[Original_IN_Varname]' is 0 )

			
			recode m1_505 (1/4=0) (5/6=1), gen(marriedp) 
			char marriedp[Module] `m1_505[Module]'
			char marriedp[Original_IN_Varname]  `m1_505[Original_IN_Varname]'
			
			recode m1_509b 0=1 1=0, g(mosquito)
			char mosquito[Original_IN_Varname] `m1_509b[Original_IN_Varname]'

			recode m1_510b 0=1 1=0, g(tbherb)
			char tbherb[Original_IN_Varname] `m1_510b[Original_IN_Varname]'

			recode m1_511 1=0 2=1 3/4=0, g(drink)
			char drink[Original_IN_Varname] `m1_511[Original_IN_Varname]'

			recode m1_512 1=0 2=1 3=0, g(smoke)
			char smoke[Original_IN_Varname] `m1_512[Original_IN_Varname]'

			
			egen m1_health_literacy=rowtotal(m1_509a mosquito m1_510a tbherb drink smoke), m
			recode m1_health_literacy 0/3=1 4=2 5=3 6=4
			lab def health_lit 1"Poor" 2"Fair" 3"Good" 4"Very good"
			lab val m1_health_lit health_lit
			
			char m1_health_literacy[Module] 1
			char m1_health_literacy[Original_IN_Varname] Total of `m1_509a[Original_IN_Varname]' + `mosquito[Original_IN_Varname]' + `m1_510a[Original_IN_Varname]' + `tbherb[Original_IN_Varname]' + `drink[Original_IN_Varname]' + `smoke[Original_IN_Varname]'

			foreach v in marriedp mosquito tbherb drink smoke {
				char `v'[Module] 1
			}

*------------------------------------------------------------------------------*	
	* SECTION 6: USER EXPERIENCE
			local vlist
			foreach v in m1_601 m1_605a m1_605b m1_605c m1_605d m1_605e m1_605f ///
			             m1_605g m1_605h {
				recode `v' (2=1) (3/5=0), gen(vg`v')
				char vg`v'[Module] 1
				
				char vg`v'[Original_IN_Varname] ``v'[Original_IN_Varname]'
				local vlist `vlist' & ``v'[Original_IN_Varname]'
			}
			
			egen anc1ux=rowmean(vgm1_605a-vgm1_605h) // this is different than ETH!
			char anc1ux[Module] 1
			char anc1ux[Original_IN_Varname] Mean of `vlist'

*------------------------------------------------------------------------------*	
	* SECTION 7: VISIT TODAY: CONTENT OF CARE
	
			* Technical quality of first ANC visit
			gen anc1bp = m1_700 
			char anc1bp[Original_IN_Varname] `m1_700[Original_IN_Varname]'

			gen anc1weight = m1_701 
			char anc1weight[Original_IN_Varname] `m1_701[Original_IN_Varname]'

			gen anc1height = m1_702
			char anc1height[Original_IN_Varname] `m1_702[Original_IN_Varname]'
		
			egen anc1bmi = rowtotal(m1_701 m1_702)
			char anc1bmi[Original_IN_Varname] `m1_701[Original_IN_Varname]' + `m1_702[Original_IN_Varname]' (Set to 0 if total = 1, Set to 1 if total = 2)
			recode anc1bmi (1=0) (2=1)
			
			gen anc1muac = m1_703
			char anc1muac[Original_IN_Varname] `m1_703[Original_IN_Varname]'
		
			gen anc1fetal_hr = m1_704
			char anc1fetal_hr[Original_IN_Varname] `m1_704[Original_IN_Varname]' (Set to missing if `m1_804[Original_IN_Varname]' is 1 or missing because it only applies in the 2nd or 3rd trimester)			
			recode anc1fetal_hr  (2=.) 
			replace anc1fetal_hr=. if m1_804==1 | m1_804==. // only applies to those in 2nd or 3rd trimester
			
			gen anc1urine = m1_705
			char anc1urine[Original_IN_Varname] `m1_705[Original_IN_Varname]'

			egen anc1blood = rowmax(m1_706 m1_707) // finger prick or blood draw
			char anc1blood[Original_IN_Varname] Max of `m1_706[Original_IN_Varname]' & `m1_707[Original_IN_Varname]'

			gen anc1hiv_test =  m1_708a
			char anc1hiv_test[Original_IN_Varname] `m1_708a[Original_IN_Varname]'

			gen anc1syphilis_test = m1_710a
			char anc1syphilis_test[Original_IN_Varname] `m1_710a[Original_IN_Varname]'

			gen anc1blood_sugar_test = m1_711a
			char anc1blood_sugar_test[Original_IN_Varname] `m1_711a[Original_IN_Varname]'

			gen anc1ultrasound = m1_712
			char anc1ultrasound[Original_IN_Varname] `m1_712[Original_IN_Varname]'


			gen anc1ifa =  m1_713a
			char anc1ifa[Original_IN_Varname] `m1_713a[Original_IN_Varname]'
			recode anc1ifa (2=1) (3=0)
			
			gen anc1tt = m1_714a
			char anc1tt[Original_IN_Varname] `m1_714a[Original_IN_Varname]'
	
			gen anc1calcium = m1_713b
			char anc1calcium[Original_IN_Varname] `m1_713b[Original_IN_Varname]'
			recode anc1calcium (2=1) (3=0)

			gen anc1deworm= m1_713d
			char anc1deworm[Original_IN_Varname] `m1_713d[Original_IN_Varname]' (Set to missing if `m1_804[Original_IN_Varname]' is 1)
			recode anc1deworm (2=1) (3=0) 
			replace anc1deworm =. if m1_804 ==1
			
			recode m1_715 (2=1), gen(anc1itn)
			char anc1itn[Original_IN_Varname] `m1_715[Original_IN_Varname]'

			gen anc1depression = m1_716c
			char anc1depression[Original_IN_Varname] `m1_716c[Original_IN_Varname]'

			gen anc1malaria_proph =  m1_713e
			char anc1malaria_proph[Original_IN_Varname] `m1_713e[Original_IN_Varname]'
			recode anc1malaria_proph (2=1) (3=0)
			
			gen anc1edd =  m1_801
			char anc1edd[Original_IN_Varname] `m1_801[Original_IN_Varname]'

			egen anc1tq = rowmean(anc1bp anc1weight anc1urine anc1blood anc1ultrasound anc1ifa anc1tt anc1calcium anc1deworm ) // 9 items 
			char anc1tq[Original_IN_Varname] Mean of `anc1bp[Original_IN_Varname]' ///
									& `anc1weight[Original_IN_Varname]' ///
									& `anc1urine[Original_IN_Varname]' ///
									& `anc1blood[Original_IN_Varname]'  ///
									& `anc1ultrasound[Original_IN_Varname]'  ///
									& `anc1ifa[Original_IN_Varname]'  ///
									& `anc1tt[Original_IN_Varname]'  ///
									& `anc1calcium[Original_IN_Varname]'  ///
									& `anc1deworm[Original_IN_Varname]'  

			
			* Counselling at first ANC visit
			gen counsel_nutri =  m1_716a  
			char counsel_nutri[Original_IN_Varname] `m1_716a[Original_IN_Varname]'

			gen counsel_exer=  m1_716b
			char counsel_exer[Original_IN_Varname] `m1_716b[Original_IN_Varname]'

			gen counsel_complic =  m1_716e
			char counsel_complic[Original_IN_Varname] `m1_716e[Original_IN_Varname]'

			gen counsel_comeback = m1_724a
			char counsel_comeback[Original_IN_Varname] `m1_724a[Original_IN_Varname]'

			gen counsel_birthplan =  m1_809
			char counsel_birthplan[Original_IN_Varname] `m1_809[Original_IN_Varname]'

			egen anc1counsel = rowmean(counsel_nutri counsel_complic ///
								counsel_comeback counsel_birthplan)
			
			char anc1counsel[Original_IN_Varname] Mean of `counsel_nutri[Original_IN_Varname]' ///
													/// //& `counsel_exer[Original_IN_Varname]' ///
													& `counsel_complic[Original_IN_Varname]' ///
													& `counsel_comeback[Original_IN_Varname]' ///
													& `counsel_birthplan[Original_IN_Varname]'

										
			* Q713 Other treatments/medicine at first ANC visit 
			gen anc1food_supp = m1_713c
			char anc1food_supp[Original_IN_Varname] `m1_713c[Original_IN_Varname]'

			gen anc1mental_health_drug = m1_713f
			char anc1mental_health_drug[Original_IN_Varname] `m1_713f[Original_IN_Varname]'

			gen anc1hypertension = m1_713h
			char anc1hypertension[Original_IN_Varname] `m1_713h[Original_IN_Varname]'

			gen anc1diabetes = m1_713i
			char anc1diabetes[Original_IN_Varname] `m1_713i[Original_IN_Varname]'

			foreach v in anc1food_supp anc1mental_health_drug anc1hypertension ///
						 anc1diabetes {
			recode `v' (3=0) (2=1)
			}
			
			* Instructions and advanced care
			egen specialist_hosp= rowmax(m1_724e m1_724c) 
			char specialist_hosp[Original_IN_Varname] Max of `m1_724e[Original_IN_Varname]' & `m1_724c[Original_IN_Varname]'
			
			foreach v in anc1bp anc1weight anc1height anc1bmi anc1muac anc1fetal_hr anc1urine anc1blood anc1hiv_test anc1hiv_test anc1syphilis_test anc1blood_sugar_test anc1ultrasound anc1ifa anc1tt anc1tt anc1calcium anc1deworm anc1itn anc1depression anc1malaria_proph anc1edd anc1edd anc1tq counsel_nutri counsel_exer counsel_complic counsel_comeback counsel_birthplan anc1counsel anc1food_supp anc1mental_health_drug anc1hypertension anc1diabetes specialist_hosp {
				char `v'[Module] 1
			}

			
*------------------------------------------------------------------------------*	
	* SECTION 8: CURRENT PREGNANCY
			egen m1_dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d m1_814f m1_814g)
			char m1_dangersigns[Original_IN_Varname] Max of `m1_814a[Original_IN_Varname]' ///
													& `m1_814b[Original_IN_Varname]' ///
													& `m1_814c[Original_IN_Varname]' ///
													& `m1_814d[Original_IN_Varname]' ///
													& `m1_814f[Original_IN_Varname]' ///
													& `m1_814g[Original_IN_Varname]' 


			gen preg_intent = m1_807
			char preg_intent[Original_IN_Varname] `m1_807[Original_IN_Varname]' 
			
	* THE BELOW IS NOT CORRECT!SHALOM TO ADJUST
			gen m1_ga = gest_age
			char m1_ga[Original_IN_Varname] `gest_age[Original_IN_Varname]' 
			
			*recode m1_ga (0/12=1) (12.1/27=2) (27.1/40=3), g(trimester)
			g trimester=m1_804
			char trimester[Original_IN_Varname] `m1_804[Original_IN_Varname]' 
			
			* Asked about LMP
			gen anc1lmp= m1_806
			char anc1lmp[Original_IN_Varname] `m1_806[Original_IN_Varname]' 
		
			foreach v in preg_intent m1_dangersigns m1_ga trimester anc1lmp  {
				char `v'[Module] 1
			}

			
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
			char gravidity[Original_IN_Varname] `m1_1001[Original_IN_Varname]' 

			gen primipara=  m1_1001==1 // first pregnancy
			replace primipara = 1 if  m1_1002==0  // never gave birth
			char primipara[Original_IN_Varname] `m1_1001[Original_IN_Varname]' == 1 or `m1_1002[Original_IN_Varname]' == 0
			
			gen nbpreviouspreg = m1_1001-1 // nb of pregnancies including current minus current pregnancy
			char nbpreviouspreg[Original_IN_Varname] `m1_1001[Original_IN_Varname]' - 1

			gen pregloss = nbpreviouspreg-m1_1002 // nb previous pregnancies not including current minus previous births
			char pregloss[Original_IN_Varname] `nbpreviouspreg[Original_IN_Varname]' - `m1_1002[Original_IN_Varname]'

			
			gen stillbirths = m1_1002 - m1_1003 // nb of deliveries/births minus live births
			replace stillbirths = 1 if stillbirths>1 & stillbirths<.
			char stillbirths[Original_IN_Varname] `m1_1002[Original_IN_Varname]' - `m1_1003[Original_IN_Varname]' (Set to 1 if > 1 but not missing)

			foreach v in gravidity primipara nbpreviouspreg pregloss stillbirths {
				char `v'[Module] 1
			}

*------------------------------------------------------------------------------*	
	* SECTION 12: ECONOMIC STATUS AND OUTCOMES
			
			*Asset variables
			recode  m1_1201 (2 4 6 96=0) (3=1), gen(safewater) // 96 is  tanker 
			char safewater[Original_IN_Varname] `m1_1201[Original_IN_Varname]'
			
			recode  m1_1202 (2=1) (3=0), gen(toilet) // flush/ pour flush toilet and pit laterine =improved 
			char toilet[Original_IN_Varname] `m1_1202[Original_IN_Varname]'

			gen electr = m1_1203
			char electr[Original_IN_Varname] `m1_1203[Original_IN_Varname]'

			gen radio = m1_1204
			char radio[Original_IN_Varname] `m1_1204[Original_IN_Varname]'

			gen tv = m1_1205
			char tv[Original_IN_Varname] `m1_1205[Original_IN_Varname]'

			gen phone = m1_1206
			char phone[Original_IN_Varname] `m1_1206[Original_IN_Varname]'

			gen refrig = m1_1207
			char refrig[Original_IN_Varname] `m1_1207[Original_IN_Varname]'

			recode m1_1208 (2=1) (4/7=0), gen(fuel) // electricity, gas (improved) charcoal, wood, dung, crop residuals (unimproved)
			char fuel[Original_IN_Varname] `m1_1208[Original_IN_Varname]'

			gen bicycle =  m1_1212 
			char bicycle[Original_IN_Varname] `m1_1212[Original_IN_Varname]'

			gen motorbik = m1_1213
			char motorbik[Original_IN_Varname] `m1_1213[Original_IN_Varname]'

			gen car = m1_1214 
			char car[Original_IN_Varname] `m1_1214[Original_IN_Varname]'

			gen bankacc = m1_1215
			char bankacc[Original_IN_Varname] `m1_1215[Original_IN_Varname]'

			recode m1_1209 (96 1=0) (2/3=1), gen(floor) //Earth, dung (unimproved) wood planks, palm, polished wood, tiles (improved)
			char floor[Original_IN_Varname] `m1_1209[Original_IN_Varname]'

			recode m1_1210 (1 2 5=0) (3/4 6/8=1) (96=0), gen(wall) // Grass, timber, poles, mud  (unimproved) bricks, cement, stones (improved)
			char wall[Original_IN_Varname] `m1_1210[Original_IN_Varname]'

			recode m1_1211 (1/2=0) (3/5=1) (96=0), gen(roof)  // Iron sheets, Tiles, Concrete (improved) grass, leaves, mud, no roof (unimproved)
			char roof[Original_IN_Varname] `m1_1211[Original_IN_Varname]'

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
			
			foreach v in wealthindex quintile tertile {
				char `v'[Original_IN_Varname] `m1_1201[Original_IN_Varname]' /// 
											& `m1_1202[Original_IN_Varname]' /// 
											& `m1_1203[Original_IN_Varname]' /// 
											& `m1_1204[Original_IN_Varname]' /// 
											& `m1_1205[Original_IN_Varname]' /// 
											& `m1_1206[Original_IN_Varname]' /// 
											& `m1_1207[Original_IN_Varname]' /// 
											& `m1_1208[Original_IN_Varname]' /// 
											& `m1_1212[Original_IN_Varname]' /// 
											& `m1_1213[Original_IN_Varname]' /// 
											& `m1_1214[Original_IN_Varname]' /// 
											& `m1_1215[Original_IN_Varname]' /// 
											& `m1_1209[Original_IN_Varname]' /// 
											& `m1_1210[Original_IN_Varname]' /// 
											& `m1_1211[Original_IN_Varname]'
			}

			
			gen registration_cost= m1_1218a_1 // registration
				replace registration = . if registr==0
				char registration_cost[Original_IN_Varname] `m1_1218a_1[Original_IN_Varname]' (Set to missing if `m1_1218a_1[Original_IN_Varname]' is 0)

			gen med_vax_cost =  m1_1218b_1 // med or vax
				replace med_vax_cost = . if med_vax_cost==0
				char med_vax_cost[Original_IN_Varname] `m1_1218b_1[Original_IN_Varname]' (Set to missing if `m1_1218b_1[Original_IN_Varname]' is 0)

			gen labtest_cost =  m1_1218c_1 // lab tests
				replace labtest_cost= . if labtest_cost==0
				char labtest_cost[Original_IN_Varname] `m1_1218c_1[Original_IN_Varname]' (Set to missing if `m1_1218c_1[Original_IN_Varname]' is 0)

			egen indirect_cost = rowtotal (m1_1218d_1 m1_1218e_1)
				replace indirect = . if indirect==0
				char indirect_cost[Original_IN_Varname] `m1_1218d_1[Original_IN_Varname]' ///
															+ `m1_1218e_1[Original_IN_Varname]' ///
															/// //+ `m1_1218f_1[Original_IN_Varname]' ///
															(Set to missing if total is 0)
			foreach v in registration_cost med_vax_cost labtest_cost indirect_cost tertile quintile wealthindex safewater toilet electr radio tv phone refrig fuel bicycle motorbik car bankacc floor wall roof {
				char `v'[Module] 1
			}

				
*------------------------------------------------------------------------------*	
	* SECTION 13: HEALTH ASSESSMENTS AT BASELINE

			* High blood pressure (HBP)
			egen systolic_bp= rowmean(bp_time_1_systolic bp_time_2_systolic bp_time_3_systolic)
			egen diastolic_bp= rowmean(bp_time_1_diastolic bp_time_2_diastolic bp_time_3_diastolic)
			
			recode systolic_bp 50/139.999=0 140/160=1, gen(systolic_high)
			
			recode diastolic_bp 50/89.999=0 90/160=1, gen(diastolic_high)
			
			egen HBP= rowmax (systolic_high diastolic_high)
			char HBP[Original_IN_Varname] Max of the mean of (`bp_time_1_systolic[Original_IN_Varname]', `bp_time_2_systolic[Original_IN_Varname]', `bp_time_3_systolic[Original_IN_Varname]') and mean of (`bp_time_1_diastolic[Original_IN_Varname]', `bp_time_2_diastolic[Original_IN_Varname]', `bp_time_3_diastolic[Original_IN_Varname]') 

			drop systolic* diastolic*
			
			* Anemia 
			gen Hb= m1_1307 // hemoglobin value taken from the card
			gen Hb2= m1_1309 // test done by E-Cohort data collector
			replace Hb = Hb2 if Hb==.a // use the card value if the test wasn't done
			drop Hb2
			char Hb[Original_IN_Varname] `m1_1307[Original_IN_Varname]'  (If missing uses `m1_1309[Original_IN_Varname]') 
			

			// Reference value of 11 from Ethiopian 2022 guidelines. Should check if relevant in KE
			recode Hb 0/10.9999=1 11/20=0, g(anemic)
			char anemic[Original_IN_Varname] `Hb[Original_IN_Varname]' 
	
			* BMI 
			recode height_cm 41.5=141 112=155 93=144  4.5=137.2 4.6=140.21 5.2=158.5 ///
			5.3=161.5 5.5=167.64 5.6=170.69 6.1=185.93 6.2=188.98 5.4=164.592 
			gen height_m = height_cm/100 
			char height_m[Original_IN_Varname] `height_cm[Original_IN_Varname]'/100 

			gen BMI = weight_kg / (height_m^2)
			char BMI[Original_IN_Varname] `weight_kg[Original_IN_Varname]' / (`height_m[Original_IN_Varname]' ^2)

			gen low_BMI= 1 if BMI<18.5 
			replace low_BMI = 0 if BMI>=18.5 & BMI<.
			char low_BMI[Original_IN_Varname] Set to 1 if `BMI[Original_IN_Varname]' < 18.5 (Set to 0 if BMI >=18.5 and not missing)

			foreach v in HBP Hb height_m BMI low_BMI anemic {
				char `v'[Module] 1
			}


*------------------------------------------------------------------------------*	
	* SECTION 14: M3 outcome development 		

		* 1. Create new variables 
			* Create pregnancyend_ga to indicate GA at the end of pregnancy
			gen time_between_m1_birth = (m3_302 - m1_date)/7     // m3_302: the date of delivery or pregnancy end
			gen pregnancyend_ga = m1_ga + time_between_m1_birth          
			
			* Create preterm birth to indicate birth before GA 37
			gen preterm_birth = 1 if pregnancyend_ga <37 
			replace preterm_birth = 0 if pregnancyend_ga >=37 & pregnancyend_ga <.

			* Create m3_deathage_dys_baby1, m3_deathage_dys_baby2, m3_deathage_dys_baby3 to indicate newborn death age (days). m3_313a_b1, m3_313a_b2, m3_313a_b3: death dates for baby1 baby2 baby3
			gen m3_deathage_dys_baby1 = m3_313a_b1 - m3_302 if m3_312_b1 ==1 
			gen m3_deathage_dys_baby2 = m3_313a_b2 - m3_302 if m3_312_b2 ==1 

		* 2. Create birth outcome variable
			* m3_303_b1 m3_303_b2 still alive; m3_312_b1 m3_312_b2 born alive 
			gen birth_outcome = .
			replace birth_outcome = 1 if m2_date_r1 ==. & (m3_date ==.a | m3_date ==.)                             		// LTFU after M1 
			replace birth_outcome = 2 if m2_date_r1 !=. & (m3_date ==.a | m3_date ==.)                      			// LTFU after M2, these m3_date for these two id (1690-45, 1707-30) should be .1 not . 
			replace birth_outcome = 3 if (m3_303_b1==1 & m3_303_b2==.a )                                            	// live birth singletone  
			replace birth_outcome = 4 if (m3_303_b1==1 & m3_303_b2==1  )                                            	// live birth twin  
			replace birth_outcome = 6 if m3_312_b1==0 & pregnancyend_ga <13                             				// early miscarraige       
			replace birth_outcome = 7 if m3_312_b1==0 & (pregnancyend_ga <28 & pregnancyend_ga >=13)                	// late miscarraige 
			replace birth_outcome = 8 if m3_312_b1==0 & (pregnancyend_ga >= 28 & pregnancyend_ga <.)                	// stillbirth
			replace birth_outcome = 6 if m3_202==3 & pregnancyend_ga <13                             			    	// early miscarraige (m3_202==3, something happened)      
			replace birth_outcome = 7 if m3_202==3 & (pregnancyend_ga <28 & pregnancyend_ga >=13)                   	// late miscarraige (m3_202==3, something happened)  
			replace birth_outcome = 8 if m3_202==3 & (pregnancyend_ga >= 28 & pregnancyend_ga <.)                   	// stillbirth (m3_202==3, something happened)  
			replace birth_outcome = 9 if m3_deathage_dys_baby1 <28                                                  	// neonatal death  
			replace birth_outcome = 10 if m3_deathage_dys_baby1 >=28 & m3_deathage_dys_baby1 !=.                     	// infant death
			replace birth_outcome = 11 if (m3_303_b1==1 & m3_303_b2==0) & (m3_312_b2 == 1 & m3_deathage_dys_baby2 < 28) // twin set (1 alive 1 neonatal death)
			replace birth_outcome = 11 if (m3_303_b1==0 & m3_303_b2==1) & (m3_312_b1 == 1 & m3_deathage_dys_baby1 < 28) // twin set (1 alive 1 neonatal death) 
			replace birth_outcome = 12 if m3_303_b1==1 & m3_303_b2==0 & m3_312_b2 ==0                                   // twin set (1 alive 1 stillbirth)   
			
			* manually edited outcome (N=22: pregnancy end date unavaiable, so pregnancy end ga unavailable, N=15: can only use m2 ga to detemrmined. N=7 cannot determine)
			replace birth_outcome = 6 if (respondentid == "202311201039030209" | respondentid == "202312091319030616" | respondentid == "202312131146030109" | respondentid == "202311181134030509" | respondentid == "202311091213031296" | ///
										  respondentid == "202311211319030396" | respondentid == "202312131233031106" | respondentid == "202311091209031106" | respondentid == "202311151402030504" | respondentid == "202312221123030504" | ///
										  respondentid == "202312081222030515")  & (m2_202_r1 == 3) & ((((m2_date_r1 - m1_date)/7) + m1_ga) <13)                                          // something happened in M2 round 1, and round 1 ga < 13  
			replace birth_outcome = 7 if (respondentid == "202311201039030209" | respondentid == "202312091319030616" | respondentid == "202312131146030109" | respondentid == "202311181134030509" | respondentid == "202311091213031296" | ///
										  respondentid == "202311211319030396" | respondentid == "202312131233031106" | respondentid == "202311091209031106" | respondentid == "202311151402030504" | respondentid == "202312221123030504" | ///
										  respondentid == "202312081222030515")  & (m2_202_r1 == 3) & ((((m2_date_r1 - m1_date)/7) + m1_ga)>=13 &(((m2_date_r1 - m1_date)/7) + m1_ga)<28) // something happened in M2 round 1, and round 1 ga>= 13 & <28 
			replace birth_outcome = 7 if respondentid == "202311061043030506" & (m2_202_r2 == 3) & ((((m2_date_r2 - m1_date)/7) + m1_ga)>=13 &(((m2_date_r2 - m1_date)/7) + m1_ga) <28)   // something happened in M2 round 2, and round 2 ga>= 13 & <28 
			replace birth_outcome = 7 if respondentid == "202312151053013512" & (m2_202_r4 == 3) & ((((m2_date_r4 - m1_date)/7) + m1_ga)>=13 &(((m2_date_r4 - m1_date)/7) + m1_ga) <28)   // something happened in M2 round 4, and round 4 ga>= 13 & <28 
			replace birth_outcome = 8 if (respondentid == "202311231230022012" | respondentid == "202312061131030596") & (m2_202_r5 == 3) & ((((m2_date_r5 - m1_date)/7) + m1_ga) >=28)   // something happened in M2 round 5, and round 5 ga>=28 
			
			* Label birth_outcome 		   
			label define birth_outcome  1 "LTFU after M1" 2 "LTFU after M2" 3 "LB singleton" 4 "LB twin" 5 "LB triplet" 6 "early miscarriage" 7 "late miscarraige" 8 "stillbirth" /// 
										9 "neonatal death" 10 "infant death" 11 "twin 1 alive 1 neonatal death" 12 "twin 1 alive 1 stillbirth" 13 "twin both neonatal death"  			   							   
			label values birth_outcome birth_outcome
			lab var birth_outcome "Birth outcome at M3"
			tab birth_outcome, missing // 7 missingness now 

		* 3. Create M3_maternal_outcome 
			gen M3_maternal_outcome = .  
			replace M3_maternal_outcome = 1 if birth_outcome == 1 
			replace M3_maternal_outcome = 2 if birth_outcome == 2 
			replace M3_maternal_outcome = 4 if birth_outcome == 3 | birth_outcome == 4 | birth_outcome == 5 | birth_outcome == 6 | birth_outcome == 7 | birth_outcome == 8 | ///
											   birth_outcome == 9 | birth_outcome == 10 | birth_outcome == 11 |  birth_outcome == 12 | birth_outcome == 13     
			replace M3_maternal_outcome = 3 if (m2_maternal_death_reported_r1==1 | m2_maternal_death_reported_r2==1 | m2_maternal_death_reported_r3==1 | m2_maternal_death_reported_r4==1 | m2_maternal_death_reported_r5==1 | ///
												m2_maternal_death_reported_r6==1 | m2_maternal_death_reported_r7==1 | m2_maternal_death_reported_r8==1 | m2_maternal_death_reported_r9==1 | m2_maternal_death_reported_r10==1 ) 

			*Label M3_maternal_outcome 
			label define m3_maternal_outcome  1 "LTFU after M1" 2 "LTFU after M2" 3 "Maternal death" 4 "Maternal alive"
			label values M3_maternal_outcome m3_maternal_outcome  
			lab var M3_maternal_outcome "Maternal outcome at M3"
			tab M3_maternal_outcome, missing   


*------------------------------------------------------------------------------*	
	* Labeling variables (by Wen-Chien on April 19)
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
			lab var anc1ultrasound "Ultrasound performed at 1st ANC visit"
			lab var anc1ifa "IFA given at 1st ANC visit" 
			lab var anc1calcium "Calcium given at 1st ANC"
			lab var anc1deworm "Dewormning medicines given at 1st ANC"
			lab var anc1malaria_proph "Malaria medicines given at 1st ANC"
			lab var anc1tt "Tetanus Toxoid vaccination given at 1st ANC visit"
			lab var anc1depression "Anxiety or depression discussed at 1st ANC visit"
			lab var anc1edd "Estimated due date told by provider at 1st ANC visit"
			lab var anc1ux "User experience at 1st ANC visit"
			lab var anc1tq "Content of 1st ANC visit - total quality"
			lab var anc1counsel "Counseling score at 1st ANC visit"
			lab var anc1food_supp "Food supplement given at 1t ANC visit" 
			lab var anc1mental_health_drug "Mental health drug given at 1st ANC visit"
			lab var anc1hypertension "Medicines for hypertension given at 1st ANC visit"
			lab var anc1diabetes "Medicines for diabetes given at 1st ANC visit"
			lab var anc1lmp "Last menstrual perioid asked by provider at 1st ANC visit"
			lab var phq2_cat "PHQ2 depression level based on sum of 2 items"
			lab var educ_cat "Education level category"
			lab var electr "Does your household have electricity?"
			lab var car "Does any member of your household own a car or truck?"
			lab var radio "Does your household have a radio?"
			lab var tv "Does your household have a television?"
			lab var phone "Does your household have a telephone or a mobile phone?"
			lab var refrig "Does your household have a refrigerator?" 
			lab var bicycle "Does any member of your household own a bicycle?"
			lab var motorbik "Does any member of your household own a motorcycle or motor scooter?"
			lab var bankacc "Does any member of your household have a bank account?"
			lab var facility_lvl "Facility level"
			lab var m1_dangersigns "Experienced danger signs in pregnancy"
			lab var m1_health_literacy "Health literacy score"
			lab var nbpreviouspreg "The number of previous pregnancies"
			lab var gravidity "How many pregnancies have you had, including the current pregnancy?"
			lab var primipara "First time pregnancy"
			lab var stillbirths "The number of stillbirths"
			lab var preg_intent "The pregnancy was intended"
			lab var Hb "Hemoglobin level from maternal card"
			lab var registration_cost "The amount of money spent on registration / consultation"
			lab var med_vax_cost "The amount of money spent for medicine/vaccines"
			lab var labtest_cost "The amounr of money spent on Test/investigations (x-ray, lab etc.)"
			lab var indirect_cost "Indirect cost, including transport, accommodation, and other"
			lab var counsel_comeback "Counselled about coming back for additional ANC visit"
			lab var Date_of_interview "Date of interview"
			lab var DATE_OF_INTERVIEW "Date of interview"
			lab var estimated_delivery_date "Estimated delivery date"
			lab var ESTIMATED_DELIVERY_DATE "Estimated delivery date"
			lab var DURATION "Interview duration"

*** Note by Wen-Chien (April 19)
* gestational_age gestational_age_1: It looks like people have either data avaiable (not labeled yet)
* estimated_delivery_date ESTIMATED_DELIVERY_DATE: both are EDD 
*　Date_of_interview DATE_OF_INTERVIEW: both are interview date 
* HEM: this might be hemoglobin, not sure if it's the Hb taken during 1st ANC (another var Hb refering to Hb level from maternal card) (not labeled yet)
* study_id CALC_END_TIME REVIEW_CORRECTIONS REVIEW_COMMENTS REVIEW_QUALITY: not sure about these variables (not labeled yet)
						
		*	save "$in_data_final/eco_m1_in_der.dta", replace
