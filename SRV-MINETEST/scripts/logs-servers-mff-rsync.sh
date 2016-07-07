#!/bin/bash
#rsync -e "ssh -i /root/.ssh/id_dsa" -av --delete-after /home/quentinbd/minetest/worlds/minetestforfun/news.txt root@192.168.1.20:/var/www/wordpress/wp-content/uploads/news/

# Check the public key rights
chmod 600 /home/quentinbd/.ssh/id_rsa
chmod 600 /home/quentinbd/.ssh/id_rsa.pub

#######################
### Begin the RSYNC ###
#######################
# MFF CLASSIC #
###############
# On prend les 1000 dernières lignes des logs et on y met dans "notready-moredebug-mff.txt"
tail -n 1000 /home/quentinbd/scripts/moredebug-mff.txt > /home/quentinbd/scripts/notready-moredebug-mff.txt

# On ajoute une ligne au début
sed -i '1s/^/################################################\n/' /home/quentinbd/scripts/notready-moredebug-mff.txt
sed -i '1s/^/### MFF CLASSIC server - 1000 last log lines ###\n/' /home/quentinbd/scripts/notready-moredebug-mff.txt
sed -i '1s/^/################################################\n/' /home/quentinbd/scripts/notready-moredebug-mff.txt

# On cache les adresses IPs
sed 's/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9]*/???.???.???.???/g' /home/quentinbd/scripts/notready-moredebug-mff.txt > /home/quentinbd/scripts/1000-moredebug-mff.txt

# On envoi "1000-moredebug-mff.txt" puis on le supprime
rsync -azrv --delete /home/quentinbd/scripts/1000-moredebug-mff.txt quentinbd@192.168.1.20:/var/www/wordpress/wp-content/uploads/logs/
echo ">>> Transfert réussi de 1000-moredebug-mff.txt sur le wordpress <<<"
echo ""

# On supprime le fichier temporaire
rm /home/quentinbd/scripts/notready-moredebug-mff.txt
rm /home/quentinbd/scripts/1000-moredebug-mff.txt

##########
# MFF HG #
##########
# On prend les 1000 dernières lignes des logs et on y met dans "notready-moredebug-mff-hg.txt"
tail -n 1000 /home/quentinbd/scripts/moredebug-mff-hg.txt > /home/quentinbd/scripts/notready-moredebug-mff-hg.txt

# On ajoute une ligne au début
sed -i '1s/^/###########################################\n/' /home/quentinbd/scripts/notready-moredebug-mff-hg.txt
sed -i '1s/^/### MFF HG server - 1000 last log lines ###\n/' /home/quentinbd/scripts/notready-moredebug-mff-hg.txt
sed -i '1s/^/###########################################\n/' /home/quentinbd/scripts/notready-moredebug-mff-hg.txt

# On cache les adresses IPs
sed 's/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9]*/???.???.???.???/g' /home/quentinbd/scripts/notready-moredebug-mff-hg.txt > /home/quentinbd/scripts/1000-moredebug-mff-hg.txt

# On envoi "1000-moredebug-mff-hg.txt" puis on le supprime
rsync -azrv --delete /home/quentinbd/scripts/1000-moredebug-mff-hg.txt quentinbd@192.168.1.20:/var/www/wordpress/wp-content/uploads/logs/
echo ">>> Transfert réussi de 1000-moredebug-mff-hg.txt sur le wordpress <<<"
echo ""

# On supprime le fichier temporaire
rm /home/quentinbd/scripts/notready-moredebug-mff-hg.txt
rm /home/quentinbd/scripts/1000-moredebug-mff-hg.txt

################
# MFF SKYBLOCK #
################
# On prend les 1000 dernières lignes des logs et on y met dans "notready-moredebug-mff-skyblock.txt"
tail -n 1000 /home/quentinbd/scripts/moredebug-mff-skyblock.txt > /home/quentinbd/scripts/notready-moredebug-mff-skyblock.txt

# On ajoute une ligne au début
sed -i '1s/^/#################################################\n/' /home/quentinbd/scripts/notready-moredebug-mff-skyblock.txt
sed -i '1s/^/### MFF SKYBLOCK server - 1000 last log lines ###\n/' /home/quentinbd/scripts/notready-moredebug-mff-skyblock.txt
sed -i '1s/^/#################################################\n/' /home/quentinbd/scripts/notready-moredebug-mff-skyblock.txt

# On cache les adresses IPs
sed 's/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9]*/???.???.???.???/g' /home/quentinbd/scripts/notready-moredebug-mff-skyblock.txt > /home/quentinbd/scripts/1000-moredebug-mff-skyblock.txt

# On envoi "1000-moredebug-mff-skyblock.txt" puis on le supprime
rsync -azrv --delete /home/quentinbd/scripts/1000-moredebug-mff-skyblock.txt quentinbd@192.168.1.20:/var/www/wordpress/wp-content/uploads/logs/
echo ">>> Transfert réussi de 1000-moredebug-mff-skyblock.txt sur le wordpress <<<"
echo ""

# On supprime le fichier temporaire
rm /home/quentinbd/scripts/notready-moredebug-mff-skyblock.txt
rm /home/quentinbd/scripts/1000-moredebug-mff-skyblock.txt

################
# MFF CREATIVE #
################
# On prend les 1000 dernières lignes des logs et on y met dans "notready-moredebug-mff-creative.txt"
tail -n 1000 /home/quentinbd/scripts/moredebug-mff-creative.txt > /home/quentinbd/scripts/notready-moredebug-mff-creative.txt

# On ajoute une ligne au début
sed -i '1s/^/#################################################\n/' /home/quentinbd/scripts/notready-moredebug-mff-creative.txt
sed -i '1s/^/### MFF CREATIVE server - 1000 last log lines ###\n/' /home/quentinbd/scripts/notready-moredebug-mff-creative.txt
sed -i '1s/^/#################################################\n/' /home/quentinbd/scripts/notready-moredebug-mff-creative.txt

# On cache les adresses IPs
sed 's/[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9]*/???.???.???.???/g' /home/quentinbd/scripts/notready-moredebug-mff-creative.txt > /home/quentinbd/scripts/1000-moredebug-mff-creative.txt

# On envoi "1000-moredebug-mff-creative.txt" puis on le supprime
rsync -azrv --delete /home/quentinbd/scripts/1000-moredebug-mff-creative.txt quentinbd@192.168.1.20:/var/www/wordpress/wp-content/uploads/logs/
echo ">>> Transfert réussi de 1000-moredebug-mff-creative.txt sur le wordpress <<<"
echo ""

# On supprime le fichier temporaire
rm /home/quentinbd/scripts/notready-moredebug-mff-creative.txt
rm /home/quentinbd/scripts/1000-moredebug-mff-creative.txt
