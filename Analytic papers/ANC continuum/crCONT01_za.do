clear all
set more off
	global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
	global za_data_final "$user/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data"

* South Africa
	u "$za_data_final/eco_m1-m3_za_der.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date!=.

*-------------------------------------------------------------------------------
	* Number of follow up surveys
	*Drop the m2 date where the woman has delivered or lost pregnancy since 
	*they will move to Module 3 and the rest of the survey is blank 
	
	forval i = 1/6 { // drop the m2 date where the woman has delivered/lost pregnancy
		replace m2_date_r`i' =. if m2_202_r`i'==2 | m2_202_r`i'==3 // 25% did not have a module 2!
	}
	egen totalfu=rownonmiss(m1_date m2_date_r* m3_date) 
	
	* Dropping women with no M2
	drop if totalfu<3 // 25% dropped, N=663
	
*-------------------------------------------------------------------------------		
	* Time between follow-up surveys
	gen time_m2_r1_m1= (m2_date_r1-m1_date)/7
	gen time_m2_r2_m2_r1 = (m2_date_r2-m2_date_r1)/7
	gen time_m2_r3_m2_r2 = (m2_date_r3-m2_date_r2)/7
	gen time_m2_r4_m2_r3 = (m2_date_r4-m2_date_r3)/7
	gen time_m2_r5_m2_r4 = (m2_date_r5-m2_date_r4)/7
	gen time_m2_r6_m2_r5 = (m2_date_r6-m2_date_r5)/7

	egen countm2=rownonmiss(m2_date_r*)
	gen m2_date_last= m2_date_r1 if countm2==1
	replace m2_date_last= m2_date_r2 if countm2==2
	replace m2_date_last= m2_date_r3 if countm2==3
	replace m2_date_last= m2_date_r4 if countm2==4
	replace m2_date_last= m2_date_r5 if countm2==5
	replace m2_date_last= m2_date_r6 if countm2==6
	replace m2_date_last=m1_date if countm2==0
	format m2_date_last %td
	gen time_m2_last_m3 = (m3_date - m2_date_last)/7

	forval i = 1/6 {
		gen tag`i'=1 if time_m2_r`i'>14 & time_m2_r`i' <.
		}	
	gen tag7 = 1 if time_m2_last_m3 >14 & time_m2_last_m3<.
	* Time between M3 survey and DOB/end of pregnancy
	gen m3delay=(m3_date-m3_birth_or_ended) 
	recode m3delay 0/31 = 1 32/63=2 64/94=3 95/126=4 127/157=5 158/max=6
	
	lab def m3delay 1 "within a month" 2"within 2mos" 3 "within 3mos" 4"withn 4 mos" ///
	5"within 5 months" 6"within 6-12mos"
	lab val m3delay m3delay

