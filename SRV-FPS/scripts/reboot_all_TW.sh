#!/bin/sh

screen -S "TeeWorlds_Vanilla_CTF" -X quit
sleep 1
screen -dmS "TeeWorlds_Vanilla_CTF" /home/quentinbd/TeeWorlds_Vanilla_CTF/teeworlds_srv_d -f /home/quentinbd/TeeWorlds_Vanilla_CTF/serverconfig.cfg
sleep 1
screen -S "TeeWorlds_Vanilla_DM" -X quit
sleep 1
screen -dmS "TeeWorlds_Vanilla_DM" /home/quentinbd/TeeWorlds_Vanilla_DM/teeworlds_srv_d -f /home/quentinbd/TeeWorlds_Vanilla_DM/serverconfig.cfg
sleep 1
screen -S "TeeWorlds_Vanilla_TDM" -X quit
sleep 1
screen -dmS "TeeWorlds_Vanilla_TDM" /home/quentinbd/TeeWorlds_Vanilla_TDM/teeworlds_srv_d -f /home/quentinbd/TeeWorlds_Vanilla_TDM/serverconfig.cfg
sleep 1
screen -S "TeeWorlds_infclass" -X quit
sleep 1
screen -dmS "TeeWorlds_infclass" /home/quentinbd/TeeWorlds_infclass/teeworlds_srv_d -f /home/quentinbd/TeeWorlds_infclass/autoexec.cfg
sleep 1
screen -S "TeeWorlds_OpenFNG" -X quit
sleep 1
screen -dmS "TeeWorlds_OpenFNG" /home/quentinbd/TeeWorlds_OpenFNG/openfng_srv -f /home/quentinbd/TeeWorlds_OpenFNG/openfng.cfg
sleep 1
echo ">>> Reboot done. <<<"
