-- se llama ventas_a_tiendas_directas
CREATE EXTERNAL TABLE `raw.ventas_web_antigua`(
  `mp_date` bigint, 
  `mp_ref_id` string, 
  `mp_ref_type` string, 
  `mp_artist` string, 
  `mp_title` string, 
  `mp_quantity` bigint, 
  `mp_amount_pre_tax` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/ventas_web_antigua/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='ventas_web_antigua', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='76', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='138', 
  'sizeKey'='10530', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')


--file	
--report_date -> igual a "sale date"
--sale_date -> 01-01-"Date" (solo tiene el ano)
--quantity -> "MP_Quantity"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "MP_Amount_pre_tax"
--net_revenue	-> "MP_Amount_pre_tax"
--product_id	-> "MP_ref_ID"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Mushroom Pillow Store Web" matchear con plataforma_corregida
--"source"	-> VENTAS_WEB_ANTIGUA
--country	-> 'ESPANA'
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- EXCHANGE RATE EUR
