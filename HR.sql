-- 1.
conn system/123456

-- 2.
-- ALL_USERS ���̺��� USERNAME �÷��� ��HR����,
-- USER_ID�� USERNAME �� ��ȸ�Ͻÿ�.
-- ctrl + enter : �ڵ� �κ� ����
SELECT user_id, username
FROM all_users
WHERE username = 'HR';


-- HR ��������
-- C## ���� ���� ����
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;


-- CREATE USER [������] IDENTIFIED BY [��й�ȣ];
CREATE USER HR IDENTIFIED BY 123456;

-- ������ ���̺� �����̽��� ����� �� �ִ� ���� �ο�
-- HR ������ ���Ͽ� ���������� users ���̺����̽��� ���� ���
ALTER USER HR QUOTA UNLIMITED ON users;

-- ���� ���� ���� �ο�
-- HR ������ ���Ͽ� ���� �� �ڿ���뿡 ���� ���� �ο�
GRANT connect, resource TO HR;

-- HR ���õ����� ����
@?/demo/schema/human_resources/hr_main.sql



-- 3. ���̺� ���� ��ȸ
DESC employees;

--
SELECT employee_id, first_name
FROM employees;

-- 4.
SELECT employee_id  AS �����ȣ
      ,first_name   AS �̸�
      ,last_name    AS ��
      ,email        AS �̸���
      ,phone_number AS ��ȭ��ȣ
      ,hire_date    AS �Ի�����
      ,salary       AS �޿�
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

-- ���� ����
-- ctrl + shift + D
-- ctrl + shift + ��

-- 8.
-- ������ ���� : ORDER BY [�÷���] [ASC/DESC]
-- ASC  : ��������
-- DESC : ��������
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
  
-- 13. FIRST_NAME �� 'S' �� �����ϴ� ���
SELECT *
FROM employees
WHERE first_name LIKE 'S%';

-- '_' : �� ���� ��ü ��ȣ
-- '%' : ���� ���� ���� ���ڸ� ��ü�ϴ� ��ȣ

-- 14. FIRST_NAME �� 's' �� ������ ���
SELECT *
FROM employees
WHERE first_name LIKE '%s';

-- 15. FIRST_NAME �� 's' �� ���ԵǴ� ���
SELECT *
FROM employees
WHERE first_name LIKE '%s%';

-- 16. FIRST_NAME �� 5������ ���
SELECT *
FROM employees
WHERE first_name LIKE '_____';

-- LENGTH(�÷�)  : �÷��� ���� ���� ��ȯ�ϴ� �Լ�  
SELECT *
FROM employees
WHERE LENGTH(first_name) = 5;

--17. COMMISSION_PCT �� NULL �� ���
SELECT *
FROM employees
WHERE commission_pct IS NULL;

--18. COMMISSION_PCT �� NULL �� �ƴ� ���
SELECT *
FROM employees
WHERE commission_pct IS NOT NULL;


-- 19.HIRE_DATE�� 04�� �̻��� ���
SELECT *
FROM employees 
WHERE hire_date >= '04/01/01';


-- 20. HIRE_DATE�� 04�� ���� 05�⵵ �� ���
SELECT *
FROM employees 
WHERE hire_date >= '04/01/01'
  AND hire_date <= '05/12/31';
  
SELECT *
FROM employees
WHERE hire_date BETWEEN '04/01/01' AND '05/12/31';
 
-- ���� ��¥/�ð� ��ȸ
-- dual : �ӽ����̺� (���� �Ǵ� �ӽ���ȸ�� ���� ���)
SELECT sysdate FROM dual;
SELECT TO_NUMBER( TO_CHAR(sysdate, 'j') ) FROM dual;


-- sysdate 
-- 1970�� 1�� 1�� ms ������ ���� �Ͻñ��� �ð��� ������ ���� (/��)���� ȯ���� ��

-- ���� : �ټ��ϼ�
SELECT first_name AS �̸�
      ,hire_date AS �Ի�����
      -- 2022/01/01  ~ 2022/12/16
      -- ,sysdate - hire_date
      ,trunc(sysdate - hire_date)+1 AS �ټ��ϼ�        -- (���糯¥ - �Ի�����)
