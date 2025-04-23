clear all
set more off
	global user "/Users/catherine.arsenault/Dropbox/SPH Kruk QuEST Network/Core Research/Ecohorts"
	global in_data_final "$user/MNH Ecohorts QuEST-shared/Data/India/02 recoded data"
	
* ETHIOPIA
	u "$in_data_final/eco_IN_Complete.dta", clear
	
	* Restrict dataset to those who were not lost to follow up
	keep if m3_date<. // 35 deleted
	
	* Remove women who had a miscarriage (didn't reach 28 weeks gestation)
	foreach x in 202310051121022012 202310090932029613 202310161057019610 ///
		202310181147019610 202310191151019610 202310261053019610 202310261118021811 ///
		202310271205029611 202310301020019610 202311061043030506 202311081129022012 ///
		202311081052030596 202311151402030504 202311091209031106 202311091213031296 ///
		202311181134030509 202311201039030209 202311211319030396 202311231314031196 /// 
		202311281116029611 202311281151022012 202311281442030596 202312151215032417 ///
		202312032004030109 202312051118022012 202312061202030596 202312061025022513 ///
		202312071015022012 202312071041031296 202312071136022020 202312081156022813 ///
		202312081222030515 202312101227031504 202312081224019618 202312091319030616 ///
		202312121131030616 202312131233031106 202312131250022813 202312131146030109 ///
		202312151223031414 202312191140022012 202312191120022012 202312211200013910 ///
		202312211118013910 202312221123030504 202312261248022012 202312271028013910 ///
		202312271315023411 202312291126022513 202401041156013910 202401051301030515 ///
		202401091136013910 202401251047023311 202312191114019619 202401311300030917 ///
		202402041242032417 202402131223019613  202402151234030515 202312081224019618 /// 
		202405171305031117 {
			drop if respondentid=="`x'"
		}
*-------------------------------------------------------------------------------
	* Number of follow up surveys
	
	   /* Put the m2 date to missing for any survey round where
	     the woman has delivered or lost pregnancy since 
	     they will move to Module 3 and the rest of the M2 survey is blank */
	forval i = 1/10 { 
		replace m2_date_r`i' =. if m2_202_r`i'==2 | m2_202_r`i'==3 
		}
	
	egen totalfu=rownonmiss(m1_date m2_date_r* m3_date) // total surveys until M3

*-------------------------------------------------------------------------------		
	* Time between follow-up surveys
		gen time_m2_r1_m1= (m2_date_r1-m1_date)/7 // time in weeks bw 1st m2 and m1
		gen time_m2_r2_m2_r1 = (m2_date_r2-m2_date_r1)/7 // time bw 2nd m2 and 1st m2
		gen time_m2_r3_m2_r2 = (m2_date_r3-m2_date_r2)/7
		gen time_m2_r4_m2_r3 = (m2_date_r4-m2_date_r3)/7
		gen time_m2_r5_m2_r4 = (m2_date_r5-m2_date_r4)/7
		gen time_m2_r6_m2_r5 = (m2_date_r6-m2_date_r5)/7
		gen time_m2_r7_m2_r6 = (m2_date_r7-m2_date_r6)/7
		gen time_m2_r8_m2_r7 = (m2_date_r8-m2_date_r7)/7
		gen time_m2_r9_m2_r8 = (m2_date_r9-m2_date_r8)/7
		gen time_m2_r10_m2_r9 = (m2_date_r10-m2_date_r9)/7
	* Number of M2 surveys conducted
		egen countm2=rownonmiss(m2_date_r*)
		gen m2_date_last= m2_date_r1 if countm2==1
		replace m2_date_last= m2_date_r2 if countm2==2
		replace m2_date_last= m2_date_r3 if countm2==3
		replace m2_date_last= m2_date_r4 if countm2==4
		replace m2_date_last= m2_date_r5 if countm2==5
		replace m2_date_last= m2_date_r6 if countm2==6
		replace m2_date_last= m2_date_r7 if countm2==7
		replace m2_date_last= m2_date_r8 if countm2==8
		replace m2_date_last= m2_date_r9 if countm2==9
		replace m2_date_last= m2_date_r10 if countm2==10
		replace m2_date_last=m1_date if countm2==0
		format m2_date_last %td
		gen time_m2_last_m3 = (m3_date - m2_date_last)/7 // time bw last m2 and m3

		* Create tag for any time bw follow up surveys > 13.5 weeks (a whole trimester missed)
		forval i = 1/10 {
			gen tag`i'=1 if time_m2_r`i'_>13.5 & time_m2_r`i'_ <.
			count if tag`i'==1
			}	
		gen tag11 = 1 if time_m2_last_m3 >13.5 & time_m2_last_m3<.
		egen anygap=rowmax(tag*)
	*brow m1_date m2_date_r* m3_date tag*
	
*-------------------------------------------------------------------------------	
	* RECALCULATING BASELINE GA and RUNNING GA
	* Baseline GA 
			rename m3_302 m3_birth_or_ended
			gen bslga=m1_ga
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+m1_ga
			// 10% have gestation > 42 wks
			drop ga_endpreg	
	* Recalculating baseline and running GA based on DOB for those with live births
	* and no LBW babies.
		gen bslga2 = 40-((m3_birth_or_ended-m1_date)/7)
		egen alive=rowmin(m3_303_b*  ) // any baby died
			replace bslga2=. if alive==0
		/*recode m3_baby1_weight min/2.4999=1 2.5/max=0
		recode m3_baby2_weight min/2.4999=1 2.5/max=0 
		egen lbw=rowmax(m3_baby1_weight m3_baby2_weight )
			replace bslga2=. if lbw==1 */
			replace bslga2=. if m3_307_b1==4 | m3_307_b1==5 | m3_307_b2==4 | m3_307_b2==5 
			replace bslga2=. if bslga2<0
			replace bslga= bslga2 if bslga2!=. 
			gen ga_endpreg= ((m3_birth_or_ended-m1_date)/7)+bslga 
			recode ga_endpreg (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), g(endtrimes)
	* Recalculating running GA and running trimester 
		drop m2_ga_r1  m2_ga_r2 m2_ga_r3 m2_ga_r4 m2_ga_r5 m2_ga_r6 m2_ga_r7 ///
		m2_ga_r8 m2_ga_r9 m2_ga_r10
		forval i=1/10 {
			gen m2_ga_r`i' = ((m2_date_r`i'-m1_date)/7) +bslga
			gen m2_trimes_r`i'=m2_ga_r`i'
			recode m2_trimes_r`i' (1/12.99999 = 1) (13/27.99999= 2) (28/max=3)
			lab var m2_trimes_r`i' "Trimester of pregnancy at follow up"
			}
	* Baseline trimester
	recode bslga (1/12.99999 = 1) (13/27.99999= 2) (28/max=3), gen(bsltrimester)
			lab def trim 1"1st trimester 0-12wks" 2"2nd trimester 13-27 wks" ///
			3 "3rd trimester 28-42 wks"
					lab val bsltrimester trim
					lab val m2_trimes_r* trim
					lab var bsltrimester "Trimester at ANC initiation/enrollment"	
					
