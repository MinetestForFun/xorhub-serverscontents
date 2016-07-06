fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun.git --depth=1 || fatal 'Le clone du dépot a échoué !'
echo ">>> Clone de server-minetestforfun réussit. <<<"
cd /home/quentinbd/server-minetestforfun/
git submodule sync
git submodule update --init --recursive || fatal 'La MaJ des submodules a échouée !'

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff/olds-part/games/
rm -R /home/quentinbd/upgrade-mff/olds-part/mods/
echo ">>> Ancienne sauvegarde de /mods et /games correctement supprimée. <<<"

cp -R /home/quentinbd/mff/mods/ /home/quentinbd/upgrade-mff/olds-part/
cp -R /home/quentinbd/mff/games/ /home/quentinbd/upgrade-mff/olds-part/
echo ">>> Sauvegarde de /mods et /games correctement effectuée. <<<"

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff/games/
rm -R /home/quentinbd/mff/mods/
mkdir -p /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun/minetestforfun_game/ /home/quentinbd/mff/games/
cp -R /home/quentinbd/server-minetestforfun/mods/ /home/quentinbd/mff/
echo ">>> Nouveaux /mods et /games correctement déplacés. <<<"

# On MAJ le minetest.conf, world.mt, random_messages, forbidden_names, et le news.txt
mkdir -p /home/quentinbd/mff/worlds/minetestforfun/
rm /home/quentinbd/mff/minetest.conf
rm /home/quentinbd/mff/worlds/minetestforfun/world.mt
rm /home/quentinbd/mff/worlds/minetestforfun/random_messages
rm /home/quentinbd/mff/worlds/minetestforfun/news.txt
rm /home/quentinbd/mff/worlds/minetestforfun/forbidden_names.txt
# On les remet
cp /home/quentinbd/server-minetestforfun/minetest.conf /home/quentinbd/mff/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/world.mt /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/random_messages /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/news.txt /home/quentinbd/mff/worlds/minetestforfun/
cp /home/quentinbd/server-minetestforfun/worlds/minetestforfun/forbidden_names.txt /home/quentinbd/mff/worlds/minetestforfun/
echo ">>> Nouveau minetest.conf, game.conf, world.mt, random_messages, et le forbidden_names correctement déplacé. <<<"

# TEMPORAIRE - ré-ajout de l'ancien mod irc
#rm -R /home/quentinbd/mff/mods/irc/
#cp -R /home/quentinbd/server-minetestforfun/other_things/irc-old-save/ /home/quentinbd/mff/mods/
#mv /home/quentinbd/mff/mods/irc-old-save/ /home/quentinbd/mff/mods/irc/
#echo "TEMPORAIRE - ré-ajout de l'ancien mod irc"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun/
echo ''
echo -e '\e[46m                                                                \e[49m'
echo -e "\e[36mBravo ! mff-classic/mods et mff-classic/games maintenant à jour.\e[39m"
echo -e '\e[46m                                                                \e[49m'

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff/
chmod -R 755 /home/quentinbd/mff/
echo ''
echo -e "\e[2mRé-attribution des droits à quentinbd:quentinbd.\e[22m"
#false || fatal 'Ceci est un échec cuisant totalement fictif, pour montrer les couleurs'
