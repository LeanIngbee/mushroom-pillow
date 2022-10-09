CREATE EXTERNAL TABLE `raw.delorean`(
  `account name` string, 
  `client contract` string, 
  `vendor` string, 
  `period date` string, 
  `sales code` string, 
  `sales code description` string, 
  `analysis code` string, 
  `analysis code description` string, 
  `item sold` string, 
  `territory code` string, 
  `territoryname` string, 
  `region` string, 
  `quantity` bigint, 
  `dealer price` string, 
  `ingresos brutos` string, 
  `cat split %` bigint, 
  `royalty rate (%)` bigint, 
  `reduced royalty (%)` bigint, 
  `ingresos netos` string, 
  `item title` string, 
  `unique id` string, 
  `album code` string, 
  `album artist` string, 
  `track isrc` string, 
  `track name` string, 
  `track artist` string, 
  `sales date` string, 
  `royalty format` string, 
  `cat format` string, 
  `description` string, 
  `album upc` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/delorean/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='delorean', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='297', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='99857', 
  'sizeKey'='29657652', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')