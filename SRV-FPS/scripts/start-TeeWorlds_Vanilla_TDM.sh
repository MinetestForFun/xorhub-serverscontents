#!/bin/bash

while true; do
    sleep 5
    screen -S "TeeWorlds_Vanilla_TDM" -X quit
    sleep 0.5
    #cd /home/quentinbd/TeeWorlds_Vanilla_TDM/data
    sleep 0.5
    /home/quentinbd/TeeWorlds_Vanilla_TDM/teeworlds_srv_d -f /home/quentinbd/TeeWorlds_Vanilla_TDM/serverconfig.cfg
    sleep 5
done
