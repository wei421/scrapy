******* ANOVA2.sas ************;
options pageno=min nodate formdlim='-';
proc format; value rec 1='Counting' 2='Rhyming' 3='Adjective'
 4='Imagery' 5='Intentional'; value Age 1='Old' 2='Young';
TITLE '2-WAY, EQUAL NS, INDEPENDENT SAMPLES ANOVA';
title2 'Howell, 8th edition, page 415'; run;
*** Create Macros for Confidence Interval for d ***;
%macro CIt;
d = t/sqrt(n1*n2/(n1+n2));
ncp_lower = TNONCT(t,df,.975);
ncp_upper = TNONCT(t,df,.025);
d_lower = ncp_lower*sqrt((n1+n2)/(n1*n2));
d_upper = ncp_upper*sqrt((n1+n2)/(n1*n2));
output; run; proc print; var d d_lower d_upper; run;
%mend CIt;
DATA KLW;
INPUT Age Condition; DO I=1 TO 10; INPUT Items @@; OUTPUT; END;
format Condition rec. Age Age.; CARDS;
1 1
9 8 6 8 10 4 6 5 7 7
1 2
7 9 6 6 6 11 6 3 8 7
1 3
11 13 8 6 14 11 13 13 10 11
1 4
12 11 16 11 9 23 12 10 19 11
1 5
10 19 14 5 10 11 14 15 11 11
2 1
8 6 4 6 7 6 5 7 9 7
2 2
10 7 8 10 4 7 10 6 7 7
2 3
14 11 18 14 13 22 17 16 12 11
2 4
20 16 16 15 18 16 20 22 14 19
2 5
21 19 17 15 22 16 22 22 18 21
;
******************************************************************************;
proc means NWAY noprint; class Age Condition; var Items;
 output out=klw2 mean= ;
*set the default text height to value 2;
GOPTIONS reset = global;
 goptions htext=2;
*change text heights and axis widths;
axis1  value=(h=1.3);
axis2 label=(h=2.5) value=(h=1.75) width=2;
proc gplot data=klw2; 
symbol1 interpol=join width=4 value=triangle height=2 color=red;
symbol2 interpol=join width=4 value=square height=2 color=green;
plot Items*Condition=Age / vaxis=axis1 haxis=axis2;
title 'Figure 1. Recall by Age and Condition';
run; quit;
******************************************************************************;
PROC GLM data=klw; CLASS Age Condition;
 MODEL Items=Age|Condition / EFFECTSIZE alpha=0.1;
 means Age|Condition; MEANS Condition / REGWQ;
 LSMEANS Condition / PDIFF CL ALPHA=.05;
 LSMEANS Age*Condition / SLICE=Age; LSMEANS Age*Condition / SLICE=Condition;
 title 'Omnibus Analysis and Simple Main Effects Using Pooled Error'; run; quit;
********************************************************************************
Construct confidence interval for d, main effect of Age.
*******************************************************************************;
PROC TTEST data=klw; CLASS Age; VAR Items;
 title 'Comparing Oldsters with Youngsters'; run; 
Data CI; t= 3.11; df = 98; n1 = 50; n2 = 50; %CIt
******************************************************************************;
PROC SORT data=klw; BY Age;
PROC GLM data=klw; CLASS Condition; MODEL Items=Condition / EFFECTSIZE alpha=0.1; BY Age;
title 'Simple Main Effects of Recall Condition Using Individual Error Terms'; run;
******************************************************************************;
PROC SORT data=klw; BY Condition;
PROC GLM data=klw; CLASS Age; MODEL Items=Age / EFFECTSIZE alpha=0.1; BY Condition;
title 'Simple Main Effects of Age Using Individual Error Terms'; run;
 title2 'Counting'; run; 
Data CI; t= .678; df = 18; n1 = 10; n2 = 10; %CIt
 title2 'Rhyming'; run; 
Data CI; t= .768; df = 18; n1 = 10; n2 = 10; %CIt
 title2 'Adjective'; run; 
Data CI; t= 2.80; df = 18; n1 = 10; n2 = 10; %CIt
 title2 'Imagery'; run; 
Data CI; t= 2.56; df = 18; n1 = 10; n2 = 10; %CIt
 title2 'Intentional'; run; 
Data CI; t= 5.02; df = 18; n1 = 10; n2 = 10; %CIt

