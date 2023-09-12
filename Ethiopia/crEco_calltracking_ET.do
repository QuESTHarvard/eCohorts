* CALL TRACKING ETHIOPHIA MNH E-COHORT
* Created Jul 19, 2023, C.Arsenault

* GLOBALS
global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
*global user "/Users/katewright/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts"

* IMPORT DATA
* import delimited "$user/MNH Ecohorts QuEST-shared/Data/Ethiopia/01 raw data/MaternalAndNewbornHe_DATA_LABELS_2023-07-19_1654.csv", clear

import delimited "$user/MNH Ecohorts QuEST-shared/Data/Ethiopia/01 raw data/11Sept2023", clear  

	* DROP THE TEST RECORDS AND KEEP ELIGIBLE RECORDS 
	drop in 1/119
	encode b7istherespondenteligibletoparti, gen(eli)
	
	* KEEP REQUIRED VARS FOR CALL TRACKING
	keep recordid  eventname repeatinstrument repeatinstance eli ///
	a2dateofinterviewdmy /// m1_date
	a7interviewername dgestationalageinweeksbasedonlnm ///
	howmanyweekspregnantdoyouthinkyo interviewercalculatesthegestatio ///
	v424 agestationalageatthiscallbasedon ///
	bgestationalagebasedonmaternales ///
	dateofinterviewdmyየቃለመጠይቁቀንguyya aonwhatdatedidyougivebirthordidt ///
	v873 /// date of m3 part 2
	dateofinterviewመረጃየተሰበሰበትቀንguyya /// date of M4
	v1632 // date of M5
	 
	* RENAME VARIABLES
	rename (a2dateofinterviewdmy-v1632) ///
	(m1_date m1_interviewer m1_GA_LNMP m1_GA_matrecall ///
	m1_trimester m2_date m2_GA_LNMP m2_GA_matrecall m3_date m3_endpreg_date m3_p2_date m4_date m5_date)
	
	* DESTRING VARIABLES
	encode recordid, gen(PID)
	foreach v in m1_date m2_date m3_date m3_endpreg_date m3_p2_date m4_date m5_date {
		encode `v', gen(`v'd)
		drop `v'
	}
	 * REFORMAT TO WIDE FORM (1 ROW PER WOMAN)
	 sort PID eventname
	 by PID, sort: carryforward m1* eli, replace
	 keep if eli==1
	 gsort PID -eventname
	 by PID: carryforward m3* m4* m5*, replace
	 preserve 
		keep if eventname=="Module 2" 
		reshape wide m2*, i(PID) j(repeatinstance)
		save "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Data Collection/tmp.dta", replace
	restore 
	keep if eventname=="Module 1"
	merge 1:1 PID using  "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Data Collection/tmp.dta"
	sort m1_date PID 
	order PID m1_dated m1* m2_dated1 m2_*1 m2_dated2 m2_*2 m3_date m3* m4* m5* 
	drop recordid eventname repeatinstrument _merge
	dropmiss _all, force
	
	* CALL STATISTICS
	egen nb_m2_1 = rownonmiss(m2_dated1)
	egen nb_m2_2 = rownonmiss (m2_dated2)
	egen nb_m2_3 = rownonmiss (m2_dated3)
	egen nb_m2_4 = rownonmiss (m2_dated4)
	egen nb_m2_5 = rownonmiss (m2_dated5)
	egen nb_m2_6 = rownonmiss (m2_dated6)
	egen nb_m3_part1 = rownonmiss(m3_dated)
	egen nb_m4 = rownonmiss(m4_dated)
	egen nb_fu_calls = rowtotal (nb_m2_1 nb_m2_2 nb_m2_3 nb_m2_4 nb_m2_5 nb_m2_6 nb_m3 nb_m4)
	
	
	 * EXPORT TO CALL TRACKING SHEET
	 export excel using "$user/MNH Ecohorts QuEST-shared/Data collection/1 Ethiopia/Data Collection/DataCollectionTracker.xlsx", sheet("Individual tracking 09112023", replace) firstrow(var)
	 
	 