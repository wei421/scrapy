*This program computes a CI for the effect size in 
a between-subject design with two groups. 
m1 and m2 are the means for the two groups
s1 and s2 are the standard deviations for the two groups
n1 and n2 are the sample sizes for the two groups
prob is the confidence level;
*Downloaded from James Algina’s webpage at http://plaza.ufl.edu/algina/ ;
data;
m1=14.8125     ;
m2= -1.3125    ;
s1=9.032      ;
s2=8.4041       ;
n1=32  ;
n2=16  ;
prob=.95;
v1=s1**2;
v2=s2**2;
pvar=((n1-1)*v1+(n2-1)*v2)/(n1+n2-2);
se=sqrt(pvar*(1/n1+1/n2));
nchat=(m1-m2)/se;
es=(m1-m2)/(sqrt(pvar));
df=n1+n2-2;
ncu=TNONCT(nchat,df,(1-prob)/2);
ncl=TNONCT(nchat,df,1-(1-prob)/2);
ll=(sqrt(1/n1+1/n2))*ncl;
ul=(sqrt(1/n1+1/n2))*ncu;
output;
proc print;
title1 'll is the lower limit and ul is the upper limit';
title2 'of a confidence interval for the effect size';
var es  ll ul;
run;
quit;
