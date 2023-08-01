* MNH: ECohorts derived variable creation (Ethiopia)
* Date of last update: August 2023
* S Sabwa, K Wright, C Arsenault

/*

	This file creates derived variables for analysis from the MNH ECohorts Ethiopia dataset. 

*/

***************************** Deriving variables *******************************

*u "$et_data_final/eco_m1m2_et.dta", clear

u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et.dta", clear
*------------------------------------------------------------------------------*
* MODULE 1
*------------------------------------------------------------------------------*
	* SECTION A: META DATA
			gen facility_own = facility
			recode facility_own (2/11 14 16/19 =1) ///
							    (1 13 15 20 21 22 96 =2)
			
			lab def facility_own 1 "Public" 2 "Private"
			lab val facility_own facility_own 
			
			gen facility_lvl = facility 
			recode facility_lvl (2/6 8/12 14 16 17 19  =1) (7 18 =2) ///
								(1 13 15 20 21 22 96 =3) 
			
			lab def facility_lvl 1"Primary" 2 "Secondary" 3 "Private"
			lab val facility_lvl facility_lvl
*------------------------------------------------------------------------------*	
	* SECTION 7: VISIT TODAY: CONTENT OF CARE
			* Technical quality of first ANC visit
			gen bp = m1_700 
			gen weight = m1_701 
			gen height = m1_702
			gen upper_arm = m1_703
			gen fetal_hr = m1_704
			recode fetal_hr  (2=.) // only applies to those in 2nd or 3rd trimester
			gen urine = m1_705
			egen blood = rowmax(m1_706 m1_707) // finger prick or blood draw
			gen hiv_test =  m1_708a
			gen syphilis_test = m1_710a
			gen blood_sugar_test = m1_711a
			gen ultrasound = m1_712
			gen ifa =  m1_713a
			recode ifa (2=1) (3=0)
			gen tt = m1_714a

			egen anc1tq = rowmean(bp weight height upper_arm fetal_hr urine ///
								  blood ultrasound ifa tt ) // 10 items
	
*------------------------------------------------------------------------------*	
	* SECTION 13: HEALTH ASSESSMENTS AT BASELINE

			* High blood pressure (HBP)
			egen systolic_bp= rowmean(bp_time_1_systolic bp_time_2_systolic bp_time_3_systolic)
			egen diastolic_bp= rowmean(bp_time_1_diastolic bp_time_2_diastolic bp_time_3_diastolic)
			gen systolic_high = 1 if systolic_bp >=140 & systolic_bp <.
			replace systolic_high = 0 if systolic_bp<140
			gen diastolic_high = 1 if diastolic_bp>=90 & diastolic_bp<.
			replace diastolic_high=0 if diastolic_high <90
			egen HBP= rowmax (systolic_high diastolic_high)
			drop systolic* diastolic*
			
			* Anemia 
			gen Hb= m1_1309 // test done by E-Cohort data collector
			gen Hb_card= m1_1307 // hemoglobin value taken from the card
				replace Hb_card = "12.6" if Hb_card=="12.6g/d" | Hb_card=="12.6g/dl"
				replace Hb_card = "13" if Hb_card=="13g/dl" 
				replace Hb_card= "14.6" if Hb_card=="14.6g/dl"
				replace Hb_card = "15" if Hb_card=="15g/dl"
				replace Hb_card= "16.3" if Hb_card=="16.3g/dl"
				replace Hb_card= "16.6" if Hb_card=="16.6g/dl"
				replace Hb_card= "16" if Hb_card=="16g/dl"
				replace Hb_card= "17.6" if Hb_card=="17.6g/dl"
				replace Hb_card="11.3" if Hb_card=="113"
			destring Hb_card, replace
			replace Hb = Hb_card if Hb==.a // use the card value if the test wasn't done
				// Reference value of 10 from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8990104/
			gen anemic= 1 if Hb<10
			replace anemic=0 if Hb>=10 & Hb<. 
			drop Hb*
			
			* BMI 
			gen height_m = height_cm/100
			gen BMI = weight_kg / (height_m^2)
			gen low_BMI= 1 if BMI<18.5 
			replace low_BMI = 0 if BMI>=18.5 & BMI<.

*------------------------------------------------------------------------------*	
* Labelling new variables 
	lab var facility_own "Facility ownership"
	lab var bp "Blood pressure taken at ANC1"
	lab var weight "Weight taken at ANC1"
	lab var height "Height measured at ANC1"
	lab var upper_arm "Upper arm measured at ANC1"
	lab var urine "Urine test done at ANC1"
	lab var blood "Blood test done at ANC1 (finger prick or blood draw)"
	lab var hiv_test "HIV test done at ANC1"
	lab var syphilis_test "Syphilis test done at ANC1"
	lab var ultrasound "Ultrasound done at ANC1"
	lab var ifa "Received iron and folic acid pills directly or a prescription at ANC1"
	lab var anc1tq "Technical quality score 1st ANC"
	lab var HBP "High blood pressure at 1st ANC"
	lab var anemic "Anemic (Hb <10.0)"
	lab var height_m "Height in meters"
	lab var BMI "Body mass index"
	lab var low_BMI "BMI below 18.5 (low)"
	
	
save "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et_der.dta", replace
