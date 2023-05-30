CREATE EXTERNAL TABLE IF NOT EXISTS `raw`.`universal_francia` (
	`Contract No.` FLOAT,
	`Sub Contract Number` STRING,
	`Sub Contract Name` STRING,
	`Payee Share %` STRING,
	`Sale Reference Number` STRING,
	`Product Number` STRING,
	`Title` STRING,
	`ISRC` STRING,
	`Track Title` STRING,
	`Artist Name` STRING,
	`Product Type` STRING,
	`Product Share %` STRING,
	`Sale Transaction Code` STRING,
	`Sale Transaction Name` STRING,
	`Sales Type Code` STRING,
	`Sales Type` STRING,
	`Country` STRING,
	`Distributor` STRING,
	`Sales Period` STRING,
	`Price Level` STRING,
	`Price Basis` STRING,
	`Price Basis Description` STRING,
	`PPD` STRING,
	`Price Basis %` STRING,
	`Pkg Deduct %` STRING,
	`Accounting Price` STRING,
	`Release Ind` STRING,
	`Units` STRING,
	`Sales Reserve Qty` STRING,
	`Sales %` STRING,
	`Sales Units` STRING,
	`Escalation Level` STRING,
	`Royalty Rate %` STRING,
	`Royalty Amount` STRING)
ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	ESCAPED BY '\\'
	LINES TERMINATED BY '\n'
LOCATION
	 's3://mushroom-pillow-bi/data/raw/sales_csv/universal_francia/'
TBLPROPERTIES (
  'skip.header.line.count'='1'
)