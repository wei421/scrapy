options formdlim='-' pageno=min nodate;
TITLE '2 GROUP DFA, Harass90 Study'; run;
DATA seckel; INFILE 'C:\Users\Vati\Documents\_XYZZY\_Stats\StatData\harass90.dat'; INPUT  VERDICT $ 6
  D_excit 16 D_calm 17 D_indep 18 D_sincer 19 D_warm 20 D_attrac 21
  D_kind 22 D_intell 23 D_strong 24 D_sophis 25 D_happy 26
  P_excit 28 P_calm 29 P_indep 30 P_sincer 31 P_warm 32 P_attrac 33
  P_kind 34 P_intell 35 P_strong 36 P_sophis 37 P_happy 38;
If verdict = 'Y' then verdic = 1; else verdic = 2;
PROC DISCRIM simple anova canonical listerr;
CLASS verdict; VAR D_excit -- P_happy;
  PRIORS proportional;
PROC REG; MODEL verdic = D_excit -- P_happy / stb; run;
