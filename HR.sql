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
      ,TO_CHAR(hire_date, 'YYYY-MM-DDD (dy) HH:MI:SS') AS 입사일자
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

SELECT first_name 이름
      ,salary 연봉
      ,salary + (salary * NVL(commission_pct, 0)) 총급여
      ,NVL2( commission_pct, 'O', 'X' ) 커미션여부
FROM employees
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

-- 45.
-- 테이블 EMPLOYEES 의 FIRST_NAME, SALARY, COMMISION_PCT 속성을 이용하여 
--  이름, 급여, 커미션, 최종급여 
--  <조건> 
--  최종급여 = 급여 + (급여*커미션)
--  최종급여를 기준으로 내림차순 정렬
SELECT FIRST_NAME 이름
      ,SALARY 급여
      ,NVL(COMMISSION_PCT,0) 커미션
      ,SALARY + (SALARY * NVL(COMMISSION_PCT,0)) 최종급여
FROM employees
ORDER BY 최종급여 DESC
;

-- COALESCE(인자1, 인자2, ...)
-- : 인자들 중 NULL 이 아닌 첫번째 값을 반환하는 함수
SELECT FIRST_NAME 이름
      ,SALARY 급여
      ,NVL(COMMISSION_PCT,0) 커미션
      ,COALESCE( SALARY + (SALARY * COMMISSION_PCT), SALARY  ) 최종급여
FROM employees
ORDER BY 최종급여 DESC
;

-- LNVNL(조건식)
-- : 조건식의 결과가 
--    TRUE                     --> FALSE
--    FALSE 또는 UNKNOWN(NULL)  --> TRUE 반환하는 함수
-- commission_pct 가 0.2 미만 그리고 NULL 인 사원까지 조회된다.
SELECT *
FROM employees
WHERE LNNVL( commission_pct >= 0.2 );

-- 아래와 같이 조건을 주면, 
-- commission_pct 가 NULL 인 사원은 포함되지 않는다.
SELECT *
FROM employees
WHERE commission_pct < 0.2 ;

-- 직무 시작일부터 종료일이 1년을 초과하지 않는 데이터를 조회하시오.
SELECT job_id
      ,NULLIF( TO_CHAR(start_date, 'YYYY'), TO_CHAR(end_date, 'YYYY') ) null_year
FROM job_history
;

-- 
SELECT first_name
      ,salary
      ,NULLIF( salary, 10000 )
FROM employees
ORDER BY salary DESC
;









-- 46.
SELECT *
FROM employees;

SELECT *
FROM departments;

-- 조인 : INNER JOIN
SELECT emp.first_name 이름
      ,dep.department_name 부서
FROM employees emp, departments dep
WHERE emp.department_id = dep.department_id;


-- DECODE( 인자, 조건1, 결과1, 조건2, 결과2, ... )
-- : 인자의 값이 조건과 일치할 때, 그 뒤의 지정한 결과를 출력하는 함수
SELECT first_name 이름
      ,DECODE(department_id, 10, 'Administration'
                           , 20, 'Marketing'
                           , 30, 'Purchasing'
                           , 40, 'Human Resources'
                           , 50, 'Shipping'
                           , 60, 'IT'
                           , 70, 'Public Relations'
                           , 80, 'Sales'
                           , 90, 'Executive'
                           , 100, 'Finance'
      ) 부서
FROM employees;

-- 47
SELECT first_name 이름
      ,CASE 
            WHEN department_id = 10 THEN 'Administration'
            WHEN department_id = 20 THEN 'Marketing'
            WHEN department_id = 30 THEN 'Puchasing'
            WHEN department_id = 40 THEN 'Human Resources'
            WHEN department_id = 50 THEN 'Shipping'
            WHEN department_id = 60 THEN 'IT'
            WHEN department_id = 70 THEN 'Public Relations'
            WHEN department_id = 80 THEN 'Sales'
            WHEN department_id = 90 THEN 'Executive'
            WHEN department_id = 100 THEN 'Finance'
       END 부서
FROM employees;
       
-- 48.
SELECT COUNT(*) 사원수
FROM employees;

-- 49.
SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM employees;

-- 50.
SELECT SUM(salary) 급여합계
      ,ROUND( AVG(salary), 2) 급여평균
FROM employees;

-- 51.
SELECT ROUND( STDDEV(salary), 2) 급여표준편자
      ,ROUND( VARIANCE(salary), 2) 급여분산
FROM employees;

--52. MS_STUDENT 테이블 생성하기

-- human 계정 생성
-- C## 없이 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
drop user "human";

-- USER SQL
CREATE USER human IDENTIFIED BY 123456
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER human QUOTA UNLIMITED ON "USERS";

-- ROLES
GRANT "CONNECT" TO human WITH ADMIN OPTION;
GRANT "RESOURCE" TO human WITH ADMIN OPTION;
ALTER USER human DEFAULT ROLE "CONNECT","RESOURCE";


CREATE TABLE 테이블명 (
    컬럼명1    타입  [NOT NULL/NULL] [제약조건],
    컬럼명2    타입  [NOT NULL/NULL] [제약조건],
    ...
);

DROP TABLE MS_STUDENT;
CREATE TABLE MS_STUDENT 
(
      ST_NO         NUMBER NOT NULL     PRIMARY KEY
    , NAME          VARCHAR2(20) NOT NULL 
    , CTZ_NO        CHAR(14) NOT NULL 
    , EMAIL         VARCHAR2(100) NOT NULL UNIQUE
    , ADDRESS       VARCHAR2(1000) 
    , DEPT_NO       NUMBER NOT NULL 
    , MJ_NO         NUMBER NOT NULL 
    , REG_DATE      DATE DEFAULT SYSDATE NOT NULL 
    , UPD_DATE      DATE DEFAULT SYSDATE NOT NULL 
    , ETC           VARCHAR2(1000) DEFAULT '없음'
);
COMMENT ON TABLE MS_STUDENT IS '학생정보';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '주민등록번호';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '학부번호';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';


