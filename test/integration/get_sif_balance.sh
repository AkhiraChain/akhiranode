#!/bin/bash 

addr=$1
shift

akiranoded q auth account ${addr:=${VALIDATOR1_ADDR}} -o json | jq
