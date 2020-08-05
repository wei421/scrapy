*ANOVA-Interact2x3.sas;
options pageno=min nodate formdlim='-';
DATA KLW;
INPUT Cell A B; DO I=1 TO 10; INPUT Y @@; OUTPUT; END;CARDS;
11 1 1
9 8 6 8 10 4 6 5 7 7
12 1 2
10 19 14 5 10 11 14 15 11 11
13 1 3
10 7 7 7 11 3 7 4 8 6 
21 2 1
8 6 4 6 7 6 5 7 9 7
22 2 2
21 19 17 15 22 16 22 22 18 21
23 2 3
27 23 23 19 28 20 28 26 24 25

Proc GLM data =klw; Class Cell; Model Y=Cell / SS1;
CONTRAST 'A' Cell 1 1 1 -1 -1 -1;
CONTRAST 'B12vs3' Cell 1 1 -2 1 1 -2;   CONTRAST 'B1vs2' Cell 1 -1 0 1 -1 0;
CONTRAST 'A x B12vs3' Cell 1 1 -2 -1 -1 2; CONTRAST 'A x B1vs2' Cell 1 -1 0 -1 1 0; 
CONTRAST 'B12vs3 at A1' Cell 1 1 -2 0 0 0; CONTRAST 'B1vs2 at A1' Cell 1 -1 0 0 0 0;
CONTRAST 'B12vs3 at A2' Cell 0 0 0 1 1 -2; CONTRAST 'B1vs2 at A2' Cell 0 0 0 1 -1 0;
CONTRAST 'A at B1' Cell 1 0 0 -1 0 0;
CONTRAST 'A at B2' Cell 0 1 0 0 -1 0;
CONTRAST 'A at B3' Cell 0 0 1 0 0 -1;
title 'Factorial ANOVA By Contrasts'; run;
PROC GLM data=klw; CLASS A B; MODEL Y=A|B / SS1;
  LSMEANS A*B / SLICE=A; LSMEANS A*B / SLICE=B;
 title 'Factorial ANOVA the Easy Way'; run;
