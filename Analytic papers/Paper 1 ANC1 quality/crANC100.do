
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*-------------------------------------------------------------------------------
* RECODES MODULE 0 - HEALTH FACILITY VARIABLES 
*-------------------------------------------------------------------------------
* ETHIOPIA	
u "$user/$data/Ethiopia/02 recoded data/eco_m0_et.dta", clear
* SERVICE READINESS INDICES 

/* Service readiness: basic amenities
	Average of 6 items: electricity, water, toilet, communication, computer & internet, ambulance */
	gen elect= m0_206
	replace elect= 0 if m0_207==1
	gen water =  m0_211
	recode water 2=1
	gen toilet = m0_214
	gen communication= m0_217==1 // functionning cell phone
	replace communi = 1 if  m0_216==1 // functionning landline
	gen comput_inter =  m0_219==1 
	replace comput_inter= 0 if m0_220==0
	gen ambulance = m0_221 // ambulance on site
	egen sri_basicamenities =rowmean(elect water toilet communication comput_inter ambulance)
	
* Service readiness: Basic equipment
	gen bp_st= m0_401a==1
	gen scale_st= m0_402a==1
	gen iscale_st= m0_403a==1
	gen thermo_st= m0_405a==1
	gen stetho_st = m0_406a==1
	gen ultra_st = m0_433!=.
	egen sri_equip=rowmean(bp_st scale_st iscale_st thermo_st  stetho_st ultra_st )

* Service readiness: diagnostic capacity 
	* At least 1 rapid test available and valid today
	gen malaria = m0_416 ==1 // at least one valid
	gen syphi =  m0_417==1
	egen hiv = anymatch(m0_418 m0_419 m0_420), val(1)
	gen preg = m0_421==1
	gen uripro = m0_422 ==1
	gen uriglu= m0_423 ==1
	gen uriket = m0_424 ==1
	* Testing performed on site
	gen blood_glu= m0_426==1 // conducts onsite blood glucose testing
	gen hemo= m0_427==1  //onsite Haemoglobin testing
	gen genmicro= m0_428==1 // onsite general microscopy
	gen elisa = m0_430==1 // HIV antibody testing by ELISA
	egen sri_diag= rowmean(malaria syphi hiv preg uripro uriglu uriket blood_glu hemo genmicro elisa )

	egen sri_score =rowmean(sri_basicamenities sri_equip sri_diag)
	egen sri_cat = cut(sri_score), group(3)

/* Total staff providing ANC: 
	GP, OBGYN Emergency surgical officers, health officer, diploma nurses, degree nurses, diploma midwife, degree midwives */
	egen total_staff_onc=rowtotal(m0_1a_et m0_1b_et m0_1c_et m0_1d_et m0_1e_et m0_1f_et m0_1g_et m0_102d )
	egen staff_cat = cut(total_staff_onc), group(3)
	* At least one full time doctor
	gen ftdoc= m0_101a - m0_101b
	recode ftdoc (-5/-1=1) (1/20=1)
* BEDS
	gen beds = m0_201
	egen bedcat=cut(beds), group(3)
	
* Volumes 
	*adding first + repeat visits 
		gen anc_tot_jan = m0_802_jan + m0_801_jan
		gen anc_tot_feb =  m0_802_feb +  m0_801_feb 
		gen anc_tot_mar =  m0_802_mar + m0_801_mar 
		gen anc_tot_apr= m0_802_apr + m0_801_apr  
		gen anc_tot_may = m0_802_may + m0_801_may
		gen anc_tot_jun = m0_802_jun + m0_801_jun
		gen anc_tot_jul =  m0_802_jul +m0_801_jul
		gen anc_tot_aug = m0_802_aug + m0_801_aug  
		gen anc_tot_sep = m0_802_sep +  m0_801_sep
		gen anc_tot_oct = m0_802_oct +   m0_801_oct
		gen anc_tot_nov = m0_802_nov +  m0_801_nov
		gen anc_tot_dec = m0_802_dec + m0_801_dec 
		
		egen anc_annual= rowtotal (anc_tot*)
		gen anc_mont = anc_annual/12
		egen vol_cat = cut(anc_mont), group(3)