*-------------------------------------------------------------------------------		
	* Total number of ROUTINE ANC visits
		egen totvisits=rowtotal(m2_305_r* m2_308_r* m2_311_r* m2_314_r* m2_317_r* ///
							m3_403 m3_406 m3_409)
		replace totvisits = totvisits + 1 
		recode totvisit 3=2 4/7=3 8/max=4 , gen(viscat)
			lab def totvis 1"Only 1 visit" 2"2-3 visits" 3"4-7 visits" 4"8+ visits"
			lab val viscat totvis 
			lab var totvisits "Total routine ANC visits"
			lab var viscat "Total number of routine ANC visits (categories)"
		
		* Number of routine ANC or ANC referral visits  at each follow-up call
		forval i= 1/10 {
			egen ranc`i'=rowtotal(m2_305_r`i' m2_306_r`i' m2_308_r`i' m2_309_r`i' ///
					m2_311_r`i' m2_312_r`i' m2_314_r`i' m2_315_r`i'  ///
					m2_317_r`i' m2_318_r`i' ), m
		}
			egen ranclast=rowtotal(m3_403 m3_404 m3_406 m3_407 m3_409 m3_410)
		
		egen totvisref=rowtotal(ranc*)
		replace totvisref=totvisref+1
		
		* Ever visited hospital during pregnancy (for any reason)
		recode  facility_lvl 2=1 1=0, g(anc1hosp) // had 1st ANC at hospital
		
		forval i= 1/10 {
			recode m2_303a_r`i' (3 4 5 7 8 34 35= 1) (2 6 31/33= 0) , g(vis1hosp_r`i')
			recode m2_303b_r`i' (3 4 5 7 8 34 35= 1) (2 6 31/33= 0), g(vis2hosp_r`i')
			recode m2_303c_r`i' (3 4 5 7 8 34 35= 1) (2 6 31/33= 0), g(vis3hosp_r`i')
			recode m2_303d_r`i' (3 4 5 7 8 34 35= 1) (2 6 31/33= 0), g(vis4hosp_r`i')
			recode m2_303e_r`i' (3 4 5 7 8 34 35= 1) (2 6 31/33= 0) , g(vis5hosp_r`i')
			} 
		
		egen anyhosp=rowmax(anc1hosp vis*hosp_r* )
		lab var anyhosp "Ever visited hospital during pregnancy (for any reason)"

