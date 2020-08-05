*******     CHISQ.sas     *******;
options formdlim='-' pageno=min nodate;
title 'Chi-Square via PROC FREQ on SAS';
title2 'Escalator Use and Obesity';
proc format; value  wgt 1='Obese' 2='Overweight' 3='Normal';
  value dir 1='Ascending' 2='Descending'; value dev 1='stairs' 2='escalate'; run;
data Lotus; input weight direct device freq;
format weight wgt. direct dir. device dev. ;
cards;
1 1 1 10
1 1 2 205
1 2 1 14
1 2 2 81
2 1 1 22
2 1 2 538
2 2 1 143
2 2 2 372
3 1 1 82
3 1 2 998
3 2 1 174
3 2 2 578
proc freq; tables direct*device weight*direct*device / chisq relrisk nopercent nocol; 
  weight freq; run;
********************************  Create a new format  ***************************;
data Format;
title  'Contingency Table Analysis After Categorizing a Continuous Variable.'; run;
proc format;
  value add   1='low add'   2='medium add' 3 = 'high add' 0 = 'low/medium add';
  value rep  0='promoted'   1='repeated';
******************************* Read in Howell.dat and do CTA ********************;
data Sol; infile 'C:\Users\Vati\Documents\StatData\howell.dat';
input addsc sex repeat iq engl engg gpa socprob dropout;
if 0 < addsc <= 47 then add_cat = 1;
  else if 47 < addsc <= 56 then add_cat = 2; 
  else if addsc > 56 then add_cat = 3;
format add_cat add. repeat rep. ;
proc freq; tables add_cat*repeat / expected nocol nopercent chisq; run;
****************** Compare High Group with Other Groups Combined *****************;
Data LoMed; set Sol;
If add_cat < 3 then add_cat = 0;
proc freq; tables add_cat*repeat / relrisk nocol nopercent chisq; run;
