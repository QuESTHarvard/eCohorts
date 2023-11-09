
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------*
* Ethiopia
u "$user/$data/Ethiopia/02 recoded data/eco_m1m2_et_der.dta", clear
	
	keep if b7eligible==1  & m1_complete==2 // keep baseline data only
	gen hiv_test= anc1hiv if m1_202e==0 // HIV test only among those not HIV+
			
	egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1ultrasound anc1lmp anc1depression anc1danger_screen ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan anc1edd ///
		counsel_comeback anc1ifa anc1calcium anc1deworm anc1tt anc1itn)
		
	gen second_third_trim= trimester>=2
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e  m1_202g_et m1_203_et)
	replace chronic = 0 if m1_203_other=="Anemia" | m1_203_other=="Chronic Sinusitis and tonsil" ///
	| m1_203_other=="gastritis" | m1_203_other=="Gastro intestinal track" ///
	| m1_203_other=="Hemorrhoids"  | m1_203_other=="Sinus" | m1_203_other=="Sinuse" ///
	| m1_203_other=="Sinusitis" | m1_203_other=="gastric"
	replace chronic=1 if HBP==1
	rename malnutrition maln_underw
	
	gen multiple= m1_805 >1 &  m1_805<.
	gen cesa= m1_1007==1
	
	gen neodeath = m1_1010 ==1
	gen preterm = m1_1005 ==1
	gen PPH=m1_1006==1
	egen complic = rowmax(stillbirth neodeath preterm PPH)
	
	* add anemia back in anemia cat 
save "$user/$analysis/ETtmp.dta", replace
*------------------------------------------------------------------------------*		
* Kenya
u "$user/$data/Kenya/02 recoded data/eco_m1_ke_der.dta", clear

		rename study_site site
				
		egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1ultrasound anc1lmp anc1depression  ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan anc1edd ///
		counsel_comeback anc1ifa  anc1deworm anc1tt anc1itn)
		
		gen second_third_trim= trimester>=2
		egen chronic= rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e m1_203c_ke ///
		m1_203d_ke m1_203e_ke m1_203f_ke m1_203g_ke m1_203h_ke m1_203i_ke ///
		m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke)
		replace chronic = 1 if m1_203_other=="Fibroids" | m1_203_other=="Peptic ulcers disease" ///
		| m1_203_other=="PUD" | m1_203_other=="Gestational Hypertension in previous pregnancy" ///
		| m1_203_other=="Ovarian cyst" | m1_203_other=="Peptic ulcerative disease"
		replace chronic=1 if HBP==1
		rename low_BMI maln_underw
		
		gen multiple= m1_805 >1 &  m1_805<.
		gen cesa= m1_1007==1
		
		gen neodeath = m1_1010 ==1
		gen preterm = m1_1005 ==1
		gen PPH=m1_1006==1
		egen complic = rowmax(stillbirth neodeath preterm PPH)
	
		* add back m1_203j_ke in severe anemia
save "$user/$analysis/KEtmp.dta", replace
*------------------------------------------------------------------------------*	
* South Africa
u  "$user/$data/South Africa/02 recoded data/eco_m1_za_der.dta", clear
 
		rename  study_site_sd site

		egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1lmp anc1depression anc1danger_screen ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan anc1edd ///
		counsel_comeback anc1ifa anc1calcium  anc1tt )
		
		gen second_third_trim= trimester>=2
		egen chronic= rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
		encode m1_203, gen(prob)
		recode prob (1/4 10 16 18/21 24 29 33 34 28 =0 ) (5/9 11/15 17 22 23 25 26 27 30 31 32=1)
		replace chronic = 1 if prob==1
		replace chronic=1 if HBP==1
		rename low_BMI maln_underw
		
		gen multiple= m1_805 >1 &  m1_805<.
		gen cesa= m1_1007==1
		
		gen neodeath = m1_1010 ==1
		gen preterm = m1_1005 ==1
		gen PPH=m1_1006==1
		egen complic = rowmax(stillbirth neodeath preterm PPH)
	
		
		* add back anemia from m1_203
save "$user/$analysis/ZAtmp.dta", replace
