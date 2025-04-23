	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
	
	* REGRESSIONS: CONTENT OF CARE
	* Ethiopia
		u ETtmp.dta, clear
				recode job 3/4=2, g(jobet) // employed vs. homemaker, student, unemployed
			
				logistic maanc i.educ_cat healthlit_corr i.tertile i.jobet ///
					married  i.factype preg_intent i.danger i.riskcat  i.site ///
					if anygap!=1 , vce(robust)	
					
	* Kenya
		u KEtmp.dta, clear
				recode job 3/4=3, g(jobke) // 1. employed, 2. homemaker 3. student or unemployed 
				recode educ_cat 2=1 3=2 4=3 // 1. No educ, primary 2. complete secondary 3. higher educ
				
				logistic maanc i.educ_cat healthlit_corr i.tertile i.jobke ///
					married  i.factype preg_intent i.danger i.riskcat  i.study_site ///
					if anygap!=1, vce(robust)	
					
	* India
		u INtmp.dta, clear
				*recode job 3/4=3, g(jobin) // 1. employed, 2. homemaker 3. student or unemployed 
				recode urban 0=2, g(site) // 1. urban 2. rural
				*recode study_site 1=2 3=1, g(state) // 1. Jodhpur 2. Sonipat
				recode educ_cat 2=1 3=2 4=3 // 1. No educ, primary 2. complete secondary 3. higher educ
				
				reg anctotal i.educ_cat healthlit_corr i.tertile  ///
					  i.factype preg_intent i.danger i.riskcat  i.urban ///
					if anygap!=1, vce(robust)
					
	* South Africa
		u ZAtmp.dta, clear
				recode job 2=1 3=2 4=3, g(jobza) // 1. employed or homemaker 2. student, 3.unemployed 
				
				reg anctotal i.educ_cat healthlit_corr i.tertile i.jobza ///
					marriedp  preg_intent i.danger i.riskcat  i.study_site ///
					if anygap!=1, vce(robust)
		
/*-------------------------------------------------------------------------------
	* REGRESSIONS: CONTENT OF CARE
	
	use "allcountries.dta", clear
	
	putexcel set "forestplots.xlsx", sheet("content") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="ET" 
		reg anctotal i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.danger i.riskcat  i.site 
				if country==1 & totalfu>3, vce(robust)
				margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B2="onerisk"
					putexcel C2=(_b[RR])
					putexcel D2=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E2=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A3="ET" 		
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.riskcat, post coeflegend
				nlcom (RR:  ( _b[2.riskcat] / _b[0bn.riskcat])), post
					putexcel B3="tworisks"
					putexcel C3=(_b[RR])
					putexcel D3=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E3=(_b[RR]+invnormal(1-.05/2)*_se[RR])
			
	* KEN
		putexcel A4="KE"
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B4="onerisk"
					putexcel C4=(_b[RR])
					putexcel D4=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E4=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A5="KE"			
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[2.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B5="tworisks"
					putexcel C5=(_b[RR])
					putexcel D5=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E5=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	* IND
		putexcel A6="IN"
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B6="onerisk"
					putexcel C6=(_b[RR])
					putexcel D6=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E6=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A7="IN"		
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[2.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B7="tworisks"
					putexcel C7=(_b[RR])
					putexcel D7=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E7=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	*ZAF
	putexcel A8="ZA"
	reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B8="onerisk"
					putexcel C8=(_b[RR])
					putexcel D8=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E8=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
	putexcel A9="ZA"
	reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[2.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B9="tworisks"
					putexcel C9=(_b[RR])
					putexcel D9=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E9=((_b[RR])+invnormal(1-.05/2)*_se[RR])

*-------------------------------------------------------------------------------
* FOREST PLOTS 
gen rr = ln(coeff)
gen lnlcl= ln(lcl)
gen lnucl = ln(ucl)	


metan rr lnlcl lnucl if outcome=="totvisits", by(country) nosubgroup eform ///
		nooveral nobox label(namevar=indic) graphregion(color(white)) effect(RR) ///
		xlabel(0.7, 1.1, 1.5 ) xtick (0.7, 1.1, 1.5) 

metan rr lnlcl lnucl if outcome=="anctotal", by(country) nosubgroup eform ///
		nooveral nobox label(namevar=indic) graphregion(color(white)) effect(RR) ///
		xlabel(0.7, 1.1, 1.5 ) xtick (0.7, 1.1, 1.5) 










/*-------------------------------------------------------------------------------
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
