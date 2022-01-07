CREATE DATA SOURCE s3_kinetica_benchmark
LOCATION = 'S3://'
USER = '{{ dataimport_s3_user }}'
PASSWORD = '{{ dataimport_s3_password }}'
WITH OPTIONS
(
    BUCKET NAME = '{{ dataimport_s3_bucket_name }}',
    REGION = '{{ dataimport_s3_region }}'
);

-- No deps
copy into {{ omnisci_tpcds_schema }}.dbgen_version from file paths '{{ dataimport_tpcds_s3_path }}/dbgen_version.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.time_dim from file paths '{{ dataimport_tpcds_s3_path }}/time_dim.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.date_dim from file paths '{{ dataimport_tpcds_s3_path }}/date_dim.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.income_band from file paths '{{ dataimport_tpcds_s3_path }}/income_band.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.reason from file paths '{{ dataimport_tpcds_s3_path }}/reason.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.ship_mode from file paths '{{ dataimport_tpcds_s3_path }}/ship_mode.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.customer_address from file paths '{{ dataimport_tpcds_s3_path }}/customer_address.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.customer_demographics from file paths '{{ dataimport_tpcds_s3_path }}/customer_demographics.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.item from file paths '{{ dataimport_tpcds_s3_path }}/item.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.warehouse from file paths '{{ dataimport_tpcds_s3_path }}/warehouse.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);

-- One dep to block above
copy into {{ omnisci_tpcds_schema }}.call_center from file paths '{{ dataimport_tpcds_s3_path }}/call_center.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.catalog_page from file paths '{{ dataimport_tpcds_s3_path }}/catalog_page.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.household_demographics from file paths '{{ dataimport_tpcds_s3_path }}/household_demographics.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.customer from file paths '{{ dataimport_tpcds_s3_path }}/customer.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.promotion from file paths '{{ dataimport_tpcds_s3_path }}/promotion.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.web_site from file paths '{{ dataimport_tpcds_s3_path }}/web_site.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.web_page from file paths '{{ dataimport_tpcds_s3_path }}/web_page.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.store from file paths '{{ dataimport_tpcds_s3_path }}/store.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.inventory from file paths '{{ dataimport_tpcds_s3_path }}/inventory.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);

-- Complex dep
copy into {{ omnisci_tpcds_schema }}.catalog_returns from file paths '{{ dataimport_tpcds_s3_path }}/catalog_returns.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.catalog_sales from file paths '{{ dataimport_tpcds_s3_path }}/catalog_sales.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.store_returns from file paths '{{ dataimport_tpcds_s3_path }}/store_returns.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.store_sales from file paths '{{ dataimport_tpcds_s3_path }}/store_sales.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.web_returns from file paths '{{ dataimport_tpcds_s3_path }}/web_returns.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);
copy into {{ omnisci_tpcds_schema }}.web_sales from file paths '{{ dataimport_tpcds_s3_path }}/web_sales.csv' format text (delimiter '|', includes header = false) with options (data source = 's3_kinetica_benchmark', loading mode = distributed shared);

