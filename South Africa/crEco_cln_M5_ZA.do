* South Africa MNH ECohort Data M5 Cleaning File 
* Created by N. Kapoor
* Updated: May 2025

import delimited "$za_data/Module 5/Module-5 3Jan2025-forstata.csv", clear 

* NK NOTE: Why are there a few Mod4 variables? 

foreach v of varlist * {
	char `v'[Original_ZA_Varname] `v'
	char `v'[Module] 5
	capture destring `v', replace
	capture replace `v' = trim(`v')
	
	* Clean up the values we know are defaults
	capture recode `v' 9999998 = . // These were skipped appropriately
	capture replace `v' = "" if `v' == "9999998"
	capture replace `v' = ".d" if inlist(`v'," 1-Jan-98","1-Jan-98", "1/1/1998"," 1/1/1998")
	capture replace `v' = ".r" if inlist(`v'," 1-Jan-99","1-Jan-99", "1/1/1999"," 1/1/1999")
	capture replace `v' = ".a" if inlist(`v'," 1-Jan-95","1-Jan-95", "1/1/1995"," 1/1/1995")
}


foreach v of varlist *_b3 *baby3 *_b3_* {
    quietly count if !missing(`v')
    if r(N)==0 {
        drop `v'
        display "`v' dropped - all values missing"
    }
}

drop mod5_assessment_1403_b3 mod5_thm_b3 // NK Note: not sure why mod5_thm_b3 isn't all missing! 

 

capture assert missing(MOD4_HEALTHBABY_210_BABY3_OTHER)
if _rc == 0 drop MOD4_HEALTHBABY_210_BABY3_OTHER

***************** VARIABLE RENAMING ****************** 

* Module 5 South Africa variable renaming

* Basic respondent info and identifiers
rename response_questionnaireid m5_questionnaireid
rename response_questionnairename m5_questionnairename
rename response_questionnaireversion m5_questionnaireversion
rename response_fieldworkerid m5_fieldworkerid
rename response_fieldworker m5_fieldworker
rename response_starttime m5_starttime
rename response_location m5_location
rename response_lattitude m5_latitude
rename response_longitude m5_longitude
rename response_studynoprefix m5_studynoprefix
rename response_studyno m5_studyno
rename studynumber m5_studynumber
rename responseid m5_responseid
rename mod5_permission_granted m5_consent

* Identification section
rename mod5_identification_101 m5_101
rename mod5_identification_102 m5_102
rename mod5_identification_103 m5_103
rename crhid m5_crhid
rename mod5_identification_108 m5_108
rename mod5_identification_109 m5_109
rename mod5_identification_110 m5_110
rename mod5_identification_111 m5_111
rename mod5_identification_112_b1 m5_112_baby1
rename mod5_identification_112_b2 m5_112_baby2
rename mod5_identification_113 m5_113
rename mod5_identification_114 m5_114
rename mod5_identification_115 m5_115
rename mod5_identification_115_other m5_115_other

* Health baby section
rename mod5_healthbaby_201_baby1 m5_baby1_alive
rename mod5_healthbaby_201_baby2 m5_baby2_alive
rename mod5_healthbaby_202_baby1 m5_baby1_health
rename mod5_healthbaby_202_baby2 m5_baby2_health
rename mod5_healthbaby_203_baby1 m5_baby1_feeding
rename mod5_healthbaby_203_baby2 m5_baby2_feeding
rename mod5_healthbaby_204 m5_204
rename mod5_healthbaby_205a m5_baby1_sleep
rename mod5_healthbaby_205a_baby2 m5_baby2_sleep
rename mod5_healthbaby_205b_baby1 m5_baby1_feed
rename mod5_healthbaby_205b_baby2 m5_baby2_feed
rename mod5_healthbaby_205c_baby1 m5_baby1_breath
rename mod5_healthbaby_205c_baby2 m5_baby2_breath
rename mod5_healthbaby_205d_baby1 m5_baby1_stool
rename mod5_healthbaby_205d_baby2 m5_baby2_stool
rename mod5_healthbaby_205e_baby1 m5_baby1_mood
rename mod4_healthbaby_205e_baby2 m5_baby2_mood
rename mod5_healthbaby_205f_baby1 m5_baby1_skin
rename mod5_healthbaby_205f_baby2 m5_baby2_skin
rename mod5_healthbaby_205g_baby1 m5_baby1_interactivity
rename mod5_healthbaby_205g_baby2 m5_baby2_interactivity

* Health issues for babies
rename mod5_healthbaby_206a_b1 m5_baby1_issue_a
rename mod5_healthbaby_206a_b2 m5_baby2_issue_a
rename mod5_healthbaby_206b_b1 m5_baby1_issue_b
rename mod5_healthbaby_206b_b2 m5_baby2_issue_b
rename mod5_healthbaby_206c_b1 m5_baby1_issue_c
rename mod5_healthbaby_206c_b2 m5_baby2_issue_c
rename mod5_healthbaby_206d_b1 m5_baby1_issue_d
rename mod5_healthbaby_206d_b2 m5_baby2_issue_d
rename mod5_healthbaby_206e_b1 m5_baby1_issue_e
rename mod5_healthbaby_206e_b2 m5_baby2_issue_e
rename mo5_healthbaby_206f_b1 m5_baby1_issue_f
rename mo5_healthbaby_206f_b2 m5_baby2_issue_f
rename mod5_healthbaby_206g_b1 m5_baby1_issue_g
rename mod5_healthbaby_206g_b2 m5_baby2_issue_g
rename mod5_healthbaby_206h_b1 m5_baby1_issue_h
rename mod5_healthbaby_206h_b2 m5_baby2_issue_h
rename mod5_healthbaby_206i_b1 m5_baby1_issue_i
rename mod5_healthbaby_206i_b2 m5_baby2_issue_i
rename mod5_healthbaby_206j_b1 m5_baby1_issues_none
rename mod5_healthbaby_206j_b2 m5_baby2_issues_none

* Baby death info
rename mod5_healthbaby_207_b1 m5_baby1_issue_oth
rename mod5_healthbaby_207_b1_other m5_baby1_issue_oth_text
rename mod5_healthbaby_207_b2 m5_baby2_issue_oth
rename mod5_healthbaby_207_b2_other m5_baby2_issue_oth_text

rename mod5_healthbaby_208_baby1 m5_baby1_death_date
rename mod5_healthbaby_209_baby1 m5_baby1_death_age
rename mod5_healthbaby_210_baby1 m5_baby1_death_cause
rename mod5_healthbaby_210_baby1_other m5_baby1_death_cause_oth_text
rename mod5_healthbaby_211_baby1 m5_baby1_advice
rename mod5_healthbaby_212_baby1 m5_baby1_death_loc
rename mod5_healthbaby_212_b1_other m5_baby1_death_loc_oth

rename mod5_healthbaby_208_baby2 m5_baby2_death_date
rename mod5_healthbaby_209_baby2 m5_baby2_death_age
rename mod4_healthbaby_210_baby2 m5_baby2_death_cause
rename mod5_healthbaby_210_baby2_other m5_baby2_death_cause_oth_text
rename mod5_healthbaby_211_baby2 m5_baby2_advice
rename mod5_healthbaby_212_baby2 m5_baby2_death_loc
rename mod5_healthbaby_212_b2_other m5_baby2_death_loc_oth

* Mother's health
rename mod5_health_301 m5_health
rename mod5_health_302a m5_health_a
rename mod5_health_302b m5_health_b
rename mod5_health_302c m5_health_c
rename mod5_health_302d m5_health_d
rename mod5_health_302e m5_health_e
rename mod5_health_303a m5_depression_a
rename mod5_health_303b m5_depression_b
rename mod5_health_303c m5_depression_c
rename mod5_health_303d m5_depression_d
rename mod5_health_303e m5_depression_e
rename mod5_health_303f m5_depression_f
rename mod5_health_303g m5_depression_g
rename mod5_health_303h m5_depression_h
rename mod5_health_303i m5_depression_i
rename mod5_health_304 m5_health_affect_scale

rename mod5_health_305a m5_feeling_a
rename mod5_health_305b m5_feeling_b
rename mod5_health_305c m5_feeling_c
rename mod5_health_305d m5_feeling_d
rename mod5_health_305e m5_feeling_e
rename mod5_health_305f m5_feeling_f
rename mod5_health_305g m5_feeling_g
rename mod5_health_305h m5_feeling_h
rename mod5_health_306 m5_pain
rename mod5_health_307 m5_leakage
rename mod5_health_308 m5_leakage_when
rename mod5_health_309 m5_leakage_affect
rename mod5_health_310 m5_leakage_tx
rename mod5_health_311 m5_leakage_no_treatment
rename mod5_health_311_other m5_leakage_notx_reason_oth
rename mod5_health_312 m5_leakage_txeffect

* Rating section
rename mod5_rating_401 m5_401
rename mod5_rating_402 m5_402
rename mod5_rating_403 m5_403
rename mod5_rating_404 m5_404
rename mod5_rating_405a m5_405a
rename mod5_rating_405b m5_405b
rename mod5_rating_406a m5_406a
rename mod5_rating_406b m5_406b

* Care pathways
rename mod5_care_pathways_501_b1 m5_501a
rename mod5_care_pathways_501_b2 m5_501b
rename mod5_care_pathways_502_b1 m5_502a
rename mod5_care_pathways_502_b2 m5_502b
* Care pathways section (continued)
rename mod5_care_pathways_503a_b1 m5_503a_b1
rename mod5_care_pathways_504a_b1 m5_504a_b1
rename mod5_care_pathways_505_b1 m5_505_1
rename mod5_care_pathways_506_b1 m5_consultation1
rename mod5_care_pathways_506_b1_other m5_consultation1_oth_text

rename mod5_care_pathways_503a_b2 m5_503a_b2
rename mod5_care_pathways_504a_b2 m5_504a_b2
rename mod5_care_pathways_505_b2 m5_505_2
rename mod5_care_pathways_506_b2 m5_consultation2
rename mod5_care_pathways_506_b2_other m5_consultation2_oth_text

rename mod5_care_pathways_503b_b1 m5_503b_b1
rename mod5_care_pathways_504b_b1 m5_504b_b1
rename mod5_care_pathways_507_b1 m5_507_1
rename mod5_care_pathways_508_b1 m5_508_1
rename mod5_care_pathways_507_b1_other m5_507_1_other

rename mod5_care_pathways_503b_b2 m5_503b_b2
rename mod5_care_pathways_504b_b2 m5_504b_b2
rename mod5_care_pathways_507_b2 m5_507_2
rename mod5_care_pathways_508_b2 m5_508_2
rename mod5_care_pathways_508_b2_other m5_508_2_other

rename mod5_care_pathways_503c_b1 m5_503c_b1
rename mod5_care_pathways_504c_b1 m5_504c_b1
rename mod5_care_pathways_509_b1 m5_509_1
rename mod5_care_pathways_510_b1 m5_510_1
rename mod5_care_pathways_510_b1_other m5_510_1_other

rename mod5_care_pathways_503c_b2 m5_503c_b2
rename mod5_care_pathways_504c_b2 m5_504c_b2
rename mod5_care_pathways_509_b2 m5_509_2
rename mod5_care_pathways_510_b2 m5_510_2
rename mod5_care_pathways_510_b2_other m5_510_2_other

