/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-10-24		1.00	MK Trimner		Original code
*******************************************************************************/

* This program will add shortened labels to the M1 datasts so that the codebook is helpful

* It will also add characters with the full text question
capture program drop m3_add_shortened_labels
program define m3_add_shortened_labels

capture label var m3_1004k "Rate: Cost to the service you received"
capture label var m3_101 "Interviewer ID"
capture label var m3_102 "Date of interview"
capture label var m3_date_p2 "Date of interview (2)"
capture label var m3_date_time "Start time of interview"
capture label var m3_103 "Time of interview"
capture label var m3_104 "Respondent ID"
capture label var m3_105 "Respondent first name"
capture label var m3_106 "Respondent last name"
capture label var m3_107 "Gestational age at this call"
capture label var m3_108 "HIV status"
capture label var m3_hiv_status "HIV Status"
capture label var respondentid "Respondent ID"


capture label var m3_109 "Maternal death reported"
capture label var m3_maternal_death_reported "Maternal death reported"
capture label var m3_maternal_death_learn "How did you learn about the maternal death? "
capture label var m3_maternal_death_learn_oth "How did you learn about the maternal death: Other specified"

capture label var m3_110 "Date of maternal death"
capture label var m3_date_of_maternal_death "Date of maternal death"
capture label var m3_date_of_maternal_death "Date of maternal death"

capture label var m3_111 "How did you learn about the maternal death?"
capture label var m3_111_other "How did you learn about the maternal death: Other specified"

capture label var m3_date "Date of interview"

*capture label var m3_201 "Rate overall health"

capture label var m3_303a "How many babies were you pregnant with?"

capture label var m3_303b "Baby1 still alive"
capture label var m3_303c "Baby2 still alive"

capture label var m3_201a "Baby1 still alive"
capture label var m3_201b "Baby2 still alive"
capture label var m3_201c "Baby3 still alive"

capture label var m3_202 "Status of birth based on gestational age at death"

*capture label var m2_202 "Pregnancy status"

capture label var m3_birth_or_ended_date "Date of giving birth or pregnancy ended calculation"
capture label var m3_birth_or_ended "Date delivered or pregnancy ended"
capture label var m3_birth_or_ended_provided "Date of delivery provided"

capture label var m3_301 "How many babies were you pregnant with?"
capture label var m3_302 "On what date did you deliver/did the pregnancy end?"

capture label var m3_313c_baby1 "Baby 1: Days or Hours after birth baby died"
capture label var m3_313c_baby2 "Baby 2: Days or Hours after birth baby died"

capture label var m3_313d_baby1 "Baby 1: Unit of time to measure how long after birth baby died"
capture label var m3_313d_baby2 "Baby 2: Unit of time to measure how long after birth baby died"

***************************************
capture label var m3_314_b1 "Baby 1: Cause of death"
capture label var m3_314_b2 "Baby 2: Cause of death"
capture label var m3_314_b3 "Baby 3: Cause of death"

capture label var m3_314_other_b1 "Baby 1: Cause of death Other specified"
capture label var m3_314_other_b2 "Baby 2: Cause of death Other specified"
capture label var m3_314_other_b3 "Baby 3: Cause of death Other specified"

capture label var m3_death_cause_baby1 "Baby 1: Cause of death"
capture label var m3_death_cause_baby2 "Baby 2: Cause of death"

capture label var m3_death_cause_baby1_a "Baby 1 Cause of death: Not told anything"
capture label var m3_death_cause_baby1_b "Baby 1 Cause of death: The baby was premature (born too early)"
capture label var m3_death_cause_baby1_c "Baby 1 Cause of death: An infection"
capture label var m3_death_cause_baby1_d "Baby 1 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m3_death_cause_baby1_e "Baby 1 Cause of death: Birth injury"
capture label var m3_death_cause_baby1_f "Baby 1 Cause of death: Difficulties breathing"
capture label var m3_death_cause_baby1_g "Baby 1 Cause of death: Unexplained causes"
capture label var m3_death_cause_baby1_96 "Baby 1 Cause of death: Other cause"
capture label var m3_death_cause_baby1_other "Baby 1: Cause of death Other specified"

capture label var m3_death_cause_baby2_a "Baby 2 Cause of death: Not told anything"
capture label var m3_death_cause_baby2_b "Baby 2 Cause of death: The baby was premature (born too early)"
capture label var m3_death_cause_baby2_c "Baby 2 Cause of death: An infection"
capture label var m3_death_cause_baby2_d "Baby 2 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m3_death_cause_baby2_e "Baby 2 Cause of death: Birth injury"
capture label var m3_death_cause_baby2_f "Baby 2 Cause of death: Difficulties breathing"
capture label var m3_death_cause_baby2_g "Baby 2 Cause of death: Unexplained causes"
capture label var m3_death_cause_baby2_96 "Baby 2 Cause of death: Other cause"
capture label var m3_death_cause_baby2_other "Baby 2: Cause of death Other specified"

capture label var m3_death_cause_baby3 "Baby 3: Cause of death"
capture label var m3_death_cause_baby3_a "Baby 3 Cause of death: Not told anything"
capture label var m3_death_cause_baby3_b "Baby 3 Cause of death: The baby was premature (born too early)"
capture label var m3_death_cause_baby3_c "Baby 3 Cause of death: An infection"
capture label var m3_death_cause_baby3_d "Baby 3 Cause of death: Congenital abnormality (genetic/acquired)"
capture label var m3_death_cause_baby3_e "Baby 3 Cause of death: Birth injury"
capture label var m3_death_cause_baby3_f "Baby 3 Cause of death: Difficulties breathing"
capture label var m3_death_cause_baby3_g "Baby 3 Cause of death: Unexplained causes"
capture label var m3_death_cause_baby3_other "Baby 3: Cause of death Other specified"
capture label var m3_death_cause_baby3_96 "Baby 3 Cause of death: Other cause"

***************************************
capture label var m3_303_b1 "Baby 1 still alive"
capture label var m3_303_b2 "Baby 2 still alive"
capture label var m3_303_b3 "Baby 3 still alive"
capture label var m3_303d "Baby3 still alive"

***************************************
capture label var m3_304_b1 "Baby 1: name"
capture label var m3_304_b2 "Baby 2: name"
capture label var m3_304_b3 "Baby 3: name"

capture label var m3_baby1_name "Baby 1: Name"
capture label var m3_baby2_name "Baby 2: Name"
capture label var m3_baby3_name "Baby 3: Name"

capture label var m3_305_b1 "Baby 1: gender"
capture label var m3_305_b2 "Baby 2: gender"
capture label var m3_305_b3 "Baby 3: gender"

capture label var m3_baby1_gender "Baby 1: Gender"
capture label var m3_baby2_gender "Baby 2: Gender"
capture label var m3_baby3_gender "Baby 3: Gender"

capture label var m3_306_b1 "Baby 1: age in weeks"
capture label var m3_306_b2 "Baby 2: age in weeks"
capture label var m3_306_b3 "Baby 3: age in weeks"

capture label var m3_baby1_age_weeks "Baby 1: age in weeks"

capture label var m3_307_b1 "Baby 1: Birth size"
capture label var m3_307_b2 "Baby 2: Birth size"
capture label var m3_307_b3 "Baby 3: Birth size"

capture label var m3_baby1_size "Baby 1: Birth size"
capture label var m3_baby2_size "Baby 2: Birth size"
capture label var m3_baby3_size "Baby 3: Birth size"

capture label var m3_308_b1 "Baby 1: Birth weight(kg)"
capture label var m3_308_b2 "Baby 2: Birth weight(kg)"
capture label var m3_308_b3 "Baby 3: Birth weight(kg)"

capture label var m3_baby1_weight "Baby 1: Birth weight(kg)"
capture label var m3_baby2_weight "Baby 2: Birth weight(kg)"
capture label var m3_baby3_weight "Baby 3: Birth weight(kg)"

capture label var m3_309_b1 "Baby 1: Health rating"
capture label var m3_309_b2 "Baby 2: Health rating"
capture label var m3_309_b3 "Baby 3: Health rating"

capture label var m3_baby1_health "Baby 1: Health rating"
capture label var m3_baby2_health "Baby 2: Health rating"
capture label var m3_baby3_health "Baby 3: Health rating"

***************************************
capture label var m3_310a_b1_1 "Baby 1: how fed by Breast milk"
capture label var m3_310a_b1_2 "Baby 1: how fed by Formula"
capture label var m3_310a_b1_3 "Baby 1: how fed by Water"
capture label var m3_310a_b1_4 "Baby 1: how fed by Juice"
capture label var m3_310a_b1_5 "Baby 1: how fed by Broth"
capture label var m3_310a_b1_6 "Baby 1: how fed by Baby food"
capture label var m3_310a_b1_7 "Baby 1: how fed by Local food"
capture label var m3_310a_b1_99 "Baby 1: how fed No Response/Refused to answer"

capture label var m3_baby1_feed_a "Baby 1: how fed by Breast milk"
capture label var m3_baby1_feed_b "Baby 1: how fed by Formula/Cow milk"
capture label var m3_baby1_feed_c "Baby 1: how fed by Water"
capture label var m3_baby1_feed_d "Baby 1: how fed by Juice"
capture label var m3_baby1_feed_e "Baby 1: how fed by Broth"
capture label var m3_baby1_feed_f "Baby 1: how fed by Baby food"
capture label var m3_baby1_feed_g "Baby 1: how fed by Local food/butter"
capture label var m3_baby1_feed_h "Baby 1: how fed by Fresh milk (Cow or goat milk)"
capture label var m3_baby1_feed_95 "Baby 1: how fed Not applicable"
capture label var m3_baby1_feed_96 "Baby 1: how fed Other"
capture label var m3_baby1_feed_98 "Baby 1: how fed Don't know"
capture label var m3_baby1_feed_99 "Baby 1: how fed No Response/Refused to answer"
capture label var m3_baby1_feed_other "Baby 1: how fed Other specified"


capture label var m3_310a_b2_1 "Baby 2: how fed by Breast milk"
capture label var m3_310a_b2_2 "Baby 2: how fed by Formula"
capture label var m3_310a_b2_3 "Baby 2: how fed by Water"
capture label var m3_310a_b2_4 "Baby 2: how fed by Juice"
capture label var m3_310a_b2_5 "Baby 2: how fed by Broth"
capture label var m3_310a_b2_6 "Baby 2: how fed by Baby food"
capture label var m3_310a_b2_7 "Baby 2: how fed by Local food"
capture label var m3_310a_b2_99 "Baby 2: how fed No Response/Refused to answer"

