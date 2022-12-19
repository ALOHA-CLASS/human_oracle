-- 1.
conn system/123456

-- 2.
-- ALL_USERS 테이블에서 USERNAME 컬럼이 ‘HR’인,
-- USER_ID와 USERNAME 을 조회하시오.
-- ctrl + enter : 코드 부분 실행
SELECT user_id, username
FROM all_users
WHERE username = 'HR';


-- HR 계정생성
-- C## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- CREATE USER [계정명] IDENTIFIED BY [비밀번호];
CREATE USER HR IDENTIFIED BY 123456;

-- 계정에 테이블 스페이스를 사용할 수 있는 권한 부여
-- HR 계정에 대하여 무제한으로 users 테이블스페이스에 접근 허용
ALTER USER HR QUOTA UNLIMITED ON users;

-- 계정 접근 권한 부여
-- HR 계정에 대하여 접속 및 자원사용에 대한 권한 부여
GRANT connect, resource TO HR;

-- HR 샘플데이터 생성
@?/demo/schema/human_resources/hr_main.sql



-- 3. 테이블 구조 조회
DESC employees;

--
SELECT employee_id, first_name
FROM employees;

-- 4.
SELECT employee_id  AS 사원번호
      ,first_name   AS 이름
      ,last_name    AS 성
      ,email        AS 이메일
      ,phone_number AS 전화번호
      ,hire_date    AS 입사일자
      ,salary       AS 급여
FROM employees;

--5. 
SELECT DISTINCT job_id
FROM employees;

-- 6.
SELECT *
FROM employees
WHERE salary > 6000;

-- 7.
SELECT *
FROM employees
WHERE salary = 10000;

-- 한줄 복사
-- ctrl + shift + D
-- ctrl + shift + ↓

-- 8.
-- 데이터 정렬 : ORDER BY [컬럼명] [ASC/DESC]
-- ASC  : 오름차순
-- DESC : 내림차순
SELECT *
FROM employees
ORDER BY salary DESC, first_name ASC;


-- 9.
SELECT *
FROM employees
WHERE job_id = 'FI_ACCOUNT' 
   OR job_id = 'IT_PROG';
   
-- 10.
SELECT *
FROM employees
WHERE job_id IN ('FI_ACCOUNT', 'IT_PROG');


-- 11.
SELECT *
FROM employees
WHERE job_id NOT IN ('FI_ACCOUNT', 'IT_PROG');


-- 12.
SELECT *
FROM employees
WHERE job_id = 'IT_PROG'
  AND salary >= 6000;
  
-- 13. FIRST_NAME 이 'S' 로 시작하는 사원
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- '_' : 한 글자 대체 기호
-- '%' : 공백 포함 여러 글자를 대체하는 기호

-- 14. FIRST_NAME 이 's' 로 끝나는 사원
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15. FIRST_NAME 에 's' 가 포함되는 사원
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16. FIRST_NAME 이 5글자인 사원
SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- LENGTH(컬럼)  : 컬럼의 글자 수를 반환하는 함수  
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;

--17. COMMISSION_PCT 가 NULL 인 사원
SELECT *
FROM employees
WHERE commission_pct IS NULL;

--18. COMMISSION_PCT 가 NULL 이 아닌 사원
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;


-- 19.HIRE_DATE가 04년 이상인 사원
SELECT *
FROM employees 
WHERE hire_date >= '04/01/01';


-- 20. HIRE_DATE가 04년 부터 05년도 인 사원
SELECT *
FROM employees 
WHERE hire_date >= '04/01/01'
  AND hire_date <= '05/12/31';
  
SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';
 
-- 현재 날짜/시간 조회
-- dual : 임시테이블 (연산 또는 임시조회를 위해 사용)
SELECT sysdate FROM dual;
SELECT TO_NUMBER( TO_CHAR(sysdate, 'j') ) FROM dual;


-- sysdate 
-- 1970년 1월 1일 ms 단위로 현재 일시까지 시간을 누적한 값을 (/일)단위 환산한 값

-- 질문 : 근속일수
SELECT first_name AS 이름
      ,hire_date AS 입사일자
      -- 2022/01/01  ~ 2022/12/16
      -- ,sysdate - hire_date
      ,trunc(sysdate - hire_date)+1 AS 근속일수        -- (현재날짜 - 입사일자)
FROM employees;

-- 근속월수
SELECT first_name AS 이름
      ,hire_date AS 입사일자
      -- 2022/01/01  ~ 2022/12/16
      ,trunc( months_between(sysdate, hire_date) ) AS 근속월수    
      -- months_between() : 두 날짜 간의 개월 수를 반환
FROM employees;

-- 근속연수
SELECT first_name AS 이름
      ,hire_date AS 입사일자
      -- 2022/01/01  ~ 2022/12/16
      ,trunc( (sysdate-hire_date+1) / 365 ) AS 근속연수
FROM employees 
WHERE trunc( (sysdate-hire_date+1) / 365 ) >= 15
ORDER BY 근속연수 DESC
;



