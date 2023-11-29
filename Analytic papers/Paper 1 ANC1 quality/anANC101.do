

global demog educ_cat
		
global riskfactors chronic anemic_11 maln_underw ///
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
		
		tab1 $demog if site==2
		tab1 $demog if site==1


		tabstat $riskfactors if site==2, stat(mean count) col(stat) // East Shewa
		tabstat $riskfactors if site==1, stat(mean count) col(stat) // Adama
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
		
		tab1 $demog if site==2 // Kitui
		tab1 $demog if site==1 // Kiambu
		
		tabstat  $riskfactors if site==2, stat(mean count) col(stat) // Kitui
		tabstat  $riskfactors if site==1, stat(mean count) col(stat) // Kiambu
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
		
		tab1 $demog if site==2 // Nongoma
		tab1 $demog if site==1  // uMhlathuze
		
		tabstat $riskfactors if site==2, stat(mean count) col(stat) // Nongoma
		tabstat $riskfactors if site==1, stat(mean count) col(stat) // uMhlathuze
		