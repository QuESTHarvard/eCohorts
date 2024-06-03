* ETHIOPIA
u "$user/$analysis/ETtmp.dta", clear
cd "$user/$analysis"

*------------------------------------------------------------------------------*
* DESCRIPTIVE TABLES

global qualvarsET anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression anc1danger_screen previous_preg ///
		m1_counsel_nutri m1_counsel_exer m1_counsel_complic m1_counsel_birthplan edd ///
		m1_counsel_comeback anc1ifa calcium deworm tt anc1itn
		
	* Supp Table 1. ANC1 quality
		tabstat  $qualvarsET if site==2, stat(mean count) col(stat) // East Shewa
		tabstat  $qualvarsET if site==1, stat(mean count) col(stat) // Adama
		tabstat anc1qual, by(site) stat(mean sd)
		
	* Table 1 Demog & health 		
		summtab , contvars(enrollage ) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depress  m1_dangersigns primipara preg_intent trimester) mean by(site) excel ///
		excelname(Table1) sheetname(ETH_demog) replace 
		
	* Fig 1 risk factors		
		tabstat m1_anemic_11 chronic maln_underw overweight complic anyrisk, stat(mean count) col(stat)

	* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ) contvars (sri_score total_staff ///
		anc_mont beds) mean by(site) excel excelname(suppTable4) sheetname(ET) replace 
		
		tabstat sri_score, by(sri_cat) stat(min max) col(stat)
		tabstat total_staff_onc, by(staff_cat) stat(min max) col(stat)
		tabstat anc_mont, by(vol_cat) stat(min max) col(stat)

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
	
	* Table 1 Demog & health 		
		summtab , contvars(enrollage) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depress  m1_dangersigns primipara preg_intent trimester) mean by(site) excel ///
		excelname(Table1) sheetname(KEN_demog) replace 
		
	* Fig 1 risk factors		
		tabstat  anemic chronic maln_underw overweight complic anyrisk, stat(mean count) col(stat)

		
	* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ) contvars (sri_score total_staff ///
		anc_mont beds) mean by(site) excel excelname(suppTable4) sheetname(KE) replace 

		tabstat sri_score, by(sri_cat) stat(min max) col(stat)
		tabstat total_staff_onc, by(staff_cat) stat(min max) col(stat)
		tabstat anc_mont, by(vol_cat) stat(min max) col(stat)

		
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
		
	* Table 1 Demog & health 		
		summtab , contvars(enrollage) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depress m1_dangersigns primipara preg_intent trimester) mean by(site) excel ///
		excelname(Table1) sheetname(ZAF_demog) replace 
		
	* Fig 1 risk factors		
		tabstat  anemic chronic maln_underw overweight complic anyrisk, stat(mean count) col(stat)
		
	* Table 3 Facility characteristics
		summtab if tag==1,  contvars (sri_score total_staff ///
		anc_mont beds) mean by(site) excel excelname(suppTable4) sheetname(ZA) replace 
		
		tabstat sri_score, by(sri_cat) stat(min max) col(stat)
		tabstat total_staff_onc, by(staff_cat) stat(min max) col(stat)
		tabstat anc_mont, by(vol_cat) stat(min max) col(stat)


*------------------------------------------------------------------------------*
* INDIA	
u "$user/$analysis/INtmp.dta", clear 
cd "$user/$analysis"
global qualvarsIND anc1bp anc1weight anc1blood ///
		anc1urine ultra anc1lmp  previous_preg counsel_nutri  counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium anc1deworm tt
		
		* Supp Table 1
		tabstat  $qualvarsIND if urban==0, stat(mean count) col(stat) // Rural facilities
		tabstat  $qualvarsIND if urban==1, stat(mean count) col(stat) // Urban
		tabstat anc1qual, by(state) stat(mean p50 sd)
		
		* Table 1 Demog & health 		
		summtab , contvars(enrollage) catvars(second healthlit_corr young tertile marriedp ///
		poorhealth depress  m1_dangersigns primipara preg_intent trimester) mean by(urban) excel ///
		excelname(Table1) sheetname(IND_demog) replace 
		
		* Fig 1 risk factors		
		tabstat  anemic chronic maln_underw overweight complic anyrisk, stat(mean count) col(stat)
		ta lvl_anemia
	
	* Table 3 Facility characteristics
		summtab if tag==1, catvars(facility_lvl ) contvars (sri_score total_staff ///
		anc_mont beds) mean by(urban) excel excelname(suppTable4) sheetname(IN) replace 

		tabstat sri_score, by(sri_cat) stat(min max) col(stat)
		tabstat total_staff_onc, by(staff_cat) stat(min max) col(stat)
		tabstat anc_mont, by(vol_cat) stat(min max) col(stat)

