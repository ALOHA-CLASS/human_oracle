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

-- COALESCE(����1, ����2, ...)
-- : ���ڵ� �� NULL �� �ƴ� ù��° ���� ��ȯ�ϴ� �Լ�
SELECT FIRST_NAME �̸�
      ,SALARY �޿�
      ,NVL(COMMISSION_PCT,0) Ŀ�̼�
      ,COALESCE( SALARY + (SALARY * COMMISSION_PCT), SALARY  ) �����޿�
FROM employees
ORDER BY �����޿� DESC
;

-- LNVNL(���ǽ�)
-- : ���ǽ��� ����� 
--    TRUE                     --> FALSE
--    FALSE �Ǵ� UNKNOWN(NULL)  --> TRUE ��ȯ�ϴ� �Լ�
-- commission_pct �� 0.2 �̸� �׸��� NULL �� ������� ��ȸ�ȴ�.
SELECT *
FROM employees
WHERE LNNVL( commission_pct >= 0.2 );

-- �Ʒ��� ���� ������ �ָ�, 
-- commission_pct �� NULL �� ����� ���Ե��� �ʴ´�.
SELECT *
FROM employees
WHERE commission_pct < 0.2 ;

-- ���� �����Ϻ��� �������� 1���� �ʰ����� �ʴ� �����͸� ��ȸ�Ͻÿ�.
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
 
-- 60. ������ ����
DELETE FROM ms_student
WHERE st_no = '20110002';

-- ROLLBACK : ��������� �ǵ����� ���
ROLLBACK;

-- COMMIT   : ��������� �����ϴ� ���
COMMIT;

SELECT * FROM ms_student;

-- 61. ms_student ���̺� ��ȸ
SELECT *
FROM ms_student;

-- 62. ��� ���̺� ����
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


-- 65. ���� ���� �߰�
-- ALTER TABLE [���̺��] ADD CONSTRAINT [�������� ��] CHECK [��������];
ALTER TABLE MS_STUDENT 
ADD CONSTRAINT MS_STD_GENDER_CHECK 
CHECK (gender IN ('��','��','��Ÿ') );

INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,
                          ADM_DATE ,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20221234', '���޸�', '991005', 'khm@univ.ac.kr', '����', '��', 'I01', 
         '����', '2018/03/01', NULL, sysdate, sysdate, NULL );

UPDATE MS_STUDENT
   SET GENDER = '����'
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

COMMENT ON TABLE MS_USER IS 'ȸ��';
COMMENT ON COLUMN MS_USER.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN MS_USER.USER_ID IS '���̵�';
COMMENT ON COLUMN MS_USER.USER_PW IS '��й�ȣ';
COMMENT ON COLUMN MS_USER.USER_NAME IS '�̸�';
COMMENT ON COLUMN MS_USER.BIRTH IS '�������';
COMMENT ON COLUMN MS_USER.TEL IS '��ȭ��ȣ';
COMMENT ON COLUMN MS_USER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN MS_USER.REG_DATE IS '�������';
COMMENT ON COLUMN MS_USER.UPD_DATE IS '��������';

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

COMMENT ON TABLE MS_BOARD IS '�Խ���';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '�Խñ� ��ȣ';
COMMENT ON COLUMN MS_BOARD.TITLE IS '����';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '����';
COMMENT ON COLUMN MS_BOARD.WRITER IS '�ۼ���';
COMMENT ON COLUMN MS_BOARD.HIT IS '��ȸ��';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '���ƿ� ��';
COMMENT ON COLUMN MS_BOARD.DEL_YN IS '��������';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '��������';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '�������';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '��������';

-- 68
CREATE TABLE MS_FILE (
    FILE_NO     NUMBER NOT NULL PRIMARY KEY,
    BOARD_NO    NUMBER NOT NULL,
    FILE_NAME   VARCHAR2(2000) NOT NULL,
    FILE_DATA   BLOB NOT NULL,
    REG_DATE    DATE DEFAULT SYSDATE NOT NULL,
    UPD_DATE    DATE DEFAULT SYSDATE NOT NULL
);

COMMENT ON TABLE MS_FILE IS '÷������';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '���Ϲ�ȣ';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '�۹�ȣ';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '���ϸ�';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '����';
COMMENT ON COLUMN MS_FILE.REG_DATE IS '�������';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '��������';


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

