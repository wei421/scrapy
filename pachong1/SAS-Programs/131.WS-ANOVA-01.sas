options pageno=min nodate formdlim='-';
title 'One-way repeated measures ANOVA with data in univariate setup.';
title2 'Data from p 359 of 4th ed. of Howell''s Fundamental Statistics.'; run;
data univariate; input subject week duration; cards;
1 1 21
1 2 22
1 3 8 
1 4 6 
1 5 6 
2 1 20
2 2 19
2 3 10
2 4 4 
2 5 9 
3 1 7 
3 2 5 
3 3 5 
3 4 4 
3 5 5 
4 1 25
4 2 30
4 3 13
4 4 12
4 5 4 
5 1 30
5 2 33
5 3 10
5 4 8 
5 5 6 
6 1 19
6 2 27
6 3 8 
6 4 7 
6 5 4 
7 1 26
7 2 16
7 3 5 
7 4 2 
7 5 5 
8 1 13
8 2 4 
8 3 8 
8 4 1 
8 5 5 
9 1 26
9 2 24
9 3 14
9 4 8 
9 5 17
proc anova; class subject week; model duration = subject week; run;
*****************************************************************************;
title 'One-way repeated measures ANOVA with data in multivariate setup.';run;
data multivariate; input subject week1-week5 @@; d23 = week2-week3; cards;
1 21 22  8  6  6     2 20 19 10  4  9     3  7  5  5  4  5
4 25 30 13 12 .4     5 30 33 10  8  6     6 19 27  8  7  4
7 26 16  5  2  5     8 13  4  8  1  5     9 26 24 14  8  17
proc anova;  model week2 week3 = / nouni;  repeated week 2 / nom;
proc means mean t prt;  var d23 week1-week5;
proc anova;  model week1-week5= / nouni;  repeated week 5 profile / summary;
run;
