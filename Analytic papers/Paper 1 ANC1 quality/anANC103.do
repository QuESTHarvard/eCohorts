
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"
	
	global demog enrollage second quintile minority marriedp primipara preg_intent trimester
	global health_needs chronic anemic maln_underw dangersigns cesa complic

* Appending datasets
	u "$user/$analysis/ETtmp.dta", clear
		keep site anc1qual facility facility_lvl $demog $health_needs
		recode site 2=1 1=2
		recode facility 96=23
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/KEtmp.dta", clear
		keep site anc1qual  facility facility_lvl $demog $health_needs
		recode site 1=4 2=3
		replace facility= facility+22
		append using "$user/$analysis/4cos.dta"
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/ZAtmp.dta", clear 
		keep site anc1qual anc1qual  facility $demog $health_needs
		gen facility_lvl=1
		recode site 1=6 2=5
		replace facility= facility+43
		append using "$user/$analysis/4cos.dta"
		save "$user/$analysis/4cos.dta", replace
		
		lab def site 1 "East Shewa" 2 "Adama Town" 3"Kitui" 4 "Kiambu"  5 "Nongoma" 6 "uMhlathuze"
		lab val site site
		
	
	
	* Full model
	qui mixed anc1qual $demog $health_needs $visit $facility i.site || facility: , vce(robust)
	
	* Null model with no covariates
	mixed anc1qual || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects
	mixed anc1qual i.site || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects + facility covars
	mixed anc1qual $facility i.site || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects + facility + visit covars
	mixed anc1qual $visit $facility i.site || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects + facility + visit covars + demographics
	mixed anc1qual $demog $health_needs $visit $facility i.site || facility:  if e(sample) ==1, vce(robust)
