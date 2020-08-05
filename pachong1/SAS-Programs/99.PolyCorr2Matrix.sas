/* PolyCorr2Matrix -- adapted from code at http://www.ats.ucla.edu/stat/sas/faq/tetrac.htm */
options pageno=min nodate formdlim='-'; title;
PROC IMPORT OUT= WORK.epq 
            DATAFILE= "C:\Users\Vati\Documents\StatData\EPQ.xlsx" 
            DBMS=EXCEL REPLACE;
     RANGE="Sheet1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;

proc freq data = epq;
  tables (Q1-Q20)*(Q1-Q20) / NOPRINT plcorr;
  ods output measures=mycorr (where=(statistic="Tetrachoric Correlation" or statistic="Polychoric Correlation")
    keep = statistic table value); run;
/* proc print data = mycorr; run; */

data mycorrt;
  set mycorr;
  group = floor((_n_ - 1)/20);
  x = scan(table, 2, " *");
  y = scan(table, 3, " *");
   keep group value table x y; run;
/* proc print data = mycorrt; run; */

proc transpose data = mycorrt out=mymatrix (drop = _name_ group)   ;
   id x;
   by group;
   var value ;
run;
/* proc print data = mymatrix; */
run;

Data fa(type=corr);
set mymatrix(type=corr);
_type_ = 'corr';
proc print; run;
Proc Factor METHOD=PRINIT REORDER ROTATE=VARIMAX PRIORS=SMC NFACTORS=2; var q1-q20; 
title 'Factor Analysis with Polychoric Correlation Coefficients'; run;

Proc Factor  DATA = epq METHOD=PRINIT REORDER ROTATE=VARIMAX PRIORS=SMC NFACTORS=2; var q1-q20; 
title 'Factor Analysis with Pearson Correlation Coefficients'; run;
