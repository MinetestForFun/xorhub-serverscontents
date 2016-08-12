#!/bin/bash

update_mffclassic() {
    echo ">>> UPDATE de MFF-CLASSIC - En cours... <<<"
    /home/quentinbd/scripts/upgrade-mff/upgrade-part-mff.sh
    echo ">>> UPDATE de MFF-CLASSIC - Terminée <<<"
    sleep 0.5
}

update_mffhungergames() {
    echo ">>> UPDATE de MFF-HUNGERGAMES - En cours... <<<"
    /home/quentinbd/scripts/upgrade-mff-hg/upgrade-part-mff-hg.sh
    echo ">>> UPDATE de MFF-HUNGERGAMES - Terminée <<<"
    sleep 0.5
}

update_mffskyblock() {
    echo ">>> UPDATE de MFF-SKYBLOCK - En cours... <<<"
    /home/quentinbd/scripts/upgrade-mff-skyblock/upgrade-part-mff-skyblock.sh
    echo ">>> UPDATE de MFF-SKYBLOCK - Terminée <<<"
    sleep 0.5
}

update_mffcreative() {
    echo ">>> UPDATE de MFF-CREATIVE - En cours... <<<"
    /home/quentinbd/scripts/upgrade-mff-creative/upgrade-part-mff-creative.sh
    echo ">>> UPDATE de MFF-CREATIVE - Terminée <<<"
    sleep 0.5
}

reboot_mffclassic() {
    echo ">>> Arrêt du serveur MinetestForFun Classic en cours... <<<"
    screen -S "mff-classic-mtredisalize" -X quit
    screen -S "mff-classic-mtseeder" -X quit
    screen -S "mff-classic-mtwebmapper" -X quit
    screen -S "mff-classic" -X quit
    sleep 0.5
    echo ">>> Arrêt du serveur MinetestForFun Classic terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun Classic en cours... <<<"
    screen -dmS "mff-classic-automappercolors" /home/quentinbd/mff/mods/automappercolors/process.py /home/quentinbd/mff/worlds/minetestforfun/ /home/quentinbd/mff/
    sleep 30
    screen -dmS "mff-classic-mtredisalize" /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6379 -interleaved=true -change-url=http://localhost:8808/update -change-duration=15s /home/quentinbd/mff/worlds/minetestforfun/map.db
    sleep 0.5
    screen -dmS "mff-classic-mtwebmapper" nice -n 10 /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff/worlds/minetestforfun/colors.txt -web-host="" -web-port=8808 -map=/home/quentinbd/mff/worlds/minetestforfun/map.db -web=/var/www/mtsatellite -redis-host=localhost -redis-port=6379 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff/worlds/minetestforfun/mt_players_fifo ulimit -n 4096
    sleep 0.5
    screen -dmS "mff-classic" /home/quentinbd/scripts/start-mff.sh
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun Classic terminé. <<<"
}

reboot_mffhungergames() {
    echo ">>> Arrêt du serveur MinetestForFun Hunger Games en cours... <<<"
    screen -S "mff-hg-mtredisalize" -X quit
    screen -S "mff-hg-mtseeder" -X quit
    screen -S "mff-hg-mtwebmapper" -X quit
    screen -S "mff-hg" -X quit
    sleep 0.5
    echo ">>> Arrêt du serveur MinetestForFun Hunger Games terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun Hunger Games en cours... <<<"
    screen -dmS "mff-hg-automappercolors" /home/quentinbd/mff-hg/games/minetestforfun_hg/mods/automappercolors/process.py /home/quentinbd/mff-hg/worlds/minetestforfun-hg /home/quentinbd/mff-hg/
    sleep 30
    screen -dmS "mff-hg-mtredisalize" /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6380 -interleaved=true -change-url=http://localhost:8809/update -change-duration=15s /home/quentinbd/mff-hg/worlds/minetestforfun-hg/map.db
    sleep 0.5
    #Viré car fait lag le serveur pour l'instant : #screen -dmS "mff-hg-mtwebmapper" nice -n 10 /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff-hg/worlds/minetestforfun-hg/colors.txt -web-host="" -web-port=8809 -map=/home/quentinbd/mff-hg/worlds/minetestforfun-hg/map.db -web=/var/www/mtsatellite-hg -redis-host=localhost -redis-port=6380 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff-hg/worlds/minetestforfun-hg/mt_players_fifo ulimit -n 4096
    sleep 0.5
    screen -dmS "mff-hg" /home/quentinbd/scripts/start-mff-hg.sh
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun Hunger Games terminé. <<<"
}

