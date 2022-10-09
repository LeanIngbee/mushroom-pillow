CREATE EXTERNAL TABLE raw.`royalties_video`(
  `Codigo Unico` string,
  `Record Label` string,
  `PNAME` string,
  `Artist Name` string,
  `Video Title` string,
  `Video version` string,
  `Video ISRC` string,
  `Release Year` string,
  `Corresponding Audio Title` string,
  `Corresponding Audio ISRC` string,
  `Collection territories included` string,
  `Duration (in seconds)` string,
  `Country of recording AUDIO` string,
  `Country of Recording VIDEO` string,
  `% Rights` string,
  `MP` string,
  `UPC` string,
  `Royalty 1` string,
  `Royalty 2` string,
  `Royalty 3` string,
  `Royalty 4` string,
  `Royalty 5` string,
  `Mail envio royalty 1` string,
  `Mail envio royalty 2` string,
  `Mail envio royalty 3` string,
  `Mail envio royalty 4` string,
  `Mail envio royalty 5` string
)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/royalties_video'
TBLPROPERTIES (
  'escapeChar'='\\', 
  'quoteChar'='\"', 
  'separatorChar'='\;', 
  'skip.header.line.count'='2')