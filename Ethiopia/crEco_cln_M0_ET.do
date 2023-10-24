* Ethiopia ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Oct 24 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

*--------------------DATA FILE:

import delimited using "$et_data/M0_ET_final.csv", clear

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 29)
		* STEP TW0: ADD VALUE LABELS (starts at: line 214)
		* STEP THREE: RECODING MISSING VALUES (starts at: line 903)
		* STEP FOUR: LABELING VARIABLES (starts at: line 1688)
		* STEP FIVE: ORDER VARIABLES (starts at: line 2379)
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
    