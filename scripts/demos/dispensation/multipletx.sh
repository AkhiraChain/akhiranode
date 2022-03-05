#!/usr/bin/env bash

# Use akiranoded q account $(akiranoded keys show sif -a) to get seq
seq=1
akiranoded tx dispensation create Airdrop output.json --gas 90128 --from $(akiranoded keys show sif -a) --yes --broadcast-mode async --sequence $seq --account-number 3 --chain-id localnet
seq=$((seq+1))
akiranoded tx dispensation create ValidatorSubsidy output.json --gas 90128 --from $(akiranoded keys show sif -a) --yes --broadcast-mode async --sequence $seq --account-number 3 --chain-id localnet
seq=$((seq+1))
akiranoded tx dispensation create ValidatorSubsidy output.json --gas 90128 --from $(akiranoded keys show sif -a) --yes --broadcast-mode async --sequence $seq --account-number 3 --chain-id localnet