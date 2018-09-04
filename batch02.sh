#!/bin/bash

source ./functions.sh $1 $2

processWithDaemon "| Parse raw CSV file                                       |" ./commands/parse-csv.ini
processWithDaemon "| Parse raw CSV file and patch one field on each line      |" ./commands/patch-csv.ini
processWithDaemon "| Parse raw CSV file and anonymise all fields on each line |" ./commands/rewrite-csv.ini
memoize           "| Save CSV file with ezs internal format                   |" ./commands/save-csv.ini
executeWithDaemon "| Use saved CSV file and patch one field on each line      |" ./commands/patch-saved-csv.ini
executeWithDaemon "| Use saved CSV file and anonymise all fields on each line |" ./commands/rewrite-saved-csv.ini
