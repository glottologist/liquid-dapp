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

build(){
    echo "Compiling liquid contract"
     ligo compile contract src/liquid.mligo -e  liquid_main -s cameligo -o out/liquid.tz
}

case $OP in 
  "build")
    build;;
   *)
    fail_op
esac

exit 0





# Compile contract
ligo compile contract src/liquid.mligo -e liquid_main -s cameligo -o out/liquid.tz