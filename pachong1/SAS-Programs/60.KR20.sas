options formdlim='-';
title 'Computing the Kuder-Richardson 20'; run;
data kr; input q1-q10;
*Next line needed only for little program below, not needed for proc corr;
TOT=Q1+Q2+Q3+Q4+Q5+Q6+Q7+Q8+Q9+Q10;
cards;
1 1 1 1 1 1 0 1 1 0
1 0 1 1 0 1 1 1 0 1
1 1 1 1 0 1 1 0 0 1
0 0 1 0 0 0 1 0 0 0
0 0 0 0 0 1 0 0 1 0
1 1 1 0 1 1 1 1 1 1
1 1 0 1 1 1 0 1 1 1
1 1 1 1 1 1 1 1 0 1
0 1 0 1 1 1 1 1 0 1
1 1 0 1 1 0 1 1 1 0
proc corr nosimple nocorr nomiss alpha; var q1-q10;
title2 'the easy way, let proc corr do it'; run;
PROC MEANS VAR CSS; VAR Q1-Q10 TOT;
OUTPUT OUT=VAROUT VAR=VQ1-VQ10 VTOT;
title2 'Little program that shows how a KR20 is computed';
title3 'Variances are with (N-1) in denominator.  For variance with (N)';
title4 'in denominator, divide CSS (corrected sum of squares) by N (10).'; run;
DATA _NULL_; FILE PRINT; SET VAROUT;
SUMVAR = SUM(OF VQ1-VQ10);
ALPHA = (10/9) * (1 - SUMVAR/VTOT); PUT ALPHA = ; run;