-- 53. MS_STUDENT 테이블에 속성을 추가
-- 성별, 재적, 입학일자, 졸업일자 속성 추가
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';

-- 속성 제거
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;   -- 컬럼명 변경
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;               -- 데이터 타입 변경
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';        -- 설명 변경

-- 55
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;


-- 56
DROP TABLE MS_STUDENT;

-- 57
CREATE TABLE MS_STUDENT (
    ST_NO       NUMBER          NOT NULL PRIMARY KEY,
    NAME        VARCHAR2(20)    NOT NULL,
    BIRTH       DATE            NOT NULL,
    EMAIL       VARCHAR2(100)   NOT NULL    UNIQUE,
    ADDRESS     VARCHAR2(1000)  NOT NULL  ,
    MJ_NO       VARCHAR2(10)    NOT NULL  ,
    GENDER      CHAR(6)         DEFAULT '기타'    NOT NULL ,
    STATUS      VARCHAR2(10)    DEFAULT '대기'    NOT NULL ,
    ADM_DATE    DATE            NULL    ,
    GRD_DATE    DATE            NULL    ,
    REG_DATE    DATE            DEFAULT sysdate  NOT NULL    ,
    UPD_DATE    DATE            DEFAULT sysdate  NOT NULL    ,
    ETC         VARCHAR2(1000)  DEFAULT '없음'    NULL
);

COMMENT ON TABLE MS_STUDENT IS '학생';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '학생번호';
COMMENT ON COLUMN MS_STUDENT.NAME IS '이름';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '이메일';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '주소';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '전공번호';
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '수정일자';
COMMENT ON COLUMN MS_STUDENT.ETC IS '특이사항';

-- 58
-- 데이터 추가 
-- INSERT INTO [테이블명] ( 컬럼1, 컬럼2, ... )
-- VALUES ( '값1', '값2', ... );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,
                          ADM_DATE ,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', '여', 'I01', 
         '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '박서준', '020504', 'psj@univ.ac.kr', '서울', '남', 'B02', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '김아윤', '020504', 'kay@univ.ac.kr', '인천', '여', 'S01', '재학', '2021/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '정수안', '970210', 'jsa@univ.ac.kr', '경남', '여', 'J02', '재학', '2016/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '윤도현', '960311', 'ydh@univ.ac.kr', '제주', '남', 'K01', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '안아람', '941124', 'aar@univ.ac.kr', '경기', '여', 'Y01', '재학', '2013/03/01', NULL, sysdate, sysdate, '영상예술 특기자' );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '한성호', '921007', 'hsh@univ.ac.kr', '서울', '기타', 'E03', '재학', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;
         
SELECT * FROM ms_student;

--59
-- UPDATE [테이블명]
--    SET [컬럼1] = '수정값'
--       ,[컬럼2] = '수정값'
--  WHERE [컬럼] = [값];
-- 학번 : 20160001 인 학생을 주소를 '서울', 재적을 '휴학'으로 수정하시오.
UPDATE ms_student
   SET address = '서울'
      ,status = '휴학'
WHERE st_no = 20160001;

UPDATE MS_STUDENT 
    SET ADDRESS = '서울', STATUS = '졸업'
      , GRD_DATE = '2020/02/20', UPD_DATE = '2020/01/01'  
WHERE ST_NO = '20150010';

UPDATE MS_STUDENT 
   SET STATUS = '졸업', GRD_DATE = '2020/02/20', UPD_DATE ='2020/01/01' 
WHERE ST_NO = '20130007';

UPDATE MS_STUDENT 
SET STATUS = '퇴학', UPD_DATE = '2013/02/10', ETC = '자진 퇴학' 
WHERE ST_NO = '20110002';

COMMIT;

SELECT * FROM ms_student;
 
-- 60. 데이터 삭제
DELETE FROM ms_student
WHERE st_no = '20110002';

-- ROLLBACK : 변경사항을 되돌리는 명령
ROLLBACK;

-- COMMIT   : 변경사항을 적용하는 명령
COMMIT;

SELECT * FROM ms_student;

-- 61. ms_student 테이블 조회
SELECT *
FROM ms_student;

-- 62. 백업 테이블 생성
CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;

SELECT * FROM MS_STUDENT_BACK;


-- 63. 
DELETE FROM MS_STUDENT;
COMMIT;

SELECT * FROM MS_STUDENT;

-- 64.
INSERT INTO MS_STUDENT 
SELECT * FROM MS_STUDENT_BACK;
COMMIT;

SELECT * FROM MS_STUDENT;


-- 65. 제약 조건 추가
-- ALTER TABLE [테이블명] ADD CONSTRAINT [제약조건 명] CHECK [제약조건];
ALTER TABLE MS_STUDENT 
ADD CONSTRAINT MS_STD_GENDER_CHECK 
CHECK (gender IN ('여','남','기타') );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,
                          ADM_DATE ,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20221234', '김휴먼', '991005', 'khm@univ.ac.kr', '서울', '여', 'I01', 
         '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

UPDATE MS_STUDENT
   SET GENDER = '여자'
WHERE ST_NO = '20130007';

SELECT * FROM MS_STUDENT;

-- 66.
CREATE TABLE MS_USER (
    USER_NO     NUMBER          NOT NULL    PRIMARY KEY,
    USER_ID     VARCHAR2(100)   NOT NULL    UNIQUE,
    USER_PW     VARCHAR2(200)   NOT NULL,    
    USER_NAME   VARCHAR2(50)    NOT NULL,
    BIRTH       DATE            NOT NULL,
    TEL         VARCHAR2(20)    NOT NULL    UNIQUE,
    ADDRESS     VARCHAR(200)    NULL,
    REG_DATE    DATE            DEFAULT sysdate NOT NULL,
    UPD_DATE    DATE            DEFAULT sysdate NOT NULL 
);

