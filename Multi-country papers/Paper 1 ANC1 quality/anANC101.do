
global user "/Users/catherine.arsenault"

* Ethiopia
u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1m2_et_der.dta", clear

drop redcap_repeat_instrument-redcap_data_access_group m2_attempt_date-maternal_integrated_cards_comple anc1tq
keep if b7eligible==1  & m1_complete==2

tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt anc1ultrasound if site==1, stat(mean count) col(stat)
		
tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt if site==2, stat(mean count) col(stat)	
		
egen anc1tq= rowmean(anc1bp anc1weight anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt)

		
tabstat anc1tq, by(site) stat(mean min max )
histogram anc1tq, percent normal by(, title(`"Proportion of 12 items completed during first ANC"')) by(site)

		
* Kenya
u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data/eco_m1_ke_der.dta", clear
drop anc1tq
rename study_site site

tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt if site==1, stat(mean count) col(stat)
		
tabstat anc1bp anc1weight anc1height anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt if site==2, stat(mean count) col(stat)	
		
egen anc1tq= rowmean(anc1bp anc1weight anc1muac anc1blood anc1urine ///
		counsel_nutri counsel_complic counsel_birthplan ///
		counsel_comeback anc1ifa anc1tt)
		
tabstat anc1tq, by(site) stat(mean min max)
histogram anc1tq, percent normal by(, title(`"Proportion of 12 items completed during first ANC"')) by(site)

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
