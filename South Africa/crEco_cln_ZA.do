* South Africa MNH ECohort Baseline Data Cleaning File 
* Created by S. Sabwa
* Updated: Aug 17 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

import delimited using "$ke_data/KEMRI_Module_1_ANC_2023_WIDE-KENBO-LT1318-L.csv", clear

keep if is_the_respondent_eligible == 1

gen country = "Kenya"

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line )
		* STEP TW0: ADD VALUE LABELS (starts at: line )
		* STEP THREE: RECODING MISSING VALUES (starts at: line )
		* STEP FOUR: LABELING VARIABLES (starts at: line )
		* STEP FIVE: ORDER VARIABLES (starts at: line )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:
