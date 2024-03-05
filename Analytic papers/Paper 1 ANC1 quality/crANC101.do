
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------- 
* RECODES MODULE 1 VARIABLES

*-------------------------------------------------------------------------------
* ETHIOPIA

u "$user/$data/Ethiopia/02 recoded data/eco_m1_et_der.dta", clear	
	keep if redcap_event_name=="module_1_arm_1"
	egen tag=tag(facility)
	
* ANC quality
	gen ultrasound = anc1ultrasound if trimester>2 & trimester<. // 3rd trimester only
	gen edd = anc1edd if trimester>1 & trimester<. // 2nd,3rd trimester only
	gen calcium = anc1calcium if trimester>1 & trimester<. // 2nd,3rd trimester only
	gen deworm = anc1deworm if trimester>1 & trimester<. // 2nd,3rd trimester only
	gen tt= anc1tt
	replace tt =. if  m1_714c>=5 &  m1_714c<98 // had 5 or more previous lifetime doses
	replace tt =. if  m1_714c>=4 &  m1_714c<98 & m1_714e <=10 // had 4 or more incl. 1 in last 10 years
	replace tt =. if  m1_714c>=3 &  m1_714c<98 & m1_714e <=5 // had 3 or more incl. 1 in last 5 years
	replace tt =. if  m1_714c>=2 &  m1_714c<98 & m1_714e <=3 // had 2 or more incl. 1 in last 3 years
	g previous_preg=m1_1011a 
			
	egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression anc1danger_screen previous_preg ///
		m1_counsel_nutri m1_counsel_exer m1_counsel_complic m1_counsel_birthplan edd ///
		m1_counsel_comeback anc1ifa calcium deworm tt anc1itn)
	
	replace anc1qual = anc1qual*100
	
		egen phys_exam=rowmean(anc1bp anc1weight anc1height anc1muac)
		egen diag=rowmean(anc1blood anc1urine ultrasound)
		egen hist= rowmean(anc1lmp anc1depression anc1danger_screen previous_preg)
		egen counsel=rowmean(m1_counsel_nutri m1_counsel_exer m1_counsel_complic m1_counsel_birthplan edd ///
		m1_counsel_comeback)
		egen tx=rowmean(anc1ifa calcium deworm tt anc1itn)
	
	xtile group_anc1qual=anc1qual, nquantiles(4)
	gen q4_anc1=group_anc1qual==4
	
	gen q60=anc1qual>60

* Demographics & health
	gen second=educ_cat>=3
	gen healthlit_corr=m1_health_lit==4
	
	gen age_cat=enrollage
	recode age_cat 15/19=1 20/35=2 36/60=3
	lab def age_cat 1"15-19yrs" 2"20-35 yrs" 3 "36+yrs"
	lab val age_cat age_cat
	gen young= age_cat==1
	gen older=age_cat==3
	recode  m1_201 (1/3=0) (4/5=1), gen(poorhealth)
	
	recode m1_phq9 4/5=3, gen(depression_cat)
	lab def depression_cat 1"none-minimal 0-4" 2"Mild 5-9" 3"Moderate to severe 10+"
	lab val depression_cat depression_cat
	recode depression_cat 1=0 2/3=1, g(depress)
	
* Medical risk factors
	* Anemia
	recode m1_Hb 0/6.999=1 7/10.999=2 11/30=3, gen(lvl_anemia)
	lab def lvl_anemia 1"Severe anemia (<7gm/dl)" 2"Moderate, mild anemia (7-10.9gm/dl)" 3"Normal"
	lab val lvl_anemia lvl_anemia
	g severe_anemia=lvl_anemia==1
	* Chronic illnesses
	replace m1_203_et = 0 if m1_203_other=="Anemia" | m1_203_other=="Chgara" ///
	| m1_203_other=="Chronic Gastritis" ///
	| m1_203_other=="Chronic Sinusitis and tonsil" ///
	| m1_203_other=="gastritis" | m1_203_other=="Gastro intestinal track"  | m1_203_other=="STI"  ///
	| m1_203_other=="Hemorrhoids"  | m1_203_other=="Sinus" | m1_203_other=="Sinuse" ///
	| m1_203_other=="Sinusitis" | m1_203_other=="gastric" | m1_203_other=="gastric ulcer" 
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e  m1_202g_et m1_203_et)
	replace chronic=1 if m1_HBP==1 // measured BP
	* Underweight/overweight
	rename m1_malnutrition maln_underw
	recode m1_BMI 0/29.999=0 30/100=1, g(overweight)
	
