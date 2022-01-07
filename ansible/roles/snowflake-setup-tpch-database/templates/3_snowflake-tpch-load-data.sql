alter warehouse COMPUTE_WH resume;
use database {{ snowflake_tpch_database }};
use warehouse COMPUTE_WH;
use schema {{ snowflake_tpch_schema }};

create or replace file format tpch_csv_format
  type = csv
  field_delimiter = '|'
  skip_header = 1
  null_if = ('NULL', 'null')
  error_on_column_count_mismatch = false
  empty_field_as_null = true;

create or replace stage tpch_sf100_s3_stage url='s3://{{ dataimport_s3_bucket_name }}/{{ dataimport_tpch_s3_path }}'
  credentials=(aws_key_id='{{ dataimport_s3_user }}' aws_secret_key='{{ dataimport_s3_password }}')
  file_format = tpch_csv_format;

-----

copy into region from @tpch_sf100_s3_stage files=('region.csv');
copy into nation from @tpch_sf100_s3_stage files=('nation.csv');
copy into supplier from @tpch_sf100_s3_stage files=('supplier.csv');
copy into customer from @tpch_sf100_s3_stage files=('customer.csv');
copy into part from @tpch_sf100_s3_stage files=('part.csv');
copy into partsupp from @tpch_sf100_s3_stage files=('partsupp.csv');
copy into orders from @tpch_sf100_s3_stage files=('orders.csv');
copy into lineitem from @tpch_sf100_s3_stage files=('lineitem.csv');

-----

alter warehouse COMPUTE_WH suspend;