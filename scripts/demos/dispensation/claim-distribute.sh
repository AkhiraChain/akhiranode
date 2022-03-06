


# Multisig Key - It is a key composed of two or more keys (N) , with a signing threshold (K) ,such that the transaction needs K out of N votes to go through.
akhiranoded tx dispensation claim ValidatorSubsidy --from akasha --keyring-backend test --yes --chain-id localnet -o json
akhiranoded tx dispensation claim ValidatorSubsidy --from sif --keyring-backend test --yes --chain-id localnet -o json
# create airdrop
# mkey = multisig key
# ar1 = name for airdrop , needs to be unique for every airdrop . If not the tx gets rejected
# input.json list of funding addresses  -  Input address must be part of the multisig key
# output.json list of airdrop receivers.
sleep 8
akhiranoded q dispensation claims-by-type ValidatorSubsidy -o json
sleep 8
akhiranoded tx dispensation create ValidatorSubsidy output.json ak1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd --gas 200064128 --from ak1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd --keyring-backend test --fees 100000aku --yes --chain-id akhirachain-devnet-042 --node tcp://rpc-devnet-042.sifchain.finance:80

sleep 8
akhiranoded q dispensation distributions-all --chain-id localnet -o json
#akhiranoded q dispensation records-by-name-all ar1 >> all.json
#akhiranoded q dispensation records-by-name-pending ar1 >> pending.json
#akhiranoded q dispensation records-by-name-completed ar1 >> completed.json
#akhiranoded q dispensation records-by-addr sif1cp23ye3h49nl5ty35vewrtvsgwnuczt03jwg00


