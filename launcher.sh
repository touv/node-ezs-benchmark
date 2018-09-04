#!/bin/bash


OUTPUT=results.tsv
npm uninstall node-zstd
rm -Rf ./node_modules/node-zstd

./batch01.sh ./data/big1.csv "zlib\t100M\t~27k\tnormal" >> $OUTPUT

npm install node-zstd

./batch01.sh ./data/big1.csv "zstd\t100M\t~27k\tnormal" >> $OUTPUT

npx ezs -d &
EZSPID=$!

sleep 1

./batch02.sh ./data/big1.csv "zstd\t100M\t~27k\tdaemon" >> $OUTPUT

sleep 1
kill -s TERM ${EZSPID}
cat $OUTPUT
