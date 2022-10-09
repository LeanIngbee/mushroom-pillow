CREATE EXTERNAL TABLE raw.`product_id_mapping`(
  `isrc` string, 
  `song_name` string, 
  `song_name_std` string, 
  `album_std` string, 
  `artist_std` string, 
  `product_id` string, 
  `track agrupado` string, 
  `upc` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/product_id_mapping'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='metadata', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='55', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='6254', 
  'sizeKey'='343990', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1645994236', 
  'typeOfData'='file')