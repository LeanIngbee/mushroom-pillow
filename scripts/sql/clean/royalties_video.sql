create or replace view clean.royalties_video as 

select distinct 
  nullif("Video ISRC", '') as isrc, 
  nullif("MP", '') as product_id, 
  try_cast(nullif("Royalty 1", '') as double) as royalties_rate_1,
  lower(nullif(nullif("Mail envio royalty 1", ''), '0')) as contact_email_1,
  try_cast(nullif("Royalty 2", '') as double) as royalties_rate_2,
  lower(nullif(nullif("Mail envio royalty 2", ''), '0')) as contact_email_2,
  try_cast(nullif("Royalty 3", '') as double) as royalties_rate_3,
  lower(nullif(nullif("Mail envio royalty 3", ''), '0')) as contact_email_3,
  try_cast(nullif("Royalty 4", '') as double) as royalties_rate_4,
  lower(nullif(nullif("Mail envio royalty 4", ''), '0')) as contact_email_4,
  try_cast(nullif("Royalty 5", '') as double) as royalties_rate_5,
  lower(nullif(nullif("Mail envio royalty 5", ''), '0')) as contact_email_5

from raw.royalties_video
where nullif("Video ISRC", '') is not null and nullif("MP", '') is not null