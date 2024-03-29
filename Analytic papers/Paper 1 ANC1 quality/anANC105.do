
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------*
* Ethiopia
u "$user/$analysis/ETtmp.dta", clear
	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
	tabstat m1_202a m1_202b m1_202c m1_202d m1_202e, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 // DM
	ta m1_719 if m1_202b  ==1 // HTN
	ta m1_720 if m1_202c ==1 // cardiac
	ta m1_721 if  m1_202d ==1 // mental
	ta m1_722 if m1_202e ==1 // hiv
	
	egen diabetes_tx = rowmax(anc1diabetes m1_specialist_hosp )
	egen hypertension_tx = rowmax(anc1hypertension m1_specialist_hosp)	
	egen mental_tx=rowmax(m1_724d anc1mental_health_drug m1_specialist_hosp)	
	egen hiv_tx = rowmax( m1_708c m1_specialist_hosp m1_204)	
	
	ta diabetes_tx if m1_202a  ==1
	ta hypertension_tx if m1_202b  ==1
	ta m1_specialist_hosp if m1_202c ==1 
	ta mental_tx if m1_202d ==1 
	ta hiv_tx if  m1_202e ==1 

	* Prior obstetric complications
	egen complic4=rowmax(late_misc stillbirth m1_1005 m1_1010)
	tabstat late_misc stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if late_misc ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	
	ta m1_specialist_hosp if complic4==1
	
	* Depression
	g depression_address = m1_716c if depress==1
	egen depress_tx=rowmax(m1_724d anc1mental_health_drug)
	ta depress_tx if depress==1
	
	* Anemia
	g anemia_address= anc1blood if lvl_anemia<4
	ta anc1ifa if lvl_anemia<4
	
	* Danger signs (one of 6)
	ta m1_dangersign
	egen danger_address = rowmax(m1_815_1-m1_815_96) 
	replace danger_address = 0 if m1_815_other=="I told her the problem but she said nothing"
	replace danger_address= 0 if  m1_815_0==1 // did not discuss the danger sign 
	replace danger_address=. if m1_dangersign==0
	
	ta m1_specialist_hosp if m1_dangersign==1
	
	* Undernourished
	ta anc1muac if maln_under==1
	ta anc1food if maln_under==1


*------------------------------------------------------------------------------*	
* Kenya
u "$user/$analysis/KEtmp.dta", clear

	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
	tabstat m1_202a m1_202b m1_202c m1_202d m1_202e, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 
	ta m1_719 if m1_202b  ==1
	ta m1_720 if m1_202c ==1
	ta m1_721 if  m1_202d ==1
	ta m1_722 if m1_202e ==1
	
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp)
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)	
	egen mental_tx=rowmax(m1_724d anc1mental_health_drug specialist_hosp)	
	recode m1_713k 4=. 3=0 2=1
	egen hiv_tx = rowmax(m1_713k m1_708c specialist_hosp)
	
	ta diabetes_tx if m1_202a  ==1
	ta hypertension_tx if m1_202b  ==1
	ta specialist_hosp if m1_202c ==1 
	ta mental_tx if m1_202d ==1 
	ta hiv_tx if  m1_202e ==1 
	
	* Prior obstetric complications
	egen complic4=rowmax(m1_1004 stillbirth m1_1005 m1_1010)
	tabstat m1_1004 stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if m1_1004 ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	
	ta specialist_hosp if complic4==1
	
	* Depression
	g depression_address = m1_716c if depress==1
	egen depress_tx=rowmax(m1_724d anc1mental_health_drug)
	ta depress_tx if depress==1
	
	* Anemia
	g anemia_address= anc1blood if lvl_anemia<4
	ta anc1ifa if lvl_anemia<4
	
	* Danger signs (one of 6)
	ta m1_dangersign
	egen danger_address = rowmax(m1_815_2 m1_815_3 m1_815_4 m1_815_5 m1_815_6 m1_815_7 m1_815_96) 
	replace danger_address = 0 if m1_815_other=="We discussed but there was no answer from provider" ///
	| m1_815_other=="Didn't discuss because it happened twice only."  | m1_815_other=="Never informed the care provider" ///
	| m1_815_other=="No response given by the nurse"
	replace danger_address= 0 if   m1_815_1==1 // did not discuss the danger sign 
	replace danger_address=. if m1_dangersign==0
			
	ta specialist_hosp if m1_dangersign==1

