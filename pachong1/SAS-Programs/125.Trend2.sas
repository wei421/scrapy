options pageno=min nodate formdlim='-';
title 'Two-Way Trend Analysis'; run;
data Lotus; 
input Dose Diagnosis $; 
 Quadratic=Dose*Dose; Cubic=Dose**3; Quartic=Dose**4;
  Do I=1 to 20; Input Illness @@; output; end;
cards;
0 A
  83 118 115 73 129 127 127 122 109 81 90 94 67 121 108 79 107 85 100 125 
10 A
  48 57 88 86 55 100 71 104 79 93 102 60 65 100 84 60 53 88 113 82 
20 A
  73 91 82 69 73 86 78 100 71 83 69 61 71 71 101 83 95 83 129 95 
30 A
  74 69 81 99 87 57 68 152 86 76 70 73 124 101 115 100 105 92 116 88 
40 A
  101 123 90 114 115 127 84 91 105 140 74 77 106 89 87 110 100 83 85 97 
0 B
  126 65 103 107 93 100 87 63 115 116 88 136 90 77 103 98 93 83 86 112
10 B
  120 102 104 65 105 107 57 117 131 86 101 134 113 86 113 107 125 109 109 94 
20 B
  116 129 116 89 65 97 121 105 64 112 72 50 127 86 106 115 109 62 64 93 
30 B
  90 80 81 76 84 75 72 127 74 90 105 70 93 63 90 54 73 77 65 97 
40 B
  60 113 75 60 100 81 75 84 45 60 120 36 63 47 82 52 62 90 73 95 
0 C
  72 85 126 169 117 98 117 108 85 141 94 101 101 106 80 139 92 101 119 105 
10 C
  70 94 62 108 106 91 61 94 97 84 102 81 102 108 108 54 99 114 90 95 
20 C
  95 126 87 74 83 112 58 68 55 77 59 58 72 45 97 92 71 94 76 68 
30 C
  46 66 48 60 83 89 79 98 60 90 74 77 75 47 57 83 86 91 104 94 
40 C
  60 73 100 64 61 34 62 63 75 73 77 55 99 99 65 90 82 67 49 59 
proc means NWAY noprint; class Dose Diagnosis; var illness;
 output out=Athena mean= ;
proc plot; plot illness*Dose=Diagnosis;
******************************************************************************;
PROC GLM data=Lotus; CLASS Diagnosis Dose; MODEL Illness = Dose|Diagnosis / ss1;
 MEANS Dose|Diagnosis;
title 'Omnibus Analysis'; run;
******************************************************************************;
PROC GLM data=Lotus; class Diagnosis; 
 Model Illness = Diagnosis Dose Quadratic Cubic Quartic
  Diagnosis*Dose Diagnosis*Quadratic Diagnosis*Cubic Diagnosis*Quartic / ss1;
Title 'Trends, Including Interactions, via Polynomial Regression'; run;
******************************************************************************;
PROC SORT data=Lotus; by Diagnosis;
PROC GLM data=Lotus; Model Illness = Dose Quadratic Cubic / ss1;
 BY Diagnosis;
title 'Simple Main Effects'; run;
******************************************************************************;
PROC REG data=Lotus lineprinter; Model Illness = Dose Quadratic;
plot p. * dose='x'; by Diagnosis;
title 'Obtain Coefficients and Plot for Quadratic Regression Lines'; run;
********************* Interaction Plot with GPLOT ****************************;
proc gplot data=Athena; 
symbol1 interpol=spline width=4 value=triangle height=2 color=red;
symbol2 interpol=spline width=4 value=square height=2 color=green;
symbol3 interpol=spline width=4 value=circle height=2 color=blue;
plot Illness * Dose = Diagnosis / haxis=0 to 40 by 10;
title 'Dose-Response for Athenopram in Cuddly Toys';
run; quit;

