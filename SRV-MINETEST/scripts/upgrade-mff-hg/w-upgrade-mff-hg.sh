#!/bin/bash

# Aller au répertoire du serveur
cd /home/quentinbd/mff-hg/ || exit "Le répertoire du serveur n'existe pas !"

# Suppression des anciens fichiers
rm -Rv /home/quentinbd/scripts/upgrade-mff-hg/olds
rm -Rv /home/quentinbd/scripts/upgrade-mff-hg/olds-part
rm -Rv /home/quentinbd/scripts/upgrade-mff-hg/mff-hg.tar.gz

# Sauvegarde des fichiers critiques
mkdir /home/quentinbd/mff-hg/games/minetestforfun_hg/
cp -Rv /home/quentinbd/mff-hg/games/minetestforfun_hg/ /home/quentinbd/scripts/upgrade-mff-hg/olds/
cp -Rv /home/quentinbd/mff-hg/mods/ /home/quentinbd/scripts/upgrade-mff-hg/olds/
cp -Rv /home/quentinbd/mff-hg/worlds/ /home/quentinbd/scripts/upgrade-mff-hg/olds/
cp /home/quentinbd/mff-hg/minetest.conf /home/quentinbd/scripts/upgrade-mff-hg/olds/

# Sauvegarde et compression du dossier minetest (au cas ou)
cd /home/quentinbd/scripts/upgrade-mff-hg/ || exit "Le répertoire du script n'existe pas !"
tar -cf mff-hg.tar.gz /home/quentinbd/mff-hg/

# Suppression de minetest
rm -Rv /home/quentinbd/mff-hg/

# Réinstallaton de minetest
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
# DEBUT - Utilisation de la dernière version 0.4 stable
wget https://codeload.github.com/minetest/minetest/zip/stable-0.4
unzip /home/quentinbd/stable-0.4
mv /home/quentinbd/minetest-stable-0.4/ /home/quentinbd/mff-hg/
rm -v /home/quentinbd/stable-0.4
# FIN - Utilisation de la version 0.4 stable

# Compilation
cd /home/quentinbd/mff-hg/ || exit "Le répertoire du serveur n'existe pas !"
# Build REDIS + IRC
cmake . -DBUILD_CLIENT=0 -DBUILD_SERVER=1 -DENABLE_REDIS=1 -DRUN_IN_PLACE=1 -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LUAJIT=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DENABLE_CURL=1
make -j"$(grep -c processor /proc/cpuinfo)"

# Ajout des fichiers critiques au nouveau dossier minetest
cp -Rv /home/quentinbd/scripts/upgrade-mff-hg/olds/minetestforfun_game/ /home/quentinbd/mff-hg/games/
cp -Rv /home/quentinbd/scripts/upgrade-mff-hg/olds/mods/ /home/quentinbd/mff-hg/
cp -Rv /home/quentinbd/scripts/upgrade-mff-hg/olds/worlds/ /home/quentinbd/mff-hg/
cp /home/quentinbd/scripts/upgrade-mff-hg/olds/minetest.conf /home/quentinbd/mff-hg/

# Donne les droits à quentinbd (= utilisateur minetest uniquement, à renommer un jour)
chmod -R 755 /home/quentinbd/mff-hg/
chown -R quentinbd:quentinbd /home/quentinbd/mff-hg/
