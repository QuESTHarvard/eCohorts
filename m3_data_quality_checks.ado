* m3_data_quality_checks
/*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
* 2024-08-27	1.00	MK Trimner		Original Program
*******************************************************************************
*/

capture program drop m3_data_quality_checks
program define m3_data_quality_checks

	local country =lower("${Country}")

	if "`excel'" == "" local excel Module_3_Data_uality_checks.xlsx
	if "`output'" == "" local output ${`country'_data}
	
	* CD to the location that you want to save the D checks
	cd "`output'"

	* Erase the older version of this excel file
	capture erase "`excel'"
	
	* Set up a local with the standard assertlist values that will be used for all assertions
	local ids m3_respondentid 
	local standard_values idlist(`ids') excel(`excel')
	
	****************************************************************************
	****************************************************************************
	****************************************************************************
	
	* Complete the checks on the Identification variables
	local sheet_name Identification
	
	assertlist m3_permission == 1, list(m3_permission) tag(m3_permission (`=m3_permission[Original_${Country}_Varname]') should be set to 1 (Yes) for all respondents) `standard_values' sheet(`sheet_name')
	
	
	
	
	* confirm that date delivered was before survey date	
	
	
	* Confirm that the values in 405 are the values selected in 405_1-405_96
		
				* The same for 408 and 411
				
		* Confirm the values in 519 are the same as those selected in 519_1-519_99
	

end