CREATE EXTERNAL TABLE raw.`isrc_mapping`(
  `artist` string, 
  `album` string, 
  `song_name` string, 
  `isrc` string, 
  `artist_std` string, 
  `song_name_std` string, 
  `isrc_std` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/isrc_mapping'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='metadata', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='91', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='3892', 
  'sizeKey'='354247', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1645984987', 
  'typeOfData'='file')