* Obstetric risk factors
	gen multiple= m1_805 >1 &  m1_805<.
	gen cesa= m1_1007==1
	gen neodeath = m1_1010 ==1
	gen preterm = m1_1005 ==1
	gen PPH=m1_1006==1
	rename m1_1004 late_misc
	egen complic = rowmax(cesa stillbirth preterm neodeath  PPH )
	
egen anyrisk =rowmax(m1_anemic_11 chronic maln_underw overweight young old multiple complic )

* Visit time
	encode m1_start_time, gen(time)
	recode time 1/8=2 9/20=3 21/202=1 203/321=2 322/418=3
	lab def time2 1"Morning" 2"Afternoon" 3"Evening"
	lab val time time2
	
* MERGING WITH M0 DATA
	merge m:1 facility using "$user/$analysis/ETtmpfac.dta"
	keep if _merge==3 
	drop _merge 
	save  "$user/$analysis/ETtmp.dta", replace		

save "$user/$analysis/ETtmp.dta", replace

*------------------------------------------------------------------------------*		
* KENYA
u "$user/$data/Kenya/02 recoded data/eco_m1_ke_der.dta", clear
		keep if module==1	// keep m1 data only
		rename study_site site
		egen tag=tag(facility)
* ANC quality
		gen ultrasound = anc1ultrasound if trimester>2 & trimester<. // 3rd trimester only
		gen edd2 = anc1edd if trimester>1 & trimester<. // 2nd or 3rd
		gen deworm = anc1deworm if trimester>1 & trimester<. // 2nd or 3rd
		gen tt= anc1tt
		replace tt =. if  m1_714c>=5 &  m1_714c<98 // had 5 or more previous lifetime doses
		replace tt =. if  m1_714c>=4 &  m1_714c<98 & m1_714e <=10 // had 4 or more incl. 1 in last 10 years
		replace tt =. if  m1_714c>=3 &  m1_714c<98 & m1_714e <=5 // had 3 or more incl. 1 in last 5 years
		replace tt =. if  m1_714c>=2 &  m1_714c<98 & m1_714e <=3 // had 2 or more incl. 1 in last 3 years
		g previous_preg=m1_1011a 
		
		egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression previous_preg ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd2 ///
		counsel_comeback anc1ifa deworm tt anc1itn)
		replace anc1qual = anc1qual*100
		
		xtile group_anc1qual=anc1qual, nquantiles(4)
		gen q4_anc1=group_anc1qual==4
		
		gen q60=anc1qual>60
		
		egen phys_exam=rowmean(anc1bp anc1weight anc1height anc1muac)
		egen diag=rowmean(anc1blood anc1urine ultrasound)
		egen hist= rowmean(anc1lmp anc1depression previous_preg)
		egen counsel=rowmean(counsel_nutri counsel_exer counsel_complic counsel_birthplan edd2 ///
		counsel_comeback)
		egen tx=rowmean(anc1ifa deworm tt anc1itn)

* Demographics & health 
		recode educ_cat 1/2=0 3/4=1, gen(second)
		gen healthlit_corr=health_lit==4
		gen age_cat=enrollage
		recode age_cat 15/19=1 20/35=2 36/60=3
		lab def age_cat 1"15-19yrs" 2"20-35 yrs" 3 "36+yrs"
		gen young= age_cat==1
		gen older=age_cat==3
		recode  m1_201 (1/3=0) (4/5=1), gen(poorhealth)
	
		recode phq9_cat 4/5=3, gen(depression_cat)
		lab def depression_cat 1"none-minimal 0-4" 2"Mild 5-9" 3"Moderate to severe 10+"
		lab val depression_cat depression_cat
		recode depression_cat 1=0 2/3=1, g(depress)
			
*Medical risk factors
		* Anemia
		recode Hb 0/6.999=1 7/10.999=2 11/30=3, gen(lvl_anemia)
		lab def lvl_anemia 1"Severe anemia (<7gm/dl)" 2"Moderate, mild anemia (7-10.9gm/dl)" 3"Normal"
		lab val lvl_anemia lvl_anemia
		g severe_anemia=lvl_anemia==1
		* Chronic illnesses
		g other_chronic= 1 if m1_203_other=="Fibroids" | m1_203_other=="Peptic ulcers disease" ///
		| m1_203_other=="PUD" | m1_203_other=="Gestational Hypertension in previous pregnancy" ///
		| m1_203_other=="Ovarian cyst" | m1_203_other=="Peptic ulcerative disease"
		
		egen chronic= rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_203c_ke ///
		m1_203d_ke  m1_203g_ke  m1_203i_ke ///
		m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke other_chronic)
		replace chronic=1 if HBP==1 // measured BP
		* Underweight/overweight
		rename low_BMI maln_underw
		recode BMI 0/29.999=0 30/100=1, g(overweight)
		
		egen ipv=rowmax(m1_1101 m1_1103)