reboot_mffskyblock() {
    echo ">>> Arrêt du serveur MinetestForFun SkyBlock en cours... <<<"
    screen -S "mff-skyblock-mtredisalize" -X quit
    screen -S "mff-skyblock-mtseeder" -X quit
    screen -S "mff-skyblock-mtwebmapper" -X quit
    screen -S "mff-skyblock" -X quit
    sleep 0.5
    echo ">>> Arrêt du serveur MinetestForFun SkyBlock terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun SkyBlock en cours... <<<"
    screen -dmS "mff-skyblock-automappercolors" /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/mods/automappercolors/process.py /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock /home/quentinbd/mff-skyblock/
    sleep 30
    screen -dmS "mff-skyblock-mtredisalize" /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6382 -interleaved=true -change-url=http://localhost:8811/update -change-duration=15s /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/map.db
    sleep 0.5
    screen -dmS "mff-skyblock-mtwebmapper" nice -n 10 /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/colors.txt -web-host="" -web-port=8811 -map=/home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/map.db -web=/var/www/mtsatellite-skyblock -redis-host=localhost -redis-port=6382 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/mt_players_fifo ulimit -n 4096
    sleep 0.5
    screen -dmS "mff-skyblock" /home/quentinbd/scripts/start-mff-skyblock.sh
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun SkyBlock terminé. <<<"
}

reboot_mffcreative() {
    echo ">>> Arrêt du serveur MinetestForFun Creative en cours... <<<"
    screen -S "mff-creative-mtredisalize" -X quit
    screen -S "mff-creative-mtseeder" -X quit
    screen -S "mff-creative-mtwebmapper" -X quit
    screen -S "mff-creative" -X quit
    sleep 0.5
    echo ">>> Arrêt du serveur MinetestForFun Creative terminé. <<<"
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun Creative en cours... <<<"
    screen -dmS "mff-creative-automappercolors" /home/quentinbd/mff-creative/games/minetestforfun_creative/mods/automappercolors/process.py /home/quentinbd/mff-creative/worlds/minetestforfun-creative /home/quentinbd/mff-creative/
    sleep 30
    screen -dmS "mff-creative-mtredisalize" /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6381 -interleaved=true -change-url=http://localhost:8810/update -change-duration=15s /home/quentinbd/mff-creative/worlds/minetestforfun-creative/map.db
    sleep 0.5
    screen -dmS "mff-creative-mtwebmapper" nice -n 10 /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff-creative/worlds/minetestforfun-creative/colors.txt -web-host="" -web-port=8810 -map=/home/quentinbd/mff-creative/worlds/minetestforfun-creative/map.db -web=/var/www/mtsatellite-creative -redis-host=localhost -redis-port=6381 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff-creative/worlds/minetestforfun-creative/mt_players_fifo ulimit -n 4096
    sleep 0.5
    screen -dmS "mff-creative" /home/quentinbd/scripts/start-mff-creative.sh
    sleep 0.5
    echo ">>> Démarrage du serveur MinetestForFun Creative terminé. <<<"
}

CHOOSE_UPDATE=$(dialog --separate-output --checklist "Choose the server you want to UPDATE :" 20 60 10 \
    1 "MinetestForFun Classic" off \
    2 "MinetestForFun Hunger Games" off \
    3 "MinetestForFun SkyBlock" off \
    4 "MinetestForFun Creative" off \
    3>&1 1>&2 2>&3 3>&-
)

CHOOSERET=$?
echo $CHOOSERET
if [ "$CHOOSERET" = 0 ]; then
  for i in $CHOOSE_UPDATE; do
    case "$i" in
      # Continuer est par défaut
      1) update_mffclassic ;;
      2) update_mffhungergames ;;
      3) update_mffskyblock ;;
      4) update_mffcreative ;;
    esac
  done
fi

CHOOSE_REBOOT=$(dialog --separate-output --checklist "Choose the server you want to REBOOT :" 20 60 10 \
    1 "MinetestForFun Classic" off \
    2 "MinetestForFun Hunger Games" off \
    3 "MinetestForFun SkyBlock" off \
    4 "MinetestForFun Creative" off \
    3>&1 1>&2 2>&3 3>&-
)

CHOOSERET=$?
echo $CHOOSERET
if [ "$CHOOSERET" = 0 ]; then
  for i in $CHOOSE_REBOOT; do
    case "$i" in
      # Continuer est par défaut
      1) reboot_mffclassic ;;
      2) reboot_mffhungergames ;;
      3) reboot_mffskyblock ;;
      4) reboot_mffcreative ;;
    esac
  done
fi

echo ">>> Reboot(s) and/or update(s) done. <<<"
