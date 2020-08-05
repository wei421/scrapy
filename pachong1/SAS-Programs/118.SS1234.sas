options pageno=min nodate formdlim='-';
proc format; value gen 1='Male' 2='Female'; value attr 1='No' 2='Yes';
data harass; infile 'C:\StatData\SS1234.dat';
input gender plattr deattr rating;
format gender gen. plattr deattr attr. ;
proc glm; class deattr gender plattr;
 model rating =deattr|gender|plattr / ss1 ss2 ss3;
 means deattr  deattr*gender*plattr; lsmeans deattr; run;
proc glm; class deattr gender plattr;
 model rating = plattr|gender|deattr / ss1 ss2 ss3;run;
