* ETHIOPIA
u "$user/$analysis/ETtmp.dta", clear
cd "$user/$analysis"
global qualvarsET anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression anc1danger_screen previous_preg ///
		m1_counsel_nutri m1_counsel_exer m1_counsel_complic m1_counsel_birthplan edd ///
		m1_counsel_comeback anc1ifa calcium deworm tt anc1itn
		
	* Supp Table 1. ANC1 quality
		tabstat  $qualvarsET if site==2, stat(mean count) col(stat) // East Shewa
		tabstat  $qualvarsET if site==1, stat(mean count) col(stat) // Adama
		tabstat anc1qual, by(site) stat(mean sd )
		
	* Table 2 Demog & health 		
		summtab , contvars(enrollage ) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depression_cat  m1_dangersigns primipara preg_intent trimester) mean by(site) excel ///
		excelname(Table2) sheetname(ETH_demog) replace 
		
	* Fig 3 risk factors		
		summtab , catvars(lvl_anemia chronic maln_underw overweight complic) mean  excel ///
		excelname(Fig3) sheetname(ETH_risk) replace 

		
	* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ) contvars (sri_score total_staff ///
		anc_mont ) mean by(site) excel excelname(Table3) sheetname(ET) replace 
		
		
*------------------------------------------------------------------------------*/	
* KENYA
u "$user/$analysis/KEtmp.dta", clear
cd "$user/$analysis"
global qualvarsKE anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression  previous_preg ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd2 ///
		counsel_comeback anc1ifa deworm tt anc1itn
			
	* Supp Table 1 ANC quality 
		tabstat  $qualvarsKE if site==2, stat(mean count) col(stat) // Kitui
		tabstat  $qualvarsKE if site==1, stat(mean count) col(stat) // Kiambu
		tabstat anc1qual, by(site) stat(mean sd)
	
	* Table 2 Demog & health 		
		summtab , contvars(enrollage) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depression_cat  dangersigns primipara preg_intent trimester) mean by(site) excel ///
		excelname(Table2) sheetname(KEN_demog) replace 
		
	* Fig 3 risk factors		
		summtab , catvars(lvl_anemia chronic maln_underw overweight complic) mean excel ///
		excelname(Fig3) sheetname(KEN_risk) replace 
		
	* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ) contvars (sri_score total_staff ///
		anc_mont ) mean by(site) excel excelname(Table3) sheetname(KE) replace 

		
*------------------------------------------------------------------------------*/		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 
cd "$user/$analysis"
global qualvarsZA anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1lmp anc1depression anc1danger_screen previous_preg ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium tt
		
* Supp Table 1
		tabstat  $qualvarsZA if site==2, stat(mean count) col(stat) // Nongoma
		tabstat  $qualvarsZA if site==1, stat(mean count) col(stat) // uMhlathuze
		tabstat anc1qual, by(site) stat(mean sd)
		
	* Table 2 Demog & health 		
		summtab , contvars(enrollage) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depression_cat  dangersigns primipara preg_intent trimester) mean by(site) excel ///
		excelname(Table2) sheetname(ZAF_demog) replace 
		
	* Fig 3 risk factors		
		summtab , catvars(lvl_anemia chronic maln_underw overweight complic) mean excel ///
		excelname(Fig3) sheetname(ZAF_risk) replace 
		
	* Table 3 Facility characteristics
		summtab if tag==1,  contvars (sri_score total_staff ///
		anc_mont ) mean by(site) excel excelname(Table3) sheetname(ZA) replace 

*------------------------------------------------------------------------------*
* INDIA	
u "$user/$analysis/INtmp.dta", clear 
cd "$user/$analysis"
global qualvarsIND anc1bp anc1weight anc1blood ///
		anc1urine ultra anc1lmp  previous_preg counsel_nutri  counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium anc1deworm tt
		
		* Supp Table 1
		tabstat  $qualvarsIND if state==1, stat(mean count) col(stat) // Sonipat
		tabstat  $qualvarsIND if state==2, stat(mean count) col(stat) // Jodhpur
		tabstat anc1qual, by(state) stat(mean p50 sd)
		
		* Table 2 Demog & health 		
		summtab , contvars(enrollage) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depression_cat  m1_dangersigns primipara preg_intent trimester) mean by(state) excel ///
		excelname(Table2) sheetname(IND_demog) replace 
		
		* Fig 3 risk factors		
		summtab , catvars(lvl_anemia chronic maln_underw overweight complic) mean  excel ///
		excelname(Fig3) sheetname(IND_risk) replace 
	
	
	

