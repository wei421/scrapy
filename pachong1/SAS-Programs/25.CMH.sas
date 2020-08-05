options formdlim='-' pageno=min nodate;
data B_F; input Dept $ Sex $ Decision $ freq;
cards;
B M A 353
B M R 207
B F A 17
B F R 8
C M A 120
C M R 205
C F A 202
C F R 391
D M A 138
D M R 279
D F A 131
D F R 244
E M A 53
E M R 138
E F A 94
E F R 299
F M A 22
F M R 351
F F A 24
F F R 317
proc freq; tables Dept * Sex * Decision / CMH nopercent nocol rrisk; weight freq; run;
Data B_F_Aggregated; input Sex $ Decision $ freq; cards;
M A 686
M R 1180
F A 508
F R 1259
proc freq; tables Sex * Decision / Chisq nopercent nocol rrisk; weight freq; run;
Data A_F; input Dept $ Sex $ Decision $ freq; cards;
A M A 512
A M R 313
A F A 89
A F R 19
B M A 353
B M R 207
B F A 17
B F R 8
C M A 120
C M R 205
C F A 202
C F R 391
D M A 138
D M R 279
D F A 131
D F R 244
E M A 53
E M R 138
E F A 94
E F R 299
F M A 22
F M R 351
F F A 24
F F R 317
proc freq; tables Dept * Sex * Decision / CMH nopercent nocol rrisk; weight freq; run;
Data A_F_Aggregated; input Sex $ Decision $ freq; cards;
M A 1198
M R 1493
F A 597
F R 1278
proc freq; tables Sex * Decision / Chisq nopercent nocol rrisk; weight freq; run;

