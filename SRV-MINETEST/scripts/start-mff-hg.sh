#!/bin/bash

#DEBUG='/home/quentinbd/scripts/debug-mff-hg.txt'
MOREDEBUG='/home/quentinbd/scripts/moredebug-mff-hg.txt'

cd /home/quentinbd/mff-hg || exit "Le répertoire du serveur n'existe pas !"

while true
	do

	echo "----------------------" >>$MOREDEBUG
	echo "Server restarted at `date`" >>$MOREDEBUG
	echo "----------------------" >>$MOREDEBUG

	echo "0" >/tmp/players_c.txt

	/home/quentinbd/mff-hg/bin/minetestserver \
		--world /home/quentinbd/mff-hg/worlds/minetestforfun-hg/ \
		--config /home/quentinbd/mff-hg/minetest.conf \
		--gameid minetestforfun_hg \
		--port 30042 \
#		--logfile $DEBUG

	sleep 25
done &>> $MOREDEBUG