COMMENT ON TABLE MS_REPLY IS '���';
COMMENT ON COLUMN MS_REPLY.REPLY_NO IS '��۹�ȣ';
COMMENT ON COLUMN MS_REPLY.BOARD_NO IS '�۹�ȣ';
COMMENT ON COLUMN MS_REPLY.CONTENT IS '����';
COMMENT ON COLUMN MS_REPLY.WRITER IS '�ۼ���';
COMMENT ON COLUMN MS_REPLY.DEL_YN IS '��������';
COMMENT ON COLUMN MS_REPLY.DEL_DATE IS '��������';
COMMENT ON COLUMN MS_REPLY.REG_DATE IS '�������';
COMMENT ON COLUMN MS_REPLY.UPD_DATE IS '��������';


-- 70
-- �������� ��������(import)
-- import ��, 
-- dmp ������ ������ ������ �ٸ� �������� ������ ����
-- system ���� �Ǵ� ������ �������� �����Ͽ� ��ɾ �����ؾ��Ѵ�.
imp userid=system/123456 file=C:\KHM\SQL\human\community.dmp fromuser=human touser=human2;

-- human2 ���� ����
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER human2 IDENTIFIED BY 123456;
ALTER USER human2 DEFAULT TABLESPACE users;
ALTER USER human2 QUOTA UNLIMITED ON users;
GRANT connect, resource TO human2;

-- humna ������ DBA ���� �ο�
GRANT dba TO human;
GRANT dba TO human2;

-- 71
-- �������� �����ϱ�(export)
exp userid=human/123456 file=C:\KHM\SQL\human\community.dmp log=C:\KHM\SQL\human\community.log 
;
--
expdp human/123456 directory=C:\KHM\SQL\human dumpfile=community2.dmp log=community2.log version=11
;





-- 72
-- MS_BOARD ���̺��� WRITER �Ӽ��� ������Ÿ���� NUMBER �� ����
ALTER TABLE ms_board MODIFY writer NUMBER;

-- MS_BOARD ���̺��� �ܷ�Ű ����
ALTER TABLE ms_board DROP CONSTRAINT MS_BOARD_WRITER_FK;

-- MS_BOARD ���̺��� WRITER �Ӽ��� �ܷ�Ű�� ����
ALTER TABLE ms_board 
ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (writer) REFERENCES ms_user(user_no);

-- MS_FILE ���̺��� �ܷ�Ű ����
ALTER TABLE ms_file DROP CONSTRAINT MS_FILE_BOARD_NO_FK;

-- MS_FILE ���̺��� BOARD_NO �Ӽ��� �ܷ�Ű�� ����
ALTER TABLE ms_file
ADD CONSTRAINT MS_FILE_BOARD_NO_FK FOREIGN KEY (board_no) REFERENCES ms_board(board_no);

-- MS_REPLY ���̺��� �ܷ�ĳ ����
ALTER TABLE ms_reply DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;

-- MS_REPLY ���̺��� BOARD_NO �Ӽ��� �ܷ�Ű�� ����
ALTER TABLE ms_reply 
ADD CONSTRAINT MS_REPLY_BOARD_NO_FK FOREIGN KEY (board_no) REFERENCES ms_board(board_no);

-- 73.
-- MS_USER ���̺� CTZ_NO, GENDER �Ӽ��� �߰�
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '�ֹι�ȣ';
COMMENT ON column MS_USER.GENDER IS '����';

DESC MS_USER;

-- 74.
-- MS_USER ���̺��� GENDER �Ӽ��� ('��','��','��Ÿ') ���� ������ �������� �߰�
ALTER TABLE MS_USER 
ADD CONSTRAINT MS_USER_GENDER_CHECK CHECK (GENDER IN ('��','��', '��Ÿ'));

-- 75. 
-- MS_FILE ���̺� EXT(Ȯ����) �Ӽ��� �߰�
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NULL;
COMMENT ON COLUMN MS_FILE.EXT IS 'Ȯ����';


76. 
-- ������.jpg, �޸ձ�������.png
MERGE INTO MS_FILE T
USING (SELECT FILE_NO, FILE_NAME FROM MS_FILE ) F ON (T.FILE_NO = F.FILE_NO)
WHEN MATCHED THEN
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1)
    DELETE 
    WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1) + 1) 
    NOT IN ('jpeg','jpg','png','gif')
;

-- ���ڿ����� Ȯ���� �����ϱ�
SELECT SUBSTR( '������.jpg', INSTR('������.jpg', '.', -1) + 1 ) Ȯ���� 
      ,INSTR('������.jpg', '.', -1) ".��ġ"
FROM dual;

