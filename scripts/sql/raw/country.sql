CREATE EXTERNAL TABLE raw.`country`(
  `country` string, 
  `iso_code` string, 
  `country_corrected` string, 
  `continent` string, 
  `zone` string, 
  `language` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/country'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='metadata_countries', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='54', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='469', 
  'sizeKey'='25344', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1645477628', 
  'typeOfData'='file')