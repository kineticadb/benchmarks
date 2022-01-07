
select distinct i_product_name
 from item i1
 JOIN (SELECT i_manufact, count(*) item_cnt
       FROM item
       WHERE
        ((i_category = 'Women' and
        (i_color = 'forest' or i_color = 'lime') and
        (i_units = 'Pallet' or i_units = 'Pound') and
        (i_size = 'economy' or i_size = 'small')
        ) or
        (i_category = 'Women' and
        (i_color = 'navy' or i_color = 'slate') and
        (i_units = 'Gross' or i_units = 'Bunch') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'powder' or i_color = 'sky') and
        (i_units = 'Dozen' or i_units = 'Lb') and
        (i_size = 'N/A' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'maroon' or i_color = 'smoke') and
        (i_units = 'Ounce' or i_units = 'Case') and
        (i_size = 'economy' or i_size = 'small')
        )) or
        ((i_category = 'Women' and
        (i_color = 'dark' or i_color = 'aquamarine') and
        (i_units = 'Ton' or i_units = 'Tbl') and
        (i_size = 'economy' or i_size = 'small')
        ) or
        (i_category = 'Women' and
        (i_color = 'frosted' or i_color = 'plum') and
        (i_units = 'Dram' or i_units = 'Box') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'papaya' or i_color = 'peach') and
        (i_units = 'Bundle' or i_units = 'Carton') and
        (i_size = 'N/A' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'firebrick' or i_color = 'sienna') and
        (i_units = 'Cup' or i_units = 'Each') and
        (i_size = 'economy' or i_size = 'small')
        ))
       GROUP BY i_manufact) i2 ON i2.i_manufact = i1.i_manufact
 where i_manufact_id between 704 and 704+40
   and i2.item_cnt > 0
 order by i_product_name
 LIMIT 100
 ;