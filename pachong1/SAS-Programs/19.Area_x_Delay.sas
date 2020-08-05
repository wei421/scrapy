*** Area_x_Delay.sas ***;
options pageno=min nodate formdlim='-';
TITLE '2-WAY, EQUAL NS, INDEPENDENT SAMPLES ANOVA';
title2 'Howell''s Methods Text, 7th edition, page 456'; run;
DATA KLW;
INPUT AREA DELAY LATENCY @@; CARDS;
0 50 25   0 50 30   0 50 28   0 50 40   0 50 20
0 100 30  0 100 25  0 100 27  0 100 35  0 100 23
0 150 28  0 150 31  0 150 26  0 150 20  0 150 35
1 50 11   1 50 18   1 50 26   1 50 15   1 50 14
1 100 31  1 100 20  1 100 22  1 100 23  1 100 19
1 150 23  1 150 28  1 150 35  1 150 27  1 150 21
2 50 23   2 50 30   2 50 18   2 50 28   2 50 23
2 100 18  2 100 24  2 100  9  2 100 16  2 100 13
2 150 28  2 150 21  2 150 30  2 150 30  2 150 23
Proc GLM; class area delay; model latency = area|delay / ss1; means area|delay;
 LSMEANS area*delay / SLICE=area; run;
*NOTE:  Type I sums of squares requested because cell sizes are equal;
Proc Sort; By Area;
Proc ANOVA; Class Delay; Model Latency = Delay; Means Delay / LSD lines; By Area;
 Title 'Pairwise comparisons at each level of area'; run;
********************************************************************************
Construct Confidence Interval for Eta-Squared for Area -- used Proc ANOVA to get the adjusted F
 with effects of delay and the interaction put in the error term.
*******************************************************************************;
title 'Confidence Interval on Eta-Squared for Area'; run;
proc ANOVA; class area; model latency=area; run;
Data CI_A;
F= 4.63   ;
df_num = 2 ;
df_den = 42;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.90));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.10));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; run;
********************************************************************************
Construct Confidence Interval for Eta-Squared for Delay -- used Proc ANOVA to get the adjusted F
 with effects of area and the interaction put in the error term.
*******************************************************************************;
title 'Confidence Interval on Eta-Squared for Delay'; run;
proc ANOVA data=klw; class delay; model latency=delay; run;
Data CI_D;
F= 2.22   ;
df_num = 2 ;
df_den = 42;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.90));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.10));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; run;
********************************************************************************
Construct Confidence Interval for Eta-Squared for Interaction (had to adjust F by hand).
From the factorial ANOVA, add to the error SS (1055.2) the SS for area (356.04) and delay (188.58),
so pooled error SS = 1599.82.
Add to the error df (36) the df for area (2) and delay (2), so pooled error df = 40.
Adjust F(4, 40) = 92.99/(1599.82/40) = 2.325
*******************************************************************************;
title 'Confidence Interval on Eta-Squared for Interaction'; run;
Data CI_Interaction;
F= 2.325   ;
df_num = 4 ;
df_den = 40;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.90));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.10));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; run;
********************************************************************************
Construct Confidence Interval for Simple Main Effect of Delay, Area = 0,
using individual error F and df provided with LSD tests above.
*******************************************************************************;
Data CI_Area0;
F= .02   ;
df_num = 2 ;
df_den = 12;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.90));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.10));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; 
title 'Confidence Interval on Eta-Squared for Delay at Area 0'; run;
Data CI_Area1;
F= 4.53   ;
df_num = 2 ;
df_den = 12;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.90));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.10));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; 
title 'Confidence Interval on Eta-Squared for Delay at Area 1'; run;
Data CI_Area2;
F= 6.42   ;
df_num = 2 ;
df_den = 12;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.90));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.10));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; 
title 'Confidence Interval on Eta-Squared for Delay at Area 2'; run;




