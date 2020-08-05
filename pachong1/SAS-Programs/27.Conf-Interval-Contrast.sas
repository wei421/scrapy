options pageno=min nodate formdlim='-';
title 'Compute 95% Confidence Interval for Standardized Contrast';
Data CI;
**************************************************************************************************************
Replace tttt with the computed value of the contrast t.
Replace dd with the degrees of freedom for the error term.
Replace n1n with the sample size for the first group.
Replace n2n with the sample size for the second group.
Replace n3n with the sample size for the third group.
Replace c1c, c2c, and c3c with the standard contrast coefficients for the desired contrast;

**************************************************************************************************************;
t= tttt  ;
df = dd  ;
n1 = n1n  ;
n2 = n2n  ;
n3 = n3n  ;
c1 = c1c  ;
c2 = c2c  ;
c3 = c3c  ;
**************************************************************************************************************;
ncp_lower = TNONCT(t,df,.975);
ncp_upper = TNONCT(t,df,.025);
d_lower = ncp_lower*sqrt(c1*c1/n1 + c2*c2/n2 + c3*c3/n3);
d_upper = ncp_upper*sqrt(c1*c1/n1 + c2*c2/n2 + c3*c3/n3);
output; run; proc print; var d_lower d_upper; run;
**************************************************************************************************************
d_lower and d_upper are the lower and upper limits for a 95% confidence interal for the standardized contrast.
For a different degree of confidence, just change the values in ncp_lower and ncp_upper -- for example, change them
from .975 and .025 to .95 and .05 if you want 90% confidence.
For more than three groups, just expand the program by adding additional values of n and c.
Contrast coefficients must be standard: The coefficients for the one set must equal +1 divided by
the number of conditions in that set, while those for the other set must equal -1 divided by
the number of conditions in that other set.  For example,  -1, .5, .5 to compare group 1 with combined groups 2 and 3.
***************************************************************************************************************;

