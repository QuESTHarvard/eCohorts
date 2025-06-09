
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	u allcountries.dta, clear

	* DESCRIPTIVE ANALYSES
	
*-------------------------------------------------------------------------------	
	* Table 1
*-------------------------------------------------------------------------------	
		summtab , contvars(enrollage ) ///
				catvars(second healthlit_corr tertile  job married ///
				factype preg_intent primipara bsltrimester danger riskcat ) ///
				mean by(country) excel  excelname(Table1) replace 
				
			
	* Number of visits
		graph box totvisits, over(country) ytitle("Total number of visits")
		
		by country, sort: tabstat totvisit, stat(min max med mean)
		ta viscat country if totalfu>2, col nofreq
*-------------------------------------------------------------------------------
	* FIGURE 1: OPTIMAL ANC AND MINIMALLY ADEQUATE ANC
*-------------------------------------------------------------------------------
		by country, sort: tabstat optanc maanc if anygap!=1 , stat(mean count) col(stat)
		
		replace ifa1=. if bsltrimester==3
		* MAANC
		by country, sort: tabstat bp1 wgt1 blood1 urine1 atleast1ultra ///
				atleast1danger atleast1bplan ifa1 if anygap!=1 , ///
				stat(mean count) col(stat)
				
	foreach v in bp wgt blood urine {
		replace `v'1 = . if bsltrimester==2 | bsltrimester==3
		replace `v'2 = . if bsltrimester==1 | bsltrimester==3
		replace `v'3 = . if bsltrimester==1 | bsltrimester==2
		egen `v'=rowmax(`v'1 `v'2 `v'2)
	}
		replace ifa1 =. if bsltrimester==2 | bsltrimester==3
		replace ifa2 = . if bsltrimester==1 | bsltrimester==3
		
		egen ifa=rowmax(ifa1 ifa2)
	
	by country, sort: tabstat bp wgt blood urine atleast1ultra ///
				atleast1danger atleast1bplan ifa if anygap!=1 , ///
				stat(mean count) col(stat)
		
*-------------------------------------------------------------------------------
	* FIGURE 1: MINIMUM SET OF ITEMS 
*-------------------------------------------------------------------------------
	
	* Minimum set of ANC items (among women with at least 3 surveys)
		by country, sort: tabstat bpthree wgtthree bloodthre urinethre  ///
						all4 if totalfu>2, stat(mean count) col(stat)
	
	* Minmum set of ANC items (among women with at least 3 surveys) and adjusted for multiple visits
		by country, sort: tabstat abpthree awgtthree abloodthre aurinethre  ///
						all4 if totalfu>2, stat(mean count) col(stat)

*-------------------------------------------------------------------------------
* FIGURE 2: TIMELY ANC BY TRIMESTER
	u timelyanc.dta, clear
		append using timelyancza 
		append using timelyancke, force
		append using timelyancin
		
		encode country, gen(co)
		recode co 3=2 2=3
		
		lab def country 1 "Ethiopia" 2 "Kenya" 3 "India" 4 "South Africa"
		lab val co country
		drop if anygap==1 // drops any woman with gaps between follow-ups greater than 13.5 weeks
		egen qual1=rowmean(anc1first ancfufirst)
		egen qual2=rowmean(anc1second ancfusecond)
		egen qual3=rowmean(anc1third ancfuthird)
		
		lab var qual1 "ANC completeness 1st trimester" 
		lab var qual2 "ANC completeness 2nd trimester" 
		lab var qual3 "ANC completeness 3rd trimester" 
		
		graph box qual1 qual2 qual3 , over(co) legend(off) ///
			ytitle("Proportion of recommended interventions received by trimester", size(small))
		
		/* Among women enrolled in 1st
		graph box qual1 qual2 qual3 if bsltrimester==1, over(country)
	
		* First and follow up visits
		graph box anc1first anc1second anc1third, over(country)
		graph box  anc1first anc1second anc1third ancfusecond ancfuthird, over(country) */

*-------------------------------------------------------------------------------
* FIGURE 3: TOTAL VISITS AND TOTAL CONTENT
*-------------------------------------------------------------------------------

	u allcountries.dta, clear
	
/* Total number of visits (among women surveyed at least 4 times)
	graph box totvisi if totalfu>3, over(site) ylabel(, labsize(small)) ///
		ytitle("Total number of antenatal care visits") asyvars ///
		box(1, fcolor(navy) lcolor(navy) lwidth(thin)) marker(1, mcolor(navy)) ///
		box(2, fcolor(navy) lcolor(navy) lwidth(thin)) marker(2, mcolor(navy)) ///
		box(3, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(4, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(5, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(6, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(7, fcolor(ebblue) lcolor(ebblue) lwidth(thin)) marker(3, mcolor(ebblue)) ///
		box(8, fcolor(ebblue) lcolor(ebblue)lwidth(thin)) marker(3, mcolor(ebblue)) */

					
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


		by country, sort: tabstat anctotal  if totalfu>3, stat(mean med count) col(stat)

*-------------------------------------------------------------------------------
* SUPPLEMENTAL FIGURE: TIMELY ULTRASOUNDS
*-------------------------------------------------------------------------------

		table site , stat(mean anyus)
		table site , stat(mean timelyus)
		table country , stat(mean timelyus)
		by site, sort: tab riskcat anyus, chi2
		by site, sort: tab riskcat timelyus, chi2
			
*-------------------------------------------------------------------------------	
	* Table 2: ANC USE, INTENSITY AND QUALITY BY RISK GROUP
*-------------------------------------------------------------------------------	
			
			replace all4=. if totalfu<3 // surveyed at least 3 times
			replace anctotal=. if totalfu<4 // surveyed at least 4 times
			replace totvisref =. if totalfu<4 // surveyed at least 4 times
			
			summtab if country==1, contvars(totvisref anctotal) ///
				catvars(all4 anyus timelyus ever_refer anyhosp) ///
				mean by(riskcat) excel pval ///
				excelname(Table2) sheetname(ETH) replace 
				
			summtab if country==2, contvars(totvisref anctotal) ///
				catvars(all4 anyus timelyus ever_refer anyhosp) ///
				mean by(riskcat) excel pval ///
				excelname(Table2) sheetname(KEN) replace 	
				
			summtab if country==3, contvars(totvisref anctotal) ///
				catvars(all4 anyus timelyus ever_refer anyhosp) ///
				mean by(riskcat) excel pval ///
				excelname(Table2) sheetname(IND) replace 	
				
			summtab if country==4, contvars(totvisref anctotal) ///
				catvars(all4 anyus timelyus ever_refer anyhosp) ///
				mean by(riskcat) excel pval ///
				excelname(Table2) sheetname(ZAF) replace 	
