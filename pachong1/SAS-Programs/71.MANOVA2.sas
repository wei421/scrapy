options pageno=min nodate formdlim='-';
title 'Two-way MANOVA & ANCOV, for instructional purposes.';
title2 'Data are from thesis, Michelle Plaster, 1989';
proc format; value attr 1='Attractive' 2='Average' 3='Unattractive';
  value cr 1='Burglary' 2='Swindle';
data sol; infile 'C:\Users\Vati\Documents\_XYZZY\_Stats\StatData\plaster.dat';
input PA Crime Years Serious exciting calm indepen sincere warm phyattr
  sociable kind intellig strong sophist happy ownpa;
format PA attr.  crime cr. ;
Z_Serious = (serious-5.0175439)/2.2021006;
Z_Years = (years-4.6929825)/3.6339773;
CV_PA1 = 1.19783801*Z_years -0.69052428*Z_serious;
CV_INT1 =  1.20033973*Z_years -0.55543752*Z_serious;
proc means; var serious years;
proc GLM; class PA Crime; model serious years = PA|Crime / nouni;
  manova h = PA|Crime / canonical; means PA|Crime;
  title 'MANOVA, PA x Crime, Seriousness and Years'; run;
proc GLM; class PA Crime; model CV_PA1 CV_INT1 serious years = PA|Crime / ss3;
  means PA / lsd lines;
  title 'Factorial ANOVAs on canonical variates and observed variables'; run;
proc GLM; class PA Crime; model CV_INT1 = PA|Crime / ss3;
  lsmeans PA*Crime / slice = PA; run;
proc GLM; class PA Crime; model years = serious  PA|Crime / ss3;
  lsmeans pa / pdiff; title1 'ANCOV, seriousness as covariate'; run;

