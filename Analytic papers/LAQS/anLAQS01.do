cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"

	u allcountries.dta, clear
*-------------------------------------------------------------------------------
*  Table 1 Characteristics
*-------------------------------------------------------------------------------		
		recode chronic 1/max=1, g(bchronic)
		recode complic 1/max=1, g(bcomplic)
		replace dcomplic = . if hospital_del !=1 
		// service-based complication only if delivered in hospital
		
		summtab, contvars(totvisref) ///
				catvars(agecat second healthlit_corr tertile marriedp ///
				factype preg_intent primipara bsltrimester m1danger riskcat ///
				bchronic bcomplic anemia malnut hospital_del dcomplic complic2 ///
				poorh) mean by(country) excel excelname(Table1) replace	
*-------------------------------------------------------------------------------
*  LAQS BOXPLOT
*-------------------------------------------------------------------------------
	set scheme white_viridis				
	graph box ancmean , over(site ) ylabel(, labsize(small)) ///
		ytitle("Completeness of antenatal care (%)") asyvars 
		
	
	lab def prim 1"Public primary" 2 "Public secondary" 3"Private"
	lab val factype prim
	replace factype =1 if country==4 // ZA all primary public
	set scheme white_tableau
	graph box ancmean , over(factype ) ylabel(, labsize(small)) ///
		ytitle("Completeness of antenatal care (%)") asyvars by(country, rows(1)) 
*-------------------------------------------------------------------------------
*  TIMELY DIAGNOSTICS
*-------------------------------------------------------------------------------
	set scheme white_ptol
	
	graph bar (mean) firstblood (mean) secblood (mean) thirdblood, over(country) ///
		blabel(bar, size(vsmall) format(%9.1g)) legend(order(1 "First trimester" ///
		2 "Second trimester" 3 "Third trimester") rows(1) position(6))

	set scheme white_piyg
	
	graph bar (mean) firsturine (mean) securine (mean) thirdurine, over(country) ///
		blabel(bar, size(vsmall) format(%9.1g)) ///
		 legend(order(1 "First trimester" ///
		2 "Second trimester" 3 "Third trimester") rows(1) position(6))

	set scheme white_viridis
	
	graph bar (mean) firstbp (mean) secbp (mean) thirdbp, over(country) ///
		blabel(bar, size(vsmall) format(%9.1g)) ///
		 legend(order(1 "First trimester" ///
		2 "Second trimester" 3 "Third trimester") rows(1) position(6))
*-------------------------------------------------------------------------------
*  LAQS: INDIVIDUAL ITEMS
*-------------------------------------------------------------------------------		
	summtab, contvars(totvisref ancmean) ///
		catvars(ancall bp1 bp2 bp3 wgt1 wgt2 wgt3 urine1 urine2 urine3 ///
		blood1 blood2 blood3 laqstimelyultra anybplan anydanger anc1_bmi anc1_muac ///
		anc1_anxi anc1_lmp anc1_nutri anc1_exer anc1_edd anyifa anycalcium deworm) ///
		mean by(country) excel excelname(Table2) replace		
*-------------------------------------------------------------------------------
*  REGRESSIONS
*-------------------------------------------------------------------------------
u ETtmp.dta, clear
		
	* Table 3
		logistic complic2 i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.site ///
					  if bsltrim<3 , vce(robust)		
					  
	* App
		logistic dcomplic i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.site ///
					  if bsltrim<3 & hospital_del==1 , vce(robust)
					  
	quiet logistic dcomplic ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.site ///
					  if bsltrim<3 & hospital_del==1 , vce(robust)
					  
	margins, at(ancmean=(0.1(0.05)1))
			marginsplot, ytitle("Predicted probability of intrapartum complications") ///
			xtitle("Antenatal care quality score (%)") ///
			title("Ethiopia") scheme(white_tableau)
				
	* Appendix
		logistic poorh i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.site ///
					  if bsltrim<3 , vce(robust)	
	* Figure 4. 			  
		logistic poorh ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.site ///
					  if bsltrim<3  , vce(robust)	
					  
		margins, at(ancmean=(0.1(0.05)1))
			marginsplot, ytitle("Predicted probability of poor postpartum health") ///
			xtitle("Antenatal care quality score (%)") ///
			title("Ethiopia") scheme(white_tableau)
			
