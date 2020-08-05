options pageno=min nodate formdlim='-';
title 'Multiple Imputation of Missing Data then Multiple Regression.'; run;
PROC IMPORT OUT= WORK.IntroQuest 
            DATAFILE= "C:\Users\Vati\Documents\StatData\IntroQ\IntroQ.sav" 
            DBMS=SPSS REPLACE;
RUN;
proc means n nmiss; run;
Proc MI seed=69301 out=MIdata; var gender ideal nucoph SATM year; run;
Proc Reg outest=MRbyImput covout;
  Model Statoph = gender ideal nucoph SATM year / stb; By _Imputation_; run;
Proc MIAnalyze; modeleffects intercept gender ideal nucoph SATM year; run;
