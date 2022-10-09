create or replace view clean.royalties_audio as 

select distinct 
  nullif("ISRC Code", '') as isrc, 
  nullif("Catalogue Number", '') as product_id, 
  try_cast(nullif("Royalty rate Artist", '') as double) as royalties_rate_1,
  lower(nullif("Mail Envio Royalties Artista 1", '')) as contact_email_1,
  lower(nullif("Periodicidad 1", '')) as periodicity_1,
  try_cast(nullif("Royalty Artista 2", '') as double) as royalties_rate_2,
  lower(nullif("Mail Envio Royalties Artista 2", '')) as contact_email_2,
  lower(nullif("Periodicidad 2", '')) as periodicity_2,
  try_cast(nullif("Royalty Artista 3", '') as double) as royalties_rate_3,
  lower(nullif("Mail Envio Royalties Artista 3", '')) as contact_email_3,
  lower(nullif("Periodicidad 3", '')) as periodicity_3,
  try_cast(nullif("Royalty Artista 4", '') as double) as royalties_rate_4,
  lower(nullif("Mail Envio Royalties Artista 4", '')) as contact_email_4,
  lower(nullif("Periodicidad 4", '')) as periodicity_4,
  try_cast(nullif("Royalty Artista 5", '') as double) as royalties_rate_5,
  lower(nullif("Mail Envio Royalties Artista 5", '')) as contact_email_5,
  lower(nullif("Periodicidad 5", '')) as periodicity_5

from raw.royalties_audio
where nullif("ISRC Code", '') is not null and nullif("Catalogue Number", '') is not null