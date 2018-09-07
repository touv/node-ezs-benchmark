#!/bin/bash


if test -z "$1"
then
      echo "no input file !"
      exit 1
fi

inputfile=$1
inputsha1=`sha1sum ${inputfile}|cut -d " " -f 1`
mode=${2:-$inputfile}
modesha1=`echo ${mode}|sha1sum|cut -d " " -f 1`
timestamp=`date +%s`
format="${mode}\t%E"

function logging()
{
    echo -e -n "${timestamp}\t$1\t"
}

function ezspath()
{
    echo "./.ezs/${inputsha1}/$modesha1"
}

function process()
{
    logging "$1"
    (/usr/bin/time  -f ${format} npx ezs $2 < ${inputfile} >/dev/null) 2>&1
}

function memoize()
{
    messag="$1"
    script="$2"
    output=`ezspath ${script}`
    if [ ! -d "${output}" ]; then
        logging "${messag}"
        (/usr/bin/time  -f ${format} npx ezs -o ${output} ${script} < ${inputfile} >/dev/null) 2>&1
    fi
}

function execute()
{
    logging "$1"
    script="$2"
    input=`ezspath ${script}`
    (/usr/bin/time -f ${format} npx ezs -i ${input} ${script} >/dev/null) 2>&1
}

function processWithDaemon()
{
    logging "$1"
    (/usr/bin/time -f ${format} npx ezs -s 127.0.0.1 $2 < ${inputfile} >/dev/null) 2>&1
}

function executeWithDaemon()
{
    logging "$1"
    input=`ezspath $2`
    (/usr/bin/time -f ${format} npx ezs -s 127.0.0.1 -i ${input} $2 >/dev/null) 2>&1
}
