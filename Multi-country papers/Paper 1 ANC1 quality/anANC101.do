
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
* Ethiopia
u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et_der.dta", clear
	keep if b7eligible==1  & m1_complete==2 // keep baseline data only
	
	gen hiv_test= anc1hiv if m1_202e==0 // HIV test only among those not HIV+
	
tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression anc1danger_screen counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan counsel_comeback anc1ifa anc1calcium ///
		anc1deworm anc1tt anc1itn if site==2, stat(mean count) col(stat)
		
tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression anc1danger_screen counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan counsel_comeback anc1ifa anc1calcium ///
		anc1deworm anc1tt anc1itn if site==1, stat(mean count) col(stat)
			
egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression anc1danger_screen counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan counsel_comeback anc1ifa anc1calcium ///
		anc1deworm anc1tt anc1itn)

tabstat anc1qual, by(site) stat(mean min max )

save "$user/$analysis/ETtmp.dta", replace
		
* Kenya
u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data/eco_m1_ke_der.dta", clear
rename study_site site

tabstat  anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression  counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan counsel_comeback anc1ifa  ///
		anc1deworm anc1tt anc1itn anc1malaria if site==2, stat(mean count) col(stat)
		
tabstat  anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression  counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan counsel_comeback anc1ifa  ///
		anc1deworm anc1tt anc1itn anc1malaria if site==1, stat(mean count) col(stat)
				
egen anc1qual= rowmean(anc1bp anc1weight anc1height anc1muac anc1blood anc1urine anc1ultrasound ///
		anc1lmp anc1depression  counsel_nutri counsel_exer ///
		counsel_complic counsel_birthplan counsel_comeback anc1ifa  ///
		anc1deworm anc1tt anc1itn anc1malaria)
		
tabstat anc1qual, by(site) stat(mean min max)

* South Africa
u  "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data/eco_m1_za_der.dta", clear
drop anc1tq 
rename  study_site_sd site

tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt if site==1, stat(mean count ) col(stat)
		
tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt if site==2, stat(mean count) col(stat)	
		
egen anc1tq= rowmean(anc1bp anc1weight anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt)
	
tabstat anc1tq, by(site) stat(mean min max )
histogram anc1tq, percent normal yscale(range(0 40)) xscale(range(0 1)) by(, title(`"Proportion of 12 items completed during first ANC"')) by(site)
