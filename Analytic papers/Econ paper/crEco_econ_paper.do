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
		
		** M5 vars (PNC): m5_1001 (any expense- y/n), m5_1002a m5_1002b m5_1002c m5_1002d m5_1002e, m5_1003, m5_1004

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
gen totalspent_m2_r1 = m2_703_r1 
replace totalspent_m2_r1 = m2_704_confirm_r1 if m2_704_r1 == 0 //& m2_704_confirm_r1 !=.a // Some people did not answer the subsequent question so I'm using their original answer here
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
*check:  totalspent_m2 totalspent_m2_r1 totalspent_m2_r2 totalspent_m2_r3 totalspent_m2_r4 totalspent_m2_r5 totalspent_m2_r6 totalspent_m2_r7 totalspent_m2_r8

*adding back total spent in M1
egen totalspent_anc = rowtotal(m1_1219 totalspent_m2)
lab var totalspent_anc "Total spent during ANC period"
*check:  totalspent_anc m1_1219 totalspent_m2

*drop totalspent_m2_r1 totalspent_m2_r2 totalspent_m2_r3 totalspent_m2_r4 totalspent_m2_r5 totalspent_m2_r6 totalspent_m2_r7 totalspent_m2_r8 totalspent_m2

*----Delivery:
*egen totalspent_del = rowtotal(m3_1102a_amt m3_1102b_amt m3_1102c_amt m3_1102d_amt m3_1102e_amt m3_1102f_amt) 
*check: totalspent_del m3_1103 //did this to double-check and all data adds up, don't need this code anymore

gen totalspent_del = m3_1103 
replace totalspent_del = m3_1102_total if m3_1103_confirm == 0 & m3_1102_total !=. & m3_1102_total !=.d // N=11 people said "No" to m3_1103_confirm and have other data for m3_1104 confirm, confirm with Aleks that its ok to replace the data in m3_1103 with m3_1104 (the value)
lab var totalspent_del "Total spent during delivery"
*check: br totalspent_del m3_1103 m3_1102_total m3_1103_confirm


*PNC:
gen totalspent_m4 = m4_903
replace totalspent_m4 = m4_904 if m4_904 !=. // There was no y/n trigger question here. It looks like we had a calculated field in redcap (m4_903) then we asked them to confirm the amount in m4_904. Most numbers were the same though.
*check: totalspent_m4 m4_903 m4_904

gen totalspent_m5 = m5_1003
replace totalspent_m5 = m5_1004 if m5_1003_confirm == 0 & m5_1004 !=.
*check: totalspent_m5 m5_1003 m5_1004 m5_1003_confirm

egen totalspent_pnc = rowtotal(totalspent_m4 totalspent_m5)
lab var totalspent_pnc "Total spent during PNC"

*check: br totalspent_pnc totalspent_m4 totalspent_m5

*drop totalspent_m4 totalspent_m5
	
*--------Across whole pregnancy: total spent on each item:

**Aleks: please note that ET has an extra question about services "Have you spent money for Medicine/vaccines(including outside purchase)?" not in other countries that i've excluded for now. (m1_1218b, m3_1102b)

*-----Total spent during ANC
	*total spent on Registration:	
egen totalspent_reg_anc = rowtotal(m1_1218a_1 m2_702a_cost_r1 m2_702a_cost_r2 m2_702a_cost_r3 m2_702a_cost_r4 m2_702a_cost_r5 m2_702a_cost_r6 m2_702a_cost_r7 m2_702a_cost_r8)
lab var totalspent_reg_anc "ANC: total spent on registration"
*check: br totalspent_reg_anc m1_1218a_1 m2_702a_cost_r1 m2_702a_cost_r2 m2_702a_cost_r3 m2_702a_cost_r4 m2_702a_cost_r5 m2_702a_cost_r6 m2_702a_cost_r7 m2_702a_cost_r8
	
	*total spent on Test/investigations:
