clear all
set more off
	global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
	global in_data_final "$user/MNH Ecohorts QuEST-shared/Data/India/02 recoded data"
	
* ETHIOPIA
	u "$in_data_final/eco_IN_Complete.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date<.
	
	* Remove women who had a miscarriage (didn't reach 28 weeks gestation)
