create or replace view clean.altafonte_ventas_fisicas as 

with prepared as (
    select
        *,
        "$path" as path,
        case "mes"
          WHEN 'Enero' THEN '01'
          WHEN 'Febrero' THEN '02'
          WHEN 'Marzo' THEN '03'
          WHEN 'Abril' THEN '04'
          WHEN 'Mayo' THEN '05'
          WHEN 'Junio' THEN '06'
          WHEN 'Julio' THEN '07'
          WHEN 'Agosto' THEN '08'
          WHEN 'Septiembre' THEN '09'
          WHEN 'Octubre' THEN '10'
          WHEN 'Noviembre' THEN '11'
          WHEN 'Diciembre' THEN '12'
        end as "mes corregido",
        TRY_CAST("cantidad neta" as bigint) as "cantidad neta corregida"
    from raw.altafonte_ventas_fisicas 
)

SELECT
    "path" file,
    date_add('month', 2, TRY_CAST(try_cast("año" as varchar) || '-' || "mes corregido" || '-01' AS date)) report_date,
    TRY_CAST(try_cast("año" as varchar) || '-' || "mes corregido" || '-01' AS date) sale_date,
    "cantidad neta corregida" quantity,
    'VENTA FISICA' sale_type,
    TRY_CAST(REPLACE(REPLACE("ventas brutas", '.', ''), ',','.') as double ) gross_revenue,
    TRY_CAST(REPLACE(REPLACE("ventas netas", '.', ''), ',','.') as double ) net_revenue,
    nullif(case when "referencia" is not null and "referencia" != '' then 'MP' || lpad(try_cast(try_cast(regexp_replace("referencia", '([^0-9.])', '') as bigint) as varchar), 3, '0') end, '') as product_id,
    CAST(null AS varchar) as isrc,
    'Physical Store' platform,
    'ALTAFONTE' source, -- REAL SOURCE es altafonte_ventas_fisicas pero tomas pide ALTAFONTE
    COALESCE(NULLIF(lower("Pais"), ''), 'Unknown') country,
    CAST(null AS varchar) agency,
    false is_licencing,
    CAST(null AS varchar) operation_type, --TODO: NEED TO TAKE IT FROM MP
    cast(NULL as varchar) stream_quality,
    'EUR' as source_currency,
    nullif("artista", '') as artist,
    nullif("titulos", '') as album,
    cast(NULL as varchar) as song
    
FROM prepared

--file	01
--report_date -> "sale_date" + 1 mes
--sale_date -> 01-"MES"-"AÑO"
--quantity -> "Cantidad neta"
--sale_type ->  "VENTAS_FISICAS"
--gross_revenue	-> "ventas brutas"
--net_revenue	-> "ventas netas"
--product_id	-> "Referencia"
--isrc	 -> null
--song	-> XXXX (CALC)
--album	-> XXXX (CALC) (si no hay ningun match que ponga "Spinning Over You")
--artist	-> XXXX (CALC) (si no hay ningun match que ponga "reyko")
--platform	-> "Physical Store" matchear con plataforma_corregida
--"source"	-> ALTAFONTE
--country	-> "País"
--continent	-> XXXX (CALC)
--agency	-> null
--is_licencing	-> false
--operation_type --> A CONFIRMAR EN CASO DE QUE SEA LP O CD tomar el formato del MP.
--stream_quality -> "N/A"

-- raw table:
  -- "referencia" string, 
  -- "artista" string, 
  -- "titulos" string, 
  -- "ventas" double, 
  -- "importe" string, 
  -- "cantidad devoluciones" bigint, 
  -- "importe devoluciones" string, 
  -- "cantidad neta" double, 
  -- "ventas brutas" string, 
  -- "p. medio" string, 
  -- "costo distribución" string, 
  -- "costo devolución" string, 
  -- "ventas netas" string, 
  -- "distribuidor" string, 
  -- "pais" string, 
  -- "mes" string, 
  -- "año" bigint, 
  -- "cd/lp" string)
