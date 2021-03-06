#!/bin/sh
#
# Script to read back backups of the database
#
#Create a blank file
echo "" > create_tradedb.sql

#Setup the basics of the database
cat trading_user.sql >> create_tradedb.sql
cat trading_database.sql >> create_tradedb.sql
cat trading_grant.sql >> create_tradedb.sql

#Setup Database and schema
# Triple backslash to work with debian (ignores arguments)
echo "-- SCRIPT BEGIN: set up connection and schema" >> create_tradedb.sql
echo "\\\connect tradingdb" >> create_tradedb.sql
echo "set schema 'trading_schema';" >> create_tradedb.sql
echo "-- SCRIPT END" >> create_tradedb.sql

#Write the data into the system
cat tradingdb.sql >> create_tradedb.sql
cat tradingdb_data.sql >> create_tradedb.sql

#Modify the schema so we load the correct one
#sed -iv 's/trading_schema/tradingdb.trading_schema/' create_tradedb.sql
