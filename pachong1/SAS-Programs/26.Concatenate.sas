options formdlim='-' pageno=min nodate;
data harold; input A $ B $;
*Notice that both variables to be concatenated must be declared as alphanumeric;
AB1 = A || B;
*I create the new variable AB1 by concatenating variables A and B;
AB2 = TRIM(A) || TRIM(B);
*I used the TRIM function to remove trailing blanks from A and B before concatenation;
AB3 = TRIM(A) || '--' || TRIM(B);
*I insert characters between A and B; 
cards;
Wise 6588
Wuensch 4102
proc print; var A B AB1 AB2 AB3; run;

