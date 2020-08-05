options pageno=min nodate formdlim='-';
data kopetski; infile 'D:\StatData\WilcoxonSignedRanks.txt';
input  id 1-4  mental 11 wrong 12 xlogic 13 xrespon 14 oblame 15 prison 16
hospit 17 med 18  drunk 19 xinsdef 20 avoidp 21 p_insan 22-23 p_acq 24-25
verdict 26  mental2 28 wrong2 29 xlogic2 30 xrespon2 31 oblame2 32 prison2 33
hospit2 34  med2 35 drunk2 36 xinsdef2 37 avoidp2 38 p_insan2 39-40 p_acq2 41-42
 verdict2 43 jurydec 45;
********************* reflect variables;
mental=8-mental; wrong=8-wrong; xlogic=8-xlogic; xrespon=8-xrespon;
oblame=8-oblame; prison=8-prison; hospit=8-hospit; med=1-med; drunk=1-drunk;
xinsdef=8-xinsdef; avoidp=8-avoidp;
mental2=8-mental2; wrong2=8-wrong2; xlogic=8-xlogic; xrespon2=8-xrespon2;
oblame2=8-oblame2; prison2=8-prison2; hospit2=8-hospit2; med2=1-med2;
drunk2=1-drunk2; xinsdef2=8-xinsdef2; avoidp2=8-avoidp2;
*************************** compute difference scores;
d1=mental2-mental; d2=wrong2-wrong; d3=xlogic2-xlogic; d4=xrespon2-xrespon;
d5=oblame2-oblame; d6=prison2-prison; d7=hospit2-hospit;
d8=med2-med; d9=drunk2-drunk; d10=xinsdef2-xinsdef;
d11=avoidp2-avoidp; d12=p_insan2-p_insan; d13=p_acq2-p_acq;
****************************** get correlated t-tests;
proc means mean n t prt; var d1-d7 d10-d13; run;
proc univariate NOPRINT; var d1-d7 d10-d13;
 output out=wilc_mpt signrank=W1 W2 W3 W4 W5 W6 W7 W10 W11 W12 W13
  probs=P1 P2 P3 P4 P5 P6 P7 P10 P11 P12 P13; run;
proc print data=wilc_mpt; run;
/*****************************************************************************
This program is an example of how to get SAS to do Wilcoxon's Signed Ranks
Test for Matched Pairs data.  If you have only one variable, it is easy, just
compute the difference scores and run PROC UNIVARIATE.  The output will
include the signed rank statistic and its p-value.  But it also gives you
a whole page of other statistics.  If you just want the signed rank statistics,
suppress the printed output (use the NOPRINT option) and OUTPUT to a new data
set the statistics you want -- then print that new data set.  In our example,
we compute 11 difference scores.  We ask SAS to output the signed rank
statistic (keyword SIGNRANK) for each of the 11 variables, naming those
statistics W1, W2, W3, W4, W5, W6, W7, W10, W11, W12, and W13 (the numbers
reflect item numbers on the questionnaire).  We also ask SAS to output the
p-values (keyword PROBS) with similar names.
 
This method of getting UNIVARIATE output can also be used with other UNIVARIATE
statistics, such as the MEDIAN.
**********************************************************************/
