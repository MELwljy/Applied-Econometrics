/*Q2-1*/

use "C:\Users\WLJY8\Desktop\资料\ECO 375\A2\ANES2016.dta"
summarize
/* a.*/
reg loginc female black age agesq educ1 educ2 educ3 educ4

/* b.*/
reg loginc female black age agesq educ0 educ2 educ3 educ4

/* c.*/
test (age == 0) (agesq ==0)


/*Q2-2*/

use "C:\Users\WLJY8\Desktop\资料\ECO 375\A2\PWT_data.dta"
summarize

/* a.*/
gen y1995 = gdp1995/pop1995
gen y1975 = gdp1975/pop1975
gen result1 = log(y1995/y1975)
gen loggdp1975percapita=log(gdp1975/pop1975)
reg result loggdp1975percapita

/* b.*/
reg result loggdp1975percapita hci1975

/* c.*/
reg result loggdp1975percapita  gcf1975 hci1975
test (gcf1975 == 0) (hci1975 == 0)


/*Q2-3*/
clear all
set seed 123456
program reg1, rclass
drop _all
set obs 100
gen X=runiform(0,1)
gen U=rnormal(0,5)
gen Y= -10 + 5*X + U
reg Y X
/*
gen t_value= _b[X]/_se[X] - 5/_se[X]
gen p_value= 2*ttail(98，t_value)
*/
return scalar b1=_b[X]
return scalar b0=_b[_cons]
return scalar p_value= 2*ttail(98, abs(_b[X]/_se[X] - 5/_se[X]))
end

simulate  reg1 p_value=r(p_value) b1=r(b1) b0=r(b0),reps(1000)
sum p_value b1 b0

count if p_value < 0.05


clear all
set seed 123456
program reg2, rclass
drop _all
set obs 100
gen X=runiform(0,1)
gen U=rnormal(0,5)
gen Y= -10 + 5*X + U
reg Y X
/*
gen t_value= _b[X]/_se[X] - 5/_se[X]
gen p_value= 2*ttail(98，t_value)
*/
return scalar b1=_b[X]
return scalar b0=_b[_cons]
return scalar p_value= 2*ttail(98, abs(_b[X]/_se[X] - 4.5/_se[X]))
end

simulate  reg2 p_value=r(p_value) b1=r(b1) b0=r(b0),reps(1000)
sum p_value b1 b0

count if p_value <0.05



clear all
set seed 123456
program reg3, rclass
drop _all
set obs 100
gen X=runiform(0,1)
gen U=rnormal(0,5)
gen Y= -10 + 5*X + U
reg Y X
/*
gen t_value= _b[X]/_se[X] - 5/_se[X]
gen p_value= 2*ttail(98，t_value)
*/
return scalar b1=_b[X]
return scalar b0=_b[_cons]
return scalar p_value= 2*ttail(98, abs(_b[X]/_se[X] - 0/_se[X]))
end

simulate  reg3 p_value=r(p_value) b1=r(b1) b0=r(b0),reps(1000)
sum p_value b1 b0

count if p_value <0.05




