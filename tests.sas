/* here are some example tests */


/* 
test 1 
test some dimensions
*/
%print_test_name(name=1)
%let rows = %row_count(tablename = someData);
%let cols = %col_count(tablename = someData);
%put &=cols; */
%put &=rows; */
%print_res(val=rows, expec=10000)
%print_res(val=cols, expec=5)

/* 
test 2 
test a particular cell value
*/
%print_test_name(name=2)
%let storage_var = nothing;
%ExtractACell(dataset=someOtherData,rownum=113,var_name=series_id)
%put &=storage_var;
%print_res(val=storage_var, expec=TX.VAL.TRVL.ZS.WT)


/* 
test 3 
something fancier
calculate some summary statistic with sas code
then plug that into a grading macro
*/
%print_test_name(name=3)
data tmp;
	set someData;
	if country_name = "Yemen, Rep." then output;
run;
%let rows = %row_count(tablename = tmp);
%print_res(val=rows, expec=12)

