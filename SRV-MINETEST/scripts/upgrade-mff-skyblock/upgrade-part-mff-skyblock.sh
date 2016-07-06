fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-skyblock.git --depth=1 || fatal 'Le clone du dépot a échoué !'
echo ">>> Clone de server-minetestforfun-skyblock réussit. <<<"
cd /home/quentinbd/server-minetestforfun-skyblock/
git submodule sync
git submodule update --init --recursive || fatal 'La MaJ des submodules a échouée !'

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/scripts/upgrade-mff-skyblock/olds-part/games/
rm -R /home/quentinbd/scripts/upgrade-mff-skyblock/olds-part/mods/
echo ">>> Ancienne sauvegarde de /mods et /games correctement supprimée. <<<"

cp -R /home/quentinbd/mff-skyblock/mods/ /home/quentinbd/scripts/upgrade-mff-skyblock/olds-part/
cp -R /home/quentinbd/mff-skyblock/games/ /home/quentinbd/scripts/upgrade-mff-skyblock/olds-part/
echo ">>> Sauvegarde de /mods et /games correctement effectuée. <<<"

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff-skyblock/mods/
rm -R /home/quentinbd/mff-skyblock/games/
mkdir -p /home/quentinbd/mff-skyblock/games/
mkdir -p /home/quentinbd/server-minetestforfun-skyblock/games
mkdir -p /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/
mkdir -p /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/mods/
cp -R /home/quentinbd/server-minetestforfun-skyblock/mods/ /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/
echo ">>> Nouveaux /mods et /games correctement déplacés. <<<"

# On MAJ le minetest.conf, world.mt, le random_messages et le forbidden_names
mkdir -p /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/
rm /home/quentinbd/mff-skyblock/minetest.conf
rm /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/world.mt
rm /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/random_messages
rm /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/forbidden_names.txt
# On les remet
cp /home/quentinbd/server-minetestforfun-skyblock/minetest.conf /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/minetest.conf /home/quentinbd/mff-skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/game.conf /home/quentinbd/mff-skyblock/games/minetestforfun_skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/worlds/minetestforfun-skyblock/world.mt /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/worlds/minetestforfun-skyblock/random_messages /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/
cp /home/quentinbd/server-minetestforfun-skyblock/worlds/minetestforfun-skyblock/forbidden_names.txt /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/
echo ">>> Nouveau minetest.conf, game.conf, world.mt, le random_messages et le forbidden_names correctement déplacé. <<<"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-skyblock/
echo ''
echo -e '\e[46m                                                                  \e[49m'
echo -e "\e[36mBravo ! mff-skyblock/mods et mff-skyblock/games maintenant à jour.\e[39m"
echo -e '\e[46m                                                                  \e[49m'

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-skyblock/
chmod -R 755 /home/quentinbd/mff-skyblock/
echo ''
echo -e "\e[2mRé-attribution des droits à quentinbd:quentinbd.\e[22m"
#false || fatal 'Ceci est un échec cuisant totalement fictif, pour montrer les couleurs'
