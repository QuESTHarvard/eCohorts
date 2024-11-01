/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-10-24		1.00	MK Trimner		Original code
*******************************************************************************/

* This program will add shortened labels to the M1 datasts so that the codebook is helpful

* It will also add characters with the full text question
capture program drop m1_add_shortened_labels
program define m1_add_shortened_labels

	* Add a character that holds the current label as the full question text
	foreach v of varlist * {
		char `v'[Full_Question_Text] `:var label `v''
	}
	
	
	* Add the character with the full question text not cut off
	capture char permission[Full_Question_Text] May we have your permission to explain why we are here today, and to ask some questions?
	capture char care_self[Full_Question_Text] Are you here today to receive care for yourself or someone else?
	capture char m1_enrollage[Full_Question_Text] How old are you?
	capture char zone_live[Full_Question_Text] Which zone/district/sub-county do you live in?
	capture char b5anc [Full_Question_Text] Are you here to receive antenatal care? By that I mean care related to a pregnancy?
	capture char b6anc_first[Full_Question_Text] Is this the first time you've come to a health facility to talk to a healthcare provider about this pregnancy?   
	capture char b7eligible[Full_Question_Text] Is the respondent eligible to participate in the study AND signed a consent form?
	capture char mobile_phone[Full_Question_Text] Do you have a mobile phone with you today?
	capture char phone_number[Full_Question_Text] What is your phone number? 
	capture char flash[Full_Question_Text] Can I "flash" this number now to make sure I have noted it correctly? 
	capture char m1_201[Full_Question_Text] In general, how would you rate your overall health? 
	capture char m1_203_other[Full_Question_Text] Before you got pregnant, were you diagnosed with any other major health problems?
	capture char m1_204[Full_Question_Text] Are you currently taking any medications including for the conditions we just talked about? 
	capture char m1_205a[Full_Question_Text] I am going to read three statements about your mobility, by which I mean your ability to walk around. Please indicate which statement best describe your own health state today.
	capture char m1_205b[Full_Question_Text] I am now going to read three statements regarding your ability to self-care, by which I mean whether you can wash and dress yourself without assistance Please indicate which statement best describe your own health state today
	capture char m1_205c[Full_Question_Text] I am going to read three statements regarding your ability to perform your usual daily activities, by which I mean your ability to work, take care of your family or perform leisure activities. Please indicate which statement best describe your own health state today.
	capture char m1_205d[Full_Question_Text] I am going to read three statements regarding your experience with physical pain or discomfort Please indicate which statement best describe your own health state today
	capture char m1_205e[Full_Question_Text] I am going to read three statements regarding your experience with anxiety or depression. Please indicate which statements best describe your own health state today.
	capture char m1_301[Full_Question_Text] How would you rate the overall quality of medical care in your country?
	capture char m1_302[Full_Question_Text] Which of the following statements comes closest to expressing your overall view of the health care system in your country?
	capture char m1_303[Full_Question_Text] How confident are you that if you became very sick tomorrow, you would receive good quality healthcare from the health system?
	capture char m1_304[Full_Question_Text] How confident are you that you would be able to afford the healthcare you needed if you became very sick?  This means you would be able to afford care without suffering financial hardship.
	capture char m1_305a[Full_Question_Text] Confidence that you that you are the person who is responsible for managing your overall health?
	capture char m1_305b[Full_Question_Text] Confidence that you that you can tell a healthcare provider concerns you have even when he or she does not ask
	capture char m1_401[Full_Question_Text] How did you travel to the facility today?  Please tell me the main method you used
	capture char m1_402[Full_Question_Text] How long in hours or minutes did it take you to reach this facility from your home?
	capture char m1_403b[Full_Question_Text] How far in kilometers is your home from this facility?
	capture char m1_404[Full_Question_Text] Is this the nearest health facility to your home that provides antenatal care for pregnant women or is there another one closer?
	capture char m1_405[Full_Question_Text] What is the most important reason for choosing this facility for your visit today?
	capture char m1_501[Full_Question_Text] What is your first language?
	capture char m1_502[Full_Question_Text] Have you ever attended school?
	capture char m1_503[Full_Question_Text] What is the highest level of education you have completed?
	capture char m1_504[Full_Question_Text] Now I would like you to read this sentence to me 1 PARENTS LOVE THEIR CHILDREN 3 THE CHILD IS READING A BOOK 4 CHILDREN WORK HARD AT SCHOOL
	capture char m1_505[Full_Question_Text] What is your current marital status?
	capture char m1_506[Full_Question_Text] What is your occupation, that is, what kind of work do you mainly do?
	capture char m1_507[Full_Question_Text] What is your religion?
	capture char m1_508[Full_Question_Text] How many people do you have near you that you can readily count on for help in times of difficulty such as to watch over children, bring you to the hospital, shop or market, or help you when you are sick?
	capture char m1_509a[Full_Question_Text] Now I would like to talk about something else.  Have you ever heard of an illness called HIV/AIDS?
	capture char m1_509b[Full_Question_Text] Do you think that people can get the HIV virus from mosquito bites?
	capture char m1_510a[Full_Question_Text] Have you ever heard of an illness called tuberculosis or TB?
	capture char m1_510b[Full_Question_Text] Do you think that TB can be treated using herbal or traditional medicine made from plants?
	capture char m1_511[Full_Question_Text] When children have diarrhea, do you think that they should be given less to drink than usual, more to drink than usual, about the same or it doesn't matter?
	capture char m1_512[Full_Question_Text] Is smoke from a wood burning traditional stove good for health, harmful for health or do you think it doesn't really matter?
	capture char m1_513a[Full_Question_Text] What phone numbers can we use to reach you in the coming months?
	capture char m1_513a_1[Full_Question_Text] Primary personal phone number
	capture char m1_513b[Full_Question_Text] Primary personal phone number
	capture char m1_513c[Full_Question_Text] Can I "flash" this number now to make sure I have noted it correctly? 
	capture char m1_513d[Full_Question_Text] Secondary personal phone number
	capture char m1_513e[Full_Question_Text] Spouse or partner phone number
	capture char m1_513f[Full_Question_Text] Community health worker phone number
	capture char m1_513g[Full_Question_Text] Close friend or family member phone number 1
	capture char m1_513h[Full_Question_Text] Close friend or family member phone number 2
	capture char m1_513i[Full_Question_Text] Other phone
	capture char m1_514a[Full_Question_Text] You will be allowed to use this phone for personal calls and to keep this phone after the study is completed. Would you like to receive a mobile phone?   
	capture char m1_514b[Full_Question_Text] New mobile phone number
	capture char m1_515_address[Full_Question_Text] Can you please tell me where you live? What is your address?
	capture char m1_516[Full_Question_Text] Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions.
	capture char m1_517[Full_Question_Text] Is this a temporary residence or a permanent residence? 
	capture char m1_518[Full_Question_Text] Until when will you be at this residence?
	capture char m1_519_district[Full_Question_Text] Where will your residence be after this date?
	capture char m1_519_ward[Full_Question_Text] Where will your residence be after this date: Ward
	capture char m1_519_village[Full_Question_Text] Where will your residence be after this date: Village
	capture char m1_519_county[Full_Question_Text] Where will your residence be after this date: County
	capture char m1_519_county_other[Full_Question_Text] Where will your residence be after this date: Other county
	capture char m1_519_subcounty[Full_Question_Text] Where will your residence be after this date: Sub-county
	capture char m1_519_subcounty_other[Full_Question_Text] Where will your residence be after this date: Other sub-country
	capture char m1_519_address[Full_Question_Text] Where will your residence be after this date: Address/Street name + house number
	capture char m1_519_directions[Full_Question_Text] Could you please describe directions to your residence? Please give us enough detail so that a data collection team member could find your residence if we needed to ask you some follow up questions
	capture char m1_601[Full_Question_Text] Overall, taking everything into account, how would you rate the quality of care you received today?
	capture char m1_602[Full_Question_Text] How likely are you to recommend this facility or provider to a family member or friend to receive care for their pregnancy?
	capture char m1_603[Full_Question_Text] How long in minutes did you spend with the health provider today?
	capture char m1_604[Full_Question_Text] How long in hours or minutes did you wait between the time you arrived at this facility and the time you were able to see a provider for the consultation?
	capture char m1_700[Full_Question_Text] Measure your blood pressure
	capture char m1_701[Full_Question_Text] Measure your weight
	capture char m1_702[Full_Question_Text] Measure your height
	capture char m1_703[Full_Question_Text] Measure your upper arm
	capture char m1_704[Full_Question_Text] Listen to the heart rate of the baby (that is, where the provider places a listening device against your belly to hear the baby's heart beating)
	capture char m1_705[Full_Question_Text] Take a urine sample (that is, you peed in a container)
	capture char m1_706[Full_Question_Text] Take a blood drop using a finger prick (that is, taking a drop of blood from your finger)
	capture char m1_707[Full_Question_Text] Take a blood draw (that is, taking blood from your arm with a syringe)
	capture char m1_708a[Full_Question_Text] Do an HIV test?
	capture char m1_708b[Full_Question_Text] Would you please share with me the result of the HIV test? Remember this information will remain confidential.
	capture char m1_708c[Full_Question_Text] Did the provider give you medicine for HIV?
	capture char m1_708d[Full_Question_Text] Did the provider explain how to take the medicine for HIV?
	capture char m1_708e[Full_Question_Text] Did the provider do an HIV viral load test?
	capture char m1_708f[Full_Question_Text] Did the provider do a CD4 test?
	capture char m1_709a[Full_Question_Text] Did the provider do an HIV viral load test?
	capture char m1_709b[Full_Question_Text] Did the provider do a CD4 test?
	capture char m1_710a[Full_Question_Text] Did they do a syphilis test?
	capture char m1_710b[Full_Question_Text] Would you please share with me the result of the syphilis test? Remember this information will remain confidential.
	capture char m1_710c[Full_Question_Text] Did the provider give you medicine for syphilis directly, gave you a prescription or told you to get it somewhere else, or neither?
	capture char m1_711a[Full_Question_Text] Did they do a blood sugar test for diabetes?
	capture char m1_711b[Full_Question_Text] Do you know the result of your blood sugar test?
	capture char m1_712[Full_Question_Text] Did they do an ultrasound (that is, when a probe is moved on your belly to produce a video of the baby on a screen)
	capture char m1_713a[Full_Question_Text] For each medication or supplement, please tell me if the provider today gave it to you directly, gave you a prescription or told you to get it somewhere else, or neither? 
	capture char m1_714a[Full_Question_Text] During the visit today, were you given an injection in the arm to prevent the baby from getting tetanus, that is, convulsions after birth?
	capture char m1_714b[Full_Question_Text] At any time BEFORE the visit today, did you receive any tetanus injections?
	capture char m1_714c[Full_Question_Text] Before today, how many times did you receive a tetanus injection?
	capture char m1_714d[Full_Question_Text] How many years ago did you receive that tetanus injection?
	capture char m1_714e[Full_Question_Text] How many years ago did you receive the last tetanus injection?
	capture char m1_715[Full_Question_Text] During the visit today, were you provided with an insecticide treated bed net to prevent malaria?
	capture char m1_717[Full_Question_Text] During the visit today, did you and the healthcare provider discuss that you were feeling down or depressed, or had little interest in doing things?
	capture char m1_718[Full_Question_Text] During the visit today, did you and the healthcare provider discuss your diabetes, or not?
	capture char m1_719[Full_Question_Text] During the visit today, did you and the healthcare provider discuss your high blood pressure or hypertension, or not?
	capture char m1_720[Full_Question_Text] During the visit today, did you and the healthcare provider discuss your cardiac problems or problems with your heart, or not? 
	capture char m1_721[Full_Question_Text] During the visit today, did you and the healthcare provider discuss your mental health disorder, or not?
	capture char m1_722[Full_Question_Text] During the visit today, did you and the healthcare provider discuss your HIV, or not?
	capture char m1_723[Full_Question_Text] During the visit today, did you and the healthcare provider discuss the medications you are currently taking, or not?
	capture char m1_724a[Full_Question_Text] That you should come back for another antenatal care visit at this facility?
	capture char m1_724b[Full_Question_Text] When did the provider tell you to come back? In how many weeks?
	capture char m1_724c[Full_Question_Text] Were you told to go see a specialist like an obstetrician or a gynecologist?
	capture char m1_724d[Full_Question_Text] Were you told that you should see a mental health provider like a psychologist or therapist?
	capture char m1_724e[Full_Question_Text] Were you told to go to the hospital for follow-up antenatal care
	capture char m1_724f[Full_Question_Text] To go somewhere else to do a urine test such as a lab or another health facility?
	capture char m1_724g[Full_Question_Text] To go somewhere else to do a blood test such as a lab or another health facility?
	capture char m1_724h[Full_Question_Text] To go somewhere else to do an HIV test such as a lab or another health facility?
	capture char m1_724i[Full_Question_Text] Were you told to go somewhere else to do an ultrasound such as a hospital or another health facility?
	capture char m1_801[Full_Question_Text] During the visit today, did the healthcare provider tell you the estimated date of delivery, or not?
	capture char m1_802a[Full_Question_Text] What is the estimated date of delivery the provider told you?
	capture char m1_802b_et[Full_Question_Text] Do you know your last normal menstrual period?
	capture char m1_802d_et[Full_Question_Text] Gestational age in weeks based on LNMP
	capture char m1_803[Full_Question_Text] How many months or weeks pregnant do you think you are?
	capture char m1_804[Full_Question_Text] Interviewer calculates the gestational age in trimester based on Q802 (estimated due date) or on Q803 (self-reported number of months pregnant)
	capture char m1_805[Full_Question_Text] How many babies are you pregnant with?
	capture char m1_806[Full_Question_Text] During the visit today, did the healthcare provider ask when you had your last period, or not?
	capture char m1_807[Full_Question_Text] When you got pregnant, did you want to get pregnant at that time?
	capture char m1_808[Full_Question_Text] There are many reasons why some women may not get antenatal care earlier in their pregnancy. Which, if any, of the following, are reasons you did not receive care earlier in your pregnancy? 
	capture char m1_809[Full_Question_Text] During the visit today, did you and the provider discuss your birth plan that is, where you will deliver, how you will get there, and how you need to prepare, or didn't you?
	capture char m1_810a[Full_Question_Text] Where do you plan to give birth? 
	capture char m1_810b[Full_Question_Text] What is the name of the [facility type from 807a] where you plan to give birth?
	capture char m1_811[Full_Question_Text] Do you plan to stay at a [maternity waiting home [ETH] / mothers' lodge [ZAF] before delivering your baby?
	capture char m1_812a[Full_Question_Text] During the visit today, did the provider tell you that you might need a C-section?
	capture char m1_812b[Full_Question_Text] What were you told about why you might need a C-section?
	capture char m1_813a[Full_Question_Text] Some women experience common health problems during pregnancy, like nausea, heartburn, leg cramps, or back pain. Did you experience any of these in your pregnancy so far, or not?
	capture char [Full_Question_Text] Some women experience common health problems during pregnancy, like nausea, heartburn, leg cramps, or back pain. Did you experience any of these in your pregnancy so far, or not?
	capture char m1_813b[Full_Question_Text] During the visit today did the provider give you a treatment or advice for addressing these kinds of problems?
	capture char m1_813a_2[Full_Question_Text] Some women experience common health problems during pregnancy. Did you experience heartburn in your pregnancy so far, or not?
	capture char m1_813c_et[Full_Question_Text] c. Some women experience common health problems during pregnancy. Did you experience leg cramps in your pregnancy so far, or not?
	capture char m1_813d_et[Full_Question_Text] Some women experience common health problems during pregnancy. Did you experience back pain in your pregnancy so far, or not?
	capture char m1_813e_et[Full_Question_Text] During the visit today did the provider give you treatment or advice for addressing these kinds of problems?
	capture char m1_2_8_et[Full_Question_Text] During the visit today, did the provider give you a treatment or advice for addressing these kinds of problems?
	capture char m1_814a[Full_Question_Text] Could you please tell me if you have experienced any of the following symptoms in your pregnancy so far, or not?
	capture char m1_814i[Full_Question_Text] ET only
	capture char m1_816[Full_Question_Text] You said that you did not have any of the symptoms I just listed. Did the health provider ask you whether or not you had these symptoms, or did this topic not come up today? 
	capture char m1_901[Full_Question_Text] How often do you currently smoke cigarettes or use any other type of tobacco? Is it every day, some days, or not at all?
	capture char m1_902[Full_Question_Text] During the visit today, did the health provider advise you to stop smoking or using tobacco products
	capture char m1_903[Full_Question_Text] How often do you chew khat? Is it every day, some days, or not at all?
	capture char m1_904[Full_Question_Text] During the visit today, did the health provider advise you to stop chewing khat?
	capture char m1_905[Full_Question_Text] Have you consumed an alcoholic drink within the past 30 days? 
	capture char m1_906[Full_Question_Text] When you do drink alcohol, how many drinks do you consume on average?
	capture char m1_907[Full_Question_Text] During the visit today, did the health provider advise you to stop drinking alcohol?
	capture char m1_908_za[Full_Question_Text] What is the age of your partner or father of the baby?
	capture char m1_909_za[Full_Question_Text] Have you ever given oral, anal, or vaginal sex to someone because you expected to get or got any of these things?
	capture char m1_910_za[Full_Question_Text] In the past 12 months, have you started or stayed in a relationship with a man or boy so that you could receive any of the following?
	capture char m1_1001[Full_Question_Text] Over the course of your life, how many pregnancies have you had, including the current pregnancy and regardless of whether you gave birth or not?
	capture char m1_1002[Full_Question_Text] Over the course of your life, how many births have you had (including babies born alive or dead)?
	capture char m1_1003[Full_Question_Text] n how many of those births was the baby born alive?
	capture char m1_1004[Full_Question_Text] Have you ever lost a pregnancy after 20 weeks of being pregnant?
	capture char m1_1005[Full_Question_Text] Have you ever had a baby that came too early, more than 3 weeks before the due date/ Small baby?
	capture char m1_1006[Full_Question_Text] Have you ever bled so much in a previous pregnancy or delivery that you needed to be given blood or go back to the delivery room for an operation?
	capture char m1_1_10_et[Full_Question_Text] Have you ever had a baby born with a congenital anomaly
	capture char m1_1007[Full_Question_Text] Have you ever had cesarean section (that is an operation to remove the baby through your abdomen)?
	capture char m1_1008[Full_Question_Text] Have you ever had a delivery that lasted more than 12 hours of you pushing?
	capture char m1_1009[Full_Question_Text] How many of your children are still alive?
	capture char m1_1010[Full_Question_Text] Have you ever had a baby die within the first month of their life?
	capture char m1_1101[Full_Question_Text] At any point during your current pregnancy, has anyone ever hit, slapped, kicked, or done anything else to hurt you physically?
	capture char m1_1102[Full_Question_Text] Who has done these things to you while you were pregnant?
	capture char m1_1103[Full_Question_Text] At any point during your current pregnancy, has anyone ever said or done something to humiliate you, insulted you or made you feel bad about yourself?
	capture char m1_1104[Full_Question_Text] Who has done these things to you while you were pregnant?
	capture char m1_1105[Full_Question_Text] During the visit today, did the health provider discuss with you where you can seek support for these things?
	capture char m1_1201[Full_Question_Text] What is the main source of drinking water for members of your household?
	capture char m1_1202[Full_Question_Text] What kind of toilet facilities does your household have?
	capture char m1_1203[Full_Question_Text] Does your household have electricity?
	capture char m1_1204[Full_Question_Text] Does your household have a radio?
	capture char m1_1205[Full_Question_Text] Does your household have a television?
	capture char m1_1206[Full_Question_Text] Does your household have a telephone or a mobile phone?
	capture char m1_1207[Full_Question_Text] Does your household have a refrigerator?
	capture char m1_1208[Full_Question_Text] What type of fuel does your household mainly use for cooking?
	capture char m1_1209[Full_Question_Text] What is the main material of your floor?
	capture char m1_1210[Full_Question_Text] What is the main material your walls are made of?
	capture char m1_1211[Full_Question_Text] What is the main material your roof is made of? 
	capture char m1_1212[Full_Question_Text] Does any member of your household own a bicycle?
	capture char m1_1213[Full_Question_Text] Does any member of your household own a motor cycle or motor scooter?
	capture char m1_1214[Full_Question_Text] Does any member of your household own a car or truck?
	capture char m1_1215[Full_Question_Text] Does any member of your household have a bank account?
	capture char m1_1216a[Full_Question_Text] Do you know the number of meals your household usually has per day
	capture char m1_1216b[Full_Question_Text] How many meals does your household usually have per day?
	capture char m1_1217[Full_Question_Text] Did you pay money out of your pocket for this visit, including for the consultation or other indirect costs like your transport to the facility?
	capture char m1_1218a[Full_Question_Text] Spent money on
	capture char m1_1218a_1[Full_Question_Text] How much money did you spend on Registration / Consultation?
	capture char m1_1218b[Full_Question_Text] Spent money on
	capture char m1_1218b_1[Full_Question_Text] How much money do you spent for medicine/vaccines (including outside purchase)
	capture char m1_1218c[Full_Question_Text] Spent money on
	capture char m1_1218c_1[Full_Question_Text] How much money have you spent on Test/investigations (x-ray, lab etc )?
	capture char m1_1218d[Full_Question_Text] Spent money on
	capture char m1_1218d_1[Full_Question_Text] How much money have you spent for transport (round trip) including that of person accompanying you?
	capture char m1_1218e[Full_Question_Text] Spent money on
	capture char m1_1218e_1[Full_Question_Text] How much money have you spent on food and accommodation including that of the person accompanying you?
	capture char m1_1218f[Full_Question_Text] Are there any other costs that you incurred during your visit?
	capture char m1_1218f_1[Full_Question_Text] How much were these other costs?
	capture char m1_1219[Full_Question_Text] So, in total you spent [Programming adds total from above] – is that correct?
	capture char m1_1220[Full_Question_Text] Which of the following financial sources did your household use to pay for this?
	capture char m1_1220_1[Full_Question_Text] Current income of any household members
	capture char m1_1220_2[Full_Question_Text] Savings (e.g. bank account)
	capture char m1_1220_3[Full_Question_Text] Payment or reimbursement from a health insurance plan
	capture char m1_1220_4[Full_Question_Text] Sold items (e.g. furniture, animals, jewellery, furniture)
	capture char m1_1220_5[Full_Question_Text] Family members or friends from outside the household
	capture char m1_1220_6[Full_Question_Text] Borrowed (from someone other than a friend or family)
	capture char m1_1220_96[Full_Question_Text] Other
	capture char m1_1221[Full_Question_Text] Are you covered with a health insurance?
	capture char m1_1222[Full_Question_Text] What type of health insurance coverage do you have?
	capture char m1_1223[Full_Question_Text] To conclude this survey, overall, please tell me how satisfied you are with the health services you received at this establishment today?
	capture char m1_1306[Full_Question_Text] Hemoglobin level available in maternal health card
	capture char m1_1309[Full_Question_Text] HEMOGLOBIN LEVEL FROM TEST PERFORMED BY DATA COLLECTOR
	capture char m1_1401[Full_Question_Text] What period of the day is most convenient for you to answer the phone survey?
	capture char m1_1402_1_et[Full_Question_Text] Best phone number
	capture char m1_1402_ke[Full_Question_Text] KE only: Is there a specific day in the week that you do not want to be called?


* Add the shortened labels so that the codebook shows the correct information
	capture label var m1_date "Date of interview"
	capture label var m1_start_time "Start time of interview"
	capture label var facility "Facility name"
	capture label var care_self "Here for care for self or someone else"
	capture label var m1_enrollage "Age "
	capture label var zone_live "Zone/district/sub-city"
	capture label var b5anc  "Here to receive care related to pregnancy"
	capture label var b6anc_first "First time came to facility to talk to provider about pregnancy"
	capture label var b7eligible "Eligible to participate in survey"
	capture label var first_name "First name"
	capture label var family_name "Family name"
	capture label var id_et "Respondent id"
	capture label var id_in "Respondent id"
	capture label var mobile_phone "Have mobile phone with you today"
	capture label var phone_number "Phone number m1_105"
	capture label var flash "Permission to "flash" number to ensure it is noted correctly"
	capture label var m1_201 "Rate overall health"
	capture label var m1_202a "Prior to pregnancy had:  Diabetes"
	capture label var m1_202b "Prior to pregnancy had:  High blood pressure or hypertension"
	capture label var m1_202c "Prior to pregnancy had: Cardiac disease or problem with your heart"
	capture label var m1_202d "Prior to pregnancy had: Mental health disorder"
	capture label var m1_202e "Prior to pregnancy had: HIV"
	capture label var m1_202f_et "Prior to pregnancy had: Hepatitis B"
	capture label var m1_202g_et "Prior to pregnancy had: Renal Disorder"
	capture label var m1_203_et "Prior to pregnancy: diagnosed with any other major health problems"
	capture label var m1_203_other "Prior to pregnancy: Other health problems"
	capture label var m1_204 "Currently taking medications for conditions named"
	capture label var m1_205a "Describe current mobility status"
	capture label var m1_205b "Describe current ability to do self care"
	capture label var m1_205c "Describe current ability to do daily activities"
	capture label var m1_205d "Describe experience with pain or discomfort"
	capture label var m1_205e "Describe experience with anxiety or depression"
	capture label var phq9a "Frequency in last 2wks: Little interest or pleasure in doing things"
	capture label var phq9b "Frequency in last 2wks: Feeling down, depressed, or hopeless"
	capture label var phq9c "Frequency in last 2wks: Trouble falling or staying asleep, or sleeping too much"
	capture label var phq9d "Frequency in last 2wks: Feeling tired or having little energy"
	capture label var phq9e "Frequency in last 2wks: Poor appetite or overeating"
	capture label var phq9f "Frequency in last 2wks:  Feeling bad about self/failure/let self or family down"
	capture label var phq9g "Frequency in last 2wks: Trouble concentrating on things ( work or home duties)"
	capture label var phq9h "Frequency in last 2wks: Moving/speaking slowly or fidgety/restless"
	capture label var phq9i "Frequency in last 2wks: Thoughts would be better off dead or hurting self"
	capture label var m1_301 "Rate quality of care in country"
	capture label var m1_302 "Overall view of health care system"
	capture label var m1_303 "Confidence would receive good care in health system"
	capture label var m1_304 "Confidence could afford care without financial hardship"
	capture label var m1_305a "Confidence you are responsible for managing your overall health"
	capture label var m1_305b "Confidence can tell healthcare provider concerns even when not asked"
	capture label var m1_401 "Method of travel to facility"
	capture label var m1_402 "Time took to reach facility"
	capture label var m1_403b "Distance in kilometers home is from facility"
	capture label var m1_404 "Nearest health facility to home that provides ANC or is there another one closer"
	capture label var m1_405 "Most important reason for choosing this facility"
	capture label var m1_405a_in "Most important reason choose facility: Low cost"
	capture label var m1_405b_in "Most important reason choose facility: Short distance"
	capture label var m1_405c_in "Most important reason choose facility: Short waiting time"
	capture label var m1_405d_in "Most important reason choose facility: Good healthcare provider skills "
	capture label var m1_405e_in "Most important reason choose facility: Staff shows respect "
	capture label var m1_405f_in "Most important reason choose facility: Medicines and equipment are available"
	capture label var m1_405g_in "Most important reason choose facility: Cleaner facility"
	capture label var m1_405h_in "Most important reason choose facility: Only facility available"
	capture label var m1_405i_in "Most important reason choose facility: Covered by insurance"
	capture label var m1_405j_in "Most important reason choose facility:Were referred or told to use this provider"
	capture label var m1_405_96_in "Most important reason choose facility: Other, specify"
	capture label var m1_405_99_in "Most important reason choose facility: No response/Refused to answer"
	capture label var m1_405_other "Most important reason choose facility: Other specified"
	capture label var m1_501 "First language"
	capture label var m1_501_other "First language: Other specified"
	capture label var m1_502 "Ever attended school"
	capture label var m1_503 "Highest level of education completed"
	capture label var m1_504 "Ability to read sentence"
	capture label var m1_505 "Marital status"
	capture label var m1_506 "Occupation"
	capture label var m1_506_other "Occupation: Other specified"
	capture label var m1_507 "Religion"
	capture label var m1_507_other "Religion: Other specified"
	capture label var m1_508 "Number of people to help in time of need"
	capture label var m1_509a "Heard of HIV or AIDS"
	capture label var m1_509b "Believe can get HIV virus from mosquito bites"
	capture label var m1_510a "Heard of tuberculosis or TB"
	capture label var m1_510b "Believe can treat TB with herbs or traditional medicine from plants"
	capture label var m1_511 "How much fluid should children with diarrhea should be given"
	capture label var m1_512 "Impact of smoke from a wood burning traditional stove on health"
	capture label var m1_513a "Phone numbers used to reach respondent in follow ups"
	capture label var m1_513a_1 "Primary personal phone number"
	capture label var m1_513b "Primary personal phone number"
	capture label var m1_513c "Permission to flash number to make sure noted correctly"
	capture label var m1_513d "Secondary personal phone number"
	capture label var m1_513e "Spouse or partner phone number"
	capture label var m1_513f "Community health worker phone number"
	capture label var m1_513g "Close friend or family member phone number 1"
	capture label var m1_513h "Close friend or family member phone number 2"
	capture label var m1_513i "Other phone"
	capture label var m1_514a "Receive phone to participate in survey"
	capture label var m1_514b "Phone number of phone provided"
	capture label var m1_515_address "Address"
	capture label var m1_516 "Directions to residence"
	capture label var m1_517 "Temporary or permanent residence"
	capture label var m1_518 "Date will be at residence until"
	capture label var m1_519_district "After this date where will you reside: District"
	capture label var m1_519_ward "After this date where will you reside: Ward"
	capture label var m1_519_village "After this date where will you reside: Village"
	capture label var m1_519_county "After this date where will you reside: County"
	capture label var m1_519_county_other "After this date where will you reside: County Other"
	capture label var m1_519_subcounty "After this date where will you reside: Subcounty"
	capture label var m1_519_subcounty_other "After this date where will you reside: Subcounty Other"
	capture label var m1_519_address "After this date where will you reside: Address"
	capture label var m1_519_directions "After this date where will you reside: Directions"
	capture label var m1_c1_in "Facility name after ANC"
	capture label var m1_c2_in "Enumerator name after ANC"
	capture label var m1_c3_in "First name after ANC"
	capture label var m1_c4_in "Family name after ANC"
	capture label var m1_c5_in "respondent id after ANC"
	capture label var m1_c6_in "Date of interview after ANC"
	capture label var m1_c7_in "Time of interview after ANC"
	capture label var m1_601 "Rate how visit went"
	capture label var m1_602 "Likelihood would recommend the facility or provider to family or friend"
	capture label var m1_603 "Minutes spent with health provider"
	capture label var m1_604 "Time waited to see health provider"
	capture label var m1_605a "Rate aspects of care: knowledge and skills of your provider"
	capture label var m1_605b "Rate aspects of care: equipment and supplies that the provider had available such as medical equipment or access to lab tests"
	capture label var m1_605c "Rate aspects of care: level of respect the provider showed you"
	capture label var m1_605d "Rate aspects of care: clarity of the provider's explanations"
	capture label var m1_605e "Rate aspects of care: degree to which the provider involved you as much as you wanted to be in decisions about your care"
	capture label var m1_605f "Rate aspects of care: amount of time the provider spent with you"
	capture label var m1_605g "Rate aspects of care: amount of time you waited before being seen"
	capture label var m1_605h "Rate aspects of care: courtesy and helpfulness of the healthcare facility staff, other than your provider"
	capture label var m1_700 "Measure your blood pressure"
	capture label var m1_701 "Measure your weight"
	capture label var m1_702 "Measure your height"
	capture label var m1_703 "Measure your upper arm"
	capture label var m1_704 "Listened to baby's heart rate"
	capture label var m1_705 "Take a urine sample (that is, you peed in a container)"
	capture label var m1_706 "Take a blood drop using a finger prick"
	capture label var m1_707 "Take a blood draw"
	capture label var m1_708a "Do an HIV test?"
	capture label var m1_708b "Result of HIV test"
	capture label var m1_708c "Did the provider give you medicine for HIV?"
	capture label var m1_708d "Did the provider explain how to take the medicine for HIV?"
	capture label var m1_708e "Did the provider do an HIV viral load test?"
	capture label var m1_708f "Did the provider do a CD4 test?"
	capture label var m1_709a "Did the provider do an HIV viral load test?"
	capture label var m1_709b "Did the provider do a CD4 test?"
	capture label var m1_710a "Did they do a syphilis test?"
	capture label var m1_710b "Result of syphilis test"
	capture label var m1_710c "Provider gave medication for syphilis directly, gave perscription, or told where to get it."
	capture label var m1_711a "Did they do a blood sugar test for diabetes?"
	capture label var m1_711b "Result of blood sugar test"
	capture label var m1_712 "Performed an ultrasound"
	capture label var m1_714a "Received TT shot at visit"
	capture label var m1_714b "Received TT shot before today's visit"
	capture label var m1_714c "Number of TT shots beore today's visit"
	capture label var m1_714d "Years since that TT shot"
	capture label var m1_714e "Years since last TT shot"
	capture label var m1_715 "Provided an insecticide treated bed net to prevent malaria"
	capture label var m1_716a "Provided discussed: Nutrition/what is good to be eating during your pregnancy"
	capture label var m1_716b "Provided discussed: Exercise or physical activity during your pregnancy?"
	capture label var m1_716c "Provided discussed: Your level of anxiety or depression?"
	capture label var m1_716d "Provided discussed: Use of a mosquito net that has been treated with insecticide"
	capture label var m1_716e "Provided discussed: Pregnancy complication signs that require a health facility"
	capture label var m1_717 "Provider discussed if you were feeling down or depressed/had little interest"
	capture label var m1_718 "Provider discussed diabetes"
	capture label var m1_719 "Provider discussed hypertension or high blood pressure"
	capture label var m1_720 "Provider discussed cardiac or heart problems"
	capture label var m1_721 "Provider discussed your mental health disorder"
	capture label var m1_722 "Provider discussed your HIV"
	capture label var m1_723 "Provider discussed your medications"
	capture label var m1_724a "Provider told you to come back for another ANC visit at this facility"
	capture label var m1_724b "Provider told you to come back in how many weeks"
	capture label var m1_724c "Provider told you to see a specialist like obgyn"
	capture label var m1_724d "Provider told you to see a mental health provider "
	capture label var m1_724e "Provider told you to go to the hospital for ANC follow up"
	capture label var m1_724f "Provider told you to go somewhere else for urine test (lab or health facility)"
	capture label var m1_724g "Provider told you to go somewhere else for blood test (lab or health facility)"
	capture label var m1_724h "Provider told you to go somewhere else for HIV test (lab or health facility)"
	capture label var m1_724i "Provider told you to go somewhere else for ultrasound (lab or health facility)"
	capture label var m1_801 "Provider gave estimated due date"
	capture label var m1_802_ke "Know the estimated date of delivery"
	capture label var m1_802a "Estimated due date from provider"
	capture label var m1_802b_et "Know when last menstrual period was"
	capture label var m1_802c_et "Date of last normal menstrual period"
	capture label var m1_802d_et "Gestational age in weeks based on LNMP"
	capture label var m1_803a_in "Number of months pregnant"
	capture label var m1_803b_in "Number of weeks pregnant"
	capture label var m1_803 "How many weeks or months far along pregnancy"
	capture label var m1_804 "Program calculated gestational age"
	capture label var m1_805 "Number of babies pregnant with"
	capture label var m1_806 "Provider asked when last period was"
	capture label var m1_807 "Pregnancy intentional"
	capture label var m1_808 "Reasons did not receive prior ANC"
	capture label var m1_809 "Discussed birhtplan with provider"
	capture label var m1_810a "Where plan to give birth"
	capture label var m1_810b "Name of facility where plan to give birth"
	capture label var m1_811 "Plan to stay at maternity home/mother's lodge before delivery"
	capture label var m1_812a "Provider said might need C-section"
	capture label var m1_812b "Reason told why might need a C-section"
	capture label var m1_812b_0_et "Told the reason you might need  a C-section"
	capture label var m1_813a "Experienced common health issues during pregnancy"
	capture label var  "Experienced pregnancy health problems: nausea/heartburn/leg cramps/back pain"
	capture label var m1_813b "Provider gave advice for how to handle common health issues"
	capture label var m1_813a_2 "Experienced during pregnancy: Heartburn"
	capture label var m1_813c_et "Experienced during pregnancy: Leg cramps"
	capture label var m1_813d_et "Experienced during pregnancy: Back pain"
	capture label var m1_813e_et "Provider gave treatment or advice for addressing these problems"
	capture label var m1_8a_et "Experienced during pregnancy: Preeclampsia/eclampsia"
	capture label var m1_8b_et "Experienced during pregnancy: Hyperemisis gravidarum"
	capture label var m1_8c_et "Experienced during pregnancy: Anermia"
	capture label var m1_8d_et "Experienced during pregnancy: Amniotic fluid volume problems"
	capture label var m1_8e_et "Experienced during pregnancy: Asthma"
	capture label var m1_8f_et "Experienced during pregnancy: RH isoimmunization"
	capture label var m1_8g_et "Experienced during pregnancy: Any other pregnancy problems"
	capture label var m1_8gother_et "Experienced during pregnancy: Other problems specified"
	capture label var m1_2_8_et "Provider gave treatment or advice for addressing these problems (m1_813a_5-m1_813a_11)"
	capture label var m1_814a "Experienced: Severe or persistent headaches "
	capture label var m1_814b "Experienced: Vaginal bleeding of any amount"
	capture label var m1_814c "Experienced: A fever"
	capture label var m1_814d "Experienced: Severe abdominal pain, not just discomfort"
	capture label var m1_814e "Experienced: A lot of difficulty breathing even when you are resting"
	capture label var m1_814f "Experienced: Convulsions or seizures "
	capture label var m1_814g "Experienced: Repeated fainting or loss of consciousness"
	capture label var m1_814h "Experienced: Noticing that the baby has completely stopped moving "
	capture label var m1_815 "What did provider advise for sytmptoms"
	capture label var m1_815_0 "Provider advised for health problems: Nothing, we did not discuss this"
	capture label var m1_815_1 "Provider advised for health problems: told to come back to this health facility"
	capture label var m1_815_2 "Provider advised for health problems: told you to get a lab test or imaging"
	capture label var m1_815_3 "Provider advised for health problems: provided a treatment in the visit"
	capture label var m1_815_4 "Provider advised for health problems: prescribed a medication"
	capture label var m1_815_5 "Provider advised for health problems: told to come back to this health facility"
	capture label var m1_815_6 "Provider advised for health problems: told to go elsewhere for higher level care"
	capture label var m1_815_7 "Provider advised for health problems: told you to wait and see"
	capture label var m1_815_96 "Provider advised for health problems: Other (specify)"
	capture label var m1_815_98 "Provider advised for health problems: Don't know"
	capture label var m1_815_99 "Provider advised for health problems: No Response/Refused"
	capture label var m1_816 "Provider asked if had any common pregnancy symptoms"
	capture label var m1_901 "Frequency currently smoke cigarettes or use any other type of tobacco"
	capture label var m1_902 "Provider advised you to stop smoking or using tobacco products"
	capture label var m1_903 "Frequency chew khat"
	capture label var m1_904 "Provider advised you to stop chewing khat"
	capture label var m1_905 "Consumed alcoholic beverage in last 30 days"
	capture label var m1_906 "When drink, number of drinks consume on average"
	capture label var m1_907 "Provider advised you to stop drinking alcohol"
	capture label var m1_908_za "Age of partner/father of baby"
	capture label var m1_909_za "Ever given oral,anal or vaginal sex because expected any of these items"
	capture label var m1_910_za "Last 12m started/stayed in relationship so could receive any of these items"
	capture label var m1_1001 "Number of pregnancies (including current)"
	capture label var m1_1002 "Number of births have had"
	capture label var m1_1003 "Number of live births"
	capture label var m1_1004 "Ever lost pregnancy after 20 wks"
	capture label var m1_1005 "Ever had preterm baby (more than 3 wks prior to due date)"
	capture label var m1_1006 "Ever bled so much in pregnancy or delivery needed blood transfusion or operation"
	capture label var m1_1_10_et "Ever had baby born with congenital anomaly"
	capture label var m1_1007 "Ever had a C-section"
	capture label var m1_1008 "Ever had delivery lasting more than 12 hrs of pushing"
	capture label var m1_1009 "Number of children still alive"
	capture label var m1_1010 "Ever had baby die in first month of life"
	capture label var m1_1011a "Provider discussed: your previous pregnancies, or not"
	capture label var m1_1011b "Provider discussed: that you lost a baby after 5 months of pregnancy, or not"
	capture label var m1_1011c "Provider discussed: that you had a baby who was born dead before, or not"
	capture label var m1_1011d "Provider discussed:  that you had a baby born early before, or not"
	capture label var m1_1011e "Provider discussed: that you had a c-section before, or not"
	capture label var m1_1011f "Provider discussed: that you had a baby die within their first month of life"
	capture label var m1_1101 "During pregnancy been hit/slapped/kicked/ done anything to hurt you physically"
	capture label var m1_1102 "Who hurt you while you were pregnant"
	capture label var m1_1104 "Who has done these things to you while you were pregnant"
	capture label var m1_1104_1 "Current husband / partner"
	capture label var m1_1104_2 "Parent"
	capture label var m1_1104_3 "Sibling"
	capture label var m1_1104_4 "Child"
	capture label var m1_1104_5 "Late /last / ex-husband/partner"
	capture label var m1_1104_6 "Other relative"
	capture label var m1_1104_7 "Friend/acquaintance"
	capture label var m1_1104_8 "Teacher"
	capture label var m1_1104_9 "Employer"
	capture label var m1_1104_10 "Stranger"
	capture label var m1_1104_96 "Other"
	capture label var m1_1104_98 "Don't Know"
	capture label var m1_1104_99 "No Response/Refused to answer"
	capture label var m1_1104_other "Who has done these things: Other specified"
	capture label var m1_1105 "Health provider discuss where to see support for these things"
	capture label var m1_1201 "Main source of drinking water"
	capture label var m1_1201_other "Source of drinking water: Other Specified"
	capture label var m1_1202 "Kind of toilet in household"
	capture label var m1_1202_other "Kind of toilet in household: Other Specified"
	capture label var m1_1203 "Household has electicity"
	capture label var m1_1204 "Household has radio"
	capture label var m1_1205 "Household has a television"
	capture label var m1_1206 "Household has a telephone or mobile phone"
	capture label var m1_1207 "Household has a refrigerator"
	capture label var m1_1208 "Main fuel type for cooking in household"
	capture label var m1_1208_other "Main fuel type for cooking in household: Other specified"
	capture label var m1_1209 "Main material of floor in household"
	capture label var m1_1209_other "Main material of floor in household: Other specified"
	capture label var m1_1210 "Main material of walls in household"
	capture label var m1_1210_other "Main material of walls in household: Other specified"
	capture label var m1_1211 "Main material of roof"
	capture label var m1_1211_other "Main material of roof: Other specified"
	capture label var m1_1212 "Household member own a bike"
	capture label var m1_1213 "Household member own a motor cycle or motor scooter"
	capture label var m1_1214 "Household member own a car or truck"
	capture label var m1_1215 "Household member oave a bank account"
	capture label var m1_1216a "Do you know the number of meals household usually has per day"
	capture label var m1_1216b "Household meals ousually have per day"
	capture label var m1_1217 "Paid money out of pocket for this visit"
	capture label var m1_1218_ke "Amount spent at clinic"
	capture label var m1_1218a "Spent money on: Registration/consultation"
	capture label var m1_1218a_1 "Amount spent on: Registration/consultation"
	capture label var m1_1218b "Spent money on: Medicine/vaccines"
	capture label var m1_1218b_1 "Amount spent on: Medicine/vaccines"
	capture label var m1_1218c "Spent money on: Test/investigations"
	capture label var m1_1218c_1 "Amount spent on: Test/investigations"
	capture label var m1_1218d "Spent money on: Transport (round trip) including person accompanying you"
	capture label var m1_1218d_1 "Amount spent on: Transport (round trip) including person accompanying you"
	capture label var m1_1218e "Spent money on: Food /accommodation including person accompanying you"
	capture label var m1_1218e_1 "Amount spent on: Food /accommodation including person accompanying you"
	capture label var m1_1218f_other "Spent money on Other items: Other specified"
	capture label var m1_1218f "Spent money on: Other"
	capture label var m1_1218f_1 "Amount spent on: Other"
	capture label var m1_1219 "Confirm Total amount spent"
	capture label var m1_totalcost_in "Total amount spent on m1_1218_a-m1_1218_f"
	capture label var m1_1220 "Financial source used to pay for costs"
	capture label var m1_1220_1 "Financial Source: Current income of any household members"
	capture label var m1_1220_2 "Financial Source: Savings (e.g. bank account)"
	capture label var m1_1220_3 "Financial Source: Payment or reimbursement from a health insurance plan"
	capture label var m1_1220_4 "Financial Source: Sold items (e.g. furniture, animals, jewellery, furniture)"
	capture label var m1_1220_5 "Financial Source: Family members or friends from outside the household"
	capture label var m1_1220_6 "Financial Source: Borrowed (from someone other than a friend or family)"
	capture label var m1_1220_96 "Financial Source: Other"
	capture label var m1_1220_other "Financial Source: Other specified"
	capture label var m1_1221 "Covered with health insurance"
	capture label var m1_1222 "Type of health insurance"
	capture label var m1_1222_other "Type of Health insurance: Other Specified"
	capture label var m1_1223 "Rate satisfaction with health services"
	capture label var height_cm "Height in CM"
	capture label var weight_kg "Weight in KG"
	capture label var bp_time_1_systolic "BP systolic: Time 1"
	capture label var bp_time_1_diastolic "BP diastolic: Time 1"
	capture label var time_1_pulse_rate "Pulse Rate: Time 1"
	capture label var bp_time_2_systolic "BP systolic: Time 2"
	capture label var bp_time_2_diastolic "BP diastolic: Time 2"
	capture label var time_2_pulse_rate "Pulse Rate: Time 2"
	capture label var bp_time_3_systolic "BP systolic: Time 3"
	capture label var bp_time_3_diastolic "BP diastolic: Time 3"
	capture label var time_3_pulse_rate "Pulse Rate: Time 3"
	capture label var muac_et "Measured Upper arm circumference"
	capture label var m1_1306 "Hemoglobin level available in maternal health card"
	capture label var m1_1307 "HEMOGLOBIN LEVEL FROM MATERNAL HEALTH CARD"
	capture label var m1_1308 "Take anemia test"
	capture label var m1_1309 "HEMOGLOBIN LEVEL FROM TEST PERFORMED BY DATA COLLECTOR"
	capture label var m1_1401 "Period of day most convenient for phone survey"
	capture label var m1_1401a_ke "Phone number should call"
	capture label var m1_1401b_ke "Is this the preferred phone number"
	capture label var m1_1401_1 "Best time for survey: Morning"
	capture label var m1_1401_2 "Best time for survey: Midday"
	capture label var m1_1401_3 "Best time for survey: Afternoon"
	capture label var m1_1401_4 "Best time for survey: Evening"
	capture label var m1_1402_1_et "Best phone number: The phone provided for the study"
	capture label var m1_1402_2_et "Best phone number: Primary personal phone"
	capture label var m1_1402_3_et "Best phone number: Secondary personal phone"
	capture label var m1_1402_4_et "Best phone number: Spouse or partner phone"
	capture label var m1_1402_5_et "Best phone number: Community health worker phone"
	capture label var m1_1402_6_et "Best phone number: Friend or other family member phone 1 "
	capture label var m1_1402_7_et "Best phone number: Friend or other family member phone 2"
	capture label var m1_1402_8_et "Best phone number: Other phone"
	capture label var m1_1402_9_et "Best phone number: Does not have any phone numbers"
	capture label var m1_1402_888_et "Unknown"
	capture label var m1_1402_998_et "Refuse to answer"
	capture label var m1_1402_999_et "No information"
	capture label var m1_1402_0_ke "Day of week do not want to be called: None"
	capture label var m1_1402_1_ke "Day of week do not want to be called: Monday"
	capture label var m1_1402_2_ke "Day of week do not want to be called: Tuesday"
	capture label var m1_1402_3_ke "Day of week do not want to be called: Wednesday"
	capture label var m1_1402_4_ke "Day of week do not want to be called: Thursday"
	capture label var m1_1402_5_ke "Day of week do not want to be called: Friday"
	capture label var m1_1402_6_ke "Day of week do not want to be called: Saturday"
	capture label var m1_1402_7_ke "Day of week do not want to be called: Sunday"
	capture label var m1_end_time "Interview end time"
	capture label var interview_length "Total Duration of interview"
	capture label var m1_complete "Completed M1"

	if "${Country}" == "KE" {
		char m1_903[Full_Question_Text] How often do you chew Miraa? Is it every day, some days, or not at all?
		label var m1_903 "Frequency chew Miraa"
			
		char m1_904[Full_Question_Text] During the visit today, did the health provider advise you to stop chewing Miraa?
		label var m1_904 "During the visit today, did the health provider advise you to stop chewing Miraa?"
		
		char m1_803[Full_Question_Text] How many weeks pregnant do you think you are?
		label var m1_803 "How many weeks pregnant do you think you are?"
		
		char m1_812b[Full_Question_Text] What is the name of the [facility type from 810a] where you plan to give birth?
		label var m1_812b "Name of the [facility type from 810a] where you plan to give birth?"

		char m1_813a[Full_Question_Text] Did you experience nausea in your pregnancy so far, or not?
		label var m1_813a "Experienced nausea in your pregnancy so far, or not?"

		char m1_813b[Full_Question_Text] Did you experience heartburn in your pregnancy so far, or not?
		label var m1_813b "Experience heartburn in your pregnancy so far, or not?"
		
	}

	



end