* Obstetric risk factors		
		gen multiple= m1_805 >1 &  m1_805<.
		gen cesa= m1_1007==1
		
		gen neodeath = m1_1010 ==1
		gen preterm = m1_1005 ==1
		gen PPH=m1_1006==1
		egen complic = rowmax(stillbirth neodeath preterm PPH cesa)
	
* Visit time
		 extrdate hh time  = m1_start_time
		 recode time 9/11=1 12/14=2 15/23=3
		 lab def time2 1"Morning" 2"Afternoon" 3"Evening"
		 lab val time time2
	
egen anyrisk =rowmax(anemic chronic maln_underw overweight young old multiple complic )

		rename dangersign m1_dangersigns
		
* MERGING WITH M0 DATA
	merge m:1 facility using "$user/$analysis/KEtmpfac.dta"
	keep if _merge==3 
	drop _merge 
	
save "$user/$analysis/KEtmp.dta", replace

*------------------------------------------------------------------------------*	
* SOUTH AFRICA 

u  "$user/$data/South Africa/02 recoded data/eco_m1_za_der.dta", clear
		drop if respondent =="NEL_045"	// missing entire sections 7 and 8		 				      
		rename  study_site_sd site
		egen tag=tag(facility)
		
* ANC quality
		gen edd = anc1edd if trimester>1 & trimester<.
		gen calcium = anc1calcium if trimester>1 & trimester<.
		gen tt= anc1tt
		replace tt =. if  m1_714c>=5 &  m1_714c<98 // had 5 or more previous lifetime doses
		replace tt =. if  m1_714c>=4 &  m1_714c<98 & m1_714e <=10 // had 4 or more incl. 1 in last 10 years
		replace tt =. if  m1_714c>=3 &  m1_714c<98 & m1_714e <=5 // had 3 or more incl. 1 in last 5 years
		replace tt =. if  m1_714c>=2 &  m1_714c<98 & m1_714e <=3 // had 2 or more incl. 1 in last 3 years
		g previous_preg=m1_1011a 
		
		egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1lmp anc1depression anc1danger_screen previous_preg ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium tt )
		replace anc1qual = anc1qual*100
		xtile group_anc1qual=anc1qual, nquantiles(4)
		gen q4_anc1=group_anc1qual==4
		
		gen q60=anc1qual>60
		
		egen phys_exam=rowmean(anc1bp anc1weight anc1height anc1muac)
		egen diag=rowmean(anc1blood anc1urine )
		egen hist= rowmean(anc1lmp anc1depression anc1danger_screen previous_preg)
		egen counsel=rowmean(counsel_nutri counsel_exer counsel_complic counsel_birthplan edd ///
		counsel_comeback)
		egen tx=rowmean(anc1ifa calcium  tt )

* Demographics & health 
		recode educ_cat 1/2=0 3/4=1, gen(second)
		gen healthlit_corr=health_lit==4
		gen age_cat=enrollage
		recode age_cat 15/19=1 20/35=2 36/60=3
		lab def age_cat 1"15-19yrs" 2"20-35 yrs" 3 "36+yrs"
		gen young= age_cat==1
		gen older=age_cat==3
		recode  m1_201 (1/3=0) (4/5=1), gen(poorhealth)
	
		recode phq9_cat 4/5=3, gen(depression_cat)
		lab def depression_cat 1"none-minimal 0-4" 2"Mild 5-9" 3"Moderate to severe 10+"
		lab val depression_cat depression_cat
		recode depression_cat 1=0 2/3=1, g(depress)

* Medical risk factors
		* Anemia
		recode Hb 0/6.999=1 7/10.999=2 11/30=3, gen(lvl_anemia)
		lab def lvl_anemia 1"Severe anemia (<7gm/dl)" 2"Moderate, mild anemia (7-10.9gm/dl)" 3"Normal"
		lab val lvl_anemia lvl_anemia
		g severe_anemia=lvl_anemia==1
		* Chronic illnesses
		egen chronic= rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
		encode m1_203, gen(prob)
		recode prob (1/4 10 16 18/21 24 28 29 30 33 34 28 =0 ) (5/9 11/15 17 22 23 25 26 27 31 32=1)
		replace chronic = 1 if prob==1
		drop prob
		replace chronic=1 if HBP==1 // measured BP
		* Underweight/overweight
		rename low_BMI maln_underw
		recode BMI 0/29.999=0 30/100=1, g(overweight)
		
		egen ipv=rowmax(m1_1101 m1_1103)
		
* Obstetric risk factors
		gen multiple= m1_805 >1 &  m1_805<.
		gen cesa= m1_1007==1
		
		gen neodeath = m1_1010 ==1
		gen preterm = m1_1005 ==1
		gen PPH=m1_1006==1
		egen complic = rowmax(stillbirth neodeath preterm PPH cesa)
			
