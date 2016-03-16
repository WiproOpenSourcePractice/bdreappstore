create database hub_in_prod_20150528;
create database clu_poc;

use hub_in_prod_20150528;

create table if not exists SSGHCGP 
(
GHO_CUSTOMER_CLASSIFICATION string,
CUSTOMER_GROUP string
)
stored as  ORC;

create table if not exists SSGHCLP 
(
BANK_INDICATOR string,
GHO_CUSTOMER_CLASSIFICATION string,
INDIVIDUAL_NON_INDIVIDUAL string,
COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string
)
stored as  ORC;

use clu_poc;

--- view 1
drop view if exists CUST_GROUP;
create view CUST_GROUP
as select GHO_CUSTOMER_CLASSIFICATION, CUSTOMER_GROUP
from hub_in_prod_20150528.SSGHCGP;

--- view 2
drop view if exists CUST_CLASSIFICATION;
create view CUST_CLASSIFICATION
as select BANK_INDICATOR, GHO_CUSTOMER_CLASSIFICATION, INDIVIDUAL_NON_INDIVIDUAL, COUNTRY_CODE, GROUP_MEMBER_ABBREVIATION
from hub_in_prod_20150528.SSGHCLP;

drop table if exists CUSTOMER_INDVL;
create table CUSTOMER_INDVL 
(
COUNTRY_CODE  string,
DOMESTIC_CUSTOMER_GROUP_MEMBER  string,
CUSTOMER_BRANCH_NUMBER  double,
CUSTOMER_SERIAL_NUMBER  double,
MODE_FLAG string,
CUSTOMER_FULL_NAME string,
CUSTOMER_NAME string,
CUSTOMER_SHORT_NAME string,
INDUSTRY_CODE double,
MARKET_SECTOR_1 double,
CUSTOMER_LEGAL_TYPE double,
GHO_CUSTOMER_CLASSIFICATION string,
ACCOUNT_OFFICER double,
CUSTOMER_STATUS string,
COUNTRY_OF_REGISTRATION_RESIDENCE string,
NATIONALITY_CODE string,
CORRESPONDENT_BANK_ID string,
CORRESPONDENT_BRANCH_ID string 
)
stored as ORC;

drop table if exists CUSTOMER_JOINT;
create table CUSTOMER_JOINT
(
DOMESTIC_CUSTOMER_COUNTRY_HOLDERS string,
DOMESTIC_CUSTOMER_GROUP_MEMBER_HOLDER string,
DOMESTIC_CUSTOMER_GROUP_BRANCH_HOLDER string,
DOMESTIC_CUSTOMER_SERIAL_HOLDER double,
MODE_FLAG string,
COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double
)
stored as ORC;


drop table if exists CUSTOMER_INDVL_JOINT;
create table CUSTOMER_INDVL_JOINT
(
COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
CUSTOMER_FULL_NAME string,
CUSTOMER_NAME string,
CUSTOMER_SHORT_NAME string,
INDUSTRY_CODE double,
MARKET_SECTOR_1 double,
CUSTOMER_LEGAL_TYPE double,
GHO_CUSTOMER_CLASSIFICATION string,
ACCOUNT_OFFICER double,
CUSTOMER_STATUS string,
COUNTRY_OF_REGISTRATION_RESIDENCE string,
NATIONALITY_CODE string,
CORRESPONDENT_BANK_ID string,
CORRESPONDENT_BRANCH_ID string,
JOINT_MODE_FLAG string,
JOINT_COUNTRY_CODE string,
JOINT_DOMESTIC_GROUP_MEMBER string,
JOINT_CUSTOMER_BRANCH_NUMBER double,
JOINT_CUSTOMER_SERIAL_NUMBER double
)
stored as ORC;

drop table if exists SS_ACCOUNT;
create table SS_ACCOUNT
(
ACCOUNT_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
GHO_CUSTOMER_CLASSIFICATION string,
ACCOUNT_PRODUCT_TYPE string,
ACCOUNT_STATUS string,
ACCOUNT_TYPE string,
ACCOUNT_FILE string
)
stored as ORC;

