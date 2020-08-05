*Kurtosis-Uniform.sas;
************************************************************************************;
options formdlim='-' pageno=min nodate;
TITLE 'One Sample of 500,000 Scores From Uniform(0,1) Distribution'; run;
DATA uniform; DROP N; DO N=1 TO 500000; X=UNIFORM(0);
OUTPUT; END;
PROC MEANS mean std skewness kurtosis; VAR X; run;

