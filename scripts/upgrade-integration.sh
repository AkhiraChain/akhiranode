#!/usr/bin/env bash


clibuilder()
{
   echo ""
   echo "Usage: $0 -u UpgradeName -c CurrentBinary -n NewBinary"
   echo -e "\t-u Name of the upgrade [Must match a handler defined in setup-handlers.go in NewBinary]"
   echo -e "\t-c Branch name for old binary (Upgrade From)"
   echo -e "\t-n Branch name for new binary (Upgrade To)"
   exit 1 # Exit script after printing help
}

while getopts "u:c:n:" opt
do
   case "$opt" in
      u ) UpgradeName="$OPTARG" ;;
      c ) CurrentBinary="$OPTARG" ;;
      n ) NewBinary="$OPTARG" ;;
      ? ) clibuilder ;; # Print cliBuilder in case parameter is non-existent
   esac
done

if [ -z "$UpgradeName" ] || [ -z "$CurrentBinary" ] || [ -z "$NewBinary" ]
then
   echo "Some or all of the parameters are empty";
   clibuilder
fi


export DAEMON_HOME=$HOME/.akhiranoded
export DAEMON_NAME=akhiranoded
export DAEMON_ALLOW_DOWNLOAD_BINARIES=true

make clean
rm -rf sifnode.log

rm -rf $GOPATH/bin/akhiranoded
rm -rf $GOPATH/bin/old/akhiranoded
rm -rf $GOPATH/bin/new/akhiranoded

# Setup old binary and start chain

git checkout $CurrentBinary
make install
cp $GOPATH/bin/akhiranoded $GOPATH/bin/old/
chmod +x $GOPATH/akhiranoded
akhiranoded init test --chain-id=localnet -o

echo "Generating deterministic account - sif"
echo "race draft rival universe maid cheese steel logic crowd fork comic easy truth drift tomorrow eye buddy head time cash swing swift midnight borrow" | akhiranoded keys add sif --recover --keyring-backend=test

echo "Generating deterministic account - akasha"
echo "hand inmate canvas head lunar naive increase recycle dog ecology inhale december wide bubble hockey dice worth gravity ketchup feed balance parent secret orchard" | akhiranoded keys add akasha --recover --keyring-backend=test


#akhiranoded keys add mkey --multisig sif,akasha --multisig-threshold 2 --keyring-backend=test

akhiranoded add-genesis-account $(akhiranoded keys show sif -a --keyring-backend=test) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink,90000000000000000000ibc/96D7172B711F7F925DFC7579C6CCC3C80B762187215ABD082CDE99F81153DC80 --keyring-backend=test
akhiranoded add-genesis-account $(akhiranoded keys show akasha -a --keyring-backend=test) 500000000000000000000000aku,500000000000000000000000catk,500000000000000000000000cbtk,500000000000000000000000ceth,990000000000000000000000000stake,500000000000000000000000cdash,500000000000000000000000clink --keyring-backend=test

#akhiranoded add-genesis-clp-admin $(akhiranoded keys show sif -a --keyring-backend=test) --keyring-backend=test
#akhiranoded add-genesis-clp-admin $(akhiranoded keys show akasha -a --keyring-backend=test) --keyring-backend=test

#akhiranoded set-genesis-whitelister-admin sif --keyring-backend=test

#akhiranoded add-genesis-validators $(akhiranoded keys show sif -a --bech val --keyring-backend=test) --keyring-backend=test

akhiranoded gentx sif 1000000000000000000000000stake --chain-id=localnet --keyring-backend=test

echo "Collecting genesis txs..."
akhiranoded collect-gentxs

echo "Validating genesis file..."
akhiranoded validate-genesis


mkdir -p $DAEMON_HOME/cosmovisor/genesis/bin
mkdir -p $DAEMON_HOME/cosmovisor/upgrades/$UpgradeName/bin


# Setup new binary
git checkout $NewBinary
rm -rf $GOPATH/bin/akhiranoded
make install
cp $GOPATH/bin/akhiranoded $GOPATH/bin/new/


# Setup cosmovisor
cp $GOPATH/bin/old/akhiranoded $DAEMON_HOME/cosmovisor/genesis/bin
cp $GOPATH/bin/new/akhiranoded $DAEMON_HOME/cosmovisor/upgrades/$UpgradeName/bin/

chmod +x $DAEMON_HOME/cosmovisor/genesis/bin/akhiranoded
chmod +x $DAEMON_HOME/cosmovisor/upgrades/$UpgradeName/bin/akhiranoded

contents="$(jq '.app_state.gov.voting_params.voting_period = "10s"' $DAEMON_HOME/config/genesis.json)" && \
echo "${contents}" > $DAEMON_HOME/config/genesis.json

# Add state data here if required

cosmovisor start >> sifnode.log 2>&1  &
#sleep 7
#akhiranoded tx tokenregistry register-all /Users/tanmay/Documents/sifnode/scripts/ibc/tokenregistration/localnet/aku.json --from sif --keyring-backend=test --chain-id=localnet --yes
sleep 7
akhiranoded tx gov submit-proposal software-upgrade $UpgradeName --from sif --deposit 100000000stake --upgrade-height 10 --title $UpgradeName --description $UpgradeName --keyring-backend test --chain-id localnet --yes
sleep 7
akhiranoded tx gov vote 1 yes --from sif --keyring-backend test --chain-id localnet --yes
clear
sleep 7
akhiranoded query gov proposal 1

tail -f sifnode.log

#yes Y | akhiranoded tx gov submit-proposal software-upgrade 0.9.14 --from sif --deposit 100000000stake --upgrade-height 30 --title 0.9.14 --description 0.9.14 --keyring-backend test --chain-id localnet