u KEtmp.dta, clear
	* Table 3
	recode educ 1=2
		logistic complic2 i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site ///
					  if bsltrim<3 , vce(robust)
	* App
		logistic dcomplic i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site ///
					  if bsltrim<3 & hospital_del==1 , vce(robust)	
					  
		quiet 	logistic dcomplic ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site ///
					  if bsltrim<3 & hospital_del==1 , vce(robust)
					  
		margins, at(ancmean=(0.1(0.05)1))
			marginsplot, ytitle("Predicted probability of intrapartum complications") ///
			xtitle("Antenatal care quality score (%)") ///
			title("Kenya") scheme(white_tableau)
	
	* Appendix
		logistic poorh i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site ///
					  if bsltrim<3  , vce(robust)	
	* Figure 4. 			  
		logistic poorh ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site ///
					  if bsltrim<3  , vce(robust)	
					  
		margins, at(ancmean=(0.1(0.05)1))
			marginsplot, ytitle("Predicted probability of poor postpartum health") ///
			xtitle("Antenatal care quality score (%)") ///
			title("Kenya") scheme(white_tableau)
			
u INtmp.dta, clear
	* Table 3.
	recode educ 1=2
		logistic complic2 i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.state i.urban ///
					  if bsltrim<3 , vce(robust)		  
	* Appendix
		logistic dcomplic i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					  i.preg_intent i.riskcat m1danger i.state i.urban  ///
					  if bsltrim<3  & hospital_del==1, vce(robust)
		
		quiet logistic dcomplic ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					  i.preg_intent i.riskcat m1danger i.state i.urban  ///
					  if bsltrim<3  & hospital_del==1, vce(robust)
					  
		margins, at(ancmean=(.1(0.05)1))
			marginsplot, ytitle("Predicted probability of intrapartum complications") ///
			xtitle("Antenatal care quality score (%)") ///
			title("India") scheme(white_tableau)
					
		logistic poorh i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.state i.urban ///
					  if bsltrim<3  , vce(robust)	
	* Figure 4. 			  
		logistic poorh ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.state i.urban ///
					  if bsltrim<3  , vce(robust)	
					  
		margins, at(ancmean=(.1(0.05)1))
			marginsplot, ytitle("Predicted probability of poor postpartum health") ///
			xtitle("Antenatal care quality score (%)") ///
			title("India") scheme(white_tableau)
			
u ZAtmp.dta, clear
	* Table 3
		logistic complic2 i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site_sd ///
					  if bsltrim<3 , vce(robust)
	* Appendix
		logistic dcomplic i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site_sd ///
					  if bsltrim<3 & hospital_del==1 , vce(robust)	
					  
		quiet logistic dcomplic ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site_sd ///
					  if bsltrim<3 & hospital_del==1 , vce(robust)	
	
		margins, at(ancmean=(.1(.05)1))
			marginsplot, ytitle("Predicted probability of intrapartum complications") ///
			xtitle("Antenatal care quality score (%)") ///
			title("South Africa") 	scheme(white_tableau)
  
	* Appendix
		logistic poorh i.ancmeanter ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site_sd ///
					  if bsltrim<3 , vce(robust)	
	* Figure 4. 			  
		logistic poorh ancmean ib(2).agecat i.educ i.tertile i.healthlit  ///
					   i.preg_intent i.riskcat m1danger i.study_site_sd ///
					  if bsltrim<3  , vce(robust)	
					  
		margins, at(ancmean=(.1(.05)1))
			marginsplot, ytitle("Predicted probability of poor postpartum health") ///
			xtitle("Antenatal care quality score (%)") ///
			title("South Africa") 	scheme(white_tableau)

				
*-------------------------------------------------------------------------------
	* LINE GRAPH QUALITY BY GA
