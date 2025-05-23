* India MNH ECohort Data Cleaning File 
* Created by N. Kapoor
* Updated: Mar 6 2025

*==============================================================================
* MODULE 4:		

use "$in_data/Module_4_18032025.dta", clear

foreach v of varlist * {
	char `v'[Original_IN_Varname] `v'
	char `v'[Module] 4
	capture destring `v', replace
	capture replace `v' = trim(`v')
	
	* Clean up the values we know are defaults
*	capture recode `v' 9999998 = . // These were skipped appropriately
*	capture replace `v' = "" if `v' == "9999998"
*	capture replace `v' = ".d" if inlist(`v'," 1-Jan-98","1-Jan-98", "1/1/1998"," 1/1/1998")
*	capture replace `v' = ".r" if inlist(`v'," 1-Jan-99","1-Jan-99", "1/1/1999"," 1/1/1999")
*	capture replace `v' = ".a" if inlist(`v'," 1-Jan-95","1-Jan-95", "1/1/1995"," 1/1/1995")
}

* NK note: These capture commands were needed for the ZA data, but don't seem to be needed here for IN data 
* Also no third baby responses, but they are "_3"

/*
* There are no _B3 responses, so we will drop all these variables
foreach v of varlist *_B3 *BABY3 *_B3_* {
	assert missing(`v') | inlist(`v',95) 
	drop `v'
}
*/

*capture assert missing(MOD4_HEALTHBABY_210_BABY3_OTHER)
*if _rc == 0 drop MOD4_HEALTHBABY_210_BABY3_OTHER


********************************************************************************
********************************************************************************
* Section 1:

* Rename the variables when possible
rename Consent m4_permission

rename Q101 m4_interviewer

rename id m4_respondentid 
format m4_respondentid %20.0f
generate id_mismatch = (m4_respondentid != Q104)
list m4_respondentid Q104 if id_mismatch
drop id_mismatch Q104 // same as id

************************************************
************************************************
gen country = "India"
order country, before(SubmissionDate)

rename Q102 m4_date
rename duration m4_duration

* NK note: date /time is already numeric 
* drop SubmissionDate start end calc_start_time
* SubmissionDate is different than date/time for some respondents 

/*
* We need to put the date as a numeric value
gen date = subinstr(MOD4_IDENTIFICATION_102,"-","",.) 
local m 1
foreach v in Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec {
	local b `m'
	if `m' < 10 local b 0`b'
	replace date = subinstr(date,"`v'","`b'",.) 
	local ++m
} 
replace date = trim(date)

gen l = strlen(date)
replace date = "0" + date  if l < 6 
gen date_d = substr(date,1,2)
gen date_m = substr(date,3,2)
gen date_y = substr(date,5,2)
destring date_d date_m date_y, replace
replace date_y = 2000 + date_y
gen m4_date = mdy(date_m,date_d,date_y)
format %td m4_date
char m4_date[Original_ZA_Varname] MOD4_IDENTIFICATION_102
char m4_date[Module] 4

order m4_date, after(MOD4_IDENTIFICATION_102)
drop MOD4_IDENTIFICATION_102 date date_* l
*/

************************************************
************************************************

rename Q103 m4_time
rename Q108 m4_hiv_status
rename Q110 m4_c_section
rename Q111 m4_live_babies

rename Q112_1 m4_baby1_name
rename Q112_2 m4_baby2_name
* no baby 3's
foreach var in Q112_3 {
    capture assert missing(`var')
    if _rc == 0 {
        drop `var'
    }
}


rename Q113 m4_maternal_death_reported
rename Q114 m4_date_of_maternal_death
rename Q115 m4_maternal_death_learn
rename Q115_other m4_maternal_death_learn_other

generate m4_weeks_delivery = (m4_date - Q109) / 7
drop Q109
order m4_weeks_delivery, after(m4_maternal_death_learn_other)

********************************************************************************
********************************************************************************
* Section 2:
rename Q201_C1 m4_baby1_status
rename Q201_C2 m4_baby2_status

rename Q202_C1 m4_baby1_health
rename Q202_C2 m4_baby2_health 

************************************************
************************************************

* NK note: I don't think this is needed, alread like this in IN data 

/*
* For these variables we need to create multiple variables
forvalues b = 1/2 {
	local i 1
	foreach val in a b c d e f g rf {
		gen m4_baby`b'_feed_`val' = strpos(MOD4_HEALTHBABY_203_BABY`b',"`i'") > 0 if !missing(MOD4_HEALTHBABY_203_BABY`b')
		char m4_baby`b'_feed_`val'[Module] 4
		char m4_baby`b'_feed_`val'[Original_ZA_Varname]  `MOD4_HEALTHBABY_203_BABY`b'[Original_ZA_Varname]'
		local ++i
	}
	order m4_baby`b'_feed_*, before(MOD4_HEALTHBABY_203_BABY`b')

}

*/

* Drop variables
*drop MOD4_HEALTHBABY_203_BABY1 MOD4_HEALTHBABY_203_BABY2

rename Q203_C1 m4_baby1_feed_a_g
rename Q203_1_C1 m4_baby1_feed_a
rename Q203_2_C1 m4_baby1_feed_b
rename Q203_3_C1 m4_baby1_feed_c
rename Q203_4_C1 m4_baby1_feed_d
rename Q203_5_C1 m4_baby1_feed_e
rename Q203_6_C1 m4_baby1_feed_f
rename Q203_7_C1 m4_baby1_feed_g
rename Q203_99_C1 m4_baby1_feed_rf
rename Q203_C2 m4_baby2_feed_a_g
rename Q203_1_C2 m4_baby2_feed_a
rename Q203_2_C2 m4_baby2_feed_b
rename Q203_3_C2 m4_baby2_feed_c
rename Q203_4_C2 m4_baby2_feed_d
rename Q203_5_C2 m4_baby2_feed_e
rename Q203_6_C2 m4_baby2_feed_f
rename Q203_7_C2 m4_baby2_feed_g
rename Q203_99_C2 m4_baby2_feed_rf

************************************************
************************************************

rename Q204_C1 m4_baby1_breastfeeding 
rename Q204_C2 m4_baby2_breastfeeding // no baby2 separate var in ZA

rename Q205_a_C1 m4_baby1_sleep
rename Q205_a_C2 m4_baby2_sleep 

rename Q205_b_C1 m4_baby1_feed
rename Q205_b_C2 m4_baby2_feed

rename Q205_c_C1 m4_baby1_breath
rename Q205_c_C2 m4_baby2_breath

rename Q205_d_C1 m4_baby1_stool
rename Q205_d_C2 m4_baby2_stool

rename Q205_e_C1 m4_baby1_mood
rename Q205_e_C2 m4_baby2_mood

rename Q205_f_C1 m4_baby1_skin
rename Q205_f_C2 m4_baby2_skin

rename Q205_g_C1 m4_baby1_interactivity
rename Q205_g_C2 m4_baby2_interactivity

rename Q206_a_C1 m4_baby1_diarrhea
rename Q206_a_C2 m4_baby2_diarrhea

rename Q206_b_C1 m4_baby1_fever
rename Q206_b_C2 m4_baby2_fever

rename Q206_c_C1 m4_baby1_lowtemp
rename Q206_c_C2 m4_baby2_lowtemp

rename Q206_d_C1 m4_baby1_illness
rename Q206_d_C2 m4_baby2_illness

rename Q206_e_C1 m4_baby1_troublebreath
rename Q206_e_C2 m4_baby2_troublebreath

rename Q206_f_C1 m4_baby1_chestprob
rename Q206_f_C2 m4_baby2_chestprob

rename Q206_g_C1 m4_baby1_troublefeed
rename Q206_g_C2 m4_baby2_troublefeed

rename Q206_h_C1 m4_baby1_convulsions
rename Q206_h_C2 m4_baby2_convulsions

rename Q206_i_C1 m4_baby1_jaundice
rename Q206_i_C2 m4_baby2_jaundice

rename Q206_j_C1 m4_baby1_yellowpalms
rename Q206_j_C2 m4_baby2_yellowpalms

rename Q207_C1 m4_baby1_otherprob
*rename MOD4_HEALTHBABY_207_B1_OTHER m4_baby1_other

rename Q207_C2 m4_baby2_otherprob
*rename MOD4_HEALTHBABY_207_B2_OTHER m4_baby2_other

rename Q208_Date m4_baby1_death_date
gen m4_baby2_death_date = . // no baby2 death
drop Q208

rename Q209_a m4_baby1_deathage_wks 
rename Q209_b m4_baby1_deathage_dys


* NK note - Q209 all missing

rename Q210 m4_baby1_210
rename Q210_other m4_baby1_210_other

gen m4_baby2_210 = . // no baby2 date 
gen m4_baby2_210_other = . // no baby2 date 

rename Q211 m4_baby1_advice
gen m4_baby2_advice = . // no baby2 death

rename Q212 m4_baby1_death_loc
gen m4_baby2_death_loc = . 
drop Q212_other // missing for all 

order m4_baby2_status m4_baby2_health m4_baby2_feed_a_g m4_baby2_feed_a m4_baby2_feed_b m4_baby2_feed_c m4_baby2_feed_d m4_baby2_feed_e m4_baby2_feed_f m4_baby2_feed_g m4_baby2_feed_rf m4_baby2_breastfeeding m4_baby2_sleep m4_baby2_feed m4_baby2_breath m4_baby2_stool m4_baby2_mood m4_baby2_skin m4_baby2_interactivity m4_baby2_diarrhea m4_baby2_fever m4_baby2_lowtemp m4_baby2_illness m4_baby2_troublebreath m4_baby2_chestprob m4_baby2_troublefeed m4_baby2_convulsions m4_baby2_jaundice m4_baby2_yellowpalms m4_baby2_otherprob, after(m4_baby1_otherprob)
order m4_baby2_210 m4_baby2_210_other, after(m4_baby1_210_other)
order m4_baby2_death_date m4_baby2_advice m4_baby2_death_loc, after(m4_baby1_death_loc)


********************************************************************************
********************************************************************************
* Section 3:

rename Q301 m4_301

rename Q302_a m4_302a
rename Q302_b m4_302b
rename Q303_a m4_303a
rename Q303_b m4_303b
rename Q303_c m4_303c
rename Q303_d m4_303d
rename Q303_e m4_303e
rename Q303_f m4_303f
rename Q303_g m4_303g
rename Q303_h m4_303h
rename Q304 m4_304
rename Q305 m4_305
rename Q306 m4_306
rename Q307 m4_307
rename Q308 m4_308
rename Q309 m4_309
rename Q309_other m4_309_other
rename Q310 m4_310

********************************************************************************
********************************************************************************
* Section 4:

* Create a single variable for this by combining baby1 -3
rename Q401_a_C1 m4_401a // Setting this to be healthcare visits for self or child.
*assert m4_401a == 1 if Q401_a_C2 == 1 // NK note: two contradictions, so added this replace command
replace m4_401a = 1 if Q401_a_C2 == 1

* NK note - ZA didn't have 401_b 
rename Q401_b_C1 m4_401b // NK note: few responses, missing data 
* codebook Q401_b_C2 // all missing 

rename Q402_C1 m4_402
* assert m4_402== Q402_C2 if !missing(Q402_C2)  // NK note: assertation false, so added replace command below 
replace m4_402 = 1 if Q402_C2 == 1

* Drop the variables we dont need from this section
drop Q401_a_C2 Q401_b_C2 Q402_C2


************************************************
************************************************
* Lets rename the MOD4_CARE_PATHWAYS_404_B1 MOD4_CARE_PATHWAYS_404_B2 variables to include the A
*rename MOD4_CARE_PATHWAYS_404_B1 MOD4_CARE_PATHWAYS_404A_B1 
*rename MOD4_CARE_PATHWAYS_404_B2 MOD4_CARE_PATHWAYS_404A_B2

* Rename these variables as well
*rename MOD4_CARE_PATHWAYS_412A__B1 MOD4_CARE_PATHWAYS_412A_B1 
*rename MOD4_CARE_PATHWAYS_412A__B2 MOD4_CARE_PATHWAYS_412A_B2

* NK Note: I don't think all of this is needed for India, see loop below 
* NK note - assertlist doesn't work for me 

/*
* For each different consultation we need to create these variables
local num 1
foreach con in a b c {
	local ucon = upper("`con'")
	
	************************************************

	* Rename the variable
	rename MOD4_CARE_PATHWAYS_403`ucon'_B1 m4_403`con'
	
	* Check to see if the Baby1 & Baby 2 had the same values
	assertlist m4_403`con' == MOD4_CARE_PATHWAYS_403`ucon'_B2 if !missing(MOD4_CARE_PATHWAYS_403`ucon'_B2) & !inlist(MOD4_CARE_PATHWAYS_403`ucon'_B2,95) , list(m4_respondentid  m4_403`con' MOD4_CARE_PATHWAYS_403`ucon'_B2)
	capture assert m4_403`con' == MOD4_CARE_PATHWAYS_403`ucon'_B2 if !missing(MOD4_CARE_PATHWAYS_403`ucon'_B2) & !inlist(MOD4_CARE_PATHWAYS_403`ucon'_B2,95)
	* If they do not, create a new varible just for baby 2. Wipe out if they are the same
	if _rc !=  0 {
		rename MOD4_CARE_PATHWAYS_403`ucon'_B2 m4_baby2_403`con'
		replace m4_baby2_403`con' = . if m4_403`con' == m4_baby2_403`con'
		order m4_baby2_403`con', after(m4_403`con')
	}
	if _rc ==  0  drop MOD4_CARE_PATHWAYS_403`ucon'

	************************************************

	rename MOD4_CARE_PATHWAYS_404`ucon'_B1 m4_404`con'
	
	replace MOD4_CARE_PATHWAYS_404`ucon'_B2 = "" if MOD4_CARE_PATHWAYS_404`ucon'_B2 == "."
	assertlist upper(m4_404`con') == upper(MOD4_CARE_PATHWAYS_404`ucon'_B2) if !missing(MOD4_CARE_PATHWAYS_404`ucon'_B2), list(m4_respondentid m4_404`con' MOD4_CARE_PATHWAYS_404`ucon'_B2)
	capture assert upper(m4_404`con') == upper(MOD4_CARE_PATHWAYS_404`ucon'_B2) 
	if _rc != 0 {
		rename MOD4_CARE_PATHWAYS_404`ucon'_B2 m4_baby2_404`con'
		replace m4_baby2_404`con' = "" if upper(m4_404`con') == upper(m4_baby2_404`con') 
		order m4_baby2_404`con', after(m4_404`con')

	}
	if _rc ==  0 drop MOD4_CARE_PATHWAYS_404`ucon'_B2
	
	************************************************

	
	rename MOD4_CARE_PATHWAYS_412`ucon'_B1 m4_consult`num'_len
	destring MOD4_CARE_PATHWAYS_412`ucon'_B2, gen(test`ucon') force
	capture confirm var test`ucon'
	if _rc != 0 gen test`ucon' = MOD4_CARE_PATHWAYS_412`ucon'_B2
	capture assert m4_consult`num'_len == test if !missing(test`ucon') 
	if _rc != 0 {
		rename MOD4_CARE_PATHWAYS_412`ucon'_B2 m4_baby2_consult`num'_len 
		replace m4_baby2_consult`num'_len  = . if test`ucon' == m4_baby2_consult`num'_len 
		order m4_baby2_consult`num'_len, after(m4_consult`num'_len)

	}
	* We know this is not populated for the 1 respondent that provided a date instead of numeric values
	* This was sent to the team for confirmation
	if _rc == 0 {
		char m4_consult`num'_len[Original_ZA_Varname] `m4_consult`num'_len[Original_ZA_Varname]' & `MOD4_CARE_PATHWAYS_412`ucon'_B2[Original_ZA_Varname]'
		drop MOD4_CARE_PATHWAYS_412`ucon'_B2 test`ucon'
	}
	if _rc != 0 drop test`ucon'
	local ++num
	
	************************************************
}

*/


