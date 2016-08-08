#!/bin/bash
# Script pour vider la memoire en cache du serveur (sans choix)
# Utile car fausse le Grafana/htop

clean_pagecache_dentries_inodes(){
    echo 3 > /proc/sys/vm/drop_caches
    sleep 2
    echo 0 > /proc/sys/vm/drop_caches
    sleep 0.5
    echo ''
    echo -e '\e[46m                         \e[49m'
    echo -e "\e[36mRAM Successfully cleaned!\e[39m"
    echo -e '\e[46m                         \e[49m'
}

clean_pagecache_dentries_inodes
