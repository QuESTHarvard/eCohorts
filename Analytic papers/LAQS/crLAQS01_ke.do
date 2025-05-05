* KENYA
	u "$ke_data_final/eco_KE_Complete.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date!=. // 107 deleted

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
*drop if bslga>=.
*-------------------------------------------------------------------------------
	* Number of routine ANC or ANC referral visits  at each follow-up call
		forval i= 1/8 {
			egen ranc`i'=rowtotal(m2_305_r`i' m2_306_r`i' m2_308_r`i' m2_309_r`i' ///
					m2_311_r`i' m2_312_r`i' m2_314_r`i' m2_315_r`i'  ///
					m2_317_r`i' m2_318_r`i' ), m
		}
			egen ranclast=rowtotal(m3_consultation_* m3_consultation_referral_*)
		
		egen totvisref=rowtotal(ranc*)
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
		egen m3_blood=rowmax(m3_412c_* m3_412d_*)
		
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
		replace secblood = 0 if secblood==. & (bsltrimester ==1 | bsltrimester ==2)
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
		egen m3urine=rowmax(m3_412e_1_ke m3_412e_2_ke m3_412e_3_ke)
		
		gen firsturine= anc1urine if bsltrimester==1
		forval i=1/8 {
			replace firsturine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firsturine = 1 if m3urine==1 & endtrime==1
		lab var firsturine "Had a urine test in 1st trimester if enrolled in ANC"
		
		gen securine= anc1urine if bsltrimester==2 
		forval i=1/8 {
			replace securine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==2
		}
		replace securine = 1 if m3urine==1 & endtrime==2
		replace securine = 0 if securine==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var securine "Had a urine test in 2nd trimester if enrolled in ANC"

		gen thirdurine= anc1urine if bsltrimester==3
		forval i=1/8 {
			replace thirdurine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdurine = 1 if m3urine==1 & endtrime==3
		replace thirdurine = 0 if thirdurine==. & endtrime==3
		lab var thirdurine "Had a urine test in 3rd trimester if enrolled in ANC"

		egen laqsurine=rowmin(firsturine securine thirdurine)
		
* WEIGHT
		egen m3_weight=rowmax(m3_412b_1_ke m3_412b_2_ke m3_412b_3_ke)
			
		gen firstweight= anc1weight if bsltrimester==1
		forval i=1/8 {
			replace firstweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstweight = 1 if m3_weight==1 & endtrime==1
		lab var firstweight "Had weight measured in 1st trimester if enrolled in ANC"
		
		gen secweight= anc1weight if bsltrimester==2 
		forval i=1/8 {
			replace secweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secweight = 1 if m3_weight==1 & endtrime==2
		replace secweight = 0 if secweight==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secweight "Had weight measured in 2nd trimester if enrolled in ANC"

		gen thirdweight= anc1weight if bsltrimester==3
		forval i=1/8 {
			replace thirdweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdweight = 1 if m3_weight==1 & endtrime==3
		replace thirdweight = 0 if thirdweight==. & endtrime==3
		lab var thirdweight "Had weight measured in 3rd trimester if enrolled in ANC"
		
		egen laqsweight=rowmin(firstweight secweight thirdweight)
		
* BLOOD PRESSURE
		egen m3_bp=rowmax(m3_412a_1_ke m3_412a_2_ke m3_412a_3_ke)
		
		gen firstbp= anc1bp if bsltrimester==1
		forval i=1/8 {
			replace firstbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstbp = 1 if m3_bp==1 & endtrime==1
		lab var firstbp "Had BP measured in 1st trimester if enrolled in ANC"
		
		gen secbp= anc1bp if bsltrimester==2 
		forval i=1/8 {
			replace secbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secbp = 1 if m3_bp==1 & endtrime==2
		replace secbp = 0 if secbp==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secbp "Had BP measured in 2nd trimester if enrolled in ANC"

		gen thirdbp= anc1bp if bsltrimester==3
		forval i=1/8 {
			replace thirdbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdbp = 1 if m3_bp==1 & endtrime==3
		replace thirdbp = 0 if thirdbp==. & endtrime==3
		lab var thirdbp "Had BP measured in 3rd trimester if enrolled in ANC"

		egen laqsbp=rowmin(firstbp secbp thirdbp)		

* TIMELY ULTRASOUND
		gen laqstimelyultra=anc1ultra 
		replace laqstimelyultra=0 if bslga>24
		forval i=1/8 {
				replace laqstimelyultra = 1 if m2_501f_r`i'==1 & m2_ga_r`i'<=24
			}
		egen m3_ultra=rowmax(m3_412f_1_ke m3_412f_2_ke m3_412f_3_ke)
		
		replace laqstimelyultra = 1 if m3_ultra ==1 & ga_endpreg <=24
		
* Counselled at least once in pregnancy on:
		* Nutrition
			gen laqsnutri=m1_716a
		* Birth preparedness
			egen laqsbpp=rowmax(m1_809 m2_506b_r*)
		* Pregnancy complications	
			egen laqscomplic=rowmax(m1_716e m2_506a_r*)
			
* At least once in pregnancy given or prescribed IFA
		recode m1_713a 1/2=1 3=0
		egen laqsifa=rowmax(m1_713a m2_601a_r*)
		
	egen totlaqs=rowmin(laqs*) // all items yes/no
	egen totlaqsnous=rowmin(laqsblood laqsurine laqsweight laqsbp laqsnutri ///
							laqsbpp laqscomplic laqsifa)
	
	egen meanlaqs=rowmean(laqs*)
	egen meanlaqsnous=rowmean(laqsblood laqsurine laqsweight laqsbp laqsnutri ///
								laqsbpp laqscomplic laqsifa)
	
	tab1 totlaqs totlaqsnous
	
	tabstat meanlaqs meanlaqsnous , stat(mean sd count ) col(stat)
	
	tabstat laqs* , stat(sum mean count) col(stat)
	
	egen tertlaqs = cut(meanlaqsnous), group(3)

*-------------------------------------------------------------------------------		
	* TOTAL ANC SCORE
	
		recode totalbp 4/max=4, g(maxbp4)
		recode totalweight 4/max=4, g(maxwgt4)
		recode totalurine 4/max=4, g(maxurine4)
		recode totalblood 4/max=4, g(maxblood4)
		egen totalus =rowtotal(anc1_ultrasound m2_us_r* m3_us*)
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
		
		egen anctotal=rowtotal(maxbp4 maxwgt4 anc1_bmi anc1_muac maxurine4 maxblood4 ///
					maxus4 anc1_anxi anc1_lmp anc1_nutri anc1_exer maxdanger4 anc1_edd ///
					maxbplan4 maxifa4 maxcalc4 deworm)	
					
					

*-------------------------------------------------------------------------------
* DELIVERY COMPLICATIONS
*-------------------------------------------------------------------------------
	* problem: a lot of women with pregnancy losses did not answer the delivery questions!
	
	* Self reported health shortly after delivery
	egen countm2=rownonmiss(m2_201_r*)
		gen srh= m2_201_r1 if countm2==1
		replace srh= m2_201_r2 if countm2==2
		replace srh= m2_201_r3 if countm2==3
		replace srh= m2_201_r4 if countm2==4
		replace srh= m2_201_r5 if countm2==5
		replace srh= m2_201_r6 if countm2==6
		replace srh= m2_201_r7 if countm2==7
		replace srh= m2_201_r8 if countm2==8
		
		recode srh 1/3=0 4/5=1, g(poorh)
	gen ext = m3_707_ke_unit==1
	replace ext = 1 if  m3_707_ke>=6 & m3_707_ke_unit==2


	egen dcomplic=rowmax(m3_706 m3_705  ext) // ICU, blood transfusion
	replace dcomplic=0 if dcomplic>=. // will include those delivering at home
	
	
	logistic poorh i.tertqual i.educ i.tertile i.age35 i.riskcat  i.bsltrimester
	logistic dcomplic i.tertqual i.educ i.tertile i.age35 i.riskcat  i.bsltrimester
	
	