* Kenya MNH ECohort Data Cleaning File 
* Created by S. Sabwa
* Updated: Sep 5 2023 


*------------------------------------------------------------------------------*

* Import Data 
clear all 

use "$ke_data/KEMRI_Module_1_ANC_2023z-9-6.dta"

* Confirm: are there are any PIDS we should drop?

keep if consent == 1 // 27 ids dropped

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

* what are these vars? no data in subscriberid, simid
drop subscriberid simid username text_audit mean_sound_level min_sound_level max_sound_level sd_sound_level pct_sound_between0_60 pct_sound_above80 pct_conversation


	* STEP ONE: RENAME VARAIBLES
    
	* MODULE 1:

rename a1 interviewer_id
rename today_date date_m1
rename a4 study_site
rename a5 facility
rename b1 permission
rename (b2 b3) (care_self enrollage)
rename consent b7eligible
rename (q101 q102 q103 q104 q105 q106) (first_name family_name respondentid ///
		mobile_phone phone_number flash)




rename duration interview_length
	


