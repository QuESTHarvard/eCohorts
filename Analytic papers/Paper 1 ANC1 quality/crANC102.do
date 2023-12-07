
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

* HEALTH FACILITY DATA (MODULE 0)
*------------------------------------------------------------------------------*
* ETHIOPIA


*------------------------------------------------------------------------------*
* KENYA
u "$user/$data/Kenya/02 recoded data/eco_m0_ke", clear

* SERVICE READINESS INDICES

/* Service readiness: basic amenities
Average of 6 items: electricity, water, toilet, communication, computer & internet, ambulance */

	gen elect= m0_206
	replace elect= 0 if m0_207==1
	gen water =  m0_211
	recode water 1/9=1 96=0
	gen toilet = m0_214
	gen communication= m0_217==2 // functionning cell phone
	replace communi = 1 if  m0_216==2 
	gen comput_inter =  m0_219==2 
	replace comput_inter= 0 if m0_220==0
	gen ambulance = m0_220a_ke==2 
	egen sri_basicamenities =rowmean(elect water toilet communication comput_inter ambulance)

* Service readiness: Basic equipment
	gen bp_st= m0_401a==1
	gen scale_st= m0_402a==1
	gen iscale_st= m0_403a==1
	gen thermo_st= m0_405a==1
	gen stetho_st = m0_406a==1
	gen ultra_st = m0_433==1
	egen sri_equip=rowmean(bp_st scale_st iscale_st thermo_st  stetho_st ultra_st )
	
* Service readiness: diagnostic capacity 
	gen malaria = m0_416 ==1 // at least one valid
	gen syphi =  m0_417==1
	gen hiv = m0_420b_ke==1
	gen preg = m0_421==1
	gen uripro = m0_422 ==1
	gen uriglu= m0_423 ==1
	gen uriket = m0_424 ==1
	gen blood_glu= m0_426==1 // onsite blood glucose testing
	gen hemo= m0_427==1  //onsite Haemoglobin testing
	gen genmicro= m0_428==1 // onsite general microscopy
	gen elisa = m0_430==1 // HIV antibody testing by ELISA
	egen sri_diag= rowmean(malaria syphi hiv preg uripro uriglu uriket blood_glu hemo genmicro elisa )

	egen sri_score =rowmean(sri_basicamenities sri_equip sri_diag)
	
* STAFFING

	egen total_staff=rowtotal(m0_101a m0_102a m0_103a m0_104a m0_105a m0_106a m0_108a m0_109a m0_110a m0_111a m0_112a m0_113a)
	gen doc_ft= m0_101a-m0_101b 
	recode doc_ft (-1=0) (1/19=1)

* BEDS
	gen beds = m0_201


	lab var elect "Electricity from any power source with break less than 2hours/per day)"
	lab var water "Improved water source"
	lab var toilet "Improved toilet"
	lab var communication "functioning hone or landline"
	lab var comput_inter "Computer with internet"
	lab var ambulance "Functionning ambulance on site"

	keep facility sri_score sri_basicamenities sri_equip sri_diag total_staff doc_ft beds 

* Merge with M1 data
	merge 1:m facility using "$user/$analysis/KEtmp.dta"
	keep if _merge==3 
	drop _merge 
	save  "$user/$analysis/KEtmp.dta", replace
