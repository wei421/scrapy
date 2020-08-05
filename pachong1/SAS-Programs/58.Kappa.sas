options formdlim='-' pageno=min nodate;
proc format; value prob 0='NoProb' 1='Intern' 2='Extern'; run;
data kappa; input judge1 judge2 freq;
format judge1 judge2 prob. ;
cards;
0 0 15
0 1 1
0 2 0
1 0 2
1 1 3
1 2 1
2 0 3
2 1 2
2 2 3
proc freq; tables judge1 * judge2 / agree; test kappa; weight freq; run;

