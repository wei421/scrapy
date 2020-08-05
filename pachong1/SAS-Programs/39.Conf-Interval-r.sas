options pageno=min nodate formdlim='-';
title 'Compute 95% Confidence Interval for Pearson r';
Data CI;
**************************************************************************************************************
Replace rrrr with the computed value of the Pearson r.
Replace nnn with the sample size -- number of pairs of scores.
For confidence other than 95%, replace 1.96 with the appropriate value.
**************************************************************************************************************;
r = rrrr  ;
n = nnn  ;
**************************************************************************************************************;
zeta = .5*log(ABS((1+r)/(1-r)));
half_range = 1.96*SQRT(1/(n-3));
zeta1 = zeta - half_range;
zeta2 = zeta + half_range;
r_lower=(exp(2*zeta1)-1)/(exp(2*zeta1)+1);
r_upper=(exp(2*zeta2)-1)/(exp(2*zeta2)+1);
proc print; var r n r_lower r_upper; run;