*-------------------------------------------------------------------------------		
cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
u ETtmp.dta, clear
		keep if bsltrim==1
		egen qual0=rowmean(anc1_bp anc1_weight anc1_urine anc1_blood  ///
							anc1_danger  ) 
		forval i=1/8 {
					egen qual`i'=rowmean(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i'  ///
								  m2_danger_r`i')
				}	
		egen qual9=rowmean(m3_bp m3_wgt m3_blood m3_urine)
		
	keep redcap_record_id  bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r9 ranc9)
		
		reshape long m2_ga_r qual ranc, i(redcap_record_id) j(round)
		
		gen rga = round(m2_ga_r, 1.0)
		
		collapse (mean) qual (sum) ranc, by(rga)
		drop if rga>=41
		drop if rga<7

		twoway  (lpolyci qual rga) (scatter qual rga), ///
		 ylabel(0(.2)1) xlabel(7(4)41) xtitle("Gestational age in weeks") ///
		 xline(13,  lpattern(dash) lcolor(mint)) ///
		 xline(28,  lpattern(dash) lcolor(mint)) ///
		ytitle("ANC visit quality") legend(off) scheme(white_piyg) title("Ethiopia", size(small))
		
		
*-------------------------------------------------------------------------------		
u KEtmp.dta, clear
		*keep if bsltrim==1
		egen qual0=rowmean(anc1_bp anc1_weight anc1_urine anc1_blood anc1_danger) 
		forval i=1/8 {
					egen qual`i'=rowmean(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_danger_r`i' )
				}	
		egen qual9=rowmean(m3_bp m3_wgt* m3_blood* m3_urine*  )
		
	keep respondentid bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		drop m2_ga_r9 ranc9
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r9 ranc9)
		
		reshape long m2_ga_r qual ranc, i(respondentid) j(round)
		
		gen rga = round(m2_ga_r, 1.0)
		
		collapse (mean) ranc qual, by(rga)
		drop if rga>=41
		drop if rga<7

		twoway  (lpolyci qual rga) (scatter qual rga), ///
		 ylabel(0(.2)1) xlabel(7(4)41) xtitle("Gestational age in weeks") ///
		  xline(13,  lpattern(dash) lcolor(mint)) ///
		 xline(28,  lpattern(dash) lcolor(mint)) ///
		ytitle("ANC visit quality") legend(off) scheme(white_piyg) title("Kenya", size(small))
*-------------------------------------------------------------------------------
u INtmp.dta, clear
		*keep if bsltrim==1
		egen qual0=rowmean(anc1_bp anc1_weight anc1_urine anc1_blood anc1_danger) // bp weight urine blood complic
		forval i=1/10 {
					egen qual`i'=rowmean(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_danger_r`i' )
				}	
		egen qual11=rowmean(m3_bp m3_wgt m3_blood m3_urine )
		
	keep respondentid bslga m2_ga_r* ga_endpreg qual* ranc* anygap
	
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r11 ranc11)
		
		reshape long m2_ga_r qual ranc, i(respondentid) j(round)
		
		gen rga = round(m2_ga_r, 1.0)
		
		collapse (mean) ranc qual, by(rga)
		drop if rga>=41
		drop if rga<7

		twoway  (lpolyci qual rga) (scatter qual rga), ///
		 ylabel(0(.2)1) xlabel(7(4)41) xtitle("Gestational age in weeks") ///
		  xline(13,  lpattern(dash) lcolor(mint)) ///
		 xline(28,  lpattern(dash) lcolor(mint)) ///
		ytitle("ANC visit quality") legend(off) scheme(white_piyg) title("India", size(small))
