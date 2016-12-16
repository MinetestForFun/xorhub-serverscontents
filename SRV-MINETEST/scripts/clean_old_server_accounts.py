#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys
import os
import re

try:
    import MySQLdb
except ImportError as err:
    print (err)
    sys.exit(1)


## command ./script.py --sql:/path/to/sqlconf/file --world:path/to/mt/worlds
## or set variables
# mt world path
WORLDPATH = ""
# sql config path
CFGFILE = ""


def main(worldpath, cfgfile):
    if worldpath == "" or not os.path.isdir(worldpath):
        print ("Error worldpath is not a diretory")
        sys.exit(1)
    if cfgfile == "" or not os.path.isfile(cfgfile):
        print ("Error sql cfgfile is not a file")
        sys.exit(1)

    ### parse config file
    try:
        configfile = open(cfgfile, "r")
        data = configfile.read()
    except IOError as err:
        print ("Error ", err)
        sys.exit(1)
    else:
        configfile.close()

    try:
        data = data.replace("\n", "").replace(" ", "")
        user = re.findall("user=['\"](.+?)['\"],?", data)[0]
        passwd = re.findall("pass=['\"](.+?)['\"],?", data)[0]
        dbname = re.findall("db=['\"](.+?)['\"],?}?", data)[0]
        table = re.findall("tables={auths={name=['\"](.+?)['\"],?}?", data)[0]
    except ValueError as err:
        print ("Error parse cfgfile", err)
        sys.exit(1)

    try:
        # Open database connection
        conn = MySQLdb.connect("localhost", user, passwd, dbname)
    except Exception as err:
        print (err)
        sys.exit(1)

    # prepare a cursor object using cursor() method
    cursor = conn.cursor()
    # execute SQL query using execute() method.
    cursor.execute("SELECT `username` FROM `%s` WHERE `lastlogin` < UNIX_TIMESTAMP(NOW() - interval 6 month)" % table)

    result = cursor.fetchall()

    deleted_players = []
    for i in result:
        name = i[0]
        deleted_players.append(name)
        for directory in ("players", "feats", "ignore"):
            # players file
            if os.path.isdir(os.path.join(worldpath, directory)):
                p_file = os.path.join(worldpath, directory, name)
                if os.path.isfile(p_file):
                    try:
                        os.remove(p_file)
                    except Exception as err:
                        print (err)

    cursor.execute("DELETE FROM `%s` WHERE lastlogin` < UNIX_TIMESTAMP(NOW() - interval 6 month)" % table)

    cursor.close()
    conn.commit()
    # disconnect from server
    conn.close()

    print ("%i users deleted" % len(deleted_players))
    #MT use to delete oldusers in lua table
    with open(os.path.join(worldpath, "deletedusers.txt"), 'w') as del_file:
        for pname in deleted_players:
            del_file.write(pname + '\n')

if __name__ == "__main__":
    if len(sys.argv) >= 2:
        for arg in sys.argv[1:]:
            if arg.startswith("--sql:") and len(arg.split(":", 1)) == 2:
                CFGFILE = arg.split(":", 1)[1]
                print ("cfgfile: " + CFGFILE)
            elif arg.startswith("--world:") and len(arg.split(":", 1)) == 2:
                WORLDPATH = arg.split(":", 1)[1]
                print ("worldpath: " + WORLDPATH)
    main(WORLDPATH, CFGFILE)
    print ("finished")

