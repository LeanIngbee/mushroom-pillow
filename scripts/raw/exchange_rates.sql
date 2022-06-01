CREATE EXTERNAL TABLE `raw.exchange_rates`(
  `date` string COMMENT 'from deserializer', 
  `base` string COMMENT 'from deserializer', 
  `target` string COMMENT 'from deserializer', 
  `rate` double COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.openx.data.jsonserde.JsonSerDe' 
WITH SERDEPROPERTIES ( 
  'paths'='base,date,rate,target') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/exchange_rates/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='exchange_rates', 
  'averageRecordSize'='70', 
  'classification'='json', 
  'compressionType'='none', 
  'objectCount'='39', 
  'recordCount'='157', 
  'sizeKey'='11188', 
  'typeOfData'='file')