foreach con in a b c {
    * Rename the C1 variable
    rename Q403_`con'_C1 m4_403`con'

    * List to verify C2 has values when C1 might be missing
    list m4_403`con' Q403_`con'_C2 if !missing(Q403_`con'_C2)

    * Replace C1 with C2 values where C1 is missing
    replace m4_403`con' = Q403_`con'_C2 if missing(m4_403`con')

    * Drop the C2 variable as its purpose is served
    drop Q403_`con'_C2
	
	* Rename the C1 variable
    rename Q404_`con'_C1 m4_404`con'

    * List to verify C2 has values when C1 might be missing
    list m4_404`con' Q404_`con'_C2 if !missing(Q404_`con'_C2)

    * Replace C1 with C2 values where C1 is missing
    replace m4_404`con' = Q404_`con'_C2 if missing(m4_404`con')

    * Drop the C2 variable as its purpose is served
    drop Q404_`con'_C2
	


}

* Other 403/404 name and other vars *

* Drop all that are completely missing
foreach var in Q403_b_Name_C2 Q403_c_Name_C2 Q404_a_other_C2 Q404_b_other_C2 Q404_b_Name_C2 Q404_c_other_C2 Q404_c_Name_C2 {
    capture assert missing(`var')
    if _rc == 0 {
        drop `var'
    }
}
	

* For name vars
foreach pre in 403 404 {
    foreach suf in a b c {
        rename Q`pre'_`suf'_Name_C1 m4_`pre'`suf'_name
    }
}

foreach pre in 404 {
    foreach suf in a b c {
        rename Q`pre'_`suf'_other_C1 m4_`pre'`suf'_other
    }
}

* List to verify C2 has values when C1 name might be missing
list m4_403a_name Q403_a_Name_C2 if !missing(Q403_a_Name_C2)
list m4_404a_name Q404_a_Name_C2 if !missing(Q404_a_Name_C2)
        
* Replace C1 name with C2 values where C1 name is missing and C2 is not missing
replace m4_403a_name = Q403_a_Name_C2 if missing(m4_403a_name) & !missing(Q403_a_Name_C2)
replace m4_404a_name = Q404_a_Name_C2 if missing(m4_404a_name) & !missing(Q404_a_Name_C2)

* Drop the C2 name variable as its purpose is served
drop Q403_a_Name_C2 Q404_a_Name_C2
			
************************************************
************************************************

rename Q405_C1 m4_405a
rename Q407_C1 m4_405b
rename Q409_C1 m4_405c

list m4_405a Q405_C2 if !missing(Q405_C2)
replace m4_405a = Q405_C2 if missing(m4_405a) & !missing(Q405_C2)
drop Q405_C2

*codebook Q407_C2 Q409_C2 
drop Q407_C2 Q409_C2 // all missing

* Rename variables Q406_1_C1 to Q406_96_C1 to m4_405a_1 to m4_405a_96
foreach i in 1 2 3 4 5 6 7 8 9 10 96 {
    rename Q406_`i'_C1 m4_405a_`i'
	rename Q408_`i'_C1 m4_405b_`i'
	rename Q410_`i'_C1 m4_405c_`i'
}

* Rename the "other" variable
rename Q406_other_C1 m4_405a_other
rename Q408_other_C1 m4_405b_other
rename Q410_other_C1 m4_405c_other

* codebook Q406_C2 Q406_1_C2 Q406_2_C2 Q406_3_C2 Q406_4_C2 Q406_5_C2 Q406_6_C2 Q406_7_C2 Q406_8_C2 Q406_9_C2 Q406_10_C2 Q406_96_C2 Q406_other_C2
foreach var in Q406_C2 Q406_1_C2 Q406_2_C2 Q406_3_C2 Q406_4_C2 Q406_5_C2 Q406_6_C2 Q406_7_C2 Q406_8_C2 Q406_9_C2 Q406_10_C2 Q406_96_C2 Q406_other_C2 {
    capture assert missing(`var')
    if _rc == 0 {
        drop `var'
    }
}

foreach var in Q406_C2 Q406_1_C2 Q406_2_C2 Q406_3_C2 Q406_4_C2 Q406_5_C2 Q406_6_C2 Q406_7_C2 Q406_8_C2 Q406_9_C2 Q406_10_C2 Q406_96_C2 Q406_other_C2 Q408_C2 Q408_1_C2 Q408_2_C2 Q408_3_C2 Q408_4_C2 Q408_5_C2 Q408_6_C2 Q408_7_C2 Q408_8_C2 Q408_9_C2 Q408_10_C2 Q408_96_C2 Q408_other_C2 Q410_C2 Q410_1_C2 Q410_2_C2 Q410_3_C2 Q410_4_C2 Q410_5_C2 Q410_6_C2 Q410_7_C2 Q410_8_C2 Q410_9_C2 Q410_10_C2 Q410_96_C2 Q410_other_C2 {
    capture assert missing(`var')
    if _rc == 0 {
        drop `var'
    }
}

* NK note: Loop below not needed for India data, coded above

/*
local 405 a
local 407 b
local 409 c

local 406 a
local 408 b
local 410 c

local num 1
foreach var in 405 407 409 {
	
	rename MOD4_CARE_PATHWAYS_`var'_B1 m4_405``var''
	assertlist m4_405``var'' == MOD4_CARE_PATHWAYS_`var'_B2 if !missing(MOD4_CARE_PATHWAYS_`var'_B2) & (MOD4_CARE_PATHWAYS_`var'_B2 != 95 &  m4_402 < `num'), list(m4_respondentid m4_402 m4_405``var'' MOD4_CARE_PATHWAYS_`var'_B2)

	drop MOD4_CARE_PATHWAYS_`var'_B2
	local ++var
	local ++num

* Create multi select variables
	forvalues i = 1/2 {
		capture replace MOD4_CARE_PATHWAYS_`var'_B`i' = subinstr(MOD4_CARE_PATHWAYS_`var'_B`i',","," ",.)
		capture replace MOD4_CARE_PATHWAYS_`var'_B`i' = trim(MOD4_CARE_PATHWAYS_`var'_B`i')
	}

	local type `:type MOD4_CARE_PATHWAYS_`var'_B2'
	local type = substr("`type'",1,3)
	local type = upper("`type'")
	
	
	if "`type'"=="STR" {
		
		 forvalues i = 1/2 {
			gen wc`i' = wordcount(MOD4_CARE_PATHWAYS_`var'_B`i')
			sum wc`i'
			local max`i' = r(max)
		}
		local max = max(`max1',`max2')
		drop wc* 
	}
	if "`type'" != "STR" local max 1

* We need to check that these were skipped approriatley

	foreach v in 1 2 3 4 5 6 7 8 9 10 96 {
		di "`v'"
		gen m4_405``var''_`v' = 0 if !missing(MOD4_CARE_PATHWAYS_`var'_B1) | !missing(MOD4_CARE_PATHWAYS_`var'_B2) 
		order m4_405``var''_`v' , before(MOD4_CARE_PATHWAYS_`var'_B1)
		char m4_405``var''_`v'[Module] 4
		char m4_405``var''_`v'[Original_ZA_Varname] `MOD4_CARE_PATHWAYS_`var'_B1[Original_ZA_Varname]' & `MOD4_CARE_PATHWAYS_`var'_B2[Original_ZA_Varname]'
		
		forvalues i = 1/`max' {
			local check MOD4_CARE_PATHWAYS_`var'_B1 == `v' | MOD4_CARE_PATHWAYS_`var'_B2 == `v'
			if "`type'"=="STR" local check word(MOD4_CARE_PATHWAYS_`var'_B1,`i') == "`v'" | word(MOD4_CARE_PATHWAYS_`var'_B2,`i') == "`v'"
			replace m4_405``var''_`v' = 1 if `check'
		}
		
		char m4_405``var''_`v'[Module] 4 
		char m4_405``var''_`v'[Original_ZA_Varname] `MOD4_CARE_PATHWAYS_`var'_B1[Original_ZA_Varname]' and `MOD4_CARE_PATHWAYS_`var'_B2[Original_ZA_Varname]'
			
		if "`type'" == "STR" {
			assertlist m4_405``var''_`v' == 1 if word(MOD4_CARE_PATHWAYS_`var'_B2,1) =="`v'" | word(MOD4_CARE_PATHWAYS_`var'_B2,2) =="`v'" , list( m4_405``var''_`v' MOD4_CARE_PATHWAYS_`var'_B1 MOD4_CARE_PATHWAYS_`var'_B2 )
		
			assertlist m4_405``var''_`v' == 0 if word(MOD4_CARE_PATHWAYS_`var'_B2,1) !="`v'" & word(MOD4_CARE_PATHWAYS_`var'_B2,2) !="`v'" & word(MOD4_CARE_PATHWAYS_`var'_B1,1) !="`v'" & word(MOD4_CARE_PATHWAYS_`var'_B1,2) !="`v'" & !missing(MOD4_CARE_PATHWAYS_`var'_B1) & !missing(MOD4_CARE_PATHWAYS_`var'_B2) , list(m4_respondentid m4_405``var''_`v' MOD4_CARE_PATHWAYS_`var'_B2 ) 
		}
		if "`type'" != "STR" {
			assertlist m4_405``var''_`v' == 1 if MOD4_CARE_PATHWAYS_`var'_B2 ==`v', list( m4_405``var''_`v' MOD4_CARE_PATHWAYS_`var'_B1 MOD4_CARE_PATHWAYS_`var'_B2 )
		
			assertlist m4_405``var''_`v' == 0 if MOD4_CARE_PATHWAYS_`var'_B2 !=`v' & MOD4_CARE_PATHWAYS_`var'_B1 !=`v' & !missing(MOD4_CARE_PATHWAYS_`var'_B1) & !missing(MOD4_CARE_PATHWAYS_`var'_B2) , list(m4_respondentid m4_405``var''_`v' MOD4_CARE_PATHWAYS_`var'_B2 ) 
		}
		assertlist missing(m4_405``var''_`v') if missing(MOD4_CARE_PATHWAYS_`var'_B1)  & missing(MOD4_CARE_PATHWAYS_`var'_B2) //, list( m4_405``var''_`v' MOD4_CARE_PATHWAYS_`var'_B1 MOD4_CARE_PATHWAYS_`var'_B2 MOD4_CARE_PATHWAYS_`var'_B3 )

	}
	
	rename MOD4_CARE_PATHWAYS_`var'_B1_OTHER m4_405``var''_other 
	* For these variables we can just move the B2 into B1 if it is missing for B1
	assert missing(m4_405``var''_other) if !missing(MOD4_CARE_PATHWAYS_`var'_B2_OTHER)
	replace m4_405``var''_other = MOD4_CARE_PATHWAYS_`var'_B2_OTHER if missing(m4_405``var''_other)
	assert !missing(m4_405``var''_other) if !missing(MOD4_CARE_PATHWAYS_`var'_B2_OTHER)
	char m4_405``var''_other[Original_ZA_Varname] `m4_405``var''_other[Original_ZA_Varname]' & `MOD4_CARE_PATHWAYS_`var'_B2_OTHER[Original_ZA_Varname]' 

	drop MOD4_CARE_PATHWAYS_`var'_B1 MOD4_CARE_PATHWAYS_`var'_B2 MOD4_CARE_PATHWAYS_`var'_B2_OTHER
	
}
*/

************************************************
************************************************

* NK note - loop not needed for India, see date rename below


* For the consultation dates we need to convert them to numeric values
/*
* Loop through the different number of visits
foreach d in A B C {
	local ld = lower("`d'")
	
	* Convert the visit dates to date values
	local count 1 2
	if "`d'" == "A" local count 1
	foreach c in `count' {
		gen date = subinstr(MOD4_CARE_PATHWAYS_411`d'_B`c',"-","",.) 
		local m 1
		foreach v in Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec {
			local b `m'
			if `m' < 10 local b 0`b'
			replace date = subinstr(date,"`v'","`b'",.) 
			local ++m
		} 
		replace date = trim(date)

		gen l = strlen(date)
		replace date = "0" + date  if l < 6 & l > 2 
		gen date_d = substr(date,1,2)
		gen date_m = substr(date,3,2)
		gen date_y = substr(date,5,2)
		destring date_d date_m date_y, replace
		replace date_y = 2000 + date_y
		gen m4_411`ld'_`c' = mdy(date_m,date_d,date_y)
		format %td m4_411`ld'_`c'
		replace m4_411`ld'_`c' = .d if MOD4_CARE_PATHWAYS_411`d'_B`c' == ".d"
		replace m4_411`ld'_`c' = .a if MOD4_CARE_PATHWAYS_411`d'_B`c' == ".a"
		replace m4_411`ld'_`c' = .r if MOD4_CARE_PATHWAYS_411`d'_B`c' == ".r"

		char m4_411`ld'_`c'[Original_ZA_Varname] MOD4_CARE_PATHWAYS_411`d'_B`c'
		char m4_411`ld'_`c'[Module] 4

		order m4_411`ld'_`c', after(MOD4_CARE_PATHWAYS_411`d'_B`c')
		drop date date_* l
	}
	
	if "`d'" == "A" {
		gen date = MOD4_CARE_PATHWAYS_411`d'_B2
		replace date = trim(date)

		gen l = strpos(date,"/")
		gen date_m = substr(date,1,l-1) if l > 0
		gen date2 = substr(date,l+1,.)
		replace l = strpos(date2,"/")
		gen date_d = substr(date2,1,l-1) if l > 0
		gen date_y = substr(date2,l+1,.) if l > 0
		
		destring date_d date_m date_y, replace
		gen m4_411`ld'_2= mdy(date_m,date_d,date_y)
		format %td m4_411`ld'_2
		replace m4_411`ld'_2 = .d if MOD4_CARE_PATHWAYS_411`d'_B2 == ".d"
		replace m4_411`ld'_2 = .a if MOD4_CARE_PATHWAYS_411`d'_B2 == ".a"
		replace m4_411`ld'_2 = .r if MOD4_CARE_PATHWAYS_411`d'_B2 == ".r"
		char m4_411`ld'_2[Original_ZA_Varname] MOD4_CARE_PATHWAYS_411`d'_B2
		char m4_411`ld'_2[Module] 4

		order m4_411`ld'_2, after(MOD4_CARE_PATHWAYS_411`d'_B2)
		drop date date2 date_* l
	}
	
	assertlist m4_411`ld'_1 == m4_411`ld'_2 if !missing(m4_411`ld'_2), list(m4_respondentid m4_411`ld'_1 m4_411`ld'_2 MOD4_CARE_PATHWAYS_411`d'_B1 MOD4_CARE_PATHWAYS_411`d'_B2)
	capture assert m4_411`ld'_1 == m4_411`ld'_2 if !missing(m4_411`ld'_2)
	if _rc != 0 {
		rename m4_411`ld'_2 m4_baby2_411`ld'
		replace m4_baby2_411`ld' = . if m4_411`ld'_1 == m4_baby2_411`ld'
		order m4_baby2_411`ld', after(m4_411`ld'_1)
		drop  MOD4_CARE_PATHWAYS_411`d'_B2 MOD4_CARE_PATHWAYS_411`d'_B1
	}
	* These two dates match so we can use just the date from b1
	if _rc == 0 drop m4_411`ld'_2 MOD4_CARE_PATHWAYS_411`d'_B2 MOD4_CARE_PATHWAYS_411`d'_B1
	rename m4_411`ld'_1 m4_411`ld'
}

*/

rename Q411_a_Date_C1 m4_baby1_411a
rename Q411_b_Date_C1 m4_baby1_411b
rename Q411_c_Date_C1 m4_baby1_411c

rename Q411_a_Date_C2 m4_baby2_411a
rename Q411_b_Date_C2 m4_baby2_411b
rename Q411_c_Date_C2 m4_baby2_411c 

order m4_baby2_411a m4_baby2_411b m4_baby2_411c, after(m4_baby1_411a)
drop Q411_a_C1 Q411_b_C1 Q411_c_C1 Q411_a_C2 Q411_b_C2 Q411_c_C2 // just "enter" date variables

     
* NK note - 412 is different than ZA and KE (I think) - there aren't 6 consultations - unless this is a C1/C2 error 

rename Q412_a_a_C1 m4_consult1_len_wks
rename Q412_a_b_C1 m4_consult1_len_dys
rename Q412_b_a_C1 m4_consult2_len_wks
rename Q412_b_b_C1 m4_consult2_len_dys
rename Q412_c_a_C1 m4_consult3_len_wks
rename Q412_c_b_C1 m4_consult3_len_dys

list m4_consult1_len_wks Q412_a_a_C2 if !missing(Q412_a_a_C2)
replace m4_consult1_len_wks = Q412_a_a_C2 if missing(m4_consult1_len_wks) & !missing(Q412_a_a_C2) // NK Note: these values don't really make sense compared to others 

list m4_consult1_len_dys Q412_a_b_C2 if !missing(Q412_a_b_C2)
replace m4_consult1_len_dys = Q412_a_b_C2 if missing(m4_consult1_len_dys) & !missing(Q412_a_b_C2) // NK Note: these values don't really make sense compared to others 

* NK Note: for others, the number of weeks = number of days, but not for Q412_a_a_C2 and Q412_a_b_C2

drop Q412_a_a_C2 Q412_a_b_C2

foreach var in Q412_b_a_C2 Q412_b_b_C2 Q412_c_a_C2 Q412_c_a_C2 Q412_c_b_C2 {
    capture assert missing(`var')
    if _rc == 0 {
        drop `var'
    }
}

************************************************
************************************************

* NK note - this is different then ZA and KE that have one m413 var 

ren Q413_0 m4_413a
ren Q413_1 m4_413b
ren Q413_2 m4_413c
ren Q413_3 m4_413d
ren Q413_4 m4_413e
ren Q413_5 m4_413f
ren Q413_6 m4_413g
ren Q413_7 m4_413h
ren Q413_8 m4_413i
ren Q413_9 m4_413j
ren Q413_10 m4_413k
ren Q413_11 m4_413l
ren Q413_96 m4_413_96
ren Q413_99 m4_413_99
ren Q413_other m4_413_other

********************************************************************************
********************************************************************************
* Section 5:

rename Q501 m4_501
rename Q502 m4_502
rename Q503 m4_503

********************************************************************************
********************************************************************************
* Section 6:

foreach b in 1 2 {
	rename Q601_a_C`b' m4_baby`b'_601a

	rename Q601_b_C`b' m4_baby`b'_601b

	rename Q601_c_C`b' m4_baby`b'_601c

	rename Q601_d_C`b' m4_baby`b'_601d

	rename Q601_e_C`b' m4_baby`b'_601e

	rename Q601_f_C`b' m4_baby`b'_601f

	rename Q601_g_C`b' m4_baby`b'_601g

	rename Q601_h_C`b' m4_baby`b'_601h

	rename Q601_i_C`b' m4_baby`b'_601i
	rename Q601_i_other_C`b' m4_baby`b'_601i_other
}

rename Q602_a_C1 m4_baby1_602a	
rename Q602_b_C1 m4_baby1_602b
rename Q602_c_C1 m4_baby1_602c
rename Q602_d_C1 m4_baby1_602d
rename Q602_e_C1 m4_baby1_602e
rename Q602_f_C1 m4_baby1_602f
rename Q602_g_C1 m4_baby1_602g

rename Q602_a_C2 m4_baby2_602a	
rename Q602_b_C2 m4_baby2_602b
rename Q602_c_C2 m4_baby2_602c
rename Q602_d_C2 m4_baby2_602d
rename Q602_e_C2 m4_baby2_602e
rename Q602_f_C2 m4_baby2_602f
rename Q602_g_C2 m4_baby2_602g

order m4_baby2_601a m4_baby2_601b m4_baby2_601c m4_baby2_601d m4_baby2_601e m4_baby2_601f m4_baby2_601g m4_baby2_601h m4_baby2_601i m4_baby2_601i_other, after(m4_baby1_601i_other)
order m4_baby2_602a m4_baby2_602b m4_baby2_602c m4_baby2_602d m4_baby2_602e m4_baby2_602f m4_baby2_602g, after(m4_baby1_602g)

* NK - What are all the different a-i 603s for IN???
*	   Is 603 different in IN? Renamed below for now 
ren Q603* m4_603*


/*
* For MOD4_CONT_OF_CARE_603 we will create multiple variables
replace MOD4_CONT_OF_CARE_603 =subinstr(MOD4_CONT_OF_CARE_603,","," ",.)
replace MOD4_CONT_OF_CARE_603= trim(MOD4_CONT_OF_CARE_603)

local n 0
gen wc = wordcount(MOD4_CONT_OF_CARE_603)
sum wc
local wc =r(max)
drop wc

foreach v in a b c d e f g _96 _98 _99 {
	gen m4_603`v' = 0 if !missing(MOD4_CONT_OF_CARE_603)
	char m4_603`v'[Module] 4
	char m4_603`v'[Original_ZA_Varname] `MOD4_CONT_OF_CARE_603[Original_ZA_Varname]'
	
	forvalues w = 1/`wc' {
		replace m4_603`v' = 1 if word(MOD4_CONT_OF_CARE_603,`w') == "`n'"
	}
	
	di "`v' = `n'"
	
	local ++n
	if `n' == 7 local n 96
	if `n' == 97 local n 98
	
} 

order m4_603*, after(MOD4_CONT_OF_CARE_603)
drop MOD4_CONT_OF_CARE_603


rename MOD4_CONT_OF_CARE_603_OTHER m4_603_other
*/ 

********************************************************************************
********************************************************************************
* Section 7:

rename Q701_a m4_701a
rename Q701_b m4_701b
rename Q701_c m4_701c
rename Q701_d m4_701d
rename Q701_e m4_701e
rename Q701_f m4_701f
rename Q701_g m4_701g
rename Q701_h m4_701h
rename Q701_h_specify m4_701h_other

rename Q702 m4_702

rename Q703_a m4_703a
rename Q703_b m4_703b
rename Q703_c m4_703c
rename Q703_d m4_703d
rename Q703_e m4_703e
rename Q703_f m4_703f
rename Q703_g m4_703g

rename Q704_a m4_704a
rename Q704_b m4_704b
rename Q704_c m4_704c

********************************************************************************
********************************************************************************
* Section 8:

rename Q801_a m4_801a
rename Q801_b m4_801b
rename Q801_c m4_801c
rename Q801_d m4_801d
rename Q801_e m4_801e
rename Q801_f m4_801f
rename Q801_g m4_801g
rename Q801_h m4_801h
rename Q801_i m4_801i
rename Q801_j m4_801j
rename Q801_k m4_801k
rename Q801_l m4_801l
rename Q801_m m4_801m
rename Q801_n m4_801n
rename Q801_o m4_801o
rename Q801_p m4_801p
rename Q801_q m4_801q
rename Q801_r m4_801r
rename Q801_r_specify m4_801r_other

rename Q802_a_C1 m4_baby1_802a
rename Q802_b_C1 m4_baby1_802b
rename Q802_c_C1 m4_baby1_802c
rename Q802_d_C1 m4_baby1_802d
rename Q802_e_C1 m4_baby1_802e
rename Q802_f_C1 m4_baby1_802f
rename Q802_g_C1 m4_baby1_802g
rename Q802_h_C1 m4_baby1_802h
rename Q802_i_C1 m4_baby1_802i
rename Q802_j_C1 m4_baby1_802j
rename Q802_j_specify_C1 m4_802j_baby1_other

* NK note: ZA didn't have baby 2 vars for 802 or 803

rename Q802_a_C2 m4_baby2_802a
rename Q802_b_C2 m4_baby2_802b
rename Q802_c_C2 m4_baby2_802c
rename Q802_d_C2 m4_baby2_802d
rename Q802_e_C2 m4_baby2_802e
rename Q802_f_C2 m4_baby2_802f
rename Q802_g_C2 m4_baby2_802g
rename Q802_h_C2 m4_baby2_802h
rename Q802_i_C2 m4_baby2_802i
rename Q802_j_C2 m4_baby2_802j
rename Q802_j_specify_C2 m4_baby2_802j_other

order m4_baby2_802a m4_baby2_802b m4_baby2_802c m4_baby2_802d m4_baby2_802e m4_baby2_802f m4_baby2_802g m4_baby2_802h m4_baby2_802i m4_baby2_802j m4_baby2_802j_other , after(m4_802j_baby1_other)

rename Q803_a_C1 m4_baby1_803a
rename Q803_b_C1 m4_baby1_803b
rename Q803_c_C1 m4_baby1_803c
rename Q803_d_C1 m4_baby1_803d
rename Q803_e_C1 m4_baby1_803e
rename Q803_f_C1 m4_baby1_803f
rename Q803_g_C1 m4_baby1_803g

rename Q803_a_C2 m4_baby2_803a
rename Q803_b_C2 m4_baby2_803b
rename Q803_c_C2 m4_baby2_803c
rename Q803_d_C2 m4_baby2_803d
rename Q803_e_C2 m4_baby2_803e
rename Q803_f_C2 m4_baby2_803f
rename Q803_g_C2 m4_baby2_803g

rename Q804 m4_baby1_804
rename Q804_C2 m4_baby2_804

rename Q805 m4_805

order m4_baby2_803a m4_baby2_803b m4_baby2_803c m4_baby2_803d m4_baby2_803e m4_baby2_803f m4_baby2_803g m4_baby2_804, after(m4_baby1_804)

********************************************************************************
********************************************************************************
* Section 9:

rename Q901 m4_901
rename Q902_a m4_902a_amt
rename Q902_b m4_902b_amt
rename Q902_c m4_902c_amt
rename Q902_d m4_902d_amt
rename Q902_e m4_902e_amt
rename Q902_e_other m4_902e_oth
gen m4_902_total_spent = m4_902a_amt + m4_902b_amt + m4_902c_amt + m4_902d_amt + m4_902e_amt
     
order m4_902_total_spent, after(m4_902e_oth)

rename Q903 m4_903

rename Q904 m4_904

rename Q905 m4_905
rename Q905_1 m4_905a
rename Q905_2 m4_905b
rename Q905_3 m4_905c
rename Q905_4 m4_905d
rename Q905_5 m4_905e
rename Q905_6 m4_905f
rename Q905_96 m4_905g
rename Q905_other m4_905_other

drop SubmissionDate start end calc_start_time B1 B2_Date B2_Time B2_Place addcomment // NK Note - okay to drop these?

*===============================================================================

* Value labels - NK approach 

foreach var of varlist m4* {
    // Exclude the variable m4_duration
    if "`var'" == "m4_duration" {
        continue
    }

    // Check if the variable is numeric
    capture confirm numeric variable `var'
    if (!_rc) {  // If the variable is numeric, _rc (return code) will be 0
        // Recode only numeric variables
        recode `var' (98 = .d) (99 = .r)
    }
}