-- �׽�Ʈ ������ �߰�
INSERT INTO MS_USER 
(user_no, user_id, user_pw, user_name, birth, 
  tel, address, reg_date, upd_date, ctz_no, gender)
VALUES (1, 'HUMAN', '123456', '���޸�', '2002/03/23' , '010-1234-XXXX',
        '������', sysdate, sysdate, '020323-3xxxxxx', '��Ÿ' );

INSERT INTO MS_BOARD 
(board_no, title, content, writer, hit, like_cnt, del_yn, del_date, reg_date, upd_date)
VALUES (2, '����', '����', 1,1,0, 'N', sysdate, sysdate, sysdate);

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_data, reg_date, upd_date, ext )
VALUES (2, 2, '������.png', '123', sysdate, sysdate, 'jpg' );

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_data, reg_date, upd_date, ext )
VALUES (4, 2, '�н��ڷ�.pdf', '123', sysdate, sysdate, 'pdf' );

INSERT INTO MS_FILE
(file_no, board_no, file_name, file_data, reg_date, upd_date, ext )
VALUES (5, 2, '�н��ڷ�2.pdf', '123', sysdate, sysdate, 'jpg' );

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
-- MS_BOARD ���̺� WRITER �Ӽ� �߰�
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;

-- MS_BOARD �� WRITER �Ӽ��� �ܷ�Ű�� ����
-- ���� ���̺��� ������ ���� ��, ���������� �����Ͱ� �����ǵ��� �ɼ� ����
ALTER TABLE MS_BOARD 
ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (WRITER)
REFERENCES MS_USER(USER_NO) 
ON DELETE CASCADE;

-- MS_FILE ���̺� BOARD_NO �Ӽ� �߰�
ALTER TABLE MS_FILE ADD BOARD_NO NUMBER NOT NULL;

-- MS_FILE ���̺��� BOARD_NO �Ӽ��� �ܷ�Ű�� ����
-- ���� ���̺��� ������ ���� ��, ���������� �����Ͱ� �����ǵ��� �ɼ� ����
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK
FOREIGN KEY (BOARD_NO) 
REFERENCES MS_BOARD(BOARD_NO)
ON DELETE CASCADE;

-- MS_REPLY ���̺� BOARD_NO �Ӽ� �߰�
ALTER TABLE MS_REPLY ADD BOARD_NO NUMBER NOT NULL;

-- MS_REPLY ���̺��� BOARD_NO �Ӽ��� �ܷ�Ű�� ����
-- ���� ���̺��� ������ ���� ��, ���������� �����Ͱ� �����ǵ��� �ɼ� ����
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
SELECT EMP_ID AS �����ȣ
      ,EMP_NAME AS ������
      ,(SELECT DEPT_TITLE FROM DEPARTMENT D WHERE D.DEPT_ID = E.DEPT_CODE) �μ���
      ,(SELECT JOB_NAME FROM JOB J WHERE J.JOB_CODE = E.JOB_CODE) ���޸�
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

-- ���̺� �ϰ�����
SELECT 'DROP TABLE ' || object_name || ' CASCADE CONSTRAINTS;' "���̺� ��ü ����"
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
-- �����ȣ, ������, �μ���, �޿�, �ְ�޿�, �����޿�, ��ձ޿�
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_title �μ���
      ,e.salary �޿�
      ,t.max_sal �ְ�޿�
      ,t.min_sal �����޿�
      ,ROUND(t.avg_sal, 2) ��ձ޿�
FROM employee e LEFT JOIN department d ON (dept_code = dept_id)
    ,( SELECT DEPT_CODE, MAX(salary) MAX_SAL, MIN(salary) MIN_SAL, AVG(salary) AVG_SAL
       FROM employee
       GROUP BY dept_code
     ) t
WHERE e.salary = t.max_sal
;

                
-- 83. 
-- 1�ܰ�
-- �������� �����¸����� ����� ��ȸ
SELECT emp_name, dept_code
FROM employee
WHERE emp_name = '���¸�';

-- '���¸�' ����� ���� �μ��� �������� �����ȣ, ������, �̸���, ��ȭ��ȣ�� ��ȸ
SELECT emp_id �����ȣ
      ,emp_name ������
      ,email �̸���
      ,phone ��ȭ��ȣ
FROM employee
WHERE dept_code = (
                    SELECT dept_code
                    FROM employee
                    WHERE emp_name = '���¸�'
                   );

-- 84.
-- ����� �����ϴ� �μ��� ��ȸ�Ͻÿ�.
-- 1�ܰ� 
-- �μ��ڵ尡 NULL �� �ƴ� ������� �μ��ڵ带 �ߺ����� ��ȸ
SELECT DISTINCT dept_code
FROM employee
WHERE dept_code IS NOT NULL
;

