options pageno=min nodate formdlim='-';
title 'One-Way ANOVA with Pairwise Comparisons'; run;
data Lotus; 
input Dose N; Do I=1 to N; Input Illness @@; output; end;
cards;
0 20
  101 101 101 104 104 105 110 111 111 113 114 79 89 91 94 95 96 99 99 99
10 20
  100 65 65 67 68 80 81 82 85 87 87 88 88 91 92 94 95 94 96 96
20 20
  64 75 75 76 77 79 79 80 80 81 81 81 82 83 83 85 87 88 90 96
30 20
  100 105 108 80 82 85 87 87 87 89 90 90 92 92 92 95 95 97 98 99
40 20
  101 102 102 105 108 109 112 119 119 123 82 89 92 94 94 95 95 97 98 99 
proc sort; by Dose;
proc means noprint; output out=Sol mean=Mean_Illness; var Illness; by Dose;
proc plot; plot Mean_Illness*Dose=Dose;
*****************************************************************************;
proc ANOVA data=Lotus; class Dose; 
  model Illness = Dose; means Dose / lines lsd bon;
  means Dose; run;