* Left 96 because it had appropriate value labels, and different for the different questions


// Loop over `m4_baby1_*` variables to get and apply value labels
foreach var1 of varlist m4_baby1_* {
    // Retrieve the value label for the current `m4_baby1_*` variable
    local labelname : value label `var1'
    
    // Construct the corresponding `m4_baby2_*` variable name
    // Assuming `m4_baby1_*` and `m4_baby2_*` are perfectly aligned
    local var2 = subinstr("`var1'", "baby1", "baby2", 1)

    // Apply the value label to the corresponding `m4_baby2_*` variable if it exists
    capture confirm variable `var2'
    if (!_rc & "`labelname'" != "") {
        label values `var2' `labelname'
    }
}


// Loop over `m4_baby1_*` variables to get and apply value labels
foreach var1 of varlist m4_baby1_* {
    // Retrieve the value label for the current `m4_baby1_*` variable
    local labelname : value label `var1'
    
    // Construct the corresponding `m4_baby2_*` variable name
    // Assuming `m4_baby1_*` and `m4_baby2_*` are perfectly aligned
    local var2 = subinstr("`var1'", "baby1", "baby2", 1)

    // Apply the value label to the corresponding `m4_baby2_*` variable if it exists
    capture confirm variable `var2'
    if (!_rc & "`labelname'" != "") {
        label values `var2' `labelname'
    }
}


lab val m4_501 Q502 // no value labels for m4_501   

*===============================================================================

* From label file 

* These variables are the same for all countries 

capture label var m4_respondentid "M4 respondentid"
capture label var m4_attempt_date "M4 interview date"

capture label var m4_start "Consent"
capture label var m4_permission "Permission to conduct call"
capture label var m4_attempt_number "M4 number of attempts calling respondent"
capture label var m4_attempt_number_other "M4 number of attempts: Other"
capture label var m4_attempt_outcome "M4 Call outcome"
capture label var m4_resp_language "Able to speak the langague of the respondent"

capture label var m4_date_of_rescheduled "Date of rescheduled interview"
capture label var m4_time_of_reschedule "Time of rescheduled interview"
capture label var m4_attempt_relationship "Relationship to respondent"
capture label var m4_attempt_other "Specify other relationship with respondent"
capture label var m4_consent_recording "Consent to interview being recorded"
capture label var m4_interviewer_initials "Interviewer initials"
capture label var m4_interviewer_id "Interviewer ID"
capture label var m4_interviewer "Interviewer Name"
capture label var m4_record_id "Respondent ID"

capture label var m4_date "Date of interview"
capture label var m4_time "Interview start time"
capture label var m4_hiv_status "HIV status"
capture label var m4_maternal_death_reported "Maternal death reported"
capture label var m4_date_of_maternal_death "Date of maternal death"
capture label var m4_maternal_death_learn "How did you learn about the maternal death? "
capture label var m4_maternal_death_learn_other "How did you learn about the maternal death: Other specified"
capture label var m4_c_section "Cesarean Section"
capture label var m4_live_babies "Number of alive babies"
capture label var m4_date_delivery "Date of delivery"
capture label var m4_weeks_delivery "Weeks between delivery date and today"

capture label var m4_baby1_name "Baby 1: Name"
capture label var m4_baby2_name "Baby 2: Name"

capture label var m4_baby1_status "Baby 1: Is baby alive"
capture label var m4_baby2_status "Baby 2: Is baby alive"
capture label var m4_baby3_status "Baby 3: Is baby alive"

capture label var m4_baby1_health "Baby 1: Rate baby's overall health"
capture label var m4_baby2_health "Baby 2: Rate baby's overall health"
capture label var m4_baby3_health "Baby 3: Rate baby's overall health"

capture label var m4_baby1_feed_a "Baby 1: how fed by Breast milk"
capture label var m4_baby1_feed_b "Baby 1: how fed by Formula"
capture label var m4_baby1_feed_c "Baby 1: how fed by Water"
capture label var m4_baby1_feed_d "Baby 1: how fed by Juice"
capture label var m4_baby1_feed_e "Baby 1: how fed by Broth"
capture label var m4_baby1_feed_f "Baby 1: how fed by Baby food"
capture label var m4_baby1_feed_g "Baby 1: how fed by Local food"
capture label var m4_baby1_feed_rf "Baby 1: how fed - No Response/Refused to answer"

capture label var m4_baby2_feed_a "Baby 2: how fed by Breast milk"
capture label var m4_baby2_feed_b "Baby 2: how fed by Formula"
capture label var m4_baby2_feed_c "Baby 2: how fed by Water"
capture label var m4_baby2_feed_d "Baby 2: how fed by Juice"
capture label var m4_baby2_feed_e "Baby 2: how fed by Broth"
capture label var m4_baby2_feed_f "Baby 2: how fed by Baby food"
capture label var m4_baby2_feed_g "Baby 2: how fed by Local food"
capture label var m4_203_2_rf "Baby 2: how fed - No Response/Refused to answer"
capture label var m4_baby2_feed_rf "Baby 2: how fed - No Response/Refused to answer"

capture label var m4_baby3_feed_a "Baby 3: how fed by Breast milk"
capture label var m4_baby3_feed_b "Baby 3: how fed by Formula"
capture label var m4_baby3_feed_c "Baby 3: how fed by Water"
capture label var m4_baby3_feed_d "Baby 3: how fed by Juice"
capture label var m4_baby3_feed_e "Baby 3: how fed by Broth"
capture label var m4_baby3_feed_f "Baby 3: how fed by Baby food"
capture label var m4_baby3_feed_g "Baby 3: how fed by Local food"
capture label var m4_203_3_rf "Baby 3: how fed - No Response/Refused to answer"