* Volume per staff
		gen anc_vol_staff_onc = anc_mont / total_staff_onc
		egen anc_vol_staff_cat = cut(anc_vol_staff_onc), group(3)
		

	lab var elect "Electricity from any power source with break less than 2hours/per day)"
	lab var water "Improved water source"
	lab var toilet "Improved toilet"
	lab var communication "functioning hone or landline"
	lab var staff_cat "ONC staffing categories"
	lab var comput_inter "Computer with internet"
	lab var ambulance "Functionning ambulance on site"
	lab var ftdoc "At least one full time doctor"
	lab var anc_annual "Total number of ANC visits over the last 12 months"
	lab var anc_mont "Average number of ANC visits per month"
	lab var anc_vol_staff_onc "Average monthly number of ANC visits per staff providing obstetric care"
	
	keep facility sri_score sri_basicamenities sri_equip sri_diag sri_cat total_staff staff_cat ///
	     vol_cat anc_mont anc_vol_staff* bedcat ftdoc beds m0_a8_fac_own m0_a6_fac_type
	
	gen private = m0_a8_fac_own
	recode private (1=0) (2/4=1)
	
	gen facsecond = m0_a6_fac_type
	recode facsecond 1/2=1 3/4=0
	
save  "$user/$analysis/ETtmpfac.dta", replace  
		    
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
	replace communi = 1 if  m0_216==2 // functionning landline
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
	* Rapid test available and valid today
	gen malaria = m0_416 ==1 // at least one valid
	gen syphi =  m0_417==1
	gen hiv = m0_420b_ke==1
	gen preg = m0_421==1
	gen uripro = m0_422 ==1
	gen uriglu= m0_423 ==1
	gen uriket = m0_424 ==1
	gen blood_glu= m0_426==1 // conducts onsite blood glucose testing
	gen hemo= m0_427==1  //onsite Haemoglobin testing
	gen genmicro= m0_428==1 // onsite general microscopy
	gen elisa = m0_430==1 // HIV antibody testing by ELISA
	egen sri_diag= rowmean(malaria syphi hiv preg uripro uriglu uriket blood_glu hemo genmicro elisa )

	egen sri_score =rowmean(sri_basicamenities sri_equip sri_diag)
	egen sri_cat=cut(sri_score), group(3)
	
* STAFFING

	/* Total staff providing obstetric and newborn care: 
	Medical doc, OBGYN,  Midwife BSc, Nurse certificate Nurse BSc, Nurse diploma, 
	Health officer */
	egen total_staff_onc=rowtotal(m0_101d m0_102d  m0_108d m0_109d m0_110d m0_111d m0_112d )
	xtile staff_cat = total_staff_onc, nquant(3)
	
	* At least one full time doctor
	gen tmp1= m0_101a - m0_101b
	gen tmp2 = m0_famphy_a_ke - m0_famphy_b_ke
	egen ftdoc=rowtotal(tmp* )
	recode ftdoc (-1=0) (1/21=1)

* BEDS
	gen beds = m0_201
	egen bedcat=cut(beds), group(3)

* VOLUMES 
		*adding first + repeat visits in Kenya
		gen anc_tot_jan = m0_802_jan + m0_ancrepeat_jan_ke
		gen anc_tot_feb =  m0_802_feb + m0_ancrepeat_feb_ke 
		gen anc_tot_mar =  m0_802_mar +  m0_ancrepeat_mar_ke
		gen anc_tot_apr= m0_802_apr + m0_ancrepeat_apr_ke
		gen anc_tot_may = m0_802_may + m0_ancrepeat_may_ke
		gen anc_tot_jun = m0_802_jun +m0_ancrepeat_jun_ke
		gen anc_tot_jul =  m0_802_jul +m0_ancrepeat_jul_ke
		gen anc_tot_aug = m0_802_aug + m0_ancrepeat_aug_ke
		gen anc_tot_sep = m0_802_sep +  m0_ancrepeat_sep_ke
		gen anc_tot_oct = m0_802_oct +  m0_ancrepeat_oct_ke
		gen anc_tot_nov = m0_802_nov +  m0_ancrepeat_nov_ke
		gen anc_tot_dec = m0_802_dec + m0_ancrepeat_dec_ke
	
	    egen anc_annual= rowtotal (anc_tot*)
		gen anc_mont = anc_annual/12
		egen vol_cat = cut(anc_mont), group(3)
		* Volume per staff
		gen anc_vol_staff_onc = anc_mont / total_staff_onc
		egen anc_vol_staff_cat = cut(anc_vol_staff_onc), group(3)
		
	lab var elect "Electricity from any power source with break less than 2hours/per day)"
	lab var water "Improved water source"
	lab var toilet "Improved toilet"
	lab var communication "functioning hone or landline"
	lab var comput_inter "Computer with internet"
	lab var ambulance "Functionning ambulance on site"
	lab var ftdoc "At least one full time doctor"
	lab var total_staff_onc "Total number of staff providing obstetric care"
	lab var anc_annual "Total number of ANC visits over the last 12 months"
	lab var anc_mont "Average number of ANC visits per month"
	lab var anc_vol_staff_onc "Average monthly number of ANC visits per staff providing obstetric care"
	
	keep facility sri_score sri_basicamenities sri_equip sri_diag sri_cat total_staff ///
		   vol_cat anc_mont anc_vol_staff* ftdoc beds bedcat m0_facility_own m0_facility_type staff_cat
	
	gen private = m0_facility_own==2
	gen facsecond= m0_facility_type==2
	
