--VENTAS WEB NUEVA (SHOPPIFY)
CREATE EXTERNAL TABLE `raw.ventas_web_nueva`(
  `order id` string, 
  `sale id` string, 
  `date` string, 
  `order` string, 
  `transaction type` string, 
  `sale type` string, 
  `sales channel` string, 
  `pos location` string, 
  `billing country` string, 
  `billing region` string, 
  `billing city` string, 
  `shipping country` string, 
  `shipping region` string, 
  `shipping city` string, 
  `product type` string, 
  `product vendor` string, 
  `product` string, 
  `variant` string, 
  `variant sku` string, 
  `net quantity` bigint, 
  `gross sales` string, 
  `discounts` string, 
  `returns` string, 
  `net sales` string, 
  `shipping` string, 
  `taxes` string, 
  `total sales` string)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/ventas_web_nueva/'
TBLPROPERTIES (
  'CrawlerSchemaDeserializerVersion'='1.0', 
  'CrawlerSchemaSerializerVersion'='1.0', 
  'UPDATED_BY_CRAWLER'='ventas_web_nueva', 
  'areColumnsQuoted'='false', 
  'averageRecordSize'='228', 
  'classification'='csv', 
  'columnsOrdered'='true', 
  'compressionType'='none', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'recordCount'='2157', 
  'sizeKey'='491935', 
  'skip.header.line.count'='1', 
  'typeOfData'='file')


--file	
--report_date -> 01-"sale_date"
--sale_date -> "Date" (Sin planchar)
--quantity -> "Net Quantity"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "Total Sales"
--net_revenue	-> "Total Sales" - "Shipping"
--product_id	-> "Variant SKU"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Mushroom Pillow Store Web" matchear con plataforma_corregida
--"source"	-> VENTAS_WEB_NUEVA
--country	-> "Billing Country"
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- EXCHANGE RATE = EUR


