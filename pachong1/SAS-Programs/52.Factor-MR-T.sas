options formdlim='-' pageno=min nodate;
title 'Stats on factor scores'; run;
Proc Format; value who 1='Pitt' 2='ECU' ;
data scores; infile 'D:\StatData\factbeer.dat';
input AesthetQ CheapDr SES Group;
format Group who. ;
proc reg simple corr; model SES=AesthetQ CheapDr / stb scorr2;
proc ttest; class Group; var AesthetQ CheapDr; run;
