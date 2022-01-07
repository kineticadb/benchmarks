
select top 100 
  cd_gender,
  cd_marital_status,
  cd_education_status,
  count(*) cnt1,
  cd_purchase_estimate,
  count(*) cnt2,
  cd_credit_rating,
  count(*) cnt3,
  cd_dep_count,
  count(*) cnt4,
  cd_dep_employed_count,
  count(*) cnt5,
  cd_dep_college_count,
  count(*) cnt6
 from
  customer c
  JOIN customer_address ca ON c.c_current_addr_sk = ca.ca_address_sk
  JOIN customer_demographics ON cd_demo_sk = c.c_current_cdemo_sk
  JOIN (SELECT ss_customer_sk FROM store_sales, date_dim WHERE ss_sold_date_sk = d_date_sk and d_year = 2001 and d_moy between 3 and 3+3 GROUP BY ss_customer_sk) sub1 ON c.c_customer_sk = sub1.ss_customer_sk
  LEFT JOIN (SELECT ws_bill_customer_sk, COUNT(*) c FROM web_sales, date_dim WHERE ws_sold_date_sk = d_date_sk and d_year = 2002 and d_moy between 3 and 3+3 GROUP BY ws_bill_customer_sk) sub2 ON c.c_customer_sk = sub2.ws_bill_customer_sk
  LEFT JOIN (SELECT cs_ship_customer_sk, COUNT(*) c FROM catalog_sales, date_dim WHERE cs_sold_date_sk = d_date_sk AND d_year = 2001 AND d_moy BETWEEN 3 AND 3+3 GROUP BY cs_ship_customer_sk) sub3 ON c.c_customer_sk = sub2.ws_bill_customer_sk
 where
  ca_county in ('Fairfield County','Campbell County','Washtenaw County','Escambia County','Cleburne County') and
  (sub2.c > 0 or sub3.c > 0)
 group by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 order by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
;