*-------------------------------------------------------------------------------		
	* ANC QUALITY MEASURES
	
		* First visit
			rename (m1_700 m1_701 m1_703  m1_705 m1_712 m1_716a m1_716b m1_716c ///
			m1_716e m1_801 m1_806 m1_809 m1_724a) (anc1_bp anc1_weight anc1_muac ///
			anc1_urine anc1_ultrasound anc1_nutri anc1_exer anc1_anxi ///
			anc1_dangers anc1_edd anc1_lmp anc1_bplan anc1_return)
			
			egen anc1_bmi= rowtotal(anc1_weight m1_702)
			recode anc1_bmi 1=0 2=1
			egen anc1_blood=rowmax(m1_706 m1_707)
			recode m1_713a 2=1 3=0, g(anc1_ifa)
			recode  m1_713b 2=1 3=0, g(anc1_calcium)
			egen anc1_refer=rowmax(m1_724c m1_724e) // told to see ob or gyn or hospital for anc
			
		* Follow up visits
			rename (m2_501a_r1 m2_501a_r2 m2_501a_r3 m2_501a_r4 m2_501a_r5 ///
					m2_501a_r6 m2_501a_r7 m2_501a_r8 m2_501a_r9 m2_501a_r10 ///
					m3_412_a) (m2_bp_r1 m2_bp_r2 m2_bp_r3 m2_bp_r4 m2_bp_r5 ///
					m2_bp_r6 m2_bp_r7 m2_bp_r8 m2_bp_r9 m2_bp_r10 m3_bp)
			
			rename (m2_501b_r1 m2_501b_r2 m2_501b_r3 m2_501b_r4 m2_501b_r5 ///
					m2_501b_r6 m2_501b_r7 m2_501b_r8 m2_501b_r9 m2_501b_r10 ///
					m3_412_b) (m2_wgt_r1 m2_wgt_r2 m2_wgt_r3 m2_wgt_r4 ///
					m2_wgt_r5 m2_wgt_r6 m2_wgt_r7 m2_wgt_r8 m2_wgt_r9 m2_wgt_r10 ///
					m3_wgt)
			
			foreach r in r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 {
				egen m2_blood_`r'=rowmax(m2_501c_`r' m2_501d_`r')
				egen m2_refer_`r'=rowmax(m2_509a_`r' m2_509b_`r')
				}	
				egen m3_blood=rowmax(m3_412_c m3_412_d)
				
			rename (m2_501e_r1 m2_501e_r2 m2_501e_r3 m2_501e_r4 m2_501e_r5 ///
					m2_501e_r6 m2_501e_r7 m2_501e_r8 m2_501e_r9 m2_501e_r10 ///
					m3_412_e) (m2_urine_r1 m2_urine_r2 m2_urine_r3 m2_urine_r4 ///
					m2_urine_r5 m2_urine_r6 m2_urine_r7 m2_urine_r8 m2_urine_r9 ///
					m2_urine_r10 m3_urine)
			
			rename 	(m2_501f_r1 m2_501f_r2 m2_501f_r3 m2_501f_r4 m2_501f_r5 ///
					m2_501f_r6 m2_501f_r7 m2_501f_r8 m2_501f_r9 m2_501f_r10 ///
					m3_412_f) (m2_us_r1 m2_us_r2 m2_us_r3 m2_us_r4 m2_us_r5 ///
					m2_us_r6 m2_us_r7 m2_us_r8 m2_us_r9 m2_us_r10 m3_us)
					
			rename (m2_506a_r1 m2_506a_r2 m2_506a_r3 m2_506a_r4 m2_506a_r5 ///
					m2_506a_r6 m2_506a_r7 m2_506a_r8 m2_506a_r9 m2_506a_r10) ///
					(m2_danger_r1 m2_danger_r2 m2_danger_r3 m2_danger_r4 ///
					m2_danger_r5 m2_danger_r6 m2_danger_r7 m2_danger_r8 ///
					m2_danger_r9 m2_danger_r10)
			
			rename (m2_506b_r1 m2_506b_r2 m2_506b_r3 m2_506b_r4 m2_506b_r5 ///
					m2_506b_r6 m2_506b_r7 m2_506b_r8 m2_506b_r9 m2_506b_r10 ) ///
					(m2_bplan_r1 m2_bplan_r2 m2_bplan_r3 m2_bplan_r4 ///
					m2_bplan_r5 m2_bplan_r6 m2_bplan_r7 m2_bplan_r8 m2_bplan_r9 ///
					m2_bplan_r10)
					
			rename (m2_601a_r1 m2_601a_r2 m2_601a_r3 m2_601a_r4 m2_601a_r5 ///
					m2_601a_r6 m2_601a_r7 m2_601a_r8 m2_601a_r9 m2_601a_r10) ///
					(m2_ifa_r1 m2_ifa_r2 m2_ifa_r3 m2_ifa_r4 m2_ifa_r5 ///
					m2_ifa_r6 m2_ifa_r7 m2_ifa_r8 m2_ifa_r9 m2_ifa_r10)
			
			rename (m2_601b_r1 m2_601b_r2 m2_601b_r3 m2_601b_r4 m2_601b_r5 ///
					m2_601b_r6 m2_601b_r7 m2_601b_r8 m2_601b_r9 m2_601b_r10) ///
					(m2_calcium_r1 m2_calcium_r2 m2_calcium_r3 m2_calcium_r4 ///
					m2_calcium_r5 m2_calcium_r6 m2_calcium_r7 m2_calcium_r8 ///
					m2_calcium_r9 m2_calcium_r10)
		
