#!/bin/bash

# Aller au répertoire du serveur
cd /home/quentinbd/mff-skyblock/ || exit "Le répertoire du serveur n'existe pas !"

# Suppression des anciens fichiers
rm -Rv /home/quentinbd/scripts/upgrade-mff-skyblock/olds
rm -Rv /home/quentinbd/scripts/upgrade-mff-skyblock/olds-part
rm -Rv /home/quentinbd/scripts/upgrade-mff-skyblock/mff-skyblock.tar.gz

# Sauvegarde des fichiers critiques
mkdir /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/
cp -Rv /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/ /home/quentinbd/scripts/upgrade-mff-skyblock/olds/
cp -Rv /home/quentinbd/mff-skyblock/mods/ /home/quentinbd/scripts/upgrade-mff-skyblock/olds/
cp -Rv /home/quentinbd/mff-skyblock/worlds/ /home/quentinbd/scripts/upgrade-mff-skyblock/olds/
cp /home/quentinbd/mff-skyblock/minetest.conf /home/quentinbd/scripts/upgrade-mff-skyblock/olds/

# Sauvegarde et compression du dossier minetest (au cas ou)
cd /home/quentinbd/scripts/upgrade-mff-skyblock/ || exit "Le répertoire du script n'existe pas !"
tar -cf mff-skyblock.tar.gz /home/quentinbd/mff-skyblock/

# Suppression de minetest
rm -Rv /home/quentinbd/mff-skyblock/

# Réinstallaton de minetest
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
# DEBUT - Utilisation de la dernière version 0.4 stable
wget https://codeload.github.com/minetest/minetest/zip/stable-0.4
unzip /home/quentinbd/stable-0.4
mv /home/quentinbd/minetest-stable-0.4/ /home/quentinbd/mff-skyblock/
rm -v /home/quentinbd/stable-0.4
# FIN - Utilisation de la version 0.4 stable

# Compilation
cd /home/quentinbd/mff-skyblock/ || exit "Le répertoire du serveur n'existe pas !"
# Build REDIS + IRC
cmake . -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DENABLE_REDIS=1 -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LUAJIT=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DENABLE_CURL=1
make -j"$(grep -c processor /proc/cpuinfo)"

# Ajout des fichiers critiques au nouveau dossier minetest
cp -Rv /home/quentinbd/scripts/upgrade-mff-skyblock/olds/minetestforfun_skyblock/ /home/quentinbd/mff-skyblock/games/
cp -Rv /home/quentinbd/scripts/upgrade-mff-skyblock/olds/mods/ /home/quentinbd/mff-skyblock/
cp -Rv /home/quentinbd/scripts/upgrade-mff-skyblock/olds/worlds/ /home/quentinbd/mff-skyblock/
cp /home/quentinbd/scripts/upgrade-mff-skyblock/olds/minetest.conf /home/quentinbd/mff-skyblock/

# Donne les droits à quentinbd (= utilisateur minetest uniquement, à renommer un jour)
chmod -R 755 /home/quentinbd/mff-skyblock/
chown -R quentinbd:quentinbd /home/quentinbd/mff-skyblock/
