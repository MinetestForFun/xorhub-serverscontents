#!/bin/bash

upgrade_TeeWorlds_infclass() {
    echo ">>> UPDATE de TeeWorlds_infclass - En cours... <<<"
    /home/quentinbd/scripts/w-upgrade-TeeWorlds_infclass.sh
    echo ">>> UPDATE de TeeWorlds_infclass - Terminée <<<"
    sleep 0.5
}

reboot_warsow() {
    echo ">>> Arrêt du serveur Warsow en cours... <<<"
    screen -S "warsow" -X quit
    echo ">>> Arrêt du serveur Warsow terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur Warsow en cours... <<<"
    screen -dmS "warsow" /home/quentinbd/scripts/start-warsow_votable.sh
    echo ">>> Démarrage du serveur Warsow terminé. <<<"
    sleep 0.5
}

reboot_TeeWorlds_Vanilla_CTF() {
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_CTF en cours... <<<"
    screen -S "TeeWorlds_Vanilla_CTF" -X quit
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_CTF terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_CTF en cours... <<<"
    screen -dmS "TeeWorlds_Vanilla_CTF" /home/quentinbd/scripts/start-TeeWorlds_Vanilla_CTF.sh
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_CTF terminé. <<<"
    sleep 0.5
}

reboot_TeeWorlds_Vanilla_DM() {
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_DM en cours... <<<"
    screen -S "TeeWorlds_Vanilla_DM" -X quit
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_DM terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_DM en cours... <<<"
    screen -dmS "TeeWorlds_Vanilla_DM" /home/quentinbd/scripts/start-TeeWorlds_Vanilla_DM.sh
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_DM terminé. <<<"
    sleep 0.5
}

reboot_TeeWorlds_Vanilla_TDM() {
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_TDM en cours... <<<"
    screen -S "TeeWorlds_Vanilla_TDM" -X quit
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_TDM terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_TDM en cours... <<<"
    screen -dmS "TeeWorlds_Vanilla_TDM" /home/quentinbd/scripts/start-TeeWorlds_Vanilla_TDM.sh
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_TDM terminé. <<<"
    sleep 0.5
}

reboot_TeeWorlds_Vanilla_TDM() {
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_TDM en cours... <<<"
    screen -S "TeeWorlds_Vanilla_TDM" -X quit
    echo ">>> Arrêt du serveur TeeWorlds_Vanilla_TDM terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_TDM en cours... <<<"
    screen -dmS "TeeWorlds_Vanilla_TDM" /home/quentinbd/scripts/start-TeeWorlds_Vanilla_TDM.sh
    echo ">>> Démarrage du serveur TeeWorlds_Vanilla_TDM terminé. <<<"
    sleep 0.5
}

reboot_TeeWorlds_infclass() {
    echo ">>> Arrêt du serveur TeeWorlds_infclass en cours... <<<"
    screen -S "TeeWorlds_infclass" -X quit
    echo ">>> Arrêt du serveur TeeWorlds_infclass terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur TeeWorlds_infclass en cours... <<<"
    screen -dmS "TeeWorlds_infclass" /home/quentinbd/scripts/start-TeeWorlds_infclass.sh
    echo ">>> Démarrage du serveur TeeWorlds_infclass terminé. <<<"
    sleep 0.5
}

reboot_TeeWorlds_OpenFNG() {
    echo ">>> Arrêt du serveur TeeWorlds_OpenFNG en cours... <<<"
    screen -S "TeeWorlds_OpenFNG" -X quit
    echo ">>> Arrêt du serveur TeeWorlds_OpenFNG terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur TeeWorlds_OpenFNG en cours... <<<"
    screen -dmS "TeeWorlds_OpenFNG" /home/quentinbd/scripts/start-TeeWorlds_OpenFNG.sh
    echo ">>> Démarrage du serveur TeeWorlds_OpenFNG terminé. <<<"
    sleep 0.5
}

CHOOSE_UPGRADE=$(dialog --separate-output --checklist "Choose the server(s) you want to UPGRADE :" 20 60 10 \
    1 "TeeWorlds_infclass" off \
    3>&1 1>&2 2>&3 3>&-
)

CHOOSERET=$?
echo $CHOOSERET
if [ "$CHOOSERET" = 0 ]; then
  for i in $CHOOSE_UPGRADE; do
    case "$i" in
      # Continuer est par défaut
      1) upgrade_TeeWorlds_infclass ;;
    esac
  done
fi

CHOOSE_REBOOT=$(dialog --separate-output --checklist "Choose the server(s) you want to REBOOT :" 20 60 10 \
    1 "Warsow" off \
    2 "TeeWorlds_Vanilla_CTF" off \
    3 "TeeWorlds_Vanilla_DM" off \
    4 "TeeWorlds_Vanilla_TDM" off \
    5 "TeeWorlds_infclass" off \
    6 "TeeWorlds_OpenFNG" off \
    3>&1 1>&2 2>&3 3>&-
)

CHOOSERET=$?
echo $CHOOSERET
if [ "$CHOOSERET" = 0 ]; then
  for i in $CHOOSE_REBOOT; do
    case "$i" in
      # Continuer est par défaut
      1) reboot_warsow ;;
      2) reboot_TeeWorlds_Vanilla_CTF ;;
      3) reboot_TeeWorlds_Vanilla_DM ;;
      4) reboot_TeeWorlds_Vanilla_TDM ;;
      5) reboot_TeeWorlds_infclass ;;
      6) reboot_TeeWorlds_OpenFNG ;;
    esac
  done
fi

echo ">>> Reboot(s) and/or upgrade(s) done. <<<"