*-------------------------------------------------------------------------------		
		* MINIMUM SET OF ANC ITEMS	
			* At least 3 BP checks
			egen totalbp=rowtotal(anc1_bp m2_bp_r* m3_bp*)
				recode totalbp 1/2=0 3/max=1, gen(bpthree)

			* At least 3 wgts
			egen totalweight=rowtotal(anc1_weight m2_wgt_r* m3_wgt*)
				recode totalweight 1/2=0 3/max=1, gen(wgtthree)
				
			* At least 3 blood tests
			egen totalblood=rowtotal(anc1_blood m2_blood_r* m3_blood*)
				recode totalblood 1/2=0 3/max=1, gen(bloodthree)
				
			* At least 3 urine tests
			egen totalurine=rowtotal(anc1_urine m2_urine_r* m3_urine*)
				recode totalurine 1/2=0 3/max=1, gen(urinethree)

			egen all4= rowmin (bpthree wgtthree bloodthree urinethree )
*-------------------------------------------------------------------------------
		* Optimal ANC
			recode totalbp 1/max=1, g(bp1)
			recode totalbp 1=0 2/max=1, g(bp2)
			recode totalbp 1/2=0 3/max=1, g(bp3)
			
			recode totalweight 1/max=1, g(wgt1)
			recode totalweight 1=0 2/max=1, g(wgt2)
			recode totalweight 1/2=0 3/max=1, g(wgt3)
			
			recode totalblood 1/max=1, g(blood1)
			recode totalblood 1=0 2/max=1, g(blood2)
			recode totalblood 1/2=0 3/max=1, g(blood3)
			
			recode totalurine 1/max=1, g(urine1)
			recode totalurine 1=0 2/max=1, g(urine2)
			recode totalurine 1/2=0 3/max=1, g(urine3)
			
			egen totalifa=rowtotal(anc1_ifa m2_ifa_r*)
			recode totalifa 1/max=1, g(ifa1)
			recode totalifa 1=0 2/max=1, g(ifa2)
			
			egen atleast1ultra =rowmax(anc1_ultrasound m2_us_r* m3_us)
			egen atleast1danger =rowmax(anc1_danger m2_danger_r* )
			egen atleast1bplan=rowmax(anc1_bplan m2_bplan_r*)
			
			egen optanc_1st =rowmin(bp3 wgt3 blood3 urine3 atleast1ultra ///
					atleast1danger atleast1bplan ifa2) if bsltrimester==1
			egen optanc_2nd=rowmin(bp2 wgt2 blood2 urine2 atleast1ultra ///
					atleast1danger atleast1bplan ifa1) if bsltrimester==2
			egen optanc_3rd=rowmin(bp1 wgt1 blood1 urine1 atleast1ultra ///
					atleast1danger atleast1bplan) if bsltrimester==3
			
			egen optanc= rowmax(optanc*)
		
		* Minimally adequate ANC
			egen maanc_1st =rowmin(bp1 wgt1 blood1 urine1 atleast1ultra ///
					atleast1danger  ifa1) if bsltrimester==1
			egen maanc_2nd =rowmin(bp1 wgt1 blood1 urine1 atleast1ultra ///
					atleast1danger  ifa1) if bsltrimester==2		
			egen maanc_3rd =rowmin(bp1 wgt1 blood1 urine1 atleast1ultra ///
					atleast1danger )	if bsltrimester==3
					
			egen maanc= rowmax(maanc*)
