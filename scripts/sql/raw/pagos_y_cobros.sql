CREATE EXTERNAL TABLE `raw.pagos_y_cobros`(
`COD` string,
`Pagos Realizados` string,
`Detección Errores` string,
`Orden 2019` string,
`Cod Año` string,
`Año` string,
`Mes` string,
`Codigo guardado` string,
`Tipo` string,
`Contacto existente` string,
`Titular` string,
`Nº FACTURA` string,
`Fecha fra` string,
`Fecha prevista` string,
`Fecha realización` string,
`Concepto` string,
`Rubro` string,
`Subrubro` string,
`Rubro especifico` string,
`Codigo cuenta` string,
`PP` string,
`Inciso` string,
`Pais promo` string,
`Año Reparto` string,
`Moneda` string,
`Unidades` string,
`Base Imp` string,
`IVA` string,
`IRPF` string,
`Importe total` string,
`Base imp Euros` string,
`Importe total Euros` string,
`importe PAID` string,
`importe PTE` string,
`Medio de Pago` string,
`Nº CUENTA` string,
`Detalle EERR` string,
`PROYECTO` string,
`Album` string,
`Canción` string,
`Referencia` string,
`Referencia Agrupada` string,
`Proyectos trackeados` string,
`Pago/cobro Reclamado` string,
`Pagos reclamados/Vencidos` string,
`Observaciones` string,
`Campaña` string,
`Base imponible EUR estimada` string,
`% IVA` string,
`Costo unitario` string
)
ROW FORMAT DELIMITED 
  FIELDS TERMINATED BY '\;' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/sales_csv/pagos_y_cobros/'
TBLPROPERTIES (
  'delimiter'='\;', 
  'objectCount'='1', 
  'skip.header.line.count'='1'
)