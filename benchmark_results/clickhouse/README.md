# Clickhouse Vs. Kinetica Benchmark

Project was to benchmark CLickhouse against Kinetica for a TPC-DS SF100 query workload.
This repo items contain couple of PDF files with the results of the queries.
This repo also contains the SQL queries used for Clickhouse.

# Single Node Specs

```
[kinuser@g-300-301-u21-k80 ~]$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                56
On-line CPU(s) list:   0-55
Thread(s) per core:    2
Core(s) per socket:    14
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 79
Model name:            Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz
Stepping:              1
CPU MHz:               1200.732
CPU max MHz:           3300.0000
CPU min MHz:           1200.0000
BogoMIPS:              4799.48
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              256K
L3 cache:              35840K
NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54
NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55

[kinuser@g-300-301-u21-k80 ~]$ free -g
              total        used        free      shared  buff/cache   available
Mem:            503         184         298           0          20         317
Swap:             7           0           7

[kinuser@g-300-301-u21-k80 etc]$ df -h | grep /mnt/data
/dev/mapper/vg_data-lv_data                    1.9T  361G  1.6T  19% /mnt/data
(2TB SAMSUNG SSD)

```

## Random but relevant commands used to load data into Clickhouse
```
CREATE DATABASE tpcds ENGINE = Memory COMMENT 'TPCDS DB';

time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/time_dim.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.time_dim FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/date_dim.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.date_dim FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/catalog_page.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.catalog_page FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/catalog_returns.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.catalog_returns FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/catalog_sales.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.catalog_sales FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/customer.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.customer FORMAT CSV"  --max_partitions_per_insert_block=0   --input_format_allow_errors_num=10000000 < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/customer_demographics.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.customer_demographics FORMAT CSV"  --max_partitions_per_insert_block=0   --input_format_allow_errors_num=10000000 < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/customer_address.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.customer_address FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/household_demographics.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.household_demographics FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/income_band.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.income_band FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/inventory.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.inventory FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/call_center.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.call_center FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/item.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.item FORMAT CSV"  --max_partitions_per_insert_block=0 < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/promotion.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.promotion FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/reason.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.reason FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/ship_mode.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.ship_mode FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/store.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.store FORMAT CSV"  --max_partitions_per_insert_block=50< $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/store_returns.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.store_returns FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/store_sales.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.store_sales FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/warehouse.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.warehouse FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/web_page.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.web_page FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/web_returns.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.web_returns FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/web_sales.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.web_sales FORMAT CSV" < $filename; done)
time (for filename in /mapr/data/qe/tpc/tpc-ds/s100/123120192359/web_site.dat; do clickhouse-client --format_csv_delimiter="|" --query="INSERT INTO tpcds.web_site FORMAT CSV" < $filename; done)


```