CREATE EXTERNAL TABLE `raw.la_cupula`(
  `fecha reporte` string, 
  `fecha venta` string, 
  `country` string, 
  `currency` string, 
  `units` bigint, 
  `bruto eur` string, 
  `neto eur` string, 
  `channel` string, 
  `display_artist` string, 
  `release` string, 
  `upc` string, 
  `track` string, 
  `isrc` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/la_cupula/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='la_cupula', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='117', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='8327', 
  'sizeKey'='974260', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')

-- LA CUPULA

-- VENTAS DIGITALES

-- Inferir todo
-- en vez de tener paises

