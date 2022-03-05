#!/bin/bash

basedir=$(dirname $0)
. $basedir/vagrantenv.sh

hashes=$(cat $* | grep "^txhash: " | sed -e "s/txhash: //")
for i in $hashes
do
  akiranoded q tx --home $CHAINDIR/.akiranoded $i -o json | jq -c .
done