rename mod5_care_pathways_511 m5_no_visit
rename mod5_care_pathways_511_other m5_no_visit_oth

* User experience section
rename mod5_user_exp_601 m5_user_exp
rename mod5_user_exp_602 m5_consultation1_carequal
rename mod5_user_exp_603 m5_consultation2_carequal

* Continuity of care section
rename mod5_cont_of_care_701a_b1 m5_baby1_701a
rename mod5_cont_of_care_701a_b2 m5_baby2_701a
rename mod5_cont_of_care_701b_b1 m5_baby1_701b
rename mod5_cont_of_care_701b_b2 m5_baby2_701b
rename mod5_cont_of_care_701c_b1 m5_baby1_701c
rename mod5_cont_of_care_701c_b2 m5_baby2_701c
rename mod5_cont_of_care_701d_b1 m5_baby1_701d
rename mod5_cont_of_care_701d_b2 m5_baby2_701d
rename mod5_cont_of_care_701e_b1 m5_baby1_701e
rename mod5_cont_of_care_701e_b2 m5_baby2_701e
rename mod5_cont_of_care_701f_b1 m5_baby1_701f
rename mod5_cont_of_care_701f_b2 m5_baby2_701f
rename mod5_cont_of_care_701g_b1 m5_baby1_701g
rename mod5_cont_of_care_701g_b2 m5_baby2_701g
rename mod5_cont_of_care_701h_b1 m5_baby1_701h
rename mod5_cont_of_care_701h_b2 m5_baby2_701h
rename mod5_cont_of_care_701i_b1 m5_baby1_701i
rename mod5_cont_of_care_701i_b1_other m5_baby1_701i_other
rename mod5_cont_of_care_701i_b2 m5_baby2_701i
rename mod5_cont_of_care_701i_b2_other m5_baby2_701i_other

rename mod5_cont_of_care_702a m5_702a
rename mod5_cont_of_care_702b m5_702b
rename mod5_cont_of_care_702c m5_702c
rename mod5_cont_of_care_702d m5_702d
rename mod5_cont_of_care_702e m5_702e
rename mod5_cont_of_care_702f m5_702f
rename mod5_cont_of_care_702g m5_702g

rename mod5_cont_of_care_703 m5_703
rename mod5_cont_of_care_703_other m5_703_other

* Medical care for babies and mothers
rename mod5_cont_of_care_801a m5_801a
rename mod5_cont_of_care_801b m5_801b
rename mod5_cont_of_care_801c m5_801c
rename mod5_cont_of_care_801d m5_801d
rename mod5_cont_of_care_801e m5_801e
rename mod5_cont_of_care_801f m5_801f
rename mod5_cont_of_care_801g m5_801g
rename mod5_cont_of_care_801h m5_801h
rename mod5_cont_of_care_801h_other m5_801_other

rename mod5_cont_of_care_802 m5_802
rename mod5_cont_of_care_803a m5_803a
rename mod5_cont_of_care_803b m5_803b
rename mod5_cont_of_care_803c m5_803c
rename mod5_cont_of_care_803d m5_803d
rename mod5_cont_of_care_803e m5_803e
rename mod5_cont_of_care_803f m5_803f
rename mod5_cont_of_care_803g m5_803g

rename mod5_cont_of_care_804a m5_804a
rename mod5_cont_of_care_804b m5_804b
rename mod5_cont_of_care_804c m5_804c

* Medication section
rename mod5_meds_901a m5_901a
rename mod5_meds_901b m5_901b
rename mod5_meds_901c m5_901c
rename mod5_meds_901d m5_901d
rename mod5_meds_901e m5_901e
rename mod5_meds_901f m5_901f
rename mod5_meds_901g m5_901g
rename mod5_meds_901h m5_901h
rename mod5_meds_901i m5_901i
rename mod5_meds_901j m5_901j
rename mod5_meds_901k m5_901k
rename mod5_meds_901l m5_901l
rename mod5_meds_901m m5_901m
rename mod5_meds_901n m5_901n
rename mod5_meds_901o m5_901o
rename mod5_meds_901p m5_901p
rename mod5_meds_901q m5_901q
rename mod5_meds_901r m5_901s
rename mod5_meds_901r_other m5_901s_other

* Baby medication
rename mod5_meds_902a m5_baby1_902a
rename mod5_meds_902b m5_baby1_902b
rename mod5_meds_902c m5_baby1_902c
rename mod5_meds_902d m5_baby1_902d
rename mod5_meds_902e m5_baby1_902e
rename mod5_meds_902f m5_baby1_902f
rename mod5_meds_902g m5_baby1_902g
rename mod5_meds_902h m5_baby1_902h
rename mod5_meds_902i m5_baby1_902i
rename mod5_meds_902j m5_baby1_902j
rename mod5_meds_902j_other m5_baby1_902_other

* Baby vaccines
rename mod5_meds_903a m5_baby1_903a
rename mod5_meds_903b m5_baby1_903b
rename mod5_meds_903c m5_baby1_903c
rename mod5_meds_903d m5_baby1_903d
rename mod5_meds_903e m5_baby1_903e
rename mod5_meds_903f m5_baby1_903f
rename mod5_meds_903f_other m5_baby1_903_other

rename mod5_meds_904 m5_baby1_904
rename mod5_meds_905 m5_905

* Costs section
rename mod5_costs_1001 m5_1001
rename mod5_costs_1002a m5_1002a
rename mod5_costs_1002b m5_1002b
rename mod5_costs_1002c m5_1002c
rename mod5_costs_1002d m5_1002d
rename mod5_costs_1002e m5_1002e
rename mod5_costs_1002e_other_amount m5_1002_other
rename mod5_costs_1002_total m5_1003_confirm
rename mod5_costs_1003 m5_1003
rename mod5_costs_1004 m5_1004
rename mod5_costs_1005 m5_1005
rename mod5_costs_1005_other m5_1005_other_text
rename mod5_income_1006 m5_1006

* IPV section
rename mod5_ipv_1101 m5_1101
rename mod5_ipv_1102 m5_1102
rename mod5_ipv_1102_other m5_1102_other
rename mod5_ipv_1103 m5_1103
rename mod5_ipv_1104 m5_1104
rename mod5_ipv_1104_other m5_1104_other
rename mod5_ipv_1105 m5_1105

* Traditional health methods (THM) section
rename mod5_thm_b1 m5_thm_b1
rename mod5_thm_b2 m5_thm_b2
rename mod5_thm_b4 m5_thm_b4
rename mod5_thm_b4_relative m5_thm_b4_relative
rename mod5_thm_b4_other m5_thm_b4_other
rename mod5_thm_b5_thm1 m5_thm_b5_thm1
rename mod5_thm_b5_reason_1 m5_thm_b5_reason_1
rename mod5_thm_b5_thm2 m5_thm_b5_thm2
rename mod5_thm_b5_reason_2 m5_thm_b5_reason_2
rename mod5_thm_b5_thm3 m5_thm_b5_thm3
rename mod5_thm_b5_reason_3 m5_thm_b5_reason_3
rename mod5_thm_b6 m5_thm_b6
rename mod5_thm_b7 m5_thm_b7
rename mod5_thm_b8 m5_thm_b8
rename mod5_thm_b8_other m5_thm_b8_other
rename mod5_thm_b9 m5_thm_b9
rename mod5_thm_b9_other m5_thm_b9_other
rename mod5_thm_b10 m5_thm_b10
rename mod5_thm_b11 m5_thm_b11
rename mod5_thm_b12a m5_thm_b12a
rename mod5_thm_b12b m5_thm_b12b
rename mod5_thm_b12c m5_thm_b12c

* Closing section
rename mod5_closing_1201 m5_1201

* Assessment section (anthropometric measurements)
rename mod5_assessment_1301 m5_height
rename mod5_assessment_1302 m5_weight
rename mod5_assessment_1303a m5_sbp1
rename mod5_assessment_1303b m5_dbp1
rename mod5_assessment_1303c m5_pr1
rename mod5_assessment_1304a m5_sbp2
rename mod5_assessment_1304b m5_dbp2
rename mod5_assessment_1304c m5_pr2
rename mod5_assessment_1305a m5_sbp3
rename mod5_assessment_1305b m5_dbp3
rename mod5_assessment_1305c m5_pr3
rename mod5_assessment_1306 m5_anemiatest
rename mod5_assessment_1307 m5_hb_level

* Baby measurements
rename mod5_assessment_1401_b1 m5_baby1_weight
rename mod5_assessment_1402_b1 m5_baby1_length
rename mod5_assessment_1403_b1 m5_baby1_hc
rename mod5_1401_baby2 m5_baby2_available
rename mod5_assessment_1401_b2 m5_baby2_weight
rename mod5_assessment_1402_b2 m5_baby2_length
rename mod5_assessment_1403_b2 m5_baby2_hc

* Generate depression sum
*egen m5_depression_sum = rowtotal(m5_depression_a m5_depression_b m5_depression_c m5_depression_d m5_depression_e m5_depression_f m5_depression_g m5_depression_h m5_depression_i)

* Create derived variables for PHQ-2 score (first two depression items) if needed
*egen m5_phqscore = rowtotal(m5_depression_a m5_depression_b)

* Generate the depression sum if not already done
*capture confirm variable m5_depression_sum
*if _rc {
*    egen m5_depression_sum = rowtotal(m5_depression_a m5_depression_b m5_depression_c m5_depression_d ///
        m5_depression_e m5_depression_f m5_depression_g m5_depression_h m5_depression_i)
 *   label var m5_depression_sum "Total PHQ-9 depression score (sum of all 9 items)"
*}

* Generate PHQ-2 score for screening purposes
*capture confirm variable m5_phqscore
*if _rc {
*    egen m5_phqscore = rowtotal(m5_depression_a m5_depression_b)
*    label var m5_phqscore "PHQ-2 depression screening score (sum of first 2 items)"
*}


***************** VALUE LABELING ****************** 

* MODULE 5: Value labels for South Africa dataset (without baby 3)

