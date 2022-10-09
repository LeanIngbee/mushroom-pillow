
CREATE EXTERNAL TABLE raw.`syncro`(
  `Tipo de venta` string,
`Año Ingreso` string,
`Año Licencia` string,
`Fecha` string,
`Factura` string,
`Periodo Liquidación` string,
`Lleva IVA` string,
`Duración (meses)` string,
`Duración Sale off (meses)` string,
`Periodicidad Liquidación` string,
`Publishing recaudado por 3º` string,
`Publishing ` string,
`Master` string,
`Moneda` string,
`Tipo de Plataforma` string,
`Nombre Recopilatorio` string,
`ISRC` string,
`ISWC` string,
`Track` string,
`Album` string,
`Artista` string,
`Licenciante` string,
`Pais de explotación` string,
`Pais` string,
`Territorios de licencias` string,
`Referencia` string,
`Tasa Interm.` string,
`Royalty Master` string,
`% control Mushroom Pillow` string,
`Royalty Publishing` string,
`Master Imp Bruto` string,
`Publishing Imp Bruto` string,
`Publishing neto ` string,
`Master Neto` string,
`Fecha licencia` string,
`Fecha lanzamiento` string,
`Contacto` string)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/syncro'
TBLPROPERTIES (
  'classification'='csv', 
  'columnsOrdered'='true', 
  'delimiter'='\;', 
  'objectCount'='1', 
  'quoteChar'='\"', 
  'skip.header.line.count'='2', 
  'typeOfData'='file')