save  "$user/$analysis/KEtmpfac.dta", replace  

*-------------------------------------------------------------------------------
* SOUTH AFRICA
u "$user/$data/South Africa/02 recoded data/eco_m0_za", clear

* SERVICE READINESS INDICES

/* Service readiness: basic amenities
Average of 6 items: electricity, water, toilet, communication, computer & internet, ambulance */

	gen elect= m0_206
	replace elect= 0 if m0_207==1
	recode elect 98=.
	gen water =  m0_211
	recode water 1/4=1 12=0
	gen toilet = m0_215
	recode toilet 2=1
	gen communication= m0_217==1 // functionning cell phone
	replace communi = 1 if  m0_216==1 // functionning landline
	gen comput_inter =  m0_219==1 
	replace comput_inter= 0 if m0_220==0
	gen ambulance = m0_221==1 
	egen sri_basicamenities =rowmean(elect water toilet communication comput_inter ambulance)

* Service readiness: Basic equipment
	gen bp_st= m0_401a==1 // functioning
	gen scale_st= m0_402a==1
	gen iscale_st= m0_403a==1
	gen thermo_st= m0_405a==1
	gen stetho_st = m0_406a==1
	gen ultra_st = m0_433==1
	egen sri_equip=rowmean(bp_st scale_st iscale_st thermo_st  stetho_st ultra_st )
	
* Service readiness: diagnostic capacity 
	* Rapid test available and valid today
	gen malaria = m0_416 ==1 // at least one valid
	gen syphi =  m0_417==1
	egen hiv = anymatch(m0_418 m0_419 m0_420), val(1)
	gen preg = m0_421==1
	gen uripro = m0_422 ==1
	gen uriglu= m0_423 ==1
	gen uriket = m0_424 ==1
	gen blood_glu= m0_426==1 // conducts onsite blood glucose testing
	gen hemo= m0_427==1  //onsite Haemoglobin testing
	gen genmicro= m0_428==1 // onsite general microscopy
	gen elisa = m0_430==1 // HIV antibody testing by ELISA
	egen sri_diag= rowmean(malaria syphi hiv preg uripro uriglu uriket blood_glu hemo genmicro elisa )

	egen sri_score =rowmean(sri_basicamenities sri_equip sri_diag)
	egen sri_cat = cut(sri_score), group(3)
	
* STAFFING

	/* Total staff providing obstetric and newborn care: 
	Medical doc, OBGYN,  Midwife BSc, Midwife diploma,  Nurse BSc, Nurse diploma, 
	Health officer,  */
	egen total_staff_onc=rowtotal(m0_101d m0_102d m0_108d m0_109d m0_110d m0_111d m0_112d )
	egen staff_cat = cut(total_staff_onc), group(3)
	* At least one full time doctor
	gen ftdoc= m0_101a - m0_101b
	recode ftdoc (-1=0) (1/5=1)

* BEDS
	gen beds = m0_201
	recode beds 98=0
	egen bedcat=cut(beds), group(3)

