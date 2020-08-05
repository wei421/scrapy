options formdlim='-';
TITLE 'The Multivariate Approach to a Mixed ANOVA: 1 Within Subjects';
title2 'and one Between Subjects Factor.'; run;
Proc Format; value Mom 1='Mus' 2='Peromyscus' 3='Rattus' ;
data mus; infile 'C:\Users\Vati\Documents\StatData\tunnel4b.dat';
INPUT Nurs V_clean V_Mus V_Pero V_Rat Vt_clean Vt_Mus Vt_Pero Vt_Rat
           T_clean T_Mus T_Pero T_Rat Tt_clean Tt_Mus Tt_Pero Tt_Rat
           L_clean L_Mus L_Pero L_Rat Lt_clean Lt_Mus Lt_Pero Lt_Rat;
Format Nurs Mom. ;
proc sort; by Nurs; proc means;
  var T_clean T_Mus T_Pero T_Rat
      V_clean V_Mus V_Pero V_Rat
      L_clean L_Mus L_Pero L_Rat
      Tt_clean Tt_Mus Tt_Pero Tt_Rat
      Vt_clean Vt_Mus Vt_Pero Vt_Rat
      Lt_clean Lt_Mus Lt_Pero Lt_Rat;
  by Nurs; run;
title;
proc glm; class Nurs; model Tt_clean Tt_Mus Tt_Pero Tt_Rat = Nurs;
  repeated scent 4 contrast(1) / summary printe; means Nurs / LSD; run; quit;
proc glm; model Tt_clean Tt_Mus Tt_Pero Tt_Rat =  / nouni;
  repeated scent 4 contrast(4) / summary; by Nurs;
title 'Simple Effects Analyses of Scent by Level of Nursing Group.'; run; quit;
