clear all
set more off
	global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
	global et_data_final "$user/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data"
	
* ETHIOPIA
	u "$et_data_final/eco_m1-m5_et_wide_der.dta", clear
	
	* Restrict dataset to those who were followed through end of pregnancy
	keep if m3_date<.

*-------------------------------------------------------------------------------		
	* Number of ANC visits
		egen totvisits=rowtotal(m2_305_r* m2_308_r* m2_311_r* m2_314_r* m2_317_r* ///
							m3_consultation_1 m3_consultation_2 m3_consultation_3)
		replace totvisits = totvisits+ 1 
		recode totvisit 3=2 4/7=3 8/max=4 , gen(viscat)
		lab def totvis 1"Only 1 visit" 2"2-3 visits" 3"4-7 visits" 4"8+ visits"
		lab val viscat totvis 
		*graph pie, over(totvis) plabel(_all percent, format(%4.2g) size(medlarge))

*-------------------------------------------------------------------------------		
	* TOTAL ANC CONTENT
		* First visit
			rename (m1_700 m1_701 m1_703  m1_705 m1_712 m1_716a m1_716b m1_716c m1_716e m1_801 m1_806 m1_809 m1_724a) ///
					(anc1_bp anc1_weight anc1_muac anc1_urine anc1_ultrasound anc1_nutri anc1_exer anc1_anxi ///
					anc1_dangers anc1_edd anc1_lmp anc1_bplan anc1_return)
			
			egen anc1_bmi= rowtotal(anc1_weight m1_702)
			recode anc1_bmi 1=0 2=1
			egen anc1_blood=rowmax(m1_706 m1_707)
			recode m1_713a 2=1 3=0, g(anc1_ifa)
			recode  m1_713b 2=1 3=0, g(anc1_calcium)
		
		* Follow up visits
			rename (m2_501a_r1 m2_501a_r2 m2_501a_r3 m2_501a_r4 m2_501a_r5 ///
					m2_501a_r6 m2_501a_r7 m2_501a_r8 m3_412a) (m2_bp_r1 m2_bp_r2 ///
					m2_bp_r3 m2_bp_r4 m2_bp_r5 m2_bp_r6 m2_bp_r7 m2_bp_r8 m3_bp)
			
			rename (m2_501b_r1 m2_501b_r2 m2_501b_r3 m2_501b_r4 m2_501b_r5 ///
					m2_501b_r6 m2_501b_r7 m2_501b_r8 m3_412b) (m2_wgt_r1 m2_wgt_r2 ///
					 m2_wgt_r3 m2_wgt_r4 m2_wgt_r5 m2_wgt_r6 m2_wgt_r7 m2_wgt_r8 m3_wgt)
			
			foreach r in r1 r2 r3 r4 r5 r6 r7 r8 {
				egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
				egen m3_blood=rowmax(m3_412c m3_412d)
				
			rename (m2_501e_r1 m2_501e_r2 m2_501e_r3 m2_501e_r4 m2_501e_r5 ///
					m2_501e_r6 m2_501e_r7 m2_501e_r8 m3_412e) (m2_urine_r1 m2_urine_r2 ///
					m2_urine_r3 m2_urine_r4 m2_urine_r5 m2_urine_r6 m2_urine_r7 ///
					m2_urine_r8 m3_urine)
			
			rename 	(m2_501f_r1 m2_501f_r2 m2_501f_r3 m2_501f_r4 m2_501f_r5 ///
					m2_501f_r6 m2_501f_r7 m2_501f_r8 m3_412f) (m2_us_r1 m2_us_r2 ///
					m2_us_r3 m2_us_r4 m2_us_r5 m2_us_r6 m2_us_r7 m2_us_r8 m3_us)
					
			rename (m2_506a_r1 m2_506a_r2 m2_506a_r3 m2_506a_r4 m2_506a_r5 ///
					m2_506a_r6 m2_506a_r7 m2_506a_r8) (m2_danger_r1 m2_danger_r2 ///
					m2_danger_r3 m2_danger_r4 m2_danger_r5 m2_danger_r6 m2_danger_r7 m2_danger_r8)
			
			rename (m2_506b_r1 m2_506b_r2 m2_506b_r3 m2_506b_r4 m2_506b_r5 m2_506b_r6 m2_506b_r7 m2_506b_r8) ///
					(m2_bplan_r1 m2_bplan_r2 m2_bplan_r3 m2_bplan_r4 m2_bplan_r5 m2_bplan_r6 m2_bplan_r7 m2_bplan_r8)
					
			rename (m2_601a_r1 m2_601a_r2 m2_601a_r3 m2_601a_r4 m2_601a_r5 m2_601a_r6 m2_601a_r7 m2_601a_r8) ///
					(m2_ifa_r1 m2_ifa_r2 m2_ifa_r3 m2_ifa_r4 m2_ifa_r5 m2_ifa_r6 m2_ifa_r7 m2_ifa_r8)
			
			rename (m2_601b_r1 m2_601b_r2 m2_601b_r3 m2_601b_r4 m2_601b_r5 m2_601b_r6 m2_601b_r7 m2_601b_r8) ///
					(m2_calcium_r1 m2_calcium_r2 m2_calcium_r3 m2_calcium_r4 m2_calcium_r5 m2_calcium_r6 m2_calcium_r7 m2_calcium_r8)
	
		* Total ANC content
			egen anctotal=rowtotal(anc1_bp anc1_weight anc1_bmi anc1_muac anc1_urine ///
					anc1_blood anc1_ultrasound anc1_anxi anc1_lmp anc1_nutri anc1_exer ///
					anc1_dangers  anc1_edd anc1_bplan anc1_ifa anc1_calcium /// 13 items
					m2_bp_r* m3_bp m2_wgt_r*  m3_wgt m2_urine_r* m3_urine m2_blood_r* m3_blood ///
					m2_us_r*  m3_us m2_danger_r* m2_bplan_r* ///
					m2_ifa_r* m2_calcium_r*) // 8 x 8 

	* Number of months in ANC 
		gen months=(m3_birth_or_ended-m1_date)/30.5
		replace months = 1 if months<1
	
		gen manctotal= anctotal/months // Nb ANC clinical actions per month
*-------------------------------------------------------------------------------
* ANC CONTENT BY FOLLOW UP
	gen bp0 =anc1_bp
	forval i = 1/8 {
		gen bp`i'=m2_bp_r`i' // reported BP in M2 (among those with new visits)
		egen newanc`i'= rowmax(m2_305_r`i' m2_308_r`i' m2_311_r`i' m2_314_r`i' m2_317_r`i') // any of the new visits in M2 are routine ANC?
		replace bp`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. // replace bp to 0 if the new visit was not routine ANC (among those who had a survey)
	}
	gen bpm3 = m3_bp
	
	gen blood0= anc1_blood
	forval i = 1/8 {
		gen blood`i'=m2_blood_r`i' // reported blood test in M2 (among those with new visits)
		replace blood`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. // replace to 0 if the new visit was not routine ANC (among those who had a survey)
	}
	gen bloodm3=m3_blood
	
	gen urine0= anc1_urine
	forval i = 1/8 {
		gen urine`i'=m2_urine_r`i' // reported urine test in M2 (among those with new visits)
		replace urine`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. 
	}
	gen urinem3=m3_urine 
	
	gen us0 = anc1_ultrasound
		forval i = 1/8 {
		gen us`i'=m2_us_r`i' // reported echo in M2 (among those with new visits)
		replace us`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. 
	}
	gen usm3=m3_us
	
	gen wgt0= anc1_weight
	forval i = 1/8 {
		gen wgt`i'=m2_wgt_r`i' // reported weight taken in M2 (among those with new visits)
		replace wgt`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. 
	}
	gen wgtm3=m3_wgt

		
*-------------------------------------------------------------------------------	
	* RECALCULATING GA
	* Baseline GA
			recode mcard_ga_lmp 2/5.6=. 888/998=.
			recode m1_803 1/4=.
			gen bslga= m1_802d_et // LMP
			replace bslga = mcard_ga_lmp if bslga==. // card
			replace bslga= m1_803 if bslga==. // self reported
			gen chk_ga= 40-((m3_birth_or_ended-m1_date)/7)
			
	* Recalculating baseline and running GA based on DOB for those with LBs and no LBW babies
		gen bslga2 = 40-((m3_birth_or_ended-m1_date)/7)
		egen alive=rowmin(m3_303b m3_303c m3_303d) // any baby died
		replace bslga2=. if alive==0
		recode m3_baby1_weight min/2.4999=1 2.5/max=0
		recode m3_baby2_weight min/2.4999=1 2.5/max=0
		recode m3_baby3_weight min/2.4999=1 2.5/max=0
		egen lbw=rowmax(m3_baby1_weight m3_baby2_weight m3_baby3_weight)
		replace bslga2=. if lbw==1
		replace bslga= bslga2 if bslga2!=.
	* Recalculating running GA based on 
		drop m2_ga_r1  m2_ga_r2 m2_ga_r3 m2_ga_r4 m2_ga_r5 m2_ga_r6 m2_ga_r7 m2_ga_r8
		forval i=1/8 {
			gen m2_ga_r`i' = ((m2_date_r`i'-m1_date)/7) +bslga
			}
	* Trimesters
	recode bslga (1/12.99999 = 1) (13/27.99999= 2) (28/50=3), gen(trimester)
			lab def trim 1"1st trimester 0-12wks" 2"2nd trimester 13-27 wks" ///
			3 "3rd trimester 28-42 wks"
					lab val trimester trim
