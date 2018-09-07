#!/bin/bash

TAG1="zlib\t100M\t~27k\tnormal"
TAG2="zstd\t100M\t~27k\tnormal"
TAG3="zstd\t4,6G\t~16m\tdaemon"

OUTPUT=results.tsv
npm uninstall node-zstd
rm -Rf ./node_modules/node-zstd


./batch01.sh ./data/big1.csv $TAG1 >> $OUTPUT

npm install node-zstd

./batch01.sh ./data/big1.csv $TAG2 >> $OUTPUT
./batch01b.sh ./data/huge1.csv $TAG3 >> $OUTPUT

npx ezs -d &
EZSPID=$!

sleep 1

./batch02.sh ./data/big1.csv $TAG2 >> $OUTPUT
./batch02b.sh ./data/huge1.csv $TAG3 >> $OUTPUT

sleep 1
kill -s TERM ${EZSPID}
cat $OUTPUT
