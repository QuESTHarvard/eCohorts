clear all
set more off
	global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
	global ke_data_final "$user/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data"

* KENYA
	u "$ke_data_final/eco_m1-m5_ke_der.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date!=.
	* Remove women who had a miscarriage (didn't reach 28 weeks gestation)
	foreach x in 1830061513	1720071304	1211081324	21010071336	1114071325	///
	21825071208	21703071308	21811071513	1916081145	21225071153	1801081517	///
	1801081443	21411071610	1911071249	21704081615	21327071043	1707081248	///
	21204081236	1829061406	1805071256	21511071321	1209081131	21112071158	///
	21204081524	21620071230	1926061139	1208081034 {
	drop if respondentid=="`x'"
	}
*-------------------------------------------------------------------------------
	* Number of follow up surveys
	
	  *Drop the m2 date where the woman has delivered or lost pregnancy since 
	  *they will move to Module 3 and the rest of the survey is blank 
		forval i = 1/8 { 
			replace m2_date_r`i' =. if m2_202_r`i'==2 | m2_202_r`i'==3 
		}
		egen totalfu=rownonmiss(m1_date m2_date_r* m3_date) 
*-------------------------------------------------------------------------------		
	* Time between follow-up surveys
	gen time_m2_r1_m1= (m2_date_r1-m1_date)/7
	gen time_m2_r2_m2_r1 = (m2_date_r2-m2_date_r1)/7
	gen time_m2_r3_m2_r2 = (m2_date_r3-m2_date_r2)/7
	gen time_m2_r4_m2_r3 = (m2_date_r4-m2_date_r3)/7
	gen time_m2_r5_m2_r4 = (m2_date_r5-m2_date_r4)/7
	gen time_m2_r6_m2_r5 = (m2_date_r6-m2_date_r5)/7
	gen time_m2_r7_m2_r6 = (m2_date_r7-m2_date_r6)/7
	gen time_m2_r8_m2_r7 = (m2_date_r8-m2_date_r7)/7
	* Number of M2 surveys conducted
	egen countm2=rownonmiss(m2_date_r*)
	gen m2_date_last= m2_date_r1 if countm2==1
	replace m2_date_last= m2_date_r2 if countm2==2
	replace m2_date_last= m2_date_r3 if countm2==3
	replace m2_date_last= m2_date_r4 if countm2==4
	replace m2_date_last= m2_date_r5 if countm2==5
	replace m2_date_last= m2_date_r6 if countm2==6
	replace m2_date_last= m2_date_r7 if countm2==7
	replace m2_date_last= m2_date_r8 if countm2==8
	replace m2_date_last=m1_date if countm2==0
	format m2_date_last %td
	gen time_m2_last_m3 = (m3_date - m2_date_last)/7
	
	* Create tag for any time bw follow up surveys > 13.5 weeks (a whole trimester)	
	forval i = 1/8 {
		gen tag`i'=1 if time_m2_r`i'>14 & time_m2_r`i' <.
		count if tag`i'==1
		}	
	gen tag9 = 1 if time_m2_last_m3 >14 & time_m2_last_m3<.
	egen anygap=rowmax(tag*)
*-------------------------------------------------------------------------------	
	* RECALCULATING BASELINE GA and RUNNING GA
	* Baseline GA
			gen bslga =40-((m1_802a-m1_date)/7)
			replace bslga=. if bslga<3
			replace bslga= m1_803 if bslga==. // self reported
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga 
			// 20% have gestation > 42 wks
			drop ga_endpreg	
	* Recalculating baseline and running GA based on DOB for those with live births
	* and no LBW babies.
		gen bslga2 = 40-((m3_birth_or_ended-m1_date)/7)
		egen alive=rowmin(m3_303b m3_303c  ) // any baby died
			replace bslga2=. if alive==0
		recode m3_baby1_weight min/2.4999=1 2.5/max=0
		recode m3_baby2_weight min/2.4999=1 2.5/max=0
		egen lbw=rowmax(m3_baby1_weight m3_baby2_weight )
			replace bslga2=. if lbw==1 
			replace bslga2=. if m3_baby1_size==5 | m3_baby2_size==5 
			replace bslga2=. if bslga2<0
			replace bslga= bslga2 if bslga2!=. // IQR= 33.1
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga 
			recode ga_endpreg (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), g(endtrimes)
	* Recalculating running GA and running trimester 
		drop m2_ga_r1  m2_ga_r2 m2_ga_r3 m2_ga_r4 m2_ga_r5 m2_ga_r6 m2_ga_r7 m2_ga_r8
		forval i=1/8 {
			gen m2_ga_r`i' = ((m2_date_r`i'-m1_date)/7) +bslga
			gen m2_trimes_r`i'=m2_ga_r`i'
			recode m2_trimes_r`i' (1/12.99999 = 1) (13/27.99999= 2) (28/50=3)
			lab var m2_trimes_r`i' "Trimester of pregnancy at follow up"
			}
	* Baseline trimester
	recode bslga (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), gen(bsltrimester)
			lab def trim 1"1st trimester 0-12wks" 2"2nd trimester 13-27 wks" ///
			3 "3rd trimester 28-42 wks"
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
			lab var totvisits "Total routine ANC visits"
			lab var viscat "Total number of routine ANC visits (categories)"
		
		* Number of routine ANC or ANC referral visits  at each follow-up call
		forval i= 1/8 {
			egen ranc`i'=rowtotal(m2_305_r`i' m2_306_r`i' m2_308_r`i' m2_309_r`i' ///
					m2_311_r`i' m2_312_r`i' m2_314_r`i' m2_315_r`i'  ///
					m2_317_r`i' m2_318_r`i' ), m
		}
			egen ranclast=rowtotal(m3_consultation_* m3_consultation_referral_*)
		
		egen totvisref=rowtotal(ranc*)
		replace totvisref=totvisref+1
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
					m2_501a_r6 m2_501a_r7 m2_501a_r8 m3_412a_1_ke m3_412a_2_ke m3_412a_3_ke) (m2_bp_r1 m2_bp_r2 ///
					m2_bp_r3 m2_bp_r4 m2_bp_r5 m2_bp_r6 m2_bp_r7 m2_bp_r8 m3_bp1 m3_bp2 m3_bp3)
			
			rename (m2_501b_r1 m2_501b_r2 m2_501b_r3 m2_501b_r4 m2_501b_r5 ///
					m2_501b_r6 m2_501b_r7 m2_501b_r8 m3_412b_1 m3_412b_2 m3_412b_3) (m2_wgt_r1 m2_wgt_r2 ///
					 m2_wgt_r3 m2_wgt_r4 m2_wgt_r5 m2_wgt_r6 m2_wgt_r7 m2_wgt_r8 m3_wgt1 m3_wgt2 m3_wgt3)
			
			foreach r in r1 r2 r3 r4 r5 r6 r7 r8 {
				egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
				egen m3_blood=rowmax(m3_412c_* m3_412d_*)
				
			rename (m2_501e_r1 m2_501e_r2 m2_501e_r3 m2_501e_r4 m2_501e_r5 ///
					m2_501e_r6 m2_501e_r7 m2_501e_r8 m3_412e_1 m3_412e_2 m3_412e_3) (m2_urine_r1 m2_urine_r2 ///
					m2_urine_r3 m2_urine_r4 m2_urine_r5 m2_urine_r6 m2_urine_r7 ///
					m2_urine_r8 m3_urine1 m3_urine2 m3_urine3)
			
			rename 	(m2_501f_r1 m2_501f_r2 m2_501f_r3 m2_501f_r4 m2_501f_r5 ///
					m2_501f_r6 m2_501f_r7 m2_501f_r8 m3_412f_1 m3_412f_2 m3_412f_3) (m2_us_r1 m2_us_r2 ///
					m2_us_r3 m2_us_r4 m2_us_r5 m2_us_r6 m2_us_r7 m2_us_r8 m3_us1 m3_us2 m3_us3)
					
			rename (m2_506a_r1 m2_506a_r2 m2_506a_r3 m2_506a_r4 m2_506a_r5 ///
					m2_506a_r6 m2_506a_r7 m2_506a_r8) (m2_danger_r1 m2_danger_r2 ///
					m2_danger_r3 m2_danger_r4 m2_danger_r5 m2_danger_r6 m2_danger_r7 m2_danger_r8)
			
			rename (m2_506b_r1 m2_506b_r2 m2_506b_r3 m2_506b_r4 m2_506b_r5 m2_506b_r6 m2_506b_r7 m2_506b_r8) ///
					(m2_bplan_r1 m2_bplan_r2 m2_bplan_r3 m2_bplan_r4 m2_bplan_r5 m2_bplan_r6 m2_bplan_r7 m2_bplan_r8)
					
			rename (m2_601a_r1 m2_601a_r2 m2_601a_r3 m2_601a_r4 m2_601a_r5 m2_601a_r6 m2_601a_r7 m2_601a_r8) ///
					(m2_ifa_r1 m2_ifa_r2 m2_ifa_r3 m2_ifa_r4 m2_ifa_r5 m2_ifa_r6 m2_ifa_r7 m2_ifa_r8)
			
			rename (m2_601b_r1 m2_601b_r2 m2_601b_r3 m2_601b_r4 m2_601b_r5 ///
					m2_601b_r6 m2_601b_r7 m2_601b_r8) (m2_calcium_r1 ///
					m2_calcium_r2 m2_calcium_r3 m2_calcium_r4 m2_calcium_r5 ///
					m2_calcium_r6 m2_calcium_r7 m2_calcium_r8)
	
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
		
		egen all4= rowmin (bpthree wgtthree bloodthree urinethree  )
	
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
		egen deworm=rowmax(anc1deworm m2_601e_r*)
		
		egen anctotal=rowtotal(maxbp4 maxwgt4 anc1_bmi anc1_muac maxurine4 maxblood4 ///
					maxus4 anc1_anxi anc1_lmp anc1_nutri anc1_exer maxdanger4 anc1_edd ///
					maxbplan4 maxifa4 maxcalc4 deworm)	
*-------------------------------------------------------------------------------
	* TIMELY ANC
		cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
		egen hivtest= rowmax (m1_708a m1_709a) // at M1 an hiv test or viral load test (if already HIV+)
		forval i= 1/8 {
			egen m2hiv`i' = rowmax(m2_503b_r`i' m2_503c_r`i')
			}
		recode m1_704 2=. 
		
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
			save timelyancke.dta, replace
		restore 
		
		
	*Recommended items for follow-up anc visits in first trimester
			preserve
					forval i=1/8 {
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
					merge 1:1 respondentid using timelyancke.dta
					drop _merge
					save timelyancke.dta, replace
			restore
			
	*Recommended items for follow-up anc visits in 2nd trimester
			preserve
					forval i=1/8 {
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
					merge 1:1 respondentid using timelyancke.dta
					drop _merge
					save timelyancke.dta, replace
			restore
			
		*Recommended items for follow-up anc visits in 3rd trimester
			preserve
					forval i=1/8 {
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
							m2_calcium_r* m2_bp_r* m3_bp* m2_wgt_r* m3_wgt* ///
							m2_blood_r* m3_blood* m2_urine_r* m3_urine* ///
							m2_503e_r* m2hiv* m2_503d_r* ///
							m2_601e_r*)
							
					keep respondentid ancfuthird country bsltrimester
					merge 1:1 respondentid using timelyancke.dta
					drop _merge
					save timelyancke.dta, replace
			restore	
*-------------------------------------------------------------------------------		
		* TIMELY ULTRASOUND
			g tanc1_ultrasound=anc1_ultrasound
			replace tanc1_ultrasound=. if bslga>24 & bslga<.
			forval i=1/8 {
				g tm2_us_r`i' = m2_us_r`i'
				replace tm2_us_r`i'=. if m2_ga_r`i'>24 & m2_ga_r`i'<.
			}
			egen timelyus=rowmax(tanc1_ultrasound tm2_us_r*)
	
*-------------------------------------------------------------------------------		
	* DEMOGRAPHICS AND RISK FACTORS
		* Demographics
			recode enrollage (min/19=1 "<20") (20/34=2 "20-34") (35/max=3 "35+"), g(agecat)
			recode enrollage (min/19=1) (20/max=0), g(age19)
			recode enrollage (min/34=0) (35/max=1), g(age35)
			// educ_cat  quintile  marriedp
			gen healthlit_corr=health_lit==4
			* Experienced danger signs in pregnancy
			egen danger=rowmax(m1_814b m1_814c m1_814f m1_814g m2_203b_r* ///
				m2_203c_r* m2_203f_r* m2_203g_r*) 
				// vaginal bleeding, fever, convulsions, seizures, fainting or LOC
			rename  (facility_lvl bsl_preg_intent) (factype preg_intent)
			g second= educ_cat>=3 & educ_cat<.
			recode m1_506 1/5=1 6=2 -96=1 7=3 8/9=1 10=4,g(job)
			lab def job 1"Employed" 2"Homemaker" 3"Student" 4"Unemployed"
			lab val job job 
		* Risk factors
			* Anemia
			recode bsl_Hb 0/10.99999=1 11/30=0, gen(anemia)
			lab val anemia anemia
			* Chronic illnesses
			g other_chronic= 1 if m1_203_other=="Fibroids" | m1_203_other=="Peptic ulcers disease" ///
			| m1_203_other=="PUD" | m1_203_other=="Gestational Hypertension in previous pregnancy" ///
			| m1_203_other=="Ovarian cyst" | m1_203_other=="Peptic ulcerative disease"
		
			egen chronic= rowtotal(m1_202a m1_202b m1_202c m1_202d m1_202e m1_203c_ke ///
			m1_203d_ke  m1_203g_ke  m1_203i_ke ///
			m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke other_chronic bsl_HBP)
			* Underweight
			rename bsl_low_BMI malnut
			* Obstetric risk factors		
			gen multiple= m1_805 >1 &  m1_805<.
			gen cesa= m1_1007==1
			
			gen neodeath = m1_1010 ==1
			gen preterm = m1_1005 ==1
			gen PPH=m1_1006==1
			egen complic = rowtotal(stillbirth neodeath preterm PPH cesa  ) 
		
			egen riskcat=rowtotal(anemia chronic malnut complic age19 age35 )
			recode riskcat 3/max=2 
			lab def riskcat 0"No risk factor" 1"One risk factor" 2"Two or more risk factors" 
			lab val riskcat riskcat
				
					
save "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/KEtmp.dta", replace	
/*			
			reg anctotal i.riskcat ib(2).agecat i.educ_cat i.healthlit_corr married ///
			i.quintile i.job preg_intent prim danger ib(2).bsltrimest i.factype i.study_site ///
			if  totalfu>2  , vce(robust)
			
			reg anctotal i.riskcat ib(2).agecat i.educ_cat i.healthlit_corr married ///
			i.quintile i.job preg_intent prim danger i.bsltrim i.factype i.study_site ///
			if  totalfu>2  , vce(robust)
			
			margins riskcat
			marginsplot 
			
			margins quintile
			marginsplot
/*-------------------------------------------------------------------------------
* Number of months in ANC 
		gen months=(m3_birth_or_ended-m1_date)/30.5
		replace months = 1 if months<1
	
		gen manctotal= anctotal/months // Nb ANC clinical actions per month in care


* Time between M3 survey and DOB/end of pregnancy
	gen m3delay=(m3_date-m3_birth_or_ended) 
	recode m3delay 0/31 = 1 32/63=2 64/94=3 95/126=4 127/157=5 158/max=6
	
	lab def m3delay 1 "within a month" 2"within 2mos" 3 "within 3mos" 4"withn 4 mos" ///
	5"within 5 months" 6"within 6-12mos"
	lab val m3delay m3delay

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