egen totalspent_tests_anc = rowtotal(m1_1218c_1 m2_702b_cost_r1 m2_702b_cost_r2 m2_702b_cost_r3 m2_702b_cost_r4 m2_702b_cost_r5 m2_702b_cost_r6 m2_702b_cost_r7 m2_702b_cost_r8)
lab var totalspent_tests_anc "ANC: total spent on tests or investigations"	
*check: br totalspent_tests_anc m1_1218c_1 m2_702b_cost_r1 m2_702b_cost_r2 m2_702b_cost_r3 m2_702b_cost_r4 m2_702b_cost_r5 m2_702b_cost_r6 m2_702b_cost_r7 m2_702b_cost_r8	
	
	*total spent on Transport:
egen totalspent_transport_anc = rowtotal(m1_1218d_1 m2_702c_cost_r1 m2_702c_cost_r2 m2_702c_cost_r3 m2_702c_cost_r4 m2_702c_cost_r5 m2_702c_cost_r6 m2_702c_cost_r7 m2_702c_cost_r8)
lab var totalspent_transport_anc "ANC: total spent on transport"		
*check: br totalspent_transport_anc m1_1218d_1 m2_702c_cost_r1 m2_702c_cost_r2 m2_702c_cost_r3 m2_702c_cost_r4 m2_702c_cost_r5 m2_702c_cost_r6 m2_702c_cost_r7 m2_702c_cost_r8
	
	*total spent on Food/accomodation:
egen totalspent_food_anc = rowtotal(m1_1218e_1 m2_702d_cost_r1 m2_702d_cost_r2 m2_702d_cost_r3 m2_702d_cost_r4 m2_702d_cost_r5 m2_702d_cost_r6 m2_702d_cost_r7 m2_702d_cost_r8)
lab var totalspent_food_anc "ANC: total spent on food"	
*check: br totalspent_food_anc m1_1218e_1 m2_702d_cost_r1 m2_702d_cost_r2 m2_702d_cost_r3 m2_702d_cost_r4 m2_702d_cost_r5 m2_702d_cost_r6 m2_702d_cost_r7 m2_702d_cost_r8

	*total spent on Other item/service:
egen totalspent_oth_anc = rowtotal(m1_1218f_1 m2_702e_cost_r1 m2_702e_cost_r2 m2_702e_cost_r3 m2_702e_cost_r4 m2_702e_cost_r5 m2_702e_cost_r6 m2_702e_cost_r7 m2_702e_cost_r8)
lab var totalspent_oth_anc "ANC: total spent on other services"	
	

*-----Total spent during delivery
	*total spent on Registration:
gen totalspent_reg_del = m3_1102a_amt
lab var totalspent_reg_del "Delivery: total spent on registration"

	*total spent on Test/investigations:
gen totalspent_tests_del = m3_1102c_amt
lab var totalspent_tests_del "Delivery: total spent on tests"	
	
	*total spent on Transport:
gen totalspent_transport_del = m3_1102d_amt
lab var totalspent_transport_del "Delivery: total spent on transport"

	*total spent on Food/accomodation:
gen totalspent_food_del = m3_1102e_amt
lab var totalspent_food_del "Delivery: total spent on food"

	*total spent on Other item/service:
gen totalspent_oth_del = m3_1102f_amt
lab var totalspent_oth_del "Delivery: total spent on other services"

*check: br totalspent_reg_del m3_1102a_amt totalspent_tests_del m3_1102c_amt totalspent_transport_del m3_1102d_amt ///
    totalspent_food_del m3_1102e_amt totalspent_oth_del m3_1102f_amt

*Total spent during PNC
	*total spent on Registration:
egen totalspent_reg_pnc = rowtotal(m4_902a_amt m5_1002a)	
lab var totalspent_reg_pnc "PNC: total spent on registration"
*check: br totalspent_reg_pnc m4_902a_amt m5_1002a

	*total spent on Test/investigations:
egen totalspent_tests_pnc = rowtotal(m4_902b_amt m5_1002b)	
lab var totalspent_tests_pnc "PNC: total spent on tests"	
	
	*total spent on Transport:
egen totalspent_transport_pnc = rowtotal(m4_902c_amt m5_1002c)	
lab var totalspent_transport_pnc "PNC: total spent on transport"	
	
	*total spent on Food/accomodation:
