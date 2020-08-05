$job sas
$mdisk 192 karl pswuensc
options ls=78 formdlim='-';
proc format; value mat 1='Monogamous' 2='Polygynous' 3='Promiscuous';
data voles; input mating body testis @@;
label body='M/F body length ratio'   testis='testis length/body length';
x1=1; if mating = 2 then x1 = -2;
x2=0; if mating = 1 then x2 = 1; if mating = 3 then x2 = -1;
x3=1; if mating = 3 then x3 = -2;
x4=0; if mating = 1 then x4 = 1; if mating = 2 then x4 = -1;
format mating mat.;  cards;
1 1.01 .11  1 0.98 .09  2 1.05 .06  2 1.05 .07  2 1.04 .08
3 1.05 .12  3 1.01 .10  3 1.04 .11  3 0.99 .12  3 0.99 .14
3 0.99 .10  3 1.02 .11  3 0.96   .  3 0.97 .13  3 1.00   .
3 0.93 .12  3 0.97 .11
proc reg simple corr; model body = x1 x2 / ss1 ss2;
proc glm; class mating; model body=mating;
contrast 'Poly vs Mono, Prom' mating 1 -2 1;
contrast 'Mono vs Prom' mating 1 0 -1;
means mating / snk;
proc reg simple corr; model testis = x3 x4 / ss1 ss2;
proc glm; class mating; model testis=mating;
contrast 'Prom vs Mono, Poly' mating 1 1 -2;
contrast 'Mono vs Poly' mating 1 -1 0;  means mating / snk;
proc npar1way wilcoxon;class mating; var body testis;
