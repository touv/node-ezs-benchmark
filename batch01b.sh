#!/bin/bash

source ./functions.sh $1 $2

process "| Parse raw CSV file                                       |" ./commands/parse-csv.ini
process "| Parse raw CSV file and patch one field on each line      |" ./commands/patch-csv.ini
process "| Parse raw CSV file and anonymise all fields on each line |" ./commands/rewrite-csv.ini