drop table if exists DD_ACCOUNT;
create table DD_ACCOUNT
(
ACCOUNT_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
GHO_CUSTOMER_CLASSIFICATION string,
ACCOUNT_PRODUCT_TYPE string,
CORRESPONDENT_BANK_ID string,
CORRESPONDENT_BRANCH_ID string,
ACCOUNT_STATUS string
)
stored as ORC;

drop table if exists CP_ACCOUNT;
create table CP_ACCOUNT
(
DOMESTIC_CUSTOMER_COUNTRY string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
TPC_BRANCH_NUMBER double,
TPC_CUSTOMER_SERIAL_NUMBER double,
ACCOUNT_SHORT_NAME string,
ACCOUNT_PRODUCT_TYPE string,
CURRENCY string,
ACCOUNT_NUMBER double,
ACCOUNT_STATUS string
)
stored as ORC;

drop table if exists LS_ACCOUNT;
create table LS_ACCOUNT
(
ACCOUNT_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
ACCOUNT_PRODUCT_TYPE string,
ACCOUNT_STATUS string
)
stored as ORC;

drop table if exists PL_ACCOUNT;
create table PL_ACCOUNT
(
ACCOUNT_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
ACCOUNT_PRODUCT_TYPE string,
TRANSACTION_REFERENCE_NUMBER double,
ACCOUNT_STATUS string
)
stored as ORC;

drop table if exists TC_ACCOUNT;
create table TC_ACCOUNT
(
ACCOUNT_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
ACCOUNT_PRODUCT_TYPE string,
ACCOUNT_STATUS string
)
stored as ORC;

drop table if exists TD_ACCOUNT;
create table TD_ACCOUNT
(
ACCOUNT_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
ACCOUNT_PRODUCT_TYPE string,
ACCOUNT_STATUS string
)
stored as ORC;


-- all customer
drop table if exists ALL_CUST_ACCT;
create table ALL_CUST_ACCT 
(
FLAG_JOIN string,
COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
CUSTOMER_REFERENCE string,
CUSTOMER_REFERENCE_2 string,
CUSTOMER_FULL_NAME string,
CUSTOMER_NAME string,
CUSTOMER_SHORT_NAME string,
INDUSTRY_CODE double,
MARKET_SECTOR_1 double,
CUSTOMER_LEGAL_TYPE string,
GHO_CUSTOMER_CLASSIFICATION string,
ACCOUNT_OFFICER string,
CUSTOMER_STATUS string,
COUNTRY_OF_REGISTRATION_RESIDENCE string,
NATIONALITY_CODE string,
CORRESPONDENT_BANK_ID string,
CORRESPONDENT_BRANCH_ID string,
CBID string,
BANK_INDICATOR string,
INDIVIDUAL_NON_INDIVUDUAL string,
ACCOUNT_COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX string,
ACCOUNT_REFERENCE string,
CARD_NUMBER string,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
ACCOUNT_PRODUCT_TYPE string,
ACCOUNT_STATUS string,
ACCOUNT_TYPE string,
ACCOUNT_FILE string,
TRANSACTION_REF_NO string,
SYSTEM_CODE_EXT string,
EXTERNAL_ACCOUNT_NUMBER double,
INTERNATIONAL_BANK_ACCOUNT_NUMBER double,
EXTERNAL_ACCOUNT_GPS string,
LOB_HUB_CUSTOMER_GROUP string,
RUN_DATE string
)
PARTITIONED BY (acct string)
stored as ORC;

