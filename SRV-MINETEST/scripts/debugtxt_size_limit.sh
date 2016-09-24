#!/bin/sh

# PATH des serveurs
PATH_MFF_CL=$HOME/mff/
PATH_MFF_CR=$HOME/mff-creative/
PATH_MFF_HG=$HOME/mff-hg/
PATH_MFF_SB=$HOME/mff-skyblock/

# tail -c option, donc 'K' 'M' 'G' possible
KEEP_DATA=200M

### MFF-CLASSIC ###
tail -c $KEEP_DATA $PATH_MFF_CL/debug.txt > $PATH_MFF_CL/debug-temp.txt     # Prend les derniers data et mettre en fichier temp
cat $PATH_MFF_CL/debug-temp.txt > $PATH_MFF_CL/debug.txt                    # Fichier temp vers vrai debug.txt
rm $PATH_MFF_CL/debug-temp.txt                                              # Supprime le fichier temp

### MFF-CREATIVE ###
tail -c $KEEP_DATA $PATH_MFF_CR/debug.txt > $PATH_MFF_CR/debug-temp.txt     # Prend les derniers data et mettre en fichier temp
cat $PATH_MFF_CR/debug-temp.txt > $PATH_MFF_CR/debug.txt                    # Fichier temp vers vrai debug.txt
rm $PATH_MFF_CR/debug-temp.txt                                              # Supprime le fichier temp

### MFF-HUNGERGAMES ###
tail -c $KEEP_DATA $PATH_MFF_HG/debug.txt > $PATH_MFF_HG/debug-temp.txt     # Prend les derniers data et mettre en fichier temp
cat $PATH_MFF_HG/debug-temp.txt > $PATH_MFF_HG/debug.txt                    # Fichier temp vers vrai debug.txt
rm $PATH_MFF_HG/debug-temp.txt                                              # Supprime le fichier temp

### MFF-SKYBLOCK ###
tail -c $KEEP_DATA $PATH_MFF_SB/debug.txt > $PATH_MFF_SB/debug-temp.txt     # Prend les derniers data et mettre en fichier temp
cat $PATH_MFF_SB/debug-temp.txt > $PATH_MFF_SB/debug.txt                    # Fichier temp vers vrai debug.txt
rm $PATH_MFF_SB/debug-temp.txt                                              # Supprime le fichier temp

##################################################################################################

# Trouver tous les debug.txt
#find $HOME -mindepth 1 -maxdepth 2 -type f -name "debug.txt"

# Trouver tous les debug.txt + afiche leurs tailes
#find $HOME -mindepth 1 -maxdepth 2 -type f -name "debug.txt" | sed 's/^/ls -lh /'| sh

# A faire plus tard, enlever le hard link des serveurs et faire un truc propre
#find $HOME -mindepth 1 -maxdepth 2 -type f -name "debug.txt" | sed 's/^/tail -c 500M /' | sed 's/$/ > /'
