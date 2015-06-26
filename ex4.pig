WIKIPEDIARECORDS= LOAD 's3://' USING PigStorage(' ') AS (site:chararray, page:chararray, views:int, totalbytes:int);
swedishresults = FILTER WIKIPEDIARECORDS BY site == 'sv';
special = filter swedishresults by page matches 'Special:.*';
SPLIT swedishresults INTO special IF page matches 'Special:.*', swedishresultsminusspecial OTHERWISE;
STORE swedishresultsminusspecial INTO 'myoutputex4' USING PigStorage ('\t'); 
DUMP swedishresultsminusspecial;
