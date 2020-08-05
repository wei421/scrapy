options pageno=min nodate formdlim='-';
TITLE 'Two-Way Nonorthogonal Least Squares ANOVA, Effects Coding'; run;
DATA SOL;  DROP I N;
INPUT A1 B1 B2 B3 A1B1 A1B2 A1B3 N;
DO I=1 TO N; INPUT Y @@; OUTPUT; END; CARDS;
1 1 0 0 1 0 0 4
5 7 9 8
1 0 1 0 0 1 0 5
2 5 7 3 9
1 0 0 1 0 0 1 4
8 11 12 14
1 -1 -1 -1 -1 -1 -1 5
11 15 16 10 9
-1 1 0 0 -1 0 0 4
7 9 10 9
-1 0 1 0 0 -1 0 4
3 8 9 11
-1 0 0 1 0 0 -1 5
9 12 14 8 7
-1 -1 -1 -1 1 1 1 5
11 14 10 12 13
PROC REG; full: MODEL Y = A1 B1 B2 B3 A1B1 A1B2 A1B3;
          a_x_b: MODEL Y = A1 B1 B2 B3;
          b: MODEL Y = A1 A1B1 A1B2 A1B3;
          a: MODEL Y = B1 B2 B3 A1B1 A1B2 A1B3; run;
*****************************************************************************;
DATA GLM;  INPUT A B N;
DO I=1 TO N; INPUT Y @@; OUTPUT; END; CARDS;
1 1 4
5 7 9 8
1 2 5
2 5 7 3 9
1 3 4
8 11 12 14
1 4 5
11 15 16 10 9
2 1 4
7 9 10 9
2 2 4
3 8 9 11
2 3 5
9 12 14 8 7
2 4 5
11 14 10 12 13
PROC GLM; CLASS A B; MODEL Y = A|B / SS3; run; QUIT;
