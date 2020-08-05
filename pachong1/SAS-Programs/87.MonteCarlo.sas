options formdlim='-' pageno=min nodate;
DATA normal1; drop obs I;
do obs=1 to 100000;
array Ys[25] Y1-Y25;
do I = 1 to 25;
Ys[I]=100+15*NORMAL(0);
end; output; end;
proc univariate plot normal; var Y1;
title 'One Sample of 100,000 scores from Normal Distribution'; run;
run;
*************************************************************************;
data normal2; set normal1;
mean9 = mean(of Y1-Y9);     mean25 = mean(of Y1-Y25);
std9 = std(of Y1-Y9);      std25=std(of Y1-Y25);
var9 = std9*std9;      var25 = std25*std25;
Z9 = (mean9 - 100)/5;      Z25 = (mean25 - 100)/3;
T9 = (mean9 - 100)/(std9/3);     T25 = (mean25 - 100)/(std25/5);
Type1_N9 = 'No ';
If ABS(T9)GE 2.306 then Type1_N9 = 'Yes';
Type1_N25 = 'No ';
If ABS(T25)GE 2.064 then Type1_N25 = 'Yes';
proc freq; tables Type1_N9 Type1_N25;
title 'Frequency of Type I Errors';
proc univariate noprint; 
output out=normal3 
 mean=mean_mean9 mean_var9 mean_std9 mean_Z9 mean_T9
 mean=mean_mean25 mean_var25 mean_std25 mean_Z25 mean_T25
 median=med_mean9 med_var9 med_std9 med_Z9 med_T9
 median=med_mean25 med_var25 med_std25 med_Z25 med_T25
 std=std_mean9 std_var9 std_std9 std_Z9 std_T9
 std=std_mean25 std_var25 std_std25 std_Z25 std_T25
 skewness=g1_mean9 g1_var9 g1_std9 g1_Z9 g1_T9
 skewness=g1_mean25 g1_var25 g1_std25 g1_Z25 g1_T25
 kurtosis=g2_mean9 g2_var9 g2_std9 g2_Z9 g2_T9
 kurtosis=g2_mean25 g2_var25 g2_std25 g2_Z25 g2_T25
 min=min_mean9 min_var9 min_std9 min_Z9 min_T9
 min=min_mean25 min_var25 min_std25 min_Z25 min_T25
 max=max_mean9 max_var9 max_std9 max_Z9 max_T9
 max=max_mean25 max_var25 max_std25 max_Z25 max_T25;
