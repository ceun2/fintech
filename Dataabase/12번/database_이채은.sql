CREATE DATABASE World; 

USE World;

CREATE TABLE country (
	Code VARCHAR(20) PRIMARY KEY NOT NULL UNIQUE,
    Code2 VARCHAR(20) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Continent VARCHAR(20) NOT NULL,
    SurfaceArea INT,
    Population INT,
    LifeExpectancy DOUBLE,
    GNP INT
);

INSERT INTO country
VALUES ('CHN', 'CHN', '중국', 'Asia', 9572900, 1277558000, 71.4, 982268);
INSERT INTO country
VALUES ('DEU', 'EU', '독일', 'Europe', 357022, 82164700, 77.4, 2133367);
INSERT INTO country
VALUES ('GBR', 'GBR', '영국', 'Europe', 242900, 59623400, 77.7, 1378330);
INSERT INTO country
VALUES ('JPN', 'JPN', '일본', 'Asia', 377829, 126714000, 80.7, 3787042);
INSERT INTO country
VALUES ('USA', 'USA', '미국', 'North America', 9363520, 278357000, 77.1, 8510700);
