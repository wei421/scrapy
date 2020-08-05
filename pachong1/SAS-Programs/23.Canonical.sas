options pageno=min nodate formdlim='-';
title 'Canonical Correlation, Journal of Interpersonal Violence, 10: 354-366.';
data SunitaPatel;  infile 'C:\Users\Vati\Documents\StatData\Sunita.dat';
input Group Gender PD MF MA SI IAH SBS F K;
if gender ne 1 then delete;
proc corr; var pd mf ma k iah sbs;
PROC CANCORR redundancy 
  VN='Homonegativity' WN='MMPI' VP=Homoneg_ WP=MMPI_ out=Sol;
  VAR IAH SBS; WITH MA MF PD K;
proc corr; var Homoneg_1 Homoneg_2 MMPI_1 MMPI_2; run;
proc reg; model IAH = MMPI_1 MMPI_2 / scorr1; run; quit;
proc reg; model SBS = MMPI_1 MMPI_2 / scorr1; run; quit;