describe m5_consent m5_baby1_issue_a m5_baby2_issue_a ///
    m5_baby1_issue_b m5_baby2_issue_b ///
    m5_baby1_issue_c m5_baby2_issue_c ///
    m5_baby1_issue_d m5_baby2_issue_d ///
    m5_baby1_issue_e m5_baby2_issue_e ///
    m5_baby1_issue_f m5_baby2_issue_f ///
    m5_baby1_issue_g m5_baby2_issue_g ///
    m5_baby1_issue_h m5_baby2_issue_h ///
    m5_baby1_issue_i m5_baby2_issue_i ///
    m5_baby1_issues_none m5_baby2_issues_none ///
    m5_baby1_issue_oth m5_baby2_issue_oth ///
    m5_baby1_advice m5_baby2_advice ///
    m5_leakage m5_leakage_tx m5_406a m5_406b m5_501a m5_501b ///
    m5_505_1 m5_505_2 ///
    m5_baby1_701a m5_baby2_701a ///
    m5_baby1_701b m5_baby2_701b ///
    m5_baby1_701c m5_baby2_701c ///
    m5_baby1_701d m5_baby2_701d ///
    m5_baby1_701e m5_baby2_701e ///
    m5_baby1_701f m5_baby2_701f ///
    m5_baby1_701g m5_baby2_701g ///
    m5_baby1_701h m5_baby2_701h ///
    m5_baby1_701i m5_baby2_701i ///
    m5_702a m5_702b m5_702c m5_702d m5_702e m5_702f m5_702g ///
    m5_801a m5_801b m5_801c m5_801d m5_801e m5_801f m5_801g m5_801h m5_802 ///
    m5_803a m5_803b m5_803c m5_803d m5_803e m5_803f m5_803g m5_804a ///
    m5_901a m5_901b m5_901c m5_901d m5_901e m5_901f m5_901g m5_901h ///
    m5_901i m5_901j m5_901k m5_901l m5_901m m5_901n m5_901o m5_901p ///
    m5_901q m5_901s ///
    m5_baby1_902a m5_baby1_902b m5_baby1_902c m5_baby1_902d m5_baby1_902e ///
    m5_baby1_902f m5_baby1_902g m5_baby1_902h m5_baby1_902i m5_baby1_902j ///
    m5_baby1_903a m5_baby1_903b m5_baby1_903c m5_baby1_903d m5_baby1_903e m5_baby1_903f ///
    m5_1001 m5_1003_confirm m5_1101 m5_1103 m5_1105 m5_anemiatest 
	
	
* m5_505_1 - fix "0," issue
replace m5_505_1 = "0" if m5_505_1 == "0,"

encode m5_505_1, gen(m5_505_1_num)
drop m5_505_1
rename m5_505_1_num m5_505_1
	
* Basic Yes/No value label
label define YN_m5 1 "Yes" 0 "No" 98 "DK" 99 "RF"
lab val m5_consent m5_baby1_issue_a m5_baby2_issue_a ///
    m5_baby1_issue_b m5_baby2_issue_b ///
    m5_baby1_issue_c m5_baby2_issue_c ///
    m5_baby1_issue_d m5_baby2_issue_d ///
    m5_baby1_issue_e m5_baby2_issue_e ///
    m5_baby1_issue_f m5_baby2_issue_f ///
    m5_baby1_issue_g m5_baby2_issue_g ///
    m5_baby1_issue_h m5_baby2_issue_h ///
    m5_baby1_issue_i m5_baby2_issue_i ///
    m5_baby1_issues_none m5_baby2_issues_none ///
    m5_baby1_issue_oth m5_baby2_issue_oth ///
    m5_baby1_advice m5_baby2_advice ///
    m5_leakage m5_leakage_tx m5_406a m5_406b m5_501a m5_501b ///
    m5_505_1 m5_505_2 ///
    m5_baby1_701a m5_baby2_701a ///
    m5_baby1_701b m5_baby2_701b ///
    m5_baby1_701c m5_baby2_701c ///
    m5_baby1_701d m5_baby2_701d ///
    m5_baby1_701e m5_baby2_701e ///
    m5_baby1_701f m5_baby2_701f ///
    m5_baby1_701g m5_baby2_701g ///
    m5_baby1_701h m5_baby2_701h ///
    m5_baby1_701i m5_baby2_701i ///
    m5_702a m5_702b m5_702c m5_702d m5_702e m5_702f m5_702g ///
    m5_801a m5_801b m5_801c m5_801d m5_801e m5_801f m5_801g m5_801h m5_802 ///
    m5_803a m5_803b m5_803c m5_803d m5_803e m5_803f m5_803g m5_804a ///
    m5_901a m5_901b m5_901c m5_901d m5_901e m5_901f m5_901g m5_901h ///
    m5_901i m5_901j m5_901k m5_901l m5_901m m5_901n m5_901o m5_901p ///
    m5_901q m5_901s ///
    m5_baby1_902a m5_baby1_902b m5_baby1_902c m5_baby1_902d m5_baby1_902e ///
    m5_baby1_902f m5_baby1_902g m5_baby1_902h m5_baby1_902i m5_baby1_902j ///
    m5_baby1_903a m5_baby1_903b m5_baby1_903c m5_baby1_903d m5_baby1_903e m5_baby1_903f ///
    m5_1001 m5_1003_confirm m5_1101 m5_1103 m5_1105 m5_anemiatest YN_m5

* Baby status - alive/dead
lab def baby_status 1 "Alive" 0 "Died"
lab val m5_baby1_alive m5_baby2_alive baby_status

* Health rating - likert scale
lab def m5_likert 1 "Excellent" 2 "Very good" 3 "Good" 4 "Fair" 5 "Poor" 99 "NR/RF"
lab val m5_baby1_health m5_baby2_health m5_health m5_401 ///
    m5_consultation1_carequal m5_consultation2_carequal m5_likert

* Breastfeeding confidence
*lab def m5_confidence 1 "Very confident" 2 "Confident" 3 "Somewhat confident" 4 "Not very confident" ///
    5 "Not at all confident" 96 "I do not breastfeed" 98 "DK" 99 "NR/RF" 
*lab val m5_baby1_feeding m5_baby2_feeding m5_confidence

* General confidence
label define m5_confidence2 1 "Very confident" 2 "Somewhat confident" 3 "Not very confident" ///
    4 "Not at all confident" 98 "DK" 99 "NR/RF" 
lab val m5_403 m5_404 m5_405a m5_405b m5_confidence2

* Baby sleep rating
label define m5_sleep 1 "Sleeps well" 2 "Slightly affected sleep" 3 "Moderately affected sleep" ///
    4 "Severely disturbed sleep" 
lab val m5_baby1_sleep m5_baby2_sleep m5_sleep 

* Baby feeding rating
label define m5_feeding 1 "Normal feeding" 2 "Slight feeding problems" 3 "Moderate feeding problems" ///
    4 "Severe feeding problems" 
lab val m5_baby1_feed m5_baby2_feed m5_feeding

* Breathing rating
label define m5_breath 1 "Normal breathing" 2 "Slight breathing problems" ///
    3 "Moderate breathing problems" 4 "Severe breathing problems" 
lab val m5_baby1_breath m5_baby2_breath m5_breath

* Stool problems rating
label define m5_stool 1 "Normal stooling/poo" 2 "Slight stooling/poo problems" ///
    3 "Moderate stooling/poo problems" 4 "Severe stooling/poo problems" 
lab val m5_baby1_stool m5_baby2_stool m5_stool

* Baby mood rating
label define m5_mood 1 "Happy/content" 2 "Fussy/irritable" 3 "Crying" 4 "Inconsolable crying" 
lab val m5_baby1_mood m5_baby2_mood m5_mood

* Skin condition rating
label define m5_skin 1 "Normal skin" 2 "Dry or red skin" 3 "Irritated or itchy skin" ///
    4 "Bleeding or cracked skin"
lab val m5_baby1_skin m5_baby2_skin m5_skin

* Interactivity rating
label define m5_interactivity 1 "Highly playful/interactive" 2 "Playful/interactive" ///
    3 "Less playful/less interactive" 4 "Low energy/inactive/dull"
lab val m5_baby1_interactivity m5_baby2_interactivity m5_interactivity

* Cause of death
label define m5_causedeath 0 "Not told anything" 1 "The baby was premature (born too early)" ///
    2 "A birth injury or asphyxia (occurring because of delivery complications)" ///
    3 "A congenital abnormality (genetic or acquired issues with growth/development)" ///
    4 "Malaria" 5 "An acute respiratory infection" 6 "Diarrhea" 7 "Another type of infection" ///
    8 "Severe acute malnutrition" 9 "An accident or injury" 96 "Another cause, (Specify)" 
lab val m5_baby1_death_cause m5_baby2_death_cause m5_causedeath

* Death location
label define m5_deathloc 1 "In a health facility" 2 "On the way to the health facility" ///
    3 "Your house or someone else's house" 96 "Other, please specify" 98 "DK" 99 "NR/RF" 
lab val m5_baby1_death_loc m5_baby2_death_loc m5_deathloc

* Mobility rating
label define m5_mobility 1 "I have no problems in walking about" 2 "I have some problems in walking about" ///
    3 "I am confined to bed" 99 "NR/RF"
lab val m5_health_a m5_mobility

* Self-care rating
label define m5_washing 1 "I have no problems with washing or dressing myself" ///
    2 "I have some problems washing or dressing myself" ///
    3 "I am unable to wash or dress myself" 99 "NR/RF" 
lab val m5_health_b m5_washing

* Usual activities rating
label define m5_activity 1 "I have no problems with performing my usual activities" ///
    2 "I have some problems with performing my usual activities" ///
    3 "I am unable to perform my usual activities" 99 "NR/RF" 
lab val m5_health_c m5_activity

* Pain/discomfort rating
label define m5_pain_discomf 1 "I have no pain or discomfort" 2 "I have moderate pain or discomfort" ///
    3 "I have extreme pain or discomfort" 99 "NR/RF" 
lab val m5_health_d m5_pain_discomf 

* Mental health rating
label define m5_mentalhealth 1 "I am not anxious or depressed" 2 "I am moderately anxious or depressed" ///
    3 "I am extremely anxious or depressed" 4 "NR/RF" 
lab val m5_health_e m5_mentalhealth

* PHQ-9 depression scale
label define m5_phq9 0 "None of the days" 1 "Several days" 2 "More than half the days (>7)" ///
    3 "Nearly every day" 99 "NR/RF" 
label val m5_depression_a m5_depression_b m5_depression_c m5_depression_d m5_depression_e m5_depression_f ///
    m5_depression_g m5_depression_h m5_depression_i m5_phq9

* Health affect scale
label define m5_health_affect_scale 0 "Have not had pain" 1 "Not at all" 2 "A little bit" 3 "Somewhat" ///
    4 "Quite a bit" 5 "Very much" 98 "DK/N/A" 99 "NR/RF" 
lab val m5_health_affect_scale m5_health_affect_scale 

* Feeling endorsement scale
label define m5_endorse 1 "Very much" 2 "A lot" 3 "A little" 4 "Not at all" 99 "NR/RF" 
lab val m5_feeling_a m5_feeling_b m5_feeling_c m5_feeling_d m5_feeling_e m5_feeling_f m5_feeling_g ///
    m5_feeling_h m5_endorse

* Pain scale
label define m5_pain_scale 0 "Have not had sex" 1 "Not at all" 2 "A little bit" 3 "Somewhat" ///
    4 "Quite a bit" 5 "Very much" 98 "DK" 99 "NR/RF" 
lab val m5_pain m5_pain_scale

* Leakage affect scale
label define m5_leakage_affect 0 "Never" 1 "Less than once per month" ///
    2 "Less than once per week & greater than once per month" ///
    3 "Less than once per day & greater than once per month" ///
    4 "Once a day or more than/once a day" 98 "DK" 99 "NR/RF"
label val m5_leakage_affect m5_leakage_affect

* Treatment effectiveness for leakage
label define m5_leakage_txeffect 1 "YES, NO MORE LEAKAGE AT ALL" 2 "YES, BUT STILL SOME LEAKAGE" ///
    3 "NO, STILL HAVE PROBLEM" 99 "NR/RF" 
lab val m5_leakage_txeffect m5_leakage_txeffect

