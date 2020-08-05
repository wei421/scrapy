%process (data=kevin,vars=ar misanth idealism,y=ar,x=idealism,m=misanth,
  model=1,jn=1,plot=1);
data plot; input Misanthropy Effect llci ulci;
cards;
1.0000	0.4940	0.1295	0.8584
1.1500	0.4513	0.1196	0.7829
1.3000	0.4086	0.1086	0.7085
1.4500	0.3658	0.0962	0.6355
1.6000	0.3231	0.0817	0.5645
1.7500	0.2804	0.0644	0.4964
1.9000	0.2377	0.0432	0.4322
2.0500	0.1950	0.0166	0.3734
2.1286	0.1726	0.0000	0.3453
2.2000	0.1523	-0.0169	0.3215
2.3500	0.1096	-0.0584	0.2776
2.5000	0.0669	-0.1082	0.2420
2.6500	0.0242	-0.1652	0.2136
2.8000	-0.0185	-0.2281	0.1910
2.9500	-0.0612	-0.2952	0.1727
3.1000	-0.1039	-0.3655	0.1576
3.2500	-0.1467	-0.4379	0.1446
3.4000	-0.1894	-0.5120	0.1333
3.5500	-0.2321	-0.5873	0.1231
3.7000	-0.2748	-0.6634	0.1139
3.8500	-0.3175	-0.7402	0.1053
4.0000	-0.3602	-0.8176	0.0972
proc sgplot;
series x=Misanthropy y=ulci/curvelabel = '95% Upper Limit' lineattrs=(color=red pattern=ShortDash);
series x=Misanthropy y=effect/curvelabel = 'Point Estimate' lineattrs=(color=blue pattern=Solid);
series x=Misanthropy y=llci/curvelabel = '95% Lower Limit' lineattrs=(color=red pattern=ShortDash);
xaxis label = 'Misanthropy';
yaxis label = 'Conditional effect of idealism';
refline 0/axis=y transparency=0.5;
refline 2.1286/axis=x transparency=0.5; run;
Data Plot2;
input Misanthropy Idealism Animal_Rights; cards;
  1.6473 0.0000 2.1201 
  2.3208 0.0000 2.3222 
  2.9942 0.0000 2.5243 
  1.6473 1.0000 2.4298 
  2.3208 1.0000 2.4401 
  2.9942 1.0000 2.4504 
proc sgplot; reg x = misanthropy y = Animal_Rights / group = Idealism nomarkers;
  yaxis label='Standardized Support of Animal Rights';
  xaxis label='Standardized Misanthropy'; run;
  *Change perspective;
  %process (data=kevin,vars=ar misanth idealism,y=ar,x=misanth,m=idealism,model=1);

