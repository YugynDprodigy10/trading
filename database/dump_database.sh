#!/bin/sh
#psql -d tradingdb -U trading -w
#Script to dump everything
#pg_dump Ft  -Utrading tradingdb > sql/tradingdb.tar
#Script to make entire DBi schema, create etc
pg_dump -svc --host=localhost -Utrading tradingdb > sql/tradingdb.sql
#Script to store data only
pg_dump -va --host=localhost --data-only -Utrading tradingdb > sql/tradingdb_data.sql
#Compress the data
tar -cvf sql/tradingdb.tar sql/tradingdb.sql sql/tradingdb_data.sql
#Exchange and Symbols only
pg_dump -va --host=localhost -Utrading tradingdb --data-only --table=trading_schema.symbol --table=trading_schema.exchange > sql/tradingdb_symbols.sql
