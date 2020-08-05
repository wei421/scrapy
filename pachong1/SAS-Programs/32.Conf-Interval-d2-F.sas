options pageno=min nodate formdlim='-';
title 'Compute 95% Confidence Interval for d, Standardardized Difference Between Two Independent Population Means';
Data CI;
**************************************************************************************************************
Replace ffff with the computed value of the independent samples F on one df.
Replace dd with the degrees of freedom for the error term.
Replace n1n with the sample size for the first group.
Replace n2n with the sample size for the second group.
**************************************************************************************************************;
F= ffff  ;
df = dd  ;
n1 = nn  ;
n2 = nn  ;
**************************************************************************************************************;
t=sqrt(F);
d = t/sqrt(n1*n2/(n1+n2));
ncp_lower = TNONCT(t,df,.975);
ncp_upper = TNONCT(t,df,.025);
d_lower = ncp_lower*sqrt((n1+n2)/(n1*n2));
d_upper = ncp_upper*sqrt((n1+n2)/(n1*n2));
output; run; proc print; var d d_lower d_upper; run;
**************************************************************************************************************
d is estimated Cohen's d.
d_lower and d_upper are the lower and upper limits for a 95% confidence interal for Cohen's d.
For a different degree of confidence, just change the values in ncp_lower and ncp_upper -- for example, change them
from .975 and .025 to .95 and .05 if you want 90% confidence.
***************************************************************************************************************;