egen totalspent_food_pnc = rowtotal(m4_902d_amt m5_1002d)	
lab var totalspent_food_pnc "PNC: total spent on food"		
	
	*total spent on Other item/service:
egen totalspent_oth_pnc = rowtotal(m4_902e_amt m5_1002e)	
lab var totalspent_oth_pnc "PNC: total spent on other services"	

*-----Total across continuum of care:	

egen totalspent_reg = rowtotal(totalspent_reg_anc totalspent_reg_del totalspent_reg_pnc)
lab var totalspent_reg "Across entire pregnancy: total spent on registration"
*check: br totalspent_reg totalspent_reg_anc totalspent_reg_del totalspent_reg_pnc

egen totalspent_tests = rowtotal(totalspent_tests_anc totalspent_tests_del totalspent_tests_pnc)
lab var totalspent_tests "Across entire pregnancy: total spent on tests"

egen totalspent_transport = rowtotal(totalspent_transport_anc totalspent_transport_del totalspent_transport_pnc)
lab var totalspent_transport "Across entire pregnancy: total spent on transport"

egen totalspent_food = rowtotal(totalspent_food_anc totalspent_food_del totalspent_food_pnc)
lab var totalspent_food "Across entire pregnancy: total spent on food"

egen totalspent_oth = rowtotal(totalspent_oth_anc totalspent_oth_del totalspent_oth_pnc)
lab var totalspent_oth "Across entire pregnancy: total spent on other services"

*====GRAND TOTAL SPENT:

egen total_spent_all = rowtotal(totalspent_reg totalspent_tests totalspent_transport totalspent_food totalspent_oth)
lab var total_spent_all "Total spent on all services across entire pregnancy"

*check: br total_spent_all totalspent_reg totalspent_tests totalspent_transport totalspent_food totalspent_oth

*Bar graphs: (SS: edit)
*graph bar (mean) totalspent_reg (mean) totalspent_tests (mean) totalspent_transport (mean) totalspent_food (mean) totalspent_oth, blabel(name)
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
		
*-------Indicator for borrow/sell vs income,savings,reimbursement from insurance:

*SS: multi-checkbox field, people can select multiple
*SS: confirm m1_1220_5 (Family members or friends from outside the household) = borrow
gen borrow_m1 = .
replace borrow_m1 = 1 if m1_1220_6 == 1 | m1_1220_4 == 1 | m1_1220_5 == 1
replace borrow_m1 = 0 if m1_1220_6 != 1 & m1_1220_4 != 1 & m1_1220_5 != 1 // SS: confirm what the other group "0" will be (other financial sources or people who did not select borrow and sell? Right now it's the latter)

*replace borrow_m1 = 2 if m1_1220_1 == 1 | m1_1220_2 == 1 | m1_1220_3 == 1 //this was for income, savings, reimbursement but I can make that a seperate var because of multicheck box field

egen borrow_m2 = rowmax(m2_705_6_r1 m2_705_6_r2 m2_705_6_r3 m2_705_6_r4 m2_705_6_r5 m2_705_6_r6 m2_705_6_r7 m2_705_6_r8 ///
						m2_705_4_r1 m2_705_4_r2 m2_705_4_r3 m2_705_4_r4 m2_705_4_r5 m2_705_4_r6 m2_705_4_r7 m2_705_4_r8 ///
						m2_705_5_r1 m2_705_5_r2 m2_705_5_r3 m2_705_5_r4 m2_705_5_r5 m2_705_5_r6 m2_705_5_r7 m2_705_5_r8) 
			
replace borrow_m2 = 0 if borrow_m2 == . | borrow_m2 == .a

*check: br borrow_m2 m2_705_6_r1 m2_705_6_r2 m2_705_6_r3 m2_705_6_r4 m2_705_6_r5 m2_705_6_r6 m2_705_6_r7 m2_705_6_r8 m2_705_4_r1 m2_705_4_r2 m2_705_4_r3 m2_705_4_r4 m2_705_4_r5 m2_705_4_r6 m2_705_4_r7 m2_705_4_r8 m2_705_5_r1 m2_705_5_r2 m2_705_5_r3 m2_705_5_r4 m2_705_5_r5 m2_705_5_r6 m2_705_5_r7 m2_705_5_r8 
						
