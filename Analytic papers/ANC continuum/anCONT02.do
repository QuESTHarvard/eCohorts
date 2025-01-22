
	u allcountries.dta, clear
*-------------------------------------------------------------------------------
	* DESCRIPTIVE ANALYSES
*-------------------------------------------------------------------------------	
	* Table 1
*-------------------------------------------------------------------------------	
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
	
* Total number of visits (among women surveyed at least 4 times)
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
			replace totvisi =. if totalfu<4 // surveyed at least 4 times
			
			summtab if country==1, contvars(totvisi anctotal) ///
				catvars(all4 anyus timelyus ever_refer) ///
				mean by(riskcat) excel pval ///
				excelname(Table2) sheetname(ETH) replace 
				
				
