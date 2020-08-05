********** ANOVA1-LS.sas **********;
options pageno=min nodate formdlim='-';
DATA Dummy; INPUT Y X1-X3 @@;
TITLE1 'Dummy Variable Coded 1-Way ANOVA'; CARDS;
8 1 0 0   9 1 0 0    7 1 0 0          5 0 1 0   7 0 1 0   3 0 1 0 
3 0 0 1   4 0 0 1    1 0 0 1          6 0 0 0   4 0 0 0   9 0 0 0 
PROC REG simple corr; MODEL Y = X1-X3; run;
************************************;
DATA Effects; INPUT Y X1-X3 @@;
Title1 'Effects Coded 1-Way ANOVA'; CARDS;
8 1 0 0   9 1 0 0    7 1 0 0          5 0 1 0   7 0 1 0   3 0 1 0
3 0 0 1   4 0 0 1    1 0 0 1          6 -1 -1 -1   4 -1 -1 -1   9 -1 -1 -1
PROC REG simple corr; MODEL Y = X1-X3; run;
************************************;
DATA Contrast; INPUT Y X1-X3 @@;
TITLE1 'Contrast Coded 1-Way ANOVA'; CARDS;
8 1 1 0     9 1 1 0      7 1 1 0         5 1 -1 0    7 1 -1 0    3 1 -1 0
3  -1 0 1   4  -1 0 1    1  -1 0 1       6 -1 0 -1   4 -1 0 -1   9 -1 0 -1
PROC REG simple corr; MODEL Y = X1-X3; run;
************************************;
DATA StandardContrast; INPUT Y X1-X3 @@;
TITLE1 'Standard Contrast Coded 1-Way ANOVA'; CARDS;
8 .5 .5 0     9 .5 .5 0      7 .5 .5 0         5 .5 -.5 0    7 .5 -.5 0    3 .5 -.5 0
3  -.5 0 .5   4  -.5 0 .5    1  -.5 0 .5       6 -.5 0 -.5   4 -.5 0 -.5   9 -.5 0 -.5
PROC REG simple corr; MODEL Y = X1-X3; run;
***************************************************************************;
DATA GLM; INPUT Y A @@; 
TITLE1 'Let GLM Do It'; CARDS;
8 1  9 1  7 1   5 2  7 2  3 2   3 3  4 3  1 3   6 4  4 4  9 4
PROC GLM; CLASS A; MODEL Y = A / SS1;
CONTRAST '12 VS 34' A 1 1 -1 -1;
CONTRAST '1 VS 2'   A 1 -1 0 0;
CONTRAST '3 VS 4'   A 0 0 1 -1;
CONTRAST '12s VS 34s' A .5 .5 -.5 -.5;
CONTRAST '1s VS 2s'   A .5 -.5 0 0;
CONTRAST '3s VS 4s'   A 0 0 .5 -.5; run;
run; quit;
