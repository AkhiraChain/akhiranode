#!/bin/zsh

# save balances to examine later
SIF_BEFORE_TRANSFERS=$(echo "localnet-1"; akiranoded q bank balances $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27665; echo ""; echo "localnet-2"; akiranoded q bank balances $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27666; echo ""; echo "localnet-3";  akiranoded q bank balances $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27667)

AKASHA_BEFORE_TRANSFERS=$(echo "localnet-1"; akiranoded q bank balances $(akiranoded keys show akasha -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27665; echo ""; echo "localnet-2"; akiranoded q bank balances $(akiranoded keys show akasha -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27666; echo ""; echo "localnet-3"; akiranoded q bank balances $(akiranoded keys show akasha -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27667)


akiranoded tx ibc-transfer transfer transfer channel-1 $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) 50000000000000000000aku --node tcp://127.0.0.1:27666 --chain-id=localnet-2 --from=akasha --log_level=debug  --keyring-backend test --gas-prices 10000000000000000aku  --home ~/.sifnode-2 --yes --broadcast-mode block
echo "Tried localnet-2 -> localnet-3"
echo ""

sleep 5

akiranoded tx ibc-transfer transfer transfer channel-0 $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) 50000000000000000000aku --node tcp://127.0.0.1:27666 --chain-id=localnet-2 --from=akasha --log_level=debug  --keyring-backend test --gas-prices 10000000000000000aku  --home ~/.sifnode-2 --yes --broadcast-mode block
echo "Tried localnet-2 -> localnet-1"
echo ""

sleep 5

akiranoded tx ibc-transfer transfer transfer channel-0 $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) 50000000000000000000aku --node tcp://127.0.0.1:27665 --chain-id=localnet-1 --from=akasha --log_level=debug  --keyring-backend test --gas-prices 10000000000000000aku  --home ~/.sifnode-1 --yes --broadcast-mode block
echo "Tried localnet-1 -> localnet-2"
echo ""

sleep 5

akiranoded tx ibc-transfer transfer transfer channel-1 $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) 50000000000000000000aku --node tcp://127.0.0.1:27667 --chain-id=localnet-3 --from=akasha --log_level=debug  --keyring-backend test --gas-prices 10000000000000000aku  --home ~/.sifnode-3 --yes --broadcast-mode block
echo "Tried localnet-3 -> localnet-1"
echo ""

sleep 5

akiranoded tx ibc-transfer transfer transfer channel-1 $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) 50000000000000000000aku --node tcp://127.0.0.1:27665 --chain-id=localnet-1 --from=akasha --log_level=debug  --keyring-backend test --gas-prices 10000000000000000aku  --home ~/.sifnode-1 --yes --broadcast-mode block
echo "Tried localnet-1 -> localnet-3"

sleep 10

echo "Checking channels"
hermes query packet unreceived-packets localnet-1 transfer channel-0
hermes query packet unreceived-packets localnet-1 transfer channel-1
hermes query packet unreceived-packets localnet-2 transfer channel-0
hermes query packet unreceived-packets localnet-2 transfer channel-1
hermes query packet unreceived-packets localnet-3 transfer channel-0
hermes query packet unreceived-packets localnet-3 transfer channel-1

echo "Sif balances before transfers"
echo $SIF_BEFORE_TRANSFERS

echo "Current Sif balances (should go up for aku)"
echo "localnet-1"
akiranoded q bank balances $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27665
echo ""
echo "localnet-2"
akiranoded q bank balances $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27666
echo ""
echo "localnet-3"
akiranoded q bank balances $(akiranoded keys show sif -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27667
echo ""

echo "Akasha balances before transfers"
echo $AKASHA_BEFORE_TRANSFERS

echo "Current Akaha balances (should go down for aku)"
echo "localnet-1"
akiranoded q bank balances $(akiranoded keys show akasha -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27665
echo ""
echo "localnet-2"
akiranoded q bank balances $(akiranoded keys show akasha -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27666
echo ""
echo "localnet-3"
akiranoded q bank balances $(akiranoded keys show akasha -a --keyring-backend=test --home ~/.sifnode-1) --node tcp://127.0.0.1:27667
