

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
		summtab , contvars(enrollage) catvars(second health_lit tertile  marriedp ///
		primipara preg_intent trimester ) mean by(site) excel ///
		excelname(Table2) sheetname(ETH_demog) replace 
	
		summtab, catvars(chronic anemic maln_underw dangersigns cesa complic) mean by(site) excel ///
		excelname(Table2) sheetname(ETH_risk) replace 
	
	/* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ftdoc) contvars (sri_basicamenities ///
		sri_equip sri_diag total_staff anc_mont anc_vol_staff_onc beds) mean by(site) excel ///
		excelname(Table3) sheetname(ET) replace 
	
	* Figure 1
		ttest anc1qual, by(chronic)
		ttest anc1qual, by(anemic)
		ttest anc1qual, by(maln_underw)
		ttest anc1qual, by(dangersigns)
		ttest anc1qual, by(cesa)
		ttest anc1qual, by(complic)
				
		ttest timespent, by(chronic)
		ttest timespent, by(anemic)
		ttest timespent, by(maln_underw)
		ttest timespent, by(dangersigns)
		ttest timespent, by(cesa)
		ttest timespent, by(complic)

	
		/*reg anc1qual chronic
		margins, at(chronic=(0 1)) post
		lincom (_b[2._at] - _b[1._at])*/
		
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
		summtab , contvars(enrollage) catvars(second health_lit tertile  marriedp ///
		primipara preg_intent trimester ) mean by(site) excel ///
		excelname(Table2) sheetname(KE_demog) replace 
		
		summtab, catvars(chronic anemic maln_underw dangersigns cesa complic) mean by(site) excel ///
		excelname(Table2) sheetname(KE_risk) replace 
		
	/* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ftdoc) contvars (sri_basicamenities ///
		sri_equip sri_diag total_staff anc_mont anc_vol_staff_onc beds) mean by(site) excel ///
		excelname(Table3) sheetname(KE) replace 
	
		* Figure 1
		ttest anc1qual, by(chronic)
		ttest anc1qual, by(anemic)
		ttest anc1qual, by(maln_underw)
		ttest anc1qual, by(dangersigns)
		ttest anc1qual, by(cesa)
		ttest anc1qual, by(complic)
				
		ttest timespent, by(chronic)
		ttest timespent, by(anemic)
		ttest timespent, by(maln_underw)
		ttest timespent, by(dangersigns)
		ttest timespent, by(cesa)
		ttest timespent, by(complic)
		
		scatter anc1qual sri_score
		
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
		tabstat timespent, by(site) stat(mean sd)
		
		summtab , contvars(enrollage) catvars(second health_lit tertile  marriedp ///
		primipara preg_intent trimester ) mean by(site) excel ///
		excelname(Table2) sheetname(ZA_demog) replace 
		
		summtab, catvars(chronic anemic maln_underw dangersigns cesa complic) mean by(site) excel ///
		excelname(Table2) sheetname(ZA_risk) replace 
		
		/* Table 3 Facility characteristics
		summtab if tag==1, catvars(private facsecond ftdoc) contvars (sri_basicamenities ///
		sri_equip sri_diag total_staff anc_mont anc_vol_staff_onc beds) mean by(site) excel ///
		excelname(Table3) sheetname(ZA) replace 

		* Figure 1
		ttest anc1qual, by(chronic)
		ttest anc1qual, by(anemic)
		ttest anc1qual, by(maln_underw)
		ttest anc1qual, by(dangersigns)
		ttest anc1qual, by(cesa)
		ttest anc1qual, by(complic)
		
		ttest timespent, by(chronic)
		ttest timespent, by(anemic)
		ttest timespent, by(maln_underw)
		ttest timespent, by(dangersigns)
		ttest timespent, by(cesa)
		ttest timespent, by(complic)
			
		table quintile, stat(mean anc1qual)
		table educ, stat(mean anc1qual)
		
*------------------------------------------------------------------------------*
* INDIA		
