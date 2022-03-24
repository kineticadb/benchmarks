# Clickhouse Vs. Kinetica Benchmark

Project was to benchmark CLickhouse against Kinetica for a TPC-DS SF100 query workload.
This repo items contain couple of PDF files with the results of the queries.
This repo also contains the SQL queries used for Clickhouse.

## Random but relevant commands used to load data into Clickhouse
```
CREATE DATABASE tpcdsch ENGINE = Memory COMMENT 'TPCDS DB';

CREATE TABLE tpcdsch.catalog_sales ( \
'cs_sold_date_sk' Int8, \
'cs_sold_time_sk' Int8)\
ENGINE = MergeTree() PARTITION BY (cs_sold_date_sk) ORDER BY (cs_sold_time_sk) SETTINGS index_granularity = 8192;

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/catalog_sales.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.catalog_sales FORMAT CSV" < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/call_center.csv; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.call_center FORMAT CSV" < $filename; done)
 
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/date_dim.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.date_dim FORMAT CSV" --max_partitions_per_insert_block=0 < $filename; done) 

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/household_demographics.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.household_demographics FORMAT CSV" < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/item.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.item FORMAT CSV"  --max_partitions_per_insert_block=0 < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/store.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.store FORMAT CSV"  --max_partitions_per_insert_block=50< $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/store_sales.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.store_sales FORMAT CSV" < $filename; done)

clickhouse-client --format_csv_delimiter="|" -m
set max_partitions_per_insert_block=10000;
INSERT INTO tpcdsch.store_sales FROM INFILE '/mapr/data/qe/tpc/tpc-ds/s100/123120192359/store_sales.dat' FORMAT CSV;

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/web_sales.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.web_sales FORMAT CSV" < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/customer.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.customer FORMAT CSV"  --max_partitions_per_insert_block=0   --input_format_allow_errors_num=10000000 < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/customer_demographics.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.customer_demographics FORMAT CSV" < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/promotion.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.promotion FORMAT CSV" < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/store_returns.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.store_returns FORMAT CSV" < $filename; done)

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/customer_address.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcdsch.customer_address FORMAT CSV" < $filename; done)

```