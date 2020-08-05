options pageno=min nodate formdlim='-';
title 'One-way MANOVA &  DFA for instructional purposes.';
title2 'Data are from thesis, Michelle Plaster, 1989';
proc format; value attr 1='Beautiful' 2='Average' 3='Unattr';
data sol; infile 'C:\Users\Vati\Documents\_XYZZY\_Stats\StatData\plaster.dat';
input pa crime years serious exciting calm indepen sincere warm phyattr
  sociable kind intellig strong sophist happy ownpa;  format pa attr. ;
z_phyattr = (phyattr - 4.929824) / 3.0619541;
z_happy = (happy - 5.061403) / 2.528720;
z_indepen = (indepen - 6.131578) / 2.494287;
z_sophist = (sophist - 5.0614035) / 2.4505195;
cv1=1.63582926*z_phyattr-0.1512594*z_happy+.0122376*z_indepen+.0965477*z_sophist;
cv2=-0.05808645*z_phyattr+0.70694469*z_happy
  +0.71902789*z_indepen-0.33710555*z_sophist;
proc means; var phyattr happy indepen sophist;
proc anova; class pa; model phyattr happy indepen sophist = pa / nouni;
  manova h = pa / canonical;
proc anova; class pa; model cv1 cv2 phyattr happy indepen sophist = pa;
  means pa / lsd lines;
proc discrim canonical;
class pa; var phyattr happy indepen sophist; run;
