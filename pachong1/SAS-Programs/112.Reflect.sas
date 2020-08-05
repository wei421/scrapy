options formdlim='-'; title 'Reflecting a Variable';
data sol; input (A1-A5)(1.);
mean=mean(of a1-a5); min=min(of a1-a5); max=max(of a1-a5);
n=n(of a1-a5); skew=skewness(of a1-a5); var=var(of a1-a5); cards;
12345
11114
14555
12355
22334
proc print; title 'Here are the data prior to reflecting.'; run;
data refl; set sol;
array reflect a1-a5; do over reflect;
reflect=6-reflect; end;
mean=mean(of a1-a5); min=min(of a1-a5); max=max(of a1-a5);
n=n(of a1-a5); skew=skewness(of a1-a5); var=var(of a1-a5); cards;
proc print; title 'Here are the data after reflecting.'; run;
