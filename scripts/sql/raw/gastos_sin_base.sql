CREATE EXTERNAL TABLE raw.`gastos_sin_base`(
  `Fecha` string,
  `Importe` string,
  `Detalle` string
)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/gastos_sin_base'
TBLPROPERTIES (
  'classification'='csv', 
  'columnsOrdered'='true', 
  'separatorChar'='\;', 
  'objectCount'='1', 
  'quoteChar'='\"', 
  'skip.header.line.count'='1', 
  'typeOfData'='file'
)