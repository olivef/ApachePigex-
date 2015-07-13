WIKIPEDIARECORDS1= LOAD 's3://xxxx/wikistats/' USING PigStorage(' ') AS (site:chararray, page:chararray, views:int, totalbytes:int);

swedishresults = FILTER WIKIPEDIARECORDS1 BY site != 'sv';

special = filter swedishresults by page matches 'Special:.*';

SPLIT swedishresults INTO special IF page matches 'Special:.*', swedishresultsminusspecial OTHERWISE;

groupedwikipediarecords= GROUP swedishresultsminusspecial BY  page;

sum = FOREACH  groupedwikipediarecords GENERATE group, SUM(swedishresultsminusspecial.views) AS soma;

ORDEREDSUM =  ORDER sum BY soma DESC;

TOP10 = LIMIT ORDEREDSUM 10;
