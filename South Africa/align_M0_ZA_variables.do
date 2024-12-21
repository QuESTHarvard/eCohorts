* Bring in dataset
use "${za_data_final}/eco_m0_za", clear


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

***********************************************
***********************************************

* Add country specific value labels


***********************************************
***********************************************
* Rename varibles

***********************************************
***********************************************
* Label variables

***********************************************
***********************************************
* Add value labels


***********************************************
***********************************************
* Save cleaned dataset