-- ��� ���̺��� �����ϴ� �μ��ڵ常 �����ϴ� �μ� ���̺��� ���� ��ȸ
-- 84 - 1�� �ذ���
SELECT dept_id �μ���ȣ
      ,dept_title �μ���
      ,location_id ������
FROM department
WHERE dept_id IN (
                    SELECT DISTINCT dept_code
                    FROM employee
                    WHERE dept_code IS NOT NULL
                 )
ORDER BY dept_id ASC
;

-- 84 - 2�� �ذ���
SELECT dept_id �μ���ȣ
      ,dept_title �μ���
      ,location_id ������
FROM department d
WHERE EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY d.dept_id;

-- 85
-- ����� �������� �ʴ� �μ� ���̺��� �μ���ȣ, �μ���, �������� ��ȸ
-- 85 - 1�� �ذ���
SELECT dept_id �μ���ȣ
      ,dept_title �μ���
      ,location_id ������
FROM department
WHERE dept_id NOT IN (
                    SELECT DISTINCT dept_code
                    FROM employee
                    WHERE dept_code IS NOT NULL
                 )
ORDER BY dept_id ASC;
-- 85 - 2�� �ذ���
SELECT dept_id �μ���ȣ
      ,dept_title �μ���
      ,location_id ������
FROM department d
WHERE NOT EXISTS ( SELECT * FROM employee e WHERE e.dept_code = d.dept_id )
ORDER BY d.dept_id;


-- 86.
-- 1�ܰ�
-- ��� ���̺�� �μ� ���̺��� �����Ͽ� �����ȣ,������,�μ���ȣ,�μ���,�޿��� ��ȸ
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_id �μ���ȣ
      ,d.dept_title �μ���
      ,e.salary �޿�
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id;
-- �μ��ڵ� 'D1' �μ��� �ִ� �޿����� ���� �޿��� �޴� ����� ��ȸ
-- 86 - 1�� �ذ���
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_id �μ���ȣ
      ,d.dept_title �μ���
      ,TO_CHAR( e.salary, '999,999,999,999' ) �޿�
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ( SELECT MAX(salary) FROM employee WHERE dept_code = 'D1' )
ORDER BY salary ASC
;

-- 86�� - 2�� �ذ���
-- ���ǽ� ALL
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_id �μ���ȣ
      ,d.dept_title �μ���
      ,TO_CHAR( e.salary, '999,999,999,999' ) �޿�
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ALL( SELECT salary FROM employee WHERE dept_code = 'D1' )
ORDER BY salary ASC
;



--87
-- �μ��ڵ� 'D9' �μ��� ���� �޿����� ���� �޿��� �޴� ����� ��ȸ
-- 87 - 1�� �ذ���
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_id �μ���ȣ
      ,d.dept_title �μ���
      ,TO_CHAR( e.salary, '999,999,999,999' ) �޿�
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ( SELECT MIN(salary) FROM employee WHERE dept_code = 'D9' )
ORDER BY salary DESC
;

-- 87 - 2�� �ذ���
-- ���ǽ� ANY
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_id �μ���ȣ
      ,d.dept_title �μ���
      ,TO_CHAR( e.salary, '999,999,999,999' ) �޿�
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
  AND salary > ANY( SELECT salary FROM employee WHERE dept_code = 'D9' )
ORDER BY salary DESC;

-- 88
-- ���̺� EMPLOYEE �� DEPARTMENT �� �����Ͽ� ����ϵ�, 
-- �μ��� ���� ������ �����Ͽ�, �����ȣ, ������, �μ���ȣ, �μ��� ����Ͻÿ�.
SELECT NVL( e.emp_id, '(����)' ) �����ȣ
      ,NVL( e.emp_name, '(����)' ) ������
      ,NVL( d.dept_id, '(����)' ) �μ���ȣ
      ,NVL( d.dept_title, '(����)' ) �μ���
FROM employee e 
     LEFT JOIN department d ON ( e.dept_code = d.dept_id );


-- 89
-- ���̺� EMPLOYEE �� DEPARTMENT �� �����Ͽ� ����ϵ�, 
-- ������ ���� �μ��� �����Ͽ�, �����ȣ, ������, �μ���ȣ, �μ��� ����Ͻÿ�.

