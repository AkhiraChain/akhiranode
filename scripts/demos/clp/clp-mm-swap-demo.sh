#!/usr/bin/env bash

echo "Creating pools ceth and cdash"
akhiranoded tx clp create-pool --from sif --symbol ceth --nativeAmount 20000000000000000000 --externalAmount 20000000000000000000  --yes

sleep 5
akhiranoded tx clp create-pool --from sif --symbol cdash --nativeAmount 20000000000000000000 --externalAmount 20000000000000000000  --yes


sleep 8
echo "Swap Native for Pegged - Sent aku Get ceth"
akhiranoded tx clp swap --from sif --sentSymbol aku --receivedSymbol ceth --sentAmount 2000000000000000000 --minReceivingAmount 0 --yes
sleep 8
echo "Swap Pegged for Native - Sent ceth Get aku"
akhiranoded tx clp swap --from sif --sentSymbol ceth --receivedSymbol aku --sentAmount 2000000000000000000 --minReceivingAmount 0 --yes
sleep 8
echo "Swap Pegged for Pegged - Sent ceth Get cdash"
akhiranoded tx clp swap --from sif --sentSymbol ceth --receivedSymbol cdash --sentAmount 2000000000000000000 --minReceivingAmount 0 --yes

akhiranoded q clp pools

