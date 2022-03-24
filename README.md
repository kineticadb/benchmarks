# Benchmark Databases

Project to benchmark different products against TPC-DS and TPC-H.
The benchmark results will be loaded to the machine where the Ansible client runs and stored in the folder configured in jmeter_local_result_path.
The detailed test results can be found in this file: test-results.csv

## Setup JMeter (required to run the benchmarks)
```
ansible-playbook -i jmeter-hosts jmeter-setup.yml
```

## Kinetica

Setup / Install Kinetica
```
ansible-playbook -i kinetica-hosts kinetica-setup.yml
```
Load TPC-DS data
```
ansible-playbook -i kinetica-hosts kinetica-setup-tpcds-database.yml
```
Run TPC-DS Benchmark for Kinetica 
```
ansible-playbook -i kinetica-hosts jmeter-run-kinetica-tpcds.yml
```
Load TPC-H data
```
ansible-playbook -i kinetica-hosts kinetica-setup-tpch-database.yml
```
Run TPC-H Benchmark for Kinetica 
```
ansible-playbook -i kinetica-hosts jmeter-run-kinetica-tpch.yml
```

## Spark

Setup / Install Spark
```
ansible-playbook -i spark3-hosts spark3-setup.yml
```
Load TPC-DS data
```
ansible-playbook -i spark3-hosts spark3-setup-tpcds-database.yml
```
Run TPC-DS Benchmark for Spark3 
```
ansible-playbook -i spark3-hosts jmeter-run-spark3-tpcds.yml
```
Load TPC-H data
```
ansible-playbook -i spark3-hosts spark3-setup-tpch-database.yml
```
Run TPC-H Benchmark for Spark3 
```
ansible-playbook -i spark3-hosts jmeter-run-spark3-tpch.yml
```

## Snowflake

Setup / Install Snowflake client (required to load TPC-DS data)
```
ansible-playbook -i snowflake-hosts snowflake-setup.yml
```
Load TPC-DS data
```
ansible-playbook -i snowflake-hosts snowflake-setup-tpcds-database.yml
```
Run TPC-DS Benchmark for Snowflake 
```
ansible-playbook -i snowflake-hosts jmeter-run-snowflake-tpcds.yml
```
Load TPC-H data
```
ansible-playbook -i snowflake-hosts snowflake-setup-tpch-database.yml
```
Run TPC-H Benchmark for Snowflake 
```
ansible-playbook -i snowflake-hosts jmeter-run-snowflake-tpch.yml
```

## Redshift

Setup / Install Redshift client (required to load TPC-DS data)
```
ansible-playbook -i redshift-hosts redshift-setup.yml
```
Load TPC-DS data
```
ansible-playbook -i redshift-hosts redshift-setup-tpcds-database.yml
```
Run TPC-DS Benchmark for Redshift 
```
ansible-playbook -i redshift-hosts jmeter-run-redshift-tpcds.yml
```