*-------------------------------------------------------------------------------		
	* REFERRED AT LEAST ONCE
		egen ever_refer=rowmax(anc1_refer m2_refer_r*)
					
*-------------------------------------------------------------------------------		
		* TOTAL ANC SCORE
			recode totalbp 4/max=4, g(maxbp4)
			recode totalweight 4/max=4, g(maxwgt4)
			recode totalurine 4/max=4, g(maxurine4)
			recode totalblood 4/max=4, g(maxblood4)
			egen totalus =rowtotal(anc1_ultrasound m2_us_r* m3_us)
				recode totalus 4/max=4, g(maxus4)
				recode totalus 1/max=1, g(anyus)
			egen totaldanger=rowtotal(anc1_dangers m2_danger_r*) 
				recode totaldanger 4/max=4, g(maxdanger4)
			egen totalbplan= rowtotal(anc1_bplan m2_bplan_r*)
				recode totalbplan 4/max=4, g(maxbplan4)
				recode totalifa 4/max=4, g(maxifa4)
			egen totalcalcium = rowtotal(anc1_calcium m2_calcium_r*)
				recode totalcalcium 4/max=4, g(maxcalc4)
			egen deworm=rowmax(anc1deworm m2_601e_r*)
			
			egen anctotal=rowtotal(maxbp4 maxwgt4 anc1_bmi anc1_muac maxurine4 maxblood4 ///
						maxus4 anc1_anxi anc1_lmp anc1_nutri anc1_exer maxdanger4 anc1_edd ///
						maxbplan4 maxifa4 maxcalc4 deworm)
