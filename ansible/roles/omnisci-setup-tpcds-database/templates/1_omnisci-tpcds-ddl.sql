DROP DATABASE IF EXISTS {{ omnisci_tpcds_schema }};
CREATE DATABASE {{ omnisci_tpcds_schema }};

create table "{{ omnisci_tpcds_schema }}"."dbgen_version"
(
    dv_version                TEXT          ,
    dv_create_date            date                          ,
    dv_create_time            time                          ,
    dv_cmdline_args           TEXT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."customer_address"
(
   "ca_address_sk" INTEGER NOT NULL,
   "ca_address_id" TEXT NOT NULL,
   "ca_street_number" TEXT,
   "ca_street_name" TEXT,
   "ca_street_type" TEXT,
   "ca_suite_number" TEXT,
   "ca_city" TEXT ENCODING DICT,
   "ca_county" TEXT ENCODING DICT,
   "ca_state" TEXT ENCODING DICT,
   "ca_zip" TEXT ENCODING DICT,
   "ca_country" TEXT ENCODING DICT,
   "ca_gmt_offset" DECIMAL(5,2),
   "ca_location_type" TEXT ENCODING DICT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."customer_demographics"
(
   "cd_demo_sk" INTEGER NOT NULL,
   "cd_gender" TEXT,
   "cd_marital_status" TEXT,
   "cd_education_status" TEXT ENCODING DICT,
   "cd_purchase_estimate" INTEGER,
   "cd_credit_rating" TEXT ENCODING DICT,
   "cd_dep_count" INTEGER,
   "cd_dep_employed_count" INTEGER,
   "cd_dep_college_count" INTEGER
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."date_dim"
(
   "d_date_sk" INTEGER NOT NULL,
   "d_date_id" TEXT NOT NULL,
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
   "d_day_name" TEXT ENCODING DICT,
   "d_quarter_name" TEXT ENCODING DICT,
   "d_holiday" TEXT,
   "d_weekend" TEXT,
   "d_following_holiday" TEXT,
   "d_first_dom" INTEGER,
   "d_last_dom" INTEGER,
   "d_same_day_ly" INTEGER,
   "d_same_day_lq" INTEGER,
   "d_current_day" TEXT,
   "d_current_week" TEXT,
   "d_current_month" TEXT,
   "d_current_quarter" TEXT,
   "d_current_year" TEXT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."warehouse"
(
   "w_warehouse_sk" INTEGER NOT NULL,
   "w_warehouse_id" TEXT ENCODING DICT NOT NULL,
   "w_warehouse_name" TEXT ENCODING DICT,
   "w_warehouse_sq_ft" INTEGER,
   "w_street_number" TEXT ENCODING DICT,
   "w_street_name" TEXT ENCODING DICT,
   "w_street_type" TEXT ENCODING DICT,
   "w_suite_number" TEXT ENCODING DICT,
   "w_city" TEXT ENCODING DICT,
   "w_county" TEXT ENCODING DICT,
   "w_state" TEXT ENCODING DICT,
   "w_zip" TEXT ENCODING DICT,
   "w_country" TEXT ENCODING DICT,
   "w_gmt_offset" DECIMAL(5,2)
);


CREATE TABLE "{{ omnisci_tpcds_schema }}"."ship_mode"
(
   "sm_ship_mode_sk" INTEGER NOT NULL,
   "sm_ship_mode_id" TEXT ENCODING DICT NOT NULL,
   "sm_type" TEXT ENCODING DICT,
   "sm_code" TEXT ENCODING DICT,
   "sm_carrier" TEXT ENCODING DICT,
   "sm_contract" TEXT ENCODING DICT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."time_dim"
(
   "t_time_sk" INTEGER NOT NULL,
   "t_time_id" TEXT ENCODING DICT NOT NULL,
   "t_time" INTEGER,
   "t_hour" INTEGER,
   "t_minute" INTEGER,
   "t_second" INTEGER,
   "t_am_pm" TEXT ENCODING DICT,
   "t_shift" TEXT ENCODING DICT,
   "t_sub_shift" TEXT ENCODING DICT,
   "t_meal_time" TEXT ENCODING DICT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."reason"
(
   "r_reason_sk" INTEGER NOT NULL,
   "r_reason_id" TEXT ENCODING DICT NOT NULL,
   "r_reason_desc" TEXT ENCODING DICT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."income_band"
(
   "ib_income_band_sk" INTEGER NOT NULL,
   "ib_lower_bound" INTEGER,
   "ib_upper_bound" INTEGER
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."item"
(
   "i_item_sk" INTEGER NOT NULL,
   "i_item_id" TEXT NOT NULL,
   "i_rec_start_date" DATE,
   "i_rec_end_date" DATE,
   "i_item_desc" TEXT,
   "i_current_price" DECIMAL(7,2),
   "i_wholesale_cost" DECIMAL(7,2),
   "i_brand_id" INTEGER,
   "i_brand" TEXT ENCODING DICT,
   "i_class_id" INTEGER,
   "i_class" TEXT ENCODING DICT,
   "i_category_id" INTEGER,
   "i_category" TEXT ENCODING DICT,
   "i_manufact_id" INTEGER,
   "i_manufact" TEXT ENCODING DICT,
   "i_size" TEXT ENCODING DICT,
   "i_formulation" TEXT ENCODING DICT,
   "i_color" TEXT ENCODING DICT,
   "i_units" TEXT ENCODING DICT,
   "i_container" TEXT,
   "i_manager_id" INTEGER,
   "i_product_name" TEXT
);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."store"
(
   "s_store_sk" INTEGER NOT NULL,
   "s_store_id" TEXT ENCODING DICT NOT NULL,
   "s_rec_start_date" DATE,
   "s_rec_end_date" DATE,
   "s_closed_date_sk" INTEGER,
   "s_store_name" TEXT ENCODING DICT,
   "s_number_employees" INTEGER,
   "s_floor_space" INTEGER,
   "s_hours" TEXT ENCODING DICT,
   "s_manager" TEXT ENCODING DICT,
   "s_market_id" INTEGER,
   "s_geography_class" TEXT ENCODING DICT,
   "s_market_desc" TEXT ENCODING DICT,
   "s_market_manager" TEXT ENCODING DICT,
   "s_division_id" INTEGER,
   "s_division_name" TEXT ENCODING DICT,
   "s_company_id" INTEGER,
   "s_company_name" TEXT ENCODING DICT,
   "s_street_number" TEXT ENCODING DICT,
   "s_street_name" TEXT ENCODING DICT,
   "s_street_type" TEXT ENCODING DICT,
   "s_suite_number" TEXT ENCODING DICT,
   "s_city" TEXT ENCODING DICT,
   "s_county" TEXT ENCODING DICT,
   "s_state" TEXT ENCODING DICT,
   "s_zip" TEXT ENCODING DICT,
   "s_country" TEXT ENCODING DICT,
   "s_gmt_offset" DECIMAL(7,2),
   "s_tax_precentage" DECIMAL(7,2),
   SHARED DICTIONARY (s_closed_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.store add foreign key  (s_closed_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."call_center"
(
   "cc_call_center_sk" INTEGER NOT NULL,
   "cc_call_center_id" TEXT ENCODING DICT NOT NULL,
   "cc_rec_start_date" DATE,
   "cc_rec_end_date" DATE,
   "cc_closed_date_sk" INTEGER,
   "cc_open_date_sk" INTEGER,
   "cc_name" TEXT ENCODING DICT,
   "cc_class" TEXT ENCODING DICT,
   "cc_employees" INTEGER,
   "cc_sq_ft" INTEGER,
   "cc_hours" TEXT ENCODING DICT,
   "cc_manager" TEXT,
   "cc_mkt_id" INTEGER,
   "cc_mkt_class" TEXT ENCODING DICT,
   "cc_mkt_desc" TEXT,
   "cc_market_manager" TEXT,
   "cc_division" INTEGER,
   "cc_division_name" TEXT ENCODING DICT,
   "cc_company" INTEGER,
   "cc_company_name" TEXT ENCODING DICT,
   "cc_street_number" TEXT ENCODING DICT,
   "cc_street_name" TEXT ENCODING DICT,
   "cc_street_type" TEXT ENCODING DICT,
   "cc_suite_number" TEXT ENCODING DICT,
   "cc_city" TEXT ENCODING DICT,
   "cc_county" TEXT ENCODING DICT,
   "cc_state" TEXT ENCODING DICT,
   "cc_zip" TEXT ENCODING DICT,
   "cc_country" TEXT ENCODING DICT,
   "cc_gmt_offset" DECIMAL(5,2),
   "cc_tax_percentage" DECIMAL(5,2),
   SHARED DICTIONARY (cc_closed_date_sk) REFERENCES date_dim(d_date_sk),
   SHARED DICTIONARY (cc_open_date_sk) REFERENCES date_dim(d_date_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.call_center add foreign key  (cc_closed_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.call_center add foreign key  (cc_open_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);

-- with SF100 table has 30 records ... no partitions required.
-- PARTITION BY RANGE (cc_tax_percentage)
-- PARTITIONS
-- (
--     perc_01      MIN(0.00) MAX(0.01),
--     perc_02                MAX(0.02),
--     perc_03                MAX(0.03),
--     perc_04               MAX(0.04)
-- )

CREATE TABLE "{{ omnisci_tpcds_schema }}"."customer"
(
   "c_customer_sk" INTEGER NOT NULL,
   "c_customer_id" TEXT ENCODING DICT NOT NULL,
   "c_current_cdemo_sk" INTEGER,
   "c_current_hdemo_sk" INTEGER,
   "c_current_addr_sk" INTEGER,
   "c_first_shipto_date_sk" INTEGER,
   "c_first_sales_date_sk" INTEGER,
   "c_salutation" TEXT ENCODING DICT,
   "c_first_name" TEXT,
   "c_last_name" TEXT,
   "c_preferred_cust_flag" TEXT,
   "c_birth_day" INTEGER,
   "c_birth_month" INTEGER,
   "c_birth_year" INTEGER,
   "c_birth_country" TEXT ENCODING DICT,
   "c_login" TEXT,
   "c_email_address" TEXT,
   "c_last_review_date_sk" TEXT,
   SHARED DICTIONARY (c_current_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (c_current_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (c_current_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (c_first_sales_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (c_first_shipto_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.customer add foreign key  (c_current_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.customer add foreign key  (c_current_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.customer add foreign key  (c_current_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.customer add foreign key  (c_first_sales_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.customer add foreign key  (c_first_shipto_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."web_site"
(
   "web_site_sk" INTEGER NOT NULL,
   "web_site_id" TEXT ENCODING DICT NOT NULL,
   "web_rec_start_date" DATE,
   "web_rec_end_date" DATE,
   "web_name" TEXT ENCODING DICT,
   "web_open_date_sk" INTEGER,
   "web_close_date_sk" INTEGER,
   "web_class" TEXT ENCODING DICT,
   "web_manager" TEXT ENCODING DICT,
   "web_mkt_id" INTEGER,
   "web_mkt_class" TEXT ENCODING DICT,
   "web_mkt_desc" TEXT ENCODING DICT,
   "web_market_manager" TEXT ENCODING DICT,
   "web_company_id" INTEGER,
   "web_company_name" TEXT ENCODING DICT,
   "web_street_number" TEXT ENCODING DICT,
   "web_street_name" TEXT ENCODING DICT,
   "web_street_type" TEXT ENCODING DICT,
   "web_suite_number" TEXT ENCODING DICT,
   "web_city" TEXT ENCODING DICT,
   "web_county" TEXT ENCODING DICT,
   "web_state" TEXT ENCODING DICT,
   "web_zip" TEXT ENCODING DICT,
   "web_country" TEXT ENCODING DICT,
   "web_gmt_offset" DECIMAL(5,2),
   "web_tax_percentage" DECIMAL(5,2),
   SHARED DICTIONARY (web_close_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (web_open_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk)
);
-- alter table {{ omnisci_tpcds_schema }}.web_site add foreign key  (web_close_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_site add foreign key  (web_open_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."store_returns"
(
   "sr_returned_date_sk" INTEGER,
   "sr_return_time_sk" INTEGER,
   "sr_item_sk" INTEGER NOT NULL,
   "sr_customer_sk" INTEGER,
   "sr_cdemo_sk" INTEGER,
   "sr_hdemo_sk" INTEGER,
   "sr_addr_sk" INTEGER,
   "sr_store_sk" INTEGER,
   "sr_reason_sk" INTEGER,
   "sr_ticket_number" INTEGER NOT NULL,
   "sr_return_quantity" INTEGER,
   "sr_return_amt" DECIMAL(7,2),
   "sr_return_tax" DECIMAL(7,2),
   "sr_return_amt_inc_tax" DECIMAL(7,2),
   "sr_fee" DECIMAL(7,2),
   "sr_return_ship_cost" DECIMAL(7,2),
   "sr_refunded_cash" DECIMAL(7,2),
   "sr_reversed_charge" DECIMAL(7,2),
   "sr_store_credit" DECIMAL(7,2),
   "sr_net_loss" DECIMAL(7,2),
   SHARED DICTIONARY (sr_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (sr_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (sr_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (sr_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (sr_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (sr_reason_sk) REFERENCES {{ omnisci_tpcds_schema }}.reason(r_reason_sk),
   SHARED DICTIONARY (sr_returned_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (sr_return_time_sk) REFERENCES {{ omnisci_tpcds_schema }}.time_dim(t_time_sk),
   SHARED DICTIONARY (sr_store_sk) REFERENCES {{ omnisci_tpcds_schema }}.store(s_store_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_reason_sk) references {{ omnisci_tpcds_schema }}.reason (r_reason_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_returned_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_return_time_sk) references {{ omnisci_tpcds_schema }}.time_dim (t_time_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_returns add foreign key  (sr_store_sk) references {{ omnisci_tpcds_schema }}.store (s_store_sk);
-- Does it make sense?
-- PARTITION BY RANGE (sr_reversed_charge)
-- PARTITIONS
-- (
--     perc_01      MIN(0.00) MAX(0.01),
--     perc_02                MAX(0.02),
--     perc_03                MAX(0.03),
--     perc_04               MAX(0.04)
-- );

CREATE TABLE "{{ omnisci_tpcds_schema }}"."household_demographics"
(
   "hd_demo_sk" INTEGER NOT NULL,
   "hd_income_band_sk" INTEGER,
   "hd_buy_potential" TEXT ENCODING DICT,
   "hd_dep_count" INTEGER,
   "hd_vehicle_count" INTEGER,
   SHARED DICTIONARY (hd_income_band_sk) REFERENCES {{ omnisci_tpcds_schema }}.income_band(ib_income_band_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.household_demographics add foreign key  (hd_income_band_sk) references {{ omnisci_tpcds_schema }}.income_band (ib_income_band_sk);


CREATE TABLE "{{ omnisci_tpcds_schema }}"."web_page"
(
   "wp_web_page_sk" INTEGER NOT NULL,
   "wp_web_page_id" TEXT ENCODING DICT NOT NULL,
   "wp_rec_start_date" DATE,
   "wp_rec_end_date" DATE,
   "wp_creation_date_sk" INTEGER,
   "wp_access_date_sk" INTEGER,
   "wp_autogen_flag" TEXT,
   "wp_customer_sk" INTEGER,
   "wp_url" TEXT ENCODING DICT,
   "wp_type" TEXT ENCODING DICT,
   "wp_char_count" INTEGER,
   "wp_link_count" INTEGER,
   "wp_image_count" INTEGER,
   "wp_max_ad_count" INTEGER,
   SHARED DICTIONARY (wp_access_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (wp_creation_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.web_page add foreign key  (wp_access_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_page add foreign key  (wp_creation_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."promotion"
(
   "p_promo_sk" INTEGER NOT NULL,
   "p_promo_id" TEXT ENCODING DICT NOT NULL,
   "p_start_date_sk" INTEGER,
   "p_end_date_sk" INTEGER,
   "p_item_sk" INTEGER,
   "p_cost" DECIMAL(15,2),
   "p_response_target" INTEGER,
   "p_promo_name" TEXT ENCODING DICT,
   "p_channel_dmail" TEXT,
   "p_channel_email" TEXT,
   "p_channel_catalog" TEXT,
   "p_channel_tv" TEXT,
   "p_channel_radio" TEXT,
   "p_channel_press" TEXT,
   "p_channel_event" TEXT,
   "p_channel_demo" TEXT,
   "p_channel_details" TEXT,
   "p_purpose" TEXT ENCODING DICT,
   "p_discount_active" TEXT,
   SHARED DICTIONARY (p_end_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (p_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (p_start_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.promotion add foreign key  (p_end_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.promotion add foreign key  (p_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.promotion add foreign key  (p_start_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."catalog_page"
(
   "cp_catalog_page_sk" INTEGER NOT NULL,
   "cp_catalog_page_id" TEXT ENCODING DICT NOT NULL,
   "cp_start_date_sk" INTEGER,
   "cp_end_date_sk" INTEGER,
   "cp_department" TEXT ENCODING DICT,
   "cp_catalog_number" INTEGER,
   "cp_catalog_page_number" INTEGER,
   "cp_description" TEXT ENCODING DICT,
   "cp_type" TEXT ENCODING DICT,
   SHARED DICTIONARY (cp_end_date_sk) REFERENCES date_dim(d_date_sk),
   SHARED DICTIONARY (cp_start_date_sk) REFERENCES date_dim(d_date_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.catalog_page add foreign key  (cp_end_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_page add foreign key  (cp_start_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- with SF100 20k records ...
-- PARTITION BY LIST (cp_catalog_page_number)
-- AUTOMATIC

CREATE TABLE "{{ omnisci_tpcds_schema }}"."inventory"
(
   "inv_date_sk" INTEGER NOT NULL,
   "inv_item_sk" INTEGER NOT NULL,
   "inv_warehouse_sk" INTEGER NOT NULL,
   "inv_quantity_on_hand" INTEGER,
   SHARED DICTIONARY (inv_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (inv_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (inv_warehouse_sk) REFERENCES {{ omnisci_tpcds_schema }}.warehouse(w_warehouse_sk)
);
-- alter table {{ omnisci_tpcds_schema }}.inventory add foreign key  (inv_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.inventory add foreign key  (inv_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.inventory add foreign key  (inv_warehouse_sk) references {{ omnisci_tpcds_schema }}.warehouse (w_warehouse_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."catalog_returns"
(
   "cr_returned_date_sk" INTEGER,
   "cr_returned_time_sk" INTEGER,
   "cr_item_sk" INTEGER NOT NULL,
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
   "cr_order_number" INTEGER NOT NULL,
   "cr_return_quantity" INTEGER,
   "cr_return_amount" DECIMAL(7,2),
   "cr_return_tax" DECIMAL(7,2),
   "cr_return_amt_inc_tax" DECIMAL(7,2),
   "cr_fee" DECIMAL(7,2),
   "cr_return_ship_cost" DECIMAL(7,2),
   "cr_refunded_cash" DECIMAL(7,2),
   "cr_reversed_charge" DECIMAL(7,2),
   "cr_store_credit" DECIMAL(7,2),
   "cr_net_loss" DECIMAL(7,2),
   SHARED DICTIONARY (cr_call_center_sk) REFERENCES {{ omnisci_tpcds_schema }}.call_center(cc_call_center_sk),
   SHARED DICTIONARY (cr_catalog_page_sk) REFERENCES {{ omnisci_tpcds_schema }}.catalog_page(cp_catalog_page_sk),
   SHARED DICTIONARY (cr_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (cr_reason_sk) REFERENCES {{ omnisci_tpcds_schema }}.reason(r_reason_sk),
   SHARED DICTIONARY (cr_refunded_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (cr_refunded_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (cr_refunded_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (cr_refunded_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (cr_returned_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (cr_returned_time_sk) REFERENCES {{ omnisci_tpcds_schema }}.time_dim(t_time_sk),
   SHARED DICTIONARY (cr_returning_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (cr_returning_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (cr_returning_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (cr_returning_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (cr_ship_mode_sk) REFERENCES {{ omnisci_tpcds_schema }}.ship_mode(sm_ship_mode_sk),
   SHARED DICTIONARY (cr_warehouse_sk) REFERENCES {{ omnisci_tpcds_schema }}.warehouse(w_warehouse_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_call_center_sk) references {{ omnisci_tpcds_schema }}.call_center (cc_call_center_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_catalog_page_sk) references {{ omnisci_tpcds_schema }}.catalog_page (cp_catalog_page_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_reason_sk) references {{ omnisci_tpcds_schema }}.reason (r_reason_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_refunded_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_returned_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_returned_time_sk) references {{ omnisci_tpcds_schema }}.time_dim (t_time_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_returning_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_ship_mode_sk) references {{ omnisci_tpcds_schema }}.ship_mode (sm_ship_mode_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_returns add foreign key  (cr_warehouse_sk) references {{ omnisci_tpcds_schema }}.warehouse (w_warehouse_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."web_returns"
(
   "wr_returned_date_sk" INTEGER,
   "wr_returned_time_sk" INTEGER,
   "wr_item_sk" INTEGER NOT NULL,
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
   "wr_order_number" INTEGER NOT NULL,
   "wr_return_quantity" INTEGER,
   "wr_return_amt" DECIMAL(7,2),
   "wr_return_tax" DECIMAL(7,2),
   "wr_return_amt_inc_tax" DECIMAL(7,2),
   "wr_fee" DECIMAL(7,2),
   "wr_return_ship_cost" DECIMAL(7,2),
   "wr_refunded_cash" DECIMAL(7,2),
   "wr_reversed_charge" DECIMAL(7,2),
   "wr_account_credit" DECIMAL(7,2),
   "wr_net_loss" DECIMAL(7,2),
   SHARED DICTIONARY (wr_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (wr_reason_sk) REFERENCES {{ omnisci_tpcds_schema }}.reason(r_reason_sk),
   SHARED DICTIONARY (wr_refunded_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (wr_refunded_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (wr_refunded_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (wr_refunded_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (wr_returned_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (wr_returned_time_sk) REFERENCES {{ omnisci_tpcds_schema }}.time_dim(t_time_sk),
   SHARED DICTIONARY (wr_returning_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (wr_returning_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (wr_returning_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (wr_returning_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (wr_web_page_sk) REFERENCES {{ omnisci_tpcds_schema }}.web_page(wp_web_page_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_reason_sk) references {{ omnisci_tpcds_schema }}.reason (r_reason_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_refunded_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_refunded_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_refunded_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_refunded_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_returned_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_returned_time_sk) references {{ omnisci_tpcds_schema }}.time_dim (t_time_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_returning_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_returning_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_returning_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_returning_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_returns add foreign key  (wr_web_page_sk) references {{ omnisci_tpcds_schema }}.web_page (wp_web_page_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."web_sales"
(
   "ws_sold_date_sk" INTEGER,
   "ws_sold_time_sk" INTEGER,
   "ws_ship_date_sk" INTEGER,
   "ws_item_sk" INTEGER NOT NULL,
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
   "ws_order_number" INTEGER NOT NULL,
   "ws_quantity" INTEGER,
   "ws_wholesale_cost" DECIMAL(7,2),
   "ws_list_price" DECIMAL(7,2),
   "ws_sales_price" DECIMAL(7,2),
   "ws_ext_discount_amt" DECIMAL(7,2),
   "ws_ext_sales_price" DECIMAL(7,2),
   "ws_ext_wholesale_cost" DECIMAL(7,2),
   "ws_ext_list_price" DECIMAL(7,2),
   "ws_ext_tax" DECIMAL(7,2),
   "ws_coupon_amt" DECIMAL(7,2),
   "ws_ext_ship_cost" DECIMAL(7,2),
   "ws_net_paid" DECIMAL(7,2),
   "ws_net_paid_inc_tax" DECIMAL(7,2),
   "ws_net_paid_inc_ship" DECIMAL(7,2),
   "ws_net_paid_inc_ship_tax" DECIMAL(7,2),
   "ws_net_profit" DECIMAL(7,2),
   SHARED DICTIONARY (ws_bill_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (ws_bill_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (ws_bill_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (ws_bill_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (ws_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (ws_promo_sk) REFERENCES {{ omnisci_tpcds_schema }}.promotion(p_promo_sk),
   SHARED DICTIONARY (ws_ship_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (ws_ship_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (ws_ship_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (ws_ship_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (ws_ship_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (ws_ship_mode_sk) REFERENCES {{ omnisci_tpcds_schema }}.ship_mode(sm_ship_mode_sk),
   SHARED DICTIONARY (ws_sold_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (ws_sold_time_sk) REFERENCES {{ omnisci_tpcds_schema }}.time_dim(t_time_sk),
   SHARED DICTIONARY (ws_warehouse_sk) REFERENCES {{ omnisci_tpcds_schema }}.warehouse(w_warehouse_sk),
   SHARED DICTIONARY (ws_web_page_sk) REFERENCES {{ omnisci_tpcds_schema }}.web_page(wp_web_page_sk),
   SHARED DICTIONARY (ws_web_site_sk) REFERENCES {{ omnisci_tpcds_schema }}.web_site(web_site_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_bill_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_bill_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_bill_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_bill_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_promo_sk) references {{ omnisci_tpcds_schema }}.promotion (p_promo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_ship_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_ship_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_ship_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_ship_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_ship_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_ship_mode_sk) references {{ omnisci_tpcds_schema }}.ship_mode (sm_ship_mode_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_sold_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_sold_time_sk) references {{ omnisci_tpcds_schema }}.time_dim (t_time_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_warehouse_sk) references {{ omnisci_tpcds_schema }}.warehouse (w_warehouse_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_web_page_sk) references {{ omnisci_tpcds_schema }}.web_page (wp_web_page_sk);
-- alter table {{ omnisci_tpcds_schema }}.web_sales add foreign key  (ws_web_site_sk) references {{ omnisci_tpcds_schema }}.web_site (web_site_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."catalog_sales"
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
   "cs_item_sk" INTEGER NOT NULL,
   "cs_promo_sk" INTEGER,
   "cs_order_number" INTEGER NOT NULL,
   "cs_quantity" INTEGER,
   "cs_wholesale_cost" DECIMAL(7,2),
   "cs_list_price" DECIMAL(7,2),
   "cs_sales_price" DECIMAL(7,2),
   "cs_ext_discount_amt" DECIMAL(7,2),
   "cs_ext_sales_price" DECIMAL(7,2),
   "cs_ext_wholesale_cost" DECIMAL(7,2),
   "cs_ext_list_price" DECIMAL(7,2),
   "cs_ext_tax" DECIMAL(7,2),
   "cs_coupon_amt" DECIMAL(7,2),
   "cs_ext_ship_cost" DECIMAL(7,2),
   "cs_net_paid" DECIMAL(7,2),
   "cs_net_paid_inc_tax" DECIMAL(7,2),
   "cs_net_paid_inc_ship" DECIMAL(7,2),
   "cs_net_paid_inc_ship_tax" DECIMAL(7,2),
   "cs_net_profit" DECIMAL(7,2),
   SHARED DICTIONARY (cs_bill_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (cs_bill_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (cs_bill_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (cs_bill_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (cs_call_center_sk) REFERENCES {{ omnisci_tpcds_schema }}.call_center(cc_call_center_sk),
   SHARED DICTIONARY (cs_catalog_page_sk) REFERENCES {{ omnisci_tpcds_schema }}.catalog_page(cp_catalog_page_sk),
   SHARED DICTIONARY (cs_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (cs_promo_sk) REFERENCES {{ omnisci_tpcds_schema }}.promotion(p_promo_sk),
   SHARED DICTIONARY (cs_ship_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (cs_ship_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (cs_ship_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (cs_ship_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (cs_ship_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (cs_ship_mode_sk) REFERENCES {{ omnisci_tpcds_schema }}.ship_mode(sm_ship_mode_sk),
   SHARED DICTIONARY (cs_sold_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (cs_sold_time_sk) REFERENCES {{ omnisci_tpcds_schema }}.time_dim(t_time_sk),
   SHARED DICTIONARY (cs_warehouse_sk) REFERENCES {{ omnisci_tpcds_schema }}.warehouse(w_warehouse_sk)
);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_bill_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_call_center_sk) references {{ omnisci_tpcds_schema }}.call_center (cc_call_center_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_catalog_page_sk) references {{ omnisci_tpcds_schema }}.catalog_page (cp_catalog_page_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_promo_sk) references {{ omnisci_tpcds_schema }}.promotion (p_promo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_ship_mode_sk) references {{ omnisci_tpcds_schema }}.ship_mode (sm_ship_mode_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_sold_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_sold_time_sk) references {{ omnisci_tpcds_schema }}.time_dim (t_time_sk);
-- alter table {{ omnisci_tpcds_schema }}.catalog_sales add foreign key  (cs_warehouse_sk) references {{ omnisci_tpcds_schema }}.warehouse (w_warehouse_sk);

CREATE TABLE "{{ omnisci_tpcds_schema }}"."store_sales"
(
   "ss_sold_date_sk" INTEGER,
   "ss_sold_time_sk" INTEGER,
   "ss_item_sk" INTEGER NOT NULL,
   "ss_customer_sk" INTEGER,
   "ss_cdemo_sk" INTEGER,
   "ss_hdemo_sk" INTEGER,
   "ss_addr_sk" INTEGER,
   "ss_store_sk" INTEGER,
   "ss_promo_sk" INTEGER,
   "ss_ticket_number" INTEGER NOT NULL,
   "ss_quantity" INTEGER,
   "ss_wholesale_cost" DECIMAL(7,2),
   "ss_list_price" DECIMAL(7,2),
   "ss_sales_price" DECIMAL(7,2),
   "ss_ext_discount_amt" DECIMAL(7,2),
   "ss_ext_sales_price" DECIMAL(7,2),
   "ss_ext_wholesale_cost" DECIMAL(7,2),
   "ss_ext_list_price" DECIMAL(7,2),
   "ss_ext_tax" DECIMAL(7,2),
   "ss_coupon_amt" DECIMAL(7,2),
   "ss_net_paid" DECIMAL(7,2),
   "ss_net_paid_inc_tax" DECIMAL(7,2),
   "ss_net_profit" DECIMAL(7,2),
   SHARED DICTIONARY (ss_addr_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_address(ca_address_sk),
   SHARED DICTIONARY (ss_cdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer_demographics(cd_demo_sk),
   SHARED DICTIONARY (ss_customer_sk) REFERENCES {{ omnisci_tpcds_schema }}.customer(c_customer_sk),
   SHARED DICTIONARY (ss_hdemo_sk) REFERENCES {{ omnisci_tpcds_schema }}.household_demographics(hd_demo_sk),
   SHARED DICTIONARY (ss_item_sk) REFERENCES {{ omnisci_tpcds_schema }}.item(i_item_sk),
   SHARED DICTIONARY (ss_promo_sk) REFERENCES {{ omnisci_tpcds_schema }}.promotion(p_promo_sk),
   SHARED DICTIONARY (ss_sold_date_sk) REFERENCES {{ omnisci_tpcds_schema }}.date_dim(d_date_sk),
   SHARED DICTIONARY (ss_sold_time_sk) REFERENCES {{ omnisci_tpcds_schema }}.time_dim(t_time_sk),
   SHARED DICTIONARY (ss_store_sk) REFERENCES {{ omnisci_tpcds_schema }}.store(s_store_sk)

);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_addr_sk) references {{ omnisci_tpcds_schema }}.customer_address (ca_address_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_cdemo_sk) references {{ omnisci_tpcds_schema }}.customer_demographics (cd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_customer_sk) references {{ omnisci_tpcds_schema }}.customer (c_customer_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_hdemo_sk) references {{ omnisci_tpcds_schema }}.household_demographics (hd_demo_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_item_sk) references {{ omnisci_tpcds_schema }}.item (i_item_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_promo_sk) references {{ omnisci_tpcds_schema }}.promotion (p_promo_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_sold_date_sk) references {{ omnisci_tpcds_schema }}.date_dim (d_date_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_sold_time_sk) references {{ omnisci_tpcds_schema }}.time_dim (t_time_sk);
-- alter table {{ omnisci_tpcds_schema }}.store_sales add foreign key  (ss_store_sk) references {{ omnisci_tpcds_schema }}.store (s_store_sk);





