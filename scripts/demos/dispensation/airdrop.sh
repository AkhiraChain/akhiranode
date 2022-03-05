


# Multisig Key - It is a key composed of two or more keys (N) , with a signing threshold (K) ,such that the transaction needs K out of N votes to go through.

# create airdrop
# mkey = multisig key
# ar1 = name for airdrop , needs to be unique for every airdrop . If not the tx gets rejected
# input.json list of funding addresses  -  Input address must be part of the multisig key
# output.json list of airdrop receivers.
akiranoded tx dispensation create ValidatorSubsidy output.json sif1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd --from sif1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd --yes --fees 150000aku --chain-id=localnet --keyring-backend=test
akiranoded tx dispensation run 29_sif1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd ValidatorSubsidy--from sif1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd --yes --fees 150000aku --chain-id=localnet --keyring-backend=test
sleep 8
akiranoded q dispensation distributions-all -chain-id localnet
#akiranoded q dispensation records-by-name-all ar1 >> all.json
#akiranoded q dispensation records-by-name-pending ar1 >> pending.json
#akiranoded q dispensation records-by-name-completed ar1 >> completed.json
#akiranoded q dispensation records-by-addr sif1cp23ye3h49nl5ty35vewrtvsgwnuczt03jwg00

akiranoded tx dispensation create Airdrop output.json --gas 90128 --from $(akiranoded keys show sif -a) --yes --broadcast-mode async --sequence 26 --account-number 3 --chain-id localnet
akiranoded tx dispensation create Airdrop output.json --gas 90128 --from $(akiranoded keys show sif -a) --yes --broadcast-mode async --sequence 27 --account-number 3 --chain-id localnet
akiranoded tx dispensation run 25_sif1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd ValidatorSubsidy --from sif1syavy2npfyt9tcncdtsdzf7kny9lh777yqc2nd --yes --gas auto --gas-adjustment=1.5 --gas-prices 1.0aku --chain-id=localnet --keyring-backend=test



