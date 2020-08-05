options pageno=min nodate formdlim='-'; title 'Friedman ANOVA, Kendall Concordance'; run;
data dal; input judge patch rank @@; cards;
1 1 1  1 2 2  1 3 3  1 4 4  1 5 5  1 6 6  1 7 7  1 8 8
2 1 2  2 2 1  2 3 5  2 4 4  2 5 3  2 6 8  2 7 7  2 8 6
3 1 1  3 2 3  3 3 2  3 4 7  3 5 5  3 6 6  3 7 8  3 8 4
4 1 2  4 2 1  4 3 3  4 4 5  4 5 4  4 6 7  4 7 8  4 8 6
5 1 3  5 2 1  5 3 2  5 4 4  5 5 6  5 6 5  5 7 7  5 8 8
6 1 2  6 2 1  6 3 3  6 4 6  6 5 5  6 6 4  6 7 8  6 8 7
proc freq; tables judge*patch*rank / noprint cmh;
title 'Statistic 2 is the Friedman Chi-Square'; run;
