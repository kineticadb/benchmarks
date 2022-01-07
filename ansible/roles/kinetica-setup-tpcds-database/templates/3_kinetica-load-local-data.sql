-- No deps
copy into {{ kinetica_tpcds_schema }}.dbgen_version from file paths '{{ dataimport_tpcds_localfs }}/dbgen_version.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.time_dim from file paths '{{ dataimport_tpcds_localfs }}/time_dim.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.date_dim from file paths '{{ dataimport_tpcds_localfs }}/date_dim.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.income_band from file paths '{{ dataimport_tpcds_localfs }}/income_band.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.reason from file paths '{{ dataimport_tpcds_localfs }}/reason.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.ship_mode from file paths '{{ dataimport_tpcds_localfs }}/ship_mode.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.customer_address from file paths '{{ dataimport_tpcds_localfs }}/customer_address.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.customer_demographics from file paths '{{ dataimport_tpcds_localfs }}/customer_demographics.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.item from file paths '{{ dataimport_tpcds_localfs }}/item.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.warehouse from file paths '{{ dataimport_tpcds_localfs }}/warehouse.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);

-- One dep to block above
copy into {{ kinetica_tpcds_schema }}.call_center from file paths '{{ dataimport_tpcds_localfs }}/call_center.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.catalog_page from file paths '{{ dataimport_tpcds_localfs }}/catalog_page.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.household_demographics from file paths '{{ dataimport_tpcds_localfs }}/household_demographics.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.customer from file paths '{{ dataimport_tpcds_localfs }}/customer.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.promotion from file paths '{{ dataimport_tpcds_localfs }}/promotion.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.web_site from file paths '{{ dataimport_tpcds_localfs }}/web_site.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.web_page from file paths '{{ dataimport_tpcds_localfs }}/web_page.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.store from file paths '{{ dataimport_tpcds_localfs }}/store.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.inventory from file paths '{{ dataimport_tpcds_localfs }}/inventory.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);

-- Complex dep
copy into {{ kinetica_tpcds_schema }}.catalog_returns from file paths '{{ dataimport_tpcds_localfs }}/catalog_returns.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.catalog_sales from file paths '{{ dataimport_tpcds_localfs }}/catalog_sales.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.store_returns from file paths '{{ dataimport_tpcds_localfs }}/store_returns.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.store_sales from file paths '{{ dataimport_tpcds_localfs }}/store_sales.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.web_returns from file paths '{{ dataimport_tpcds_localfs }}/web_returns.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
copy into {{ kinetica_tpcds_schema }}.web_sales from file paths '{{ dataimport_tpcds_localfs }}/web_sales.csv' format text (delimiter '|', includes header = false) with options (loading mode = distributed shared);
