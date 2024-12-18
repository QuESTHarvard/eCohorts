* India ECohort Data Cleaning File 
* Created by S. Sabwa 
* Updated: Feb 13 2023

*------------------------------------------------------------------------------*

* Import Data 
clear all 

*--------------------DATA FILE:
u "$in_data/Module0_02_04_2024.dta", clear 

foreach v of varlist * {
	char `v'[Original_IN_Varname] `v'
	char `v'[Module] 0
}
*u "$in_data/MODULE_0.dta", clear
*use "$in_data/FacilitySurvey_2024_01_20.dta", clear

*------------------------------------------------------------------------------*
	* STEPS: 
		* STEP ONE: RENAME VARIABLES (starts at: line 29)
		* STEP TW0: ADD VALUE LABELS (starts at: )
		* STEP THREE: RECODING MISSING VALUES (starts at: )
		* STEP FOUR: LABELING VARIABLES (starts at: )
		* STEP FIVE: ORDER VARIABLES (starts at: )
		* STEP SIX: SAVE DATA

*------------------------------------------------------------------------------*

*drop Consent SubmissionDate addcomment instanceID instanceName formdef_version KEY review_quality review_comments review_corrections calc_time_0 start

	* STEP ONE: RENAME VARIABLES
	
rename (end duration) (m0_end_datetime m0_duration)	

*A2_other not in the dataset	
rename (A1 calc_start_time calc_time_1 A4 A5 A7 A2 A3) (m0_a1_date m0_start_datetime m0_a1_time m0_a4_site m0_a4_region m0_id m0_facility m0_facility_in)
	
*A9, A11 (facility ownership) not in dataset
rename (A10 A12 A16 A17) (m0_facility_type m0_urban m0_a13 m0_a14)
	
rename (Q101_a Q101_b Q101_c Q101_d Q101_e) (m0_101a m0_101b m0_101c m0_101d m0_101e_in)	

rename (Q102_a Q102_b Q102_c Q102_d Q102_e) (m0_102a m0_102b m0_102c m0_102d m0_102e_in)

rename (Q103_a Q103_b Q103_c Q103_d Q103_e Q104_a Q104_b Q104_c Q104_d Q104_e) (m0_103a m0_103b m0_103c m0_103d m0_103e_in m0_104a m0_104b m0_104c m0_104d m0_104e_in)

rename (Q105_a Q105_b Q105_c Q105_d Q105_e) (m0_105a m0_105b m0_105c m0_105d m0_105e_in)

rename (Q106_a Q106_b  Q106_c Q106_d  Q106_e) (m0_106a m0_106b m0_106c m0_106d m0_106e_in)

*Q107_a Q107_b, Q107_c, Q107_d, Q107_e, Q111_a not in the dataset

rename (Q108_a Q108_c Q108_d Q108_e Q109_a Q109_c Q109_d Q109_e Q110_a Q110_c Q110_d Q110_e) (m0_108a m0_108c m0_108d m0_108e_in m0_109a m0_109c m0_109d m0_109e_in m0_110a m0_110c m0_110d m0_110e_in)

*Q111_c,Q111_d, Q111_e not in the dataset
rename (Q112_a Q112_c Q112_d Q112_e Q113_a Q113_c Q113_d Q113_e Q114_a Q114_c Q114_d Q114_e) (m0_112a m0_112c m0_112d m0_112e_in m0_113a m0_113c m0_113d m0_113e_in m0_114a m0_114c m0_114d m0_114e_in)

rename (Q115 Q116 Q117 Q118 Q119 Q120 Q121 Q122 Q201) (m0_115 m0_116 m0_117 m0_118 m0_119 m0_120 m0_121 m0_122 m0_201)

rename (Q202_a Q202_b Q204 Q206  Q209_a Q210 Q211 Q209) (m0_202 m0_203 m0_204 m0_205 m0_207 m0_208 m0_209 m0_206)

rename (Q211_other Q212 Q213 Q213_other Q214 Q214_a Q215 Q216  Q218 Q219 Q220 Q217) (m0_209_other m0_210 m0_211 m0_211_other m0_212 m0_213 m0_215 m0_216  m0_218 m0_219 m0_220 m0_217)

rename (Q221 Q222 Q223) (m0_221 m0_222 m0_223)

rename (Q301 Q302 Q302_a Q303 Q304 Q305_a Q305_b Q306 Q307_a Q307_b Q307_c Q307_d Q308) (m0_301 m0_302a_za m0_302b_za m0_303 m0_304 m0_305a m0_305b m0_306 m0_307 m0_307a m0_307b m0_307c m0_308)

rename (Q309 Q310 Q311 Q312 Q313 Q314 Q315_a Q315_b Q315_c Q315_d Q315_e Q315_f Q316 Q317 Q318 Q318_a Q319) (m0_309 m0_310 m0_311 m0_312 m0_313 m0_314 m0_315a m0_315b m0_315c m0_315d m0_315e m0_315f m0_316 m0_317 m0_318 m0_318a_in m0_319)

rename (Q401 Q401_a Q402 Q402_a Q403 Q403_a Q404  Q404_a Q405 Q405_a Q406 Q406_a Q407) (m0_401 m0_401a m0_402 m0_402a m0_403 m0_403a m0_404 m0_404a m0_405 m0_405a m0_406 m0_406a m0_407)

rename (Q408 Q409 Q410 Q411 Q412 Q413 Q414 Q415) (m0_408 m0_409 m0_410 m0_411 m0_412 m0_413 m0_414 m0_415)

*Q419, Q420 not in the dataset
rename (Q416 Q417 Q418) (m0_416 m0_417 m0_418)

rename (Q421 Q422 Q423 Q424 Q425) (m0_421 m0_422 m0_423 m0_424 m0_425)

rename (Q426 Q427 Q428 Q429 Q430 Q431) (m0_426 m0_427 m0_428 m0_429 m0_430 m0_431)

rename (Q432 Q433 Q434 Q435 Q501 Q502 Q503) (m0_432 m0_433 m0_434 m0_435 m0_501 m0_502 m0_503)

rename (Q504 Q505 Q506 Q507 Q508) (m0_504 m0_505 m0_506 m0_507 m0_508)

rename (Q601 Q601_a Q602 Q603 Q604 Q605 Q606) (m0_601 m0_602 m0_603 m0_604 m0_605 m0_606 m0_607)

rename (Q701 Q702 Q703 Q703_other Q704 Q705 Q706 Q707) (m0_701 m0_702 m0_703 m0_703_other m0_704 m0_705 m0_706 m0_707)

rename (Q801_1 Q801_2 Q801_3 Q801_4 Q801_5 Q801_6 Q801_7 Q801_8 Q801_9 Q801_10 Q801_11 Q801_12) (m0_801_jan m0_801_feb m0_801_mar m0_801_apr m0_801_may m0_801_jun m0_801_jul m0_801_aug m0_801_sep m0_801_oct m0_801_nov m0_801_dec)

rename (Q802_1 Q802_2 Q802_3 Q802_4 Q802_5 Q802_6 Q802_7 Q802_8 Q802_9 Q802_10  Q802_11 Q802_12) (m0_802_jan m0_802_feb m0_802_mar m0_802_apr m0_802_may m0_802_jun m0_802_jul m0_802_aug m0_802_sep m0_802_oct m0_802_nov m0_802_dec)

rename (Q803_1 Q803_2 Q803_3 Q803_4 Q803_5 Q803_6 Q803_7 Q803_8 Q803_9 Q803_10 Q803_11 Q803_12) (m0_803_jan m0_803_feb m0_803_mar m0_803_apr m0_803_may m0_803_jun m0_803_jul m0_803_aug m0_803_sep m0_803_oct m0_803_nov m0_803_dec)

rename (Q804_1 Q804_2 Q804_3 Q804_4 Q804_5 Q804_6 Q804_7 Q804_8 Q804_9 Q804_10 Q804_11 Q804_12) (m0_804_jan m0_804_feb m0_804_mar m0_804_apr m0_804_may m0_804_jun m0_804_jul m0_804_aug m0_804_sep m0_804_oct m0_804_nov m0_804_dec)

rename (Q805_1 Q805_2 Q805_3 Q805_4 Q805_5 Q805_6 Q805_7 Q805_8 Q805_9 Q805_10 Q805_11 Q805_12) (m0_805_jan m0_805_feb m0_805_mar m0_805_apr m0_805_may m0_805_jun m0_805_jul m0_805_aug m0_805_sep m0_805_oct m0_805_nov m0_805_dec)

rename (Q806_1 Q806_2 Q806_3 Q806_4 Q806_5 Q806_6 Q806_7 Q806_8 Q806_9 Q806_10 Q806_11 Q806_12) (m0_806_jan m0_806_feb m0_806_mar m0_806_apr m0_806_may m0_806_jun m0_806_jul m0_806_aug m0_806_sep m0_806_oct m0_806_nov m0_806_dec)

rename (Q807_1 Q807_2 Q807_3 Q807_4 Q807_5 Q807_6 Q807_7 Q807_8 Q807_9 Q807_10 Q807_11 Q807_12) (m0_807_jan m0_807_feb m0_807_mar m0_807_apr m0_807_may m0_807_jun m0_807_jul m0_807_aug m0_807_sep m0_807_oct m0_807_nov m0_807_dec)

rename (Q808_1 Q808_2 Q808_3 Q808_4 Q808_5 Q808_6 Q808_7 Q808_8 Q808_9 Q808_10 Q808_11 Q808_12) (m0_808_jan m0_808_feb m0_808_mar m0_808_apr m0_808_may m0_808_jun m0_808_jul m0_808_aug m0_808_sep m0_808_oct m0_808_nov m0_808_dec)

rename (Q809_1 Q809_2 Q809_3 Q809_4 Q809_5 Q809_6 Q809_7 Q809_8 Q809_9 Q809_10 Q809_11 Q809_12) (m0_809_jan m0_809_feb m0_809_mar m0_809_apr m0_809_may m0_809_jun m0_809_jul m0_809_aug m0_809_sep m0_809_oct m0_809_nov m0_809_dec)

rename (Q810_1 Q810_2 Q810_3 Q810_4 Q810_5 Q810_6 Q810_7 Q810_8 Q810_9 Q810_10 Q810_11 Q810_12) (m0_810_jan m0_810_feb m0_810_mar m0_810_apr m0_810_may m0_810_jun m0_810_jul m0_810_aug m0_810_sep m0_810_oct m0_810_nov m0_810_dec)

rename (Q811_1 Q811_2 Q811_3 Q811_4 Q811_5 Q811_6 Q811_7 Q811_8 Q811_9 Q811_10 Q811_11 Q811_12) (m0_811_jan m0_811_feb m0_811_mar m0_811_apr m0_811_may m0_811_jun m0_811_jul m0_811_aug m0_811_sep m0_811_oct m0_811_nov m0_811_dec)

rename (Q812_1 Q812_2 Q812_3 Q812_4 Q812_5 Q812_6 Q812_7 Q812_8 Q812_9 Q812_10 Q812_11 Q812_12) (m0_812_jan m0_812_feb m0_812_mar m0_812_apr m0_812_may m0_812_jun m0_812_jul m0_812_aug m0_812_sep m0_812_oct m0_812_nov m0_812_dec)

rename (Q813_1 Q813_2 Q813_3 Q813_4 Q813_5 Q813_6 Q813_7 Q813_8 Q813_9 Q813_10 Q813_11 Q813_12) (m0_813_jan m0_813_feb m0_813_mar m0_813_apr m0_813_may m0_813_jun m0_813_jul m0_813_aug m0_813_sep m0_813_oct m0_813_nov m0_813_dec)

rename (Q115_1 Q115_2 Q115_4 Q115_5 Q115_6 Q115_7 Q115_8 Q115_0 Q115_3) (m0_115a m0_115b m0_115c m0_115d m0_115e m0_115f m0_115g m0_115h m0_115i)

rename (Q116_1 Q116_2 Q116_4 Q116_5 Q116_6 Q116_7 Q116_8 Q116_0 Q116_3) (m0_116a m0_116b m0_116c m0_116d m0_116e m0_116f m0_116g m0_116h m0_116i)

rename (Q117_1 Q117_2 Q117_4 Q117_5 Q117_6 Q117_7 Q117_8 Q117_0 Q117_3) (m0_117a m0_117b m0_117c m0_117d m0_117e m0_117f m0_117g m0_117h m0_117i)

rename (Q118_1 Q118_2 Q118_4 Q118_5 Q118_6 Q118_7 Q118_8 Q118_0 Q118_3) (m0_118a m0_118b m0_118c m0_118d m0_118e m0_118f m0_118g m0_118h m0_118i)

rename (Q119_1 Q119_2 Q119_4 Q119_5 Q119_6 Q119_7 Q119_8 Q119_0 Q119_3) (m0_119a m0_119b m0_119c m0_119d m0_119e m0_119f m0_119g m0_119h m0_119i)

rename (Q120_1 Q120_2 Q120_4 Q120_5 Q120_6 Q120_7 Q120_8 Q120_0 Q120_3) (m0_120a m0_120b m0_120c m0_120d m0_120e m0_120f m0_120g m0_120h m0_120i)

rename (Q121_1 Q121_2 Q121_4 Q121_5 Q121_6 Q121_7 Q121_8 Q121_0 Q121_3) (m0_121a m0_121b m0_121c m0_121d m0_121e m0_121f m0_121g m0_121h m0_121i)

rename (Q122_1 Q122_2 Q122_4 Q122_5 Q122_6 Q122_7 Q122_8 Q122_0 Q122_3) (m0_122a m0_122b m0_122c m0_122d m0_122e m0_122f m0_122g m0_122h m0_122i)

rename (Q102_Available Q102_Available_1 Q102_Available_2 Q102_Available_3 Q102_Available_4 Q102_Available_5 Q102_Available_6 Q102_Available_7) (m0_102_week m0_102_mon m0_102_tu m0_102_wed m0_102_thu m0_102_fri m0_102_sat m0_102_sun) 

rename (Q103_Available Q103_Available_1 Q103_Available_2 Q103_Available_3 Q103_Available_4 Q103_Available_5 Q103_Available_6 Q103_Available_7) (m0_103_week m0_103_mon m0_103_tu m0_103_wed m0_103_thu m0_103_fri m0_103_sat m0_103_sun)

rename (Q104_Available Q104_Available_1 Q104_Available_2 Q104_Available_3 Q104_Available_4 Q104_Available_5 Q104_Available_6 Q104_Available_7) (m0_104_week m0_104_mon m0_104_tu m0_104_wed m0_104_thu m0_104_fri m0_104_sat m0_104_sun)

rename (Q105_Available Q105_Available_1 Q105_Available_2 Q105_Available_3 Q105_Available_4 Q105_Available_5 Q105_Available_6 Q105_Available_7) (m0_105_week m0_105_mon m0_105_tu m0_105_wed m0_105_thu m0_105_fri m0_105_sat m0_105_sun)

rename (Q106_Available Q106_Available_1 Q106_Available_2 Q106_Available_3 Q106_Available_4 Q106_Available_5 Q106_Available_6 Q106_Available_7) (m0_106_week m0_106_mon m0_106_tu m0_106_wed m0_106_thu m0_106_fri m0_106_sat m0_106_sun)

rename (Q115_a Q115_c Q115_d Q115_e Q116_a Q116_c Q116_d Q116_e Q117_a Q117_c Q117_d Q117_e Q118_a Q118_c Q118_d Q118_e) (m0_ang_a_in m0_ang_c_in m0_ang_d_in m0_ang_e_in m0_mpw_a_in m0_mpw_c_in m0_mpw_d_in m0_mpw_e_in m0_anm_a_in m0_anm_c_in m0_anm_d_in m0_anm_e_in m0_nur_a_in m0_nur_c_in m0_nur_d_in m0_nur_e_in)

rename (Q211_1 Q211_2 Q211_3 Q211_96 Q211_98) (m0_209a m0_209b m0_209c m0_209d m0_209e)

rename (Q502_01 Q502_02 Q502_03 Q502_04 Q502_05 Q502_06 Q502_07 Q502_08 Q502_09 Q502_1 Q502_96 Q502_98 Q502_other) (m0_502a_in m0_502b_in m0_502c_in m0_502d_in m0_502e_in m0_502f_in m0_502g_in m0_502h_in m0_502i_in m0_502j_in m0_502k_in m0_502l_in m0_502_other_in)

rename (Q503_1 Q503_2 Q503_3 Q503_4 Q503_5 Q503_6) (m0_503a m0_503b m0_503c m0_503d m0_503e m0_503f)

	* STEP TWO: ADD VALUE LABELS
	
	recode m0_206 1=0 2=1 3=1
	recode m0_217 1=0 2=1 3=0
	
	* STEP FOUR: LABELING VARIABLES
	

* STEP FIVE: ORDER VARIABLES

order m0_*, sequential
order m0_start_datetime m0_end_datetime m0_a1_date m0_a1_time m0_facility m0_facility_in m0_facility_type m0_a13 m0_a14 m0_a4_site m0_a4_region m0_urban m0_id m0_duration 
order m0_ang_a_in m0_ang_c_in m0_ang_d_in m0_ang_e_in m0_mpw_a_in m0_mpw_c_in m0_mpw_d_in m0_mpw_e_in m0_anm_a_in m0_anm_c_in m0_anm_d_in m0_anm_e_in m0_nur_a_in m0_nur_c_in m0_nur_d_in m0_nur_e_in,after(m0_114e_in)

* STEP THREE: RECODING MISSING VALUES

save "$in_data_final/eco_m0_in.dta", replace




