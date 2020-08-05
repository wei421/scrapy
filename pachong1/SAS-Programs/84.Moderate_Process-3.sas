*Moderate_Process-3.sas;
data AR1; infile 'F:\StatData\Moderate.dat';
input AR Misanth Ideal;
proc standard mean=0 std=1 out=Zs; run;
%process (data=Zs,y=ar,x=Misanth,w=Ideal,model=1,jn=1,plot=1);
data plot; input Misanthropy Idealism Animal_Rights;
cards;
-1.0703 -1.0328 -0.5746 
-0.1793 -1.0328 -0.1709 
1.0085 -1.0328 0.3675 
-1.0703 0.0934 -0.3235 
-0.1793 0.0934 -0.0658 
1.0085 0.0934 0.2777 
-1.0703 1.2196 -0.0723 
-0.1793 1.2196 0.0392 
1.0085 1.2196 0.1879 
proc sgplot; reg x = misanthropy y = Animal_Rights / group = Idealism nomarkers;
  yaxis label='Standardized Support of Animal Rights';
  xaxis label='Standardized Misanthropy'; run;
data plot_JN; input Idealism Effect llci ulci;
cards;
-2.5343	0.6719	0.2722	1.0716
-2.2809	0.6350	0.2690	1.0010
-2.0275	0.5981	0.2650	0.9312
-1.7742	0.5612	0.2603	0.8622
-1.5208	0.5243	0.2543	0.7943
-1.2674	0.4874	0.2467	0.7281
-1.0140	0.4505	0.2368	0.6642
-0.7606	0.4136	0.2236	0.6036
-0.5072	0.3767	0.2057	0.5476
-0.2538	0.3398	0.1816	0.4980
-0.0004	0.3029	0.1494	0.4563
0.2529	0.2660	0.1086	0.4233
0.5063	0.2291	0.0598	0.3984
0.7597	0.1922	0.0044	0.3800
0.7788	0.1894	0.0000	0.3788
1.0131	0.1553	-0.0558	0.3664
1.2665	0.1184	-0.1195	0.3562
1.5199	0.0815	-0.1855	0.3484
1.7733	0.0446	-0.2532	0.3423
2.0267	0.0076	-0.3221	0.3374
2.2800	-0.0293	-0.3919	0.3333
2.5334	-0.0662	-0.4623	0.3300
proc sgplot;
series x=Idealism y=ulci/curvelabel = '95% Upper Limit' lineattrs=(color=red pattern=ShortDash);
series x=Idealism y=effect/curvelabel = 'Point Estimate' lineattrs=(color=blue pattern=Solid);
series x=Idealism y=llci/curvelabel = '95% Lower Limit' lineattrs=(color=red pattern=ShortDash);
xaxis label = 'Standardized Idealism';
yaxis label = 'Conditional Effect of Misanthropy';
refline 0/axis=y transparency=0.3;
refline .7788/axis=x transparency=0.3; run;