COMMENT ON TABLE MS_USER IS '회원';
COMMENT ON COLUMN MS_USER.USER_NO IS '회원번호';
COMMENT ON COLUMN MS_USER.USER_ID IS '아이디';
COMMENT ON COLUMN MS_USER.USER_PW IS '비밀번호';
COMMENT ON COLUMN MS_USER.USER_NAME IS '이름';
COMMENT ON COLUMN MS_USER.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_USER.TEL IS '전화번호';
COMMENT ON COLUMN MS_USER.ADDRESS IS '주소';
COMMENT ON COLUMN MS_USER.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_USER.UPD_DATE IS '수정일자';

SELECT * FROM MS_USER;

-- 67
CREATE TABLE MS_BOARD (
    BOARD_NO    NUMBER          NOT NULL    PRIMARY KEY,
    TITLE       VARCHAR2(200)   NOT NULL    ,
    CONTENT     VARCHAR2(100)    NOT NULL    ,
    WRITER      VARCHAR2(100)   NOT NULL    ,
    HIT         NUMBER          NOT NULL    ,
    LIKE_CNT    NUMBER          NOT NULL    ,
    DEL_YN      CHAR(2)         NULL    ,
    DEL_DATE    DATE            NULL    ,
    REG_DATE    DATE            DEFAULT sysdate NOT NULL    ,
    UPD_DATE    DATE            DEFAULT sysdate NOT NULL    
);

COMMENT ON TABLE MS_BOARD IS '게시판';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '게시글 번호';
COMMENT ON COLUMN MS_BOARD.TITLE IS '제목';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '내용';
COMMENT ON COLUMN MS_BOARD.WRITER IS '작성자';
COMMENT ON COLUMN MS_BOARD.HIT IS '조회수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정일자';

-- 68
CREATE TABLE MS_FILE (
    FILE_NO     NUMBER NOT NULL PRIMARY KEY,
    BOARD_NO    NUMBER NOT NULL,
    FILE_NAME   VARCHAR2(2000) NOT NULL,
    FILE_DATA   BLOB NOT NULL,
    REG_DATE    DATE DEFAULT SYSDATE NOT NULL,
    UPD_DATE    DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE MS_FILE IS '첨부파일';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';


-- 69.
CREATE TABLE MS_REPLY (
    REPLY_NO    NUMBER NOT NULL PRIMARY KEY,
    BOARD_NO    NUMBER NOT NULL ,
    CONTENT     VARCHAR2(2000) NOT NULL,
    WRITER      VARCHAR2(100) NOT NULL,
    DEL_YN      CHAR(2) DEFAULT 'N' NULL,
    DEL_DATE    DATE    NULL,
    REG_DATE    DATE    DEFAULT sysdate NOT NULL,
    UPD_DATE    DATE    DEFAULT sysdate NOT NULL
);

COMMENT ON TABLE MS_REPLY IS '댓글';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '댓글번호';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '내용';
COMMENT ON COLUMN MS_REPLY.WRITER IS '작성자';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '삭제여부';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '수정일자';


-- 70
-- 덤프파일 가져오기(import)
-- import 시, 
-- dmp 파일의 생성한 계정과 다른 계정으로 가져올 때는
-- system 계정 또는 가져올 계정으로 접속하여 명령어를 실행해야한다.
imp userid=system/123456 file=C:\KHM\SQL\human\community.dmp fromuser=human touser=human2;

-- human2 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human2 IDENTIFIED BY 123456;
ALTER USER human2 DEFAULT TABLESPACE users;
ALTER USER human2 QUOTA UNLIMITED ON users;
GRANT connect, resource TO human2;

-- humna 계정에 DBA 권한 부여
GRANT dba TO human;
GRANT dba TO human2;

-- 71
-- 덤프파일 생성하기(export)
exp userid=human/123456 file=C:\KHM\SQL\human\community.dmp log=C:\KHM\SQL\human\community.log 
;
--
expdp human/123456 directory=C:\KHM\SQL\human dumpfile=community2.dmp log=community2.log version=11
;





-- 72
-- MS_BOARD 테이블의 WRITER 속성의 데이터타입을 NUMBER 로 변경
ALTER TABLE ms_board MODIFY writer NUMBER;

-- MS_BOARD 테이블의 외래키 삭제
ALTER TABLE ms_board DROP CONSTRAINT MS_BOARD_WRITER_FK;

-- MS_BOARD 테이블의 WRITER 속성을 외래키로 지정
ALTER TABLE ms_board 
ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (writer) REFERENCES ms_user(user_no);

-- MS_FILE 테이블의 외래키 삭제
ALTER TABLE ms_file DROP CONSTRAINT MS_FILE_BOARD_NO_FK;

-- MS_FILE 테이블의 BOARD_NO 속성을 외래키로 지정
ALTER TABLE ms_file
ADD CONSTRAINT MS_FILE_BOARD_NO_FK FOREIGN KEY (board_no) REFERENCES ms_board(board_no);

-- MS_REPLY 테이블의 외래캐 삭제
ALTER TABLE ms_reply DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;

-- MS_REPLY 테이블의 BOARD_NO 속성을 외래키로 지정
ALTER TABLE ms_reply 
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK FOREIGN KEY (board_no) REFERENCES ms_board(board_no);

-- 73.
-- MS_USER 테이블에 CTZ_NO, GENDER 속성을 추가
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON column MS_USER.GENDER IS '성별';

DESC MS_USER;

-- 74.
-- MS_USER 테이블의 GENDER 속성에 ('여','남','기타') 값만 갖도로 제약조건 추가
ALTER TABLE MS_USER 
ADD CONSTRAINT MS_USER_GENDER_CHECK CHECK (GENDER IN ('여','남', '기타'));

-- 75. 
-- MS_FILE 테이블에 EXT(확장자) 속성을 추가
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';


76. 
-- 강아지.jpg, 휴먼교육센터.png
MERGE INTO MS_FILE T
USING (SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F ON (T.FILE_NO = F.FILE_NO)
WHEN MATCHED THEN
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1)
    DELETE 
    WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1) 
    NOT IN ('jpeg','jpg','png','gif')
