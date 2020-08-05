proc contents; run;
proc means data=protest; run;
data protest2; set protest;
  SexismZ=(sexism-5.1169767)/0.7837616;
  LikingZ=(liking-5.6367442)/1.0496973;
  RespapprZ=(respappr-4.8662791)/1.3481203; run;
  Proc Means; run;
%process (data=protest2, vars=protest RespapprZ LikingZ,y=LikingZ,x=protest,m=RespapprZ,boot=10000,model=4);
%process (data=protest2, vars=protest RespapprZ SexismZ,y=RespapprZ,x=protest,m=SexismZ,quantile=1,model=1);
%process (data=protest2, vars=protest RespapprZ SexismZ LikingZ,y=LikingZ,x=protest,m=SexismZ,quantile=1,model=1);
%process (data=protest2, vars=protest RespapprZ SexismZ LikingZ,y=LikingZ,x=protest,w=SexismZ, m=RespapprZ,quantile=1,model=8, boot=10000);
data plot; input SexismZ @@;
Direct = -0.0297 + .4051*SexismZ;
Indirect = (1.0815 + .4709*SexismZ)*.4614;
cards;
-1.272 -0.7872 0.0039 0.6418 1.2798
proc sgplot;
 series x=SexismZ y=direct/curvelabel = 'Direct Effect' lineattrs=(color=blue pattern=ShortDash);
 series x=SexismZ y=indirect/curvelabel = 'Indirect Effect' lineattrs=(color=red pattern=Solid);
 xaxis label = 'Perceived Pervasiveness of Sexism';
 yaxis label = 'Conditional Effect of Protest';
 refline 0/axis=y lineattrs=(color=gray pattern=ShortDash);
run; 
