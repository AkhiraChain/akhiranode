#!/usr/bin/env bash

### chain init script for development purposes only ###

make clean-config
akhiranoded init test --chain-id=localnet

echo "Generating deterministic account - sif"
echo "race draft rival universe maid cheese steel logic crowd fork comic easy truth drift tomorrow eye buddy head time cash swing swift midnight borrow" | akhiranoded keys add sif --recover

echo "Generating deterministic account - akasha"
echo "hand inmate canvas head lunar naive increase recycle dog ecology inhale december wide bubble hockey dice worth gravity ketchup feed balance parent secret orchard" | akhiranoded keys add akasha --recover

akhiranoded add-genesis-account $(akhiranoded keys show sif -a) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink
akhiranoded add-genesis-account $(akhiranoded keys show akasha -a) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink

akhiranoded add-genesis-clp-admin $(akhiranoded keys show sif -a)
akhiranoded add-genesis-clp-admin $(akhiranoded keys show akasha -a)

akhiranoded add-genesis-validators $(akhiranoded keys show sif -a --bech val)

akhiranoded gentx sif 1000000000000000000000000stake --keyring-backend test

echo "Collecting genesis txs..."
akhiranoded collect-gentxs

echo "Validating genesis file..."
akhiranoded validate-genesis
