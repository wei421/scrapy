options nonumber nodate formdlim='-';
data skew;
INFILE 'C:\Flying Spaghetti Monster\Residual-Skew.dat';
input X Y X2 Y2;
Y2_SQRT=SQRT(Y2);
proc means mean stdev min max skewness; var X Y X2 Y2 Y2_SQRT;
title 'Notice that X2 and Y2 are skewed.  Taking the SQRT of Y2 reduces the skewness greatly.'; run;
proc reg data=skew lineprinter; model Y=X;  output out=XY r=Y_Resid; plot r.*p.; 
title 'Predicting Y from X.'; run;
proc univariate normal plot data=XY; var Y_Resid;
title 'Distribution of the residuals is normal.'; run;
proc reg data=skew lineprinter; model Y=X2;  output out=X2Y r=Y_Resid; plot r.*p.;
title 'Predicting Y from skewed X2.'; run;
proc univariate normal plot data=X2Y; var Y_Resid;
title 'Distribution of the residuals is normal.'; run;
proc reg data=skew lineprinter; model Y2=X; output out=XY2 r=Y_Resid; plot r.*p.;
title 'Predicting skewed Y from X.'; run;
proc univariate normal plot data=XY2; var Y_Resid;
title 'Distribution of the residuals is skewed.'; run;
proc reg data=skew lineprinter; model Y2_SQRT=X; output out=XSQRTY2 r=Y_Resid; plot r.*p.;
title 'Predicting transformed Y2 from X.'; run;
proc univariate normal plot data=XSQRTY2; var Y_Resid; 
title 'Distribution of the residuals is nearly normal.'; run;
***********************************************************************************;
data linear; 
input X N; Do I=1 to N; Input Y @@; output; end;
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
proc means mean stddev skewness; var Y X;
title 'New Data Set.'; run;
proc reg lineprinter; model Y=X; output out=resids r=residuals; plot r.*p. ;
title 'Predict Y from X.'; run;
proc univariate normal plot; var residuals;
title 'Marginal distribution of residuals does not show the problem.'; run; 
data quadratic; set linear; X_SQ=X*X; 
proc reg lineprinter; model Y=X X_SQ; plot r.*p. ; plot Y*X='.' p.*X='X' / overlay;
title 'Polynomial regression:  Quadratic.'; run;
***********************************************************************************;
data hetero;
INFILE 'C:\Documents and Settings\Karl Wuensch\My Documents\Temp\Residual-Hetero.dat';
input X Y;
proc means mean stddev min max skewness; var X Y;
title 'Another new data set.';
proc reg lineprinter; model Y=X;  plot r.*p.='.';
title 'Heteroscedasticity.'; run;
