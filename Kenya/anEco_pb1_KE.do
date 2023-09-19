* Kenya ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Updated: September 19, 2023


u "$user/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Kenya/02 recoded data/eco_m1_ke_der.dta", clear

* QUALITY OF ANC1
	* By facility type
			tabstat anc1tq, by(facility_lvl) stat(mean sd count)
			tabstat anc1counsel, by(facility_lvl) stat(mean sd count)
	* By education level 
			tabstat anc1tq, by(educ_cat) stat(mean sd count)
			tabstat anc1counsel, by(educ_cat) stat(mean sd count)
	* Items done the least
			tabstat anc1bp anc1muac anc1bmi anc1fetal_hr anc1urine anc1blood ///
				    anc1ultrasound anc1ifa anc1tt counsel_nutri counsel_exer ///
					counsel_complic counsel_comeback counsel_birthplan, ///
					stat(mean count) col(stat)	
			
			ta risk_health
			ta stop_risk
			ta m1_1105 if physical_verbal==1
			
* GENERAL RISK FACTORS
	gen aged18 = enrollage<18
	gen aged35 = enrollage>35
	egen chronic = rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e  m1_203c_ke ///
		m1_203d_ke m1_203e_ke m1_203f_ke m1_203g_ke m1_203h_ke m1_203i_ke ///
		m1_203j_ke m1_203k_ke m1_203l_ke m1_203m_ke m1_203n_ke m1_203o_ke )
	egen general_risk = rowmax(aged18 aged35 chronic HBP anemic)
	
* OBSTETRIC RISK FACTORS
	gen multi= m1_805>1 & m1_805<.
	gen neodeath = m1_1010 ==1
	gen preterm = m1_1005 ==1
	gen PPH=m1_1006==1
	gen csect = m1_1007==1
	
	egen obst_risk = rowmax(multi stillbirth neodeath preterm PPH csect)
	egen anyrisk = rowmax (general_risk obst_risk)
	
			tab1 general_risk obst_risk anyrisk	
			tabstat anc1tq, by(anyrisk) stat(mean sd count)
			tabstat anc1counsel, by(anyrisk) stat(mean sd count)
			ttest anc1tq, by(anyrisk)
			ttest anc1counsel, by(anyrisk)
			tabstat m1_603, by(anyrisk) stat(mean sd count)
			ttest m1_603, by(anyrisk)
			tabstat anc1ultrasound, by(anyrisk) stat(mean sd count)
			
* REFERRAL CARE
ta specialist_hosp if facility_lvl!=2 & facility!="Kalimoni mission hospital" & ///
					 facility!="Mercylite hospital" & facility!="Our Lady of Lourdes Mutomo Hospital" & ///
					 facility!="Muthale Mission Hospital"
			
ta specialist_hosp anyrisk if facility_lvl!=2 & facility!="Kalimoni mission hospital" & ///
					 facility!="Mercylite hospital" & facility!="Our Lady of Lourdes Mutomo Hospital" & ///
					 facility!="Muthale Mission Hospital", col chi2
	
			tabstat anc1ux, by(facility_lvl) stat(mean sd count)
			ta vgm1_601 facility_lvl, col
