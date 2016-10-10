#!/bin/sh

# Servers PATH
PATH_MFF_CL=$HOME/mff/
PATH_MFF_CR=$HOME/mff-creative/
PATH_MFF_HG=$HOME/mff-hg/
PATH_MFF_SB=$HOME/mff-skyblock/

# 'tail -c' option, so can be 'K' 'M' 'G'
KEEP_DATA=500M

# Scripts PATH
PATH_SCRIPTS=$HOME/scripts/

#################
### debug.txt ###
#################
### MFF-CLASSIC ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_MFF_CL/debug.txt > $PATH_MFF_CL/debug-temp.txt
# Temp file to debug.txt
mv $PATH_MFF_CL/debug-temp.txt $PATH_MFF_CL/debug.txt

### MFF-CREATIVE ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_MFF_CR/debug.txt > $PATH_MFF_CR/debug-temp.txt
# Temp file to debug.txt
mv $PATH_MFF_CR/debug-temp.txt $PATH_MFF_CR/debug.txt

### MFF-HUNGERGAMES ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_MFF_HG/debug.txt > $PATH_MFF_HG/debug-temp.txt
# Temp file to debug.txt
mv $PATH_MFF_HG/debug-temp.txt $PATH_MFF_HG/debug.txt

### MFF-SKYBLOCK ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_MFF_SB/debug.txt > $PATH_MFF_SB/debug-temp.txt
# Temp file to debug.txt
mv $PATH_MFF_SB/debug-temp.txt $PATH_MFF_SB/debug.txt

##########################
### moredebug-mff*.txt ###
##########################
### MFF-CLASSIC ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_SCRIPTS/moredebug-mff.txt > $PATH_SCRIPTS/moredebug-mff-temp.txt
# Temp file to debug.txt
mv $PATH_SCRIPTS/moredebug-mff-temp.txt $PATH_SCRIPTS/moredebug-mff.txt

### MFF-CREATIVE ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_SCRIPTS/moredebug-mff-creative.txt > $PATH_SCRIPTS/moredebug-mff-creative-temp.txt
# Temp file to debug.txt
mv $PATH_SCRIPTS/moredebug-mff-creative-temp.txt $PATH_SCRIPTS/moredebug-mff-creative.txt

### MFF-HUNGERGAMES ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_SCRIPTS/moredebug-mff-hg.txt > $PATH_SCRIPTS/moredebug-mff-hg-temp.txt
# Temp file to debug.txt
mv $PATH_SCRIPTS/moredebug-mff-hg-temp.txt $PATH_SCRIPTS/moredebug-mff-hg.txt

### MFF-SKYBLOCK ###
# Take lastest datas and put it in a temp file
tail -c $KEEP_DATA $PATH_SCRIPTS/moredebug-mff-skyblock.txt > $PATH_SCRIPTS/moredebug-mff-skyblock-temp.txt
# Temp file to debug.txt
mv $PATH_SCRIPTS/moredebug-mff-skyblock-temp.txt $PATH_SCRIPTS/moredebug-mff-skyblock.txt

##################################################################################################

# Find all debug.txt files
#find $HOME -mindepth 1 -maxdepth 2 -type f -name "debug.txt"

# Find all debug.txt files and display their size
#find $HOME -mindepth 1 -maxdepth 2 -type f -name "debug.txt" | sed 's/^/ls -lh /'| sh

# A faire plus tard, enlever le hard link des serveurs et faire un truc propre
#find $HOME -mindepth 1 -maxdepth 2 -type f -name "debug.txt" | sed 's/^/tail -c 500M /' | sed 's/$/ > /'
