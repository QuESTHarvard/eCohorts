
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"


* Figure 1
	u "$user/$analysis/ETtmp.dta", clear
		keep site anc1qual timespent facility_lvl chronic anemic maln_underw dangersigns cesa complic
		recode site 2=1 1=2
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/KEtmp.dta", clear
		keep site anc1qual timespent facility_lvl chronic anemic maln_underw dangersigns cesa complic
		recode site 1=4 2=3
		append using "$user/$analysis/4cos.dta"
		save "$user/$analysis/4cos.dta", replace
		
	u "$user/$analysis/ZAtmp.dta", clear 
		keep site anc1qual timespent   chronic anemic maln_underw dangersigns cesa complic
		recode site 1=6 2=5
		append using "$user/$analysis/4cos.dta"
		save "$user/$analysis/4cos.dta", replace
		
		lab def site 1 "East Shewa" 2 "Adama Town" 3"Kitui" 4 "Kiambu"  5 "Nongoma" 6 "uMhlathuze"
		lab val site site
		replace facility=1 if site>=5
		
		
		graph dot (mean) anc1qual, over(chronic) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ///
		ylabel(0 (0.1) 1) marker(1, msymbol(O) msize(large) mc(gs3)) marker(2, msymbol(D) msize(large) mc(gs12)) ///
		subtitle("Women with chronic illnesses") legend(label(1 "No") ///
		label(2 "Yes")) legend(size(small) rows(2)) ///
		saving("$user/$analysis/Graphs/chronic.gph", replace) 
		
		graph dot (mean) anc1qual, over(anemic) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ///
		ylabel(0 (0.1) 1)marker(1, msymbol(O) msize(large) mc(gs3)) marker(2, msymbol(D) msize(large) mc(gs12)) ///
		subtitle("Women with mild to severe anemia (hemoglobin level <11g/dL)") legend(label(1 "No") label(2 "Yes")) ///
		saving("$user/$analysis/Graphs/anemic.gph", replace)
		
		graph dot (mean) anc1qual, over(maln_underw) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ylabel(0 (0.1) 1) ///
		marker(1, msymbol(O) msize(large) mc(gs3)) marker(2, msymbol(D) msize(large) mc(gs12)) ///
		subtitle("Undernourished women") legend(label(1 "No") label(2 "Yes")) ///
		saving("$user/$analysis/Graphs/undernou.gph", replace)
		
		graph dot (mean) anc1qual, over(dangersigns) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ylabel(0 (0.1) 1) ///
		marker(1, msymbol(O) msize(large) mc(gs3)) marker(2, msymbol(D) msize(large) mc(gs12)) ///
		subtitle("Women reporting danger signs") legend(label(1 "No") label(2 "Yes")) ///
		saving("$user/$analysis/Graphs/danger.gph", replace)
		
		graph dot (mean) anc1qual, over(cesa) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ylabel(0 (0.1) 1) ///
		marker(1, msymbol(O) msize(large) mc(gs3)) marker(2, msymbol(D) msize(large) mc(gs12)) ///
		subtitle("Women with previous c-section") legend(label(1 "No") label(2 "Yes")) ///
		saving("$user/$analysis/Graphs/cesa.gph", replace)
		
		graph dot (mean) anc1qual, over(complic) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ylabel(0 (0.1) 1) ///
		marker(1, msymbol(O) msize(large) mc(gs3)) marker(2, msymbol(D) msize(large) mc(gs12)) ///
		subtitle("Women with previous obstetric complications") ///
		legend(label(1 "No") label(2 "Yes")) ///
		saving("$user/$analysis/Graphs/complic.gph", replace)
	
		/*graph dot (mean) anc1qual, over(facility) asyvars over(site, label(labsize(medsmall))) ///
		graphregion(color(white)) ytitle("ANC1 quality index") ysc(range(0 1)) ylabel(0 (0.1) 1) ///
		subtitle("Undernourished women") legend(label(1 "Public primary") label(2 "Public secondary") ///
		label(3 "Private")) saving("$user/$analysis/Graphs/facility_lvl.gph", replace)
	
		
		graph combine "$user/$analysis/Graphs/chronic.gph" "$user/$analysis/Graphs/anemic.gph" ///
		"$user/$analysis/Graphs/undernou.gph" "$user/$analysis/Graphs/danger.gph" "$user/$analysis/Graphs/complic.gph",  ///
		scale(.75) rows(3) xsize(14) ysize(20) graphregion(color(white)) saving("$user/$graphs/anc1qual.gph", replace)

		graph export "$user/$analysis/Graphs/fig1.pdf", replace
		