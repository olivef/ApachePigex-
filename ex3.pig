WIKIPEDIARECORDS= LOAD 's3://xxxx/datasets/wikistats/' USING PigStorage(' ') AS (site:chararray, page:chararray, views:int, totalbytes:int);

DBPEDIARECORDS= LOAD 's3://xxxx/datasets/dbpedia/' USING PigStorage('\t') AS (page:chararray, url:chararray, category:chararray, flag:chararray);

JOINALIAS = JOIN WIKIPEDIARECORDS by $1, DBPEDIARECORDS by $0;

STORE JOINALIAS INTO 'myoutput' USING PigStorage ('\t'); 

groupedbycat= GROUP JOINALIAS BY  category;

sum = FOREACH  groupedbycat GENERATE group, SUM(JOINALIAS.views) AS soma;

ORDEREDSUM =  ORDER sum BY soma DESC;

TOP10 = LIMIT ORDEREDSUM 10;

DUMP TOP10;
