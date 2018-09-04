#!/bin/bash


if test -z "$1" 
then
      echo "no input file !"
      exit 1
fi

inputfile=$1
mode=${2:-$inputfile}
timestamp=`date +%s`
savedir=./.data
format="${mode}\t%E"

function logging()
{
    echo -e -n "${timestamp}\t$1\t"
}

function process()
{
    logging "$1"
    (/usr/bin/time  -f ${format} npx ezs $2 < ${inputfile} >/dev/null) 2>&1
}

function memoize()
{
    logging "$1"
    (/usr/bin/time  -f ${format} npx ezs -o ${savedir} $2 < ${inputfile} >/dev/null) 2>&1
}

function execute()
{
    logging "$1"
    (/usr/bin/time -f ${format} npx ezs -i ./.data $2 >/dev/null) 2>&1
}

function processWithDaemon()
{
    logging "$1"
    (/usr/bin/time -f ${format} npx ezs -s 127.0.0.1 $2 < ${inputfile} >/dev/null) 2>&1
}

function executeWithDaemon()
{
    logging "$1"
    (/usr/bin/time -f ${format} npx ezs -s 127.0.0.1 -i ./.data $2 >/dev/null) 2>&1
}
