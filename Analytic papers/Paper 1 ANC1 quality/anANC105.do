
global user "/Users/catherine.arsenault"
global analysis "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 1 ANC1 quality"
global data "Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data"

*------------------------------------------------------------------------------*
* Ethiopia
u "$user/$analysis/ETtmp.dta", clear
	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
	tabstat m1_202a m1_202b m1_202c m1_202d m1_202e, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 
	ta m1_719 if m1_202b  ==1
	ta m1_720 if m1_202c ==1
	ta m1_721 if  m1_202d ==1
	ta m1_722 if m1_202e ==1
	
	
	* Prior obstetric complications
	egen complic4=rowmax(m1_1004 stillbirth m1_1005 m1_1010)
	tabstat m1_1004 stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if m1_1004 ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	
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
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
	tabstat m1_202a m1_202b m1_202c m1_202d m1_202e, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 
	ta m1_719 if m1_202b  ==1
	ta m1_720 if m1_202c ==1
	ta m1_721 if  m1_202d ==1
	ta m1_722 if m1_202e ==1
	
	* Prior obstetric complications
	egen complic4=rowmax(m1_1004 stillbirth m1_1005 m1_1010)
	tabstat m1_1004 stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if m1_1004 ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	
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
			
*------------------------------------------------------------------------------*		
* ZAF
u "$user/$analysis/ZAtmp.dta", clear 			
	
	* Diabetes, HTN, cardiac problem, mental health problem, HIV
	egen chronic5=rowmax(m1_202a m1_202b m1_202c m1_202d m1_202e)
	tabstat m1_202a m1_202b m1_202c m1_202d m1_202e, stat(sum N) col(stat)
	ta m1_718 if m1_202a  ==1 
	ta m1_719 if m1_202b  ==1
	ta m1_720 if m1_202c ==1
	ta m1_721 if  m1_202d ==1
	ta m1_722 if m1_202e ==1
	
	* Prior obstetric complications
	egen complic4=rowmax(m1_1004 stillbirth m1_1005 m1_1010)
	tabstat m1_1004 stillbirth m1_1005 m1_1010, stat(sum N) col(stat) // late miscarriage, stillbirth (deliv>live births), preterm, neodeath
	ta m1_1011b if m1_1004 ==1 
	ta m1_1011c if stillbirth ==1 
	ta m1_1011d if m1_1005 ==1 
	ta m1_1011f if m1_1010 ==1 
	* Depression
	recode phq9_cat (1=0) (2/5=1), gen(depression)
	g depression_address = m1_716c if depression==1
	
	* Anemia
	ta anemic
	g anemia_address= anc1blood if anemic==1
	
	* Danger signs (one of 6)
	ta dangersign
	recode m1_815 (1=0) (2/96=1) (.a .d .r=.) , gen(danger_address)
	replace danger_address = 0 if m1_815_other=="She told the nurse that she bleeds and the nurse said there is no such thing"
	replace danger_address=. if dangersign==0		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
