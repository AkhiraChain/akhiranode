#!/usr/bin/env bash

cp $GOPATH/src/new/akhiranoded $GOPATH/bin/
cosmovisor start >> sifnode.log 2>&1  &