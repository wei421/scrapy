************************** Tetrachoric.sas  *************************;
options formdlim='-' pageno=min nodate;
title 'Tetrachoric Correlation';
proc format; value MS 0 = '< median' 1 = '> median';
data AMI; infile 'D:\StatData\potthoff.dat'; input ar misanth idealism;
If idealism = 1 then delete;
If 0 < AR LE 2.286 then AnimRights = 0;
	Else if AR > 2.286 then AnimRights = 1;
If 0 < Misanth LE 2.4 then Misanthropy = 0;
	Else if Misanth > 2.4 then Misanthropy = 1;
	format AnimRights Misanthropy MS. ;
proc means median min max; var ar misanth; run;
proc freq; tables Misanthropy*AnimRights / nopercent nocol chisq plcorr; run;
proc corr; var misanth; with ar; run;
