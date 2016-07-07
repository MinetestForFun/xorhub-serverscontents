#!/bin/sh

### ATTENTION ! Ce script effectue UNIQUEMENT un REDEMARRAGE de tous les serveurs !!! (et en aucun cas un update) ###

### Arrêt des serveurs ###
echo ">>> Arrêt de tous les serveurs - En cours... <<<"
screen -S "mff-classic-mtredisalize" -X quit
screen -S "mff-classic-mtseeder" -X quit
screen -S "mff-classic-mtwebmapper" -X quit
screen -S "mff-classic" -X quit
screen -S "mff-hg-mtredisalize" -X quit
screen -S "mff-hg-mtseeder" -X quit
screen -S "mff-hg-mtwebmapper" -X quit
screen -S "mff-hg" -X quit
screen -S "mff-skyblock-mtredisalize" -X quit
screen -S "mff-skyblock-mtseeder" -X quit
screen -S "mff-skyblock-mtwebmapper" -X quit
screen -S "mff-skyblock" -X quit
screen -S "mff-creative-mtredisalize" -X quit
screen -S "mff-creative-mtseeder" -X quit
screen -S "mff-creative-mtwebmapper" -X quit
screen -S "mff-creative" -X quit
sleep 1
echo ">>> Arrêt de tous les serveurs - OK <<<"

### Démarrage des serveurs ###
echo ">>> Démarrage de tous les serveurs - En cours... <<<"
sleep 1
screen -dmS "mff-classic-automappercolors" /home/quentinbd/mff/mods/automappercolors/process.py /home/quentinbd/mff/worlds/minetestforfun/ /home/quentinbd/mff/
sleep 1
screen -dmS "mff-classic-mtredisalize" /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6379 -interleaved=true -change-url=http://localhost:8808/update -change-duration=15s /home/quentinbd/mff/worlds/minetestforfun/map.db
sleep 1
screen -dmS "mff-classic-mtwebmapper" /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff/worlds/minetestforfun/colors.txt -web-host="" -web-port=8808 -map=/home/quentinbd/mff/worlds/minetestforfun/map.db -web=/var/www/mtsatellite -redis-host=localhost -redis-port=6379 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff/worlds/minetestforfun/mt_players_fifo
sleep 1
screen -dmS "mff-classic" /home/quentinbd/scripts/start-mff.sh
sleep 1
screen -dmS "mff-hg-automappercolors" /home/quentinbd/mff-hg/games/minetestforfun_hg/mods/automappercolors/process.py /home/quentinbd/mff-hg/worlds/minetestforfun-hg /home/quentinbd/mff-hg/
sleep 1
screen -dmS "mff-hg-mtredisalize" /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6380 -interleaved=true -change-url=http://localhost:8809/update -change-duration=15s /home/quentinbd/mff-hg/worlds/minetestforfun-hg/map.db
sleep 1
screen -dmS "mff-hg-mtwebmapper" /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff-hg/worlds/minetestforfun-hg/colors.txt -web-host="" -web-port=8809 -map=/home/quentinbd/mff-hg/worlds/minetestforfun-hg/map.db -web=/var/www/mtsatellite-hg -redis-host=localhost -redis-port=6380 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff-hg/worlds/minetestforfun-hg/mt_players_fifo
sleep 1
screen -dmS "mff-hg" /home/quentinbd/scripts/start-mff-hg.sh
sleep 1
screen -dmS "mff-skyblock-automappercolors" /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/mods/automappercolors/process.py /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock /home/quentinbd/mff-skyblock/
sleep 1
screen -dmS mff-skyblock-mtredisalize /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6382 -interleaved=true -change-url=http://localhost:8811/update -change-duration=15s /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/map.db
sleep 1
screen -dmS mff-skyblock-mtwebmapper /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/colors.txt -web-host="" -web-port=8811 -map=/home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/map.db -web=/var/www/mtsatellite-skyblock -redis-host=localhost -redis-port=6382 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/mt_players_fifo
sleep 1
screen -dmS "mff-skyblock" /home/quentinbd/scripts/start-mff-skyblock.sh
sleep 1
screen -dmS "mff-creative-automappercolors" /home/quentinbd/mff-creative/games/minetestforfun_creative/mods/automappercolors/process.py /home/quentinbd/mff-creative/worlds/minetestforfun-creative /home/quentinbd/mff-creative/
sleep 1
screen -dmS mff-creative-mtredisalize /home/quentinbd/gopath/bin/mtredisalize -host=localhost -port=6381 -interleaved=true -change-url=http://localhost:8810/update -change-duration=15s /home/quentinbd/mff-creative/worlds/minetestforfun-creative/map.db
sleep 1
screen -dmS mff-creative-mtwebmapper /home/quentinbd/gopath/bin/mtwebmapper -colors=/home/quentinbd/mff-creative/worlds/minetestforfun-creative/colors.txt -web-host="" -web-port=8810 -map=/home/quentinbd/mff-creative/worlds/minetestforfun-creative/map.db -web=/var/www/mtsatellite-creative -redis-host=localhost -redis-port=6381 -workers=1 -transparent=true -websockets=true -players=/home/quentinbd/mff-creative/worlds/minetestforfun-creative/mt_players_fifo
sleep 1
screen -dmS "mff-creative" /home/quentinbd/scripts/start-mff-creative.sh
sleep 1
echo ">>> Démarrage de tous les serveurs - OK <<<"
echo ">>> Tous les serveurs ont bien été REDEMARRÉ <<<"