*-------------------------------------------------------------------------------		
u ZAtmp.dta, clear
		keep if bsltrim==1
		* Removed the multiplication before running graph (crLAQS01_za line 279)
		egen qual0=rowmean(anc1_bp anc1_weight anc1_urine anc1_blood anc1_danger ) // bp weight urine blood complic
		forval i=1/6 {
					egen qual`i'=rowmean(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_danger_r`i' )
				}	
		egen qual7=rowmean(m3_bp m3_wgt* m3_blood* m3_urine* )
		
	keep respondentid bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r7 ranc7)
		
		reshape long m2_ga_r qual ranc, i(respondentid) j(round)
		
		gen rga = round(m2_ga_r, 1.0)
		
		collapse (mean) ranc qual, by(rga)
		drop if rga>=41
		drop if rga<7

		twoway  (lpolyci qual rga) (scatter qual rga), ///
		 ylabel(0(.2)1) xlabel(7(4)41) xtitle("Gestational age in weeks") ///
		  xline(13,  lpattern(dash) lcolor(mint)) ///
		 xline(28,  lpattern(dash) lcolor(mint)) ///
		ytitle("ANC visit quality") scheme(white_piyg) ///
		legend(off) title("South Africa", size(small))

		
*-------------------------------------------------------------------------------
	* LINE GRAPH VISITS BY GA
*-------------------------------------------------------------------------------		
cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
u ETtmp.dta, clear
		gen ranc0=1 
		egen ranc9=rowtotal(m3_consultation_* m3_consultation_referral_*)
		
		keep redcap_record_id  bslga m2_ga_r* ga_endpreg  ranc* 
		drop ranclast
		rename (bslga ga_endpreg ) (m2_ga_r0 m2_ga_r9 )
		
		reshape long m2_ga_r ranc, i(redcap_record_id) j(round)
		
		gen rga = round(m2_ga_r, 1.0)
		
		collapse  (mean) ranc, by(rga)
		drop if rga>=40
		drop if rga<7

		twoway  (lpolyci ranc rga) (scatter ranc rga), ///
		  xlabel(7(4)40) xtitle("Gestational age in weeks") ///
		 xline(13,  lpattern(dash) lcolor(mint)) ///
		 xline(28,  lpattern(dash) lcolor(mint)) ///
		ytitle("Average number of new ANC visits reported") ///
		legend(off) scheme(white_piyg) title("Ethiopia", size(small))
		
*-------------------------------------------------------------------------------		
u KEtmp.dta, clear
		gen ranc0=1 
		egen ranc11=rowtotal(m3_consultation_* m3_consultation_referral_*)
		
		keep respondentid  bslga m2_ga_r* ga_endpreg  ranc* 
		drop ranclast
		rename (bslga ga_endpreg ) (m2_ga_r0 m2_ga_r11 )
		
		reshape long m2_ga_r ranc, i(respondentid) j(round)
		
		gen rga = round(m2_ga_r, 1.0)
		
		collapse  (mean) ranc, by(rga)
		drop if rga>=41
		drop if rga<7

		twoway  (lpolyci ranc rga) (scatter ranc rga), ///
		  xlabel(7(4)40) xtitle("Gestational age in weeks") ///
		 xline(13,  lpattern(dash) lcolor(mint)) ///
		 xline(28,  lpattern(dash) lcolor(mint)) ///
		ytitle("Average number of new ANC visits reported") ///
		legend(off) scheme(white_piyg) title("Kenya", size(small))

				
	/*set scheme white_viridis	
	graph pie, over(laqstimelyultra) by(, legend(on)) by(country, rows(1)) legend(off) ///
	by(, title("Proportion of women who received an ultrasound before 24 weeks", size(medium))) ///
	plabel(_all percent, format(%9.1g)) 

/*-------------------------------------------------------------------------------
*  BOX PLOTS ANCTOTAL BY OUTCOMES 
*-------------------------------------------------------------------------------
	 set scheme white_tableau
	 graph box anctotal, over(dcomplic)  by(country, rows(1)) ylabel(, labsize(small)) ///
		ytitle("Total number of antenatal care services received") asyvars 

	 graph box anctotal, over(complic2)  by(country, rows(1)) ylabel(, labsize(small)) ///
		ytitle("Total number of antenatal care services received") asyvars 

	 graph box anctotal, over(poorh)  by(country, rows(1)) ylabel(, labsize(small)) ///
		ytitle("Total number of antenatal care services received") asyvars */
			
