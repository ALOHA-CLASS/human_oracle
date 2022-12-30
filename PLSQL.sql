create or replace PROCEDURE pro_print
IS      -- �����
    V_A NUMBER := 10;
    V_B NUMBER := 20;
    V_C NUMBER;
BEGIN   -- �����
    V_C := V_A + V_B;
    -- ��¹�
    DBMS_OUTPUT.PUT_LINE('V_C : ' || V_C);
END;
/

SET SERVEROUTPUT ON;
EXECUTE pro_print();

--

create or replace PROCEDURE pro_emp_write 
(
    IN_EMP_ID IN employee.emp_id%TYPE,
    IN_TITLE IN VARCHAR2,
    IN_CONTENT IN CLOB
)
IS
    V_EMP_NAME employee.emp_name%TYPE;
BEGIN
    -- INTO : ��ȸ����� ���� �����ϴ� Ű����
    SELECT emp_name INTO V_EMP_NAME FROM employee WHERE emp_id = IN_EMP_ID ;
    INSERT INTO ms_board ( BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT )
    VALUES ( SEQ_MS_BOARD.nextval, IN_TITLE, IN_CONTENT, V_EMP_NAME, 0, 0 );
    DBMS_OUTPUT.PUT_LINE('���� : ' || IN_TITLE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || IN_CONTENT);
    DBMS_OUTPUT.PUT_LINE('�ۼ��� : ' || V_EMP_NAME);
END;
/
SELECT * FROM employee;
SELECT * FROM ms_board;
EXECUTE pro_emp_write( '207', '����', '����' );

--
create or replace PROCEDURE pro_app_emp (
  -- �Ķ����
  IN_EMP_ID IN employees.employee_id%TYPE,
  IN_JOB_ID IN jobs.job_id%TYPE,
  IN_STD_DATE IN DATE,
  IN_END_DATE IN DATE
)
IS      -- �����
    V_DEPT_ID employees.department_id%TYPE;
    V_CNT NUMBER := 0;       -- �⺻ �����̷� ���� (emp_id, job_id)
BEGIN  -- �����
    -- 1. ������� ��ȸ
    SELECT department_id INTO V_DEPT_ID FROM employees WHERE employee_id = IN_EMP_ID;
    
    -- 2. ��� JOB_ID ����
    UPDATE employees
      SET job_id = IN_JOB_ID
     WHERE employee_id = IN_EMP_ID;
 
    -- 3. job_history �����̷� ����
    SELECT COUNT(*) INTO V_CNT 
    FROM job_history 
    WHERE employee_id = IN_EMP_ID
      AND job_id = IN_JOB_ID;
    
    DBMS_OUTPUT.PUT_LINE('�⺻���� ���� : ' || V_CNT);

    IF V_CNT = 0 THEN
        INSERT INTO job_history ( employee_id, start_date, end_date, job_id, department_id )
        VALUES ( IN_EMP_ID, IN_STD_DATE, IN_END_DATE, IN_JOB_ID, V_DEPT_ID );
    ELSE
        UPDATE job_history
           SET start_date = IN_STD_DATE
              ,end_date = IN_END_DATE
        WHERE employee_id = IN_EMP_ID
          AND job_id = IN_JOB_ID;
    END IF;
END;
/

--EXECUTE pro_app_emp ( in_emp_id => '100', in_job_id => 'IT PROG', in_std_date => '2023/01/01', in_end_date => '2023/12/31');
EXECUTE pro_app_emp ( '103', 'IT_PROG', '2026/01/01', '2026/12/31' );

SELECT * FROM employees;
SELECT * FROM job_history;
--

-- 
CREATE OR REPLACE PROCEDURE pro_print_emp (
    IN_EMP_ID IN employee.emp_id%TYPE
)
IS
    STR_EMP_INFO CLOB;      -- VARCHAR2(1000)
    -- V_EMP_NAME employee.emp_name%TYPE;
    -- V_EMP_EMAIL employee.emp_eamil%TYPE;
    -- V_EMP_PHONE employee.emp_phone%TYPE;
    -- %ROWTYPE
    -- : �ش� ���̺� �Ǵ� ���� �÷����� ����Ÿ������ �����Ѵ�.
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    STR_EMP_INFO := '�������' || CHR(10) || 
                    '����� : ' || V_EMP.emp_name || CHR(10) || 
                    '�̸��� : ' || V_EMP.email || CHR(10) || 
                    '��ȭ��ȣ : ' || V_EMP.phone;
    -- DBMS_OUTPUT.PUT_LINE('�������');
    -- DBMS_OUTPUT.PUT_LINE('����� : ' || V_EMP.emp_name);
    -- DBMS_OUTPUT.PUT_LINE('�̸��� : ' || V_EMP.email);
    -- DBMS_OUTPUT.PUT_LINE('��ȭ��ȣ : ' || V_EMP.phone);
    
    DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            STR_EMP_INFO := '�������� �ʴ� ���ID �Դϴ�.';
            DBMS_OUTPUT.PUT_LINE(STR_EMP_INFO);
