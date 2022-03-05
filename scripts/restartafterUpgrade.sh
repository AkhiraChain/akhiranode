#!/usr/bin/env bash

cp $GOPATH/src/new/akiranoded $GOPATH/bin/
cosmovisor start >> sifnode.log 2>&1  &