options pageno=min nodate formdlim='-';
TITLE1 'Stepwise regression'; run;
data grades; infile 'C:\Users\Vati\Documents\StatData\MultReg.dat';
input GPA GRE_Q GRE_V MAT AR;
PROC REG;
a: MODEL GPA = GRE_Q GRE_V MAT AR / STB SCORR2
   selection=forward slentry = .05 details; run;
b: MODEL GPA = GRE_Q GRE_V MAT AR / STB SCORR2
   selection=backward slstay = .05 details; run;
c: MODEL GPA = GRE_Q GRE_V MAT AR / STB SCORR2
   selection=stepwise slentry=.08 slstay = .08 details; run;
d: MODEL GPA = GRE_Q GRE_V MAT AR / selection=rsquare cp mse; run;
e:  MODEL GPA = GRE_Q GRE_V MAT / STB SCORR2; run;
