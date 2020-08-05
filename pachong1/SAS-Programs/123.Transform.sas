options formdlim='-' pageno=min nodate;
DATA skewed; drop obs;
do obs=1 to 500;
Y=10+100*RANEXP(0);
output; end;
run;
proc univariate noprint; histogram Y; title 'Exponential Distribution'; run;
proc means mean min max std skewness kurtosis; var Y; run;
******************************************************************************;
proc standard data=skewed mean=0 std=1 out=zScores;	var Y; run;
proc univariate noprint; histogram Y; title 'Z Scores'; title'Z Scores'; run;
proc means min max mean std skewness kurtosis; var Y; run;
******************************************************************************;
proc rank data=skewed out=ranks; var Y; run;
proc univariate noprint; histogram Y / midpoints=50.5 150.5 250.5 350.5 450.5; title 'Ranks'; run;
proc means min max mean std skewness kurtosis; var Y; run;
*************************************************************************;
data transformed; set skewed;
Square_Root=sqrt(Y);  Cube_Root=Y**(1/3); Natural_Log=log(Y); run;
proc univariate noprint; histogram Square_Root -- Natural_Log; title 'Ordinal Transformations'; run;
proc means min max mean std skewness kurtosis; var Square_Root Cube_Root Natural_Log; run;
******************************************************************************************
Given a distribution of scores that has great positive skewness,
what is the effect of each of the following transformations:
1.  Converting the scores to z-scores, which is linear transformation.
2.  Ranking scores, which is an ordinal transformation.
3.  Ordinal transformations which reduce the values of large scores more than they
    reduce the values of small scores (square root, cube root, natural log).
******************************************************************************************; 

