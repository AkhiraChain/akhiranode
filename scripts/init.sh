#!/usr/bin/env bash

### chain init script for development purposes only ###

make clean install
akhiranoded init test --chain-id=sudannet -o

echo "Generating deterministic account - ak"
echo "race draft rival universe maid cheese steel logic crowd fork comic easy truth drift tomorrow eye buddy head time cash swing swift midnight borrow" | akhiranoded keys add ak --recover --keyring-backend=os

echo "Generating deterministic account - akasha"
echo "hand inmate canvas head lunar naive increase recycle dog ecology inhale december wide bubble hockey dice worth gravity ketchup feed balance parent secret orchard" | akhiranoded keys add akasha --recover --keyring-backend=os


akhiranoded keys add mkey --multisig ad,akasha --multisig-threshold 2 --keyring-backend=os

akhiranoded add-genesis-account $(akhiranoded keys show ak -a --keyring-backend=os) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink,90000000000000000000ibc/96D7172B711F7F925DFC7579C6CCC3C80B762187215ABD082CDE99F81153DC80 --keyring-backend=os
akhiranoded add-genesis-account $(akhiranoded keys show akasha -a --keyring-backend=os) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink --keyring-backend=os

akhiranoded add-genesis-clp-admin $(akhiranoded keys show ak -a --keyring-backend=os) --keyring-backend=os
akhiranoded add-genesis-clp-admin $(akhiranoded keys show akasha -a --keyring-backend=os) --keyring-backend=os

akhiranoded set-genesis-oracle-admin ad --keyring-backend=os
akhiranoded add-genesis-validators $(akhiranoded keys show ak -a --bech val --keyring-backend=os) --keyring-backend=os

akhiranoded set-genesis-whitelister-admin ak --keyring-backend=os
akhiranoded set-gen-denom-whitelist scripts/denoms.json

akhiranoded gentx akasha 1000000000000000000000000stake --chain-id=sudannet --keyring-backend=os

echo "Collecting genesis txs..."
akhiranoded collect-gentxs

echo "Validating genesis file..."
akhiranoded validate-genesis
