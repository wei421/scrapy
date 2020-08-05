options formdlim='-';
title 'Exercises 11.3, 13.11, and 13.12, 4th edition, Stat. Methods.'; run;
data eysenck;
INPUT AGE $ L_O_P $; DO I=1 TO 10; INPUT ITEMS @@; OUTPUT; END; cards;
Young Low
8 6 4 6 7 6 5 7 9 7
Young High
21 19 17 15 22 16 22 22 18 21
Old Low
9 8 6 8 10 4 6 5 7 7
Old High
10 19 14 5 10 11 14 15 11 11
PROC ANOVA; CLASS AGE L_O_P; MODEL ITEMS=AGE|L_O_P; MEANS AGE|L_O_P;
PROC SORT; BY AGE; PROC ANOVA; CLASS L_O_P; MODEL ITEMS=L_O_P; BY AGE;
PROC SORT; BY L_O_P; PROC ANOVA; CLASS AGE; MODEL ITEMS=AGE; BY L_O_P; run;
