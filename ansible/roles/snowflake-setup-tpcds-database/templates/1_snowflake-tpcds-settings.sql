create warehouse if not exists BENCHMARK_WH_XSMALL with warehouse_size=XSMALL initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_SMALL with warehouse_size=SMALL initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_MEDIUM with warehouse_size=MEDIUM initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_LARGE with warehouse_size=LARGE initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_XLARGE with warehouse_size=XLARGE initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_XXLARGE with warehouse_size=XXLARGE initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_XXXLARGE with warehouse_size=XXXLARGE initially_suspended=true max_cluster_count=1 auto_suspend=180;
create warehouse if not exists BENCHMARK_WH_X4LARGE with warehouse_size=X4LARGE initially_suspended=true max_cluster_count=1 auto_suspend=180;

create database if not exists {{ snowflake_tpcds_database }};