* m2_data_quality_checks
*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
2024-08-12		1.00	MK Trimner		Original Program
*******************************************************************************
*/
	local country in	

	if "`excel'" == "" local excel Module_2_Data_Quality_checks.xlsx
	if "`output'" == "" local output ${`country'_data}
	
	* CD to the location that you want to save the DQ checks
	cd "`output'"

	* Erase the older version of this excel file
	capture erase "`excel'"
	
	* Set up a local with the standard assertlist values that will be used for all assertions
	local ids m2_respondentid m2_date 
	local standard_values idlist(`ids') excel(`excel')
	
	
	****************************************************************************
	****************************************************************************
	****************************************************************************
	
	* Complete the checks on the Identification variables
	local sheet_name Identification
	
	* confirm that there are no repeats by respondentid and date
	bysort m2_respondentid: gen num_M2_surveys = _N
	label var num_M2_surveys "Number of times Respondent appears in M2 dataset"
	assertlist num_M2_surveys <= 10, list(num_M2_surveys) tag(Each respondent should have no more than 10 M2 surveys) `standard_values' sheet(`sheet_name')
	
	bysort m2_respondentid m2_date: gen num_M2_surveys_by_date = _N
	label var num_M2_surveys_by_date "Number of times Respondent appears in M2 dataset with m2_date"
	assertlist num_M2_surveys_by_date == 1, list(m2_date) tag(M2 survey date should only appear once per respondent) `standard_values' sheet(`sheet_name')
	
	drop num_M2_surveys* 
	
	
	* Check that the date is within the appropriate window 
	*gen earliest_date = date(`earliest_date',"DMY")
	
	*if "`latest_date'" == "" gen latest_date = today()
	* WE are using the date that the information was given
	gen latest_date = date("24062024","DMY")
	format %tdDMY latest_date
	
	*assertlist m2_date >= `earliest_date', list(m2_date) tag(M2 survey date should be after earliest possible survey date provided : `earliest_date') `standard_values' sheet(`sheet_name') 
	assertlist m2_date <= latest_date, list(m2_date latest_date) tag(`"m2_date (`m2_date[Original_Varname]'): M2 survey date should be before lastest possible survey date provided : 24-06-2024"') `standard_values' sheet(`sheet_name') 
	* Check the time between each visit
	gen time_between_surveys = 0
	forvalues i = 2/`=_N' {
		replace time_between_surveys = m2_date[`i'] - m2_date[`=`i'- 1'] if m2_respondentid[`i'] == m2_respondentid[`=`i'- 1'] in `i'
	}
	
	assertlist time_between_surveys >= 21 if time_between_surveys != 0, list(m2_date time_between_surveys) tag(`"m2_date (`m2_date[Original_Varname]'): Time between each survey should be more than 3 weeks (21 days)"') `standard_values' sheet(`sheet_name')
	assertlist time_between_surveys < 60 if time_between_surveys != 0, list(m2_date time_between_surveys) tag(`"m2_date (`m2_date[Original_Varname]'): Time between each survey should be less than 3 months (90 days)"') `standard_values' sheet(`sheet_name')

	* Check Gestational age makes sense
	assertlist m2_ga > 0, list(m2_ga) tag(`"m2_ga (`m2_ga[Original_Varname]'): Gestational Age is less than 0 weeks"') `standard_values' sheet(`sheet_name')
	assertlist m2_ga <= 41, list(m2_ga) tag(`"m2_ga (`m2_ga[Original_Varname]'): Gestational Age is more than 41 weeks"') `standard_values' sheet(`sheet_name')
	
	assertlist inlist(m2_hiv_status,1,0,99,.), list(m2_hiv_status) tag(`"m2_hiv_status (`m2_hiv_status[Original_Varname]'): Invalid M2 HIV status"') `standard_values' sheet(`sheet_name')
	
	* Confirm valid values for maternal death
	assertlist inlist(m2_maternal_death_reported,0,1), list(m2_maternal_death_reported) tag(`"m2_maternal_death_reported (`m2_maternal_death_reported[Original_Varname]'): Invalid values in M2 maternal death"') `standard_values' sheet(`sheet_name')
	
	* Confirm that the below variables are populated if said mother died
	assertlist missing(m2_date_of_maternal_death) if m2_maternal_death_reported != 1, list(m2_maternal_death_reported m2_date_of_maternal_death) tag(`"m2_date_of_maternal_death (`m2_date_of_maternal_death[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')
	
	assertlist m2_date_of_maternal_death < m2_date if m2_maternal_death_reported == 1, list(m2_maternal_death_reported m2_date_of_maternal_death) tag(`"m2_date_of_maternal_death (`m2_date_of_maternal_death[Original_Varname]'): Should be before m2_date"') `standard_values' sheet(`sheet_name')
	
	* Confirm appropriate values for how they learned about the maternal death
	assertlist inlist(m2_maternal_death_learn,1,2,3,4,5) if m2_maternal_death_reported == 1, list(m2_maternal_death_reported m2_maternal_death_learn) tag(`"m2_maternal_death_learn (`m2_maternal_death_learn[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
	
	assertlist missing(m2_maternal_death_learn) if m2_maternal_death_reported != 1, list(m2_maternal_death_reported m2_maternal_death_learn) tag(`"m2_maternal_death_learn (`m2_maternal_death_learn[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')
	
	* Check permission
	assertlist inlist(m2_permission,0,1) if m2_maternal_death_reported != 1, list(m2_maternal_death_reported m2_permission) tag(`"m2_permission (`m2_permission[Original_Varname]'): Invalid permission value"') `standard_values' sheet(`sheet_name')
	
	assertlist missing(m2_permission) if m2_maternal_death_reported == 1, list(m2_maternal_death_reported m2_permission) tag(`"m2_permission (`m2_permission[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')
	
	* Confirm that if did not give permission all other vars are missing
	gen no_permission = 0
	foreach v of varlist m2_* {
		if !inlist("`v'","m2_permission","m2_date","m2_respondentid","m2_time_start","m2_hiv_status") & !inlist("`v'","m2_ga","m2_maternal_death_reported","m2_maternal_death_learn","m2_maternal_death_learn_other", "m2_date_of_maternal_death") {
			replace no_permission = 1 if !missing(`v')
		}
	}
	
	assertlist no_permission == 0 if m2_permission != 1, list(m2_permission no_permission) tag(Survey should have ended since did not give consent) `standard_values' sheet(`sheet_name')

		
	****************************************************************************
	****************************************************************************
	****************************************************************************
	
	* Complete the checks on the General health variables
	local sheet_name General Health
	
	* Check to make sure the rating variables have appropriate values
	assertlist inlist(m2_201,1,2,3,4,5) if m2_permission == 1, list(m2_permission m2_201) tag(`"m2_201 (`m2_201[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
	
	assertlist inlist(m2_202,1,2,3) if m2_permission == 1, list(m2_permission m2_202) tag(`"m2_202 (`m2_202[Original_Varname]'): Invalid values"') `standard_values' sheet(`sheet_name')
	
	foreach v in a b c d e f g h  {
		assertlist inlist(m2_203`v',0,1,98,99) if m2_202 == 1, list(m2_202 m2_203`v') tag(`"m2_203`v' (`m2_203`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
	}
	
	* Confirm that populated other symptoms if said expereinced other sypmtoms
	assertlist inlist(m2_204i,0,1) if m2_202 == 1, list(m2_202 m2_204i) tag(`"m2_204i (`m2_204i[Original_Varname]'): Invalid values"') `standard_values' sheet(`sheet_name')
	
	assertlist inlist(m2_205a,0,1,2,3,99) if m2_202 == 1, list(m2_202 m2_205a) tag(`"m2_205b (`m2_205b[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
	assertlist inlist(m2_205b,0,1,2,3,99) if m2_202 == 1, list(m2_202 m2_205b) tag(`"m2_205b (`m2_205b[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')

	gen not_pregnant = 0
	* Confirm that if respondent is not still pregnant that they did not answer the other questions in this module
	foreach v of varlist m2_203* m2_204* m2_205* {
		replace not_pregnant = 1 if !missing(`v')
	}
		
	
	****************************************************************************
	****************************************************************************
	****************************************************************************
	
	* Complete the checks on the Care Pathways variables
	local sheet_name Care Pathways
	
	
	assertlist inlist(m2_301,0,1,98,99) if m2_202 == 1, list(m2_202 m2_301) tag(`"m2_301 (`m2_301[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
	
	assertlist m2_302 > 0 & m2_302 < 5 if m2_301 == 1, list(m2_301 m2_302) tag(`"m2_302 (`m2_302[Original_Varname]'): Should be greater than 0 and less than 5"') `standard_values' sheet(`sheet_name')
	assertlist missing(m2_302) if m2_301 != 1, list(m2_301 m2_302) tag(`"m2_302 (`m2_302[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')

	* Confirm the location has the appropriate values
	local n 1
	foreach v in a b c d e {
		assertlist inlist(m2_303`v',1,2,3,31,32,33,34,35) | inlist(m2_303`v',4,5,6,7,8,9,98,99) if m2_301 == 1 & m2_302 >= `n', list(m2_301 m2_302 m2_303`v') tag(`"m2_303`v' (`m2_303`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheetname')
		
		assertlist missing(m2_303`v') if m2_301 != 1 , list(m2_301 m2_303`v') tag(`"m2_303`v' (`m2_303`v'[Original_Varname]'): Should be missing since said did not have any consultations"') `standard_values' sheet(`sheetname')
		assertlist missing(m2_303`v') if m2_301 == 1 &  m2_302 < `n', list(m2_301 m2_302 m2_303`v') tag(`"m2_303`v' (`m2_303`v'[Original_Varname]'): Should be missing since said had < `n' consultations"') `standard_values' sheet(`sheetname')

		local ++n
	}
	
	
	
	* There are several different individual variables that also contain this information
	* We want to check to make sure that all the variables align (Q303, m2_303a-m2_303e and Q303_1-Q303_99)
	* Create variable to show the different locations based on Q303
	split Q303, gen(Q303_v) 
	
	foreach v in 1 2 {
		replace Q303_v`v' = subinstr(Q303_v`v',".","",.)
	}
	
	destring Q303_v1 Q303_v2, replace
	
	rename Q303 Q303_org
	
	* Confirm that the values in Q303 are selected
	foreach n in 1 2 3 31 32 33 34 35 4 5 6 7 8 9 98 99 { // loop through the different location var values
		local b `n'
		if `n' == 31 local b 3_1 
		if `n' == 32 local b 3_2
		if `n' == 33 local b 3_3
		if `n' == 34 local b 3_4
		if `n' == 35 local b 3_5
		
		di "`b'"
		
		assertlist Q303_`b' == 1 if (m2_303a == `n' | m2_303b == `n' | m2_303c == `n' | m2_303d == `n' | m2_303e == `n' | Q303_v1 == `n' | Q303_v2 == `n'), list(m2_303a m2_303b m2_303c m2_303d m2_303e Q303_org Q303_`b' ) tag(`"Inconsisent between m2_303a-m2_303e (Q303a-Q303e), Q303 and Q303_`b'"') `standard_values' sheet(`sheet_name')
		
		assertlist (m2_303a == `n' | m2_303b == `n' | m2_303c == `n' | m2_303d == `n' | m2_303e == `n') if Q303_`b' == 1 | Q303_v1 == `n' | Q303_v2 == `n', list(Q303_`b' Q303_org m2_303a m2_303b m2_303c m2_303d m2_303e) tag(`"Inconsisent between m2_303a-m2_303e (Q303a-Q303e), Q303 and Q303_`b'"') `standard_values' sheet(`sheet_name')

		assertlist (m2_303a != `n' & m2_303b != `n' & m2_303c != `n' & m2_303d != `n' & m2_303e != `n') if Q303_`b' != 1 & Q303_v1 != `n' & Q303_v2 != `n', list(m2_303a-m2_303e Q303_org Q303_`b') tag(`"Inconsisent between m2_303a-m2_303e (Q303a-Q303e), Q303 and Q303_`b'"') `standard_values' sheet(`sheet_name') 
		
	}
	
	local sheet_name Care Pathways

	* Confirm that the other option was only provided if specified
	local 1 st
	local 2 nd
	local 3 rd
	local 4 th
	local 5 th
	
	local n 1
	foreach v in a b c d e {
		
		assertlist (m2_304`v' >= 1 & m2_304`v' <= 40) | m2_304`v' == 96 if !inlist(m2_303`v',1,2,98,99,.) & m2_302 >= `n' & !missing(m2_302), list(m2_302 m2_303`v' m2_304`v') tag(`"m2_304`v'  (`m2_304`v'[Original_Varname]'): Invalid facility location for `n'``n'' health consultation"') `standard_values' sheet(`sheet_name')
		
		assertlist missing(m2_304`v') if inlist(m2_303`v',1,2) & m2_302 >= `n' & !missing(m2_302), list(m2_302 m2_303`v' m2_304`v') tag(`"m2_304`v' (`m2_304`v'[Original_Varname]'): Facility location for `n'``n'' health consultation should be missing because the consultation took place in a home"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_304`v') if inlist(m2_303`v',98) & m2_302 >= `n' & !missing(m2_302), list(m2_302 m2_303`v' m2_304`v') tag(`"m2_304`v' (`m2_304`v'[Original_Varname]'): Facility location for `n'``n'' health consultation should be missing because did not know consultation location"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_304`v') if inlist(m2_303`v',99) & m2_302 >= `n' & !missing(m2_302), list(m2_302 m2_303`v' m2_304`v') tag(`"m2_304`v' (`m2_304`v'[Original_Varname]'): Facility location for `n'``n'' health consultation should be missing because refused to provide consulation location"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_304`v') if inlist(m2_303`v',.) & m2_302 >= `n' & !missing(m2_302), list(m2_302 m2_303`v' m2_304`v') tag(`"m2_304`v' (`m2_304`v'[Original_Varname]'): Facility location for `n'``n'' health consultation should be missing because missing consultation location"') `standard_values' sheet(`sheet_name')

		assertlist !missing(m2_304`v'_other) if m2_304`v' == 96, list(m2_304`v' m2_304`v'_other) tag(`"m2_304`v'_other (`m2_304`v'_other[Original_Varname]'): Other specified `n'``n'' facility should be populated because specified Other in m2_304`v' (`m2_304`v'[Original_Varname]')"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_304`v'_other) if m2_304`v' != 96 & m2_302 >= `n' & !missing(m2_302), list(m2_302 m2_304`v' m2_304`v'_other) tag(`"m2_304`v'_other (`m2_304`v'_other[Original_Varname]'): Other specified `n'``n'' facility should be missing because did not specify Other in m2_304`v' (`m2_304`v'[Original_Varname]')"') `standard_values' sheet(`sheet_name')

		local ++n
	}
	
	
	* For the reasons for each non ANC visit or referral visit 
	* Set locals with the different corresponding variables for each visit
	local 1 05 06 07
	local 2 08 09 10
	local 3 11 12 13
	local 4 14 15 16
	local 5 17 18 19
	
	* Set locals to be used in output strings
	local 1_rsn 1st
	local 2_rsn 2nd
	local 3_rsn 3rd 
	local 4_rsn 4th 
	local 5_rsn 5th 
	
	local first_desc this was a routine ANC visit
	local second_desc this was a referral from ANC provider if not for a routine ANC visit
	local third_desc this was not an ANC visit or a referral from ANC provider
	
	local first_type Routine ANC 
	local second_type Refferal from ANC provider
	local third_type Non ANC or refferal overall
	
	foreach n in 1 2 3 4 5 { // begin visit number loop
	di ""
			di "Check variables for ``n'_rsn' health consultation ..... "
			local first m2_3`=word("``n''",1)'
			local second m2_3`=word("``n''",2)'
			local third m2_3`=word("``n''",3)'
			
			* Confirm the values are valid for the question asking if this was a routine antenatal care visit
			local if_statement1
			local if_statement2
			local if_statement3
			local listvars
			foreach f in first second third  { // loop through first, second and third variables to do checks
				di "	``f'_type' : Variable ``f'' ..... "

				local listvars `listvars' ``f''
				assertlist missing(``f'') if m2_301 != 1 , list(m2_301 ``f'') tag(`"``f'' (```f''[Original_Varname]'):  ``n'_rsn' visit should be missing if there were no additional healthcare consultations"') `standard_values' sheet(`sheet_name')
				assertlist missing(``f'') if m2_301 == 1  & m2_302 < `n', list(m2_301 m2_302 ``f'') tag(`"``f'' (```f''[Original_Varname]'): ``n'_rsn' visit should be missing if there were < `n' healthcare consultations"') `standard_values' sheet(`sheet_name')
			
				if "`f'" != "first" assertlist missing(``f'') if m2_301 == 1 `if_statement2' & (m2_302 >= `n' & !missing(m2_302)), list(m2_301 m2_302 `listvars') tag(`"``f'' (```f''[Original_Varname]'): ``n'_rsn' visit should be missing if `state2'"') `standard_values' sheet(`sheet_name')
				
				* Check the values for first and second variables (Third has different options)
				if "`f'" != "third" assertlist inlist(``f'',0,1,98,99) if m2_301 == 1 `if_statement1' & (m2_302 >= `n' & !missing(m2_302)), list(m2_301 m2_302 `listvars') tag(`"``f'' (```f''[Original_Varname]'): Invalid value for ``n'_rsn' visit if ``f'_desc'"') `standard_values' sheet(`sheet_name')
				
				* Check the values for the third variable
				if "`f'" == "third" assertlist !missing(``f'') if m2_301 == 1 `if_statement1' & (m2_302 >= `n' & !missing(m2_302)), list(m2_301 m2_302 `listvars') tag(`"``f'' (```f''[Original_Varname]'): Invalid value for ``n'_rsn' visit if ``f'_desc'"') `standard_values' sheet(`sheet_name')
				


				if "`f'" != "third" local if_statement1 `if_statement1' & ``f'' == 0
				
				if "`f'" == "first" {
					local if_statement2  & `first' == 1 
					local state2 ``f'_desc'
				}
				if "`f'" == "second" {
					local if_statement2 & (`first' == 1 | `second' == 1)
					local state2 this was a routine ANC visit or a refferal from ANC provider
				}
			} // end loop through first, second and third
		
			local rsn_yes 
			local rsn_no
			local rsn_list 
			local wc 0
			* Count to make sure that not everyone is missing the third variable
			qui count if !missing(`third')
			
			if `r(N)' > 0  {
				gen `third'_wc = wordcount(`third')
				qui sum `third'_wc, d
				local wc = r(max)
		
				forvalues i = 1/`wc' {
					 gen visit_rsn_`n'_`i' = word(`third',`i')
						
					destring visit_rsn_`n'_`i' , replace
						
					local rsn_yes `rsn_yes' | visit_rsn_`n'_`i' == VALUE 
					local rsn_no `rsn_no' & visit_rsn_`n'_`i' != VALUE 
					local rsn_list `rsn_list' visit_rsn_`n'_`i'
				}
					
				foreach y in yes no {
					local rsn_`y' = substr("`rsn_`y''",3,.)
				}
		
			}
		
			foreach v in 1 2 3 4 5 96 { // loop through all the reason values
					di "		 `:var label `third'_`v'': `third'_`v' ..... "

					assertlist missing(`third'_`v') if m2_301 != 1 , list(m2_301 `listvars') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): ``n'_rsn' visit should be missing if there were no additional healthcare consultations"') `standard_values' sheet(`sheet_name')
					assertlist missing(`third'_`v') if m2_301 == 1  & m2_302 < `n', list(m2_301 m2_302 `listvars') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): ``n'_rsn' visit should be missing if there were < `n' healthcare consultations"') `standard_values' sheet(`sheet_name')
					assertlist missing(`third'_`v') if m2_301 == 1 `if_statement2' & (m2_302 >= `n' & !missing(m2_302)), list(m2_301 m2_302 `listvars') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): ``n'_rsn' visit should be missing if `third_desc'"') `standard_values' sheet(`sheet_name')

					assertlist inlist(`third'_`v',0,1) if m2_301 == 1 `if_statement1' & (m2_302 >= `n' & !missing(m2_302)), list(m2_301 m2_302 `listvars') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): Invalid value for ``n'_rsn' visit if `third_desc'"') `standard_values' sheet(`sheet_name')
					
			
					* The next check we only want to do if there was a string value provided in the main third variable
					if `wc' > 0 {
						di "			`:var label `third'' aligns with the `:var label `third'_`v'' : Variables `third' and `third'_`v' ..... "

						local rsn_yes_`v' = subinstr("`rsn_yes'","VALUE","`v'",.)
						local rsn_no_`v' = subinstr("`rsn_no'","VALUE","`v'",.)
									
						assertlist `third'_`v' == 1 if (`rsn_yes_`v''), list(`third'_`v' `third' `rsn_list') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): ``n'_rsn' visit reason should be set to 1 if sepcified in `third'"') `standard_values' sheet(`sheet_name')
						
						assertlist `third'_`v' != 1 if (`rsn_no_`v''), list(`third'_`v' `third' `rsn_list') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): ``n'_rsn' visit reason should not be set to 1 if not sepcified in `third'"') `standard_values' sheet(`sheet_name')
					}
					
					if `wc' == 0 assertlist missing(`third'_`v') if missing(`third'), list(`third' `third'_`v') tag(`"`third'_`v' (``third'_`v'[Original_Varname]'): ``n'_rsn' visit reason should be missing if no value provided in `third'"') `standard_values' sheet(`sheet_name')
			
			} // end reason values
			
			di "				Other specified ..... "
			
			assertlist !missing(`third'_other) if `third'_96 == 1, list(`third' `third'_96) tag(`"`third'_other (``third'_other[Original_Varname]'): ``n'_rsn' visit Other reason should be populated since they selected it in `third'_96 (``third'_96[Original_Varname]')"') `standard_values' sheet(`sheet_name')
			assertlist missing(`third'_other) if `third'_96 != 1, list(`third' `third'_96) tag(`"`third'_other (``third'_other[Original_Varname]'): ``n'_rsn' visit Other reason should be missing since they did not select it in `third'_96 (``third'_96[Original_Varname]')"') `standard_values' sheet(`sheet_name')
			
		} // end visit number loop
		
		
		* Confirm that the reasons that prevented more antenatal care since last call are appropriately filled out
		assertlist missing(m2_320) if m2_301 == 1, list(m2_301 m2_320) tag(`"m2_320 (`m2_320[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')
		assertlist !missing(m2_320) if m2_301 == 0 & m2_202 == 1, list(m2_301 m2_320) tag(`"m2_320 (`m2_320[Original_Varname]'): Should be populated"') `standard_values' sheet(`sheet_name')

		assertlist missing(m2_320_0) if m2_301 == 1, list(m2_301 m2_320_0) tag(`"m2_320_0 (`m2_320_0[Original_Varname]'): Should be missing since said got ANC"') `standard_values' sheet(`sheet_name')
		assertlist inlist(m2_320_0,0,1) if m2_301 == 0 & m2_202 == 1, list(m2_301 m2_320_0) tag(`"m2_320_0 (`m2_320_0[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		
		
		foreach v in 1 2 3 4 5 6 7 8 9 10 11 96 99 {
			assertlist missing(m2_320_`v') if m2_301 == 1, list(m2_301 m2_320_`v') tag(`"m2_320_`v' (`m2_320_`v'[Original_Varname]'): Should be missing since said got ANC"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_320_`v') if m2_301 == 1 & m2_320_0 == 1, list(m2_301 m2_320_0 m2_320_`v') tag(`"m2_320_`v' (`m2_320_`v'[Original_Varname]'): Should be missing since said `:var label m2_320_0'"') `standard_values' sheet(`sheet_name')

			assertlist inlist(m2_320_`v',0,1) if m2_301 == 0 & m2_202 == 1, list(m2_202 m2_301 m2_320_`v') tag(`"m2_320_`v' (`m2_320_`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		}
		
		
		
		assertlist inlist(m2_321,0,1,2,3,12,98,99) if m2_202 == 1, list(m2_202 m2_321) tag(`"m2_321 (`m2_321[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		
		foreach v in 0 1 2 3 98 99 {
			assertlist inlist(m2_321_`v',0,1) if m2_202 == 1 & !missing(m2_321), list(m2_202 m2_321 m2_321_`v') tag(`"m2_321_`v' (`m2_321_`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name') 
			assertlist missing(m2_321_`v') if missing(m2_321) & m2_202 == 1, list(m2_321 m2_321_`v') tag(`"m2_321_`v'(`m2_321_`v'[Original_Varname]'): Should be missing if missing m2_321"') `standard_values' sheet(`sheet_name') 
		}
		
		
		drop m2_*_wc
		
		
		
		* Confirm that if respondent is not still pregnant that they did not answer the other questions in this module
		foreach v of varlist m2_3*  {
			replace not_pregnant = 1 if !missing(`v')
		}
		
		****************************************************************************
		****************************************************************************
		****************************************************************************
		
		* Complete the checks on the User Experience variables
		local sheet_name User Experience
		
		forvalues i = 1/5 {
			assertlist inlist(m2_40`i',1,2,3,4,5,99) if m2_202 == 1 & m2_302 >= `i' & !missing(m2_302), list(m2_202 m2_302 m2_40`i') tag(`"m2_40`i' (`m2_40`i'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_40`i') if m2_302 < `i' , list(m2_302 m2_40`i') tag(`"m2_40`i' (`m2_40`i'[Original_Varname]'): Should be missing as they did not have `i' consultations"') `standard_values' sheet(`sheet_name')
		}
		
		* Confirm that if respondent is not still pregnant that they did not answer the other questions in this module
		foreach v of varlist m2_4*  {
			replace not_pregnant = 1 if !missing(`v')
		}
		
		
		****************************************************************************
		****************************************************************************
		****************************************************************************
		
		* Complete the checks on the Content of Care variables
		local sheet_name Content of Care
		
		foreach v in a b c d e f g {
			assertlist inlist(m2_501`v',0,1,98,99) if m2_301 == 1 , list(m2_301 m2_501`v') tag(`"m2_501`v' (`m2_501`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_501`v') if m2_301 != 1 & m2_202 == 1 , list(m2_301 m2_501`v') tag(`"m2_501`v' (`m2_501`v'[Original_Varname]'): Should be missing because did not have any new consultations"') `standard_values' sheet(`sheet_name')
		}
		
		assertlist inlist(m2_502,0,1,98,99) if m2_202 == 1, list(m2_202 m2_502) tag(`"m2_502 (`m2_502[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		
		foreach v in a b c d e f {
			assertlist inlist(m2_503`v',0,1,98,99) if m2_502 == 1, list(m2_502 m2_503`v') tag(`"m2_503`v' (`m2_503`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_503`v') if m2_502 != 1 & m2_202 == 1, list(m2_502 m2_503`v') tag(`"m2_503`v' (`m2_503`v'[Original_Varname]'): Should be missing if said did not receive test results"') `standard_values' sheet(`sheet_name')
		
			assertlist inlist(m2_505`v',0,1,98,99) if m2_503`v' == 1, list(m2_503`v' m2_505`v') tag(`"m2_505`v' (`m2_505`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_505`v') if m2_503`v' != 1 & m2_202 == 1, list(m2_503`v' m2_505`v') tag(`"m2_505`v' (`m2_505`v'[Original_Varname]'): Should be missing if said did not receive test results"') `standard_values' sheet(`sheet_name')

		}
		
		assertlist inlist(m2_504,0,1) if m2_502 == 1 & m2_202 == 1, list(m2_502 m2_504) tag(`"m2_504 (`m2_504[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_504) if m2_502 != 1, list(m2_502 m2_504) tag(`"m2_504 (`m2_504[Original_Varname]'): Should not have answered if said did not receive any other test results"') `standard_values' sheet(`sheet_name')
		
		assertlist inlist(m2_505g,0,1,98,99) if m2_504 == 1, list(m2_504 m2_505g) tag(`"m2_505g (`m2_505g[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_505g) if m2_504 != 1 & m2_202 == 1, list(m2_504 m2_505g) tag(`"m2_505g (`m2_505g[Original_Varname]'): Should be missing if said did not receive any other test results"') `standard_values' sheet(`sheet_name')

		foreach v in a b c d {
			assertlist inlist(m2_506`v',0,1,98,99) if m2_301 ==1, list(m2_301 m2_506`v') tag(`"m2_506`v' (`m2_506`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_506`v') if m2_301 !=1 & m2_202 == 1, list(m2_301 m2_506`v') tag(`"m2_506`v' (`m2_506`v'[Original_Varname]'): Should be missing if said did not have a consultation"') `standard_values' sheet(`sheet_name')
		}
		
		gen any_symptoms = 0 if m2_202 == 1
		foreach v in m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h {
			replace any_symptoms = 1 if `v' == 1
		}
		
		foreach v in 1 2 3 4 5 6 7 96 98 99 {
			assertlist inlist(m2_507_`v',0,1,98,99) if any_symptoms == 1 , list(m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_507_`v') tag(`"m2_507_`v' (`m2_507_`v'[Original_Varname]'): Invalid value if said had any symptoms in m2_203a-m2_203h (`m2_203a[Original_Varname]'-`m2_203h[Original_Varname]')"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_507_`v') if any_symptoms == 0 & m2_202 == 1, list(m2_203a m2_203b m2_203c m2_203d m2_203e m2_203f m2_203g m2_203h m2_507_`v') tag(`"m2_507_`v' (`m2_507_`v'[Original_Varname]'): Should be missing if did not experience any symptoms in in m2_203a-m2_203h (`m2_203a[Original_Varname]'-`m2_203h[Original_Varname]')"') `standard_values' sheet(`sheet_name')

		}
		
		
		gen m2_205 = 0
		replace m2_205 = m2_205a  if !inlist(m2_205a,99,.) 
		replace m2_205 = m2_205 + m2_205b if !inlist(m2_205b,99,.)
		
		assertlist inlist(m2_508a,0,1,98,99) if m2_205 >= 3, list(m2_205a m2_205b m2_508a) tag(`"m2_508a (`m2_508a[Original_Varname]'): Invalid value if had a combined score of >= 3 in m2_205a and m2_205b (`m2_205a[Original_Varname]' and `m2_205b[Original_Varname]')"') `standard_values' sheet(`sheet_name')
		
		assertlist missing(m2_508a) if m2_205 < 3 & m2_202 == 1, list(m2_205a m2_205b m2_508a) tag(`"m2_508a (`m2_508a[Original_Varname]'): Should be missing as did not have a score >= 3 for m2_205a m2_205b (`m2_205a[Original_Varname]' and `m2_205b[Original_Varname]')"') `standard_values' sheet(`sheet_name')

		drop m2_205
		
		rename m2_508b_num m2_508b
		rename m2_508c_time m2_508c
		
		local b 1 10
		local c 10 60
		foreach v in b c {
			local l1 = word("``v''",1)
			local l2 = word("``v''",2)
			assertlist (m2_508`v' >= `l1' & m2_508`v' <= `l2') | inlist(m2_508`v',98,99) if m2_508a == 1, list(m2_508a m2_508`v') tag(`"m2_508`v' (`m2_508`v'[Original_Varname]'): Invalid value, should have between `l1'-`l2'"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_508`v') if m2_508a != 1 & m2_202 == 1, list(m2_508a m2_508`v') tag(`"m2_508`v' (`m2_508`v'[Original_Varname]'): Should be missing if did not have any sessions"') `standard_values' sheet(`sheet_name')
		}
		
		foreach v in a b c {
			assertlist inlist(m2_509`v',0,1,98,99) if m2_301 == 1, list(m2_301 m2_509`v') tag(`"m2_509`v' (`m2_509`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(m2_509`v') if m2_301 != 1 & m2_202 == 1, list(m2_301 m2_509`v') tag(`"m2_509`v' (`m2_509`v'[Original_Varname]'): Should be missing if did not have a consultation"') `standard_values' sheet(`sheet_name')
		}
		

			* Confirm that if respondent is not still pregnant that they did not answer the other questions in this module
		foreach v of varlist m2_5*  {
			replace not_pregnant = 1 if !missing(`v')
		}
		****************************************************************************
		****************************************************************************
		****************************************************************************
		
		* Complete the checks on the New Medications variables
		local sheet_name New Medications
		
		gen any_medicines = 0
		foreach v in a b c d e f g h i j k l m n o {
			assertlist inlist(m2_601`v',0,1,98,99) if m2_202 == 1, list(m2_202 m2_601`v') tag(`"m2_601`v' (`m2_601`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			replace any_medicines = 1 if m2_601`v' == 1
		}
		
		assertlist !missing(m2_602b) if any_medicines == 1 & m2_202 == 1, list(m2_202 m2_602b m2_601a-m2_601o m2_601o_other) tag(`"m2_602b (`m2_602b[Original_Varname]'): Should have an amount if said bought medications in m2_601a-m2_601o (`m2_601a[Original_Varname]'-`m2_601o[Original_Varname]')"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_602b) if any_medicines == 0 & m2_202 == 1, list(m2_202 m2_602b) tag(`"m2_602b (`m2_602b[Original_Varname]'): Should be missing since said did not buy any medications (`m2_601a[Original_Varname]'-`m2_601o[Original_Varname]')"') `standard_values' sheet(`sheet_name')

		assertlist inlist(m2_603,0,1,98,99) if m2_202 == 1, list(m2_202 m2_603) tag(`"m2_603`v' (`m2_603`v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		
			* Confirm that if respondent is not still pregnant that they did not answer the other questions in this module
		foreach v of varlist m2_6*  {
			replace not_pregnant = 1 if !missing(`v')
		}
		****************************************************************************
		****************************************************************************
		****************************************************************************
		
		* Complete the checks on the Cost variables
		local sheet_name Costs
		
		assertlist inlist(m2_701,0,1,98,99) if m2_202 == 1, list(m2_202 m2_701) tag(`"m2_701 (`m2_701[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		
		foreach v in m2_702a_cost m2_702b_cost m2_702c_cost m2_702d_cost m2_702e_cost  {
			assertlist !missing(`v') if m2_701 == 1, list(m2_701 `v') tag(`"`v' (``v'[Original_Varname]'): Should be populated"') `standard_values' sheet(`sheet_name')
			assertlist missing(`v') if m2_701 != 1 & m2_202 == 1, list(m2_701 `v') tag(`"`v' (``v'[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')
		}

		assertlist inlist(m2_703,0,1) if m2_701 == 1, list(m2_701 m2_703) tag(`"m2_703 (`m2_703[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
		assertlist missing(m2_703) if m2_701 != 1 & m2_202 == 1, list(m2_701 m2_703) tag(`"m2_703 (`m2_703[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')

		foreach v in m2_705_1 m2_705_2 m2_705_3 m2_705_4 m2_705_5 m2_705_6 m2_705_96 {
			assertlist inlist(`v',0,1) if m2_701 == 1, list(m2_701 `v') tag(`"`v' (``v'[Original_Varname]'): Invalid value"') `standard_values' sheet(`sheet_name')
			assertlist missing(`v') if m2_701 != 1 & m2_202 == 1, list(m2_701 `v') tag(`"`v' ``v'[Original_Varname]'): Should be missing"') `standard_values' sheet(`sheet_name')
		}
		
		split m2_705, gen(m2_705_v)	destring
		
		foreach v in 1 2 3 4 5 6 96 {
			assertlist m2_705_`v' == 1 if (m2_705_v1 == `v'  | m2_705_v2 == `v') & m2_701 == 1, list(m2_701 m2_705 m2_705_`v') tag(`"Inconsistent between the two variables: Specified `v' in m2_705 (`m2_705[Original_Varname]'), should have also been specified in m2_705_`v'(`m2_705_`v'[Original_Varname]')"')  `standard_values' sheet(`sheet_name')
			assertlist m2_705_`v' == 0 if m2_705_v1 != `v' & m2_705_v2 != `v' & m2_701 == 1, list(m2_701 m2_705 m2_705_`v') tag(`"Inconsistent between the two variables: Did not specify `v' in m2_705 (`m2_705[Original_Varname]'), so m2_705_`v' (`m2_705_`v'[Original_Varname]') should be 0"')  `standard_values' sheet(`sheet_name')

		}
		
		drop m2_705_v*
		
		foreach v of varlist m2_7*  {
			replace not_pregnant = 1 if !missing(`v')
		}
		
		local sheet_name Survey Cont Error
		
		assertlist not_pregnant == 0 if m2_202 != 1 & m2_permission == 1, list(m2_202) tag(Survey continued even though not pregnant) `standard_values' sheet(`sheet_name')

		
		****************************************************************************
		****************************************************************************
		****************************************************************************

		assertlist_cleanup, excel(Module_2_Data_Quality_checks.xlsx)
		
		* add a single tab with all the ids in one row
		assertlist_export_ids, excel(Module_2_Data_Quality_checks.xlsx) 
