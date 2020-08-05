
Data Diffs; Input Diff @@; Cards;
-4 27 32 19 25 23 32 31 33 32 2 20 21 -5 17
;


/**
Much of the code here was adapted from Burchill, http://mchp-appserv.cpe.umanitoba.ca/Upload/SAS/code.html .

data=   Input data set, this is required. 

repeat= Number of iterations to sample for boot strap.  Default is 1000.
var=  Variable of interest for median/mean using boot strap

ci= Confidence coefficient (integer 1-100) default is 95


Output 
  Three printed tables:
1. Median and CI using Burchill's code.
2. Confidence intervals for quartiles from Proc Univariate.
3. Confidence interval for Mean from Proc Univariate.
4. Standard method bootstrap mean, median, CI, using Burchill's code.
5. Bias reduced method bootstrap mean, median, CI using Burchill's code.

   The number of iterations (repeat=) of sampling done is limited to 
less than 2000.  According to some literature you should not
need to run with more than 250 repeated samples.  Many other
sources suggest an limit of 1000 samples should be adequate.

*** get median and number of records ; */
proc univariate data=Diffs  noprint ;
      var Diff ;
      output out=itest  median=median n=n  ;
      run ;
*** Calculate upper and lower record numbers (bounds) ;
data itest ;
   set itest ;
   z = probit(0.05/2) ;  *** set alpha here, divide by 2 for two tailed test.  As it stands, z = -1.95996 ;
   upper = ceil(((n+1)/2)+((n)**0.5)/2*z) ; 
   lower = floor(((n+1)/2)-((n)**0.5)/2*z) ;
   run;
*** Sort by the variable you are getting the median value for ;
proc sort data=Diffs ;
   by Diff ;
   run;
*** Find the value of the variable for the record representing the bound ;
data test ;
   if _n_ = 1 then set itest ;
   set Diffs ;
   if _n_ = lower then do ; ci='Lower' ; output ; end ;
   if _n_ = upper then do ; ci='Upper' ; output ; end  ;
   run;
*** print it out. ;
Title 'Standard Confidence Interval for Median Using Burchill''s Code'; run;
proc print data=test ;
   var ci Diff median ;
   run;

/* CIPCTLDF requests confidence limits for quantiles by using a method that is distribution-free.
   In other words, no specific parametric distribution such as the normal is assumed for the data.
   PROC UNIVARIATE uses order statistics (ranks) to compute the confidence limits as described by Hahn and Meeker (1991)*/
Title 'Confidence Intervals for Quartiles from Proc Univariate'; run;
proc univariate data=Diffs CIPCTLDF CIPCTLNORMAL ;
var Diff;
run;

*** The following macro randomly samples (with replacement) a data set the
    size of the original and does a proc univariate to get the mean
    and median on the data ; 
%macro _boot(data=Diffs, repeat=500, var=Diff, ci=95, debug=0 ) / stmt ;

%put Simple Boot Strap Macro for Calculating Median Confidence Intervals ;
%put Charles A. Burchill, Manitoba Centre for Health Policy and Evaluation ;
%put $Id: _boot.sas,v 1.1 2000/10/14 00:03:18 burchil Exp burchil $ ;

%if &debug = 1 %then %let debug=debug ;
%if &debug ^= debug %then options nonotes nomprint ;
%else options notes mprint ; ;

%* The differnce from 100 of the upper and lower bound used in the 
   proc univariate procedure is only 1/2 the alpha removed
   from the top and bottom ;
%let low=%sysevalf((100-&ci)/2) ;
%let upper=%sysevalf(100-&low) ;
%let ci = %sysevalf(&ci/100) ;

%* If request is over 2000 iterations bail out ;
%if %eval(&repeat>2000) %then %goto out0 ;

%*** Run a means to provide some base information for the variable ;
proc means data=&data mean clm alpha=%sysevalf(1-&ci) max min n ;
   var &var ;
   title "Mean and Confidence Interval (%sysevalf(&ci*100) %) using Proc Means for &var" ;
   run;

%** delete any existing final dataset ;
proc datasets nolist ;
   delete final ;
   run;

