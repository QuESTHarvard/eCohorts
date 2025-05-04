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
			graph pie, over(viscat) plabel(_all percent, format(%9.2g)) legend(off)
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
		graph pie, over(viscatref) plabel(_all percent, format(%9.2g)) legend(off)
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
	egen m3visit=rowmax(m3_consultation_* m3_consultation_referral_*)	

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
		drop trimenrolled
		lab var timelyvisit "Had at least one ANC visit each trimester enrolled in care" //

		tabstat firstvisit secvisit thirdvisit , stat(mean count) col(stat)
					
*-------------------------------------------------------------------------------
	* ANEMIA CASCADE
*-------------------------------------------------------------------------------	
	cd "$user/MNH E-Cohorts-internal/Analyses/Policy Briefs/PB2"
		
		* Anemia	
		recode bsl_Hb 0/10.99999=1 11/30=0, gen(anemia)
		lab val anemia anemia
			
		* Blood tests
		egen anc1_blood=rowmax(m1_706 m1_707)
		foreach r in r1 r2 r3 r4 r5 r6 r7 r8 {
			egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				}	
		egen m3_blood=rowmax(m3_412c_* m3_412d_*)
		
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
	
	* Proportion given or prescribed IFA & reports taking IFA (at least once for each)
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
	* bsl_low_BMI 
	* anc1weight m2_501b_r1 
	egen m3_weight=rowmax(m3_412b_1_ke m3_412b_2_ke m3_412b_3_ke)
			
	* Proportion of women who had their weight measured at least once per trimester enrolled in ANC
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
		replace thirdweight = 1 if m3_weight==3 & endtrime==3
		replace thirdweight = 0 if thirdweight==. & endtrime==3
		lab var thirdweight "Had weight measured in 3rd trimester if enrolled in ANC"

		egen trimenrolled=rownonmiss(firstweight secweight thirdweight)
		egen totalweight=rowtotal(firstweight secweight thirdweight)
		gen timelyweight= totalweight /trimenrolled
		recode timelyweight 0/0.99=0 
		lab var timelyweight "Had weight measured each trimester enrolled in care" //
		
		tabstat firstweight secweight thirdweight, stat(mean count) col(stat)

		tab1 timelyweight if bsl_low_BMI ==1 
		
		* Proportion of undernourished women given or prescribed food supplements at least once in pregnancy
		egen foodsupp=rowmax(anc1food_supp m2_601d_r*)
		
		ta foodsupp if bsl_low_BMI ==1

*-------------------------------------------------------------------------------
	* MATERNAL BIRTH COMPLICATIONS
*-------------------------------------------------------------------------------					
		g ext=m3_707_ke_unit==1
		replace ext=1 if m3_707_ke_unit==2 & m3_707_ke>=7 & m3_707_ke<.
		
		egen bcomplic=rowmax(m3_703 m3_705 m3_706 ext)
