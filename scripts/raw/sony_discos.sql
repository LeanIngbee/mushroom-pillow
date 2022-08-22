CREATE EXTERNAL TABLE `raw.sony_discos`(
  `rec. #` bigint, 
  `n� de cuenta` string, 
  `nombre de la cuenta simple` string, 
  `n� de cuenta/contrato` string, 
  `nombre de la cuenta` string, 
  `fin per�odo` bigint, 
  `booking text` string, 
  `nombre del artista` string, 
  `t�tulo del producto` string, 
  `nombre del tema` string, 
  `numero de producto` string, 
  `territorio de venta` string, 
  `configuration` string, 
  `per�odo` string, 
  `canal de distribuci�n` string, 
  `clave de proveedor` string, 
  `categor�a de precio` string, 
  `base de liquidaci�n` string, 
  `% ded. cto` bigint, 
  `precio` string, 
  `% royalty` string, 
  `% part` string, 
  `unidades a pagar` bigint, 
  `royalty a pagar` string, 
  `participaci�n en el contrato` bigint, 
  `canal` string, 
  `proveedor` string, 
  `grupo de soportes` string, 
  `track number` string, 
  `artista del tema` string, 
  `royalties contract share %` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/sony_discos/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='sony_discos', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='385', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='16', 
  'recordCount'='103686', 
  'sizeKey'='40132724', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')