*-------------------------------------------------------------------------------		
	* Number of ANC visits
		egen totvisits=rowtotal(m2_305_r* m2_308_r* m2_311_r* m2_314_r* m2_317_r* ///
							m3_consultation_1 m3_consultation_2 m3_consultation_3)
		replace totvisits = totvisits+ 1 
		recode totvisit 3=2 4/7=3 8/max=4 , gen(viscat)
		lab def totvis 1"Only 1 visit" 2"2-3 visits" 3"4-7 visits" 4"8+ visits"
		lab val viscat totvis 

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
			recode  m1_713b 2=1 3=0 98=., g(anc1_calcium)
		
		* Follow up visits
			rename (m2_501a_r1 m2_501a_r2 m2_501a_r3 m2_501a_r4 m2_501a_r5 ///
					m2_501a_r6  m3_412a) (m2_bp_r1 m2_bp_r2 ///
					m2_bp_r3 m2_bp_r4 m2_bp_r5 m2_bp_r6  m3_bp)
			
			rename (m2_501b_r1 m2_501b_r2 m2_501b_r3 m2_501b_r4 m2_501b_r5 ///
					m2_501b_r6  m3_412b) (m2_wgt_r1 m2_wgt_r2 ///
					 m2_wgt_r3 m2_wgt_r4 m2_wgt_r5 m2_wgt_r6  m3_wgt)
			
			foreach r in r1 r2 r3 r4 r5 r6  {
				egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
				egen m3_blood=rowmax(m3_412c m3_412d)
				
			rename (m2_501e_r1 m2_501e_r2 m2_501e_r3 m2_501e_r4 m2_501e_r5 ///
					m2_501e_r6  m3_412e) (m2_urine_r1 m2_urine_r2 ///
					m2_urine_r3 m2_urine_r4 m2_urine_r5 m2_urine_r6  m3_urine)
			
			rename 	(m2_501f_r1 m2_501f_r2 m2_501f_r3 m2_501f_r4 m2_501f_r5 ///
					m2_501f_r6  m3_412f) (m2_us_r1 m2_us_r2 ///
					m2_us_r3 m2_us_r4 m2_us_r5 m2_us_r6  m3_us)
					
			rename (m2_506a_r1 m2_506a_r2 m2_506a_r3 m2_506a_r4 m2_506a_r5 ///
					m2_506a_r6 ) (m2_danger_r1 m2_danger_r2 ///
					m2_danger_r3 m2_danger_r4 m2_danger_r5 m2_danger_r6 )
			
			rename (m2_506b_r1 m2_506b_r2 m2_506b_r3 m2_506b_r4 m2_506b_r5 m2_506b_r6 ) ///
					(m2_bplan_r1 m2_bplan_r2 m2_bplan_r3 m2_bplan_r4 m2_bplan_r5 m2_bplan_r6 )
					
			rename (m2_601a_r1 m2_601a_r2 m2_601a_r3 m2_601a_r4 m2_601a_r5 m2_601a_r6 ) ///
					(m2_ifa_r1 m2_ifa_r2 m2_ifa_r3 m2_ifa_r4 m2_ifa_r5 m2_ifa_r6 )
			
			rename (m2_601b_r1 m2_601b_r2 m2_601b_r3 m2_601b_r4 m2_601b_r5 m2_601b_r6 ) ///
					(m2_calcium_r1 m2_calcium_r2 m2_calcium_r3 m2_calcium_r4 m2_calcium_r5 m2_calcium_r6 )
	
		* Total ANC content
			egen anctotal=rowtotal(anc1_bp anc1_weight anc1_bmi anc1_muac anc1_urine ///
					anc1_blood anc1_ultrasound anc1_anxi anc1_lmp anc1_nutri anc1_exer ///
					anc1_dangers  anc1_edd anc1_bplan anc1_ifa anc1_calcium /// 13 items
					m2_bp_r* m3_bp m2_wgt_r*  m3_wgt m2_urine_r* m3_urine m2_blood_r* m3_blood ///
					m2_us_r*  m3_us m2_danger_r* m2_bplan_r* ///
					m2_ifa_r* m2_calcium_r*) // 8 x 8 

	* Number of months in ANC 
		
		gen months=(m3_birth_or_ended-m1_date)/30.5
		replace months = . if m3_birth_or_ended > m3_date // birth is after survey
		replace months = . if m3_birth_or_ended < m1_date // birth before M1
		replace months = . if m3_birth_or_ended < m2_date_r1
		
		gen manctotal= anctotal/months // Nb ANC clinical actions per month
*-------------------------------------------------------------------------------		
	* MINIMUM SET OF ANC ITEMS	
	* At least 3 BP checks
	egen totalbp=rowtotal(anc1_bp m2_bp_r* m3_bp*)
		recode totalbp 1/2=0 3/max=1, gen(bpthree)

	* At least 3 wgts
	egen totalweight=rowtotal(anc1_weight m2_wgt_r* m3_wgt*)
		recode totalweight 1/2=0 3/max=1, gen(wgtthree)
		
	* At least 3 blood tests
	egen totalblood=rowtotal(anc1_blood m2_blood_r* m3_blood*)
		recode totalblood 1/2=0 3/max=1, gen(bloodthree)
		
	* At least 3 urine tests
	egen totalurine=rowtotal(anc1_urine m2_urine_r* m3_urine*)
		recode totalurine 1/2=0 3/max=1, gen(urinethree)
		replace urinethree=. if totalfu <2
	
	* At least 1 ultrasound
	egen totalus=rowtotal(anc1_ultrasound m2_us_r* m3_us*)
		recode totalus 1/max=1
		
	* Takes IFA at each survey
	egen contifa = rowmin(m2_603_r*) // always taking IFA
	
	egen all4= rowmin (bpthree wgtthree bloodthree urinethree )
	
*-------------------------------------------------------------------------------	
	* RECALCULATING BASELINE GA and RUNNING GA
		gen bslga=ga
		gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga  // 12% have a GA>42 weeks, no adjustements
		drop ga_endpreg
	* Trimesters
	drop trimester
	recode bslga (1/12.99999 = 1) (13/27.99999= 2) (28/50=3), gen(trimester)
			lab def trim 1"1st trimester 0-12wks" 2"2nd trimester 13-27 wks" ///
			3 "3rd trimester 28-42 wks"
					lab val trimester trim
	* Recalculating baseline and running GA based on DOB for those with live births
	* and no LBW babies.
		gen bslga2 = 40-((m3_birth_or_ended-m1_date)/7)
		egen alive=rowmin(m3_303b m3_303c m3_303d) // any baby died
			replace bslga2=. if alive==0
		recode m3_baby1_weight min/2.4999=1 2.5/max=0
		recode m3_baby2_weight min/2.4999=1 2.5/max=0
		recode m3_baby3_weight min/2.4999=1 2.5/max=0
		egen lbw=rowmax(m3_baby1_weight m3_baby2_weight m3_baby3_weight)
			replace bslga2=. if lbw==1 
			replace bslga2=. if m3_baby1_size==5 | m3_baby2_size==5 | m3_baby3_size==5
			replace bslga= bslga2 if bslga2!=. 
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga 
			recode ga_endpreg (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), g(endtrimes)
	* Recalculating running GA and running trimester 
		drop m2_ga_r1  m2_ga_r2 m2_ga_r3 m2_ga_r4 m2_ga_r5 m2_ga_r6 
		forval i=1/6 {
			gen m2_ga_r`i' = ((m2_date_r`i'-m1_date)/7) +bslga
			gen m2_trimes_r`i'=m2_ga_r`i'
			recode m2_trimes_r`i' (1/12.99999 = 1) (13/27.99999= 2) (28/50=3)
			lab var m2_trimes_r`i' "Trimester of pregnancy at follow up"
			}
	* Baseline trimester
	recode bslga (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), gen(bsltrimester)
					lab val bsltrimester trim
					lab val m2_trimes_r* trim
					lab var bsltrimester "Trimester at ANC initiation/enrollment"

					
					
*-------------------------------------------------------------------------------		
	* DEMOGRAPHICS AND RISK FACTORS					
		* Demographics
				gen age20= enrollage<20
				gen age35= enrollage>=35
				recode educ_cat 2=1 3=2 4=3
				lab def edu 1 "Primary only" 2 "Complete Secondary" 3"Higher education"
				lab val educ_cat edu
				// tertile  marriedp 
				gen healthlit_corr=health_lit==4
				recode m1_506 1/6=1 96=1 7=2 8/9=1 10=3,g(job)
				lab def job 1"Employed or homemaker" 2"Student" 3"Unemployed"
				lab val job job 
			
		*Risk factors
			* Anemia
				recode Hb 0/10.99999=1 11/30=0, gen(anemia)
				lab val anemia anemia
			* Chronic illnesses
				egen chronic= rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e )  
				encode m1_203, gen(prob)
				recode prob (1/4 10 16 18/21 24 28 29 30 33 34 28 =0 ) (5/9 11/15 17 22 23 25 26 27 31 32=1)
				replace chronic = 1 if prob==1
				replace chronic_nohiv=1 if prob==1
				drop prob
				replace chronic=1 if HBP==1 // measured BP
				replace chronic_nohiv=1 if HBP==1
			
			* Underweight/overweight
			rename low_BMI maln_underw
			recode BMI 0/29.999=0 30/100=1, g(overweight)
			
			egen ipv=rowmax(m1_1101 m1_1103)
			
			* Obstetric risk factors
			gen multiple= m1_805 >1 &  m1_805<.
			gen cesa= m1_1007==1
			
			gen neodeath = m1_1010 ==1
			gen preterm = m1_1005 ==1
			gen PPH=m1_1006==1
			egen complic = rowmax(stillbirth neodeath preterm PPH cesa)	