* Health system rating
label define m5_healthcare_system 1 "On the whole, the system works pretty well, and only minor changes are necessary to make it work better" ///
    2 "There are some good things in our health care system, but major changes are needed to make it work better" ///
    3 "Our health care system has so much wrong with it that we need to completely rebuild it" 98 "DK" 99 "NR/RF" 
lab val m5_402 m5_healthcare_system

* Number of consultations
label define m5_consultations 1 "One" 2 "Two" 3 "Three" 
lab val m5_502a m5_502b m5_consultations

* Consultation location 
label define m5_consultations_loc 1 "In your home" 2 "Someone else's home" 3 "Government hospital" ///
    4 "Government health center" 5 "Government health post" 6 "NGO or faith-based health facility" ///
    7 "Private hospital" 8 "Private specialty maternity center" 9 "Private specialty maternity clinic" ///
    10 "Private clinic" 11 "Another private medical facility (including pharmacy, shop, traditional healer)" ///
    98 "DK" 99 "NR/RF" 
lab val m5_503a_b1 m5_503a_b2 m5_503b_b1 m5_503b_b2 ///
    m5_503c_b1 m5_503c_b2 m5_consultations_loc

* Vaccination location
label define m5_vaccine_location 1 "At home" 2 "At a facility" 3 "At another location" 
lab val m5_baby1_904 m5_vaccine_location 

* Violence perpetrator
label define m5_violence 1 "Current husband" 2 "Mother; Father" 3 "Step-mother" 4 "Step-father" ///
    5 "Sister" 6 "Brother" 7 "Daughter" 8 "Son" 9 "Late/last/ex-husband/partner" ///
    10 "Current boyfriend" 11 "Former boyfriend" 12 "Mother-in-law;/Father-in-law" ///
    13 "Other female relative/in-law" 14 "Other male relative/in-law" 15 "Female friend /acquaintance" ///
    16 "Male friend/acquaintance" 17 "Teacher" 18 "Employer" 19 "Stranger" 96 "Other (specify)" ///
    98 "DK" 99 "NR/RF" 
lab val m5_1102 m5_1104 m5_violence

* Satisfaction with care
label define m5_satisfaction 1 "Very satisfied" 2 "Satisfied" 3 "Neither satisfied nor dissatisfied" ///
    4 "Dissatisfied" 5 "Very dissatisfied" 98 "DK" 99 "NR" 
lab val m5_1201 m5_satisfaction

* THM (Traditional health methods) related labels
label define m5_thm_yn 1 "Yes" 0 "No" 98 "DK" 99 "RF"
lab val m5_thm_b1 m5_thm_b2 m5_thm_b4 m5_thm_b6 m5_thm_b7 m5_thm_b8 ///
    m5_thm_b10 m5_thm_b11 m5_thm_b12a   m5_thm_yn
	
* m5_thm_b12b m5_thm_b12c

* Baby's wellness/health status from assessment section
label define m5_baby_wellness 1 "Child appears well" 2 "Child appears unwell" 3 "Child appears severely unwell"
lab val m5_baby1_weight m5_baby2_weight m5_baby_wellness


***************** VARIABLE LABELING ****************** 
* (FROM M5 shortened label)

	
* These variables are the same for all countries 
capture label var m5_start "Consent to proceed with interview"
capture label var m5_consent "Consent to confinue interview"
capture label var m5_no_consent "Reason respondent not consent to take part in the interview"
capture label var m5_starttime "Interview start time"
capture label var m5_endtime "Interview end time"
capture label var m5_duration  "Duration of interview"
capture label var m5_date "Interview date"

capture label var m5_dateconfirm "Confirm today's date"

capture label var respondentid "Respondent ID"

capture label var m5_n_livebabies "Number of live babies"


capture label var m5_n_alivebabies "Number of alive babies"
capture label var m5_n_deadbabies "Number of babies that have died"
capture label var m5_csection "Cesarean Section"
capture label var m5_hiv_status  "HIV status"


capture label var m5_maternal_death_reported "Maternal death reported"
capture label var m5_date_of_maternal_death "Date of maternal death"
capture label var m5_maternal_death_learn "How did you learn about maternal death"
capture label var m5_maternal_death_learn_other "How did you learn about maternal death: Other specified"


capture label var m5_baby1_alive "Baby 1: Still alive"
capture label var m5_baby2_alive "Baby 2: Still alive"
capture label var m5_baby3_alive "Baby 3: Still alive"
capture label var m5_baby1_health "Baby 1: Rate overall health"
capture label var m5_baby2_health "Baby 2: Rate overall health"
capture label var m5_baby3_health "Baby 3: Rate overall health"
capture label var m5_baby1_feed_a "Baby 1: how fed by Breast milk"
capture label var m5_baby1_feed_b "Baby 1: how fed by Formula"
capture label var m5_baby1_feed_c "Baby 1: how fed by Water"
capture label var m5_baby1_feed_d "Baby 1: how fed by Juice"
capture label var m5_baby1_feed_e "Baby 1: how fed by Broth"
capture label var m5_baby1_feed_f "Baby 1: how fed by Baby food"
capture label var m5_baby1_feed_g "Baby 1: how fed by Local food"
capture label var m5_baby1_feed_h "Baby 1: how fed by Milk/soup / Porridge"
capture label var m5_baby1_feed_99 "Baby 1: how fed - No Response/Refused to answer"

capture label var m5_baby2_feed_a "Baby 2: how fed by Breast milk"
capture label var m5_baby2_feed_b "Baby 2: how fed by Formula"
capture label var m5_baby2_feed_c "Baby 2: how fed by Water"
capture label var m5_baby2_feed_d "Baby 2: how fed by Juice"
capture label var m5_baby2_feed_e "Baby 2: how fed by Broth"
capture label var m5_baby2_feed_f "Baby 2: how fed by Baby food"
capture label var m5_baby2_feed_g "Baby 2: how fed by Local food"
capture label var m5_baby2_feed_h "Baby 1: how fed by Milk/soup / Porridge"

capture label var m5_baby2_feed_99 "Baby 2: how fed - No Response/Refused to answer"

capture label var m5_baby3_feed_a "Baby 3: how fed by Breast milk"
capture label var m5_baby3_feed_b "Baby 3: how fed by Formula"
capture label var m5_baby3_feed_c "Baby 3: how fed by Water"
capture label var m5_baby3_feed_d "Baby 3: how fed by Juice"
capture label var m5_baby3_feed_e "Baby 3: how fed by Broth"
capture label var m5_baby3_feed_f "Baby 3: how fed by Baby food"
capture label var m5_baby3_feed_g "Baby 3: how fed by Local food"
capture label var m5_baby3_feed_h "Baby 1: how fed by Milk/soup / Porridge"

capture label var m5_baby3_feed_99 "Baby 3: how fed - No Response/Refused to answer"

capture label var m5_baby1_breastfeeding "Baby 1: Confidence in beastfeeding (as of today)"
capture label var m5_baby2_breastfeeding "Baby 2: Confidence in beastfeeding (as of today)"
capture label var m5_baby1_sleep "Baby 1: Today's sleep description"
capture label var m5_baby2_sleep "Baby 2: Today's sleep description"
capture label var m5_baby3_sleep "Baby 3: Today's sleep description"
capture label var m5_baby1_feed "Baby 1: Today's feeding description"
capture label var m5_baby2_feed "Baby 2: Today's feeding description"
capture label var m5_baby3_feed "Baby 3: Today's feeding description"
capture label var m5_baby1_breath "Baby 1: Today's breathing description"
capture label var m5_baby2_breath "Baby 2: Today's breathing description"
capture label var m5_baby3_breath "Baby 3: Today's breathing description"
capture label var m5_baby1_stool "Baby 1: Today's stool/poo description"
capture label var m5_baby2_stool "Baby 2: Today's stool/poo description"
capture label var m5_baby3_stool "Baby 3: Today's stool/poo description"
capture label var m5_baby1_mood "Baby 1: Today's mood description"
capture label var m5_baby2_mood "Baby 2: Today's mood description"
capture label var m5_baby3_mood "Baby 3: Today's mood description"
capture label var m5_baby1_skin "Baby 1: Today's skin description"
capture label var m5_baby2_skin "Baby 2: Today's skin description"
capture label var m5_baby3_skin "Baby 3: Today's skin description"
capture label var m5_baby1_interactivity "Baby 1: Today's interactivity description"
capture label var m5_baby2_interactivity "Baby 2: Today's interactivity description"
capture label var m5_baby3_interactivity "Baby 3: Today's interactivity description"
capture label var m5_baby1_issues_a "Since last spoke Baby 1 had: Diarrhea with blood in the stools"
capture label var m5_baby2_issues_a "Since last spoke Baby 2 had: Diarrhea with blood in the stools"
capture label var m5_baby3_issues_a "Since last spoke Baby 3 had: Diarrhea with blood in the stools"
capture label var m5_baby1_issues_b "Since last spoke Baby 1 had: A fever (a temperature > 37)"
capture label var m5_baby2_issues_b "Since last spoke Baby 2 had: A fever (a temperature > 37)"
capture label var m5_baby3_issues_b "Since last spoke Baby 3 had: A fever (a temperature > 37)"
capture label var m5_baby1_issues_c "Since last spoke Baby 1 had: A low temperature (< 35)"
capture label var m5_baby2_issues_c "Since last spoke Baby 2 had: A low temperature (< 35)"
capture label var m5_baby3_issues_c "Since last spoke Baby 3 had: A low temperature (< 35)"
capture label var m5_baby1_issues_d "Since last spoke Baby 1 had: An illness with a cough"
capture label var m5_baby2_issues_d "Since last spoke Baby 2 had: An illness with a cough"
capture label var m5_baby3_issues_d "Since last spoke Baby 3 had: An illness with a cough"
capture label var m5_baby1_issues_e "Since last spoke Baby 1 had: Trouble breathing or fast/short rapid breaths"
capture label var m5_baby2_issues_e "Since last spoke Baby 2 had: Trouble breathing or fast/short rapid breaths"
capture label var m5_baby3_issues_e "Since last spoke Baby 3 had: Trouble breathing or fast/short rapid breaths"
capture label var m5_baby1_issues_f "Since last spoke Baby 1 had: A problem in the chest"
capture label var m5_baby2_issues_f "Since last spoke Baby 2 had: A problem in the chest"
capture label var m5_baby3_issues_f "Since last spoke Baby 3 had: A problem in the chest"
capture label var m5_baby1_issues_g "Since last spoke Baby 1 had: Trouble feeding"
capture label var m5_baby2_issues_g "Since last spoke Baby 2 had: Trouble feeding"
capture label var m5_baby3_issues_g "Since last spoke Baby 3 had: Trouble feeding"
capture label var m5_baby1_issues_h "Since last spoke Baby 1 had: Convulsions"
capture label var m5_baby2_issues_h "Since last spoke Baby 2 had: Convulsions"
capture label var m5_baby3_issues_h "Since last spoke Baby 3 had: Convulsions"
capture label var m5_baby1_issues_i "Since last spoke Baby 1 had: Jaundice (that is, yellow color of the skin)"
capture label var m5_baby2_issues_i "Since last spoke Baby 2 had: Jaundice (that is, yellow color of the skin)"
capture label var m5_baby3_issues_i "Since last spoke Baby 3 had: Jaundice (that is, yellow color of the skin)"
capture label var m5_baby1_issues_j "Since last spoke Baby 1 had: Yellow palms or soles"
capture label var m5_baby2_issues_j "Since last spoke Baby 2 had: Yellow palms or soles"
capture label var m5_baby3_issues_j "Since last spoke Baby 3 had: Yellow palms or soles"
capture label var m5_baby1_issues_k "Since last spoke Baby 1 had: Experience Lethargic/unconscious "
capture label var m5_baby2_issues_k "Since last spoke Baby 2 had: Experience Lethargic/unconscious "
capture label var m5_baby3_issues_k "Since last spoke Baby 3 had: Experience Lethargic/unconscious "
capture label var m5_baby1_issues_l "Since last spoke Baby 1 had: Experience Bulged fontanels"
capture label var m5_baby2_issues_l "Since last spoke Baby 2 had: Experience Bulged fontanels"
capture label var m5_baby3_issues_l "Since last spoke Baby 3 had: Experience Bulged fontanels"


