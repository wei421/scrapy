options pageno=min nodate formdlim='-';
title 'Compute 95% Confidence Interval for R-squared,eta-squared, fixed effect ANOVA/regression, Large N';
DATA ETA;
**************************************************************************************************************
Replace r2r2 with the computed value of the R-Squared.
Replace nnnn with the number of cases.
Replace ppp with the number of predictor variables
**************************************************************************************************************;
R2= r2r2  ;
n = nnnn  ;
p = ppp  ;
**************************************************************************************************************;
SE = sqrt((4*r2*(1-r2)**2*(n-p-1)**2)/((n**2-1)*(n+3)));
Lower = R2-1.96*SE; Upper = R2+1.96*SE;
output; run; proc print; run;
**************************************************************************************************************;
SE is the standard error for the R-squared.  The confidence interval runs from Lower to Upper.;
***************************************************************************************************************;

