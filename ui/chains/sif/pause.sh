#!/bin/bash
pid_sifnode=$(ps aux | grep "./akiranoded start" | grep -v grep | awk '{print $2}')
# pid_rest=$(ps aux | grep "akiranoded rest-server" | grep -v grep | awk '{print $2}')

if [[ ! -z "$pid_sifnode" ]]; then 
  kill -9 $pid_sifnode
fi

# if [[ ! -z "$pid_rest" ]]; then 
#   kill -9 $pid_rest
# fi