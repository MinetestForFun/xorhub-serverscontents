#!/bin/bash

PATH_CLONED_REPO=/home/quentinbd/xorhub-serverscontents/

fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du dépôt
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
git clone https://github.com/MinetestForFun/xorhub-serverscontents.git --depth=1 || fatal 'Le clone du dépot a échoué !'
cd $PATH_CLONED_REPO || exit "Le répertoire cloné n'existe pas !"
echo ">>> Clone de xorhub-serverscontents réussit. <<<"

################################
### MAJ du dossier "scripts" ###
################################
cp -R $PATH_CLONED_REPO/SRV-MINETEST/scripts/* /home/quentinbd/scripts/

#####################
### MAJ Minetest ###
#####################
### MFF
# Schematics
cp $PATH_CLONED_REPO/SRV-MINETEST/minetest/mff/worlds/minetestforfun/schems/* /home/quentinbd/mff/worlds/minetestforfun/schems/*

### MFF-CREATIVE
# Schematics
cp $PATH_CLONED_REPO/SRV-MINETEST/minetest/mff-creative/worlds/minetestforfun-creative/schems/* /home/quentinbd/mff-creative/worlds/minetestforfun-creative/schems/*

### MFF-HG
# Schematics
cp $PATH_CLONED_REPO/SRV-MINETEST/minetest/mff-hg/worlds/minetestforfun-hg/schems/* /home/quentinbd/mff-hg/worlds/minetestforfun-hg/schems/*

### MFF-SKYBLOCK
# Schematics
cp $PATH_CLONED_REPO/SRV-MINETEST/minetest/mff-skyblock/worlds/minetestforfun-skyblock/schems/* /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/schems/*

#######################
### MAJ MTsatellite ###
#######################
# MTsatellite configuration file
cp -R $PATH_CLONED_REPO/SRV-MINETEST/var/www/* /var/www/*

# Suppression du dossier cloné
rm -Rf $PATH_CLONED_REPO
echo ''
echo -e '\e[46m                                                                      \e[49m'
echo -e "\e[36mBravo ! Les 'scripts', les 'schematics Minetest' et les maps 'MTsatellite' sont à jour.\e[39m"
echo -e '\e[46m                                                                      \e[49m'
