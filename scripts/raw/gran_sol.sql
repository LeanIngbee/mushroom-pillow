CREATE EXTERNAL TABLE `raw.gran_sol`(
  `referencia` string, 
  `ean` bigint, 
  `titulo` string, 
  `stock.ini.total` bigint, 
  `entradas` bigint, 
  `ajustes` bigint, 
  `ventas` bigint, 
  `devoluciones` bigint, 
  `primas` bigint, 
  `promos` bigint, 
  `stock depóstio` string, 
  `stock.fin.total` bigint, 
  `stock defectuoso` string, 
  `stock fin recup.` string, 
  `stock.fin. disponible` string, 
  `precio lista` string, 
  `u.antes dev.` bigint, 
  `u.post. dev.` bigint, 
  `bruto venta` string, 
  `dto. venta` string, 
  `bruto devols.` string, 
  `dto. devols` string, 
  `cargos/abonos` string, 
  `neto total` string, 
  `comisión gran sol 25%` string, 
  `ventas netas sello` string, 
  `cod año - mes` string, 
  `cd/lp` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/gran_sol/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='gran_sol', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='223', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='5071', 
  'sizeKey'='1131016', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')


--file	
--report_date -> "Cod Año - MEs" siempre el 1 mas un mes
--sale_date -> "Cod Año - Mes" siempre el 1
--quantity -> "U. post. dev"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "neto total"
--net_revenue	-> "ventas netas sello"
--product_id	-> "Referencia"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Physical Store" matchear con plataforma_corregida
--"source"	-> GRAN_SOL
--country	-> 'Spain'
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- CURRENCY TYPE EUR