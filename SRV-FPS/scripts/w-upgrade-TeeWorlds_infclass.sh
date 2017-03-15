#!/bin/bash
# /!\ Not done /!\

currentdate=`date +%Y_%m_%d_%H_%M`

# Backup the actual TeeWorlds_infclass folder
mv /home/quentinbd/TeeWorlds_infclass/ /home/quentinbd/TeeWorlds_infclass_SAVE$currentdate

# Download the latest TeeWorlds_infclass version
cd /home/quentinbd/
git clone https://github.com/necropotame/teeworlds-infclass.git
cd /home/quentinbd/teeworlds-infclass/
git checkout master
git pull

# Rename to the right name the folder
mv /home/quentinbd/teeworlds-infclass/ /home/quentinbd/TeeWorlds_infclass/

# Install needed packages (if not already done)
sudo aptitude install -y -t jessie-backports bam
sudo aptitude install -y libicu-dev

# Compile the TeeWorlds_infclass server
cd /home/quentinbd/TeeWorlds_infclass/
bam "config=release server"

# Merge all maps and config files for all servers
/home/quentinbd/scripts/merge_SRV-FPS_xorhub-servercontents.sh

# Reboot all TW servers
/home/quentinbd/scripts/reboot_all_TW.sh