*-------------------------------------------------------------------------------		
		* TIMELY ANC
		cd "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/"
		egen hivtest= rowmax (m1_708a m1_709a) // at M1 an hiv test or viral load test (if already HIV+)
		forval i= 1/10 {
			egen m2hiv`i' = rowmax(m2_503b_r`i' m2_503c_r`i')
			}
			
		* Recommended items for first visits in first trimester
			egen anc1first=rowmean(anc1_lmp anc1_edd anc1_dangers anc1_bplan ///
					anc1_nutri anc1_ifa anc1_bp anc1_weight m1_702 anc1_muac ///
					anc1_blood  anc1_urine m1_711a  hivtest  m1_710a ///
					anc1_ultrasound   anc1tt) ///
					if bsltrimest==1 
					
		* Recommended items for first visits in 2nd trimester
			egen anc1second=rowmean(anc1_lmp anc1_edd anc1_dangers anc1_bplan ///
					anc1_nutri anc1_ifa anc1_calcium anc1_bp anc1_weight m1_702 anc1_muac ///
					anc1_blood  anc1_urine m1_711a  hivtest  m1_710a m1_704 ///
					anc1_ultrasound anc1tt) ///
					if bsltrimest==2
					
		* Recommended items for first visits in 3rd trimester
			egen anc1third=rowmean(anc1_lmp anc1_edd anc1_dangers anc1_bplan ///
					anc1_nutri anc1_ifa anc1_calcium anc1_bp anc1_weight m1_702 anc1_muac ///
					anc1_blood  anc1_urine m1_711a  hivtest  m1_710a m1_704 ///
					anc1tt) ///
					if bsltrimest==3
		preserve
			keep respondentid anc1first anc1second anc1third anygap
			save timelyancin.dta, replace
		restore 
		
		
		*Recommended items for follow-up anc visits in first trimester
			preserve
					forval i=1/10 {
						replace m2_danger_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_bplan_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_ifa_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_bp_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_wgt_r`i' = . if m2_trimes_r`i'!=1 
						replace m2_blood_r`i' = . if m2_trimes_r`i'!=1  
						replace m2_urine_r`i' = . if m2_trimes_r`i'!=1  
						replace m2_503e_r`i' = . if m2_trimes_r`i'!=1  
						replace m2hiv`i' = . if m2_trimes_r`i'!=1 
						replace m2_503d_r`i' = . if m2_trimes_r`i'!=1  
						replace m2_us_r`i' = . if m2_trimes_r`i'!=1 
					}
					
					egen ancfufirst=rowmean(m2_danger_r* m2_bplan_r* m2_ifa_r* m2_bp_r* ///
							m2_wgt_r* m2_blood_r* m2_urine_r* m2_503e_r* m2hiv* m2_503d_r* m2_us_r*)
					
					keep respondentid ancfufirst 
					merge 1:1 respondentid using timelyancin.dta
					drop _merge
					save timelyancin.dta, replace
			restore
			
		*Recommended items for follow-up anc visits in 2nd trimester
			preserve
					forval i=1/10 {
						replace m2_danger_r`i' = . if m2_trimes_r`i'!=2
						replace m2_bplan_r`i' = . if m2_trimes_r`i'!=2
						replace m2_ifa_r`i' = . if m2_trimes_r`i'!=2
						replace m2_calcium_r`i' = . if m2_trimes_r`i'!=2
						replace m2_bp_r`i' = . if m2_trimes_r`i'!=2
						replace m2_wgt_r`i' = . if m2_trimes_r`i'!=2 
						replace m2_blood_r`i' = . if m2_trimes_r`i'!=2  
						replace m2_urine_r`i' = . if m2_trimes_r`i'!=2  
						replace m2_503e_r`i' = . if m2_trimes_r`i'!=2 
						replace m2hiv`i' = . if m2_trimes_r`i'!=2
						replace m2_503d_r`i' = . if m2_trimes_r`i'!=2  
						replace m2_us_r`i' = . if m2_trimes_r`i'!=2
						replace m2_601e_r`i' = . if m2_trimes_r`i'!=2
					}
					
					egen ancfusecond=rowmean(m2_danger_r* m2_bplan_r* m2_ifa_r* ///
							m2_calcium_r* m2_bp_r* m2_wgt_r* m2_blood_r* ///
							m2_urine_r* m2_503e_r* m2hiv* m2_503d_r* ///
							m2_us_r* m2_601e_r*)
					
					keep respondentid ancfusecond
					merge 1:1 respondentid using timelyancin.dta
					drop _merge
					save timelyancin.dta, replace
			restore
			
		*Recommended items for follow-up anc visits in 3rd trimester
			preserve
					forval i=1/10 {
						replace m2_danger_r`i' = . if m2_trimes_r`i'!=3
						replace m2_bplan_r`i' = . if m2_trimes_r`i'!=3
						replace m2_ifa_r`i' = . if m2_trimes_r`i'!=3
						replace m2_calcium_r`i' = . if m2_trimes_r`i'!=3
						replace m2_bp_r`i' = . if m2_trimes_r`i'!=3
						replace m2_wgt_r`i' = . if m2_trimes_r`i'!=3 
						replace m2_blood_r`i' = . if m2_trimes_r`i'!=3  
						replace m2_urine_r`i' = . if m2_trimes_r`i'!=3  
						replace m2_503e_r`i' = . if m2_trimes_r`i'!=3
						replace m2hiv`i' = . if m2_trimes_r`i'!=3
						replace m2_503d_r`i' = . if m2_trimes_r`i'!=3  
						replace m2_601e_r`i' = . if m2_trimes_r`i'!=3
					}
					
					egen ancfuthird=rowmean(m2_danger_r* m2_bplan_r* m2_ifa_r* ///
							m2_calcium_r* m2_bp_r* m3_bp m2_wgt_r* m3_wgt ///
							m2_blood_r* m3_blood m2_urine_r* m3_urine ///
							m2_503e_r* m2hiv* m2_503d_r* ///
							m2_601e_r*)
							
					keep respondentid ancfuthird country bsltrimester
					merge 1:1 respondentid using timelyancin.dta
					drop _merge
					save timelyancin.dta, replace
			restore