-- 21. 올림(CEIL) 12.45, -12.45 보다 크거나 같은 정수 중 제일 작은 수
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;

-- 22. 내림(FLOOR) 12.55, -12.55 보다 작거나 같은 정수 중 가장 큰 수
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;

-- 23. 반올림(ROUND) (0.5 작으면 내림 / 0.5 크거나 같으면 올림)
-- 0.54 를 소수점 아래 첫째 자리에서 반올림하시오.  
SELECT ROUND(0.54,0) FROM dual;
-- 0.xxxxxxxxxx
--   0123456789

-- 0.54 를 소수점 아래 둘째 자리에서 반올림하시오.  
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 을 일의 자리에서 반올림하시오. 
SELECT ROUND(125.67, -1) FROM dual;
--    xxxxx.xxxxx
-- (-)54321.01234

-- 125.67 을 십의 자리에서 반올림하시오. 
SELECT ROUND(125.67, -2) FROM dual;



-- 24. MOD( ) : 나머지를 구하는 함수
--  10 % 2    :   MOD(10, 2)

-- 3을 8로 나눈 나머지를 구하시오. → 결과 : 3
SELECT MOD(3, 8) FROM dual;

-- 30을 4로 나눈 나머지를 구하시오. → 결과 : 2
SELECT MOD(30, 4) FROM dual;


-- 25. POWER( ) : 제곱수를 구하는 함수
--     2^4      : POWER(2, 4)

-- 2의 10제곱을 구하시오. → 결과 : 1024
SELECT POWER(2, 10) FROM dual;

-- 2의 31제곱을 구하시오. → 결과 : 2147483648
SELECT POWER(2, 31) FROM dual;

-- 25.  SQRT( ) : 제곱근을 구하는 함수
--   9의 제곱근  :  SQRT(9)
-- 2의 제곱근을 구하시오 → 1.4xxx
SELECT SQRT(2) FROM dual;

-- 100의 제곱근을 구하시오 → 10
SELECT SQRT(100) FROM dual;


-- 27. TRUNC(실수, 자리수) : 해당 수를 절삭하는 함수
--  12.34 소수점 아래 첫째 자리에서 절삭  : TRUNC(12.34, 0)

-- 527425.1234 을 소수점 아래 첫째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 을 소수점 아래 둘째 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 을 일의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 을 십의 자리에서 절삭하시오.
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28. ABS( ) : 절댓값을 구하는 함수
-- -12.34 의 절댓값    :  ABS(-12.34)

-- -20 의 절댓값을 구하시오.
SELECT ABS(-20) FROM dual;

-- -12.456 의 절댓값을 구하시오.
SELECT ABS(12.456) FROM dual;

-- 29.
-- UPPER( )     : 영문자를 대문자로 변환하는 함수
-- LOWER( )     : 영문자를 소문자로 변환하는 함수
-- INITCAP( )   : 영문자를 단어를 기준으로 첫글자만 대문자로
-- 원문 : 'AlOhA WoRlD~!'
SELECT 'AlOhA WoRlD~!' AS 원문
      ,UPPER('AlOhA WoRlD~!') AS 대문자
      ,LOWER('AlOhA WoRlD~!') AS 소문자
      ,INITCAP('AlOhA WoRlD~!') AS "첫글자만 대문자"
FROM dual;

-- 30. 글자수와 바이트 수
-- LENGTH( )  : 글자수를 출력하는 함수
-- LENGTHB( ) : 바이트수를 출력하는 함수
-- 영어/숫자/특수문자 : 1byte
-- 한글             : 3byte
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
      ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
      ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;

-- 31. 두 문자열을 연결(병합)
-- CONCAT(문자열1, 문자열2) : 두 문자열을 연결하는 함수
--  ||  : 두 개이상의 문자열을 연결하는 기호
SELECT CONCAT('ALOHA', 'WORLD') AS "함수"
      ,'ALOHA' || 'WORLD' AS "기호"
FROM dual;


-- 32. SUBSTR( ) : 문자열의 일부만 출력하는 함수
-- 문자열 : 'www.human.com'
-- SUBSTR('문자열', 시작번호, 글자수)
SELECT SUBSTR('www.human.com', 1, 3) AS "1"       -- www
      ,SUBSTR('www.human.com', 5, 5) AS "2"       -- human
      ,SUBSTR('www.human.com', 11, 3) AS "3"      -- com
FROM dual;

-- SUBSTRB('문자열', 시작바이트, 바이트수)
SELECT SUBSTRB('www.human.com', 1, 3) AS "1"       -- www
      ,SUBSTRB('www.human.com', 5, 5) AS "2"       -- human
      ,SUBSTRB('www.human.com', 11, 3) AS "3"      -- com
FROM dual;

SELECT SUBSTRB('www.휴먼.com', 1, 3) AS "1"       -- www
      ,SUBSTRB('www.휴먼.com', 5, 6) AS "2"       -- 휴먼
      ,SUBSTRB('www.휴먼.com', 12, 3) AS "3"      -- com