capture label var m3_baby2_feed_a "Baby 2: how fed by Breast milk"
capture label var m3_baby2_feed_b "Baby 2: how fed by Formula/Cow milk"
capture label var m3_baby2_feed_c "Baby 2: how fed by Water"
capture label var m3_baby2_feed_d "Baby 2: how fed by Juice"
capture label var m3_baby2_feed_e "Baby 2: how fed by Broth"
capture label var m3_baby2_feed_f "Baby 2: how fed by Baby food"
capture label var m3_baby2_feed_g "Baby 2: how fed by Local food/butter"
capture label var m3_baby2_feed_h "Baby 2: how fed by Fresh milk (Cow or goat milk)"
capture label var m3_baby2_feed_99 "Baby 2: how fed No Response/Refused to answer"

capture label var m3_310a_b3_1 "Baby 3: how fed by Breast milk"
capture label var m3_310a_b3_2 "Baby 3: how fed by Formula"
capture label var m3_310a_b3_3 "Baby 3: how fed by Water"
capture label var m3_310a_b3_4 "Baby 3: how fed by Juice"
capture label var m3_310a_b3_5 "Baby 3: how fed by Broth"
capture label var m3_310a_b3_6 "Baby 3: how fed by Baby food"
capture label var m3_310a_b3_7 "Baby 3: how fed by Local food"
capture label var m3_baby2_feed_95 "Baby 2: how fed Not applicable"
capture label var m3_baby2_feed_96 "Baby 2: how fed by Other"
capture label var m3_baby2_feed_98 "Baby 2: how fed Don't know"
capture label var m3_310a_b3_99 "Baby 3: how fed No Response/Refused to answer"
capture label var m3_baby2_feed_other "Baby 2: how fed by Other specified"

capture label var m3_baby3_feed_a "Baby 3: how fed by Breast milk"
capture label var m3_baby3_feed_b "Baby 3: how fed by Formula/Cow milk"
capture label var m3_baby3_feed_c "Baby 3: how fed by Water"
capture label var m3_baby3_feed_d "Baby 3: how fed by Juice"
capture label var m3_baby3_feed_e "Baby 3: how fed by Broth"
capture label var m3_baby3_feed_f "Baby 3: how fed by Baby food"
capture label var m3_baby3_feed_g "Baby 3: how fed by Local food/butter"
capture label var m3_baby3_feed_95 "Baby 2: how fed Not applicable"
capture label var m3_baby3_feed_96 "Baby 3: how fed by Other"
capture label var m3_baby3_feed_98 "Baby 2: how fed Don't know"
capture label var m3_baby3_feed_99 "Baby 3: how fed No Response/Refused to answer"
capture label var m3_baby3_feed_other "Baby 3: how fed by Other specified"
***************************************

capture label var m3_310b "Confidence in beastfeeding"
capture label var m3_breastfeeding "Confidence in beastfeeding"
capture label var m3_breastfeeding_2 "Baby 2: Confidence in beastfeeding"

***************************************
capture label var m3_311a_b1 "Baby 1: Today's sleep description"
capture label var m3_311a_b2 "Baby 2: Today's sleep description"
capture label var m3_311a_b3 "Baby 3: Today's sleep description"

capture label var m3_baby1_sleep "Baby 1: Today's sleep description"
capture label var m3_baby2_sleep "Baby 2: Today's sleep description"
capture label var m3_baby3_sleep "Baby 3: Today's sleep description"

capture label var m3_311b_b1 "Baby 1: Today's feeding description"
capture label var m3_311b_b2 "Baby 2: Today's feeding description"
capture label var m3_311b_b3 "Baby 3: Today's feeding description"

capture label var m3_baby1_feeding "Baby 1: Today's feeding description"
capture label var m3_baby2_feeding "Baby 2: Today's feeding description"
capture label var m3_baby3_feeding "Baby 3: Today's feeding description"

capture label var m3_baby1_feed "Baby 1: Today's feeding description"
capture label var m3_baby2_feed "Baby 2: Today's feeding description"
capture label var m3_baby3_feed "Baby 3: Today's feeding description"

*capture label var m3_baby3_feed "Baby 3: Today's feeding description"

***************************************

capture label var m3_311c_b1 "Baby 1: Today's breathing description"
capture label var m3_311c_b2 "Baby 2: Today's breathing description"
capture label var m3_311c_b3 "Baby 3: Today's breathing description"

capture label var m3_baby1_breath "Baby 1: Today's breathing description"
capture label var m3_baby2_breath "Baby 2: Today's breathing description"
capture label var m3_baby3_breath "Baby 3: Today's breathing description"

capture label var m3_311d_b1 "Baby 1: Today's stool/poo description"
capture label var m3_311d_b2 "Baby 2: Today's stool/poo description"
capture label var m3_311d_b3 "Baby 3: Today's stool/poo description"

capture label var m3_baby1_stool "Baby 1: Today's stool/poo description"
capture label var m3_baby2_stool "Baby 2: Today's stool/poo description"
capture label var m3_baby3_stool "Baby 3: Today's stool/poo description"

capture label var m3_311e_b1 "Baby 1: Today's mood description"
capture label var m3_311e_b2 "Baby 2: Today's mood description"
capture label var m3_311e_b3 "Baby 3: Today's mood description"

capture label var m3_baby1_mood "Baby 1: Today's mood description"
capture label var m3_baby2_mood "Baby 2: Today's mood description"
capture label var m3_baby3_mood "Baby 3: Today's mood description"

capture label var m3_311f_b1 "Baby 1: Today's skin description"
capture label var m3_311f_b2 "Baby 2: Today's skin description"
capture label var m3_311f_b3 "Baby 3: Today's skin description"

capture label var m3_baby1_skin "Baby 1: Today's skin description"
capture label var m3_baby2_skin "Baby 2: Today's skin description"
capture label var m3_baby3_skin "Baby 3: Today's skin description"

capture label var m3_311g_b1 "Baby 1: Today's interactivity description"
capture label var m3_311g_b2 "Baby 2: Today's interactivity description"
capture label var m3_311g_b3 "Baby 3: Today's interactivity description"

capture label var m3_baby1_interactivity "Baby 1: Today's interactivity description"
capture label var m3_baby2_interactivity "Baby 2: Today's interactivity description"
capture label var m3_baby3_interactivity "Baby 3: Today's interactivity description"

***************************************
capture label var m3_312_a_b1 "Baby 1: Show any signs of life (Cry/make any movement/sound/effort to breathe)"
capture label var m3_312_a_b2 "Baby 2: Show any signs of life (Cry/make any movement/sound/effort to breathe)"
capture label var m3_312_a_b3 "Baby 3: Show any signs of life (Cry/make any movement/sound/effort to breathe)"

capture label var m3_baby1_born_alive2 "Baby 1: Show any signs of life (Cry/make any movement/sound/effort to breathe)"

***************************************
capture label var m3_312_b1 "Baby 1: Born alive"
capture label var m3_312_b2 "Baby 2: Born alive"
capture label var m3_312_b3 "Baby 3: Born alive"

capture label var m3_baby1_born_alive1 "Baby 1: Born alive"
capture label var m3_baby2_born_alive1 "Baby 2: Born alive"

capture label var m3_baby1_born_alive "Baby 1: Born alive"
capture label var m3_baby2_born_alive "Baby 2: Born alive"
capture label var m3_baby3_born_alive "Baby 3: Born alive"
***************************************

capture label var m3_313a_b1 "Baby 1: Death date"
capture label var m3_313a_b2 "Baby 2: Death date"
capture label var m3_313a_b3 "Baby 3: Death date"

capture label var m3_313a_baby1 "Baby 1: Death date"
capture label var m3_313a_baby2 "Baby 2: Death date"
capture label var m3_313a_baby3 "Baby3: Death date"

capture label var m3_313b_baby1 "Baby1: Time of death"
capture label var m3_313b_baby2 "Baby2: Time of death"
capture label var m3_313b_baby3 "Baby3: Time of death"

capture label var m3_313b_days_b1 "Baby 1: After how many days did the baby"
capture label var m3_313b_days_b2 "Baby 2: After how many days did the baby"
capture label var m3_313b_days_b3 "Baby 3: After how many days did the baby"

capture label var m3_313b_hours_b1 "Baby 1: After how many hours did the baby"
capture label var m3_313b_hours_b2 "Baby 2: After how many hours did the baby"
capture label var m3_313b_hours_b3 "Baby 3: After how many hours did the baby"

capture label var m3_313e_baby1 "Baby 1: After how many hours did the baby"
capture label var m3_313e_baby2 "Baby 2: After how many hours did the baby"
capture label var m3_313e_baby3 "Baby 3: After how many hours did the baby"

***************************************
capture label var m3_401 "New healthcare consultations for self before delivery"

capture label var m3_402 "Number of new consultations"

capture label var m3_consultation_1 "1st Consultation : ANC visit"
capture label var m3_consultation_2 "2nd Consultation : ANC visit"
capture label var m3_consultation_3 "3rd Consultation : ANC visit"
capture label var m3_consultation_4 "4th Consultation : ANC visit"
capture label var m3_consultation_5 "5th Consultation : ANC visit"

capture label var m3_consultation_referral_1 "1st Consultation : Referral from ANC provider"
capture label var m3_consultation_referral_2 "2nd Consultation : Referral from ANC provider"
capture label var m3_consultation_referral_3 "3rd Consultation : Referral from ANC provider"
capture label var m3_consultation_referral_4 "4th Consultation : Referral from ANC provider"
capture label var m3_consultation_referral_5 "5th Consultation : Referral from ANC provider"


capture label var m3_403 "1st Consultation : ANC visit"
capture label var m3_404 "1st Consultation : Referral from ANC provider"
capture label var m3_405_1 "1st Consultation : New health problem"
capture label var m3_405_2 "1st Consultation : Existing health problem"
capture label var m3_405_3 "1st Consultation : Lab test, x-ray or ultrasound"
capture label var m3_405_4 "1st Consultation : Pick up medicine"
capture label var m3_405_5 "1st Consultation : To get a vaccine"
capture label var m3_405_96 "1st Consultation : Other reasons"
capture label var m3_405_other "1st Consultation : Other reasons Specified"

