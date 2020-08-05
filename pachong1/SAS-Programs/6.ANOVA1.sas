options pageno=min nodate formdlim='-';
Title 'Illness Related to Dose of Therapeutic Drug'; run;
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
proc plot; plot Mean_Illness*Dose=Dose; run;
*****************************************************************************;
Title 'One-Way ANOVA With Welch Test, Pairwise Comparisons, and Orthogonal Contrasts'; run;
proc GLM data=Lotus; class Dose; 
  model Illness = Dose / ss1 EFFECTSIZE alpha=0.1; means Dose / snk tukey regwq;
  means Dose / hovtest=obrien hovtest=levene welch;
  contrast 'Placebo vs Drug' dose -4 1 1 1 1;
  contrast 'Lo vs Hi' dose 0 1 1 -1 -1;
  contrast '10 vs 20' dose 0 1 -1 0 0;
  contrast '30 vs 40' dose 0 0 0 1 -1; run;
*****************************************************************************;
Title 'One-Way ANOVA with Trend Contrasts'; run;
proc GLM data=Lotus; class Dose; 
  model Illness = Dose / ss1 EFFECTSIZE alpha=0.1;
CONTRAST 'Linear' Dose -2 -1 0 1 2;
CONTRAST 'Quadratic' Dose 2 -1 -2 -1 2;
CONTRAST 'Cubic' Dose -1 2 0 -2 1;
CONTRAST 'Quartic' Dose 1 -4 6 -4 1; run;
*****************************************************************************;
Title 'Polynomial Regression'; run;
data Polynomial; set Lotus; Quadratic=Dose*Dose; Cubic=Dose**3; Quartic=Dose**4;
proc GLM data=Polynomial; model Illness = Dose Quadratic Cubic Quartic / ss1 EFFECTSIZE alpha=0.1; run;
*****************************************************************************;
title 'Polynomial Regression with Quartic Component Dropped from the Model'; run;
proc GLM data=Polynomial; model Illness = Dose Quadratic Cubic / ss1;
 run;

/******************************************************************************************
Construct 95% confidence interval for first contrast
******************************************************************************************/
Data CI;t= 4.735 ;
df = 95  ;
n1 = 20  ;
n2 = 20  ;
n3 = 20  ;
n4 = 20  ;
n5 = 20  ;
c1 = -1  ;
c2 = .25 ;
c3 = .25 ;
c4 = .25 ;
c5 = .25 ;
ncp_lower = TNONCT(t,df,.975);
ncp_upper = TNONCT(t,df,.025);
d_lower = ncp_lower*sqrt(c1*c1/n1 + c2*c2/n2 + c3*c3/n3 + c4*c4/n4 + c5*c5/n5);
d_upper = ncp_upper*sqrt(c1*c1/n1 + c2*c2/n2 + c3*c3/n3 + c4*c4/n4 + c5*c5/n5);
output; run; proc print; var d_lower d_upper; 
title 'Confidence Interval on Standardized Contrast'; run;
/*********************************************************************************************
GPLOT is not very user friendly, but it produces snazzy plots
*********************************************************************************************/
title 'Severity of Illness as a Function of Dose of Drug'; run;
proc gplot data=Sol; 
symbol1 interpol=join width=4 value=triangle height=2 color=blue; 
plot Mean_Illness*Dose; run; quit;
