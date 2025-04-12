CREATE DATABASE World; 

USE World;

CREATE TABLE exchange_rate (
	code2 VARCHAR(20) PRIMARY KEY NOT NULL UNIQUE,
    country_name VARCHAR(20),
    Currency_Name VARCHAR(20),
    Exchange_Rate DOUBLE,
    Cash_Buying DOUBLE,
    Cash_Selling DOUBLE,
    Remit_Sending DOUBLE,
    Remit_Receiving DOUBLE,
    USD_Conv_Rate DOUBLE,
    date DATE NOT NULL
);
# DATETIME 데이터타입은 시간까지 나오는데 제시되어 있는 데이터를 보니 DATE 데이터타입이라 이 부분 수정했습니다

# DESCRIBE exchange_Rate;


INSERT INTO exchange_rate
VALUES ('USA', '미국', 'USD', 1377.00, 1401.09, 1352.91, 1390.40, 1363.60, 1, '2024-07-13');
INSERT INTO exchange_rate
VALUES ('EU', '유럽연합', 'EUR', 1501.55, 1531.43, 1471.67, 1516.56, 1486.54, 1.091, '2024-07-13');
INSERT INTO exchange_rate
VALUES ('JPN', '일본', 'JPY (100엔)', 872.07, 887.33, 856.81, 880.61, 863.53, 0.633, '2024-07-13');
INSERT INTO exchange_rate
VALUES ('CHN', '중국', 'CNY', 189.37, 198.83, 179.91, 191.26, 187.48, 0.138, '2024-07-13');
INSERT INTO exchange_rate
VALUES ('GBR', '영국', 'GBP', 1788.10, 1823.32, 1752.88, 1805.98, 1770.22, 1.299, '2024-07-13');
