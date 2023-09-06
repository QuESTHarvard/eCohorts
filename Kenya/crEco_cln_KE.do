* Kenya MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Sep 5 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

use "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/01 raw data/KEMRI_Module_1_ANC_2023.dta"

* Confirm: are there are any PIDS we should drop?

keep if consent == 1 // 19 ids dropped

gen country = "Kenya"

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
