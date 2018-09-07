#!/bin/bash

source ./functions.sh $1 $2

memoize "| Save CSV file with ezs internal format                   |" ./commands/save-csv.ini
execute "| Use saved CSV file                                       |" ./commands/parse-saved-csv.ini
