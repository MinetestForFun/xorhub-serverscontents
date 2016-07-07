#!/bin/bash

PATH_CLONED_REPO=/home/quentinbd/xorhub-serverscontents/

fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière du dépôt
cd /home/quentinbd/ || exit "Le répertoire de l'utilisateur n'existe pas !"
git clone https://github.com/MinetestForFun/xorhub-serverscontents.git --depth=1 || fatal 'Le clone du dépot a échoué !'
cd $PATH_CLONED_REPO || exit "Le répertoire cloné n'existe pas !"
echo ">>> Clone de server-minetestforfun réussit. <<<"

################################
### MAJ du dossier "scripts" ###
################################
cp $PATH_CLONED_REPO/scripts/* /home/quentinbd/scripts/

#####################
### MAJ TeeWorlds ###
#####################
### TeeWorlds_infclass
# Fichier de configuration serveur
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_infclass/autoexec.cfg /home/quentinbd/TeeWorlds_infclass/
# Maps
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_infclass/data/maps/* /home/quentinbd/TeeWorlds_infclass/data/maps/

### TeeWorlds_OpenFNG
# Fichier de configuration serveur
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_OpenFNG/openfng.cfg /home/quentinbd/TeeWorlds_OpenFNG/
# Maps
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_OpenFNG/data/maps/* /home/quentinbd/TeeWorlds_OpenFNG/data/maps/

### TeeWorlds_Vanilla_CTF
# Fichier de configuration serveur
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_Vanilla_CTF/serverconfig.cfg /home/quentinbd/TeeWorlds_Vanilla_CTF/
# Maps (aucune pour l'instant)
#cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_Vanilla_CTF/data/maps/* /home/quentinbd/TeeWorlds_Vanilla_CTF/data/maps/

### TeeWorlds_Vanilla_DM
# Fichier de configuration serveur
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_Vanilla_DM/serverconfig.cfg /home/quentinbd/TeeWorlds_Vanilla_DM/
# Maps
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_Vanilla_DM/data/maps/* /home/quentinbd/TeeWorlds_Vanilla_DM/data/maps/

### TeeWorlds_Vanilla_TDM
# Fichier de configuration serveur
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_Vanilla_TDM/serverconfig.cfg /home/quentinbd/TeeWorlds_Vanilla_TDM/
# Maps (les même que TeeWorlds_Vanilla_DM)
cp $PATH_CLONED_REPO/SRV-FPS/teeworlds/TeeWorlds_Vanilla_DM/data/maps/* /home/quentinbd/TeeWorlds_Vanilla_TDM/data/maps/

##################
### MAJ Warsow ###
##################
# Fichier de configuration serveur
cp $PATH_CLONED_REPO/SRV-FPS/warsow/basewsw/* /home/quentinbd/warsow/basewsw/

# Suppression du dossier cloné
rm -Rf $PATH_CLONED_REPO
echo ''
echo -e '\e[46m                                                                               \e[49m'
echo -e "\e[36mBravo ! Le dossier 'scripts', les serveurs 'Teeworlds' et 'Warsow' sont à jour.\e[39m"
echo -e '\e[46m                                                                               \e[49m'
