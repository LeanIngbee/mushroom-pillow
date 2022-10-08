CREATE EXTERNAL TABLE raw.`operation_type`(
  `operation_type` string, 
  `operation_type_std` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/operation_type'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='metadata', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='25', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='57', 
  'sizeKey'='1449', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1647543948', 
  'typeOfData'='file')