FROM employees;

-- �ټӿ���
SELECT first_name AS �̸�
      ,hire_date AS �Ի�����
      -- 2022/01/01  ~ 2022/12/16
      ,trunc( months_between(sysdate, hire_date) ) AS �ټӿ���    
      -- months_between() : �� ��¥ ���� ���� ���� ��ȯ
FROM employees;

-- �ټӿ���
SELECT first_name AS �̸�
      ,hire_date AS �Ի�����
      -- 2022/01/01  ~ 2022/12/16
      ,trunc( (sysdate-hire_date+1) / 365 ) AS �ټӿ���
FROM employees 
WHERE trunc( (sysdate-hire_date+1) / 365 ) >= 15
ORDER BY �ټӿ��� DESC
;



-- 21. �ø�(CEIL) 12.45, -12.45 ���� ũ�ų� ���� ���� �� ���� ���� ��
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;

-- 22. ����(FLOOR) 12.55, -12.55 ���� �۰ų� ���� ���� �� ���� ū ��
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;

-- 23. �ݿø�(ROUND) (0.5 ������ ���� / 0.5 ũ�ų� ������ �ø�)
-- 0.54 �� �Ҽ��� �Ʒ� ù° �ڸ����� �ݿø��Ͻÿ�.  
SELECT ROUND(0.54,0) FROM dual;
-- 0.xxxxxxxxxx
--   0123456789

-- 0.54 �� �Ҽ��� �Ʒ� ��° �ڸ����� �ݿø��Ͻÿ�.  
SELECT ROUND(0.54, 1) FROM dual;

-- 125.67 �� ���� �ڸ����� �ݿø��Ͻÿ�. 
SELECT ROUND(125.67, -1) FROM dual;
--    xxxxx.xxxxx
-- (-)54321.01234

-- 125.67 �� ���� �ڸ����� �ݿø��Ͻÿ�. 
SELECT ROUND(125.67, -2) FROM dual;



-- 24. MOD( ) : �������� ���ϴ� �Լ�
--  10 % 2    :   MOD(10, 2)

-- 3�� 8�� ���� �������� ���Ͻÿ�. �� ��� : 3
SELECT MOD(3, 8) FROM dual;

-- 30�� 4�� ���� �������� ���Ͻÿ�. �� ��� : 2
SELECT MOD(30, 4) FROM dual;


-- 25. POWER( ) : �������� ���ϴ� �Լ�
--     2^4      : POWER(2, 4)

-- 2�� 10������ ���Ͻÿ�. �� ��� : 1024
SELECT POWER(2, 10) FROM dual;

-- 2�� 31������ ���Ͻÿ�. �� ��� : 2147483648
SELECT POWER(2, 31) FROM dual;

-- 25.  SQRT( ) : �������� ���ϴ� �Լ�
--   9�� ������  :  SQRT(9)
-- 2�� �������� ���Ͻÿ� �� 1.4xxx
SELECT SQRT(2) FROM dual;

-- 100�� �������� ���Ͻÿ� �� 10
SELECT SQRT(100) FROM dual;


-- 27. TRUNC(�Ǽ�, �ڸ���) : �ش� ���� �����ϴ� �Լ�
--  12.34 �Ҽ��� �Ʒ� ù° �ڸ����� ����  : TRUNC(12.34, 0)

-- 527425.1234 �� �Ҽ��� �Ʒ� ù° �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, 0) FROM dual;

-- 527425.1234 �� �Ҽ��� �Ʒ� ��° �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, 1) FROM dual;

-- 527425.1234 �� ���� �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, -1) FROM dual;

-- 527425.1234 �� ���� �ڸ����� �����Ͻÿ�.
SELECT TRUNC(527425.1234, -2) FROM dual;

-- 28. ABS( ) : ������ ���ϴ� �Լ�
-- -12.34 �� ����    :  ABS(-12.34)

-- -20 �� ������ ���Ͻÿ�.
SELECT ABS(-20) FROM dual;

