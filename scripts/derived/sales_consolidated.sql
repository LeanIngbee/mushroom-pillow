drop table derived.sales_consolidated;
CREATE table derived.sales_consolidated
AS (
    SELECT 
        file,
        report_date,
        sale_date,
        quantity,
        sale_type,
        gross_revenue,
        net_revenue,
        product_id,
        isrc,
        song,
        album,
        artist,
        platform,
        source,
        country,
        continent,
        agency,
        is_licencing,
        operation_type,
        stream_quality,
        array_join(errors, ',') AS errors
    FROM derived.sales
);
