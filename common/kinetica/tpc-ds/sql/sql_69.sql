
select top 100 
  cd_gender,
  cd_marital_status,
  cd_education_status,
  count(*) cnt1,
  cd_purchase_estimate,
  count(*) cnt2,
  cd_credit_rating,
  count(*) cnt3
 from
  customer c
  JOIN (SELECT DISTINCT ss_customer_sk
        FROM store_sales, date_dim
        WHERE ss_sold_date_sk = d_date_sk AND d_year = 1999 AND d_moy between 2 and 2+2) j1 ON j1.ss_customer_sk = c.c_customer_sk
  LEFT JOIN (SELECT DISTINCT ws_bill_customer_sk
        FROM web_sales, date_dim
        WHERE ws_sold_date_sk = d_date_sk AND d_year = 1999 AND d_moy between 2 and 2+2) j2 ON j2.ws_bill_customer_sk = c.c_customer_sk
  LEFT JOIN (SELECT DISTINCT cs_ship_customer_sk
        FROM catalog_sales, date_dim
        WHERE cs_sold_date_sk = d_date_sk AND d_year = 1999 AND d_moy between 2 and 2+2) j3 ON j3.cs_ship_customer_sk = c.c_customer_sk
  ,customer_address ca,customer_demographics
 where
  c.c_current_addr_sk = ca.ca_address_sk and
  ca_state in ('WV','LA','NC') and
  cd_demo_sk = c.c_current_cdemo_sk and
  (j2.ws_bill_customer_sk IS NULL AND j3.cs_ship_customer_sk IS NULL)
 group by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating
 order by cd_gender,
          cd_marital_status,
          cd_education_status,
          cd_purchase_estimate,
          cd_credit_rating
 ;