SELECT NVL( e.emp_id, '(����)' ) �����ȣ
      ,NVL( e.emp_name, '(����)' ) ������
      ,NVL( d.dept_id, '(����)' ) �μ���ȣ
      ,NVL( d.dept_title, '(����)' ) �μ���
FROM employee e
     RIGHT JOIN department d ON ( e.dept_code = d.dept_id );
     




-- 90
-- ���̺� EMPLOYEE �� DEPARTMENT �� �����Ͽ� ����ϵ�, 
-- ���� �� �μ� ������ ������� ����ϴ�, �����ȣ, ������, �μ���ȣ, �μ��� ����Ͻÿ�.
SELECT NVL( e.emp_id, '(����)' ) �����ȣ
      ,NVL( e.emp_name, '(����)' ) ������
      ,NVL( d.dept_id, '(����)' ) �μ���ȣ
      ,NVL( d.dept_title, '(����)' ) �μ���
FROM employee e
     FULL JOIN department d ON ( e.dept_code = d.dept_id );
     
-- 91
-- �����ȣ, ������, �μ���ȣ, �μ���, ������, ������, �޿�, �Ի�����
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_id �μ���ȣ
      ,d.dept_title �μ���
      ,l.local_name ������
      ,n.national_name ������
      ,e.salary �޿�
      ,e.hire_date �Ի�����
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     LEFT JOIN location l ON d.location_id = l.local_code
     LEFT JOIN national n USING(national_code)
;
-- USING : �����ϰ��� �ϴ� �� ���̺��� �÷����� ���� ���, 
-- ���� ������ �����ϰ� �ۼ��ϴ� Ű����
     
--92
-- �����ȣ, ������, �μ���, ����, ����
-- ����� �� �Ŵ����� ����Ͻÿ�.
-- 1�ܰ�
-- manager_id �÷��� NULL �� �ƴ� ��� ��ȸ
SELECT DISTINCT manager_id 
FROM employee
WHERE manager_id IS NOT NULL;

-- 2�ܰ�
-- employee, department, job ���̺��� �����Ͽ� ��ȸ
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_title �μ���
      ,j.job_name ����
      ,'�Ŵ���' ����
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
;

-- 3�ܰ�
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_title �μ���
      ,j.job_name ����
      ,'�Ŵ���' ����
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                );


--93
-- �����ȣ, ������, �μ���, ����, ����
-- ����� �� �Ϲݻ��(�Ŵ����� �ƴ�)�� ����Ͻÿ�.
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_title �μ���
      ,j.job_name ����
      ,'���' ����
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id NOT IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                );

-- 94.
-- ������� �Ŵ����� ������� �����Ͽ� ��� ����Ͻÿ�
-- ��, UNION Ű���带 ����Ͻÿ�.
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_title �μ���
      ,j.job_name ����
      ,'�Ŵ���' ����
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
WHERE emp_id IN ( 
                    SELECT DISTINCT manager_id 
                    FROM employee
                    WHERE manager_id IS NOT NULL
                )
UNION
SELECT e.emp_id �����ȣ
      ,e.emp_name ������
      ,d.dept_title �μ���
      ,j.job_name ����
      ,'���' ����
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
SELECT e.emp_id �����ȣ
      ,e.emp_name  ������
      ,d.dept_title �μ���
      ,j.job_name ����
      , CASE
            WHEN e.emp_id IN (
                              SELECT DISTINCT manager_id 
                              FROM employee
                              WHERE manager_id IS NOT NULL
                            )
            THEN '�Ŵ���'
            ELSE '���'
        END ����
FROM employee e
     LEFT JOIN department d ON e.dept_code = d.dept_id
     JOIN job j USING(job_code)
;

-- 96
-- �ֹε�Ϲ�ȣ ���ڸ��� ù���ڰ� 1 �Ǵ� 3 �̸� ����
--                            2 �Ǵ� 4 �̸� ����

-- XX800101-
-- XX050101-
-- �ֹε�Ϲ�ȣ ���ڸ��� ù���ڰ� 1,2,5,6 �̸� 19XX ���
--                            3,4,7,8 �̸� 20XX ���  
--                            9,0     �̸� 18XX ���
SELECT emp_id �����ȣ
      ,emp_name ������
      ,dept_title �μ���
      ,job_name ����
      ,CASE 
            WHEN emp_id IN (
                             SELECT DISTINCT manager_id
                             FROM employee
                             WHERE manager_id IS NOT NULL
                            ) THEN '�Ŵ���'
            ELSE '���' 
        END ����
      ,CASE 
            WHEN SUBSTR(emp_no, 8, 1) IN ('1','3') THEN '����'
            WHEN SUBSTR(emp_no, 8, 1) IN ('2','4') THEN '����'
       END ����
      , EXTRACT( year FROM sysdate)
        -
        (
            CASE 
                WHEN SUBSTR(emp_no, 8, 1) IN ('1','2','5','6') THEN '19'
                WHEN SUBSTR(emp_no, 8, 1) IN ('3','4','7','8') THEN '20'
                WHEN SUBSTR(emp_no, 8, 1) IN ('9','0') THEN '18'
            END || SUBSTR(emp_no, 1, 2) 
        ) + 1 ����
      ,RPAD( SUBSTR(emp_no, 1, 8), 14, '*' ) �ֹε�Ϲ�ȣ