;

-- 문자열에서 확장자 추출하기
SELECT SUBSTR( '강아지.jpg', INSTR('강아지.jpg', '.', -1) + 1 ) 확장자 
      ,INSTR('강아지.jpg', '.', -1) ".위치"
FROM dual;

-- 테스트 데이터 추가
INSERT INTO MS_USER 
(user_no, user_id, user_pw, user_name, birth, 
  tel, address, reg_date, upd_date, ctz_no, gender)
VALUES (1, 'HUMAN', '123456', '김휴먼', '2002/03/23' , '010-1234-XXXX',
        '영등포', sysdate, sysdate, '020323-3xxxxxx', '기타' );

INSERT INTO MS_BOARD 
(board_no, title, content, writer, hit, like_cnt, del_yn, del_date, reg_date, upd_date)
VALUES (2, '제목', '내용', 1,1,0, 'N', sysdate, sysdate, sysdate);

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_data, reg_date, upd_date, ext )
VALUES (2, 2, '강아지.png', '123', sysdate, sysdate, 'jpg' );

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_data, reg_date, upd_date, ext )
VALUES (4, 2, '학습자료.pdf', '123', sysdate, sysdate, 'pdf' );

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_data, reg_date, upd_date, ext )
VALUES (5, 2, '학습자료2.pdf', '123', sysdate, sysdate, 'jpg' );

SELECT * FROM MS_USER;
SELECT * FROM MS_BOARD;
SELECT * FROM MS_FILE;
commit;


-- 77
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_EXT_CHECK 
CHECK (EXT IN ('jpg','jpeg','gif','png'));


-- 78.
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

-- 79.
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;

-- 80.
-- MS_BOARD 테이블에 WRITER 속성 추가
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;

-- MS_BOARD 의 WRITER 속성을 외래키로 지정
-- 참조 테이블의 데이터 삭제 시, 연쇄적으로 데이터가 삭제되도로 옵션 지정
ALTER TABLE MS_BOARD 
ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (WRITER)
REFERENCES MS_USER(USER_NO) 
ON DELETE CASCADE;

-- MS_FILE 테이블에 BOARD_NO 속성 추가
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;

-- MS_FILE 테이블의 BOARD_NO 속성을 외래키로 지정
-- 참조 테이블의 데이터 삭제 시, 연쇄적으로 데이터가 삭제되도록 옵션 지정
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) 
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;

-- MS_REPLY 테이블에 BOARD_NO 속성 추가
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;

-- MS_REPLY 테이블의 BOARD_NO 속성을 외래키로 지정
-- 참조 테이블의 데이터 삭제 시, 연쇄적으로 데이터가 삭제되도록 옵션 지정
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK
FOREIGN KEY (BOARD_NO)
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;


-- 81
DROP TABLE MS_FILE;
DROP TABLE MS_REPLY;
DROP TABLE MS_BOARD;
DROP TABLE MS_STUDENT;
DROP TABLE MS_STUDENT_BACK;
DROP TABLE MS_USER;

-- CMD
imp userid=system/123456 file=C:\KHM\SQL\human\human.dmp fromuser=human touser=human;


-- 81.
SELECT * FROM employee;
SELECT * FROM department;
SELECT * FROM job;

--
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,(SELECT DEPT_TITLE FROM DEPARTMENT D WHERE D.DEPT_ID = E.DEPT_CODE) 부서명
      ,(SELECT JOB_NAME FROM JOB J WHERE J.JOB_CODE = E.JOB_CODE) 직급명
FROM EMPLOYEE E;


-- JOIN

-- INNER JOIN
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e INNER JOIN department d ON e.dept_code = d.dept_id
;

-- EQUI JOIN
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e, department d
WHERE e.dept_code = d.dept_id
;


-- SEMI JOIN (EXISTS)
SELECT dept_id
      ,dept_title
FROM department d
WHERE EXISTS ( SELECT * FROM employee e 
               WHERE e.dept_code = d.dept_id
                 AND e.salary > 2000000
              )
;

-- SEMI JOIN (IN)
SELECT dept_id, dept_title
FROM department d
WHERE d.dept_id IN (
                        SELECT e.dept_code
                        FROM employee e
                        WHERE e.salary > 2000000
                    )
;

-- 테이블 일괄삭제
SELECT 'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;' "테이블 전체 삭제"
FROM    user_objects
WHERE   object_type = 'TABLE';


-- OUTER JOIN

-- LEFT OUTER JOIN
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e LEFT OUTER JOIN department d
                ON e.dept_code = d.dept_id
;

-- RIGTH OUTER JOIN
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e RIGHT OUTER JOIN department d
                ON e.dept_code = d.dept_id
;

-- FULL OUTER JOIN
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e FULL OUTER JOIN department d
                ON e.dept_code = d.dept_id
;

-- 82
-- 사원번호, 직원명, 부서명, 급여, 최고급여, 최저급여, 평균급여
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,e.salary 급여
      ,t.max_sal 최고급여
      ,t.min_sal 최저급여
      ,ROUND(t.avg_sal, 2) 평균급여
FROM employee e LEFT JOIN department d ON (dept_code = dept_id)
    ,( SELECT DEPT_CODE, MAX(salary) MAX_SAL, MIN(salary) MIN_SAL, AVG(salary) AVG_SAL
       FROM employee
       GROUP BY dept_code
     ) t
WHERE e.salary = t.max_sal
;

                
-- 83. 
-- 1단계
-- 직원명이 ‘이태림＇인 사원을 조회
SELECT emp_name, dept_code
FROM employee
WHERE emp_name = '이태림';

