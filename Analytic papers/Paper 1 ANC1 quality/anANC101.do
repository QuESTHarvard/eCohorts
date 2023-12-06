

global demog educ_cat primipara preg_intent trimester marriedp quintile
		
global riskfactors chronic anemic maln_underw ///
		dangersigns cesa complic
		
* Ethiopia
u "$user/$analysis/ETtmp.dta", clear

global qualvarsET anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression anc1danger_screen ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium deworm tt anc1itn
		
		tabstat  $qualvarsET if site==2, stat(mean count) col(stat) // East Shewa
		tabstat  $qualvarsET if site==1, stat(mean count) col(stat) // Adama
		tabstat anc1qual, by(site) stat(mean min max )
		tabstat timespent, by(site) stat(mean min max )
		
		su enrollage gravidity if site==2
		su enrollage gravidity if site==1
		
		tab1 $demog if site==2
		tab1 $demog if site==1

		tabstat $riskfactors if site==2, stat(mean count) col(stat) // East Shewa
		tabstat $riskfactors if site==1, stat(mean count) col(stat) // Adama
		
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
		
*------------------------------------------------------------------------------*	
* Kenya

u "$user/$analysis/KEtmp.dta", clear

global qualvarsKE anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine ultrasound anc1lmp anc1depression  ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd2 ///
		counsel_comeback anc1ifa deworm tt anc1itn
		
		tabstat  $qualvarsKE if site==2, stat(mean count) col(stat) // Kitui
		tabstat  $qualvarsKE if site==1, stat(mean count) col(stat) // Kiambu
		tabstat anc1qual, by(site) stat(mean min max)
		tabstat timespent, by(site) stat(mean min max )
		
		su enrollage gravidity if site==2 // Kitui
		su enrollage gravidity if site==1 // Kiambu
		
		
		tab1 $demog if site==2 // Kitui
		tab1 $demog if site==1 // Kiambu
		
		tabstat  $riskfactors if site==2, stat(mean count) col(stat) // Kitui
		tabstat  $riskfactors if site==1, stat(mean count) col(stat) // Kiambu
		
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
*------------------------------------------------------------------------------*		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 

global qualvarsZA anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1lmp anc1depression anc1danger_screen ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan edd ///
		counsel_comeback anc1ifa calcium tt
		
		tabstat  $qualvarsZA if site==2, stat(mean count) col(stat) // Nongoma
		tabstat  $qualvarsZA if site==1, stat(mean count) col(stat) // uMhlathuze
		tabstat anc1qual, by(site) stat(mean min max)
		tabstat timespent, by(site) stat(mean min max )
		
		su enrollage gravidity if site==2 // Nongoma
		su enrollage gravidity if site==1 // uMhlathuze
		
		tab1 $demog if site==2 // Nongoma
		tab1 $demog if site==1  // uMhlathuze
		
		tabstat $riskfactors if site==2, stat(mean count) col(stat) // Nongoma
		tabstat $riskfactors if site==1, stat(mean count) col(stat) // uMhlathuze
		
		* Figure 1
		table chronic, stat(mean anc1qual)
			ttest anc1qual, by(chronic)
		table anemic, stat(mean anc1qual)
			ttest anc1qual, by(anemic)
		table maln_underw, stat(mean anc1qual)
			ttest anc1qual, by(maln_underw)
		table dangersigns, stat(mean anc1qual)
			ttest anc1qual, by(dangersigns)
		table cesa, stat(mean anc1qual)
			ttest anc1qual, by(cesa)
		table complic, stat(mean anc1qual)
			ttest anc1qual, by(complic)
			
		table quintile, stat(mean anc1qual)
		table educ, stat(mean anc1qual)
		