* This program is used with within-subjects designs. It computes 
confidence intervals for effect size estimates.  To use the program one 
inputs at the top of the program:
     m--a vector of means
     v--a covariance matrix in lower diagonal form, with periods for
        the upper elements
     n--the sample size
  prob--the confidence level prior to the Bonferroni adjustment
adjust--the number of contrats is a Bonferroni adjustment to the 
        confidence level is requested. Otherwise adjust is set 
        equal to 1
  Bird--a switch that uses the variances of all variables to calculate
        the denominator of the effect size as suggested by K. Bird 
        (Bird=1). Our suggestion is to use the variance of those 
        variables involved in the contrast to calculate the denominator 
        of the effect size (Bird=0)
In addition one inputs at the bottom of the program:
     c--a vector of contrast weights 
multiple contrasts can be entered. After each, type the code 
run ci;
*Downloaded from James Algina's page at http://plaza.ufl.edu/algina/index.programs.html ;
*************************************************************************************;
proc iml;
m={32.500 22.467 23.133};
v={58.121 . .,
   35.517 49.016 .,
   36.690 40.384 49.430};
do ii = 1 to nrow(v)-1;
do jj = ii+1 to nrow(v);
   v[ii,jj]=v[jj,ii];
end;
end;
n=30    ;
Bird=1;
df=n-1;
cl=.95;
adjust=3;
prob=cl;
print 'Vector of means:';
print m;
print 'Covariance matrix:';
print v;
print 'Sample size:';
print n;
print 'Confidence level before Bonferroni adjustment:';
print cl;
cl=1-(1-prob)/adjust;
print 'Confidence level with Bonferroni adjustment:';
print cl;
start CI;
pvar=0;
count=0;
if bird=0 then do;
  do mm=1 to nrow(v);
     if c[1,mm]^=0  then do;
        pvar=pvar+v[mm,mm];
	    count=count+1;
     end;
  end;
end;
if bird=1 then do;
   do mm=1 to nrow(v);
      pvar=pvar+v[mm,mm];
	   count=count+1;
   end;
end;
pvar=pvar/count;
es=m*c`/(sqrt(pvar));
se=sqrt(c*v*c`/n);
nchat=m*c`/se;
ncu=TNONCT(nchat,df,(1-prob)/(2*adjust));
ncl=TNONCT(nchat,df,1-(1-prob)/(2*adjust));
ll=se*ncl/(sqrt(pvar));
ul=se*ncu/(sqrt(pvar));
print 'Contrast vector';
print c;
print 'Effect size:';
print es;
Print 'Estimated noncentrality parameter';
print nchat;
Print 'll is the lower limit of the CI and ul is the upper limit';
print ll ul;
finish;
c={1 -1 0};
run ci;
c={1 0 -1};
run ci;
c={0 1 -1};
run ci;
quit;
