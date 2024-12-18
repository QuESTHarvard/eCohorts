capture program drop create_module_codebook
program define create_module_codebook

	syntax, country(string asis) codebook_folder(string asis) outputfolder(string asis) module_number(string asis) module_dataset(string asis) id(string asis) [date_variables(string asis) SPECIAL]
	capture mkdir "`codebook_folder'/M`module_number'"
	local codebook_folder "`codebook_folder'/M`module_number'"	
	cd "`codebook_folder'"

	* Set this local to pass through for special values
	local when notalways
	
	local country = lower("`country'")
	if inlist("`country'","et","ethiopia") local c_n 1
	if inlist("`country'","ke","kenya") local c_n 2
	if inlist("`country'","za","south africa") local c_n 3
	if inlist("`country'","in","india") local c_n 4
	
	if strlen("`country'") > 2 local country =substr("`country'",1,2)
	if "`country'" == "so" local country za
	
	
	local ucountry = upper("`country'")
	global Country `ucountry'

	 
	use "${`country'_data_final}/`module_dataset'", clear

	* Only keep those form the module # dataset
	//capture rename respondentid m`module_number'_respondentid 
	 

	foreach v of varlist * {
		if !inlist("`v'","country") & "``v'[Module]'" != "`module_number'" & !inlist("`v'","respondentid")  drop `v'  
	}
	
	if "`module_number'" == "2" {
		foreach v of varlist m2_maternal_death_learn_oth*_r*	{
			capture rename `v' `=subinstr("`v'","m2_maternal_death_learn_other_r","m2_maternal_dealth_learn_oth_r",1)'
		}	
	}
	
	* Create a dataset that has all the original variables names
	capture postclose mkt
	postfile mkt str85(new_varname original_varname label) using `country'_M`module_number'_original_vars, replace
	foreach v of varlist * {
		post mkt ("`v'") ("``v'[Original_`ucountry'_Varname]'") ("`:var label `v''")
	}
	postclose mkt
	preserve
	
	use `country'_M`module_number'_original_vars, clear
	label var new_varname "New Variable Name"
	label var original_varname "Original Variable Name"
	local var label "Variable Label"
	compress
	restore
	
	
	* Confirm the date format is correct for all date variables		
	local exit 0
	foreach v in `date_variables' {
		capture confirm variable `v'
		if _rc == 0 {
			count if !missing(`v')
			if `r(N)' > 0 {
				
				local format `:format `v''
				di "`format'"
				local type = substr("`format'",1,3)
				
				if "`type'" != "%td" {
					di as error "var `v' is not in date format, correct and rerun"
					local exit 1
				}
					
			} // End loop to count if missing value in the variable
		} // end loop to confirm variable exists in the dataset
	}
	
	if `exit' == 0 {
	
		/*gen country_value = `n'
		label var country_value "Country"
		label define country_value 1 "Ethiopia" 2 "Kenya" 3 "South Africa" 4 "India", replace
		label value country_value country_value
		*/	
		 
		order country respondentid
		
		
		* We want to wipe out any value labels that have the values of 98 or 99 because we are not using these any more
		/*foreach v of varlist * {
			
			if inlist("`:var label `v''", "Respondent ID","study_id") & "`v'" != "respondentid" drop `v'
			
			* We want to destring all variables if possible
			capture destring `v', replace

			local label `:value label `v''
			if "`label'" != "" { // If there is a value label continue
				label list `label'
				return list
				
				local 98 `:label `label' 98'
				local 99 `:label `label' 99'
				*if "${Country}" == "KE" & "`99'"=="" local 99 `:label `label' 999'
				
				local nr 
				local dnk 
				if "`99'" != "99" 	local nr 99
				if "`98'" != "98" & "`nr'" == "99"	local dnk 98,
				if "`98'" != "98" & "`nr'" == ""	local dnk 98
				if `r(max)' >= 98 { // If the highest value is >= 98 continue
					local label_values
					forvalues i = `r(min)'/`r(max)' { // Loop through the min to max values
					
						* If this `i' value has a label associated with it that is not DNK or NR, pass it through
						if !inlist(`i',`dnk'`nr') & !inlist("`:label `label' `i''","","`i'") local label_values `label_values' `i' "`:label `label' `i''"
						
					} // end the loop through min to max values
					
					* Define the updated value label minus the DNK and NR values
					if `"`label_values'"' != "" label define `label' `label_values', replace
					
					* If there are no longer any value labels we want to remove this value label from the variable
					if `"`label_values'"' == "" label value `v' 
				}
			}
		}*/
		
		//if `module_number' == 6 rename m6_respondentid mcard_respondentid
		save M`module_number'_`country'_data, replace
		char list
		
		if "`special'"=="special" {
			
		* grab all the variables and var types to create the trt file
		capture postclose mkt 	
		postfile mkt str85(var vartype) using M`module_number'_`country'_codebook_trt, replace
		
		capture postclose mktspecial
		postfile mktspecial str500(vartype variable value label when who) using M`module_number'_`country'_special_values, replace

		
			foreach v of varlist * {
				
				di "`v'"
				local type freq
				local format = "`:format `v''"
				if `=strpos("`:type `v''","str")' != 1 & "`:value label `v''" == "" local type univ
				if `=strpos("`:type `v''","str")' == 1 local type open

				if "`v'"=="respondentid" local type open
				*if "`v'"=="mcard_respondentid" local type open

				if "`=substr("`format'",1,3)'" == "%td" local type date
				di "`type'"
				if "`=substr("`format'",1,3)'" == "%tc" local type time
				di "`type'"
				
				if inlist("`type'","univ") {
					levelsof `v', local(llist)
					local wc = wordcount(`"`llist'"')
					if `wc' < 3  local type freq
				}
			
				post mkt ("`v'") ("`type'")
				
				
				local var_type numeric
				if `=strpos("`:type `v''","str")' == 1 	local var_type string
				
				local label 
				if `=strpos("`:type `v''","str")' != 1 count if missing(`v')
				if `=strpos("`:type `v''","str")' == 1 count if inlist(`v',"",".",".a",".r",".d",".n",".i")

				if `r(N)' > 0 {
					
					
					di "`v'"
					if "`var_type'" == "numeric" {
						local label `:value label `v''
						if "`label'" == "" {
							local label `v'
							label define `label', replace
							*label value `v' `label'
						}
									
						local a Skipped appropriately due to survey logic
						local d Don't' Know
						local r No Response/Refused to answer
						local n No information // This is specifically for ET
						local i Invalid Date
						
						foreach m in a d r n i {
							count if `v' == .`m'
							if `r(N)' > 0 & inlist("`:label `label' .`m''",".`m'") 	{
								label define `label' .`m' "``m''", modify
								label value `v' `label'
							}
							label list `label'
						}
					}
					
					preserve
					keep `v'
					if `=strpos("`:type `v''","str")' != 1 keep if missing(`v')
					if `=strpos("`:type `v''","str")' == 1 keep if inlist(`v',"",".a",".r",".d",".n",".i")
					
					duplicates drop		
					
														
						local a Skipped appropriately due to survey logic
						local d Don't' Know
						local r No Response/Refused to answer
						local n No information // This is specifically for ET
						local i Invalid Date

					
					forvalues b = 1/`=_N' {
						
						local f `=`v'[`b']'
						di "`f'"
					
						local raw =substr("`f'",2,.)
						di "`raw'"
						if "`f'"!= "" local value_label ``raw''
						
						if inlist("`f'",".","") local value_label Missing
						if "`label'" != "" {
							if !inlist("`:label `label' `=`v'[`b']''",".","") local value_label `:label `label' `=`v'[`b']''
						}
						post mktspecial ("`var_type'") ("`v'") ("`=`v'[`b']'") ("`value_label'") ("`when'") ("isinlist")
						
						
					}			
					restore
					
				}
			}

			postclose mkt
			postclose mktspecial
			
			use M`module_number'_`country'_codebook_trt, clear
			compress
			
			export delimited using M`module_number'_`country'_codebook_trt, novarnames replace
			
			use M`module_number'_`country'_special_values, clear
			compress
			
			replace variable = "_all" 
			duplicates drop

			save, replace

			export delimited using M`module_number'_`country'_special_values, novarnames replace
		}
		
		
		local sheetname M`module_number'

		if `module_number' == 6 	local sheetname MCARD
				
		harvard_codebook, keys(respondentid, country) ///
		datafolder("`codebook_folder'") /// //codebook_folder("`codebook_folder'") ///
		datasetlist(M`module_number'_`country'_data) ///
		templatefolder("`codebook_folder'") ///
		summarytrt("`codebook_folder'\M`module_number'_`country'_codebook_trt.csv") ///
		specialvalues("`codebook_folder'\M`module_number'_`country'_special_values.csv") ///
		outputfolder ("`outputfolder'") sheet("`sheetname'") excel
	} // if contains valid dates 
end


