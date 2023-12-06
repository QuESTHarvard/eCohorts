


	mixed anc1qual i.site || facility: , vce(robust)
	
	
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
