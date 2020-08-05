ods html close; /* close previous */
ods html; /* open new */

/* In SAS 9.3, the default output is htm, not a plain text listing.  Each time you produce new output,
it is appended to that produced earlier in the session.  You cannot Edit, Clear All as in earlier versions.  This
file, NewViewer, will allow you to deposit new output in a file without the previously generated output.
Just run it when you want to start a file with new output.  The file with the output produced earlier will be closed
and new output will be put in a new file. */
