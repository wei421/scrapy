title 'Animal Research Committee Research'; run;
proc format; value sx 1='Female' 2='Male'; value wi 1='No' 2='Yes';
value ra 1='Black' 2='White' 3='Other';
value cl 1='Fresh' 2='Soph' 3='Junior' 4='Senior' 5='Grad';
value gr 1='1=Cosmetic' 2='2=Theory'
3='3=Meat' 4='4=Cat Dis.' 5='5=Human Dis.';
data arc; infile 'C:\StatData\arc.dat';
input group 1 withdraw 2 justify 3 (epq1-epq20) (1.0) sex 24
  age 25-26 class 27 race 28 id 29-31;
nmiss=nmiss(of group -- id);
data cull; set arc; if justify = . then delete;
if nmiss > 2 then delete;
idealism=mean(of epq1-epq10); relatvsm=mean(of epq11-epq20);