FROM employee
     LEFT JOIN department ON dept_code = dept_id
     JOIN job USING(job_code)
;

-- EXTRACT()
-- ��¥ �����ͷ� ���� ��¥����(��,��,��,��,��,��)�� �����ϴ� �Լ�
SELECT sysdate
      ,EXTRACT ( year FROM sysdate ) ��
      ,EXTRACT ( month FROM sysdate ) ��
      ,EXTRACT ( day FROM sysdate ) ��
FROM dual;

SELECT systimestamp
      ,EXTRACT ( year FROM systimestamp ) ��
      ,EXTRACT ( month FROM systimestamp ) ��
      ,EXTRACT ( day FROM systimestamp ) ��
      ,EXTRACT ( hour FROM systimestamp ) ��
      ,EXTRACT ( minute FROM systimestamp ) ��
      ,EXTRACT ( second FROM systimestamp ) ��
FROM dual;


--
SELECT e.emp_id �����ȣ
      ,e.emp_name �����
      ,d.dept_title �μ���
      ,J.JOB_NAME  ����
      ,
       CASE 
            WHEN SUBSTR(E.EMP_ID, 8, 1) = '1' THEN '����'
            ELSE '����'      
       END ����
      ,
       TRUNC
        (
        MONTHS_BETWEEN(
                        TRUNC(SYSDATE), 
                        TO_DATE( CONCAT('19',SUBSTR(E.EMP_NO, 1, 6) ), 'YYYYMMDD')
                       ) / 12          
        ) +1 ���糪��
      ,RPAD(SUBSTR(E.EMP_NO, 1, 8), 14, '*') �ֹε�Ϲ�ȣ
      ,
      CASE 
        WHEN E.EMP_ID NOT IN (
            SELECT DISTINCT MANAGER_ID 
            FROM EMPLOYEE E
            WHERE MANAGER_ID IS NOT NULL)
        THEN '���'
        ELSE '�Ŵ���'     
      END ����

FROM EMPLOYEE E 
         LEFT JOIN DEPARTMENT D ON E.dept_code = D.dept_id
              JOIN JOB J USING(JOB_CODE)
;


-- �׷� ���� �Լ�
-- ROLLUP �̻�� 
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;

-- ROLLUP ���
-- : �׷� �������� ������ ����� �߰������� �� ���� ������ ����ϴ� �Լ�
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY ROLLUP(dept_code, job_code)
ORDER BY dept_code, job_code
;


-- CUBE ���
-- : ������ ��� ���պ����� ���������� ����Ѵ�.
SELECT dept_code, job_code
      ,COUNT(*), MAX(salary), SUM(salary), TRUNC( AVG(salary), 2)
FROM employee
GROUP BY CUBE(dept_code, job_code)
ORDER BY dept_code, job_code
;

-- GROUPING SETS( )
-- : �׷��÷��� ���� �� �� ��, ������ ������ �÷����� ����ϴ� �Լ�
-- Ư�� �μ��� ���޺� �ο� ��
SELECT dept_code, job_code, COUNT(*)
FROM employee
GROUP BY GROUPING SETS( dept_code, job_code )
ORDER BY dept_code, job_code
;

-- GROUPING
-- : �׷�ȭ�� �÷����� �׷�ȭ�� �̷���� �������� �� ���θ� ����ϴ� �Լ�
--   �׷�ȭ O : ��°�� 0
--   �׷�ȭ X : ��°�� 1
SELECT �÷�1, �÷�2, �÷�3, ...
      ,GROUPING �׷�ȭ ���θ� Ȯ���� �÷�, ...
FROM ���̺��
GROUP BY [ROLLUP || CUBE] �׷��÷�;

--
SELECT dept_code, job_code, MAX(salary), SUM(salary), TRUNC( AVG(salary), 2 )
      ,GROUPING(dept_code) "�μ��ڵ� �׷쿩��"
      ,GROUPING(job_code) "�����ڵ� �׷쿩��"
