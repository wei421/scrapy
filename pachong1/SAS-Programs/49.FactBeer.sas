options pageno=min nodate options formdlim='-';
title 'Factor Analysis with Factor Scores Analyzed Within SAS'; run;
DATA BEER;
INPUT COST SIZE ALCOHOL REPUTAT COLOR AROMA TASTE ses group;CARDS;
90 80 70 20 50 70 60 2 1
75 95 100 50 55 40 65 1 1
10 15 20 85 40 30 50 4 2
100 70 50 30 75 60 80 3 2
20 10 25 35 30 35 45 4 1
50 100 100 30 90 75 100 3 1
5 15 15 75 20 10 25 2 1
65 30 35 80 80 60 90 6 2
95 95 100 0 80 70 95 2 1
85 80 70 40 60 50 65 2 1
0 0 20 30 80 90 100 8 2
10 25 10 100 50 40 60 5 2
80 70 50 50 40 20 50 1 1
25 35 30 40 45 30 65 3 2
5 10 15 65 50 65 85 7 2
20 5 10 40 60 50 95 7 2
70 60 70 75 10 15 25 0 1
50 15 20 50 10 5 50 2 1
75 50 95 40 0 0 40 0 1
15 10 25 30 95 80 100 8 2
80 90 100 50 20 . 40 0 1
;
Proc Factor METHOD=PRINIT REORDER ROTATE=VARIMAX
  PRIORS=SMC NFACTORS=2 RES;
  var cost size alcohol reputat color aroma taste; run;
DATA alpha; SET Beer; NegRep = -1*reputat;
Proc Corr nomiss nosimple nocorr alpha; Var color taste aroma negrep; 
  Title 'Alpha for unit weighed AQ scale'; run;
Proc Corr nomiss nosimple nocorr alpha; Var color taste aroma;
  Title 'Alpha for AQ After Dumping the Reputation Variable'; run;
Proc Factor Data = Beer METHOD=PRINIT MSA REORDER ROTATE=VARIMAX
  PRIORS=SMC NFACTORS=2 RES OUT=DRINKME; var cost size alcohol color aroma taste; 
  Title 'Factor Analysis Without the Reputation Variable'; run;
Proc TTest; Class Group; Var Factor1 Factor2 SES;
   Title 'Comparing the Groups on the Factors'; run;
Proc Reg simple corr; Model SES = Factor1 Factor2 / stb;
   Title 'Predicting SES From the Factor Scores'; run; 
Quit;



