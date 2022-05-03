#!/usr/bin/env bash
set +x 

OP=$1
ADDR=$2

usage(){
    echo "=============================================================="
    echo "./do <op>"
    echo "=> where:"
    echo "=> op = build.              Build compiles the ligo contract and storage"
    echo "=> op = dryrun.             Performs a dry-run against the liquid contract that deposits a test amount of XTZ"
    echo "=> op = deploy <address>.   Deploys the smart contract for the passed user address"
}

if [ -z "$OP" ]
then
    echo "No operation entered."
    usage
    exit 1;
fi


fail_op(){
   echo "Unsupported operation"
   usage
}

build_storage() {
    echo "Compiling liquid storage"
    ligo compile contract src/liquid.mligo -e  liquid_main -s cameligo -o out/liquid.tz
}

build_contract(){
    echo "Compiling liquid contract"
    INITSTORAGE=$(<src/storage/initial_storage.mligo) 
    ligo compile storage src/liquid.mligo "$INITSTORAGE" -s cameligo  -e  liquid_main -o out/liquid-storage.tz
}

build(){
    build_contract
    build_storage
}



dryrun(){
 echo "Executing dry-run of contract"
 INITSTORAGE=$(<src/storage/initial_storage.mligo) 
 ligo run dry-run src/liquid.mligo "Deposit 5n" "$INITSTORAGE" -s cameligo  -e  liquid_main

}

deploy(){

echo "Deploying contract"
INITSTORAGE=$(<src/storage/initial_storage.mligo) 
tezos-client originate contract "liquid" for "$ADDR" transferring 0tez from $ADDR running out/liquid.tz --init "$INITSTORAGE" --burn-cap 2

}

case $OP in 
  "build")
    build;;
  "dryrun")
    dryrun;;
   "deploy")
    deploy;;
   *)
    fail_op
esac

exit 0