%*** Create random samples with replacement of provided data set ;
%do i = 1 %to &repeat ;
   data _test ;
      _choice = int(ranuni(500+&i)*n) + 1; 
      set &data(keep=&var) point=_choice nobs=n ; 
          * keep forces only variable used in boot strap to be kept - limit size ;
      j+1 ;
      if j > n then stop ;
      run;

   %if %eval(&SYSERR>0) %then %goto out1;

   %*** Procedure that you want to boot strap - in this case mean and median values. ;
   proc univariate data=_test  noprint ;
      var &var ;
      output out=_itest mean=l_Mean median=l_median ;
      run ;

   %if %eval(&SYSERR>0) %then %goto out1;

   %*** Build new dataset based on output from above procedure ;
   proc append base=final data=_itest ;

   %end ;

  ** Get the 95% confidence interval around the mean - standard method using percent points i
n boot strapped data ;
  proc univariate  data=final noprint ; ;
     var l_mean l_median ;
     output out=final2 pctlpts=&low &upper pctlpre=Mean_ Med_  ;
     run;

  *** Get mean and median of variable for reporting and bias reduced test below ;
  proc univariate data=&data  noprint ;
      var &var ;
      output out=btest mean=b_Mean median=b_median ;
      run ;

   %if %eval(&SYSERR>0) %then %goto out1;

  data final2 ;
    merge btest final2 ;
    label b_mean="Mean &var"
          b_median="Median &var" ;
    run;

  proc print data=final2 label ;
     title1 'Standard upper and lower confidence intervals for Mean and Median using Bootstra
p' ;
     title2 "Data = &data Variable=&var CI=%sysevalf(&ci*100)";;
     run;  

  *** Calculate the sample bias-reduced estimates 
    see:  http://www.dmstat1.com/bootstrap.html, and T method refered to in SAS bootstrap macro ; 
  *** See following references for variations 
  E&T     Efron, B. and Tibshirani, R.J. (1993), An Introduction to the
        Bootstrap, New York: Chapman & Hall.

  S&T     Shao, J. and Tu, D. (1995), The Jackknife and Bootstrap, New York:
        Springer-Verlag. ;
  data final3 ;
    if _n_ = 1 then set btest ;
    set final ; ;
    s_mean = 2*b_mean - l_mean ;
    s_median = 2*b_median - l_median ;
    run;

  proc univariate data=final3 noprint ;
    var s_mean s_median ;
    output out=btest2 std=s_mean s_median ;
    run;

  data final3(drop=s_mean s_median alpha pro) ;
    merge btest btest2 ;
    alpha = (1-&ci)/2 ;  *** Set probability based on confidence interval e.g. (0.95)  ;
    pro = probit(alpha) ;   *** pro is the probability statistic based on the given alpha ;
    bl_mn = b_mean+pro*s_mean ;
    bu_mn = b_mean-pro*s_mean ;
    bl_md = b_median+pro*s_median ;
    bu_md = b_median-pro*s_median ;
    label b_mean="Mean &var "
          b_median="Median &var" 
          bl_mn = "Lower Mean" 
          bu_mn = "Upper Mean" 
          bl_md = "Lower Median" 
          bu_md = "Upper Median" ;

    run;

  proc print label ;
    title1 'Bias Reduced upper and lower confidence intervals for Mean and Median using Boots
trap' ;
    title2 "Data = &data Variable=&var CI=%sysevalf(&ci*100)";
    run;


  %goto exit;  
  %out0:
     option notes ;
     %put WARNING: This is an iterative procedure that will duplicate the data set &repeat ti
mes ;
     %put WARNING: There is a limit of 2000 iterations, generally boot strap methods need no 
more than 500 iterations ;
     %put WARNING: The macro did not execute ;
     %goto exit ;
  %out1:
      options notes ;
     %put WARNING: There was an ERROR in the boot macro. ;
     %put WARNING: The macro did not execute. ;
     %goto exit ;
  %exit:
   options notes ;
   title1 ;
   title2 ;

%mend ;
%_boot;
