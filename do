#!/usr/bin/env bash
set +x 

OP=$1

usage(){
    echo "=============================================================="
    echo "./do <op>"
    echo "=> where:"
    echo "=> op = build.   Build compiles the ligo contract and storage"
     
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

case $OP in 
  "build")
    build;;
   *)
    fail_op
esac

exit 0
