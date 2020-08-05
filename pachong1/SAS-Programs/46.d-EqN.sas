options pageno=min nodate formdlim='-';
title 'Estimate Cohen''s d, Independent or Correlated Samples with Equal Sample Sizes';
Data D;
**************************************************************************************************************
Replace mmmm with the sample means.
Replace ssss with the sample standard deviations
**************************************************************************************************************;
M1 = mmmm  ;   SD1 = ssss;
M2 = mmmm  ;   SD2 = ssss;
**************************************************************************************************************;
d = (m1-m2) / SQRT(.5*(sd1*sd1+sd2*sd2));
Proc print; var g; run;
**************************************************************************************************************
d is estimated Cohen's d.  Please note that the denominator is the pooled standard deviation.  I opine that with correlated samples this standardizer is usually more appropriate than the standard deviation of the difference scores.
***************************************************************************************************************;
