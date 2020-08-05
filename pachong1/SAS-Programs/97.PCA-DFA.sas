OPTIONS formdlim='-' pageno=min nodate;
TITLE 'Principal Components Discriminant Function Analysis';
PROC FORMAT; value v 1 = 'Guilty' 2='GBMI' 5='NGRI';
DATA jury;
infile 'D:\StatData\PCA-DFA.dat';
INPUT verdict exptst mentstat attinsan dpvscc attdeath rehabil dewatch prwatch;
FORMAT verdict v. ;
PROC FACTOR OUT=Priapus NFACT=8 METHOD=principal PRIORS=one;
VAR exptst mentstat attinsan dpvscc attdeath rehabil dewatch prwatch;
PROC DISCRIM CAN; CLASS verdict; VAR factor1 - factor8;
DATA CMPSCORE; set Priapus;
df1 = (1.392*factor1)+(-.403*factor2)+(-.346*factor3)+
      (-.035*factor4)+(.231*factor5) + (.032*factor6) +
      (-.261*factor7)+(.012*factor8);
df2 = (.130*factor1)+(.366*factor2)+(.371*factor3)+
      (.556*factor4)+(.566*factor5)+(.082*factor6)+
      (.045*factor7)+(-.492*factor8);
if DF1 = . then delete;
PROC CORR;
VAR df1 df2;
WITH exptst mentstat attinsan dpvscc attdeath rehabil dewatch prwatch;
PROC SORT; BY verdict;
PROC MEANS; VAR df1 df2; BY verdict;
PROC ANOVA; CLASS verdict;
MODEL df1 df2 exptst mentstat attinsan dpvscc attdeath rehabil dewatch prwatch
 = verdict; MEANS verdict / lsd lines;
run;
