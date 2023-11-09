

* Ethiopia
u "$user/$analysis/ETtmp.dta", clear

global qualvarsET anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression anc1danger_screen counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan anc1edd counsel_comeback anc1ifa anc1calcium ///
		anc1deworm anc1tt anc1itn
		
		tabstat  $qualvarsET if site==2, stat(mean count) col(stat) // East Shewa
		tabstat  $qualvarsET if site==1, stat(mean count) col(stat) // Adama
		tabstat anc1qual, by(site) stat(mean min max )
		
global riskfactors second_third_trim chronic anemic maln_underw ///
		dangersigns multiple cesa complic

		tabstat $riskfactors if site==2, stat(mean count) col(stat) // East Shewa
		tabstat $riskfactors if site==1, stat(mean count) col(stat) // Adama
*------------------------------------------------------------------------------*	
* Kenya

u "$user/$analysis/KEtmp.dta", clear

global qualvarsKE anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1ultrasound anc1lmp anc1depression  ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan anc1edd ///
		counsel_comeback anc1ifa  anc1deworm anc1tt anc1itn
		
		tabstat  $qualvarsKE if site==2, stat(mean count) col(stat) // Kitui
		tabstat  $qualvarsKE if site==1, stat(mean count) col(stat) // Kiambu
		tabstat anc1qual, by(site) stat(mean min max)
		
		tabstat  $riskfactors if site==2, stat(mean count) col(stat) // Kitui
		tabstat  $riskfactors if site==1, stat(mean count) col(stat) // Kiambu
*------------------------------------------------------------------------------*		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 

global qualvarsZA anc1bp anc1weight anc1height anc1muac anc1blood ///
		anc1urine anc1lmp anc1depression anc1danger_screen ///
		counsel_nutri counsel_exer counsel_complic counsel_birthplan anc1edd ///
		counsel_comeback anc1ifa anc1calcium  anc1tt 
		
		tabstat  $qualvarsZA if site==2, stat(mean count) col(stat) // Nongoma
		tabstat  $qualvarsZA if site==1, stat(mean count) col(stat) // uMhlathuze
		tabstat anc1qual, by(site) stat(mean min max)
		
		tabstat $riskfactors if site==2, stat(mean count) col(stat) // Nongoma
		tabstat $riskfactors if site==1, stat(mean count) col(stat) // uMhlathuze
		