* This program is used with between-subjects designs. It computes 
confidence intervals for effect size estimates.  To use the program one 
inputs at the top of the program:
     m--a vector of means
    sd--a vector of standard deviations
     n--a vector of sample size
  prob--the confidence level prior to the Bonferroni adjustment
adjust--the number of contrats is a Bonferroni adjustment to the 
        confidence level is requested. Otherwise adjust=1
In addition one inputs at the bottom of the program:
     c--a vector of contrast weights 
multiple contrasts can be entered. After each, type the code 
run ci;
*Downloaded from James Algina's page at http://plaza.ufl.edu/algina/index.programs.html ;
*************************************************************************************;
proc iml;
m={22.467 24.933 32.000};
sd={7.001 8.288 6.938};
v=sd##2;
n={30 30 30};
cl=.95;
adjust=2;
prob=cl;
df=(n-j(1,ncol(n),1));
pdf=df[,+];
temp= df#v;
pvar=temp[,+]/pdf;
nn=diag(n);
ni=inv(nn);
print 'Vector of means:';
print m;
print 'Vector of standard deviations:';
print sd;
print 'Vector of sample sizes:';
print n;
print 'Confidence level before Bonferroni adjustment:';
print cl;
cl=1-(1-prob)/adjust;
print 'Confidence level with Bonferroni adjustment:';
print cl;
print 'Pooled df:';
print pdf;
print 'Pooled variance:';
print pvar;
start CI;
es=m*c`/sqrt(pvar);
nchat=es/(sqrt(c*ni*c`));
ncu=TNONCT(nchat,pdf,(1-prob)/(2*adjust));
ncl=TNONCT(nchat,pdf,1-(1-prob)/(2*adjust));
ll=(sqrt(c*ni*c`))*ncl;
ul=(sqrt(c*ni*c`))*ncu;
print 'Effect size:';
print es;
Print 'Estimated noncentrality parameter';
print nchat;
Print 'll is the lower limit of the CI and ul is the upper limit';
print ll ul;
finish;
c={.5 .5 -1};
run ci;
c={1  -1  0};
run ci;
quit;
