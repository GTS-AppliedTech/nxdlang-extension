#!/usr/bin/env bash
set -e

echo "==============================="
echo "==== Formatting & Building ===="
echo "==============================="
cargo fmt
cargo build

echo "==============================="
echo "==============================="
echo "======== Testing Build ========"
echo "==============================="
cargo test

echo "==============================="
echo "==============================="
echo "= Cargo Successful Completion ="
echo "==============================="
echo "==============================="