-- -12.456 �� ������ ���Ͻÿ�.
SELECT ABS(12.456) FROM dual;

-- 29.
-- UPPER( )     : �����ڸ� �빮�ڷ� ��ȯ�ϴ� �Լ�
-- LOWER( )     : �����ڸ� �ҹ��ڷ� ��ȯ�ϴ� �Լ�
-- INITCAP( )   : �����ڸ� �ܾ �������� ù���ڸ� �빮�ڷ�
-- ���� : 'AlOhA WoRlD~!'
SELECT 'AlOhA WoRlD~!' AS ����
      ,UPPER('AlOhA WoRlD~!') AS �빮��
      ,LOWER('AlOhA WoRlD~!') AS �ҹ���
      ,INITCAP('AlOhA WoRlD~!') AS "ù���ڸ� �빮��"
FROM dual;

-- 30. ���ڼ��� ����Ʈ ��
-- LENGTH( )  : ���ڼ��� ����ϴ� �Լ�
-- LENGTHB( ) : ����Ʈ���� ����ϴ� �Լ�
-- ����/����/Ư������ : 1byte
-- �ѱ�             : 3byte
SELECT LENGTH('ALOHA WORLD') AS "���� ��"
      ,LENGTHB('ALOHA WORLD') AS "����Ʈ ��"
FROM dual;

SELECT LENGTH('�˷��� ����') AS "���� ��"
      ,LENGTHB('�˷��� ����') AS "����Ʈ ��"
FROM dual;

-- 31. �� ���ڿ��� ����(����)
-- CONCAT(���ڿ�1, ���ڿ�2) : �� ���ڿ��� �����ϴ� �Լ�
--  ||  : �� ���̻��� ���ڿ��� �����ϴ� ��ȣ
SELECT CONCAT('ALOHA', 'WORLD') AS "�Լ�"
      ,'ALOHA' || 'WORLD' AS "��ȣ"
FROM dual;


-- 32. SUBSTR( ) : ���ڿ��� �Ϻθ� ����ϴ� �Լ�
-- ���ڿ� : 'www.human.com'
-- SUBSTR('���ڿ�', ���۹�ȣ, ���ڼ�)
SELECT SUBSTR('www.human.com', 1, 3) AS "1"       -- www
      ,SUBSTR('www.human.com', 5, 5) AS "2"       -- human
      ,SUBSTR('www.human.com', 11, 3) AS "3"      -- com
FROM dual;

-- SUBSTRB('���ڿ�', ���۹���Ʈ, ����Ʈ��)
SELECT SUBSTRB('www.human.com', 1, 3) AS "1"       -- www
      ,SUBSTRB('www.human.com', 5, 5) AS "2"       -- human
      ,SUBSTRB('www.human.com', 11, 3) AS "3"      -- com
FROM dual;

SELECT SUBSTRB('www.�޸�.com', 1, 3) AS "1"       -- www
      ,SUBSTRB('www.�޸�.com', 5, 6) AS "2"       -- �޸�
      ,SUBSTRB('www.�޸�.com', 12, 3) AS "3"      -- com
FROM dual;

-- 33
-- INSTR('���ڿ�', '����', �˻���ġ, ����)
-- 'ALOHACAMPUS'
-- ����° ���ں��� ã�Ƽ�, 1��° A�� ��ġ�� ���Ͻÿ�.
SELECT INSTR('ALOHACAMPUS', 'A', 3, 1) FROM dual;

SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1��° A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2��° A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3��° A"
FROM dual;

SELECT INSTRB('ALOHACAMPUS', 'A', 1, 1) AS "1��° A"
      ,INSTRB('ALOHACAMPUS', 'A', 1, 2) AS "2��° A"
      ,INSTRB('ALOHACAMPUS', 'A', 1, 3) AS "3��° A"
FROM dual;


-- 34.
-- LPAD('���ڿ�', ĭ�Ǽ�, 'ä�﹮��') : ���� ������� Ư�����ڷ� ä��� �Լ�
-- RPAD('���ڿ�', ĭ�Ǽ�, 'ä�﹮��') : ������ ������� Ư�����ڷ� ä��� �Լ�
SELECT LPAD('ALOHACAMPUS', 20, '#') AS "����"
      ,RPAD('ALOHACAMPUS', 20, '#') AS "������"
