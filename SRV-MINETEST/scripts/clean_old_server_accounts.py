#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import sys, os, re
try:
    import MySQLdb
except ImportError as err:
    print err
    sys.exit(1)


## command ./script.py --sql:/path/to/sqlconf/file --world:path/to/mt/worlds
## or set variables
# mt world path
worldpath = ""
# sql config path
cfgfile = ""

if len(sys.argv) >= 2:
    for arg in sys.argv[1:]:
        if arg.startswith("--sql:") and os.path.isfile(arg.split(":", 1)[1]):
            cfgfile = arg.split(":", 1)[1]
            print "cfgfile: " + cfgfile
        elif arg.startswith("--world:") and os.path.isdir(arg.split(":", 1)[1]):
            worldpath = arg.split(":", 1)[1]
            print "worldpath: " + worldpath


class Config:
    def __init__(self):
        self.host = "localhost"
        self.user = None
        self.passwd = None
        self.db = None
        self.table = None

    def set_host(self, host):
        self.host = host
    def set_user(self, user):
        self.user = user
    def set_passwd(self, passwd):
        self.passwd = passwd
    def set_db(self, db):
        self.db = db
    def set_table(self, table):
        self.table = table

    def get_host(self):
        return self.host
    def get_user(self):
        return self.user
    def get_passwd(self):
        return self.passwd
    def get_db(self):
        return self.db
    def get_table(self):
        return self.table


def Main():
    if not os.path.isdir(worldpath):
        print "Error worldpath is not a diretory"
        sys.exit(1)
    if not os.path.isfile(cfgfile):
        print "Error sql cfgfile is not a file"
        sys.exit(1)


    Conf = Config()

    ### parse config file
    try:
        f = open(cfgfile, "r")
        data = f.read()
        f.close()
        data = data.replace("\n", "").replace(" ", "")
        user = re.findall("user=['\"](.+?)['\"],?", data)[0]
        Conf.set_user(user)

        passwd = re.findall("pass=['\"](.+?)['\"],?", data)[0]
        Conf.set_passwd(passwd)

        db = re.findall("db=['\"](.+?)['\"],?}?", data)[0]
        Conf.set_db(db)

        table = re.findall("tables={auths={name=['\"](.+?)['\"],?}?", data)[0]
        Conf.set_table(table)
    except Exception as err:
        print("Error read/parse cfgfile", err)
        sys.exit(1)


    try:
        # Open database connection
        db = MySQLdb.connect(Conf.get_host(), Conf.get_user(), Conf.get_passwd(), Conf.get_db())
    except Exception as err:
        print err
        sys.exit(1)


    # prepare a cursor object using cursor() method
    cursor = db.cursor()

    # execute SQL query using execute() method.
    cursor.execute("SELECT `username` FROM `%s` WHERE `lastlogin` < UNIX_TIMESTAMP(NOW() - interval 6 month)" % Conf.get_table())

    result = cursor.fetchall()

    deleted_players = []
    for i in result:
        name = i[0]
        deleted_players.append(name)
        for d in ("players", "feats", "ignore"):
            # players file
            if os.path.isdir(os.path.join(worldpath, d)):
                p_file = os.path.join(worldpath, d, name)
                if os.path.exists(p_file) and os.path.isfile(p_file):
                    try:
                        os.remove(p_file)
                    except Exception as err:
                        print err

    cursor.execute("DELETE FROM `%s` WHERE `lastlogin` < UNIX_TIMESTAMP(NOW() - interval 6 month)" % Conf.get_table())

    cursor.close()
    db.commit()
    # disconnect from server
    db.close()

    print "%i users deleted" % len(deleted_players)
    #MT use to delete oldusers in lua table
    with open(os.path.join(worldpath, "deletedusers.txt"), 'w') as f:
        for s in deleted_players:
            f.write(s + '\n')

if __name__ == "__main__":
    Main()
    print("finished")
