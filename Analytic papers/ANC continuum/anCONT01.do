
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
*-------------------------------------------------------------------------------
	* Appending the four country datasets
*-------------------------------------------------------------------------------	
	global keepvars totalfu anctotal totvisits viscat bpthree wgtthree bloodthre ///
		   urinethre bsltrimester all4 anc1_bp anc1_weight anc1_blood anc1_urine site ///
			anc1_bmi anc1_muac anc1_ultrasound anc1_anxi anc1_lmp anc1_nutri anc1_exer ///
			anc1_dangers  anc1_edd anc1_bplan anc1_ifa anc1_calcium ever_refer /// 
			m2_bp_r* m3_bp* m2_wgt_r*  m3_wgt* m2_urine_r* m3_urine* m2_blood_r* m3_blood ///
			m2_us_r*  m3_us* m2_danger_r* m2_bplan_r* m2_ifa_r* m2_calcium_r* totalus ///
			agecat enrollage healthlit_corr tertile married preg_intent educ_cat ///
			anyus anyhosp danger riskcat primipara second job anygap timelyus totvisref ///
			optanc maanc bp1 bp2 bp3 wgt1 wgt2 wgt3 urine1 urine2 urine3 blood1 blood2 blood3 ///
			atleast1* ifa1 ifa2

	u ETtmp.dta, clear
	keep $keepvars quintile factype 
		gen country=1
		recode site 2=0 // 0 ES 1 Adama
		save allcountries.dta, replace
	
	u KEtmp.dta, clear
	rename study_site site
	keep $keepvars quintile factype 
		gen country=2
		recode site 1=3 // 2 Kitui 3 Kiambu
		append using allcountries.dta
		save allcountries.dta, replace
		
	u INtmp.dta, clear 
	rename study_site site
	keep $keepvars quintile factype urban
		gen country=3
		rename site study_site 
		recode urban 0=4 1=5, g(site) // 4 Rural India 5 Urban India
		append using allcountries.dta
		save allcountries.dta, replace
	
	u ZAtmp.dta, clear
	rename study_site_sd site 
	keep $keepvars 
		gen country=4 
		recode site 1=7 2=6
		lab drop study_site_sd
		append using allcountries.dta
	
	lab def site 0"Rural-ETH" 1"Urban-ETH" 2"Rural-KEN" 3"Urban-KEN" ///
	4"Rural-IND" 5"Urban-IND" 6 "Rural-ZAF" 7 "Urban-ZAF", modify
	lab val site site
	
	recode study_site 2=1 3=2 , g(state)
	lab def state 1 Haryana 2 Jodhpur
	lab val state state 
	
	lab def country 1 "Ethiopia" 2 "Kenya" 3 "India" 4 "South Africa"
	lab val country country
	
	save allcountries.dta, replace




