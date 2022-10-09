CREATE EXTERNAL TABLE raw.`video`(
  `record label` string, 
  `pname` string, 
  `artist name` string, 
  `video title` string, 
  `video version` string, 
  `isrc` string, 
  `release year` string, 
  `corresponding audio title` string, 
  `audio_isrc` string, 
  `collection territories included` string, 
  `duration (in seconds)` string, 
  `country of recording audio` string, 
  `country of recording video` string, 
  `% rights` string, 
  `product_id` string, 
  `upc` string, 
  `album agrupado` string, 
  `publisher` string, 
  `release year2` string, 
  `p line` string, 
  `productor` string, 
  `escritor` string, 
  `col22` string, 
  `col23` string, 
  `kobalt` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/video'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='metadata', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='245', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='187', 
  'sizeKey'='46003', 
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1645987941', 
  'typeOfData'='file')