capture label var m4_breastfeeding "Confidence in beastfeeding (as of today)"
capture label var m4_baby1_breastfeeding "Baby 1: Confidence in beastfeeding (as of today)"
capture label var m4_baby2_breastfeeding "Baby 2: Confidence in beastfeeding (as of today)"

capture label var m4_baby1_sleep "Baby 1: Today's sleep description"
capture label var m4_baby2_sleep "Baby 2: Today's sleep description"
capture label var m4_baby3_sleep "Baby 3: Today's sleep description"
capture label var m4_baby1_feed "Baby 1: Today's feeding description"
capture label var m4_baby2_feed "Baby 2: Today's feeding description"
capture label var m4_baby3_feed "Baby 3: Today's feeding description"
capture label var m4_baby1_breath "Baby 1: Today's breathing description"
capture label var m4_baby2_breath "Baby 2: Today's breathing description"
capture label var m4_baby3_breath "Baby 3: Today's breathing description"
capture label var m4_baby1_stool "Baby 1: Today's stool/poo description"
capture label var m4_baby2_stool "Baby 2: Today's stool/poo description"
capture label var m4_baby3_stool "Baby 3: Today's stool/poo description"
capture label var m4_baby1_mood "Baby 1: Today's mood description"
capture label var m4_baby2_mood "Baby 2: Today's mood description"
capture label var m4_baby3_mood "Baby 3: Today's mood description"
capture label var m4_baby1_skin "Baby 1: Today's skin description"
capture label var m4_baby2_skin "Baby 2: Today's skin description"
capture label var m4_baby3_skin "Baby 3: Today's skin description"
capture label var m4_baby1_interactivity "Baby 1: Today's interactivity description"
capture label var m4_baby2_interactivity "Baby 2: Today's interactivity description"
capture label var m4_baby3_interactivity "Baby 3: Today's interactivity description"
capture label var m4_baby1_diarrhea "Since last spoke Baby 1 had: Diarrhea with blood in the stools"
capture label var m4_baby2_diarrhea "Since last spoke Baby 2 had: Diarrhea with blood in the stools"
capture label var m4_baby3_diarrhea "Since last spoke Baby 3 had: Diarrhea with blood in the stools"
capture label var m4_baby1_fever "Since last spoke Baby 1 had: A fever (a temperature > 37)"
capture label var m4_baby2_fever "Since last spoke Baby 2 had: A fever (a temperature > 37)"
capture label var m4_baby3_fever "Since last spoke Baby 3 had: A fever (a temperature > 37)"
capture label var m4_baby1_lowtemp "Since last spoke Baby 1 had: A low temperature (< 35)"
capture label var m4_baby2_lowtemp "Since last spoke Baby 2 had: A low temperature (< 35)"
capture label var m4_baby3_lowtemp "Since last spoke Baby 3 had: A low temperature (< 35)"
capture label var m4_baby1_illness "Since last spoke Baby 1 had: An illness with a cough"
capture label var m4_baby2_illness "Since last spoke Baby 2 had: An illness with a cough"
capture label var m4_baby3_illness "Since last spoke Baby 3 had: An illness with a cough"
capture label var m4_baby1_troublebreath "Since last spoke Baby 1 had: Trouble breathing or fast/short rapid breaths"
capture label var m4_baby2_troublebreath "Since last spoke Baby 2 had: Trouble breathing or fast/short rapid breaths"
capture label var m4_baby3_troublebreath "Since last spoke Baby 3 had: Trouble breathing or fast/short rapid breaths"
capture label var m4_baby1_chestprob "Since last spoke Baby 1 had: A problem in the chest"
capture label var m4_baby2_chestprob "Since last spoke Baby 2 had: A problem in the chest"
capture label var m4_baby3_chestprob "Since last spoke Baby 3 had: A problem in the chest"
capture label var m4_baby1_troublefeed "Since last spoke Baby 1 had: Trouble feeding"
capture label var m4_baby2_troublefeed "Since last spoke Baby 2 had: Trouble feeding"
capture label var m4_baby3_troublefeed "Since last spoke Baby 3 had: Trouble feeding"
capture label var m4_baby1_convulsions "Since last spoke Baby 1 had: Convulsions"
capture label var m4_baby2_convulsions "Since last spoke Baby 2 had: Convulsions"
capture label var m4_baby3_convulsions "Since last spoke Baby 3 had: Convulsions"
capture label var m4_baby1_jaundice "Since last spoke Baby 1 had: Jaundice (that is, yellow color of the skin)"
capture label var m4_baby2_jaundice "Since last spoke Baby 2 had: Jaundice (that is, yellow color of the skin)"
capture label var m4_baby3_jaundice "Since last spoke Baby 3 had: Jaundice (that is, yellow color of the skin)"
capture label var m4_baby1_yellowpalms "Since last spoke Baby 1 had: Yellow palms or soles"
capture label var m4_baby2_yellowpalms "Since last spoke Baby 2 had: Yellow palms or soles"
capture label var m4_baby3_yellowpalms "Since last spoke Baby 3 had: Yellow palms or soles"

capture label var m4_baby1_bulgedfont "Since last spoke Baby 1: Experienced Bulged fontanels"
capture label var m4_baby2_bulgedfont "Since last spoke Baby 2: Experienced Bulged fontanels"
capture label var m4_baby3_bulgedfont  "Since last spoke Baby 3: Experienced Bulged fontanels"

capture label var m4_baby1_lethargic "Since last spoke Baby 1: Experienced Lethargic/unconscious "
capture label var m4_baby2_lethargic "Since last spoke Baby 2: Experienced Lethargic/unconscious "
capture label var m4_baby3_lethargic "Since last spoke Baby 3: Experienced Lethargic/unconscious "

capture label var m4_baby1_noprobs "Since last spoke Baby 1 had: None of the above issues"
capture label var m4_baby1_otherprob "Since last spoke Baby 1 had: Any other health issues"
capture label var m4_baby1_other "Since last spoke Baby 1 had: Any other health issues specified"
capture label var m4_baby2_noprobs "Since last spoke Baby 2 had: None of the above issues"
capture label var m4_baby2_otherprob "Since last spoke Baby 2 had: Any other health issues"
capture label var m4_baby2_other "Since last spoke Baby 2 had: Any other health issues specified"
capture label var m4_baby3_otherprob "Since last spoke Baby 3 had: Any other health issues"
capture label var m4_baby3_other "Since last spoke Baby 3 had: Any other health issues specified"

capture label var m4_baby1_death_date "Baby 1: Death date"
capture label var m4_baby1_death_date_unk "Baby 1: Death date unknown"
capture label var m4_baby2_death_date "Baby 2: Death date"
capture label var m4_baby2_death_date_unk "Baby 2: Death date unknown"
capture label var m4_baby3_death_date "Baby 3: Death date"
capture label var m4_baby3_death_date_unk "Baby 3: Death date unknown"

capture label var m4_baby1_deathage "Baby 1: Age in weeks or days old when died"
capture label var m4_baby1_deathage_unit_ke "Baby 1: Unit used to answer how many days or weeks old when baby died"
capture label var m4_baby2_deathage "Baby 2: Age in weeks or days old when died"
capture label var m4_baby3_deathage "Baby 3: Age in weeks or days old when died"

capture label var m4_baby1_210 "Baby 1 Cause of death"
capture label var m4_baby2_210 "Baby 1 Cause of death"

capture label var m4_baby1_210a "Baby 1 Cause of death: Not told anything"
capture label var m4_baby1_210b "Baby 1 Cause of death: The baby was premature (born too early)"
capture label var m4_baby1_210c "Baby 1 Cause of death: A birth injury or asphyxia(due to delivery complications)"
capture label var m4_baby1_210d "Baby 1 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m4_baby1_210e "Baby 1 Cause of death: Malaria"
capture label var m4_baby1_210f "Baby 1 Cause of death: An acute respiratory infection"
capture label var m4_baby1_210g "Baby 1 Cause of death: Diarrhea"
capture label var m4_baby1_210h "Baby 1 Cause of death: Another type of infection"
capture label var m4_baby1_210i "Baby 1 Cause of death: Severe acute malnutrition"
capture label var m4_baby1_210j "Baby 1 Cause of death: An accident or injury"
capture label var m4_baby1_210_96 "Baby 1 Cause of death: Another cause"
capture label var m4_baby1_210_98 "Baby 1 Cause of death: Don't know"
capture label var m4_baby1_210_99 "Baby 1 Cause of death: No response/Refused to answer"
capture label var m4_baby1_210_other "Baby 1 Cause of death: Other specified"

capture label var m4_baby2_210a "Baby 2 Cause of death: Not told anything"
capture label var m4_baby2_210b "Baby 2 Cause of death: The baby was premature (born too early)"
capture label var m4_baby2_210c "Baby 2 Cause of death: A birth injury or asphyxia(due to delivery complications)"
capture label var m4_baby2_210d "Baby 2 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m4_baby2_210e "Baby 2 Cause of death: Malaria"
capture label var m4_baby2_210f "Baby 2 Cause of death: An acute respiratory infection"
capture label var m4_baby2_210g "Baby 2 Cause of death: Diarrhea"
capture label var m4_baby2_210h "Baby 2 Cause of death: Another type of infection"
capture label var m4_baby2_210i "Baby 2 Cause of death: Severe acute malnutrition"
capture label var m4_baby2_210j "Baby 2 Cause of death: An accident or injury"
capture label var m4_baby2_210_96 "Baby 2 Cause of death: Another cause"
capture label var m4_baby2__210_998 "Baby 2 Cause of death: Don't know"
capture label var m4_baby2_210_999 "Baby 2 Cause of death: No response/Refused to answer"
capture label var m4_baby2_210_other "Baby 2 Cause of death: Other specified"

capture label var m4_baby3_210a "Baby 3 Cause of death: Not told anything"
capture label var m4_baby3_210b "Baby 3 Cause of death: The baby was premature (born too early)"
capture label var m4_baby3_210c "Baby 3 Cause of death: A birth injury or asphyxia(due to delivery complications)"
capture label var m4_baby3_210d "Baby 3 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m4_baby3_210e "Baby 3 Cause of death: Malaria"
capture label var m4_baby3_210f "Baby 3 Cause of death: An acute respiratory infection"
capture label var m4_baby3_210g "Baby 3 Cause of death: Diarrhea"
capture label var m4_baby3_210h "Baby 3 Cause of death: Another type of infection"
capture label var m4_baby3_210i "Baby 3 Cause of death: Severe acute malnutrition"
capture label var m4_baby3_210j "Baby 3 Cause of death: An accident or injury"
capture label var m4_baby3_210_96 "Baby 3 Cause of death: Another cause"
capture label var m4_baby3_210_998 "Baby 3 Cause of death: Don't know"
capture label var m4_baby3_210_999 "Baby 3 Cause of death: No response/Refused to answer"
capture label var m4_baby3_210_other "Baby 3 Cause of death: Other specified"

capture label var m4_baby1_advice "Baby 1: Before baby's death did you seek advice or treatment for illness?"
capture label var m4_baby2_advice "Baby 2: Before baby's death did you seek advice or treatment for illness?"
capture label var m4_baby3_advice "Baby 3: Before baby's death did you seek advice or treatment for illness?"
capture label var m4_baby1_death_loc "Baby 1: Location of death"
capture label var m4_baby2_death_loc "Baby 2: Location of death"
capture label var m4_baby3_death_loc "Baby 3: Location of death"

capture label var m4_301 "Since last spoke: Rate overall health"
capture label var m4_302a "Frequency in past 2wks: Little interest or pleasure in doing things (days)"
capture label var m4_302b "Frequency in past 2wks: Feeling down, depressed, or hopeless (days)"
capture label var m4_303a "Since birth feel towards baby: Loving"
capture label var m4_303b "Since birth feel towards baby: Resentful"
capture label var m4_303c "Since birth feel towards baby: Neutral or felt nothing"
capture label var m4_303d "Since birth feel towards baby: Joyful"
capture label var m4_303e "Since birth feel towards baby: Dislike"
capture label var m4_303f "Since birth feel towards baby: Protective"
capture label var m4_303g "Since birth feel towards baby: Disappointed"
capture label var m4_303h "Since birth feel towards baby: Aggressive"
capture label var m4_304 "Past 30 days how much has pain affected satisfaction with sex life"
capture label var m4_305 "Experienced constant leakage of urine or stool from vagina during day or night"
capture label var m4_306 "Days after birth symptoms started"
capture label var m4_307 "How much problem interferes with everyday life"
capture label var m4_308 "Sought treatment for constant leakage"
capture label var m4_309 "Why have not sought treatment for constant leakage"
capture label var m4_309_other "Why have not sought treatment for constant leakage: Other specified"
capture label var m4_310 "Treatment stopped constant leakage"

capture label var m4_401a "Since last spoke: New health care consultations for self or child"
capture label var m4_401b "Since last spoke: New health care consultations for self"
capture label var m4_402 "Since last spoke: Number of new health care consultations for self"

capture label var m4_403a "Since last spoke: Location of 1st new consultation"
capture label var m4_baby2_403a "Since last spoke: Location of 1st new consultation Baby2 if different from Baby1"

capture label var m4_403b "Since last spoke: Location of 2nd new consultation"
capture label var m4_baby2_403b "Since last spoke: Location of 2nd new consultation Baby2 if different from Baby1"

capture label var m4_403c "Since last spoke: Location of 3rd new consultation"
capture label var m4_baby2_403c "Since last spoke: Location of 3rd new consultation Baby2 if different from Baby1"

capture label var m4_403d "Since last spoke: Location of 4th new consultation"
capture label var m4_403e "Since last spoke: Location of 5th new consultation"
capture label var m4_403f "Since last spoke: Location of 6th new consultation"
capture label var m4_404a "Since last spoke: Facility name where 1st consultation took place"
capture label var m4_baby2_404a "Since last spoke: Facility name 1st consultation Baby2 if different from Baby1"


capture label var m4_baby2_404a "Since last spoke: Facility name 1st consultation Baby2 if different from Baby1"
capture label var m4_404a_other "Since last spoke: Facility name for 1st consultation: Other specified"

capture label var m4_404b "Since last spoke: Facility name where 2nd consultation took place"
capture label var m4_baby2_404b "Since last spoke: Facility name 3rd consultation Baby2 if different from Baby1"
capture label var m4_404b_other "Since last spoke: Facility name for 2nd consultation: Other specified"

capture label var m4_404c "Since last spoke: Facility name where 3rd consultation took place"
capture label var m4_baby2_404c "Since last spoke: Facility name 3rd consultation Baby2 if different from Baby1"

capture label var m4_404c_other "Since last spoke: Facility name for 3rd consultation: Other specified"


capture label var m4_404d "Since last spoke: Facility name where 4th consultation took place"
capture label var m4_404d_other "Since last spoke: Facility name for 4th consultation: Other specified"
capture label var m4_404e "Since last spoke: Facility name where 5th consultation took place"
capture label var m4_404e_other "Since last spoke: Facility name for 5th consultation: Other specified"
capture label var m4_404f "Since last spoke: Facility name where 6th consultation took place"
capture label var m4_404f_other "Since last spoke: Facility where 6th consultation took place: Other specified"

capture label var m4_405a "1st Consultation: For routine or regular checkup after delivery?"
capture label var m4_405a_1 "1st Consultation : New health problem for baby"
capture label var m4_405a_2 "1st Consultation : New health problem for self"
capture label var m4_405a_3 "1st Consultation : Existing health problem for baby"
capture label var m4_405a_4 "1st Consultation : Existing health problem for self"
capture label var m4_405a_5 "1st Consultation : Lab test, x-ray or ultrasound for self"
capture label var m4_405a_6 "1st Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m4_405a_7 "1st Consultation : To get a vaccine for baby"
capture label var m4_405a_8 "1st Consultation : To get a vaccine for self"
capture label var m4_405a_9 "1st Consultation : Pick up medicine for self"
capture label var m4_405a_10 "1st Consultation : Pick up medicine for baby"
capture label var m4_405a_96 "1st Consultation : Other reasons"
capture label var m4_405a_other "1st Consultation : Other reasons Specified"

