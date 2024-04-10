
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

* Linear regressions: continuous score
*-------------------------------------------------------------------------------	
	* ETHIOPIA
	u "$user/$analysis/ETtmp.dta", clear

	mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent  private facsecond i.sri_cat  i.staff_cat ib(2).site || facility:  , vce(robust)
			estat icc
	
	* Collinearity	
	reg anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent private facsecond i.sri_cat  i.staff_cat i.vol_cat ib(2).site   , vce(robust)
			estat vif
	* Variance analysis
	quiet mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent private facsecond i.sri_cat  i.staff_cat ib(2).site || facility:  , vce(robust)
			
	 mixed anc1qual if e(sample)==1 || facility:  , vce(robust) // variance null model
	 estat icc
	 
	 * Number of risk factors
	 mixed anc1qual i.total_risk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent  private facsecond i.sri_cat  i.staff_cat ib(2).site || facility:  , vce(robust)

*-------------------------------------------------------------------------------	
	* KENYA
	u "$user/$analysis/KEtmp.dta", clear
	
	mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent private facsecond i.sri_cat  i.staff_cat ib(2).site || facility:  , vce(robust) 
			estat icc
	* Collinearity
	reg anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent  private facsecond i.sri_cat i.staff_cat i.vol_cat ib(2).site
			estat vif 
	
	* Variance analysis
	quiet mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent  private facsecond i.sri_cat  i.staff_cat ib(2).site || facility:  , vce(robust) 
	
	mixed anc1qual if e(sample)==1 || facility:  , vce(robust) // variance null model
	 estat icc
	
	 * Number of risk factors
	 mixed anc1qual i.total_risk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile   ///
			primipara preg_intent  private facsecond i.sri_cat  i.staff_cat ib(2).site || facility:  , vce(robust)

*-------------------------------------------------------------------------------	
	* INDIA + vol
	u "$user/$analysis/INtmp.dta", clear
		
	mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent i.facility_lvl i.sri_cat  i.staff_cat i.vol_cat  i.urban || facility: , vce(robust)
			estat icc	
	* Collinearity
	reg anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent i.facility_lvl i.sri_cat  i.staff_cat i.vol_cat  i.urban , vce(robust)
			estat vif 
			
	* Variance analysis
	quiet mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent i.facility_lvl i.sri_cat  i.staff_cat i.vol_cat  i.urban || facility: , vce(robust)
	
	mixed anc1qual if e(sample)==1 || facility:  , vce(robust) // variance null model
	
	* Number of risks
	mixed anc1qual i.total_risk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent i.facility_lvl i.sri_cat  i.staff_cat i.vol_cat  i.urban || facility: , vce(robust)

*-----------------------------------------------------------------------------	
	* ZAF	+ vol	 	
	u "$user/$analysis/ZAtmp.dta", clear
	
	mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent  i.sri_cat  i.staff_cat  i.vol_cat ib(2).site || facility: , vce(robust)
			estat icc
	* Collinearity
	reg anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent   i.sri_cat  i.staff_cat  i.vol_cat ib(2).site  , vce(robust)
	estat vif
	
	* Variance analysis
	quiet mixed anc1qual i.anyrisk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent   i.sri_cat  i.staff_cat  i.vol_cat ib(2).site || facility: , vce(robust)
			
	mixed anc1qual if e(sample)==1 || facility:  , vce(robust) // variance null model

	* Number of risks
	mixed anc1qual i.total_risk m1_dangersigns poorhealth ib(2).age second healthlit_corr i.tertile  ///
			primipara preg_intent  i.sri_cat  i.staff_cat  i.vol_cat ib(2).site || facility: , vce(robust)

