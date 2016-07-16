#!/bin/bash

#DEBUG='/home/quentinbd/scripts/debug-mff-creative.txt'
MOREDEBUG='/home/quentinbd/scripts/moredebug-mff-creative.txt'

cd /home/quentinbd/mff-creative || exit "Le répertoire du serveur n'existe pas !"

while true
	do

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at `date`" >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-creative/bin/minetestserver \
		--world /home/quentinbd/mff-creative/worlds/minetestforfun-creative/ \
		--config /home/quentinbd/mff-creative/minetest.conf \
		--gameid minetestforfun_creative \
		--port 30088 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
