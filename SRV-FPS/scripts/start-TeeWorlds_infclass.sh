#!/bin/bash

while true; do
    sleep 5
    screen -S "TeeWorlds_infclass" -X quit
    sleep 0.5
    cd /home/quentinbd/TeeWorlds_infclass/data
    sleep 0.5
    /home/quentinbd/TeeWorlds_infclass/infclass_srv_d -f /home/quentinbd/TeeWorlds_infclass/autoexec.cfg
    sleep 5
done
