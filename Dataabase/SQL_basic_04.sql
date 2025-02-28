# View 뷰
# SELECT로 조회한 내용을 테이블을 만드는 것처럼 저장하는 것.
# 읽기 전용
# CREATE VIEW 뷰이름 AS SELECT문
# DROP VIEW 뷰이름

USE korea_exchange_rate;
SELECT * FROM exchange_rate;

# 1997년 1월 1일부터 2001년 12월 31일까지 환율병동
SELECT * 
FROM exchange_rate 
WHERE date BETWEEN "1997-01-01" AND "2001-12-31";

# 통화별로 현찰_살때_환율, 현찰_팔때_환율의
# MIN() 살때_최저환율, MAX() 살때_최고환율, AVG() 살때_평균환율
# MAX() - MIN() 살때환율변동량
# MIN() 팔때_최저환율, MAX() 팔때_최고환율, AVG() 팔때_평균환율
# MAX() - MIN() 팔때환율변동량

CREATE VIEW exchange_rate_1997_2001 AS
SELECT 
	통화, 
    MIN(현찰_살때_환율) 살때_최저환율, 
    MAX(현찰_살때_환율) 살때_최고환율, 
    ROUND(AVG(현찰_살때_환율),2) 살때_평균환율,
    ROUND(MAX(현찰_살때_환율) - MIN(현찰_살때_환율),2) 살때환율변동량,
    MIN(현찰_팔때_환율) 팔때_최저환율, 
    MAX(현찰_팔때_환율) 팔때_최고환율, 
    ROUND(AVG(현찰_팔때_환율),2) 팔때_평균환율,
    ROUND(MAX(현찰_팔때_환율) - MIN(현찰_팔때_환율),2) 팔때환율변동량
FROM exchange_rate 
WHERE date BETWEEN "1997-01-01" AND "2001-12-31"
GROUP BY 통화;

# 뷰 조회는 테이블과 똑같음
# 읽기 전용이기 때문에 업데이트는 불가
# 뷰는 원래 참고했던 테이블의 변화가 반영되는가? → 그러하다
SELECT * FROM exchange_rate_1997_2001 WHERE 통화="미국 USD";