*-------------------------------------------------------------------------------		
	* ANC CONTENT	
	* Minumum set
	egen totalbp=rowtotal(anc1_bp m2_bp_r*)
		recode totalbp 1/3=0 4/max=1, gen(bpfour)
	
	egen totalweight=rowtotal(anc1_weight m2_wgt_r*)
		recode totalweight 4/max=4
		lab def totw 0"None" 1"One" 2"Two" 3"Three" 4"Four or more"
		lab val totalweight totw
		
	egen totalblood=rowtotal(anc1_blood m2_blood_r*)
		recode totalblood 1/2=0 3/max=1, gen(bloodthree)
		recode totalblood 3/max=3
		lab def counttests 0"None" 1"One" 2"Two" 3"Three or more" 
		lab val totalblood counttests
		
	egen totalurine=rowtotal(anc1_urine m2_urine_r* )
		recode totalurine 1/2=0 3/max=1, gen(urinethree)
		recode totalurine 3/max=3
		lab val totalurine counttests
		
	gen usone = 1 if anc1_ultrasound ==1 & bslga<24
	forval i=1/8 {
		replace usone =1 if m2_us_r`i'==1 & m2_ga_r`i'<24 
		}
	replace usone=0 if usone==. // Ultrasound before 24 weeks GA

	egen contifa = rowmin(m2_603_r*) // always taking IFA
	
	
