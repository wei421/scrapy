options formdlim='-' pageno=min nodate;
* Assign filenames (Demog_In, SophSen_In) to external files;
filename Demog_In 'D:\Research-Misc\Dudley\demogs.txt';
filename SophSen_In 'D:\Research-Misc\Dudley\soph-srData.txt';

/*read in and sort by id SophSen_In;
Truncover prevents SAS from treating next data line as part of current observation
when it encounters a truncated data line*/
data senior_sophomore; infile SophSen_In truncover;
input @1 id 4. @7 (a1-a9)($1.) @16 (b1a b1b b1c b1d b1e)($1.)
	@21 (b2a b2b b2c b2d)($1.) @25 (b3a b3b b3c b3d b3e b3f)($1.)
	@31 (b4a b4b b4c b4d b4e)($1.) @36 (b5a b5b b5c b5d)($1.)
	@40 (c1a c1b c1c c1d c1e c1f c1g c1h c1i c1j c1k c1l c1m c1n)($1.)
	@54 (c2a c2b)($1.) @56 (d1a d1b d1c)($1.) 
	@59 (d2a d2b d2c d2a1 d2b1 d2c1 d2a2 d2b2 d2c2)($1.)
	@68 (d3a d3b d3c)($1.) @71 (d4a d4b d4c)($1.) 
	@74 (d5a d5b d5c)($1.) @77 (d6a d6b d6c)($1.) 
	@80 (d7a d7b d7c)($1.) @83 (d8a d8b)($1.) @85 (d9a d9b)($1.) 
	@87 (d10a d10b)($1.) @89 (e1 e2a e2b e3-e6)($1.)
	@96 f1 $1. @97 (h1-h5)($1.) @102 (i1 i2a i2b i2c i2d i3 i4)($1.)
	@109 j3 $1. @110 cipcod $12. 
	/* end of senior data - leave one blank column */
	@123 (sqa1-sqa9)($1.) @132 (sqb1a sqb1b sqb1c sqb1d sqb1e)($1.)
	@137 (sqb2a sqb2b sqb2c sqb2d sqb2e)($1.)
	@142 (sqb3a sqb3b sqb3c sqb3d sqb3e)($1.)
	@147 (sqb4a sqb4b sqb4c sqb4d)($1.) 
	@151 (sqb5a sqb5b sqb5c sqb5d sqb5e sqb5f)($1.)
	@157 (sqb6a sqb6b sqb6c sqb6d sqb6e)($1.)
	@162 sqb7a $1. @163 (sqc1 sqc2 sqc3)($1.) @166 (sqd1a sqd1b)($1.)
	@168 (sqd2a sqd2b)($1.)
	@170 (sqd3a sqd3b)($1.) @172 (sqd4a sqd4b)($1.)
	@174 (sqd5a sqd5b)($1.) @176 (sqd6a sqd6b)($1.)
	@178 (sqd7a sqd7b)($1.) @180 sqd8a $1. @181 sqd9a $1. @182 sqd10a $1.
	@183 (sqe1-sqe5)($1.) @188 sophsem $3. @191 srsem $3.;
	/* end of soph data */
proc sort; by id; run;

*Read in and sort by id Demog_In;
data demogr; infile Demog_In truncover;
input @1 id 4. @5 high_act_score 6. @11 high_msat_score 6. 
	@17 high_vsat_score 6. @23 prog $20. @43 bmon 2. @45 bday $2. @47 byr 4.
	@51 degr $10. @61 gpa 5.3 @66 hrsearnd 7.2 @73 hrstran 7.2
	@80 race $1. @81 sex $1. @82 cit $1. @83 term $1. @84 year $4.
	@89 advisor;
run;
proc sort; by id; run;

*Merge the two files by id;
data both; merge senior_sophomore demogr; by id; run;

*Inspect the merged data file;
proc contents varnum; run;
proc freq; table advisor; run;