capture label var m3_consultation1_reason "1st Consultation : Reason for visit"
capture label var m3_consultation1_reason_a "1st Consultation : New health problem"
capture label var m3_consultation1_reason_b "1st Consultation : Existing health problem "
capture label var m3_consultation1_reason_c "1st Consultation : Lab test, x-ray or ultrasound"
capture label var m3_consultation1_reason_d "1st Consultation : To pick up medicine"
capture label var m3_consultation1_reason_e "1st Consultation : To get a vaccine "
capture label var m3_consultation1_reason_96 "1st Consultation : Other reasons"
capture label var m3_consultation1_reason_other "1st Consultation : Other reasons Specified"

capture label var m3_406 "2nd Consultation : ANC visit"
capture label var m3_407 "2nd Consultation : Referral from ANC provider"
capture label var m3_408_1 "2nd Consultation : New health problem"
capture label var m3_408_2 "2nd Consultation : Existing health problem"
capture label var m3_408_3 "2nd Consultation : Lab test, x-ray or ultrasound"
capture label var m3_408_4 "2nd Consultation : Pick up medicine"
capture label var m3_408_5 "2nd Consultation : To get a vaccine"
capture label var m3_408_96 "2nd Consultation : Other reasons"
capture label var m3_408_other "2nd Consultation : Other reasons Specified"

capture label var m3_consultation2_reason "2nd Consultation : Reason for visit"
capture label var m3_consultation2_reason_a "2nd Consultation : New health problem"
capture label var m3_consultation2_reason_b "2nd Consultation : Existing health problem "
capture label var m3_consultation2_reason_c "2nd Consultation : Lab test, x-ray or ultrasound"
capture label var m3_consultation2_reason_d "2nd Consultation : To pick up medicine"
capture label var m3_consultation2_reason_e "2nd Consultation : To get a vaccine "
capture label var m3_consultation2_reason_96 "2nd Consultation : Other reasons"
capture label var m3_consultation2_reason_other "2nd Consultation : Other reasons Specified"


capture label var m3_409 "3rd Consultation : ANC visit"
capture label var m3_410 "3rd Consultation : Referral from ANC provider"
capture label var m3_411_1 "3rd Consultation : New health problem"
capture label var m3_411_2 "3rd Consultation : Existing health problem"
capture label var m3_411_3 "3rd Consultation : Lab test, x-ray or ultrasound"
capture label var m3_411_4 "3rd Consultation : Pick up medicine"
capture label var m3_411_5 "3rd Consultation : To get a vaccine"
capture label var m3_411_96 "3rd Consultation : Other reasons"
capture label var m3_411_other "3rd Consultation : Other reasons Specified"

capture label var m3_consultation3_reason "3rd Consultation : Reason for visit"
capture label var m3_consultation3_reason_a "3rd Consultation : New health problem"
capture label var m3_consultation3_reason_b "3rd Consultation : Existing health problem "
capture label var m3_consultation3_reason_c "3rd Consultation : Lab test, x-ray or ultrasound"
capture label var m3_consultation3_reason_d "3rd Consultation : Pick up medicine"
capture label var m3_consultation3_reason_e "3rd Consultation : To get a vaccine "
capture label var m3_consultation3_reason_96 "3rd Consultation : Other reasons"
capture label var m3_consultation3_reason_other "3rd Consultation : Other reasons Specified"

capture label var m3_consultation4_reason_a "4th Consultation : New health problem"
capture label var m3_consultation4_reason_b "4th Consultation : Existing health problem "
capture label var m3_consultation4_reason_c "4th Consultation : Lab test, x-ray or ultrasound"
capture label var m3_consultation4_reason_d "4th Consultation : Pick up medicine"
capture label var m3_consultation4_reason_e "4th Consultation : To get a vaccine "
capture label var m3_consultation4_reason_96 "4th Consultation : Other reasons"
capture label var m3_consultation4_reason_other "4th Consultation : Other reasons Specified"

capture label var m3_consultation5_reason_a "5th Consultation : New health problem"
capture label var m3_consultation5_reason_b "5th Consultation : Existing health problem "
capture label var m3_consultation5_reason_c "5th Consultation : Lab test, x-ray or ultrasound"
capture label var m3_consultation5_reason_d "5th Consultation : Pick up medicine"
capture label var m3_consultation5_reason_e "5th Consultation : To get a vaccine "
capture label var m3_consultation5_reason_96 "5th Consultation : Other reasons"
capture label var m3_consultation5_reason_other "5th Consultation : Other reasons Specified"


*******************************************************
*******************************************************
capture label var m3_412_a "Since last spoke/before delivery had: Blood preasure measured"
capture label var m3_412_b "Since last spoke/before delivery had: Weight taken"
capture label var m3_412_c "Since last spoke/before delivery had: Blood draw"
capture label var m3_412_d "Since last spoke/before delivery had: Blood test using finger prick"
capture label var m3_412_e "Since last spoke/before delivery had: Urine test"
capture label var m3_412_f "Since last spoke/before delivery had: Ultrasound"
capture label var m3_412_g "Since last spoke/before delivery had: Other test"
capture label var m3_412_other "Since last spoke/before delivery had: Other test specified"

capture label var m3_412a "Since last spoke/before delivery had: Blood preasure measured"
capture label var m3_412b "Since last spoke/before delivery had: Weight taken"
capture label var m3_412c "Since last spoke/before delivery had: Blood draw"
capture label var m3_412d "Since last spoke/before delivery had: Blood test using finger prick"
capture label var m3_412e "Since last spoke/before delivery had: Urine test"
capture label var m3_412f "Since last spoke/before delivery had: Ultrasound"
capture label var m3_412g "Since last spoke/before delivery had: Other test"
capture label var m3_412g_other "Since last spoke/before delivery had: Other test specified"

*******************************************************
*******************************************************
capture label var m3_501 "Delivered in a health facility"

capture label var m3_502 "Facility type where delivered"

capture label var m3_503 "Facility name where delivered"

capture label var m3_503_final "Facility name where delivered: Selected text or user specified responses"

capture label var m3_503_inside_zone_other "Facility location where delivered: Other Inside zone "

capture label var m3_503_other "Other specified facility name"
capture label var m3_503_outside_zone_other "Facility location where delivered: Other outside zone "

capture label var m3_504 "Where is facility located"
capture label var m3_504a "Region where delivered"
capture label var m3_504b "City/sub-city/district where delivered"
capture label var m3_504c "County where delivered"


capture label var m3_505a "Go to maternity waiting home to wait for label before delivery"

capture label var m3_505b "How many days did you stay at the maternity waiting home for?"
capture label var m3_505b_days "How many days did you stay at the maternity waiting home for?"
capture label var m3_505b_hours "How many hours did you stay at the maternity waiting home for?"
capture label var m3_505b_weeks "How many weeks did you stay at the maternity waiting home for?"

capture label var m3_506_date "Date labor started"
capture label var m3_506_time "Time labor started"
capture label var m3_506a "Date labor started"
capture label var m3_506b "Time labor started"
capture label var m3_506b_unknown "Time labor started: Unknown"

capture label var m3_506 "Date and time labor started"
capture label var m3_506_pre "Able to provide date and time labor started"
capture label var m3_506_pre_oth "Other reason unable to provide date and time labor started"


capture label var m3_507_time "Time left for the facility"
capture label var m3_507_unknown "Time left for the facility: Unknown"
capture label var m3_507 "Time left for the facility"

capture label var m3_508 "Homebirth: Tried to go to facility at any point during labor/deliver"

capture label var m3_509_other "Homebirth: Other reason for deliverying at home specified"
capture label var m3_509 "Homebirth: Main reason for delivering at home"

capture label var m3_510 "Did you go to another health facility first?"

capture label var m3_511 "Number of facilities went to first"

capture label var m3_512 "First facility: Facility type"
capture label var m3_512_1 "First facility: Facility type"
capture label var m3_512_outside_zone_other "First facility: Other facility type outside zone specified"

capture label var m3_512_1_ke "First facility: Facility type"
capture label var m3_512_2_ke "Second facility: Facility type"

capture label var m3_513a "First facility: Facility name"
capture label var m3_513b2 "First facility: City/sub-city/district "
capture label var m3_513b3 "First facility: County where facility located"

capture label var m3_513_outside_zone_other "First facility: Other facility name outside zone specified"
capture label var m3_513_inside_zone_other "First facility: Other facility name inside zone specified"

capture label var m3_513a "First facility: Facility name"
capture label var m3_513b "First facility: Location"
capture label var m3_513b1 "First facility: City and Region"

capture label var m3_514_time "First facility: Time arrived at facility"
capture label var m3_514_unknown "First facility: Time arrived unknown"
capture label var m3_514 "First facility: Time arrived"

*********************************
capture label var m3_515 "Reason went to facility delivered at after going to first facility"
*********************************
capture label var m3_516 "Reason self/family member left first facility & went to faciilty delivered at"
capture label var m3_516_other "Reason self/family member left first facility: Other specified"
*********************************
capture label var m3_517 "Did provider inform you why they referred you?"

*********************************

capture label var m3_518_0 "Reason for referral: The provider did not give a reason"
capture label var m3_518_1 "Reason for referral: No space or no bed available"
capture label var m3_518_10 "Reason for referral: Bleeding"
capture label var m3_518_2 "Reason for referral: Facility did not provide delivery care"
capture label var m3_518_3 "Reason for referral: Prolonged labor"
capture label var m3_518_4 "Reason for referral: Obstructed labor"
capture label var m3_518_5 "Reason for referral: Eclampsia/pre-eclampsia"
capture label var m3_518_6 "Reason for referral: Previous cesarean section scar"
capture label var m3_518_7 "Reason for referral: Fetal distress"
capture label var m3_518_8 "Reason for referral: Fetal presentation"
capture label var m3_518_9 "Reason for referral: No fetal movement/heartbeat"
capture label var m3_518_96 "Reason for referral: Other delivery complications "
capture label var m3_518_97 "Reason for referral: Other reasons"
capture label var m3_518_98 "Reason for referral: Don´t know"
capture label var m3_518_99 "Reason for referral: No response/Refuse"

capture label var m3_518 "Reason referred to delivery facility"
capture label var m3_518_other "Reason referred to delivery facility: Other reasons specified"
capture label var m3_518_other_complications "Reason referred to facility: Other complications specified"

