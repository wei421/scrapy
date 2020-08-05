*******     If_Then.sas     *******;
options formdlim='-' pageno=min nodate;
title 'Missing values are coded with extreme negative numbers within SAS';
title2 'Keep this in mind when recoding values';
data Oops; input ID $ X @@;
If X > 5 then Group = 2;
Else if X LE 5 then Group = 1;
cards;
a 1 b 2 c 3 d . e 5 f 6 g 7 h . i 9 j 10
proc print; run;
*You wanted cases with X values 1 through 5 to be in Group 1, values 6 through 10 in Group 2.';
*Look what happened to cases where there was missing data on X -- they were assigned to Group 1.;
data Ahah; input ID $ X @@;
If X > 5 then Group = 2;
Else if 0 < X LE 5 then Group = 1;
cards;
a 1 b 2 c 3 d . e 5 f 6 g 7 h . i 9 j 10
proc print; run;
*Here cases with missing data on X are not assigned to either Group.;
