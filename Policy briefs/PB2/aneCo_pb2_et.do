* ETHIOPIA
	u "$et_data_final/eco_ET_Complete.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date<. // 112 lost 

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
			egen m3_blood=rowmax(m3_412c m3_412d)
			
	* Proportion of women who got at least one blood test per trimester enrolled in ANC
	preserve
			keep redcap_record_id
			save tmp1.dta, replace
	restore
	
	preserve
		replace anc1_blood = . if bsltrimester!=1
		forval i=1/8 {
			replace m2_blood_r`i'= . if m2_trimes_r`i'!=1  
		}
		replace m3_blood=. if endtrimes!=1
			
		egen first_trim_blood=rowmax(anc1_blood m2_blood_r* m3_blood)
		lab var first_trim_blood "At least one blood test in first trimester"
		replace first_trim_blood = . if bsltrimester!=1 // if she didnt start ANC in 1st trimester
		
		keep redcap_record_id first_trim_blood 
			merge 1:1 redcap_record_id using tmp1.dta
			drop _merge
			save timelyanc.dta, replace
	restore
		
				