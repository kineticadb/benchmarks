
select top 100 
   count(distinct ws_order_number) as order_count
  ,sum(ws_ext_ship_cost) as total_shipping_cost
  ,sum(ws_net_profit) as total_net_profit
from
   web_sales ws1
   JOIN (SELECT ws_order_number wson, COUNT(DISTINCT ws_warehouse_sk) c
         FROM web_sales
         GROUP BY ws_order_number) j1 ON j1.wson = ws1.ws_order_number
   LEFT JOIN (SELECT DISTINCT wr_order_number FROM web_returns) wr1 ON ws1.ws_order_number = wr1.wr_order_number
  ,date_dim
  ,customer_address
  ,web_site
where
    d_date between '2000-02-01' and
           (cast('2000-02-01' as date) + INTERVAL 60 days)
and ws1.ws_ship_date_sk = d_date_sk
and ws1.ws_ship_addr_sk = ca_address_sk
and ca_state = 'AR'
and ws1.ws_web_site_sk = web_site_sk
and web_company_name = 'pri'
and wr1.wr_order_number IS NULL
order by count(distinct ws_order_number)
;