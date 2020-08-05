******* ANOVA2.sas ************
Howell, Methods, 7th Edition, pages 432-434.
Case is fixed effects, Letter is random effects. ;
options pageno=min nodate formdlim='-';
DATA Mixed;
INPUT Case Letter; DO I=1 TO 10; INPUT Latency @@; OUTPUT; END;
CARDS;
1 1
9 8 6 8 10 4 6 5 7 7
1 2
7 9 6 6 6 11 6 3 8 7
1 3
11 13 8 6 14 11 13 13 10 11
1 4
12 11 16 11 9 23 12 10 19 11
1 5
10 19 14 5 10 11 14 15 11 11
2 1
8 6 4 6 7 6 5 7 9 7
2 2
10 7 8 10 4 7 10 6 7 7
2 3
14 11 18 14 13 22 17 16 12 11
2 4
20 16 16 15 18 16 20 22 14 19
2 5
21 19 17 15 22 16 22 22 18 21
******************************************************************************;
Title 'Correct solution, note specification of error term for effect of (fixed) case';
PROC GLM data=Mixed; CLASS Case Letter; MODEL Latency=Case|Letter / SS1;
Test H=Case E=Case*Letter; run;
******************************************************************************;
Title 'Random statement leads to incorrect error term for effect of Letter'; run;
PROC GLM data=Mixed; CLASS Case Letter; MODEL Latency=Case|Letter / SS3;
Random Letter Case*Letter / test; run;