gen borrow_m3 = .
replace borrow_m3 = 1 if m3_1105 == 6 | m3_1105 == 4 | m3_1105 == 5
replace borrow_m3 = 0 if m3_1105 != 6 & m3_1105 != 4 & m3_1105 != 5
*check: br borrow_m3 m3_1105 

gen borrow_m4 = .
replace borrow_m4 = 1 if m4_905f ==1 | m4_905d == 1 | m4_905e == 1
replace borrow_m4 = 0 if m4_905f !=1 & m4_905d != 1 & m4_905e != 1
*check: br borrow_m4 m4_905f m4_905d m4_905e

gen borrow_m5 = .
replace borrow_m5 = 1 if m5_1005f ==1 | m5_1005d == 1 | m5_1005e == 1
replace borrow_m5 = 0 if m5_1005f !=1 & m5_1005d != 1 & m5_1005e != 1
*check: br borrow_m5 m5_1005f m5_1005d m5_1005e
 
gen borrow = .
replace borrow = 1 if borrow_m1 == 1 | borrow_m2 == 1 | borrow_m3 == 1 | borrow_m4 == 1 | borrow_m5 ==1
replace borrow = 0 if borrow_m1 != 1 & borrow_m2 != 1 & borrow_m3 != 1 & borrow_m4 != 1 & borrow_m5 !=1
*check: br borrow borrow_m1 borrow_m2 borrow_m3 borrow_m4 borrow_m5

lab def borrow 1 "Borrow/Sold items" 2 "Did not borrow/sell items"
lab val borrow_m1 borrow_m2 borrow_m3 borrow_m4 borrow_m5 borrow borrow
lab var borrow "Indicator for borrow/sell"

*===============================================================================*	
*Compare women who are insured and uninsured
	*	BL: 1221 and 1222
	
*-------
*Variables:
		** M1 vars (ANC): m1_1221 (y/n), m1_1222 (type), m1_1222_other (other type) - nothing in m1_1222_other
		
gen insured = m1_1221
gen insur_type = m1_1222

*===============================================================================*
*Depending on variation, could also assess incidence of women skipping ANC services because of high cost of care (q320)

*-------
*Variables:

		** M1 vars: 
			*m1_808_3_et
		
		** M2 vars (ANC): 	
		  *0: No reason or you didn't need it, 1: You tried but were sent away (e.g.,no appointment available), 2: High cost (e.g., high out of pocket payment, not covered by insurance), 3: Far distance (e.g., too far to walk or drive, transport not readily available), 4: Long waiting time (e.g., long line to access facility, long wait for the provider), 5: Poor healthcare provider skills (e.g., spent too little time with patient, did not conduct a thorough exam), 6: Staff don't show respect (e.g., staff is rude, impolite, dismissive), 7:Medicines or equipment are not available (e.g., medicines regularly out of stock, equipment like X-ray machines broken or unavailable)
			
			*m2_320_2_r1 m2_320_2_r2 m2_320_2_r3 m2_320_2_r4 m2_320_2_r5 m2_320_2_r6 m2_320_2_r7 m2_320_2_r8

			
*-------Indicator for incidence of women skipping ANC services because of high cost of care		
gen high_cost_m1 = m1_808_3_et

egen high_cost_m2 = rowmax(m2_320_2_r1 m2_320_2_r2 m2_320_2_r3 m2_320_2_r4 m2_320_2_r5 m2_320_2_r6 m2_320_2_r7 m2_320_2_r8) 
replace high_cost_m2 = 0 if high_cost_m2 == . | high_cost_m2 == .a	
br high_cost_m2 m2_320_2_r1 m2_320_2_r2 m2_320_2_r3 m2_320_2_r4 m2_320_2_r5 m2_320_2_r6 m2_320_2_r7 m2_320_2_r8

gen high_cost_anc = .
replace high_cost_anc = 1 if high_cost_m1 == 1 | high_cost_m2 == 1 // N=14 women here out of 1,000
replace high_cost_anc = 0 if high_cost_m1 !=1 & high_cost_m2 != 1
*check: br high_cost_anc high_cost_m1 high_cost_m2

