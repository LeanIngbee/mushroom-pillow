CREATE EXTERNAL TABLE raw.`ingresos_sin_base`(
  `Fecha` string,
  `Fuente` string,
  `Pais` string,
  `Tipo de Ingreso` string,
  `Importe Bruto` string,
  `Importe Neto` string,
  `Observaciones` string,
  `Artista` string,
  `Album` string,
  `Track` string,
  `ISRC` string,
  `Referencia` string
)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/ingresos_sin_base'
TBLPROPERTIES (
  'classification'='csv', 
  'columnsOrdered'='true', 
  'separatorChar'='\;', 
  'objectCount'='1', 
  'quoteChar'='\"', 
  'skip.header.line.count'='1', 
  'typeOfData'='file'
)