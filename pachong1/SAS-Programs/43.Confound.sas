options pageno=min nodate formdlim='-';
title 'Matching and ANCOV with Confounded Covariate'; run;
data confound;
input gender courses aptitude pair apt1 apt2 diff;
interaction = gender*courses;
cards;
  1  12  66   .  .   .   .
  1  10  64   .  .   .   .
  1   9  57   .  .   .   .
  1   9  53   .  .   .   .
  1   8  53   .  .   .   .
  1   8  50   .  .   .   .
  1   8  47   .  .   .   .

  1   7  43   1  .   .   .
  2   7  52   1  .   .   .
  .   .   .   1  43  52  9

  1   7  47   2  .    .  . 
  2   7  48   2  .    .  .
  .   .   .   2   47  48 1

  1   6  43   3   .   .  .
  2   6  48   3   .   .  .
  .   .   .   3   43  48  5

  1   6  40   4   .   .  .
  2   6  45   4   .   .  .
  .   .   .   4   40  45 5

  1   6  37   5   .   .  .
  2   6  42   5   .   .  .
  .   .   .   5   37  42 5

  1   5  33   6   .   .  .
  2   5  38   6   .   .  .
  .   .   .   6   33  38 5

  1   5  35   7   .   .  .
  2   5  40   7   .   .  .
  .   .   .   7   35  40 5

  1   5  37   8   .   .  .
  2   5  42   8   .   .  .
  .    .   .  8   37  42 5

  1   4  32   9   .   .  .
  2   4  33   9   .   .  .
  .   .   .   9   32  33 1

  1   4  28  10   .   .  .
  2   4  37  10   .   .  .
  .   .   .  10   28  37 9

  2   3  34   .   .   .  .
  2   3  26   .   .   .  .
  2   2  21   .   .   .  .
  2   2  29   .   .   .  .
  2   1  23   .   .   .  .
  2   1  17   .   .   .  .
  2   0  15   .   .   .  .
proc corr; var gender courses aptitude;
proc ttest; class gender; var courses aptitude;
proc means mean stddev n t prt; var apt1 apt2 diff;
proc glm; class gender; model aptitude = courses gender interaction / ss1;
title 'Test the interaction term'; run;
proc glm; class gender; model aptitude = courses gender / ss1; 
  means gender; lsmeans gender;
title 'ANCOV with effect of gender adjusted for number of courses'; run;
