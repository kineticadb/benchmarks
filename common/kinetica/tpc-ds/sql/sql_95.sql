
with ws_wh as
(select ws1.ws_order_number,ws1.ws_warehouse_sk wh1,ws2.ws_warehouse_sk wh2
 from web_sales ws1,web_sales ws2
 where ws1.ws_order_number = ws2.ws_order_number
   and ws1.ws_warehouse_sk <> ws2.ws_warehouse_sk)
 select top 100 
   count(distinct ws_order_number) as order_count
  ,sum(ws_ext_ship_cost) as total_shipping_cost
  ,sum(ws_net_profit) as total_net_profit
from
   web_sales ws1
  ,date_dim
  ,customer_address
  ,web_site
  ,(SELECT DISTINCT ws_order_number wson FROM ws_wh) j1
  ,(SELECT DISTINCT wr_order_number wron FROM web_returns, ws_wh WHERE wr_order_number = ws_wh.ws_order_number) j2
where
    d_date between '1999-05-01' and
           (cast('1999-05-01' as date) + INTERVAL 60 days)
and ws1.ws_ship_date_sk = d_date_sk
and ws1.ws_ship_addr_sk = ca_address_sk
and ca_state = 'MT'
and ws1.ws_web_site_sk = web_site_sk
and web_company_name = 'pri'
and ws1.ws_order_number = j1.wson
and ws1.ws_order_number = j2.wron
order by count(distinct ws_order_number)
;