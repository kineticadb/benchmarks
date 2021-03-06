use database {{ snowflake_tpcds_database }};
create or replace schema {{ snowflake_tpcds_schema }};

create or replace TABLE {{ snowflake_tpcds_schema }}.CALL_CENTER cluster by LINEAR(CC_CALL_CENTER_SK)(
	CC_CALL_CENTER_SK NUMBER(38,0) NOT NULL,
	CC_CALL_CENTER_ID VARCHAR(16) NOT NULL,
	CC_REC_START_DATE DATE,
	CC_REC_END_DATE DATE,
	CC_CLOSED_DATE_SK NUMBER(38,0),
	CC_OPEN_DATE_SK NUMBER(38,0),
	CC_NAME VARCHAR(50),
	CC_CLASS VARCHAR(50),
	CC_EMPLOYEES NUMBER(38,0),
	CC_SQ_FT NUMBER(38,0),
	CC_HOURS VARCHAR(20),
	CC_MANAGER VARCHAR(40),
	CC_MKT_ID NUMBER(38,0),
	CC_MKT_CLASS VARCHAR(50),
	CC_MKT_DESC VARCHAR(100),
	CC_MARKET_MANAGER VARCHAR(40),
	CC_DIVISION NUMBER(38,0),
	CC_DIVISION_NAME VARCHAR(50),
	CC_COMPANY NUMBER(38,0),
	CC_COMPANY_NAME VARCHAR(50),
	CC_STREET_NUMBER VARCHAR(10),
	CC_STREET_NAME VARCHAR(60),
	CC_STREET_TYPE VARCHAR(15),
	CC_SUITE_NUMBER VARCHAR(10),
	CC_CITY VARCHAR(60),
	CC_COUNTY VARCHAR(30),
	CC_STATE VARCHAR(2),
	CC_ZIP VARCHAR(10),
	CC_COUNTRY VARCHAR(20),
	CC_GMT_OFFSET NUMBER(5,2),
	CC_TAX_PERCENTAGE NUMBER(5,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.CATALOG_PAGE cluster by LINEAR(CP_CATALOG_PAGE_SK)(
	CP_CATALOG_PAGE_SK NUMBER(38,0) NOT NULL,
	CP_CATALOG_PAGE_ID VARCHAR(16) NOT NULL,
	CP_START_DATE_SK NUMBER(38,0),
	CP_END_DATE_SK NUMBER(38,0),
	CP_DEPARTMENT VARCHAR(50),
	CP_CATALOG_NUMBER NUMBER(38,0),
	CP_CATALOG_PAGE_NUMBER NUMBER(38,0),
	CP_DESCRIPTION VARCHAR(100),
	CP_TYPE VARCHAR(100)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.CATALOG_RETURNS cluster by LINEAR(CR_RETURNED_DATE_SK, CR_ITEM_SK)(
	CR_RETURNED_DATE_SK NUMBER(38,0),
	CR_RETURNED_TIME_SK NUMBER(38,0),
	CR_ITEM_SK NUMBER(38,0) NOT NULL,
	CR_REFUNDED_CUSTOMER_SK NUMBER(38,0),
	CR_REFUNDED_CDEMO_SK NUMBER(38,0),
	CR_REFUNDED_HDEMO_SK NUMBER(38,0),
	CR_REFUNDED_ADDR_SK NUMBER(38,0),
	CR_RETURNING_CUSTOMER_SK NUMBER(38,0),
	CR_RETURNING_CDEMO_SK NUMBER(38,0),
	CR_RETURNING_HDEMO_SK NUMBER(38,0),
	CR_RETURNING_ADDR_SK NUMBER(38,0),
	CR_CALL_CENTER_SK NUMBER(38,0),
	CR_CATALOG_PAGE_SK NUMBER(38,0),
	CR_SHIP_MODE_SK NUMBER(38,0),
	CR_WAREHOUSE_SK NUMBER(38,0),
	CR_REASON_SK NUMBER(38,0),
	CR_ORDER_NUMBER NUMBER(38,0) NOT NULL,
	CR_RETURN_QUANTITY NUMBER(38,0),
	CR_RETURN_AMOUNT NUMBER(7,2),
	CR_RETURN_TAX NUMBER(7,2),
	CR_RETURN_AMT_INC_TAX NUMBER(7,2),
	CR_FEE NUMBER(7,2),
	CR_RETURN_SHIP_COST NUMBER(7,2),
	CR_REFUNDED_CASH NUMBER(7,2),
	CR_REVERSED_CHARGE NUMBER(7,2),
	CR_STORE_CREDIT NUMBER(7,2),
	CR_NET_LOSS NUMBER(7,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.CATALOG_SALES cluster by LINEAR(CS_SOLD_DATE_SK, CS_ITEM_SK)(
	CS_SOLD_DATE_SK NUMBER(38,0),
	CS_SOLD_TIME_SK NUMBER(38,0),
	CS_SHIP_DATE_SK NUMBER(38,0),
	CS_BILL_CUSTOMER_SK NUMBER(38,0),
	CS_BILL_CDEMO_SK NUMBER(38,0),
	CS_BILL_HDEMO_SK NUMBER(38,0),
	CS_BILL_ADDR_SK NUMBER(38,0),
	CS_SHIP_CUSTOMER_SK NUMBER(38,0),
	CS_SHIP_CDEMO_SK NUMBER(38,0),
	CS_SHIP_HDEMO_SK NUMBER(38,0),
	CS_SHIP_ADDR_SK NUMBER(38,0),
	CS_CALL_CENTER_SK NUMBER(38,0),
	CS_CATALOG_PAGE_SK NUMBER(38,0),
	CS_SHIP_MODE_SK NUMBER(38,0),
	CS_WAREHOUSE_SK NUMBER(38,0),
	CS_ITEM_SK NUMBER(38,0) NOT NULL,
	CS_PROMO_SK NUMBER(38,0),
	CS_ORDER_NUMBER NUMBER(38,0) NOT NULL,
	CS_QUANTITY NUMBER(38,0),
	CS_WHOLESALE_COST NUMBER(7,2),
	CS_LIST_PRICE NUMBER(7,2),
	CS_SALES_PRICE NUMBER(7,2),
	CS_EXT_DISCOUNT_AMT NUMBER(7,2),
	CS_EXT_SALES_PRICE NUMBER(7,2),
	CS_EXT_WHOLESALE_COST NUMBER(7,2),
	CS_EXT_LIST_PRICE NUMBER(7,2),
	CS_EXT_TAX NUMBER(7,2),
	CS_COUPON_AMT NUMBER(7,2),
	CS_EXT_SHIP_COST NUMBER(7,2),
	CS_NET_PAID NUMBER(7,2),
	CS_NET_PAID_INC_TAX NUMBER(7,2),
	CS_NET_PAID_INC_SHIP NUMBER(7,2),
	CS_NET_PAID_INC_SHIP_TAX NUMBER(7,2),
	CS_NET_PROFIT NUMBER(7,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.CUSTOMER cluster by LINEAR(C_CUSTOMER_SK)(
	C_CUSTOMER_SK NUMBER(38,0) NOT NULL,
	C_CUSTOMER_ID VARCHAR(16) NOT NULL,
	C_CURRENT_CDEMO_SK NUMBER(38,0),
	C_CURRENT_HDEMO_SK NUMBER(38,0),
	C_CURRENT_ADDR_SK NUMBER(38,0),
	C_FIRST_SHIPTO_DATE_SK NUMBER(38,0),
	C_FIRST_SALES_DATE_SK NUMBER(38,0),
	C_SALUTATION VARCHAR(10),
	C_FIRST_NAME VARCHAR(20),
	C_LAST_NAME VARCHAR(30),
	C_PREFERRED_CUST_FLAG VARCHAR(1),
	C_BIRTH_DAY NUMBER(38,0),
	C_BIRTH_MONTH NUMBER(38,0),
	C_BIRTH_YEAR NUMBER(38,0),
	C_BIRTH_COUNTRY VARCHAR(20),
	C_LOGIN VARCHAR(13),
	C_EMAIL_ADDRESS VARCHAR(50),
	C_LAST_REVIEW_DATE VARCHAR(10)
);

create or replace TABLE {{ snowflake_tpcds_schema }}.CUSTOMER_ADDRESS cluster by LINEAR(CA_ADDRESS_SK)(
	CA_ADDRESS_SK NUMBER(38,0) NOT NULL,
	CA_ADDRESS_ID VARCHAR(16) NOT NULL,
	CA_STREET_NUMBER VARCHAR(10),
	CA_STREET_NAME VARCHAR(60),
	CA_STREET_TYPE VARCHAR(15),
	CA_SUITE_NUMBER VARCHAR(10),
	CA_CITY VARCHAR(60),
	CA_COUNTY VARCHAR(30),
	CA_STATE VARCHAR(2),
	CA_ZIP VARCHAR(10),
	CA_COUNTRY VARCHAR(20),
	CA_GMT_OFFSET NUMBER(5,2),
	CA_LOCATION_TYPE VARCHAR(20)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.CUSTOMER_DEMOGRAPHICS cluster by LINEAR(CD_DEMO_SK)(
	CD_DEMO_SK NUMBER(38,0) NOT NULL,
	CD_GENDER VARCHAR(1),
	CD_MARITAL_STATUS VARCHAR(1),
	CD_EDUCATION_STATUS VARCHAR(20),
	CD_PURCHASE_ESTIMATE NUMBER(38,0),
	CD_CREDIT_RATING VARCHAR(10),
	CD_DEP_COUNT NUMBER(38,0),
	CD_DEP_EMPLOYED_COUNT NUMBER(38,0),
	CD_DEP_COLLEGE_COUNT NUMBER(38,0)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.DATE_DIM cluster by LINEAR(D_DATE_SK)(
	D_DATE_SK NUMBER(38,0) NOT NULL,
	D_DATE_ID VARCHAR(16) NOT NULL,
	D_DATE DATE,
	D_MONTH_SEQ NUMBER(38,0),
	D_WEEK_SEQ NUMBER(38,0),
	D_QUARTER_SEQ NUMBER(38,0),
	D_YEAR NUMBER(38,0),
	D_DOW NUMBER(38,0),
	D_MOY NUMBER(38,0),
	D_DOM NUMBER(38,0),
	D_QOY NUMBER(38,0),
	D_FY_YEAR NUMBER(38,0),
	D_FY_QUARTER_SEQ NUMBER(38,0),
	D_FY_WEEK_SEQ NUMBER(38,0),
	D_DAY_NAME VARCHAR(9),
	D_QUARTER_NAME VARCHAR(6),
	D_HOLIDAY VARCHAR(1),
	D_WEEKEND VARCHAR(1),
	D_FOLLOWING_HOLIDAY VARCHAR(1),
	D_FIRST_DOM NUMBER(38,0),
	D_LAST_DOM NUMBER(38,0),
	D_SAME_DAY_LY NUMBER(38,0),
	D_SAME_DAY_LQ NUMBER(38,0),
	D_CURRENT_DAY VARCHAR(1),
	D_CURRENT_WEEK VARCHAR(1),
	D_CURRENT_MONTH VARCHAR(1),
	D_CURRENT_QUARTER VARCHAR(1),
	D_CURRENT_YEAR VARCHAR(1)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.DBGEN_VERSION (
	DV_VERSION VARCHAR(16),
	DV_CREATE_DATE DATE,
	DV_CREATE_TIME VARCHAR(10),
	DV_CMDLINE_ARGS VARCHAR(200)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.HOUSEHOLD_DEMOGRAPHICS cluster by LINEAR(HD_DEMO_SK)(
	HD_DEMO_SK NUMBER(38,0) NOT NULL,
	HD_INCOME_BAND_SK NUMBER(38,0),
	HD_BUY_POTENTIAL VARCHAR(15),
	HD_DEP_COUNT NUMBER(38,0),
	HD_VEHICLE_COUNT NUMBER(38,0)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.INCOME_BAND cluster by LINEAR(IB_INCOME_BAND_SK)(
	IB_INCOME_BAND_SK NUMBER(38,0) NOT NULL,
	IB_LOWER_BOUND NUMBER(38,0),
	IB_UPPER_BOUND NUMBER(38,0)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.INVENTORY cluster by LINEAR(INV_DATE_SK, INV_ITEM_SK)(
	INV_DATE_SK NUMBER(38,0) NOT NULL,
	INV_ITEM_SK NUMBER(38,0) NOT NULL,
	INV_WAREHOUSE_SK NUMBER(38,0) NOT NULL,
	INV_QUANTITY_ON_HAND NUMBER(38,0)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.ITEM cluster by LINEAR(I_ITEM_SK)(
	I_ITEM_SK NUMBER(38,0) NOT NULL,
	I_ITEM_ID VARCHAR(16) NOT NULL,
	I_REC_START_DATE DATE,
	I_REC_END_DATE DATE,
	I_ITEM_DESC VARCHAR(200),
	I_CURRENT_PRICE NUMBER(7,2),
	I_WHOLESALE_COST NUMBER(7,2),
	I_BRAND_ID NUMBER(38,0),
	I_BRAND VARCHAR(50),
	I_CLASS_ID NUMBER(38,0),
	I_CLASS VARCHAR(50),
	I_CATEGORY_ID NUMBER(38,0),
	I_CATEGORY VARCHAR(50),
	I_MANUFACT_ID NUMBER(38,0),
	I_MANUFACT VARCHAR(50),
	I_SIZE VARCHAR(20),
	I_FORMULATION VARCHAR(20),
	I_COLOR VARCHAR(20),
	I_UNITS VARCHAR(10),
	I_CONTAINER VARCHAR(10),
	I_MANAGER_ID NUMBER(38,0),
	I_PRODUCT_NAME VARCHAR(50)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.PROMOTION cluster by LINEAR(P_PROMO_SK)(
	P_PROMO_SK NUMBER(38,0) NOT NULL,
	P_PROMO_ID VARCHAR(16) NOT NULL,
	P_START_DATE_SK NUMBER(38,0),
	P_END_DATE_SK NUMBER(38,0),
	P_ITEM_SK NUMBER(38,0),
	P_COST NUMBER(15,2),
	P_RESPONSE_TARGET NUMBER(38,0),
	P_PROMO_NAME VARCHAR(50),
	P_CHANNEL_DMAIL VARCHAR(1),
	P_CHANNEL_EMAIL VARCHAR(1),
	P_CHANNEL_CATALOG VARCHAR(1),
	P_CHANNEL_TV VARCHAR(1),
	P_CHANNEL_RADIO VARCHAR(1),
	P_CHANNEL_PRESS VARCHAR(1),
	P_CHANNEL_EVENT VARCHAR(1),
	P_CHANNEL_DEMO VARCHAR(1),
	P_CHANNEL_DETAILS VARCHAR(100),
	P_PURPOSE VARCHAR(15),
	P_DISCOUNT_ACTIVE VARCHAR(1)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.REASON cluster by LINEAR(R_REASON_SK)(
	R_REASON_SK NUMBER(38,0) NOT NULL,
	R_REASON_ID VARCHAR(16) NOT NULL,
	R_REASON_DESC VARCHAR(100)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.SHIP_MODE cluster by LINEAR(SM_SHIP_MODE_SK)(
	SM_SHIP_MODE_SK NUMBER(38,0) NOT NULL,
	SM_SHIP_MODE_ID VARCHAR(16) NOT NULL,
	SM_TYPE VARCHAR(30),
	SM_CODE VARCHAR(10),
	SM_CARRIER VARCHAR(20),
	SM_CONTRACT VARCHAR(20)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.STORE cluster by LINEAR(S_STORE_SK)(
	S_STORE_SK NUMBER(38,0) NOT NULL,
	S_STORE_ID VARCHAR(16) NOT NULL,
	S_REC_START_DATE DATE,
	S_REC_END_DATE DATE,
	S_CLOSED_DATE_SK NUMBER(38,0),
	S_STORE_NAME VARCHAR(50),
	S_NUMBER_EMPLOYEES NUMBER(38,0),
	S_FLOOR_SPACE NUMBER(38,0),
	S_HOURS VARCHAR(20),
	S_MANAGER VARCHAR(40),
	S_MARKET_ID NUMBER(38,0),
	S_GEOGRAPHY_CLASS VARCHAR(100),
	S_MARKET_DESC VARCHAR(100),
	S_MARKET_MANAGER VARCHAR(40),
	S_DIVISION_ID NUMBER(38,0),
	S_DIVISION_NAME VARCHAR(50),
	S_COMPANY_ID NUMBER(38,0),
	S_COMPANY_NAME VARCHAR(50),
	S_STREET_NUMBER VARCHAR(10),
	S_STREET_NAME VARCHAR(60),
	S_STREET_TYPE VARCHAR(15),
	S_SUITE_NUMBER VARCHAR(10),
	S_CITY VARCHAR(60),
	S_COUNTY VARCHAR(30),
	S_STATE VARCHAR(2),
	S_ZIP VARCHAR(10),
	S_COUNTRY VARCHAR(20),
	S_GMT_OFFSET NUMBER(5,2),
	S_TAX_PRECENTAGE NUMBER(5,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.STORE_RETURNS cluster by LINEAR(SR_RETURNED_DATE_SK, SR_ITEM_SK)(
	SR_RETURNED_DATE_SK NUMBER(38,0),
	SR_RETURN_TIME_SK NUMBER(38,0),
	SR_ITEM_SK NUMBER(38,0) NOT NULL,
	SR_CUSTOMER_SK NUMBER(38,0),
	SR_CDEMO_SK NUMBER(38,0),
	SR_HDEMO_SK NUMBER(38,0),
	SR_ADDR_SK NUMBER(38,0),
	SR_STORE_SK NUMBER(38,0),
	SR_REASON_SK NUMBER(38,0),
	SR_TICKET_NUMBER NUMBER(38,0) NOT NULL,
	SR_RETURN_QUANTITY NUMBER(38,0),
	SR_RETURN_AMT NUMBER(7,2),
	SR_RETURN_TAX NUMBER(7,2),
	SR_RETURN_AMT_INC_TAX NUMBER(7,2),
	SR_FEE NUMBER(7,2),
	SR_RETURN_SHIP_COST NUMBER(7,2),
	SR_REFUNDED_CASH NUMBER(7,2),
	SR_REVERSED_CHARGE NUMBER(7,2),
	SR_STORE_CREDIT NUMBER(7,2),
	SR_NET_LOSS NUMBER(7,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.STORE_SALES cluster by LINEAR(SS_SOLD_DATE_SK, SS_ITEM_SK)(
	SS_SOLD_DATE_SK NUMBER(38,0),
	SS_SOLD_TIME_SK NUMBER(38,0),
	SS_ITEM_SK NUMBER(38,0) NOT NULL,
	SS_CUSTOMER_SK NUMBER(38,0),
	SS_CDEMO_SK NUMBER(38,0),
	SS_HDEMO_SK NUMBER(38,0),
	SS_ADDR_SK NUMBER(38,0),
	SS_STORE_SK NUMBER(38,0),
	SS_PROMO_SK NUMBER(38,0),
	SS_TICKET_NUMBER NUMBER(38,0) NOT NULL,
	SS_QUANTITY NUMBER(38,0),
	SS_WHOLESALE_COST NUMBER(7,2),
	SS_LIST_PRICE NUMBER(7,2),
	SS_SALES_PRICE NUMBER(7,2),
	SS_EXT_DISCOUNT_AMT NUMBER(7,2),
	SS_EXT_SALES_PRICE NUMBER(7,2),
	SS_EXT_WHOLESALE_COST NUMBER(7,2),
	SS_EXT_LIST_PRICE NUMBER(7,2),
	SS_EXT_TAX NUMBER(7,2),
	SS_COUPON_AMT NUMBER(7,2),
	SS_NET_PAID NUMBER(7,2),
	SS_NET_PAID_INC_TAX NUMBER(7,2),
	SS_NET_PROFIT NUMBER(7,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.TIME_DIM cluster by LINEAR(T_TIME_SK)(
	T_TIME_SK NUMBER(38,0) NOT NULL,
	T_TIME_ID VARCHAR(16) NOT NULL,
	T_TIME NUMBER(38,0),
	T_HOUR NUMBER(38,0),
	T_MINUTE NUMBER(38,0),
	T_SECOND NUMBER(38,0),
	T_AM_PM VARCHAR(2),
	T_SHIFT VARCHAR(20),
	T_SUB_SHIFT VARCHAR(20),
	T_MEAL_TIME VARCHAR(20)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.WAREHOUSE cluster by LINEAR(W_WAREHOUSE_SK)(
	W_WAREHOUSE_SK NUMBER(38,0) NOT NULL,
	W_WAREHOUSE_ID VARCHAR(16) NOT NULL,
	W_WAREHOUSE_NAME VARCHAR(20),
	W_WAREHOUSE_SQ_FT NUMBER(38,0),
	W_STREET_NUMBER VARCHAR(10),
	W_STREET_NAME VARCHAR(60),
	W_STREET_TYPE VARCHAR(15),
	W_SUITE_NUMBER VARCHAR(10),
	W_CITY VARCHAR(60),
	W_COUNTY VARCHAR(30),
	W_STATE VARCHAR(2),
	W_ZIP VARCHAR(10),
	W_COUNTRY VARCHAR(20),
	W_GMT_OFFSET NUMBER(5,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.WEB_PAGE cluster by LINEAR(WP_WEB_PAGE_SK)(
	WP_WEB_PAGE_SK NUMBER(38,0) NOT NULL,
	WP_WEB_PAGE_ID VARCHAR(16) NOT NULL,
	WP_REC_START_DATE DATE,
	WP_REC_END_DATE DATE,
	WP_CREATION_DATE_SK NUMBER(38,0),
	WP_ACCESS_DATE_SK NUMBER(38,0),
	WP_AUTOGEN_FLAG VARCHAR(1),
	WP_CUSTOMER_SK NUMBER(38,0),
	WP_URL VARCHAR(100),
	WP_TYPE VARCHAR(50),
	WP_CHAR_COUNT NUMBER(38,0),
	WP_LINK_COUNT NUMBER(38,0),
	WP_IMAGE_COUNT NUMBER(38,0),
	WP_MAX_AD_COUNT NUMBER(38,0)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.WEB_RETURNS cluster by LINEAR(WR_RETURNED_DATE_SK, WR_ITEM_SK)(
	WR_RETURNED_DATE_SK NUMBER(38,0),
	WR_RETURNED_TIME_SK NUMBER(38,0),
	WR_ITEM_SK NUMBER(38,0) NOT NULL,
	WR_REFUNDED_CUSTOMER_SK NUMBER(38,0),
	WR_REFUNDED_CDEMO_SK NUMBER(38,0),
	WR_REFUNDED_HDEMO_SK NUMBER(38,0),
	WR_REFUNDED_ADDR_SK NUMBER(38,0),
	WR_RETURNING_CUSTOMER_SK NUMBER(38,0),
	WR_RETURNING_CDEMO_SK NUMBER(38,0),
	WR_RETURNING_HDEMO_SK NUMBER(38,0),
	WR_RETURNING_ADDR_SK NUMBER(38,0),
	WR_WEB_PAGE_SK NUMBER(38,0),
	WR_REASON_SK NUMBER(38,0),
	WR_ORDER_NUMBER NUMBER(38,0) NOT NULL,
	WR_RETURN_QUANTITY NUMBER(38,0),
	WR_RETURN_AMT NUMBER(7,2),
	WR_RETURN_TAX NUMBER(7,2),
	WR_RETURN_AMT_INC_TAX NUMBER(7,2),
	WR_FEE NUMBER(7,2),
	WR_RETURN_SHIP_COST NUMBER(7,2),
	WR_REFUNDED_CASH NUMBER(7,2),
	WR_REVERSED_CHARGE NUMBER(7,2),
	WR_ACCOUNT_CREDIT NUMBER(7,2),
	WR_NET_LOSS NUMBER(7,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.WEB_SALES cluster by LINEAR(WS_SOLD_DATE_SK, WS_ITEM_SK)(
	WS_SOLD_DATE_SK NUMBER(38,0),
	WS_SOLD_TIME_SK NUMBER(38,0),
	WS_SHIP_DATE_SK NUMBER(38,0),
	WS_ITEM_SK NUMBER(38,0) NOT NULL,
	WS_BILL_CUSTOMER_SK NUMBER(38,0),
	WS_BILL_CDEMO_SK NUMBER(38,0),
	WS_BILL_HDEMO_SK NUMBER(38,0),
	WS_BILL_ADDR_SK NUMBER(38,0),
	WS_SHIP_CUSTOMER_SK NUMBER(38,0),
	WS_SHIP_CDEMO_SK NUMBER(38,0),
	WS_SHIP_HDEMO_SK NUMBER(38,0),
	WS_SHIP_ADDR_SK NUMBER(38,0),
	WS_WEB_PAGE_SK NUMBER(38,0),
	WS_WEB_SITE_SK NUMBER(38,0),
	WS_SHIP_MODE_SK NUMBER(38,0),
	WS_WAREHOUSE_SK NUMBER(38,0),
	WS_PROMO_SK NUMBER(38,0),
	WS_ORDER_NUMBER NUMBER(38,0) NOT NULL,
	WS_QUANTITY NUMBER(38,0),
	WS_WHOLESALE_COST NUMBER(7,2),
	WS_LIST_PRICE NUMBER(7,2),
	WS_SALES_PRICE NUMBER(7,2),
	WS_EXT_DISCOUNT_AMT NUMBER(7,2),
	WS_EXT_SALES_PRICE NUMBER(7,2),
	WS_EXT_WHOLESALE_COST NUMBER(7,2),
	WS_EXT_LIST_PRICE NUMBER(7,2),
	WS_EXT_TAX NUMBER(7,2),
	WS_COUPON_AMT NUMBER(7,2),
	WS_EXT_SHIP_COST NUMBER(7,2),
	WS_NET_PAID NUMBER(7,2),
	WS_NET_PAID_INC_TAX NUMBER(7,2),
	WS_NET_PAID_INC_SHIP NUMBER(7,2),
	WS_NET_PAID_INC_SHIP_TAX NUMBER(7,2),
	WS_NET_PROFIT NUMBER(7,2)
);
create or replace TABLE {{ snowflake_tpcds_schema }}.WEB_SITE cluster by LINEAR(WEB_SITE_SK)(
	WEB_SITE_SK NUMBER(38,0) NOT NULL,
	WEB_SITE_ID VARCHAR(16) NOT NULL,
	WEB_REC_START_DATE DATE,
	WEB_REC_END_DATE DATE,
	WEB_NAME VARCHAR(50),
	WEB_OPEN_DATE_SK NUMBER(38,0),
	WEB_CLOSE_DATE_SK NUMBER(38,0),
	WEB_CLASS VARCHAR(50),
	WEB_MANAGER VARCHAR(40),
	WEB_MKT_ID NUMBER(38,0),
	WEB_MKT_CLASS VARCHAR(50),
	WEB_MKT_DESC VARCHAR(100),
	WEB_MARKET_MANAGER VARCHAR(40),
	WEB_COMPANY_ID NUMBER(38,0),
	WEB_COMPANY_NAME VARCHAR(50),
	WEB_STREET_NUMBER VARCHAR(10),
	WEB_STREET_NAME VARCHAR(60),
	WEB_STREET_TYPE VARCHAR(15),
	WEB_SUITE_NUMBER VARCHAR(10),
	WEB_CITY VARCHAR(60),
	WEB_COUNTY VARCHAR(30),
	WEB_STATE VARCHAR(2),
	WEB_ZIP VARCHAR(10),
	WEB_COUNTRY VARCHAR(20),
	WEB_GMT_OFFSET NUMBER(5,2),
	WEB_TAX_PERCENTAGE NUMBER(5,2)
);