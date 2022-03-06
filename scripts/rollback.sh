#!/usr/bin/env bash

pkill akhiranoded
sleep 5
akhiranoded export --height -1 > exported_state.json
sleep 1
akhiranoded migrate v0.38 exported_state.json --chain-id new-chain > new-genesis.json  2>&1
sleep 1
akhiranoded unsafe-reset-all
sleep 1
cp new-genesis.json ~/.akhiranoded/config/genesis.json
sleep 2
akhiranoded start