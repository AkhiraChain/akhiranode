#!/usr/bin/env bash

. ../credentials.sh

rm -rf ~/.akiranoded

akiranoded init test --chain-id=sifchain-local
cp ./app.toml ~/.akiranoded/config

echo "Generating deterministic account - ${SHADOWFIEND_NAME}"
echo "${SHADOWFIEND_MNEMONIC}" | akiranoded keys add ${SHADOWFIEND_NAME}  --keyring-backend=test --recover

echo "Generating deterministic account - ${AKASHA_NAME}"
echo "${AKASHA_MNEMONIC}" | akiranoded keys add ${AKASHA_NAME}  --keyring-backend=test --recover

echo "Generating deterministic account - ${JUNIPER_NAME}"
echo "${JUNIPER_MNEMONIC}" | akiranoded keys add ${JUNIPER_NAME} --keyring-backend=test --recover

akiranoded add-genesis-account $(akiranoded keys show ${SHADOWFIEND_NAME} -a --keyring-backend=test) 100000000000000000000000000000aku,100000000000000000000000000000catk,100000000000000000000000000000cbtk,100000000000000000000000000000ceth,100000000000000000000000000000cusdc,100000000000000000000000000000clink,100000000000000000000000000stake
akiranoded add-genesis-account $(akiranoded keys show ${AKASHA_NAME} -a --keyring-backend=test) 100000000000000000000000000000aku,100000000000000000000000000000catk,100000000000000000000000000000cbtk,100000000000000000000000000000ceth,100000000000000000000000000000cusdc,100000000000000000000000000000clink,100000000000000000000000000stake
akiranoded add-genesis-account $(akiranoded keys show ${JUNIPER_NAME} -a --keyring-backend=test) 10000000000000000000000aku,10000000000000000000000cusdc,100000000000000000000clink,100000000000000000000ceth

akiranoded add-genesis-validators $(akiranoded keys show ${SHADOWFIEND_NAME} -a --bech val --keyring-backend=test)

akiranoded gentx ${SHADOWFIEND_NAME} 1000000000000000000000000stake --chain-id=sifchain-local --keyring-backend test

echo "Collecting genesis txs..."
akiranoded collect-gentxs

echo "Validating genesis file..."
akiranoded validate-genesis

echo "Starting test chain"

./start.sh
