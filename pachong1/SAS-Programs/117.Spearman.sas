options pageno=min nodate;
title 'Spearman rho and Kendall tau computed on data from perfect monotonic (log) relationship';
data curvi; input x y; y_log=log10(y); cards;
1.0       10
1.9       99
2.0      100
2.9      999
3.0     1000
3.1     1001
4.0    10000
4.1    10001
5.0   100000
proc rank out = transformed; var x y; ranks x_rank y_rank; run;
proc print;
proc plot; plot y*x y_log*x y_rank*x_rank;
proc corr pearson spearman kendall nosimple; var y y_log; with x; run;
