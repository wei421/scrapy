options nocenter nodate nonumber  linesize=100 pagesize=500   formdlim=' ';  title;


/* Velicer's Minimum Average Partial (MAP) Test

   To run this program you need to first specify the data
   for analysis and then select and run, all at once, the commands
   from the "proc iml;" statement to the "quit;" statement.

   There are 3 possible methods of specifying the data
   that will be processed by this program:

   Method 1: Manually enter (type in) a correlation matrix

   Method 2: Have the MAP program read a correlation matrix that was
             previously created by a SAS procedure (e.g., by PROC CORR)

   Method 3: Have the MAP program read a SAS raw data file  */

proc iml;
reset noname;

/*  Specify the data for the analyses: */

/*  Method 1: Manually enter a correlation matrix
    (i.e., type the correlations yourself) directly into the 
    program, as in the example below for Harman's (1967, p 80) data.  
    Make sure to name the correlation matrix "CR", as in the example. */
cr = {
 1.000  .846  .805  .859  .473  .398  .301  .382,
  .846 1.000  .881  .826  .376  .326  .277  .415,
  .805  .881 1.000  .801  .380  .319  .237  .345,
  .859  .826  .801 1.000  .436  .329  .327  .365,
  .473  .376  .380  .436 1.000  .762  .730  .629,
  .398  .326  .319  .329  .762 1.000  .583  .577,
  .301  .277  .237  .327  .730  .583 1.000  .539,
  .382  .415  .345  .365  .629  .577  .539 1.000  }; 


/*  Method 2: You can have the MAP program read a correlation
    matrix that was previously saved by e.g., the PROC CORR procedure, as in: 

    proc corr data = datafilename  outp = work.filename; 

    You must then use the same filename (e.g., 'work.filename')
    on the USE command below, & you must un-comment the following line: */
/* USE work.filename;  read all var _num_ into whole;  cr = whole[4:nrow(whole),]; */


/* Method 3: Have SAS read a raw data file, where the rows are 
   cases & the columns are variables; missing values are not permitted;
   insert the name of your data file in the place of "datafilename" on the
   USE command below, & un-comment the following line: */
/*USE datafilename;  read all var _num_  into raw;*/



/************************ End of user specifications ***********************/

/* computes the correlation matrix, if necessary. */
if (nrow(raw) > 1) then do;
ncases = nrow(raw);
nvars  = ncol(raw);
ones = j(ncases,1,1);
xi1 = ( 1 / ncases) * t(ones);
nm1 = 1 / (ncases-1);
vcv = nm1 * (t(raw)*raw - ((t(raw[+,])*raw[+,])/ncases));
d = inv(diag(sqrt(vecdiag(vcv))));
cr = (d * vcv * d);
end;

/* MAP test computations */
call eigen (eigval,eigvect,cr);
loadings = eigvect * sqrt(diag(eigval));
nvars  = ncol(cr);
fm = j(nvars,2,-9999);
fm[1,2] = (ssq(cr) - nvars)/(nvars*(nvars-1));
fm4 = fm;
fm4[1,2] = (sum(cr##4)-nvars)/(nvars*(nvars-1));
do m = 1 to nvars - 1;
a = loadings[,1:m];
partcov = cr - (a * t(a));
d = diag( 1 / (sqrt(vecdiag(partcov))) );
pr = d * partcov * d;
fm[m+1,2] = (ssq(pr)-nvars) / (nvars*(nvars-1));
fm4[m+1,2] = (sum(pr##4)-nvars)/(nvars*(nvars-1));
end;

/* identifying the smallest fm value & its location (= the of factors) */
minfm = fm[1,2];
nfacts = 0;
minfm4 = fm4[1,2];
nfacts4 = 0;
do s = 1 to nrow(fm);
fm[s,1] = s - 1;
if ( fm[s,2] < minfm ) then do;
minfm = fm[s,2];
nfacts = s - 1;
end;
if ( fm4[s,2] < minfm4 ) then do;
minfm4 = fm4[s,2];
nfacts4 = s - 1;
end;end;

print, "Velicer's Minimum Average Partial (MAP) Test:";
print, "Eigenvalues", eigval[format=12.4];
labels = ("  "||"squared"||"power4");
print,, "Average Partial Correlations", (fm || fm4[,2]) [colname=labels format=f12.4]; 
print, "The smallest average squared partial correlation is", minfm[format=f12.4];
print, "The smallest average 4rth power partial correlation is", minfm4[format=f12.4];
print, "The Number of Components According to the Original (1976) MAP Test is", nfacts[format=f12.4];
print, "The Number of Components According to the Revised (2000) MAP Test is", nfacts4[format=f12.4];

quit;


/* References.
 
  the original MAP test:
  Velicer, W. F. (1976). Determining the number of components 
  from the matrix of partial correlations. Psychometrika, 41, 321-327.
 
  the revised (2000) MAP test i.e., with the partial correlations
  raised to the 4rth power (rather than squared):
  Velicer, W. F., Eaton, C. A., and Fava, J. L. (2000). Construct
  explication through factor or component analysis: A review and 
  evaluation of alternative procedures for determining the number 
  of factors or components. Pp. 41-71 in R. D. Goffin and 
  E. Helmes, eds., Problems and solutions in human assessment
  Boston: Kluwer.
 
  the present programs:
  O'Connor, B. P. (2000). SPSS and SAS programs for determining 
  the number of components using parallel analysis and Velicer's 
  MAP test. Behavior Research Methods, Instrumentation, and
  Computers, 32, 396-402. */
