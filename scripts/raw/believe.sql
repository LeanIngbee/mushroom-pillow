CREATE EXTERNAL TABLE raw.`believe`(
  `report_date` string COMMENT 'from deserializer', 
  `sale_date` string COMMENT 'from deserializer', 
  `platform` string COMMENT 'from deserializer', 
  `country` string COMMENT 'from deserializer', 
  `company` string COMMENT 'from deserializer', 
  `artist` string COMMENT 'from deserializer', 
  `album` string COMMENT 'from deserializer', 
  `song` string COMMENT 'from deserializer', 
  `upc` string COMMENT 'from deserializer', 
  `isrc` string COMMENT 'from deserializer', 
  `product_id` string COMMENT 'from deserializer', 
  `publishing_type` string COMMENT 'from deserializer', 
  `operation_type` string COMMENT 'from deserializer', 
  `quantity` string COMMENT 'from deserializer', 
  `currency` string COMMENT 'from deserializer', 
  `unit_price` string COMMENT 'from deserializer', 
  `costs` string COMMENT 'from deserializer', 
  `amount` string COMMENT 'from deserializer', 
  `fee` string COMMENT 'from deserializer', 
  `net_amount` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
  'escapeChar'='\\', 
  'quoteChar'='\"', 
  'separatorChar'='\;', 
  'skip.header.line.count'='1') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/believe'
TBLPROPERTIES (
  'transient_lastDdlTime'='1648647606')