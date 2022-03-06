#!/bin/bash 

addr=$1
shift

akhiranoded q auth account ${addr:=${VALIDATOR1_ADDR}} -o json | jq
