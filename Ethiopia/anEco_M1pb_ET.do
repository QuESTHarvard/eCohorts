* Ethiopia ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Updated: July 27 2023


use "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et.dta", clear


drop in 1/72 // drop the test records
keep if  b7eligible ==1 // drop the non eligible.. this is also droping the other modules currently.

drop redcap_repeat_instrument-redcap_data_access_group m2_attempt_date-m2_complete // drops M2 variables

* Baseline highrisk features