/*-------------------------------------------------------------------------------
*  Unadjusted predicted probabilities
*-------------------------------------------------------------------------------
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	u ETtmp.dta, clear
		logit dcomplic c.anctotal if hospital_del==1 // INCREASE? 
			margins, at(anctotal=(2(1)36))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("ICU, blood transfusion, extended stay") title("Ethiopia")
		
		logit complic2 c.anctotal   if bsltrim<3
			margins, at(anctotal=(2(1)36))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("Self reported delivery complications:seizures, excessive bleeding, fever") ///
			title("Ethiopia")
	
		logit poorh c.anctotal
			margins, at(anctotal=(2(1)36))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") note("Poor self reported health M3") ///
			title("Ethiopia")
	
	u KEtmp.dta, clear
		logit dcomplic c.anctotal if hospital_del==1
			margins, at(anctotal=(4(1)37))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("ICU, blood transfusion, extended stay") title("Kenya")
		
		logit complic2 c.anctotal
			margins, at(anctotal=(4(1)37))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("Self reported delivery complications:seizures, excessive bleeding, fever") ///
			title("Kenya")
	
		logit poorh c.anctotal
			margins, at(anctotal=(4(1)37))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") note("Poor self reported health M3 ")  title("Kenya")
	
	u INtmp.dta, clear
		logit dcomplic c.anctotal  if hospital_del==1 // INCREASE?
			margins, at(anctotal=(6(1)43))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("ICU, blood transfusion, extended stay") title("India")
		
		logit complic2 c.anctotal // small increase
			margins, at(anctotal=(6(1)43))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("Self reported delivery complications:seizures, excessive bleeding, fever") title("India")
	
		logit poorh c.anctotal
			margins, at(anctotal=(6(1)43))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") note("Poor self reported health M3  ") title("India")

	
	u ZAtmp.dta, clear
		logit dcomplic c.anctotal if hospital_del==1 //
			margins, at(anctotal=(6(1)43))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("ICU, blood transfusion, extended stay") title("South Africa")
		
		logit complic2 c.anctotal // 
			margins, at(anctotal=(6(1)43))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") ///
			note("Self reported delivery complications:seizures, excessive bleeding, fever") //
			title("South Africa")
	
		logit poorh c.anctotal
			margins, at(anctotal=(6(1)43))
			marginsplot, ytitle("Predicted probability of delivery complications") ///
			xtitle("Total ANC services received") note("Poor self reported health M3") ///
			title("South Africa")

			
*-------------------------------------------------------------------------------
*  Regressions (1st and 2nd trimester only)
*-------------------------------------------------------------------------------

cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
u ETtmp.dta, clear
	
	twoway (lowess dcomplic anctotal, bwidth(0.8) msymbol(none) ///
    lcolor(red) lpattern(dash) lwidth(thick)), ///
    ytitle("Smoothed Probability") ///
    xtitle("ANC Total")  ylabel(0(.2).5) ///
    title("LOWESS with High Bandwidth")
	
	logistic dcomplic i.tertqual  ib(2).agecat i.educ  ///
		i.tertile i.healthlit i.marriedp ///
		i.factype i.preg_intent i.riskcat m1danger i.site if bsltrim<3, vce(robust)
		
	logistic complic2 i.tertqual  ib(2).agecat i.educ  ///
		i.tertile i.healthlit i.marriedp ///
		i.factype i.preg_intent i.riskcat m1danger i.site if bsltrim<3, vce(robust)

	logistic poorh i.tertqual  ib(2).agecat i.educ  ///
		i.tertile i.healthlit i.marriedp ///
		i.factype i.preg_intent i.riskcat m1danger i.site if bsltrim<3, vce(robust)
	
		est store clust

	logistic dcomplic i.tertqual  ib(2).agecat i.educ  ///
		i.tertile i.healthlit i.marriedp ///
		i.factype i.preg_intent i.riskcat m1danger i.site if bsltrim<3
		est store noclust

	estimates stats clust noclust

cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
u ETtmp.dta, clear
	f_spline spline=anctotal, knots(10 20 30)
	
	logistic dcomplic spline* anctotal ib(2).agecat i.educ  ///
		i.tertile i.healthlit i.marriedp ///
		i.factype i.preg_intent i.riskcat m1danger i.site if bsltrim<3, vce(cluster facility)
		est store linear
	
	f_able spline*, auto
    margins,  at(anctotal=(2(1)36)) plot
		 
u INtmp.dta, clear
	twoway (lowess anyc anctotal, bwidth(0.8) msymbol(none) ///
        lcolor(red) lpattern(dash) lwidth(thick)), ///
    ytitle("Smoothed Probability") ///
    xtitle("ANC Total") ///
    title("LOWESS with High Bandwidth")
	
	f_spline spline=anctotal, knots(20 30 35)
		
	
	logistic anyc spline* o.anctotal ib(2).agecat i.educ i.tertile i.healthlit ///
					 i.factype  i.preg_intent i.riskcat m1danger  i.urban if bsltrim<3

	f_able spline*, auto
    margins,  at(anctotal=(6(1)43)) plot				 
	
	logistic anyc s1-s5 i.agecat i.educ i.tertile i.healthlit i.marriedp ///
			i.factype i.preg_intent i.riskcat m1danger  i.site if bsltrim<3
	est store spline
	
	estimates stats linear quad tert spline
	
	
u ETtmp.dta, clear		
		logistic anyc anctotal i.agecat i.educ i.tertile i.healthlit i.marriedp ///
					  i.factype i.preg_intent i.riskcat m1danger  i.site if bsltrim<3
					  margins,  at(anctotal=(2(1)36)) plot
		// tested melogit by facility id + checked VIF
		
u KEtmp.dta, clear
		recode educ 1=2
		logistic anyc anctotal ib(2).agecat i.educ i.tertile i.healthlit i.marriedp ///
					i.factype i.preg_intent i.riskcat m1danger i.study_site if bsltrim<3
					 

u INtmp.dta, clear 
	
	logistic anyc anctotal ib(2).agecat i.educ i.tertile i.healthlit ///
					 i.factype  i.preg_intent i.riskcat m1danger  i.urban if bsltrim<3
	
	margins,  at(anctotal=(24 29 33)) plot
		
		
u ZAtmp.dta, clear
		
		logistic anyc anctotal ib(2).agecat i.educ i.tertile i.healthlit ///
				i.preg_intent i.riskcat m1danger  ///
					  i.study_site if bsltrim<3
		
		margins,  at(anctotal=(23 29 36)) plot
		
					  
	
*-------------------------------------------------------------------------------
	* REGRESSIONS: ANC QUAL TERTILES do not edit!
*-------------------------------------------------------------------------------
			
u ETtmp.dta, clear		
		logistic anyc i.tertqual i.agecat i.educ i.tertile i.healthlit i.marriedp ///
					  i.factype i.preg_intent i.riskcat m1danger  i.site if bsltrim<3 , 
					  // tested melogit by facility id + checked VIF
		qui reg anyc i.tertqual i.agecat i.educ i.tertile i.healthlit i.marriedp ///
					  i.factype i.preg_intent i.riskcat m1danger  i.site if bsltrim<3
		estat vif
		
u KEtmp.dta, clear
		recode educ 1=2
		logistic anyc i.tertqual ib(2).agecat i.educ i.tertile i.healthlit i.marriedp ///
					i.factype i.preg_intent i.riskcat m1danger i.study_site if bsltrim<3
		
		qui reg anyc i.tertqual i.agecat i.educ i.tertile i.healthlit i.marriedp ///
					i.factype i.preg_intent i.riskcat m1danger i.study_site if bsltrim<3
		estat vif			 

u INtmp.dta, clear 

	
		logistic anyc i.tertqual ib(2).agecat i.educ i.tertile i.healthlit ///
					 i.factype  i.preg_intent i.riskcat m1danger  i.urban if bsltrim<3
	
		qui reg anyc i.tertqual i.agecat i.educ i.tertile i.healthlit i.marriedp ///
					i.factype i.preg_intent i.riskcat m1danger i.study_site if bsltrim<3
		estat vif	
		
u ZAtmp.dta, clear
		
		logistic anyc i.tertqual ib(2).agecat i.educ i.tertile i.healthlit ///
				i.preg_intent i.riskcat m1danger  ///
					  i.study_site if bsltrim<3
					  
		qui reg anyc i.tertqual i.agecat i.educ i.tertile i.healthlit i.marriedp ///
					i.factype i.preg_intent i.riskcat m1danger i.study_site if bsltrim<3
		estat vif	
		
		
		
*-------------------------------------------------------------------------------
	* REGRESSIONS: ANC total modeled with linear splines
*-------------------------------------------------------------------------------
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
u ETtmp.dta, clear

	tabstat anctotal, s(p25 p50 p75 )
	
	mkspline a1 11  a2 15  a3 20 a4=anctotal , displayknots	
		 logistic anyc a1-a4 ib(2).agecat i.educ i.tertile i.healthlit i.marriedp ///
					  i.factype i.preg_intent i.riskcat m1danger i.site if bsltrim<3
	
		 margins, dydx(*) // risk differences
		 test a1 a2 a3 a4
		
u KEtmp.dta, clear

	tabstat anctotal, s(p25 p50 p75 )
	
	mkspline a1 14  a2 19  a3 23 a4=anctotal , displayknots	
	
	logistic anyc a1-a4 ib(2).agecat i.educ i.tertile i.healthlit i.marriedp ///
					i.factype i.preg_intent i.riskcat m1danger i.study_site if bsltrim<3
	
		 margins, dydx(*) // risk differences
		 test a1 a2 a3 a4
	
u INtmp.dta, clear
	tabstat anctotal, s(p25 p50 p75 )
	f_spline spline=anctotal,knots(18 28 35)
	
	logistic poorh spline* anctotal ib(2).agecat i.educ i.tertile i.healthlit ///
					 i.factype  i.preg_intent i.riskcat m1danger  i.urban if bsltrim<3
	
	f_able spline*, auto
     margins,  at(anctotal=(6(1)43)) plot



/*-------------------------------------------------------------------------------
	* SCATTER CUMULATIVE NUMBER OF SERVICES VS CUMULATIVE NB OF VISITS BY GA
*-------------------------------------------------------------------------------		
cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
u ETtmp.dta, clear
		egen qual0=rowtotal(anc1_bp anc1_weight anc1_urine anc1_blood anc1_ultra ///
							anc1_bplan anc1_danger) 
		forval i=1/8 {
					egen qual`i'=rowtotal(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_us_r`i' ///
								 m2_bplan_r`i'  m2_danger_r`i')
				}	
		egen qual9=rowtotal(m3_bp m3_wgt m3_blood m3_urine m3_us )
		
		keep redcap_record_id  bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r9 ranc9)
		reshape long m2_ga_r qual ranc, i(redcap_record_id) j(round)
	
		sort redcap_record_id round
		bysort redcap (round): gen cum_visit = sum(ranc)
		bysort redcap (round): gen cum_service = sum(qual)
		
		gen rga = round(m2_ga_r, 1.0)
		
		gen service_per_visit = cum_service / cum_visit
		collapse (mean) service_per_visit, by(rga)
		drop if rga>=41
		drop if rga<7
		
		twoway line service_per_visit rga, ///
		xlabel(7(4)41) ylabel(1(1)6) ytitle("Avg. services per visit") ///
		xtitle("Gestational age (weeks)") ///
		title("Ethiopia")

		
*-------------------------------------------------------------------------------
	* SCATTER CUMULATIVE NUMBER OF SERVICES VS CUMULATIVE NB OF VISITS BY GA
*-------------------------------------------------------------------------------		
cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
u KEtmp.dta, clear
		egen qual0=rowtotal(anc1_bp anc1_weight anc1_urine anc1_blood anc1_ultra ///
							anc1_bplan anc1_danger) 
		forval i=1/8 {
					egen qual`i'=rowtotal(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_us_r`i' ///
								 m2_bplan_r`i'  m2_danger_r`i')
				}	
		egen qual9=rowtotal(m3_bp* m3_wgt* m3_blood* m3_urine* m3_us* )
		
		keep respondentid  bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		drop m2_ga_r9 ranc9
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r9 ranc9)
		reshape long m2_ga_r qual ranc, i(respondentid) j(round)
	
		sort respondentid round
		bysort respondentid (round): gen cum_visit = sum(ranc)
		bysort respondentid (round): gen cum_service = sum(qual)
		
		gen rga = round(m2_ga_r, 1.0)
		
		gen service_per_visit = cum_service / cum_visit
		collapse (mean) service_per_visit, by(rga)
		drop if rga>=41
		drop if rga<7
		
		twoway line service_per_visit rga, ///
		ylabel(1(1)6) xlabel(7(4)41) ytitle("Average services per visit") ///
		xtitle("Gestational age (weeks)") ///
		title("Kenya")
		
*-------------------------------------------------------------------------------
	* SCATTER CUMULATIVE NUMBER OF SERVICES VS CUMULATIVE NB OF VISITS BY GA
*-------------------------------------------------------------------------------		
cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
u INtmp.dta, clear
		egen qual0=rowtotal(anc1_bp anc1_weight anc1_urine anc1_blood anc1_ultra ///
							anc1_bplan anc1_danger) 
		forval i=1/10 {
					egen qual`i'=rowtotal(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_us_r`i' ///
								 m2_bplan_r`i'  m2_danger_r`i')
				}	
		egen qual11=rowtotal(m3_bp m3_wgt m3_blood m3_urine m3_us )
		
		keep respondentid  bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r11 ranc11)
		reshape long m2_ga_r qual ranc, i(respondentid) j(round)
	
		sort respondentid round
		bysort respondentid (round): gen cum_visit = sum(ranc)
		bysort respondentid (round): gen cum_service = sum(qual)
		
		gen rga = round(m2_ga_r, 1.0)
		
		gen service_per_visit = cum_service / cum_visit
		collapse (mean) service_per_visit, by(rga)
		drop if rga>=41
		drop if rga<7
		
		twoway line service_per_visit rga, ///
		ylabel(1(1)6) xlabel(7(4)41) ytitle("Average services per visit") ///
		xtitle("Gestational age (weeks)") ///
		title("India")
*-------------------------------------------------------------------------------
	* SCATTER CUMULATIVE NUMBER OF SERVICES VS CUMULATIVE NB OF VISITS BY GA
*-------------------------------------------------------------------------------		
cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
u ZAtmp.dta, clear
		egen qual0=rowtotal(anc1_bp anc1_weight anc1_urine anc1_blood anc1_ultra ///
							anc1_bplan anc1_danger) 
		forval i=1/6 {
					egen qual`i'=rowtotal(m2_bp_r`i' m2_wgt_r`i'  ///
								m2_blood_r`i' m2_urine_r`i' m2_us_r`i' ///
								 m2_bplan_r`i'  m2_danger_r`i')
				}	
		egen qual7=rowtotal(m3_bp m3_wgt m3_blood m3_urine m3_us )
		
		keep respondentid  bslga m2_ga_r* ga_endpreg qual* ranc* anygap
		*drop if anygap==1 // those with gaps > 10 weeks between calls
		gen ranc0=1
		rename (bslga ga_endpreg ranclast) (m2_ga_r0 m2_ga_r7 ranc7)
		reshape long m2_ga_r qual ranc, i(respondentid) j(round)
	
		sort respondentid round
		bysort respondentid (round): gen cum_visit = sum(ranc)
		bysort respondentid (round): gen cum_service = sum(qual)
		
		gen rga = round(m2_ga_r, 1.0)
		
		gen service_per_visit = cum_service / cum_visit
		collapse (mean) service_per_visit, by(rga)
		drop if rga>=41
		drop if rga<7
		
		twoway line service_per_visit rga, ///
		ylabel(1(1)6) xlabel(7(4)41) ytitle("Average services per visit") ///
		xtitle("Gestational age (weeks)") ///
		title("South Africa")