lab def high_cost_anc 1 "Skipped anc because of high cost of care" 2 "Did not anc because of high cost of care"
lab val borrow_m1 borrow_m2 borrow_m3 borrow_m4 borrow_m5 borrow borrow
lab var borrow "Reason for skipping ANC was because of high cost (e.g., high out of pocket payment, not covered by insurance)"

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
			
*-------Indicator for facility type (private vs. public vs. faith-based facilities)	

*module 1:
gen fac_type_m1 = facility_own // 1:Public, 2:Private

*module 2:
** adding category 3 for facith based facility
gen fac_type_m2 = .
replace fac_type_m2 = 1 if m2_303a_r1 == 3 | m2_303a_r1 == 4 | m2_303a_r1 == 5 | ///
						   m2_303a_r2 == 3 | m2_303a_r2 == 4 | m2_303a_r2 == 5 | ///
						   m2_303a_r3 == 3 | m2_303a_r3 == 4 | m2_303a_r3 == 5 | ///
						   m2_303a_r4 == 3 | m2_303a_r4 == 4 | m2_303a_r4 == 5 | ///
						   m2_303a_r5 == 3 | m2_303a_r5 == 4 | m2_303a_r5 == 5 | ///
						   m2_303a_r6 == 3 | m2_303a_r6 == 4 | m2_303a_r6 == 5 | ///
						   m2_303a_r7 == 3 | m2_303a_r7 == 4 | m2_303a_r7 == 5 | ///
						   m2_303a_r8 == 3 | m2_303a_r8 == 4 | m2_303a_r8 == 5 | ///
						   
						   m2_303b_r1 == 3 | m2_303b_r1 == 4 | m2_303b_r1 == 5 | ///
						   m2_303b_r2 == 3 | m2_303b_r2 == 4 | m2_303b_r2 == 5 | ///
						   m2_303b_r3 == 3 | m2_303b_r3 == 4 | m2_303b_r3 == 5 | ///
						   m2_303b_r4 == 3 | m2_303b_r4 == 4 | m2_303b_r4 == 5 | ///
						   m2_303b_r5 == 3 | m2_303b_r5 == 4 | m2_303b_r5 == 5 | ///
						   m2_303b_r6 == 3 | m2_303b_r6 == 4 | m2_303b_r6 == 5 | ///
						   m2_303b_r7 == 3 | m2_303b_r7 == 4 | m2_303b_r7 == 5 | ///
						   m2_303b_r8 == 3 | m2_303b_r8 == 4 | m2_303b_r8 == 5 | ///
						   
						   m2_303c_r1 == 3 | m2_303c_r1 == 4 | m2_303c_r1 == 5 | ///
						   m2_303c_r2 == 3 | m2_303c_r2 == 4 | m2_303c_r2 == 5 | ///
						   m2_303c_r3 == 3 | m2_303c_r3 == 4 | m2_303c_r3 == 5 | ///
						   m2_303c_r4 == 3 | m2_303c_r4 == 4 | m2_303c_r4 == 5 | ///
						   m2_303c_r5 == 3 | m2_303c_r5 == 4 | m2_303c_r5 == 5 | ///
						   m2_303c_r6 == 3 | m2_303c_r6 == 4 | m2_303c_r6 == 5 | ///
						   m2_303c_r7 == 3 | m2_303c_r7 == 4 | m2_303c_r7 == 5 | ///
						   m2_303c_r8 == 3 | m2_303c_r8 == 4 | m2_303c_r8 == 5 | ///
						   
						   m2_303d_r1 == 3 | m2_303d_r1 == 4 | m2_303d_r1 == 5 | ///
						   m2_303d_r2 == 3 | m2_303d_r2 == 4 | m2_303d_r2 == 5 | ///
						   m2_303d_r3 == 3 | m2_303d_r3 == 4 | m2_303d_r3 == 5 | ///
						   m2_303d_r4 == 3 | m2_303d_r4 == 4 | m2_303d_r4 == 5 | ///
						   m2_303d_r5 == 3 | m2_303d_r5 == 4 | m2_303d_r5 == 5 | ///
						   m2_303d_r6 == 3 | m2_303d_r6 == 4 | m2_303d_r6 == 5 | ///
						   m2_303d_r7 == 3 | m2_303d_r7 == 4 | m2_303d_r7 == 5 | ///
						   m2_303d_r8 == 3 | m2_303d_r8 == 4 | m2_303d_r8 == 5 | ///
						   
						   m2_303e_r1 == 3 | m2_303e_r1 == 4 | m2_303e_r1 == 5 | ///
						   m2_303e_r2 == 3 | m2_303e_r2 == 4 | m2_303e_r2 == 5 | ///
						   m2_303e_r3 == 3 | m2_303e_r3 == 4 | m2_303e_r3 == 5 | ///
						   m2_303e_r4 == 3 | m2_303e_r4 == 4 | m2_303e_r4 == 5 | ///
						   m2_303e_r5 == 3 | m2_303e_r5 == 4 | m2_303e_r5 == 5 | ///
						   m2_303e_r6 == 3 | m2_303e_r6 == 4 | m2_303e_r6 == 5 | ///
						   m2_303e_r7 == 3 | m2_303e_r7 == 4 | m2_303e_r7 == 5 | ///
						   m2_303e_r8 == 3 | m2_303e_r8 == 4 | m2_303e_r8 == 5 


