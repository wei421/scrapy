*** ANOVA3.sas ***;
options pageno=min nodate formdlim='-';
proc format; value EX 1='Inexperienced' 2='Experienced';
value R 1='First Class' 2='Second Class' 3='Dirt';
value T 1='Day' 2='Night';
*** Create Macro for Confidence Intervals ***;
%macro CIt;
d = t/sqrt(n1*n2/(n1+n2));
ncp_lower = TNONCT(t,df,.975);
ncp_upper = TNONCT(t,df,.025);
d_lower = ncp_lower*sqrt((n1+n2)/(n1*n2));
d_upper = ncp_upper*sqrt((n1+n2)/(n1*n2));
output; run; proc print; var g d_lower d_upper; run;
%mend CIt;
*** 3-WAY, INDEPENDENT SAMPLES ANOVA -- Howell, 7th edition, page 448 ***;
DATA drive;
INPUT Experience Road Time; DO I = 1 TO 4; INPUT Corrections @@; OUTPUT; END;
format Experience EX. Road R. Time T.; 
CARDS;
1 1 1
4 18 8 10
1 2 1
23 15 21 13
1 3 1
16 27 23 14
1 1 2
21 14 19 26
1 2 2
25 33 30 20
1 3 2
32 42 46 40
2 1 1
6 4 13 7
2 2 1
2 6 8 12
2 3 1
20 15 8 17
2 1 2
11 7 6 16
2 2 2
23 14 13 12
2 3 2
17 16 25 12
PROC GLM; CLASS Experience Road Time;
 MODEL Corrections = Experience|Road|Time / EFFECTSIZE alpha=0.1 ss1;
 MEANS Experience|Road|Time;
 LSMEANS Experience*Time / slice = Time;
Title 'Omnibus ANOVA and Simple Effects of Experience at Each Level of Time, Pooled Error'; run;
******************************************************************************;
PROC SORT; BY Time;
PROC GLM; CLASS Experience Road; MODEL Corrections = Experience|Road / ss1 EFFECTSIZE alpha=0.1 ; BY Time;
title 'Simple effects at levels of Time, Individual Error.'; run;
proc means NWAY noprint; class Experience Time; var Corrections;
 output out=ExT mean= ;
proc plot; plot Corrections*Experience=Time;run;
Proc gplot; 
symbol1 interpol=join width=4 value=triangle height=2 color=red;
symbol2 interpol=join width=4 value=square height=2 color=gray;
plot Corrections*Experience=Time / haxis=1 to 2 by 1;
title 'Figure 1. Mean Corrections by Experience and Time';
run;
********************************************************************************;
data p;
 F_Day = 1-PROBF(1.42, 2, 36); F_Night = 1-PROBF(3.49, 2, 36);
proc print; Title 'P values for Simple Interactions using pooled error'; run;
*****************************************************************************;
title 'Simple interactions at levels of Time.'; run;
proc means data=drive NWAY noprint; class Experience Road; var Corrections;
 output out=ExR mean= ; by Time;
proc plot; plot Corrections*Experience=Road / VAXIS=5 10 15 20 25 30 35 40; By Time; run;
Proc gplot; 
symbol1 interpol=join width=4 value=triangle height=2 color=red;
symbol2 interpol=join width=4 value=square height=2 color=green;
symbol3 interpol=join width=4 value=circle height=2 color=brown;
By Time;
plot Corrections*Experience=Road / haxis=1 to 2 by 1;;
title 'Figure 2. Corrections by Experience, Road, & Time'; run;

*****************************************************************************;
* Look at simple, simple main effects of Experience at Road for Time = night;
data night; set drive; if Time = 2;  proc sort; by Road;
proc GLM; class Experience; model Corrections = Experience / EFFECTSIZE alpha=0.1; by Road;
title 'Simple, simple main effects of Experience at Road for Time = night.'; run;
**********************************************************************;
title 'Get t values for estimating d with confidence interval.'; run;
proc ttest data=drive; class experience; var corrections;
proc ttest data=drive; class time; var corrections;
proc ttest data=drive; class experience; var corrections; by time; run;
***********************************************************************;
title 'Estimated d for Experience.';run;
Data CId; t= 4.18; df = 46; n1 = 24; n2 = 24; %CIt
***********************************************************************;
title 'Estimated d for Time of Day.';run;
Data CId; t= 3.33; df = 46; n1 = 24; n2 = 24; %CIt
***********************************************************************;
title 'Estimated d for Experience during the Day.';run;
Data CId; t= 2.44; df =22; n1 = 12; n2 = 12;  %CIt
***********************************************************************;
title 'Estimated d for Experience at Night.';run;
Data CId; t= 4.43; df =22; n1 = 12; n2 = 12; %CIt
*** end of program ***;
