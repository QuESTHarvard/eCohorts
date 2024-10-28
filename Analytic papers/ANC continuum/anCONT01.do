
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
*-------------------------------------------------------------------------------
	global keepvars totalfu anctotal totvisits viscat bpthree wgtthree bloodthre ///
		   urinethre bsltrimester all4 anc1_bp anc1_weight anc1_blood anc1_urine site ///
			anc1_bmi anc1_muac anc1_ultrasound anc1_anxi anc1_lmp anc1_nutri anc1_exer ///
			anc1_dangers  anc1_edd anc1_bplan anc1_ifa anc1_calcium /// 13 items
			m2_bp_r* m3_bp* m2_wgt_r*  m3_wgt* m2_urine_r* m3_urine* m2_blood_r* m3_blood ///
			m2_us_r*  m3_us* m2_danger_r* m2_bplan_r* m2_ifa_r* m2_calcium_r* totalus ///
			agecat enrollage healthlit_corr tertile married preg_intent educ_cat ///
			danger riskcat primipara second job anygap timelyus totvisref
			
	* Appending datasets
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
*-------------------------------------------------------------------------------
	* DESCRIPTIVE ANALYSES
	
	* Table 1
		summtab if country==1, contvars( enrollage anctotal totvisi ) ///
				catvars(second healthlit_corr tertile  job married ///
				factype preg_intent primipara bsltrimester danger ) ///
				mean by(riskcat) excel pval ///
				excelname(Table1) sheetname(ETH) replace 
				
		summtab if country==2, contvars( enrollage anctotal totvisi) ///
				catvars(second healthlit_corr tertile  job married ///
				factype preg_intent primipara bsltrimester danger ) pval ///
				mean by(riskcat) excel pval excelname(Table1) sheetname(KE) replace 
		
		summtab if country==3, contvars( enrollage  anctotal totvisi) ///
				catvars( second healthlit_corr tertile  job married ///
				factype preg_intent primipara bsltrimester danger ) pval ///
				mean by(riskcat) excel excelname(Table1) sheetname(IN) replace 
				
		summtab if country==4, contvars(enrollage anctotal totvisi ) ///
				catvars( second healthlit_corr tertile  job married ///
				 preg_intent primipara bsltrimester danger ) pval ///
				mean by(riskcat) excel excelname(Table1) sheetname(ZA) replace 
			
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

	* Total number of items (among women surveyed at least 4 times)
	graph box totvisi if totalfu>3, over(site) ylabel(, labsize(small)) ///
		ytitle("Total number of antenatal care visits") asyvars ///
		box(1, fcolor(navy) lcolor(navy) lwidth(thin)) marker(1, mcolor(navy)) ///
		box(2, fcolor(navy) lcolor(navy) lwidth(thin)) marker(2, mcolor(navy)) ///
		box(3, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(4, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(5, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(6, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(7, fcolor(ebblue) lcolor(ebblue) lwidth(thin)) marker(3, mcolor(ebblue)) ///
		box(8, fcolor(ebblue) lcolor(ebblue)lwidth(thin)) marker(3, mcolor(ebblue)) 

		by country, sort: tabstat anctotal  if totalfu>3, stat(mean med count) col(stat)

	*Figure 3 ultrasounds 
		recode totalus 1/max=1, g(anyus)
		table site riskcat, stat(mean anyus)
		table site riskcat , stat(mean timelyus)
			by site, sort: tab riskcat anyus, chi2
			by site, sort: tab riskcat timelyus, chi2
	
*-------------------------------------------------------------------------------
	* REGRESSIONS: NUMBER OF VISITS
	putexcel set "forestplots.xlsx", sheet("visits") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="ET" 
		reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B2="onerisk"
					putexcel C2=(_b[RR])
					putexcel D2=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E2=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A3="ET" 		
		reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
				margins i.riskcat, post coeflegend
				nlcom (RR:  ( _b[2.riskcat] / _b[0bn.riskcat])), post
					putexcel B3="tworisks"
					putexcel C3=(_b[RR])
					putexcel D3=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E3=(_b[RR]+invnormal(1-.05/2)*_se[RR])
			
	* KEN
		putexcel A4="KE"
		reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B4="onerisk"
					putexcel C4=(_b[RR])
					putexcel D4=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E4=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A5="KE"			
		reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.site if country==2 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[2.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B5="tworisks"
					putexcel C5=(_b[RR])
					putexcel D5=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E5=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	* IND
		putexcel A6="IN"
		reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B6="onerisk"
					putexcel C6=(_b[RR])
					putexcel D6=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E6=((_b[RR])+invnormal(1-.05/2)*_se[RR])
					
		putexcel A7="IN"		
		reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent i.factype i.state if country==3 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[2.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B7="tworisks"
					putexcel C7=(_b[RR])
					putexcel D7=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E7=((_b[RR])+invnormal(1-.05/2)*_se[RR])
				
	*ZAF
	putexcel A8="ZA"
	reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[1.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B8="onerisk"
					putexcel C8=(_b[RR])
					putexcel D8=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E8=((_b[RR])+invnormal(1-.05/2)*_se[RR])
	putexcel A9="ZA"
	reg totvisi i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
			married preg_intent  i.site if country==4 & totalfu>3, vce(robust)
			margins i.riskcat, post coeflegend
				nlcom  (RR:  (_b[2.riskcat] /  _b[0bn.riskcat])) , post
					putexcel B9="tworisks"
					putexcel C9=(_b[RR])
					putexcel D9=((_b[RR]) -invnormal(1-.05/2)*_se[RR])
					putexcel E9=((_b[RR])+invnormal(1-.05/2)*_se[RR])
			
*-------------------------------------------------------------------------------
	* REGRESSIONS: CONTENT OF CARE	
	putexcel set "forestplots.xlsx", sheet("content") modify
	putexcel A1="country" B1= "indic" C1="coeff" D1="LCL" E1="UCL"
	* ET
		putexcel A2="ET" 
		reg anctotal i.riskcat i.educ_cat healthlit_corr i.tertile ib(2).job ///
				married preg_intent i.factype i.site if country==1 & totalfu>3, vce(robust)
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

* Timely ANC
	u timelyanc.dta, clear
		append using timelyancza 
		append using timelyancke 
		append using timelyancin
		
		encode country, gen(co)
		recode co 3=2 2=3
		
		lab def country 1 "Ethiopia" 2 "Kenya" 3 "India" 4 "South Africa"
		lab val co country
		drop if anygap==1
		egen qual1=rowmean(anc1first ancfufirst)
		egen qual2=rowmean(anc1second ancfusecond)
		egen qual3=rowmean(anc1third ancfuthird)
		
		lab var qual1 "ANC completeness 1st trimester" 
		lab var qual2 "ANC completeness 2nd trimester" 
		lab var qual3 "ANC completeness 3rd trimester" 
		
		graph box qual1 qual2 qual3 , over(co) legend(off)
		
		* Among women enrolled in 1st
		graph box qual1 qual2 qual3 if bsltrimester==1, over(country)
	
		* First and follow up visits
		graph box anc1first anc1second anc1third, over(country)
		graph box  anc1first anc1second anc1third ancfusecond ancfuthird, over(country)

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












