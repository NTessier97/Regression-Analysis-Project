clear all

use "C:\Users\ntess\Downloads\canadiancollege.dta" 

sum

tab sex, gen(gender) //gender1 gender2

rename gender1 female
rename gender2 male

tab mtongue, gen(mtongue) //mtongue1 mtongue2 mtongue3

rename mtongue1 english
rename mtongue2 french
rename mtongue3 other_lang

tab birthplace, gen(birthplace) //birthplace1 birthplace2 birthplace3 birthplace4

rename birthplace1 america
rename birthplace2 asia
rename birthplace3 canada
rename birthplace4 other_place

drop suspended_ever
gen suspended_ever=0
replace suspended_ever=1 if suspended_year1==1 | suspended_year2==1

gen GPA_total = (GPA_year1+GPA_year2)/2

gen probation_ever=0
replace probation_ever=1 if probation_year1==1 | probation_year2==1

gen hsgrade_pctXtotcredits_year1=hsgrade_pct*totcredits_year1

reg probation_ever GPA_total totcredits_year1 totcredits_year2 age_at_entry gpacutoff campus2 hsgrade_pct female english french america asia canada, robust

reg probation_ever GPA_total totcredits_year1 totcredits_year2 gpacutoff campus2 hsgrade_pct, robust

predict probation_everhatlpm
hist probation_everhatlpm

probit probation_ever GPA_total totcredits_year1 totcredits_year2 gpacutoff campus2 hsgrade_pct

predict probation_everhatprobit
hist probation_everhatprobit

margins, dydx(*)

reg gradin4 GPA_year1 GPA_year2 totcredits_year1 totcredits_year2 age_at_entry probation_ever suspended_ever gpacutoff campus2 hsgrade_pct female english french america asia canada, robust

reg gradin4 GPA_year1 GPA_year2 totcredits_year1 totcredits_year2 probation_ever suspended_ever gpacutoff hsgrade_pct female english french asia canada, robust

predict gradin4hatlpm
hist gradin4hatlpm

probit gradin4 GPA_year1 GPA_year2 totcredits_year1 totcredits_year2 i.probation_ever i.suspended_ever gpacutoff hsgrade_pct i.female i.english i.french i.asia i.canada

predict gradin4hatprobit
hist gradin4hatprobit

margins, dydx(probation_ever)

reg GPA_year2 GPA_year1 totcredits_year1 totcredits_year2 age_at_entry probation_year1 suspended_year1 suspended_year2 campus2 campus3 hsgrade_pct female english french america asia canada

reg GPA_year2 GPA_year1 totcredits_year1 totcredits_year2 probation_year1 suspended_year2 campus2 hsgrade_pct female english asia
 
 