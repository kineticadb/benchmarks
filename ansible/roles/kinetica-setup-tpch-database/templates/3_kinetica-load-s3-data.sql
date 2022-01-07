CREATE DATA SOURCE s3_kinetica_benchmark
LOCATION = 'S3://'
USER = '{{ dataimport_s3_user }}'
PASSWORD = '{{ dataimport_s3_password }}'
WITH OPTIONS
(
    BUCKET NAME = '{{ dataimport_s3_bucket_name }}',
    REGION = '{{ dataimport_s3_region }}'
);

copy into {{ kinetica_tpch_schema }}.region from file paths '{{ dataimport_tpch_s3_path }}/region.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.nation from file paths '{{ dataimport_tpch_s3_path }}/nation.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.supplier from file paths '{{ dataimport_tpch_s3_path }}/supplier.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.customer from file paths '{{ dataimport_tpch_s3_path }}/customer.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.part from file paths '{{ dataimport_tpch_s3_path }}/part.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.partsupp from file paths '{{ dataimport_tpch_s3_path }}/partsupp.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.orders from file paths '{{ dataimport_tpch_s3_path }}/orders.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ kinetica_tpch_schema }}.lineitem from file paths '{{ dataimport_tpch_s3_path }}/lineitem.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);

