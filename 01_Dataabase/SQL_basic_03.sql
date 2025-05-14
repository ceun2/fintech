USE korea_stock_info;
SHOW tables;
SELECT * FROM stock_company_info;

# 7, 8, 9월로 나눠져 있는 데이터를 1개의 테이블로 모으기 위해서는
# JOIN을 쓸 수 없으므로 UNION을 사용
CREATE TABLE stock_2024_all AS 
SELECT * FROM 2024_07_stock_price_info
UNION ALL
SELECT * FROM 2024_08_stock_price_info
UNION ALL
SELECT * FROM 2024_09_stock_price_info;
SHOW tables;
SELECT * FROM stock_2024_all;

USE korea_exchange_rate;
SHOW tables;
SELECT * FROM exchange_rate;
SELECT 통화, MIN(현찰_살때_환율) 최저가, MAX(현찰_살때_환율) 최고가, ROUND(AVG(현찰_살때_환율),2) 평균가
FROM exchange_rate 
WHERE date BETWEEN "2020-01-01" AND "2020-12-31"
GROUP BY 통화;

# SQL 함수
# SELECT 함수(값) MIN(), MAX()

# 절댓값 ABS()
SELECT ABS(-34);

# 문자열의 길이 측정 LENGTH(문자열)
SELECT LENGTH("mysql");

# 반올림 함수 round()
SELECT ROUND(3.14567, 2);
SELECT ROUND(3.14467, 2);

# 올림 ceil, 내림 floor
SELECT CEIL(4.1);
SELECT FLOOR(4.9);

# truncate(값, 자릿수) 버림
SELECT ROUND(2.2345, 3), TRUNCATE(2.2345, 3);
SELECT ROUND(1153.2345, -2), TRUNCATE(1153.2345, -2);

# 문자열 함수
# 문자의 길이를 알아보는 함수
SELECT CHAR_LENGTH("my sql"), LENGTH("my sql");
SELECT CHAR_LENGTH("홍 길동"), LENGTH("홍 길동");

# 문자를 연결하는 함수 concat(), concat_ws()
SELECT CONCAT("this ", "is ", "mysql") AS concat1;
SELECT CONCAT_WS(" ", "this", "is", "mysql") AS concat2;

# 대문자를 소문자로 lower(), 소문자를 대문자로 upper()
SELECT LOWER("ABcd");
SELECT UPPER("ABcd");

# 문자열의 자릿수를 일정하게 하고 빈 공간을 지정한 문자로 채우는 함수
# lpad(값, 자릿수, 채울문자), rpad(값, 자릿수, 채울문자)
SELECT LPAD("SQL", 7, "#");
SELECT RPAD("SQL", 7, "#");

# 공백을 없애는 함수 LTRIM(문자열), RTRIM(문자열)
SELECT LTRIM("    SQL    ");
SELECT RTRIM("    SQL    ");

# 문자열의 공백을 앞뒤로 삭제하는 TRIM()
# 문자열들 사이에 있는 공백은 삭제되지 않음
SELECT TRIM("    SQL    ");
SELECT TRIM("    MY SQL    ");

# 문자열을 잘라내는 함수 LEFT(문자열, 길이), RIGHT(문자열, 길이)
SELECT LEFT("this is my sql", 4);
SELECT RIGHT("this is my sql", 4);

# 문자열을 중간에서 잘라내는 함수 SUBSTR(문자열, 시작위치, 길이)
SELECT SUBSTR("this is my sql", 6, 5);
SELECT SUBSTR("this is my sql", 6);

# 문자열의 공백을 앞뒤로 삭제하고 문자열 앞뒤에 포함된 특정 문자도 삭제하는 함수
# TRIM (LEADING "삭제할 문자" FROM "전체 문자열");
SELECT TRIM(LEADING "*" FROM "****my sql****"); # 앞
SELECT TRIM(TRAILING "*" FROM "****my sql****"); # 뒤
SELECT TRIM(BOTH "*" FROM "****my sql****"); # 앞뒤