-- '이태림' 사원과 같은 부서의 직원들의 사원번호, 직원명, 이메일, 전화번호를 조회
SELECT emp_id 사원번호
      ,emp_name 직원명
      ,email 이메일
      ,phone 전화번호
FROM employee
WHERE dept_code = (
                    SELECT dept_code
                    FROM employee
                    WHERE emp_name = '이태림'
                   );

-- 84.
-- 사원이 존재하는 부서만 조회하시오.
-- 1단계 
-- 부서코드가 NULL 이 아닌 사원들의 부서코드를 중복없이 조회
SELECT DISTINCT dept_code
FROM employee
WHERE dept_code IS NOT NULL
;

-- 사원 테이블의 존재하는 부서코드만 포함하는 부서 테이블의 행을 조회
-- 84 - 1번 해결방법
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department
WHERE dept_id IN (
                    SELECT DISTINCT dept_code
                    FROM employee
                    WHERE dept_code IS NOT NULL
                 )
ORDER BY dept_id ASC
;

-- 84 - 2번 해결방법
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department d
WHERE EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY d.dept_id;

-- 85
-- 사원이 존재하지 않는 부서 테이블의 부서번호, 부서명, 지역명을 조회
-- 85 - 1번 해결방법
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department
WHERE dept_id NOT IN (
                    SELECT DISTINCT dept_code
                    FROM employee
                    WHERE dept_code IS NOT NULL
                 )
ORDER BY dept_id ASC;
-- 85 - 2번 해결방법
SELECT dept_id 부서번호
      ,dept_title 부서명
      ,location_id 지역명
FROM department d
WHERE NOT EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY d.dept_id;


-- 86.
-- 1단게
-- 사원 테이블과 부서 테이블을 조인하여 사원번호,직원명,부서번호,부서명,급여를 조회
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,e.salary 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id;
-- 부서코드 'D1' 부서의 최대 급여보다 높은 급여를 받는 사원을 조회
-- 86 - 1번 해결방법
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR( e.salary, '999,999,999,999' ) 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ( SELECT MAX(salary) FROM employee WHERE dept_code = 'D1' )
ORDER BY salary ASC
;

-- 86번 - 2번 해결방법
-- 조건식 ALL
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR( e.salary, '999,999,999,999' ) 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ALL( SELECT salary FROM employee WHERE dept_code = 'D1' )
ORDER BY salary ASC
;



--87
-- 부서코드 'D9' 부서의 최저 급여보다 높은 급여를 받는 사원을 조회
-- 87 - 1번 해결방법
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR( e.salary, '999,999,999,999' ) 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ( SELECT MIN(salary) FROM employee WHERE dept_code = 'D9' )
ORDER BY salary DESC
;

-- 87 - 2번 해결방법
-- 조건식 ANY
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,TO_CHAR( e.salary, '999,999,999,999' ) 급여
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ANY( SELECT salary FROM employee WHERE dept_code = 'D9' )
ORDER BY salary DESC;

-- 88
-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 
-- 부서가 없는 직원도 포함하여, 사원번호, 직원명, 부서번호, 부서명 출력하시오.
SELECT NVL( e.emp_id, '(없음)' ) 사원번호
      ,NVL( e.emp_name, '(없음)' ) 직원명
      ,NVL( d.dept_id, '(없음)' ) 부서번호
      ,NVL( d.dept_title, '(없음)' ) 부서명
FROM employee e 
     LEFT JOIN department d ON ( e.dept_code = d.dept_id );


-- 89
-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 
-- 직원이 없는 부서도 포함하여, 사원번호, 직원명, 부서번호, 부서명 출력하시오.

SELECT NVL( e.emp_id, '(없음)' ) 사원번호
      ,NVL( e.emp_name, '(없음)' ) 직원명
      ,NVL( d.dept_id, '(없음)' ) 부서번호
      ,NVL( d.dept_title, '(없음)' ) 부서명
FROM employee e
     RIGHT JOIN department d ON ( e.dept_code = d.dept_id );
     




-- 90
-- 테이블 EMPLOYEE 와 DEPARTMENT 를 조인하여 출력하되, 
-- 직원 및 부서 유무에 상관없이 출력하는, 사원번호, 직원명, 부서번호, 부서명 출력하시오.
SELECT NVL( e.emp_id, '(없음)' ) 사원번호
      ,NVL( e.emp_name, '(없음)' ) 직원명
      ,NVL( d.dept_id, '(없음)' ) 부서번호
      ,NVL( d.dept_title, '(없음)' ) 부서명
FROM employee e
     FULL JOIN department d ON ( e.dept_code = d.dept_id );
     
-- 91
-- 사원번호, 직원명, 부서번호, 부서명, 지역명, 국가명, 급여, 입사일자
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_id 부서번호
      ,d.dept_title 부서명
      ,l.local_name 지역명
      ,n.national_name 국가명
      ,e.salary 급여
      ,e.hire_date 입사일자
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     LEFT JOIN location l ON d.location_id = l.local_code
     LEFT JOIN national n USING(national_code)
;
-- USING : 조인하고자 하는 두 테이블의 컬럼명이 같은 경우, 
-- 조인 조건을 간단하게 작성하는 키워드
     
--92
-- 사원번호, 직원명, 부서명, 직급, 구분
-- 사원들 중 매니저를 출력하시오.
-- 1단계
-- manager_id 컬럼이 NULL 이 아닌 사원 조회
SELECT DISTINCT manager_id 
FROM employee
WHERE manager_id IS NOT NULL;

-- 2단계
-- employee, department, job 테이블을 조인하여 조회
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
;

-- 3단계
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                );


--93
-- 사원번호, 직원명, 부서명, 직급, 구분
-- 사원들 중 일반사원(매니저가 아닌)을 출력하시오.
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'사원' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id NOT IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                );

