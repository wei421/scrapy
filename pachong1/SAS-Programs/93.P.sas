options formdlim='-' pageno=min nodate;
title 'Obtaining Exact Significance Levels With SAS:  Output values are p-values'; run;
data p;
 Z = 2*PROBNORM(-1.96);
 B4cum = PROBBNML(.6, 10, 4);
 B3cum = PROBBNML(.6, 10, 3);
 B4only = B4cum - B3cum;
 C = 1-PROBCHI(10.55, 5);
 T = 2*PROBT(-2.92, 36);
 F = 1-PROBF(6.94, 2, 4);
proc print; run;
Title'Obtaining Critical Values (Quantiles)'; run;
data q;
Z975 = PROBIT(.975);
C95 = CINV(.95, 5);
T975 = TINV(.975, 36);
F95 = FINV(.95, 2, 4);
Cook0 = FINV(.5, 2, 89);
Cook1 = FINV(.5, 2, 61);
proc print; run;
