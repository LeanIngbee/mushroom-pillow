CREATE EXTERNAL TABLE `raw.universal_suecia`(
  `fecha informe` string, 
  `n�mero de producto` string, 
  `n�mero de cat�logo local` string, 
  `nombre del artista` string, 
  `t�tulo` string, 
  `t�tulo del track` string, 
  `pista del artista` string, 
  `per�odo` string, 
  `distribuidor` string, 
  `tipo de producto` string, 
  `tipo de venta` string, 
  `unidades de ventas` bigint, 
  `precio contable` string, 
  `% de royalty` string, 
  `% de participaci�n en el producto` string, 
  `importe de royalties` string, 
  `pa�s` string, 
  `importe de precio base` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/universal_suecia/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='universal_suecia', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='218', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='12326', 
  'sizeKey'='2687269', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')