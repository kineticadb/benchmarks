DROP SCHEMA IF EXISTS {{ kinetica_tpcds_schema }} CASCADE;
CREATE SCHEMA {{ kinetica_tpcds_schema }};

create or replace table "{{ kinetica_tpcds_schema }}"."dbgen_version"
(
    dv_version                varchar(16)                   ,
    dv_create_date            date                          ,
    dv_create_time            time                          ,
    dv_cmdline_args           varchar(256)
);

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."customer_address"
(
   "ca_address_sk" INTEGER (primary_key) NOT NULL,
   "ca_address_id" VARCHAR (16) NOT NULL,
   "ca_street_number" VARCHAR (16),
   "ca_street_name" VARCHAR (64),
   "ca_street_type" VARCHAR (16),
   "ca_suite_number" VARCHAR (16),
   "ca_city" VARCHAR (64, DICT),
   "ca_county" VARCHAR (32, DICT),
   "ca_state" VARCHAR (2, DICT),
   "ca_zip" VARCHAR (16, DICT),
   "ca_country" VARCHAR (32, DICT),
   "ca_gmt_offset" DECIMAL(5,4),
   "ca_location_type" VARCHAR (32, DICT)
)
PARTITION BY HASH (ca_address_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."customer_demographics"
(
   "cd_demo_sk" INTEGER (primary_key) NOT NULL,
   "cd_gender" VARCHAR (1),
   "cd_marital_status" VARCHAR (1),
   "cd_education_status" VARCHAR (32, DICT),
   "cd_purchase_estimate" INTEGER,
   "cd_credit_rating" VARCHAR (16, DICT),
   "cd_dep_count" INTEGER,
   "cd_dep_employed_count" INTEGER,
   "cd_dep_college_count" INTEGER
)
PARTITION BY HASH (cd_demo_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."date_dim"
(
   "d_date_sk" INTEGER (primary_key) NOT NULL,
   "d_date_id" VARCHAR (16) NOT NULL,
   "d_date" DATE,
   "d_month_seq" INTEGER,
   "d_week_seq" INTEGER,
   "d_quarter_seq" INTEGER,
   "d_year" INTEGER,
   "d_dow" INTEGER,
   "d_moy" INTEGER,
   "d_dom" INTEGER,
   "d_qoy" INTEGER,
   "d_fy_year" INTEGER,
   "d_fy_quarter_seq" INTEGER,
   "d_fy_week_seq" INTEGER,
   "d_day_name" VARCHAR (16, DICT),
   "d_quarter_name" VARCHAR (8, DICT),
   "d_holiday" VARCHAR (1),
   "d_weekend" VARCHAR (1),
   "d_following_holiday" VARCHAR (1),
   "d_first_dom" INTEGER,
   "d_last_dom" INTEGER,
   "d_same_day_ly" INTEGER,
   "d_same_day_lq" INTEGER,
   "d_current_day" VARCHAR (1),
   "d_current_week" VARCHAR (1),
   "d_current_month" VARCHAR (1),
   "d_current_quarter" VARCHAR (1),
   "d_current_year" VARCHAR (1)
)
PARTITION BY HASH (d_date_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."warehouse"
(
   "w_warehouse_sk" INTEGER (primary_key) NOT NULL,
   "w_warehouse_id" VARCHAR (16, DICT) NOT NULL,
   "w_warehouse_name" VARCHAR (32, DICT),
   "w_warehouse_sq_ft" INTEGER,
   "w_street_number" VARCHAR (16, DICT),
   "w_street_name" VARCHAR (64, DICT),
   "w_street_type" VARCHAR (16, DICT),
   "w_suite_number" VARCHAR (16, DICT),
   "w_city" VARCHAR (64, DICT),
   "w_county" VARCHAR (32, DICT),
   "w_state" VARCHAR (2, DICT),
   "w_zip" VARCHAR (16, DICT),
   "w_country" VARCHAR (32, DICT),
   "w_gmt_offset" DECIMAL(5,4)
)
PARTITION BY HASH (w_warehouse_sk)
PARTITIONS 10;


CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."ship_mode"
(
   "sm_ship_mode_sk" INTEGER (primary_key) NOT NULL,
   "sm_ship_mode_id" VARCHAR (16, DICT) NOT NULL,
   "sm_type" VARCHAR (32, DICT),
   "sm_code" VARCHAR (16, DICT),
   "sm_carrier" VARCHAR (32, DICT),
   "sm_contract" VARCHAR (32, DICT)
)
PARTITION BY HASH (sm_ship_mode_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."time_dim"
(
   "t_time_sk" INTEGER (primary_key) NOT NULL,
   "t_time_id" VARCHAR (16, DICT) NOT NULL,
   "t_time" INTEGER,
   "t_hour" INTEGER,
   "t_minute" INTEGER,
   "t_second" INTEGER,
   "t_am_pm" VARCHAR (2, DICT),
   "t_shift" VARCHAR (32, DICT),
   "t_sub_shift" VARCHAR (32, DICT),
   "t_meal_time" VARCHAR (32, DICT)
)
PARTITION BY HASH (t_time_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."reason"
(
   "r_reason_sk" INTEGER (primary_key) NOT NULL,
   "r_reason_id" VARCHAR (16, DICT) NOT NULL,
   "r_reason_desc" VARCHAR (128, DICT)
)
PARTITION BY HASH (r_reason_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."income_band"
(
   "ib_income_band_sk" INTEGER (primary_key) NOT NULL,
   "ib_lower_bound" INTEGER,
   "ib_upper_bound" INTEGER
)
PARTITION BY HASH (ib_income_band_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."item"
(
   "i_item_sk" INTEGER (primary_key) NOT NULL,
   "i_item_id" VARCHAR (16) NOT NULL,
   "i_rec_start_date" DATE,
   "i_rec_end_date" DATE,
   "i_item_desc" VARCHAR (256),
   "i_current_price" DECIMAL(7,4),
   "i_wholesale_cost" DECIMAL(7,4),
   "i_brand_id" INTEGER,
   "i_brand" VARCHAR (64, DICT),
   "i_class_id" INTEGER,
   "i_class" VARCHAR (64, DICT),
   "i_category_id" INTEGER,
   "i_category" VARCHAR (64, DICT),
   "i_manufact_id" INTEGER,
   "i_manufact" VARCHAR (64, DICT),
   "i_size" VARCHAR (32, DICT),
   "i_formulation" VARCHAR (32, DICT),
   "i_color" VARCHAR (32, DICT),
   "i_units" VARCHAR (16, DICT),
   "i_container" VARCHAR (16),
   "i_manager_id" INTEGER,
   "i_product_name" VARCHAR (64)
)
PARTITION BY HASH (i_item_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."store"
(
   "s_store_sk" INTEGER (primary_key) NOT NULL,
   "s_store_id" VARCHAR (16, DICT) NOT NULL,
   "s_rec_start_date" DATE,
   "s_rec_end_date" DATE,
   "s_closed_date_sk" INTEGER,
   "s_store_name" VARCHAR (64, DICT),
   "s_number_employees" INTEGER,
   "s_floor_space" INTEGER,
   "s_hours" VARCHAR (32, DICT),
   "s_manager" VARCHAR (64, DICT),
   "s_market_id" INTEGER,
   "s_geography_class" VARCHAR (128, DICT),
   "s_market_desc" VARCHAR (128, DICT),
   "s_market_manager" VARCHAR (64, DICT),
   "s_division_id" INTEGER,
   "s_division_name" VARCHAR (64, DICT),
   "s_company_id" INTEGER,
   "s_company_name" VARCHAR (64, DICT),
   "s_street_number" VARCHAR (16, DICT),
   "s_street_name" VARCHAR (64, DICT),
   "s_street_type" VARCHAR (16, DICT),
   "s_suite_number" VARCHAR (16, DICT),
   "s_city" VARCHAR (64, DICT),
   "s_county" VARCHAR (32, DICT),
   "s_state" VARCHAR (2, DICT),
   "s_zip" VARCHAR (16, DICT),
   "s_country" VARCHAR (32, DICT),
   "s_gmt_offset" DECIMAL(7,4),
   "s_tax_precentage" DECIMAL(7,4)
)
PARTITION BY HASH (s_store_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."call_center"
(
   "cc_call_center_sk" INTEGER (primary_key) NOT NULL,
   "cc_call_center_id" VARCHAR (16, DICT) NOT NULL,
   "cc_rec_start_date" DATE,
   "cc_rec_end_date" DATE,
   "cc_closed_date_sk" INTEGER,
   "cc_open_date_sk" INTEGER,
   "cc_name" VARCHAR (64, DICT),
   "cc_class" VARCHAR (64, DICT),
   "cc_employees" INTEGER,
   "cc_sq_ft" INTEGER,
   "cc_hours" VARCHAR (32, DICT),
   "cc_manager" VARCHAR (64),
   "cc_mkt_id" INTEGER,
   "cc_mkt_class" VARCHAR (64, DICT),
   "cc_mkt_desc" VARCHAR (128),
   "cc_market_manager" VARCHAR (64),
   "cc_division" INTEGER,
   "cc_division_name" VARCHAR (64, DICT),
   "cc_company" INTEGER,
   "cc_company_name" VARCHAR (64, DICT),
   "cc_street_number" VARCHAR (16, DICT),
   "cc_street_name" VARCHAR (64, DICT),
   "cc_street_type" VARCHAR (16, DICT),
   "cc_suite_number" VARCHAR (16, DICT),
   "cc_city" VARCHAR (64, DICT),
   "cc_county" VARCHAR (32, DICT),
   "cc_state" VARCHAR (2, DICT),
   "cc_zip" VARCHAR (16, DICT),
   "cc_country" VARCHAR (32, DICT),
   "cc_gmt_offset" DECIMAL(5,4),
   "cc_tax_percentage" DECIMAL(5,4)
)
PARTITION BY HASH (cc_call_center_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."customer"
(
   "c_customer_sk" INTEGER (primary_key) NOT NULL,
   "c_customer_id" VARCHAR (16, DICT) NOT NULL,
   "c_current_cdemo_sk" INTEGER,
   "c_current_hdemo_sk" INTEGER,
   "c_current_addr_sk" INTEGER,
   "c_first_shipto_date_sk" INTEGER,
   "c_first_sales_date_sk" INTEGER,
   "c_salutation" VARCHAR (16, DICT),
   "c_first_name" VARCHAR (32),
   "c_last_name" VARCHAR (32),
   "c_preferred_cust_flag" VARCHAR (1),
   "c_birth_day" INTEGER,
   "c_birth_month" INTEGER,
   "c_birth_year" INTEGER,
   "c_birth_country" VARCHAR (32, DICT),
   "c_login" VARCHAR (16),
   "c_email_address" VARCHAR (64),
   "c_last_review_date_sk" VARCHAR (16)
)
PARTITION BY HASH (c_customer_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."web_site"
(
   "web_site_sk" INTEGER (primary_key) NOT NULL,
   "web_site_id" VARCHAR (16, DICT) NOT NULL,
   "web_rec_start_date" DATE,
   "web_rec_end_date" DATE,
   "web_name" VARCHAR (64,DICT),
   "web_open_date_sk" INTEGER,
   "web_close_date_sk" INTEGER,
   "web_class" VARCHAR (64,DICT),
   "web_manager" VARCHAR (64, DICT),
   "web_mkt_id" INTEGER,
   "web_mkt_class" VARCHAR (64,DICT),
   "web_mkt_desc" VARCHAR (128,DICT),
   "web_market_manager" VARCHAR (64,DICT),
   "web_company_id" INTEGER,
   "web_company_name" VARCHAR (64,DICT),
   "web_street_number" VARCHAR (16,DICT),
   "web_street_name" VARCHAR (64,DICT),
   "web_street_type" VARCHAR (16,DICT),
   "web_suite_number" VARCHAR (16,DICT),
   "web_city" VARCHAR (64,DICT),
   "web_county" VARCHAR (32,DICT),
   "web_state" VARCHAR (2,DICT),
   "web_zip" VARCHAR (16,DICT),
   "web_country" VARCHAR (32,DICT),
   "web_gmt_offset" DECIMAL(5,4),
   "web_tax_percentage" DECIMAL(5,4)
)
PARTITION BY HASH (web_site_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."store_returns"
(
   "sr_returned_date_sk" INTEGER,
   "sr_return_time_sk" INTEGER,
   "sr_item_sk" INTEGER (primary_key) NOT NULL,
   "sr_customer_sk" INTEGER,
   "sr_cdemo_sk" INTEGER,
   "sr_hdemo_sk" INTEGER,
   "sr_addr_sk" INTEGER,
   "sr_store_sk" INTEGER,
   "sr_reason_sk" INTEGER,
   "sr_ticket_number" INTEGER (primary_key) NOT NULL,
   "sr_return_quantity" INTEGER,
   "sr_return_amt" DECIMAL(7,4),
   "sr_return_tax" DECIMAL(7,4),
   "sr_return_amt_inc_tax" DECIMAL(7,4),
   "sr_fee" DECIMAL(7,4),
   "sr_return_ship_cost" DECIMAL(7,4),
   "sr_refunded_cash" DECIMAL(7,4),
   "sr_reversed_charge" DECIMAL(7,4),
   "sr_store_credit" DECIMAL(7,4),
   "sr_net_loss" DECIMAL(7,4)
)
PARTITION BY HASH (sr_returned_date_sk, sr_item_sk)
PARTITIONS 10;


CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."household_demographics"
(
   "hd_demo_sk" INTEGER (primary_key) NOT NULL,
   "hd_income_band_sk" INTEGER,
   "hd_buy_potential" VARCHAR (16, DICT),
   "hd_dep_count" INTEGER,
   "hd_vehicle_count" INTEGER
)
PARTITION BY HASH (hd_demo_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."web_page"
(
   "wp_web_page_sk" INTEGER (primary_key) NOT NULL,
   "wp_web_page_id" VARCHAR (16, DICT) NOT NULL,
   "wp_rec_start_date" DATE,
   "wp_rec_end_date" DATE,
   "wp_creation_date_sk" INTEGER,
   "wp_access_date_sk" INTEGER,
   "wp_autogen_flag" VARCHAR (1),
   "wp_customer_sk" INTEGER,
   "wp_url" VARCHAR (128, DICT),
   "wp_type" VARCHAR (64, DICT),
   "wp_char_count" INTEGER,
   "wp_link_count" INTEGER,
   "wp_image_count" INTEGER,
   "wp_max_ad_count" INTEGER
)
PARTITION BY HASH (wp_web_page_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."promotion"
(
   "p_promo_sk" INTEGER (primary_key) NOT NULL,
   "p_promo_id" VARCHAR (16, DICT) NOT NULL,
   "p_start_date_sk" INTEGER,
   "p_end_date_sk" INTEGER,
   "p_item_sk" INTEGER,
   "p_cost" DECIMAL(15,4),
   "p_response_target" INTEGER,
   "p_promo_name" VARCHAR (64, DICT),
   "p_channel_dmail" VARCHAR (1),
   "p_channel_email" VARCHAR (1),
   "p_channel_catalog" VARCHAR (1),
   "p_channel_tv" VARCHAR (1),
   "p_channel_radio" VARCHAR (1),
   "p_channel_press" VARCHAR (1),
   "p_channel_event" VARCHAR (1),
   "p_channel_demo" VARCHAR (1),
   "p_channel_details" VARCHAR (128),
   "p_purpose" VARCHAR (16, DICT),
   "p_discount_active" VARCHAR (1)
)
PARTITION BY HASH (p_promo_sk)
PARTITIONS 10;

CREATE OR REPLACE REPLICATED TABLE "{{ kinetica_tpcds_schema }}"."catalog_page"
(
   "cp_catalog_page_sk" INTEGER (primary_key) NOT NULL,
   "cp_catalog_page_id" VARCHAR (16, DICT) NOT NULL,
   "cp_start_date_sk" INTEGER,
   "cp_end_date_sk" INTEGER,
   "cp_department" VARCHAR (64, DICT),
   "cp_catalog_number" INTEGER,
   "cp_catalog_page_number" INTEGER,
   "cp_description" VARCHAR (128, DICT),
   "cp_type" VARCHAR (128, DICT)
)
PARTITION BY HASH (cp_catalog_page_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."inventory"
(
   "inv_date_sk" INTEGER (primary_key) NOT NULL,
   "inv_item_sk" INTEGER (primary_key) NOT NULL,
   "inv_warehouse_sk" INTEGER (primary_key) NOT NULL,
   "inv_quantity_on_hand" INTEGER
)
PARTITION BY HASH (inv_date_sk, inv_item_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."catalog_returns"
(
   "cr_returned_date_sk" INTEGER,
   "cr_returned_time_sk" INTEGER,
   "cr_item_sk" INTEGER (primary_key) NOT NULL,
   "cr_refunded_customer_sk" INTEGER,
   "cr_refunded_cdemo_sk" INTEGER,
   "cr_refunded_hdemo_sk" INTEGER,
   "cr_refunded_addr_sk" INTEGER,
   "cr_returning_customer_sk" INTEGER,
   "cr_returning_cdemo_sk" INTEGER,
   "cr_returning_hdemo_sk" INTEGER,
   "cr_returning_addr_sk" INTEGER,
   "cr_call_center_sk" INTEGER,
   "cr_catalog_page_sk" INTEGER,
   "cr_ship_mode_sk" INTEGER,
   "cr_warehouse_sk" INTEGER,
   "cr_reason_sk" INTEGER,
   "cr_order_number" INTEGER (primary_key) NOT NULL,
   "cr_return_quantity" INTEGER,
   "cr_return_amount" DECIMAL(7,4),
   "cr_return_tax" DECIMAL(7,4),
   "cr_return_amt_inc_tax" DECIMAL(7,4),
   "cr_fee" DECIMAL(7,4),
   "cr_return_ship_cost" DECIMAL(7,4),
   "cr_refunded_cash" DECIMAL(7,4),
   "cr_reversed_charge" DECIMAL(7,4),
   "cr_store_credit" DECIMAL(7,4),
   "cr_net_loss" DECIMAL(7,4)
)
PARTITION BY HASH (cr_returned_date_sk, cr_item_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."web_returns"
(
   "wr_returned_date_sk" INTEGER,
   "wr_returned_time_sk" INTEGER,
   "wr_item_sk" INTEGER (primary_key) NOT NULL,
   "wr_refunded_customer_sk" INTEGER,
   "wr_refunded_cdemo_sk" INTEGER,
   "wr_refunded_hdemo_sk" INTEGER,
   "wr_refunded_addr_sk" INTEGER,
   "wr_returning_customer_sk" INTEGER,
   "wr_returning_cdemo_sk" INTEGER,
   "wr_returning_hdemo_sk" INTEGER,
   "wr_returning_addr_sk" INTEGER,
   "wr_web_page_sk" INTEGER,
   "wr_reason_sk" INTEGER,
   "wr_order_number" INTEGER (primary_key) NOT NULL,
   "wr_return_quantity" INTEGER,
   "wr_return_amt" DECIMAL(7,4),
   "wr_return_tax" DECIMAL(7,4),
   "wr_return_amt_inc_tax" DECIMAL(7,4),
   "wr_fee" DECIMAL(7,4),
   "wr_return_ship_cost" DECIMAL(7,4),
   "wr_refunded_cash" DECIMAL(7,4),
   "wr_reversed_charge" DECIMAL(7,4),
   "wr_account_credit" DECIMAL(7,4),
   "wr_net_loss" DECIMAL(7,4)
)
PARTITION BY HASH (wr_returned_date_sk, wr_item_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."web_sales"
(
   "ws_sold_date_sk" INTEGER,
   "ws_sold_time_sk" INTEGER,
   "ws_ship_date_sk" INTEGER,
   "ws_item_sk" INTEGER (primary_key) NOT NULL,
   "ws_bill_customer_sk" INTEGER,
   "ws_bill_cdemo_sk" INTEGER,
   "ws_bill_hdemo_sk" INTEGER,
   "ws_bill_addr_sk" INTEGER,
   "ws_ship_customer_sk" INTEGER,
   "ws_ship_cdemo_sk" INTEGER,
   "ws_ship_hdemo_sk" INTEGER,
   "ws_ship_addr_sk" INTEGER,
   "ws_web_page_sk" INTEGER,
   "ws_web_site_sk" INTEGER,
   "ws_ship_mode_sk" INTEGER,
   "ws_warehouse_sk" INTEGER,
   "ws_promo_sk" INTEGER,
   "ws_order_number" INTEGER (primary_key) NOT NULL,
   "ws_quantity" INTEGER,
   "ws_wholesale_cost" DECIMAL(7,4),
   "ws_list_price" DECIMAL(7,4),
   "ws_sales_price" DECIMAL(7,4),
   "ws_ext_discount_amt" DECIMAL(7,4),
   "ws_ext_sales_price" DECIMAL(7,4),
   "ws_ext_wholesale_cost" DECIMAL(7,4),
   "ws_ext_list_price" DECIMAL(7,4),
   "ws_ext_tax" DECIMAL(7,4),
   "ws_coupon_amt" DECIMAL(7,4),
   "ws_ext_ship_cost" DECIMAL(7,4),
   "ws_net_paid" DECIMAL(7,4),
   "ws_net_paid_inc_tax" DECIMAL(7,4),
   "ws_net_paid_inc_ship" DECIMAL(7,4),
   "ws_net_paid_inc_ship_tax" DECIMAL(7,4),
   "ws_net_profit" DECIMAL(7,4)
)
PARTITION BY HASH (ws_sold_date_sk, ws_item_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."catalog_sales"
(
   "cs_sold_date_sk" INTEGER,
   "cs_sold_time_sk" INTEGER,
   "cs_ship_date_sk" INTEGER,
   "cs_bill_customer_sk" INTEGER,
   "cs_bill_cdemo_sk" INTEGER,
   "cs_bill_hdemo_sk" INTEGER,
   "cs_bill_addr_sk" INTEGER,
   "cs_ship_customer_sk" INTEGER,
   "cs_ship_cdemo_sk" INTEGER,
   "cs_ship_hdemo_sk" INTEGER,
   "cs_ship_addr_sk" INTEGER,
   "cs_call_center_sk" INTEGER,
   "cs_catalog_page_sk" INTEGER,
   "cs_ship_mode_sk" INTEGER,
   "cs_warehouse_sk" INTEGER,
   "cs_item_sk" INTEGER (primary_key) NOT NULL,
   "cs_promo_sk" INTEGER,
   "cs_order_number" INTEGER (primary_key) NOT NULL,
   "cs_quantity" INTEGER,
   "cs_wholesale_cost" DECIMAL(7,4),
   "cs_list_price" DECIMAL(7,4),
   "cs_sales_price" DECIMAL(7,4),
   "cs_ext_discount_amt" DECIMAL(7,4),
   "cs_ext_sales_price" DECIMAL(7,4),
   "cs_ext_wholesale_cost" DECIMAL(7,4),
   "cs_ext_list_price" DECIMAL(7,4),
   "cs_ext_tax" DECIMAL(7,4),
   "cs_coupon_amt" DECIMAL(7,4),
   "cs_ext_ship_cost" DECIMAL(7,4),
   "cs_net_paid" DECIMAL(7,4),
   "cs_net_paid_inc_tax" DECIMAL(7,4),
   "cs_net_paid_inc_ship" DECIMAL(7,4),
   "cs_net_paid_inc_ship_tax" DECIMAL(7,4),
   "cs_net_profit" DECIMAL(7,4)
)
PARTITION BY HASH (cs_sold_date_sk, cs_item_sk)
PARTITIONS 10;

CREATE OR REPLACE TABLE "{{ kinetica_tpcds_schema }}"."store_sales"
(
   "ss_sold_date_sk" INTEGER,
   "ss_sold_time_sk" INTEGER,
   "ss_item_sk" INTEGER (primary_key) NOT NULL,
   "ss_customer_sk" INTEGER,
   "ss_cdemo_sk" INTEGER,
   "ss_hdemo_sk" INTEGER,
   "ss_addr_sk" INTEGER,
   "ss_store_sk" INTEGER,
   "ss_promo_sk" INTEGER,
   "ss_ticket_number" INTEGER (primary_key) NOT NULL,
   "ss_quantity" INTEGER,
   "ss_wholesale_cost" DECIMAL(7,4),
   "ss_list_price" DECIMAL(7,4),
   "ss_sales_price" DECIMAL(7,4),
   "ss_ext_discount_amt" DECIMAL(7,4),
   "ss_ext_sales_price" DECIMAL(7,4),
   "ss_ext_wholesale_cost" DECIMAL(7,4),
   "ss_ext_list_price" DECIMAL(7,4),
   "ss_ext_tax" DECIMAL(7,4),
   "ss_coupon_amt" DECIMAL(7,4),
   "ss_net_paid" DECIMAL(7,4),
   "ss_net_paid_inc_tax" DECIMAL(7,4),
   "ss_net_profit" DECIMAL(7,4)
)
PARTITION BY HASH (ss_sold_date_sk, ss_item_sk)
PARTITIONS 10;

alter table {{ kinetica_tpcds_schema }}.call_center add foreign key  (cc_closed_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.call_center add foreign key  (cc_open_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_page add foreign key  (cp_end_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ kinetica_tpcds_schema }}.catalog_page add foreign key  (cp_promo_id) references {{ kinetica_tpcds_schema }}.promotion (p_promo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_page add foreign key  (cp_start_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_call_center_sk) references {{ kinetica_tpcds_schema }}.call_center (cc_call_center_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_catalog_page_sk) references {{ kinetica_tpcds_schema }}.catalog_page (cp_catalog_page_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_reason_sk) references {{ kinetica_tpcds_schema }}.reason (r_reason_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_returned_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_returned_time_sk) references {{ kinetica_tpcds_schema }}.time_dim (t_time_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_ship_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_ship_mode_sk) references {{ kinetica_tpcds_schema }}.ship_mode (sm_ship_mode_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_returns add foreign key  (cr_warehouse_sk) references {{ kinetica_tpcds_schema }}.warehouse (w_warehouse_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_call_center_sk) references {{ kinetica_tpcds_schema }}.call_center (cc_call_center_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_catalog_page_sk) references {{ kinetica_tpcds_schema }}.catalog_page (cp_catalog_page_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_promo_sk) references {{ kinetica_tpcds_schema }}.promotion (p_promo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_mode_sk) references {{ kinetica_tpcds_schema }}.ship_mode (sm_ship_mode_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_sold_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_sold_time_sk) references {{ kinetica_tpcds_schema }}.time_dim (t_time_sk);
alter table {{ kinetica_tpcds_schema }}.catalog_sales add foreign key  (cs_warehouse_sk) references {{ kinetica_tpcds_schema }}.warehouse (w_warehouse_sk);
alter table {{ kinetica_tpcds_schema }}.customer add foreign key  (c_current_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.customer add foreign key  (c_current_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.customer add foreign key  (c_current_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.customer add foreign key  (c_first_sales_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.customer add foreign key  (c_first_shipto_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.household_demographics add foreign key  (hd_income_band_sk) references {{ kinetica_tpcds_schema }}.income_band (ib_income_band_sk);
alter table {{ kinetica_tpcds_schema }}.inventory add foreign key  (inv_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.inventory add foreign key  (inv_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.inventory add foreign key  (inv_warehouse_sk) references {{ kinetica_tpcds_schema }}.warehouse (w_warehouse_sk);
alter table {{ kinetica_tpcds_schema }}.promotion add foreign key  (p_end_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.promotion add foreign key  (p_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.promotion add foreign key  (p_start_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.store add foreign key  (s_closed_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_reason_sk) references {{ kinetica_tpcds_schema }}.reason (r_reason_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_returned_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_return_time_sk) references {{ kinetica_tpcds_schema }}.time_dim (t_time_sk);
alter table {{ kinetica_tpcds_schema }}.store_returns add foreign key  (sr_store_sk) references {{ kinetica_tpcds_schema }}.store (s_store_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_promo_sk) references {{ kinetica_tpcds_schema }}.promotion (p_promo_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_sold_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_sold_time_sk) references {{ kinetica_tpcds_schema }}.time_dim (t_time_sk);
alter table {{ kinetica_tpcds_schema }}.store_sales add foreign key  (ss_store_sk) references {{ kinetica_tpcds_schema }}.store (s_store_sk);
alter table {{ kinetica_tpcds_schema }}.web_page add foreign key  (wp_access_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.web_page add foreign key  (wp_creation_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_reason_sk) references {{ kinetica_tpcds_schema }}.reason (r_reason_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_refunded_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_refunded_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_refunded_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_refunded_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_returned_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_returned_time_sk) references {{ kinetica_tpcds_schema }}.time_dim (t_time_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_returning_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_returning_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_returning_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_returning_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_returns add foreign key  (wr_web_page_sk) references {{ kinetica_tpcds_schema }}.web_page (wp_web_page_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_bill_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_bill_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_bill_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_bill_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_item_sk) references {{ kinetica_tpcds_schema }}.item (i_item_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_promo_sk) references {{ kinetica_tpcds_schema }}.promotion (p_promo_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_ship_addr_sk) references {{ kinetica_tpcds_schema }}.customer_address (ca_address_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_ship_cdemo_sk) references {{ kinetica_tpcds_schema }}.customer_demographics (cd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_ship_customer_sk) references {{ kinetica_tpcds_schema }}.customer (c_customer_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_ship_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_ship_hdemo_sk) references {{ kinetica_tpcds_schema }}.household_demographics (hd_demo_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_ship_mode_sk) references {{ kinetica_tpcds_schema }}.ship_mode (sm_ship_mode_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_sold_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_sold_time_sk) references {{ kinetica_tpcds_schema }}.time_dim (t_time_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_warehouse_sk) references {{ kinetica_tpcds_schema }}.warehouse (w_warehouse_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_web_page_sk) references {{ kinetica_tpcds_schema }}.web_page (wp_web_page_sk);
alter table {{ kinetica_tpcds_schema }}.web_sales add foreign key  (ws_web_site_sk) references {{ kinetica_tpcds_schema }}.web_site (web_site_sk);
alter table {{ kinetica_tpcds_schema }}.web_site add foreign key  (web_close_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
alter table {{ kinetica_tpcds_schema }}.web_site add foreign key  (web_open_date_sk) references {{ kinetica_tpcds_schema }}.date_dim (d_date_sk);
