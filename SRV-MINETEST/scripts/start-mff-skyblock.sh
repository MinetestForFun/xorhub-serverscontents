#!/bin/bash

#DEBUG='/home/quentinbd/scripts/debug-mff-skyblock.txt'
MOREDEBUG='/home/quentinbd/scripts/moredebug-mff-skyblock.txt'

cd /home/quentinbd/mff-skyblock || exit "Le répertoire du serveur n'existe pas !"

while true
	do

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at "'date' >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-skyblock/bin/minetestserver \
		--world /home/quentinbd/mff-skyblock/worlds/minetestforfun-skyblock/ \
		--config /home/quentinbd/mff-skyblock/minetest.conf \
		--gameid minetestforfun_skyblock \
		--port 30054 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
