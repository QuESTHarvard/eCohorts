* ETHIOPIA
	u "$et_data_final/eco_ET_Complete.dta", clear

	* Restrict dataset to those who were not lost to follow up
	drop if birth_outcome==1 | birth_outcome==2 // 110 lost to follow up before M3
	drop if birth_outcome==6 // 7 early miscarriages
*-------------------------------------------------------------------------------
	* Number of follow up surveys
	
	   *Drop the m2 date where the woman has delivered or lost pregnancy since 
	   * they will move to Module 3 and the rest of the M2 survey is blank 
	forval i = 1/8 { 
		replace m2_date_r`i' =. if m2_202_r`i'==2 | m2_202_r`i'==3 
		}
	
	egen totalfu=rownonmiss(m1_date m2_date_r* m3_date) // total surveys until M3
*-------------------------------------------------------------------------------		
	* Time between follow-up surveys
		gen time_m2_r1_m1= (m2_date_r1-m1_date)/7 // time in weeks bw 1st m2 and m1
		gen time_m2_r2_m2_r1 = (m2_date_r2-m2_date_r1)/7 // time bw 2nd m2 and 1st m2
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
		gen time_m2_last_m3 = (m3_date - m2_date_last)/7 // time bw last m2 and m3
	
	* Create tag for any time bw follow up surveys > 10 weeks (a whole trimester missed)
		forval i = 1/8 {
			gen tag`i'=1 if time_m2_r`i'>10 & time_m2_r`i' <.
			}	
		gen tag9 = 1 if time_m2_last_m3 >10 & time_m2_last_m3<.
		egen anygap=rowmax(tag*)
*-------------------------------------------------------------------------------	
	* RECALCULATING BASELINE GA and RUNNING GA
	* Baseline GA
			recode mcard_ga_lmp 2/5.6=. 888/998=. 
			recode m1_803 1/4=.
			gen bslga= m1_802d_et // LMP
			replace bslga = mcard_ga_lmp if bslga==. // card lmp
			replace bslga= m1_803 if bslga==. // self reported weeks pregnant
			gen ga_endpreg= ((m3_birth_or_ended - m1_date)/7)+bslga 
			// 15% have gestation > 42 wks, IQR=32.29
			drop ga_endpreg
			
	* Recalculating baseline and running GA based on DOB for those with live births
	* and no LBW babies.
		replace m3_birth_or_ended = m3_date if m3_birth_or_ended==. // DOB is unknowwn for 8 women
		
		gen bslga2 = 40-((m3_birth_or_ended-m1_date)/7)
		egen alive=rowmin(m3_303b m3_303c m3_303d ) // any baby died
			replace bslga2=. if alive==0
		recode m3_baby1_weight min/2.4999=1 2.5/max=0
		recode m3_baby2_weight min/2.4999=1 2.5/max=0
		recode m3_baby3_weight min/2.4999=1 2.5/max=0
		egen lbw=rowmax(m3_baby1_weight m3_baby2_weight m3_baby3_weight)
			replace bslga2=. if lbw==1 
			replace bslga2=. if m3_baby1_size==5 | m3_baby2_size==5 | m3_baby3_size==5
			replace bslga2=. if bslga2<0
			replace bslga= bslga2 if bslga2!=. // IQR= 33.1
			
		gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga 
		recode ga_endpreg (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), g(endtrimes)
			
			
	* Recalculating running GA and running trimester 
		drop m2_ga_r1  m2_ga_r2 m2_ga_r3 m2_ga_r4 m2_ga_r5 m2_ga_r6 m2_ga_r7 m2_ga_r8
		forval i=1/8 {
			gen m2_ga_r`i' = ((m2_date_r`i'-m1_date)/7) +bslga
			gen m2_trimes_r`i'=m2_ga_r`i'
			recode m2_trimes_r`i' (1/12.99999 = 1) (13/27.99999= 2) (28/max=3)
			lab var m2_trimes_r`i' "Trimester of pregnancy at follow up"
			}
	* Baseline trimester
	recode bslga (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), gen(bsltrimester)
			lab def trim 1"1st trimester 0-12wks" 2"2nd trimester 13-27 wks" ///
			3 "3rd trimester 28-42 wks"
					lab val bsltrimester trim
					lab val m2_trimes_r* trim
					lab var bsltrimester "Trimester at ANC initiation/enrollment"
