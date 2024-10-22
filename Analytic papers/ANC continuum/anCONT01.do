
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
*-------------------------------------------------------------------------------
	global keepvars totalfu anctotal totvisits viscat bpthree wgtthree bloodthre ///
		   urinethre bsltrimester all4 anc1_bp anc1_weight anc1_blood anc1_urine site ///
			anc1_bmi anc1_muac anc1_ultrasound anc1_anxi anc1_lmp anc1_nutri anc1_exer ///
			anc1_dangers  anc1_edd anc1_bplan anc1_ifa anc1_calcium /// 13 items
			m2_bp_r* m3_bp* m2_wgt_r*  m3_wgt* m2_urine_r* m3_urine* m2_blood_r* m3_blood ///
			m2_us_r*  m3_us* m2_danger_r* m2_bplan_r* m2_ifa_r* m2_calcium_r* ///
			agecat enrollage healthlit_corr tertile married preg_intent educ_cat ///
			danger riskcat primipara second job
			
	* Appending datasets
	u ETtmp.dta, clear
	keep $keepvars quintile factype 
		gen country=1
		recode site 2=0 // 0 ES 1 Adama
		save allcountries.dta, replace
	
	u KEtmp.dta, clear
	rename study_site site
	keep $keepvars quintile factype 
		gen country=3 
		recode site 1=3 // 2 Kitui 3 Kiambu
		append using allcountries.dta
		save allcountries.dta, replace
	
	u ZAtmp.dta, clear
	rename study_site_sd site 
	keep $keepvars 
		gen country=4 
		recode site 1=7 2=6
		lab drop study_site_sd
		append using allcountries.dta
		save allcountries.dta, replace
	
	lab def site 0"Rural-ETH" 1"Urban-ETH" 2"Rural-KEN" 3"Urban-KEN" ///
	4"Rural-IND" 5"Urban-IND" 6 "Rural-ZAF" 7 "Urban-ZAF", modify
	lab val site site
	
	lab def country 1 "Ethiopia" 2 "India" 3 "Kenya" 4 "South Africa"
	lab val country country
*-------------------------------------------------------------------------------
	* DESCRIPTIVE ANALYSES
	
	replace viscat=. if totalfu<3
	replace anctotal=. if totalfu<3
	
	* Table 1
	summtab if riskcat==0, contvars(anctotal totvisits enrollage) ///
			catvars(viscat agecat second healthlit_corr tertile  job married ///
			factype preg_intent primipara bsltrimester danger riskcat) mean by(country) excel ///
			excelname(Table1) sheetname(norisk) replace 
			
	summtab if riskcat==1, contvars(anctotal totvisits enrollage ) ///
			catvars(viscat agecat second healthlit_corr tertile  job married ///
			factype preg_intent primipara bsltrimester danger riskcat) mean by(country) excel ///
			excelname(Table1) sheetname(onerisk) replace 
	
	summtab if riskcat==2, contvars(anctotal totvisits enrollage ) ///
			catvars(viscat agecat second healthlit_corr tertile  job married ///
			factype preg_intent primipara bsltrimester danger riskcat) mean by(country) excel ///
			excelname(Table1) sheetname(two+risks) replace 
			
	* Number of visits
	graph box totvisits, over(country) ytitle("Total number of visits")
	
	by country, sort: tabstat totvisit, stat(min max med mean)
	ta viscat country if totalfu>2, col nofreq

	* Minimum set of ANC items (among women with at least 3 surveys)
	by country, sort: tabstat bpthree wgtthree bloodthre urinethre  ///
						all4 if totalfu>2, stat(mean count) col(stat)
	
	* Minmum set of ANC items (among women with at least 3 surveys) and adjusted for multiple visits
	by country, sort: tabstat abpthree awgtthree abloodthre aurinethre  ///
						aall4 if totalfu>2, stat(mean count) col(stat)
						
	* Total number of items (among women surveyed at least 4 times)
	graph box anctotal if totalfu>3, over(site) ylabel(, labsize(small)) ///
		ytitle("Total number of antenatal care services received") asyvars ///
		box(1, fcolor(navy) lcolor(navy) lwidth(thin)) marker(1, mcolor(navy)) ///
		box(2, fcolor(navy) lcolor(navy) lwidth(thin)) marker(2, mcolor(navy)) ///
		box(3, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(4, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(5, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(6, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(7, fcolor(ebblue) lcolor(ebblue) lwidth(thin)) marker(3, mcolor(ebblue)) ///
		box(8, fcolor(ebblue) lcolor(ebblue)lwidth(thin)) marker(3, mcolor(ebblue)) 
		
	by country, sort: tabstat anctotal  if totalfu>3, stat(mean med count) col(stat)

	* Timely ANC
	u timelyanc.dta
		append using timelyancza 
		append using timelyancke 
	
		drop if anygap==1
		egen qual1=rowmean(anc1first ancfufirst)
		egen qual2=rowmean(anc1second ancfusecond)
		egen qual3=rowmean(anc1third ancfuthird)
		
		graph box qual1 qual2 qual3 , over(country)
		
		* Among women enrolled in 1st
		graph box qual1 qual2 qual3 if bsltrimester==1, over(country)
	
		* First and follow up visits
		graph box anc1first anc1second anc1third, over(country)
		graph box  anc1first anc1second anc1third ancfusecond ancfuthird, over(country)
		
*-------------------------------------------------------------------------------
	* REGRESSIONS
	
		