* Visit time
		encode m1_start_time, gen(time)
		recode time 2/11=2 12/217=1 218/344=2  345/369=3
		lab def time2 1"Morning" 2"Afternoon" 3"Evening"
		lab val time time2
* Risk score 
		encode m1_203, gen(prob)
		ta prob,g(dum)
			
egen anyrisk =rowmax(anemic chronic maln_underw overweight young old multiple complic )

		rename dangersign m1_dangersigns
		
* MERGING WITH M0 DATA
	merge m:1 facility using "$user/$analysis/ZAtmpfac.dta"
	keep if _merge==3 
	drop _merge 
save "$user/$analysis/ZAtmp.dta", replace

*------------------------------------------------------------------------------*
* INDIA
u "$user/$data/India/02 recoded data/eco_m1_in_der.dta", clear	
egen tag=tag(facility)
* ANC quality
		gen edd = anc1edd if trimester>1 & trimester<.  // 2nd or 3rd trimester only
		gen ultra =anc1ultrasound if trimester>2 & trimester<. // 3rd trimester only
		gen calcium = anc1calcium if trimester>1 & trimester<. // 2nd or 3rd trimester only
		gen tt= anc1tt
		replace tt =. if  m1_714c>=5 &  m1_714c<98 // had 5 or more previous lifetime doses
		replace tt =. if  m1_714c>=4 &  m1_714c<98 & m1_714e <=10 // had 4 or more incl. 1 in last 10 years
		replace tt =. if  m1_714c>=3 &  m1_714c<98 & m1_714e <=5 // had 3 or more incl. 1 in last 5 years
		replace tt =. if  m1_714c>=2 &  m1_714c<98 & m1_714e <=3 // had 2 or more incl. 1 in last 3 years
		
		g previous_preg=m1_1011a 

		egen anc1qual= rowmean(anc1bp anc1weight anc1blood ///
		anc1urine ultra anc1lmp  previous_preg counsel_nutri  counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium anc1deworm tt )
		
		replace anc1qual = anc1qual*100
		
		egen phys_exam=rowmean(anc1bp anc1weight)
		egen diag=rowmean(anc1blood anc1urine ultra )
		egen hist= rowmean(anc1lmp previous_preg)
		egen counsel=rowmean(counsel_nutri  counsel_complic counsel_birthplan edd counsel_comeback)
		egen tx=rowmean(anc1ifa calcium anc1deworm tt)

* Demographics & health 
		recode educ_cat 1/2=0 3/4=1, gen(second)
		gen healthlit_corr=m1_health_lit==4
		gen age_cat=enrollage
		recode age_cat 15/19=1 20/35=2 36/60=3
		lab def age_cat 1"15-19yrs" 2"20-35 yrs" 3 "36+yrs"
		gen young= age_cat==1
		gen older=age_cat==3
		recode  m1_201 (1/3=0) (4/5=1), gen(poorhealth)
	
		recode phq9_cat 4/5=3, gen(depression_cat)
		lab def depression_cat 1"none-minimal 0-4" 2"Mild 5-9" 3"Moderate to severe 10+"
		lab val depression_cat depression_cat
		recode depression_cat 1=0 2/3=1, g(depress)
		
* Medical risk factors
		* Anemia
		recode Hb 0/6.999=1 7/10.999=2 11/30=3, gen(lvl_anemia)
		lab def lvl_anemia 1"Severe anemia (<7gm/dl)" 2"Moderate, mild anemia (7-10.9gm/dl)" 3"Normal"
		lab val lvl_anemia lvl_anemia
		g severe_anemia=lvl_anemia==1
		* Chronic illnesses
		egen chronic= rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_203)
		replace chronic=1 if HBP==1
		* Underweight / overweight
		rename low_BMI maln_underw
		recode BMI 0/29.999=0 30/100=1, g(overweight)
* Obstetric risk factors
		gen multiple= m1_805 >1 &  m1_805<.
		gen cesa= m1_1007==1
		
		gen neodeath = m1_1010 ==1
		gen preterm = m1_1005 ==1
		gen PPH=m1_1006==1
		egen complic = rowmax(stillbirth neodeath preterm PPH cesa)

egen anyrisk =rowmax(anemic chronic maln_underw overweight young old multiple complic )
	
		drop if anc1qual==. // 1 woman had no data on ANC content
	
* MERGING WITH M0 FACILITY-LEVEL DATA
	merge m:1 facility using "$user/$analysis/INtmpfac.dta"
	keep if _merge==3  // dropping 18 women for which we dont have Module 0. 
	drop _merge 
	
save "$user/$analysis/INtmp.dta", replace



















