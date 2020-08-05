Data Two;
*Randomly sample scores for X and Y for two cases;
DO K=1 TO 2; X=NORMAL(0); Y=NORMAL(0); Output; End;
Proc Reg; Model Y = X;
Title 'Two variables, two cases';
run; quit;
Data Three;
*Randomly sample scores for X1, X2, and Y for three cases;
DO K=1 TO 3; X1=NORMAL(0); X2=NORMAL(0);Y=NORMAL(0); Output; End;
Proc Reg; Model Y = X1 X2;
Title 'Three variables, three cases';
Proc Reg; Model Y = X1;
Title 'Two variables, three cases';
run; quit;
Data Four;
*Randomly sample scores for X1, X2, X3, and Y for four cases;
DO K=1 TO 4; X1=NORMAL(0); X2=NORMAL(0); X3=NORMAL(0);Y=NORMAL(0); Output; End;
Proc Reg; Model Y = X1 X2 X3;
Title 'Four variables, four cases';
Proc Reg; Model Y = X1;
Title 'Two variables, four cases';
run; quit;