capture label var m5_baby1_issues_none "Since last spoke Baby 1 had: None of the above issues"
capture label var m5_baby2_issues_none "Since last spoke Baby 2 had: None of the above issues"
capture label var m5_baby1_issues_oth "Since last spoke Baby 1 had: Any other health issues"
capture label var m5_baby2_issues_oth "Since last spoke Baby 2 had: Any other health issues"
capture label var m5_baby3_issues_oth "Since last spoke Baby 3 had: Any other health issues"
capture label var m5_baby1_issues_oth_text "Since last spoke Baby 1 had: Any other health issues specified"
capture label var m5_baby2_issues_oth_text "Since last spoke Baby 2 had: Any other health issues specified"
capture label var m5_baby3_issues_oth_text "Since last spoke Baby 3 had: Any other health issues specified"

capture label var m5_baby1_death "Know when Baby 1 died"
capture label var m5_baby2_death "Know when Baby 2 died"
capture label var m5_baby3_death "Know when Baby 3 died"


capture label var m5_baby1_death_date "Baby 1: Death date"
capture label var m5_baby2_death_date "Baby 2: Death date"
capture label var m5_baby3_death_date "Baby 3: Death date"
capture label var m5_baby1_death_time "Baby 1: Age in weeks or days when died"
capture label var m5_baby1_death_time_unit "Baby 1: Unit used to answer how many days or weeks when baby died"
capture label var m5_baby2_death_time "Baby 2: Age in weeks or days when died"
capture label var m5_baby2_death_time_unit "Baby 2: Unit used to answer how many days or weeks when baby died"

capture label var m5_baby1_death_age "Baby 1: Age in weeks or days when died"
capture label var m5_baby2_death_age "Baby 2: Age in weeks or days when died"
capture label var m5_baby3_death_age "Baby 3: Age in weeks or days when died"

capture label var m5_baby1_death_cause "Baby 1: Cause of death"
capture label var m5_baby1_death_cause_a "Baby 1 Cause of death: Not told anything"
capture label var m5_baby1_death_cause_b "Baby 1 Cause of death: The baby was premature (born too early)"
capture label var m5_baby1_death_cause_c "Baby 1 Cause of death: A birth injury or asphyxia(due to delivery complications)"
capture label var m5_baby1_death_cause_d "Baby 1 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m5_baby1_death_cause_e "Baby 1 Cause of death: Malaria"
capture label var m5_baby1_death_cause_f "Baby 1 Cause of death: An acute respiratory infection"
capture label var m5_baby1_death_cause_g "Baby 1 Cause of death: Diarrhea"
capture label var m5_baby1_death_cause_h "Baby 1 Cause of death: Another type of infection"
capture label var m5_baby1_death_cause_i "Baby 1 Cause of death: Severe acute malnutrition"
capture label var m5_baby1_death_cause_j "Baby 1 Cause of death: An accident or injury"
capture label var m5_baby1_death_cause_oth "Baby 1 Cause of death: Another cause"
capture label var m5_baby1_death_cause_98 "Baby 1 Cause of death: Don't know"
capture label var m5_baby1_death_cause_99 "Baby 1 Cause of death: No response/Refused to answer"
capture label var m5_baby1_deathcause_other "Baby 1 Cause of death: Other cause specified"
capture label var m5_baby1_death_cause_oth_text "Baby 1 Cause of death: Other cause specified"

capture label var m5_baby2_death_cause "Baby 2: Cause of death"
capture label var m5_baby2_death_cause_a "Baby 2 Cause of death: Not told anything"
capture label var m5_baby2_death_cause_b "Baby 2 Cause of death: The baby was premature (born too early)"
capture label var m5_baby2_death_cause_c "Baby 2 Cause of death: A birth injury or asphyxia(due to delivery complications)"
capture label var m5_baby2_death_cause_d "Baby 2 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m5_baby2_death_cause_e "Baby 2 Cause of death: Malaria"
capture label var m5_baby2_death_cause_f "Baby 2 Cause of death: An acute respiratory infection"
capture label var m5_baby2_death_cause_g "Baby 2 Cause of death: Diarrhea"
capture label var m5_baby2_death_cause_h "Baby 2 Cause of death: Another type of infection"
capture label var m5_baby2_death_cause_i "Baby 2 Cause of death: Severe acute malnutrition"
capture label var m5_baby2_death_cause_j "Baby 2 Cause of death: An accident or injury"
capture label var m5_baby2_death_cause_oth "Baby 2 Cause of death: Another cause"

capture label var m5_baby2_death_cause_98 "Baby 2 Cause of death: Don't know"
capture label var m5_baby2_death_cause_99 "Baby 2 Cause of death: No response/Refused to answer"
capture label var m5_baby2_deathcause_other "Baby 2 Cause of death: Other cause specified"
capture label var m5_baby2_death_cause_oth_text "Baby 2 Cause of death: Other cause specified"

capture label var m5_baby3_death_cause "Baby 3: Cause of death"
capture label var m5_baby3_deathcause_other "Baby 3 Cause of death: Other cause specified"
capture label var m5_baby3_death_cause_a "Baby 3 Cause of death: Not told anything"
capture label var m5_baby3_death_cause_b "Baby 3 Cause of death: The baby was premature (born too early)"
capture label var m5_baby3_death_cause_c "Baby 3 Cause of death: A birth injury or asphyxia(due to delivery complications)"
capture label var m5_baby3_death_cause_d "Baby 3 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m5_baby3_death_cause_e "Baby 3 Cause of death: Malaria"
capture label var m5_baby3_death_cause_f "Baby 3 Cause of death: An acute respiratory infection"
capture label var m5_baby3_death_cause_g "Baby 3 Cause of death: Diarrhea"
capture label var m5_baby3_death_cause_h "Baby 3 Cause of death: Another type of infection"
capture label var m5_baby3_death_cause_i "Baby 3 Cause of death: Severe acute malnutrition"
capture label var m5_baby3_death_cause_j "Baby 3 Cause of death: An accident or injury"
capture label var m5_baby3_death_cause_oth "Baby 3 Cause of death: Another cause"

capture label var m5_baby2_death_cause_98 "Baby 2 Cause of death: Don't know"
capture label var m5_baby2_death_cause_99 "Baby 2 Cause of death: No response/Refused to answer"
capture label var m5_baby2_deathcause_other "Baby 2 Cause of death: Other cause specified"
capture label var m5_baby2_death_cause_oth_text "Baby 2 Cause of death: Other cause specified"



capture label var m5_baby1_advice "Baby 1: Before baby's death did you seek advice or treatment for illness?"

capture label var m5_baby2_advice "Baby 2: Before baby's death did you seek advice or treatment for illness?"
capture label var m5_baby3_advice "Baby 3: Before baby's death did you seek advice or treatment for illness?"

capture label var m5_baby1_deathloc "Baby 1: Location of death"
capture label var m5_baby2_deathloc "Baby 2: Location of death"
capture label var m5_baby3_deathloc "Baby 3: Location of death"
*capture label var m5_death_loc_oth "Baby 1: Location of death: Other specified"

*capture label var  "Baby 2: Location of death: Other specified"
*capture label var  "Baby 3: Location of death: Other specified"

capture label var m5_health "Since last spoke: Rate overall health"
capture label var m5_health_a "Describe current mobility status"
capture label var m5_health_b "Describe current ability to do self care"
capture label var m5_health_c "Describe current ability to do daily activities"
capture label var m5_health_d "Describe experience with pain or discomfort"
capture label var m5_health_e "Describe experience with anxiety or depression"
capture label var m5_depression_a "Frequency in past 2wks: Little interest or pleasure in doing things"
capture label var m5_depression_b "Frequency in past 2wks: Feeling down, depressed, or hopeless"
capture label var m5_depression_c "Frequency in past 2wks: Trouble falling or staying asleep, or sleeping too much"
capture label var m5_depression_d "Frequency in past 2wks: Feeling tired or having little energy"
capture label var m5_depression_e "Frequency in past 2wks: Poor appetite or overeating"
capture label var m5_depression_f "Frequency in past 2wks: Feeling bad about self/failure/let self or family down"
capture label var m5_depression_g "Frequency in past 2wks: Trouble concentrating on things (work or home duties)"
capture label var m5_depression_h "Frequency in past 2wks: Moving/speaking slowly or fidgety/restless"
capture label var m5_depression_i "Frequency in past 2wks: Thoughts would be better off dead or hurting self"
capture label var m5_depression_sum "Sum of day in past 2wks: bothered by depression"

capture label var m5_phq9_score "Over past 2wks: Sum days bothered by depression (depression_a-depression_i)"
capture label var m5_affecthealth_scale "Past 7 days: Impact of health problems on work productivity 0=none 10=completely"

capture label var m5_feeling_a "Since birth feel towards baby: Loving"
capture label var m5_feeling_b "Since birth feel towards baby: Resentful"
capture label var m5_feeling_c "Since birth feel towards baby: Neutral or felt nothing"
capture label var m5_feeling_d "Since birth feel towards baby: Joyful"
capture label var m5_feeling_e "Since birth feel towards baby: Dislike"
capture label var m5_feeling_f "Since birth feel towards baby: Protective"
capture label var m5_feeling_g "Since birth feel towards baby: Disappointed"
capture label var m5_feeling_h "Since birth feel towards baby: Aggressive"
capture label var m5_pain "Past 30 days how much has pain affected satisfaction with sex life"
capture label var m5_leakage "Experienced constant leakage of urine or stool from vagina during day or night"
capture label var m5_leakage_when "Days after birth symptoms started"
capture label var m5_leakage_affect "How much problem interferes with everyday life"
capture label var m5_leakage_tx "Sought treatment for constant leakage"
capture label var m5_leakage_no_treatment "Why have not sought treatment for constant leakage"

capture label var m5_leakage_notx_reason_oth "Why have not sought treatment for constant leakage: Other specified"
capture label var m5_leakage_txeffect "Treatment stopped constant leakage"

capture label var m5_401 "Rate quality of care in country"
capture label var m5_402 "Overall view of health care system"
capture label var m5_403 "Confidence would receive good care in health system"
capture label var m5_404 "Confidence could afford care without financial hardship"
capture label var m5_405a "Confidence you are responsible for managing your overall health"
capture label var m5_405b "Confidence can tell healthcare provider concerns even when not asked"
capture label var m5_406a "Since first ANC Experienced: A medical mistake in your treatment or care"
capture label var m5_406b "Since first ANC Experienced: Treated unfairly/discriminated against by provider"

