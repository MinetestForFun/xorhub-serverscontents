fatal() {
  echo -e '\n\e[41m\n\e[49m\n'
  echo -e "\e[1m\e[4m\e[5m\e[91m$1\e[0m\n"
  echo -e '\e[41m\n\e[49m\n'
  exit
}

# On récupère la dernière version du jeu
cd /home/quentinbd/
git clone https://github.com/MinetestForFun/server-minetestforfun-creative.git --depth=1 || fatal 'Le clone du dépot a échoué !'
echo ">>> Clone de server-minetestforfun-creative réussit. <<<"
cd /home/quentinbd/server-minetestforfun-creative/
git submodule sync
git submodule update --init --recursive || fatal 'La MaJ des submodules a échouée !'

# On sauvegarde les anciens ../games et ../mods
rm -R /home/quentinbd/upgrade-mff-creative/olds-part/games/
rm -R /home/quentinbd/upgrade-mff-creative/olds-part/mods/
echo ">>> Ancienne sauvegarde de /mods et /games correctement supprimée. <<<"

cp -R /home/quentinbd/mff-creative/mods/ /home/quentinbd/upgrade-mff-creative/olds-part/
cp -R /home/quentinbd/mff-creative/games/ /home/quentinbd/upgrade-mff-creative/olds-part/
echo ">>> Sauvegarde de /mods et /games correctement effectuée. <<<"

# On MAJ les nouveaux minetest/games et minetest/mods
rm -R /home/quentinbd/mff-creative/mods/
rm -R /home/quentinbd/mff-creative/games/
mkdir -p /home/quentinbd/mff-creative/games/
cp -R /home/quentinbd/server-minetestforfun-creative/minetestforfun_game/ /home/quentinbd/mff-creative/games/
mv /home/quentinbd/mff-creative/games/minetestforfun_game/ /home/quentinbd/mff-creative/games/minetestforfun_creative/
mkdir -p /home/quentinbd/mff-creative/games/minetestforfun_creative/
mkdir -p /home/quentinbd/mff-creative/games/minetestforfun_creative/mods/
cp -R /home/quentinbd/server-minetestforfun-creative/mods/ /home/quentinbd/mff-creative/
echo ">>> Nouveaux /mods et /games correctement déplacés. <<<"

# On MAJ le minetest.conf, game.conf, world.mt, random_messages, et le forbidden_names
mkdir -p /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/minetestforfun_game/game.conf /home/quentinbd/mff-creative/games/minetestforfun_creative/
rm /home/quentinbd/mff-creative/minetest.conf
rm /home/quentinbd/mff-creative/worlds/minetestforfun-creative/world.mt
rm /home/quentinbd/mff-creative/worlds/minetestforfun-creative/random_messages
# On les remet
cp /home/quentinbd/server-minetestforfun-creative/minetest.conf /home/quentinbd/mff-creative/games/minetestforfun_creative/
cp /home/quentinbd/server-minetestforfun-creative/minetest.conf /home/quentinbd/mff-creative/
cp /home/quentinbd/server-minetestforfun-creative/minetestforfun_game/game.conf /home/quentinbd/mff-creative/games/minetestforfun_creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/world.mt /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/random_messages /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
cp /home/quentinbd/server-minetestforfun-creative/worlds/minetestforfun-creative/forbidden_names.txt /home/quentinbd/mff-creative/worlds/minetestforfun-creative/
echo ">>> Nouveau minetest.conf, game.conf, world.mt, random_messages, et le forbidden_names correctement déplacé. <<<"

# Suppression du dossier cloné
rm -Rf /home/quentinbd/server-minetestforfun-creative/
echo ''
echo -e '\e[46m                                                                  \e[49m'
echo -e "\e[36mBravo ! mff-creative/mods et mff-creative/games maintenant à jour.\e[39m"
echo -e '\e[46m                                                                  \e[49m'

# On ré-attribut les droits à quentinbd et en 755
chown -R quentinbd:quentinbd /home/quentinbd/mff-creative/
chmod -R 755 /home/quentinbd/mff-creative/
echo ''
echo -e "\e[2mRé-attribution des droits à quentinbd:quentinbd.\e[22m"
#false || fatal 'Ceci est un échec cuisant totalement fictif, pour montrer les couleurs'
