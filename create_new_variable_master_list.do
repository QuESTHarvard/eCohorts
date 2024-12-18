cd "${data_doc}"

capture erase "New_Variable_master_list.xlsx" 

	capture postclose mkt0
	postfile mkt0 str80(country varname original_varname label) using variable_list_0, replace

	* Now create it for the M0 datasets
	foreach c in ET KE ZA IN {
		local lc = lower("`c'")
		use "${`lc'_data_final}/eco_m0_`lc'", clear
		
		foreach v of varlist * {
				local name =substr("`v'",1,29)

				post mkt0 ("`c'_") ("`v'") ("``v'[Original_`c'_Varname]'") ("`:var label `v''") 
				
			} // end variable loop
		} // end country loop
		postclose mkt0
		
		use variable_list_0, clear
		compress
		
		reshape wide @original_varname @label , i(varname) j(country) string

		sort varname ET_label KE_label ZA_label IN_label
		
		
		foreach v of varlist * {
			label var `v' "`=subinstr("`v'","_"," ",.)'"
		}
		
		label var varname "Standardized Variable Name" 
		save variable_list_0, replace
		local sheetname M0

		export excel _all using "New_Variable_master_list.xlsx", sheet("`sheetname'", replace) first(varl)

		capture erase variable_list_0.dta

	foreach i in 1 2 3 4 5 6 {
		capture postclose mkt`i'
		postfile mkt`i' str80(country varname original_varname label) using variable_list_`i', replace
		
		local clist1 ET KE ZA IN 
		local clist2 ET KE ZA IN 
		local clist3 ET KE ZA IN 
		local clist4 ET KE ZA 
		local clist5 ET KE
		local clist6 ET KE ZA
		
		foreach c in `clist`i'' {
			local lc =lower("`c'")
			use "$`lc'_data_final/eco_`c'_Complete", clear
					 			
			foreach v of varlist * {
				local name =substr("`v'",1,29)

				if "``v'[Module]'" == "`i'" post mkt`i' ("`c'_") ("`v'") ("``v'[Original_`c'_Varname]'") ("`:var label `v''") 
				
			} // end variable loop
		} // end country loop
		postclose mkt`i'
		
		use variable_list_`i', clear
		capture gen ZA_label = ""
		capture gen IN_label = ""
		capture gen ZA_original_varname = ""
		capture gen IN_original_varname = ""
		
		reshape wide @original_varname @label , i(varname) j(country) string
		
		 
		sort varname ET_label KE_label ZA_label IN_label
		foreach v of varlist * {
			label var `v' "`=subinstr("`v'","_"," ",.)'"
		}
		
		label var varname "Standardized Variable Name" 

		save variable_list_`i', replace
		
		local sheetname M`i'
		if `i' == 6 local sheetname MCARD
		
		export excel _all using "New_Variable_master_list.xlsx", sheet("`sheetname'", replace) first(varl)
		capture erase variable_list_`i'.dta
		
	} // end module loop