*********************************

capture label var m3_519_1 "Main reason delivered here: Low cost of delivery"
capture label var m3_519_10 "Main reason delivered here: Low risk of getting COVID-19"
capture label var m3_519_11 "Main reason delivered here: Female providers available"
capture label var m3_519_12 "Main reason delivered here: I was told by family member"
capture label var m3_519_13 "Main reason delivered here: I was told by a health worker"
capture label var m3_519_14 "Main reason delivered here: Familiarity with health worker"
capture label var m3_519_15 "Main reason delivered here: Familiarity with facility"
capture label var m3_519_16 "Main reason delivered here: Emergency care is available if need"
capture label var m3_519_17 "Main reason delivered here: Birth companion can come with me"
capture label var m3_519_2 "Main reason delivered here: Close to home"
capture label var m3_519_3 "Main reason delivered here: Short waiting time or enough HCWs"
capture label var m3_519_4 "Main reason delivered here: Good healthcare provider skills"
capture label var m3_519_5 "Main reason delivered here: Staff are respectful / nice"
capture label var m3_519_6 "Main reason delivered here: Medicine and equipment available"
capture label var m3_519_7 "Main reason delivered here: Facility is clean and/or comfortable"
capture label var m3_519_8 "Main reason delivered here: I delivered here before"
capture label var m3_519_9 "Main reason delivered here: Possible within COVID restrictions"
capture label var m3_519_96 "Main reason delivered here: Other"
capture label var m3_519_98 "Main reason delivered here: Don't know"
capture label var m3_519_99 "Main reason delivered here: No Response/Refused to answer"

capture label var m3_519 "Main reason delivered here"
capture label var m3_519_other "Main reason delivered here: Other specified"

*********************************
capture label var m3_520_time "Time arrived at facility where delivered"
capture label var m3_520_unknown "Time arrived at facility where delivered: Unknown"
capture label var m3_520 "Time arrived at facility where delivered"

*********************************
capture label var m3_521 "Minutes waited until a healthcare worker checked on you"
capture label var m3_521_hours "Hours waited until a healthcare worker checked on you"
capture label var m3_521_minutes "Minutes waited until a healthcare worker checked on you"
capture label var m3_521_unknown "Minutes waited until a healthcare worker checked on you: Unknown"


capture label var m3_521_ke "Amount of time waited until a healthcare worker checked on you"
capture label var m3_521_ke_unit "Amount of time waited until a healthcare worker checked on you (Unit of time)"

*********************************
*******************************************************
*******************************************************

capture label var m3_601a "Did healthcare provider: Ask about health status?"
capture label var m3_601 "Did healthcare provider: Do any of the following"
capture label var m3_601_hiv "Did healthcare provider: Ask about HIV status"
capture label var m3_601b "Did healthcare provider: Take blood pressure?"
capture label var m3_601c "Did healthcare provider: Explain what happens during labor?"
*********************************
capture label var m3_602a "Health care provider looked at maternal health card"
capture label var m3_602b "Health care provider had information about ANC from health facility records"
*********************************
capture label var m3_603a "Told could walk around and move during labour"
capture label var m3_603b "Allowed to have a birth companion present? (husband/friend etc)"
capture label var m3_603c "During labor/deliver: Had a needle inserted in your arm with a drip"
capture label var m3_603d "During labor/delivery: Encouraged to drink fluids"

*********************************
capture label var m3_604a "During labor/delivery: What were you sitting or lying on"
capture label var m3_604b "During labor/delivery: Curtains/partitions/other measures to provide for privacy"

*********************************

capture label var m3_605c_0 "Reason for having caesarean: I was not told"
capture label var m3_605c_1 "Reason for having caesarean: It was previously planned for medical reasons"
capture label var m3_605c_2 "Reason for having caesarean: I asked for a c-section"
capture label var m3_605c_3 "Reason for having caesarean: Problems arose during labor"
capture label var m3_605c_96 "Reason for having caesarean: Other"
capture label var m3_605c_98 "Reason for having caesarean: Don't Know"
capture label var m3_605c_99 "Reason for having caesarean: No Response/Refused to answer"
capture label var m3_605c_a "Reason for having caesarean: Was not told"
capture label var m3_605c_b "Reason for having caesarean: Previously planned or medical reasons"
capture label var m3_605c_c "Reason for having caesarean: Asked for caesaran section"
capture label var m3_605c_d "Reason for having caesarean: Problems arose during labor"


capture label var m3_605a "Had a caesarean birth"
capture label var m3_605b "Decision to have a caesarean section before or after labor pains started"
capture label var m3_605c "Reason for having caesarean section "
capture label var m3_605c_other "Reason for having caesarean section: Other specified"

*********************************
capture label var m3_606 "Provider perform a cut near vagina to help baby come out"
*********************************
capture label var m3_607 "Receive stiches near your vagina after the delivery"

*********************************
capture label var m3_608 "Immediately after delivery: Given an injection/pill to stop the bleeding"
*********************************

capture label var m3_609 "Immediately after delivery: Provider dried the baby/babies with a towel"
*********************************

capture label var m3_610a "Immediately after delivery:  Baby/babies put on your chest"
capture label var m3_610b "Immediately after delivery:  Baby's/babies' bare skin touching your bare skin"
*********************************

capture label var m3_611 "Immediately after delivery:  Provider helped with breastfeeding the baby/babies"
*********************************

capture label var m3_612_ke "Time after birth:  Breastfed baby/ies "
capture label var m3_612_ke_unit "Time after birth:  Breastfed baby/ies (Unit of time)"


capture label var m3_612 "Minutes after delivery: Breastfed baby/ies"
capture label var m3_612_days "Days after baby/babies born first breastfed"
capture label var m3_612_hours "Hours after baby/babies born first breastfeed"
*********************************
capture label var m3_613 "Did anyone check on your health while you were still in the facility"
*********************************

capture label var m3_614 "Hours after delivery: First check took place"
capture label var m3_614_days "Days after delivery: first check took place"
capture label var m3_614_hours "Hours after delivery: first check took place"
capture label var m3_614_weeks "Weeks after delivery: first check took place"
*********************************

capture label var m3_615_b1 "Baby 1: Checked on while still at facility"
capture label var m3_615_b2 "Baby 2: Checked on while still at facility"
capture label var m3_615_b3 "Baby 3: Checked on while still at facility"
capture label var m3_615c "Baby 3: Checked on while still at facility"

capture label var m3_615a "Baby 1: Checked on while still at facility"
capture label var m3_615b "Baby 2: Checked on while still at facility"

*********************************

capture label var m3_616_days_b1 "Baby 1: Days after delivery health first checked"
capture label var m3_616_days_b2 "Baby 2: Days after delivery health first checked"
capture label var m3_616_days_b3 "Baby 3: Days after delivery health first checked"

capture label var m3_616_hours_b1 "Baby 1: Hours after delivery health first checked"
capture label var m3_616_hours_b2 "Baby 2: Hours after delivery health first checked"
capture label var m3_616_hours_b3 "Baby 3: Hours after delivery health first checked"

capture label var m3_616_weeks_b1 "Baby 1: Weeks after delievery health first checked"
capture label var m3_616_weeks_b2 "Baby 2: Weeks after delievery health first checked"
capture label var m3_616_weeks_b3 "Baby 3: Weeks after delievery health first checked"

capture label var m3_616a "Baby 1: Hours after delivery health first checked"
capture label var m3_616b "Baby 2: Hours after delivery health first checked"
capture label var m3_616c "Baby 3: Hours after delivery health first checked"

capture label var m3_616c_1 "Baby 1: Time after delivery first check took place"
capture label var m3_616c_2 "Baby 2: Time after delivery first check took place"

capture label var m3_616c_1_unit "Baby 1: Time after delivery first check took place (Unit of time)"
capture label var m3_616c_2_unit "Baby 2: Time after delivery first check took place (Unit of time)"

*********************************

capture label var m3_617_b1 "Baby 1: Received BCG vaccine"
capture label var m3_617_b2 "Baby 2: Received BCG vaccine"
capture label var m3_617_b3 "Baby 3: Received BCG vaccine"

capture label var m3_617a "Baby 1: Received BCG vaccine"
capture label var m3_617b "Baby 2: Received BCG vaccine"
capture label var m3_617c "Baby 3: Received BCG vaccine"

capture label var m3_617d_et "Baby 1: Received Vitamin K"
capture label var m3_617e_et "Baby 2: Received Vitamin K"
capture label var m3_617f_et "Baby 3: Received Vitamin K"

capture label var m3_617g_et "Baby 1: Received eye ointment"
capture label var m3_617h_et "Baby 2: Received eye ointment"
capture label var m3_617i_et "Baby 3: Received eye ointment"
*********************************

capture label var m3_618a_1 "Baby 1: Tested for HIV after birth"
capture label var m3_618a_2 "Baby 2: Tested for HIV after birth"
capture label var m3_618a_3 "Baby 3: Tested for HIV after birth"

capture label var m3_618a_b1 "Baby 1: Tested for HIV after birth"
capture label var m3_618a_b2 "Baby 2: Tested for HIV after birth"
capture label var m3_618a_b3 "Baby 3: Tested for HIV after birth"

capture label var m3_618b_1 "Baby 1: Result of HIV test"
capture label var m3_618b_2 "Baby 2: Result of HIV test"
capture label var m3_618b_3 "Baby 3: Result of HIV test"

capture label var m3_618b_b1 "Baby 1: Result of HIV test"
capture label var m3_618b_b2 "Baby 2: Result of HIV test"
capture label var m3_618b_b3 "Baby 3: Result of HIV test"

capture label var m3_618c_1 "Baby 1: Given medication to prevent HIV/AIDS"
capture label var m3_618c_2 "Baby 2: Given medication to prevent HIV/AIDS"
capture label var m3_618c_3 "Baby 3: Given medication to prevent HIV/AIDS"

capture label var m3_618c_b1 "Baby 1: Given medication to prevent HIV/AIDS"
capture label var m3_618c_b2 "Baby 2: Given medication to prevent HIV/AIDS"
capture label var m3_618c_b3 "Baby 3: Given medication to prevent HIV/AIDS"
*********************************

