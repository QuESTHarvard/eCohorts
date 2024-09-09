* Ecohorts econ paper outline
* Created by S. Sabwa
* Last Updated: Aug 1 2024

clear all
set more off 

*===============================================================================*
* Import clean data with derived variables (by country)

*ethiopia:
use "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH Ecohorts QuEST-shared/Data/Ethiopia/02 recoded data/eco_m1-m5_et_wide_der.dta", clear

*===============================================================================*
/* Keep variables for analysis (to make it easier to append countries to each other)
**add all vars here once done

keep m1_1217 m1_1218a_1 m1_1218b_1 m1_1218c_1 m1_1218d_1 m1_1218e_1 m1_1218f_1 m1_1219 m2_701_r1 m2_701_r2 m2_701_r3 m2_701_r4 m2_701_r5 m2_701_r6 m2_701_r7 m2_701_r8 m2_702a_cost_r1 m2_702a_cost_r2 m2_702a_cost_r3 m2_702a_cost_r4 m2_702a_cost_r5 m2_702a_cost_r6		m2_702a_cost_r7 m2_702a_cost_r8 m2_702b_cost_r1 m2_702b_cost_r2 m2_702b_cost_r3 m2_702b_cost_r4 m2_702b_cost_r5 m2_702b_cost_r6 m2_702b_cost_r7 m2_702b_cost_r8 m2_702c_cost_r1 m2_702c_cost_r2 m2_702c_cost_r3 m2_702c_cost_r4 m2_702c_cost_r5 m2_702c_cost_r6 m2_702c_cost_r7 m2_702c_cost_r8 m2_702d_cost_r1 m2_702d_cost_r2 m2_702d_cost_r3 m2_702d_cost_r4 m2_702d_cost_r5 m2_702d_cost_r6 m2_702d_cost_r7 m2_702d_cost_r8 m2_702e_cost_r1 m2_702e_cost_r2 m2_702e_cost_r3 m2_702e_cost_r4 m2_702e_cost_r5 m2_702e_cost_r6 m2_702e_cost_r7 m2_702e_cost_r8 m2_703_r1 m2_703_r2 m2_703_r3 m2_703_r4 m2_703_r5 m2_703_r6 m2_703_r7 m2_703_r8 m2_704_confirm_r1 m2_704_confirm_r2 m2_704_confirm_r3 m2_704_confirm_r4 m2_704_confirm_r5 m2_704_confirm_r6 m2_704_confirm_r7 m2_704_confirm_r8 m3_1101 m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt m3_1103 m3_1104 m4_901 m4_902a_amt m4_902b_amt m4_902c_amt m4_902d_amt m4_902e_amt m4_903 m4_904 m5_1001 m5_1002a_yn m5_1002b_yn m5_1002c_yn m5_1002d_yn m5_1002e_yn m5_1003 m5_1004

*/
*===============================================================================*
*Break down the OOP expenses by:
	*Antenatal (cumulative over pregnancy), delivery, postnatal (where is the bulk of the spending?)
		*	Any expense BL:1217/FU: q701 or BLq713? / FU:q602 
		*	Sum up the expenses for medication/supplements and facility fees to get total expenses during ANC, delivery, postnatal
		*	Of total expenditure, is majority spent on drugs, transport, etc?
		*	intensive margin: among women with expense, what was total sum across care for ANC
		*	spike at first ANC and then less at subsequent visits? 
		*	group by what they spent money on
		
		*ANALYSIS
		***Create new var for total expenditure for anc, delivery, post-partum (new column for everything they paid for drugs, transports, tests, 3 total expenditures: ANC, delivery, PNC (we'll see where most money is spent)
		***Create new var for total spent on registration, tests, transport... etc. (sum by different types of services - reg/tests/, wide format sum expenditures (meds, transport, etx.) at M1, M2, M3 (all ANC visits)
		
			
*--------Variables:
		** M1 vars (ANC): m1_1217 (any expense- y/n), m1_1218a_1, m1_1218b_1, m1_1218c_1, m1_1218d_1, m1_1218e_1, m1_1218f_1, m1_1219
		
		** M2 vars (ANC): 
			*Any expense- y/n: m2_701_r1 m2_701_r2 m2_701_r3 m2_701_r4 m2_701_r5 m2_701_r6 m2_701_r7 m2_701_r8 
			*Registration: m2_702a_cost_r1, m2_702a_cost_r2, m2_702a_cost_r3, m2_702a_cost_r4, m2_702a_cost_r5, m2_702a_cost_r6, 		m2_702a_cost_r7, m2_702a_cost_r8
			*Test/investigations: m2_702b_cost_r1 m2_702b_cost_r2 m2_702b_cost_r3 m2_702b_cost_r4 m2_702b_cost_r5 m2_702b_cost_r6 m2_702b_cost_r7 m2_702b_cost_r8
			*Transport:m2_702c_cost_r1 m2_702c_cost_r2 m2_702c_cost_r3 m2_702c_cost_r4 m2_702c_cost_r5 m2_702c_cost_r6 m2_702c_cost_r7 m2_702c_cost_r8
			*Food/accomodation: m2_702d_cost_r1 m2_702d_cost_r2 m2_702d_cost_r3 m2_702d_cost_r4 m2_702d_cost_r5 m2_702d_cost_r6 m2_702d_cost_r7 m2_702d_cost_r8
			*Other item/service: m2_702e_cost_r1 m2_702e_cost_r2 m2_702e_cost_r3 m2_702e_cost_r4 m2_702e_cost_r5 m2_702e_cost_r6 m2_702e_cost_r7 m2_702e_cost_r8
			*Total spending: m2_703_r1, m2_703_r2, m2_703_r3, m2_703_r4, m2_703_r5, m2_703_r6, m2_703_r7, m2_703_r8
			*Total spending confirmation: m2_704_confirm_r1, m2_704_confirm_r2, m2_704_confirm_r3, m2_704_confirm_r4, m2_704_confirm_r5, m2_704_confirm_r6, m2_704_confirm_r7, m2_704_confirm_r8
		
		** M3 vars (delivery): m3_1101 (any expense- y/n), m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt, m3_1103, m3_1104
		
		** M4 vars (PNC): m4_901 (any expense- y/n), m4_902a_amt, m4_902b_amt, m4_902c_amt, m4_902d_amt, m4_902e_amt, m4_903, m4_904
		
		** M5 vars (PNC): m5_1001 (any expense- y/n), m5_1002a_yn m5_1002b_yn m5_1002c_yn m5_1002d_yn m5_1002e_yn, m5_1003, m5_1004

*--------Create var of people with any expenses (y/n):

*ANC:
egen anyexp_anc = rowmax(m1_1217 m2_701_r1 m2_701_r2 m2_701_r3 m2_701_r4 m2_701_r5 m2_701_r6 m2_701_r7 m2_701_r8)

lab var anyexp_anc "Any expenses during ANC period"
lab def anyexp_anc 0 "No expenses during ANC" 1 "Had expenses during ANC"
lab val anyexp_anc anyexp_anc

*check: br m1_1217 m2_701_r1 m2_701_r2 m2_701_r3 m2_701_r4 m2_701_r5 m2_701_r6 m2_701_r7 m2_701_r8 anyexp_anc

*Delivery
gen anyexp_del = m3_1101

lab var anyexp_del "Any expenses during delivery"
lab def anyexp_del 0 "No expenses during delivery" 1 "Had expenses during delivery"
lab val anyexp_del anyexp_del

*check: br m3_1101 anyexp_del //SS: confirm with Aleks if we should drop missings? (N=17 true missings)

*PNC:
egen anyexp_pnc = rowmax(m4_901 m5_1001)

lab var anyexp_pnc "Any expenses during PNC"
lab def anyexp_pnc 0 "No expenses during PNC" 1 "Had expenses during PNC"
lab val anyexp_pnc anyexp_pnc

*check: br m4_901 m5_1001 anyexp_pnc //SS: N=167 true missings

*--------Total expenditures:

*----ANC:

*calculating M2 costs 
* m2_704 asks: "Is the total cost correct" If no the respondent says how much they actually spent "m2_704_confirm". 
gen totalspent_m2_r1 = m2_703_r1 //
replace totalspent_m2_r1 = m2_704_confirm_r1 if m2_704_r1 == 0 & m2_704_confirm_r1 !=.a // Some people did not answer the subsequent question so I'm using their original answer here
*check: br m2_703_r1 m2_704_r1 m2_704_confirm_r1 totalspent_m2_r1

gen totalspent_m2_r2 = m2_703_r2
replace totalspent_m2_r2 = m2_704_confirm_r2 if m2_704_r2 == 0 & m2_704_confirm_r2 !=.a
*check: br m2_703_r2 m2_704_r2 m2_704_confirm_r2 totalspent_m2_r2

gen totalspent_m2_r3 = m2_703_r3
replace totalspent_m2_r3 = m2_704_confirm_r3 if m2_704_r3 == 0 & m2_704_confirm_r3 !=.a
*check: br m2_703_r3 m2_704_r3 m2_704_confirm_r3 totalspent_m2_r3

gen totalspent_m2_r4 = m2_703_r4
replace totalspent_m2_r4 = m2_704_confirm_r4 if m2_704_r4 == 0 & m2_704_confirm_r4 !=.a
*check: br m2_703_r4 m2_704_r4 m2_704_confirm_r4 totalspent_m2_r4

gen totalspent_m2_r5 = m2_703_r5
replace totalspent_m2_r5 = m2_704_confirm_r5 if m2_704_r5 == 0 & m2_704_confirm_r5 !=.a
*check: br m2_703_r5 m2_704_r5 m2_704_confirm_r5 totalspent_m2_r5

gen totalspent_m2_r6 = m2_703_r6
replace totalspent_m2_r6 = m2_704_confirm_r6 if m2_704_r6 == 0 & m2_704_confirm_r6 !=.a
*check: br m2_703_r6 m2_704_r6 m2_704_confirm_r6 totalspent_m2_r6

gen totalspent_m2_r7 = m2_703_r7
replace totalspent_m2_r7 = m2_704_confirm_r7 if m2_704_r7 == 0 & m2_704_confirm_r7 !=.a
*check: br m2_703_r7 m2_704_r7 m2_704_confirm_r7 totalspent_m2_r7

gen totalspent_m2_r8 = m2_703_r8
replace totalspent_m2_r8 = m2_704_confirm_r8 if m2_704_r8 == 0 & m2_704_confirm_r8 !=.a 
*check:  br m2_703_r8 m2_704_r8 m2_704_confirm_r8 totalspent_m2_r8 // N=0 respondents

egen totalspent_m2 = rowtotal(totalspent_m2_r1 totalspent_m2_r2 totalspent_m2_r3 totalspent_m2_r4 totalspent_m2_r5 totalspent_m2_r6 totalspent_m2_r7 totalspent_m2_r8)
br totalspent_m2 totalspent_m2_r1 totalspent_m2_r2 totalspent_m2_r3 totalspent_m2_r4 totalspent_m2_r5 totalspent_m2_r6 totalspent_m2_r7 totalspent_m2_r8

*adding back total spent in M1
egen totalspent_anc = rowtotal(m1_1219 totalspent_m2)
lab var totalspent_anc "Total spent during ANC period"
br totalspent_anc m1_1219 totalspent_m2

*drop totalspent_m2_r1 totalspent_m2_r2 totalspent_m2_r3 totalspent_m2_r4 totalspent_m2_r5 totalspent_m2_r6 totalspent_m2_r7 totalspent_m2_r8 totalspent_m2

*----Delivery:
*egen totalspent_del = rowtotal(m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt) 
*br totalspent_del m3_1103 //did this to double-check and all data adds up, don't need this code anymore

gen totalspent_del = m3_1103 
replace total_spent_del = m3_1102_total if m3_1103_confirm == 0 // N=11 people said "No" to m3_1103_confirm and have other data for m3_1104 confirm, confirm with Aleks that its ok to replace the data in m3_1103 with m3_1104 (the value)

lab var totalspent_del "Total spent during delivery"

*PNC:
gen totalspent_m4 = m4_903
replace totalspent_m4 = m4_904 if m4_904 !=. // There was no y/n trigger question here. It looks like we had a calculated field in redcap (m4_903) then we asked them to confirm the amount in m4_904. Most numbers were the same though.

gen totalspent_m5 = m5_1003
replace totalspent_m5 = m5_1004 if m5_1003_confirm == 0

egen totalspent_pnc = rowtotal(totalspent_m4 totalspent_m5)
drop totalspent_m4 totalspent_m5

lab var totalspent_pnc "Total spent during PNC"
	
*--------Across whole pregnancy: total spent on each item:

*Total spent during ANC
	*total spent on Registration:	
egen totalspent_reg_anc = rowtotal(m1_1218a_1 m2_702a_cost_r1, m2_702a_cost_r2, m2_702a_cost_r3, m2_702a_cost_r4, m2_702a_cost_r5, m2_702a_cost_r6, 		m2_702a_cost_r7, m2_702a_cost_r8)
	
	*total spent on Test/investigations:
	*total spent on Transport:
	*total spent on Food/accomodation:
	*total spent on Other item/service:

*Total spent during delivery
	*total spent on Registration:
gen totalspent_reg_del = m3_1102a_amt


	*total spent on Test/investigations:
	*total spent on Transport:
	*total spent on Food/accomodation:
	*total spent on Other item/service:

*Total spent during PNC
	*total spent on Registration:
egen totalspent_reg_pnc = rowtotal(m4_902a_amt m5_1002a_yn)	

	*total spent on Test/investigations:
	*total spent on Transport:
	*total spent on Food/accomodation:
	*total spent on Other item/service:


*Total across continuum of care:	
gen totalspent_reg = rowtotal(totalspent_reg_anc totalspent_reg_del totalspent_reg_pnc)
*gen total_tests =

*Bar graphs:
	
*===============================================================================*
*Compare how women paid for the expenses 
	*o	Q705, define indicator for borrow/sell vs. income, savings, reimbursement from health insurance
	*o	If enough variation reimbursement could be its own indicator
	
		*ANALYSIS
		***Q705, define indicator for borrow/sell vs. income, savings, reimbursement from health insurance ==1 if she had to borrow or sell things

*-------
*Variables:
		** M1 vars (ANC): 
			*m1_1220_1: current income of any household members
			*m1_1220_2: Saving(bank account)
			*m1_1220_3: Payment or reimbursement from a health insurance plan
			*m1_1220_4: Sold items (e.g. furniture, animals, jewellery, furniture) 
			*m1_1220_5: Family members or friends from outside the household 
			*m1_1220_6: Borrowed (from someone other than a friend or family)
			*m1_1220_96: (Other, specify) 
			*m1_1220_888_et: no information
			*m1_1220_998_et: unknown
			*m1_1220_999_et: refuse to answer  
			*m1_1220_other: text from other specify (confirm with Aleks how we should clean this)
		
		** M2 vars (ANC):
		 *1: current income of any household members, 2: Savings (e.g., bank account), 3: Payment or reimbursement from a health insurance plan, 4: Sold items (e.g., furniture, animals, jewellery, furniture), 5: Family members or friends from outside the household, 6: Borrowed (from someone other than a friend or family), 96: other
		 
			*m2_705_1_r1 m2_705_2_r1 m2_705_3_r1 m2_705_4_r1 m2_705_5_r1 m2_705_6_r1 m2_705_96_r1 m2_705_888_et_r1 m2_705_998_et_r1 m2_705_999_et_r1 m2_705_other_r1 
			*m2_705_1_r2 m2_705_2_r2 m2_705_3_r2 m2_705_4_r2 m2_705_5_r2 m2_705_6_r2 m2_705_96_r2 m2_705_888_et_r2 m2_705_998_et_r2 m2_705_999_et_r2 m2_705_other_r2 
			*m2_705_1_r3 m2_705_2_r3 m2_705_3_r3 m2_705_4_r3 m2_705_5_r3 m2_705_6_r3 m2_705_96_r3 m2_705_888_et_r3 m2_705_998_et_r3 m2_705_999_et_r3 m2_705_other_r3 
			*m2_705_1_r4 m2_705_2_r4 m2_705_3_r4 m2_705_4_r4 m2_705_5_r4 m2_705_6_r4 m2_705_96_r4 m2_705_888_et_r4 m2_705_998_et_r4 m2_705_999_et_r4 m2_705_other_r4 
			*m2_705_1_r5 m2_705_2_r5 m2_705_3_r5 m2_705_4_r5 m2_705_5_r5 m2_705_6_r5 m2_705_96_r5 m2_705_888_et_r5 m2_705_998_et_r5 m2_705_999_et_r5 m2_705_other_r5 
			*m2_705_1_r6 m2_705_2_r6 m2_705_3_r6 m2_705_4_r6 m2_705_5_r6 m2_705_6_r6 m2_705_96_r6 m2_705_888_et_r6 m2_705_998_et_r6 m2_705_999_et_r6 m2_705_other_r6 
			*m2_705_1_r7 m2_705_2_r7 m2_705_3_r7 m2_705_4_r7 m2_705_5_r7 m2_705_6_r7 m2_705_96_r7 m2_705_888_et_r7 m2_705_998_et_r7 m2_705_999_et_r7 m2_705_other_r7 m2_705_1_r8 m2_705_2_r8 m2_705_3_r8 m2_705_4_r8 m2_705_5_r8 m2_705_6_r8 m2_705_96_r8 m2_705_888_et_r8 m2_705_998_et_r8 m2_705_999_et_r8 m2_705_other_r8
		
		** M3 vars (delivery): 
			*m3_1105 (single select question - can only have one response below):
				*a:Current income of any household members
				*b:Savings (e.g. bank account)
				*c:Payment or reimbursement from a health insurance plan
				*d:Sold items (e.g. furniture, animals, jewelry, furniture)
				*e:Family members or friends from outside the household
				*f:Borrowed (from someone other than a friend or family)
				*96:Other
			*m3_1105_other: free text from other
		
		** M4 vars (PNC):        	
			*m4_905a: Current income of any household members
			*m4_905b: Savings (e.g., bank account)
			*m4_905c: Payment or reimbursement from a health insurance plan
			*m4_905d: Sold items (e.g., furniture, animals, jewellery, furniture)
			*m4_905e: Family members or friends from outside the household
			*m4_905f: Borrowed (from someone other than a friend or family)
			*m4_905_96: Other
			*m4_905_other: free text
		
		** M5 vars (PNC):
			*m5_1005a: Current income of any household members
			*m5_1005b: Savings (e.g., bank account)
			*m5_1005c: Payment or reimbursement from a health insurance plan
			*m5_1005d: Sold items (e.g., furniture, animals, jewellery, furniture)
			*m5_1005e: Family members or friends from outside the household
			*m5_1005f: Borrowed (from someone other than a friend or family)
			*m5_1005_888: no information
			*m5_1005_998: unknown
			*m5_1005_999: refuse to answer  
			*m5_1005_other: Other (y/n)
			*m5_1005_oth_text: free text		          
		
*-------Indicator for borrow/sell vs income,savings,reimbursement from insurance

*===============================================================================*	
*Compare women who are insured and uninsured
	*	BL: 1221 and 1222
	
*-------
*Variables:
		** M1 vars (ANC): m1_1221 (y/n), m1_1222 (type), m1_1222_other (other type)

*===============================================================================*
*Depending on variation, could also assess incidence of women skipping ANC services because of high cost of care (q320)

*-------
*Variables:
		** M2 vars (ANC): 	
		  *0: No reason or you didn't need it, 1: You tried but were sent away (e.g.,no appointment available), 2: High cost (e.g., high out of pocket payment, not covered by insurance), 3: Far distance (e.g., too far to walk or drive, transport not readily available), 4: Long waiting time (e.g., long line to access facility, long wait for the provider), 5: Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam), 6: Staff don't show respect (e.g., staff is rude, impolite, dismissive), 7:Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)
			
			*m2_320_0_r1 m2_320_1_r1 m2_320_2_r1 m2_320_3_r1 m2_320_4_r1 m2_320_5_r1 m2_320_6_r1 m2_320_7_r1 m2_320_8_r1 m2_320_9_r1 m2_320_10_r1 m2_320_11_r1 m2_320_96_r1 m2_320_99_r1 m2_320_888_et_r1 m2_320_998_et_r1 m2_320_999_et_r1 m2_320_other_r1 m2_320_0_r2 m2_320_1_r2 m2_320_2_r2 m2_320_3_r2 m2_320_4_r2 m2_320_5_r2 m2_320_6_r2 m2_320_7_r2 m2_320_8_r2 m2_320_9_r2 m2_320_10_r2 m2_320_11_r2 m2_320_96_r2 m2_320_99_r2 m2_320_888_et_r2 m2_320_998_et_r2 m2_320_999_et_r2 m2_320_other_r2 m2_320_0_r3 m2_320_1_r3 m2_320_2_r3 m2_320_3_r3 m2_320_4_r3 m2_320_5_r3 m2_320_6_r3 m2_320_7_r3 m2_320_8_r3 m2_320_9_r3 m2_320_10_r3 m2_320_11_r3 m2_320_96_r3 m2_320_99_r3 m2_320_888_et_r3 m2_320_998_et_r3 m2_320_999_et_r3 m2_320_other_r3 m2_320_0_r4 m2_320_1_r4 m2_320_2_r4 m2_320_3_r4 m2_320_4_r4 m2_320_5_r4 m2_320_6_r4 m2_320_7_r4 m2_320_8_r4 m2_320_9_r4 m2_320_10_r4 m2_320_11_r4 m2_320_96_r4 m2_320_99_r4 m2_320_888_et_r4 m2_320_998_et_r4 m2_320_999_et_r4 m2_320_other_r4 m2_320_0_r5 m2_320_1_r5 m2_320_2_r5 m2_320_3_r5 m2_320_4_r5 m2_320_5_r5 m2_320_6_r5 m2_320_7_r5 m2_320_8_r5 m2_320_9_r5 m2_320_10_r5 m2_320_11_r5 m2_320_96_r5 m2_320_99_r5 m2_320_888_et_r5 m2_320_998_et_r5 m2_320_999_et_r5 m2_320_other_r5 m2_320_0_r6 m2_320_1_r6 m2_320_2_r6 m2_320_3_r6 m2_320_4_r6 m2_320_5_r6 m2_320_6_r6 m2_320_7_r6 m2_320_8_r6 m2_320_9_r6 m2_320_10_r6 m2_320_11_r6 m2_320_96_r6 m2_320_99_r6 m2_320_888_et_r6 m2_320_998_et_r6 m2_320_999_et_r6 m2_320_other_r6 m2_320_0_r7 m2_320_1_r7 m2_320_2_r7 m2_320_3_r7 m2_320_4_r7 m2_320_5_r7 m2_320_6_r7 m2_320_7_r7 m2_320_8_r7 m2_320_9_r7 m2_320_10_r7 m2_320_11_r7 m2_320_96_r7 m2_320_99_r7 m2_320_888_et_r7 m2_320_998_et_r7 m2_320_999_et_r7 m2_320_other_r7 m2_320_0_r8 m2_320_1_r8 m2_320_2_r8 m2_320_3_r8 m2_320_4_r8 m2_320_5_r8 m2_320_6_r8 m2_320_7_r8 m2_320_8_r8 m2_320_9_r8 m2_320_10_r8 m2_320_11_r8 m2_320_96_r8 m2_320_99_r8 m2_320_888_et_r8 m2_320_998_et_r8 m2_320_999_et_r8 m2_320_other_r8
			
		** M4 vars (PNC):
			*m4_413a: No reason or the baby and I didn't need it
			*m4_413b: You tried but were sent away (e.g., no appointment available)
			*m4_413c: High cost (e.g., high out of pocket payment, not covered by insurance)
			*m4_413d: Far distance (e.g., too far to walk or drive, transport not readily available)
			*m4_413e: Long waiting time (e.g., long line to access facility, long wait for the provider)
			*m4_413f: Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)
			*m4_413g: Staff don't show respect (e.g., staff is rude, impolite, dismissive)
			*m4_413h: Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)
			*m4_413i: COVID-19 fear
			*m4_413j: Don't know where to go/too complicated
			*m4_413k: Fear of discovering serious problem
			*m4_413_96: Other
			*m4_413_other: free text of other field           
			
		** M5 vars (PNC):
			*m5_no_visit_a: No reason or the baby and I didn't need it
			*m5_no_visit_b: You tried but were sent away (e.g., no appointment available)
			*m5_no_visit_c: High cost (e.g., high out of pocket payment, not covered by insurance)
			*m5_no_visit_d: Far distance (e.g., too far to walk or drive, transport not readily available)
			*m5_no_visit_e: Long waiting time (e.g., long line to access facility, long wait for the provider)
			*m5_no_visit_f: Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam)
			*m5_no_visit_g: Staff don't show respect (e.g., staff is rude, impolite, dismissive)
			*m5_no_visit_h: Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable) 
			*m5_no_visit_i: COVID-19 fear 
			*m5_no_visit_j: Don't know where to go/too complicated
			*m5_no_visit_k: Fear of discovering serious problem
			*m5_no_visit_96: other 
			*m5_no_visit_oth: free text of other field
			*m5_no_visit_98: DK
			*m5_no_visit_99: NR/RF
			*m5_no_visit_888: no information
			*m5_no_visit_998: unknown
			*m5_no_visit_999: refuse to answer  

