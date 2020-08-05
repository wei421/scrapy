options formdlim='-' pageno=min nodate;
data regdiag; input Lipids Fiber RedMeat @@;
SR_RedMeat = sqrt(1+RedMeat);
cards;
280 65 53  301 54 71  485 50 70  422 30 84  516  50 168
244 90 24  626  5 31  525 6 61    55 85 17   46 100   1
769 99 .5 
proc univariate plot data=regdiag; var Lipids -- SR_RedMeat; Title 'Univariate Screening' ; run;
proc reg data=regdiag; model Lipids = Fiber SR_RedMeat / influence r ; Title 'Transformed RedMeat' ;run; quit;
Data Larger; input ID Lipids Fiber RedMeat @@;
SR_Fiber = sqrt(1+Fiber); SR_RedMeat = sqrt(1+RedMeat);
cards;
1 280 65 53  2 301 54 71  3 485 50 70  4 422 30 84  5 516  50 168
6 244 90 24  7 626  5 31  8 525 6 61    9 55 85 17   10 46 100   1
11 281 64 52  12 300 53 70  13 486 51 71  14 423 32 86  15 519  53 167
16 244 90 24  17 626  5 31  18 525 6 61    19 55 85 17   20 46 100   1
21 769 200 .5  22 10 1 150
Title 'New Data Set, Captive Primates';
proc means skewness kurtosis; run; 
proc reg ; model Lipids = SR_Fiber SR_RedMeat / influence r ;  
Proc RobustReg data=Larger method=MM;
  Model Lipids = SR_Fiber SR_RedMeat /Leverage; Overall: test SR_Fiber SR_RedMeat;
  Output Out = Diag2 weight=wgt SR=StResid MD=MahalDist Leverage=Outlier; 
Proc Sort; By wgt; run;
Proc Print data = Diag2 (obs=5); ID ID;
  Var wgt StResid Outlier MahalDist Lipids SR_Fiber SR_RedMeat; run;
