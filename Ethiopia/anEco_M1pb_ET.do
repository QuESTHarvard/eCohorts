* Ethiopia ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Updated: July 27 2023


use "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et.dta", clear


drop in 1/72 // drop the test records
keep if  b7eligible ==1 // drop the non eligible.. this is also droping the other modules currently.
drop redcap_repeat_instrument-redcap_data_access_group m2_attempt_date-m2_complete // drops M2 variables


* Baseline highrisk features
	gen aged18 = age<19
	gen aged40 = age>40
	recode m1_203 (2=0)
	egen chronic = rowmax(m1_202a-m1_203)
	egen dangersigns = rowmax(m1_814a m1_814b m1_814c m1_814d m1_814e m1_814f m1_814g)
	* BMI from health assessments
	gen height_m = height_cm/100
	gen BMI = weight_kg / (height_m^2)
	gen low_BMI= 1 if BMI<18.5 
	replace low_BMI = 0 if BMI>=18.5 & BMI<.
	* Anemia from card or from hemocue test at baseline
	* Reference value from: https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8990104/
	gen Hb= m1_1309
	gen Hb_card= m1_1307 
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
	gen anemic= 1 if Hb<11
	replace anemic=0 if Hb>=11 & Hb<. 
	drop Hb*
 
	egen highrisk_baseline = rowmax(aged18 aged40 chronic dangersigns low_BMI anemic)

	lab var aged18 "Aged less than 19"
	lab var aged40 "Aged more than 40"
	lab var chronic "Has a chronic health problem"
	lab var dangersigns "Experienced a danger sign so far in pregnancy"
	lab var height_m "Height in meters"
	lab var BMI "Body mass index"
	lab var low_BMI "BMI below 18.5 (low)"
	lab var anemic "Anemic (Hb <13.2)"
	lab var highrisk_baseline "Has any high risk baseline feature"
