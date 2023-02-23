#!/bin/bash

# [assignment] create your own bash script to compile Multiplier3.circom modeling after compile-HelloWorld.sh below

cd contracts/circuits

mkdir Multiplier3

if [ -f ./powersOfTau28_hez_final_10.ptau ]; then
    echo "powersOfTau28_hez_final_10.ptau already exists. Skipping."
else
    echo 'Downloading powersOfTau28_hez_final_10.ptau'
    wget https://hermez.s3-eu-west-1.amazonaws.com/powersOfTau28_hez_final_10.ptau
fi

FOLDER_NAME=Multiplier3_groth16

mkdir -p $FOLDER_NAME

# Compile circuit
circom Multiplier3.circom --r1cs --wasm --sym --inspect -o $FOLDER_NAME
snarkjs r1cs info $FOLDER_NAME/Multiplier3.r1cs

# Does a contribution
snarkjs groth16 setup $FOLDER_NAME/Multiplier3.r1cs powersOfTau28_hez_final_10.ptau $FOLDER_NAME/Multiplier3_0000.zkey
snarkjs zkey contribute $FOLDER_NAME/Multiplier3_0000.zkey $FOLDER_NAME/Multiplier3_final.zkey --name="israel" -v -e="xpto-blablabla"
snarkjs zkey export verificationkey $FOLDER_NAME/Multiplier3_final.zkey $FOLDER_NAME/verification_key.json
snarkjs zkey export solidityverifier $FOLDER_NAME/Multiplier3_final.zkey ../Multiplier3_Verifier.sol

cd ../..
