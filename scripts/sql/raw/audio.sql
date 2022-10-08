CREATE EXTERNAL TABLE raw.`audio`(
  `keycode` string COMMENT 'from deserializer', 
  `record label` string COMMENT 'from deserializer', 
  `pname` string COMMENT 'from deserializer', 
  `artist name` string COMMENT 'from deserializer', 
  `individual performer` string COMMENT 'from deserializer', 
  `performer category` string COMMENT 'from deserializer', 
  `role` string COMMENT 'from deserializer', 
  `album title` string COMMENT 'from deserializer', 
  `barcode/upc` string COMMENT 'from deserializer', 
  `product_id` string COMMENT 'from deserializer', 
  `format` string COMMENT 'from deserializer', 
  `main release date` string COMMENT 'from deserializer', 
  `country of original label` string COMMENT 'from deserializer', 
  `country of recording` string COMMENT 'from deserializer', 
  `artist nationality` string COMMENT 'from deserializer', 
  `recording year` string COMMENT 'from deserializer', 
  `release year` string COMMENT 'from deserializer', 
  `collection territories included` string COMMENT 'from deserializer', 
  `number of disc` string COMMENT 'from deserializer', 
  `track on disc` string COMMENT 'from deserializer', 
  `main title` string COMMENT 'from deserializer', 
  `title version` string COMMENT 'from deserializer', 
  `isrc` string COMMENT 'from deserializer', 
  `duration (in seconds)` string COMMENT 'from deserializer', 
  `date start` string COMMENT 'from deserializer', 
  `date end` string COMMENT 'from deserializer', 
  `% rights` string COMMENT 'from deserializer', 
  `publisher(s)` string COMMENT 'from deserializer', 
  `publisher(s) share` string COMMENT 'from deserializer', 
  `publishing synch` string COMMENT 'from deserializer', 
  `publishing mushroom %` string COMMENT 'from deserializer', 
  `publishing resto` string COMMENT 'from deserializer', 
  `album agrupado` string COMMENT 'from deserializer', 
  `formato` string COMMENT 'from deserializer', 
  `tipo` string COMMENT 'from deserializer', 
  `final mp` string COMMENT 'from deserializer', 
  `iswc` string COMMENT 'from deserializer', 
  `codigo sgae` string COMMENT 'from deserializer', 
  `lenguaje` string COMMENT 'from deserializer', 
  `bpm` string COMMENT 'from deserializer', 
  `genero` string COMMENT 'from deserializer', 
  `sub genero` string COMMENT 'from deserializer', 
  `tipo voz` string COMMENT 'from deserializer', 
  `p line` string COMMENT 'from deserializer', 
  `producers` string COMMENT 'from deserializer', 
  `writers/composers` string COMMENT 'from deserializer', 
  `precio` string COMMENT 'from deserializer', 
  `syncros catalogo` string COMMENT 'from deserializer', 
  `coments` string COMMENT 'from deserializer', 
  `kobalt` string COMMENT 'from deserializer')
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
WITH SERDEPROPERTIES ( 
  'escapeChar'='\\', 
  'quoteChar'='\"', 
  'separatorChar'='\;', 
  'skip.header.line.count'='1') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/audio'
TBLPROPERTIES (
  'transient_lastDdlTime'='1648321256')