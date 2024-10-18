clear all
set more off
	global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
	global za_data_final "$user/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data"

* South Africa
	u "$za_data_final/eco_m1-m3_za_der.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date!=.
	* Remove women who had a miscarriage (didn't reach 28 weeks gestation)
	foreach x in RCH_050	QEE_171	QEE_103	PAP_031	NEL_011	NWE_031	EUB_005	///
	TOK_086	NWE_011	BXE_034	NWE_050	RCH_087	NEL_077	NUN_020	NWE_017	QEE_197	///
	NWE_004	MBA_001	QEE_126	MER_048	MND_013	NLO_011	RCH_042	TOK_003	NUN_025	///
	RCH_081	MPH_038	TOK_077	QEE_186	EUB_019	KAN_043	BNE_050	MND_004	TOK_012 ///
	NOK_019	NWE_041	EUB_015	IIB_032	NWE_075	MBA_010	IIB_026	RCH_043	TOK_042	///
	MPH_006	NEL_062	UKH_022	BCH_003	NEL_025 {
	drop if respondentid =="`x'"
	}
	
*-------------------------------------------------------------------------------
	* Number of follow up surveys
	*Drop the m2 date where the woman has delivered or lost pregnancy since 
	*they will move to Module 3 and the rest of the survey is blank 
	
	forval i = 1/6 { // drop the m2 date where the woman has delivered/lost pregnancy
		replace m2_date_r`i' =. if m2_202_r`i'==2 | m2_202_r`i'==3 // 25% did not have a module 2!
	}
	egen totalfu=rownonmiss(m1_date m2_date_r* m3_date) 
	
*-------------------------------------------------------------------------------		
	* Time between follow-up surveys
		gen time_m2_r1_m1= (m2_date_r1-m1_date)/7 // time in weeks bw 1st m2 and m1
		gen time_m2_r2_m2_r1 = (m2_date_r2-m2_date_r1)/7
		gen time_m2_r3_m2_r2 = (m2_date_r3-m2_date_r2)/7
		gen time_m2_r4_m2_r3 = (m2_date_r4-m2_date_r3)/7
		gen time_m2_r5_m2_r4 = (m2_date_r5-m2_date_r4)/7
		gen time_m2_r6_m2_r5 = (m2_date_r6-m2_date_r5)/7
	* Number of M2 surveys conducted
		egen countm2=rownonmiss(m2_date_r*)
		gen m2_date_last= m2_date_r1 if countm2==1
		replace m2_date_last= m2_date_r2 if countm2==2
		replace m2_date_last= m2_date_r3 if countm2==3
		replace m2_date_last= m2_date_r4 if countm2==4
		replace m2_date_last= m2_date_r5 if countm2==5
		replace m2_date_last= m2_date_r6 if countm2==6
		replace m2_date_last=m1_date if countm2==0
		format m2_date_last %td
		gen time_m2_last_m3 = (m3_date - m2_date_last)/7 // time bw last m2 and m3
	
	* Create tag for any time bw follow up surveys > 13.5 weeks (a whole trimester)
		forval i = 1/6 {
			gen tag`i'=1 if time_m2_r`i'>13.5 & time_m2_r`i' <.
			}	
		gen tag7 = 1 if time_m2_last_m3 >13.5 & time_m2_last_m3<.
		egen anygap=rowmax(tag*)
	*brow m1_date ga m2_date_r*  m3_date tag* m2_ga_r*
*-------------------------------------------------------------------------------	
	* RECALCULATING BASELINE GA and RUNNING GA
		gen bslga=ga
		gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga  // 8.9% have a GA>42 weeks
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
			replace bslga2=. if bslga2<0
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
			rename (m1_700 m1_701 m1_703  m1_705 m1_712 m1_716a m1_716b ///
					m1_716c m1_716e m1_801 m1_806 m1_809 m1_724a) ///
					(anc1_bp anc1_weight anc1_muac anc1_urine anc1_ultrasound ///
					anc1_nutri anc1_exer anc1_anxi ///
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

		egen all4= rowmin (bpthree wgtthree bloodthree urinethree )
		
*-------------------------------------------------------------------------------		
	* TOTAL ANC SCORE
	
		recode totalbp 4/max=4, g(maxbp4)
		recode totalweight 4/max=4, g(maxwgt4)
		recode totalurine 4/max=4, g(maxurine4)
		recode totalblood 4/max=4, g(maxblood4)
		egen totalus =rowtotal(anc1_ultrasound m2_us_r* m3_us*)
			recode totalus 4/max=4, g(maxus4)
		egen totaldanger=rowtotal(anc1_dangers m2_danger_r*) 
			recode totaldanger 4/max=4, g(maxdanger4)
		egen totalbplan= rowtotal(anc1_bplan m2_bplan_r*)
			recode totalbplan 4/max=4, g(maxbplan4)
		egen totalifa = rowtotal(anc1_ifa m2_ifa_r*)
			recode totalifa 4/max=4, g(maxifa4)
		egen totalcalcium = rowtotal(anc1_calcium m2_calcium_r*)
			recode totalcalcium 4/max=4, g(maxcalc4)
		recode m1_713d (2=1) (3=0), gen(anc1deworm)
		egen deworm=rowmax(anc1deworm m2_601e_r*)
		
		egen anctotal=rowtotal(maxbp4 maxwgt4 anc1_bmi anc1_muac maxurine4 maxblood4 ///
					maxus4 anc1_anxi anc1_lmp anc1_nutri anc1_exer maxdanger4 anc1_edd ///
					maxbplan4 maxifa4 maxcalc4 deworm)	
				
*-------------------------------------------------------------------------------		
		* TIMELY ANC
		cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
		egen hivtest= rowmax (m1_708a m1_709a) // an hiv test or viral load test (if already HIV+)
		forval i= 1/6 {
			recode m2_503c_r`i' 9999998=.
			egen m2hiv`i' = rowmax(m2_503b_r`i' m2_503c_r`i')
			}
		recode m1_704 2=. // listen to fetal heart rate 
		
		* Recommended items for first visits in first trimester
		egen anc1first=rowmean(anc1_lmp anc1_edd anc1_dangers anc1_bplan ///
					anc1_nutri anc1_ifa anc1_bp anc1_weight m1_702 anc1_muac ///
					anc1_blood  anc1_urine m1_711a  hivtest  m1_710a ///
					anc1_ultrasound   anc1tt) ///
					if bsltrimest==1 
					
		* Recommended items for first visits in 2nd trimester
		egen anc1second=rowmean(anc1_lmp anc1_edd anc1_dangers anc1_bplan ///
					anc1_nutri anc1_ifa anc1_calcium anc1_bp anc1_weight m1_702 anc1_muac ///
					anc1_blood  anc1_urine m1_711a  hivtest  m1_710a m1_704 ///
					anc1_ultrasound anc1tt) ///
					if bsltrimest==2
					
		* Recommended items for first visits in 3rd trimester
		egen anc1third=rowmean(anc1_lmp anc1_edd anc1_dangers anc1_bplan ///
					anc1_nutri anc1_ifa anc1_calcium anc1_bp anc1_weight m1_702 anc1_muac ///
					anc1_blood  anc1_urine m1_711a  hivtest  m1_710a m1_704 ///
					anc1tt) ///
					if bsltrimest==3
		preserve
			keep respondentid anc1first anc1second anc1third anygap
			save timelyancza.dta, replace
		restore 
		
		
	*Recommended items for follow-up anc visits in first trimester
			preserve
					forval i=1/6 {
						replace m2_danger_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_bplan_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_ifa_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_bp_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_wgt_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_blood_r`i' = . if m2_trimes_r`i'!=1  
						replace m2_urine_r`i' = . if m2_trimes_r`i'!=1  
						replace m2_503e_r`i' = . if m2_trimes_r`i'!=1  
						replace m2hiv`i' = . if m2_trimes_r`i'!=1 
						replace m2_503d_r`i' = . if m2_trimes_r`i'!=1  
						replace m2_us_r`i' = . if m2_trimes_r`i'!=1 
					}
					
					egen ancfufirst=rowmean(m2_danger_r* m2_bplan_r* m2_ifa_r* m2_bp_r* ///
							m2_wgt_r* m2_blood_r* m2_urine_r* m2_503e_r* m2hiv* m2_503d_r* m2_us_r*)
					
					keep respondentid ancfufirst 
					merge 1:1 respondentid using timelyancza.dta
					drop _merge
					save timelyancza.dta, replace
			restore
			
	*Recommended items for follow-up anc visits in 2nd trimester
			preserve
					forval i=1/6 {
						replace m2_danger_r`i' = . if m2_trimes_r`i'!=2
						replace m2_bplan_r`i' = . if m2_trimes_r`i'!=2
						replace m2_ifa_r`i' = . if m2_trimes_r`i'!=2
						replace m2_calcium_r`i' = . if m2_trimes_r`i'!=2
						replace m2_bp_r`i' = . if m2_trimes_r`i'!=2
						replace m2_wgt_r`i' = . if m2_trimes_r`i'!=2 
						replace m2_blood_r`i' = . if m2_trimes_r`i'!=2  
						replace m2_urine_r`i' = . if m2_trimes_r`i'!=2  
						replace m2_503e_r`i' = . if m2_trimes_r`i'!=2 
						replace m2hiv`i' = . if m2_trimes_r`i'!=2
						replace m2_503d_r`i' = . if m2_trimes_r`i'!=2  
						replace m2_us_r`i' = . if m2_trimes_r`i'!=2
						replace m2_601e_r`i' = . if m2_trimes_r`i'!=2
					}
					
					egen ancfusecond=rowmean(m2_danger_r* m2_bplan_r* m2_ifa_r* ///
							m2_calcium_r* m2_bp_r* m2_wgt_r* m2_blood_r* ///
							m2_urine_r* m2_503e_r* m2hiv* m2_503d_r* ///
							m2_us_r* m2_601e_r*)
					
					keep respondentid ancfusecond
					merge 1:1 respondentid using timelyancza.dta
					drop _merge
					save timelyancza.dta, replace
			restore
			
		*Recommended items for follow-up anc visits in 3rd trimester
			preserve
					forval i=1/6 {
						replace m2_danger_r`i' = . if m2_trimes_r`i'!=3
						replace m2_bplan_r`i' = . if m2_trimes_r`i'!=3
						replace m2_ifa_r`i' = . if m2_trimes_r`i'!=3
						replace m2_calcium_r`i' = . if m2_trimes_r`i'!=3
						replace m2_bp_r`i' = . if m2_trimes_r`i'!=3
						replace m2_wgt_r`i' = . if m2_trimes_r`i'!=3 
						replace m2_blood_r`i' = . if m2_trimes_r`i'!=3  
						replace m2_urine_r`i' = . if m2_trimes_r`i'!=3  
						replace m2_503e_r`i' = . if m2_trimes_r`i'!=3
						replace m2hiv`i' = . if m2_trimes_r`i'!=3
						replace m2_503d_r`i' = . if m2_trimes_r`i'!=3  
						replace m2_601e_r`i' = . if m2_trimes_r`i'!=3
					}
					
					egen ancfuthird=rowmean(m2_danger_r* m2_bplan_r* m2_ifa_r* ///
							m2_calcium_r* m2_bp_r* m3_bp m2_wgt_r* m3_wgt ///
							m2_blood_r* m3_blood m2_urine_r* m3_urine ///
							m2_503e_r* m2hiv* m2_503d_r* ///
							m2_601e_r*)
							
					keep respondentid ancfuthird country bsltrimester
					merge 1:1 respondentid using timelyancza.dta
					drop _merge
					save timelyancza.dta, replace
			restore		
*-------------------------------------------------------------------------------		
	* DEMOGRAPHICS AND RISK FACTORS					
		* Demographics
				recode enrollage (min/19=1 "<20") (20/34=2 "20-34") (35/max=3 "35+"), g(agecat)
				recode educ_cat 2=1 3=2 4=3
				lab def edu 1 "Primary only" 2 "Complete Secondary" 3"Higher education"
				lab val educ_cat edu
				// tertile  marriedp 
				gen healthlit_corr=health_lit==4
				recode m1_506 1/5=1 6=2  7=3 8/9=1 10=4 96=1,g(job)
				lab def job 1"Employed" 2"Homemaker" 3"Student" 4"Unemployed"
					lab val job job 
				g second= educ_cat>=2 & educ_cat<.
			* Baseline danger signs
			egen danger=rowmax(m1_814b m1_814c m1_814f m1_814g) 
				// vaginal bleeding, fever, convulsions, seizures, fainting or LOC
		*Risk factors
			* Anemia
				recode Hb 0/10.99999=1 11/30=0, gen(anemia)
				lab val anemia anemia
			* Chronic illnesses
				egen diab=rowmax(m1_202a m1_202a_2_za)
				egen hbp=rowmax(m1_202b m1_202b_2_za)
				egen cardiac=rowmax(m1_202c m1_202c_2_za)
				egen mh=rowmax(m1_202d m1_202d_2_za)
				egen hiv=rowmax(m1_202e m1_202e_2_za)
				encode m1_203, g(prob1) 
					recode prob1 ( 1/4 14/17 20 24 27=0 "No") (5/13 18/19 21/23 25/26 =1 "Yes"), g(p1)
				encode m1_203_2_za, g(prob2) 
					recode prob2 (1 5/7 =0 "No") (2/4 =1 "Yes") , g(p2)
				egen chronic= rowtotal(diab hbp cardiac mh hiv p1 p2 HBP)  
				egen chronic_nohiv = rowtotal(diab hbp cardiac mh p1 p2 HBP)  
			* Underweight/overweight
			rename low_BMI malnut
			
			* Obstetric risk factors
			gen multiple= m1_805 >1 &  m1_805<.
			gen cesa= m1_1007==1
			
			gen neodeath = m1_1010 ==1
			gen preterm = m1_1005 ==1
			gen PPH=m1_1006==1
			egen complic = rowmax(stillbirth neodeath preterm PPH cesa)	
			
			egen riskcat=rowtotal(anemia chronic malnut complic )
			recode riskcat 3/max=2 
			lab def riskcat 0"No risk factor" 1"One risk factor" 2"Two or more risk factors" 
			lab val riskcat riskcat
			
			egen riskcat2=rowtotal(anemia chronic malnut complic )
			recode riskcat2 3/max=3

save "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/ZAtmp.dta", replace	

			reg totvis i.riskcat2 ib(2).agecat i.educ_cat i.healthlit_corr married ///
				i.tertile i.job preg_intent prim danger  i.study_site ///
				if  totalfu>3  , vce(robust)
				
			
*-------------------------------------------------------------------------------		
	/* 
	* Number of months in ANC 
			
			gen months=(m3_birth_or_ended-m1_date)/30.5
			replace months = . if m3_birth_or_ended > m3_date // birth is after survey
			replace months = . if m3_birth_or_ended < m1_date // birth before M1
			replace months = . if m3_birth_or_ended < m2_date_r1
			
			gen manctotal= anctotal/months // Nb ANC clinical actions per month
			
	* Time between M3 survey and DOB/end of pregnancy
	gen m3delay=(m3_date-m3_birth_or_ended) 
	recode m3delay 0/31 = 1 32/63=2 64/94=3 95/126=4 127/157=5 158/max=6
	
	lab def m3delay 1 "within a month" 2"within 2mos" 3 "within 3mos" 4"withn 4 mos" ///
	5"within 5 months" 6"within 6-12mos"
	lab val m3delay m3delay 
	
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
