* South Africa ECohort M1 data analysis 
* The following code generates a megatable for all data included in the baseline module 
* Created by K. Wright, C. Arsenault, and S. Sabwa 

*------------------------------------------------------------------------------*

* This .do file should be used only after the data has been cleaned, using the crEco_cln_ZA.do file

global user "/Users/katewright/Dropbox (Harvard University)/"

global data "SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data collection/4 South Africa/Analyses"

use "/Users/katewright/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/South Africa/02 recoded data/eco_m1_za.dta"

*------------------------------------------------------------------------------*

**---------summtab for enrollment data----------* 

summtab, by(study_site) catvars (facility) total catmisstype(missnoperc) excel excelname(ZA_ECohort_summtab) sheetname(Enrollment) directory("$user/$data")

**----------------------------------------------* 

**--------summtab for demographic data----------*

summtab2, by(study_site) vars(enrollage m1_501 m1_501_other m1_502 m1_503 m1_504 m1_505 m1_506 m1_506_other m1_507 m1_508) type (1 2 2 2 2 2 2 2 2 2 1) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Demographics) directory("$user/$data")

**---------------------------------------------*

**--------summtab for health literacy ---------*

summtab, by(study_site) catvars(m1_509a m1_509b m1_510a m1_510b m1_511 m1_512) total catmisstype(missnoperc) excel excelname(ZA_ECohort_summtab) sheetname(Health Literacy) directory("$user/$data")

**---------------------------------------------*

**--------summtab for health profile  ---------*

** need to move the phq9 variables to a derived variable file. but keeping here for now for ease ** 

* generate PHQ9 variable 
		gen phq9 = phq9a + phq9b + phq9c + phq9d + phq9e + phq9f + phq9f + phq9g + phq9h + phq9i 
		
		tab phq9
		
		
		recode phq9 (0 1 2 3 4 = 1) (5 6 7 8 9 = 2) (10 11 12 13 14 = 3) (15 16 17 18 19 = 4) (20 21 22 23 24 25 26 27 = 5)
		* define labels for phq9 
		label define phq9 1 "none-minimal" 2 "mild" 3 "moderate" 4 "moderately severe" 5 "severe" 6 "error"
		label values phq9 phq9
		tab phq9
		
summtab2, by (study_site) vars(m1_201 m1_202a m1_202b m1_202c m1_202d m1_202e m1_203 m1_204 m1_205a m1_205b m1_205c m1_205d m1_205e phq9 m1_207) type (2 2 2 2 2 2 2 2 2 2 2 2 2 2 1) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Health Profile) directory("$user/$data")

**---------------------------------------------*

**--------summtab for health system ratings  ---------*

summtab, by(study_site) catvars(m1_301 m1_302 m1_303 m1_304 m1_305a m1_305b) total catmisstype(missnoperc) excel excelname(ZA_ECohort_summtab) sheetname(HS Ratings) directory("$user/$data")

**----------------------------------------------------*

**--------  summtab for care pathways ---------*

summtab2, by (study_site) vars(m1_401 m1_402 m1_403b m1_404 m1_405) type (2 1 1 2 2) mean median range total replace catmisstype(missnoperc) total excel excelname(ZA_ECohort_summtab) sheetname(Care Pathways) directory("$user/$data")
