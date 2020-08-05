options formdlim='-' pageno=min nodate;
title 'Polychoric Correlation via PROC FREQ on SAS';
proc format; value  wgt 1='Normal' 2='Overweight' 3='Obese';
  value mls 1='Small' 2='Medium' 3='Large'; run;
data lotus; input weight mealsize freq;
format weight wgt. mealsize mls. ;
cards;
1 1  100
1 2  205
1 3  53
2 1  80
2 2  104
2 3  157
3 1  20
3 2  50
3 3  278
proc freq; tables weight*mealsize / chisq nopercent nocol PLCORR; 
  weight freq; run;