replace fac_type_m2 = 2 if m2_303a_r1 == 7 | m2_303a_r1 == 8 | m2_303a_r1 == 9 | m2_303a_r1 == 10 | m2_303a_r1 == 11
replace fac_type_m2 = 3 if m2_303a_r1 == 6

lab def fac_type 1 "Public" 2 "Private" 3 "Faith-based facility"
lab val fac_type_m2 fac_type
			
*-------Women who changed facility type (explore)


	

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
gen annual_income = m5_1202 * 12
*check: br annual_income m5_1202

gen annual_income_tenpercent = annual_income * 0.10
*check: br annual_income annual_income_tenpercent

*-------Variable for women who spent more than 10% of annual income		
gen catastrophic = .
replace catastrophic = 1 if (annual_income_tenpercent < total_spent_all) | annual_income_tenpercent == . // N=415 women (41.5%)
replace catastrophic = 0 if (annual_income_tenpercent >= total_spent_all) & annual_income_tenpercent < .
*check:  br catastrophic annual_income_tenpercent total_spent_all

lab def catastrophic 0 "Did not have catastrophic health expenditures" 1 "Experienced catastrophic health expenditures"
lab val catastrophic catastrophic
lab var "Women whose OOP costs for maternal care equates to 'catastrophic health expenditures' (>10% of annual income spent on maternal health)"

*===============================================================================*
*MULTIVARIABLE ANALYSIS:
*We could then assess what factors are associated with catastrophic health expenditures:
	*•	Lower wealth at BL, poor self-reported health or pre-existing conditions at BL, insurance status, rural residence, primiparity, complications with previous pregnancies
	*•	Note: even small expenditures may be catastrophic for low-income families. But they may have fewer expenditures if they are eligible for subsidized/free care. 
	*•	Of interest: catastrophic expenditures and UX, healthcare utilization, health outcomes but all these analyses would be mired in endogeneity issues. 

		*ANALYSIS/NEXT STEPS:
		***append ET, KE, and ZA datasets 
		***local currency amounts - currency conversion from (seperate dataset for currency converstion values and do a loop, median income for people in the county?)

*-------
*Variables:		
		
		
*===============================================================================*	
*other questions we could explore:
	* Confidence affording care if became sick: m1_304
	* 404. How confident are you that you would be able to afford the healthcare you needed if you became very sick? This means you would be able to afford care without suffering financial hardship.:m5_404
	
	
*===============================================================================*
/* Save new dataset 	   
	   
save "/Users/shs8688/Dropbox (Harvard University)/SPH-Kruk Team/QuEST Network/Core Research/Ecohorts/MNH E-Cohorts-internal/Analyses/Manuscripts/OOP paper/Data/cr_oop_paper.dta", replace
