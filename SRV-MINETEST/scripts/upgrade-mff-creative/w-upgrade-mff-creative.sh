#!/bin/bash

# Aller au répertoire du serveur
cd /home/quentinbd/mff-creative/ || exit "Le répertoire du serveur n'existe pas !"

# Suppression des anciens fichiers
rm -Rv /home/quentinbd/scripts/upgrade-mff-creative/olds
rm -Rv /home/quentinbd/scripts/upgrade-mff-creative/olds-part
rm -Rv /home/quentinbd/scripts/upgrade-mff-creative/mff-creative.tar.gz

# Sauvegarde des fichiers critiques
mkdir /home/quentinbd/mff-creative/games/minetestforfun_creative/
cp -Rv /home/quentinbd/mff-creative/games/minetestforfun_creative/ /home/quentinbd/scripts/upgrade-mff-creative/olds/
cp -Rv /home/quentinbd/mff-creative/mods/ /home/quentinbd/scripts/upgrade-mff-creative/olds/
cp -Rv /home/quentinbd/mff-creative/worlds/ /home/quentinbd/scripts/upgrade-mff-creative/olds/
cp /home/quentinbd/mff-creative/minetest.conf /home/quentinbd/scripts/upgrade-mff-creative/olds/

# Sauvegarde et compression du dossier minetest (au cas ou)
cd /home/quentinbd/scripts/upgrade-mff-creative/ || exit "Le répertoire du script n'existe pas !"
tar -cf mff-creative.tar.gz /home/quentinbd/mff-creative/

# Suppression de minetest
rm -Rv /home/quentinbd/mff-creative/

# Réinstallaton de minetest
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
# DEBUT - Utilisation de la dernière version 0.4 stable
wget https://codeload.github.com/minetest/minetest/zip/stable-0.4
unzip /home/quentinbd/stable-0.4
mv /home/quentinbd/minetest-stable-0.4/ /home/quentinbd/mff-creative/
rm -v /home/quentinbd/stable-0.4
# FIN - Utilisation de la version 0.4 stable

# Compilation
cd /home/quentinbd/mff-creative/ || exit "Le répertoire du serveur n'existe pas !"
# Build REDIS + IRC
cmake . -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DENABLE_REDIS=1 -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LUAJIT=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DENABLE_CURL=1
make -j"$(grep -c processor /proc/cpuinfo)"

# Ajout des fichiers critiques au nouveau dossier minetest
cp -Rv /home/quentinbd/scripts/upgrade-mff-creative/olds/minetestforfun_creative/ /home/quentinbd/mff-creative/games/
cp -Rv /home/quentinbd/scripts/upgrade-mff-creative/olds/mods/ /home/quentinbd/mff-creative/
cp -Rv /home/quentinbd/scripts/upgrade-mff-creative/olds/worlds/ /home/quentinbd/mff-creative/
cp /home/quentinbd/scripts/upgrade-mff-creative/olds/minetest.conf /home/quentinbd/mff-creative/

# Donne les droits à quentinbd (= utilisateur minetest uniquement, à renommer un jour)
chmod -R 755 /home/quentinbd/mff-creative/
chown -R quentinbd:quentinbd /home/quentinbd/mff-creative/
