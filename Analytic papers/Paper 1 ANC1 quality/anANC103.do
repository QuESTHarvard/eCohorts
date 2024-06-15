
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------*
* MULTI COUNTRY GRAPHS AND CREATING ANALYTIC DATASET

*ssc install schemepack, replace
*------------------------------------------------------------------------------*	
* APPENDING COUNTRIES FOR GRAPHS

u "$user/$analysis/ETtmp.dta", clear
recode site 2=0 // 0 ES 1 Adama
egen facid=concat(country facility)
drop facility
save "$user/$analysis/allcountrytmp.dta", replace

u "$user/$analysis/KEtmp.dta", clear
recode site 1=3 // 2 Kitui 3 Kiambu
lab drop a4
egen facid=concat(country facility)
drop facility
append using "$user/$analysis/allcountrytmp.dta", force
save "$user/$analysis/allcountrytmp.dta", replace

u "$user/$analysis/INtmp.dta", clear
recode urban 0=4 1=5, g(site) // 4 Rural 5 Urban
egen facid=concat(country facility)
drop facility
append using "$user/$analysis/allcountrytmp.dta", force
save "$user/$analysis/allcountrytmp.dta", replace

u "$user/$analysis/ZAtmp.dta", clear 
recode site 1=7 2=6
lab drop study_site_sd
egen facid=concat(country facility)
drop facility
append using "$user/$analysis/allcountrytmp.dta", force

lab def site 0"Rural-ETH" 1"Urban-ETH" 2"Rural-KEN" 3"Urban-KEN" 4"Rural-IND" 5"Urban-IND" 6 "Rural-ZAF" 7 "Urban-ZAF", modify
lab val site site

encode country, gen(co)
recode co 2=3 3=2
lab def co 1"Ethiopia" 2"Kenya" 3"India" 4"South Africa", replace
lab val co co 
save "$user/$analysis/allcountrytmp.dta", replace

