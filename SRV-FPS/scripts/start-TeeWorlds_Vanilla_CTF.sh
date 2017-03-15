#!/bin/bash

while true; do
    sleep 5
    screen -S "TeeWorlds_Vanilla_CTF" -X quit
    sleep 0.5
    #cd /home/quentinbd/TeeWorlds_Vanilla_CTF/data
    sleep 0.5
    /home/quentinbd/TeeWorlds_Vanilla_CTF/teeworlds_srv_d -f /home/quentinbd/TeeWorlds_Vanilla_CTF/serverconfig.cfg
    sleep 5
done
