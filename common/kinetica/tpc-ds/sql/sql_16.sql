
select top 100 
   count(distinct cs_order_number) as order_count
  ,sum(cs_ext_ship_cost) as total_shipping_cost
  ,sum(cs_net_profit) as total_net_profit
from
   catalog_sales cs1
   JOIN (SELECT cs_order_number cson, COUNT(DISTINCT cs_warehouse_sk) c
              FROM catalog_sales GROUP BY cs_order_number) cs2
        ON cs1.cs_order_number = cs2.cson
              and cs2.c > 1
   LEFT JOIN (SELECT DISTINCT cr_order_number FROM catalog_returns) cr1
        ON cr1.cr_order_number = cs1.cs_order_number
  ,date_dim
  ,customer_address
  ,call_center
where
    d_date between '2002-04-01' and
           (cast('2002-04-01' as date) + INTERVAL 60 days)
and cs1.cs_ship_date_sk = d_date_sk
and cs1.cs_ship_addr_sk = ca_address_sk
and ca_state = 'PA'
and cs1.cs_call_center_sk = cc_call_center_sk
and cc_county in ('Williamson County','Williamson County','Williamson County','Williamson County',
                  'Williamson County'
)
and cr1.cr_order_number IS NULL
order by count(distinct cs_order_number)
;