*-------------------------------------------------------------------------------	
	/*margins anyrisk, atmeans
	marginsplot, recast(line) plot1opts(lcolor(gs8)) ciopt(color(black%20)) recastci(rarea) title("Quality of 1st ANC visit, Average Marginal Effects of risk profile") xtitle("Risk score") ytitle("Predicted ANC quality") ylabel(40(20)85, labsize(small) ) 

* Logistic regression: top quartile of quality
	u "$user/$analysis/ETtmp.dta", clear

	xtmixed q4_anc1	 i.anyrisk m1_dangersigns poorhealth i.age second ///
			healthlit_corr i.tertile marriedp  i.depression_cat ///
			primipara preg_intent i.time private i.staff_cat ib(2).site || facility: 
	
	u "$user/$analysis/KEtmp.dta", clear
	xtmixed q4_anc1	 i.anyrisk dangersigns poorhealth i.age second ///
			healthlit_corr i.tertile marriedp  i.depression_cat ///
			primipara preg_intent i.time private i.staff_cat ib(2).site || facility: 
	
		
		
/* MULTI COUNTRY REGRESSION 	
	u "$user/$analysis/ETtmp.dta", clear	
	keep site facility anc1qual private sri_score sri_basic sri_diag sri_equip ///
	anc_vol_staff_onc ftdoc month day time  ///
	age_cat educ_cat tertile minority primipara marriedp ///
	chronic anemic maln_underw dangersigns complic cesa 
	recode site 2=1 1=2
	recode facility 13=12 14=13 15=14 16=15 17=16 18=17 19=18 20=19 21=20 22=21 96=22
	lab drop facility
	save "$user/$analysis/4cos.dta", replace
	
	u "$user/$analysis/KEtmp.dta", clear
	keep site facility anc1qual private sri_score sri_basic sri_diag sri_equip anc_vol_staff_onc ftdoc month day time  ///
	age_cat educ_cat tertile minority primipara chronic anemic maln_underw dangersigns complic cesa 
	recode site 1=4 2=3
	replace facility= facility+22
	append using "$user/$analysis/4cos.dta"
	save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/ZAtmp.dta", clear 
	keep site facility anc1qual private sri_score sri_basic sri_diag sri_equip anc_vol_staff_onc ftdoc month day time  ///
	age_cat educ_cat tertile minority primipara chronic anemic maln_underw dangersigns complic cesa 
	recode site 1=6 2=5
	replace facility= facility+43
	append using "$user/$analysis/4cos.dta"
	save "$user/$analysis/4cos.dta", replace
		

	lab def site 1 "East Shewa" 2 "Adama Town" 3"Kitui" 4 "Kiambu"  5 "Nongoma" 6 "uMhlathuze"
	lab val site site
	
	mixed anc1qual ib(2).age_cat ib(3).educ_cat  minority primipara ib(3).tertile ///
	chronic anemic maln_underw dangersigns complic cesa ///
	 sri_score  anc_vol_staff_onc ftdoc month day i.time  ///
	 i.site || facility: , vce(robust)

	 * checking model assumptions
	predict es1
	predict rs1, rstandard
	*Normality of residuals
	qnorm rs1,   graphregion(color(white)) title("Full model")
	hist rs1
	* Linearity assumption
	twoway (scatter rs1 es1), yline(0) title("Full model") graphregion(color(white))
	
	* Variance analysis
	
	* Null model
	mixed anc1qual || facility: if e(sample) ==1, vce(robust)
	
	* With site FEs
	mixed anc1qual i.site || facility: if e(sample) ==1, vce(robust)
	
	* With site FEs + facility covars
	mixed anc1qual i.site sri_score total_staff_onc  ftdoc || facility: if e(sample) ==1, vce(robust)
	
	* With site FEs + facility covars + visit covars
	mixed anc1qual i.site sri_score total_staff_onc  ftdoc month day i.time || facility: if e(sample) ==1, vce(robust)
	
	* With site FEs + facility covars + visit covars + demog
	mixed anc1qual i.site sri_score total_staff_onc  ftdoc month day i.time i.age_cat i.educ_cat  minority primipara  || facility: if e(sample) ==1, vce(robust)

	* With site FEs + facility covars + visit covars + demog + health 
	mixed anc1qual i.site sri_score total_staff_onc  ftdoc month day i.time i.age_cat i.educ_cat  minority ///
	primipara chronic anemic maln_underw dangersigns complic cesa  || facility: if e(sample) ==1, vce(robust)

* COUNTRY-SPECIFIC REGRESSIONS
*------------------------------------------------------------------------------*

* ETHIOPIA	
	mixed anc1qual private sri_score anc_vol_staff_onc ftdoc month day i.time  ///
	i.age_cat i.educ_cat i.quintile minority primipara chronic anemic maln_underw dangersigns complic cesa i.site || facility: , vce(robust)

* KENYA
	u "$user/$analysis/KEtmp.dta", clear
	mixed anc1qual private sri_score anc_vol_staff_onc ftdoc month day i.time ///
	i.age_cat i.educ_cat i.quintile minority primipara chronic anemic maln_underw dangersigns complic cesa i.site || facility: , vce(robust)
	
* KENYA
	u "$user/$analysis/ZAtmp.dta", clear
	mixed anc1qual  sri_score total_staff_onc ftdoc month day i.time ///
	i.age_cat i.educ_cat i.quintile minority primipara chronic anemic maln_underw dangersigns complic cesa i.site || facility: , vce(robust)

	
	
* REGRESSIONS
*------------------------------------------------------------------------------*
	global demog age_cat second quintile minority marriedp primipara preg_intent 
	global health_needs chronic anemic maln_underw dangersigns cesa complic
	global facility private facsecond  sri_score sri_basic sri_equip sri_diag total_staff ftdoc beds 
	global visit month day time
		
* Appending datasets
	u "$user/$analysis/ETtmp.dta", clear
		keep site anc1qual facility tag $demog $health_needs $facility $visit anc_vol_staff_onc
		recode site 2=1 1=2
		recode facility 13=12 14=13 15=14 16=15 17=16 18=17 19=18 20=19 21=20 22=21 96=22
		lab drop facility
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/KEtmp.dta", clear
		keep site anc1qual  facility tag  $demog $health_needs $facility anc_vol_staff_onc
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
		
		mixed anc1qual private facsecond sri_basic sri_equip sri_diag total_staff_onc ///
		i.age_cat second i.quintile primipara chronic anemic maln_underw dangersigns complic cesa  || site: , vce(cluster site)

	* Full model
	qui mixed anc1qual enrollage second i.quintile minority marriedp primipara preg_intent  /// 
					   $health_needs $facility i.site || facility: , vce(robust)
	
	* Null model with no covariates
	mixed anc1qual || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects
	mixed anc1qual i.site || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects + facility covars
	mixed anc1qual $facility i.site || facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects + facility + demog
	mixed anc1qual  $facility i.site enrollage second i.quintile minority marriedp primipara preg_intent  /// 
					|| facility:  if e(sample) ==1, vce(robust)
	
	* Model with site fixed effects + facility + demog + health needs
	mixed anc1qual  private   sri_score beds ftdoc anc_vol_staff_onc ///
					enrollage second i.quintile  marriedp primipara preg_intent  /// 
					chronic anemic maln_underw dangersigns cesa complic i.site  || facility: , vce(robust)
