#!/bin/bash

set -e

UI=$PWD

./scripts/stack-pause.sh 
cd $UI/chains/peggy && ./snapshot.sh
cd $UI/chains/ak && ./snapshot.sh
cd $UI/chains/eth && ./snapshot.sh