var mean9 var9 std9 Z9 T9 mean25 var25 std25 Z25 T25; run;
*************************************************************************;
data normal4; set normal3;
proc print; var mean_mean9 med_mean9 std_mean9 g1_mean9 g2_mean9 min_mean9 max_mean9;
title 'Normal Population, Distribution of Sample Means, N = 9';
proc print; var mean_mean25 med_mean25 std_mean25 g1_mean25 g2_mean25 min_mean25 max_mean25;
title 'Normal Population, Distribution of Sample Means, N = 25';
**;
proc print; var mean_var9 med_var9 std_var9 g1_var9 g2_var9 min_var9 max_var9;
title 'Normal Population, Distribution of Sample Variances, N = 9';
proc print; var mean_var25 med_var25 std_var25 g1_var25 g2_var25 min_var25 max_var25;
title 'Normal Population, Distribution of Sample Variances, N = 25';
**;
proc print; var mean_std9 med_std9 std_std9 g1_std9 g2_std9 min_std9 max_std9;
title 'Normal Population, Distribution of Sample Standard Deviations, N = 9';
proc print; var mean_std25 med_std25 std_std25 g1_std25 g2_std25 min_std25 max_std25;
title 'Normal Population, Distribution of Sample Standard Deviations, N = 25';
**;
proc print; var mean_Z9 med_Z9 std_Z9 g1_Z9 g2_Z9 min_Z9 max_Z9;
title 'Normal Population, Distribution of Z Test Statistic, N = 9';
proc print; var mean_Z25 med_Z25 std_Z25 g1_Z25 g2_Z25 min_Z25 max_Z25;
title 'Normal Population, Distribution of Z Test Statistic, N = 25';
**;
proc print; var mean_T9 med_T9 std_T9 g1_T9 g2_T9 min_T9 max_T9;
title 'Normal Population, Distribution of T Test Statistic, N = 9';
proc print; var mean_T25 med_T25 std_T25 g1_T25 g2_T25 min_T25 max_T25;
title 'Normal Population, Distribution of T Test Statistic, N = 25';
run;
*############################################################################;
DATA skewed1; drop obs J;
do obs=1 to 100000;
array Xs[25] X1-X25;
do J = 1 to 25;
Xs[J]=100*RANEXP(0);
end; output; end;
run;
proc univariate plot normal; var X1;
title 'One Sample of 100,000 scores from Exponential Distribution'; run;
*************************************************************************;
data skewed2; set skewed1;
mean9 = mean(of X1-X9);     mean25 = mean(of X1-X25);
Z9 = 3*(mean9 - 100)/100;      Z25 = (mean25 - 100)/20;
std9 = std(of X1-X9);      std25=std(of X1-X25);
T9 = (mean9 - 100)/(std9/3);     T25 = (mean25 - 100)/(std25/5);
Type1_N9 = 'No ';
If ABS(T9)GE 2.306 then Type1_N9 = 'Yes';
Type1_N25 = 'No ';
If ABS(T25)GE 2.064 then Type1_N25 = 'Yes';
proc freq; tables Type1_N9 Type1_N25;
title 'Frequency of Type I Errors';
proc univariate noprint;
output out=skewed3 
 mean=mean_mean9 mean_std9 mean_Z9 mean_T9
 mean=mean_mean25 mean_std25 mean_Z25 mean_T25
 median=med_mean9 med_std9 med_Z9 med_T9
 median=med_mean25 med_std25 med_Z25 med_T25
 std=std_mean9 std_std9 std_Z9 std_T9
 std=std_mean25 std_std25 std_Z25 std_T25
 skewness=g1_mean9 g1_std9 g1_Z9 g1_T9
 skewness=g1_mean25 g1_std25 g1_Z25 g1_T25
 kurtosis=g2_mean9 g2_std9 g2_Z9 g2_T9
 kurtosis=g2_mean25 g2_std25 g2_Z25 g2_T25
 min=min_mean9 min_std9 min_Z9 min_T9
 min=min_mean25 min_std25 min_Z25 min_T25
 max=max_mean9 max_std9 max_Z9 max_T9
 max=max_mean25 max_std25 max_Z25 max_T25;
var mean9 std9 Z9 T9 mean25 std25 Z25 T25;
 run;
*************************************************************************;
proc print; var mean_mean9 med_mean9 std_mean9 g1_mean9 g2_mean9 min_mean9 max_mean9;
title 'Exponential Population, Distribution of Sample Means, N = 9';
proc print; var mean_mean25 med_mean25 std_mean25 g1_mean25 g2_mean25 min_mean25 max_mean25;
title 'Exponential Population, Distribution of Sample Means, N = 25';
**;
proc print; var mean_std9 med_std9 std_std9 g1_std9 g2_std9 min_std9 max_std9;
title 'Exponential Population, Distribution of Sample Standard Deviations, N = 9';
proc print; var mean_std25 med_std25 std_std25 g1_std25 g2_std25 min_std25 max_std25;
title 'Exponential Population, Distribution of Sample Standard Deviations, N = 25';
**;
proc print; var mean_Z9 med_Z9 std_Z9 g1_Z9 g2_Z9 min_Z9 max_Z9;
title 'Exponential Population, Distribution of Z Test Statistic, N = 9';
proc print; var mean_Z25 med_Z25 std_Z25 g1_Z25 g2_Z25 min_Z25 max_Z25;
title 'Exponential Population, Distribution of Z Test Statistic, N = 25';
**;
proc print; var mean_T9 med_T9 std_T9 g1_T9 g2_T9 min_T9 max_T9;
title 'Exponential Population, Distribution of T Test Statistic, N = 9';
proc print; var mean_T25 med_T25 std_T25 g1_T25 g2_T25 min_T25 max_T25;
title 'Exponential Population, Distribution of T Test Statistic, N = 25';
run;