capture label var m3_619a "Advice on: What baby should eat"
capture label var m3_619b "Advice on: Care of the umbilical cord"
capture label var m3_619c "Advice on: Need to avoid chilling of baby"
capture label var m3_619d "Advice on: When to return for vaccinations for the baby"
capture label var m3_619e "Advice on: Hand washing with soap/water before touching the baby"
capture label var m3_619f "Advice on: Danger signs/symptoms in baby that would mean go to a health facility"
capture label var m3_619g "Advice on: Danger signs/symptoms in self that would mean go to a health facility"

*********************************
capture label var m3_620 "After delivery: Received vaccination card for baby to take home"

capture label var m3_620_1 "Baby 1: Received mother & child booklet for the baby to take home with you"
capture label var m3_620_2 "Baby 2: Received mother & child booklet for the baby to take home with you"
capture label var m3_620_3 "Baby 3: Received mother & child booklet for the baby to take home with you"

capture label var m3_620_b1 "Baby 1: Received a health card for the baby to take home with you"
capture label var m3_620_b2 "Baby 2: Received a health card for the baby to take home with you"
capture label var m3_620_b3 "Baby 3: Received a health card for the baby to take home with you"
*********************************

capture label var m3_621a_1 "Assisted in the delivery: A relative or a friend"
capture label var m3_621a_2 "Assisted in the delivery: A traditional birth attendant"
capture label var m3_621a_3 "Assisted in the delivery: A community health worker"
capture label var m3_621a_4 "Assisted in the delivery: A nurse"
capture label var m3_621a_5 "Assisted in the delivery: A midwife"
capture label var m3_621a_6 "Assisted in the delivery: A doctor"
capture label var m3_621a_98 "Assisted in the delivery: Don't Know"
capture label var m3_621a_99 "Assisted in the delivery: No Response/Refused to answer"

capture label var m3_621c "Hours after birth before checkup"
capture label var m3_621c_days "Days after birth before checkup"
capture label var m3_621c_hours "Hours after birth before checkup"
capture label var m3_621c_weeks "Weeks after birth before checkup"

capture label var m3_621a "Who assisted you in the delivery"
capture label var m3_621b "Checked on after gave birth"
*******************************************************
capture label var m3_622a "Told would need to go to a facility for a checkup for you or your baby"
capture label var m3_622b "Number of days after delivery told to go to health facility for postnatal check"
capture label var m3_622c "Told someone would come visit at home to check on you and your baby's health"

*******************************************************
*******************************************************


capture label var m3_701 "Suffer health problems during labor, delivery or after delivery"
capture label var m3_702 "Health problems during labor, delivery or after delivery: Problems specified"
capture label var m3_703 "Would say health problem was severe"
capture label var m3_704a "During delivery experienced: Seizures"
capture label var m3_704b "During delivery experienced: Blurred vision"
capture label var m3_704c "During delivery experienced: Severe headaches"
capture label var m3_704d "During delivery experienced: Swelling in hands/feet"
capture label var m3_704e "During delivery experienced: Labor over 12 hours"
capture label var m3_704f "During delivery experienced: Excessive bleeding"
capture label var m3_704g "During delivery experienced: Fever"

capture label var m3_705 "Received blood transfusion around time of delivery"

capture label var m3_706 "Admitted to intensive care unit"


capture label var m3_707 "Hours stayed after delivery"
capture label var m3_707_days "Days stayed after delivery"
capture label var m3_707_hours "Hours stayed after delivery"
capture label var m3_707_unknown "Hours stayed after delivery: Unknown"
capture label var m3_707_weeks "Weeks stayed after delivery"


*******************************************************

capture label var m3_708_1_b1 "Baby 1: Experienced 1st day of life: Trouble breathing"
capture label var m3_708_2_b1 "Baby 1: Experienced 1st day of life: Fever, low temperature, or infection"
capture label var m3_708_3_b1 "Baby 1: Experienced 1st day of life: Trouble feeding"
capture label var m3_708_4_b1 "Baby 1: Experienced 1st day of life: Jaundice (yellow color of the skin)"
capture label var m3_708_5_b1 "Baby 1: Experienced 1st day of life: Low birth weight"
capture label var m3_708_6_b1 "Baby 1: Experienced 1st day of life: No complications"
capture label var m3_708_98_b1 "Baby 1: Experienced 1st day of life: Don't Know"
capture label var m3_708_99_b1 "Baby 1: Experienced 1st day of life: No Response/Refused to answer"

capture label var m3_708_1_b2 "Baby 2: Experienced 1st day of life: Trouble breathing"
capture label var m3_708_2_b2 "Baby 2: Experienced 1st day of life: Fever, low temperature, or infection"
capture label var m3_708_3_b2 "Baby 2: Experienced 1st day of life: Trouble feeding"
capture label var m3_708_4_b2 "Baby 2: Experienced 1st day of life: Jaundice (yellow color of the skin)"
capture label var m3_708_5_b2 "Baby 2: Experienced 1st day of life: Low birth weight"
capture label var m3_708_6_b2 "Baby 2: Experienced 1st day of life: No complications"
capture label var m3_708_98_b2 "Baby 2: Experienced 1st day of life: Don't Know"
capture label var m3_708_99_b2 "Baby 2: Experienced 1st day of life: No Response/Refused to answer"

capture label var m3_708_1_b3 "Baby 3: Experienced 1st day of life: Trouble breathing"
capture label var m3_708_2_b3 "Baby 3: Experienced 1st day of life: Fever, low temperature, or infection"
capture label var m3_708_3_b3 "Baby 3: Experienced 1st day of life: Trouble feeding"
capture label var m3_708_4_b3 "Baby 3: Experienced 1st day of life: Jaundice (yellow color of the skin)"
capture label var m3_708_5_b3 "Baby 3: Experienced 1st day of life: Low birth weight"
capture label var m3_708_6_b3 "Baby 3: Experienced 1st day of life: No complications"
capture label var m3_708_98_b3 "Baby 3: Experienced 1st day of life: Don't Know"
capture label var m3_708_99_b3 "Baby 3: Experienced 1st day of life: No Response/Refused to answer"


capture label var m3_baby1_issues_a "Baby 1: Experienced 1st day of life: Trouble breathing"
capture label var m3_baby1_issues_b "Baby 1: Experienced 1st day of life: Fever, low temperature, or infection"
capture label var m3_baby1_issues_c "Baby 1: Experienced 1st day of life: Trouble feeding"
capture label var m3_baby1_issues_d "Baby 1: Experienced 1st day of life: Jaundice (yellow color of the skin)"
capture label var m3_baby1_issues_e "Baby 1: Experienced 1st day of life: Low birth weight"
capture label var m3_baby1_issues_f "Baby 1: Experienced 1st day of life: No complications"
capture label var m3_baby1_issues_98 "Baby 1: Experienced 1st day of life: Don't Know"
capture label var m3_baby1_issues_95 "Baby 1: Experienced 1st day of life: Not applicable"
capture label var m3_baby1_issues_96 "Baby 1: Experienced 1st day of life: Other issues"
capture label var m3_baby1_issues_99 "Baby 1: Experienced 1st day of life: No Response/Refused to answer"
capture label var m3_baby1_issue_oth "Baby 1: Experienced 1st day of life: Other Issues"
capture label var m3_baby1_issue_oth_text "Baby 1: Experienced Other Issues specified"

capture label var m3_baby2_issues_a "Baby 2: Experienced 1st day of life: Trouble breathing"
capture label var m3_baby2_issues_b "Baby 2: Experienced 1st day of life: Fever, low temperature, or infection"
capture label var m3_baby2_issues_c "Baby 2: Experienced 1st day of life: Trouble feeding"
capture label var m3_baby2_issues_d "Baby 2: Experienced 1st day of life: Jaundice (yellow color of the skin)"
capture label var m3_baby2_issues_e "Baby 2: Experienced 1st day of life: Low birth weight"
capture label var m3_baby2_issues_f "Baby 2: Experienced 1st day of life: No complications"
capture label var m3_baby2_issues_95 "Baby 2:Experienced 1st day of life: Not applicable"
capture label var m3_baby2_issues_96 "Baby 2:Experienced 1st day of life: Other issues"
capture label var m3_baby2_issues_98 "Baby 2: Experienced 1st day of life: Don't Know"
capture label var m3_baby2_issues_99 "Baby 2: Experienced 1st day of life: No Response/Refused to answer"
capture label var m3_baby2_issue_oth "Baby 2: Experienced 1st day of life: Other Issues"
capture label var m3_baby2_issue_oth_text "Baby 2: Experienced Other Issues specified"

capture label var m3_baby3_issues_a "Baby 3: Experienced 1st day of life: Trouble breathing"
capture label var m3_baby3_issues_b "Baby 3: Experienced 1st day of life: Fever, low temperature, or infection"
capture label var m3_baby3_issues_c "Baby 3: Experienced 1st day of life: Trouble feeding"
capture label var m3_baby3_issues_d "Baby 3: Experienced 1st day of life: Jaundice (yellow color of the skin)"
capture label var m3_baby3_issues_e "Baby 3: Experienced 1st day of life: Low birth weight"
capture label var m3_baby3_issues_f "Baby 3: Experienced 1st day of life: No complications"
capture label var m3_baby3_issues_95 "Baby 3: Experienced 1st day of life: Not applicable"
capture label var m3_baby3_issues_96 "Baby 3: Experienced 1st day of life: Other issues"
capture label var m3_baby3_issues_98 "Baby 3: Experienced 1st day of life: Don't Know"
capture label var m3_baby3_issues_99 "Baby 3: Experienced 1st day of life: No Response/Refused to answer"
capture label var m3_baby3_issue_oth "Baby 3: Experienced 1st day of life: Other Issues"
capture label var m3_baby3_issue_oth_text "Baby 3: Experienced Other Issues specified"


capture label var m3_708a "Baby 1: Experienced other health issues first day of life specified"
capture label var m3_708b "Baby 2: Experienced other health issues first day of life specified"
capture label var m3_709c "Baby 3: Experienced other health issues first day of life specified"
*******************************************************

*capture label var m3_708c "1st day Baby 3: Experienced Issues"

capture label var m3_709_b1 "Baby 1: Experienced other health problems first day of life"
capture label var m3_709_b2 "Baby 2: Experienced other health problems first day of life"
capture label var m3_709_b3 "Baby 3: Experienced other health problems first day of life"

capture label var m3_710_b1 "Baby 1: Spent time in a special care nursery or intensive care"
capture label var m3_710_b2 "Baby 2: Spent time in a special care nursery or intensive care"
capture label var m3_710_b3 "Baby 3: Spent time in a special care nursery or intensive care"

