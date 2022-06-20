CREATE EXTERNAL TABLE `raw.altafonte_ventas_fisicas`(
  `referencia` string, 
  `artista` string, 
  `titulos` string, 
  `ventas` double, 
  `importe` string, 
  `cantidad devoluciones` bigint, 
  `importe devoluciones` string, 
  `cantidad neta` double, 
  `ventas brutas` string, 
  `p. medio` string, 
  `costo distribución` string, 
  `costo devolución` string, 
  `ventas netas` string, 
  `distribuidor` string, 
  `pais` string, 
  `mes` string, 
  `año` bigint, 
  `cd/lp` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/altafonte_ventas_fisicas/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='altafonte_ventas_fisicas', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='141', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='7675', 
  'sizeKey'='1082268', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')

--file	01
--report_date -> "sale_date" + 1 mes
--sale_date -> 01-"MES"-"AÑO"
--quantity -> "Cantidad neta"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "ventas brutas"
--net_revenue	-> "ventas netas"
--product_id	-> "Referencia"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Physical Store" matchear con plataforma_corregida
--"source"	-> ALTAFONTE
--country	-> "País"
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"


