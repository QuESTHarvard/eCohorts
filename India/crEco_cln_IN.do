* India MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Last Updated: Jan 22 2024 
*------------------------------------------------------------------------------*

* Import Data 
clear all 

use "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/India/01 raw data/Module_1_Baseline_Data.dta"

*------------------------------------------------------------------------------*

* Create sample

* keeping eligible participants:
keep if B7 == 1
gen country = "India"

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 28)
		* STEP TW0: ADD VALUE LABELS (starts at: line 158)
		* STEP THREE: RECODING MISSING VALUES (starts at: line 496)
		* STEP FOUR: LABELING VARIABLES (starts at: line 954)
		* STEP FIVE: ORDER VARIABLES (starts at: line )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
