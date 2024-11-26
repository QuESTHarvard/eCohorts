*! bgc_codebook version 1.03 - Dale Rhoda - 2024-10-16
*******************************************************************************
* Change log
* 				Updated
*				version
* Date 			number 	Name			What Changed
* 2023-06-19	1.02	Dale Rhoda		Added version GM geometric mean option
* 2024-10-16	1.03	MK Trimner		Changed the value in postfile command in univblock for level2 from str30 to str50 to prevent label from being cut off	
* 2024-11-12	1.04	MK Trimner		Changed so that continuous variables only show mean, SD, missing and non-missing
*										Added sheet name option
*										Added code to export to excel after appends
*										Added excel export option
*******************************************************************************

capture program drop harvard_codebook
program harvard_codebook

version 14

syntax , DATAFOLDER(string) DATASETlist(string) SUMmarytrt(string) ///
[ TEMPlatefolder(string) KEYs(string) SPECialvalues(string) SKIP(string) ///
  QUEStiontext DROPZEROs OUTPUTFOLDER(string) GM SHEET(string) EXCEL]

* The templatefolder is where this program finds its include files
* and the default special missing value .csv file
*
* If the user does not specify it, then use c:\ado\personal\bgc_codebook
* Confirm the folder's existence and establish a global macro.
*

if "`gm'" == "gm" global GM gm // user has requested geometric means in univ summaries 
else global GM  

if "`templatefolder'" == "" local templatefolder c:\ado\personal\bgc_codebook\

if substr("`templatefolder'", -1, .) != "\" local templatefolder `templatefolder'\

confirmdir "`templatefolder'"

if `r(confirmdir)' != 0 {
	display as error "The templatefolder `templatefolder'  does not exist."
	display as error "Correct this error and try again."
	exit
}

if substr("`templatefolder'", -1, .) != "\" local templatefolder `templatefolder'\
global template_dir `templatefolder'

* The datafolder is where we expect to find the dataset and where we will put the codebook.
* Add a slash to the end of its name, if necessary.

if substr("`datafolder'", -1, .) != "\" local datafolder `datafolder'\

* If user doesn't specify, then put the finished codebook in the datafolder
if "`outputfolder'" == "" local outputfolder `datafolder'

if substr("`outputfolder'", -1, .) != "\" local outputfolder `outputfolder'\
di "`outputfolder'"

confirmdir "`datafolder'"

if `r(confirmdir)' != 0 {
	display as error "The datafolder `datafolder'  does not exist."
	display as error "Correct this error and try again."
	exit
}
cd "`datafolder'"

confirmdir "`outputfolder'"
if `r(confirmdir)' != 0 {
	display as error "The output folder `outputfolder'  does not exist."
	display as error "Correct this error and try again."
	exit
}

* Confirm the existence of the dataset(s)

foreach d in `datasetlist' {
	if substr("`d'",-4,.) != ".dta" local d `d'.dta
	capture confirm file "`d'"
	if _rc != 0 {
		display as error "The dataset `d' does not exist in the data folder `datafolder'."
		display as error "Correct this error and try again."
		exit
	}
}

* Confirm the existence of the mandatory summarytrt CSV file

capture confirm file "`summarytrt'"
if _rc != 0 {
	display as error "The summarytrt CSV file `summarytrt' is not being found."
	display as error "If it located in a folder other than `datafiles' then please specify its full path in the SUMmarytrt() option."
	display as error "Correct this error and try again."
	exit
}

* Confirm the existence of the special values file, if the user specifies one

if "`specialvalues'" != "" {
	capture confirm file "`specialvalues'"
	if _rc != 0 {
		display as error "The specialvalues CSV file `specialvalues' is not being found."
		display as error "If it located in a folder other than `datafiles' then please specify its full path in the SPECialvalues() option."
		display as error "Correct this error and try again."
		exit
	}
}

* Confirm the existence of the skip pattern file, if the user specifies one

if "`skip'" != "" {
	capture confirm file "`skip'"
	if _rc != 0 {
		display as error "The skip CSV file `skip' is not being found."
		display as error "If it located in a folder other than `datafiles' then please specify its full path in the SKIP() option."
		display as error "Correct this error and try again."
		exit
	}
}

* Confirm the existence of the question text file, if the user specifies one
/*
if "`questiontext'" != "" {
	capture confirm file "`questiontext'"
	if _rc != 0 {
		display as error "The questiontext CSV file `questiontext' is not being found."
		display as error "If it located in a folder other than `datafiles' then please specify its full path in the QUEStiontext() option."
		display as error "Correct this error and try again."
		exit
	}
}
*/

if "`keys'" != "" {
	if wordcount("`keys'") > 1 & strpos("`keys'", ",") == 0 {
		display as error "If you specify more than one variable in the KEYs option, they need"
		display as error "to be separated by commas."
		display as error "Correct this error and try again."
		exit
	}
}


*set trace on
*bgc_codebook , datafolder(C:\Documents and Settings\rhodad\My Documents\- Projects\Codebooks\testing) dataset(rhodatest) key(a b) sum(rhodatest codebook treatment.csv)
*set trace off


***************************************************************************************
* Finished checking the prima facie validity of the command line options
***************************************************************************************
capture log close
log using bgc_codebook_logfile.txt, text replace

set more off

* Establish the project directory and CD to it (a second time, so it is recorded in the logfile)
global project_dir `datafolder'
cd "`datafolder'"

global temp_dir = "${project_dir}tempfiles\"	
capture mkdir "$temp_dir"

* Note that the program write_special_values_code actually writes the
* Program named ${temp_dir}special_missing_code.do"

if "`specialvalues'" == "" write_special_values_code "c:/ado/personal/bgc_codebook/special values template.csv"
else write_special_values_code "`specialvalues'"

do `"${temp_dir}special_missing_code.do"'


prepare_block_commands "`summarytrt'" , `dropzeros'
if _rc == 9 exit

