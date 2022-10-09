CREATE EXTERNAL TABLE `raw.ventas_a_tiendas_directas`(
  `nº factura asociada` string, 
  `pendiente de facturar` string, 
  `año` bigint, 
  `fecha` string, 
  `cliente` string, 
  `referencia` string, 
  `merch/cd` string, 
  `artista` string, 
  `album` string, 
  `cantidad` string, 
  `pvp` string, 
  `total` string, 
  `tipo de merch` string, 
  `detalle` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/ventas_a_tiendas_directas/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='ventas_a_tiendas_directas', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='114', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='1956', 
  'sizeKey'='223020', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')


--file	
--report_date -> 01-"sale_date"
--sale_date -> "Fecha" (sin planchar)
--quantity -> "Cantidad neta"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "Total"
--net_revenue	-> "Total"
--product_id	-> "Referencia"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Mushroom Pillow Store" matchear con plataforma_corregida
--"source"	-> VENTAS_A_TIENDAS
--country	-> 'ESPANA'
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- EXCHANGE RATE EUR