*===============================================================================*
*Compare costs by women in private vs. public vs. faith-based facilities. (Note from Catherine: Note that the facility type chosen for follow up visits and delivery may not be the same as the facility type for baseline. So it will be a bit of a coding nightmare to assess this and link costs to facility types)
	*Discuss with Aleks how to code women since facility types change

*-------
*Variables:
		** M1 vars (ANC): facility_type (1: General Hospital, 2:Primary Hospital, 3:Health center, 4: MCH Specialty Clinic/Center, 5:Primary clinic)
		
		** M2 vars (ANC): 
			*asks about any new health consulatations:
			*m2_303a_r1 m2_303a_r2 m2_303a_r3 m2_303a_r4 m2_303a_r5 m2_303a_r6 m2_303a_r7 m2_303a_r8 
			*m2_303b_r1 m2_303b_r2 m2_303b_r3 m2_303b_r4 m2_303b_r5 m2_303b_r6 m2_303b_r7 m2_303b_r8 
			*m2_303c_r1 m2_303c_r2 m2_303c_r3 m2_303c_r4 m2_303c_r5 m2_303c_r6 m2_303c_r7 m2_303c_r8
			*m2_303d_r1 m2_303d_r2 m2_303d_r3 m2_303d_r4 m2_303d_r5 m2_303d_r6 m2_303d_r7 m2_303d_r8
			*m2_303e_r1 m2_303e_r2 m2_303e_r3 m2_303e_r4 m2_303e_r5 m2_303e_r6 m2_303e_r7 m2_303e_r8
				*1 : In your home, 2: Someone else's home, 3: Gov't hospital, 4: Gov't health center, 5: Gov't health post, 6: NGO/faith-based health facility, 7: Private hospital, 8: Private speciality maternity center, 9: Private speciality maternity clnic, Private clinic, Another private medical facility (including pharmacy, shop, traditional healer), 98: DK, 99: RF
		
		** M3 vars (delivery): 
			*m3_501: Did you deliver in a health facility? (y/n)
			*m3_502: What kind of facility was it? (1 : Gov't hospital, 2: Gov't health center, 3: Gov't health post, 4: NGO/faith-based health facility, 5: Private hospital, 6: Private speciality maternity center, 7: Private speciality maternity clinics, 8: Private clinic, 9: Another private medical facility (including pharmacy, shop, traditional healer), 98: DK, 99: NR/RF)
			
		** M4 vars (PNC): 
			*asks about any new health consulatations:
			*m4_403a, m4_403b, m4_403c
				*1 : In your home, 2: Someone else's home, 3: Gov't hospital, 4: Gov't health center, 5: Gov't health post, 6: NGO/faith-based health facility, 7: Private hospital, 8: Private speciality maternity center, 9: Private speciality maternity clnic, Private clinic, Another private medical facility (including pharmacy, shop, traditional healer), 98: DK, 99: RF

			
		** M5 vars (PNC):
			*asks about any new health consulatations:
			*m5_503_1, m5_503_2, m5_503_3
			
*-------Women who changed facility type (explore)


*-------Indicator for facility type (private vs. public vs. faith-based facilities)		

*===============================================================================*
*Define women whose OOP costs for maternal care equates to "catastrophic health expenditures" (>10% of annual income spent on maternal health)
	*o	Incidence of catastrophic health expenditures
	*o	Intensity of catastrophic health expenditures
	*o	Income variable will be problematic because of self-report bias and unreliable measure for subsistence farmers. Are data available about household expenditures on other items (food and non-food expenditures?)


*-------
*Variables (income):		
		** M5 vars (PNC): m5_1202
		
*Analysis vars (created above):
		** Total spent	
		
*------- Variable for 10% of annual income (multiply monthly income)

*-------Variable for women who spent more than 10% of annual income		

*===============================================================================*
*MULTIVARIABLE ANALYSIS:
*We could then assess what factors are associated with catastrophic health expenditures:
	*•	Lower wealth at BL, poor self-reported health or pre-existing conditions at BL, insurance status, rural residence, primiparity, complications with previous pregnancies
	*•	Note: even small expenditures may be catastrophic for low-income families. But they may have fewer expenditures if they are eligible for subsidized/free care. 
	*•	Of interest: catastrophic expenditures and UX, healthcare utilization, health outcomes but all these analyses would be mired in endogeneity issues. 

		*ANALYSIS:
		***append ET, KE, and ZA datasets
		***local currency amounts - currency conversion from (seperate dataset for currency converstion values and do a loop, median income for people in the county? )

*-------
*Variables:		
		
		
*===============================================================================*	

*other questions we could explore:
	* Confidence affording care if became sick: m1_304
	* 404. How confident are you that you would be able to afford the healthcare you needed if you became very sick? This means you would be able to afford care without suffering financial hardship.:m5_404
	
	
*===============================================================================*
/* Save new dataset 	   
	   
save "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/OOP paper/Data/cr_oop_paper.dta", replace