capture label var m4_405b "2nd Consultation: For routine or regular checkup after delivery?"
capture label var m4_405b_1 "2nd Consultation : New health problem for baby"
capture label var m4_405b_2 "2nd Consultation : New health problem for self"
capture label var m4_405b_3 "2nd Consultation : Existing health problem for baby"
capture label var m4_405b_4 "2nd Consultation : Existing health problem for self"
capture label var m4_405b_5 "2nd Consultation : Lab test, x-ray or ultrasound for self"
capture label var m4_405b_6 "2nd Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m4_405b_7 "2nd Consultation : To get a vaccine for baby"
capture label var m4_405b_8 "2nd Consultation : To get a vaccine for self"
capture label var m4_405b_9 "2nd Consultation : Pick up medicine for self"
capture label var m4_405b_10 "2nd Consultation : Pick up medicine for baby"
capture label var m4_405b_96 "2nd Consultation : Other reasons"
capture label var m4_405b_other "2nd Consultation : Other reasons Specified"

capture label var m4_405c "3rd Consultation: For routine or regular checkup after delivery?"
capture label var m4_405c_1 "3rd Consultation : New health problem for baby"
capture label var m4_405c_2 "3rd Consultation : New health problem for self"
capture label var m4_405c_3 "3rd Consultation : Existing health problem for baby"
capture label var m4_405c_4 "3rd Consultation : Existing health problem for self"
capture label var m4_405c_5 "3rd Consultation : Lab test, x-ray or ultrasound for self"
capture label var m4_405c_6 "3rd Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m4_405c_7 "3rd Consultation : To get a vaccine for baby"
capture label var m4_405c_8 "3rd Consultation : To get a vaccine for self"
capture label var m4_405c_9 "3rd Consultation : Pick up medicine for self"
capture label var m4_405c_10 "3rd Consultation : Pick up medicine for baby"
capture label var m4_405c_96 "3rd Consultation : Other reasons"
capture label var m4_405c_other "3rd Consultation : Other reasons Specified"

capture label var m4_405d "4th Consultation: For routine or regular checkup after delivery?"
capture label var m4_405d_1 "4th Consultation : New health problem for baby"
capture label var m4_405d_2 "4th Consultation : New health problem for self"
capture label var m4_405d_3 "4th Consultation : Existing health problem for baby"
capture label var m4_405d_4 "4th Consultation : Existing health problem for self"
capture label var m4_405d_5 "4th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m4_405d_6 "4th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m4_405d_7 "4th Consultation : To get a vaccine for baby"
capture label var m4_405d_8 "4th Consultation : To get a vaccine for self"
capture label var m4_405d_9 "4th Consultation : Pick up medicine for self"
capture label var m4_405d_10 "4th Consultation : Pick up medicine for baby"
capture label var m4_405d_96 "4th Consultation : Other reasons"
capture label var m4_405d_other "4th Consultation : Other reasons Specified"

capture label var m4_405e "5th Consultation: For routine or regular checkup after delivery?"
capture label var m4_405e_1 "5th Consultation : New health problem for baby"
capture label var m4_405e_2 "5th Consultation : New health problem for self"
capture label var m4_405e_3 "5th Consultation : Existing health problem for baby"
capture label var m4_405e_4 "5th Consultation : Existing health problem for self"
capture label var m4_405e_5 "5th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m4_405e_6 "5th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m4_405e_7 "5th Consultation : To get a vaccine for baby"
capture label var m4_405e_8 "5th Consultation : To get a vaccine for self"
capture label var m4_405e_9 "5th Consultation : Pick up medicine for self"
capture label var m4_405e_10 "5th Consultation : Pick up medicine for baby"
capture label var m4_405e_96 "5th Consultation : Other reasons"
capture label var m4_405e_other "5th Consultation : Other reasons Specified"

capture label var m4_405f "6th Consultation: For routine or regular checkup after delivery?"
capture label var m4_405f_1 "6th Consultation : New health problem for baby"
capture label var m4_405f_2 "6th Consultation : New health problem for self"
capture label var m4_405f_3 "6th Consultation : Existing health problem for baby"
capture label var m4_405f_4 "6th Consultation : Existing health problem for self"
capture label var m4_405f_5 "6th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m4_405f_6 "6th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m4_405f_7 "6th Consultation : To get a vaccine for baby"
capture label var m4_405f_8 "6th Consultation : To get a vaccine for self"
capture label var m4_405f_9 "6th Consultation : Pick up medicine for self"
capture label var m4_405f_10 "6th Consultation : Pick up medicine for baby"
capture label var m4_405f_96 "6th Consultation : Other reasons"
capture label var m4_405f_other "6th Consultation : Other reasons Specified"

capture label var m4_411a "1st Consultation: Date"
capture label var m4_baby2_411a "1st Consultation: Date for Baby 2 if different from Baby 1"

capture label var m4_411b "2nd Consultation: Date"
capture label var m4_baby2_411b "2nd Consultation: Date for Baby 2 if different from Baby 1"

capture label var m4_411c "3rd Consultation: Date"
capture label var m4_baby2_411c "3rd Consultation: Date for Baby 2 if different from Baby 1"

capture label var m4_411d "4th Consultation: Date"
capture label var m4_411e "5th Consultation: Date"
capture label var m4_411f "6th Consultation: Date"

capture label var m4_405d_1_unit "1st Consultation: Approximate time after delivery did visit occur (Unit of time)"
capture label var m4_405d_2_unit "2nd Consultation: Approximate time after delivery did visit occur (Unit of time)"
capture label var m4_405d_3_unit "3rd Consultation: Approximate time after delivery did visit occur (Unit of time)"
capture label var m4_405d_4_unit "4th Consultation: Approximate time after delivery did visit occur (Unit of time)"
capture label var m4_405d_5_unit "5th Consultation: Approximate time after delivery did visit occur (Unit of time)"
capture label var m4_405d_6_unit "6th Consultation: Approximate time after delivery did visit occur (Unit of time)"

capture label var m4_consult1_len "1st Consultation: Approximately how long after delivery did visit occur"
capture label var m4_consult2_len "2nd Consultation: Approximately how long after delivery did visit occur"
capture label var m4_baby2_consult2_len "2nd Consultation:Approx time after delivery visit occurred Baby2 if differ Baby1"
capture label var m4_consult3_len "3rd Consultation: Approximately how long after delivery did visit occur"
capture label var m4_baby2_consult3_len "3rd Consultation:Approx time after delivery visit occurred Baby2 if differ Baby1"
capture label var m4_consult4_len "4th Consultation: Approximately how long after delivery did visit occur"
capture label var m4_consult5_len "5th Consultation: Approximately how long after delivery did visit occur"
capture label var m4_consult6_len "6th Consultation: Approximately how long after delivery did visit occur"


capture label var m4_412a_unit "1st Consultation: Time unit (days or weeks) after delivery for consultation"
capture label var m4_412b_unit "2nd Consultation: Time unit (days or weeks) after delivery for consultation"
capture label var m4_412c_unit "3rd Consultation: Time unit (days or weeks) after delivery for consultation"
capture label var m4_412d_unit "4th Consultation: Time unit (days or weeks) after delivery for consultation"
capture label var m4_412e_unit "5th Consultation: Time unit (days or weeks) after delivery for consultation"
capture label var m4_412f_unit "6th Consultation: Time unit (days or weeks) after delivery for consultation"

/* NK Note - here were slightly different in India so I labeled them below 
capture label var m4_413 "Since last spoke: Main reason prevented you from receiving PNC/postpartum care"
capture label var m4_413_other "Since last spoke: Other reason did not receive PNC or postpartum care specified"

capture label var m4_413a "Main reason no PNC/postpartum care: No reason or didn't need it "
capture label var m4_413b "Main reason no PNC/postpartum care: Tried but were sent away"
capture label var m4_413c "Main reason no PNC/postpartum care: High cost"
capture label var m4_413d "Main reason no PNC/postpartum care: Far distance"
capture label var m4_413e "Main reason no PNC/postpartum care: Long waiting time"
capture label var m4_413f "Main reason no PNC/postpartum care: Poor healthcare provider skills"
capture label var m4_413g "Main reason no PNC/postpartum care: Staff don't show respect"
capture label var m4_413h "Main reason no PNC/postpartum care: Medicines or equipment are not available"
capture label var m4_413i "Main reason no PNC/postpartum care: COVID-19 fear" 
capture label var m4_413j "Main reason no PNC/postpartum care: Don't know where to go/too complicated"
capture label var m4_413k "Main reason no PNC/postpartum care: Fear of discovering serious problem"
capture label var m4_413_96 "Main reason no PNC/postpartum care: Other reason "
*/ 

capture label var m4_501 "1st Consultation: Rate overall quality of care received"
capture label var m4_502 "2nd Consultation: Rate overall quality of care received"
capture label var m4_503 "3rd Consultation: Rate overall quality of care received"
capture label var m4_504 "4th Consultation: Rate overall quality of care received"
capture label var m4_505 "5th Consultation: Rate overall quality of care received"
capture label var m4_506 "6th Consultation: Rate overall quality of care received"

capture label var m4_baby1_601a "Since last spoke Baby 1: Had their temperature taken (using a thermometer)"
capture label var m4_baby2_601a "Since last spoke Baby 2: Had their temperature taken (using a thermometer)"
capture label var m4_baby3_601a "Since last spoke Baby 3: Had their temperature taken (using a thermometer)"
capture label var m4_baby1_601b "Since last spoke Baby 1: Had their weight taken (using a scale)"
capture label var m4_baby2_601b "Since last spoke Baby 2: Had their weight taken (using a scale)"
capture label var m4_baby3_601b "Since last spoke Baby 3: Had their weight taken (using a scale)"
capture label var m4_baby1_601c "Since last spoke Baby 1: Had their length measured (using a measuring tape)"
capture label var m4_baby2_601c "Since last spoke Baby 2: Had their length measured (using a measuring tape)"
capture label var m4_baby3_601c "Since last spoke Baby 3: Had their length measured (using a measuring tape)"
capture label var m4_baby1_601d "Since last spoke Baby 1: Had eyes examined"
capture label var m4_baby2_601d "Since last spoke Baby 2: Had eyes examined"
capture label var m4_baby3_601d "Since last spoke Baby 3: Had eyes examined"
capture label var m4_baby1_601e "Since last spoke Baby 1: Had hearing checked"
capture label var m4_baby2_601e "Since last spoke Baby 2: Had hearing checked"
capture label var m4_baby3_601e "Since last spoke Baby 3: Had hearing checked"
capture label var m4_baby1_601f "Since last spoke Baby 1: Had chest listened to with a stethoscope"
capture label var m4_baby2_601f "Since last spoke Baby 2: Had chest listened to with a stethoscope"
capture label var m4_baby3_601f "Since last spoke Baby 3: Had chest listened to with a stethoscope"
capture label var m4_baby1_601g "Since last spoke Baby 1: Had a blood test using a finger prick "
capture label var m4_baby2_601g "Since last spoke Baby 2: Had a blood test using a finger prick "
capture label var m4_baby3_601g "Since last spoke Baby 3: Had a blood test using a finger prick "
capture label var m4_baby1_601h "Since last spoke Baby 1: Had a malaria test"
capture label var m4_baby2_601h "Since last spoke Baby 2: Had a malaria test"
capture label var m4_baby3_601h "Since last spoke Baby 3: Had a malaria test"
capture label var m4_baby1_601i "Since last spoke Baby 1: Had any other test"
capture label var m4_baby1_601i_other "Since last spoke Baby 1: Had any other test specified"
capture label var m4_baby2_601i "Since last spoke Baby 2: Had any other test"
capture label var m4_baby2_601i_other "Since last spoke Baby 2: Had any other test specified"
capture label var m4_baby3_601i "Since last spoke Baby 3: Had any other test"
capture label var m4_baby3_601i_other "Since last spoke Baby 3: Had any other test specified"

capture label var m4_602a "Provider discussed: How often the baby/ies eats"
capture label var m4_602b "Provider discussed: What the baby/ies should eat (breastmilk/other food)"
capture label var m4_602c "Provider discussed: Vaccinations for the baby/ies"
capture label var m4_602d "Provider discussed: Baby/ies' sleeping position (on back/their stomach)"
capture label var m4_602e "Provider discussed: Dangerous symptoms in baby/ies requiring health facility"
capture label var m4_602f "Provider discussed: How you should play and interact with the baby/ies"
capture label var m4_602g "Provider discussed: Taking baby/ies to the hospital or to see a specialist"


capture label var m4_baby1_602a "Provider discussed Baby 1: How often the baby eats"
capture label var m4_baby1_602b "Provider discussed Baby 1: What the baby should eat (breastmilk/other food)"
capture label var m4_baby1_602c "Provider discussed Baby 1: Vaccinations for the baby"
capture label var m4_baby1_602d "Provider discussed Baby 1: Baby's sleeping position (on back/their stomach)"
capture label var m4_baby1_602e "Provider discussed Baby 1: Dangerous symptoms requiring health facility"
capture label var m4_baby1_602f "Provider discussed Baby 1: How you should play and interact with the baby"
capture label var m4_baby1_602g "Provider discussed Baby 1: Taking baby to the hospital or to see a specialist"

capture label var m4_baby2_602a "Provider discussed Baby 2: How often the baby eats"
capture label var m4_baby2_602b "Provider discussed Baby 2: What the baby should eat (breastmilk/other food)"
capture label var m4_baby2_602c "Provider discussed Baby 2: Vaccinations for the baby"
capture label var m4_baby2_602d "Provider discussed Baby 2: Baby's sleeping position (on back/their stomach)"
capture label var m4_baby2_602e "Provider discussed Baby 2: Dangerous symptoms requiring health facility"
capture label var m4_baby2_602f "Provider discussed Baby 2: How you should play and interact with the baby"
capture label var m4_baby2_602g "Provider discussed Baby 2: Taking baby to the hospital or to see a specialist"

capture label var m4_603a "Advise for Baby issues: Did not speak about this with provider"
capture label var m4_603b "Advise for Baby issues: Provider told you symptoms not serious, nothing to do"
capture label var m4_603c "Advise for Baby issues: Provider told you to monitor and return if worsen"
capture label var m4_603d "Advise for Baby issues:  Provider told you to get medication"
capture label var m4_603e "Advise for Baby issues: Provider gave you advice on feeding"
capture label var m4_603f "Advise for Baby issues: Provider told you to get a lab test or imaging"
capture label var m4_603g "Advise for Baby issues: Provider told you to go to hospital or see specialist"
capture label var m4_603_96 "Advise for Baby issues: Other"
capture label var m4_603_98 "Advise for Baby issues: Don't know"
capture label var m4_603_99 "Advise for Baby issues: No response/Refused to answer"
capture label var m4_603_other "Advise for Baby issues: Other specified"

capture label var m4_baby1_603a "Advise for Baby 1 issues: Did not speak about this with provider"
capture label var m4_baby1_603b "Advise for Baby 1 issues: Provider told you symptoms not serious, nothing to do"
capture label var m4_baby1_603c "Advise for Baby 1 issues: Provider told you to monitor and return if worsen"
capture label var m4_baby1_603d "Advise for Baby 1 issues:  Provider told you to get medication"
capture label var m4_baby1_603e "Advise for Baby 1 issues: Provider gave you advice on feeding"
capture label var m4_baby1_603f "Advise for Baby 1 issues: Provider told you to get a lab test or imaging"
capture label var m4_baby1_603g "Advise for Baby 1 issues: Provider told you to go to hospital or see specialist"
capture label var m4_baby1_603_96 "Advise for Baby 1 issues: Other"
capture label var m4_baby1_603_98 "Advise for Baby 1 issues: Don't know"
capture label var m4_baby1_603_99 "Advise for Baby 1 issues: No response/Refused to answer"