foreach dataset in `datasetlist' {

	* Store intermediate results in this folder 
	global storage_dir = "${project_dir}\tempfiles\" + "`dataset'" + "\"	
	capture mkdir "$storage_dir"

	* Don't save individual HTML blocks 
	global save_html_blocks 0
	* Clean up *
	global cb_debugging 0
	
 	cd "${project_dir}"

	* Make a dataset that describes the dataset 
	make_descsave_dataset `dataset' var_label(`var_label')

	* Populate the KEY variable 
	if "`keys'" != "" {
		use "${storage_dir}descsave", clear
		local keys = subinstr("`keys'",", ",`"", ""', .)
		replace key = "Y" if inlist( newvar, "`keys'")
		save "${storage_dir}descsave", replace
	}


	* Summarize all the variables 
	
	include "${temp_dir}block_commands.do"
				
	* Concatenate the summaries 

	cd "$storage_dir"

	include "${temp_dir}append_commands.do"
	
	sort varnum order
	
	bysort varnum: replace order = _n
	replace value2 = round(value2, 0.00001)
	
	save codebook_dataset_for_`dataset', replace
	
	cd "$project_dir"
	
	if "`excel'" == "excel" {
		preserve
		
		label var varnum "Order of Variable"
		label var newvar "Variable Name" 
		label var orgvar "Original Dataset Variable name" 
		label var label "Variable Label"
		label var key "Key"
		label var vartype "Variable Type"
		label var length "Variable Length" 
		label var level1 "Response Category" 
		label var level2 "Response Category Description"
		label var value1 "Number of Observations / Distribution Summary"
		label var value2 "Percent of Population" 
		 
		drop order summary_block_type
		di "`outputfolder'\${Country}_Codebooks.xlsx"
	
		export excel "`outputfolder'\${Country}_Codebooks.xlsx", sheet("`sheet'", replace) first(varl) 
		
		restore 
		
		preserve
		gen row = _n + 1
		
		egen start = min(row), by(varnum)
		egen end = max(row), by(varnum)

		rename summary_block_type type
		tempfile mkt
		save `mkt', replace
		
		levelsof varnum, local(vlist)
		foreach v in `vlist' {
			use `mkt', clear
			keep if varnum == `v'
			foreach var in start end type varnum newvar orgvar label key vartype length level2 {
				local `var'_`v' = `var'[1]
			}
		}
		
		local lastcol K
		local col_end 11
		local rows `=_N + 1'
		restore
		
		

		preserve
		putexcel set "`outputfolder'\${Country}_Codebooks.xlsx", modify sheet("`sheet'")

		* Merge the cells together
		foreach v in `vlist' {
			
			putexcel A`start_`v'':A`end_`v'' = "`varnum_`v''", merge
			putexcel B`start_`v'':B`end_`v'' = "`newvar_`v''", merge
			putexcel C`start_`v'':C`end_`v'' = "`orgvar_`v''", merge
			putexcel D`start_`v'':D`end_`v'' = "`label_`v''", merge
			putexcel E`start_`v'':E`end_`v'' = "`key_`v''", merge
			putexcel F`start_`v'':F`end_`v'' = "`vartype_`v''", merge
			putexcel G`start_`v'':G`end_`v'' = "`length_`v''", merge
		
			if "`type_`v''" == "univ" {
				forvalues i = 1/`start_`v''/`end_`v'' {
					putexcel H`i':I`i' = "`level2_`v''", merge
				}
			}
		}
		exit 99
			
	
		
			/*putexcel A`start_`v'':A`end_`v'', hcenter top font("Arial","11","black") merge
			putexcel B`start_`v'':B`end_`v'', left top font("Arial","11","black") merge
			putexcel C`start_`v'':C`end_`v'', left top font("Arial","11","black") merge
			putexcel D`start_`v'':D`end_`v'', left top font("Arial","11","black") merge
			putexcel E`start_`v'':E`end_`v'', hcenter top font("Arial","11","black") merge
			putexcel F`start_`v'':F`end_`v'', hcenter top font("Arial","11","black") merge
			putexcel G`start_`v'':G`end_`v'', hcenter top font("Arial","11","black") merge
*/

	
		mata: b = xl()
		mata: b.load_book("`outputfolder'\${Country}_Codebooks.xlsx")
		mata: b.set_mode("open")
		mata: b.set_sheet("`sheet'")
		
		* Create format ids
		
		* Create a bold font
		mata: bold_font = b.add_fontid()
		mata: b.fontid_set_font(bold_font, "Arial", 11, "black")
		mata: b.fontid_set_font_bold(bold_font, "on" )
		mata: b.fontid_set_font_italic(bold_font, "off" )  
		
		* Create regular font
		mata: regular_font = b.add_fontid()
		mata: b.fontid_set_font(regular_font, "Arial", 11, "black")
		mata: b.fontid_set_font_bold(regular_font, "off" )
		mata: b.fontid_set_font_italic(regular_font, "off" )  

		* Add formatting for header row
		mata: header = b.add_fmtid()
		mata: b.fmtid_set_horizontal_align(header, "center")
		mata: b.fmtid_set_vertical_align(header, "center")
		mata: b.fmtid_set_fill_pattern(header, "solid","lightgray")
		mata: b.fmtid_set_text_wrap(header, "on")
		mata: b.fmtid_set_fontid(header, bold_font) 


		mata: b.set_fmtid(1,(1,15),header)
		
		foreach v in white gray {
			local color white
			if "`v'" =="gray" local color  242 242 242
			
			mata: left_`v' = b.add_fmtid()
			mata: b.fmtid_set_fontid(left_`v', regular_font) 
			mata: b.fmtid_set_horizontal_align(left_`v', "left")
			mata: b.fmtid_set_vertical_align(left_`v', "top")
			mata: b.fmtid_set_text_wrap(left_`v', "on")
			mata: b.fmtid_set_fill_pattern(left_`v', "solid","`color'")

			mata: center_`v' = b.add_fmtid()
			mata: b.fmtid_set_fontid(center_`v', regular_font) 
			mata: b.fmtid_set_horizontal_align(center_`v', "center")
			mata: b.fmtid_set_vertical_align(center_`v', "top")
			mata: b.fmtid_set_text_wrap(center_`v', "on")
			mata: b.fmtid_set_fill_pattern(center_`v', "solid","`color'")
			
			mata: center_number_`v' = b.add_fmtid()
			mata: b.fmtid_set_fontid(center_number_`v', regular_font) 
			mata: b.fmtid_set_horizontal_align(center_number_`v', "center")
			mata: b.fmtid_set_vertical_align(center_number_`v', "top")
			mata: b.fmtid_set_text_wrap(center_number_`v', "on")
			mata: b.fmtid_set_number_format(center_number_`v',"number")
			mata: b.fmtid_set_fill_pattern(center_number_`v', "solid","`color'")


			mata: right_`v' = b.add_fmtid()
			mata: b.fmtid_set_fontid(right_`v', regular_font) 
			mata: b.fmtid_set_horizontal_align(right_`v', "right")
			mata: b.fmtid_set_vertical_align(right_`v', "top")
			mata: b.fmtid_set_text_wrap(right_`v', "on")
			mata: b.fmtid_set_fill_pattern(right_`v', "solid","`color'")

			mata: percent_`v' = b.add_fmtid()
			mata: b.fmtid_set_fontid(percent_`v', regular_font) 
			mata: b.fmtid_set_horizontal_align(percent_`v', "center")
			mata: b.fmtid_set_vertical_align(percent_`v', "top")
			mata: b.fmtid_set_text_wrap(percent_`v', "on")
			mata: b.fmtid_set_number_format(percent_`v',"percent")
			mata: b.fmtid_set_fill_pattern(percent_`v', "solid","`color'")
			
		}
		* Now we want to alternate the colors for each row
		foreach v in `vlist' {
			local color white
			if `=mod(`v',2)' == 0 local color gray
			
			* Merge the rows that have the same values
			
			mata: b.set_fmtid((`start_`v'',`end_`v''),1, center_number_`color')
			
			mata: b.set_fmtid((`start_`v'',`end_`v''),(2,4), left_`color')
			mata: b.set_fmtid((`start_`v'',`end_`v''),(5,7), center_`color')
			
			if "`type_`v''" != "univ" {
				mata: b.set_fmtid((`start_`v'',`end_`v''),8, center_`color')
				mata: b.set_fmtid((`start_`v'',`end_`v''),9, left_`color')
			}
			
			if "`type_`v''" == "univ" 	mata: b.set_fmtid((`start_`v'',`end_`v''),(8,9), right_`color')

			mata: b.set_fmtid((`start_`v'',`end_`v''),10, right_`color')
			mata: b.set_fmtid((`start_`v'',`end_`v''),11, percent_`color')

		}
		
		
		mata b.set_column_width(1,1,10)
		mata b.set_column_width(2,3,26)
		mata b.set_column_width(4,5,35)
		mata b.set_column_width(6,6,6)
		mata b.set_column_width(7,8,10)
		mata b.set_column_width(9,10,18)
		mata b.set_column_width(11,13,13)

		mata b.set_row_height(1,1,60)
		mata b.close_book()	
		putexcel close

		restore
	}
	
	exit 99
	
	

* Someday we may wish to put more than just question text above
* the summary block, so I have put hooks in place to write any number
* of rows above the block.  That number is specified as the second
* argument to the program write_html_summary.  For the time being, 
* that parameter takes values of 0 or 1. -DAR 2011-01-04

	if "`questiontext'" != "" local blank_rows_above 1
	else local blank_rows_above 0

	if "`excel'" =="" write_html_summary "`outputfolder'CODEBOOK_`dataset'.html" `blank_rows_above'

}

end


* comfirmdir Version 1.1 dan.blanchette@duke.edu  22Jan2009
* Center of Entrepreneurship and Innovation Duke University's Fuqua School of Business
* confirmdir Version 1.1 dan_blanchette@unc.edu  17Jan2008
* research computing, unc-ch
*  - made it handle long directory names
** confirmdir Version 1.0 dan_blanchette@unc.edu  05Oct2003
** the carolina population center, unc-ch

capture program drop confirmdir
program define confirmdir, rclass
 version 8
 
 local cwd `"`c(pwd)'"'
 quietly capture cd `"`1'"'
 local confirmdir=_rc 
 quietly cd `"`cwd'"'
 return local confirmdir `"`confirmdir'"'
 
end 



/* Stata programs for building Excel codebook summaries.  These programs were inspired by SAS macros in
   Shawna Collins' program named AlternativeCodebook.sas.
   
   This package relies upon the user-written descsave program.  You must acquire that and install it on 
   your PC before running these programs.  Type 'search descsave, all' in Stata to find and then install 
   that package.
   
   There are several programs here.
   
   program CntUniq is used internally by make_descsave_dataset; I grabbed it out of Stata's codebook program
   and modified it for my own use.
   
   program make_descsave_dataset - constructs a dataset named descsave that describes the dataset in question.  
   That dataset is massaged and augmented and saved for later use.  Among other things, it contains seven of 
   the desired summary variables (varnum newvar order label key vartype length). The way those are formatted 
   never changes, so they are constructed just once.  It also contains a variable that shows the number of
   unique values in each variable...that may be helpful for deciding how to summarize the variable.  (i.e., A 
   string variable with 500 unique values is probably open text and should be summarized using openblock.  A 
   string variable with 5 unique values is probably categorical and should be summarized using freqblock. 
   (Note:  As of early November 2010, we don't use this technique, but instead specify explicitly how each 
   variable should be summarized.)
   
   The remaining four summary variables (level1,level2, value1, and value2) are used in five different ways
   for five sorts of variables.  Those are populated using one of the other five programs in this file:
      
   1. program emtyblock  - uses only the chracteristics in the descsave dataset...
                           level1, level2, value1, and value2 are all missing; their cells are merged in
						   the HTML table output.
			
   2. program freqblock  - summarizes the variable using a frequency table: level 1 is the variable value or level,
                           level2 is its label, if any, value1 lists the frequency with which that level is
						   observed, and value2 lists the proportion of observations at that level

   3. program univblock - summarizes the variable using output like that from PROC UNIVARIATE or 
                           PROC MEANS:  min, max, p10, p25, p50, p75, p90, stddev, stderr.  Level1 is missing,
						   level2 contains a label, value1 contains a value, and value2 is missing.
						   The cells for level1 and level2 are merged in the HTML table output.
						   
   4. program openblock  - summarizes a variable containing open text with three lines: one that lists
                           the number of non-missing responses and one that lists the number of 
						   missing responses.  Again, level1 is missing, level 2 contains a label, 
						   value1 contains a value (count) and value2 contains a proportion.  
						   The cells for level1 and level2 are merged in the HTML table output.
						   
   5. program dateblock  - summarizes a variable containing a date; uses four lines: one that lists the earliest
                           date in the dataset and one that lists the latest date, one that lists the number of
						   non-missing dates and one that lists the number of missing dates.  Again, level 1 is 
						   missing, level2 contains a label, value 1 contains a date, and value2 is missing.
						   The cells for level1 and level2 are merged in the HTML table output.
								   
   6. program yearblock  - summarizes a variable containing a year; uses two lines: one that lists the earliest
                           year in the dataset and one that lists the latest date.  Again, level 1 is missing,
						   level2 contains a label, value 1 contains a date, and value2 is missing.
						   The cells for level1 and level2 are merged in the HTML table output.

    We may add additional 'block' programs in the future to summarize variables in other ways.
	
	program write_html_summary writes the HTML codebook
							   
*/

/* **************************************************************************************************
   Establish several global macros...these should be established elsewhere in the future...like in 
   the project-specific program...this program should simply be 'sourced' to put the programs in 
   memory. 

   Three global macros should be set before running these programs:
   storage_dir is a folder for holding resulting datasets and HTML files
   save_html_blocks: will save html if 1, and will not otherwise
   cb_debugging: will save some intermediate datasets if 1, and will not otherwise

   i.e., 

   global storage_dir C:\Documents and Settings\rhodad\My Documents\- Projects\Codebooks\ChES\devstorage\
   global save_html_blocks 1
   global cb_debugging 1

   ***************************************************************************************************/



/* This small program is based on a similar program within 
   Stata's codebook.ado file.  It counts unique non-missing values
   for a variable (v) within a Stata dataset.
   This program is used by the make_descsave_dataset program.
*/
capture program drop CntUniq
program CntUniq, rclass
	args v dataset
	preserve
	use `dataset', clear
	quietly {
		tempvar tag
		bys `v': gen byte `tag'= 1 if _n==1 
		count if `tag'==1 & !missing(`v') 
		ret scalar uniq_nmv = r(N)
	}
end


capture program drop make_descsave_dataset
program make_descsave_dataset

	/* The main goal of this program is to
	1. Establish some variables that are used in the codebook entries.  Specifically,
	   (varnum newvar label key vartype length).  Key is not set here, but it
	   is established.  That should be done in the project-specific program.
	   
	2. Calculate some variables that might be useful for deciding how to summarize 
	   each variable.  One such variable is numlevels, which indicates how many
	   unique non-missing values each variable has in the dataset.
	   
	3. Save the dataset in a place where we can later merge in the info for
	   the first 6 columns of the codebook:
	   (varnum newvar order label key vartype length)
	*/

	version 11.1
	args dataset
	
	/* Generate the descsave dataset & tweak variable names to be 
	   consistent with codebook programs.
	*/
	
	use `dataset', clear
	quietly descsave, saving("${storage_dir}descsave", replace) 
	
	* We want to create a local that passes through the new variable label.
	* This is contained in the char(question_text)

	foreach v of varlist * {
		local `v' "``v'[Question_text]'"
		if "``v'[Question_text]'" == "" local `v' `:var label `v''
		
		local `v'_org "``v'[Original_${Country}_Varname]'"
	}
	
	
	use "${storage_dir}descsave", clear
	rename order varnum
	rename name newvar
	rename varlab label
	
	* Now replace the label with the appropriate question text if specified
	
	gen orgvar = ""
	label var orgvar "Original instrument variable name"
	levelsof newvar, local(var_list)
	foreach v in `var_list' {
		replace label = "``v''" if newvar == "`v'" & "``v''" != ""
		replace orgvar = "``v'_org'" if newvar == "`v'" & "``v''" != ""
	}
	
	/* Generate a SAS-like vartype variable */
	gen vartype = "Num"
	replace vartype = "Char" if substr(type,1,3)=="str"
	gen length = "-"
	replace length = substr(type,4,.) if vartype == "Char" 

	gen key = "" 
	
	/* The key variable should be replaced later with 
	   dataset-specific logic, like:
	   replace key = "Y" if newvar == "caseid"
	*/

	order varnum newvar orgvar label key vartype length
	

	/* Use a simplified version of CntUniq (modified from Stata's codebook command)
	   to count the unique non-missing levels of each variable
	*/
	
	gen counter = _n
	gen numlevels = .
	forvalue i = 1(1)`=_N' {
		local vname = newvar[`i']
		CntUniq `vname' `dataset'
		quietly replace numlevels = r(uniq_nmv) if counter == `i'
	}
	
	drop counter
	save "${storage_dir}descsave", replace
end

capture program drop write_html_summary
program write_html_summary
	version 11.1
	
	args codebook_filename blank_rows_above 

	bysort varnum: gen rowcount = _N
	
	capture file close out

	file open out using `"`codebook_filename'"', replace write text

	file write out "<html><body><table>" _n

	file write out "<thead><tr>" _n
	file write out "<td align=center > Order of Variable </td>" _n
	file write out "<td align=center > Variable Name </td>" _n
	file write out "<td align=center > Original Dataset Variable name </td>" _n
	file write out "<td align=left   > Variable Label </td>" _n
	file write out "<td align=center > Key </td>" _n
	file write out "<td align=center > Variable Type </td>" _n
	file write out "<td align=center > Variable Length </td>" _n
	file write out "<td align=center > Response Category </td>" _n
	file write out "<td align=left   > Response Category Description </td>" _n
	file write out "<td align=center > Number of Observations / Distribution Summary </td>" _n
	file write out "<td align=right  > Percent of Population</td>" _n
	file write out "</tr></thead><tbody>" _n
	
	local toprowtdstyle    border-top:thin solid #C0C0C0;border-right:thin solid #C0C0C0;border-bottom:thin solid #C0C0C0;border-left:thin solid #C0C0C0
	local otherrowtdstyle  border-top:thin solid #C0C0C0;border-right:thin solid #C0C0C0;border-bottom:thin solid #C0C0C0;border-left:thin solid #C0C0C0

	forvalues i = 1(1)`=_N' {
	
		if inlist(summary_block_type[`i'],"emty") {
			if order[`i'] == 1 {
			
				if inlist(`blank_rows_above',.,0) {
					file write out "<tr ><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (varnum[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (newvar[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (orgvar[`i'])

				}
				else {

					file write out "<tr ><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']+`blank_rows_above') "> " (varnum[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']+`blank_rows_above') "> " (newvar[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left valign=top colspan=8> =vlookup(" _char(34)(newvar[`i']) _char(34)
					file write out ", place_to_look_`blank_rows_above', col_to_look_`blank_rows_above', FALSE) </td></tr>"		

					forvalues j = 2/`blank_rows_above' {
						local k = `blank_rows_above' - `j' + 1
						file write out "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=left valign=top colspan=8> =vlookup(" _char(34)(newvar[`i']) _char(34)
						file write out ", place_to_look_`k', col_to_look_`k', FALSE) </td></tr>"		
					}
				}
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (label[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (key[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (vartype[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (length[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=right   colspan=4 >" (level2[`i'])
				file write out "</td></tr>" 
			}
			else {
				file write out "<tr ><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=right   colspan=4>" (level2[`i']) 
				file write out "</td></tr>" _n
			}
		}
	
		if inlist(summary_block_type[`i'],"univ","date","year","mont","dayd","mnmx","time","open") {
			if order[`i'] == 1 {
			
				if inlist(`blank_rows_above',.,0) {
					file write out "<tr ><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (varnum[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (newvar[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (orgvar[`i'])

				}
				else {
					file write out "<tr ><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']+`blank_rows_above') "> " (varnum[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']+`blank_rows_above') "> " (newvar[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left valign=top colspan=8> =vlookup(" _char(34)(newvar[`i']) _char(34)
					file write out ", place_to_look_`blank_rows_above', col_to_look_`blank_rows_above', FALSE) </td></tr>"		
					
					forvalues j = 2/`blank_rows_above' {
						local k = `blank_rows_above' - `j' + 1
						file write out "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=left valign=top colspan=8> =vlookup(" _char(34)(newvar[`i']) _char(34)
						file write out ", place_to_look_`k', col_to_look_`k', FALSE) </td></tr>"		
					}
				}
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (label[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (key[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (vartype[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (length[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=right   colspan=2 >" (level2[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=right   colspan=1 >" (value1[`i']) "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=right colspan=1 >" (value2[`i'])
				file write out "</td></tr>" 
			}
			else {
				file write out "<tr ><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=right   colspan=2>" (level2[`i']) 
				file write out "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=right   colspan=1 >" (value1[`i']) "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=right colspan=1 >" (value2[`i']) 
				file write out "</td></tr>" _n
			}		
		}
		
		if inlist(summary_block_type[`i'],"freq") {
			if order[`i'] == 1 {
			
				if inlist(`blank_rows_above',.,0) {
					file write out "<tr ><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (varnum[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (newvar[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (orgvar[`i'])

				}
				else {
					file write out "<tr ><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']+`blank_rows_above') "> " (varnum[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']+`blank_rows_above') "> " (newvar[`i'])
					file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left valign=top colspan=8> =vlookup(" _char(34)(newvar[`i']) _char(34)
					file write out ", place_to_look_`blank_rows_above', col_to_look_`blank_rows_above', FALSE) </td></tr>"		
					
					forvalues j = 2/`blank_rows_above' {
						local k = `blank_rows_above' - `j' + 1
						file write out "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=left valign=top colspan=8> =vlookup(" _char(34)(newvar[`i']) _char(34)
						file write out ", place_to_look_`k', col_to_look_`k', FALSE) </td></tr>"
					}
				}
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left   valign=top rowspan=" (rowcount[`i']) "> " (label[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (key[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (vartype[`i'])
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center valign=top rowspan=" (rowcount[`i']) "> " (length[`i'])

        if vartype[`i'] == "Char" file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center colspan=2 >" (level2[`i']) 
        else file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=center colspan=1 >" (level1[`i']) "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=left  colspan=1 >" (level2[`i'])
        
				file write out "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=right  colspan=1 >" (value1[`i']) "</td><td style=" _char(34) "`toprowtdstyle'" _char(34) " align=right colspan=1 >" (value2[`i'])
				file write out "</td></tr>" 
			}
			else {
			
        if vartype[`i'] == "Char" file write out "<tr ><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=center colspan=2 >" (level2[`i']) 
        else file write out "<tr ><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=center colspan=1 >" (level1[`i']) "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=left  colspan=1 >" (level2[`i'])
        
				file write out "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=right  colspan=1 >" (value1[`i']) "</td><td style=" _char(34) "`otherrowtdstyle'" _char(34) " align=right colspan=1 >" (value2[`i']) 
				file write out "</td></tr>" _n
			}
		}
	}

	file write out "</tbody></table></body>"

	file close out
	
	drop rowcount

end


capture program drop emtyblock
program emtyblock

	/* This program populates the variables level1 level2 value1 and value2 
	   with missing values and then merges them with other summary variables 
	   in the descsave dataset.
	*/
	version 11.1

	args dataset svar
	use `dataset', clear
	
	clear
	set obs 1
	gen order  = 1
	gen newvar = "`svar'"
	gen orgvar = "`orgvar'"
	gen level1 = ""
	gen level2 = ""
	gen value1 = .
	gen value2 = .
	
	/* Merge the frequency table with the non-frequency related info */
	merge m:1 newvar using "${storage_dir}descsave", keep(match) nogenerate	
	keep  varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	order varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	tostring value1, replace
	gen summary_block_type = "emty"
	compress
	save "${storage_dir}block_`svar'", replace
	
	if $save_html_blocks == 1 write_html_summary "${storage_dir}h_`svar'.html"
		
end

capture program drop freqblock
program freqblock

    * This program populates the variables level1 level2 value1 and value2 and then
    * merges them with other summary variables in the descsave dataset.
	*   
	* If the user specifies the DROPZEROS option then the frequency table will only
	* list response categories with one or more responses...it will not list those
	* with zero responses.  The default (no DROPZEROS option) is to list all response
	* categories regardless of the number of respondents who selected them.

    *version 11.1

	syntax  namelist(min=2 max=2) [, DROPZEROS]
	tokenize `namelist'
	local dataset `1'
	local svar `2'

    use `dataset', clear
	
	local bign `=_N'
	local orgvar ``svar'[Original_${Country}_Varname]'

	
	* Later we'll need to know if svar is one of the variables
	* that has a special missing value.  Expand the varlists that
	* are associated with special missing values now, at the top
	* of the program, before we drop all variables except the one
	* we're summarizing.
	make_scvarlists
	
	* Save the variable type value label and variable formats in local macros
	local svartype : type `svar'
	if substr("`svartype'",1,3)=="str" local svartype string
	
    local vallab : value label `svar'
    local level1fmt : format `svar'	

	* Drop all but the one relevant variable
	keep `svar'
	local orgvar ``svar'[Original_${Country}_Varname]'

	* Count the observations with special missing values, and drop them from the dataset
	tempfile smvtable
	capture postclose handle
	postfile handle str244(newvar orgvar) order str244 level1 str244 level2 value1 value2 using `smvtable' , replace
	handle_special_values_freqblock `svar' `svartype' `bign' `orgvar'
	postclose handle
	

	* Consider the possibility that *ALL* of the observations were special or missing values
	
	if `=_N' == 0 local tomerge `smvtable'
	
	* If there are still observations left to summarize, handle the case where
	* there is *NO* value label first...that is the most straightforward
	
	if `=_N' > 0 {
		preserve
		contract `svar', freq(value1) percent(value2) format(%10.4f)
		replace value2 = value1 / `bign'
		rename `svar' level1
		gen newvar = "`svar'"   
		gen orgvar = "`orgvar'"
		gen level2 = ""
		tempfile contract
		save `contract', replace
		local tomerge `contract'
		restore
	
		if "`vallab'" != "" {
			* make a list of the values with labels...call this vlist
			* make the list by saving the value label in a temporary 
			* file and then reading it into a dataset...
		
			* Note that this step is necesary because we want to see a 
			* list of ALL possible values, even if they have zero 
			* frequency...the second table that is constructed with the
			* 'contract' command below only lists those values that 
			* appear in the data.  (It will also list values that do NOT
			* have value labels, if they appear in the data.) So together,
			* ftable and the contract table list all possible values.
		
			* Of course, file I/O is notoriously slow so it would be nice 
			* to replace this block of code with something that doesn't 
			* rely on writing and reading an actual file...
			
			tempfile ftable
			preserve
			tempfile llist
			label save `vallab' using `llist', replace
			clear
			insheet using `llist', delimiter(" ") nonames
			erase `llist'
			local vlist
			forvalue i = 1/`=_N' {
				local newv = v4[`i']
				local vlist `vlist' `newv'
			}
			restore	
		
			* now count the number of entries for each labeled value
			* put this in a temporary dataset called `ftable'
	
			capture postclose handle
			postfile handle str244(newvar orgvar) level1 str244 level2 value1 value2 using `ftable', replace
	
			foreach v in `vlist' {
				count if `svar' == `v'
				local vlabel  : label (`svar') `v'
				post handle ("`svar'") ("`orgvar'") (`v') ("`vlabel'") (r(N)) (r(N)/`bign')
			}	
			
			postclose handle  
			use `ftable', clear
			merge 1:1 newvar level1 using `contract', keep(master using match) nogenerate
			save `ftable', replace
			local tomerge `ftable'
		}

		use `tomerge', clear
		
		* if the user does NOT want to see output lines where the number
		* of responses is zero, then remove them now
	
		if "`dropzeros'" != "" drop if value1 == 0

		* sort the remaining responses and generate the order variable
	
		sort level1
		gen order = _n	
		
		if "`vallab'" == "" {
			forvalues i = 1/`=_N' { 
				local level = level1[`i']
				* this next line guards against the situation where the string variable 
				* contains a single-quote like the one that starts a Stata local macro (`);
				* this line of code temporarily substitutes the string ~'~ for that macro 
				* quote and then a line of code below switches it back after it is no longer
				* going to cause a problem...
				if "`svartype'" == "string" local level = subinstr(level1[`i'],"\`","~'~",100)
				
				* otherwise if the level1 variable has an explicit format, use that
				* (this helps with things like dates, etc.)
				* otherwise just display the value as-is
				if "`level1fmt'" == "" & "`svartype'" != "string" local ilabel `level'
				if "`level1fmt'" == "" & "`svartype'" == "string" local ilabel `"`level'"'
				if "`level1fmt'" != "" & "`svartype'" == "string" local ilabel `"`level'"' 
				if "`level1fmt'" != "" & "`svartype'" != "string" local ilabel : display `level1fmt' `level' 
			
				if "`svartype'" == "string" replace level2 = `"`ilabel'"' if _n == `i' //level1 == "`level'"
				else replace level2 = "`ilabel'" if level1 == `level'
			}
		}
		
		* now it's okay to put the single quote (`) back in the string if it was
		* there before, so substitute it in there (up to 100 of them)
		if "`svartype'" == "string" replace level2 = subinstr(level2,"~'~","`",100)
		if "`svartype'" != "string" tostring level1, replace force format(`level1fmt')
			
		* if there is a special missing value table, then append it now
		capture confirm file `smvtable'
		if _rc == 0 {
			local freqn = `=_N'
			preserve
			use `smvtable', clear			
			replace order = `freqn' + order + 1
			save `smvtable', replace
			restore
			merge 1:1 level1 using `smvtable', keep(master)
			append using `smvtable'
		}
		
		save `tomerge', replace
	}
	
	* At this point, the macro tomerge might point to a dataset consisting only of 
	* special missing values, one with output from contract and special missing values, 
	* or one with output from fvalue, contract, and special missing values.
	* In any event, merge it with the non-frequency related info and wrap up.
	
	use `tomerge', clear
    
	if "`svartype'" == "string" {
		replace level1 = "=" + char(34) + level1 + char(34)
		replace level2 = "=" + char(34) + level2 + char(34)
	}
	
	
    * Merge the frequency table with the non-frequency related info 
    merge m:1 newvar using "${storage_dir}descsave", keep(match) nogenerate    
    keep  varnum newvar orgvar order label key vartype length level1 level2 value1 value2
    order varnum newvar orgvar order label key vartype length level1 level2 value1 value2
    tostring value1, replace force format(%15.0fc)
    	
	sort order	
	replace order = _n
	gen summary_block_type = "freq"
	
    compress
    save "${storage_dir}block_`svar'", replace
    
    if $save_html_blocks == 1 write_html_summary "${storage_dir}h_`svar'.html"
        
end


capture program drop univblock
program univblock

	* This program populates the variables level2 and value1 and then
	*   merges them with other summary variables in the descsave dataset.
	*   Level1 and value2 are set to missing.

	version 11.1

	args dataset svar
	use `dataset', clear
	
	* If there were any varlists specified in the special missing values file
	* then expand them now while we have the full dataset in memory.  We'll use 
	* these lists later, but must make and store them now...
	
	make_scvarlists

	keep `svar'
	local orgvar ``svar'[Original_${Country}_Varname]'
	
	local bign `=_N'
	
	* Obtain summary stats via 'summarize' command
	*   and put them in a dataset with a variable called order
	
	capture postclose handle
	postfile handle str244(newvar orgvar) order str30 level1 str50 level2 value1 value2 using "${storage_dir}u_`svar'", replace

	* First take care of special values...count them up and post them to the handle file
	* and then set their values to missing so they don't enter into the 'summarize' command.
	
	handle_special_values_univblock `svar' `bign' `orgvar'
	* Now if there are any valid observations left, summarize them
	
	count if !missing(`svar')

	if r(N) > 0 {
	
		quietly summarize `svar', detail
		
		*post handle ("`svar'") ("`orgvar'") ( 1) ("") ("Minimum")                    (r(min))  (.)
		*post handle ("`svar'") ("`orgvar'") ( 2) ("") ("10th Percentile")            (r(p10))  (.)
		*post handle ("`svar'") ("`orgvar'") ( 3) ("") ("25th Percentile")            (r(p25))  (.)
		*post handle ("`svar'") ("`orgvar'") ( 4) ("") ("Median")                     (r(p50))  (.)
		*post handle ("`svar'") ("`orgvar'") ( 5) ("") ("75th Percentile")            (r(p75))  (.)
		*post handle ("`svar'") ("`orgvar'") ( 6) ("") ("90th Percentile")            (r(p90))  (.)
		*post handle ("`svar'") ("`orgvar'") ( 7) ("") ("Maximum")                    (r(max))  (.)
		post handle ("`svar'") ("`orgvar'") ( 8) ("") ("Mean")                       (r(mean)) (.)
		post handle ("`svar'") ("`orgvar'") ( 9) ("") ("Standard Deviation")         (r(sd))   (.)
		*post handle ("`svar'") ("`orgvar'") (10) ("") ("Standard Error of the Mean") (r(sd)/sqrt(r(sum_w))) (.)
		if "$GM" == "gm" {  // If the user has asked for geometric means, post them here
			ameans `svar'
		*	post handle ("`svar'") ("`orgvar'") (11) ("") ("Geometric Mean") (r(mean_g)) (.)
		}

	}
	
	postclose handle           
	
	use "${storage_dir}u_`svar'", clear
	
	merge m:1 newvar using "${storage_dir}descsave", keep(match) nogenerate	
	keep  varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	order varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	
	* Convert value1 to string (to be compatible with date blocks, which contain strings).
	* List non-integers out to three decimal places.  
	* Display integers without decimal points or places.

	tostring value1, replace force format(%25.3fc)
	replace value1 = substr(value1, 1, length(value1)-4) if substr(value1,-4,4)== ".000"
	gen summary_block_type = "univ"

	compress
	save "${storage_dir}block_`svar'", replace
	
	if $cb_debugging != 1 erase "${storage_dir}u_`svar'.dta"
	
	if $save_html_blocks == 1 write_html_summary "${storage_dir}h_`svar'.html"
		
end


capture program drop openblock
program openblock

	* This program populates the variables level2 value1 and value2 and then
	*  merges them with other summary variables in the descsave dataset.
	*  Level 1 is missing
	*
	
	* This program simply enumerates the number of non-missing values and the number of missing values.
	* It works for either numeric or string variables.
	* It does NOT NOT NOT pay any attention to "special" missing values.  
	* For numeric variables, it lumps all of Stata's different missing categories (.a, .b, .c, etc.) 
	* into the category of "Missing".
	* For string variables, the only thing that counts as missing is an empty string.  So please note
	* that a string that contains only the word "Missing" is in fact not missing. 

	version 11.1

	syntax anything 
	local dataset `1'
	local svar `2'
	use `dataset', clear
	
	local bign `=_N'
	
	* Later we'll need to know if svar is one of the variables
	* that has a special missing value.  Expand the varlists that
	* are associated with special missing values now, at the top
	* of the program, before we drop all variables except the one
	* we're summarizing.
	make_scvarlists
	
	* Save the variable type 
	local svartype : type `svar'
	if substr("`svartype'",1,3)=="str" local svartype string
	
	keep `svar'
	local orgvar ``svar'[Original_${Country}_Varname]'

	* Count the observations with special missing values, and drop them from the dataset
	tempfile smvtable
	capture postclose handle
	postfile handle str244(newvar orgvar) order str244 level1 str244 level2 value1 value2 using `smvtable' , replace
	handle_special_values_freqblock `svar' `svartype' `bign' `orgvar'
	postclose handle

/*
	capture postclose handle
	postfile handle str244 newvar order str30 level1 str30 level2 value1 value2 using "${storage_dir}o_`svar'", replace

	local bign `=_N'

	count if !missing(`svar')
	post handle ("`svar'") (1) ("") ("Non-Missing")                (r(N))    (r(N)/`bign')
	count if missing(`svar')																			
	post handle ("`svar'") (2) ("") ("Missing")                    (r(N))    (r(N)/`bign')		
	
	postclose handle           
	
	use "${storage_dir}o_`svar'", clear
*/

	use `smvtable', clear
	
	/* Merge the frequency table with the non-frequency related info */
	merge m:1 newvar using "${storage_dir}descsave", keep(match) nogenerate	
	keep  varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	order varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	tostring value1, replace force format(%25.0fc)
	gen summary_block_type = "open"
	
	sort order
	replace order = _n
	
	compress
	save "${storage_dir}block_`svar'", replace
	
	if $save_html_blocks == 1 write_html_summary "${storage_dir}h_`svar'.html"
end

capture program drop mnmxblock
program mnmxblock
	minmaxblock `1' `2' mnmx Value %12.0g
end
	
capture program drop yearblock
program yearblock
	minmaxblock `1' `2' year Year %4.0f
end
	
capture program drop daydblock
program daydblock
	minmaxblock `1' `2' day Day %02.0f
end
	
capture program drop montblock
program montblock
	minmaxblock `1' `2' month Month %02.0f
end

capture program drop dateblock
program dateblock
	minmaxblock `1' `2' date Date %tdNN/DD/CCYY
end

capture program drop timeblock
program timeblock
	minmaxblock `1' `2' time Time %tcHH:MM
end


capture program drop minmaxblock
program minmaxblock 

	/* This program populates the variables level2 and value1 and then
	   merges them with other summary variables in the descsave dataset.
	   Level1 and value2 are set to missing.
	*/

	version 11.1

	args dataset svar type word di_format
	use `dataset', clear
	
	* If there were any varlists specified in the special missing values file
	* then expand them now while we have the full dataset in memory.  We'll use 
	* these lists later, but must make and store them now...
	
	make_scvarlists

	keep `svar'	
	local orgvar ``svar'[Original_${Country}_Varname]'
	
	local bign `=_N'
	
	/* Obtain summary stats via 'summarize' command
	   and put them in a dataset with a variable called order
	*/
	capture postclose handle
	postfile handle str244(newvar orgvar) order str30 level1 str30 level2 str15 value1 value2 using "${storage_dir}m_`svar'", replace

	* First take care of special values...count them up and post them to the handle file
	* and then set their values to missing so they don't enter into the 'summarize' command.
	
	handle_special_values_mnmxblock `svar' `bign' `orgvar'
	
	count if !missing(`svar')

	if r(N) > 0 {	
	
		quietly summarize `svar', detail
		if r(min) != . local minval : display `di_format' r(min)
		if r(max) != . local maxval : display `di_format' r(max)
	
		post handle ("`svar'") ("`orgvar'") ( 1) ("") ("Minimum `word'")               ("`minval'")  (.)
		post handle ("`svar'") ("`orgvar'") ( 2) ("") ("Maximum `word'")               ("`maxval'")  (.)
	}
	
	postclose handle           
	
	use "${storage_dir}m_`svar'", clear
	
	merge m:1 newvar using "${storage_dir}descsave", keep(match) nogenerate	
	keep  varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	order varnum newvar orgvar order label key vartype length level1 level2 value1 value2
	gen summary_block_type = "`type'"
	
	compress
	save "${storage_dir}block_`svar'", replace
	
	if $cb_debugging != 1 erase "${storage_dir}m_`svar'.dta"
	
	if $save_html_blocks == 1 write_html_summary "${storage_dir}h_`svar'.html"
		
end

capture program drop prepare_block_commands
program prepare_block_commands

	version 11.1
	syntax  anything [, DROPZEROS]
	*tokenize `anything'
	local csvfile `anything'

	insheet using "`csvfile'", clear nonames

	capture file close out
	file open out using `"${temp_dir}block_commands.do"', replace write text
	
	forvalue i = 1(1)`=_N' {
		if !inlist(v2[`i'], "emty", "freq", "univ", "open", "year") & ///
		   !inlist(v2[`i'], "dayd", "mont", "mnmx", "date", "time") {
			display as error "Valid summary blocktypes are emty, freq, univ, open, year, dayd, mont, mnmx, date and time."
			display as error v2[`i'] " is not a valid summary block type.  Fix `csvfile'."
			exit 9
		}
		file write out (v2[`i']) "block " _char(96) "dataset" _char(39) " " (v1[`i']) 
		if v2[`i'] == "freq" & "`dropzeros'" != "" file write out " , dropzeros"
		file write out _n
	}
	file close out
	
	file open out using `"${temp_dir}append_commands.do"', replace write text
	
	file write out "use block_" (v1[1]) " ,clear" _n
	
	forvalue i = 2(1)`=_N' {
		file write out "append using block_" (v1[`i']) _n
	}
	
	file close out
	
end


capture program drop write_special_values_code
program write_special_values_code

	version 11.1

	args csvfile

	* write code to expand varlists
	* this code is "include"d later
	* put it in the temp folder for now

	insheet using "`csvfile'", clear nonames
			
	capture file close out
	file open out using `"${temp_dir}special_missing_code.do"', replace write text
	
	file write out "capture program drop make_scvarlists" _n
	file write out "program make_scvarlists" _n
	file write out "display " _n

	forvalue i = 1(1)`=_N' {
		if v2[`i'] != "_all" {
			file write out "unab scvarlist_`i' : " (v2[`i'])  _n
			file write out "global scvarlist_`i' " _char(96) "scvarlist_`i'" _char(39) _n
		}
	}
	file write out _n "end" _n _n

	* write code to handle special missing values in the freqblocks
	* this code is "include"d later
	* put it in the temp folder for now		

	file write out "capture program drop handle_special_values_freqblock" _n
	file write out "program handle_special_values_freqblock" _n
	file write out "args svar svartype bign orgvar" _n
	
	
	file write out "if " _char(34) _char(96) "svartype" _char(39) _char(34) " == " _char(34) "string" _char(34) " { " _n _n
	
	
		forvalue i = 1/`=_N' {

			if upper(v6[`i']) == "ISINLIST" local teststring >
			else local teststring = "=="

			if inlist( upper(v1[`i']) , "STRING", "CHAR", "CHARACTER", "TEXT") {
				* we need to replace missing values for strings to be "" instead of "."
				capture tostring v3, replace
				replace v3 = "" if inlist( upper(v1[`i']) , "STRING", "CHAR", "CHARACTER", "TEXT") & v3[`i']=="." in `i'
				if v2[`i'] != "_all" file write out "        if strpos(" _char(34) " " _char(36) "scvarlist_`i'" " " _char(34) " , " _char(34) " " _char(96) "svar" _char(39) " " _char(34) ") `teststring'  0 {" _n
				file write out "        count if " _char(96) "svar" _char(39) " == " _char(34) (v3[`i']) _char(34) _n
				if upper(v5[`i']) != "ALWAYS" file write out "        if r(N) > 0 | upper(" _char(34) (v4[`i']) _char(34) ") == " _char(34) "MISSING" _char(34) " "
				file write out "        post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (`i') (" _char(34) (v3[`i']) _char(34) ") (" _char(34) (v4[`i']) _char(34) ") (r(N)) (r(N)/" _char(96) "bign" _char(39) ")" _n
				file write out "        drop if " _char(96) "svar" _char(39) " == " _char(34) (v3[`i']) _char(34) _n
				if v2[`i'] != "_all" file write out "        }" _n
				file write out _n
			}
		}
			
	file write out "}" _n _n
	
	file write out "else { " _n _n

		forvalue i = 1/`=_N' {
		
			if upper(v6[`i']) == "ISINLIST" local teststring >
			else local teststring = "=="
		
			if inlist(upper(v1[`i']),"NUM", "NUMERIC", "NUMBER") {
				
				if v2[`i'] != "_all" file write out "        if strpos(" _char(34) " " _char(36) "scvarlist_`i'" " " _char(34) " , " _char(34) " " _char(96) "svar" _char(39) " " _char(34) ") `teststring'  0 {" _n
				file write out "        count if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				if upper(v5[`i']) != "ALWAYS" file write out "        if r(N) > 0 | upper(" _char(34) (v4[`i']) _char(34) ") == " _char(34) "MISSING" _char(34) " "
				file write out "        post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (`i') (" _char(34) (v3[`i']) _char(34) ") (" _char(34) (v4[`i']) _char(34) ") (r(N)) (r(N)/" _char(96) "bign" _char(39) ")" _n
				file write out "        drop if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				if v2[`i'] != "_all" file write out "        }" _n
				file write out _n
			}

		}
					
	file write out "}" _n _n
	
	file write out "count if !missing(" _char(96) "svar" _char(39) ")" _n
	file write out "post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (0) (" _char(34) "Non-Missing" _char(34) ") (" _char(34) "Non-Missing" _char(34) ") (r(N)) (r(N)/" _char(96) "bign" _char(39) ")" _n

	file write out _n "end" _n _n


	* write code to handle special missing values in the univblocks
	* this code is "include"d later
	* put it in the temp folder for now		

	file write out "capture program drop handle_special_values_univblock" _n
	file write out "program handle_special_values_univblock" _n
	file write out "args svar bign orgvar" _n

	local ii 11
	forvalues i = 1/`=_N' {		

		if upper(v6[`i']) == "ISINLIST" local teststring >
		else local teststring = "=="
			
		if inlist(upper(v1[`i']),"NUM", "NUMERIC", "NUMBER") {
			local ++ii
			if v2[`i'] == "_all" {
				file write out "count if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				if upper(v5[`i']) != "ALWAYS" file write out "        if r(N) > 0 | upper(" _char(34) (v4[`i']) _char(34) ") == " _char(34) "MISSING" _char(34) " "
				file write out "post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (`ii') (" _char(34) _char(34) ") (" _char(34) (v4[`i']) _char(34) ") (r(N)) (r(N)/" _char(96) "bign" _char(39) ")" _n
				file write out "drop if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
			}
			else {
				file write out "if strpos(" _char(34) " " _char(36) "scvarlist_`i'" " " _char(34) " , " _char(34) " " _char(96) "svar" _char(39) " " _char(34) ") `teststring'  0 {" _n
				file write out "    count if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				if upper(v5[`i']) != "ALWAYS" file write out "        if r(N) > 0 | upper(" _char(34) (v4[`i']) _char(34) ") == " _char(34) "MISSING" _char(34) " "
				file write out "    post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ")  (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (`ii') (" _char(34) _char(34) ") (" _char(34) (v4[`i']) _char(34) ") (r(N)) (r(N)/" _char(96) "bign" _char(39) ")" _n
				file write out "    drop if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				file write out "}" _n
			}
		}
	}		
	file write out "count if !missing(" _char(96) "svar" _char(39) ")" _n
	file write out "post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (11) (" _char(34) _char(34) ") (" _char(34) "Non-Missing" _char(34) ") (r(N)) (r(N)/" _char(96) "bign" _char(39) ")" _n

	file write out _n "end" _n _n
		
	* write code to handle special missing values in the year/date/timeblocks
	* this code is "include"d later
	* put it in the temp folder for now		
	
	file write out "capture program drop handle_special_values_mnmxblock" _n
	file write out "program handle_special_values_mnmxblock" _n
	file write out "args svar bign orgvar" _n

	local ii 3
	forvalues i = 1/`=_N' {

		if upper(v6[`i']) == "ISINLIST" local teststring >
		else local teststring = "=="
				
		if inlist(upper(v1[`i']),"NUM", "NUMERIC", "NUMBER") {
			local ++ii
			if v2[`i'] == "_all" {
				file write out "count if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				file write out "local rN : display %15.0fc r(N)" _n
				if upper(v5[`i']) != "ALWAYS" file write out "        if r(N) > 0 | upper(" _char(34) (v4[`i']) _char(34) ") == " _char(34) "MISSING" _char(34) " "
				file write out "post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (`ii') (" _char(34) _char(34) ") (" _char(34) (v4[`i']) _char(34) ") (" _char(34) _char(96) "rN" _char(39) _char(34) ") (r(N)/" _char(96) "bign" _char(39) ")" _n
				file write out "drop if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
			}
			else {
				file write out "if strpos(" _char(34) " " _char(36) "scvarlist_`i'" " " _char(34) " , " _char(34) " " _char(96) "svar" _char(39) " " _char(34) ") `teststring'  0 {" _n
				file write out "    count if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				file write out "    local rN : display %15.0fc r(N)" _n
				if upper(v5[`i']) != "ALWAYS" file write out "        if r(N) > 0 | upper(" _char(34) (v4[`i']) _char(34) ") == " _char(34) "MISSING" _char(34) " "
				file write out "    post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (`ii') (" _char(34) _char(34) ") (" _char(34) (v4[`i']) _char(34) ") (" _char(34) _char(96) "rN" _char(39) _char(34) ") (r(N)/" _char(96) "bign" _char(39) ")" _n
				file write out "    drop if " _char(96) "svar" _char(39) " == " (v3[`i']) _n
				file write out "}" _n
			}
		}
	}		

	file write out "count if !missing(" _char(96) "svar" _char(39) ")" _n	
	file write out "local rN : display %15.0fc r(N)" _n
	file write out "post handle (" _char(34) _char(96) "svar" _char(39) _char(34) ") (" _char(34) _char(96) "orgvar" _char(39) _char(34) ") (3) (" _char(34) _char(34) ") (" _char(34) "Non-Missing" _char(34) ") (" _char(34) _char(96) "rN" _char(39) _char(34) ") (r(N)/" _char(96) "bign" _char(39) ")" _n

	file write out _n "end" _n _n
	
	file close out

end



*bgc_codebook , datafolder(C:\Documents and Settings\rhodad\My Documents\- Projects\CDC - HPV Typing\Project data) dataset(HPV_SELECT HPV HPV_NOSELECT) sum(HPV_Typing_codebook_treatment.csv) key(crid) spec(HPV_Typing_codebook_special_values.csv)