-- 94.
-- 사원들을 매니저와 사원으로 구분하여 모두 출력하시오
-- 단, UNION 키워드를 사용하시오.
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'매니저' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                )
UNION
SELECT e.emp_id 사원번호
      ,e.emp_name 직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      ,'사원' 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id NOT IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                )
;

-- 95
SELECT e.emp_id 사원번호
      ,e.emp_name  직원명
      ,d.dept_title 부서명
      ,j.job_name 직급
      , CASE
            WHEN e.emp_id IN (
                              SELECT DISTINCT manager_id 
                              FROM employee
                              WHERE manager_id IS NOT NULL
                            )
            THEN '매니저'
            ELSE '사원'
        END 구분
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
;

-- 96
-- 주민등록번호 뒷자리가 첫글자가 1 또는 3 이면 남자
--                            2 또는 4 이면 여자

-- XX800101-
-- XX050101-
-- 주민등록번호 뒷자리가 첫글자가 1,2,5,6 이면 19XX 년생
--                            3,4,7,8 이면 20XX 년생  
--                            9,0     이면 18XX 년생
SELECT emp_id 사원번호
      ,emp_name 직원명
      ,dept_title 부서명
      ,job_name 직급
      ,CASE 
            WHEN emp_id IN (
                             SELECT DISTINCT manager_id
                             FROM employee
                             WHERE manager_id IS NOT NULL
                            ) THEN '매니저'
            ELSE '사원' 
        END 구분
      ,CASE 
            WHEN SUBSTR(emp_no, 8, 1) IN ('1','3') THEN '남자'
            WHEN SUBSTR(emp_no, 8, 1) IN ('2','4') THEN '여자'
       END 성별
      , EXTRACT( year FROM sysdate)
        -
        (
            CASE 
                WHEN SUBSTR(emp_no, 8, 1) IN ('1','2','5','6') THEN '19'
                WHEN SUBSTR(emp_no, 8, 1) IN ('3','4','7','8') THEN '20'
                WHEN SUBSTR(emp_no, 8, 1) IN ('9','0') THEN '18'
            END || SUBSTR(emp_no, 1, 2) 
        ) + 1 나이
      ,RPAD( SUBSTR(emp_no, 1, 8), 14, '*' ) 주민등록번호
FROM employee
     LEFT JOIN department ON dept_code = dept_id
     JOIN job USING(job_code)
;

-- EXTRACT()
-- 날짜 데이터로 부터 날짜정보(연,월,일,시,분,초)를 추출하는 함수
SELECT sysdate
      ,EXTRACT ( year FROM sysdate ) 연
      ,EXTRACT ( month FROM sysdate ) 월
      ,EXTRACT ( day FROM sysdate ) 일
FROM dual;

SELECT systimestamp
      ,EXTRACT ( year FROM systimestamp ) 연
      ,EXTRACT ( month FROM systimestamp ) 월
      ,EXTRACT ( day FROM systimestamp ) 일
      ,EXTRACT ( hour FROM systimestamp ) 시
      ,EXTRACT ( minute FROM systimestamp ) 분
      ,EXTRACT ( second FROM systimestamp ) 초
FROM dual;


--
SELECT e.emp_id 사원번호
      ,e.emp_name 사원명
      ,d.dept_title 부서명
      ,J.JOB_NAME  직급
      ,
       CASE 
            WHEN SUBSTR(E.EMP_ID, 8, 1) = '1' THEN '남자'
            ELSE '여자'      
       END 성별
      ,
       TRUNC
        (
        MONTHS_BETWEEN(
                        TRUNC(SYSDATE), 
                        TO_DATE( CONCAT('19',SUBSTR(E.EMP_NO, 1, 6) ), 'YYYYMMDD')
                       ) / 12          
        ) +1 현재나이
      ,RPAD(SUBSTR(E.EMP_NO, 1, 8), 14, '*') 주민등록번호
      ,
      CASE 
        WHEN E.EMP_ID NOT IN (
            SELECT DISTINCT MANAGER_ID 
            FROM EMPLOYEE E
            WHERE MANAGER_ID IS NOT NULL)
        THEN '사원'
        ELSE '매니저'     
      END 구분

FROM EMPLOYEE E 
         LEFT JOIN DEPARTMENT D ON E.dept_code = D.dept_id
              JOIN JOB J USING(JOB_CODE)
;


-- 그룹 관련 함수
-- ROLLUP 미사용 
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;

-- ROLLUP 사용
-- : 그룹 기준으로 집계한 결과와 추가적으로 총 집계 정보를 출력하는 함수
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY ROLLUP(dept_code, job_code)
ORDER BY dept_code, job_code
;


-- CUBE 사용
-- : 가능한 모든 조합별로의 집계정보를 출력한다.
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY CUBE(dept_code, job_code)
ORDER BY dept_code, job_code
;

-- GROUPING SETS( )
-- : 그룹컬럼이 여러 개 일 때, 집계한 정보를 컬럼별로 출력하는 함수
-- 특정 부서의 직급별 인원 수
SELECT dept_code, job_code, COUNT(*)
FROM employee
GROUP BY GROUPING SETS( dept_code, job_code )
ORDER BY dept_code, job_code
;

-- GROUPING
-- : 그룹화한 컬럼들이 그룹화가 이루어진 상태인지 그 여부를 출력하는 함수
--   그룹화 O : 출력결과 0
--   그룹화 X : 출력결과 1
SELECT 컬럼1, 컬럼2, 컬럼3, ...
      ,GROUPING 그룹화 여부를 확인할 컬럼, ...
FROM 테이블명
GROUP BY [ROLLUP || CUBE] 그룹컬럼;

--
SELECT dept_code, job_code, MAX(salary), SUM(salary), TRUNC( AVG(salary), 2 )
      ,GROUPING(dept_code) "부서코드 그룹여부"
      ,GROUPING(job_code) "직급코드 그룹여부"
