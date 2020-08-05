*This program produces plots of the t-distributions for a given sample size
 under the null and alternate hypotheses. It also computes critical t-values for
 a pre-specified alpha. From Phil Wood, PSYSPARC GOPHER, minor mods by
 K. Wuensch.  PLAY AROUND WITH THE PARAMETERS IN THE LAST LINES OF THIS
 FILE TO OBSERVE THE EFFECTS THEREOF ON THE POWER OF A ONE-SAMPLE T-TEST
*****************************************************************************;
options nodate nonumber formdlim='-';
%macro tpower(alpha,df,nc); %let alpha=1-&alpha; %let df=&df-1;
data calc; nc=sqrt(&df+1)*&nc;
tcrit=tinv(&alpha,&df,0); power=1-probt(tcrit,&df,nc);
alpha=&alpha;df=&df; output;
proc print; var tcrit alpha df power;
data tdist; df=&df; nc=sqrt(df+1)*&nc; keep x cumy df nc;
do x=-5 to 5 by .1;  cumy=probt(x,df,0);  output;  end;
 x=.;cumy=.;output;
do x=-5+nc to 5+nc by .1;  cumy=probt(x,df,nc); output;  end;
data tdist;set tdist;  y=dif(cumy)/dif(x);  tcrit=tinv(&alpha,&df,0);
symbol1 i=spline l=1; symbol2 i=spline l=2;
proc gplot data=tdist;
 plot y*x;
%mend tpower;
/******************************************************************************;
Put in your desired alpha, the sample size, and the mean difference for the
alternate hypothesis (in standard deviation units) in the lines below. For
example, the first line below assumes a two-tailed alpha of .05 (that's why I
divided by two), a sample size of 10, and considers the alternative hypothesis 
that the mean of the population is .5;  In the second line I change the sample
size to 20. In the third line I change the mean difference to .80 sd.  You can,
of course, have more than three lines.
******************************************************************************/;
Title 'N = 10, d = .5'; run;
%tpower(.05/2,10,.50);run; quit;
Title 'N = 20, d = .5'; run;
%tpower(.05/2,20,.50);run; quit;
Title 'N = 20, d = .8'; 
%tpower(.05/2,20,.80);run; quit;
