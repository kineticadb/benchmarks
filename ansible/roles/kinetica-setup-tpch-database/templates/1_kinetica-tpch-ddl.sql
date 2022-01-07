DROP SCHEMA IF EXISTS {{ kinetica_tpch_schema }} CASCADE;
CREATE SCHEMA {{ kinetica_tpch_schema }};

CREATE or REPLACE REPLICATED TABLE "{{ kinetica_tpch_schema }}"."region"
(
   R_REGIONKEY INTEGER (primary_key) NOT NULL,
   R_NAME VARCHAR (32, DICT) NOT NULL,
   R_COMMENT VARCHAR (store_only) NOT NULL
);

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpch_schema }}"."nation"
(
    N_NATIONKEY INTEGER (primary_key) NOT NULL,
    N_NAME  VARCHAR (32, DICT) NOT NULL,
    N_REGIONKEY  INTEGER NOT NULL,
    N_COMMENT  VARCHAR (store_only) NOT NULL
);

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpch_schema }}"."supplier"
(
   S_SUPPKEY INTEGER (primary_key) NOT NULL,
   S_NAME VARCHAR (32) NOT NULL,
   S_ADDRESS VARCHAR (64) NOT NULL,
   S_NATIONKEY INTEGER NOT NULL,
   S_PHONE VARCHAR (16) NOT NULL,
   S_ACCTBAL DECIMAL(18,4) NOT NULL,
   S_COMMENT VARCHAR (128) NOT NULL
);

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpch_schema }}"."customer"
(
   C_CUSTKEY INTEGER (primary_key) NOT NULL,
   C_NAME VARCHAR (32) NOT NULL,
   C_ADDRESS VARCHAR (64) NOT NULL,
   C_NATIONKEY INTEGER NOT NULL,
   C_PHONE VARCHAR (16) NOT NULL,
   C_ACCTBAL DECIMAL(18,4) NOT NULL,
   C_MKTSEGMENT VARCHAR (16, DICT) NOT NULL,
   C_COMMENT VARCHAR (128) NOT NULL
);

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpch_schema }}"."part"
(
    P_PARTKEY  INTEGER (primary_key) NOT NULL,
    P_NAME  VARCHAR (64, DICT) NOT NULL,
    P_MFGR  VARCHAR (32, DICT) NOT NULL,
    P_BRAND  VARCHAR (16, DICT) NOT NULL,
    P_TYPE  VARCHAR (32, DICT) NOT NULL,
    P_SIZE  INTEGER NOT NULL,
    P_CONTAINER  VARCHAR (16, DICT) NOT NULL,
    P_RETAILPRICE  DECIMAL(18,4) NOT NULL,
    P_COMMENT  VARCHAR (store_only) NOT NULL
);

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpch_schema }}"."partsupp"
(
   PS_PARTKEY INTEGER (primary_key) NOT NULL,
   PS_SUPPKEY INTEGER (primary_key) NOT NULL,
   PS_AVAILQTY INTEGER NOT NULL,
   PS_SUPPLYCOST DECIMAL(18,4) NOT NULL,
   PS_COMMENT VARCHAR (store_only) NOT NULL
);

CREATE or REPLACE TABLE "{{ kinetica_tpch_schema }}"."orders"
(
   O_ORDERKEY INTEGER (primary_key) NOT NULL,
   O_CUSTKEY INTEGER NOT NULL,
   O_ORDERSTATUS VARCHAR (1) NOT NULL,
   O_TOTALPRICE DECIMAL(18,4) NOT NULL,
   O_ORDERDATE DATE NOT NULL,
   O_ORDERPRIORITY VARCHAR (16, DICT) NOT NULL,
   O_CLERK VARCHAR (16, DICT) NOT NULL,
   O_SHIPPRIORITY INTEGER NOT NULL,
   O_COMMENT VARCHAR (128) NOT NULL
);

CREATE OR REPLACE TABLE "{{ kinetica_tpch_schema }}"."lineitem"
(
   L_ORDERKEY INTEGER (primary_key, shard_key) NOT NULL,
   L_PARTKEY INTEGER NOT NULL,
   L_SUPPKEY INTEGER NOT NULL,
   L_LINENUMBER INTEGER (primary_key) NOT NULL,
   L_QUANTITY DECIMAL(18,4) NOT NULL,
   L_EXTENDEDPRICE DECIMAL(18,4) NOT NULL,
   L_DISCOUNT DECIMAL(18,4) NOT NULL,
   L_TAX DECIMAL(18,4) NOT NULL,
   L_RETURNFLAG VARCHAR (1) NOT NULL,
   L_LINESTATUS VARCHAR (1) NOT NULL,
   L_SHIPDATE DATE NOT NULL,
   L_COMMITDATE DATE NOT NULL,
   L_RECEIPTDATE DATE NOT NULL,
   L_SHIPINSTRUCT VARCHAR (32, DICT) NOT NULL,
   L_SHIPMODE VARCHAR (16, DICT) NOT NULL,
   L_COMMENT VARCHAR (store_only) NOT NULL
);

alter table {{ kinetica_tpch_schema }}.nation add foreign key (N_REGIONKEY) references {{ kinetica_tpch_schema }}.region (R_REGIONKEY);
alter table {{ kinetica_tpch_schema }}.supplier add foreign key (S_NATIONKEY) references {{ kinetica_tpch_schema }}.nation (N_NATIONKEY);
alter table {{ kinetica_tpch_schema }}.customer add foreign key (C_NATIONKEY) references {{ kinetica_tpch_schema }}.nation (N_NATIONKEY);
alter table {{ kinetica_tpch_schema }}.partsupp add foreign key (PS_PARTKEY) references {{ kinetica_tpch_schema }}.part (P_PARTKEY);
alter table {{ kinetica_tpch_schema }}.partsupp add foreign key (PS_SUPPKEY) references {{ kinetica_tpch_schema }}.supplier (S_SUPPKEY);
alter table {{ kinetica_tpch_schema }}.orders add foreign key (O_CUSTKEY) references {{ kinetica_tpch_schema }}.customer (C_CUSTKEY);
alter table {{ kinetica_tpch_schema }}.lineitem add foreign key (L_ORDERKEY) references {{ kinetica_tpch_schema }}.orders (O_ORDERKEY);
alter table {{ kinetica_tpch_schema }}.lineitem add foreign key (L_PARTKEY) references {{ kinetica_tpch_schema }}.part (P_PARTKEY);
alter table {{ kinetica_tpch_schema }}.lineitem add foreign key (L_SUPPKEY) references {{ kinetica_tpch_schema }}.supplier (S_SUPPKEY);