END;
/
EXECUTE pro_print_emp('200');
EXECUTE pro_print_emp('300');



-- OUT �Ű������� ���ν��� ����ϱ�
CREATE OR REPLACE PROCEDURE pro_out_emp(
    IN_EMP_ID IN employee.emp_id%TYPE,
    OUT_RESULT_STR1 OUT CLOB
) IS
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    
    OUT_RESULT_STR := V_EMP.emp_id || '/' || V_EMP.emp_name || '/' || V_EMP.salary;
    -- DBMS_OUTPUT.PUT_LINE( OUT_RESULT_STR );
END;
/

SET SERVEROUTPUT ON;
DECLARE
    out_result_str CLOB;
BEGIN
    pro_out_emp('200', out_result_str );
    DBMS_OUTPUT.PUT_LINE( out_result_str );
END;
/

-- ���ν��� �ȿ��� ���ν��� ȣ��
CREATE OR REPLACE PROCEDURE pro_in_call  (
    IN_EMP_ID IN employee.emp_id%TYPE
)
IS
    V_TAX_SALARY employee.salary%TYPE;
BEGIN
    DECLARE
        out_result_str CLOB;
    BEGIN
        pro_out_emp( IN_EMP_ID, out_result_str );   -- ���ν��� �ȿ��� ���ν��� ȣ��
        DBMS_OUTPUT.PUT_LINE( pro_out_emp( IN_EMP_ID, out_result_str) );
    END;
    -- V_TAX_SALARY := func_sal_tax( 10000 );
    -- SELECT func_sal_tax( salary ) INTO V_TAX_SALARY FROM employee;
    DBMS_OUTPUT.PUT_LINE( '���ı޿� : ' || func_sal_tax( 10000 ) );  -- ���ν��� �ȿ��� �Լ� ȣ��
    DBMS_OUTPUT.PUT_LINE( '���ν��� �ȿ��� ���ν��� ȣ��' );
END;
/
EXECUTE pro_in_call( '200' );

-- ���ν����� OUT �Ķ���� 2�� �̻� ����ϱ�
CREATE OR REPLACE PROCEDURE pro_out_mul (
    IN_EMP_ID IN employee.emp_id%TYPE,
    OUT_DEPT_CODE OUT employee.dept_code%TYPE,
    OUT_JOB_CODE OUT employee.job_code%TYPE
)
IS
    V_EMP employee%ROWTYPE;
BEGIN
    SELECT * INTO V_EMP
    FROM employee
    WHERE emp_id = IN_EMP_ID;
    
    OUT_DEPT_CODE := V_EMP.dept_code;
    OUT_JOB_CODE := V_EMP.job_code;
END;
/
-- ���ν��� ȣ��
-- 1) �Ű����� X, IN �Ű�����  : EXCUTE ���ν�����( ����1, ����2 );
-- 2) OUT �Ű�����            : PL/SQL ��� �ȿ��� ȣ��
DECLARE
    out_dept_code employee.dept_code%TYPE;
    out_job_code employee.job_code%TYPE;
BEGIN
    pro_out_mul('200', out_dept_code, out_job_code );
    DBMS_OUTPUT.PUT_LINE(out_dept_code);
    DBMS_OUTPUT.PUT_LINE(out_job_code);
END;
/


SELECT * FROM employee;
















-- �Լ� ����
-- ���� �޿�
CREATE OR REPLACE FUNCTION func_sal_tax (
    IN_SALARY IN NUMBER
)
RETURN NUMBER
IS
    tax NUMBER := 0.10;
    result NUMBER;
BEGIN
    result := TRUNC( IN_SALARY - ( IN_SALARY * tax ), 2 );
    RETURN result;
END;
/
SELECT emp_id
      ,emp_name
      ,salary �����޿�
      ,func_sal_tax( salary ) ���ı޿�
FROM employee;
    