capture label var m5_501a "Since last spoke: You or baby(ies) seen/attended to by a healthcare provider"
capture label var m5_501b "Since last spoke: New health care consultations for self"
capture label var m5_502 "Since last spoke: Number of new health care consultations for self"
capture label var m5_503_1 "Since last spoke: Location of 1st new consultation"
capture label var m5_503_2 "Since last spoke: Location of 2nd new consultation"
capture label var m5_503_3 "Since last spoke: Location of 3rd new consultation"
capture label var m5_503_4 "Since last spoke: Location of 4th new consultation"
capture label var m5_503_5 "Since last spoke: Location of 5th new consultation"
capture label var m5_503_6 "Since last spoke: Location of 6th new consultation"
capture label var m5_503_7 "Since last spoke: Location of 7th new consultation"
capture label var m5_503_8 "Since last spoke: Location of 8th new consultation"
capture label var m5_504a_1 "Since last spoke: Facility name where 1st consultation took place"
capture label var m5_504a_2 "Since last spoke: Facility name where 2nd consultation took place"
capture label var m5_504a_3 "Since last spoke: Facility name where 3rd consultation took place"

capture label var m5_505_1 "1st Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_2 "2nd Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_3 "3rd Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_4 "4th Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_5 "5th Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_6 "6th Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_7 "7th Consultation: For routine or regular checkup after delivery?"
capture label var m5_505_8 "8th Consultation: For routine or regular checkup after delivery?"


capture label var m5_504a_other_a_1 "Since last spoke: Facility name where 1st consultation: Other East Shewa/Adama"
capture label var m5_504a_other_b_1 "Since last spoke: Facility name where 1st consultation: Other outside zone"

capture label var m5_consultation1 "1st Consultation : All reasons for visit specified"
capture label var m5_consultation1_a "1st Consultation : New health problem for baby"
capture label var m5_consultation1_b "1st Consultation : New health problem for self"
capture label var m5_consultation1_c "1st Consultation : Existing health problem for baby"
capture label var m5_consultation1_d "1st Consultation : Existing health problem for self"
capture label var m5_consultation1_e "1st Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation1_f "1st Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation1_g "1st Consultation : To get a vaccine for baby"
capture label var m5_consultation1_h "1st Consultation : To get a vaccine for self"
capture label var m5_consultation1_i "1st Consultation : Pick up medicine for self"
capture label var m5_consultation1_j "1st Consultation : Pick up medicine for baby"
capture label var m5_consultation1_oth "1st Consultation : Other reasons"
capture label var m5_consultation1_oth_text "1st Consultation : Other reasons Specified"
capture label var m5_consultation1_98 "1st Consultation : Don't know"
capture label var m5_consultation1_99 "1st Consultation : No response/refusal"

capture label var m5_consultation2 "2nd Consultation : All reasons for visit specified"
capture label var m5_consultation2_a "2nd Consultation : New health problem for baby"
capture label var m5_consultation2_b "2nd Consultation : New health problem for self"
capture label var m5_consultation2_c "2nd Consultation : Existing health problem for baby"
capture label var m5_consultation2_d "2nd Consultation : Existing health problem for self"
capture label var m5_consultation2_e "2nd Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation2_f "2nd Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation2_g "2nd Consultation : To get a vaccine for baby"
capture label var m5_consultation2_h "2nd Consultation : To get a vaccine for self"
capture label var m5_consultation2_i "2nd Consultation : Pick up medicine for self"
capture label var m5_consultation2_j "2nd Consultation : Pick up medicine for baby"
capture label var m5_consultation2_oth "2nd Consultation : Other reasons"
capture label var m5_consultation2_oth_text "2nd Consultation : Other reasons Specified"
capture label var m5_consultation2_98 "2nd Consultation : Don't know"
capture label var m5_consultation2_99 "2nd Consultation : No response/refusal"

capture label var m5_consultation3 "3rd Consultation : All reasons for visit specified"
capture label var m5_consultation3_a "3rd Consultation : New health problem for baby"
capture label var m5_consultation3_b "3rd Consultation : New health problem for self"
capture label var m5_consultation3_c "3rd Consultation : Existing health problem for baby"
capture label var m5_consultation3_d "3rd Consultation : Existing health problem for self"
capture label var m5_consultation3_e "3rd Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation3_f "3rd Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation3_g "3rd Consultation : To get a vaccine for baby"
capture label var m5_consultation3_h "3rd Consultation : To get a vaccine for self"
capture label var m5_consultation3_i "3rd Consultation : Pick up medicine for self"
capture label var m5_consultation3_j "3rd Consultation : Pick up medicine for baby"
capture label var m5_consultation3_oth "3rd Consultation : Other reasons"
capture label var m5_consultation3_oth_text "3rd Consultation : Other reasons Specified"
capture label var m5_consultation3_98 "3rd Consultation : Don't know"
capture label var m5_consultation3_99 "3rd Consultation : No response/refusal"

capture label var m5_consultation4 "4th Consultation : All reasons for visit specified"
capture label var m5_consultation4_a "4th Consultation : New health problem for baby"
capture label var m5_consultation4_b "4th Consultation : New health problem for self"
capture label var m5_consultation4_c "4th Consultation : Existing health problem for baby"
capture label var m5_consultation4_d "4th Consultation : Existing health problem for self"
capture label var m5_consultation4_e "4th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation4_f "4th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation4_g "4th Consultation : To get a vaccine for baby"
capture label var m5_consultation4_h "4th Consultation : To get a vaccine for self"
capture label var m5_consultation4_i "4th Consultation : Pick up medicine for self"
capture label var m5_consultation4_j "4th Consultation : Pick up medicine for baby"
capture label var m5_consultation4_oth "4th Consultation : Other reasons"
capture label var m5_consultation4_oth_text "4th Consultation : Other reasons Specified"
capture label var m5_consultation4_98 "4th Consultation : Don't know"
capture label var m5_consultation4_99 "4th Consultation : No response/refusal"

capture label var m5_consultation5 "5th Consultation : All reasons for visit specified"
capture label var m5_consultation5_a "5th Consultation : New health problem for baby"
capture label var m5_consultation5_b "5th Consultation : New health problem for self"
capture label var m5_consultation5_c "5th Consultation : Existing health problem for baby"
capture label var m5_consultation5_d "5th Consultation : Existing health problem for self"
capture label var m5_consultation5_e "5th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation5_f "5th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation5_g "5th Consultation : To get a vaccine for baby"
capture label var m5_consultation5_h "5th Consultation : To get a vaccine for self"
capture label var m5_consultation5_i "5th Consultation : Pick up medicine for self"
capture label var m5_consultation5_j "5th Consultation : Pick up medicine for baby"
capture label var m5_consultation5_oth "5th Consultation : Other reasons"
capture label var m5_consultation5_oth_text "5th Consultation : Other reasons Specified"
capture label var m5_consultation5_98 "5th Consultation : Don't know"
capture label var m5_consultation5_99 "5th Consultation : No response/refusal"
				  
capture label var m5_consultation6 "6th Consultation : All reasons for visit specified"
capture label var m5_consultation6_a "6th Consultation : New health problem for baby"
capture label var m5_consultation6_b "6th Consultation : New health problem for self"
capture label var m5_consultation6_c "6th Consultation : Existing health problem for baby"
capture label var m5_consultation6_d "6th Consultation : Existing health problem for self"
capture label var m5_consultation6_e "6th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation6_f "6th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation6_g "6th Consultation : To get a vaccine for baby"
capture label var m5_consultation6_h "6th Consultation : To get a vaccine for self"
capture label var m5_consultation6_i "6th Consultation : Pick up medicine for self"
capture label var m5_consultation6_j "6th Consultation : Pick up medicine for baby"
capture label var m5_consultation6_oth "6th Consultation : Other reasons"
capture label var m5_consultation6_oth_text "6th Consultation : Other reasons Specified"
capture label var m5_consultation6_98 "6th Consultation : Don't know"
capture label var m5_consultation6_99 "6th Consultation : No response/refusal"

capture label var m5_consultation7 "7th Consultation : All reasons for visit specified"
capture label var m5_consultation7_a "7th Consultation : New health problem for baby"
capture label var m5_consultation7_b "7th Consultation : New health problem for self"
capture label var m5_consultation7_c "7th Consultation : Existing health problem for baby"
capture label var m5_consultation7_d "7th Consultation : Existing health problem for self"
capture label var m5_consultation7_e "7th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation7_f "7th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation7_g "7th Consultation : To get a vaccine for baby"
capture label var m5_consultation7_h "7th Consultation : To get a vaccine for self"
capture label var m5_consultation7_i "7th Consultation : Pick up medicine for self"
capture label var m5_consultation7_j "7th Consultation : Pick up medicine for baby"
capture label var m5_consultation7_oth "7th Consultation : Other reasons"
capture label var m5_consultation7_oth_text "7th Consultation : Other reasons Specified"
capture label var m5_consultation7_98 "7th Consultation : Don't know"
capture label var m5_consultation7_99 "7th Consultation : No response/refusal"

capture label var m5_consultation8 "8th Consultation : All reasons for visit specified"
capture label var m5_consultation8_a "8th Consultation : New health problem for baby"
capture label var m5_consultation8_b "8th Consultation : New health problem for self"
capture label var m5_consultation8_c "8th Consultation : Existing health problem for baby"
capture label var m5_consultation8_d "8th Consultation : Existing health problem for self"
capture label var m5_consultation8_e "8th Consultation : Lab test, x-ray or ultrasound for self"
capture label var m5_consultation8_f "8th Consultation : Lab test, x-ray or ultrasound for baby"
capture label var m5_consultation8_g "8th Consultation : To get a vaccine for baby"
capture label var m5_consultation8_h "8th Consultation : To get a vaccine for self"
capture label var m5_consultation8_i "8th Consultation : Pick up medicine for self"
capture label var m5_consultation8_j "8th Consultation : Pick up medicine for baby"
capture label var m5_consultation8_oth "8th Consultation : Other reasons"
capture label var m5_consultation8_oth_text "8th Consultation : Other reasons Specified"
capture label var m5_consultation8_98 "8th Consultation : Don't know"
capture label var m5_consultation8_99 "8th Consultation : No response/refusal"

capture label var m5_consultation3_oth_text "3rd Consultation : Other reasons Specified"
capture label var m5_no_visit "Since last spoke: Main reason prevented you from receiving PNC/postpartum care"

capture label var m5_no_visit_oth "Since last spoke: Other reason did not receive PNC or postpartum care specified"
capture label var m5_consultation1_carequality  "1st Consultation: Rate overall quality of care received"
capture label var m5_consultation2_carequality  "2nd Consultation: Rate overall quality of care received"
capture label var m5_consultation3_carequality  "3rd Consultation: Rate overall quality of care received"
capture label var m5_consultation4_carequality  "4th Consultation: Rate overall quality of care received"
capture label var m5_consultation5_carequality  "5th Consultation: Rate overall quality of care received"
capture label var m5_consultation6_carequality  "6th Consultation: Rate overall quality of care received"
capture label var m5_consultation7_carequality  "7th Consultation: Rate overall quality of care received"
capture label var m5_consultation8_carequality  "8th Consultation: Rate overall quality of care received"

