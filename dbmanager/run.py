#!/usr/bin/env python

import MySQLdb
import yaml
import os
import subprocess
import time

def is_there_dbmanager(con):
    query = "SELECT count(*) FROM information_schema.tables WHERE TABLE_SCHEMA = 'dbmanager' AND TABLE_NAME = 'versions'"
    c = con.cursor()
    c.execute(query)
    cnt = c.fetchone()[0]
    if cnt > 0:
        return True
    return False

def get_installed_versions(con):
    query = "SELECT id from dbmanager.versions"
    c = con.cursor()
    c.execute(query)
    results = c.fetchall()
    ids = set(map(lambda row: row[0], results))
    return ids

def get_available_versions():
    files = os.listdir("/opt/dbmanager/versions")
    return set(map(int, files))

cfg = None
with open("/opt/dbmanager/config.yaml") as conf_file:
    cfg = yaml.load(conf_file)

conn = None
while conn is None:
    try:
        db = MySQLdb.connect(passwd=cfg['mysql']['password'], user=cfg['mysql']['user'], host=cfg['mysql']['host'], port=cfg['mysql']['port'])
        conn = db
    except:
        time.sleep(5)

install_list = []
if is_there_dbmanager(conn):
    installed = get_installed_versions(conn)
    print installed
    available = get_available_versions()
    install_list = sorted(available - installed)
else:
    available = get_available_versions()
    install_list = sorted(available)

print install_list
for version in install_list:
    subprocess.call(["/opt/dbmanager/versions/%s" % version, cfg['mysql']['host'], cfg['mysql']['password']])
