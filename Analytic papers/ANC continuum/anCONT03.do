	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
	use "allcountries.dta", clear
*-------------------------------------------------------------------------------
	* REGRESSIONS: VISITS	
	putexcel set "forestplots.xlsx", sheet("visits_wealth") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="Ethiopia" 
		reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B2="Middle"
					putexcel C2=(_b[RR])
					putexcel D2=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E2=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A3="Ethiopia" 		
		reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B3="Richest"
					putexcel C3=(_b[RR])
					putexcel D3=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E3=(_b[RR]+invnormal(1-.05/2)*_se[RR])
			
	* KEN
		putexcel A4="Kenya"
		reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B4="Middle"
					putexcel C4=(_b[RR])
					putexcel D4=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E4=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A5="Kenya"			
		reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B5="Richest"
					putexcel C5=(_b[RR])
					putexcel D5=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E5=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	* IND
		putexcel A6="India"
		reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B6="Middle"
					putexcel C6=(_b[RR])
					putexcel D6=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E6=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A7="India"		
		reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B7="Richest"
					putexcel C7=(_b[RR])
					putexcel D7=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E7=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	*ZAF
	putexcel A8="South Africa"
	reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B8="Middle"
					putexcel C8=(_b[RR])
					putexcel D8=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E8=((_b[RR])+invnormal(1-.05/2)*_se[RR])
	putexcel A9="South Africa"
	reg totvisit i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B9="Richest"
					putexcel C9=(_b[RR])
					putexcel D9=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E9=((_b[RR])+invnormal(1-.05/2)*_se[RR])

*-------------------------------------------------------------------------------
	* REGRESSIONS: CONTENT OF CARE	
	putexcel set "forestplots.xlsx", sheet("content_wealth") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="Ethiopia" 
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B2="Middle"
					putexcel C2=(_b[RR])
					putexcel D2=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E2=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A3="Ethiopia" 		
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B3="Richest"
					putexcel C3=(_b[RR])
					putexcel D3=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E3=(_b[RR]+invnormal(1-.05/2)*_se[RR])
			
	* KEN
		putexcel A4="Kenya"
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B4="Middle"
					putexcel C4=(_b[RR])
					putexcel D4=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E4=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A5="Kenya"			
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B5="Richest"
					putexcel C5=(_b[RR])
					putexcel D5=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E5=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	* IND
		putexcel A6="India"
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B6="Middle"
					putexcel C6=(_b[RR])
					putexcel D6=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E6=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A7="India"		
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B7="Richest"
					putexcel C7=(_b[RR])
					putexcel D7=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E7=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	*ZAF
	putexcel A8="South Africa"
	reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[2.tertile] /  _b[1bn.tertile])) , post
					putexcel B8="Middle"
					putexcel C8=(_b[RR])
					putexcel D8=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E8=((_b[RR])+invnormal(1-.05/2)*_se[RR])
	putexcel A9="South Africa"
	reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.tertile, post coeflegend
				nlcom  (RR:  (_b[3.tertile] /  _b[1bn.tertile])) , post
					putexcel B9="Richest"
					putexcel C9=(_b[RR])
					putexcel D9=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E9=((_b[RR])+invnormal(1-.05/2)*_se[RR])
