#!/usr/bin/env bash

. ../credentials.sh

rm -rf ~/.akhiranoded

akhiranoded init test --chain-id=akhirachain-local
cp ./app.toml ~/.akhiranoded/config

echo "Generating deterministic account - ${SHADOWFIEND_NAME}"
echo "${SHADOWFIEND_MNEMONIC}" | akhiranoded keys add ${SHADOWFIEND_NAME}  --keyring-backend=test --recover

echo "Generating deterministic account - ${AKASHA_NAME}"
echo "${AKASHA_MNEMONIC}" | akhiranoded keys add ${AKASHA_NAME}  --keyring-backend=test --recover

echo "Generating deterministic account - ${JUNIPER_NAME}"
echo "${JUNIPER_MNEMONIC}" | akhiranoded keys add ${JUNIPER_NAME} --keyring-backend=test --recover

akhiranoded add-genesis-account $(akhiranoded keys show ${SHADOWFIEND_NAME} -a --keyring-backend=test) 100000000000000000000000000000aku,100000000000000000000000000000catk,100000000000000000000000000000cbtk,100000000000000000000000000000ceth,100000000000000000000000000000cusdc,100000000000000000000000000000clink,100000000000000000000000000stake
akhiranoded add-genesis-account $(akhiranoded keys show ${AKASHA_NAME} -a --keyring-backend=test) 100000000000000000000000000000aku,100000000000000000000000000000catk,100000000000000000000000000000cbtk,100000000000000000000000000000ceth,100000000000000000000000000000cusdc,100000000000000000000000000000clink,100000000000000000000000000stake
akhiranoded add-genesis-account $(akhiranoded keys show ${JUNIPER_NAME} -a --keyring-backend=test) 10000000000000000000000aku,10000000000000000000000cusdc,100000000000000000000clink,100000000000000000000ceth

akhiranoded add-genesis-validators $(akhiranoded keys show ${SHADOWFIEND_NAME} -a --bech val --keyring-backend=test)

akhiranoded gentx ${SHADOWFIEND_NAME} 1000000000000000000000000stake --chain-id=akhirachain-local --keyring-backend test

echo "Collecting genesis txs..."
akhiranoded collect-gentxs

echo "Validating genesis file..."
akhiranoded validate-genesis

echo "Starting test chain"

./start.sh
