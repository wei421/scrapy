options formdlim='-';
proc format; value ph 1='baseline' 2='treatment';
title 'Liza Hines'' Thesis'; run;
data brats; infile 'C:\StatData\hines.data';
input phase date $ hours puters users dirty probs fix;
proc means skewness; var hours puters users dirty probs fix; by phase;
proc ttest; class phase; var hours puters users dirty probs fix;
proc npar1way wilcoxon; exact;
class phase; var hours puters users dirty probs fix; run;
