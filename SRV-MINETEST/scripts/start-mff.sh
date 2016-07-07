#!/bin/sh

#DEBUG='/home/quentinbd/scripts/debug-mff.txt'
MOREDEBUG='/home/quentinbd/scripts/moredebug-mff.txt'

cd /home/quentinbd/mff || exit "Le répertoire du serveur n'existe pas !"

while true
	do

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "'date' >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff/bin/minetestserver \
		--world /home/quentinbd/mff/worlds/minetestforfun/ \
		--config /home/quentinbd/mff/minetest.conf \
		--gameid minetestforfun_game \
		--port 30001 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
