CREATE EXTERNAL TABLE raw.`royalties_contacts`(
  contact_email string,
  contact_name string
)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.OpenCSVSerde' 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://mushroom-pillow-bi/data/raw/metadata/royalties_contacts'
TBLPROPERTIES (
  'escapeChar'='\\', 
  'quoteChar'='\"', 
  'separatorChar'='\;', 
  'skip.header.line.count'='1')