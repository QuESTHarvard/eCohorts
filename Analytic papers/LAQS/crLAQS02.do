	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
*-------------------------------------------------------------------------------
	* Appending the four country datasets
*-------------------------------------------------------------------------------
global keepvars site bsltrim totvisref firstblood secblood thirdblood ///
		firsturine securine thirdurine firstbp secbp thirdbp ///
		laqstimelyultra anyus agecat enrollage healthlit_corr ///
		tertile married preg_intent educ_cat riskcat m1danger chronic malnut ///
		complic anemia second  preg_intent primipara dcomplic poorh ///
		ancqualperweek weeksinanc complic2 ext hospital_del ancmean* ///
		bp1 bp2 bp3 wgt1 wgt2 wgt3 urine1 urine2 urine3 blood1 blood2 blood3 ///
		laqstimelyultra anybplan anydanger anc1_bmi anc1_muac anc1_anxi ///
		anc1_lmp anc1_nutri anc1_exer anc1_edd anyifa anycalcium deworm ancall
		
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
	rename  study_site site
	keep $keepvars quintile factype urban
		gen country=3
		rename site study_site 
		recode study_site 1/2=4 3=5, g(site) // 4 Haryana 5 Rajasthan
		append using allcountries.dta
		save allcountries.dta, replace
	
	u ZAtmp.dta, clear
	rename study_site_sd site 
	keep $keepvars 
		gen country=4 
		recode site 1=7 2=6
		lab drop study_site_sd
		append using allcountries.dta
	
		lab def site 0"East Shewa, ETH" 1"Adama, ETH" 2"Kitui, KEN" 3"Kiambu, KEN" ///
		4"Haryana, IND" 5"Rajasthan, IND" 6 "Nongoma, ZAF" 7 "Umhlathuze, ZAF", modify
		lab val site site
		
		recode study_site 2=1 3=2 , g(state)
		lab def state 1 Haryana 2 Rajasthan
		lab val state state 
		
		lab def country 1 "Ethiopia" 2 "Kenya" 3 "India" 4 "South Africa"
		lab val country country
	
	save allcountries.dta, replace
