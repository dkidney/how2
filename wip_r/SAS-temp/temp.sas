
proc import datafile='C:\Documents and Settings\sum3\My Documents\Dropbox\Resources\R\Examples\SAS-temp\inputdata.csv' out=inputdata dbms=csv replace;
proc reg data=inputdata;
    ods output ParameterEstimates=estimates;
    model y = x;
    output out=predictions p=predictions;
proc export data=estimates dbms=csv outfile='C:\Documents and Settings\sum3\My Documents\Dropbox\Resources\R\Examples\SAS-temp\estimates.csv' replace; 
proc export data=predictions dbms=csv outfile='C:\Documents and Settings\sum3\My Documents\Dropbox\Resources\R\Examples\SAS-temp\predictions.csv' replace;
run;
