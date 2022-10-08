CREATE EXTERNAL TABLE raw.`altafonte`(
  `fecha reporte` string, 
  `fecha_consumo` string, 
  `tipo de ingreso` string, 
  `country` string, 
  `isrc` string, 
  `artista` string, 
  `album` string, 
  `track` string, 
  `referencia` string, 
  `suma de cantidad` bigint, 
  `suma de neto altafonte` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/altafonte/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='altafonte', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='94', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='141938', 
  'sizeKey'='13342193', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')