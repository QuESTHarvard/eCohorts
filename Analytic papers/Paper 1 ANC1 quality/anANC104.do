
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------*
* Ethiopia
u "$user/$analysis/ETtmp.dta", clear

	tabstat anc1qual, by(site) stat(mean sd ) //  East Shewa 38.83369 Adama 48.39692
	
	collapse (median) med_anc1qual=anc1qual (max) max_anc1qual=anc1qual (min) min_anc1qual=anc1qual site facility_own facility_lvl (count)  N_anc1qual=anc1qual , by (facility)
		
		lab val facility_lvl facility_lvl
		drop if N_anc1qual<3 // dropping 3 facilities with 1 or 2 women only
		recode site (2=0) //0 East Shewa 1 Adama
		sort site max_anc1qual 
		gen Facility=_n 
		gen yline0 = 38.83369 if site==0
		gen yline1 = 48.39692 if site==1
		
	twoway || rbar max_anc1qual min_anc1qual Facility if site==0 ,  barwidth(.5) bfcolor(none) bcolor(ebblue) ///
			|| scatter med_anc1qual Facility if site==0,  msymbol(X) msize(large) mcolor(black)  ///
			|| line yline0 Facility,  lwidth(vthin) lcolor(ebblue) lpattern(dash) ///
			|| rbar max_anc1qual min_anc1qual Facility if site==1 ,   barwidth(.6) bfcolor(none) bcolor(green) ///
			|| scatter med_anc1qual Facility if site==1 ,  msymbol(X) mcolor(black) msize(large)  ///
			|| line yline1 Facility,  lwidth(vthin) lcolor(green) lpattern(dash) /// 
				ytitle("Antenatal care quality index", size(small)) legend(off) title("Ethiopia", size(medium)) ///
				ylabel(0(20)100, labsize(small) )  xlabel(1(1)18, labsize(small) nogrid) graphregion(color(white)) ///
				text(95 5 "East Shewa", color(ebblue)) text(95 15 "Adama Town", color(green))
				graph export "$user/$analysis/Graphs/ETHfac.pdf", replace
				
	  *graph box anc1qual, over(facility)


*------------------------------------------------------------------------------*	
* Kenya
u "$user/$analysis/KEtmp.dta", clear

	tabstat anc1qual, by(site) stat(mean sd ) // 1 Kiambu  68.14943   2 Kitui   64.84679
	
	collapse (median) med_anc1qual=anc1qual (max) max_anc1qual=anc1qual (min) min_anc1qual=anc1qual site facility_lvl (count)  N_anc1qual=anc1qual , by (facility)
	
		lab val facility_lvl facility_lvl
		recode site (2=0) //0 Kitui 1 Kiambu
		sort site max_anc1qual 
		gen Facility=_n 
		gen yline0 = 64.84679 if site==0
		gen yline1 = 68.14943 if site==1
		
	twoway || rbar max_anc1qual min_anc1qual Facility if site==0 ,  barwidth(.5) bfcolor(none) bcolor(ebblue) ///
			|| scatter med_anc1qual Facility if site==0,  msymbol(X) msize(large) mcolor(black) ///
			|| line yline0 Facility,  lwidth(vthin) lcolor(ebblue) lpattern(dash) ///
			|| rbar max_anc1qual min_anc1qual Facility if site==1 ,   barwidth(.6) bfcolor(none) bcolor(green) ///
			|| scatter med_anc1qual Facility if site==1 ,  msymbol(X) mcolor(black) msize(large)  ///
			|| line yline1 Facility,  lwidth(vthin) lcolor(green) lpattern(dash) /// 
				ytitle("Antenatal care quality index", size(small)) legend(off) title("Kenya", size(medium)) ///
				ylabel(0(20)100, labsize(small) )  xlabel(1(1)21, labsize(small) nogrid) graphregion(color(white)) ///
				text(95 6 "Kitui", color(ebblue)) text(95 17 "Kiambu", color(green))
				graph export "$user/$analysis/Graphs/KEfac.pdf", replace

*------------------------------------------------------------------------------*		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 

	tabstat anc1qual, by(site) stat(mean sd ) // 1 Umhlatuze 77.89773   2 Nongoma  73.24961
	
	collapse (median) med_anc1qual=anc1qual (max) max_anc1qual=anc1qual (min) min_anc1qual=anc1qual site (count)  N_anc1qual=anc1qual , by (facility)
	
		recode site (2=0) //0 Nongoma 1 uMhlathuze 
		sort site max_anc1qual 
		gen Facility=_n 
		gen yline0 = 73.24961 if site==0
		gen yline1 = 77.89773  if site==1
		
	twoway || rbar max_anc1qual min_anc1qual Facility if site==0 ,  barwidth(.5) bfcolor(none) bcolor(ebblue) ///
			|| scatter med_anc1qual Facility if site==0,  msymbol(X) msize(large) mcolor(black) ///
			|| line yline0 Facility,  lwidth(vthin) lcolor(ebblue) lpattern(dash) ///
			|| rbar max_anc1qual min_anc1qual Facility if site==1 ,   barwidth(.6) bfcolor(none) bcolor(green) ///
			|| scatter med_anc1qual Facility if site==1 ,  msymbol(X) mcolor(black) msize(large)  ///
			|| line yline1 Facility,  lwidth(vthin) lcolor(green) lpattern(dash) /// 
				ytitle("Antenatal care quality index", size(small)) legend(off) title("South Africa", size(medium)) ///
				ylabel(0(20)100, labsize(small) )  xlabel(1(1)22, labsize(small) nogrid) graphregion(color(white)) ///
				text(104 6 "Nongoma", color(ebblue)) text(104 17 "uMhlathuze ", color(green))
				graph export "$user/$analysis/Graphs/ZAfac.pdf", replace



