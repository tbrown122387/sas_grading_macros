/*
from:
https://documentation.sas.com/?cdcId=pgmsascdc&cdcVersion=9.4_3.5&docsetId=mcrolref&docsetTarget=n0js70lrkxo6uvn1fl4a5aafnlgt.htm&locale=en

example usage:
%list_files(c:\temp,sas)

*/
%macro list_files(dir,ext);
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
%get_table_size(my_data, answer);

*/
%macro get_table_size(inset,macvar); 
 data _null_; 
  set &inset.; NOBS=size; 
  call symput(&macvar.,size); 
 stop; 
 run; 
%mend; 


/*
Gets a specific cell from a data set

example usage:
%ExtractACell(my_data, 3, colname);

*/

%macro ExtractACell(dataset, rownum=1, var_name=Make); */
data _null_; 
	set &dataset. (obs=&rownum. firstobs=&rownum. keep = &var_name.);	/
	call symputx(storage_var, &var_name., "G"); 
    stop;
run;
%mend ExtractACell;



/* 
prints success if somethign is true, and prints fail otherwise
*/
%macro print_res(tOrFalse);
    %if &tOrFalse = 1 %then %do;
        %put "--------------------------------------------------------\n success!";
    %else %do;
        %put "--------------------------------------------------------\n fail";
    %end;
%mend;
