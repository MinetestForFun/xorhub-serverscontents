#!/bin/bash

PATH_SCRIPT=/home/quentinbd/scripts/upgrade-mff-hg/
PATH_SERVER=/home/quentinbd/mff-hg/

fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du jeu
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
git clone https://github.com/MinetestForFun/server-minetestforfun-hungry_games.git --depth=1 || fatal 'Le clone du dépot a échoué !'
echo ">>> Clone de server-minetestforfun-hungry_games réussit. <<<"
cd /home/quentinbd/server-minetestforfun-hungry_games/ || exit "Le répertoire cloné n'existe pas !"
git submodule sync
git submodule update --init --recursive || fatal 'La MaJ des submodules a échouée !'

# On sauvegarde les anciens ../games et ../mods
rm -R $PATH_SCRIPT/olds-part/games/
rm -R $PATH_SCRIPT/olds-part/mods/
echo ">>> Ancienne sauvegarde de /mods et /games correctement supprimée. <<<"

cp -R $PATH_SERVER/mods/ $PATH_SCRIPT/olds-part/
cp -R $PATH_SERVER/games/ $PATH_SCRIPT/olds-part/
echo ">>> Sauvegarde de /mods et /games correctement effectuée. <<<"

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R $PATH_SERVER/mods/
rm -R $PATH_SERVER/games/
mkdir -p $PATH_SERVER/games/
mkdir -p /home/quentinbd/server-minetestforfun-hungry_games/games
mkdir -p $PATH_SERVER/games/minetestforfun_hg/
mkdir -p $PATH_SERVER/games/minetestforfun_hg/mods/
cp -R /home/quentinbd/server-minetestforfun-hungry_games/mods/ $PATH_SERVER/games/minetestforfun_hg/
echo ">>> Nouveaux /mods et /games correctement déplacés. <<<"

# On MAJ le minetest.conf, world.mt, random_messages, top_config.txt, et le forbidden_names
mkdir -p $PATH_SERVER/worlds/minetestforfun-hg/
rm $PATH_SERVER/minetest.conf
rm $PATH_SERVER/worlds/minetestforfun-hg/world.mt
rm $PATH_SERVER/worlds/minetestforfun-hg/random_messages
rm $PATH_SERVER/worlds/minetestforfun-hg/top_config.txt
rm $PATH_SERVER/worlds/minetestforfun-hg/forbidden_names.txt
# On les remet
cp /home/quentinbd/server-minetestforfun-hungry_games/minetest.conf $PATH_SERVER/games/minetestforfun_hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/minetest.conf $PATH_SERVER
cp /home/quentinbd/server-minetestforfun-hungry_games/game.conf $PATH_SERVER/games/minetestforfun_hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/world.mt $PATH_SERVER/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/random_messages $PATH_SERVER/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/forbidden_names.txt $PATH_SERVER/worlds/minetestforfun-hg/
cp /home/quentinbd/server-minetestforfun-hungry_games/worlds/minetestforfun-hg/top_config.txt $PATH_SERVER/worlds/minetestforfun-hg/
echo ">>> Nouveau minetest.conf, game.conf, world.mt, le random_messages, forbidden_names et top_config.txt correctement déplacé. <<<"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-hungry_games/
echo ''
echo -e '\e[46m                                                      \e[49m'
echo -e "\e[36mBravo ! mff-hg/mods et mff-hg/games maintenant à jour.\e[39m"
echo -e '\e[46m                                                      \e[49m'

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd $PATH_SERVER
chmod -R 755 $PATH_SERVER
echo ''
echo -e "\e[2mRé-attribution des droits à quentinbd:quentinbd.\e[22m"