drop table if exists CLU_ALL_COUNTRY_FLAT_FILE;
create table CLU_ALL_COUNTRY_FLAT_FILE 
(
FLAG_JOIN string,
COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
CUSTOMER_REFERENCE string,
CUSTOMER_REFERENCE_2 string,
CUSTOMER_FULL_NAME string,
CUSTOMER_NAME string,
CUSTOMER_SHORT_NAME string,
INDUSTRY_CODE double,
MARKET_SECTOR_1 double,
CUSTOMER_LEGAL_TYPE string,
GHO_CUSTOMER_CLASSIFICATION string,
ACCOUNT_OFFICER string,
CUSTOMER_STATUS string,
COUNTRY_OF_REGISTRATION_RESIDENCE string,
NATIONALITY_CODE string,
CORRESPONDENT_BANK_ID string,
CORRESPONDENT_BRANCH_ID string,
CBID string,
BANK_INDICATOR string,
INDIVIDUAL_NON_INDIVUDUAL string,
ACCOUNT_COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX string,
ACCOUNT_REFERENCE string,
CARD_NUMBER string,
ACCOUNT_SHORT_NAME string,
CURRENCY string,
ACCOUNT_PRODUCT_TYPE string,
ACCOUNT_STATUS string,
ACCOUNT_TYPE string,
ACCOUNT_FILE string,
TRANSACTION_REF_NO string,
SYSTEM_CODE_EXT string,
EXTERNAL_ACCOUNT_NUMBER double,
INTERNATIONAL_BANK_ACCOUNT_NUMBER double,
EXTERNAL_ACCOUNT_GPS string,
LOB_HUB_CUSTOMER_GROUP string, 
LOB_HUB_FATCA_CORP string,
LOB_HUB_FATCA_NON_CORP string,
LOB_HUB_GLEAM string,
LOB_DR_GBM string,
LOB_DR_CMB string,
LOB_DR_GPB string,
LOB_DR_RBWM string,
LOB_LOCAL string,
LOB_USE string,
GUCI string,
GRID string,
GID string,
DATA_SYSTEM string,
RUN_DATE string
)
PARTITIONED BY (COUNTRY string)
stored as ORC;

drop table if exists LOB_REF_TABLE_CORE;
create table LOB_REF_TABLE_CORE
(
source_field string,
flat_file_lob_use_field string
)
stored as ORC;


drop table if exists EXT_ACCT_FIELDS;
create table EXT_ACCT_FIELDS
(
COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
EXTERNAL_ACCOUNT_NUMBER double,
SYSTEM_CODE double
)
stored as ORC;

drop table if exists NON_CORPORATE_FATCA_LOB;
create table NON_CORPORATE_FATCA_LOB
(
COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
HSBC_BUSINESS_GROUP string
)
stored as ORC;

drop table if exists CORPORATE_FATCA_LOB;
create table CORPORATE_FATCA_LOB
(
COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
HSBC_BUSINESS_GROUP string
)
stored as ORC;

--drop table if exists CORPORATE_FATCA_LOB;
--create table CORPORATE_FATCA_LOB
--(
--COUNTRY_CODE string,
--DOMESTIC_CUSTOMER_GROUP_MEMBER string,
--CUSTOMER_BRANCH_NUMBER double,
--CUSTOMER_SERIAL_NUMBER double,
--MODE_FLAG string,
--CORRESPONDENT_BANK_ID string,
--CORRESPONDENT_BRANCH_ID string,
--HSBC_BUSINESS_GROUP string
--)
--stored as ORC;

drop table if exists EU_ACCT_FIELDS;
create table EU_ACCT_FIELDS
(
COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
EXTERNAL_ACCOUNT_NUMBER double,
SYSTEM_CODE double
)
stored as ORC;

drop table if exists IBAN_ACCT_FIELDS;
create table IBAN_ACCT_FIELDS
(
COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX double,
IBAN_ACCOUNT_NUMBER double
)
stored as ORC;


--Table for data reconciliation
drop table if exists CLU_ACCOUNT_COUNT;
create table CLU_ACCOUNT_COUNT
(
COUNTRY string,
EXEC_DATE string,
ACCOUNT_TYPE string,
INDVL_COUNT int,
JOINT_COUNT int,
EXCEPTION_COUNT int,
SOURCE_COUNT int,
FLAT_FILE_COUNT int,
STATUS string
)
stored as ORC;

--Table for Exception
drop table if exists clu_poc.CLU_EXCEPTIONS;
create table clu_poc.CLU_EXCEPTIONS
(
COUNTRY string,
ACCOUNT_TYPE string,
RUN_DATE string,
ERROR_DESCRIPTION string,
CUSTOMER_COUNTRY_CODE string,
DOMESTIC_CUSTOMER_GROUP_MEMBER string,
CUSTOMER_BRANCH_NUMBER double,
CUSTOMER_SERIAL_NUMBER double,
MODE_FLAG string,
ACCOUNT_COUNTRY_CODE string,
GROUP_MEMBER_ABBREVIATION string,
ACCOUNT_BRANCH string,
ACCOUNT_NUMBER_SERIAL double,
ACCOUNT_SUFFIX string
)
stored as ORC;