* VOLUMES 
	egen anc_annual= rowtotal (m0_801_*)
	gen anc_mont = anc_annual/12
	egen vol_cat = cut(anc_mont), group(3)
	
	* Volume per staff
	gen anc_vol_staff_onc = anc_mont / total_staff_onc
	egen anc_vol_staff_cat = cut(anc_vol_staff_onc), group(3)
		
		
	lab var elect "Electricity from any power source with break less than 2hours/per day)"
	lab var water "Improved water source"
	lab var toilet "Improved toilet"
	lab var communication "functioning hone or landline"
	lab var comput_inter "Computer with internet"
	lab var ambulance "Functionning ambulance on site"
	lab var ftdoc "At least one full time doctor"
	lab var anc_annual "Total number of ANC visits over the last 12 months"
	lab var anc_mont "Average number of ANC visits per month"
	lab var anc_vol_staff_onc "Average monthly number of ANC visits per staff providing obstetric care"
	
	keep facility sri_score sri_basicamenities sri_equip sri_diag sri_cat total_staff staff_cat ///
		    vol_cat anc_mont anc_vol_staff* ftdoc beds bedcat m0_facility_own m0_facility_type	

save  "$user/$analysis/ZAtmpfac.dta", replace  

*-------------------------------------------------------------------------------
* INDIA
u "$user/$data/India/02 recoded data/eco_m0_in.dta", clear

	rename m0_facility facility 
	
* SERVICE READINESS INDICES 

/* Service readiness: basic amenities
Average of 6 items: electricity, water, toilet, communication, computer & internet, ambulance */
	gen elect= m0_206
	replace elect= 0 if m0_207==1
	gen water =  m0_211
	recode water 1/4=1 10=0
	gen toilet = m0_215
	recode toilet 3=1 6=0
	gen communication= m0_217==1 // functionning cell phone
	replace communi = 1 if  m0_216==1 // functionning landline
	gen comput_inter =  m0_219==1 
	replace comput_inter= 0 if m0_220==0
	gen ambulance = m0_221==1 
	egen sri_basicamenities =rowmean(elect water toilet communication comput_inter ambulance)


* Service readiness: Basic equipment
	gen bp_st= m0_401a==1 // functioning
	gen scale_st= m0_402a==1
	gen iscale_st= m0_403a==1
	gen thermo_st= m0_405a==1
	gen stetho_st = m0_406a==1
	gen ultra_st = m0_433==1
	egen sri_equip=rowmean(bp_st scale_st iscale_st thermo_st  stetho_st ultra_st )


* Service readiness: diagnostic capacity 
	* Rapid test available and valid today
	gen malaria = m0_416 ==1 // at least one valid
	gen syphi =  m0_417==1
	gen hiv = m0_418 ==1
	gen preg = m0_421==1
	gen uripro = m0_422 ==1
	gen uriglu= m0_423 ==1
	gen uriket = m0_424 ==1
	gen blood_glu= m0_426==1 // conducts onsite blood glucose testing
	gen hemo= m0_427==1  // onsite Haemoglobin testing
	gen genmicro= m0_428==1 // onsite general microscopy
	gen elisa = m0_430==1 // HIV antibody testing by ELISA
	egen sri_diag= rowmean(malaria syphi hiv preg uripro uriglu uriket blood_glu hemo genmicro elisa )

	egen sri_score =rowmean(sri_basicamenities sri_equip sri_diag)
	egen sri_cat = cut(sri_score), group(3)
	
* STAFFING
	/* Total staff providing obstetric and newborn care: Medical doc, OBGYN, Neonatologist,
	ANM, GNM, Staff Nurse, Community health officer, Asha, Anganwadi worker, 
	MPW, ANM, Staff nurse Anganwadi */
	egen total_staff_onc=rowtotal(m0_101d m0_102d m0_106d m0_108d m0_109d m0_110d ///
		m0_112d m0_114d m0_ang_d_in m0_mpw_d_in m0_anm_d_in m0_nur_d_in )
		
	egen staff_cat = cut(total_staff_onc), group(3)

* VOLUMES 
	egen anc_annual= rowtotal (m0_801_*)
	egen tmp= rowtotal(m0_802_*) // replacing with volume of 1st ANC visits
	replace anc_annual=tmp if facility==18 // facilities 18 and 25 have no ANC volumes.
	drop tmp
	recode anc_annual 0=.
	gen anc_mont = anc_annual/12
	egen vol_cat = cut(anc_mont), group(3)
	
	* Volume per staff
	gen anc_vol_staff_onc = anc_mont / total_staff_onc
	egen anc_vol_staff_cat = cut(anc_vol_staff_onc), group(3)

* BEDS
	gen beds = m0_201
	egen bedcat=cut(beds), group(3)
	
	keep facility sri_score sri_basicamenities sri_equip sri_diag sri_cat total_staff staff_cat ///
		    vol_cat anc_mont beds bedcat anc_vol_staff* 
	
save  "$user/$analysis/INtmpfac.dta", replace  



