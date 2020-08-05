options pageno=min nodate formdlim='-';
title 'Animal Research Committee Research'; run;
proc format; value sx 1='Female' 2='Male'; value wi 1='No' 2='Yes';
value gr 1='Cosmetic' 2='Theory' 3='Meat' 4='Veterin.' 5='Medical';
data arc; infile 'D:\StatData\arc.dat';
input group 1 withdraw 2 justify 3 (epq1-epq20) (1.0) gender 24
  age 25-26 class 27 race 28 id 29-31;
nmiss=nmiss(of group -- id);
data cull; set arc; if nmiss > 2 then delete; if justify = . then delete;
idealism=mean(of epq1-epq10); relatvsm=mean(of epq11-epq20);
cosmetic = 0; theory = 0; meat = 0; veterin = 0;
if group = 1 then cosmetic = 1; else if group = 2 then theory = 1;
 else if group = 3 then meat = 1; else if group = 4 then veterin = 1;
proc logistic;
 model withdraw = idealism relatvsm gender cosmetic theory meat veterin
 / ctable;
proc logistic;
 model withdraw = idealism relatvsm gender;
proc ttest; class withdraw; var idealism relatvsm;
 format withdraw wi. ;
proc freq; tables withdraw*(group gender) / norow nopercent chisq;
 format withdraw wi. group gr. gender sx. ; run;
data p; c = probchi(8.443, 4); proc print; run;
