* South Africa
	u "$za_data_final/eco_ZA_Complete.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date!=.
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
		replace anygap=. if tag7==1 & (tag1!=1 & tag2!=1 & tag3!=1 ///
			& tag4!=1 & tag5!=1 & tag6!=1) & countm2>=2
		// won't exclude if the long gap was at the end
		// and there were at least 3 follow-ups in pregnancy
		
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

drop if bslga>=.
drop if anygap==1
*-------------------------------------------------------------------------------
		* Number of routine ANC or ANC referral visits  at each follow-up call
		forval i= 1/6 {
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
* LAQS
*-------------------------------------------------------------------------------
	* BLOOD
		egen anc1_blood=rowmax(m1_706 m1_707)
		foreach r in r1 r2 r3 r4 r5 r6  {
			egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
			egen m3_blood=rowmax(m3_412c m3_412d)
			
		gen firstblood= anc1_blood if bsltrimester==1
		forval i=1/6 {
			replace firstblood = 1 if m2_blood_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstblood = 1 if m3_blood==1 & endtrime==1
		lab var firstblood "Had a blood test in 1st trimester if enrolled in ANC"
		
		gen secblood= anc1_blood if bsltrimester==2 
		forval i=1/6 {
			replace secblood = 1 if m2_blood_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secblood = 1 if m3_blood==1 & endtrime==2
		replace secblood = 0 if secblood==. & (bsltrimester ==1 | bsltrimester ==2) // started ANC in 1st or 2nd trimester
		lab var secblood "Had a blood test in 2nd trimester if enrolled in ANC"

		gen thirdblood= anc1_blood if bsltrimester==3
		forval i=1/6 {
			replace thirdblood = 1 if m2_blood_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdblood = 1 if m3_blood==1 & endtrime==3
		replace thirdblood = 0 if thirdblood==. & endtrime==3
		lab var thirdblood "Had a blood test in 3rd trimester if enrolled in ANC"
		
		egen laqsblood=rowmin(firstblood secblood thirdblood)
	
	* URINE
		gen firsturine= anc1urine if bsltrimester==1
		forval i=1/6 {
			replace firsturine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firsturine = 1 if m3_412e==1 & endtrime==1
		lab var firsturine "Had a urine test in 1st trimester if enrolled in ANC"
		
		gen securine= anc1urine if bsltrimester==2 
		forval i=1/6 {
			replace securine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==2
		}
		replace securine = 1 if m3_412e==1 & endtrime==2
		replace securine = 0 if securine==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var securine "Had a urine test in 2nd trimester if enrolled in ANC"

		gen thirdurine= anc1urine if bsltrimester==3
		forval i=1/6 {
			replace thirdurine = 1 if m2_501e_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdurine = 1 if m3_412e==1 & endtrime==3
		replace thirdurine = 0 if thirdurine==. & endtrime==3
		lab var thirdurine "Had a urine test in 3rd trimester if enrolled in ANC"

		egen laqsurine=rowmin(firsturine securine thirdurine)
		
	* WEIGHT
		gen firstweight= anc1weight if bsltrimester==1
		forval i=1/6 {
			replace firstweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstweight = 1 if m3_412b==1 & endtrime==1
		lab var firstweight "Had weight measured in 1st trimester if enrolled in ANC"
		
		gen secweight= anc1weight if bsltrimester==2 
		forval i=1/6 {
			replace secweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secweight = 1 if m3_412b==1 & endtrime==2
		replace secweight = 0 if secweight==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secweight "Had weight measured in 2nd trimester if enrolled in ANC"

		gen thirdweight= anc1weight if bsltrimester==3
		forval i=1/6 {
			replace thirdweight = 1 if m2_501b_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdweight = 1 if m3_412b==1 & endtrime==3
		replace thirdweight = 0 if thirdweight==. & endtrime==3
		lab var thirdweight "Had weight measured in 3rd trimester if enrolled in ANC"

		egen laqsweight=rowmin(firstweight secweight thirdweight)
		
	* BLOOD PRESSURE
		gen firstbp= anc1bp if bsltrimester==1
		forval i=1/6 {
			replace firstbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==1
		}
		replace firstbp = 1 if m3_412a==1 & endtrime==1
		lab var firstbp "Had BP measured in 1st trimester if enrolled in ANC"
		
		gen secbp= anc1bp if bsltrimester==2 
		forval i=1/6 {
			replace secbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==2
		}
		replace secbp = 1 if m3_412a==1 & endtrime==2
		replace secbp = 0 if secbp==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secbp "Had BP measured in 2nd trimester if enrolled in ANC"

		gen thirdbp= anc1bp if bsltrimester==3
		forval i=1/6 {
			replace thirdbp = 1 if m2_501a_r`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdbp = 1 if m3_412a==1 & endtrime==3
		replace thirdbp = 0 if thirdbp==. & endtrime==3
		lab var thirdbp "Had BP measured in 3rd trimester if enrolled in ANC"

		egen laqsbp=rowmin(firstbp secbp thirdbp)
		
	* TIMELY ULTRASOUND
		gen laqstimelyultra=anc1ultra 
		replace laqstimelyultra=0 if bslga>24
		replace laqstimelyultra=. if bslga==.d | bslga==.n
		forval i=1/6 {
				replace laqstimelyultra = 1 if m2_501f_r`i'==1 & m2_ga_r`i'<=24
			}
		replace laqstimelyultra = 1 if m3_412f ==1 & ga_endpreg <=24
		
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
	
	
				
		