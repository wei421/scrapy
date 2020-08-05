options pageno=min nodate formdlim='-';
data Escalator;
input Weight Direction Device count;
cards;
1 1 1  10
1 1 2 205
1 2 1  14
1 2 2  81
2 1 1  22
2 1 2 538
2 2 1 143
2 2 2 372
3 1 1  82
3 1 2 998
3 2 1 174
3 2 2 578
proc catmod;
weight count;
model Weight*Direction*Device = _response_;
Loglin Weight Direction Device Weight*Direction Direction*Device Weight*Direction*Device;
run;
quit;
