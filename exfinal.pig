GDELTRecords= LOAD '$input' USING PigStorage('\t') AS (
EventId:int,
Day:int,
MonthYear:int,
Year:int,
FractionDate:int,
Actor1Code:chararray,
Actor1Name:chararray,
Actor1CountryCode:chararray,
Actor1KnownGroupCode:chararray,
Actor1EthnicCode:chararray,
Actor1Religion1Code:chararray,
Actor1Religion2Code:chararray,
Actor1Type1Code:chararray,
Actor1Type2Code:chararray,
Actor1Type3Code:chararray,
Actor2Code:chararray,
Actor2Name:chararray,
Actor2CountryCode:chararray,
Actor2KnownGroupCode:chararray,
Actor2EthnicCode :chararray,
Actor2Religion1Code:chararray,
Actor2Religion2Code:chararray,
Actor2Type1Code:chararray,
Actor2Type2Code:chararray,
Actor2Type3Code:chararray,
IsRootEvent:int,
EventCode:chararray,
EventBaseCode:chararray,
EventRootCode:chararray,
QuadClass:int,
GoldsteinScale:int,
NumMentions:int,
NumSources:int,
NumArticles:int,
AvgTone:int,
Actor1Geo_Type:int,
Actor1Geo_FullName:chararray,
Actor1Geo_CountryCode:chararray,
Actor1Geo_ADM1Code:chararray,
Actor1Geo_Lat:int,
Actor1Geo_Long:int,
Actor1Geo_FeatureID:int,
Actor2Geo_Type:int,
Actor2Geo_FullName:chararray,
Actor2Geo_CountryCode:chararray,
Actor2Geo_ADM1Code:chararray,
Actor2Geo_Lat:int,
Actor2Geo_Long:int,
Actor2Geo_FeatureID:int,
ActionGeo_Type:int,
ActionGeo_FullName:chararray,
ActionGeo_CountryCode:chararray,
ActionGeo_ADM1Code:chararray,
ActionGeo_Lat:int,
ActionGeo_Long:int,
ActionGeo_FeatureID:int,
DATEADDED:chararray,
SOURCEURL:chararray);

Records= GROUP GDELTRecords2 BY ActionGeo_CountryCode;

USINDIARECORDS = FILTER GDELTRecords2 BY (ActionGeo_CountryCode MATCHES 'IN|US');

groupset= GROUP USINDIARECORDS BY (ActionGeo_CountryCode, MonthYear);

numofevents = FOREACH groupset  GENERATE group, COUNT(USINDIARECORDS) AS soma;

TOP10 = LIMIT numofevents 10;

STORE TOP10 INTO 'myoutputex' USING PigStorage ('\t') ;