capture label var m4_baby1_603_other "Advise for Baby 1 issues: Other specified"
capture label var m4_baby2_603a "Advise for Baby 2 issues: Did not speak about this with provider"
capture label var m4_baby2_603b "Advise for Baby 2 issues: Provider told you symptoms not serious, nothing to do"
capture label var m4_baby2_603c "Advise for Baby 2 issues: Provider told you to monitor and return if worsen"
capture label var m4_baby2_603d "Advise for Baby 2 issues:  Provider told you to get medication"
capture label var m4_baby2_603e "Advise for Baby 2 issues: Provider gave you advice on feeding"
capture label var m4_baby2_603f "Advise for Baby 2 issues: Provider told you to get a lab test or imaging"
capture label var m4_baby2_603g "Advise for Baby 2 issues: Provider told you to go to hospital or see specialist"
capture label var m4_baby2_603_96 "Advise for Baby 2 issues: Other"
capture label var m4_baby2_603_98 "Advise for Baby 2 issues: Don't know"
capture label var m4_baby2_603_99 "Advise for Baby 2 issues: No response/Refused to answer"

capture label var m4_baby2_603_other "Advise for Baby 2 issues: Other specified"
capture label var m4_baby3_603a "Advise for Baby 3 issues: Did not speak about this with provider"
capture label var m4_baby3_603b "Advise for Baby 3 issues: Provider told you symptoms not serious, nothing to do"
capture label var m4_baby3_603c "Advise for Baby 3 issues: Provider told you to monitor and return if worsen"
capture label var m4_baby3_603d "Advise for Baby 3 issues:  Provider told you to get medication"
capture label var m4_baby3_603e "Advise for Baby 3 issues: Provider gave you advice on feeding"
capture label var m4_baby3_603f "Advise for Baby 3 issues: Provider told you to get a lab test or imaging"
capture label var m4_baby3_603g "Advise for Baby 3 issues: Provider told you to go to hospital or see specialist"
capture label var m4_baby3_603_96 "Advise for Baby 3 issues: Other"
capture label var m4_baby3_603_98 "Advise for Baby 3 issues: Don't know"
capture label var m4_baby3_603_99 "Advise for Baby 3 issues: No response/Refused to answer"
capture label var m4_baby3_603_other "Advise for Baby 3 issues: Other specified"

capture label var m4_701a "Since delivery have you had: Your blood pressure measured (cuff around arm)"
capture label var m4_701b "Since delivery have you had: Your temperature taken (with a thermometer)"
capture label var m4_701c "Since delivery have you had: A vaginal exam"
capture label var m4_701d "Since delivery have you had: A blood draw (blood taken from arm with syringe)"
capture label var m4_701e "Since delivery have you had: A blood test using a finger prick"
capture label var m4_701f "Since delivery have you had: An HIV test"
capture label var m4_701g "Since delivery have you had: A urine test (peed in a container)"
capture label var m4_701h "Since delivery have you had: Any other test or examination"
capture label var m4_701h_other "Since delivery have you had: Other test or examination specified"
capture label var m4_702 "Since delivery: Provider examined C-section scar"
capture label var m4_703a "Since delivery Provider discussed: How to take care of breasts"
capture label var m4_703b "Since delivery Provider discussed: Danger signs for self"
capture label var m4_703c "Since delivery Provider discussed: Your level of anxiety/depression"
capture label var m4_703d "Since delivery Provider discussed: Family planning options"
capture label var m4_703e "Since delivery Provider discussed: Resuming sexual activity"
capture label var m4_703f "Since delivery Provider discussed: Importance of exercise"
capture label var m4_703g "Since delivery Provider discussed: Importance sleeping under bed net"
capture label var m4_704a "Since delivery: Have you had a session of psychological counseling/therapy "
capture label var m4_704b "Since delivery: Number of psychological counseling/therapy  sessions"
capture label var m4_704c "Since delivery: Minutes each session of psychological counseling/therapy lasted"

capture label var m4_801a "Since last spoke received/bought: Iron or folic acid pills"
capture label var m4_801b "Since last spoke received/bought: Iron drip/injection"
capture label var m4_801c "Since last spoke received/bought: Calcium pills"
capture label var m4_801d "Since last spoke received/bought: Multivitamins"
capture label var m4_801e "Since last spoke received/bought: Food supplements (Super Cereal/Plumpynut)"
capture label var m4_801f "Since last spoke received/bought: Medicine for intestinal worms "
capture label var m4_801g "Since last spoke received/bought: Medicine for malaria "
capture label var m4_801h "Since last spoke received/bought: Medicine for HIV/ARVs"
capture label var m4_801i "Since last spoke received/bought: Medicine for mental health"
capture label var m4_801j "Since last spoke received/bought: Medicine for hypertension/HBP"
capture label var m4_801k "Since last spoke received/bought: Medicine for diabetes"
capture label var m4_801l "Since last spoke received/bought: Antibiotics for an infection"
capture label var m4_801m "Since last spoke received/bought: Aspirin"
capture label var m4_801n "Since last spoke received/bought: Paracetamol, or other pain relief drugs"
capture label var m4_801o "Since last spoke received/bought: Contraceptive pills"
capture label var m4_801p "Since last spoke received/bought: Contraceptive injection"
capture label var m4_801q "Since last spoke received/bought: Other contraception method-not pills/injection"
capture label var m4_801r "Since last spoke received/bought: Any other medicine or supplement"
capture label var m4_801r_other "Since last spoke received/bought: Any other medicine or supplement specified"

capture label var m4_802a "Since last spoke Baby 1 received: Iron supplements"
capture label var m4_802b "Since last spoke Baby 1 received: Vitamin A supplements"
capture label var m4_802c "Since last spoke Baby 1 received: Vitamin D supplements"
capture label var m4_802d "Since last spoke Baby 1 received: Oral rehydration salts (ORS)"
capture label var m4_802e "Since last spoke Baby 1 received: Antidiarrheal"
capture label var m4_802f "Since last spoke Baby 1 received: Antibiotics for an infection"
capture label var m4_802g "Since last spoke Baby 1 received: Medicine to prevent pneumonia"
capture label var m4_802h "Since last spoke Baby 1 received: Medicine for malaria"
capture label var m4_802i "Since last spoke Baby 1 received: Medicine for HIV/ARVs"
capture label var m4_802j "Since last spoke Baby 1 received: Any other medicine or supplement"
capture label var m4_802j_other "Since last spoke Baby 1 received: Any other medicine or supplement specified"


capture label var m4_baby1_802a "Since last spoke Baby 1 received: Iron supplements"
capture label var m4_baby2_802a "Since last spoke Baby 2 received: Iron supplements"
capture label var m4_baby3_802a "Since last spoke Baby 3 received: Iron supplements"
capture label var m4_baby1_802b "Since last spoke Baby 1 received: Vitamin A supplements"
capture label var m4_baby2_802b "Since last spoke Baby 2 received: Vitamin A supplements"
capture label var m4_baby3_802b "Since last spoke Baby 3 received: Vitamin A supplements"
capture label var m4_baby1_802c "Since last spoke Baby 1 received: Vitamin D supplements"
capture label var m4_baby2_802c "Since last spoke Baby 2 received: Vitamin D supplements"
capture label var m4_baby3_802c "Since last spoke Baby 3 received: Vitamin D supplements"
capture label var m4_baby1_802d "Since last spoke Baby 1 received: Oral rehydration salts (ORS)"
capture label var m4_baby2_802d "Since last spoke Baby 2 received: Oral rehydration salts (ORS)"
capture label var m4_baby3_802d "Since last spoke Baby 3 received: Oral rehydration salts (ORS)"
capture label var m4_baby1_802e "Since last spoke Baby 1 received: Antidiarrheal"
capture label var m4_baby2_802e "Since last spoke Baby 2 received: Antidiarrheal"
capture label var m4_baby3_802e "Since last spoke Baby 3 received: Antidiarrheal"
capture label var m4_baby1_802f "Since last spoke Baby 1 received: Antibiotics for an infection"
capture label var m4_baby2_802f "Since last spoke Baby 2 received: Antibiotics for an infection"
capture label var m4_baby3_802f "Since last spoke Baby 3 received: Antibiotics for an infection"
capture label var m4_baby1_802g "Since last spoke Baby 1 received: Medicine to prevent pneumonia"
capture label var m4_baby2_802g "Since last spoke Baby 2 received: Medicine to prevent pneumonia"
capture label var m4_baby3_802g "Since last spoke Baby 3 received: Medicine to prevent pneumonia"
capture label var m4_baby1_802h "Since last spoke Baby 1 received: Medicine for malaria"
capture label var m4_baby2_802h "Since last spoke Baby 2 received: Medicine for malaria"
capture label var m4_baby3_802h "Since last spoke Baby 3 received: Medicine for malaria"
capture label var m4_baby1_802i "Since last spoke Baby 1 received: Medicine for HIV/ARVs"
capture label var m4_baby2_802i "Since last spoke Baby 2 received: Medicine for HIV/ARVs"
capture label var m4_baby3_802i "Since last spoke Baby 3 received: Medicine for HIV/ARVs"
capture label var m4_baby1_802j "Since last spoke Baby 1 received: Any other medicine or supplement"
capture label var m4_baby1_802j_other "Since last spoke Baby 2 received: Any other medicine or supplement specified"
capture label var m4_baby2_802j "Since last spoke Baby 3 received: Any other medicine or supplement"
capture label var m4_baby2_802j_other "Since last spoke Baby 1 received: Any other medicine or supplement specified"
capture label var m4_baby3_802j "Since last spoke Baby 2 received: Any other medicine or supplement"
capture label var m4_baby3_802j_other "Since last spoke Baby 3 received: Any other medicine or supplement specified"

capture label var m4_803a "Baby/ies received: BCG vaccine (against TB - injection in arm can cause scar)"
capture label var m4_803b "Baby/ies received: Polio vaccine (Either two drops orally or injection)"
capture label var m4_803c "Baby/ies received: Pentavalent vaccination (Injection in the thigh)"
capture label var m4_803d "Baby/ies received: Pneumococcal vaccination (Injection in thigh-prevent pneumonia)"
capture label var m4_803e "Baby/ies received: Rotavirus vaccination (liquid in the mouth to prevent diarrhea)"
capture label var m4_803f "Baby/ies received: Any other vaccines or immunizations"
capture label var m4_803g "Baby/ies received: Any other vaccines or immunizations specified"
capture label var m4_804 "Baby/ies: Where did they  get these vaccines?"

capture label var m4_baby1_803a "Baby 1 received: BCG vaccine (against TB - injection in arm can cause scar)"
capture label var m4_baby2_803a "Baby 2 received: BCG vaccine (against TB - injection in arm can cause scar)"
capture label var m4_baby3_803a "Baby 3 received: BCG vaccine (against TB - injection in arm can cause scar)"
capture label var m4_baby1_803b "Baby 1 received: Polio vaccine (Either two drops orally or injection)"
capture label var m4_baby2_803b "Baby 2 received: Polio vaccine (Either two drops orally or injection)"
capture label var m4_baby3_803b "Baby 3 received: Polio vaccine (Either two drops orally or injection)"
capture label var m4_baby1_803c "Baby 1 received: Pentavalent vaccination (Injection in the thigh)"
capture label var m4_baby2_803c "Baby 2 received: Pentavalent vaccination (Injection in the thigh)"
capture label var m4_baby3_803c "Baby 3 received: Pentavalent vaccination (Injection in the thigh)"
capture label var m4_baby1_803d "Baby 1 received: Pneumococcal vaccination (Injection in thigh-prevent pneumonia)"
capture label var m4_baby2_803d "Baby 2 received: Pneumococcal vaccination (Injection in thigh-prevent pneumonia)"
capture label var m4_baby3_803d "Baby 3 received: Pneumococcal vaccination (Injection in thigh-prevent pneumonia)"
capture label var m4_baby1_803e "Baby 1 received: Rotavirus vaccination (liquid in the mouth to prevent diarrhea)"
capture label var m4_baby2_803e "Baby 2 received: Rotavirus vaccination (liquid in the mouth to prevent diarrhea)"
capture label var m4_baby3_803e "Baby 3 received: Rotavirus vaccination (liquid in the mouth to prevent diarrhea)"
capture label var m4_baby1_803f "Baby 1 received: Any other vaccines or immunizations"
capture label var m4_baby2_803f "Baby 2 received: Any other vaccines or immunizations"
capture label var m4_baby3_803f "Baby 3 received: Any other vaccines or immunizations"
capture label var m4_baby1_803g "Baby 1 received: Any other vaccines or immunizations specified"
capture label var m4_baby2_803g "Baby 2 received: Any other vaccines or immunizations specified"
capture label var m4_baby3_803g "Baby 3 received: Any other vaccines or immunizations specified"
capture label var m4_baby1_804 "Baby 1: Where did they  get these vaccines?"
capture label var m4_baby2_804 "Baby 2: Where did they  get these vaccines?"
capture label var m4_baby3_804 "Baby 3: Where did they  get these vaccines?"
capture label var m4_804_other "Where did they  get these vaccines: Other specified"
capture label var m4_805 "Total amount paid for new meications or supplements for self/baby(ies)"

capture label var m4_901 "Paid money out of pocket for new visits"
capture label var m4_902a_amt "Amount spent on: Registration/consultation"
capture label var m4_902a "Spent money on: Registration/consultation"
capture label var m4_902b_amt "Amount spent on: Test or investigations (lab tests, ultrasound etc.)"
capture label var m4_902b "Spent money on: Test or investigations (lab tests, ultrasound etc.)"
capture label var m4_902c_amt "Amount spent on: Transport round trip (+ accompanying person)"
capture label var m4_902c "Spent money on: Transport round trip (+ accompanying person)"
capture label var m4_902d_amt "Amount spent on: Food /accommodation (+ accompanying person)"
capture label var m4_902d "Spent money on: Food /accommodation (+ accompanying person)"
capture label var m4_902e_amt "Amount spent on: Other service or product"
capture label var m4_902e "Spent money on: Other service or product"
capture label var m4_902e_oth "Amount spent on: Other service or product specified "
capture label var m4_902_total_spent "Total amount spent on services and products"
capture label var m4_903 "Confirm total amount spent is correct"
capture label var m4_904 "Correct total amount spent"
capture label var m4_905a "Financial source used: Current income of any household members"
capture label var m4_905b "Financial source used: Savings (bank account)"
capture label var m4_905c "Financial source used: Payment/reimbursement from health insurance"
capture label var m4_905d "Financial source used: Sold items (furniture, animals, jewellery)"
capture label var m4_905e "Financial source used: Family members/friends outside household"
capture label var m4_905f "Financial source used: Borrowed (other than friend or family)"
capture label var m4_905g "Financial source used: Other"
capture label var m4_905_96 "Financial source used: Other"
capture label var m4_905_other "Financial source used: Other specified"

capture label var m4_duration "Duration of interview"
capture label var m4_language "Language of survey"
capture label var m4_language_oth "Language of survey: Other"

capture label var m4_meet_for_m5 "Possible to meet next month for M5"
capture label var m4_meet_for_m5_date "Meet up next month for M5: Date "
capture label var m4_meet_for_m5_time_of_day "Meet up next month for M5: Time of day "
capture label var m4_meet_for_m5_location "Meet up next month for M5: Location "


