* Ecohorts main code file 
* Date of last update: July 2023
* Last updated by: S Sabwa

/* Purpose of code file: 
	
	This file sets all macros and runs all data cleaning files for the 
	ECohorts data. 
	
	Countries included: Ethiopia, Kenya, South Africa
	
*/

* Setting up files and macros
********************************************************************************
* global 
clear all
set more off

* Dropping any existing macros
macro drop _all

* Setting user globals 
global user "/Users/shs8688"
*global user "/Users/catherine.arsenault"
*global user "/Users/katedwright"

********************************************************************************
* Setting file path globals for raw data
	*ETHIOPIA:
	global et_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/01 raw data"
	
	*KENYA:
	global ke_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/01 raw data"
	
	*SOUTH AFRICA:
	global za_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/01 raw data"
	
	*INDIA:
	global in_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/India/01 raw data"
	
********************************************************************************	
* Path to recoded data folders:
	*ETHIOPIA:
	global et_data_final "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data"
	
	*KENYA:
	global ke_data_final "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data"
	
	*SOUTH AFRICA:
	global za_data_final "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data"
	
	*INDIA:
	global in_data_final "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/India/02 recoded data"
	
********************************************************************************

* Path to GitHub folder 
global github "$user/Documents/GitHub/eCohorts"

********************************************************************************

* Clean each dataset separately 
run "$github/Ethiopia/crEco_cln_ET.do"
run "$github/South Africa/crEco_cln_ZA.do"
run "$github/Kenya/crEco_cln_KE.do"

* ETHIOPIA:
	* derived vars
	run "$github/Ethiopia/crEco_der_ET.do"
	
	* Call tracking
	run "$github/Ethiopia/crEco_calltracking_ET.do"
	
	* summtab table creation
	run "$github/Ethiopia/anEco_mtbl_ET.do"

	* policy briefs
	run "$github/Ethiopia/anEco_pb1_ET.do"
	
	
 



