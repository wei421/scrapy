options pageno=min nodate formdlim='-';
TITLE 'Two-Way Orthogonal Least Squares ANOVA, Effects Coding'; run;
DATA SOL;  DROP I;
INPUT A1 B1 B2 B3 A1B1 A1B2 A1B3;
DO I=1 TO 4; INPUT Y @@; OUTPUT; END; CARDS;
1 1 0 0 1 0 0
5 7 9 8
1 0 1 0 0 1 0
2 5 7 3
1 0 0 1 0 0 1
8 11 12 14
1 -1 -1 -1 -1 -1 -1
11 15 16 10
-1 1 0 0 -1 0 0
7 9 10 9
-1 0 1 0 0 -1 0
3 8 9 11
-1 0 0 1 0 0 -1
9 12 14 8
-1 -1 -1 -1 1 1 1
11 14 10 12
PROC REG; full: MODEL Y = A1 B1 B2 B3 A1B1 A1B2 A1B3;
                a_x_b: MODEL Y = A1 B1 B2 B3;
                b: MODEL Y = A1 A1B1 A1B2 A1B3;
                a: MODEL Y = B1 B2 B3 A1B1 A1B2 A1B3; RUN;
***************************************************************************;
DATA ANOVA;  INPUT A B;
DO I=1 TO 4; INPUT Y @@; OUTPUT; END; CARDS;
1 1
5 7 9 8
1 2
2 5 7 3
1 3
8 11 12 14
1 4
11 15 16 10
2 1
7 9 10 9
2 2
3 8 9 11
2 3
9 12 14 8
2 4
11 14 10 12
PROC ANOVA; CLASS A B; MODEL Y = A|B; run; QUIT;
