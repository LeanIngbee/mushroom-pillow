CREATE EXTERNAL TABLE `raw.product_types`(
  `Concat` string, 
  `Referencia` string, 
  `Referencia Estandariazada` string, 
  `Ref. Agrupada` string, 
  `EAN` string, 
  `Artista` string, 
  `Album` string, 
  `Fisico/Digital` string, 
  `Formato` string, 
  `Tipo` string, 
  `Fecha de lanzamiento` string, 
  `Album Agrupado` string, 
  `Observaciones` string, 
  `Video` string, 
  `Metadata Audio` string, 
  `Stock Inicial` string, 
  `PVP Online` string, 
  `Antiguedad Catalogo` string, 
  `Tipo Antiguedad ppto` string, 
  `Tipo catalogo` string, 
  `Campaña` string, 
  `Editorial Firmado` string, 
  `Discografico Firmado` string, 
  `Costo unitario` string, 
  `Es licencia o referencia secundaria` string, 
  `col` string, 
  `col25` string, 
  `col26` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/product_types/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='product_types', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='286', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='953', 
  'sizeKey'='272820', 
  'typeOfData'='file',
  'skip.header.line.count'='1')