capture label var m3_710a "Baby 1: Spent time in special care nursery or intensive care unit"
capture label var m3_710b "Baby 2: Spent time in special care nursery or intensive care unit"
capture label var m3_710c "Baby 3: Spent time in special care nursery or intensive care unit"

capture label var m3_baby1_710 "Baby 1: Spent time in special care nursery/ICU before discharge"
capture label var m3_baby2_710 "Baby 2: Spent time in special care nursery/ICU before discharge"
capture label var m3_baby3_710 "Baby 3: Spent time in special care nursery/ICU before discharge"

*******************************************************



capture label var m3_711_days_b1 "Baby 1: Days spent in health facility after birth"
capture label var m3_711_days_b2 "Baby 2: Days spent in health facility after birth"
capture label var m3_711_days_b3 "Baby 3: Days spent in health facility after birth"

capture label var m3_711_hours_b1 "Baby 1: Hours spent in health facility after birth"
capture label var m3_711_hours_b2 "Baby 2: Hours spent in health facility after birth"
capture label var m3_711_hours_b3 "Baby 3: Hours spent in health facility after birth"

capture label var m3_711_weeks_b1 "Baby 1: Weeks spent in health facility after birth"
capture label var m3_711_weeks_b2 "Baby 2: Weeks spent in health facility after birth"
capture label var m3_711_weeks_b3 "Baby 3: Weeks spent in health facility after birth"

capture label var m3_711a "Baby 1: Hours stayed at health facility after birth"
capture label var m3_711a_days "Baby 1: Days in special care nursery/ICU before discharge"
capture label var m3_711a_hours "Baby 1: Hours in special care nursery/ICU before discharge"

capture label var m3_711b "Baby 2: Hours stayed at health facility after birth"
capture label var m3_711b_days "Baby 2: Days in special care nursery/ICU before discharge"
capture label var m3_711b_hours "Baby 2: Hours in special care nursery/ICU before discharge"

capture label var m3_711c "Baby 3: Hours stayed at health facility after birth"
capture label var m3_711c_days "Baby 3: Days in special care nursery/ICU before discharge"
capture label var m3_711c_hours "Baby 3: Hours in special care nursery/ICU before discharge"

capture label var m3_711c_1 "Baby 1: Time spent in health facility after being born"
capture label var m3_711c_2 "Baby 2: Time spent in health facility after being born"

capture label var m3_711c_1_unit "Baby 1: Time spent in health facility after being born (Unit of time)"
capture label var m3_711c_2_unit "Baby 2: Time spent in health facility after being born (Unit of time)"

*******************************************************
*******************************************************

capture label var m3_801_a "Frequency in last 2wks: Little interest or pleasure in doing things"
capture label var m3_801_b "Frequency in last 2wks: Feeling down, depressed, or hopeless"

capture label var m3_801a "Frequency in last 2wks: Little interest or pleasure in doing things"
capture label var m3_801b "Frequency in last 2wks: Feeling down, depressed, or hopeless"
*******************************************************
capture label var m3_802a "Had a psychological counseling or therapy session with professional"
capture label var m3_802b "Psychological counseling/therapy: Number of sessions"
capture label var m3_802c "Psychological counseling/therapy: Minutes per session"

*******************************************************
capture label var m3_803a "Since delivery experienced: Severe or persistent headaches"
capture label var m3_803b "Since delivery experienced: A fever"
capture label var m3_803c "Since delivery experienced: Severe abdominal pain, not just discomfort"
capture label var m3_803d "Since delivery experienced: A lot of difficulty breathing even when resting"
capture label var m3_803e "Since delivery experienced: Convulsions or seizures"
capture label var m3_803f "Since delivery experienced: Repeated feinting or loss of consciousness"
capture label var m3_803g "Since delivery experienced: Continued heavy vaginal bleeding"
capture label var m3_803h "Since delivery experienced: Foul smelling vaginal discharge"
capture label var m3_803j "Since delivery experienced: Other major health problems"
capture label var m3_803j_other "Since delivery experienced: Other major health problems specified"

*******************************************************
capture label var m3_804 "Since delivery experienced: Other major health problems"

*******************************************************
capture label var m3_805 "Experienced constant leakage of urine or stool from vagina during day or night"
capture label var m3_806 "Days after birth leakage symptoms started"
capture label var m3_807 "Rate how much leakage problem interferes with everyday life (Scale)"
capture label var m3_808a "Sought treatment for leakage condition"
capture label var m3_808b "Why have not sought treatment for leakage"
capture label var m3_808b_other "Why have not sought treatment for leakage: Other reason specified"
capture label var m3_809 "Treatment stopped leakage problem"

*******************************************************
*******************************************************


capture label var m3_901_cost "Total cost of medications or supplements for the woman"
capture label var m3_901r_other "Received: Any other medicine or supplement specified"
capture label var m3_901a "Received: Iron or folic acid pills"
capture label var m3_901b "Received: Iron injection"
capture label var m3_901c "Received: Calcium pills"
capture label var m3_901d "Received: Multivitamins"
capture label var m3_901e "Received: Food supplements like Super Cereal or Plumpynut"
capture label var m3_901f "Received: Medicine for intestinal worms [endemic areas]"
capture label var m3_901g "Received: Medicine for malaria [endemic areas]"
capture label var m3_901h "Received: Medicine for HIV"
capture label var m3_901i "Received: Medicine for your emotions, nerves, depression, or mental health"
capture label var m3_901j "Received: Medicine for hypertension"
capture label var m3_901k "Received: Medicine for diabetes, including injections of insulin"
capture label var m3_901l "Received: Antibiotics for an infection"
capture label var m3_901m "Received: Aspirin"
capture label var m3_901n "Received: Paracetamol, or other pain relief drugs"
capture label var m3_901o "Received: Contraceptive pills"
capture label var m3_901p "Received: Contraceptive injection"
capture label var m3_901q "Received: Other contraception method"
capture label var m3_901r "Received: Any other medicine or supplement"
capture label var m3_901_other "Other medicine or supplement specified"
*****************************************
capture label var m3_902 "In total how much payed for new meds for yourself"
capture label var m3_902_1_cost "Baby 1: Total cost of medication or supplement"
capture label var m3_902_2_cost "Baby 2: Total cost of medication or supplement"

capture label var m3_902a_baby1 "Since born Baby 1 received: Iron supplements"
capture label var m3_902b_baby1 "Since born Baby 1 received: Vitamin A supplements"
capture label var m3_902c_baby1 "Since born Baby 1 received: Vitamin D supplements"
capture label var m3_902d_baby1 "Since born Baby 1 received: Oral rehydration salts (ORS)"
capture label var m3_902e_baby1 "Since born Baby 1 received: Antidiarrheal"
capture label var m3_902f_baby1 "Since born Baby 1 received: Antibiotics for an infection"
capture label var m3_902g_baby1 "Since born Baby 1 received: Medicine to prevent pneumonia"
capture label var m3_902h_baby1 "Since born Baby 1 received: Medicine for malaria"
capture label var m3_902i_baby1 "Since born Baby 1 received: Medicine for HIV"
capture label var m3_902j_baby1 "Since born Baby 1 received: Any other medicine or supplement"
capture label var m3_902j_baby1_other "Since born Baby 1 received: Any other medicine or supplement specified"

capture label var m3_902a_baby2 "Since born Baby 2 received: Iron supplements"
capture label var m3_902b_baby2 "Since born Baby 2 received: Vitamin A supplements"
capture label var m3_902c_baby2 "Since born Baby 2 received: Vitamin D supplements"
capture label var m3_902d_baby2 "Since born Baby 2 received: Oral rehydration salts (ORS)"
capture label var m3_902e_baby2 "Since born Baby 2 received: Antidiarrheal"
capture label var m3_902f_baby2 "Since born Baby 2 received: Antibiotics for an infection"
capture label var m3_902g_baby2 "Since born Baby 2 received: Medicine to prevent pneumonia"
capture label var m3_902h_baby2 "Since born Baby 2 received: Medicine for malaria"
capture label var m3_902j_baby2 "Since born Baby 2 received: Any other medicine or supplement"
capture label var m3_902j_baby2_other "Since born Baby 2 received: Any other medicine or supplement specified"

capture label var m3_902a_baby3 "Since born Baby 3 received: Iron supplements"
capture label var m3_902b_baby3 "Since born Baby 3 received: Vitamin A supplements"
capture label var m3_902c_baby3 "Since born Baby 3 received: Vitamin D supplements"
capture label var m3_902d_baby3 "Since born Baby 3 received: Oral rehydration salts (ORS)"
capture label var m3_902e_baby3 "Since born Baby 3 received: Antidiarrheal"
capture label var m3_902f_baby3 "Since born Baby 3 received: Antibiotics for an infection"
capture label var m3_902g_baby3 "Since born Baby 3 received: Medicine to prevent pneumonia"
capture label var m3_902h_baby3 "Since born Baby 3 received: Medicine for malaria"
capture label var m3_902i_baby2 "Since born Baby 2 received: Medicine for HIV"
capture label var m3_902i_baby3 "Since born Baby 3 received: Medicine for HIV"
capture label var m3_902j_baby3 "Since born Baby 3 received: Any other medicine or supplement"
capture label var m3_902j_baby3_other "Since born Baby 3 received: Any other medicine or supplement specified"



*****************************************

capture label var m3_903_other_b1 "Since born Baby 1 received: Other medicine or supplement specified"
capture label var m3_903_other_b2 "Since born Baby 2 received: Other medicine or supplement specified"
capture label var m3_903_other_b3 "Since born Baby 3 received: Other medicine or supplement specified"

capture label var m3_903a_b1 "Since born Baby 1 received: Iron supplements"
capture label var m3_903a_b2 "Since born Baby 2 received: Iron supplements"
capture label var m3_903a_b3 "Since born Baby 3 received: Iron supplements"

capture label var m3_903b_b1 "Since born Baby 1 received: Vitamin A supplements"
capture label var m3_903b_b2 "Since born Baby 2 received: Vitamin A supplements"
capture label var m3_903b_b3 "Since born Baby 3 received: Vitamin A supplements"

