/*
This is an example script from where I grade a single submission. 
Unfortunately, there are still some manual aspects to this (E.g. copy/pasting file paths, running a student's submission, etc.)
*/

/* remove everything */
proc datasets library=work kill;
run;

/* read in macros so they are available for use */
%include "~/sas_grading_macros/macros.sas";

/* manually edit filenames then run the script */
/* replace file paths for data sets */
/* then hit the runner icon (I don't think university edition comes with a batch run funcitonality ) */
/* must manually hit the runner guy icon on the student script submission after openining it up*/

/* run the tests (Examine log file output) */
%include "~/sas_grading_macros/tests.sas";