*------------------------------------------------------------------------------*		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 			
	
	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen hiv=rowmax( m1_202e m1_202e_2_za)
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d hiv)
	tabstat m1_202a m1_202b m1_202c m1_202d hiv, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 
	ta m1_719 if m1_202b  ==1
	ta m1_720 if m1_202c ==1
	ta m1_721 if  m1_202d ==1
	ta m1_722 if hiv ==1
	
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp )
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)	
	egen mental_tx=rowmax(m1_724d anc1mental_health_drug specialist_hosp)	
	recode m1_713k 4=. 3=0 2=1
	egen hiv_tx = rowmax(m1_713k m1_708c m1_708c_2_za m1_204b_za specialist_hosp)	

	ta diabetes_tx if m1_202a  ==1
	ta hypertension_tx if m1_202b  ==1
	ta specialist_hosp if m1_202c ==1 
	ta mental_tx if m1_202d ==1 
	ta hiv_tx if  hiv ==1 
	
	
	* Prior obstetric complications
	egen complic4=rowmax(m1_1004 stillbirth m1_1005 m1_1010)
	tabstat m1_1004 stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if m1_1004 ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	
	ta specialist_hosp if complic4==1
	
	* Depression
	g depression_address = m1_716c if depress==1
	egen depress_tx=rowmax(m1_724d anc1mental_health_drug)
	ta depress_tx if depress==1

	* Anemia
	g anemia_address= anc1blood if lvl_anemia<4
	recode m1_713_za_in 0=1 2/3=0
	egen anemia_tx= rowmax(anc1ifa m1_713_za_in ) // ifa or iron injection
	ta anemia_tx if lvl_anemia<4

	* Danger signs (one of 6)
	ta m1_dangersign
	recode m1_815 (1=0) (2/96=1) (.a .d .r=.) , gen(danger_address)
	replace danger_address = 0 if m1_815_other=="She told the nurse that she bleeds and the nurse said there is no such thing"
	replace danger_address=. if m1_dangersign==0
	
	ta specialist_hosp if m1_dangersign==1		
		
			
------------------------------------------------------------------------------*		
* INDIA
u "$user/$analysis/INtmp.dta", clear 			
	
	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
	tabstat m1_202a m1_202b m1_202c m1_202d m1_202e, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 
	ta m1_719 if m1_202b  ==1
	ta m1_720 if m1_202c ==1
	ta m1_721 if  m1_202d ==1
	ta m1_722 if m1_202e ==1
	
	egen diabetes_tx = rowmax(anc1diabetes specialist_hosp )
	egen hypertension_tx = rowmax(anc1hypertension specialist_hosp)	
	egen mental_tx=rowmax(m1_724d anc1mental_health_drug specialist_hosp)	
	recode m1_713k 4=. 3=0 2=1
	egen hiv_tx = rowmax(m1_713k m1_708c specialist_hosp)
	
	ta diabetes_tx if m1_202a  ==1
	ta hypertension_tx if m1_202b  ==1
	ta specialist_hosp if m1_202c ==1 
	ta mental_tx if m1_202d ==1 
	ta hiv_tx if  m1_202e ==1 

	* Prior obstetric complications
	egen complic4=rowmax(m1_1004 stillbirth m1_1005 m1_1010)
	tabstat m1_1004 stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if m1_1004 ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	
	ta specialist_hosp if complic4==1
	
	* Depression
	g depression_address = m1_716c if depress==1
	egen depress_tx=rowmax(m1_724d anc1mental_health_drug)
	ta depress_tx if depress==1
	
	* Anemia
	g anemia_address= anc1blood if lvl_anemia<4
	recode m1_713_in_za 2=1 3=0
	egen anemia_tx=rowmax(anc1ifa m1_713_in_za) // ifa or iron injection
	ta anemia_tx if lvl_anemia<4
	
	
	* Danger signs (one of 6)
	ta m1_dangersign
	egen danger_address = rowmax(m1_815a_1_in m1_815a_2_in m1_815a_3_in m1_815a_4_in ///
	m1_815a_5_in m1_815a_6_in m1_815b_1_in m1_815b_2_in m1_815b_3_in m1_815b_4_in ///
	m1_815b_5_in m1_815b_6_in m1_815c_1_in m1_815c_2_in m1_815c_3_in m1_815c_4_in ///
	m1_815c_5_in m1_815c_6_in m1_815d_1_in m1_815d_2_in m1_815d_3_in m1_815d_4_in ///
	m1_815d_5_in m1_815d_6_in m1_815e_1_in m1_815e_2_in m1_815e_3_in m1_815e_4_in ///
	m1_815e_5_in m1_815e_6_in m1_815f_1_in m1_815f_2_in m1_815f_3_in m1_815f_4_in ///
	m1_815f_5_in m1_815f_6_in m1_815g_1_in m1_815g_2_in m1_815g_3_in m1_815g_4_in ///
	m1_815g_5_in m1_815g_6_in m1_815h_1_in m1_815h_2_in m1_815h_3_in m1_815h_4_in m1_815h_5_in m1_815h_6_in) 
	replace danger_address=. if m1_dangersign==0		
			
	ta specialist_hosp if m1_dangersign==1		
			
	* Undernourished
	ta anc1muac if maln_under==1
	ta anc1food if maln_under==1
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