FROM dual;

-- 33
-- INSTR('문자열', '문자', 검색위치, 순서)
-- 'ALOHACAMPUS'
-- 세번째 글자부터 찾아서, 1번째 A의 위치를 구하시오.
SELECT INSTR('ALOHACAMPUS', 'A', 3, 1) FROM dual;

SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;

SELECT INSTRB('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTRB('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTRB('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;


-- 34.
-- LPAD('문자열', 칸의수, '채울문자') : 왼쪽 빈공간에 특정문자로 채우는 함수
-- RPAD('문자열', 칸의수, '채울문자') : 오른쪽 빈공간에 특정문자로 채우는 함수
SELECT LPAD('ALOHACAMPUS', 20, '#') AS "왼쪽"
      ,RPAD('ALOHACAMPUS', 20, '#') AS "오른쪽"
FROM dual;

-- 35.
-- TO_CHAR( )   : 날짜, 숫자 데이터를 문자열로 변환하는 함수
-- employees 의 HIRE_DATE 를 2022-12-19 (월) 12:00:00 형태로 출력하시오
-- 연 : YYYY
-- 월 : MM
-- 일 : DD
-- 요일 : dy
-- 시 : HH
-- 분 : MI
-- 초 : SS
SELECT first_name AS 이름
      ,hire_date 
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS 입사일자
FROM employees
;

-- 36.
-- employees 테이블의 salary(숫자) 컬럼을 $10,000 이와같은 형식으로 출력하시오.
-- 9 : 값이 없으면 표시하지 않음
-- 0 : 값이 없으면 "0" 처리하여 표시
SELECT first_name AS 이름
      ,salary
      ,TO_CHAR(salary, '$99,999.00') AS 급여
FROM employees;

-- 37
-- TO_DATE : 문자형의 날짜 데이터를 날짜형 데이터로 변환하는 함수
SELECT 20221219 AS 문자
      ,TO_DATE(sysdate) AS 날짜
      ,TO_DATE('2022.12.19') 날짜2
      ,TO_DATE('2022/12/19') 날짜3
      ,TO_DATE('2022-12-19') 날짜4
      ,TO_CHAR(TO_DATE('2022-12-19'), 'YYYY-MM-DD (dy) HH:MI:SS')
      
FROM dual;

-- 38
-- TO_NUMBER('문자형숫자', '포맷') 
-- '1,200,000'  --> 1200000
SELECT '1,200,000' AS 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;


-- 39
-- 어제, 오늘, 내일 날짜를 출력하시오
SELECT TO_CHAR(sysdate-1, 'YYYY.MM.DD') AS 어제
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') AS 오늘
      ,TO_CHAR(sysdate+1, 'YYYY.MM.DD') AS 내일
FROM dual;


-- 40
SELECT first_name 이름
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') 오늘
      ,TRUNC( (sysdate - hire_date)) 근무일수
      ,TRUNC( MONTHS_BETWEEN(sysdate, hire_date) ) 근무달수
      ,TRUNC( MONTHS_BETWEEN(sysdate, hire_date) / 12 ) 근속연수
FROM employees
;

-- 41
-- ADD_MONTHS(날짜, 개월수)  : 해당날짜로부터 개월 수를 더한 날짜를 반환하는 함수
SELECT sysdate 오늘
      ,ADD_MONTHS(sysdate, 6) "6개월후"
      ,ADD_MONTHS(sysdate, -6) "6개월전"
FROM dual;

--42
-- NEXT_DAY(날짜, 요일번호)  : 해당 날짜 다음에 오는 요일의 날짜를 반환하는 함수
-- 일(1)~토(7)
SELECT sysdate 오늘
      ,NEXT_DAY(sysdate, 7) "다음 토요일"
      ,NEXT_DAY('2023/01/01', 7) "2023 첫 토요일"
FROM dual;

-- 43
-- 월초, 월말 구하기
SELECT sysdate 오늘
      ,TRUNC(sysdate, 'MM') 월초
      ,LAST_DAY(sysdate) 월말
      ,TRUNC(sysdate, 'IW')주초
      ,NEXT_DAY(sysdate, 1)주말
FROM dual;
-- 월화수목금토일


-- 44.
-- NVL(값, 널일때 지정할 값)  : 해당 값이 NULL 이면 지정된 값으로 변환하는 함수
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC
;

SELECT DISTINCT NVL(commission_pct, 0) "커미션"
FROM employees
ORDER BY 커미션 DESC
;

-- 조회한 컬럼의 별칭으로 ORDER BY 절에서 사용할 수 있다.
-- 조회한 컬럼의 별칭으로 WHERE 절에는 사용할 수 없다.

-- SELECT 명령의 실행 순서
SELECT [컬럼1], [컬럼2]  ( * )
FROM [테이블]
WHERE [조건]
GROUP BY [그룹기준 컬럼] HAVING [그룹 조건]
ORDER BY [정렬기준 컬럼] [ASC/DESC]
;
-- (실행순서)
-- FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY






















































































      



















































































































