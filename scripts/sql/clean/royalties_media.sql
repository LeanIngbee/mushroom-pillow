create or replace view clean.royalties_media as 

with

royalties_audio_information as (
  select distinct 
    1 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_1 as royalties_rate,
    contact_email_1 as contact_email,
    periodicity_1 as periodicity

  from clean.royalties_audio
  where isrc is not null and product_id is not null and royalties_rate_1 > 0 and contact_email_1 is not null and periodicity_1 is not null

  union

  select distinct 
    2 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_2 as royalties_rate,
    contact_email_2 as contact_email,
    periodicity_2 as periodicity

  from clean.royalties_audio
  where isrc is not null and product_id is not null and royalties_rate_2 > 0 and contact_email_2 is not null and periodicity_2 is not null

  union

  select distinct 
    3 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_3 as royalties_rate,
    contact_email_3 as contact_email,
    periodicity_3 as periodicity

  from clean.royalties_audio
  where isrc is not null and product_id is not null and royalties_rate_3 > 0 and contact_email_3 is not null and periodicity_3 is not null

  union

  select distinct 
    4 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_4 as royalties_rate,
    contact_email_4 as contact_email,
    periodicity_4 as periodicity

  from clean.royalties_audio
  where isrc is not null and product_id is not null and royalties_rate_4 > 0 and contact_email_4 is not null and periodicity_4 is not null

  union

  select distinct 
    5 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_5 as royalties_rate,
    contact_email_5 as contact_email,
    periodicity_5 as periodicity

  from clean.royalties_audio
  where isrc is not null and product_id is not null and royalties_rate_5 > 0 and contact_email_5 is not null and periodicity_5 is not null
),

royalties_video_information as (
  select distinct 
    1 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_1 as royalties_rate,
    contact_email_1 as contact_email

  from clean.royalties_video
  where isrc is not null and product_id is not null and royalties_rate_1 > 0 and contact_email_1 is not null

  union

  select distinct 
    2 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_2 as royalties_rate,
    contact_email_2 as contact_email

  from clean.royalties_video
  where isrc is not null and product_id is not null and royalties_rate_2 > 0 and contact_email_2 is not null

  union

  select distinct 
    3 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_3 as royalties_rate,
    contact_email_3 as contact_email

  from clean.royalties_video
  where isrc is not null and product_id is not null and royalties_rate_3 > 0 and contact_email_3 is not null

  union

  select distinct 
    4 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_4 as royalties_rate,
    contact_email_4 as contact_email

  from clean.royalties_video
  where isrc is not null and product_id is not null and royalties_rate_4 > 0 and contact_email_4 is not null

  union

  select distinct 
    5 as artist_number,
    isrc, 
    product_id, 
    royalties_rate_5 as royalties_rate,
    contact_email_5 as contact_email

  from clean.royalties_video
  where isrc is not null and product_id is not null and royalties_rate_5 > 0 and contact_email_5 is not null
)

select a.*, b.contact_name
from (
  (select *, 'audio' as media_type from royalties_audio_information)
  union
  (
    select a.*, b.periodicity, 'video' as media_type
    from royalties_video_information a
    left join royalties_audio_information b on a.isrc = b.isrc and a.product_id = b.product_id and a.artist_number = b.artist_number 
  )
) a
left join raw.royalties_contacts b on a.contact_email = b.contact_email