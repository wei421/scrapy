***** ANCOV2.sas *****
options pageno=min nodate formdlim='-';
TITLE 'Two-Way ANCOV, Howell, Table 16.11'; run;
Proc Format; Value tsk 1='Pattern' 2 = 'Cognitive' 3 = 'Driving';
	Value smk 1 = 'NonSmoker' 2 = 'Delayed Smoker' 3 = 'Active Smoker' ;
DATA SOL; INPUT task smoke; DO I = 1 TO 15;
INPUT errors distract @@; OUTPUT; END; format task tsk. smoke smk. ;CARDS;
1 1
9 107 8 133 12 123 10 94 7 83 10 86 9 112 11 117 8 130 10 111 8 102
10 120 8 118 11 134 10 97
1 2
12 101 7 75 14 138 4 94 8 138 11 127 16 126 17 124 5 100 6 103 9 120
6 91 6 138 7 88 16 118
1 3
8 64 8 135 9 130 1 106 9 123 7 117 16 124 19 141 1 95 1 98 22 95 12 103
18 134 8 119 10 123
2 1
27 126 34 154 19 113 20 87 56 125 35 130 23 103 37 139 4 85 30 131 4 98
42 107 34 107 19 96 49 143
2 2
48 113 29 100 34 114 6 74 18 76 63 162 9 80 54 118 28 99 71 146 60 132
54 135 51 111 25 106 49 96
2 3
34 108 65 191 55 112 33 98 42 128 54 145 21 76 44 107 61 128 38 128
75 142 61 144 51 131 32 110 47 132
3 1
15 110 2 96 2 112 14 114 5 137 0 125 16 168 14 102 9 109 17 111 15 137
9 106 3 117 15 101 13 116
3 2
7 93 0 102 6 108 0 100 12 123 17 131 1 99 11 116 4 81 4 103 3 78 5 103
16 139 5 101 11 102
3 3
3 130 2 83 0 91 0 92 6 109 2 106 0 99 6 109 4 136 1 102 0 119 0 84 6 68
2 67 3 114
PROC ANOVA; CLASS task smoke; MODEL errors distract = task|smoke;
 MEANS task|smoke;
TITLE3 'Two-way ANOVAs using errors and distract as DVs';
Title4 'Were the design unbalanced (unequal n''s) you would use';
title5 'PROC GLM here instead of PROC ANOVA.'; run; quit;
**************************************************************************;
PROC GLM; CLASS task smoke;
 MODEL errors = task|smoke|distract / SS3;
title3 'Test Homogeneity of Regression Within Cells and Treatments'; run; quit;
**************************************************************************;
PROC GLM; CLASS task smoke;
 MODEL errors = task|smoke distract(task smoke) / SS1 SOLUTION;
title2 'Obtain Within-Cell Slopes';
***************************************************************************;
PROC GLM; CLASS task smoke;
 MODEL errors = distract task|smoke / SOLUTION;
 LSMEANS task|smoke / PDIFF;
title2 'The ANCOV With Means and Adjusted Means'; run; quit;
***************************************************************************;
PROC SORT; BY task;
PROC GLM; CLASS smoke;
 MODEL errors = distract smoke  / SS1 solution;
  LSMEANS smoke / PDIFF; BY task;
title2 'Simple Main Effects ANCOV by Level of Task'; run; quit;
