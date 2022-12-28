create or replace PROCEDURE pro_print
IS      -- 선언부
    V_A NUMBER := 10;
    V_B NUMBER := 20;
    V_C NUMBER;
BEGIN   -- 실행부
    V_C := V_A + V_B;
    -- 출력문
    DBMS_OUTPUT.PUT_LINE('V_C : ' || V_C);
END;
/

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
    -- INTO : 조회결과를 변수 대입하는 키워드
    SELECT emp_name INTO V_EMP_NAME FROM employee WHERE emp_id = IN_EMP_ID ;
    INSERT INTO ms_board ( BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT )
    VALUES ( SEQ_MS_BOARD.nextval, IN_TITLE, IN_CONTENT, V_EMP_NAME, 0, 0 );
    DBMS_OUTPUT.PUT_LINE('제목 : ' || IN_TITLE);
    DBMS_OUTPUT.PUT_LINE('내용 : ' || IN_CONTENT);
    DBMS_OUTPUT.PUT_LINE('작성자 : ' || V_EMP_NAME);
END;
/
--
create or replace PROCEDURE pro_app_emp (
  -- 파라미터
  IN_EMP_ID IN employees.employee_id%TYPE,
  IN_JOB_ID IN jobs.job_id%TYPE,
  IN_STD_DATE IN DATE,
  IN_END_DATE IN DATE
)
IS      -- 선언부
    V_DEPT_ID employees.department_id%TYPE;
    V_CNT NUMBER := 0;       -- 기본 업무이력 개수 (emp_id, job_id)
BEGIN  -- 실행부
    -- 1. 사원정보 조회
    SELECT department_id INTO V_DEPT_ID FROM employees WHERE employee_id = IN_EMP_ID;
    
    -- 2. 사원 JOB_ID 수정
    UPDATE employees
      SET job_id = IN_JOB_ID
     WHERE employee_id = IN_EMP_ID;
 
    -- 3. job_history 업무이력 갱신
    SELECT COUNT(*) INTO V_CNT 
    FROM job_history 
    WHERE employee_id = IN_EMP_ID
      AND job_id = IN_JOB_ID;
    
    DBMS_OUTPUT.PUT_LINE('기본업무 개수 : ' || V_CNT);

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
EXECUTE pro_app_emp ( '103', 'IT_PROG', '2025/01/01', '2025/12/31' );

SELECT * FROM employees;
SELECT * FROM job_history;
--



-- 함수 생성
-- 세후 급여
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
      ,salary 세전급여
      ,func_sal_tax( salary ) 세후급여
FROM employee;
    























