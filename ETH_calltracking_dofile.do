
* CALL TRACKING ETHIOPHIA MNH E-COHORT
* Created Jul 19, 2023, C.Arsenault

* GLOBALS
global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"

* IMPORT DATA
import delimited "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Interim data/Data/MaternalAndNewbornHe_DATA_LABELS_2023-07-19_1654.csv", clear 

	* DROP THE TEST RECORDS
	drop in 1/71
	
	* KEEP REQUIRED VARS FOR CALL TRACKING
	keep recordid eventname repeatinstrument repeatinstance ///	
	a2dateofinterviewdmyየቃለመጠይቁቀንguy ///
	a7interviewernameየጠያቂዋስምmaqaaafa dgestationalageinweeksbasedonlnm ///
	howmanyweekspregnantdoyouthinkyo interviewercalculatesthegestatio ///
	v415 agestationalageatthiscallbasedon bgestationalagebasedonmaternales ///
	 dateofinterviewdmyየቃለመጠይቁቀንguyya aonwhatdatedidyougivebirthordidt
	
	* RENAME VARIABLES
	rename (a2dateofinterviewdmyየቃለመጠይቁቀንguy-aonwhatdatedidyougivebirthordidt) ///
	(m1_date m1_interviewer m1_GA_LNMP m1_GA_matrecall ///
	m1_trimester m2_date m2_GA_LNMP m2_GA_matrecall m3_date m3_endpreg_date)
	
	* DESTRING VARIABLES
	encode recordid, gen(PID)
	foreach v in m1_date m2_date m3_date m3_endpreg_date {
		encode `v', gen(`v'd)
		drop `v'
	}
	 * REFORMAT TO WIDE FORM (1 ROW PER WOMAN)
	 sort PID eventname
	 by PID, sort: carryforward m1*, replace
	 gsort PID -eventname
	 by PID: carryforward m3*, replace
	 preserve 
		keep if eventname=="Module 2" 
		reshape wide m2*, i(PID) j(repeatinstance)
		save "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Data Collection/tmp.dta", replace
	restore 
	keep if eventname=="Module 1"
	merge 1:1 PID using  "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Data Collection/tmp.dta"
	sort m1_date PID 
	order PID m1_dated m1* m2_dated1 m2_*1 m2_dated2 m2_*2 m3_date m3* 
	drop recordid eventname repeatinstrument _merge
	dropmiss _all, force
	
	* CALL STATISTICS
	egen nb_m2_1 = rownonmiss(m2_dated1)
	egen nb_m2_2 = rownonmiss (m2_dated2)
	egen nb_m3 = rownonmiss(m3_dated)
	egen nb_fu_calls = rowtotal (nb_m2_1 nb_m2_2 nb_m3)
	
	
	 * EXPORT TO CALL TRACKING SHEET
	 export excel using "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Data Collection/DataCollectionTracker.xlsx", sheet("Individual tracking", replace) firstrow(var)
	 
	 