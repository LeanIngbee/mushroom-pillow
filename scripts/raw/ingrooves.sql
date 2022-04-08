CREATE EXTERNAL TABLE raw.`ingrooves`(
  `period` string COMMENT 'from deserializer', 
  `delivered by` string COMMENT 'from deserializer', 
  `retailer` string COMMENT 'from deserializer', 
  `retailer reporting period` string COMMENT 'from deserializer', 
  `label` string COMMENT 'from deserializer', 
  `artist` string COMMENT 'from deserializer', 
  `album` string COMMENT 'from deserializer', 
  `upc/ean` string COMMENT 'from deserializer', 
  `product / catalog #` string COMMENT 'from deserializer', 
  `song` string COMMENT 'from deserializer', 
  `mix (version)` string COMMENT 'from deserializer', 
  `isrc` string COMMENT 'from deserializer', 
  `genre` string COMMENT 'from deserializer', 
  `release date` string COMMENT 'from deserializer', 
  `retailer stmt country iso` string COMMENT 'from deserializer', 
  `territory` string COMMENT 'from deserializer', 
  `asset type` string COMMENT 'from deserializer', 
  `sales description` string COMMENT 'from deserializer', 
  `sales classification` string COMMENT 'from deserializer', 
  `quantity net` string COMMENT 'from deserializer', 
  `net amount` string COMMENT 'from deserializer', 
  `mechanicals amount net` string COMMENT 'from deserializer', 
  `amount after fees` string COMMENT 'from deserializer', 
  `payment currency` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/ingrooves'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='ingrooves', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='308', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'quoteChar'='\"', 
  'recordCount'='262355', 
  'sizeKey'='80805491', 
  'skip.footer.line.count'='1', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1647287511', 
  'typeOfData'='file')