FROM dual;

-- 35.
-- TO_CHAR( )   : ��¥, ���� �����͸� ���ڿ��� ��ȯ�ϴ� �Լ�
-- employees �� HIRE_DATE �� 2022-12-19 (��) 12:00:00 ���·� ����Ͻÿ�
-- �� : YYYY
-- �� : MM
-- �� : DD
-- ���� : dy
-- �� : HH
-- �� : MI
-- �� : SS
SELECT first_name AS �̸�
      ,hire_date 
      ,TO_CHAR(hire_date, 'YYYY-MM-DDD (dy) HH:MI:SS') AS �Ի�����
FROM employees
;

-- 36.
-- employees ���̺��� salary(����) �÷��� $10,000 �̿Ͱ��� �������� ����Ͻÿ�.
-- 9 : ���� ������ ǥ������ ����
-- 0 : ���� ������ "0" ó���Ͽ� ǥ��
SELECT first_name AS �̸�
      ,salary
      ,TO_CHAR(salary, '$99,999.00') AS �޿�
FROM employees;

-- 37
-- TO_DATE : �������� ��¥ �����͸� ��¥�� �����ͷ� ��ȯ�ϴ� �Լ�
SELECT 20221219 AS ����
      ,TO_DATE(sysdate) AS ��¥
      ,TO_DATE('2022.12.19') ��¥2
      ,TO_DATE('2022/12/19') ��¥3
      ,TO_DATE('2022-12-19') ��¥4
      ,TO_CHAR(TO_DATE('2022-12-19'), 'YYYY-MM-DD (dy) HH:MI:SS')
      
FROM dual;

-- 38
-- TO_NUMBER('����������', '����') 
-- '1,200,000'  --> 1200000
SELECT '1,200,000' AS ����
      ,TO_NUMBER('1,200,000', '999,999,999') AS ����
FROM dual;


-- 39
-- ����, ����, ���� ��¥�� ����Ͻÿ�
SELECT TO_CHAR(sysdate-1, 'YYYY.MM.DD') AS ����
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') AS ����
      ,TO_CHAR(sysdate+1, 'YYYY.MM.DD') AS ����
FROM dual;


-- 40
SELECT first_name �̸�
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') �Ի�����
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') ����
      ,TRUNC( (sysdate - hire_date)) �ٹ��ϼ�
      ,TRUNC( MONTHS_BETWEEN(sysdate, hire_date) ) �ٹ��޼�
      ,TRUNC( MONTHS_BETWEEN(sysdate, hire_date) / 12 ) �ټӿ���
FROM employees
;

-- 41
-- ADD_MONTHS(��¥, ������)  : �ش糯¥�κ��� ���� ���� ���� ��¥�� ��ȯ�ϴ� �Լ�
SELECT sysdate ����
      ,ADD_MONTHS(sysdate, 6) "6������"
      ,ADD_MONTHS(sysdate, -6) "6������"
FROM dual;

--42
-- NEXT_DAY(��¥, ���Ϲ�ȣ)  : �ش� ��¥ ������ ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
-- ��(1)~��(7)
SELECT sysdate ����
      ,NEXT_DAY(sysdate, 7) "���� �����"
      ,NEXT_DAY('2023/01/01', 7) "2023 ù �����"
FROM dual;

-- 43
-- ����, ���� ���ϱ�
SELECT sysdate ����
      ,TRUNC(sysdate, 'MM') ����
      ,LAST_DAY(sysdate) ����
      ,TRUNC(sysdate, 'IW')����
      ,NEXT_DAY(sysdate, 1)�ָ�
FROM dual;
-- ��ȭ���������


-- 44.
-- NVL(��, ���϶� ������ ��)  : �ش� ���� NULL �̸� ������ ������ ��ȯ�ϴ� �Լ�
SELECT DISTINCT NVL(commission_pct, 0) "Ŀ�̼�(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC
;

