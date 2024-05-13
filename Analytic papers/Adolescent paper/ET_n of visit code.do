* Code to calculate N of ANC visits from M1 to M3 
* created by Wen-Chien Yang on May 9 2024 

clear all 

** read data 
cd "C:/Users/wench/Desktop/eCohort study/4. studies/continuity of ANC/variable construct" // (NOte: Please adjust the path as needed)
use eco_m1-m3_et_wide_der.dta, replace 

** I. create new var gen m1_n_anc to indicate M1 (first ANC) for all participants 
	 gen m1_n_anc = 1 
	 lab var m1_n_anc "Number of ANC visits in M1"
   
** II. create new var m2_n_anc to calcuate total n of visits between M1 and M2  
     * create n_anc_r1 to calculate the n of visits in M2 round 1 
     egen n_anc_r1=rowtotal(m2_305_r1 m2_306_r1  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r1 m2_309_r1  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r1 m2_312_r1  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r1 m2_315_r1  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r1 m2_318_r1) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r1 "Number of ANC visits in M2 R1"						
							
	 * create n_anc_r2 to calculate the n of visits in M2 round 2 
     egen n_anc_r2=rowtotal(m2_305_r2 m2_306_r2  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r2 m2_309_r2  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r2 m2_312_r2  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r2 m2_315_r2  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r2 m2_318_r2) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r2 "Number of ANC visits in M2 R2"	
	 
	 * create n_anc_r3 to calculate the n of visits in M2 round 3
     egen n_anc_r3=rowtotal(m2_305_r3 m2_306_r3  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r3 m2_309_r3  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r3 m2_312_r3  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r3 m2_315_r3  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r3 m2_318_r3) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r3 "Number of ANC visits in M2 R3"	
							
	 * create n_anc_r4 to calculate the n of visits in M2 round 4 
     egen n_anc_r4=rowtotal(m2_305_r4 m2_306_r4  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r4 m2_309_r4  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r4 m2_312_r4  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r4 m2_315_r4  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r4 m2_318_r4) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r4 "Number of ANC visits in M2 R4"	
							
	 * create n_anc_r5 to calculate the n of visits in M2 round 5 
     egen n_anc_r5=rowtotal(m2_305_r5 m2_306_r5  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r5 m2_309_r5  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r5 m2_312_r5  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r5 m2_315_r5  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r5 m2_318_r5) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r5 "Number of ANC visits in M2 R5"	
							
	 * create n_anc_r6 to calculate the n of visits in M2 round 6 
     egen n_anc_r6=rowtotal(m2_305_r6 m2_306_r6  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r6 m2_309_r6  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r6 m2_312_r6  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r6 m2_315_r6  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r6 m2_318_r6) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r6 "Number of ANC visits in M2 R6"	
							
	 * create n_anc_r7 to calculate the n of visits in M2 round 7 
     egen n_anc_r7=rowtotal(m2_305_r7 m2_306_r7  /// 1st consultation for routine ANC, 1st consultation was referred  
	                        m2_308_r7 m2_309_r7  /// 2nd consultation for routine ANC, 2nd consultation was referred 
                            m2_311_r7 m2_312_r7  /// 3rd consultation for routine ANC, 3rd consultation was referred 
                            m2_314_r7 m2_315_r7  /// 4th consultation for routine ANC, 4th consultation was referred 
                            m2_317_r7 m2_318_r7) // 5th consultation for routine ANC, 5th consultation was referred 
	 lab var n_anc_r7 "Number of ANC visits in M2 R7"	
	 ** NOTE : might use rowtotal for all variables but this allows us to know how many visits in each round 
  
     * create m2_n_anc to sum up r1 to r7
	 egen m2_n_anc=rowtotal(n_anc_r1 n_anc_r2 n_anc_r3 n_anc_r4 n_anc_r5 n_anc_r6 n_anc_r7)
     lab var m2_n_anc "Number of ANC visits in M2"

** III. create new var m3_n_anc to calcuate total n of visits between M2 and M3 
     egen m3_n_anc=rowtotal(m3_consultation_1 m3_consultation_referral_1  /// 1st consultation for routine ANC, 1st consultation was referred  
						    m3_consultation_2 m3_consultation_referral_2  /// 2nd consultation for routine ANC, 1st consultation was referred  
						    m3_consultation_3 m3_consultation_referral_3  /// 3rd consultation for routine ANC, 1st consultation was referred  
						    m3_consultation_4 m3_consultation_referral_4  /// 4th consultation for routine ANC, 1st consultation was referred  
						    m3_consultation_5 m3_consultation_referral_5) // 5th consultation for routine ANC, 1st consultation was referred   
	 lab var m3_n_anc "Number of ANC visits in M3"		
	 
** IV. create new var anc_total to sum up m1_n_anc m2_n_anc m3_n_anc 	 
     egen anc_total= rowtotal (m1_n_anc m2_n_anc m3_n_anc)
	 lab var anc_total "Total number of visits from M1 to M3"
	 