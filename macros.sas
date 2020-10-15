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

