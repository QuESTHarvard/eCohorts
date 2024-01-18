
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------*
* Ethiopia
u "$user/$analysis/ETtmp.dta", clear
	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5 =rowtotal(m1_202a m1_202b m1_202c m1_202d m1_202e), m
	recode chronic5 0=.
	egen chronic5_disc= rowtotal(m1_718 m1_719 m1_720 m1_721 m1_722), m
	g chronic5_address = chronic5-chronic5_disc 
	recode chronic5_add 0=1 1/5=0
	
	* Prior obstetric complications
	egen complic4= rowtotal(m1_1004 stillbirth m1_1005 m1_1010), m // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	recode complic4 0=.
	egen complic4_disc= rowtotal (m1_1011b m1_1011c m1_1011d m1_1011f), m
	gen complic4_address = complic4-complic4_disc
	recode  complic4_add -1/0=1 1/5=0
	
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	g depression_address = m1_716c if depression==1
	
	* Anemia
	ta anemic
	ta anc1blood if anemic==1
	
	* Danger signs (one of 6)
	ta dangersign
	egen danger_address = rowmax(m1_815_1-m1_815_96) 
	replace danger_address = 0 if m1_815_other=="I told her the problem but she said nothing"
	replace danger_address= 0 if  m1_815_0==1 // did not discuss the danger sign 
	replace danger_address=. if dangersign==0
*------------------------------------------------------------------------------*	
* Kenya
u "$user/$analysis/KEtmp.dta", clear

	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5 =rowtotal(m1_202a m1_202b m1_202c m1_202d m1_202e), m
	recode chronic5 0=.
	egen chronic5_disc= rowtotal(m1_718 m1_719 m1_720 m1_721 m1_722), m
	g chronic5_address = chronic5-chronic5_disc 
	recode chronic5_add 0=1 1/5=0
	
	* Prior obstetric complications
	egen complic4= rowtotal(m1_1004 stillbirth m1_1005 m1_1010), m // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	recode complic4 0=.
	egen complic4_disc= rowtotal (m1_1011b m1_1011c m1_1011d m1_1011f), m
	gen complic4_address = complic4-complic4_disc
	recode  complic4_add 0=1 1/5=0
	
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	g depression_address = m1_716c if depression==1
	
	* Anemia
	ta anemic
	g anemia_address= anc1blood if anemic==1
	
	* Danger signs (one of 6)
	ta dangersign
	egen danger_address = rowmax(m1_815_2 m1_815_3 m1_815_4 m1_815_5 m1_815_6 m1_815_7 m1_815_96) 
	replace danger_address = 0 if m1_815_other=="We discussed but there was no answer from provider" ///
	| m1_815_other=="Didn't discuss because it happened twice only."  | m1_815_other=="Never informed the care provider" ///
	| m1_815_other=="No response given by the nurse"
	replace danger_address= 0 if   m1_815_1==1 // did not discuss the danger sign 
	replace danger_address=. if dangersign==0
	
	
	egen keep = rownonmiss(chronic5_add complic4_add depression_address anemia_address danger_address)
	keep if keep!=0
	keep educ *_address facility_lvl site facility tertile
			
*------------------------------------------------------------------------------*		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 			
			
			
			
			ta  neodeath // previous neonatal death
			ta m1_1011f if neodeath==1
			ta specialist_hosp if neodeath==1
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
