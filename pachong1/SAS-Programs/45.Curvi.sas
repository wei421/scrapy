*CURVI.sas;
options pageno=min nodate formdlim='-';
title 'Curvilinear Regression, Ladybugs'; run;
data ladybugs; input temperature free @@;
temp2 = temperature*temperature; temp3 = temperature**3;
temp4 = temperature**4;cards;
-2 13  -1 15  0 12  0 13  1 13  1 15  1 16  2 11  2 12  2 13  2 15
3 11 3 12  3 12  3 15  3 16  4 12  4 15  4 19  5 14  6 14  7 12
10 12  10 13  11 17  14 10  15 15  17 11  17 13  19 16  21 16
22 17  25 19  27 18  30 25  32 24  32 29  33 32  33 35  34 28
proc reg plot=none; var free temperature temp2 temp3 temp4;
LINEAR: model free = temperature; plot r.*p.; run;
QUARTIC: model free = temperature temp2 temp3 temp4 / ss1 scorr1(seqtests);run;
 TEST temp2=0, temp3=0, temp4=0; Title 'Quadratic, Cubic, & Quartic'; run;
 TEST temp3=0, temp4=0; Title 'Cubic & Quartic'; run; Title;
QUADRATIC: model free = temperature temp2 / ss1 scorr1(seqtests);
CUBIC: model free = temperature temp2 temp3 / ss1 scorr1(seqtests);
 run; quit;
 proc sgplot; scatter x = Temperature y = Free; reg x = Temperature y = Free;
 yaxis label='Ladybugs Free' grid values=(0 to 40 by 5);
 xaxis label='Temperature' grid values=(-5 to 40 by 4); Title 'Linear'; run;
proc sgplot; scatter x = Temperature y = Free; reg x = Temperature y = Free / degree=2;
 yaxis label='Ladybugs Free' grid values=(0 to 40 by 5);
 xaxis label='Temperature' grid values=(-5 to 40 by 4); Title 'Quadratic'; run;
 proc sgplot; scatter x = Temperature y = Free; reg x = Temperature y = Free / degree=3;
 yaxis label='Ladybugs Free' grid values=(0 to 40 by 5);
 xaxis label='Temperature' grid values=(-5 to 40 by 4); Title 'Cubic'; run;
*********Obtain Confidence Interval for Eta-Squared**********;
Data eta2;
  F= 74.50  ;
df_num = 3  ;
df_den = 36  ;
ncp_lower = MAX(0,fnonct (F,df_num,df_den,.95));
ncp_upper = MAX(0,fnonct (F,df_num,df_den,.05));
eta_squared = df_num*F/(df_den + df_num*F);
eta2_lower = ncp_lower / (ncp_lower + df_num + df_den + 1);
eta2_upper = ncp_upper / (ncp_upper + df_num + df_den + 1);
output; run; proc print; var eta_squared eta2_lower eta2_upper; run;

