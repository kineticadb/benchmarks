
select top 100 sum(cs_ext_discount_amt)  as excess_discount_amount
from 
   catalog_sales 
   ,item
   JOIN (select cs_item_sk csisk, 1.3 * avg(cs_ext_discount_amt) av
         from catalog_sales, date_dim
         where
          d_date between '2001-03-09' and
                             (cast('2001-03-09' as date) + INTERVAL 90 days)
          and d_date_sk = cs_sold_date_sk GROUP BY cs_item_sk) j ON j.csisk = i_item_sk
   ,date_dim
where
i_manufact_id = 722
and i_item_sk = cs_item_sk 
and d_date between '2001-03-09' and 
        (cast('2001-03-09' as date) + INTERVAL 90 days)
and d_date_sk = cs_sold_date_sk 
and cs_ext_discount_amt  > j.av
;