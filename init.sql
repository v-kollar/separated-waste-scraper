CREATE DATABASE mendelu;

CREATE table mendelu.waste (
    tid SMALLINT PRIMARY KEY,
    name VARCHAR(40) CHARACTER SET utf8 COLLATE utf8_czech_ci,
    public BOOLEAN
  );

CREATE USER 'alice'@'localhost' IDENTIFIED BY 'aaa';
CREATE USER 'bob'@'localhost' IDENTIFIED BY 'aaa';
CREATE USER 'xkollar3'@'localhost' IDENTIFIED BY 'aaa';

CREATE ROLE reader;
GRANT SELECT(tid, name) ON mendelu.waste TO reader;

GRANT reader TO 'alice'@'localhost';
GRANT reader TO 'bob'@'localhost';
GRANT reader TO 'xkollar3'@'localhost';

SET DEFAULT ROLE reader FOR 'alice'@'localhost';
SET DEFAULT ROLE reader FOR 'bob'@'localhost';
SET DEFAULT ROLE reader FOR 'xkollar3'@'localhost';


LOAD DATA INFILE '/mnt/mysql-data/containers-filtered.csv'
INTO TABLE mendelu.waste
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS

