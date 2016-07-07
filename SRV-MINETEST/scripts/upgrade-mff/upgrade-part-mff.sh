#!/usr/bin/bash

PATH_SCRIPT=/home/quentinbd/scripts/upgrade-mff/
PATH_SERVER=/home/quentinbd/mff/

fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du jeu
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
git clone https://github.com/MinetestForFun/server-minetestforfun.git --depth=1 || fatal 'Le clone du dépot a échoué !'
echo ">>> Clone de server-minetestforfun réussit. <<<"
cd /home/quentinbd/server-minetestforfun/ || exit "Le répertoire cloné n'existe pas !"
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
rm -R $PATH_SERVER/games/
rm -R $PATH_SERVER/mods/
mkdir -p $PATH_SERVER/games/
cp -R /home/quentinbd/server-minetestforfun/minetestforfun_game/ $PATH_SERVER/games/
cp -R /home/quentinbd/server-minetestforfun/mods/ $PATH_SERVER
echo ">>> Nouveaux /mods et /games correctement déplacés. <<<"

# On MAJ le minetest.conf, world.mt, random_messages, forbidden_names, et le news.txt
mkdir -p $PATH_SERVER/worlds/minetestforfun/
rm $PATH_SERVER/minetest.conf
rm $PATH_SERVER/worlds/minetestforfun/world.mt
rm $PATH_SERVER/worlds/minetestforfun/random_messages
rm $PATH_SERVER/worlds/minetestforfun/news.txt
rm $PATH_SERVER/worlds/minetestforfun/forbidden_names.txt
# On les remet
cp /home/quentinbd/server-minetestforfun/minetest.conf $PATH_SERVER
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/world.mt $PATH_SERVER/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/random_messages $PATH_SERVER/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/news.txt $PATH_SERVER/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/forbidden_names.txt $PATH_SERVER/worlds/minetestforfun/
echo ">>> Nouveau minetest.conf, game.conf, world.mt, random_messages, et le forbidden_names correctement déplacé. <<<"

# TEMPORAIRE - ré-ajout de l'ancien mod irc
#rm -R $PATH_SERVER/mods/irc/
#cp -R /home/quentinbd/server-minetestforfun/other_things/irc-old-save/ $PATH_SERVER/mods/
#mv $PATH_SERVER/mods/irc-old-save/ $PATH_SERVER/mods/irc/
#echo "TEMPORAIRE - ré-ajout de l'ancien mod irc"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun/
echo ''
echo -e '\e[46m                                                                \e[49m'
echo -e "\e[36mBravo ! mff-classic/mods et mff-classic/games maintenant à jour.\e[39m"
echo -e '\e[46m                                                                \e[49m'

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd $PATH_SERVER
chmod -R 755 $PATH_SERVER
echo ''
echo -e "\e[2mRé-attribution des droits à quentinbd:quentinbd.\e[22m"
