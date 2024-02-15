#!/usr/bin/env bash
set -xu

# Usage: ./run.sh <name>
NAME=$1

pushd fmt

LIB=../output/fmt/$NAME
rm -rf ${LIB}
mkdir -p ${LIB}

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --intel --everything > $LIB/intel-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --intel my_test_func > $LIB/intel-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm --everything > $LIB/llvm-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm my_test_func > $LIB/llvm-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm-input --everything > $LIB/llvm-input-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm-input my_test_func > $LIB/llvm-input-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mir --everything > $LIB/mir-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mir my_test_func > $LIB/mir-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mca-intel --everything > $LIB/mca-intel-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mca-intel my_test_func > $LIB/mca-intel-func.txt

popd




pushd str

LIB=../output/str/$NAME
rm -rf ${LIB}
mkdir -p ${LIB}

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --intel --everything > $LIB/intel-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --intel my_test_func > $LIB/intel-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm --everything > $LIB/llvm-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm my_test_func > $LIB/llvm-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm-input --everything > $LIB/llvm-input-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --llvm-input my_test_func > $LIB/llvm-input-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mir --everything > $LIB/mir-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mir my_test_func > $LIB/mir-func.txt

cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mca-intel --everything > $LIB/mca-intel-lib.txt
cargo clean && cargo +stage1 asm --lib --release --rust --simplify --all-sources --mca-intel my_test_func > $LIB/mca-intel-func.txt

popd