FROM employee
WHERE dept_code IS NOT NULL
  AND job_code IS NOT NULL
GROUP BY CUBE (dept_code, job_code)
ORDER BY dept_code, job_code;

-- LISTAGG(������ �÷�, [������])
-- LIST + Aggregate
-- �����͸�� + ���ļ� ����ϴ� �Լ�
-- WITHIN GROUP (ORDER BY ���ı��� �÷�)
-- : �׷��÷��� ��������, �׷�ȭ�� �����͸� �ϳ��� ���� ���η� �����Ͽ� ����ϴ� �Լ�
SELECT *
FROM employees
WHERE department_id = 50
;

-- GROUP BY �׷���� �÷����� 
-- first_name �� �������� ������,
-- SELECT ������ first_name ����ؼ� ��ȸ�Ͽ� ����� �� ����.
SELECT department_id, first_name
FROM employees
GROUP BY department_id, first_name
;

-- �μ��ڵ庰�� �μ��ڵ�� �� �μ��� ����̸��� �̸� ������ �����Ͽ� ����Ͻÿ�.
SELECT dept_code �μ��ڵ�
      ,LISTAGG( emp_name, ', ' )
       WITHIN GROUP (ORDER BY emp_name) "�μ��� ����̸����"
FROM employee
GROUP BY dept_code
ORDER BY dept_code
;

-- PIVOT
-- : �׷�ȭ�� �� �����͸� ���� �ٲپ ����ϴ� �Լ�
SELECT dept_code, job_code
      , LISTAGG(emp_name, ', ')
        WITHIN GROUP(ORDER BY salary DESC) "�μ��� ������"
      , MAX(salary) �ִ�޿�
FROM employee
GROUP BY dept_code, job_code
ORDER BY dept_code, job_code
;

-- PITVOT �Լ��� �̿��ؼ� ������ �࿡, �μ��� ���� �׷�ȭ�Ͽ� �ְ�޿��� ����Ͻÿ�. 
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

-- PITVOT �Լ��� �̿��ؼ� �μ��� �࿡, ������ ���� �׷�ȭ�Ͽ� �ְ�޿��� ����Ͻÿ�. 
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
-- : �׷�ȭ�� ����� ���� �� �����ͷ� �ٲپ ����ϴ� �Լ�
SELECT *
    FROM (
        select dept_code
              ,MAX( DECODE(job_code, 'J1', salary ) ) J1 -- "��ǥ �ִ�޿�"
              ,MAX( DECODE(job_code, 'J2', salary ) ) J2 -- "�λ��� �ִ�޿�"
              ,MAX( DECODE(job_code, 'J3', salary ) ) J3 -- "���� �ִ�޿�"
              ,MAX( DECODE(job_code, 'J4', salary ) ) J4 -- "���� �ִ�޿�"
              ,MAX( DECODE(job_code, 'J5', salary ) ) J5 -- "���� �ִ�޿�"
              ,MAX( DECODE(job_code, 'J6', salary ) ) J6 -- "�븮 �ִ�޿�"
              ,MAX( DECODE(job_code, 'J7', salary ) ) J7 -- "��� �ִ�޿�"
        FROM employee
        GROUP BY dept_code
        ORDER BY dept_code
    )
    UNPIVOT (
        salary
        FOR job_code IN (J1,J2,J3,J4,J5,J6,J7)
    )
;

-- ����
-- ��������
-- : ��ȣ(=) �����ڸ� ����Ͽ� 2�� �̻��� ���̺��� �����ϴ� ����ϴ� ��� 
SELECT e.emp_name, d.dept_title, e.salary
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id
;

-- ��������
-- : ���� ������ �����ϴ� �����͸� ���� �������� �����Ͽ� ����ϴ� ���
--   * IN �Ǵ� EXISTS �����ڸ� ����� ����
-- �޿��� 3000000 �̻��� �μ��� ����Ͻÿ�.
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





-- ��Ƽ ����
--  ���� ������ �����ϴ� �����͸� �����ϰ� ���� �������� �����Ͽ� ����ϴ� ���
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

-- ���� ����
-- ������ �ϳ��� ���̺��� 2���̻� �����Ͽ� ����ϴ� ���
-- ���� �μ��� ��������� �Ŵ����� ����Ͻÿ�.
SELECT b.emp_id �����ȣ
     , b.emp_name �����
     , a.emp_name �Ŵ�����
FROM employee a
    ,employee b
