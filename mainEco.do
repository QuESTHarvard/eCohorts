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

* Setting file path globals for raw data
	*ETHIOPIA:
	global et_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/01 raw data"
	*global data "$user/Dropbox/SPH Kruk QuEST Network/Core Research/People's Voice Survey/PVS External/Data"
	
	*KENYA:
	global ke_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/01 raw data"
	
	*SOUTH AFRICA:
	global za_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/01 raw data"
	
	*INDIA:
	global in_data "$user/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/India/01 raw data"
	
* Path to recoded data folders:





global data_mc "$data/Multi-country"

* Path to GitHub folder 
global github "$user/Documents/GitHub/eCohorts"


************************************************

* Clean each dataset separately 
run "$github/crPVS_cln_ET_IN_KE_ZA.do"

*summtab table creation
run 
