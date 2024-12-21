
* Bring in the ET M0 dataset
use "${et_data_final}/eco_m0_et", clear


***********************************************
***********************************************

* Create standard label values
label define m0_urban  1 "Urban" 2 "Rural", replace

label define m0_catchment 1 "Yes" 0 "No", replace

label define m0_selected 1 "Selected" 0 "Not selected", replace

label define m0_water 1 "Piped into the facility" 2 "Piped onto facility grounds"  3 "Public taps/stand pipes" 4 "Tube well/ bore hole" 5 "Protected dug well" 6 "Unprotected dug well" 7 "Protected spring" 8 "Unprotected spring" 9 "Rain water" 10 "Bottled water" 11 "Cart/small tank/drum water" 12 "Surface water" 96 "Other", replace

label define m0_onsite 1 "Onsite (within compound)" 2 "Within 500 m of facility" 3 "Beyond 500 m of facility", replace

label define m0_toliet_type 1 "FLUSH TOILET" 2 "VENTILATED IMPROVED PIT LATRINE (VIP)" 3 "PIT LATRINE WITH SLAB" 4 "PIT LATRINE WITHOUT SLAB/OPEN PIT" 5 "COMPOSTING TOILET" 6 "BUCKET" 7 "HANGING TOILET/ HANGING LATRINE" 8 "NO FACILITIES ON PREMISES", replace

label define m0_observed 1 "Observed" 2 "Reported, not seen"  0 "Not available", replace

label define m0_functional 1 "Functional" 2 "Non functional", replace

label define m0_availible_onsite  1 "Yes, onsite" 0 "No", replace

label define m0_available  1 "At least one valid" 2 "Available but expired" 3 "Not available today" 0 "Never available", replace 

label define m0_conducts 1 "Yes, onsite"  2 "Yes, off site" 0 "Don't conduct the test", replace 

label define m0_frequency 0 "Never" 1 "Rarely" 2 "Sometimes" 3 "Usually" 98 "DK", replace

label define m0_guidelines 0 "Does not have" 1 "Has, but not observed" 2 "Has and observed", replace

label define m0_mnh_data 1 "Monthly" 2 "Quarterly" 96 "Other", replace

label define m0_yesno 1 "Yes" 0 "No", replace

***********************************************
***********************************************

* Clean up the dates to be in date format
replace m0_a1_date = subinstr(m0_a1_date,"-","/",.)
replace m0_a1_date = subinstr(m0_a1_date,"/23","/2023",.)

