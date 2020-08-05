***** ANCOV1.sas *****;
options FORMCHAR="|----|+|---+=|-/\<>*" pageno=min nodate formdlim='-';
TITLE 'Is there gender-bias in salaries?';
Proc Format; Value sx 1='M' 2='F'; run;
DATA LOTUS;
 INPUT GENDER QUALIFIC SALARY @@; format gender sx.; cards;
2 20 20  2 30 20  2 25 25  2 35 25  1 28 27  1 38 27  2 20 30  2 30 30  2 30 30
2 40 30  1 32 32  1 42 32  2 25 35  2 35 35  1 28 37  1 38 47  1 38 47  1 48 47
2 30 40  2 40 40  1 32 42  1 42 42  1 38 47  1 48 47  2 21 21  2 29 19  2 26 26
2 34 24  1 29 28  1 37 26  2 21 31  2 29 29  2 31 31  2 39 29  1 33 33  1 41 31
2 26 36  2 34 34  1 29 38  1 37 46  1 39 48  1 47 46  2 31 41  2 39 39  1 33 43
1 41 41  1 39 48  1 47 46
PROC PLOT;PLOT SALARY*QUALIFIC=GENDER;
******************************************************************************;
PROC CORR nosimple; Var Gender Salary Qualific; run;
PROC ANOVA; CLASS GENDER; Model QUALIFIC SALARY = Gender; Means Gender;
TITLE3 'Gender differences in qualifications and in salary ($thousands)'; run; quit;
******************************************************************************;
PROC GLM; CLASS Gender; MODEL Salary = Qualific|Gender / SS3;
title3 'Test Qualific*Gender for Homogeneity of Regression'; run; quit;
******************************************************************************;
PROC GLM; CLASS Gender; MODEL Salary = Gender Qualific(Gender) / SS3 SOLUTION;
title3 'Get Slopes for Salary Predicted From Qualifications for Each Group'; run; quit;
******************************************************************************;
PROC GLM; CLASS GENDER; MODEL SALARY = QUALIFIC GENDER / SS3 EFFECTSIZE alpha =.1;
  LSMEANS GENDER;
TITLE3 'ANCOV:  Gender differences in salary holding qualifications constant.'; run; quit;
******************************************************************************;
PROC GLM; CLASS GENDER; MODEL QUALIFIC = SALARY GENDER / SS3 EFFECTSIZE alpha =.1; LSMEANS GENDER;
TITLE3 'ANCOV:  Gender differences in qualifications holding salary constant.'; run; quit;
******************************************************************************;
