title 'Cyberloafing, Mike Sage'; run;
ODS GRAPHICS ON; 
proc univariate plot data=Sage; var Cyberloafing Conscientiousness Age;
 Histogram / normal; PPPLot / normal; run;
 data transform; set Sage;
 SR_Age = SQRT(Age);  Log_Age = Log10(Age);
 Proc Means skewness kurtosis; Var Age SR_Age Log_Age; run;
proc corr data=Sage; var Cyberloafing Conscientiousness Age;
proc reg data=Sage; a: model Cyberloafing = Conscientiousness; 
 b: model Cyberloafing = Conscientiousness age / scorr2 pcorr2 stb vif; run; quit;
 proc glm data=Sage; model Cyberloafing = Conscientiousness / EFFECTSIZE ALPHA=.1; run; quit;
 proc glm data=Sage; model Cyberloafing = Conscientiousness Age / EFFECTSIZE ALPHA=.1;
*If the leading * were removed, the below statement would compute confidence intervals for predicted Cyberloafing for each subject;
*print clm cli;
*****************************************************************************;   run; quit;
title 'Importance of Plotting Your Data'; run; quit;
*From PSYPARC gopher, Phil Wood, modified by K. Wuensch;
*Originally from Anscombe (1973), American Statistician, pp 17-21;

data PW; input x1 y1 x2 y2 x3 y3 x4 y4; cards;
10 8.04       10 9.14       10 7.46         8 6.58
 8 6.95        8 8.14        8 6.77         8 5.76
13 7.58       13 8.74       13 12.74        8 7.7
 9 8.81        9 8.77        9 7.11         8 8.84
11 8.33       11 9.26       11 7.81         8 8.47
14 9.96       14 8.10       14 8.84         8 7.04
6 7.24         6 6.13        6 6.08         8 5.25
4 4.26         4 3.10        4 5.39        19 12.50
12 10.84      12 9.13       12 8.15         8 5.56
7 4.82         7 7.26        7 6.42         8 7.91
5 5.68         5 4.74        5 5.73         8 6.89
;
proc reg simple; A: model y1 = x1;
  B: model y2 = x2;;
  C: model y3 = x3;
  D: model y4 = x4;  run; quit;
*****************************************************************************;
title 'Ar-Misanth Relationship for Nonidealists versus Idealists.'; run;
proc format; value I 0='NonIdealist' 1='Idealist';
data kevin2; infile 'C:\Users\Vati\Documents\StatData\potthoff.dat'; input ar misanth idealism;
format idealism I.;
proc sort; by idealism;
proc reg simple corr; model ar=misanth; 
by idealism; run; quit;
