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
* user

clear all
set more off

* Dropping any existing macros
macro drop _all

* Setting user globals 
global user "/Users/shs8688"
*global user "/Users/catherine.arsenault"
*global user "/Users/katedwright"

* Setting file path globals
	*ETHIOPIA:
	global et_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/01 raw data"
	*global data "$user/Dropbox/SPH Kruk QuEST Network/Core Research/People's Voice Survey/PVS External/Data"
	
	*KENYA:
	global ke_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/01 raw data"
	
	*SOUTH AFRICA:
	
	
	*INDIA:
	global in_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/India/01 raw data"
	
* Path to multi-country data folder (includes input and output folders for data checks)
global data_mc "$data/Multi-country"

* Path to data input/output folders 
global in_out "$data_mc/03 input output"

* Path to GitHub folder 
global github "$user/Documents/GitHub/eCohorts"


************************************************

* Clean each dataset separately 
run "$github/crPVS_cln_ET_IN_KE_ZA.do"
run "$github/crPVS_cln_CO_PE_UY.do"
run "$github/crPVS_cln_LA.do"
run "$github/crPVS_cln_IT_MX_US.do"
run "$github/crPVS_cln_KR.do"
run "$github/crPVS_cln_AR.do"
run "$github/crPVS_cln_BR.do"

* Append datasets 
run "$github/crPVS_append.do"

* Adding derived variables for analysis
run "$github/crPVS_der.do"
