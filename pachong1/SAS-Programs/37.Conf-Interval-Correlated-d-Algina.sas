*This program computes an approximate CI for the effect 
size in a within-subjects design with two groups. 
m2 and m1 are the means for the two groups
s1 and s2 are the standard deviations for the two groups
n1 and n2 are the sample sizes for the two groups
r is the correlation
prob is the confidence level;
*Downloaded from James Algina page at http://plaza.ufl.edu/algina/ ;
data;
m1=22.7291667 ;
m2=13.2916667  ;
s1=10.4428324  ;
s2=10.4656649  ;
r= 0.38075 ; 
n=48    ;
prob=.95 ;
v1=s1**2;
v2=s2**2;
s12=s1*s2*r; 
se=sqrt((v1+v2-2*s12)/n);
pvar=(v1+v2)/2;
nchat=(m1-m2)/se;
es=(m1-m2)/(sqrt(pvar));
df=n-1;
ncu=TNONCT(nchat,df,(1-prob)/2);
ncl=TNONCT(nchat,df,1-(1-prob)/2);
ul=se*ncu/(sqrt(pvar));
ll=se*ncl/(sqrt(pvar));
output;
proc print;
title1 'll is the lower limit and ul is the upper limit';
title2 'of a confidence interval for the effect size';
var es ll ul ;
run;
quit;
