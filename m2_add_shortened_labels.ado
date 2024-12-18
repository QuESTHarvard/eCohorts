/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-10-24		1.00	MK Trimner		Original code
*******************************************************************************/

* This program will add shortened labels to the M1 datasts so that the codebook is helpful

* It will also add characters with the full text question
capture program drop m2_add_shortened_labels
program define m2_add_shortened_labels

capture label var m2_respondentid "Respondent ID from M2"

* Add shortened variable labels for codebook purposes
	
* These variables are the same for all countries 
forvalues i = 1/10 {
	capture label var m2_attempt_date_r`i' "R`i': Date of M2 attempt"
	capture label var m2_attempt_number_r`i' "R`i': M2 attempt number"
	capture label var m2_attempt_number_other_r`i' "R`i': M2 attempt number other specified "
	capture label var m2_attempt_outcome_r`i' "R`i': Outcome of call"
	capture label var m2_resp_lang1_r`i' "R`i': Language"
	capture label var language_r`i' "R`i': Language used for most of the survey"
	capture label var language_oth_r`i' "R`i': Language used for most of the survey: Other specified"
	
	capture label var m2_county_r`i' "R`i': County"
	capture label var m2_time_of_rescheduled_r`i' "R`i': Time of rescheduled"
	capture label var m2_date_of_rescheduled_r`i' "R`i': Date of rescheduled"
	capture label var m2_attempt_relationship_r`i' "R`i': Relationship to respondent"
	capture label var m2_attempt_other_r`i' "R`i': Specify other relationship with the respondent"

	capture label var m2_attempt_avail_r`i' "R`i': Respondent available"
	capture label var m2_attempt_contact_r`i' "R`i': Is this still the best contact"
	capture label var m2_attempt_bestnumber_r`i' "R`i': Best number to contact respondent"
	capture label var m2_attempt_goodtime_r`i' "R`i': Good time to contact respondent"
	capture label var m2_consent_r`i' "R`i': May I proceed with the interview?"
	capture label var m2_consent_recording_r`i' "R`i': Permission granted to record call"
	capture label var m2_permission_r`i' "R`i': Permission granted to conduct call"
	capture label var m2_date_r`i' "R`i': Date of interview"
	capture label var m2_date_time_r`i' "R`i': Date and start time of interview"
	capture label var m2_103_r`i' "R`i': Date of interview"
	capture label var m2_lastdate_r`i' "R`i': Last interview date in module"
	capture label var m2_time_start_r`i' "R`i': Start time of interview"
	capture label var m2_start_time_r`i'"R`i': Start time of interview"

	capture label var m2_start_r`i' "R`i': Permission to proceed with interview"
	capture label var m2_endstatus_r`i' "R`i': Woman's current status at end of interview"
	capture label var m2_site_r`i' "R`i': Facility Name"
	
	capture label var m2_interviewer_r`i' "R`i': Interviewer ID"
	capture label var m2_respondentid_r`i' "R`i': Respondent ID"

	capture label var m2_111_other_r`i' "R`i': How learned about maternal death: Other specified 2nd time collected"

	capture label var m2_maternal_death_reported_r`i' "R`i': Maternal death reported"
	capture label var m2_ga_r`i' "R`i': Gestational age at time of call"
	capture label var m2_ga_estimate_r`i' "R`i': Gestational age at time of call based on maternal estimation in weeks"
	capture label var m2_hiv_status_r`i' "R`i': HIV Status"

	capture label var m2_date_of_maternal_death_r`i' "R`i': Date of maternal death"
	capture label var m2_maternal_death_learn_r`i' "R`i': How learned about maternal death"
	capture label var m2_maternal_death_learn_other_r`i' "R`i': How learned about maternal death: Other specified"
	capture label var m2_111_r`i' "R`i': How learned about maternal death: 2nd time collected"
	capture label var m2_date_of_maternal_death_2_r`i' "R`i': Date of maternal death: 2nd time collected"

	capture label var m2_201_r`i' "R`i': Rate overall health since last phone call"
	capture label var m2_202_r`i' "R`i': Still pregnant at time of call"
	capture label var m2_202_delivery_date_r`i' "R`i': Delivery date"
	capture label var m2_202_other_r`i' "R`i': What happened"
	capture label var m2_202_other_date_r`i' "R`i': Date of pregnancy outcome"
	
	capture label var m2_203a_r`i' "R`i': Since last spoke: Experienced: Severe or persistent headaches"
	capture label var m2_203b_r`i' "R`i': Since last spoke: Experienced: Vaginal bleeding of any amount"
	capture label var m2_203c_r`i' "R`i': Since last spoke: Experienced: A fever"
	capture label var m2_203d_r`i' "R`i': Since last spoke: Experienced: Severe abdominal pain, not just discomfort"
	capture label var m2_203e_r`i' "R`i': Since last spoke: Experienced: A lot of difficulty breathing"
	capture label var m2_203f_r`i' "R`i': Since last spoke: Experienced: Convulsions or seizures" 

	capture label var m2_203g_r`i' "R`i': Since last spoke: Experienced: Repeated fainting or loss of consciousness"
	capture label var m2_203h_r`i' "R`i': Since last spoke: Experienced: Noticing baby has completely stopped moving"
	capture label var m2_203i_r`i' "R`i': Since last spoke: Experienced: Blurring of vision"
	
	capture label var m2_204a_et_r`i' "R`i': ET: Since last spoke: Experienced: Preeclampsia/eclampsia"
	capture label var m2_204b_et_r`i' "R`i': ET: Since last spoke: Experienced: Bleeding during pregnancy"
	capture label var m2_204c_et_r`i' "R`i': ET: Since last spoke: Experienced: Hyperemesis gravidarum"
	capture label var m2_204d_et_r`i' "R`i': ET: Since last spoke: Experienced: Anemia"
	capture label var m2_204e_et_r`i' "R`i': ET: Since last spoke: Experienced: Cardiac problems"
	capture label var m2_204f_et_r`i' "R`i': ET: Since last spoke: Experienced: Amniotic uid volume problems"
	capture label var m2_204g_et_r`i' "R`i': ET: Since last spoke: Experienced: Asthma"
	capture label var m2_204h_et_r`i' "R`i': ET: Since last spoke: Experienced: RH isoimmunization"
	capture label var m2_204i_r`i' "R`i': Since last spoke: Experienced: Any other health problems"
	capture label var m2_204_other_r`i' "R`i': Since last spoke: Experienced: Any other health problems: Other specified"
	capture label var m2_204i_other_r`i' "R`i': Since last spoke: Experienced: Any other health problems: Other specified"

	
	capture label var m2_205a_r`i' "R`i': Frequency in last 2wks: Little interest or pleasure in doing things"
	capture label var m2_205b_r`i' "R`i': Frequency in last 2wks: Feeling down, depressed, or hopeless"
	capture label var m2_205c_r`i' "R`i': Frequency in last 2wks: Trouble falling,staying asleep, or sleeping too much"
	capture label var m2_205d_r`i' "R`i': Frequency in last 2wks: Feeling tired or having little energy"
	capture label var m2_205e_r`i' "R`i': Frequency in last 2wks: Poor appetite or overeating"
	capture label var m2_205f_r`i' "R`i': Frequency in last 2wks: Feeling bad about self,failure,let self/family down"
	capture label var m2_205g_r`i' "R`i': Frequency in last 2wks: Trouble concentrating on things (work/home duties)"
	capture label var m2_205h_r`i' "R`i': Frequency in last 2wks: Moving/speaking slowly or fidgety/restless"
	capture label var m2_205i_r`i' "R`i': Frequency in last 2wks: Thoughts would be better off dead or hurting self"
	
	capture label var m2_206_r`i' "R`i': Frequency currently smoke cigarettes or use any other type of tobacco"
	capture label var m2_207_r`i' "R`i': Frequency currently chew Khat"
	capture label var m2_208_r`i' "R`i': Frequency currently drink alcohol or use any other type of alcoholic"

	capture label var m2_301_r`i' "R`i': Since last spoke: New healthcare consultations for self"
	capture label var m2_302_r`i' "R`i': Since last spoke: Number of new consultations"
	capture label var m2_303_r`i' "R`i': Since last spoke: Location of new consultations"
	
	capture label var m2_303a_r`i' "R`i': Since last spoke: Location of 1st new consultation"
	capture label var m2_303b_r`i' "R`i': Since last spoke: Location of 2nd new consultation"
	capture label var m2_303c_r`i' "R`i': Since last spoke: Location of 3rd new consultation"
	capture label var m2_303d_r`i' "R`i': Since last spoke: Location of 4th new consultation"
	capture label var m2_303e_r`i' "R`i': Since last spoke: Location of 5th new consultation"
	
	capture label var m2_304a_r`i' "R`i': Since last spoke: Facility name where 1st consultation took place"
	capture label var m2_304a_other_r`i' "R`i': Since last spoke: Facility name 1st consultation: Other specified"
	capture label var m2_304b_r`i' "R`i': Since last spoke: Facility name where 2nd consultation took place"
	capture label var m2_304b_other_r`i' "R`i': Since last spoke: Facility name 2nd consultation: Other specified"
	capture label var m2_304c_r`i' "R`i': Since last spoke: Facility name where 3rd consultation took place"
	capture label var m2_304c_other_r`i' "R`i': Since last spoke: Facility name 3rd consultation: Other specified"
	capture label var m2_304d_r`i' "R`i': Since last spoke: Facility name where 4th consultation took place"
	capture label var m2_304d_other_r`i' "R`i': Since last spoke: Facility name 4th consultation: Other specified"
	capture label var m2_304e_r`i' "R`i': Since last spoke: Facility name where 5th consultation took place"
	capture label var m2_304e_other_r`i' "R`i': Since last spoke: Facility name 5th consultation: Other specified"
	
	capture label var m2_305_r`i' "R`i': Since last spoke: 1st Consultation : ANC visit"
	capture label var m2_306_r`i' "R`i': Since last spoke: 1st Consultation : Referral from ANC provider"
	capture label var m2_307_r`i' "R`i': Since last spoke: 1st Consultation : New health problem"
	capture label var m2_307_1_r`i' "R`i': Since last spoke: 1st Consultation : New health problem"
	capture label var m2_307_2_r`i' "R`i': Since last spoke: 1st Consultation : Existing health problem"
	capture label var m2_307_3_r`i' "R`i': Since last spoke: 1st Consultation : Lab test, x-ray or ultrasound"
	capture label var m2_307_4_r`i' "R`i': Since last spoke: 1st Consultation : Pick up medicine"
	capture label var m2_307_5_r`i' "R`i': Since last spoke: 1st Consultation : To get a vaccine"
	capture label var m2_307_96_r`i' "R`i': Since last spoke: 1st Consultation : Other reasons"
	capture label var m2_307_other_r`i' "R`i': Since last spoke: 1st Consultation : Other reasons Specified"
	
	capture label var m2_308_r`i' "R`i': Since last spoke: 2nd Consultation : ANC visit"
	capture label var m2_309_r`i' "R`i': Since last spoke: 2nd Consultation : Referral from ANC provider"
	capture label var m2_310_1_r`i' "R`i': Since last spoke: 2nd Consultation : New health problem"
	capture label var m2_310_2_r`i' "R`i': Since last spoke: 2nd Consultation : Existing health problem"
	capture label var m2_310_3_r`i' "R`i': Since last spoke: 2nd Consultation : Lab test, x-ray or ultrasound"
	capture label var m2_310_4_r`i' "R`i': Since last spoke: 2nd Consultation : Pick up medicine"
	capture label var m2_310_5_r`i' "R`i': Since last spoke: 2nd Consultation : To get a vaccine"
	capture label var m2_310_96_r`i' "R`i': Since last spoke: 2nd Consultation : Other reasons"
	capture label var m2_310_other_r`i' "R`i': Since last spoke: 2nd Consultation : Other reasons Specified"
	
	capture label var m2_311_r`i' "R`i': Since last spoke: 3rd Consultation : ANC visit"
	capture label var m2_312_r`i' "R`i': Since last spoke: 3rd Consultation : Referral from ANC provider"
	capture label var m2_313_1_r`i' "R`i': Since last spoke: 3rd Consultation : New health problem"
	capture label var m2_313_2_r`i' "R`i': Since last spoke: 3rd Consultation : Existing health problem"
	capture label var m2_313_3_r`i' "R`i': Since last spoke: 3rd Consultation : Lab test, x-ray or ultrasound"
	capture label var m2_313_4_r`i' "R`i': Since last spoke: 3rd Consultation : Pick up medicine"
	capture label var m2_313_5_r`i' "R`i': Since last spoke: 3rd Consultation : To get a vaccine"
	capture label var m2_313_96_r`i' "R`i': Since last spoke: 3rd Consultation : Other reasons"
	capture label var m2_313_other_r`i' "R`i': Since last spoke: 3rd Consultation : Other reasons Specified"
	
	capture label var m2_314_r`i' "R`i': Since last spoke: 4th Consultation : ANC visit"
	capture label var m2_315_r`i' "R`i': Since last spoke: 4th Consultation : Referral from ANC provider"
	capture label var m2_316_1_r`i' "R`i': Since last spoke: 4th Consultation : New health problem"
	capture label var m2_316_2_r`i' "R`i': Since last spoke: 4th Consultation : Existing health problem"
	capture label var m2_316_3_r`i' "R`i': Since last spoke: 4th Consultation : Lab test, x-ray or ultrasound"
	capture label var m2_316_4_r`i' "R`i': Since last spoke: 4th Consultation : Pick up medicine"
	capture label var m2_316_5_r`i' "R`i': Since last spoke: 4th Consultation : To get a vaccine"
	capture label var m2_316_96_r`i' "R`i': Since last spoke: 4th Consultation : Other reasons"
	capture label var m2_316_other_r`i' "R`i': Since last spoke: 4th Consultation : Other reasons Specified"
	
	capture label var m2_317_r`i' "R`i': Since last spoke: 5th Consultation : ANC visit"
	capture label var m2_318_r`i' "R`i': Since last spoke: 5th Consultation : Referral from ANC provider"
	capture label var m2_319_r`i'  "R`i': Since last spoke: 5th Consultation : All reasons for new visit"
	capture label var m2_319_1_r`i' "R`i': Since last spoke: 5th Consultation : New health problem"
	capture label var m2_319_2_r`i' "R`i': Since last spoke: 5th Consultation : Existing health problem"
	capture label var m2_319_3_r`i' "R`i': Since last spoke: 5th Consultation : Lab test, x-ray or ultrasound"
	capture label var m2_319_4_r`i' "R`i': Since last spoke: 5th Consultation : Pick up medicine"
	capture label var m2_319_5_r`i' "R`i': Since last spoke: 5th Consultation : To get a vaccine"
	capture label var m2_319_96_r`i' "R`i': Since last spoke: 5th Consultation : Other reasons"
	capture label var m2_319_other_r`i' "R`i': Since last spoke: 5th Consultation : Other reasons Specified"
	
	capture label var m2_320_r`i' "R`i': Since last spoke: Reason no ANC earlier: All reasons"
	capture label var m2_320_0_r`i' "R`i': Since last spoke: Reason no ANC earlier: No reason or you didn't need it"
	capture label var m2_320_1_r`i' "R`i': Since last spoke: Reason no ANC earlier: Tried earlier & were sent away"
	capture label var m2_320_2_r`i' "R`i': Since last spoke: Reason no ANC earlier: High cost"
	capture label var m2_320_3_r`i' "R`i': Since last spoke: Reason no ANC earlier: Far distance"
	capture label var m2_320_4_r`i' "R`i': Since last spoke: Reason no ANC earlier: Long waiting time"
	capture label var m2_320_5_r`i' "R`i': Since last spoke: Reason no ANC earlier: Poor healthcare provider skills"
	capture label var m2_320_6_r`i' "R`i': Since last spoke: Reason no ANC earlier: Staff don't show respect"
	capture label var m2_320_7_r`i' "R`i': Since last spoke: Reason no ANC earlier: Medicines/equipment not available"
	capture label var m2_320_8_r`i' "R`i': Since last spoke: Reason no ANC earlier: COVID-19 restrictions"
	capture label var m2_320_9_r`i' "R`i': Since last spoke: Reason no ANC earlier: COVID-19 fear"
	capture label var m2_320_10_r`i' "R`i': Since last spoke: Reason no ANC earlier: Don't know where to go"
	capture label var m2_320_11_r`i' "R`i': Since last spoke: Reason no ANC earlier: Fear discovering serious problems"
	capture label var m2_320_96_r`i' "R`i': Since last spoke: Reason no ANC earlier: Other, specify"
	capture label var m2_320_99_r`i' "R`i': Since last spoke: Reason no ANC earlier: No response/Refused to answer"
	capture label var m2_320_other_r`i' "R`i': Since last spoke: Reason no ANC earlier: Other specified"
	
	capture label var m2_321_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy (phone/SMS)"

	capture label var m2_401_r`i' "R`i': Since last spoke: Rate quality of care for 1st Consultation"
	capture label var m2_402_r`i' "R`i': Since last spoke: Rate quality of care for 2nd Consultation"
	capture label var m2_403_r`i' "R`i': Since last spoke: Rate quality of care for 3rd Consultation"
	capture label var m2_404_r`i' "R`i': Since last spoke: Rate quality of care for 4th Consultation"
	capture label var m2_405_r`i' "R`i': Since last spoke: Rate quality of care for 5th Consultation"

	capture label var m2_501_r`i' "R`i': Since we last spoke: All diagnostic tests received listed"
	capture label var m2_501a_r`i' "R`i': Since last spoke: Had blood preassure measured"
	capture label var m2_501b_r`i' "R`i': Since last spoke: Had weight taken"
	capture label var m2_501c_r`i' "R`i': Since last spoke: Had a blood draw"
	capture label var m2_501d_r`i' "R`i': Since last spoke: Had a blood test using a finger prick"
	capture label var m2_501e_r`i' "R`i': Since last spoke: Had a urine test"
	capture label var m2_501f_r`i' "R`i': Since last spoke: Had an ultrasound"
	capture label var m2_501g_r`i' "R`i': Since last spoke: Had an other tests"
	capture label var m2_501g_other_r`i' "R`i': Since last spoke: Had an other tests: Specified"
	capture rename m2_501_0_r`i' m2_501h_r`i'
	capture label var m2_501h_r`i' "R`i': Since last spoke: Had none of the above tests done"
	
	capture label var m2_502_r`i' "R`i': Since last spoke: Received any test results"
	capture label var m2_503_r`i' "R`i': Since last spoke: Which test results did you receive" 
	
	capture label var m2_503a_r`i' "R`i': Since last spoke: Received Anemia results"
	capture label var m2_503b_r`i' "R`i': Since last spoke: Received HIV results"
	capture label var m2_503c_r`i' "R`i': Since last spoke: Received results for HIV viral load"
	capture label var m2_503d_r`i' "R`i': Since last spoke: Received Syphilis results"
	capture label var m2_503e_r`i' "R`i': Since last spoke: Received Diabetes results"
	capture label var m2_503f_r`i' "R`i': Since last spoke: Received Hypertension results"
	capture label var m2_503g_za_r`i' "R`i': Since last spoke: Received TB results"
	capture rename m2_503_0_r`i'   m2_503h_r`i'
	capture label var m2_503h_r`i' "R`i': Since last spoke: Received none of the above test results"

	capture label var m2_504_r`i' "R`i': Since last spoke: Received any other new test results"
	capture label var m2_504_other_r`i' "R`i': Since last spoke: Received any other new test results: Other specified"
	
	capture label var m2_505_r`i' "R`i': Since last spoke: Result of Anemia test"

	capture label var m2_505a_r`i' "R`i': Since last spoke: Result of Anemia test"
	capture label var m2_505b_r`i' "R`i': Since last spoke: Result of HIV test"
	capture label var m2_505c_r`i' "R`i': Since last spoke: Result of HIV viral load"
	capture label var m2_505d_r`i' "R`i': Since last spoke: Result of Syphilis test"
	capture label var m2_505e_r`i' "R`i': Since last spoke: Result of Diabetes test"
	capture label var m2_505f_r`i' "R`i': Since last spoke: Result of Hypertension test"
	capture label var m2_505g_r`i' "R`i': Since last spoke: Result of any other new tests"
	capture label var m2_505h_za_r`i' "R`i': Since last spoke: Result of TB test"
	
	capture label var m2_506_r`i' "R`i': Since last spoke: Provider discussed: All items listed"
	capture label var m2_506a_r`i' "R`i':Since last spoke:Provider discuss complication signs require health facility"
	capture label var m2_506b_r`i' "R`i': Since last spoke: Provider discussed birth plan"
	capture label var m2_506c_r`i' "R`i': Since last spoke: Provider discussed newborn care"
	capture label var m2_506d_r`i' "R`i': Since last spoke: Provider discussed family planning after delivery"
	capture rename m2_506_0_r`i' m2_506e_r`i'
	capture label var m2_506e_r`i' "R`i': Since last spoke: Provider discussed none of the above"

	
	
	capture label var m2_507_r`i' "R`i': Since last spoke: What did provider advise for new symptoms"
	capture label var m2_507_other_r`i' "R`i': Since last spoke: Other specified advise for new symptoms"
	
	capture label var m2_507_1_r`i' "R`i':Since last spoke: Advice regarding symptoms: Nothing, did not discuss this"
	capture label var m2_507_2_r`i' "R`i':Since last spoke: Advice regarding symptoms: Told to get a lab test/imaging"
	capture label var m2_507_3_r`i' "R`i':Since last spoke:Advice regarding symptoms:Provided a treatment during visit"
	capture label var m2_507_4_r`i' "R`i':Since last spoke: Advice regarding symptoms: Prescribed a medication"
	capture label var m2_507_5_r`i' "R`i':Since last spoke:Advice regarding symptoms:Told to come back to this facility"
	capture label var m2_507_6_r`i' "R`i':Since last spoke: Advice regarding symptoms:Told to go for higher level care"
	capture label var m2_507_7_r`i' "R`i':Since last spoke: Advice regarding symptoms: Told to wait and see"
	capture label var m2_507_96_r`i' "R`i':Since last spoke: Advice regarding symptoms: Other"

	
	capture label var m2_508a_r`i' "R`i':Since last spoke: Had a session to see a mental health provider/psychologist"
	capture label var m2_508b_yn_r`i' "R`i': Since last spoke: Know number of sessions had with mental health provider"
	capture label var m2_508b_num_r`i' "R`i':Since last spoke:Number of sessions with mental health provider/psychologist"
	
	capture label var m2_508c_yn_r`i' "R`i': Since last spoke: Do you know how long sessions took?"
	capture label var m2_508c_time_r`i' "R`i': Since last spoke: Minutes for each session with mental health provider"
	
	capture label var m2_509_r`i' "R`i': Since last spoke provider: What heath care rpovider told you: All responses"
	capture label var m2_509a_r`i' "R`i': Since last spoke provider: Told to see a specialist like ob or gyn"
	capture label var m2_509b_r`i' "R`i': Since last spoke provider: Told to go to the hospital for ANC follow up"
	capture label var m2_509c_r`i' "R`i': Since last spoke provider: Said would need a C-section"
	capture rename m2_509_0_r`i' m2_509d_r`i' 
	capture label var m2_509d_r`i' "R`i': Since last spoke provider: Said none of the above"

	capture label var m2_601_r`i' "R`i': Since last spoke did you get any of the following"
	
	capture label var m2_601a_r`i' "R`i': Since last spoke received/bought: Iron or folic acid pills"
	capture label var m2_601b_r`i' "R`i': Since last spoke received/bought: Calcium pills"
	capture label var m2_601c_r`i' "R`i': Since last spoke received/bought: Multivitamins"
	capture label var m2_601d_r`i' "R`i': Since last spoke received/bought: Food supplements (Super Cereal/Plumpynut)"
	capture label var m2_601e_r`i' "R`i': Since last spoke received/bought: Intestinal worm"
	capture label var m2_601f_r`i' "R`i': Since last spoke received/bought: Medicine for malaria"
	capture label var m2_601g_r`i' "R`i': Since last spoke received/bought: Medicine for HIV"
	capture label var m2_601h_r`i' "R`i': Since last spoke received/bought: Medicine for mental health"
	capture label var m2_601i_r`i' "R`i': Since last spoke received/bought: Medicine for hypertension/ high BP"
	capture label var m2_601j_r`i' "R`i': Since last spoke received/bought: Medicine for diabetes"
	capture label var m2_601k_r`i' "R`i': Since last spoke received/bought: Antibiotics for an infection"
	capture label var m2_601l_r`i' "R`i': Since last spoke received/bought: Aspirin"
	capture label var m2_601m_r`i' "R`i': Since last spoke received/bought: Paracetamol, or other pain relief drugs"
	capture label var m2_601n_r`i' "R`i': Since last spoke received/bought: Other medicine or supplement"
	capture label var m2_601o_r`i' "R`i': Since last spoke received/bought: Iron injection"
	capture rename m2_601_0_r`i' m2_601p_r`i' 
	capture label var m2_601p_r`i'  "R`i': Since last spoke received/bought: None of the above"

	
	capture label var m2_601_other_r`i' "R`i': Since last spoke received/bought: Other medicine or supplement Specified"
	capture label var m2_601n_other_r`i' "R`i': Since last spoke received/bought: Other medicine or supplement Specified"
	
	capture label var m2_602a_r`i' "R`i': Since last spoke: Know how much in total paid for new medication"
	capture label var m2_602b_r`i' "R`i': Since last spoke: Total amount paid for new meications or supplements (ETB)"
	capture label var m2_603_r`i' "R`i': Since last spoke: Currently taking iron and folic acid pills"
	capture label var m2_604_r`i' "R`i': Since last spoke: Frequency take iron and folic acid pills"

	capture label var m2_701_r`i' "R`i': Since last spoke: Paid money out of pocket for new visits"
	
	capture label var m2_702a_r`i' "R`i': Since last spoke: Spent money on: Registration/consultation"
	capture label var m2_702a_cost_r`i' "R`i': Since last spoke: Amount spent on: Registration/consultation"
	
	capture label var m2_702b_r`i' "R`i': Since last spoke: Spent money on: Test/investigations"
	capture label var m2_702b_cost_r`i' "R`i': Since last spoke: Amount spent on: Test/investigations"
	
	capture label var m2_702c_r`i' "R`i': Since last spoke: Spent money on: Transport round trip(+accompanying person)"
	capture label var m2_702c_cost_r`i' "R`i':Since last spoke: Amount spent on:Transport round trip(+accompanying person)"
	
	capture label var m2_702d_r`i' "R`i': Since last spoke: Spent money on: Food/accommodation (+accompanying person)"
	capture label var m2_702d_cost_r`i' "R`i':Since last spoke: Amount spent on: Food/accommodation (+accompanying person)"
	
	capture label var m2_702e_r`i' "R`i': Since last spoke: Spent money on: Other services"
	capture label var m2_702e_cost_r`i' "R`i': Since last spoke: Amount spent on: Other services"
	
	capture label var m2_702_other_r`i' "R`i': Since last spoke: Spent on: Other services specified"
	capture label var m2_702b_other_r`i' "R`i': Since last spoke: Amount spent on: Other services specified"
	
	capture label var m2_703_r`i' "R`i': Since last spoke: Total amount spent"
	capture label var m2_704_r`i' "R`i': Since last spoke: Confirm total amount spent is correct"
	capture label var m2_704_confirm_r`i' "R`i': Since last spoke: Correct total amount spent"
	
	capture label var m2_705_r`i' "R`i': Since last spoke: Financial source used to pay for costs"
	capture label var m2_705_1_r`i' "R`i': Since last spoke: Financial source: Current income of any household members"
	capture label var m2_705_2_r`i' "R`i': Since last spoke: Financial source: Savings (bank account)"
	capture label var m2_705_3_r`i' "R`i':Since last spoke:Financial source:Health insurance payment/reimbursement "
	capture label var m2_705_4_r`i' "R`i': Since last spoke: Financial source: Sold items(furniture/animals/jewellery)"
	capture label var m2_705_5_r`i' "R`i': Since last spoke: Financial source: Family members/friends outside household"
	if `i' == 10 capture label var m2_705_5_r`i' "R`i': Since last spoke: Financial source:Family members/friends outside household"
	capture label var m2_705_6_r`i' "R`i': Since last spoke: Financial source: Borrowed (other than friend or family)"
	capture label var m2_705_96_r`i' "R`i': Since last spoke: Financial source: Other"
	capture label var m2_705_other_r`i' "R`i': Since last spoke: Financial source: Other source specified"

	capture label var m2_interview_inturrupt_r`i' "R`i': M2 Interview interrupted"
	capture label var m2_interupt_time_r`i' "R`i': M2 interview interrupted time"
	capture label var m2_interview_restarted_r`i' "R`i': M2 interview restarted"
	capture label var m2_restart_time_r`i' "R`i': M2 interview restart time"
	capture label var m2_endtime_r`i' "R`i': M2 end time"
	capture label var m2_int_duration_r`i' "R`i': M2 total duration of interview (minutes)"
	capture label var duration_r`i' "R`i': M2 total duraiton of interview"

	* These variable labes are country specific
	if "${Country}" == "ET" {

	}

	if "${Country}" == "ZA" {
	}

	if "${Country}" == "IN" {
		capture label var m2_204a_r`i' "R`i': Since last spoke: Experienced: Preeclampsia/eclampsia"
		capture label var m2_204b_r`i' "R`i': Since last spoke: Experienced: Bleeding during pregnancy"
		capture label var m2_204c_r`i' "R`i': Since last spoke: Experienced: Hyperemesis gravidarum"
		capture label var m2_204d_r`i' "R`i': Since last spoke: Experienced: Anemia"
		capture label var m2_204e_r`i' "R`i': Since last spoke: Experienced: Cardiac problems"
		capture label var m2_204f_r`i' "R`i': Since last spoke: Experienced: Amniotic uid volume problems"
		capture label var m2_204g_r`i' "R`i': Since last spoke: Experienced: Asthma"
		capture label var m2_204h_r`i' "R`i': Since last spoke: Experienced: RH isoimmunization"	
		
		capture label var m2_321_org_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy (phone/SMS)"
		capture label var m2_321_0_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy: No"
		capture label var m2_321_1_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy: Yes, by phone"
		capture label var m2_321_2_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy: Yes, by SMS"
		capture label var m2_321_3_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy: Yes, by web"
		capture label var m2_321_98_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy: Don't Know"
		capture label var m2_321_99_r`i' "R`i':Since last spoke:Contacted health care provider about pregnancy: No response/Refused to answer"
		
		capture label var m2_507_99_r`i' "R`i':Since last spoke: Advice regarding symptoms: No response/refused to answer"
		capture label var m2_507_98_r`i' "R`i':Since last spoke: Advice regarding symptoms: Don't know"
		


	
	}

	if "${Country}" == "KE" {
		
		capture rename consent_r`i' m2_consent_r`i'
		capture label var m2_consent_r`i' "R`i': May I proceed with the interview?"

		
		capture label var m2_maternal_death_learn_oth_r`i' "R`i': How learned about maternal death: Other specified"

		
		capture label var m2_306_1_r`i' "R`i': Since last spoke: 1st Consultation : New health problem"
		capture label var m2_306_2_r`i' "R`i': Since last spoke: 1st Consultation : Existing health problem"
		capture label var m2_306_3_r`i' "R`i': Since last spoke: 1st Consultation : Lab test, x-ray or ultrasound"
		capture label var m2_306_4_r`i' "R`i': Since last spoke: 1st Consultation : Pick up medicine"
		capture label var m2_306_5_r`i' "R`i': Since last spoke: 1st Consultation : To get a vaccine"
		capture label var m2_306_96_r`i' "R`i': Since last spoke: 1st Consultation : Other reasons"
		capture label var m2_306_other_r`i' "R`i': Since last spoke: 1st Consultation : Other reasons Specified"

		capture label var m2_308_1_r`i' "R`i': Since last spoke: 2nd Consultation : New health problem"
		capture label var m2_308_2_r`i' "R`i': Since last spoke: 2nd Consultation : Existing health problem"
		capture label var m2_308_3_r`i' "R`i': Since last spoke: 2nd Consultation : Lab test, x-ray or ultrasound"
		capture label var m2_308_4_r`i' "R`i': Since last spoke: 2nd Consultation : Pick up medicine"
		capture label var m2_308_5_r`i' "R`i': Since last spoke: 2nd Consultation : To get a vaccine"
		capture label var m2_308_96_r`i' "R`i': Since last spoke: 2nd Consultation : Other reasons"
		capture label var m2_308_other_r`i' "R`i': Since last spoke: 2nd Consultation : Other reasons Specified"
		
		capture label var m2_311_1_r`i' "R`i': Since last spoke: 3rd Consultation : New health problem"
		capture label var m2_311_2_r`i' "R`i': Since last spoke: 3rd Consultation : Existing health problem"
		capture label var m2_311_3_r`i' "R`i': Since last spoke: 3rd Consultation : Lab test, x-ray or ultrasound"
		capture label var m2_311_4_r`i' "R`i': Since last spoke: 3rd Consultation : Pick up medicine"
		capture label var m2_311_5_r`i' "R`i': Since last spoke: 3rd Consultation : To get a vaccine"
		capture label var m2_311_96_r`i' "R`i': Since last spoke: 3rd Consultation : Other reasons"
		capture label var m2_311_other_r`i' "R`i': Since last spoke: 3rd Consultation : Other reasons Specified"

		capture label var m2_314_1_r`i' "R`i': Since last spoke: 4th Consultation : New health problem"
		capture label var m2_314_2_r`i' "R`i': Since last spoke: 4th Consultation : Existing health problem"
		capture label var m2_314_3_r`i' "R`i': Since last spoke: 4th Consultation : Lab test, x-ray or ultrasound"
		capture label var m2_314_4_r`i' "R`i': Since last spoke: 4th Consultation : Pick up medicine"
		capture label var m2_314_5_r`i' "R`i': Since last spoke: 4th Consultation : To get a vaccine"
		capture label var m2_314_96_r`i' "R`i': Since last spoke: 4th Consultation : Other reasons"
		capture label var m2_314_other_r`i' "R`i': Since last spoke: 4th Consultation : Other reasons Specified"
		
		capture label var m2_317_1_r`i' "R`i': Since last spoke: 5th Consultation : New health problem"
		capture label var m2_317_2_r`i' "R`i': Since last spoke: 5th Consultation : Existing health problem"
		capture label var m2_317_3_r`i' "R`i': Since last spoke: 5th Consultation : Lab test, x-ray or ultrasound"
		capture label var m2_317_4_r`i' "R`i': Since last spoke: 5th Consultation : Pick up medicine"
		capture label var m2_317_5_r`i' "R`i': Since last spoke: 5th Consultation : To get a vaccine"
		capture label var m2_317_96_r`i' "R`i': Since last spoke: 5th Consultation : Other reasons"
		capture label var m2_317_other_r`i' "R`i': Since last spoke: 5th Consultation : Other reasons Specified"

		capture label var m2_320a_r`i' "R`i': Since last spoke: Reason no ANC earlier: No reason or you didn't need it"
		capture label var m2_320b_r`i' "R`i': Since last spoke: Reason no ANC earlier: Tried earlier & were sent away"
		capture label var m2_320c_r`i' "R`i': Since last spoke: Reason no ANC earlier: High cost"
		capture label var m2_320d_r`i' "R`i': Since last spoke: Reason no ANC earlier: Far distance"
		capture label var m2_320e_r`i' "R`i': Since last spoke: Reason no ANC earlier: Long waiting time"
		capture label var m2_320f_r`i' "R`i': Since last spoke: Reason no ANC earlier: Poor healthcare provider skills"
		capture label var m2_320g_r`i' "R`i': Since last spoke: Reason no ANC earlier: Staff don't show respect"
		capture label var m2_320h_r`i' "R`i': Since last spoke: Reason no ANC earlier: Medicines/equipment not available"
		capture label var m2_320i_r`i' "R`i': Since last spoke: Reason no ANC earlier: COVID-19 restrictions"
		capture label var m2_320j_r`i' "R`i': Since last spoke: Reason no ANC earlier: COVID-19 fear"
		capture label var m2_320k_r`i' "R`i': Since last spoke: Reason no ANC earlier: Don't know where to go"
		capture label var m2_320_12_ke_r`i' "R`i': Since last spoke: Reason no ANC earlier: Fear discovering serious problems"
		
		capture label var m2_601g_r`i' "R`i': Since last spoke received/bought: Medicine for HIV/ARVs"
		
		capture label var m2_702_meds_ke_r`i' "R`i': Total costs for medicine (Ksh.) includes costs indicated in section 6"
		
		capture label var m2_interviewer_r`i' "R`i': Interviewer Name"
		capture label var m2_phq2_ke_r`i' "R`i': PHQ score"
		capture label var resp_language_r`i' "R`i':Able to communicate with respondent (Does not speak foreign language)"
		

		
	}
}


end