lab var country "Country"
lab var m4_baby1_feed_a_g "Baby 1: how fed a-g"
lab var m4_baby2_feed_a_g "Baby 2: how fed a-g"
lab var m4_baby1_deathage_wks "Baby 1: death age (weeks)"
lab var m4_baby1_deathage_dys "Baby 1: death age (days)"
lab var m4_403a_name "Since last spoke: Location of 1st new consultation - name"
lab var m4_403b_name "Since last spoke: Location of 2nd new consultation - name"
lab var m4_403c_name "Since last spoke: Location of 3rd new consultation - name"
lab var m4_404a_name "Since last spoke: Facility name for 1st consultation: Other specified"
lab var m4_404b_name "Since last spoke: Facility name for 2nd consultation: Other specified"
lab var m4_404c_name "Since last spoke: Facility name for 3rd consultation: Other specified"
lab var m4_baby1_411a "1st Consultation: Date"
lab var m4_consult1_len_wks "1st Consultation: Approximately how long after delivery did visit occur - weeks"
lab var m4_consult1_len_dys "1st Consultation: Approximately how long after delivery did visit occur - days"
lab var m4_baby1_411b "2nd Consultation: Date"
lab var m4_consult2_len_wks "2nd Consultation: Approximately how long after delivery did visit occur - weeks"
lab var m4_consult2_len_dys "2nd Consultation: Approximately how long after delivery did visit occur - days"
lab var m4_baby1_411c "3rd Consultation: Date"
lab var m4_consult3_len_wks "3rd Consultation: Approximately how long after delivery did visit occur - weeks"
lab var m4_consult3_len_dys "3rd Consultation: Approximately how long after delivery did visit occur - days"

label var m4_413a "Main reason no PNC/postpartum care: No reason or didn't need it "
label var m4_413b "Main reason no PNC/postpartum care: Tried but were sent away"
label var m4_413c "Main reason no PNC/postpartum care: High cost"
label var m4_413d "Main reason no PNC/postpartum care: Far distance"
label var m4_413e "Main reason no PNC/postpartum care: Long waiting time"
label var m4_413f "Main reason no PNC/postpartum care: Poor healthcare provider skills"
label var m4_413g "Main reason no PNC/postpartum care: Staff don't show respect"
label var m4_413h "Main reason no PNC/postpartum care: Medicines or equipment are not available"
label var m4_413i "Main reason no PNC/postpartum care: COVID-19 restrictions" 
label var m4_413j "Main reason no PNC/postpartum care: COVID-19 fear " 
label var m4_413k "Main reason no PNC/postpartum care: Don't know where to go/too complicated"
label var m4_413l "Main reason no PNC/postpartum care: Fear of discovering serious problem"
label var m4_413_96 "Main reason no PNC/postpartum care: Other reason "
label var m4_413_99 "Main reason no PNC/postpartum care: Refused"
label var m4_413_other "Main reason no PNC/postpartum care: Other"

lab var m4_603_a_0 
lab var m4_603_a_1 
lab var m4_603_a_2 
lab var m4_603_a_3 
lab var m4_603_a_4 
lab var m4_603_a_5 
lab var m4_603_a_6 
lab var m4_603_a_96 
lab var m4_603_a_98 
lab var m4_603_a_99 
lab var m4_603_a_other 
lab var m4_603_b_0 
lab var m4_603_b_1 
lab var m4_603_b_2 
lab var m4_603_b_3 
lab var m4_603_b_4 
lab var m4_603_b_5
lab var m4_603_b_6 
lab var m4_603_b_96 
lab var m4_603_b_98 
lab var m4_603_b_99 
lab var m4_603_b_other 
lab var m4_603_c_0 
lab var m4_603_c_1 
lab var m4_603_c_2 
lab var m4_603_c_3 
lab var m4_603_c_4 
lab var m4_603_c_5 
lab var m4_603_c_6 
lab var m4_603_c_96 
lab var m4_603_c_98 
lab var m4_603_c_99 
lab var m4_603_c_other 
lab var m4_603_d_0 
lab var m4_603_d_1 
lab var m4_603_d_2 
lab var m4_603_d_3 
lab var m4_603_d_4 
lab var m4_603_d_5 
lab var m4_603_d_6 
lab var m4_603_d_96 
lab var m4_603_d_98 
lab var m4_603_d_99 
lab var m4_603_d_other 
lab var m4_603_e_0
lab var m4_603_e_1 
lab var m4_603_e_2 
lab var m4_603_e_3 
lab var m4_603_e_4 
lab var m4_603_e_5 
lab var m4_603_e_6 
lab var m4_603_e_96 
lab var m4_603_e_98 
lab var m4_603_e_99 
lab var m4_603_e_other 
lab var m4_603_f_0
lab var m4_603_f_1 
lab var m4_603_f_2 
lab var m4_603_f_3 
lab var m4_603_f_4 
lab var m4_603_f_5 
lab var m4_603_f_6 
lab var m4_603_f_96 
lab var m4_603_f_98 
lab var m4_603_f_99 
lab var m4_603_f_other 
lab var m4_603_g_0 
lab var m4_603_g_1 
lab var m4_603_g_2 
lab var m4_603_g_3 
lab var m4_603_g_4 
lab var m4_603_g_5 
lab var m4_603_g_6 
lab var m4_603_g_96 
lab var m4_603_g_98 
lab var m4_603_g_99 
lab var m4_603_g_other 
lab var m4_603_h_0 
lab var m4_603_h_1 
lab var m4_603_h_2 
lab var m4_603_h_3 
lab var m4_603_h_4 
lab var m4_603_h_5 
lab var m4_603_h_6 
lab var m4_603_h_96 
lab var m4_603_h_98 
lab var m4_603_h_99 
lab var m4_603_h_other 
lab var m4_603_i_0 
lab var m4_603_i_1 
lab var m4_603_i_2 
lab var m4_603_i_3 
lab var m4_603_i_4 
lab var m4_603_i_5 
lab var m4_603_i_6 
lab var m4_603_i_96 
lab var m4_603_i_98 
lab var m4_603_i_99 
lab var m4_603_i_other 
lab var m4_603_j_0 
lab var m4_603_j_1 
lab var m4_603_j_2 
lab var m4_603_j_3 
lab var m4_603_j_4 
lab var m4_603_j_5 
lab var m4_603_j_6 
lab var m4_603_j_96 
lab var m4_603_j_98 
lab var m4_603_j_99 
lab var m4_603_j_other

lab var m4_905 "Financial source used"

*===============================================================================
* NK note - this is copied over from crECO_cln_IN_M3
	
rename m4_respondentid respondentid
	* confirm there is 1 row per respondent
bysort respondentid: assert _N == 1
*replace respondentid = trim(respondentid)

tempfile mkt
save `mkt'

use "${in_data_final}/eco_IN_Complete.dta"
*merge 1:1 respondentid using "${in_data_final}\eco_m1_and_m2_in.dta"
bysort respondentid: assert _N == 1 // NK added
destring respondentid, replace
merge 1:1 respondentid using  `mkt'

* all those from M3 should be in M1
*assertlist _merge != 2, list(respondentid) 

rename _merge merge_m4_to_m3_m2_m1 
label var merge_m4_to_m3_m2_m1 "Match between M4 dataset and M1 and M2 dataset"
label define m4 1 "M1-3 Only" 2 "M4 only" 3 "Both M1-3 & M4"
label value merge_m4_to_m3_m2_m1 m4

* We want to drop those that do not merge back to main dataset
* Per India team these 3 ids should not be included
/*202307181044030109 
202311171131039696 
202311201424039696 
202311212018039696
*/

*drop if merge_m3_to_m2_m1 == 2 // this is 3 ids

*save "${in_data_final}/eco_m1_m2_m3_in.dta", replace

order respondentid country
save "$in_data_final/eco_IN_Complete_0411.dta", replace

* NK NOTE - HIV Status doesn't seem to match ??? 