*-------------------------------------------------------------------------------		
		* TIMELY ULTRASOUND
			g tanc1_ultrasound=anc1_ultrasound
			replace tanc1_ultrasound=. if bslga>24 & bslga<.
			forval i=1/10 {
				g tm2_us_r`i' = m2_us_r`i'
				replace tm2_us_r`i'=. if m2_ga_r`i'>24 & m2_ga_r`i'<.
			}
			egen timelyus=rowmax(tanc1_ultrasound tm2_us_r*)
	
*-------------------------------------------------------------------------------		
	* DEMOGRAPHICS AND RISK FACTORS
		* Demographics
			rename m1_enrollage enrollage
			recode enrollage (min/19=1 "<20") (20/34=2 "20-34") (35/max=3 "35+"), g(agecat)
			recode enrollage (min/19=1) (20/max=0), g(age19)
			recode enrollage (min/34=0) (35/max=1), g(age35)
			// educ_cat  quintile  marriedp
			gen healthlit_corr=m1_health_lit==4
			g second= educ_cat>=3 & educ_cat<.
			rename  facility_lvl factype
		* Experienced danger signs in pregnancy
			egen danger=rowmax(m1_814b m1_814c m1_814f m1_814g m2_203b_r* ///
				m2_203c_r* m2_203f_r* m2_203g_r*) 
				// vaginal bleeding, fever, convulsions, seizures, fainting or LOC
			recode m1_506 1/3=1 6=2 96=1 7=3 8/9=1 10=4, g(job)
				lab def job 1"Employed" 2"Homemaker" 3"Student" 4"Unemployed"
				lab val job job 
		* Risk factors
			*Anemia
			egen anemia= rowmax(m1_1307 m1_1309)
			recode anemia 0/10.99999=1 11/30=0
			lab def anemia 1 "Anemia (Hb<11g/dl)" 0 "Normal"
			lab val anemia anemia
			
			* Chronic illnesses
			egen chronic = rowtotal(m1_202a m1_202b m1_202c m1_202d m1_202e m1_203)
			lab var chronic "Number of chronic illnesses"
			
			* Malnutrition
			rename low_BMI malnut
			
			* Previous obstetric complications
			gen multiple= m1_805 >1 &  m1_805<.
			gen cesa= m1_1007==1
			gen neodeath = m1_1010 ==1
			gen preterm = m1_1005 ==1
			gen PPH=m1_1006==1
			rename m1_1004 late_misc
			egen complic = rowtotal(cesa stillbirth preterm neodeath PPH late_misc)

			egen riskcat=rowtotal(anemia chronic malnut complic age19 age35 )
			recode riskcat 3/max=2 
			lab def riskcat 0"No risk factor" 1"One risk factor" 2"Two or more risk factors" 
			lab val riskcat riskcat
			
			
save "$user/MNH E-Cohorts-internal/Analyses/Manuscripts/Paper 5 Continuum ANC/Data/INtmp.dta", replace		
	
	
	
	
	
	
	
	
	
	
	
	
	