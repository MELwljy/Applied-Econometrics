*Computer Based Problems

*1.Weight Loss
 
 *(b)
 clear all
 
 use "C:\Users\WLJY8\Desktop\资料\ECO 375\A1\WeightFoodDays.dta"
 describe
 summarize
 gen BMI=(WeightPounds/2.2)/1.73^2
 
 tabstat WeightPounds WaistInches PlatesFoodCons BMI, s(mean v sd n)
 
 *(c)
 scatter WeightPounds TimeUnitDay

 scatter WaistInches TimeUnitDay
 
 *(d)
 reg WeightPounds TimeUnitDay

 * iv) 7221.293 - 0.3240695 * TimeUnitDay =145, 
 *TimeUnitDay = 21835.7266
 di %td 21835.7266
 
* 2. Exports and Employment.
* (a)
 
 clear all
 use "C:\Users\WLJY8\Desktop\资料\ECO 375\A1\AMS_exporters.dta"

 describe
 
 gen total_employment= employment_w + employment_m
 
 tabstat exports total_employment, s(mean sd median p25 p75 )
 
 gen lnexports = log(exports)
 
 gen lntotal_employment = log(total_employment)
 
 tabstat lnexports lntotal_employment, s(mean sd median p25 p75 )
 
 * (b)
 scatter lnexports lntotal_employment
 
 * （c）
 reg lnexports lntotal_employment

 
 * （d）
 * median of total_employment is 94
 * median of lntotal_employment is 4.543295
 gen lnest_exports = _b[_cons] + _b[lntotal_employment] * 4.543295
 sum(lnest_exports)

 gen est_exports=exp( 14.0998 )
 sum(est_exports)

* est_exports=e^lnest_exports= 1328818

 
 * (e)
 gen lnmaterials = log(materials)
 
 gen lncapital = log(capital)
 
 reg  lnexports lntotal_employment lnmaterials lncapital
 
 scatter total_employment materials
 scatter total_employment capital
 
 *（f）
 reg lntotal_employment lnmaterials lncapital
  
 gen lntotal_employment_new = _b[_cons] + _b[lnmaterials]* lnmaterials +_b[lncapital]* lncapital
  
 gen est_error = lntotal_employment - lntotal_employment_new

 sum(est_error)
 
 reg lnexports est_error 


 
* 3. Monte Carlo Simulation.*
 
 * a) 
clear all
set seed 123456

program regression1, rclass
drop _all
set obs 100
gen x1 = rnormal(0,1)
gen v = rnormal(-1,2)
gen x2 = 0.4*x1 + v
gen u = rnormal(0,3)
gen y = 5 - 2*x1-3*x2 + u
reg y x1 x2
return scalar b1 = _b[x1]
return scalar b2 = _b[x2]
return scalar b0 = _b[_cons]
end 

simulate "regression1" b0 = r(b0) b1 = r(b1) b2 = r(b2), reps(1000)

* summarize
sum b0 b1 b2
hist b0, frequency normal name(beta0)
hist b1, frequency normal name(beta1)
hist b2, frequency normal name(beta2)


 *b) 

clear all
set seed 123456
program regression2, rclass
drop _all
set obs 100
gen x1 = rnormal(0, 1)
gen v = rnormal(-1,2)
gen x2 = 0.4*x1 + v
gen u = rnormal(0,3)
gen y = 5 - 2*x1-3*x2 + u
reg y x1 
return scalar b1 = _b[x1]
return scalar b0 = _b[_cons]
end 

simulate "regression2" b0 = r(b0) b1 = r(b1), reps(1000)
sum b0 b1
hist b0, frequency normal name(beta0)
hist b1, frequency normal name(beta1)


