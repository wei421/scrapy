*** ZPF.sas ***;
options pageno=min nodate formdlim='-';
title 'Comparing Correlated but Nonoverlapping Correlations'; run;
data PF; input Pair N AB AX AY BX BY XY;
k = (AX-BX*AB)*(BY-BX*XY)+(AY-AX*XY)*(BX-AX*AB)+(AX-AY*XY)*(BY-AY*AB)+(AY-AB*BY)*(BX-BY*XY);
PF = (AB-XY)*SQRT(N)/SQRT((1-AB**2)**2+(1-XY**2)**2-k);
p_PF = 2*probnorm(-1*ABS(PF));
ZAB = .5*log((1+AB)/(1-AB)); ZXY = .5*log((1+XY)/(1-XY));
ZPF = sqrt((n-3)/2)*(ZAB-ZXY)/sqrt(1-(k/(2*(1-AB**2)*(1-XY**2))));
p_ZPF = 2*probnorm(-1*ABS(ZPF));
*After the cards statement, enter values for Pair number, N, AB, AX, AY, BX, BY, and XY;
CARDS;
1 603 .38 .45 .53 .31 .55 .25
2 10 .645 .756 .707 .952 .947 .980
proc print; var k PF p_PF ZPF p_ZPF; id pair; run;