SELECT DISTINCT NVL(commission_pct, 0) "Ŀ�̼�"
FROM employees
ORDER BY Ŀ�̼� DESC
;

SELECT first_name �̸�
      ,salary ����
      ,salary + (salary * NVL(commission_pct, 0)) �ѱ޿�
      ,NVL2( commission_pct, 'O', 'X' ) Ŀ�̼ǿ���
FROM employees
;


-- ��ȸ�� �÷��� ��Ī���� ORDER BY ������ ����� �� �ִ�.
-- ��ȸ�� �÷��� ��Ī���� WHERE ������ ����� �� ����.

-- SELECT ����� ���� ����
SELECT [�÷�1], [�÷�2]  ( * )
FROM [���̺�]
WHERE [����]
GROUP BY [�׷���� �÷�] HAVING [�׷� ����]
ORDER BY [���ı��� �÷�] [ASC/DESC]
;
-- (�������)
-- FROM �� WHERE �� GROUP BY �� HAVING �� SELECT �� ORDER BY

-- 45.
-- ���̺� EMPLOYEES �� FIRST_NAME, SALARY, COMMISION_PCT �Ӽ��� �̿��Ͽ� 
--  �̸�, �޿�, Ŀ�̼�, �����޿� 
--  <����> 
--  �����޿� = �޿� + (�޿�*Ŀ�̼�)
--  �����޿��� �������� �������� ����
SELECT FIRST_NAME �̸�
      ,SALARY �޿�
      ,NVL(COMMISSION_PCT,0) Ŀ�̼�
      ,SALARY + (SALARY * NVL(COMMISSION_PCT,0)) �����޿�
FROM employees
ORDER BY �����޿� DESC
;


-- 46.
SELECT *
FROM employees;

SELECT *
FROM departments;

-- ���� : INNER JOIN
SELECT emp.first_name �̸�
      ,dep.department_name �μ�
FROM employees emp, departments dep
WHERE emp.department_id = dep.department_id;


-- DECODE( ����, ����1, ���1, ����2, ���2, ... )
-- : ������ ���� ���ǰ� ��ġ�� ��, �� ���� ������ ����� ����ϴ� �Լ�
SELECT first_name �̸�
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
      ) �μ�
FROM employees;

-- 47
SELECT first_name �̸�
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
       END �μ�
FROM employees;
       
-- 48.
SELECT COUNT(*) �����
FROM employees;

-- 49.
SELECT MAX(salary) �ְ�޿�
      ,MIN(salary) �����޿�
FROM employees;

-- 50.
SELECT SUM(salary) �޿��հ�
      ,ROUND( AVG(salary), 2) �޿����
FROM employees;

-- 51.
SELECT ROUND( STDDEV(salary), 2) �޿�ǥ������
      ,ROUND( VARIANCE(salary), 2) �޿��л�
FROM employees;

--52. MS_STUDENT ���̺� �����ϱ�

-- human ���� ����
-- C## ���� ���� ����
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


CREATE TABLE ���̺�� (
    �÷���1    Ÿ��  [NOT NULL/NULL] [��������],
    �÷���2    Ÿ��  [NOT NULL/NULL] [��������],
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
    , ETC           VARCHAR2(1000) DEFAULT '����'
);
COMMENT ON TABLE MS_STUDENT IS '�л�����';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '�л���ȣ';
COMMENT ON COLUMN MS_STUDENT.NAME IS '�̸�';
COMMENT ON COLUMN MS_STUDENT.CTZ_NO IS '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '�̸���';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '�ּ�';
COMMENT ON COLUMN MS_STUDENT.DEPT_NO IS '�кι�ȣ';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '������ȣ';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '�������';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '��������';
COMMENT ON COLUMN MS_STUDENT.ETC IS 'Ư�̻���';


-- 53. MS_STUDENT ���̺� �Ӽ��� �߰�
-- ����, ����, ��������, �������� �Ӽ� �߰�
ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '��Ÿ' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '����';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '���' NOT NULL;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '����';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '��������';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '��������';

-- �Ӽ� ����
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

