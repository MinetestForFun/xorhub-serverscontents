#!/bin/bash

while true; do
    sleep 5
    screen -S "TeeWorlds_OpenFNG" -X quit
    sleep 0.5
    #cd /home/quentinbd/TeeWorlds_OpenFNG/data
    sleep 0.5
    /home/quentinbd/TeeWorlds_OpenFNG/openfng_srv -f /home/quentinbd/TeeWorlds_OpenFNG/openfng.cfg
    sleep 5
done
