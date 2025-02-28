USE college;
SHOW tables;

# 테스트 데이터 생성
# 학과
INSERT INTO department VALUES (1, "수학");
INSERT INTO department VALUES (2, "국문학");
INSERT INTO department VALUES (3, "정보통신공학");
INSERT INTO department VALUES (4, "모바일공학");
SELECT * FROM department;

# 학생
INSERT INTO student VALUES (1, "가길동", 177, 1);
INSERT INTO student VALUES (2, "나길동", 178, 1);
INSERT INTO student VALUES (3, "다길동", 179, 1);
INSERT INTO student VALUES (4, "라길동", 180, 2);
INSERT INTO student VALUES (5, "마길동", 170, 2);
INSERT INTO student VALUES (6, "바길동", 172, 3);
INSERT INTO student VALUES (7, "사길동", 166, 4);
INSERT INTO student VALUES (8, "아길동", 192, 4);
SELECT * FROM student;

# 교수
INSERT INTO professor VALUES (1, "가교수", 1);
INSERT INTO professor VALUES (2, "나교수", 2);
INSERT INTO professor VALUES (3, "다교수", 3);
INSERT INTO professor VALUES (4, "빌게이츠", 4);
INSERT INTO professor VALUES (5, "스티브잡스", 3);
SELECT * FROM professor;

# 개설과목
INSERT INTO course VALUES (1, "교양영어", 1, "2016/09/02","2016/11/30");
INSERT INTO course VALUES (2, "데이터베이스 입문", 3, "2016/08/20","2016/10/30");
INSERT INTO course VALUES (3, "회로이론", 2, "2016/10/20","2016/12/30");
INSERT INTO course VALUES (4, "공업수학", 4, "2016/11/02","2017/01/28");
INSERT INTO course VALUES (5, "객체지향프로그래밍", 3, "2016/11/01","2017/01/30");
SELECT * FROM course;

# 수강
INSERT INTO student_course VALUES (1,1);
INSERT INTO student_course VALUES (2,1);
INSERT INTO student_course VALUES (3,2);
INSERT INTO student_course VALUES (4,3);
INSERT INTO student_course VALUES (5,4);
INSERT INTO student_course VALUES (6,5);
INSERT INTO student_course VALUES (7,5);
SELECT * FROM student_course;

# 문제 1
# 학생번호, 학생명, 키높이, 학과번호, 학과명 정보를 출력
DESC department;
SELECT 
	s.student_id,
    s.student_name,
    s.height,
    s.department_id,
    d.department_name
FROM student s
JOIN department d
ON s.department_id = d.department_id;

# 문제 2
# '가교수' 교수의 교수아이디를 출력
DESC professor;
SELECT professor_id FROM professor WHERE professor_name="가교수";

# 문제 3
# 학과이름별 교수의 수를 출력
SELECT d.department_name, COUNT(d.department_name)
FROM professor p
JOIN department d
ON p.department_id = d.department_id
GROUP BY d.department_name;

# 문제 4
# '정보통신공학'과의 학생정보를 출력
SELECT 
	s.student_id,
    s.student_name,
    s.height,
    s.department_id,
    d.department_name
FROM student s
JOIN department d
ON s.department_id = d.department_id
WHERE d.department_name = "정보통신공학";

# 문제 5
# '정보통신공학'과의 교수명을 출력
SELECT 
	p.professor_id,
    p.professor_name,
    p.department_id,
    d.department_name
FROM professor p
JOIN department d
ON p.department_id = d.department_id
WHERE d.department_name = "정보통신공학";

# 문제 6
# 학생 중 성이 '아'인 학생이 속한 학과명과 학생명을 출력
SELECT 
	s.student_name,
    d.department_name
FROM student s
JOIN department d
ON s.department_id = d.department_id
WHERE s.student_name LIKE "%아%";

# 문제 7
# 키가 180~190 사이에 속하는 학생 수 출력
SELECT COUNT(student_id)
FROM student 
WHERE height BETWEEN 180 AND 190;

# 문제 8
# 학과이름별 키의 최고값, 평균값을 출력
SELECT 
	d.department_name,
    MAX(height),
    ROUND(AVG(height),0)
FROM student s 
JOIN department d 
ON s.department_id = d.department_id
GROUP BY d.department_name;

# 문제 9
# '다길동' 학생과 같은 학과에 속한 학생의 이름을 출력
SELECT s.student_name
FROM student s
JOIN department d
ON s.department_id = d.department_id
WHERE d.department_id IN
	(SELECT department_id FROM student WHERE student_name = "다길동");

# 문제 10 
# 2016년 11월 시작하는 과목을 수강하는 학생의 이름과 수강과목을 출력
SELECT 
	s.student_name,
    c.course_name
FROM student_course sc
JOIN student s
ON sc.student_id = s.student_id
JOIN course c
ON sc.course_id = c.course_id
WHERE MONTH(c.start_date) = 11;

# 문제 11
# '데이터베이스 입문' 과목을 수강신청한 학생의 이름은?
SELECT s.student_name
FROM student_course sc
JOIN student s
ON sc.student_id = s.student_id
JOIN course c
ON sc.course_id = c.course_id
WHERE c.course_name = "데이터베이스 입문";

# 문제 12
# '빌게이츠' 교수의 과목을 수강신청한 학생수는?
SELECT COUNT(sc.student_id) 
FROM student_course sc
JOIN course c
ON sc.course_id = c.course_id
JOIN professor p
ON c.professor_id = p.professor_id
GROUP BY p.professor_name
HAVING p.professor_name = "빌게이츠";

SELECT COUNT(*)
FROM student s 
LEFT JOIN student_course sc
ON s.student_id = sc.student_id
WHERE sc.course_id =
	(SELECT course_id FROM professor p LEFT JOIN course c
	ON p.professor_id = c.professor_id
    WHERE p.professor_name = "빌게이츠");
    
