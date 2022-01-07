
select top 100 
   sum(ws_ext_discount_amt)  as Excess_Discount_Amount
from 
    web_sales 
   ,item
   JOIN (SELECT ws_item_sk wsi, 1.3 * avg(ws_ext_discount_amt) av
         FROM web_sales, date_dim
         WHERE d_date between '1999-02-19' and
                             (cast('1999-02-19' as date) + INTERVAL 90 days)
               and d_date_sk = ws_sold_date_sk
         GROUP BY ws_item_sk) j1 ON j1.wsi = i_item_sk
   ,date_dim
where
i_manufact_id = 408
and i_item_sk = ws_item_sk 
and d_date between '1999-02-19' and 
        (cast('1999-02-19' as date) + INTERVAL 90 days)
and d_date_sk = ws_sold_date_sk 
and ws_ext_discount_amt > j1.av
order by sum(ws_ext_discount_amt)
;