FROM employee
WHERE dept_code IS NOT NULL
  AND job_code IS NOT NULL
GROUP BY CUBE (dept_code, job_code)
ORDER BY dept_code, job_code;

-- LISTAGG(나열할 컬럼, [구분자])
-- LIST + Aggregate
-- 데이터목록 + 합쳐서 출력하는 함수
-- WITHIN GROUP (ORDER BY 정렬기준 컬럼)
-- : 그룹컬럼을 기준으로, 그룹화된 데이터를 하나의 열에 가로로 나열하여 출력하는 함수
SELECT *
FROM employees
WHERE department_id = 50
;

-- GROUP BY 그룹기준 컬럼으로 
-- first_name 을 지정하지 않으면,
-- SELECT 절에서 first_name 명시해서 조회하여 출력할 수 없다.
SELECT department_id, first_name
FROM employees
GROUP BY department_id, first_name
;

-- 부서코드별로 부서코드와 각 부서의 사원이름을 이름 순으로 나열하여 출력하시오.
SELECT dept_code 부서코드
      ,LISTAGG( emp_name, ', ' )
       WITHIN GROUP (ORDER BY emp_name) "부서별 사원이름목록"
FROM employee
GROUP BY dept_code
ORDER BY dept_code
;

-- PIVOT
-- : 그룹화한 행 데이터를 열로 바꾸어서 출력하는 함수
SELECT dept_code, job_code
      , LISTAGG(emp_name, ', ')
        WITHIN GROUP(ORDER BY salary DESC) "부서별 사원목록"
      , MAX(salary) 최대급여
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;

-- PITVOT 함수를 이용해서 직급은 행에, 부서는 열에 그룹화하여 최고급여를 출력하시오. 
SELECT *
FROM ( 
        SELECT dept_code, job_code, salary
        FROM employee
     )
     PIVOT (
        MAX(salary)
        FOR dept_code IN ('D1','D2','D3','D4','D5','D6','D7','D8','D9')
    )
ORDER BY job_code
;

-- PITVOT 함수를 이용해서 부서는 행에, 직급은 열에 그룹화하여 최고급여를 출력하시오. 
SELECT *
FROM  (
        SELECT job_code, dept_code, salary
        FROM employee
      )
      PIVOT (
        MAX(salary)
        FOR job_code IN ('J1','J2','J3','J4','J5','J6','J7')
      )
ORDER BY dept_code
;


-- UNPIVOT
-- : 그룹화된 결과인 열을 행 데이터로 바꾸어서 출력하는 함수
SELECT *
    FROM (
        select dept_code
              ,MAX( DECODE(job_code, 'J1', salary ) ) J1 -- "대표 최대급여"
              ,MAX( DECODE(job_code, 'J2', salary ) ) J2 -- "부사장 최대급여"
              ,MAX( DECODE(job_code, 'J3', salary ) ) J3 -- "부장 최대급여"
              ,MAX( DECODE(job_code, 'J4', salary ) ) J4 -- "차장 최대급여"
              ,MAX( DECODE(job_code, 'J5', salary ) ) J5 -- "과장 최대급여"
              ,MAX( DECODE(job_code, 'J6', salary ) ) J6 -- "대리 최대급여"
              ,MAX( DECODE(job_code, 'J7', salary ) ) J7 -- "사원 최대급여"
        FROM employee
        GROUP BY dept_code
        ORDER BY dept_code
    )
    UNPIVOT (
        salary
        FOR job_code IN (J1,J2,J3,J4,J5,J6,J7)
    )
;

-- 조인
-- 동등조인
-- : 등호(=) 연산자를 사용하여 2개 이상의 테이블을 연결하는 출력하는 방식 
SELECT e.emp_name, d.dept_title, e.salary
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
;

-- 세미조인
-- : 서브 쿼리에 존재하는 데이터만 메인 쿼리에서 추출하여 출력하는 방식
--   * IN 또는 EXISTS 연산자를 사용한 조인
-- 급여가 3000000 이상인 부서를 출력하시오.
SELECT *
FROM department d
WHERE EXISTS (
                SELECT *
                FROM employee e
                WHERE e.dept_code = d.dept_id
                  AND salary >= 3000000
             )
;

SELECT *
FROM department
WHERE dept_id IN (
                    SELECT dept_code
                    FROM employee
                    WHERE salary >= 3000000
                  )
;





-- 안티 조인
--  서브 쿼리에 존재하는 데이터만 제외하고 메인 쿼리에서 추출하여 출력하는 방식
SELECT *
FROM employee e
WHERE NOT EXISTS (
                    SELECT *
                    FROM department d
                    WHERE e.dept_code = d.dept_id
                 )
;

SELECT *
FROM employee e
WHERE dept_code NOT IN (
                    SELECT dept_id
                    FROM department d
                    WHERE e.dept_code = d.dept_id
                 )
;

-- 셀프 조인
-- 동일한 하나의 테이블을 2번이상 조합하여 출력하는 방식
-- 같은 부서의 사원에대한 매니저를 출력하시오.
SELECT b.emp_id 사원번호
     , b.emp_name 사원명
     , a.emp_name 매니저명
FROM employee a
    ,employee b
WHERE a.emp_id = b.manager_id
  AND a.dept_code = b.dept_code
;


-- 외부 조인 (OUTER JOIN)
-- LEFT OUTER JOIN
-- : 왼쪽 테이블을 먼저 읽어드린 후,
--  조인 조건에 일치하는 오른쪽 테이블을 함께 조회하는 것
--  * 오른쪽 테이블 데이터는 NULL 로 조회된다.
-- 1) ANSI 조인
-- LEFT OUTER JOIN 키워를 이용하여 조인한다.
-- * 테이블1 A LEFT OUTER JOIN 테이블2 B ON 조인조건;
-- 
-- 2) 기존 방식
-- 조인 조건에서 데이터가 없는 테이블의 컬럼에 (+) 기호를 붙여준다.
-- * WHERE A.공통컬럼 = B.공통컬럼(+);
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id(+);