*-------------------------------------------------------------------------------		
	* Demographics and risk factors
			
		* Risk factors
			*Anemia
			egen anemia= rowmax(m1_1307 m1_1309)
			recode anemia 0/10.99999=1 11/30=0
			lab def anemia 1 "Anemia (Hb<11g/dl)" 0 "Normal"
			lab val anemia anemia
			
			* Chronic illnesses
			replace m1_203_et = 0 if   m1_203_other=="Chgara" ///
			| m1_203_other=="Chronic Gastritis" ///
			| m1_203_other=="Chronic Sinusitis and tonsil" ///
			| m1_203_other=="gastritis" | m1_203_other=="Gastro intestinal track"  ///
			| m1_203_other=="STI" | m1_203_other=="Hemorrhoids"  | m1_203_other=="Sinus" | ///
			m1_203_other=="Sinuse" | m1_203_other=="Sinusitis" | ///
			m1_203_other=="gastric" | m1_203_other=="gastric ulcer" 
			
			egen chronic = rowtotal(m1_202a m1_202b m1_202c m1_202d m1_202e ///
			m1_202g_et m1_203_et m1_HBP)
			lab var chronic "Number of chronic illnesses"
			
			* Malnutrition
			gen malnut= m1_muac<23
			
			* Previous obstetric complications
			gen multiple= m1_805 >1 &  m1_805<.
			gen cesa= m1_1007==1
			gen neodeath = m1_1010 ==1
			gen preterm = m1_1005 ==1
			gen PPH=m1_1006==1
			rename m1_1004 late_misc
			egen complic = rowtotal(cesa stillbirth preterm neodeath PPH late_misc)
			
			gen age20= m1_enrollage<20
			gen age35= m1_enrollage>=35
			
			egen riskcat=rowtotal(anemia chronic malnut complic age20 age35)
			recode riskcat 3/max=2 
			lab def riskcat 0"No risk factor" 1"One risk factor" 2"Two or more risk factors" 
			lab val riskcat riskcat
			
			/* ANC items per month in care
			mixed manctotal i.riskcat i.trimester i.quintile i.educ_cat 
				  i.m1_health_literacy preg_intent ib(2).facility_lvl ib(2).site
				  || facility:  , vce(robust) ;
				  
			* Total ANC items, restricting to women enrolled in 1st trimester
			mixed anctot i.riskcat  i.quintile i.educ_cat 
				  i.m1_health_literacy preg_intent ib(2).facility_lvl ib(2).site 
				  if trimester==1 || facility:  , vce(robust) ;
		
	
			
/*-------------------------------------------------------------------------------
	* ANC components by trimester
	gen bp1=1 if anc1_bp==1 & bslga<13
	forval i=1/8 {
		replace bp1 =1 if m2_bp_r`i'==1 & m2_ga_r`i'<13
	}
	replace bp1=0 if bp1==. // BP measured in 1st trimester
	
	
	gen bp2=1 if anc1_bp==1 & (bslga>=13 & bslga<28)
	forval i=1/8 {
		replace bp2 =1 if m2_bp_r`i'==1 & m2_ga_r`i'>=13 & m2_ga_r`i'<28
	}
	replace bp2=0 if bp2==. // BP measured in 2nd trimester
	
	
	gen bp3=1 if anc1_bp==1 & (bslga>=28 & bslga<.)
	forval i=1/8 {
		replace bp3 =1 if m2_bp_r`i'==1 & m2_ga_r`i'>=28 & m2_ga_r`i'<.
	}
	replace bp3=0 if bp3==. // BP measured in 2nd trimester
				
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			

	
							
	