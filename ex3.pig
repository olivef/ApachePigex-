WIKIPEDIARECORDS= LOAD 's3://' USING PigStorage(' ') AS (site:chararray, page:chararray, views:int, totalbytes:int);
DBPEDIARECORDS= LOAD '' USING PigStorage('\t') AS (page:chararray, url:chararray, category:chararray, flag:chararray);
JOINALIAS = JOIN WIKIPEDIARECORDS by $1, DBPEDIARECORDS2 by $0;
STORE JOINALIAS INTO 'myoutputex3' USING PigStorage ('\t'); 
/*
cat myoutputex3
*/