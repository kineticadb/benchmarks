
select top 100 a.ca_state state, count(*) cnt
 from customer_address a
     ,customer c
     ,store_sales s
     ,date_dim d
     ,item i
     ,(SELECT avg(j.i_current_price) ap, j.i_category FROM item j GROUP BY i_category) sub1
 where       a.ca_address_sk = c.c_current_addr_sk
 	and c.c_customer_sk = s.ss_customer_sk
 	and s.ss_sold_date_sk = d.d_date_sk
 	and s.ss_item_sk = i.i_item_sk
 	and d.d_month_seq = 
 	     (select distinct (d_month_seq)
 	      from date_dim
               where d_year = 2002
 	        and d_moy = 3 )
 	and i.i_current_price > 1.2 * sub1.ap and sub1.i_category = i.i_category
 group by a.ca_state
 having count(*) >= 10
 order by cnt, a.ca_state 
 ;