capture label var m5_baby1_701a "Since last spoke Baby 1: Had their temperature taken (using a thermometer)"
capture label var m5_baby2_701a "Since last spoke Baby 2: Had their temperature taken (using a thermometer)"

capture label var m5_baby1_701b "Since last spoke Baby 1: Had their weight taken (using a scale)"
capture label var m5_baby2_701b "Since last spoke Baby 2: Had their weight taken (using a scale)"

capture label var m5_baby1_701c "Since last spoke Baby 1: Had their length measured (using a measuring tape)"
capture label var m5_baby2_701c "Since last spoke Baby 2: Had their length measured (using a measuring tape)"

capture label var m5_baby1_701d "Since last spoke Baby 1: Had eyes examined"
capture label var m5_baby2_701d "Since last spoke Baby 2: Had eyes examined"

capture label var m5_baby1_701e "Since last spoke Baby 1: Had hearing checked"
capture label var m5_baby2_701e "Since last spoke Baby 2: Had hearing checked"

capture label var m5_baby1_701f "Since last spoke Baby 1: Had chest listened to with a stethoscope"
capture label var m5_baby2_701f "Since last spoke Baby 2: Had chest listened to with a stethoscope"

capture label var m5_baby1_701g "Since last spoke Baby 1: Had a blood test using a finger prick "
capture label var m5_baby2_701g "Since last spoke Baby 2: Had a blood test using a finger prick "

capture label var m5_baby1_701h "Since last spoke Baby 1: Had a malaria test"
capture label var m5_baby2_701h "Since last spoke Baby 2: Had a malaria test"

capture label var m5_baby1_701i "Since last spoke Baby 1: Had any other test"
capture label var m5_baby2_701i "Since last spoke Baby 2: Had any other test"

capture label var m5_baby1_701_other "Since last spoke Baby 1: Had any other test specified"
capture label var m5_baby2_701_other "Since last spoke Baby 2: Had any other test specified"

capture label var m5_baby1_701i_other "Since last spoke Baby 1: Had any other test specified"
capture label var m5_baby2_701i_other "Since last spoke Baby 2: Had any other test specified"

capture label var m5_702a "Provider discussed Baby 1: How often the baby eats"
capture label var m5_702b "Provider discussed Baby 1: What the baby should eat (breastmilk/other food)"
capture label var m5_702c "Provider discussed Baby 1: Vaccinations for the baby"
capture label var m5_702d "Provider discussed Baby 1: Baby's sleeping position (on back/their stomach)"
capture label var m5_702e "Provider discussed Baby 1: Dangerous symptoms requiring health facility"
capture label var m5_702f "Provider discussed Baby 1: How you should play and interact with the baby"
capture label var m5_702g "Provider discussed Baby 1: Taking baby to the hospital or to see a specialist"

capture label var m5_baby1_703a "Advise for Baby 1 issues: Did not speak about this with provider"
capture label var m5_baby2_703a "Advise for Baby 2 issues: Did not speak about this with provider"
capture label var m5_baby1_703b "Advise for Baby 1 issues: Provider told you symptoms not serious, nothing to do"
capture label var m5_baby2_703b "Advise for Baby 2 issues: Provider told you symptoms not serious, nothing to do"
capture label var m5_baby1_703c "Advise for Baby 1 issues: Provider told you to monitor and return if worsen"
capture label var m5_baby2_703c "Advise for Baby 2 issues: Provider told you to monitor and return if worsen"
capture label var m5_baby1_703d "Advise for Baby 1 issues:  Provider told you to get medication"
capture label var m5_baby2_703d "Advise for Baby 2 issues:  Provider told you to get medication"
capture label var m5_baby1_703e "Advise for Baby 1 issues: Provider gave you advice on feeding"
capture label var m5_baby2_703e "Advise for Baby 2 issues: Provider gave you advice on feeding"
capture label var m5_baby1_703f "Advise for Baby 1 issues: Provider told you to get a lab test or imaging"
capture label var m5_baby2_703f "Advise for Baby 2 issues: Provider told you to get a lab test or imaging"
capture label var m5_baby1_703g "Advise for Baby 1 issues: Provider told you to go to hospital or see specialist"
capture label var m5_baby2_703g "Advise for Baby 2 issues: Provider told you to go to hospital or see specialist"
capture label var m5_baby1_703_96 "Advise for Baby 1 issues: Other"
capture label var m5_baby2_703_96 "Advise for Baby 2 issues: Other"
capture label var m5_baby1_703_98 "Advise for Baby 1 issues: Don't know"
capture label var m5_baby2_703_98 "Advise for Baby 2 issues: Don't know"
capture label var m5_baby1_703_99 "Advise for Baby 1 issues: No Response/Refused to answer"
capture label var m5_baby2_703_99 "Advise for Baby 2 issues: No Response/Refused to answer"


capture label var m5_baby1_703_other "Advise for Baby 1 issues: Other specified"
capture label var m5_baby2_703_other "Advise for Baby 2 issues: Other specified"


capture label var m5_801a "Since last spoke have you had: Your blood pressure measured (cuff around arm)"
capture label var m5_801b "Since last spoke have you had: Your temperature taken (with a thermometer)"
capture label var m5_801c "Since last spoke have you had: A vaginal exam"
capture label var m5_801d "Since last spoke have you had: A blood draw (blood taken from arm with syringe)"
capture label var m5_801e "Since last spoke have you had: A blood test using a finger prick"
capture label var m5_801f "Since last spoke have you had: An HIV test"
capture label var m5_801g "Since last spoke have you had: A urine test (peed in a container)"
capture label var m5_801h "Since last spoke have you had: Any other test or examination"
capture label var m5_801_other "Since last spoke have you had: Other test or examination specified"
capture label var m5_802 "Since last spoke: Provider examined C-section scar"
capture label var m5_803a "Since last spoke Provider discussed: How to take care of breasts"
capture label var m5_803b "Since last spoke Provider discussed: Danger signs for self"
capture label var m5_803c "Since last spoke Provider discussed: Your level of anxiety/depression"
capture label var m5_803d "Since last spoke Provider discussed: Family planning options"
capture label var m5_803e "Since last spoke Provider discussed: Resuming sexual activity"
capture label var m5_803f "Since last spoke Provider discussed: Importance of exercise"
capture label var m5_803g "Since last spoke Provider discussed: Importance sleeping under bed net"
capture label var m5_804a  "Since last spoke: Have you had a session of psychological counseling/therapy "
capture label var m5_804b  "Since delivery: Number of psychological counseling/therapy  sessions"
capture label var m5_804c "Since delivery: Minutes each session of psychological counseling/therapy lasted"
capture label var m5_901a "Since last spoke received/bought for self: Iron or folic acid pills"
capture label var m5_901b "Since last spoke received/bought for self: Iron drip/injection"
capture label var m5_901c "Since last spoke received/bought for self: Calcium pills"
capture label var m5_901d "Since last spoke received/bought for self: Multivitamins"
capture label var m5_901e "Since last spoke received/bought for self: Food supplements"
capture label var m5_901f "Since last spoke received/bought for self: Medicine for intestinal worms "
capture label var m5_901g "Since last spoke received/bought for self: Medicine for malaria "
capture label var m5_901h "Since last spoke received/bought for self: Medicine for HIV/ARVs"
capture label var m5_901i "Since last spoke received/bought for self: Medicine for mental health"
capture label var m5_901j "Since last spoke received/bought for self: Medicine for hypertension/HBP"
capture label var m5_901k "Since last spoke received/bought for self: Medicine for diabetes"
capture label var m5_901l "Since last spoke received/bought for self: Antibiotics for an infection"
capture label var m5_901m "Since last spoke received/bought for self: Aspirin"
capture label var m5_901n "Since last spoke received/bought for self: Paracetamol/other pain relief drugs"
capture label var m5_901o "Since last spoke received/bought for self: Contraceptive pills"
capture label var m5_901p "Since last spoke received/bought for self: Contraceptive injection"
capture label var m5_901q "Since last spoke received/bought: Other contraception method-not pills/injection"
capture label var m5_901r "Since last spoke received/bought: Antifungal medicine"

capture label var m5_901s "Since last spoke received/bought: Any other medicine or supplement"
capture label var m5_901s_other "Since last spoke received/bought: Any other medicine or supplement specified"

capture label var m5_901s_other "Since last spoke received/bought: Any other medicine or supplement specified"

capture label var m5_baby1_902a  "Since last spoke Baby 1 received: Iron supplements"
capture label var m5_baby2_902a  "Since last spoke Baby 2 received: Iron supplements"
capture label var m5_baby3_902a "Since last spoke Baby 3 received: Iron supplements"
capture label var m5_baby1_902b  "Since last spoke Baby 1 received: Vitamin A supplements"
capture label var m5_baby2_902b  "Since last spoke Baby 2 received: Vitamin A supplements"
capture label var m5_baby1_902c  "Since last spoke Baby 1 received: Vitamin D supplements"
capture label var m5_baby2_902c  "Since last spoke Baby 2 received: Vitamin D supplements"
capture label var m5_baby1_902d "Since last spoke Baby 1 received: Oral rehydration salts (ORS)"
capture label var m5_baby2_902d "Since last spoke Baby 2 received: Oral rehydration salts (ORS)"
capture label var m5_baby1_902e "Since last spoke Baby 1 received: Antidiarrheal"
capture label var m5_baby2_902e "Since last spoke Baby 2 received: Antidiarrheal"
capture label var m5_baby1_902f  "Since last spoke Baby 1 received: Antibiotics for an infection"
capture label var m5_baby2_902f  "Since last spoke Baby 2 received: Antibiotics for an infection"
capture label var m5_baby1_902g  "Since last spoke Baby 1 received: Medicine to prevent pneumonia"
capture label var m5_baby2_902g  "Since last spoke Baby 2 received: Medicine to prevent pneumonia"
capture label var m5_baby1_902h  "Since last spoke Baby 1 received: Medicine for malaria"
capture label var m5_baby2_902h  "Since last spoke Baby 2 received: Medicine for malaria"
capture label var m5_baby1_902i  "Since last spoke Baby 1 received: Medicine for HIV/ARVs"
capture label var m5_baby2_902i  "Since last spoke Baby 2 received: Medicine for HIV/ARVs"
capture label var m5_baby1_902j  "Since last spoke Baby 1 received: Any other medicine or supplement"
capture label var m5_baby2_902j  "Since last spoke Baby 2 received: Any other medicine or supplement"
capture label var m5_baby1_902_other "Since last spoke Baby 1 received: Any other medicine or supplement specified"
capture label var m5_baby2_902_other "Since last spoke Baby 2 received: Any other medicine or supplement specified"

capture label var m5_902_other "Since last spoke baby/ies received: Any other medicine or supplement specified"

capture label var m5_903_other "Since last spoke Baby 1 received: Any other vaccines or immunizations"
capture label var m5_903_oth_text "Since last spoke Baby 1 received: Any other vaccines/immunizations specified"

