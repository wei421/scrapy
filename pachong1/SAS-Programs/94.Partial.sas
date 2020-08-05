options pageno=min nodate formdlim='-';
title 'Multiple Regression, Data from Page 496 of Howell (6th ed.)'; run;
data Lotus; 
input Overall Teach Exam Knowledge Grade Enroll @@;
Z_Overall = (Overall - 3.55) / .6135378;
Z_Teach = (Teach - 3.664) / .5321347;
Z_Exam = (Exam - 3.808) / .4931531;
Z_Knowledge = (Knowledge - 4.176) / .4078615;
Z_Grade = (Grade - 3.486) / .3510974;
Z_Enroll = (Enroll - 88) / 145.059453;
  cards;
3.4 3.8 3.8 4.5 3.5 21  2.9 2.8 3.2 3.8 3.2 50  2.6 2.2 1.9 3.9 2.8 800
3.8 3.5 3.5 4.1 3.3 221  3.0 3.2 2.8 3.5 3.2 7  2.5 2.7 3.8 4.2 3.2 108
3.9 4.1 3.8 4.5 3.6 54  4.3 4.2 4.1 4.7 4.0 99  3.8 3.7 3.6 4.1 3.0 51
3.4 3.7 3.6 4.1 3.1 47  2.8 3.3 3.5 3.9 3.0 73  2.9 3.3 3.3 3.9 3.3 25
4.1 4.1 3.6 4.0 3.2 37  2.7 3.1 3.8 4.1 3.4 83  3.9 2.9 3.8 4.5 3.7 70
4.1 4.5 4.2 4.5 3.8 16  4.2 4.3 4.1 4.5 3.8 14  3.1 3.7 4.0 4.5 3.7 12
4.1 4.2 4.3 4.7 4.2 20  3.6 4.0 4.2 4.0 3.8 18  4.3 3.7 4.0 4.5 3.3 260
4.0 4.0 4.1 4.6 3.2 100  2.1 2.9 2.7 3.7 3.1 118  3.8 4.0 4.4 4.1 3.9 35
2.7 3.3 4.4 3.6 4.3 32  4.4 4.4 4.3 4.4 2.9 25  3.1 3.4 3.6 3.3 3.2 55
3.6 3.8 4.1 3.8 3.5 28  3.9 3.7 4.2 4.2 3.3 28  2.9 3.1 3.6 3.8 3.2 27
3.7 3.8 4.4 4.0 4.1 25  2.8 3.2 3.4 3.1 3.5 50  3.3 3.5 3.2 4.4 3.6 76
3.7 3.8 3.7 4.3 3.7 28  4.2 4.4 4.3 5.0 3.3 85  2.9 3.7 4.1 4.2 3.6 75
3.9 4.0 3.7 4.5 3.5 90  3.5 3.4 4.0 4.5 3.4 94  3.8 3.2 3.6 4.7 3.0 65
4.0 3.8 4.0 4.3 3.4 100  3.1 3.7 3.7 4.0 3.7 105  4.2 4.3 4.2 4.2 3.8 70
3.0 3.4 4.2 3.8 3.7 49  4.8 4.0 4.1 4.9 3.7 64  3.0 3.1 3.2 3.7 3.3 700
4.4 4.5 4.5 4.6 4.0 27  4.4 4.8 4.3 4.3 3.6 15  3.4 3.4 3.6 3.5 3.3 40
4.0 4.2 4.0 4.4 4.1 18  3.5 3.4 3.9 4.4 3.3 90
;
* STEP 1; *********************************************************************;
Proc Reg; Model Overall = Teach -- Enroll / scorr2 pcorr2 tol stb;
Title2 'Analysis on Raw Data'; run;
* STEP 2; *********************************************************************;
Proc Reg; Model Z_Overall = Z_Teach -- Z_Enroll;
Title 'Analysis on Standardized Data'; run;
* STEP 1; *********************************************************************;
Proc Reg; Model Teach = Exam -- Enroll;
Output out = Resids1  r = Teach_Resid;
Title 'Create Residuals for Teach Predicted From All Remaining Predictors'; run;
* STEP 3; *********************************************************************;
Proc Reg; Model Overall = Exam -- Enroll;
Output out = Resids2  r = Overall_Resid;
Title 'Create Residuals for Overall Predicted From All Except Teach'; run;
* STEP 4; *********************************************************************;
Proc Reg; Model Overall_Resid = Teach_resid / stb;
Title 'Use the Part of Teach Not Related to the Other Predictors';
Title2 'To Predict the Part of Overall Not Related to those Other Predictors';
run;
proc means mean stdev; var Overall Overall_Resid Teach Teach_resid; 
Title 'Descriptive Statistics on Overall, Teach, and Their Residuals'; run;
* STEP 5; *********************************************************************;
Proc Corr nosimple; Var Overall; With Teach_resid; 
Title 'Correlation Between All of Overall and the Part of Teach Not Related';
Title2 'To the Other Predictors'; run;
