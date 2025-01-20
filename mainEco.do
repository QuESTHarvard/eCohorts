* Ecohorts main code file 
* Date of last update: Aug 14 2024
* Last updated by: MK Trimner
* Version Number 1.02

/* Purpose of code file: 
	
	This file sets all macros and runs all data cleaning files for the 
	ECohorts data. 
	
	Countries included: Ethiopia, Kenya, South Africa, India
	
*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-07-22		1.01	MK Trimner		Added change log
										Added user global for MKT
*										Adjusted other user globals to include "Core Research/Echohorts" because MKT folder structure is different	
										Changed other input & output globals to remove "Core Research/Echohorts"
										
* 2024-08-14	1.02	MK Trimner		Got a new computer, added new path	
* 2024-08-28	1.03	MK Trimner		Added adopath addition to so we can call the standardized programs	
* 2024-09-12	1.04	MK Trimner		Added path for birth_outcome spreadsheet to be used in DQ checks for M3								
*/

* Setting up files and macros
********************************************************************************
* global 
clear all
set more off

* Dropping any existing macros
macro drop _all

* Setting user globals 
*global user "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network"
*global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network"
*global user "/Users/neenakapoor/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network"


* Because MKT's folder path is different, adjusting the above user globals to include Core Research/Echohorts
*global user "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts"
global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
*global user "/Users/HP/Dropbox (Biostat Global)"
*global user "C:\Users\MaryKayTrimner\Biostat Global Dropbox\Mary Kay Trimner"

* Create a global with the folder for data documents
global data_doc "$user/MNH Ecohorts QuEST-shared/Data/Data documents"
********************************************************************************
* Setting file path globals for raw data
	*ETHIOPIA:
	global et_data "$user/MNH Ecohorts QuEST-shared/Data/Ethiopia/01 raw data"
	
	*KENYA:
	global ke_data "$user/MNH Ecohorts QuEST-shared/Data/Kenya/01 raw data"
	
	*SOUTH AFRICA:
	global za_data "$user/MNH Ecohorts QuEST-shared/Data/South Africa/01 raw data"
	
	*INDIA:
	global in_data "$user/MNH Ecohorts QuEST-shared/Data/India/01 raw data"
	
********************************************************************************	
* Path to recoded data folders:
	*ETHIOPIA:
	global et_data_final "$user/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data"

	*KENYA:
	global ke_data_final "$user/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data"
	
	*SOUTH AFRICA:
	global za_data_final "$user/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data"
	
	*INDIA:
	global in_data_final "$user/MNH Ecohorts QuEST-shared/Data/India/02 recoded data"
	
********************************************************************************

* Path to GitHub folder 
global github "/Users/catherine.arsenault/Documents/GitHub/eCohorts"
*global github "$user/MKT GitHub/eCohorts"

* Path to the birth outcomes
global birth_outcomes "$user/MNH Ecohorts QuEST-shared/Data/Data documents/Cohort flow charts/list of miscarriage_0912.xlsx"

adopath + "$github"

/*
********************************************************************************

* Clean each dataset separately 
run "$github/Ethiopia/crEco_cln_ET.do"
run "$github/South Africa/crEco_cln_ZA.do"
run "$github/Kenya/crEco_cln_KE.do"
run "$github/India/crEco_cln_IN.do"

* Module 0 data cleaning:
run "$github/Ethiopia/crEco_cln_M0_ET.do"
run "$github/South Africa/crEco_cln_M0_ZA.do"
run "$github/Kenya/crEco_cln_M0_KE.do"

************Other data cleaning:

* ETHIOPIA:
	* derived vars
	run "$github/Ethiopia/crEco_der_ET.do"
	
	* Call tracking
	run "$github/Ethiopia/crEco_calltracking_ET.do"
	
	* summtab table creation
	run "$github/Ethiopia/anEco_mtbl_ET.do"

	* policy briefs
	run "$github/Policy briefs/anEco_pb1_ET.do"
	
* South Africa:
	* derived vars
	run "$github/South Africa/crEco_der_ZA.do"
	
	* summtab table creation
	run "$github/South Africa/anEco_mtbl_ZA.do"
	
	* policy briefs
	run "$github/Policy briefs/anEco_pb1_ZA.do"

* KENYA:
	* derived vars
	run "$github/Kenya/crEco_der_KE.do"
	
	* summtab table creation
	run "$github/Kenya/anEco_mtbl_KE.do"

	* policy briefs
	run "$github/Policy briefs/anEco_pb1_ZA.do"
