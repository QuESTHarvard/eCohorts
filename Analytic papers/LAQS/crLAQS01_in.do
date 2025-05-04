* INDIA
	u "$in_data_final/eco_IN_Complete.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date<. // 35 deleted

*-------------------------------------------------------------------------------	
	* RECALCULATING BASELINE GA and RUNNING GA
	* Baseline GA 
			rename m3_302 m3_birth_or_ended
			gen bslga=m1_ga
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+m1_ga
			// 10% have gestation > 42 wks
			drop ga_endpreg	
	* Recalculating baseline and running GA based on DOB for those with live births
	* and no LBW babies.
		gen bslga2 = 40-((m3_birth_or_ended-m1_date)/7)
		egen alive=rowmin(m3_303_b*  ) // any baby died
			replace bslga2=. if alive==0
		/*recode m3_baby1_weight min/2.4999=1 2.5/max=0
		recode m3_baby2_weight min/2.4999=1 2.5/max=0 
		egen lbw=rowmax(m3_baby1_weight m3_baby2_weight )
			replace bslga2=. if lbw==1 */
			replace bslga2=. if m3_307_b1==4 | m3_307_b1==5 | m3_307_b2==4 | m3_307_b2==5 
			replace bslga2=. if bslga2<0
			replace bslga= bslga2 if bslga2!=. 
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga 
			recode ga_endpreg (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), g(endtrimes)
	* Recalculating running GA and running trimester 
		drop m2_ga_r1  m2_ga_r2 m2_ga_r3 m2_ga_r4 m2_ga_r5 m2_ga_r6 m2_ga_r7 ///
		m2_ga_r8 m2_ga_r9 m2_ga_r10
		forval i=1/10 {
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
					
drop if bslga>=.
*-------------------------------------------------------------------------------	
	* Number of routine ANC or ANC referral visits  at each follow-up call
		forval i= 1/10 {
			egen ranc`i'=rowtotal(m2_305_r`i' m2_306_r`i' m2_308_r`i' m2_309_r`i' ///
					m2_311_r`i' m2_312_r`i' m2_314_r`i' m2_315_r`i'  ///
					m2_317_r`i' m2_318_r`i' ), m
		}
			egen ranclast=rowtotal(m3_403 m3_404 m3_406 m3_407 m3_409 m3_410)
		
		egen totvisref=rowtotal(ranc*)
		replace totvisref=totvisref+1
		recode totvisref 3=2 4/7=3 8/max=4 , gen(viscatref)
		lab val viscatref totvis 
		lab var viscatref "Total number of routine ANC visits (categories)"
		
*-------------------------------------------------------------------------------
* LAQS
*-------------------------------------------------------------------------------
	* BLOOD
		egen anc1_blood=rowmax(m1_706 m1_707)
		foreach r in r1 r2 r3 r4 r5 r6 r7 r8 {
			egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
			egen m3_blood=rowmax(m3_412_c m3_412_d)
			
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
		replace firsturine = 1 if m3_412_e==1 & endtrime==1
		lab var firsturine "Had a urine test in 1st trimester if enrolled in ANC"
		
		gen securine= anc1urine if bsltrimester==2 
		forval i=1/8 {
			replace securine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==2
		}
		replace securine = 1 if m3_412_e==1 & endtrime==2
		replace securine = 0 if securine==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var securine "Had a urine test in 2nd trimester if enrolled in ANC"

		gen thirdurine= anc1urine if bsltrimester==3
		forval i=1/8 {
			replace thirdurine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdurine = 1 if m3_412_e==1 & endtrime==3
		replace thirdurine = 0 if thirdurine==. & endtrime==3
		lab var thirdurine "Had a urine test in 3rd trimester if enrolled in ANC"

		egen laqsurine=rowmin(firsturine securine thirdurine)
		
	* WEIGHT
		gen firstweight= anc1weight if bsltrimester==1
		forval i=1/8 {
			replace firstweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstweight = 1 if m3_412_b==1 & endtrime==1
		lab var firstweight "Had weight measured in 1st trimester if enrolled in ANC"
		
		gen secweight= anc1weight if bsltrimester==2 
		forval i=1/8 {
			replace secweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secweight = 1 if m3_412_b==1 & endtrime==2
		replace secweight = 0 if secweight==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secweight "Had weight measured in 2nd trimester if enrolled in ANC"

		gen thirdweight= anc1weight if bsltrimester==3
		forval i=1/8 {
			replace thirdweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdweight = 1 if m3_412_b==1 & endtrime==3
		replace thirdweight = 0 if thirdweight==. & endtrime==3
		lab var thirdweight "Had weight measured in 3rd trimester if enrolled in ANC"

		egen laqsweight=rowmin(firstweight secweight thirdweight)
		
	* BLOOD PRESSURE
		gen firstbp= anc1bp if bsltrimester==1
		forval i=1/8 {
			replace firstbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstbp = 1 if m3_412_a==1 & endtrime==1
		lab var firstbp "Had BP measured in 1st trimester if enrolled in ANC"
		
		gen secbp= anc1bp if bsltrimester==2 
		forval i=1/8 {
			replace secbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secbp = 1 if m3_412_a==1 & endtrime==2
		replace secbp = 0 if secbp==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secbp "Had BP measured in 2nd trimester if enrolled in ANC"

		gen thirdbp= anc1bp if bsltrimester==3
		forval i=1/8 {
			replace thirdbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdbp = 1 if m3_412_a==1 & endtrime==3
		replace thirdbp = 0 if thirdbp==. & endtrime==3
		lab var thirdbp "Had BP measured in 3rd trimester if enrolled in ANC"

		egen laqsbp=rowmin(firstbp secbp thirdbp)
		
	* TIMELY ULTRASOUND
		gen laqstimelyultra=anc1ultra 
		replace laqstimelyultra=0 if bslga>24
		replace laqstimelyultra=. if bslga==.d | bslga==.n
		forval i=1/8 {
				replace laqstimelyultra = 1 if m2_501f_r`i'==1 & m2_ga_r`i'<=24
			}
		replace laqstimelyultra = 1 if m3_412_f ==1 & ga_endpreg <=24
		
	* Counselled at least once in pregnancy on:
		* Nutrition
			gen laqsnutri=m1_716a
		* Birth preparedness
			egen laqsbpp=rowmax(m1_809 m2_506b_r*)
		* Pregnancy complications	
			egen laqscomplic=rowmax(m1_716e m2_506a_r*)
		* Newborn care
			egen laqsnbc=rowmax(m2_506c_r*)

	* At least once in pregnancy given or prescribed IFA
		egen laqsifa=rowmax(m1_713a m2_601a_r*)
		
		
	egen totlaqs=rowmin(laqs*) // all items yes/no
	
	egen meanlaqs=rowmean(laqs*)
	
	
		