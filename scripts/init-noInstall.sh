#!/usr/bin/env bash

### chain init script for development purposes only ###

make clean-config
akiranoded init test --chain-id=localnet

echo "Generating deterministic account - sif"
echo "race draft rival universe maid cheese steel logic crowd fork comic easy truth drift tomorrow eye buddy head time cash swing swift midnight borrow" | akiranoded keys add sif --recover

echo "Generating deterministic account - akasha"
echo "hand inmate canvas head lunar naive increase recycle dog ecology inhale december wide bubble hockey dice worth gravity ketchup feed balance parent secret orchard" | akiranoded keys add akasha --recover

akiranoded add-genesis-account $(akiranoded keys show sif -a) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink
akiranoded add-genesis-account $(akiranoded keys show akasha -a) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink

akiranoded add-genesis-clp-admin $(akiranoded keys show sif -a)
akiranoded add-genesis-clp-admin $(akiranoded keys show akasha -a)

akiranoded add-genesis-validators $(akiranoded keys show sif -a --bech val)

akiranoded gentx sif 1000000000000000000000000stake --keyring-backend test

echo "Collecting genesis txs..."
akiranoded collect-gentxs

echo "Validating genesis file..."
akiranoded validate-genesis
