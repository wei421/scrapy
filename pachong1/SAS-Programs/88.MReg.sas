options pageno=min nodate formdlim='-';
title 'Multiple Regression, Four Predictors'; run;
data grades; infile 'C:\Users\Vati\Documents\_XYZZY\_Stats\StatData\multreg.dat';
input GPA GRE_Q GRE_V MAT AR;
proc corr;
proc reg; model GPA = GRE_Q -- AR / stb scorr2 tol vif;
  output out = hats p = GPA_hat; run; quit;
proc corr; var GPA; with GPA_hat; run;
proc GLM; model GPA = GRE_Q -- AR / ss1 EFFECTSIZE alpha=.10; run; quit;