*drop if bslga>=.
*-------------------------------------------------------------------------------
* Number of routine ANC or ANC referral visits  at each follow-up call
*-------------------------------------------------------------------------------	
		forval i= 1/8 {
			egen ranc`i'=rowtotal(m2_305_r`i' m2_306_r`i' m2_308_r`i' m2_309_r`i' ///
					m2_311_r`i' m2_312_r`i' m2_314_r`i' m2_315_r`i'  ///
					m2_317_r`i' m2_318_r`i' ), m
		}
			egen ranclast=rowtotal(m3_consultation_* m3_consultation_referral_*)
		
		egen totvisref=rowtotal(ranc*) 
		lab var totvisref "Total number of routine ANC visits or visit for a referal from ANC provider"
		replace totvisref=totvisref+1
		recode totvisref 3=2 4/7=3 8/max=4 , gen(viscatref)
		lab val viscatref totvis 
		lab var viscatref "Total number of routine ANC visits (categories)"
*-------------------------------------------------------------------------------
* TIMELY CARE
*-------------------------------------------------------------------------------
	* BLOOD	
		egen anc1_blood=rowmax(m1_706 m1_707)
			foreach r in r1 r2 r3 r4 r5 r6 r7 r8 {
				egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
			egen m3_blood=rowmax(m3_412c m3_412d)
		gen firstblood= anc1_blood if bsltrimester==1
		forval i=1/8 {
			replace firstblood = 1 if m2_blood_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstblood = 1 if m3_blood==1 & endtrime==1
		lab var firstblood "Had a blood test in 1st trimester if enrolled in ANC"
		
		gen secblood= anc1_blood if bsltrimester==2 
		forval i=1/8 {
			replace secblood = 1 if m2_blood_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secblood = 1 if m3_blood==1 & endtrime==2
		replace secblood = 0 if secblood==. & (bsltrimester ==1 | bsltrimester ==2) // started ANC in 1st or 2nd trimester
		lab var secblood "Had a blood test in 2nd trimester if enrolled in ANC"

		gen thirdblood= anc1_blood if bsltrimester==3
		forval i=1/8 {
			replace thirdblood = 1 if m2_blood_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdblood = 1 if m3_blood==1 & endtrime==3
		replace thirdblood = 0 if thirdblood==. & endtrime==3
		lab var thirdblood "Had a blood test in 3rd trimester if enrolled in ANC"
		
		egen laqsblood=rowmin(firstblood secblood thirdblood)
	
	* URINE
		gen firsturine= anc1urine if bsltrimester==1
		forval i=1/8 {
			replace firsturine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firsturine = 1 if m3_412e==1 & endtrime==1
		lab var firsturine "Had a urine test in 1st trimester if enrolled in ANC"
		
		gen securine= anc1urine if bsltrimester==2 
		forval i=1/8 {
			replace securine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==2
		}
		replace securine = 1 if m3_412e==1 & endtrime==2
		replace securine = 0 if securine==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var securine "Had a urine test in 2nd trimester if enrolled in ANC"

		gen thirdurine= anc1urine if bsltrimester==3
		forval i=1/8 {
			replace thirdurine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdurine = 1 if m3_412e==1 & endtrime==3
		replace thirdurine = 0 if thirdurine==. & endtrime==3
		lab var thirdurine "Had a urine test in 3rd trimester if enrolled in ANC"

		egen laqsurine=rowmin(firsturine securine thirdurine)
		
	* WEIGHT
		gen firstweight= anc1weight if bsltrimester==1
		forval i=1/8 {
			replace firstweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstweight = 1 if m3_412b==1 & endtrime==1
		lab var firstweight "Had weight measured in 1st trimester if enrolled in ANC"
		
		gen secweight= anc1weight if bsltrimester==2 
		forval i=1/8 {
			replace secweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secweight = 1 if m3_412b==1 & endtrime==2
		replace secweight = 0 if secweight==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secweight "Had weight measured in 2nd trimester if enrolled in ANC"

		gen thirdweight= anc1weight if bsltrimester==3
		forval i=1/8 {
			replace thirdweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdweight = 1 if m3_412b==1 & endtrime==3
		replace thirdweight = 0 if thirdweight==. & endtrime==3
		lab var thirdweight "Had weight measured in 3rd trimester if enrolled in ANC"

		egen laqsweight=rowmin(firstweight secweight thirdweight)
		
	* BLOOD PRESSURE
		gen firstbp= anc1bp if bsltrimester==1
		forval i=1/8 {
			replace firstbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstbp = 1 if m3_412a==1 & endtrime==1
		lab var firstbp "Had BP measured in 1st trimester if enrolled in ANC"
		
		gen secbp= anc1bp if bsltrimester==2 
		forval i=1/8 {
			replace secbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secbp = 1 if m3_412a==1 & endtrime==2
		replace secbp = 0 if secbp==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secbp "Had BP measured in 2nd trimester if enrolled in ANC"

		gen thirdbp= anc1bp if bsltrimester==3
		forval i=1/8 {
			replace thirdbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdbp = 1 if m3_412a==1 & endtrime==3
		replace thirdbp = 0 if thirdbp==. & endtrime==3
		lab var thirdbp "Had BP measured in 3rd trimester if enrolled in ANC"

		egen laqsbp=rowmin(firstbp secbp thirdbp)
		
	* VISITS
		gen firstvisit= 1 if bsltrimester==1
		forval i=1/8 {
			replace firstvisit = 1 if ranc`i'==1 & m2_trimes_r`i'==1
		}
		replace firstvisit = 1 if ranclast==1 & endtrime==1
		lab var firstvisit "Had ANC in 1st trimester"
		replace firstvis = 0 if bsltrim!=1 & firstvi==.
		
		gen secvisit= 1 if bsltrimester==2 
		forval i=1/8 {
			replace secvisit = 1 if ranc`i'==1 & m2_trimes_r`i'==2
		}
		replace secvis = 1 if ranclast==1 & endtrime==2
		replace secvis = 0 if secvis==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secbp "Had ANC in 2nd trimester"

		gen thirdvis= 1 if bsltrimester==3
		forval i=1/8 {
			replace thirdvis = 1 if ranc`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdvis = 1 if ranclast==1 & endtrime==3
		replace thirdvis = 0 if thirdvis==. & endtrime==3
		lab var thirdbp "Had ANC in 3rd trimester"

		egen laqsvis=rowmin(firstvis secvis thirdvis)
		
	* TIMELY ULTRASOUND
		gen laqstimelyultra=anc1ultra 
		replace laqstimelyultra=0 if bslga>24
		replace laqstimelyultra=. if bslga==.d | bslga==.n
		forval i=1/8 {
				replace laqstimelyultra = 1 if m2_501f_r`i'==1 & m2_ga_r`i'<=24
			}
		replace laqstimelyultra = 1 if m3_412f ==1 & ga_endpreg <=24
				
*-------------------------------------------------------------------------------		
	* TOTAL ANC QUALITY SCORE
*-------------------------------------------------------------------------------	
		* First visit
			rename (m1_700 m1_701 m1_703  m1_705 m1_712 m1_716a m1_716b m1_716c ///
			m1_716e m1_801 m1_806 m1_809 m1_724a) (anc1_bp anc1_weight anc1_muac ///
			anc1_urine anc1_ultrasound anc1_nutri anc1_exer anc1_anxi ///
			anc1_dangers anc1_edd anc1_lmp anc1_bplan anc1_return)
			
			egen anc1_bmi= rowtotal(anc1_weight m1_702)
			recode anc1_bmi 1=0 2=1
			recode m1_713a 2=1 3=0, g(anc1_ifa)
			recode  m1_713b 2=1 3=0, g(anc1_calcium)
			egen anc1_refer=rowmax(m1_724c m1_724e) // told to see ob or gyn or hospital for anc
			
		* Follow up visits
			rename (m2_501a_r1 m2_501a_r2 m2_501a_r3 m2_501a_r4 m2_501a_r5 ///
					m2_501a_r6 m2_501a_r7 m2_501a_r8 m3_412a) (m2_bp_r1 m2_bp_r2 ///
					m2_bp_r3 m2_bp_r4 m2_bp_r5 m2_bp_r6 m2_bp_r7 m2_bp_r8 m3_bp)
			
			rename (m2_501b_r1 m2_501b_r2 m2_501b_r3 m2_501b_r4 m2_501b_r5 ///
					m2_501b_r6 m2_501b_r7 m2_501b_r8 m3_412b) (m2_wgt_r1 m2_wgt_r2 ///
					 m2_wgt_r3 m2_wgt_r4 m2_wgt_r5 m2_wgt_r6 m2_wgt_r7 m2_wgt_r8 m3_wgt)
					
			rename (m2_501e_r1 m2_501e_r2 m2_501e_r3 m2_501e_r4 m2_501e_r5 ///
					m2_501e_r6 m2_501e_r7 m2_501e_r8 m3_412e) (m2_urine_r1 m2_urine_r2 ///
					m2_urine_r3 m2_urine_r4 m2_urine_r5 m2_urine_r6 m2_urine_r7 ///
					m2_urine_r8 m3_urine)
			
			rename 	(m2_501f_r1 m2_501f_r2 m2_501f_r3 m2_501f_r4 m2_501f_r5 ///
					m2_501f_r6 m2_501f_r7 m2_501f_r8 m3_412f) (m2_us_r1 m2_us_r2 ///
					m2_us_r3 m2_us_r4 m2_us_r5 m2_us_r6 m2_us_r7 m2_us_r8 m3_us)
					
			rename (m2_506a_r1 m2_506a_r2 m2_506a_r3 m2_506a_r4 m2_506a_r5 ///
					m2_506a_r6 m2_506a_r7 m2_506a_r8) (m2_danger_r1 m2_danger_r2 ///
					m2_danger_r3 m2_danger_r4 m2_danger_r5 m2_danger_r6 ///
					m2_danger_r7 m2_danger_r8)
			
			rename (m2_506b_r1 m2_506b_r2 m2_506b_r3 m2_506b_r4 m2_506b_r5 ///
					m2_506b_r6 m2_506b_r7 m2_506b_r8) ///
					(m2_bplan_r1 m2_bplan_r2 m2_bplan_r3 m2_bplan_r4 ///
					m2_bplan_r5 m2_bplan_r6 m2_bplan_r7 m2_bplan_r8)
					
			rename (m2_601a_r1 m2_601a_r2 m2_601a_r3 m2_601a_r4 m2_601a_r5 ///
					m2_601a_r6 m2_601a_r7 m2_601a_r8) ///
					(m2_ifa_r1 m2_ifa_r2 m2_ifa_r3 m2_ifa_r4 m2_ifa_r5 ///
					m2_ifa_r6 m2_ifa_r7 m2_ifa_r8)
			
			rename (m2_601b_r1 m2_601b_r2 m2_601b_r3 m2_601b_r4 m2_601b_r5 ///
					m2_601b_r6 m2_601b_r7 m2_601b_r8) (m2_calcium_r1 ///
					m2_calcium_r2 m2_calcium_r3 m2_calcium_r4 m2_calcium_r5 ///
					m2_calcium_r6 m2_calcium_r7 m2_calcium_r8)
			
			egen totalifa=rowtotal(anc1_ifa m2_ifa_r*)
			egen totalbp=rowtotal(anc1_bp m2_bp_r* m3_bp*)
			egen totalweight=rowtotal(anc1_weight m2_wgt_r* m3_wgt*)
			egen totalblood=rowtotal(anc1_blood m2_blood_r* m3_blood*)
			egen totalurine=rowtotal(anc1_urine m2_urine_r* m3_urine*)	
			recode totalbp 4/max=4, g(maxbp4)
			recode totalweight 4/max=4, g(maxwgt4)
			recode totalurine 4/max=4, g(maxurine4)
			recode totalblood 4/max=4, g(maxblood4)
			egen totalus =rowtotal(anc1_ultrasound m2_us_r* m3_us)
				recode totalus 4/max=4, g(maxus4)
				recode totalus 1/max=1, g(anyus)
			egen totaldanger=rowtotal(anc1_dangers m2_danger_r*) 
				recode totaldanger 4/max=4, g(maxdanger4)
			egen totalbplan= rowtotal(anc1_bplan m2_bplan_r*)
				recode totalbplan 4/max=4, g(maxbplan4)
				recode totalifa 4/max=4, g(maxifa4)
			egen totalcalcium = rowtotal(anc1_calcium m2_calcium_r*)
				recode totalcalcium 4/max=4, g(maxcalc4)
			egen deworm=rowmax(anc1deworm m2_601e_r*)
			
			recode totaldanger 1/max=1, g(anydanger)
			recode totalbplan 1/max=1, g(anybplan)
			recode totalifa 1/max=1, g(anyifa)
			recode totalcalcium 1/max=1, g(anycalcium)
							
			* ANC mean score
			g bp1 = totalbp>=1 
			g bp2 = totalbp>=2
			g bp3 = totalbp>=3
			
			g wgt1 = totalweight>=1
			g wgt2 = totalweight>=2
			g wgt3 = totalweight>=3
			
			g urine1 = totalurine>=1
			g urine2 = totalurine >= 2
			g urine3 = totalurine >= 3

			g blood1 = totalblood >= 1
			g blood2 = totalblood >= 2
			g blood3 = totalblood >= 3
			
			egen ancmean=rowmean(bp1 bp2 bp3 wgt1 wgt2 wgt3 urine1 urine2 urine3 ///
					blood1 blood2 blood3 laqstimelyultra anybplan anydanger anc1_bmi anc1_muac ///
					anc1_anxi anc1_lmp anc1_nutri anc1_exer anc1_edd anyifa anycalcium deworm)
					
			egen ancmeantert=cut(ancmean) , group(3)	
			
			egen ancall=rowmin(bp1 bp2 bp3 wgt1 wgt2 wgt3 urine1 urine2 urine3 ///
					blood1 blood2 blood3 laqstimelyultra anybplan anydanger anc1_bmi anc1_muac ///
					anc1_anxi anc1_lmp anc1_nutri anc1_exer anc1_edd anyifa anycalcium deworm)
			
*-------------------------------------------------------------------------------		
	* DEMOGRAPHICS AND RISK FACTORS
*-------------------------------------------------------------------------------	
		* Demographics
			rename m1_enrollage enrollage
			recode enrollage (min/19=1 "<20") (20/34=2 "20-34") (35/max=3 "35+"), g(agecat)
			recode enrollage (min/19=1) (20/max=0), g(age19)
			recode enrollage (min/34=0) (35/max=1), g(age35)
			// educ_cat  quintile  marriedp
			gen healthlit_corr=m1_health_lit==4
			g second= educ_cat>=3 & educ_cat<.
			rename  facility_lvl factype
		* Experienced danger signs at baseline
			egen m1danger=rowmax(m1_814b m1_814c m1_814f m1_814g) 
				// vaginal bleeding, fever, convulsions or seizures, fainting or LOC
			recode m1_506 1/5=1 6=2 96=1 7=3 8=1 9=4,g(job)
				lab def job 1"Employed" 2"Homemaker" 3"Student" 4"Unemployed"
				lab val job job 
		* Risk factors
			*Anemia at baseline
			egen anemia= rowmax(m1_1307 m1_1309)
			recode anemia 0/10.99999=1 11/30=0
			lab def anemia 1 "Anemia (Hb<11g/dl)" 0 "Normal"
			lab val anemia anemia
			
			* Chronic illnesses
			replace m1_203 = 0 if   m1_203_other=="Chgara" ///
			| m1_203_other=="Chronic Gastritis" ///
			| m1_203_other=="Chronic Sinusitis and tonsil" ///
			| m1_203_other=="Gastritis" | m1_203_other=="Gastro intestinal track"  ///
			| m1_203_other=="STI" | m1_203_other=="Hemorrhoids"  | m1_203_other=="Sinus" | ///
			m1_203_other=="Sinuse" | m1_203_other=="Sinusitis" | ///
			m1_203_other=="gastric" | m1_203_other=="gastric ulcer" 
			
			egen chronic = rowtotal(m1_202a m1_202b m1_202c m1_202d m1_202e ///
			m1_202g_et m1_203 )
			lab var chronic "Number of self reported chronic illnesses"
			
			* Malnutrition
			gen malnut= m1_muac<23
			
			* Previous obstetric complications
			gen multiple= m1_805 >1 &  m1_805<.
			gen cesa= m1_1007==1
			gen neodeath = m1_1010 ==1
			gen preterm = m1_1005 ==1
			gen PPH=m1_1006==1
			rename m1_1004 late_misc
			egen complic = rowtotal(stillbirth preterm neodeath PPH late_misc)

			
			egen riskcat=rowtotal(chronic malnut complic)
			recode riskcat 2/max=2 
			lab def riskcat 0"No risk factor" 1"One risk factor" 2"Two or more risk factors" 
			lab val riskcat riskcat	
			
			
*-------------------------------------------------------------------------------
* DELIVERY COMPLICATIONS
*-------------------------------------------------------------------------------
	* problem: a lot of women with pregnancy losses did not answer the delivery questions!
	
	* Self reported health shortly after delivery
	egen countsr2=rownonmiss(m2_201_r*)
		gen srh= m2_201_r1 if countsr2==1
		replace srh= m2_201_r2 if countsr2==2
		replace srh= m2_201_r3 if countsr2==3
		replace srh= m2_201_r4 if countsr2==4
		replace srh= m2_201_r5 if countsr2==5
		replace srh= m2_201_r6 if countsr2==6
		replace srh= m2_201_r7 if countsr2==7
		replace srh= m2_201_r8 if countsr2==8
		
		recode srh 1/3=0 4/5=1, g(poorh)
	
	recode 	m3_707 1/120=0 144/max=1, g(ext) // more than 5 days
	*replace ext =0 if m3_605a ==1 & (m3_707>48 & m3_707>=120) // more than 5 days for c-sections
	
	egen dcomplic=rowmax(m3_706 m3_705 ext) // ICU, blood transfusion
	replace dcomplic=0 if dcomplic>=. // will include those delivering at home
	egen anyc=rowmax(dcomplic poorh) 
	
	egen complic2=rowmax(m3_704a m3_704f m3_704g) //seizures, excessive bleeding, fever
	
	* delivery facility type
			gen hospital_del_fac = (m3_502 == 1 |  m3_502 == 5 | m3_502 == 6) if m3_502 <. & m3_502 !=.a 
			replace hospital_del_fac = 1 if m3_503_inside_zone_other == "Share hospital" ///
				| m3_503_outside_zone_other == "Dubo catholic Hospital"
			label define hospital_del_fac 1 "hospital" 0 "primary" 2"home"
			label values hospital_del_fac hospital_del_fac
			replace hospital_del_fac=2 if  m3_501==0
	
save "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/ETtmp.dta", replace
