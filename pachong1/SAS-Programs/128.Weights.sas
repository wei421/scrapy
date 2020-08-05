options pageno=min nodate formdlim='-';
title 'ANCOV with Weights Data'; run;
proc format; value gen 1='Female' 2='Male';
data weights;
input gender height weight;
interaction = gender*height;
format gender gen. ;
cards;
  2 70 172
  2 74 130
  1 64 118
  1 62 101
  2 72 165
  2 68 155
  2 69 158
  1 62 105
  2 70 157
  1 65 122
  1 64 145
  1 67 130
  2 66 175
  1 65 110
  1 68 123
  2 72 205
  1 69 140
  1 63 150
  2 73 180
  2 72 165
  1 63 126
  1 62 105
  1 62 120
  2 73 150
  1 65 125
  1 68 133
  1 63 101
  1 68 117
  1 68 118
  2 73 177
  1 64 122
  1 70 130
  2 68 158
  1 67 115
  1 66 130
  1 64 165
  2 73 163
  2 68 165
  2 68 155
  2 71 151
  1 62 121
  1 64 108
  1 64 118
  1 60 126
  2 68 168
  2 71 165
  2 72 195
  2 71 130
  1 68 130
proc corr; var gender height weight;
proc ttest; class gender; var height weight;
proc glm; class gender; model weight = height gender interaction / ss1;
title 'Test the interaction term'; run;
proc glm; class gender; model weight= height gender / ss1; 
  means gender; lsmeans gender;
title 'ANCOV with effect of gender adjusted for height'; run;