capture label var m5_baby1_903a "Since last spoke Baby 1 received: BCG vaccine (against TB - injection in arm)"
capture label var m5_baby2_903a "Since last spoke Baby 2 received: BCG vaccine (against TB - injection in arm)"
capture label var m5_baby1_903b "Since last spoke Baby 1 received: Polio vaccine (Two drops orally or injection)"
capture label var m5_baby2_903b "Since last spoke Baby 2 received: Polio vaccine (Two drops orally or injection)"
capture label var m5_baby1_903c "Since last spoke Baby 1 received: Pentavalent vaccination (Injection in thigh)"
capture label var m5_baby2_903c "Since last spoke Baby 2 received: Pentavalent vaccination (Injection in thigh)"
capture label var m5_baby1_903d "Since last spoke Baby 1 received: Pneumococcal vaccination (Injection in thigh)"
capture label var m5_baby2_903d "Since last spoke Baby 2 received: Pneumococcal vaccination (Injection in thigh)"
capture label var m5_baby1_903e "Since last spoke Baby 1 received: Rotavirus vaccination (Liquid in mouth)"
capture label var m5_baby2_903e "Since last spoke Baby 2 received: Rotavirus vaccination (Liquid in mouth)"

capture label var m5_baby1_903f "Since last spoke Baby 1 received: Any other vaccines or immunizations"
capture label var m5_baby2_903f "Since last spoke Baby 2 received: Any other vaccines or immunizations"

capture label var m5_baby1_903_other "Since last spoke Baby 1 received: Any other vaccines or immunizations specified"
capture label var m5_baby2_903_other "Since last spoke Baby 2 received: Any other vaccines or immunizations specified"

capture label var m5_baby1_904  "Baby 1: Where did they  get these vaccines?"
capture label var m5_baby2_904  "Baby 2: Where did they  get these vaccines?"
capture label var m5_904_baby1_other "Baby 1: Where did they  get these vaccines: Other specified"
capture label var m5_904_baby2_other "Baby 2: Where did they  get these vaccines: Other specified"
capture label var m5_905 "Total amount paid for new meications or supplements for self/baby(ies)"

capture label var m5_1001 "Paid money out of pocket for new visits"

capture label var m5_1002a "Amount spent on: Registration/consultation"
capture label var m5_1002a_yn "Spent money on: Registration/consultation"

capture label var m5_1002b "Amount spent on: Test or investigations (lab tests, ultrasound etc.)"
capture label var m5_1002b_yn "Spent money on: Test or investigations (lab tests, ultrasound etc.)"

capture label var m5_1002c "Amount spent on: Transport round trip (+ accompanying person)"
capture label var m5_1002c_yn "Spent money on: Transport round trip (+ accompanying person)"

capture label var m5_1002d "Amount spent on: Food /accommodation (+ accompanying person)"
capture label var m5_1002d_yn "Spent money on: Food /accommodation (+ accompanying person)"

capture label var m5_1002e_yn "Spent money on other service or product"
capture label var m5_1002e "Amount spent on: Other service or product"

capture label var m5_1002_other "Amount spent on: Other service or product specified "
capture label var m5_1003_confirm "Confirm total amount spent is correct : Yes/no"
capture label var m5_1003 "Total amount spent"
capture label var m5_1004 "Correct total amount spent"

capture label var m5_1005 "Financial source used: All methods listed"
capture label var m5_1005a "Financial source used: Current income of any household members"
capture label var m5_1005b "Financial source used: Savings (bank account)"
capture label var m5_1005c "Financial source used: Payment/reimbursement from health insurance"
capture label var m5_1005d "Financial source used: Sold items (furniture, animals, jewellery)"
capture label var m5_1005e "Financial source used: Family members/friends outside household"
capture label var m5_1005f "Financial source used: Borrowed (other than friend or family)"
capture label var m5_1005_other "Financial source used: Other"
capture label var m5_1005_oth_text "Financial source used: Other specified"
capture label var m5_1005_other_text "Financial source used: Other specified"

capture label var m5_1101 "During pregnancy/post delivery: Anyone physically hurt you (hit/slapped/kicked)"

capture label var m5_1102a "Physically hurt you: Current husband / partner"
capture label var m5_1102b "Physically hurt you: Parent (mother, father, step-parent, in-law)"
capture label var m5_1102c "Physically hurt you: Sibling "
capture label var m5_1102d "Physically hurt you: Child "
capture label var m5_1102e "Physically hurt you: Late /last / ex-husband/partner"
capture label var m5_1102f "Physically hurt you: Other relative "
capture label var m5_1102g "Physically hurt you: Friend/acquaintance "
capture label var m5_1102h "Physically hurt you: Teacher"
capture label var m5_1102i "Physically hurt you: Employer"
capture label var m5_1102j "Physically hurt you: Stranger"
capture label var m5_1102_other "Physically hurt you: Other"
capture label var m5_1102_98 "Physically hurt you: Don't know "
capture label var m5_1102_99 "Physically hurt you: No response/Refuse to answer "

capture label var m5_1102 "Who physically hurt you"

capture label var m5_1103 "During pregnancy/post delivery: Humilated/insulted/made to feel bad about self"

capture label var m5_1104 "Who Humilated, insulted or made feel bad about self"

capture label var m5_1104a "Humilated, insulted or made feel bad about self: Current husband / partner"
capture label var m5_1104b "Humilated, insulted or made feel bad about self: Parent"
capture label var m5_1104c "Humilated, insulted or made feel bad about self: Sibling"
capture label var m5_1104d "Humilated, insulted or made feel bad about self: Child"
capture label var m5_1104e "Humilated, insulted or made feel bad about self: Late/ last/ ex-husband/partner"
capture label var m5_1104f "Humilated, insulted or made feel bad about self: Other relative"
capture label var m5_1104g "Humilated, insulted or made feel bad about self: Friend/acquaintance"
capture label var m5_1104h "Humilated, insulted or made feel bad about self: Teacher"
capture label var m5_1104i "Humilated, insulted or made feel bad about self: Employer"
capture label var m5_1104j "Humilated, insulted or made feel bad about self: Stranger"
capture label var m5_1104_other "Humilated, insulted or made feel bad about self: Other"
capture label var m5_1104_98 "Humilated, insulted or made feel bad about self: Don't Know"
capture label var m5_1104_99 "Humilated, insulted or made feel bad about self: No Response/Refused to answer"
capture label var m5_1105 "During pregnancy/post delivery: Provider discuss where to seek support "
capture label var m5_1201 "Rate overall satisfaction: Health services received during pregnancy & delivery"
capture label var m5_1202a "Total monthly household income on average"
capture label var m5_1202b "Categorized: Total monthly household income on average"
capture label var m5_height  "At the conclusion of survey: Height  (cm)"
capture label var m5_weight  "At the conclusion of survey: Weight (kilograms)"
capture label var m5_muac "At the conclusion of survey:  Upper arm circumference"


capture label var m5_sbp1 "At the conclusion of survey: Blood pressure 1: Systolic"
capture label var m5_dbp1 "At the conclusion of survey: Blood pressure 1: Diastolic"
capture label var m5_hr1 "At the conclusion of survey: Blood pressure 1: Pulse rate"
capture label var m5_pr1 "At the conclusion of survey: Blood pressure 1: Pulse rate"

capture label var m5_sbp2 "At the conclusion of survey: Blood pressure 2: Systolic"
capture label var m5_dbp2 "At the conclusion of survey: Blood pressure 2: Diastolic"
capture label var m5_hr2 "At the conclusion of survey: Blood pressure 2: Pulse rate"
capture label var m5_pr2 "At the conclusion of survey: Blood pressure 2: Pulse rate"

capture label var m5_sbp3 "At the conclusion of survey: Blood pressure 3: Systolic"
capture label var m5_dbp3 "At the conclusion of survey: Blood pressure 3: Diastolic"
capture label var m5_hr3 "At the conclusion of survey: Blood pressure 3: Pulse rate"
capture label var m5_pr3 "At the conclusion of survey: Blood pressure 3: Pulse rate"

capture label var m5_anemiatest  "At the conclusion of survey: Will you take the anemia test?"
capture label var m5_hb_level "At the conclusion of survey: Hemoglobin level"


capture label var m5_baby1_weight "At the conclusion of survey: Baby 1: Weight (kilograms)"
capture label var m5_baby2_weight "At the conclusion of survey: Baby 2: Weight (kilograms)"
capture label var m5_baby3_weight "At the conclusion of survey: Baby 3: Weight (kilograms)"
capture label var m5_baby1_length "At the conclusion of survey: Baby 1: Length (cm)"
capture label var m5_baby2_length "At the conclusion of survey: Baby 2: Length (cm)"
capture label var m5_baby3_length "At the conclusion of survey: Baby 3: Length (cm)"
capture label var m5_baby1_hc "At the conclusion of survey: Baby 1: Head circumference (cm)"
capture label var m5_baby2_hc "At the conclusion of survey: Baby 2: Head circumference (cm)"
capture label var m5_baby3_hc "At the conclusion of survey: Baby 3: Head circumference (cm)"

capture label var m5_complete "M5 Interview status"

capture label var m5_breastfeeding "As of today: Confidence in breastfeeding"

capture label var m5_submissiondate "Date and time of submission"

	
capture label var m5_baby1_feed_a "Baby 1: How baby fed"
capture label var m5_baby2_feed_a "Baby 2: How baby fed"
capture label var m5_baby3_feed_a "Baby 3: How baby fed"
	
capture label var m5_baby1_703a "Advise for Baby 1 issues"
	
capture label var m5_baby1_death_age "Baby 1: Age in weeks when died"
capture label var m5_baby2_death_age "Baby 2: Age in weeks when died"
capture label var m5_baby3_death_age "Baby 3: Age in weeks when died"

* Missing labels to add
capture label var m5_latitude "GPS latitude of interview location"
capture label var m5_longitude "GPS longitude of interview location"
capture label var m5_questionnaireid "Questionnaire ID"
capture label var m5_questionnairename "Questionnaire name"
capture label var m5_questionnaireversion "Questionnaire version"
capture label var m5_fieldworkerid "Field worker ID"
capture label var m5_fieldworker "Field worker name"
capture label var m5_studyno "Study number"
capture label var m5_studynoprefix "Study number prefix"
capture label var m5_studynumber "Full study number"

* Update currency references to South African Rand - NK to check this 
foreach var in m5_905 m5_1002a m5_1002b m5_1002c m5_1002d m5_1002e m5_1003 m5_1004 {
    local lbl : variable label `var'
    if "`lbl'" != "" {
        local newlbl = subinstr("`lbl'", "Ksh", "Rand", .)
        label var `var' "`newlbl'"
    }
}

* South Africa specific variables
capture label var m5_101 "Site ID"  
capture label var m5_102 "Client ID"
capture label var m5_103 "Catchment area"
capture label var m5_crhid "Record ID"
capture label var m5_baby1_issue_a "Since last spoke Baby 1 had: Diarrhea with blood in the stools"
capture label var m5_baby2_issue_a "Since last spoke Baby 2 had: Diarrhea with blood in the stools"

capture label var m5_baby2_available "Baby 2 available for measurement"
capture label var m5_703 "What provider told you about your/baby's health issues"
capture label var m5_user_exp "Overall experience at health facility"
