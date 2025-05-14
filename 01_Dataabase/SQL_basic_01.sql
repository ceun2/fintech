USE titanic;
SHOW tables;

SELECT * FROM t_info WHERE Pclass = 1;
SELECT * FROM t_info WHERE Pclass = 2 or Fare>50;
SELECT * FROM p_info WHERE age>=20 and age<=50 and Sex = "female";

DESC ticket;
DESC survived;
DESC passenger;

SELECT * FROM survived;
SELECT * FROM survived WHERE Survived = 1;
SELECT * FROM p_info WHERE age IS NULL;

SELECT * FROM t_info WHERE Fare BETWEEN 100 AND 1000;
SELECT * FROM t_info WHERE Ticket Like "PC%" AND Embarked IN ("C", "S");
SELECT * FROM t_info WHERE Pclass IN (1, 2);
SELECT * FROM t_info WHERE Cabin LIKE "%59%";
SELECT * FROM p_info WHERE Age IS NOT NULL AND Name LIKE "%James%" AND age >= 40 and Sex = "male";

SELECT p.Name, p.Age, p.Sex, t.Pclass, s.survived 
FROM passenger p 
INNER JOIN ticket t ON p.PassengerId = t.PassengerId 
INNER JOIN survived s ON p.PassengerId = s.PassengerId 
WHERE s.survived = 1;