capture label var m3_903c_b1 "Since born Baby 1 received: Vitamin D supplements"
capture label var m3_903c_b2 "Since born Baby 2 received: Vitamin D supplements"
capture label var m3_903c_b3 "Since born Baby 3 received: Vitamin D supplements"

capture label var m3_903d_b1 "Since born Baby 1 received: Oral rehydration salts"
capture label var m3_903d_b2 "Since born Baby 2 received: Oral rehydration salts"
capture label var m3_903d_b3 "Since born Baby 3 received: Oral rehydration salts"

capture label var m3_903e_b1 "Since born Baby 1 received: Antidiarrheal"
capture label var m3_903e_b2 "Since born Baby 2 received: Antidiarrheal"
capture label var m3_903e_b3 "Since born Baby 3 received: Antidiarrheal"

capture label var m3_903f_b1 "Since born Baby 1 received: Antibiotics for an infection"
capture label var m3_903f_b2 "Since born Baby 2 received: Antibiotics for an infection"
capture label var m3_903f_b3 "Since born Baby 3 received: Antibiotics for an infection"

capture label var m3_903g_b1 "Since born Baby 1 received: Medicine to prevent pneumonia"
capture label var m3_903g_b2 "Since born Baby 2 received: Medicine to prevent pneumonia"
capture label var m3_903g_b3 "Since born Baby 3 received: Medicine to prevent pneumonia"

capture label var m3_903h_b1 "Since born Baby 1 received: Medicine for malaria [endemic areas]"
capture label var m3_903h_b2 "Since born Baby 2 received: Medicine for malaria [endemic areas]"
capture label var m3_903h_b3 "Since born Baby 3 received: Medicine for malaria [endemic areas]"

capture label var m3_903i_b1 "Since born Baby 1 received: Medicine for HIV [HIV+ mothers only]"
capture label var m3_903i_b2 "Since born Baby 2 received: Medicine for HIV [HIV+ mothers only]"
capture label var m3_903i_b3 "Since born Baby 3 received: Medicine for HIV [HIV+ mothers only]"

capture label var m3_903j_b1 "Since born Baby 1 received: Any other medicine or supplement"
capture label var m3_903j_b2 "Since born Baby 2 received: Any other medicine or supplement"
capture label var m3_903j_b3 "Since born Baby 3 received: Any other medicine or supplement"

capture label var m3_904 "In total how much payed for new meds for baby"




*******************************************************
*******************************************************

capture label var m3_1001 "Rate quality of care received for delivery"
capture label var m3_1002 "Likelihood to recommend facility or provider"
capture label var m3_1003 "Staff suggested or asked for bribe, informal payment or gift"
capture label var m3_1004a "Rate: Knowledge and skills of your provider"
capture label var m3_1004b "Rate: Equipment & supplies provider had available tests"
capture label var m3_1004c "Rate: Level of respect the provider showed you"
capture label var m3_1004d "Rate: Clarity of the provider's explanations"
capture label var m3_1004e "Rate: Degree to which provider involved you in decisions about your care"
capture label var m3_1004f "Rate: Amount of time the provider spent with you"
capture label var m3_1004g "Rate: Amount of time you waited before being seen"
capture label var m3_1004h "Rate: Courtesy & helpfulness of  healthcare facility staff"
capture label var m3_1004i "Rate: Confidentiality of care or diagnosis"
capture label var m3_1004j "Rate: Privacy (auditory or visual) maintained"

capture label var m3_1005a "During delivery: Pinched by a health worker or other staff"
capture label var m3_1005b "During delivery: Slapped by a health worker or other staff"
capture label var m3_1005c "During delivery: Physically tied to bed/held down to the bed forcefully by staff"
capture label var m3_1005d "During delivery: Had forceful downward pressure put on abdomen before baby out"
capture label var m3_1005e "During delivery: Were shouted or screamed at by a health worker or other staff"
capture label var m3_1005f "During delivery: Scolded by a health worker or other staff"
capture label var m3_1005g "During delivery: Staff made negative comments regarding your sexual activity"
capture label var m3_1005h "During delivery: Staff threatened poor outcome for baby if did not comply"

capture label var m3_1006a "Received vaginal examination at any point at health facility"
capture label var m3_1006b "Provider asked permission before performing vaginal exam"
capture label var m3_1006c "Vaginal exam conducted privately"
capture label var m3_1007a "Offered any form of pain relief while at facility"
capture label var m3_1007b "Requested pain relief during time at facility"
capture label var m3_1007c "Received pain relief during time at facility"

capture label var m3_1101 "Paid money out of pocket for delivery"

capture label var m3_1102_total "Total spent"
capture label var m3_1102a_amt "Amount spent on: Registration/consultation"
capture label var m3_1102b_amt "Amount spent on: Medicine/vaccines"
capture label var m3_1102c_amt "Amount spent on: Test or investigations (lab tests, ultrasound etc.)"
capture label var m3_1102d_amt "Amount spent on: Transport round trip (+ accompanying person)"
capture label var m3_1102e_amt "Amount spent on: Food /accommodation (+ accompanying person)"
capture label var m3_1102f_amt "Amount spent on: Other items"
capture label var m3_1102f_oth "Amount spent on: Other service or product specified "


capture label var m3_1102_other "Other expenses specified"
capture label var m3_1102_total_calc "Calculated : Total amount spent"
capture label var m3_1102a "Spent money on: Registration/ Consultation"
capture label var m3_1102b "Spent money on: Medicine/vaccines (including outside purchases)"
capture label var m3_1102c "Spent money on: Test/investigations (x-ray, lab etc.)"
capture label var m3_1102d "Spent money on: Transport round trip (+ accompanying person)"
capture label var m3_1102e "Spent money on: Food /accommodation (+ accompanying person)"
capture label var m3_1102f "Spent money on: Other items"

capture label var m3_1103 "Total amount spent"
capture label var m3_1103_confirm "Total amount confirmed"

capture label var m3_1104 "Correct total amount spent"
capture label var m3_1105_1 "Financial source used: Current income of any household members"
capture label var m3_1105_2 "Financial source used: Savings (e.g. bank account)"
capture label var m3_1105_3 "Financial source used: Payment or reimbursement from a health insurance plan"
capture label var m3_1105_4 "Financial source used: Sold items (e.g. furniture, animals, jewellery, furniture)"
capture label var m3_1105_5 "Financial source used: Family members or friends from outside the household"
capture label var m3_1105_6 "Financial source used: Borrowed (from someone other than a friend or family)"

capture label var m3_1105 "Financial source used"
capture label var m3_1105_96 "Financial source used: Other"
capture label var m3_1105a "Financial source used: Current income of any household members"
capture label var m3_1105b "Financial source used: Savings (bank account)"
capture label var m3_1105c "Financial source used: Payment/reimbursement from health insurance"
capture label var m3_1105d "Financial source used: Sold items (furniture, animals, jewellery)"
capture label var m3_1105e "Financial source used: Family members/friends outside household"
capture label var m3_1105f "Financial source used: Borrowed (other than friend or family)"
capture label var m3_1105g "Financial source used: Loan (bank, movile money, loan shark)"
capture label var m3_1105_other "Financial source used: Other specified"
capture label var m3_1106 "Rate satisfaction with health services received during labor & delivery"

***************************************************************
***************************************************************

capture label var m3_1201 "Followed up with health facility during miscarriage"
capture label var m3_1202 "Rate quality of care received for miscarriage"

capture label var m3_1203 "Go to health facility to receive abortion"
capture label var m3_1204 "Rate quality of care received for abortion"
capture label var m3_1205 "Location for abortion"
capture label var m3_1205_other "Location for abortion: Other specified"
capture label var m3_1206 "Facility name for abortion"


***************************************************************
***************************************************************

*capture label var m3_baby1_age "Baby 1: Age in days"
capture label var m3_baby1_deathga "Baby 1: Death before or after 20 weeks"
capture label var m3_baby2_deathga "Baby 2: Death before or after 20 weeks"
capture label var m3_baby3_deathga "Baby 3: Death before or after 20 weeks"






capture label var m3_breastfeeding_fx_et "Average number of times breastfeed baby/ies per day"




capture label var m3_ga "Current gestational age in weeks"
capture label var m3_hiv_status "HIV status"
capture label var m3_interviewer "Interviewer ID"
capture label var m3_maternal_death_learn "How did you learn about maternal death"
capture label var m3_maternal_death_learn_other "How did you learn about the maternal death: Other specified"
capture label var m3_maternal_death_reported "Maternal death reported"
capture label var M3_maternal_outcome "Maternal outcome at M3"
capture label var m3_p1_complete "Completed"
capture label var m3_p1_date_of_rescheduled "Rescheduled interview : Date"
capture label var m3_p1_time_of_rescheduled "Rescheduled interview : Time"
capture label var m3_p2_date_of_rescheduled "Rescheduled interview : Date (2)"
capture label var m3_p2_outcome "Outcome of phone call"
capture label var m3_p2_outcome_other "Outcome of phone call: Other specified"
capture label var m3_p2_time_of_rescheduled "Rescheduled interview : Time (2)"
capture label var m3_permission "Permission granted to conduct call"
capture label var m3_permission_p2 "Permission granted to conduct call"
capture label var m3_respondentid "Respondent ID"
capture label var m3_start_p2 "Permission to proceed with interview"
capture label var m3_time "Time interview started"
capture label var m3_time_p2 "Time interview started (2)"



capture label var m3_abortion "Abortion"
capture label var m3_after2weeks_call_ke "Call 2 weeks after delivery"
capture label var m3_num_alive_babies "Calculated : Alive babies"
capture label var m3_attempt_number "Which attempt is this at calling the household of ?"
capture label var m3_attempt_outcome "Call response"
capture label var m3_ga1_ke "Confirmed gestational age"
capture label var m3_start_p1 "Permission to proceed with interview"
capture label var m3_num_dead_babies "Calculated: Dead babies"
capture label var m3_duration "Total duration of interview"
capture label var m3_endtime "Time interview ended"
capture label var facility_name "Facility name"
capture label var m3_ga_final "Final gestational age at delivery"
capture label var m3_ga2_ke "Gestational age updated"
capture label var m3_consent_recording "Are you happy to continue and to have your agreement to participate record"
capture label var m3_language "Language used for most of the survey"
capture label var m3_miscarriage "Miscarriage"
capture label var m3_phq2_score "PHQ-2 score"
capture label var m3_pregnancy_loss "Pregnancy loss"


* Add shortened variable labels for codebook purposes
	
