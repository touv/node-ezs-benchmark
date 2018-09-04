#!/bin/bash

source ./functions.sh $1 $2

process "| Parse raw CSV file                                       |" ./commands/parse-csv.ini
process "| Parse raw CSV file and patch one field on each line      |" ./commands/patch-csv.ini
process "| Parse raw CSV file and anonymise all fields on each line |" ./commands/rewrite-csv.ini
memoize "| Save CSV file with ezs internal format                   |" ./commands/save-csv.ini
execute "| Use saved CSV file                                       |" ./commands/parse-saved-csv.ini
execute "| Use saved CSV file and patch one field on each line      |" ./commands/patch-saved-csv.ini
execute "| Use saved CSV file and anonymise all fields on each line |" ./commands/rewrite-saved-csv.ini
