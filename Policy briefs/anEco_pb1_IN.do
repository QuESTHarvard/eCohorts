* India ECohort Baseline Data - Analyses for Policy Brief 
* Created by C. Arsenault 
* Created: Jan 25, 2024

u "$in_data_final/eco_m1_in.dta", clear

	sort facility respondentid 
	egen tagfac=tag(facility)