*------------------------------------------------------------------------------*
* FIG 2. ANC1 QUALITY BOXPLOT BY SITE
preserve
	keep anc1qual site

	graph box anc1qual, over(site) ylabel(0(20)100, labsize(small)) ytitle("Antenatal Care Quality Index") asyvars ///
		box(1, fcolor(navy) lcolor(navy) lwidth(thin)) marker(1, mcolor(navy)) ///
		box(2, fcolor(navy) lcolor(navy) lwidth(thin)) marker(2, mcolor(navy)) ///
		box(3, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(4, fcolor(gold) lcolor(gold) lwidth(thin)) marker(3, mcolor(gold)) ///
		box(5, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(6, fcolor(midgreen) lcolor(midgreen) lwidth(thin)) marker(3, mcolor(midgreen)) ///
		box(7, fcolor(ebblue) lcolor(ebblue) lwidth(thin)) marker(3, mcolor(ebblue)) ///
		box(8, fcolor(ebblue) lcolor(ebblue)lwidth(thin)) marker(3, mcolor(ebblue)) 
restore
*------------------------------------------------------------------------------*
/* FIG 3. BAR GRAPH BY CATEGORY AND SITE

foreach v in phys_exam diag hist counsel tx{
	replace `v'=`v'*100
}

graph bar phys_exam diag hist counsel tx, over(co) ylabel(0(20)100, labsize(small)) ///
		ytitle("Completeness of care %") asyvars  scheme(white_tableau)  ///
		 blabel(bar, size(vsmall) position(outside) format(%2.1g)) ///
		 legend(order(1 "Physical examinations" 2 "Diagnostic tests" 3 "History taking and screening" ///
		 4 "Counselling" 5 "Preventive treatments or supplements") rows(2) position(12) size(small) ) 
		 */
		 
tabstat phys_exam diag hist counsel tx, stat (mean)  by(co)
tabstat phys_exam diag hist counsel tx, stat (mean) col(stat)

*------------------------------------------------------------------------------*
* Supp table 2.
by site, sort : tabstat severe_anemia chronic overweight young old multiple complic, stat (mean) col(stat)
by co, sort: tabstat severe_anemia chronic overweight young old multiple complic, stat (mean) col(stat)

*------------------------------------------------------------------------------*
* Creating analytic dataset

keep country site facid anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression anc1danger_screen previous_preg ///
		m1_counsel_nutri m1_counsel_exer m1_counsel_complic m1_counsel_birthplan edd ///
		m1_counsel_comeback anc1ifa calcium deworm tt anc1itn anc1qual enrollage age second ///
		healthlit_corr young tertile marriedp poorhealth depress  m1_dangersigns counsel_comeback ///
		primipara preg_intent trimester m1_anemic_11 anemic chronic maln_underw overweight ///
		complic anyrisk private facsecond  sri_score total_staff anc_mont beds sri_cat ///
		staff_cat vol_cat m1_202a m1_202b m1_202c m1_202d m1_202e m1_202e_2_za m1_718-m1_722 ///
		anc1diabetes m1_specialist_hosp anc1hypertension m1_724d anc1mental_health_drug ///
		m1_708c  m1_204 late_misc stillbirth m1_1005 m1_1010 m1_716c  depress anc1blood ///
		lvl_anemia  m1_815 m1_815_1-m1_815_96  m1_815_other  m1_815_0 anc1food anc1bmi m1_716a ///
		m1_716b m1_1004 m1_1011b m1_1011c m1_1011d m1_1011f m1_815a_1_in m1_815a_2_in ///
		m1_815a_5_in m1_815a_6_in m1_815b_1_in m1_815b_2_in m1_815b_3_in m1_815b_4_in ///
		m1_815b_5_in m1_815b_6_in m1_815c_1_in m1_815c_2_in m1_815c_3_in m1_815c_4_in ///
		m1_815c_5_in m1_815c_6_in m1_815d_1_in m1_815d_2_in m1_815d_3_in m1_815d_4_in ///
		m1_815d_5_in m1_815d_6_in m1_815e_1_in m1_815e_2_in m1_815e_3_in m1_815e_4_in ///
		m1_815e_5_in m1_815e_6_in m1_815f_1_in m1_815f_2_in m1_815f_3_in m1_815f_4_in ///
		m1_815f_5_in m1_815f_6_in m1_815g_1_in m1_815g_2_in m1_815g_3_in m1_815g_4_in ///
		m1_815g_5_in m1_815g_6_in m1_815h_1_in m1_815h_2_in m1_815h_3_in m1_815h_4_in ///
		m1_815a_3_in m1_815a_4_in  m1_815h_5_in m1_815h_6_in
		
		lab var trimester "Trimester of pregnancy at 1st ANC (enrollment in eCohort)"
		lab var edd "Given her estimated due date at ANC1 among those in 2nd/3rd trimester"
		lab var calcium "Given calcium supplements at ANC1 among those in 2nd/3rd trimester"
		lab var tt "Given TT vaccine if not already protected"
		lab var previous_preg "Discussed previous pregnancies at ANC1"
		lab var ultrasound "Received ultrasound at ANC1 among those in 2nd/3rd trimester"
		lab var deworm "Given deworming medication at ANC1 among those in 2nd/3rd trimester"
		lab var private "ANC1 facility is private"
		lab var facsecond "ANC1 facility is secondary (hospital)"
		lab var anc1qual "ANC1 quality score based on 16 to 22 items"
		lab var healthlit_corr "Answers all 6 health literacy questions correctly"
		lab var age_cat "Age category"
			lab def age_cat 1"15-19yrs" 2"20-34 yrs" 3 "35+yrs"
			lab val age_cat age_cat
		lab var young "Aged less than 20"
		lab var chronic "Has a chronic illness"
		lab var complic "Had a prior obstetric complication (cesa SB preterm neodeath PPH)" 
		lab var anyrisk "Has at least one risk factor"
		lab var sri_score "ANC1 facility service readiness score based on basic amenities equipment & diagnostics for ANC"
		lab var total_staff_onc "Total staff at the facility that provide obstetric or newborn care"
		lab var beds "Total beds in the facility"
		lab var sri_cat "Country-specific tertiles of SRI score"
		lab var staff_cat  "Country-specific tertiles of number of obstetric care staff"
		lab var vol_cat "Country-specific tertiles of monthly number of ANC visits"
		lab var m1_counsel_comeback "Counseled to come back for additional ANC visits at ANC1"
		lab var site "Multi Country study site"
		lab var facid "Multi Country Facility ID"
		order country site facid 
save "$user/$analysis/eCOANC1.dta", replace
/*------------------------------------------------------------------------------*
* Ethiopia - BY FACILITY 
u "$user/$analysis/ETtmp.dta", clear
cd "$user/$analysis/Graphs" 
	tabstat anc1qual, by(site) stat(mean sd ) 
	
	egen med_anc1qual =median(anc1qual), by (facility)
	g facnum = facility
	drop if facility ==11 | facility ==20 | facility ==21
	
	graph box anc1qual if site==2, over(facnum, sort(med_anc1qual)) ///
	yline(37.95576) saving(ES, replace) asyvars legend(off) scheme(white_tableau) ///
	ylabel(0(20)100, labsize(small) ) title("East Shewa") ytitle("Antenatal Care Quality Index")
	graph box anc1qual if site==1, over(facnum, sort(med_anc1qual)) scheme(white_tableau) ///
	yline(48.05584) saving(AD, replace) asyvars legend(off) ///
	ylabel(0(20)100, labsize(small) ) title("Adama Town") ytitle("Antenatal Care Quality Index")
	graph combine ES.gph AD.gph
*------------------------------------------------------------------------------*	
* Kenya - BY FACILITY 
u "$user/$analysis/KEtmp.dta", clear
	tabstat anc1qual, by(site) stat(mean sd ) 
	
	egen med_anc1qual =median(anc1qual), by (facility)
	g facnum = facility
	
	graph box anc1qual if site==2, over(facnum, sort(med_anc1qual)) ///
	yline( 64.84679) saving(KIT, replace) asyvars legend(off) scheme(white_tableau) ///
	ylabel(0(20)100, labsize(small) ) title("Kitui") ytitle("Antenatal Care Quality Index")
	graph box anc1qual if site==1, over(facnum, sort(med_anc1qual)) scheme(white_tableau) ///
	yline(68.14943) saving(KIA, replace) asyvars legend(off) ///
	ylabel(0(20)100, labsize(small) ) title("Kiambu") ytitle("Antenatal Care Quality Index")
	graph combine KIT.gph KIA.gph
	
*------------------------------------------------------------------------------*		
* ZAF - FACILITY 
u "$user/$analysis/ZAtmp.dta", clear 

tabstat anc1qual, by(site) stat(mean sd ) 
	
	egen med_anc1qual =median(anc1qual), by (facility)
	g facnum = facility
	
	graph box anc1qual if site==2, over(facnum, sort(med_anc1qual)) ///
	yline( 73.3169) saving(NON, replace) asyvars legend(off) scheme(white_tableau) ///
	ylabel(0(20)100, labsize(small) ) title("Nongoma") ytitle("Antenatal Care Quality Index")
	graph box anc1qual if site==1, over(facnum, sort(med_anc1qual)) scheme(white_tableau) ///
	yline(77.93765 ) saving(UM, replace) asyvars legend(off) ///
	ylabel(0(20)100, labsize(small) ) title("uMhlathuze") ytitle("Antenatal Care Quality Index")
	graph combine NON.gph UM.gph
	
*------------------------------------------------------------------------------*		
* IND - FACILITY 
u "$user/$analysis/INtmp.dta", clear 

tabstat anc1qual, by(state) stat(mean sd ) // Sonipat  66.13274 Jodhpur 72.59736
	
	egen med_anc1qual =median(anc1qual), by (facility)
	g facnum = facility
	
	graph box anc1qual if state==2, over(facnum, sort(med_anc1qual)) ///
	yline( 73.3169) saving(Jod, replace) asyvars legend(off) scheme(white_tableau) ///
	ylabel(0(20)100, labsize(small) ) title("Jod") ytitle("Antenatal Care Quality Index")
	
	graph box anc1qual if state==1, over(facnum, sort(med_anc1qual)) scheme(white_tableau) ///
	yline(77.93765 ) saving(Ha, replace) asyvars legend(off) ///
	ylabel(0(20)100, labsize(small) ) title("Hary") ytitle("Antenatal Care Quality Index")
	graph combine Jod.gph Ha.gph
*------------------------------------------------------------------------------*
* Ethiopia - BY RISK 
u "$user/$analysis/ETtmp.dta", clear
cd "$user/$analysis/Graphs" 
	lab def risk_score 0"No risk factor" 1"1 risk factor" 2"2 risk factors" 3 "3 or more risk factors"
	lab val risk_score risk_score

	graph bar anc1qual if site==2, over(risk_score)  ///
		saving("$user/$analysis/Graphs/ES.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(38.83369) ytitle("Antenatal Care Quality Index") title("East Shewa",size(medium)) scheme(white_tableau)
	graph bar anc1qual if site==1, over(risk_score)  ///
		saving("$user/$analysis/Graphs/AD.gph", replace) asyvars  legend(off)  ylabel(0(20)100, labsize(small) ) ///
		yline(48.39692) ytitle("")  title("Adama Town",size(medium)) scheme(white_tableau)
	graph combine "$user/$analysis/Graphs/ES.gph" "$user/$analysis/Graphs/AD.gph", xsize(5) title("Ethiopia", size(small))

* Kenya - BY RISK
u "$user/$analysis/KEtmp.dta", clear
cd "$user/$analysis/Graphs" 
graph bar anc1qual if site==2, over(risk_score) ///
		saving("$user/$analysis/Graphs/KIT.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(64.84679) ytitle("Antenatal Care Quality Index") title("Kitui",size(medium)) scheme(white_tableau)
graph bar anc1qual if site==1, over(risk_score)  ///
		saving("$user/$analysis/Graphs/KIA.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(68.14943) ytitle("")  title("Kiambu",size(medium)) scheme(white_tableau)
	graph combine "$user/$analysis/Graphs/KIT.gph" "$user/$analysis/Graphs/KIA.gph", xsize(4) ysize(3) title("Kenya", size(small))
		
* ZAF - BY RISK
u "$user/$analysis/ZAtmp.dta", clear 
cd "$user/$analysis/Graphs" 
	graph bar anc1qual if site==2, over(risk_score)  ///
		saving("$user/$analysis/Graphs/NON.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(73.24961) ytitle("Antenatal Care Quality Index") title("Nongoma",size(medium)) scheme(white_tableau)
	graph bar anc1qual if site==1, over(risk_score)  ///
		saving("$user/$analysis/Graphs/UM.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline( 77.89773) ytitle("")  title("uMhlathuze",size(medium)) scheme(white_tableau)
	graph combine "$user/$analysis/Graphs/NON.gph" "$user/$analysis/Graphs/UM.gph", xsize(5) title("South Africa", size(small))


/*------------------------------------------------------------------------------*
* Ethiopia - FACILITY TYPE
u "$user/$analysis/ETtmp.dta", clear

	tabstat anc1qual, by(site) stat(mean sd ) //  East Shewa 38.83369 Adama 48.39692
	egen med_anc1qual =median(anc1qual), by (facility_lvl)
	
	graph box anc1qual if site==2, over(facility_lvl, sort(med_anc1qual))  ///
		saving("$user/$analysis/Graphs/ES.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(38.83369) ytitle("Antenatal Care Quality Index") title("East Shewa",size(medium)) 
	graph box anc1qual if site==1, over(facility_lvl, sort(med_anc1qual))  ///
		saving("$user/$analysis/Graphs/AD.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(48.39692) ytitle("")  title("Adama Town",size(medium)) 
	graph combine "$user/$analysis/Graphs/ES.gph" "$user/$analysis/Graphs/AD.gph", xsize(4) ysize(3) title("Ethiopia", size(small))


*------------------------------------------------------------------------------*	
* Kenya - FACILITY TYPE
u "$user/$analysis/KEtmp.dta", clear

	tabstat anc1qual, by(site) stat(mean sd ) // 1 Kiambu  68.14943   2 Kitui   64.84679
	egen med_anc1qual =median(anc1qual), by (facility_lvl)
	
	graph box anc1qual if site==2, over(facility_lvl, sort(med_anc1qual))  ///
		saving("$user/$analysis/Graphs/KIT.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(64.84679) ytitle("Antenatal Care Quality Index") title("Kitui",size(medium)) 
	graph box anc1qual if site==1, over(facility_lvl, sort(med_anc1qual))  ///
		saving("$user/$analysis/Graphs/KIA.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(68.14943) ytitle("")  title("Kiambu",size(medium)) 
	graph combine "$user/$analysis/Graphs/KIT.gph" "$user/$analysis/Graphs/KIA.gph", xsize(4) ysize(3) title("Kenya", size(small))

*------------------------------------------------------------------------------*		
* ZAF - FACILITY TYPE
u "$user/$analysis/ZAtmp.dta", clear 
gen facility_lvl=1
insobs 4, after(1044)
replace facility_lvl = 2 in 1045
replace facility_lvl = 3 in 1046
replace facility_lvl = 2 in 1047
replace facility_lvl = 3 in 1048
replace site = 1 in 1045
replace site=1 in 1046
replace site = 2 in 1047
replace site = 2 in 1048
lab def facility_lvl 1"Public primary" 2"Public secondar" 3"Private"
lab val facility_lvl facility_lvl

	tabstat anc1qual, by(site) stat(mean sd ) // 1 uMhlathuze  77.89773   2 Nongoma 73.24961
	
	graph box anc1qual if site==2, over(facility_lvl)  ///
		saving("$user/$analysis/Graphs/NON.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(73.24961) ytitle("Antenatal Care Quality Index") title("Nongoma",size(medium)) 
	graph box anc1qual if site==1, over(facility_lvl)  ///
		saving("$user/$analysis/Graphs/UM.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline( 77.89773) ytitle("")  title("uMhlathuze",size(medium)) 
	graph combine "$user/$analysis/Graphs/NON.gph" "$user/$analysis/Graphs/UM.gph", xsize(4) ysize(3) title("South Africa", size(small))


*------------------------------------------------------------------------------*
* Ethiopia - HEALTH LITERACY
u "$user/$analysis/ETtmp.dta", clear
	
	graph box anc1qual if site==2, over(health_lit)  ///
		saving("$user/$analysis/Graphs/ES.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(38.83369) ytitle("Antenatal Care Quality Index") title("East Shewa",size(medium)) 
	graph box anc1qual if site==1, over(health_lit)  ///
		saving("$user/$analysis/Graphs/AD.gph", replace) asyvars   legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(48.39692) ytitle("")  title("Adama Town",size(medium)) 
	graph combine "$user/$analysis/Graphs/ES.gph" "$user/$analysis/Graphs/AD.gph", xsize(5) title("Ethiopia", size(small))

*------------------------------------------------------------------------------*
* Ethiopia - EDUCATION
u "$user/$analysis/ETtmp.dta", clear
	replace m1_503=0 if m1_502==0
	lab def education 0"No education", add
	
	graph box anc1qual if site==2, over(m1_503)  ///
		saving("$user/$analysis/Graphs/ES.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(38.83369) ytitle("Antenatal Care Quality Index") title("East Shewa",size(medium)) 
	graph box anc1qual if site==1, over(m1_503)  ///
		saving("$user/$analysis/Graphs/AD.gph", replace) asyvars   legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(48.39692) ytitle("")  title("Adama Town",size(medium)) 
	graph combine "$user/$analysis/Graphs/ES.gph" "$user/$analysis/Graphs/AD.gph", xsize(5) title("Ethiopia", size(small))
	
*------------------------------------------------------------------------------*	
* Kenya - EDUCATION
u "$user/$analysis/KEtmp.dta", clear
	replace m1_503=0 if m1_502==0
	lab def q503 0"No education", add
	drop if site==1 & m1_503==0
	insobs 1, after(1001)
	replace m1_503=0 in 1002
	replace site = 1 in 1002
		
	graph box anc1qual if site==2, over(health_lit)  ///
		saving("$user/$analysis/Graphs/KIT.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(64.84679) ytitle("Antenatal Care Quality Index") title("Kitui",size(medium)) 
	graph box anc1qual if site==1, over(health_lit)  ///
		saving("$user/$analysis/Graphs/KIA.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(68.14943) ytitle("")  title("Kiambu",size(medium)) 
	graph combine "$user/$analysis/Graphs/KIT.gph" "$user/$analysis/Graphs/KIA.gph", xsize(4) title("Kenya", size(small))

*------------------------------------------------------------------------------*		
* ZAF - EDUCATION
u "$user/$analysis/ZAtmp.dta", clear 
	replace m1_503=0 if m1_502==0
	lab def education 0"No education", add
	insobs 2, after(1044)
	replace m1_503=0 in 1045
	replace m1_503=0 in 1046
	replace site = 1 in 1045
	replace site = 2 in 1046
	
	graph box anc1qual if site==2, over(m1_503)  ///
		saving("$user/$analysis/Graphs/NON.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline(73.24961) ytitle("Antenatal Care Quality Index") title("Nongoma",size(medium)) 
	graph box anc1qual if site==1, over(m1_503)  ///
		saving("$user/$analysis/Graphs/UM.gph", replace) asyvars  legend(off) ylabel(0(20)100, labsize(small) ) ///
		yline( 77.89773) ytitle("")  title("uMhlathuze",size(medium)) 
	graph combine "$user/$analysis/Graphs/NON.gph" "$user/$analysis/Graphs/UM.gph", xsize(4) title("South Africa", size(small))

	box(1, color(green)) box(2, color(green)) box(3, color(green)) box(4, color(green)) ///
	box(5, color(green)) box(6, color(green)) box(7, color(green)) box(8, color(green)) ///
	box(9, color(green)) box(10, color(green)) box(11, color(green)) 


/*------------------------------------------------------------------------------*
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



