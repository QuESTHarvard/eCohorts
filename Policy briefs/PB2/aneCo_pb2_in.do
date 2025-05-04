
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
*-------------------------------------------------------------------------------
	* VISIT CASCADE
*-------------------------------------------------------------------------------	
	* all eCohort women have ANC1
	gen firstvisit= 1 if bsltrimester==1
	gen secvisit = 1 if bsltrimester==2
	gen thirdvisit = 1 if bsltrimester==3
	
	forval i=1/8 {
			egen m2visit`i'=rowmax(m2_305_r`i' m2_306_r`i')
	}
	egen m3visit=rowmax(m3_403 m3_404 m3_406 m3_407 m3_409 m3_410)	

	forval i=1/8 {
			replace firstvisit = 1 if m2visit`i'==1 & m2_trimes_r`i'==1
		}
	replace firstvisit = 1 if m3visit==1 & endtrime==1
	lab var firstvisit "Had an ANC visit in 1st trimester if enrolled in ANC"
	
	forval i=1/8 {
			replace secvisit = 1 if m2visit`i'==1 & m2_trimes_r`i'==2
		}
		replace secvisit = 1 if m3visit==1 & endtrime==2
		replace secvisit = 0 if secvisit==. & (bsltrimester ==1 | bsltrimester ==2)
		lab var secvisit "Had an ANC visit in 2nd trimester if enrolled in ANC"
	
	forval i=1/8 {
			replace thirdvisit = 1 if m2visit`i'==1 & m2_trimes_r`i'==3
		}
		replace thirdvisit = 1 if m3visit==1 & endtrime==3
		replace thirdvisit = 0 if thirdvisit==. & endtrime==3
		lab var thirdvisit "Had an ANC visit in 3rd trimester if enrolled in ANC"

		egen trimenrolled=rownonmiss(firstvisit secvisit thirdvisit)
		egen totalvisit=rowtotal(firstvisit secvisit thirdvisit)
		gen timelyvisit= totalvisit /trimenrolled
		recode timelyvisit 0/0.99=0 
		lab var timelyvisit "Had at least one ANC visit each trimester enrolled in care" //

		tabstat firstvisit secvisit thirdvisit , stat(mean count) col(stat)
				
*-------------------------------------------------------------------------------
	* ANEMIA CASCADE
*-------------------------------------------------------------------------------	
	cd "$user/MNH E-Cohorts-internal/Analyses/Policy Briefs/PB2"
	
	* Anemia
	egen anemia= rowmax(m1_1307 m1_1309)
	recode anemia 0/10.99999=1 11/30=0
	lab def anemia 1 "Anemia (Hb<11g/dl)" 0 "Normal"
	lab val anemia anemia

	* Blood tests
	egen anc1_blood=rowmax(m1_706 m1_707)
	foreach r in r1 r2 r3 r4 r5 r6 r7 r8 {
			egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
			egen m3_blood=rowmax(m3_412_c m3_412_d)
			
	* Proportion of women who got at least one blood test per trimester enrolled in ANC
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

		egen trimenrolled=rownonmiss(firstblood secblood thirdblood)
		egen totalblood=rowtotal(firstblood secblood thirdblood)
		gen timelyblood= totalblood /trimenrolled
		recode timelyblood 0/0.99=0 
		lab var timelyblood "Had a blood test each trimester enrolled in care" //
	
	* Proportion given or prescribed IFA & report taking IFA  (at least once for each)
		egen ifa=rowmax(anc1ifa m2_601a_r*)
		egen ifafreq=rowmax(m2_603_r*) 
		egen dailyifa =rowtotal(ifa ifafreq) 
		recode dailyifa 2=1 0/1=0
			drop ifa ifafreq trimenrolled
		lab var dailyifa "Given or prescribed IFA tablets & reports taking IFA at least once in pregnancy"
		
		tab1 timelyblood dailyifa if anemia==1
	
		tabstat firstblood secblood thirdblood, stat(mean count) col(stat)

*-------------------------------------------------------------------------------
	* MALNUTRITION CASCADE
*-------------------------------------------------------------------------------	
	* m1_malnutrition
	* anc1weight m2_501b_r1 m3_412b
			
	* Proportion of women who had their weight measured at least once per trimester enrolled in ANC
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
		replace thirdweight = 1 if m3_412_b==3 & endtrime==3
		replace thirdweight = 0 if thirdweight==. & endtrime==3
		lab var thirdweight "Had weight measured in 3rd trimester if enrolled in ANC"

		egen trimenrolled=rownonmiss(firstweight secweight thirdweight)
		egen totalweight=rowtotal(firstweight secweight thirdweight)
		gen timelyweight= totalweight /trimenrolled
		recode timelyweight 0/0.99=0 
		lab var timelyweight "Had weight measured each trimester enrolled in care" //
		
		tabstat firstweight secweight thirdweight, stat(mean count) col(stat)

		tab1 timelyweight if low_BMI ==1 
		
		* Proportion of undernourished women given or prescribed food supplements at least once in pregnancy
		egen foodsupp=rowmax(anc1food_supp m2_601d_r*)
		
		ta foodsupp if low_BMI ==1
