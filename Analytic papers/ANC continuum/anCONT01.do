
	cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
	
	u ETtmp.dta, clear
	keep anctotal manctotal totvisits bpthree wgtthree bloodthre urinethre totalus all4 anc1_bp anc1_weight anc1_blood anc1_urine
		gen country="Ethiopia"
		save allcountries.dta, replace
	
	u KEtmp.dta, clear
	keep anctotal manctotal totvisits bpthree wgtthree bloodthre urinethre totalus all4 anc1_bp anc1_weight anc1_blood anc1_urine
		gen country="Kenya"
		append using allcountries.dta
		save allcountries.dta, replace
	
	u ZAtmp.dta, clear
	keep anctotal manctotal totvisits bpthree wgtthree bloodthre urinethre totalus all4 anc1_bp anc1_weight anc1_blood anc1_urine
		gen country="South Africa"
		append using allcountries.dta
		save allcountries.dta, replace
	
	* Number of visits
	graph box totvisits, over(country) ytitle("Total number of visits")
	by country, sort: tabstat totvisit, stat(min max med mean)
	
	* Minimum set of items
	by country, sort: tabstat bpthree wgtthree bloodthre urinethre  all4, stat(mean count) col(stat)
	
	* Quality first visit
	by country, sort: tabstat anc1_bp anc1_weight anc1_blood anc1_urine, stat(mean count) col(stat)
