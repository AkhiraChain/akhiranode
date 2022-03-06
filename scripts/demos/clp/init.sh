#!/usr/bin/env bash
rm -rf ~/akhiranoded
rm -rf ~/akhiranoded
rm -rf akhiranode.log
rm -rf testlog.log


akhiranoded init test --chain-id=akhirachain -o

echo "Generating deterministic account - ak"
echo "race draft rival universe maid cheese steel logic crowd fork comic easy truth drift tomorrow eye buddy head time cash swing swift midnight borrow" | akhiranoded keys add ak --recover

echo "Generating deterministic account - akasha"
echo "hand inmate canvas head lunar naive increase recycle dog ecology inhale december wide bubble hockey dice worth gravity ketchup feed balance parent secret orchard" | akhiranoded keys add akasha --recover

akhiranoded add-genesis-account $(akhiranoded keys show ak -a) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink
akhiranoded add-genesis-account $(akhiranoded keys show akasha -a) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink

akhiranoded add-genesis-clp-admin $(akhiranoded keys show ak -a)
akhiranoded add-genesis-clp-admin $(akhiranoded keys show akasha -a)

akhiranoded  add-genesis-validators $(akhiranoded keys show ak -a --bech val)

akhiranoded gentx ak 1000000000000000000000000stake --keyring-backend test

echo "Collecting genesis txs..."
akhiranoded collect-gentxs

echo "Validating genesis file..."
akhiranoded validate-genesis




#contents="$(jq '.gov.voting_params.voting_period = 10' $DAEMON_HOME/config/genesis.json)" && \
#echo "${contents}" > $DAEMON_HOME/config/genesis.json