# 날짜형 함수
SELECT CURDATE();
SELECT CURTIME(); # 현재 시간
SELECT NOW(); # 현재 년월일 + 현재 시간
SELECT current_timestamp(); # 현재 년월일 + 현재 시간

# 요일 표시 함수 DAYNAME(날짜)
SELECT DAYNAME(NOW());
SELECT DAYNAME("2025-12-25");

# 요일을 번호로 표시 
# DAYOFWEEK(날짜), 일(1), 월(2), 화(3), 수(4), 목(5), 금(6), 토(7)
SELECT DAYOFWEEK(NOW());
SELECT DAYOFWEEK("2025-12-25");

# 1년 중 오늘이 며칠째인지 DAYOFYEAR(날짜)
SELECT DAYOFYEAR(NOW());
SELECT DAYOFYEAR("2025-05-08");

# 날짜를 세분화해서 보는 함수들
# 현재 달의 마지막 날이 며칠까지 있는지 출력
SELECT LAST_DAY(NOW());
SELECT LAST_DAY("2025-10-01");

# 입력한 날짜에서 연도만 출력
SELECT YEAR(NOW());
SELECT YEAR("2025-10-01");

# 입력한 날짜에서 월만 출력
SELECT MONTH(NOW());
SELECT MONTH("2025-10-01");

# 입력한 날짜에서 월만 영문으로 출력
SELECT MONTHNAME(NOW());
SELECT MONTHNAME("2025-10-01");

# 몇 주차인지
SELECT WEEKOFYEAR(NOW());
SELECT WEEKOFYEAR("2025-12-25");

# 날짜와 시간이 같이 있는 데이터에서 날짜와 시간을 구분해주는 함수
SELECT NOW();
SELECT DATE(NOW());
SELECT TIME(NOW());

# 날짜를 지정한 날 수만큼 더하는 함수
# DATE_ADD(날짜, interval 더할 날 수 day);
SELECT DATE_ADD(NOW(), INTERVAL 5 DAY);
SELECT ADDDATE(NOW(), 5);

# 날짜를 지정한 날 수만큼 빼는 함수
# SUBDATE(날짜, INTERVAL 뺄 날 수 DAY);
SELECT SUBDATE(NOW(), INTERVAL 5 DAY);
SELECT SUBDATE(NOW(), 5);

# 날짜와 시간을 년월, 날 시간, 분초 단위로 추출하는 함수
# EXTRACT(옵션, FROM 날짜시간)
SELECT EXTRACT(YEAR_MONTH FROM NOW());
SELECT EXTRACT(DAY_HOUR FROM NOW()); # NOW()와 같이 쓰면 오류가 남
SELECT EXTRACT(MINUTE_SECOND FROM NOW());

# 날짜 1에서 날짜 2를 뺀 일 수 계산
# DATEDIFF(날짜 1, 날짜 2)
SELECT DATEDIFF(NOW(), "2024-12-25");

# 날짜 포맷 함수 - 지정한 형식에 맞춰서 출력해주는 함수
# %Y 4자리 연도, %y 2자리 연도
# %M 월의 영문표기, %m 2자리 월 표시, %b 월의 축약 영문표기 Jan, Feb
# %d 2자리 일 표기, %e 1자리 일 표기
SELECT DATE_FORMAT(NOW(), "%d-%b-%Y");
SELECT DATE_FORMAT(NOW(), "%d-%M-%Y");
SELECT DATE_FORMAT(NOW(), "%e-%M-%Y");

# 시간 표기
# %H 24시간, %h 12시간, %p AM/PM 표시
# %i 2자리 분
# %S 2자리 초
# %T 24시간 표기법 시:분:초
# %r 12시간 표기법 시:분:초 AM/PM
# %W 요일의 영문표기, %w 숫자로 요일 표시
SELECT DATE_FORMAT(NOW(), "%H:%i:%S");
SELECT DATE_FORMAT(NOW(), "%p %h:%i:%S");


