CREATE EXTERNAL TABLE `raw.kobalt`(
  `agreement_id` string COMMENT 'from deserializer', 
  `batch_id` string COMMENT 'from deserializer', 
  `batch_description` string COMMENT 'from deserializer', 
  `recording_id` string COMMENT 'from deserializer', 
  `recording_title` string COMMENT 'from deserializer', 
  `recording_version_title` string COMMENT 'from deserializer', 
  `isrc` string COMMENT 'from deserializer', 
  `recording_artist` string COMMENT 'from deserializer', 
  `right_type` string COMMENT 'from deserializer', 
  `territory_id` string COMMENT 'from deserializer', 
  `territory` string COMMENT 'from deserializer', 
  `statement_period` string COMMENT 'from deserializer', 
  `royalty_period_start_date` string COMMENT 'from deserializer', 
  `royalty_period_end_date` string COMMENT 'from deserializer', 
  `credit_or_debit` string COMMENT 'from deserializer', 
  `percentage_distributed` string COMMENT 'from deserializer', 
  `pre_wht_source_amount` string COMMENT 'from deserializer', 
  `pre_wht_receipts_amount` string COMMENT 'from deserializer', 
  `wht_percentage` string COMMENT 'from deserializer', 
  `source_amount` string COMMENT 'from deserializer', 
  `received_amount` string COMMENT 'from deserializer', 
  `distributed_amount` string COMMENT 'from deserializer', 
  `source_name` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
  'escapeChar'='\\', 
  'quoteChar'='\"', 
  'separatorChar'=',') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/kobalt'
TBLPROPERTIES (
  'skip.header.line.count'='1', 
  'transient_lastDdlTime'='1660242426'
  "serialization.null.format"=""
  )

--file	
--report_date -> 01-"Statement PEriod"
--sale_date -> ROYALTY_PERIOD_END_DATE (tomar el 01 ingresado el dia)
--quantity -> Mandarle 1
--sale_type ->  "COMUNICACION_PUBLICA"
--gross_revenue	-> "SOURCE_AMOUNT"
--net_revenue	-> "DISTRIBUTED_AMOUNT" (maoxmens 13,5 de diferencia con revenue apra chequear)
--product_id	-> no incluye
--isrc	 -> columna "ISRC" 
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Unknown" (no aplica)
--"source"	-> KOBALT
--country	-> "TERRITORY"
--continent	-> XXXX (CALC)
--agency	-> "BATCH_DESCRIPTION"
--is_licencing	-> false
--operation_type	-> "RIGHT_TYPE" (mapeo con operation_type_mapping) deberian estar si no estan los agregamos
--stream_quality -> "N/A"	