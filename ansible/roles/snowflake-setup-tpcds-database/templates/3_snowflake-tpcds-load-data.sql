alter warehouse COMPUTE_WH resume;
use database {{ snowflake_tpcds_database }};
use warehouse COMPUTE_WH;
use schema {{ snowflake_tpcds_schema }};

create or replace file format tpcds_csv_format
  type = csv
  field_delimiter = '|'
  skip_header = 1
  null_if = ('NULL', 'null')
  error_on_column_count_mismatch = false
  validate_utf8 = false
  empty_field_as_null = true;

create or replace stage tpcds_sf100_s3_stage url='s3://{{ dataimport_s3_bucket_name }}/{{ dataimport_tpcds_s3_path }}'
  credentials=(aws_key_id='{{ dataimport_s3_user }}' aws_secret_key='{{ dataimport_s3_password }}')
  file_format = tpcds_csv_format;

-----

copy into dbgen_version from @tpcds_sf100_s3_stage files=('dbgen_version.csv');
copy into time_dim from @tpcds_sf100_s3_stage files=('time_dim.csv');
copy into date_dim from @tpcds_sf100_s3_stage files=('date_dim.csv');
copy into income_band from @tpcds_sf100_s3_stage files=('income_band.csv');
copy into reason from @tpcds_sf100_s3_stage files=('reason.csv');
copy into ship_mode from @tpcds_sf100_s3_stage files=('ship_mode.csv');
copy into customer_address from @tpcds_sf100_s3_stage files=('customer_address.csv');
copy into customer_demographics from @tpcds_sf100_s3_stage files=('customer_demographics.csv');
copy into item from @tpcds_sf100_s3_stage files=('item.csv');
copy into warehouse from @tpcds_sf100_s3_stage files=('warehouse.csv');

-- One dep to block above
copy into call_center from @tpcds_sf100_s3_stage files=('call_center.csv');
copy into catalog_page from @tpcds_sf100_s3_stage files=('catalog_page.csv');
copy into household_demographics from @tpcds_sf100_s3_stage files=('household_demographics.csv');
copy into customer from @tpcds_sf100_s3_stage files=('customer.csv');
copy into promotion from @tpcds_sf100_s3_stage files=('promotion.csv');
copy into web_site from @tpcds_sf100_s3_stage files=('web_site.csv');
copy into web_page from @tpcds_sf100_s3_stage files=('web_page.csv');
copy into store from @tpcds_sf100_s3_stage files=('store.csv');
copy into inventory from @tpcds_sf100_s3_stage files=('inventory.csv');

-- Complex dep
copy into catalog_returns from @tpcds_sf100_s3_stage files=('catalog_returns.csv');
copy into catalog_sales from @tpcds_sf100_s3_stage files=('catalog_sales.csv');
copy into store_returns from @tpcds_sf100_s3_stage files=('store_returns.csv');
copy into store_sales from @tpcds_sf100_s3_stage files=('store_sales.csv');
copy into web_returns from @tpcds_sf100_s3_stage files=('web_returns.csv');
copy into web_sales from @tpcds_sf100_s3_stage files=('web_sales.csv');

-----

alter warehouse COMPUTE_WH suspend;