save "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/ZAtmp.dta", replace	


*-------------------------------------------------------------------------------		
	/* ANC CONTENT	
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
	
	* ANC CONTENT BY VISIT
	gen bp0 =anc1_bp
	forval i = 1/6 {
		gen bp`i'=m2_bp_r`i' // reported BP in M2 (among those with new visits)
		egen newanc`i'= rowmax(m2_305_r`i' m2_308_r`i' m2_311_r`i' m2_314_r`i' m2_317_r`i') // any of the new visits in M2 are routine ANC?
		replace bp`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. // replace bp to 0 if the new visit was not routine ANC (among those who had a survey)
	}
	gen bpm3 = m3_bp
	
	gen blood0= anc1_blood
	forval i = 1/6 {
		gen blood`i'=m2_blood_r`i' // reported blood test in M2 (among those with new visits)
		replace blood`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. // replace to 0 if the new visit was not routine ANC (among those who had a survey)
	}
	gen bloodm3=m3_blood
	
	gen urine0= anc1_urine
	forval i = 1/6 {
		gen urine`i'=m2_urine_r`i' // reported urine test in M2 (among those with new visits)
		replace urine`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. 
	}
	gen urinem3=m3_urine 
	
	gen us0 = anc1_ultrasound
		forval i = 1/6 {
		gen us`i'=m2_us_r`i' // reported echo in M2 (among those with new visits)
		replace us`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. 
	}
	gen usm3=m3_us
	
	gen wgt0= anc1_weight
	forval i = 1/6 {
		gen wgt`i'=m2_wgt_r`i' // reported weight taken in M2 (among those with new visits)
		replace wgt`i' = 0 if newanc`i'==0 & m2_date_r`i' !=. 
	}
	gen wgtm3=m3_wgt
