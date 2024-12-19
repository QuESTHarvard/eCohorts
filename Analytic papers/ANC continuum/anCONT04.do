	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
	use "allcountries.dta", clear
*-------------------------------------------------------------------------------
	* REGRESSIONS: VISITS	
	putexcel set "forestplots.xlsx", sheet("visits_educ") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="Ethiopia" 
		reg totvisit i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B2="Completed secondary school"
					putexcel C2=(_b[RR])
					putexcel D2=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E2=((_b[RR])+invnormal(1-.05/2)*_se[RR])				
			
	* KEN
		putexcel A4="Kenya"
		reg totvisit i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B4="Completed secondary school"
					putexcel C4=(_b[RR])
					putexcel D4=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E4=((_b[RR])+invnormal(1-.05/2)*_se[RR])
			
	* IND
		putexcel A6="India"
		reg totvisit i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
		margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B6="Completed secondary school"
					putexcel C6=(_b[RR])
					putexcel D6=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E6=((_b[RR])+invnormal(1-.05/2)*_se[RR])
			
	*ZAF
	putexcel A8="South Africa"
	reg totvisit i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B8="Completed secondary school"
					putexcel C8=(_b[RR])
					putexcel D8=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E8=((_b[RR])+invnormal(1-.05/2)*_se[RR])
	

*-------------------------------------------------------------------------------
	* REGRESSIONS: CONTENT OF CARE	
	putexcel set "forestplots.xlsx", sheet("content_educ") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="Ethiopia" 
		reg anctotal i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B2="Completed secondary school"
					putexcel C2=(_b[RR])
					putexcel D2=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E2=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
	* KEN
		putexcel A4="Kenya"
		reg anctotal i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B4="Completed secondary school"
					putexcel C4=(_b[RR])
					putexcel D4=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E4=((_b[RR])+invnormal(1-.05/2)*_se[RR])

	* IND
		putexcel A6="India"
		reg anctotal i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B6="Completed secondary school"
					putexcel C6=(_b[RR])
					putexcel D6=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E6=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	*ZAF
	putexcel A8="South Africa"
	reg anctotal i.riskcat i.second healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.second, post coeflegend
				nlcom  (RR:  (_b[1.second] /  _b[0bn.second])) , post
					putexcel B8="Completed secondary school"
					putexcel C8=(_b[RR])
					putexcel D8=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E8=((_b[RR])+invnormal(1-.05/2)*_se[RR])
