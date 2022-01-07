
select i_item_id
      ,i_item_desc 
      ,i_category 
      ,i_class 
      ,i_current_price
      ,s1 as itemrevenue
      ,s1*100/s2 as revenueratio
from (SELECT *, sum(s1) over (partition by i_class) s2
      FROM (SELECT i_item_id, i_item_desc, i_category, i_class, i_current_price, sum(ss_ext_sales_price) s1 FROM
	store_sales
    	,item 
    	,date_dim
where 
	ss_item_sk = i_item_sk 
  	and i_category in ('Shoes', 'Books', 'Children')
  	and ss_sold_date_sk = d_date_sk
	and d_date between cast('2001-02-01' as date) 
				and (cast('2001-02-01' as date) + INTERVAL 30 days)
group by 
	i_item_id
        ,i_item_desc 
        ,i_category
        ,i_class
        ,i_current_price
))
order by 
	i_category
        ,i_class
        ,i_item_id
        ,i_item_desc
        ,revenueratio;