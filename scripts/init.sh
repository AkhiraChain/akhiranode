#!/usr/bin/env bash

### chain init script for development purposes only ###

make clean install
./akhiranoded init test --chain-id=localnet -o

echo "Generating deterministic account - ak"
echo "race draft rival universe maid cheese steel logic crowd fork comic easy truth drift tomorrow eye buddy head time cash swing swift midnight borrow" | ./akhiranoded keys add ak --recover --keyring-backend=test

echo "Generating deterministic account - akasha"
echo "hand inmate canvas head lunar naive increase recycle dog ecology inhale december wide bubble hockey dice worth gravity ketchup feed balance parent secret orchard" | ./akhiranoded keys add akasha --recover --keyring-backend=test


./akhiranoded keys add mkey --multisig ak,akasha --multisig-threshold 2 --keyring-backend=test

./akhiranoded add-genesis-account $(./akhiranoded keys show ak -a --keyring-backend=test) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink,90000000000000000000ibc/96D7172B711F7F925DFC7579C6CCC3C80B762187215ABD082CDE99F81153DC80 --keyring-backend=test
./akhiranoded add-genesis-account $(./akhiranoded keys show akasha -a --keyring-backend=test) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink --keyring-backend=test

./akhiranoded add-genesis-clp-admin $(./akhiranoded keys show ak -a --keyring-backend=test) --keyring-backend=test
./akhiranoded add-genesis-clp-admin $(./akhiranoded keys show akasha -a --keyring-backend=test) --keyring-backend=test

./akhiranoded set-genesis-oracle-admin ak --keyring-backend=test
./akhiranoded add-genesis-validators $(./akhiranoded keys show ak -a --bech val --keyring-backend=test) --keyring-backend=test

./akhiranoded set-genesis-whitelister-admin ak --keyring-backend=test
./akhiranoded set-gen-denom-whitelist scripts/denoms.json

./akhiranoded gentx ak 1000000000000000000000000stake --chain-id=localnet --keyring-backend=test

echo "Collecting genesis txs..."
./akhiranoded collect-gentxs

echo "Validating genesis file..."
./akhiranoded validate-genesis
