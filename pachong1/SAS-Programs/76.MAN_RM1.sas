options pageno=min nodate formdlim='-';
proc format; value rodent 1='Mus' 2='Pero' 3='Rat';
TITLE 'The Multivariate Approach to One-Way Repeated Measures ANOVA'; run;
data mus; infile 'd:\StatData\tunnel4b.dat';
INPUT NURS V_clean V_Mus V_Pero V_Rat VT_clean VT_Mus VT_Pero VT_Rat
           T_clean T_Mus T_Pero T_Rat TT_clean TT_Mus TT_Pero TT_Rat
           L_clean L_Mus L_Pero L_Rat LT_clean LT_Mus LT_Pero LT_Rat;
format NURS rodent. ;
proc anova; model TT_clean TT_mus TT_pero TT_rat =  / nouni;
repeated scent 4 contrast(1) / summary printe; run;
proc means; var T_clean -- T_Rat;
Title2 'These are means (in seconds) for the untransformed data.'; run;
****************************************************************************;
data multi; input block1-block3; subj = _N_;
B1vsB3 = block1-block3; B1vsB2 = block1-block2; B2vsB3=block2-block3; cards;
10 9 7
8 6 3
7 6 4
5 6 3
11 10 8
15 13 10
proc anova; model block1-block3 = / nouni; repeated block 3 / nom;
title 'Pairwise comparisons'; run;
proc means t prt; var B1vsB3 B1vsB2 B2vsB3; run;
data univ; set multi;
array b[3] block1-block3; do block = 1 to 3;
 errors = b[block]; output; end; drop block1-block3;
proc print; var block errors; id subj;
proc anova; class subj block; model errors = subj block;
 means block / lsd lines; run;
