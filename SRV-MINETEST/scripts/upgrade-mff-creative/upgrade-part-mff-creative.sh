#!/bin/bash

PATH_SCRIPT=/home/quentinbd/scripts/upgrade-mff-creative/
PATH_SERVER=/home/quentinbd/mff-creative/

fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du jeu
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
git clone https://github.com/MinetestForFun/server-minetestforfun-creative.git --depth=1 || fatal 'Le clone du dépot a échoué !'
echo ">>> Clone de server-minetestforfun-creative réussit. <<<"
cd /home/quentinbd/server-minetestforfun-creative/ || exit "Le répertoire cloné n'existe pas !"
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
cp -R /home/quentinbd/server-minetestforfun-creative/minetestforfun_game/ $PATH_SERVER/games/
mv $PATH_SERVER/games/minetestforfun_game/ $PATH_SERVER/games/minetestforfun_creative/
mkdir -p $PATH_SERVER/games/minetestforfun_creative/
mkdir -p $PATH_SERVER/games/minetestforfun_creative/mods/
cp -R /home/quentinbd/server-minetestforfun-creative/mods/ $PATH_SERVER
echo ">>> Nouveaux /mods et /games correctement déplacés. <<<"

# On MAJ le minetest.conf, game.conf, world.mt, random_messages, et le forbidden_names
mkdir -p $PATH_SERVER/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/minetestforfun_game/game.conf $PATH_SERVER/games/minetestforfun_creative/
rm $PATH_SERVER/minetest.conf
rm $PATH_SERVER/worlds/minetestforfun-creative/world.mt
rm $PATH_SERVER/worlds/minetestforfun-creative/random_messages
# On les remet
cp /home/quentinbd/server-minetestforfun-creative/minetest.conf $PATH_SERVER/games/minetestforfun_creative/
cp /home/quentinbd/server-minetestforfun-creative/minetest.conf $PATH_SERVER
cp /home/quentinbd/server-minetestforfun-creative/minetestforfun_game/game.conf $PATH_SERVER/games/minetestforfun_creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/world.mt $PATH_SERVER/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/random_messages $PATH_SERVER/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/forbidden_names.txt $PATH_SERVER/worlds/minetestforfun-creative/
echo ">>> Nouveau minetest.conf, game.conf, world.mt, random_messages, et le forbidden_names correctement déplacé. <<<"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-creative/
echo ''
echo -e '\e[46m                                                                  \e[49m'
echo -e "\e[36mBravo ! mff-creative/mods et mff-creative/games maintenant à jour.\e[39m"
echo -e '\e[46m                                                                  \e[49m'

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd $PATH_SERVER
chmod -R 755 $PATH_SERVER
echo ''
echo -e "\e[2mRé-attribution des droits à quentinbd:quentinbd.\e[22m"
