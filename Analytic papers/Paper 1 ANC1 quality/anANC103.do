
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

* COUNTRY-SPECIFIC REGRESSIONS
*------------------------------------------------------------------------------*
	global demog enrollage second quintile minority marriedp primipara preg_intent firsttrim
	global health_needs chronic anemic maln_underw dangersigns cesa complic
	global facility private facsecond sri_basic sri_equip sri_diag total_staff ftdoc beds 
	
* ETHIOPIA
	u "$user/$analysis/ETtmp.dta", clear
		keep site anc1qual facility tag $demog $health_needs $facility anc_vol_staff_onc
		
		

* REGRESSIONS
*------------------------------------------------------------------------------*
	global demog enrollage second quintile minority marriedp primipara preg_intent firsttrim
	global health_needs chronic anemic maln_underw dangersigns cesa complic
	global facility private facsecond sri_basic sri_equip sri_diag total_staff ftdoc beds 
	
* Appending datasets
	u "$user/$analysis/ETtmp.dta", clear
		keep site anc1qual facility tag $demog $health_needs $facility anc_vol_staff_onc
		recode site 2=1 1=2
		recode facility 13=12 14=13 15=14 16=15 17=16 18=17 19=18 20=19 21=20 22=21 96=22
		lab drop facility
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/KEtmp.dta", clear
		keep site anc1qual  facility tag  $demog $health_needs $facility  anc_vol_staff_onc
		recode site 1=4 2=3
		replace facility= facility+22
		append using "$user/$analysis/4cos.dta"
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/ZAtmp.dta", clear 
		keep site anc1qual facility tag $demog $health_needs $facility
		recode site 1=6 2=5
		replace facility= facility+43
		append using "$user/$analysis/4cos.dta"
		save "$user/$analysis/4cos.dta", replace
		

		lab def site 1 "East Shewa" 2 "Adama Town" 3"Kitui" 4 "Kiambu"  5 "Nongoma" 6 "uMhlathuze"
		lab val site site
		

	* Full model
	qui mixed anc1qual enrollage second i.quintile minority marriedp primipara preg_intent firsttrim /// 
					   $health_needs $facility i.site || facility: , vce(robust)
	
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