-- RIGHT OUTER JOIN
-- : 오른쪽 테이블을 먼저 읽어드린 후,
--  조인 조건에 일치하는 왼쪽 테이블을 함께 조회하는 것
--  * 왼쪽 테이블 데이터는 NULL 로 조회된다.
-- 1) ANSI 조인
-- RIGHT OUTER JOIN 키워를 이용하여 조인한다.
-- * 테이블1 A RIGHT OUTER JOIN 테이블2 B ON 조인조건;
-- 
-- 2) 기존 방식
-- 조인 조건에서 데이터가 없는 테이블의 컬럼에 (+) 기호를 붙여준다.
-- * WHERE A.공통컬럼(+) = B.공통컬럼;
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
    ,department d
WHERE e.dept_code(+) = d.dept_id;

-- FULL OUTER JOIN
-- : -조인조건에 일치하는 왼쪽 테이블과 오른쪽 테이블의 교집합이 되는 데이터
--   -조인조건이 일치하지 않는 왼쪽 테이블 데이터 (오른쪽 테이블 데이터 NULL)
--   -조인조건이 일치하지 않는 오른쪽 테이블 데이터 (왼쪽 테이블 데이터 NULL)
--   위의 각 집합에 해당하는 데이터를 모두 출력하는 방식
--  * ANSI 조인만 있다. (FULL OUTER JOIN)
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
    ,department d
WHERE e.dept_code(+) = d.dept_id(+); -- 불가능
  
  
-- INNER JOIN
-- : 여러 테이블의 공통된 속성 값이 일치하는 데이터만 조회하는 방식
--  "교집합"
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e INNER JOIN department d ON e.dept_code = d.dept_id
;

-- 카테시안 조인
-- : 하나의 테이블 A과 다른 하나의 테이블 B의 모든 행을 조회하는 방식
--   (A 행의 수) X (B 행의 수) = (조회 결과 행의 수)
SELECT *
FROM employee
    ,department d
;
-- CROSS JOIN
SELECT *
FROM employee e
     CROSS JOIN department d;


-- WITH 절
SELECT *
FROM (SELECT * FROM employee WHERE dept_code = 'D1' ) e
    ,(SELECT * FROM department WHERE location_id = 'L1' ) d
WHERE e.dept_code = d.dept_id
;

--
WITH
    e AS (SELECT * FROM employee WHERE dept_code = 'D1'),
    d AS (SELECT * FROM department WHERE location_id = 'L1' )
SELECT *
FROM e, d
WHERE e.dept_code = d.dept_id
;
 
    
-- 데이터 사전
SELECT * FROM dict;
SELECT * FROM dictionary;

-- USER_??? 데이터 사전
SELECT * FROM user_tables;

-- ALL_??? 데이터 사전
SELECT * FROM all_tables WHERE TABLE_NAME NOT LIKE '%$%';

-- DBA_??? 데이터 사전
SELECT * FROM dba_tables;
SELECT * FROM dba_users;


-- 98
GRANT CREATE VIEW to human;
DROP VIEW VE_EMP_DEPT;
CREATE VIEW VE_EMP_DEPT
AS
    (
    SELECT e.emp_id
          ,e.emp_name
          ,d.dept_id
          ,d.dept_title
          ,e.email
          ,e.phone
          ,RPAD( SUBSTR(emp_no, 1, 8), 14, '*') AS emp_no
          ,TO_CHAR(hire_date, 'YYYY.MM.DD') AS hire_date
          ,TO_CHAR( salary, '999,999,999,999' ) AS salary
          ,TO_CHAR( (salary + NVL(salary*bonus,0)) * 12, '999,999,999,999') AS yr_salary
    FROM employee e
         LEFT JOIN department d ON e.dept_code = d.dept_id
    );
SELECT * FROM VE_EMP_DEPT;

-- 99
CREATE SEQUENCE SEQ_MS_USER
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 1000000;
       
CREATE SEQUENCE SEQ_MS_BOARD
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 1000000;
       
CREATE SEQUENCE SEQ_MS_FILE
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 1000000;
       
CREATE SEQUENCE SEQ_MS_REPLY
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 1000000;
       
-- 100. 
SELECT SEQ_MS_USER.nextval FROM dual;
SELECT SEQ_MS_USER.currval FROM dual;


-- 101.
DROP SEQUENCE SEQ_MS_USER;

CREATE SEQUENCE SEQ_MS_USER
START WITH 1
INCREMENT BY 1
MAXVALUE 1000000;

-- 102
INSERT INTO ms_user (USER_NO, USER_ID, USER_PW, USER_NAME,
                      BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE)
VALUES ( SEQ_MS_USER.nextval, 'ALOHA', '123456', '김휴먼', 
        '2002/01/01', '010-1234-1234','서울 영등포', sysdate, sysdate );

INSERT INTO ms_user (USER_NO, USER_ID, USER_PW, USER_NAME,
                      BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE)
VALUES ( SEQ_MS_USER.nextval, 'human', '123456', '박휴먼', 
        '2002/01/01', '010-3688-3688','서울 여의도', sysdate, sysdate );
commit;        
SELECT * FROM ms_user;


-- 103
ALTER SEQUENCE SEQ_MS_USER MAXVALUE 100000000;

-- 104
SELECT index_name, table_name, column_name
FROM user_ind_columns
;

-- 105
SELECT user_id, user_name
FROM ms_user;

-- 인덱스 생성
CREATE INDEX IDX_MS_USER_NAME ON human.ms_user(user_name);

-- 인덱스 삭제
DROP INDEX IDX_MS_USER_NAME;






























































      

      
      
      
      
      
      
      
      
      
      
      
      



























































































      





















































































