-- 54
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;   -- �÷��� ����
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;               -- ������ Ÿ�� ����
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '�������';        -- ���� ����

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
    GENDER      CHAR(6)         DEFAULT '��Ÿ'    NOT NULL ,
    STATUS      VARCHAR2(10)    DEFAULT '���'    NOT NULL ,
    ADM_DATE    DATE            NULL    ,
    GRD_DATE    DATE            NULL    ,
    REG_DATE    DATE            DEFAULT sysdate  NOT NULL    ,
    UPD_DATE    DATE            DEFAULT sysdate  NOT NULL    ,
    ETC         VARCHAR2(1000)  DEFAULT '����'    NULL
);

COMMENT ON TABLE MS_STUDENT IS '�л�';
COMMENT ON COLUMN MS_STUDENT.ST_NO IS '�л���ȣ';
COMMENT ON COLUMN MS_STUDENT.NAME IS '�̸�';
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '�������';
COMMENT ON COLUMN MS_STUDENT.EMAIL IS '�̸���';
COMMENT ON COLUMN MS_STUDENT.ADDRESS IS '�ּ�';
COMMENT ON COLUMN MS_STUDENT.MJ_NO IS '������ȣ';
COMMENT ON COLUMN MS_STUDENT.GENDER IS '����';
COMMENT ON COLUMN MS_STUDENT.STATUS IS '����';
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '��������';
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '��������';
COMMENT ON COLUMN MS_STUDENT.REG_DATE IS '�������';
COMMENT ON COLUMN MS_STUDENT.UPD_DATE IS '��������';
COMMENT ON COLUMN MS_STUDENT.ETC IS 'Ư�̻���';

-- 58
-- ������ �߰� 
-- INSERT INTO [���̺��] ( �÷�1, �÷�2, ... )
-- VALUES ( '��1', '��2', ... );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,
                          ADM_DATE ,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001', '�ּ���', '991005', 'csa@univ.ac.kr', '����', '��', 'I01', 
         '����', '2018/03/01', NULL, sysdate, sysdate, NULL );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210001', '�ڼ���', '020504', 'psj@univ.ac.kr', '����', '��', 'B02', '����', '2021/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20210002', '�����', '020504', 'kay@univ.ac.kr', '��õ', '��', 'S01', '����', '2021/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20160001', '������', '970210', 'jsa@univ.ac.kr', '�泲', '��', 'J02', '����', '2016/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20150010', '������', '960311', 'ydh@univ.ac.kr', '����', '��', 'K01', '����', '2015/03/01', NULL, sysdate, sysdate, NULL );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20130007', '�Ⱦƶ�', '941124', 'aar@univ.ac.kr', '���', '��', 'Y01', '����', '2013/03/01', NULL, sysdate, sysdate, '���󿹼� Ư����' );


INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20110002', '�Ѽ�ȣ', '921007', 'hsh@univ.ac.kr', '����', '��Ÿ', 'E03', '����', '2015/03/01', NULL, sysdate, sysdate, NULL );

COMMIT;
         
SELECT * FROM ms_student;

--59
-- UPDATE [���̺��]
--    SET [�÷�1] = '������'
--       ,[�÷�2] = '������'
--  WHERE [�÷�] = [��];
-- �й� : 20160001 �� �л��� �ּҸ� '����', ������ '����'���� �����Ͻÿ�.
UPDATE ms_student
   SET address = '����'
      ,status = '����'
WHERE st_no = 20160001;

UPDATE MS_STUDENT 
    SET ADDRESS = '����', STATUS = '����'
      , GRD_DATE = '2020/02/20', UPD_DATE = '2020/01/01'  
WHERE ST_NO = '20150010';

UPDATE MS_STUDENT 
   SET STATUS = '����', GRD_DATE = '2020/02/20', UPD_DATE ='2020/01/01' 
WHERE ST_NO = '20130007';

UPDATE MS_STUDENT 
SET STATUS = '����', UPD_DATE = '2013/02/10', ETC = '���� ����' 
WHERE ST_NO = '20110002';

COMMIT;

SELECT * FROM ms_student;























































      

      
      
      
      
      
      
      
      
      
      
      
      






































































































      



















































































