gen m0_date = date(m0_a1_date,"DMY")
replace m0_date = date(m0_a1_date,"YMD") if missing(m0_date)
format %td m0_date
char m0_date[Original_ET_Varname] `m0_a1_date[Original_ET_Varname]'

label var m0_date "M0 Date"

drop m0_a1_date

***********************************************
***********************************************
* Create ET specific value labels
* add value labels and rename m0_a2_site
label define et_region  1 "Addis Ababa" 2 "Afar" 3 "Amhara" 4 "Oromia" 5 "Benshangule" 6 "Tigray" 7 "Oromia" 8 "Somali" 9 "SSNP" 10 "Sidama", replace
label value m0_a2_site et_region

label define et_zone  1 "East shewa" 2 "Adama town", replace
label value m0_a3_subsite et_zone

label define et_woreda 1 "Adama special district (town)" 2 "Dugda" 3 "Bora" 4 "Adami Tulu Jido Kombolcha" 5 "Olenchiti" 6 "Adama" 7 "Lume" 96 "Other", replace
label value m0_a4_woreda_et et_woreda 

label define et_facility 1 "Meki Catholic Primary Clinic" 2 "Bote Health Center" 3 "Meki Health Center" 4 "Adami Tulu Health Center" 5 "Bulbula Health Center" 6 "Dubisa Health Center" 7 "Olenchiti Primary Hospital" 8 "Awash Malkasa Health Center" 9 "koka Health Center" 10 "Biyo Health Center" 11 "Ejersa Health Center" 12 "Catholic Church Primary Clinic" 13 "Noh Primary Clinic" 14 "Adama Health Center" 15 "Family Guidance Nazret Specialty Clinic" 16 "Biftu" 17 "Bokushenen" 18 "Adama Teaching Hospital" 19 "Hawas" 20 "Medhanialem Hospital" 21 "Sister Aklisiya Hospital" 22 "Marie stopes Specialty Clinic" 96 "Other in East Shewa or Adama", replace
label value m0_a5_fac et_facility

***********************************************
***********************************************
* Rename variables appropriately

rename facility m0_facility_name_and_id
rename m0_115a_et m0_115a
rename m0_115b_et m0_115b
rename m0_115c_et m0_115c
rename m0_115d_et m0_115d
rename m0_115e_et m0_115e
rename m0_115f_et m0_115f
rename m0_115g_et m0_115g
rename m0_115h_et m0_115h
rename m0_115i_et m0_115i
rename m0_116a_et m0_116a
rename m0_116b_et m0_116b
rename m0_116c_et m0_116c
rename m0_116d_et m0_116d
rename m0_116e_et m0_116e
rename m0_116f_et m0_116f
rename m0_116g_et m0_116g
rename m0_116h_et m0_116h
rename m0_116i_et m0_116i
rename m0_117a_et m0_117a
rename m0_117b_et m0_117b
rename m0_117c_et m0_117c
rename m0_117d_et m0_117d
rename m0_117e_et m0_117e
rename m0_117f_et m0_117f
rename m0_117g_et m0_117g
rename m0_117h_et m0_117h
rename m0_117i_et m0_117i
rename m0_118a_et m0_118a
rename m0_118b_et m0_118b
rename m0_118c_et m0_118c
rename m0_118d_et m0_118d
rename m0_118e_et m0_118e
rename m0_118f_et m0_118f
rename m0_118g_et m0_118g
rename m0_118h_et m0_118h
rename m0_118i_et m0_118i
rename m0_119a_et m0_119a
rename m0_119b_et m0_119b
rename m0_119c_et m0_119c
rename m0_119d_et m0_119d
rename m0_119e_et m0_119e
rename m0_119f_et m0_119f
rename m0_119g_et m0_119g
rename m0_119h_et m0_119h
rename m0_119i_et m0_119i
rename m0_120a_et m0_120a
rename m0_120b_et m0_120b
rename m0_120c_et m0_120c
rename m0_120d_et m0_120d
rename m0_120e_et m0_120e
rename m0_120f_et m0_120f
rename m0_120g_et m0_120g
rename m0_120h_et m0_120h
rename m0_120i_et m0_120i
rename m0_121a_et m0_121a
rename m0_121b_et m0_121b
rename m0_121c_et m0_121c
rename m0_121d_et m0_121d
rename m0_121e_et m0_121e
rename m0_121f_et m0_121f
rename m0_121g_et m0_121g
rename m0_121h_et m0_121h
rename m0_121i_et m0_121i
rename m0_122a_et m0_122a
rename m0_122b_et m0_122b
rename m0_122c_et m0_122c
rename m0_122d_et m0_122d
rename m0_122e_et m0_122e
rename m0_122f_et m0_122f
rename m0_122g_et m0_122g
rename m0_122h_et m0_122h
rename m0_122i_et m0_122i
rename m0_1a_et m0_108_anc
rename m0_1b_et m0_109_anc
rename m0_1c_et m0_110_anc
rename m0_1d_et m0_111_anc
rename m0_1e_et m0_112_anc
rename m0_1f_et m0_107_anc
rename m0_1g_et m0_101_anc
rename m0_209_dk_et m0_209e
rename m0_209_oth_et m0_209_other
rename m0_209a_et m0_209a
rename m0_209b_et m0_209b
rename m0_209c_et m0_209c
rename m0_209d_et m0_209d
rename m0_211_oth m0_211_other
rename m0_2a_et m0_108_delivery
rename m0_2b_et m0_109_delivery
rename m0_2c_et m0_110_delivery
rename m0_2d_et m0_111_delivery
rename m0_2e_et m0_112_delivery
rename m0_2f_et m0_107_delivery
rename m0_2g_et m0_101_delivery
rename m0_3a_et m0_108_pnc
rename m0_3b_et m0_109_pnc
rename m0_3c_et m0_110_pnc
rename m0_3d_et m0_111_pnc
rename m0_3e_et m0_112_pnc
rename m0_3f_et m0_107_pnc
rename m0_3g_et m0_101_pnc
rename m0_4a_et m0_108_epi_immunization
rename m0_4b_et m0_109_epi_immunization
rename m0_4c_et m0_110_epi_immunization
rename m0_4d_et m0_111_epi_immunization
rename m0_4e_et m0_112_epi_immunization
rename m0_4f_et m0_107_epi_immunization
rename m0_4g_et m0_101_epi_immunization
rename m0_503a_et m0_503a
rename m0_503b_et m0_503b
rename m0_503c_et m0_503c
rename m0_503d_et m0_503d
rename m0_503e_et m0_503e
rename m0_503f_et m0_503f
rename m0_508a_et m0_508a
rename m0_605a m0_606
rename m0_814_apr_et m0_814_apr
rename m0_814_aug_et m0_814_aug
rename m0_814_dec_et m0_814_dec
rename m0_814_feb_et m0_814_feb
rename m0_814_jan_et m0_814_jan
rename m0_814_jul_et m0_814_jul
rename m0_814_jun_et m0_814_jun
rename m0_814_mar_et m0_814_mar
rename m0_814_may_et m0_814_may
rename m0_814_nov_et m0_814_nov
rename m0_814_oct_et m0_814_oct
rename m0_814_sep_et m0_814_sep
rename m0_815_apr_et m0_815_apr
rename m0_815_aug_et m0_815_aug
rename m0_815_dec_et m0_815_dec
rename m0_815_feb_et m0_815_feb
rename m0_815_jan_et m0_815_jan
rename m0_815_jul_et m0_815_jul
rename m0_815_jun_et m0_815_jun
rename m0_815_mar_et m0_815_mar
rename m0_815_may_et m0_815_may
rename m0_815_nov_et m0_815_nov
rename m0_815_oct_et m0_815_oct
rename m0_815_sep_et m0_815_sep
rename m0_a13 m0_catchment
rename m0_a14 m0_catchment_volumn
rename m0_a2_site m0_region
rename m0_a3_subsite m0_zone_subcity
rename m0_a4_woreda_et m0_woreda
rename m0_a4_woreda_et_oth m0_woreda_other
rename m0_a5_fac m0_facility_name
rename m0_a5_fac_oth m0_facility_name_other
rename m0_a6_fac_type mo_facility_type
rename m0_a6a_lat m0_facility_latitude
rename m0_a6b_long m0_facility_longitude
rename m0_a6c_alt m0_facility_altitude
rename m0_a8_fac_own m0_facility_ownership
rename m0_a9_urban m0_urban
rename m0_id m0_interviewer_id
rename nameofdc m0_name_of_dc
rename record_id m0_response_id


*********************************************************
*********************************************************
* Label variables

label var m0_facility_name_and_id "M0 Facility name and ID"
label var m0_101a "Medical doctor: Number currently assigned, employed or seconded"
label var m0_101b "Medical doctor: Number of part time"
label var m0_101c "Medical doctor: Number of vacancies"
label var m0_101d "Medical doctor: Number that provide obstetric and newborn care"
label var m0_102a "Obstetrician/gynecologist: Number of currently assigned, employed or seconded"
label var m0_102b "Obstetrician/gynecologist: Number of part time "
label var m0_102c "Obstetrician/gynecologist: Number of vacancies"
label var m0_102d "Obstetrician/gynecologist: Number that provide obstetric and newborn care"
label var m0_103a "General Surgeon: Number currently assigned, employed or seconded"
label var m0_103b "General Surgeon: Number of part time"
label var m0_103c "General Surgeon: Number of vacancies"
label var m0_103d "General Surgeon: Number that provide obstetric and newborn care"
label var m0_104a "Anesthesiologist: Number currently assigned, employed or seconded"
label var m0_104b "Anesthesiologist: Number of part time"
label var m0_104c "Anesthesiologist: Number of vacancies"
label var m0_104d "Anesthesiologist: Number that provide obstetric and newborn care"
label var m0_105a "Pediatrician: Number currently assigned, employed or seconded"
label var m0_105b "Pediatrician: Number of part time"
label var m0_105c "Pediatrician: Number of vacancies"
label var m0_105d "Pediatrician: Number that provide obstetric and newborn care"
label var m0_106a "Neonatologist: Number currently assigned, employed or seconded"
label var m0_106b "Neonatologist: Number of part time"
label var m0_106c "Neonatologist: Number of vacancies"
label var m0_106d "Neonatologist: Number that provide obstetric and newborn care"
label var m0_107a "Emergency surgical officer: Number currently assigned, employed or seconded"
label var m0_107b "Emergency surgical officer: Number of part time"
label var m0_107c "Emergency surgical officer: Number of vacancies"
label var m0_107d "Emergency surgical officer: Number that provide obstetric and newborn care"
label var m0_108a "Midwife BSc: Number currently assigned, employed or seconded"
label var m0_108b "Midwife BSc: Number of part time"
label var m0_108c "Midwife BSc: Number of vacancies"
label var m0_108d "Midwife BSc: Number that provide obstetric and newborn care"
label var m0_109a "Midwife dipolma: Number currently assigned, employed or seconded"
label var m0_109b "Midwife dipolma: Number of part time"
label var m0_109c "Midwife dipolma: Number of vacancies"
label var m0_109d "Midwife dipolma: Number that provide obstetric and newborn care"
label var m0_110a "Nurse BSc: Number currently assigned, employed or seconded"
label var m0_110b "Nurse BSc: Number of part time"
label var m0_110c "Nurse BSc: Number of vacancies"
label var m0_110d "Nurse BSc: Number that provide obstetric and newborn care"
label var m0_111a "Nurse diploma: Number currently assigned, employed or seconded"
label var m0_111b "Nurse diploma: Number of part time"
label var m0_111c "Nurse diploma: Number of vacancies"
label var m0_111d "Nurse diploma: Number that provide obstetric and newborn care"
label var m0_112a "Health officer: Number currently assigned, employed or seconded"
label var m0_112b "Health officer: Number of part time"
label var m0_112c "Health officer: Number of vacancies"
label var m0_112d "Health officer: Number that provide obstetric and newborn care"
label var m0_113a "Anesthetist: Number currently assigned, employed or seconded"
label var m0_113b "Anesthetist: Number of part time"
label var m0_113c "Anesthetist: Number of vacancies"
label var m0_113d "Anesthetist: Number that provide obstetric and newborn care"
label var m0_114a "Lab technologist/technician: Number currently assigned, employed or seconded"
label var m0_114b "Lab technologist/technician: Number of part time"
label var m0_114c "Lab technologist/technician: Number of vacancies"
label var m0_114d "Lab technologist/technician: Number that provide obstetric and newborn care"
label var m0_115a "Medical Doctor: Physically present Monday-Friday during the day"
label var m0_115b "Specialist (OB/GYN, surgeon, pediatrician): Physically present Monday-Friday during the day"
label var m0_115c "Emergency surgical officer: Physically present Monday-Friday during the day"
label var m0_115d "Health officer: Physically present Monday-Friday during the day"
label var m0_115e "Midwife: Physically present Monday-Friday during the day"
label var m0_115f "Nurse: Physically present Monday-Friday during the day"
label var m0_115g "Anesthesiologist/Anesthetist: Physically present Monday-Friday during the day"
label var m0_115h "Lab technologist/technician: Physically present Monday-Friday during the day"
label var m0_115i "None of the above: Physically present Monday-Friday during the day"
label var m0_116a "Medical Doctor: On call Monday-Friday during the day"
label var m0_116b "Specialist (OB/GYN, surgeon, pediatrician): On call Monday-Friday during the day"
label var m0_116c "Emergency surgical officer: On call Monday-Friday during the day"
label var m0_116d "Health officer: On call Monday-Friday during the day"
label var m0_116e "Midwife: On call Monday-Friday during the day"
label var m0_116f "Nurse: On call Monday-Friday during the day"
label var m0_116g "Anesthesiologist/Anesthetist: On call Monday-Friday during the day"
label var m0_116h "Lab technologist/technician: On call Monday-Friday during the day"
label var m0_116i "None of the above: On call Monday-Friday during the day"
label var m0_117a "Medical Doctor: Physically present Monday-Friday at night"
label var m0_117b "Specialist (OB/GYN, surgeon, pediatrician): Physically present Monday-Friday at night"
label var m0_117c "Emergency surgical officer: Physically present Monday-Friday at night"
label var m0_117d "Health officer: Physically present Monday-Friday at night"
label var m0_117e "Midwife: Physically present Monday-Friday at night"
label var m0_117f "Nurse: Physically present Monday-Friday at night"
label var m0_117g "Anesthesiologist/Anesthetist: Physically present Monday-Friday at night"
label var m0_117h "Lab technologist/technician: Physically present Monday-Friday at night"
label var m0_117i "None of the above: Physically present Monday-Friday at night"
label var m0_118a "Medical Doctor: On call Monday-Friday at night"
label var m0_118b "Specialist (OB/GYN, surgeon, pediatrician): On call Monday-Friday at night"
label var m0_118c "Emergency surgical officer: On call Monday-Friday at night"
label var m0_118d "Health officer: On call Monday-Friday at night"
label var m0_118e "Midwife: On call Monday-Friday at night"
label var m0_118f "Nurse: On call Monday-Friday at night"
label var m0_118g "Anesthesiologist/Anesthetist: On call Monday-Friday at night"
label var m0_118h "Lab technologist/technician: On call Monday-Friday at night"
label var m0_118i "None of the above: On call Monday-Friday at night"
label var m0_119a "Medical Doctor: Physically present Saturday, Sunday and holidays during the day"
label var m0_119b "Specialist (OB/GYN, surgeon, pediatrician): Physically present Saturday, Sunday and holidays during the day"
label var m0_119c "Emergency surgical officer: Physically present Saturday, Sunday and holidays during the day"
label var m0_119d "Health officer: Physically present Saturday, Sunday and holidays during the day"
label var m0_119e "Midwife: Physically present Saturday, Sunday and holidays during the day"
label var m0_119f "Nurse: Physically present Saturday, Sunday and holidays during the day"
label var m0_119g "Anesthesiologist/Anesthetist: Physically present Saturday, Sunday and holidays during the day"
label var m0_119h "Lab technologist/technician: Physically present Saturday, Sunday and holidays during the day"
label var m0_119i "None of the above: Physically present Saturday, Sunday and holidays during the day"
label var m0_120a "Medical Doctor: On call Saturday, Sunday and holidays during the day"
label var m0_120b "Specialist (OB/GYN, surgeon, pediatrician): On call Saturday, Sunday and holidays during the day"
label var m0_120c "Emergency surgical officer: On call Saturday, Sunday and holidays during the day"
label var m0_120d "Health officer: On call Saturday, Sunday and holidays during the day"
label var m0_120e "Midwife: On call Saturday, Sunday and holidays during the day"
label var m0_120f "Nurse: On call Saturday, Sunday and holidays during the day"
label var m0_120g "Anesthesiologist/Anesthetist: On call Saturday, Sunday and holidays during the day"
label var m0_120h "Lab technologist/technician: On call Saturday, Sunday and holidays during the day"
label var m0_120i "None of the above: On call Saturday, Sunday and holidays during the day"
label var m0_121a "Medical Doctor: Physically present Saturday, Sunday and holidays at night"
label var m0_121b "Specialist (OB/GYN, surgeon, pediatrician): Physically present Saturday, Sunday and holidays at night"
label var m0_121c "Emergency surgical officer: Physically present Saturday, Sunday and holidays at night"
label var m0_121d "Health officer: Physically present Saturday, Sunday and holidays at night"
label var m0_121e "Midwife: Physically present Saturday, Sunday and holidays at night"
label var m0_121f "Nurse: Physically present Saturday, Sunday and holidays at night"
label var m0_121g "Anesthesiologist/Anesthetist: Physically present Saturday, Sunday and holidays at night"
label var m0_121h "Lab technologist/technician: Physically present Saturday, Sunday and holidays at night"
label var m0_121i "None of the above: Physically present Saturday, Sunday and holidays at night"
label var m0_122a "Medical Doctor: On call Saturday, Sunday and holidays at night"
label var m0_122b "Specialist (OB/GYN, surgeon, pediatrician): On call Saturday, Sunday and holidays at night"
label var m0_122c "Emergency surgical officer: On call Saturday, Sunday and holidays at night"
label var m0_122d "Health officer: On call Saturday, Sunday and holidays at night"
label var m0_122e "Midwife: On call Saturday, Sunday and holidays at night"
label var m0_122f "Nurse: On call Saturday, Sunday and holidays at night"
label var m0_122g "Anesthesiologist/Anesthetist: On call Saturday, Sunday and holidays at night"
label var m0_122h "Lab technologist/technician: On call Saturday, Sunday and holidays at night"
label var m0_122i "None of the above: On call Saturday, Sunday and holidays at night"
label var m0_108_anc "Midwife BSc: Number currently providing ANC services"
label var m0_109_anc "Midwife diploma: Number currently providing ANC services"
label var m0_110_anc "Nurse BSc: Number currently providing ANC services"
label var m0_111_anc "Nurse diploma: Number currently providing ANC services"
label var m0_112_anc "Health officer: Number currently providing ANC services"
label var m0_107_anc "Emergency surgical officer: Number currently providing ANC services"
label var m0_101_anc "General practitioner: Number currently providing ANC services"
label var m0_201 "Number of beds available for patients in facility"
label var m0_202a "Number of beds dedicated exclusively for: OBGYN patients (ANC/postpartum/post-op)"
label var m0_202b "Number of beds dedicated exclusively for: Patients in 1st/2nd stage of labor"
label var m0_204 "Facility has separate space for women to labor"
label var m0_205 "Facility has separate space for women to recover post-delivery"
label var m0_206 "Facility connected to national electrical grid"
label var m0_207 "Over last 7 days: Has the power from the grid/other source been interrupted for more than 2hrs at a time?"
label var m0_208 "Facility has other sources of electricity (generator/solor system)"
label var m0_209e "Sources of electricity: Don't know"
label var m0_209_other "Sources of electricity: Other source specified"
label var m0_209a "Source of electricity: Fuel operated generator"
label var m0_209b "Source of electricity: Battery operated generator"
label var m0_209c "Source of electricity: Soloar system"
label var m0_209d "Sources of electricity: Other source"
label var m0_210 "Facility has water for it's basic functions"
label var m0_211 "Most commonly used source of water for the facility at this time"
label var m0_211_other "Most commonly used source of water for the facility at this time: Other specified"
label var m0_212 "Water source onsite (within 500 meters of facility, or beyond 500 meters)"
label var m0_213 "Is there a time of the year when the facility routinely has a severe shortage or lack of water"
label var m0_214 "Toliet (latrine) on the premises that is accessible for patient use"
label var m0_215 "Toliet (latrine) type"
label var m0_216 "Functioning land line telephone that is available to call outside at all times client services are offered (offers 24hr emergency services)"
label var m0_217 "Functioning cellular telephone or a private cellular phone that is supported by the facility"
label var m0_218 "Functioning short-wave radio for radio calls"
label var m0_219 "Functioning computer"
label var m0_220 "Access to email or internet today"
label var m0_221 "Functional ambulance or other vehicle for emergencies"
label var m0_222 "Number of ambulances startioned at facility/that operate from this facility"
label var m0_223 "Access to an ambulance/other vehicle for emergency transport stationed elsewhere"
label var m0_108_delivery "Midwife BSc: Number currently providing delivery service"
label var m0_109_delivery "Midwife diploma: Number currently providing delivery service"
label var m0_110_delivery "Nurse BSc: Number currently providing delivery service"
label var m0_111_delivery "Nurse diploma: Number currently providing delivery service"
label var m0_112_delivery "Health officer: Number currently providing delivery service"
label var m0_107_delivery "Emergency surgical officer: Number currently providing delivery service"
label var m0_101_delivery "General practitioner: Number currently providing delivery service"
label var m0_301 "Facility offers: Family planning services"
label var m0_303 "Facility offers: Services for the prevention of mother to child HIV transmission"
label var m0_304 "Facility offers: Delivery and/or newborn care services"
label var m0_305a "Facility offers: Caesarean sections"
label var m0_305b "Caesarean section been carried out in the last 12m by providers in delivery services"
label var m0_306 "Facility offers: Immunization services"
label var m0_307a "Facility offers: Preventative and curative care services for children under 5y"
label var m0_307b "Facility offers: Antenatal care services"
label var m0_307c "Facility offers: Postnatal care services fro newborns"
label var m0_307d "Facility offers: Cervical screening (pap smear or VIA single visit approach)"
label var m0_308 "Facility offers: Adolescent health services"
label var m0_309 "Facility offers: HIV counselling and testing services"
label var m0_310 "Facility offers: HIV & AIDS antiretroviral prescription or antiretroviral treatment follow-up services"
label var m0_311 "Facility offers: HIV & AIDS care/support services"
label var m0_312 "Facility offers: Diagnosis or treatment of STIs other than HIV"
label var m0_313 "Facility offers: Diagnosis, treatment prescription, or treatment follow-up of tuberculosis"
label var m0_314 "Facility offers: Diagnosis or treatment of malaria"
label var m0_315a "Facility offers: Diagnosis or management of Diabetes"
label var m0_315b "Facility offers: Diagnosis or management of Cardiovascular disease"
label var m0_315c "Facility offers: Diagnosis or management of Chronic respiratory disease/Cardiovascular disease"
label var m0_315d "Facility offers: Diagnosis or management of Cancer diagnosis"
label var m0_315e "Facility offers: Diagnosis or management of Cancer treatment"
label var m0_315f "Facility offers: Diagnosis or management of Mental health services"
label var m0_316 "Facility offers: Diagnosis or management of neglected tropical diseases"
label var m0_317 "Facility offers: Any surgical services or caesarean section (minor surgery, suturing, circumcision, wound debridement) "
label var m0_318 "Facility offers: Blood transfusion services"
label var m0_319 "Facility offers: Safe abortion care"
label var m0_108_pnc "Midwife BSc: Number currently providing PNC service"
label var m0_109_pnc "Midwife diploma: Number currently providing PNC service"
label var m0_110_pnc "Nurse BSc: Number currently providing PNC service"
label var m0_111_pnc "Nurse diploma: Number currently providing PNC service"
label var m0_112_pnc "Health officer: Number currently providing PNC service"
label var m0_107_pnc "Emergency surgical officer: Number currently providing PNC service"
label var m0_101_pnc "General practitioner: Number currently providing PNC service"
label var m0_401 "Facility has: Blood pressure apparatus (Digital/manual sphygmomanometer with stethoscope)"
label var m0_401a "Status of: Blood preassure apparatus"
label var m0_402 "Facility has: Adult weighing scale"
label var m0_402a "Status of: Adult weighing scale"
label var m0_403 "Facility has: Infant weighing scale"
label var m0_403a "Status of: Infant weighing scale"
label var m0_404 "Facility has: Measuring tape/Height board"
label var m0_404a "Status of: Measuring tape/Height board"
label var m0_405 "Facility has: Thermometer"
label var m0_405a "Status of: Thermometer"
label var m0_406 "Facility has: Stethoscope"
label var m0_406a "Status of: Stethoscope"
label var m0_407 "Facility conducts any diagnostic testing (including any rapid diagnostic testing)"
label var m0_408 "Facility conducts: Rapid malaria testing"
label var m0_409 "Facility conducts: Rapid syphilis testing"
label var m0_410 "Facility conducts: HIV rapid testing"
label var m0_411 "Facility conducts: Urine rapid tests for pregnancy"
label var m0_412 "Facility conducts: Urine protein dipstick testing"
label var m0_413 "Facility conducts: Uring glucose dipstick testing"
label var m0_414 "Facility conducts: Urine ketone dipstick testing"
label var m0_415 "Facility conducts: Dry blood spot (DBS) collection for HIV viral load or early infant diagnosis (EID)"
label var m0_416 "Availibility: Malaria rapid diagnostic kit"
label var m0_417 "Availibility: Syphilis rapid diagnostic kit"
label var m0_418 "Availibility: SD BIOLIN HIV rapid test kit"
label var m0_419 "Availibility: STATPACK HIV rapid test kit"
label var m0_420 "Availibility: ABON HIV rapid test kit"
label var m0_421 "Availibility: Urine pregnancy test kit"
label var m0_422 "Availibility: Dipsticks for urine protein"
label var m0_423 "Availibility: Dipsticks for urine glucose"
label var m0_424 "Availibility: Dipsticks for urine ketone bodies"
label var m0_425 "Availibility: Filter paper for collecting DBS"
label var m0_426 "Facility conducts: Blood glucose tests using a glucometer"
label var m0_427 "Facility conducts: Haemoglobin testing "
label var m0_428 "Facility conducts: General microscopy/wet-mounts"
label var m0_429 "Facility conducts: Malaria microscopy"
label var m0_430 "Facility conducts: HIV antibody testing by ELISA"
label var m0_431 "Facility conducts: Diagnostic x-rays, ultrasound, or computerized tomography"
label var m0_432 "Facility has: X-ray machine "
label var m0_433 "Facility has: Ultrasound equipment"
label var m0_434 "Facility has: CT scan"
label var m0_435 "Facility has: ECG"
label var m0_108_epi_immunization "Midwife BSc: Number currently providing EPI/Immunication service"
label var m0_109_epi_immunization "Midwife diploma: Number currently providing EPI/Immunication service"
label var m0_110_epi_immunization "Nurse BSc: Number currently providing EPI/Immunication service"
label var m0_111_epi_immunization "Nurse diploma: Number currently providing EPI/Immunication service"
label var m0_112_epi_immunization "Health officer: Number currently providing EPI/Immunication service"
label var m0_107_epi_immunization "Emergency surgical officer: Number currently providing EPI/Immunication service"
label var m0_101_epi_immunization "General practitioner: Number currently providing EPI/Immunication service"
label var m0_501 "Does facility ever refer a woman or newborn to another facility for care?"
label var m0_502 "Which facility does this facility usually refer women or newborns for care"
label var m0_503a "Facility emergency patient transportation: Own means of transportation"
label var m0_503b "Facility emergency patient transportation: Uses a dispatch center"
label var m0_503c "Facility emergency patient transportation: Has agreements with private taxis, cars, trucks and motorcycles"
label var m0_503d "Facility emergency patient transportation: Use vehicles from the district health office"
label var m0_503e "Facility emergency patient transportation: Use vehicles from the local counsil"
label var m0_503f "Facility emergency patient transportation: Assume that patients will arrange their own transport"
label var m0_504 "Frequency facility receives feedback about the treatment/outcome of the patient after patient referral"
label var m0_505 "Facility has explicit written guidelines/protocols for pre-referral management of major obstetric & newborn complications"
label var m0_506 "Has facility ever received women or newborns referred here from a different facility"
label var m0_507 "Facility has system for staff to determine priority /proper place of treatment"
label var m0_508 "Facility has a maternity waiting home"
label var m0_508a "Maternal waiting home currently functional"
label var m0_601 "Formal payment required before receiving maternity services"
label var m0_601a "Woman expected to pay for/buy supplies and medicines for delivery"
label var m0_602 "Payment required before receiving care In an obstetric emergency"
label var m0_603 "Obstetric emergency: Woman/family asked to buy med/supplies prior to services"
label var m0_604 "Formal system in place to have fees for maternity services waived for poor women"
label var m0_605 "Informal system in place to waive fees for maternity services for poor women"
label var m0_606 "Fee schedule for services posted in a visible and public place"
label var m0_701 "System in place to regularly collect maternal/newborn health services data"
label var m0_702 "Facility reports data to the health management information system"
label var m0_703 "Frequency MNH data reported to the HMIS"
label var m0_703_other "Frequency MNH data reported to the HMIS: Other specified"
label var m0_704 "Designated person responsible for MNH services data"
label var m0_705 "Labor and delivery ward register used at this facility"
label var m0_706 "Antenatal care register used at this facility"
label var m0_707 "Postnatal care register used at this facility"
label var m0_801_apr "Number of ANC visits: April"
label var m0_801_aug "Number of ANC visits: August"
label var m0_801_dec "Number of ANC visits: December"
label var m0_801_feb "Number of ANC visits: February"
label var m0_801_jan "Number of ANC visits: January"
label var m0_801_jul "Number of ANC visits: July"
label var m0_801_jun "Number of ANC visits: June"
label var m0_801_mar "Number of ANC visits: March"
label var m0_801_may "Number of ANC visits: May"
label var m0_801_nov "Number of ANC visits: November"
label var m0_801_oct "Number of ANC visits: October"
label var m0_801_sep "Number of ANC visits: September"
label var m0_802_apr "Number of first ANC visits: April"
label var m0_802_aug "Number of first ANC visits: August"
label var m0_802_dec "Number of first ANC visits: December"
label var m0_802_feb "Number of first ANC visits: February"
label var m0_802_jan "Number of first ANC visits: January"
label var m0_802_jul "Number of first ANC visits: July"
label var m0_802_jun "Number of first ANC visits: June"
label var m0_802_mar "Number of first ANC visits: March"
label var m0_802_may "Number of first ANC visits: May"
label var m0_802_nov "Number of first ANC visits: November"
label var m0_802_oct "Number of first ANC visits: October"
label var m0_802_sep "Number of first ANC visits: September"
label var m0_803_apr "Number of vaginal deliveries: April"
label var m0_803_aug "Number of vaginal deliveries: August"
label var m0_803_dec "Number of vaginal deliveries: December"
label var m0_803_feb "Number of vaginal deliveries: February"
label var m0_803_jan "Number of vaginal deliveries: January"
label var m0_803_jul "Number of vaginal deliveries: July"
label var m0_803_jun "Number of vaginal deliveries: June"
label var m0_803_mar "Number of vaginal deliveries: March"
label var m0_803_may "Number of vaginal deliveries: May"
label var m0_803_nov "Number of vaginal deliveries: November"
label var m0_803_oct "Number of vaginal deliveries: October"
label var m0_803_sep "Number of vaginal deliveries: September"
label var m0_804_apr "Number of caesarean deliveries: April"
label var m0_804_aug "Number of caesarean deliveries: August"
label var m0_804_dec "Number of caesarean deliveries: December"
label var m0_804_feb "Number of caesarean deliveries: February"
label var m0_804_jan "Number of caesarean deliveries: January"
label var m0_804_jul "Number of caesarean deliveries: July"
label var m0_804_jun "Number of caesarean deliveries: June"
label var m0_804_mar "Number of caesarean deliveries: March"
label var m0_804_may "Number of caesarean deliveries: May"
label var m0_804_nov "Number of caesarean deliveries: November"
label var m0_804_oct "Number of caesarean deliveries: October"
label var m0_804_sep "Number of caesarean deliveries: September"
label var m0_805_apr "Number of postpartum haemorrhage cases: April"
label var m0_805_aug "Number of postpartum haemorrhage cases: August"
label var m0_805_dec "Number of postpartum haemorrhage cases: December"
label var m0_805_feb "Number of postpartum haemorrhage cases: February"
label var m0_805_jan "Number of postpartum haemorrhage cases: January"
label var m0_805_jul "Number of postpartum haemorrhage cases: July"
label var m0_805_jun "Number of postpartum haemorrhage cases: June"
label var m0_805_mar "Number of postpartum haemorrhage cases: March"
label var m0_805_may "Number of postpartum haemorrhage cases: May"
label var m0_805_nov "Number of postpartum haemorrhage cases: November"
label var m0_805_oct "Number of postpartum haemorrhage cases: October"
label var m0_805_sep "Number of postpartum haemorrhage cases: September"
label var m0_806_apr "Number of prolonged/obstructed labor cases: April"
label var m0_806_aug "Number of prolonged/obstructed labor cases: August"
label var m0_806_dec "Number of prolonged/obstructed labor cases: December"
label var m0_806_feb "Number of prolonged/obstructed labor cases: February"
label var m0_806_jan "Number of prolonged/obstructed labor cases: January"
label var m0_806_jul "Number of prolonged/obstructed labor cases: July"
label var m0_806_jun "Number of prolonged/obstructed labor cases: June"
label var m0_806_mar "Number of prolonged/obstructed labor cases: March"
label var m0_806_may "Number of prolonged/obstructed labor cases: May"
label var m0_806_nov "Number of prolonged/obstructed labor cases: November"
label var m0_806_oct "Number of prolonged/obstructed labor cases: October"
label var m0_806_sep "Number of prolonged/obstructed labor cases: September"
label var m0_807_apr "Number of severe pre-eclampsia cases: April"
label var m0_807_aug "Number of severe pre-eclampsia cases: August"
label var m0_807_dec "Number of severe pre-eclampsia cases: December"
label var m0_807_feb "Number of severe pre-eclampsia cases: February"
label var m0_807_jan "Number of severe pre-eclampsia cases: January"
label var m0_807_jul "Number of severe pre-eclampsia cases: July"
label var m0_807_jun "Number of severe pre-eclampsia cases: June"
label var m0_807_mar "Number of severe pre-eclampsia cases: March"
label var m0_807_may "Number of severe pre-eclampsia cases: May"
label var m0_807_nov "Number of severe pre-eclampsia cases: November"
label var m0_807_oct "Number of severe pre-eclampsia cases: October"
label var m0_807_sep "Number of severe pre-eclampsia cases: September"
label var m0_808_apr "Number of matrenal deaths: April"
label var m0_808_aug "Number of matrenal deaths: August"
label var m0_808_dec "Number of matrenal deaths: December"
label var m0_808_feb "Number of matrenal deaths: February"
label var m0_808_jan "Number of matrenal deaths: January"
label var m0_808_jul "Number of matrenal deaths: July"
label var m0_808_jun "Number of matrenal deaths: June"
label var m0_808_mar "Number of matrenal deaths: March"
label var m0_808_may "Number of matrenal deaths: May"
label var m0_808_nov "Number of matrenal deaths: November"
label var m0_808_oct "Number of matrenal deaths: October"
label var m0_808_sep "Number of matrenal deaths: September"
label var m0_809_apr "Number of stillbirths: April"
label var m0_809_aug "Number of stillbirths: August"
label var m0_809_dec "Number of stillbirths: December"
label var m0_809_feb "Number of stillbirths: February"
label var m0_809_jan "Number of stillbirths: January"
label var m0_809_jul "Number of stillbirths: July"
label var m0_809_jun "Number of stillbirths: June"
label var m0_809_mar "Number of stillbirths: March"
label var m0_809_may "Number of stillbirths: May"
label var m0_809_nov "Number of stillbirths: November"
label var m0_809_oct "Number of stillbirths: October"
label var m0_809_sep "Number of stillbirths: September"
label var m0_810_apr "Number of eclampsia cases: April"
label var m0_810_aug "Number of eclampsia cases: August"
label var m0_810_dec "Number of eclampsia cases: December"
label var m0_810_feb "Number of eclampsia cases: February"
label var m0_810_jan "Number of eclampsia cases: January"
label var m0_810_jul "Number of eclampsia cases: July"
label var m0_810_jun "Number of eclampsia cases: June"
label var m0_810_mar "Number of eclampsia cases: March"
label var m0_810_may "Number of eclampsia cases: May"
label var m0_810_nov "Number of eclampsia cases: November"
label var m0_810_oct "Number of eclampsia cases: October"
label var m0_810_sep "Number of eclampsia cases: September"
label var m0_811_apr "Number of neonatal deaths: April"
label var m0_811_aug "Number of neonatal deaths: August"
label var m0_811_dec "Number of neonatal deaths: December"
label var m0_811_feb "Number of neonatal deaths: February"
label var m0_811_jan "Number of neonatal deaths: January"
label var m0_811_jul "Number of neonatal deaths: July"
label var m0_811_jun "Number of neonatal deaths: June"
label var m0_811_mar "Number of neonatal deaths: March"
label var m0_811_may "Number of neonatal deaths: May"
label var m0_811_nov "Number of neonatal deaths: November"
label var m0_811_oct "Number of neonatal deaths: October"
label var m0_811_sep "Number of neonatal deaths: September"
label var m0_812_apr "Number of referrals out of facility due to obstetric indications: April"
label var m0_812_aug "Number of referrals out of facility due to obstetric indications: August"
label var m0_812_dec "Number of referrals out of facility due to obstetric indications: December"
label var m0_812_feb "Number of referrals out of facility due to obstetric indications: February"
label var m0_812_jan "Number of referrals out of facility due to obstetric indications: January"
label var m0_812_jul "Number of referrals out of facility due to obstetric indications: July"
label var m0_812_jun "Number of referrals out of facility due to obstetric indications: June"
label var m0_812_mar "Number of referrals out of facility due to obstetric indications: March"
label var m0_812_may "Number of referrals out of facility due to obstetric indications: May"
label var m0_812_nov "Number of referrals out of facility due to obstetric indications: November"
label var m0_812_oct "Number of referrals out of facility due to obstetric indications: October"
label var m0_812_sep "Number of referrals out of facility due to obstetric indications: September"
label var m0_813_apr "Number of postnatal care visits: April"
label var m0_813_aug "Number of postnatal care visits: August"
label var m0_813_dec "Number of postnatal care visits: December"
label var m0_813_feb "Number of postnatal care visits: February"
label var m0_813_jan "Number of postnatal care visits: January"
label var m0_813_jul "Number of postnatal care visits: July"
label var m0_813_jun "Number of postnatal care visits: June"
label var m0_813_mar "Number of postnatal care visits: March"
label var m0_813_may "Number of postnatal care visits: May"
label var m0_813_nov "Number of postnatal care visits: November"
label var m0_813_oct "Number of postnatal care visits: October"
label var m0_813_sep "Number of postnatal care visits: September"
label var m0_814_apr "Number of instrumental deliveries: April"
label var m0_814_aug "Number of instrumental deliveries: August"
label var m0_814_dec "Number of instrumental deliveries: December"
label var m0_814_feb "Number of instrumental deliveries: February"
label var m0_814_jan "Number of instrumental deliveries: January"
label var m0_814_jul "Number of instrumental deliveries: July"
label var m0_814_jun "Number of instrumental deliveries: June"
label var m0_814_mar "Number of instrumental deliveries: March"
label var m0_814_may "Number of instrumental deliveries: May"
label var m0_814_nov "Number of instrumental deliveries: November"
label var m0_814_oct "Number of instrumental deliveries: October"
label var m0_814_sep "Number of instrumental deliveries: September"
label var m0_815_apr "Number of early neonatal death (first 24hrs) : April"
label var m0_815_aug "Number of early neonatal death (first 24hrs) : August"
label var m0_815_dec "Number of early neonatal death (first 24hrs) : December"
label var m0_815_feb "Number of early neonatal death (first 24hrs) : February"
label var m0_815_jan "Number of early neonatal death (first 24hrs) : January"
label var m0_815_jul "Number of early neonatal death (first 24hrs) : July"
label var m0_815_jun "Number of early neonatal death (first 24hrs) : June"
label var m0_815_mar "Number of early neonatal death (first 24hrs) : March"
label var m0_815_may "Number of early neonatal death (first 24hrs) : May"
label var m0_815_nov "Number of early neonatal death (first 24hrs) : November"
label var m0_815_oct "Number of early neonatal death (first 24hrs) : October"
label var m0_815_sep "Number of early neonatal death (first 24hrs) : September"
label var m0_catchment "Facility has specified catchment area"
label var m0_catchment_volumn "Number of people supposed to be in the catchment area for this facility"
label var m0_date "M0 Date"
label var m0_region "M0 Region"
label var m0_zone_subcity "M0 Zone/Sub-city"
label var m0_woreda "M0 Woreda"
label var m0_woreda_other "M0 Woreda: Other specified"
label var m0_facility_name "M0 Facility name"
label var m0_facility_name_other "M0 Facility name: Other specified"
label var mo_facility_type "M0 Facility type"
label var m0_facility_latitude "M0 Facility Latitude"
label var m0_facility_longitude "M0 Facility Longitude"
label var m0_facility_altitude "M0 Facility Altitude"
label var m0_facility_ownership "M0 Facility ownership"
label var m0_urban "M0 Facility in urban or rural area"
label var m0_complete_et "M0 - complete"
label var m0_interviewer_id "M0 Interviewer ID"
label var m0_name_of_dc "M0 Name of DC"
label var m0_response_id "M0 Response ID"


*****************************************************************
****************************************************************
* Add the value labels
label value m0_115a m0_selected
label value m0_115b m0_selected
label value m0_115c m0_selected
label value m0_115d m0_selected
label value m0_115e m0_selected
label value m0_115f m0_selected
label value m0_115g m0_selected
label value m0_115h m0_selected
label value m0_115i m0_selected
label value m0_116a m0_selected
label value m0_116b m0_selected
label value m0_116c m0_selected
label value m0_116d m0_selected
label value m0_116e m0_selected
label value m0_116f m0_selected
label value m0_116g m0_selected
label value m0_116h m0_selected
label value m0_116i m0_selected
label value m0_117a m0_selected
label value m0_117b m0_selected
label value m0_117c m0_selected
label value m0_117d m0_selected
label value m0_117e m0_selected
label value m0_117f m0_selected
label value m0_117g m0_selected
label value m0_117h m0_selected
label value m0_117i m0_selected
label value m0_118a m0_selected
label value m0_118b m0_selected
label value m0_118c m0_selected
label value m0_118d m0_selected
label value m0_118e m0_selected
label value m0_118f m0_selected
label value m0_118g m0_selected
label value m0_118h m0_selected
label value m0_118i m0_selected
label value m0_119a m0_selected
label value m0_119b m0_selected
label value m0_119c m0_selected
label value m0_119d m0_selected
label value m0_119e m0_selected
label value m0_119f m0_selected
label value m0_119g m0_selected
label value m0_119h m0_selected
label value m0_119i m0_selected
label value m0_120a m0_selected
label value m0_120b m0_selected
label value m0_120c m0_selected
label value m0_120d m0_selected
label value m0_120e m0_selected
label value m0_120f m0_selected
label value m0_120g m0_selected
label value m0_120h m0_selected
label value m0_120i m0_selected
label value m0_121a m0_selected
label value m0_121b m0_selected
label value m0_121c m0_selected
label value m0_121d m0_selected
label value m0_121e m0_selected
label value m0_121f m0_selected
label value m0_121g m0_selected
label value m0_121h m0_selected
label value m0_121i m0_selected
label value m0_122a m0_selected
label value m0_122b m0_selected
label value m0_122c m0_selected
label value m0_122d m0_selected
label value m0_122e m0_selected
label value m0_122f m0_selected
label value m0_122g m0_selected
label value m0_122h m0_selected
label value m0_122i m0_selected
label value m0_204 m0_yesno
label value m0_205 m0_yesno
label value m0_206 m0_yesno
label value m0_207 m0_yesno
label value m0_208 m0_yesno
label value m0_209e m0_selected
label value m0_209a m0_selected
label value m0_209b m0_selected
label value m0_209c m0_selected
label value m0_209d m0_selected
label value m0_210 m0_yesno
label value m0_211 m0_water
label value m0_212 m0_onsite
label value m0_213 m0_yesno
label value m0_214 m0_yesno
label value m0_215 m0_toliet_type
label value m0_216 m0_yesno
label value m0_217 m0_yesno
label value m0_218 m0_yesno
label value m0_219 m0_yesno
label value m0_220 m0_yesno
label value m0_221 m0_yesno
label value m0_223 m0_yesno
label value m0_301 m0_yesno
label value m0_303 m0_yesno
label value m0_304 m0_yesno
label value m0_305a m0_yesno
label value m0_305b m0_yesno
label value m0_306 m0_yesno
label value m0_307a m0_yesno
label value m0_307b m0_yesno
label value m0_307c m0_yesno
label value m0_307d m0_yesno
label value m0_308 m0_yesno
label value m0_309 m0_yesno
label value m0_310 m0_yesno
label value m0_311 m0_yesno
label value m0_312 m0_yesno
label value m0_313 m0_yesno
label value m0_314 m0_yesno
label value m0_315a m0_yesno
label value m0_315b m0_yesno
label value m0_315c m0_yesno
label value m0_315d m0_yesno
label value m0_315e m0_yesno
label value m0_315f m0_yesno
label value m0_316 m0_yesno
label value m0_317 m0_yesno
label value m0_318 m0_yesno
label value m0_319 m0_yesno
label value m0_401 m0_observed
label value m0_401a m0_functional
label value m0_402 m0_observed
label value m0_402a m0_functional
label value m0_403 m0_observed
label value m0_403a m0_functional
label value m0_404 m0_observed
label value m0_404a m0_functional
label value m0_405 m0_observed
label value m0_405a m0_functional
label value m0_406 m0_observed
label value m0_406a m0_functional
label value m0_407 m0_yesno
label value m0_408 m0_onsite
label value m0_409 m0_onsite
label value m0_410 m0_availible_onsite
label value m0_411 m0_availible_onsite
label value m0_412 m0_availible_onsite
label value m0_413 m0_availible_onsite
label value m0_414 m0_availible_onsite
label value m0_415 m0_availible_onsite
label value m0_416 m0_available
label value m0_417 m0_available
label value m0_418 m0_available
label value m0_419 m0_available
label value m0_420 m0_available
label value m0_421 m0_available
label value m0_422 m0_available
label value m0_423 m0_available
label value m0_424 m0_available
label value m0_425 m0_available
label value m0_426 m0_conducts
label value m0_427 m0_conducts
label value m0_428 m0_conducts
label value m0_429 m0_conducts
label value m0_430 m0_conducts
label value m0_431 m0_conducts
label value m0_432 m0_observed
label value m0_433 m0_observed
label value m0_434 m0_observed
label value m0_435 m0_observed
label value m0_501 m0_yesno
label value m0_503a m0_selected
label value m0_503b m0_selected
label value m0_503c m0_selected
label value m0_503d m0_selected
label value m0_503e m0_selected
label value m0_503f m0_selected
label value m0_504 m0_frequency
label value m0_505 m0_guidelines
label value m0_506 m0_yesno
label value m0_507 m0_yesno
label value m0_508 m0_yesno
label value m0_508a m0_yesno
label value m0_601 m0_yesno
label value m0_601a m0_yesno
label value m0_602 m0_yesno
label value m0_603 m0_yesno
label value m0_604 m0_yesno
label value m0_605 m0_yesno
label value m0_606 m0_yesno
label value m0_701 m0_yesno
label value m0_702 m0_yesno
label value m0_703 m0_mnh_data
label value m0_704 m0_yesno
label value m0_705 m0_yesno
label value m0_706 m0_yesno
label value m0_707 m0_yesno
label value m0_catchment m0_catchment
label value m0_facility_name et_facility
label value m0_urban m0_urban

***********************************************
***********************************************
* Save the dataset
save "${et_data_final}/eco_m0_et_cleaned", replace