* These variables are the same for all countries 

* These variable labes are country specific
if "${Country}" == "ET" {
	
	capture label var time_between_m1_birth "Time from M1 inteview date and date pregnancy ended (m3_birth_or_ended - m1_date)/7"
	capture label var pregnancyend_ga "Gestational age at time pregnancy ended (m1_ga + time_between_m1_birth)"
	capture label var preterm_birth "Pregnancy ended before 37 weeks (pregnancyend_ga <37 )"

	capture label var m3_617_vitaK_b1_ET "ET: Baby 1: Received Vitamina K injection"
	capture label var m3_617_vitaK_b2_ET "ET: Baby 2: Received Vitamina K injection"
	capture label var m3_617_vitaK_b3_ET "ET: Baby 3: Received Vitamina K injection"
	
	capture label var m3_619h "ET: Advice on: Need to exposure your baby/babies for Sun light"
	capture label var m3_619i "ET: Advice on: Family planning"
	capture label var m3_619j "ET: Advice on: Maternal nutrition"
	
	capture label var m3_607a_et "ET: Health care provider frequently assessed fetal heart beat"
	capture label var m3_607b_et "ET: Health care provider assessed abdominal contraction"
	capture label var m3_607c_et "ET: Health care provider frequently did vaginal examination"
	capture label var m3_607d_et "ET: Health care provider frequently assessed BP"
	capture label var m3_607e_et "ET: Health care provider check your temperature frequently"

	capture label var m3_803i "ET: Since delivery experienced: Blurring of vision"

}

if "${Country}" == "ZA" {
	capture label var m3_202 "Are you still pregnant, or did something else happen?"
	capture label var m3_601a "Did healthcare provider: Ask about HIV status?"
	capture label var m3_708a "1st day Baby 1: Experienced health issues"
	capture label var m3_708b "1st day Baby 2: Experienced health issues"
	capture label var m3_baby3_feed_b "Baby 3: how fed by Formula"
	capture label var m3_baby3_feed_g "Baby 3: how fed by Local food"
	capture label var m3_1103 "Total amount confirmed"
	capture label var m3_baby1_feed_b "Baby 1: how fed by Formula"
	capture label var m3_baby2_feed_b "Baby 2: how fed by Formula"
	capture label var m3_baby1_feed_g "Baby 1: how fed by Local food"
	capture label var m3_baby2_feed_g "Baby 2: how fed by Local food"
	capture label var m3_consultation2_reason_other "2nd Consultation : Reason for visit Other specified"
	capture label var m3_902i_baby1 "Since born Baby 1 received: Medicine for HIV/ARVs"

}

if "${Country}" == "IN" {
	capture label var m3_202 "Are you still pregnant, or did something else happen?"
	capture label var m3_601a "Did healthcare provider: Ask about HIV status?"
	capture label var m3_1103 "Total amount confirmed"
	capture label var m3_902i_baby1 "Since born Baby 1 received: Medicine for HIV/ARVs"
	
	capture label var time_between_m1_birth "Time from M1 inteview date and date pregnancy ended (m3_302 - m1_date)/7"
	capture label var pregnancyend_ga "Gestational age at time pregnancy ended (m1_ga + time_between_m1_birth)"
	capture label var preterm_birth "Pregnancy ended before 37 weeks (pregnancyend_ga <37 )"
	
	capture label var m3_502 "Health facility type"
	capture label var m3_503 "Health facility name"

}

if "${Country}" == "KE" {
	
	capture label var m3_412g_1_other "At 1st consultation had: Any other test specified"
	capture label var m3_412g_2_other "At 2nd consultation had: Any other test specified"

	capture label var m3_412a_1_ke "At 1st consultation had: Blood pressure measured"
	capture label var m3_412a_2_ke "At 2nd consultation had: Blood pressure measured"
	capture label var m3_412a_3_ke "At 3rd consultation had: Blood pressure measured"
	
	capture label var m3_412b_1_ke "At 1st consultation had: Weight taken"
	capture label var m3_412b_2_ke "At 2nd consultation had: Weight taken"
	capture label var m3_412b_3_ke "At 3rd consultation had: Weight taken"
	
	capture label var m3_412c_1_ke "At 1st consultation had: Blood draw"
	capture label var m3_412c_2_ke "At 2nd consultation had: Blood draw"
	capture label var m3_412c_3_ke "At 3rd consultation had: Blood draw"
	
	capture label var m3_412d_1_ke "At 1st consultation had: Blood test using finger prick"
	capture label var m3_412d_2_ke "At 2nd consultation had: Blood test using finger prick"
	capture label var m3_412d_3_ke "At 3rd consultation had: Blood test using finger prick"
	
	capture label var m3_412e_1_ke "At 1st consultation had: A urine test "
	capture label var m3_412e_2_ke "At 2nd consultation had: A urine test "
	capture label var m3_412e_3_ke "At 3rd consultation had: A urine test "
	
	capture label var m3_412f_1_ke "At 1st consultation had: An ultrasound"
	capture label var m3_412f_2_ke "At 2nd consultation had: An ultrasound"
	capture label var m3_412f_3_ke "At 3rd consultation had: An ultrasound"
	
	capture label var m3_412g_1_ke "At 1st consultation had: Any other test"
	capture label var m3_412g_2_ke "At 2nd consultation had: Any other test"
	capture label var m3_412g_3_ke "At 3rd consultation had: Any other test"
	
	capture label var m3_412i_1_ke "At 1st consultation had: No tests completed"
	capture label var m3_412i_2_ke "At 2nd consultation had: No tests completed"

	capture label var m3_614_ke "KE: Time after delivery: First check took place"
	capture label var m3_614_ke_unit "KE: Time after delivery: First check took place (Unit of time)"

	
	capture label var m3_621c_ke "KE: Time after delivery checkup occurred"
	capture label var m3_621c_ke_unit "KE: Time after delivery checkup occurred (Unit of time)"

	capture label var m3_621a_98_ke "KE: Assisted in delivery: Don´t know"
	capture label var m3_621a_99_ke "KE: Assisted in delivery: No response/Refuse"
	capture label var m3_621a_1_ke "KE: Assisted in delivery: A relative or a friend"
	capture label var m3_621a_2_ke "KE: Assisted in delivery: A traditional birth attendant"
	capture label var m3_621a_3_ke "KE: Assisted in delivery: A community health worker"
	capture label var m3_621a_4_ke "KE: Assisted in delivery: A nurse"
	capture label var m3_621a_5_ke "KE: Assisted in delivery: A midwife"
	capture label var m3_621a_6_ke "KE: Assisted in delivery: A doctor"

	capture label var m3_708a_ke "KE: Baby 1: Experienced health Issues first day of life"
	capture label var m3_708b_ke "KE: Baby 2: Experienced health Issues first day of life"

	capture label var m3_707_ke "KE: Time stayed after delivery"
	capture label var m3_707_ke_unit "KE: Time stayed after delivery (Unit of time)"
	
	capture label var m3_baby1_issues_other_ke "Baby 1: Experienced 1st day of life: Other health issues"
	capture label var m3_baby2_issues_other_ke "Baby 2: Experienced 1st day of life: Other health issues"
	capture label var m3_baby2_issues_othertext_ke "1st day Baby 2: Other health issues specified"

	
	capture label var m3_baby3_feed_b "Baby 3: how fed by Formula"
	capture label var m3_baby3_feed_g "Baby 3: how fed by Local food"
	capture label var m3_1103 "Total amount confirmed"
	capture label var m3_baby1_feed_b "Baby 1: how fed by Formula"
	capture label var m3_baby2_feed_b "Baby 2: how fed by Formula"
	capture label var m3_baby1_feed_e "Baby 1: how fed by Broth/Soup"
	capture label var m3_baby2_feed_e "Baby 2: how fed by Broth/Soup"
	capture label var m3_baby1_feed_g "Baby 1: how fed by Local food"
	capture label var m3_baby2_feed_g "Baby 2: how fed by Local food"
	capture label var m3_breastfeeding "Baby 1: Confidence in beastfeeding"
	capture label var m3_breastfeeding_2 "Baby 2: Confidence in beastfeeding"
	capture label var m3_504b "City where delivered"
	capture label var m3_504a "Facility name where delivered: Open text"
	capture label var m3_513b2 "First facility: City where facility located"
	capture label var m3_513_outside_zone_other "First facility: Facility name if not in list"
	capture label var m3_602a "Health care provider looked at mother and child booklet"
	capture label var m3_901h "Received: Medicine for HIV/ARVs"
	capture label var m3_902i_baby1 "Since born Baby 1 received: Medicine for HIV/ARVs"
	
	capture label var m3_518_96_ke "KE: Reason for referral: Other delivery complications "
	capture label var m3_518_97_ke "KE: Reason for referral: Other reasons"
	capture label var m3_518_98_ke "KE: Reason for referral: Don´t know"
	capture label var m3_518_99_ke "KE: Reason for referral: No response/Refuse"
	capture label var m3_518a_ke "KE: Reason for referral: The provider did not give a reason"
	capture label var m3_518b_ke "KE: Reason for referral: No space or no bed available"
	capture label var m3_518k_ke "KE: Reason for referral: Bleeding"
	capture label var m3_518c_ke "KE: Reason for referral: Facility did not provide delivery care"
	capture label var m3_518d_ke "KE: Reason for referral: Prolonged labor"
	capture label var m3_518e_ke "KE: Reason for referral: Obstructed labor"
	capture label var m3_518f_ke "KE: Reason for referral: Eclampsia/pre-eclampsia"
	capture label var m3_518g_ke "KE: Reason for referral: Previous cesarean section scar"
	capture label var m3_518h_ke "KE: Reason for referral: Fetal distress"
	capture label var m3_518i_ke "KE: Reason for referral: Fetal presentation"
	capture label var m3_518j_ke "KE: Reason for referral: No fetal movement/heartbeat"
	
	capture label var m3_weeks_from_outcome_ke "KE: Weeks from the preganancy outcome"
	
	capture label var time_between_m1_birth "Time from M1 inteview date and date pregnancy ended (m3_birth_or_ended - m1_date)/7"
	capture label var pregnancyend_ga "Gestational age at time pregnancy ended (gest_age_baseline_ke + time_between_m1_birth)"
	capture label var preterm_birth "Pregnancy ended before 37 weeks (pregnancyend_ga <37 )"



}


end