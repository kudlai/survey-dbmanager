CREATE DATABASE IF NOT EXISTS dbmanager;

use dbmanager;

DROP TABLE IF EXISTS versions;

CREATE TABLE versions (
    id int  PRIMARY KEY );

INSERT INTO versions values ('1');


