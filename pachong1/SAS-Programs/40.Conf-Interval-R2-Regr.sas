options pageno=min nodate formdlim='-';
title 'Compute 90% Confidence Interval for R-squared,eta-squared, fixed effect ANOVA/regression';
DATA ETA;
**************************************************************************************************************
Replace ff.ff with the computed value of the F test.
Replace nn with the degrees of freedom for numerator.
Replace dd with the degrees of freedom for the denominator.
WARNING:  Very large numerator df can cause this program to produce a confidence interval that excludes
  the sample R**2.
  See http://core.ecu.edu/psyc/wuenschk/SAS/Conf-Interval-R2-Regr-Warning.doc
**************************************************************************************************************;
F= ff.ff  ;
df_num = nn  ;
df_den = dd  ;
**************************************************************************************************************;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.95));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.05));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; run;
**************************************************************************************************************
d_lower and d_upper are the lower and upper limits for a 90% confidence interal for eta-squared or R-squared.
For a different degree of confidence, just change the values in ncp_lower and ncp_upper -- for example, change them
to .975 and .025 if you want 95% confidence.

So, why did I use 90% instead of 95% ?  See http://core.ecu.edu/psyc/wuenschk/docs30/CI-Eta2-Alpha.doc

Appropriate for fixed effects ANOVA and multiple regression, assuming fixed effects.
***************************************************************************************************************;

