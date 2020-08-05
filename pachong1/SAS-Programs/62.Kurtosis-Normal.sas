*Kurtosis-Normal.sas;
************************************************************************************;
options formdlim='-' pageno=min nodate;
TITLE 'Sampling Distributions of Skewness and Kurtosis for 100,000 Samples of 1000 Scores';
 title2 'Each From a Normal(0,1) Distribution'; run;
DATA normal; DROP N; DO SAMPLE=1 TO 100000; DO N=1 TO 1000; X=NORMAL(0);
OUTPUT; END; END;
PROC MEANS NOPRINT; OUTPUT OUT=SK_KUR SKEWNESS=SKEWNESS KURTOSIS=KURTOSIS; VAR X; BY SAMPLE;
PROC MEANS MEAN STD N; VAR skewness kurtosis; run;

