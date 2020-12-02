/*
from:
https://documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.5&docsetId=mcrolref&docsetTarget=n0js70lrkxo6uvn1fl4a5aafnlgt.htm&locale=en

example usage:

%list_files(/folders/myshortcuts/SASUniversityEdition/myfolders/submissions/, sas)


*/
%macro list_files(dir,ext) / store source;
  %local filrf rc did memcnt name i;
  %let rc=%sysfunc(filename(filrf,&dir));
  %let did=%sysfunc(dopen(&filrf));      

   %if &did eq 0 %then %do; 
    %put Directory &dir cannot be open or does not exist;
    %return;
  %end;

   %do i = 1 %to %sysfunc(dnum(&did));   

   %let name=%qsysfunc(dread(&did,&i));

      %if %qupcase(%qscan(&name,-1,.)) = %upcase(&ext) %then %do;
        %put &dir\&name;
      %end;
      %else %if %qscan(&name,2,.) = %then %do;        
        %list_files(&dir\&name,&ext)
      %end;

   %end;
   %let rc=%sysfunc(dclose(&did));
   %let rc=%sysfunc(filename(filrf));     

%mend list_files;



/*
Gets the size of a table

example usage:
%let rows = %row_count(tablename = sashelp.class);
%put &=rows;
*/
%macro row_count (tablename =) / store source;
  %* OBS method uses SCL to open a table, get the row count, close it and return the row count
     so it works like a function.;
    %local dsid obs; 
    %let dsid = %sysfunc(open(&tablename)); 
    %if &dsid %then %let obs = %sysfunc(attrn(&dsid, nlobs)); 
    %let tmp_varlist = &obs;
    %let dsid = %sysfunc(close(&dsid)); 
    &obs
%mend row_count; 



/*
Gets the number of columns in a table

example usage:
%let cols = %col_count(tablename = sashelp.class);
%put &=cols;
*/

%macro col_count (tablename =) / store source;
  %* OBS method uses SCL to open a table, get the row count, close it and return the row count
     so it works like a function.;
    %local dsid vars; 
    %let dsid = %sysfunc(open(&tablename)); 
    %if &dsid %then %let vars = %sysfunc(attrn(&dsid, nvars)); 
    %let tmp_varlist = &vars;
    %let dsid = %sysfunc(close(&dsid)); 
    &vars
%mend col_count; 


/*
Gets a specific cell from a data set. 
Beware: this is not a function style macro---it sets a global macro variable that might be manipulated before or after the call.

example usage:

%let storage_var = nothing;
%ExtractACell(dataset=derp,rownum=3,var_name=b)
%put &storage_var;
%let storage_var = nothing;

*/
%macro ExtractACell(dataset=, rownum=1, var_name=Make) / store source; 
data _null_; 
	set &dataset. (obs=&rownum. firstobs=&rownum. keep = &var_name.);	
	call symputx("storage_var", &var_name., "G"); 
    stop;
run;
%mend ExtractACell;


/* 
prints success if somethign is true, and prints fail otherwise

example usage:

%let myvar = 3;
%print_res(val=myvar, expec=3)
*/
%macro print_res(val=, expec=) / store source;
    %if &&&val = &&expec %then %do;
        %put "--------------------------------------------------------";
        %put "                 success!                               ";
        %put "--------------------------------------------------------";        
        %end;
    %else %do;
        %put "--------------------------------------------------------";
        %put "                 fail :(                                ";
        %put "--------------------------------------------------------";        
    %end;
%mend;



/* 
prints the name of a test...just for visual separation

example usage:

%print_test_name(name=1)
*/
%macro print_test_name(name=) / store source;
        %put "--------------------------------------------------------";
        %put "                 TEST: &name                            ";
        %put "--------------------------------------------------------";        
%mend;





