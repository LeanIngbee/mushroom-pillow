-- KOBALT - INSTRUCCIONES DE TOMAS

-- NOTA ALGUNOS RECORDS NO TIENEN ISRC.
-- ACA HAY QUE ENCONTRAR ALGUNA FORMA ALTERNATIVA DE ENCONTRAR EL ARTISTA, QUE VIENE CON EL NOMBRE
-- EN "RECORDING_ARTIST" Y A VECES EL TEMA EN "RECORDING_TITLE"


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