/*

rename MOD4_END_B1 m4_meet_for_m5	
replace MOD4_END_B1_DATE = subinstr(MOD4_END_B1_DATE,"-23","2023",.)
replace MOD4_END_B1_DATE = subinstr(MOD4_END_B1_DATE,"-24","2024",.)
replace MOD4_END_B1_DATE = subinstr(MOD4_END_B1_DATE,"-","",.)
gen m4_meet_for_m5_date	 = date(MOD4_END_B1_DATE,"DMY")
char m4_meet_for_m5_date[Module] 4
char m4_meet_for_m5_date[Original_ZA_Varname] `MOD4_END_B1_DATE[Original_ZA_Varname]'

format %td  m4_meet_for_m5_date

replace m4_meet_for_m5_date = .d if MOD4_END_B1_DATE == ".d"
replace m4_meet_for_m5_date = .a if MOD4_END_B1_DATE == ".a"

rename MOD4_END_B2_TIME m4_meet_for_m5_time_of_day	
rename MOD4_END_B2_LOCATION m4_meet_for_m5_location	

rename RESPONSE_FIELDWORKERID m4_interviewer_id
rename RESPONSE_FIELDWORKER m4_interviewer

* We can drop all of the questionnaire data
drop RESPONSE_QUESTIONNAIREID RESPONSE_QUESTIONNAIRENAME RESPONSE_QUESTIONNAIREVERSION  RESPONSE_STARTTIME RESPONSE_LOCATION RESPONSE_LATTITUDE RESPONSE_LONGITUDE RESPONSE_STUDYNOPREFIX RESPONSE_STUDYNO STUDYNUMBER RESPONSEID MOD4_END_B1_DATE


**********************************
**********************************

* clean up the respondent id

replace m4_respondentid = trim(m4_respondentid)
replace m4_respondentid = subinstr(m4_respondentid," ","",.)


*****************************
*****************************

* Create value labels for M4 

	label define m4_yes_no_dnk_nr 0 "No" 1 "Yes", replace // 98 "Don't Know" 99 "No Response/Refused to answer", replace
	label value  m4_baby1_feed_a m4_baby1_feed_b m4_baby1_feed_c m4_baby1_feed_d m4_baby1_feed_e m4_baby1_feed_f m4_baby1_feed_g m4_baby1_feed_rf m4_baby2_feed_a m4_baby2_feed_b m4_baby2_feed_c m4_baby2_feed_d m4_baby2_feed_e m4_baby2_feed_f m4_baby2_feed_g m4_baby2_feed_rf  ///
	m4_baby1_diarrhea m4_baby2_diarrhea m4_baby1_fever m4_baby2_fever m4_baby1_lowtemp m4_baby2_lowtemp m4_baby1_illness m4_baby2_illness m4_baby1_troublebreath m4_baby2_troublebreath m4_baby1_chestprob m4_baby2_chestprob m4_baby1_troublefeed m4_baby2_troublefeed m4_baby1_convulsions m4_baby2_convulsions m4_baby1_jaundice m4_baby2_jaundice m4_baby1_yellowpalms m4_baby2_yellowpalms m4_baby1_otherprob m4_baby2_otherprob ///
	m4_baby1_advice m4_baby2_advice ///
	m4_401a ///
	m4_405a m4_405a_1 m4_405a_2 m4_405a_3 m4_405a_4 m4_405a_5 m4_405a_6 m4_405a_7 m4_405a_8 m4_405a_9 m4_405a_10 m4_405a_96  ///
	m4_405b m4_405b_1 m4_405b_2 m4_405b_3 m4_405b_4 m4_405b_5 m4_405b_6 m4_405b_7 m4_405b_8 m4_405b_9 m4_405b_10 m4_405b_96 ///
	m4_405c m4_405c_1 m4_405c_2 m4_405c_3 m4_405c_4 m4_405c_5 m4_405c_6 m4_405c_7 m4_405c_8 m4_405c_9 m4_405c_10 m4_405c_96 ///
	m4_baby1_601a m4_baby2_601a m4_baby1_601b m4_baby2_601b m4_baby1_601c m4_baby2_601c m4_baby1_601d m4_baby2_601d m4_baby1_601e m4_baby2_601e m4_baby1_601f m4_baby2_601f m4_baby1_601g m4_baby2_601g m4_baby1_601h m4_baby2_601h m4_baby1_601i m4_baby2_601i ///
	m4_602a m4_602b m4_602c m4_602d m4_602e m4_602f m4_602g ///
	m4_603a m4_603b m4_603c m4_603d m4_603e m4_603f m4_603g m4_603_96 m4_603_98 m4_603_99 ///
	m4_701a m4_701b m4_701c m4_701d m4_701e m4_701f m4_701g m4_701h ///
	m4_702 m4_703a m4_703b m4_703c m4_703d m4_703e m4_703f m4_703g m4_704a ///
	m4_801a m4_801b m4_801c m4_801d m4_801e m4_801f m4_801g m4_801h m4_801i m4_801j m4_801k m4_801l m4_801m m4_801n m4_801o m4_801p m4_801q m4_801r ///
	m4_802a m4_802b m4_802c m4_802d m4_802e m4_802f m4_802g m4_802h m4_802i m4_802j ///
	m4_803a m4_803b m4_803c m4_803d m4_803e m4_803f ///
	m4_901 ///
	m4_905a m4_905b m4_905c m4_905d m4_905e m4_905f m4_905g ///
	m4_yes_no_dnk_nr
	
	
	label define m4_hiv 1 "Positive" 2 "Negative", replace // 98 "Don't Know" 99 "No Response/Refused to answer", replace
	label value m4_hiv_status m4_hiv

	label define m4_yesno 0 "No" 1 "Yes", replace
	label value m4_permission m4_c_section m4_maternal_death_reported ///
	m4_305 m4_308 ///
	m4_903 ///
	m4_meet_for_m5 ///
	m4_yesno
	
	label define m4_alive 1 "Alive" 0 "Died" 95 "Not applicable", replace
	label value m4_baby1_status m4_baby2_status m4_alive 
	
	label define m4_rate 1 "Excellent" 2 "Very Good" 3 "Good" 4 "Fair" 5 "Poor", replace // 98 "Don't know" 99 "No Response/Refused to answer", replace
	label value m4_baby1_health m4_baby2_health m4_301 ///
	m4_501 m4_502 m4_503 ///
	m4_rate
	
	label define m4_confidence 1 "Not at all confident" 2 "Not very confident" 3 "Somewhat confident" 4 "Confident" 5 "Very confident" 96 "I do not breastfeed" 99 "No Response/Refused to answer", replace
	label value m4_breastfeeding m4_confidence
	
	label define m4_sleep 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" 4 "Severely disturbed sleep", replace
	label value m4_baby1_sleep m4_baby2_sleep m4_sleep
	
	label define m4_feeding 1 "Normal feeding" 2 "Slight feeding problems" 3 "Moderate feeding problems" 4 "Severe feeding problems", replace
	label value m4_baby1_feed m4_baby2_feed m4_feeding
	
	label define m4_breathing 1 "Normal breathing" 2 "Slight breathing problems" 3 "Moderate breathing problems" 4 "Severe breathing problems", replace
	label value m4_baby1_breath m4_baby2_breath m4_breathing
	
	label define m4_stool 1 "Normal stooling/poo" 2 "Slight stooling/poo problems" 3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems", replace
	label value m4_baby1_stool m4_baby2_stool m4_stool 
	
	label define m4_mood 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying", replace
	label value m4_baby1_mood m4_baby2_mood m4_mood
	
	label define m4_skin 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin" 4 "Bleeding or cracked skin" , replace
	label value m4_baby1_skin m4_baby2_skin m4_skin
	
	label define m4_activity 1 "Highly playful/interactive" 2 "Playful/interactive" 3 "Less playful/less interactive" 4 "Low energy/inactive/dull", replace
	label value m4_baby1_interactivity m4_baby2_interactivity m4_activity
	
	label define m4_death_location 1 "In a health facility" 2 "On the way to the health facility" 3 "Your house or someone else's house" 4 "Other, please specify", replace // 98 "Don't know" 99 "No response/Refused to answer", replace
	label value m4_baby1_death_loc m4_baby2_death_loc m4_death_location
	
	label define m4_days 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" 3 "Nearly every day" 99 "No Response/Refused to answer", replace
	label value m4_302a m4_302b m4_days
	
	label define m4_feelings 1 "Very much" 2 "A lot" 3 "A little" 4 "Not at all", replace // 98 "Don't Know" 99 "No Response/Refused to answer", replace
	label value m4_303a m4_303b m4_303c m4_303d m4_303e m4_303f m4_303g m4_303h m4_feelings
	
	label define m4_sex_sat 0 "Have not had sex" 1 "Not at all" 2 "A little bit" 3 "Somewhat" 4 "Quite a bit" 5 "Very much", replace // 98 "Don't know" 99 "No Response/Refused to answer", replace
	label value m4_304 m4_sex_sat
	
	label define m4_frequency 0 "Never" 1 "Less than once/month" 2 "Less than once/week" 3 "Less than once/day" 4 "Once a day or more thanonce a day", replace
	label value m4_307 m4_frequency
	
	label define m4_no_trt_rsn 1 "Do not know it can be fixed"  2 "You tried but were sent away (e.g., no appointment available)" 3 "High cost (e.g., high out of pocket payment, not covered by insurance)" 4 "Far distance (e.g., too far to walk or drive, transport not readily available)" 5 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 6 "Staff don't show respect (e.g., staff is rude, impolite, dismissive)" 7 "Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)" 8 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)" 9 "COVID-19 fear" 10 "Don't know where to go/too complicated" 11 "Could not get permission" 12 "Embarrassment" 13 "Problem disappeared" 96 "Other (specify)" 99 "No Response/Refused to answer", replace
	label value m4_309 m4_no_trt_rsn
	
	label define m4_trt_worked 1 "Yes, no more leakage at all" 2 "Yes,but still some leakage" 3 " No, still have problem" 99 "No Response/Refused to answer", replace
	label value  m4_310 m4_trt_worked
	
	label define m4_location 1 "In your home" 2 "Someone else's home" 3 "Public clinic" 4 "Public hospital" 5 "Private clinic" 6 "Private hospital" 7 "Public Community health center" 8 "Other", replace // 98 "Don't know" 99 "No Response/Refused to answer", replace
	label value m4_403a m4_403b m4_403c m4_baby2_403b m4_baby2_403c m4_location
		
	label define m4_rsn_not_pnc 0 "No reason or the baby and I didn't need it" 1 "You tried but were sent away (e.g., no appointment available)" 2 "High cost (e.g., high out of pocket payment, not covered by insurance" 3 "Far distance (e.g., too far to walk or drive, transport not readily available)" 4 "Long waiting time (e.g., long line to access facility, long wait for the provider)" 5 "Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)" 6 "Staff don't show respect (e.g., staff is rude, impolite, dismissive)" 7 "Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines  broken or unavailable)" 8 "COVID-19 restrictions (e.g., lockdowns, travel restrictions, curfews)" 9 "COVID-19 fear" 10 "Don't know where to go/too complicated" 11 "Fear of discovering serious problem" 96 "Other (specify)" 99 "No Response/Refused to answer", replace
	label value m4_413 m4_rsn_not_pnc 
	
	label define m4_loc_vx 1 "At home" 2 "At a facility" 3 "At another location", replace
	label value m4_804 m4_loc_vx
	
	label define m4_meet_time 1 "Morning" 2 "Midday" 3 "Afternoon", replace
	label value m4_meet_for_m5_time_of_day m4_meet_time
		
	
********************************************************************************
********************************************************************************
* RECODE 
foreach v of varlist * {
	capture recode `v' (. = .a) if m4_permission != 1
	capture replace `v' =".a" if m4_permission != 1 & missing(`v')
}

recode m4_date_of_maternal_death m4_maternal_death_learn m4_maternal_death_learn_other (. = .a) if m4_maternal_death_reported != 1
*replace  = ".a" if m4_maternal_death_reported != 1

forvalues i = 1/2 {
	replace m4_baby`i'_other = ".a" if missing(m4_baby`i'_other) & m4_baby`i'_otherprob != 1  
	*replace m4_baby`i'_210_other = ".a" if missing(m4_baby`i'_210_other) & (m4_baby`i'_210 != 96 | m4_baby`i'_status == 1)	 
	recode  m4_baby`i'_210_other (. = .a) if m4_baby`i'_210 != 96 | m4_baby`i'_status == 1
	*replace m4_baby1_601i_other = ".a" if missing(m4_baby1_601i_other) & m4_baby1_601i != 1 
	recode  m4_baby1_601i_other (. = .a) if m4_baby1_601i != 1 
	
	recode m4_baby`i'_death_date m4_baby`i'_deathage m4_baby`i'_advice m4_baby`i'_death_loc (. = .a) if m4_baby`i'_status == 1
	
	recode m4_baby`i'_601a m4_baby`i'_601b m4_baby`i'_601c m4_baby`i'_601d m4_baby`i'_601e m4_baby`i'_601f m4_baby`i'_601g m4_baby`i'_601h m4_baby`i'_601i (. 95 = .a) if m4_live_babies < `i'
}

replace m4_603_other = ".a" if missing(m4_603_other) & m4_603_96 != 1
replace m4_701h_other = ".a" if missing(m4_701h_other) & m4_701h != 1
replace m4_801r_other = ".a" if missing(m4_801r_other) & m4_801r != 1
replace m4_802j_other = ".a" if missing(m4_802j_other) & m4_802j != 1  
replace m4_803g = ".a" if missing(m4_803g) & m4_803f != 1
replace m4_905_other = ".a" if missing(m4_905_other) & m4_905g != 1
  
	recode m4_306 m4_307 m4_308 m4_309 m4_310 (. = .a) if m4_305 != 1
	recode m4_309 m4_310 (. = .a) if m4_308 != 1
	replace m4_309_other = ".a" if missing(m4_309_other) & (m4_308 != 1 | m4_309 != 96)
	
	recode m4_402 (. = -1) if m4_401 != 1
	local n 1
	foreach v in a b c {
		recode m4_403`v' m4_411`v'  (95 . = .a) if m4_402 < `n'
		recode m4_consult`n'_len (. = .a) if m4_402 < `n'
		
		replace m4_404`v'  = ".a" if missing(m4_404`v') & (inlist(m4_403`v',1,2)  | m4_402 < `n')
		
		if "`v'" != "a" replace m4_baby2_404`v' = ".a" if missing(m4_baby2_404`v') & inlist(m4_403`v',1,2) & missing(m4_baby2_403`v') 
		if "`v'" != "a" replace m4_baby2_404`v' = ".a" if missing(m4_baby2_404`v') & inlist(m4_baby2_403`v',1,2)
		if "`v'" == "a" replace m4_baby2_404`v' = ".a" if missing(m4_baby2_404`v') & inlist(m4_403`v',1,2)
		replace m4_baby2_404`v' = ".a" if m4_402 < `n'
		
		
		replace m4_405`v'_other = ".a" if missing(m4_405`v'_other) & m4_405`v'_96 != 1 
		
		recode m4_405`v'_1 m4_405`v'_2 m4_405`v'_3 m4_405`v'_4 m4_405`v'_5 m4_405`v'_6 m4_405`v'_7 m4_405`v'_8 m4_405`v'_9 m4_405`v'_10 m4_405`v'_96 (. = .a) if m4_405`v' == 1 | m4_402 < `n'
		
		
		recode m4_50`n' (95 . = .a) if m4_402 < `n'
		local ++n
	}
	
	recode m4_413 (. = .a) if m4_402 >= 1
	replace m4_413_other = ".a" if missing(m4_413_other) & m4_413 != 96
	
	local n 1
	foreach v in a b c {
		foreach var in m4_403`v' m4_405`v' m4_405`v'_1 m4_405`v'_10 m4_405`v'_2 m4_405`v'_3 m4_405`v'_4 m4_405`v'_5 m4_405`v'_6 m4_405`v'_7 m4_405`v'_8 m4_405`v'_9 m4_405`v'_96  m4_411`v'   m4_consult`n'_len {
			recode `var' (. 95 = .a) if m4_402 < `n'
		}
		foreach var in m4_baby2_404`v' m4_405`v'_other m4_404`v' {
			replace `var' = ".a" if missing(`var') & m4_402 < `n'
		}
		recode m4_50`n' (. 95 = .a) if m4_402 < `n'
		local ++n
	}
	
	
	foreach v in m4_baby2_name m4_baby2_status m4_baby2_health m4_baby2_feed_a m4_baby2_feed_b m4_baby2_feed_c m4_baby2_feed_d m4_baby2_feed_e m4_baby2_feed_f m4_baby2_feed_g m4_baby2_feed_rf m4_baby2_sleep m4_baby2_feed m4_baby2_breath m4_baby2_stool m4_baby2_mood m4_baby2_skin m4_baby2_interactivity m4_baby2_diarrhea m4_baby2_fever m4_baby2_lowtemp m4_baby2_illness m4_baby2_troublebreath m4_baby2_chestprob m4_baby2_troublefeed m4_baby2_convulsions m4_baby2_jaundice m4_baby2_yellowpalms m4_baby2_otherprob m4_baby2_other m4_baby2_death_date m4_baby2_deathage m4_baby2_210 m4_baby2_210_other m4_baby2_advice m4_baby2_death_loc m4_baby2_404a m4_baby2_403b m4_baby2_404b m4_baby2_consult2_len m4_baby2_403c m4_baby2_404c m4_baby2_411c m4_baby2_consult3_len m4_baby2_601a m4_baby2_601b m4_baby2_601c m4_baby2_601d m4_baby2_601e m4_baby2_601f m4_baby2_601g m4_baby2_601h m4_baby2_601i m4_baby2_601i_other {

	
	capture recode `v' (95 . = .a) if m4_live_babies < 2 | missing(m4_live_babies)
	capture replace `v' = ".a" if missing(`v') & (m4_live_babies < 2 | missing(m4_live_babies))
}
	
	recode m4_402 (-1 = .a) if m4_401 != 1
	
	recode m4_704b m4_704c (. = .a) if m4_704a != 1
	recode m4_902a_amt m4_902b_amt m4_902c_amt m4_902d_amt  m4_902e_amt m4_902_total_spent m4_903 m4_904 m4_905a m4_905b m4_905c m4_905d m4_905e m4_905f m4_905g (. = .a) if m4_901 ==0
	replace m4_902e_oth = ".a" if missing(m4_902e_oth) & m4_901 ==0
	recode m4_904 (. = .a) if m4_903 == 1
	
	
	* Replace all the dnk and nr
	foreach v of varlist * {
		capture confirm numeric var `v'
		if _rc == 0 {
			recode `v' (98 = .d)
			recode `v' (99 = .r)
		}
	}
	
*******************************************************************************
*******************************************************************************
*******************************************************************************
* Do a little more cleanup and checks before merging
	* Confirm that the response id is unique
	bysort m4_respondentid : gen n = _N 
	keep if n == 1
	drop n
	
	* Per previous cleanups make the below changes to respondent ids
	replace m4_respondentid = "MND-011" if m4_respondentid == "MND_011"
	replace m4_respondentid = "MND-012" if m4_respondentid == "MND_012"
	replace m4_respondentid = "NEL_021" if m4_respondentid == "NEL-021"
	
	* Now merge with the M1- M3
	rename m4_respondentid respondentid
	
	*dropping these per previous modules
	drop if inlist(respondentid, "MPH_015","QEE_109","UUT_014")
	save "$za_data_final/eco_m4_za.dta", replace	
	
	assertlist !missing(m4_baby1_status) if m4_permission == 1, list(respondentid m4_baby1_status)
	assertlist !missing(m4_301) if m4_permission == 1, list(respondentid m4_301)
	assertlist missing(m4_306) if m4_305 != 1, list(respondentid m4_306 m4_305)
	assertlist !missing(m4_306) if m4_305 == 1, list(respondentid m4_306 m4_305)
	assertlist !missing(m4_401a) if m4_permission == 1, list(respondentid m4_401a)

local n 1
foreach v in a b c {
	foreach var in m4_403`v' m4_405`v' m4_405`v'_1 m4_405`v'_10 m4_405`v'_2 m4_405`v'_3 m4_405`v'_4 m4_405`v'_5 m4_405`v'_6 m4_405`v'_7 m4_405`v'_8 m4_405`v'_9 m4_405`v'_96  m4_411`v'   m4_consult`n'_len {
		assertlist `var'== .a if m4_402 < `n', list(respondentid m4_402 `var')
	}
	foreach var in m4_baby2_404`v' m4_405`v'_other m4_404`v' {
		assertlist `var' == ".a" if missing(`var') & m4_402 < `n', list(respondentid m4_402 `var')
	}
	assertlist m4_50`n' == .a if m4_402 < `n',list(respondentid m4_402 m4_50`n')
	local ++n

}
	

foreach v in m4_baby2_name m4_baby2_210_other m4_baby2_other m4_baby2_601i_other m4_baby2_404a m4_baby2_404b m4_baby2_404c {
	tab `v' if m4_live_babies < 2,m
	capture assertlist `v' ==".a" if m4_live_babies < 2 //| missing(m4_live_babies), list(respondentid m4_live_babies `v' )
	capture assertlist `v' ==.a if m4_live_babies < 2 //| missing(m4_live_babies), list(respondentid m4_live_babies `v' )

}

foreach v in m4_baby2_status m4_baby2_health m4_baby2_feed_a m4_baby2_feed_b m4_baby2_feed_c m4_baby2_feed_d m4_baby2_feed_e m4_baby2_feed_f m4_baby2_feed_g m4_baby2_feed_rf m4_baby2_sleep m4_baby2_feed m4_baby2_breath m4_baby2_stool m4_baby2_mood m4_baby2_skin m4_baby2_interactivity m4_baby2_diarrhea m4_baby2_fever m4_baby2_lowtemp m4_baby2_illness m4_baby2_troublebreath m4_baby2_chestprob m4_baby2_troublefeed m4_baby2_convulsions m4_baby2_jaundice m4_baby2_yellowpalms m4_baby2_otherprob  m4_baby2_death_date m4_baby2_deathage m4_baby2_210  m4_baby2_advice m4_baby2_death_loc  m4_baby2_403b m4_baby2_consult2_len m4_baby2_403c m4_baby2_411c m4_baby2_consult3_len m4_baby2_601a m4_baby2_601b m4_baby2_601c m4_baby2_601d m4_baby2_601e m4_baby2_601f m4_baby2_601g m4_baby2_601h m4_baby2_601i  {
	di "`v'"
	di "Should be missing..."
	assertlist `v' == .a if m4_live_babies < 2 | missing(m4_live_babies), list(respondentid m4_live_babies `v' )
	

	*di "Should be populated..."
	*assertlist !missing(`v') if m4_live_babies == 2 , list(respondentid m4_live_babies `v' )

}
	
	
	* confirm that if they said they paid money the amount if greater than 0
	gen tot = 0
	foreach v in m4_902a_amt m4_902b_amt m4_902c_amt m4_902d_amt m4_902e_amt m4_902_total_spent {
		assertlist !inlist(`v',.,0,.a) if m4_901  == 1, list(respondentid m4_901 `v')
		assertlist inlist(`v',.,0,.a) if m4_901  != 1, list(respondentid m4_901 `v')

		if "`v'" != "m4_902_total_spent"	replace tot = tot + `v'
	}
	
	assertlist tot == m4_902_total_spent if !inlist(m4_902_total_spent,.,.a), list(respondentid m4_901  m4_902a_amt m4_902b_amt m4_902c_amt m4_902d_amt m4_902e_amt m4_902_total_spent tot )
	assertlist m4_902_total_spent > 0 if m4_901 == 1 , list(respondentid m4_901 m4_902a_amt m4_902b_amt m4_902c_amt m4_902d_amt m4_902e_amt m4_902_total_spent tot )

	* Merge back with M1-M3
	use "$za_data_final/eco_m1-m3_za.dta", clear
	
	merge 1:1 respondentid using "$za_data_final/eco_m4_za.dta"

	rename _merge merge_m4_main_data
	label define m4 3 "M4 and M1" 1 "M1-M3 only", replace
label value merge_m4_main_data m4
label var merge_m4_main_data "Merge status from M4 to Main dataset"
	save "$za_data_final/eco_m1-m4_za.dta", replace

* Quick M4 DQ checks after merging

foreach v in 1 2 3 {
	foreach date of varlist m`v'_date* {
		assertlist m4_date > `date' if !inlist(m4_date,.,.a) & !inlist(`date',.,.a), list(respondentid m4_date `date') tag(M4 interview date should be after `date')
	}
}

	* Confirm that the consultation dates are before interview date
	foreach d in a b c {
		assertlist m4_411`d' < m4_date if !missing(m4_411`d') & m4_411`d' != mdy(1,1,2095), list(respondentid m4_date m4_411`d')
	}



* confirm the number of babies is the same for M3 and M4

* Confirm the HIV status is the same for M1, M2, M3 and M4
