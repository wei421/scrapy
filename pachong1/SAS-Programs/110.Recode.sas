options ls=78;
title 'Example of use of array to recode numeric value to missing.'; run;
data recode; input a b c d e f g h i j @@;
array karl a -- j; do over karl; if karl = 99 then karl = .; end; cards;
0 1 2 3 4 5 6 7 8 99   0 1 2 3 4 5 6 7 99 9   0 1 2 3 4 5 6 99 8 9
0 1 2 3 4 5 99 7 8 9   0 1 2 3 4 99 6 7 8 9   0 1 2 3 99 5 6 7 8 9
0 1 2 99 4 5 6 7 8 9   0 1 99 3 4 5 6 7 8 9   0 99 2 3 4 5 6 7 8 9
proc print; var a -- j; run;
