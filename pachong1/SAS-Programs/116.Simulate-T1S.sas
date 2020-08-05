options pageno=min nodate formdlim='-';
/* Obtain a random sample of NUM=10 scores from a normally distributed population with mean 1, standard deviation 1.
   Conduct t test of null that mean = 0.  Cohen's d = 1.
You may manipulated the value of Cohen's d by altering the value of M.
   You may manipulate the value of sample size by altering the value of NUM.
*/
DATA ECU;
M=1;SD=1; NUM=10;
DO K=1 TO NUM; Y=M+SD*NORMAL(0); KEEP Y;OUTPUT;END;
proc print; run;
PROC means data=ECU mean std t prt clm; VAR Y; run;