WHERE a.emp_id = b.manager_id
  AND a.dept_code = b.dept_code
;


-- �ܺ� ���� (OUTER JOIN)
-- LEFT OUTER JOIN
-- : ���� ���̺��� ���� �о�帰 ��,
--  ���� ���ǿ� ��ġ�ϴ� ������ ���̺��� �Բ� ��ȸ�ϴ� ��
--  * ������ ���̺� �����ʹ� NULL �� ��ȸ�ȴ�.
-- 1) ANSI ����
-- LEFT OUTER JOIN Ű���� �̿��Ͽ� �����Ѵ�.
-- * ���̺�1 A LEFT OUTER JOIN ���̺�2 B ON ��������;
-- 
-- 2) ���� ���
-- ���� ���ǿ��� �����Ͱ� ���� ���̺��� �÷��� (+) ��ȣ�� �ٿ��ش�.
-- * WHERE A.�����÷� = B.�����÷�(+);
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
    ,department d
WHERE e.dept_code = d.dept_id(+);

-- RIGHT OUTER JOIN
-- : ������ ���̺��� ���� �о�帰 ��,
--  ���� ���ǿ� ��ġ�ϴ� ���� ���̺��� �Բ� ��ȸ�ϴ� ��
--  * ���� ���̺� �����ʹ� NULL �� ��ȸ�ȴ�.
-- 1) ANSI ����
-- RIGHT OUTER JOIN Ű���� �̿��Ͽ� �����Ѵ�.
-- * ���̺�1 A RIGHT OUTER JOIN ���̺�2 B ON ��������;
-- 
-- 2) ���� ���
-- ���� ���ǿ��� �����Ͱ� ���� ���̺��� �÷��� (+) ��ȣ�� �ٿ��ش�.
-- * WHERE A.�����÷�(+) = B.�����÷�;
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
    ,department d
WHERE e.dept_code(+) = d.dept_id;

-- FULL OUTER JOIN
-- : -�������ǿ� ��ġ�ϴ� ���� ���̺�� ������ ���̺��� �������� �Ǵ� ������
--   -���������� ��ġ���� �ʴ� ���� ���̺� ������ (������ ���̺� ������ NULL)
--   -���������� ��ġ���� �ʴ� ������ ���̺� ������ (���� ���̺� ������ NULL)
--   ���� �� ���տ� �ش��ϴ� �����͸� ��� ����ϴ� ���
--  * ANSI ���θ� �ִ�. (FULL OUTER JOIN)
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e
    ,department d
WHERE e.dept_code(+) = d.dept_id(+); -- �Ұ���
  
  
-- INNER JOIN
-- : ���� ���̺��� ����� �Ӽ� ���� ��ġ�ϴ� �����͸� ��ȸ�ϴ� ���
--  "������"
SELECT e.emp_id
      ,e.emp_name
      ,d.dept_id
      ,d.dept_title
FROM employee e INNER JOIN department d ON e.dept_code = d.dept_id
;

-- ī�׽þ� ����
-- : �ϳ��� ���̺� A�� �ٸ� �ϳ��� ���̺� B�� ��� ���� ��ȸ�ϴ� ���
--   (A ���� ��) X (B ���� ��) = (��ȸ ��� ���� ��)
SELECT *
FROM employee
    ,department d
;
-- CROSS JOIN
SELECT *
FROM employee e
     CROSS JOIN department d;


-- WITH ��
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
 
    
-- ������ ����
SELECT * FROM dict;
SELECT * FROM dictionary;

-- USER_??? ������ ����
SELECT * FROM user_tables;

-- ALL_??? ������ ����
SELECT * FROM all_tables WHERE TABLE_NAME NOT LIKE '%$%';

-- DBA_??? ������ ����
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
VALUES ( SEQ_MS_USER.nextval, 'ALOHA', '123456', '���޸�', 
        '2002/01/01', '010-1234-1234','���� ������', sysdate, sysdate );

INSERT INTO ms_user (USER_NO, USER_ID, USER_PW, USER_NAME,
                      BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE)
VALUES ( SEQ_MS_USER.nextval, 'human', '123456', '���޸�', 
        '2002/01/01', '010-3688-3688','���� ���ǵ�', sysdate, sysdate );
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

-- �ε��� ����
CREATE INDEX IDX_MS_USER_NAME ON human.ms_user(user_name);

-- �ε��� ����
DROP INDEX IDX_MS_USER_NAME;






























































      

      
      
      
      
      
      
      
      
      
      
      
      



























































































      





















































































































