$JOB SAS MACRO
$MDISK 192 karl pswuensc
OPTIONS DQUOTE ls=78;
%MACRO REL;
DO K=1 TO 10000; T=INT(50+10*NORMAL(0));
X1=INT(T + SDE*NORMAL(0));  X2=INT(T + SDE*NORMAL(0));
OUTPUT;END;
PROC corr; var t x1 x2;
%MEND REL;
data r99; SDE=1; title 'error variance = 1, reliability = .990'; %REL
data r92; sde=3; title 'error variance = 9, reliability = .917'; %REL
data r80; sde=5; title 'error variance = 25, reliability = .800'; %REL
data r67; sde=7; title 'error variance = 49, reliability = .671'; %REL
data r55; sde=9; title 'error variance = 81, reliability = .552'; %REL
