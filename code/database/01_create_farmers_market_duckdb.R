#################################################################################################################
##
## R Script to (re)create Farmer's Market database using external SQL script.
## The goal of the script is to create database file using DuckDB RDBMS.
## Script adapts the MySQL script from a book "SQL for Data Scientist: A Beginner's Guide for Building Datasets for Analysis" by Renee Teate
## Original code has been downloaded from: https://www.wiley.com/en-us/SQL+for+Data+Scientists%3A+A+Beginner's+Guide+for+Building+Datasets+for+Analysis-p-9781119669364#downloadstab-section
##
#################################################################################################################

# establish connection
con <- DBI::dbConnect(duckdb::duckdb(), dbdir = here::here("data", "db", "farmers_market.duckdb"), read_only = FALSE)

# run sql script file
dbGetQuery(con,
           read_lines(here("code", "database", "00_farmers_market_database.sql")) |>
             glue::glue_collapse(sep = "\n") |>
             glue::glue_sql(.con = con)
)

# close connection
DBI::dbDisconnect(con)
