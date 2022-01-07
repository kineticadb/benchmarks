
select top 100  
  ca_state,
  cd_gender,
  cd_marital_status,
  cd_dep_count,
  count(*) cnt1,
  avg(cd_dep_count),
  stddev_samp(cd_dep_count),
  sum(cd_dep_count),
  cd_dep_employed_count,
  count(*) cnt2,
  avg(cd_dep_employed_count),
  stddev_samp(cd_dep_employed_count),
  sum(cd_dep_employed_count),
  cd_dep_college_count,
  count(*) cnt3,
  avg(cd_dep_college_count),
  stddev_samp(cd_dep_college_count),
  sum(cd_dep_college_count)
 from
  customer c
  JOIN (SELECT DISTINCT ss_customer_sk sssk
        FROM store_sales, date_dim
        WHERE ss_sold_date_sk = d_date_sk and d_year = 1999 and d_qoy < 4) j1 ON j1.sssk = c.c_customer_sk
  LEFT JOIN (SELECT DISTINCT ws_bill_customer_sk wsbcsk
        FROM web_sales, date_dim
        WHERE ws_sold_date_sk = d_date_sk and d_year = 1999 and d_qoy < 4) j2 ON j2.wsbcsk = c.c_customer_sk
  LEFT JOIN (SELECT DISTINCT cs_ship_customer_sk csscsk
        FROM catalog_sales, date_dim
        WHERE cs_sold_date_sk = d_date_sk and d_year = 1999 and d_qoy < 4) j3 ON j3.csscsk = c.c_customer_sk
  ,customer_address ca,customer_demographics
 where
  c.c_current_addr_sk = ca.ca_address_sk and
  cd_demo_sk = c.c_current_cdemo_sk and
  (NOT j2.wsbcsk IS NULL OR NOT j3.csscsk IS NULL)
 group by ca_state,
          cd_gender,
          cd_marital_status,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 order by ca_state,
          cd_gender,
          cd_marital_status,
          cd_dep_count,
          cd_dep_employed_count,
          cd_dep_college_count
 ;