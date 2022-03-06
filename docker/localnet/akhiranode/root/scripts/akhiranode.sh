#!/bin/sh
#
# Sifchain: Sifnode Genesis Entrypoint.
#

#
# Configure the node.
#
setup() {
  akhgen node create "$CHAINNET" "$MONIKER" "$MNEMONIC" --bind-ip-address "$BIND_IP_ADDRESS" --standalone --keyring-backend test
}

#
# Run the node under cosmovisor.
#
run() {
  akhiranoded start --rpc.laddr=tcp://0.0.0.0:26657 --minimum-gas-prices="$GAS_PRICE"
}

setup
run
