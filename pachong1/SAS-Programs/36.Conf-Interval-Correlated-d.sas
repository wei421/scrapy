options pageno=min nodate formdlim='-';
title 'Compute 95% Confidence Interval for d for correlated samples, large N';
Data CI;
**************************************************************************************************************
Replace dddd with the computed value of Cohen's d).
Replace nnnnn with the sample size -- number of pairs of scores.
Replace rrrr with the correlation between the two samples.
For confidence other than 95%, replace 1.96 with the appropriate value.
You need large sample sizes for this approximate confidence interval.
**************************************************************************************************************;
d = dddd  ;
n = nnnn  ;
r = rrrr  ;
**************************************************************************************************************;
SE = SQRT((.5*d*d/(n-1))+2*(1-r)/n);
CI1 = d - 1.96*SE;  CI2 = d + 1.96*SE;
proc print; var SE CI1 CI2; run;
