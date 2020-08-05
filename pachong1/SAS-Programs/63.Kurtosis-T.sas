*Kurtosis-T.sas;
************************************************************************************;
options formdlim='-' pageno=min nodate;
TITLE 'T ON 9 DF, T COMPUTED ON EACH OF 500,000 SAMPLES';
TITLE2 'EACH WITH 10 SCORES FROM A STANDARD NORMAL POPULATION'; run;
DATA T9; DROP N; DO SAMPLE=1 TO 500000; DO N=1 TO 10; X=NORMAL(0);
OUTPUT; END; END;
PROC MEANS NOPRINT; OUTPUT OUT=TS T=T; VAR X; BY SAMPLE;
PROC MEANS MEAN STD N KURTOSIS; VAR T; run;
************************************************************************************;
DATA T10; DROP N; DO SAMPLE=1 TO 500000; DO N=1 TO 11; X=NORMAL(0);
OUTPUT; END; END;
PROC MEANS NOPRINT; OUTPUT OUT=TS T=T; VAR X; BY SAMPLE;
TITLE 'T ON 10 DF, SAMPLING DISTRIBUTION OF 500,000 TS'; run;
PROC MEANS MEAN STD N KURTOSIS; VAR T; run;
************************************************************************************;
DATA T16; DROP N; DO SAMPLE=1 TO 500000; DO N=1 TO 17; X=NORMAL(0);
OUTPUT; END; END;
PROC MEANS NOPRINT; OUTPUT OUT=TS T=T; VAR X; BY SAMPLE;
TITLE 'T ON 16 DF, SAMPLING DISTRIBUTION OF 500,000 TS'; run;
PROC MEANS MEAN STD N KURTOSIS; VAR T; run;
************************************************************************************;
DATA T28; DROP N; DO SAMPLE=1 TO 500000; DO N=1 TO 29; X=NORMAL(0);
OUTPUT; END; END;
PROC MEANS NOPRINT; OUTPUT OUT=TS T=T; VAR X; BY SAMPLE;
TITLE 'T ON 28 DF, SAMPLING DISTRIBUTION OF 500,000 TS'; run;
PROC MEANS MEAN STD N KURTOSIS; VAR T; run;
