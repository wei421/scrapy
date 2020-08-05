********************************** Nonpar.sas **************************************;
options pageno=min nodate formdlim='-';
title 'Nonparametric Analysis With SAS:  Wilcoxon Rank Sum Test'; run;
proc format; value gr 1='First Trimester' 3='Third Trimester' ;
data mann; input group weight @@; format group gr. ; cards;
3 1680  3 3830  3 3110  3 2760  3 1700  3 2790  3 3050  3 2660  3 1400  3 2775
1 2940  1 3380  1 4900  1 2810  1 2800  1 3210  1 3080  1 2950
proc npar1way wilcoxon; class group; var weight; exact;
proc sort; by group;
proc means mean median std n skewness kurtosis; var weight; by group; run;
*********************************************************************;
title 'Nonparametric Analysis With SAS:  Wilcoxon Matched Pairs Signed-Ranks';
run;
data wmp; input Glucose Saccharine @@; diff = Glucose-Saccharine; cards;
0 1  10 9  9 6  4 2  8 5  6 5  9 7  3 2  12 8  10 8  15 11  9 3  5 6  6 8  10 8  6 4
proc univariate; var diff; ODS Select TestsforLocation;
proc means mean median std n skewness kurtosis; var Glucose Saccharine; run;
**********************************************************************;
proc format; value gr 1=’Depressant’ 2=’Stimulant’ 3=’Placebo’;
data kruskal; input group score @@; format group gr. ;cards;
1 55  1 0  1 1  1 0  1 50  1 60  1 44
2 73  2 85  2 51  2 63  2 85  2 81
2 66  2 69  3 61  3 54  3 80  3 47
proc npar1way wilcoxon; class group; var score; run;
title 'Nonparametric Analysis With SAS:  Kruskal-Wallis'; run;
proc sort; by group;
proc means mean median std n skewness kurtosis; var score; by group; run;
data kr12; set kruskal; if group < 3;
proc npar1way wilcoxon; class group; exact; var score;
title 'Depressant vs Stimulant'; run;
data kr23; set kruskal; if group > 1;
proc npar1way wilcoxon; class group; exact; var score;
title 'Stimulant vs Placebo'; run;
data kr13; set kruskal; if group NE 2;
proc npar1way wilcoxon; class group; exact; var score;
title 'Depressant vs Placebo'; run;
*******************************************************************;
data friede; input block IV DV @@; cards;
1 1 50  1 2 58  1 3 54    2 1 32  2 2 37  2 3 25
3 1 60  3 2 70  3 3 63    4 1 58  4 2 60  4 3 55
5 1 41  5 2 66  5 3 59    6 1 36  6 2 40  6 3 28
7 1 26  7 2 25  7 3 20    8 1 49  8 2 60  8 3 50
9 1 72  9 2 73  9 3 75    10 1 49  10 2 54  10 3 42
11 1 52  11 2 57  11 3 47    12 1 36  12 2 42  12 3 29
13 1 37  13 2 34  13 3 31    14 1 58  14 2 50  14 3 56
15 1 39  15 2 48  15 3 44    16 1 25  16 2 29  16 3 18
17 1 51  17 2 63  17 3 68
proc rank out=ranks; var DV; by block; ranks ranks;
* proc print;
* Remove asterisk in line above if you want to see output of proc rank.;
title 'Nonparametric Analysis With SAS:  Friedman ANOVA'; run;
proc freq; tables block*IV*ranks / noprint cmh;
title2 'Statistic 2 is the Friedman Chi-Square'; run;
data pairwise; input None Few Many @@;
None_Few = None - Few;  None_Many = None - Many;  Few_Many = Few - Many;
cards;
50 58 54   32 37 25   60 70 63   58 60 55
26 25 20   49 60 50   41 66 59   36 40 28
72 73 75   49 54 42   52 57 47   36 42 29
37 34 31   58 50 56   39 48 44   25 29 18
51 63 68
proc univariate; var None_Few None_Many Few_Many; ODS Select TestsforLocation;
proc means mean median std n skewness kurtosis; var None Few Many; run;
proc glm data = ranks; class block IV; model ranks=block IV; lsmeans IV / pdiff;title2 'GLM approach with multiple comparisons built in';  run;
proc sort data=friede; by IV;
proc means mean median std skewness kurtosis n; var DV; by IV; run;

/**********************************************************************
In response to a query on SAS-L regarding how to do a Friedman test on
SAS [summarized by Stephen P. Baker (sbaker@umassmed.bitnet)],
most of the respondents suggested applying ranks within the blocks then
performing a randomized block anova on the these ranks.  This is, however,
not exactly equivalent to the traditional Friedman test.  Conover
and Davenport proposed this in 1980 and in a paper in The American
Statistician.   Conover and Iman in 1981 proposed parametric methods on
ranks as a cure-all to lots of problems.  In that paper they pointed out that
the F from this is a monotonic function of the Friedman statistic and they
suggested that the F from the ranks within blocks was a better _approximation_
to the Friedman than the usual chi-squared approximation.
 
     Above is an example of how to do a Friedman analysis on SAS.  The data are
in the file FRIEDMAN DATA.  In this data file each subject or block has three
data lines, one for each level of the IV.  The data are not already ranked
within blocks, so the first step is to convert DV into such ranks, which is
what is done by PROC RANK.  PROC FREQ is then used to obtain the Friedman
chi-square. The table produced has three statistics, the second of which is the
Friedman Chi-Square with p-value (or actually a Cochran-Mantel- Haenszel
statistic which is identical in this special case).
 
Siegel warns that when the table is small, this approximation is not good and
provides exact tables for up to a 3 x 9 table and up to a 4 x 4 table.
 
Since the F approach is a better approximation, for large tables the GLM
approach on the ranks might be the best option.  Wim Lemmens provided the
SAS code from a SUGI paper referenced in the SAS/STAT guide for doing
Friedman in GLM and an associated multiple comparisons procedure which might
be controversial in itself (e.g. a Bonferroni adjustment - one might want
to do matched pairs-signed ranks tests and then Bonferroni adjust them.
 
     Our sample program includes the GLM code to do the F-approach
analysis with multiple comparisons via pdiff on lsmeans.
 
     We could do the pairwise comparisons the way we did earlier following
the Kruskal-Wallis.  That is, create three data sets (one with IV < 3, one
with IV > 1, and one with IV NE 2) and do a Wilcoxon Signed Ranks tests on
each.
***********************************************************************/
