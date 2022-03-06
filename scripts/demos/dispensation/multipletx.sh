#!/usr/bin/env bash

# Use akhiranoded q account $(akhiranoded keys show sif -a) to get seq
seq=1
akhiranoded tx dispensation create Airdrop output.json --gas 90128 --from $(akhiranoded keys show sif -a) --yes --broadcast-mode async --sequence $seq --account-number 3 --chain-id localnet
seq=$((seq+1))
akhiranoded tx dispensation create ValidatorSubsidy output.json --gas 90128 --from $(akhiranoded keys show sif -a) --yes --broadcast-mode async --sequence $seq --account-number 3 --chain-id localnet
seq=$((seq+1))
akhiranoded tx dispensation create ValidatorSubsidy output.json --gas 90128 --from $(akhiranoded keys show sif -a) --yes --broadcast-mode async --sequence $seq --account-number 3 --chain-id localnet