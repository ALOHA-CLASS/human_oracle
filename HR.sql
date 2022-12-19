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
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS �Ի�����
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






















































































      



















































































































