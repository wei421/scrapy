options formdlim='-';
title 'Example of merging two files with data from same subjects';
title2 'at different times.  First, use Xedit to get the time2 data at';
title3 'the bottom of the time1 data in one file, as I have following';
title4 'the cards statement here.'; run;
data orig; input time 1 id 3-4 x1 6 (x2-x5) (1.); cards;
1 02 10234
1 01 01234
1 03 01324
1 04 01243
1 05 01235
1 06 98765
2 05 56789
2 04 65789
2 03 56879
2 02 56798
2 01 65879
proc print;
/*     <><><><><><><><><><><><><><><><><><><><><><><><><><><><><>    */
data pre post; set orig;
 if time=1 then output pre; if time=2 then output post;
 proc sort data=pre; by id; proc sort data=post; by id;
 proc print data=pre;
title 'Partition the data into pre versus post and within each sort by';
title2 'subject id preparatory to merging';  proc print data=post;
/*     <><><><><><><><><><><><><><><><><><><><><><><><><><><><><>    */
data post; set post; by id;
 array oldname x1-x5; array newname post1-post5;
 do over oldname; newname=oldname; end; drop x1-x5; proc print;
title 'change the variable names for the post data prior to merging';
/*     <><><><><><><><><><><><><><><><><><><><><><><><><><><><><>    */
data combined; merge pre post; by id;
 array pre x1-x5; array post post1-post5; array diff d1-d5;
 do over diff; diff=post-pre; end;  proc print;
title 'Merge the data so that each subject has pre and post scores';
title2 'You could now write the data into a new data file, analyze them, etc.';
run;
