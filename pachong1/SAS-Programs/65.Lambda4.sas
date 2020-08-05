*** Lambda4.sas ***;
options pageno=min nodate formdlim='-';
*** Estimating Maximized Lambda4, Callender and Osburn (1977) ***;
data Kevin; infile 'D:/StatData/kj.dat'; input (q1-q10) (1.);
if nmiss (of Q1-Q10) > 0 then delete;
H1 = q2+q4+q6+q7+q9; H2 = q1+q3+q5+q8+q10; tot = H1 + H2;
proc corr nosimple nocorr cov; var q1-q10;
title 'Estimating maximized lambda4 for the full (10 items) idealism scale'; run;
proc corr nosimple; var H1; with H2;
proc means var; var H1 H2 TOT;
  OUTPUT OUT=Var1 VAR=V1 V2 VTOT;
DATA _NULL_; FILE PRINT; SET Var1;
Est_Max_Lambda4 = 2*(1-(V1+V2)/VTOT);
put;
put Est_Max_Lambda4 =  ;
run;
***************************************************************;
 ***** Estimating Maximized Lambda4, Osburn (2000) *****;
data MaxLambda4; set Kevin;
if nmiss (of Q1-Q10) > 0 then delete;
A=Q2+Q5+Q8+Q7+Q6; B=Q3+Q4+Q9+Q1+Q10;
TOT=Q1+Q2+Q3+Q4+Q5+Q6+Q7+Q8+Q9+Q10;
proc means var; var A B TOT;
  OUTPUT OUT=Var2 VAR=VA VB VTOT;
title 'Easier procedure, full (10 items) idealism scale';
DATA _NULL_; FILE PRINT; SET Var2;
Est_Max_Lambda4 = 2*(1-(VA+VB)/VTOT);
put;
put Est_Max_Lambda4 =  ; run;
***************************************************************;
data AR; infile 'D:\statdata\KJ.dat'; input (q1-q119)(1.);
q40=6-q40; q48=6-q48;q51=6-q51;q59=6-q59;q66=6-q66; q52=6-q52;q67=6-q67;
if nmiss(of q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
 q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65) > 0 then delete;
A=q21+q23+q26+q28+q30+q32+q34+q38+q40+q48+q49+q53+q59+q65;
B=q22+q25+q27+q29+q31+q37+q39+q43+q46+q51+q57+q60+q64+q66;
TOT=A+B;
*******************************************************************************;
proc corr nosimple nocorr alpha;
 var q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
 q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65;
title 'Cronbach alpha for the 28 item Animal Rights scale.';run;
*******************************************************************************;
proc corr nosimple; var a; with b; 
title 'Estimating maximized lambda4 for the 28 item Animal Rights scale.';run;
proc means var; var A B TOT;
  OUTPUT OUT=Var3 VAR=VA VB VTOT;
DATA _NULL_; FILE PRINT; SET Var3;
Est_Max_Lambda4 = 2*(1-(VA+VB)/VTOT);
put;
put Est_Max_Lambda4 =  ; run;
*******************************************************************************;
proc corr data=AR nosimple nocorr cov; var q21;
with q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q23;
with q21 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q25;
with q21 q23 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q26;
with q21 q23 q25 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q28;
with q21 q23 q25 q26 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q31;
with q21 q23 q25 q26 q28 q37 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q37;
with q21 q23 q25 q26 q28 q31 q38 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q38;
with q21 q23 q25 q26 q28 q31 q37 q39 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q39;
with q21 q23 q25 q26 q28 q31 q37 q38 q40 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q40;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q53 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q53;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q57 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q57;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q59 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q59;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q64 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q64;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q66 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q66;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q22
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q22;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q27;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q29;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q30 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q30;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q32 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q32;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q34 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q34;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q43 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q43;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q46 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q46;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q43 q48 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q48;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q43 q46 q49 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q49;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q43 q46 q48 q51 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q51;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q43 q46 q48 q49 q60 q65; run;
proc corr data=AR nosimple nocorr cov; var q60;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q65; run;
proc corr data=AR nosimple nocorr cov; var q65;
with q21 q23 q25 q26 q28 q31 q37 q38 q39 q40 q53 q57 q59 q64 q66
q22 q27 q29 q30 q32 q34 q43 q46 q48 q49 q51 q60; run;
