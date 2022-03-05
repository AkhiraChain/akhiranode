#!/usr/bin/env bash

pkill akiranoded
sleep 5
akiranoded export --height -1 > exported_state.json
sleep 1
akiranoded migrate v0.38 exported_state.json --chain-id new-chain > new-genesis.json  2>&1
sleep 1
akiranoded unsafe-reset-all
sleep 1
cp new-genesis.json ~/.akiranoded/config/genesis.json
sleep 2
akiranoded start