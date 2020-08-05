options pageno=min nodate formdlim='-';
data logit;
input Verdict 1 Gender 2 Pla_Attr 3 Def_Attr 4 count 5-6;
cards;
1111 7
111217
112113
112210
121116
121217
122115
122215
211113
2112 6
2121 7
212210
2211 6
2212 4
2221 5
2222 5
proc catmod;
weight count;
model Verdict*Gender*Pla_Attr*Def_Attr = _response_;
Loglin Verdict Verdict*Gender Verdict*Pla_Attr Verdict*Def_Attr
  Verdict*Gender*Pla_Attr Verdict*Gender*Def_Attr Verdict*Pla_Attr*Def_Attr
  Verdict*Gender*Pla_Attr*Def_Attr; run;
proc catmod;
weight count;
model Verdict*Gender*Pla_Attr*Def_Attr = _response_;
Loglin Verdict Verdict*Gender Verdict*Pla_Attr*Def_Attr; run;
