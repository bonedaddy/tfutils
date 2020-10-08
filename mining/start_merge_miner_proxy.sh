#! /bin/bash

TESTNET="true"
MONEROD_DATADIR="CHANGEME"
TOWNFORGE_DATADIR="CHANGEME"
WALLET_ADDRESS="CHANGEME"

if [[ "$MONEROD_DATADIR" == "CHANGEME" ]]; then
    echo "enter monerod datadir: "
    read -r MONEROD_DATADIR
fi

if [[ "$TOWNFORGE_DATADIR" == "CHANGEME" ]]; then
    echo "enter townforge datadir: "
    read -r TOWNFORGE_DATADIR
fi

if [[ "$WALLET_ADDRESS" == "CHANGEME" ]]; then
    echo "enter wallet address: "
    read -r WALLET_ADDRESS
fi

if [[ "$TESTNET" == "true" ]]; then
    # you will need a patched monerod build for proper use, right now
    # i compiled this and named it `monerod-townforge-patch` in my $PATH
    # monerod --testnet --data-dir="$MONEROD_DATADIR" --detach
    monerod-townforge-patch --testnet --data-dir="$MONEROD_DATADIR" --detach
    townforged --rpc-bind-port 18881 --data-dir="$TOWNFORGE_DATADIR" --detach
    townforge-merge-mining-proxy --monero-daemon-address 127.0.0.1:28081 --aux-daemon-address 127.0.0.1:18881 --rpc-bind-port 18083 --aux-wallet-address "$WALLET_ADDRESS"
else
    echo "only testnet supported"
fi