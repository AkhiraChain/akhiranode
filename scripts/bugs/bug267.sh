#!/usr/bin/env bash


rm -rf ~/.akhiranoded
rm -rf sifnode.log
rm -rf testlog.log

cd "$(dirname "$0")"

./init.sh
sleep 8
akhiranoded start >> sifnode.log 2>&1  &
sleep 8

yes Y | akhiranoded tx clp create-pool --from akasha --symbol catk --nativeAmount 1000 --externalAmount 1000
sleep 8
yes Y | akhiranoded tx clp create-pool --from akasha --symbol cbtk --nativeAmount 1000 --externalAmount 1000


echo "Query specific pool"
sleep 8
akhiranoded query clp pool catk

echo "adding new liquidity provider"
sleep 8
yes Y | akhiranoded tx clp add-liquidity --from sif --symbol catk --nativeAmount 5000000000000000000000 --externalAmount 5000000000000000000

echo "Query 1st Liquidity Provider / Pool creator is the first lp for the pool"
sleep 8
akhiranoded query clp lp catk $(akhiranoded keys show akasha -a)

echo "Query 2nd Liquidity Provider "
sleep 8
akhiranoded query clp lp catk $(akhiranoded keys show sif -a)


pkill akhiranoded
