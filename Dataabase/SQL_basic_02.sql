# 데이터베이스 만들기
CREATE SCHEMA sampleDB;
CREATE DATABASE sampleDB;
# 데이터베이스 삭제
DROP DATABASE sampleDB;
# 데이터베이스 조회
SHOW DATABASES;

# 테이블 만들기
CREATE TABLE `sampledb`.`customers1` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `sex` VARCHAR(20) NULL,
  `phone` VARCHAR(20) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE);
  
  # 테이블 삭제하기
  DROP TABLE sampledb.customers1;
  
  CREATE DATABASE market_db;
  USE market_db;
  CREATE TABLE hongong1 (
  toy_id INT,
  toy_name VARCHAR(4),
  age INT);
  
  # 생성한 테이블에 데이터 입력하기 
  # INSERT INTO 테이블명(컬럼명1, 컬럼명2..) VALUES (값1, 값2..)
  INSERT INTO hongong1(toy_id, toy_name, age) VALUES(1, '우디', 25);
  INSERT INTO hongong1(toy_id, toy_name) VALUES(2, '버즈');
  INSERT INTO hongong1 VALUES(5, '포테이토', 40);
  SELECT * FROM hongong1;
  
  CREATE TABLE hongong2 (
  toy_id INT AUTO_INCREMENT PRIMARY KEY,
  toy_name VARCHAR(4),
  age INT);
  # AUTO_INCREMENT가 지정된 테이블에 데이터 넣기
  INSERT INTO hongong2 VALUES(NULL, '보핍',25);
  INSERT INTO hongong2 VALUES(NULL, '슬링키',22);
  INSERT INTO hongong2 VALUES(NULL, '렉스',21);
SELECT * FROM hongong2;

# 테이블 수정하기 ALTER
# 컬럼 추가 ALTER TABLE 테이블명 ADD COLUMN 컬럼명 자료형 속성(NOT NULL, UNIQUE..);
ALTER TABLE hongong2 ADD COLUMN country VARCHAR(20);

# 기존 테이블에 있는 자료 UPDATE 하기 (반드시 WHERE와 함께 씀!!)
# UPDATE 테이블명 SET 컬럼명 = 업데이트할 값 WHERE 조건;
UPDATE hongong2 SET country = "미국" WHERE toy_id =1;

# 테이블의 내용은 모두 지우고 테이블의 구조는 남기고 싶을 때 TRUNCATE
TRUNCATE TABLE hongong2;

# 테이블의 데이터(행) 삭제 
# DELETE FROM 테이블명 WHERE 조건;
ALTER TABLE hongong1
MODIFY COLUMN toy_id INT NOT NULL,  -- NULL 값이 없도록 변경
ADD PRIMARY KEY (toy_id);
DESC hongong1;

DELETE FROM hongong1 WHERE toy_id = 2;
SELECT * FROM hongong1;
SELECT * FROM hongong2;

CREATE TABLE members (
id INT AUTO_INCREMENT PRIMARY KEY,
member_id VARCHAR(10),
name VARCHAR(10),
address VARCHAR(50));
DESC members;
INSERT INTO members VALUES(NULL, "tess", "나훈아", "경기 부천시 중동" );
INSERT INTO members VALUES(NULL, "hero", "임영웅", "서울 은평구 증산동" );
INSERT INTO members VALUES(NULL, "iyou", "아이유", "인천 남구 주안동" );
INSERT INTO members VALUES(NULL, "jyp", "박진영", "경기 고양시 장항동" );
SELECT * FROM members;

CREATE TABLE product (
name VARCHAR(20),
price INT,
manufacture_date DATE,
manufacture_company VARCHAR(15),
quantity INT);
DESC product;
INSERT INTO product VALUES ("바나나", 1500, "2024-07-01", "델몬트", 17);
INSERT INTO product VALUES ("카스", 2500, "2023-12-12", "OB", 3);
INSERT INTO product VALUES ("삼각김밥", 1000, "2025-02-26", "CJ", 22);
ALTER TABLE product ADD COLUMN prod_id INT AUTO_INCREMENT PRIMARY KEY;
DESC product;
SELECT * FROM product;

# Rollback 연습
CREATE DATABASE mywork;
USE mywork;
CREATE TABLE emp_test(
emp_no INT NOT NULL,
emp_name VARCHAR(30) NOT NULL,
hire_date DATE NULL,
salary INT NULL,
PRIMARY KEY(emp_no));
DESC emp_test;
INSERT INTO emp_test
(emp_no, emp_name, hire_date, salary)
VALUES
(1005, "쿼리", "2021-03-01", 4000),
(1006, "호킹", "2021-03-05", 5000),
(1007, "패러데이", "2021-04-01", 2200),
(1008, "맥스웰", "2021-04-04", 3300),
(1009, "플랑크", "2021-04-05", 4400);
SELECT * FROM emp_test;

# UPDATE 연습
UPDATE emp_test SET salary=10000 WHERE emp_no=1006;
UPDATE emp_test SET hire_date="2023-07-11" WHERE emp_no=1007;
DELETE FROM emp_test WHERE emp_no=1009;
SELECT * FROM emp_test;

# 오토커밋 옵션 활성화 확인
SELECT @@autocommit; # 결과가 1이면 오토커밋 활성화 0이면 비활성화
SET autocommit = 0; # 오토커밋 비활성화

# 테이블 복사해서 생성하기
CREATE TABLE emp_tran1 as SELECT * FROM emp_test;
DESC emp_test;
DESC emp_tran1; # primary key는 복사가 안됨
ALTER TABLE emp_tran1 ADD CONSTRAINT PRIMARY KEY(emp_no);
DELETE FROM emp_tran1 WHERE emp_no=1005;
ROLLBACK;
# 트랜잭션 내에서 INSERT, UPDATE, DELETE 작업은 ROLLBACK으로 되돌릴 수 있음
# COMMIT 이후에는 되돌릴 수 없고, DROP과 같은 구조적 작업은 ROLLBACK으로 복구할 수 없음
SELECT * FROM emp_tran1;
commit;  
  