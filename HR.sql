--
-- ORACLE MISSION 
-- 

-- 01
sqlplus 
system
123456

-- 또는
sqlplus / as sysdba 123456;
conn
system
123456


-- 02

SELECT USER_ID, USERNAME
FROM ALL_USERS
WHERE USERNAME = 'HR';

-- HR 계정이 없는 경우
-- C## 없이 USER 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- HR 계정생성
CREATE USER HR IDENTIFIED BY 123456;
ALTER USER HR QUOTA UNLIMITED ON users;
GRANT connect, resource TO hr;

-- hr_main.sql 실행
@ [경로]\hr_main.sql
@?/demo/schema/human_resources/hr_main.sql
--> 1  : 123456 [비빌번호]
--> 2  : users [tablespace]
--> 3  : temp [temp tablespace]
--> 4  : [log 경로]


-- HR 계정이 있는 경우,
-- HR 계정 잠금 해제
ALTER USER HR ACCOUNT UNLOCK;



-- 03
DESC employees;


--04 
SELECT employee_id, first_name
FROM employees;


--04
SELECT employee_id AS 사원번호
      ,first_name AS 이름
      ,last_name AS 성
      ,email AS 이메일
      ,phone_number AS 전화번호
      ,hire_date AS 입사일자
      ,salary AS 급여
FROM employees;


--05
SELECT DISTINCT job_id 
FROM employees;

--06
SELECT * FROM employees WHERE salary > 6000;

--07
SELECT * FROM employees WHERE salary = 10000;

--08
SELECT * FROM employees 
ORDER BY salary DESC, FIRST_NAME ASC;


--09

SELECT * FROM employees WHERE job_id = 'FI_ACCOUNT' OR job_id = 'IT_PROG';

--10
SELECT * FROM employees WHERE job_id IN ( 'FI_ACCOUNT', 'IT_PROG' );

--11
SELECT * FROM employees WHERE job_id NOT IN ( 'FI_ACCOUNT', 'IT_PROG' );

--12
SELECT * FROM employees WHERE job_id = 'IT_PROG' AND salary >= 6000;


--13
SELECT * FROM employees WHERE first_name LIKE 'S%';

--14
SELECT * FROM employees WHERE first_name LIKE '%s';

--15
SELECT * FROM employees WHERE first_name LIKE '%s%';


--16
SELECT * FROM employees WHERE first_name LIKE '_____';
SELECT * FROM employees WHERE LENGTH(first_name) = 5;



--17
SELECT * FROM employees WHERE commission_pct IS NULL;

--18
SELECT * FROM employees WHERE commission_pct IS NOT NULL;


--19
SELECT * FROM employees WHERE HIRE_DATE >= '04/01/01';

--20
SELECT * FROM employees WHERE HIRE_DATE BETWEEN '04/01/01' AND '05/12/31';
SELECT * FROM employees WHERE HIRE_DATE >= '04/01/01' AND HIRE_DATE <= '05/12/31';



--21
SELECT CEIL(12.45) FROM dual;
SELECT CEIL(-12.45) FROM dual;

--22
SELECT FLOOR(12.55) FROM dual;
SELECT FLOOR(-12.55) FROM dual;

--23
SELECT ROUND(0.54, 0) FROM dual;
SELECT ROUND(0.54, 1) FROM dual;
SELECT ROUND(125.67, -1) FROM dual;
SELECT ROUND(125.67, -2) FROM dual;



--24
SELECT MOD(3,8) FROM dual;
SELECT MOD(30,4) FROM dual;


--25
SELECT POWER(2,10) FROM dual;
SELECT POWER(2,31) FROM dual;


--26
SELECT SQRT(2) FROM dual;
SELECT SQRT(100) FROM dual;

--27
SELECT TRUNC(527425.1234, 0) FROM dual;
SELECT TRUNC(527425.1234, 1) FROM dual;
SELECT TRUNC(527425.1234, -1) FROM dual;
SELECT TRUNC(527425.1234, -2) FROM dual;


--28
SELECT ABS(-20) FROM dual;
SELECT ABS(-12.456) FROM dual;


--29
SELECT 'AlOhA WoRlD~!' AS 원문
      ,UPPER('AlOhA WoRlD~!') AS 대문자
      ,LOWER('AlOhA WoRlD~!') AS 소문자
      ,INITCAP('AlOhA WoRlD~!') AS "첫글자만 대문자"
FROM dual;



--30
SELECT LENGTH('ALOHA WORLD') AS "글자 수"
      ,LENGTHB('ALOHA WORLD') AS "바이트 수"
FROM dual;

SELECT LENGTH('알로하 월드') AS "글자 수"
      ,LENGTHB('알로하 월드') AS "바이트 수"
FROM dual;



--31
SELECT CONCAT('ALOHA','WORLD') AS "함수"
      ,'ALOHA' || 'WORLD' AS "기호"
FROM dual;
SELECT 'ALOHA' || 'WORLD' FROM dual;

--32
SELECT SUBSTR('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTR('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTR('www.alohacampus.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.alohacampus.com', 1, 3) AS "1"
      ,SUBSTRB('www.alohacampus.com', 5, 11) AS "2"
      ,SUBSTRB('www.alohacampus.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTR('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTR('www.알로하캠퍼스.com', 5, 6) AS "2"
      ,SUBSTR('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;

SELECT SUBSTRB('www.알로하캠퍼스.com', 1, 3) AS "1"
      ,SUBSTRB('www.알로하캠퍼스.com', 5, 18) AS "2"
      ,SUBSTRB('www.알로하캠퍼스.com', -3, 3) AS "3"
FROM dual;



--33
SELECT INSTR('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTR('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;

SELECT INSTRB('ALOHACAMPUS', 'A', 1, 1) AS "1번째 A"
      ,INSTRB('ALOHACAMPUS', 'A', 1, 2) AS "2번째 A"
      ,INSTRB('ALOHACAMPUS', 'A', 1, 3) AS "3번째 A"
FROM dual;


--34
SELECT LPAD('ALOHACAMPUS', 20, '#') AS "왼쪽"
      ,RPAD('ALOHACAMPUS', 20, '#') AS "오른쪽" 
FROM dual;


--35
SELECT first_name AS 이름
      ,TO_CHAR(hire_date, 'YYYY-MM-DD (dy) HH:MI:SS') AS 입사일자
FROM employees;


--36
SELECT first_name AS 이름
      ,TO_CHAR(salary, '$999,999,999.00') AS 급여
FROM employees;


--37
SELECT 20210712 AS 문자
      ,TO_DATE(20210712) AS 날짜
FROM dual;

--38
SELECT '1,200,000' AS 문자
      ,TO_NUMBER('1,200,000', '999,999,999') AS 숫자
FROM dual;

--39
SELECT TO_CHAR(sysdate-1, 'YYYY/MM/DD') AS 어제 
      ,TO_CHAR(sysdate, 'YYYY/MM/DD') AS 오늘
      ,TO_CHAR(sysdate+1, 'YYYY/MM/DD') AS 내일 
FROM dual;


--40
SELECT FIRST_NAME 이름
      ,TO_CHAR(hire_date, 'YYYY.MM.DD') 입사일자
      ,TO_CHAR(sysdate, 'YYYY.MM.DD') 오늘
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)) || '개월' 근무달수
      ,TRUNC(MONTHS_BETWEEN(sysdate, hire_date)/12) || '년' 근속연수
FROM employees;


--41
SELECT sysdate 오늘
      ,ADD_MONTHS(sysdate, 6) "6개월후"
FROM dual;

--42
SELECT sysdate 오늘
      ,NEXT_DAY(sysdate, 7) "다음 토요일"
FROM dual;


SELECT '2022/08/01' 오늘
      ,NEXT_DAY('2022/08/01', 7) "다음 토요일"
FROM dual;


--43
SELECT TRUNC(sysdate, 'MM') 월초
      ,sysdate 오늘
      ,LAST_DAY(sysdate) 월말
FROM dual;

SELECT TO_DATE('22/08/15') 오늘
      ,TRUNC(TO_DATE('22/08/15'), 'MM') 월초
      ,LAST_DAY(TO_DATE('22/08/15')) 월말
FROM dual;


--44
SELECT DISTINCT NVL(commission_pct, 0) "커미션(%)"
FROM employees
ORDER BY NVL(commission_pct, 0) DESC
;


--45
SELECT first_name 이름
      ,salary 급여
      ,NVL(commission_pct,0) 커미션
      ,NVL2(commission_pct, salary+(salary*commission_pct), salary) 최종급여
FROM employees
ORDER BY NVL2(commission_pct, salary+(salary*commission_pct), salary) DESC
;

SELECT first_name 이름
      ,salary 급여
      ,NVL(commission_pct,0) 커미션
      ,NVL2(commission_pct, salary+(salary*commission_pct), salary) 최종급여
FROM employees
ORDER BY 최종급여 DESC
;

--46
SELECT * FROM employees;
SELECT first_name 이름
      ,DECODE(department_id, 10, 'Administration'
                             ,20, 'Marketing'
                             ,30, 'Purchasing'
                             ,40, 'Human Resources'
                             ,50, 'Shipping'
                             ,60, 'IT'
                             ,70, 'Public Relations'
                             ,80, 'Sales'
                             ,90, 'Marketing'
                            ,100, 'Finance'
      ) 부서
FROM employees;


--47
SELECT first_name 이름
      ,CASE WHEN department_id=10 THEN 'Administration'
            WHEN department_id=20 THEN 'Marketing'
            WHEN department_id=30 THEN 'Purchasing'
            WHEN department_id=40 THEN 'Human Resources'
            WHEN department_id=50 THEN 'Shipping'
            WHEN department_id=60 THEN 'IT'
            WHEN department_id=70 THEN 'Public Relations'
            WHEN department_id=80 THEN 'Sales'
            WHEN department_id=90 THEN 'Marketing'
            WHEN department_id=100 THEN 'Finance'
       END 부서
FROM employees;



--48
SELECT COUNT(*) 사원수 
FROM employees;

--49
SELECT MAX(salary) 최고급여
      ,MIN(salary) 최저급여
FROM employees;

--50
SELECT SUM(salary) 급여합계
      ,ROUND(AVG(salary),2) 급여평균
FROM employees;

--51
SELECT ROUND(STDDEV(salary), 2) 급여표준편차
      ,ROUND(VARIANCE(salary),2) 급여분산
FROM employees;


--52
DROP TABLE MS_STUDENT;
CREATE TABLE MS_STUDENT(
    ST_NO       NUMBER          NOT NULL    PRIMARY KEY   ,
    NAME        VARCHAR2(20)    NOT NULL    ,
    CTZ_NO      CHAR(14)        NOT NULL    ,
    EMAIL       VARCHAR2(100)   NOT NULL    UNIQUE,
    ADDRESS     VARCHAR2(1000)  NULL    ,
    DEPT_NO     NUMBER  NOT NULL    ,
    MJ_NO       NUMBER  NOT NULL    ,
    REG_DATE    DATE    DEFAULT sysdate NOT NULL     ,
    UPD_DATE    DATE    DEFAULT sysdate NOT NULL     ,
    ETC         VARCHAR2(1000) DEFAULT '없음' NULL    
);

COMMENT ON TABLE MS_STUDENT IS '학생';
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




--53
ALTER TABLE MS_STUDENT DROP COLUMN GENDER;
ALTER TABLE MS_STUDENT DROP COLUMN STATUS;
ALTER TABLE MS_STUDENT DROP COLUMN ADM_DATE;
ALTER TABLE MS_STUDENT DROP COLUMN GRD_DATE;

ALTER TABLE MS_STUDENT ADD GENDER CHAR(6) DEFAULT '기타' NOT NULL ;
COMMENT ON COLUMN MS_STUDENT.GENDER IS '성별';

ALTER TABLE MS_STUDENT ADD STATUS VARCHAR2(10) DEFAULT '대기' NOT NULL ;
COMMENT ON COLUMN MS_STUDENT.STATUS IS '재적';

ALTER TABLE MS_STUDENT ADD ADM_DATE DATE NULL; 
COMMENT ON COLUMN MS_STUDENT.ADM_DATE IS '입학일자';

ALTER TABLE MS_STUDENT ADD GRD_DATE DATE NULL;
COMMENT ON COLUMN MS_STUDENT.GRD_DATE IS '졸업일자';




--54
ALTER TABLE MS_STUDENT RENAME COLUMN CTZ_NO TO BIRTH;
ALTER TABLE MS_STUDENT MODIFY BIRTH DATE;
COMMENT ON COLUMN MS_STUDENT.BIRTH IS '생년월일';


--55
ALTER TABLE MS_STUDENT DROP COLUMN DEPT_NO;


--56
DROP TABLE MS_STUDENT;


--57
CREATE TABLE MS_STUDENT(
    ST_NO       NUMBER          NOT NULL    PRIMARY KEY   ,
    NAME        VARCHAR2(20)    NOT NULL    ,
    BIRTH       DATE        NOT NULL    ,
    EMAIL       VARCHAR2(100)   NOT NULL    UNIQUE,
    ADDRESS     VARCHAR2(1000)  NULL    ,
    MJ_NO       VARCHAR2(10)  NOT NULL    ,
    GENDER      CHAR(6) DEFAULT '기타' NOT NULL    ,
    STATUS      VARCHAR2(10) DEFAULT '대기'    NOT NULL    ,
    ADM_DATE    DATE    NULL    ,
    GRD_DATE    DATE    NULL    ,
    REG_DATE    DATE    DEFAULT sysdate NOT NULL     ,
    UPD_DATE    DATE    DEFAULT sysdate NOT NULL     ,
    ETC         VARCHAR2(1000) DEFAULT '없음' NULL    
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


--58
INSERT INTO MS_STUDENT ( ST_NO,NAME,BIRTH,EMAIL,ADDRESS,GENDER,MJ_NO,STATUS,ADM_DATE,GRD_DATE,REG_DATE,UPD_DATE,ETC )
VALUES ( '20180001', '최서아', '991005', 'csa@univ.ac.kr', '서울', '여', 'I01', '재학', '2018/03/01', NULL, sysdate, sysdate, NULL );

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
SELECT * FROM MS_STUDENT;


--59
UPDATE MS_STUDENT SET ADDRESS = '서울', STATUS = '휴학', UPD_DATE = sysdate WHERE ST_NO = '20160001';
UPDATE MS_STUDENT SET ADDRESS = '서울', STATUS = '졸업', GRD_DATE = '2020/02/20', UPD_DATE = '2020/01/01'  WHERE ST_NO = '20150010';
UPDATE MS_STUDENT SET STATUS = '졸업', GRD_DATE = '2020/02/20', UPD_DATE ='2020/01/01' WHERE ST_NO = '20130007';
UPDATE MS_STUDENT SET STATUS = '퇴학', UPD_DATE = '2013/02/10', ETC = '자진 퇴학' WHERE ST_NO = '20110002';
COMMIT;


--60
DELETE FROM MS_STUDENT WHERE ST_NO = '20110002';
COMMIT;


--61
SELECT * FROM MS_STUDENT;


--62
CREATE TABLE MS_STUDENT_BACK
AS SELECT * FROM MS_STUDENT;


--63
DELETE FROM MS_STUDENT;
COMMIT;


--64
INSERT INTO MS_STUDENT SELECT * FROM MS_STUDENT_BACK;
COMMIT;


--65
ALTER TABLE MS_STUDENT ADD CONSTRAINT MS_STD_GENDER_CHECK CHECK (gender IN ('여','남','기타'));


--66
CREATE TABLE MS_USER ( 
    USER_NO     NUMBER      NOT NULL    PRIMARY KEY ,
    USER_ID     VARCHAR2(100)   NOT NULL UNIQUE ,
    USER_PW     VARCHAR2(200)   NOT NULL    ,
    USER_NAME   VARCHAR2(50)    NOT NULL    ,
    BIRTH   DATE    NOT NULL    ,
    TEL     VARCHAR2(20)    NOT NULL UNIQUE ,
    ADDRESS VARCHAR(200)    NULL    ,
    REG_DATE    DATE    DEFAULT sysdate NOT NULL    ,
    UPD_DATE    DATE    DEFAULT sysdate NOT NULL   
);

COMMENT ON TABLE MS_USER IS '회원';
COMMENT ON COLUMN MS_USER.USER_NO IS '회원정보';
COMMENT ON COLUMN MS_USER.USER_ID IS '아이디';
COMMENT ON COLUMN MS_USER.USER_PW IS '비밀번호';
COMMENT ON COLUMN MS_USER.USER_NAME IS '이름';
COMMENT ON COLUMN MS_USER.BIRTH IS '생년월일';
COMMENT ON COLUMN MS_USER.TEL IS '전화번호';
COMMENT ON COLUMN MS_USER.ADDRESS IS '주소';
COMMENT ON COLUMN MS_USER.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_USER.REG_DATE IS '수정일자';


--67
DROP TABLE MS_BOARD;
CREATE TABLE MS_BOARD (
    BOARD_NO    NUMBER  NOT NULL PRIMARY KEY   ,
    TITLE   VARCHAR2(200) NOT NULL  ,
    CONTENT CLOB    NOT NULL    ,
    WRITER  VARCHAR2(100)   NOT NULL    ,
    HIT   NUMBER  NOT NULL    ,
    LIKE_CNT    NUMBER  NOT NULL    ,
    DEL_YN  CHAR(2) NULL    ,
    DEL_DATE    DATE    NULL    ,
    REG_DATE    DATE    DEFAULT SYSDATE NOT NULL    ,
    UPD_DATE    DATE    DEFAULT SYSDATE NOT NULL    
);

COMMENT ON TABLE MS_BOARD IS '게시판';
COMMENT ON COLUMN MS_BOARD.BOARD_NO IS '제목';
COMMENT ON COLUMN MS_BOARD.TITLE IS '내용';
COMMENT ON COLUMN MS_BOARD.CONTENT IS '작성자';
COMMENT ON COLUMN MS_BOARD.WRITER IS '조회수';
COMMENT ON COLUMN MS_BOARD.HIT IS '좋아요 수';
COMMENT ON COLUMN MS_BOARD.LIKE_CNT IS '삭제여부';
COMMENT ON COLUMN MS_BOARD.DEL_DATE IS '삭제일자';
COMMENT ON COLUMN MS_BOARD.REG_DATE IS '등록일자';
COMMENT ON COLUMN MS_BOARD.UPD_DATE IS '수정이라';


--68
DROP TABLE MS_FILE;
CREATE TABLE MS_FILE (
    FILE_NO NUMBER  NOT NULL    PRIMARY KEY ,
    BOARD_NO    NUMBER  NOT NULL    ,
    FILE_NAME   VARCHAR2(2000)  NOT NULL    ,
    FILE_DATA    BLOB    NOT NULL    ,
    REG_DATE    DATE    DEFAULT SYSDATE NOT NULL    ,
    UPD_DATE    DATE    DEFAULT SYSDATE NOT NULL    
);

COMMENT ON TABLE MS_FILE IS '첨부파일';
COMMENT ON COLUMN MS_FILE.FILE_NO IS '파일번호';
COMMENT ON COLUMN MS_FILE.BOARD_NO IS '글번호';
COMMENT ON COLUMN MS_FILE.FILE_NAME IS '파일명';
COMMENT ON COLUMN MS_FILE.FILE_DATA IS '파일';
COMMENT ON COLUMN MS_FILE.RED_DATE IS '등록일자';
COMMENT ON COLUMN MS_FILE.UPD_DATE IS '수정일자';



--69
CREATE TABLE MS_REPLY (
    REPLY_NO    NUMBER  NOT NULL    PRIMARY KEY ,
    BOARD_NO    NUMBER  NOT NULL    ,
    CONTENT VARCHAR2(2000)  NOT NULL    ,
    WRITER  NUMBER  NOT NULL    ,
    DEL_YN CHAR(2)  DEFAULT 'N' NULL    ,
    DEL_DATE    DATE    NULL    ,
    REG_DATE    DATE    NOT NULL    ,
    UPD_DATE    DATE    NOT NULL 
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





--70
imp userid=modoo/123456 file='C:\alohaoracle\community.dmp' fromuser=modoo touser=modoo
;
--
create directory modoodump as 'C:\alohaoracle';
impdp 'modoo/123456' directory=modoodump dumpfile=community_11g.dmp full=y
impdp 'modoo/123456' directory=modoodump dumpfile=community_12c.dmp full=y




ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
CREATE USER modoo IDENTIFIED BY 123456;
ALTER USER modoo DEFAULT TABLESPACE users;
ALTER USER modoo QUOTA UNLIMITED ON users;
GRANT connect, resource, dba TO modoo;

--71
exp userid=modoo/123456 file='C:\alohaoracle\community.dmp' log='C:\alohaoracle\commnuity.log'
--
expdp modoo/123456 dumpfile=community.dmp log=commnuity.log version=11
expdp modoo/123456 dumpfile=community.dmp log=commnuity.log version=12
;



--72

ALTER TABLE MS_BOARD MODIFY WRITER NUMBER;

ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO);

ALTER TABLE MS_FILE DROP CONSTRAINT MS_FILE_BOARD_NO_FK;
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);

ALTER TABLE MS_REPLY DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO);



--73
ALTER TABLE MS_USER ADD CTZ_NO CHAR(14) NOT NULL UNIQUE;
ALTER TABLE MS_USER ADD GENDER CHAR(6) NOT NULL;

COMMENT ON COLUMN MS_USER.CTZ_NO IS '주민번호';
COMMENT ON COLUMN MS_USER.GENDER IS '성별';


--74
ALTER TABLE MS_USER ADD CONSTRAINT MS_USER_GENDER_CHECK CHECK (GENDER IN ('여','남','기타'));


--75
ALTER TABLE MS_FILE ADD EXT VARCHAR2(10) NOT NULL;
COMMENT ON COLUMN MS_FILE.EXT IS '확장자';




--76
--SELECT * FROM MS_FILE;
--SELECT * FROM MS_BOARD;
--SELECT * FROM MS_USER;
--INSERT INTO MS_USER ( USER_NO, USER_ID, USER_PW, USER_NAME, BIRTH, TEL, ADDRESS, REG_DATE, UPD_DATE, CTZ_NO, GENDER )
--VALUES ( 1, 'ALOHA', '123456', '알로하', '1992/10/07', '010-2009-9072', '인천', SYSDATE, SYSDATE, '921007-1112222', '기타' );

--INSERT INTO MS_BOARD ( BOARD_NO, TITLE, CONTENT, WRITER, HIT, LIKE_CNT, DEL_YN, DEL_DATE, REG_DATE, UPD_DATE )
--VALUES (2, '제목', '내용', 1, 0, 0, 'N', NULL, SYSDATE, SYSDATE );
--INSERT INTO MS_FILE ( FILE_NO, BOARD_NO, FILE_NAME, FILE_DATA, REG_DATE, UPD_DATE, EXT )
--VALUES ( 2, 2, '강아지.png', '123', sysdate, sysdate, 'jpg' );


MERGE INTO MS_FILE T
USING (SELECT FILE_NO, FILE_NAME FROM MS_FILE) F ON (T.FILE_NO = F.FILE_NO)
WHEN MATCHED THEN
    UPDATE SET T.EXT = SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1)+1)
    DELETE WHERE SUBSTR(F.FILE_NAME, INSTR(F.FILE_NAME, '.', -1)+1) NOT IN ('jpeg','jpg','gif','png')
-- WHEN NOT MATCHED THEN
--   [COMMAND] 
;



--77
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_EXT_CHECK CHECK (EXT IN ('jpg','jpeg','gif','png'));



--78
TRUNCATE TABLE MS_USER;
TRUNCATE TABLE MS_BOARD;
TRUNCATE TABLE MS_FILE;
TRUNCATE TABLE MS_REPLY;

--79
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_FILE DROP COLUMN BOARD_NO;
ALTER TABLE MS_REPLY DROP COLUMN BOARD_NO;



--80
ALTER TABLE MS_BOARD DROP COLUMN WRITER;
ALTER TABLE MS_BOARD ADD WRITER NUMBER NOT NULL;


ALTER TABLE MS_BOARD DROP CONSTRAINT MS_BOARD_WRITER_FK;
ALTER TABLE MS_BOARD ADD CONSTRAINT MS_BOARD_WRITER_FK FOREIGN KEY (WRITER) REFERENCES MS_USER(USER_NO)
                                                        ON DELETE CASCADE;
                                                        
ALTER TABLE MS_FILE DROP CONSTRAINT MS_FILE_BOARD_NO_FK;
ALTER TABLE MS_FILE ADD CONSTRAINT MS_FILE_BOARD_NO_FK FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
                                                        ON DELETE CASECADE;

ALTER TABLE MS_REPLY DROP CONSTRAINT MS_REPLY_BOARD_NO_FK;
ALTER TABLE MS_REPLY ADD CONSTRAINT MS_REPLY_BOARD_NO_FK FOREIGN KEY (BOARD_NO) REFERENCES MS_BOARD(BOARD_NO)
                                                        ON DELETE CASECADE;


--81
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,(SELECT DEPT_TITLE FROM DEPARTMENT D WHERE D.DEPT_ID = E.DEPT_CODE) 부서명
      ,(SELECT JOB_NAME FROM JOB J WHERE J.JOB_CODE = E.JOB_CODE) 직급명
FROM EMPLOYEE E;


--82
SELECT E.EMP_ID AS 사원번호
      ,E.EMP_NAME AS 직원명
      ,D.DEPT_TITLE 부서명 
      ,E.SALARY 급여
      ,T.MAX_SAL 최고급여
      ,T.MIN_SAL 최저급여
      ,ROUND(T.AVG_SAL,2) 평균급여
FROM EMPLOYEE E
     LEFT JOIN DEPARTMENT D ON(DEPT_CODE = DEPT_ID),
    ( SELECT DEPT_CODE, MIN(SALARY) MIN_SAL, MAX(SALARY) MAX_SAL, AVG(SALARY) AVG_SAL
      FROM EMPLOYEE
      GROUP BY DEPT_CODE ) T
WHERE E.SALARY IN T.MAX_SAL

;



--83
SELECT EMP_ID AS 사원번호
       ,EMP_NAME AS 직원명
       ,EMAIL AS 이메일
       ,PHONE AS 전화번호
FROM EMPLOYEE
WHERE DEPT_CODE = ( SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '이태림' );
                    



 
--84
SELECT DEPT_ID AS 부서번호
      ,DEPT_TITLE AS 부서명
      ,LOCATION_ID AS 지역명
FROM DEPARTMENT D
WHERE EXISTS ( SELECT * FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID )
ORDER BY D.DEPT_ID;



--85
--1)
SELECT DEPT_ID AS 부서번호
      ,DEPT_TITLE AS 부서명
      ,LOCATION_ID AS 지역명
FROM DEPARTMENT D
WHERE NOT EXISTS ( SELECT * FROM EMPLOYEE E WHERE E.DEPT_CODE = D.DEPT_ID )
ORDER BY D.DEPT_ID;

--2)
SELECT * FROM department 
WHERE dept_id NOT IN (SELECT DISTINCT dept_code FROM employee WHERE dept_code IS NOT NULL);

--86
SELECT E.EMP_ID AS 사원번호
      ,E.EMP_NAME AS 직원명
      ,D.DEPT_ID AS 부서번호
      ,D.DEPT_TITLE AS 부서명
      ,TO_CHAR(E.SALARY, '999,999,999,999') AS 급여
FROM EMPLOYEE E
    ,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
  AND SALARY > ALL ( SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D1' );
  
  
--87
SELECT E.EMP_ID AS 사원번호
      ,E.EMP_NAME AS 직원명
      ,D.DEPT_ID AS 부서번호
      ,D.DEPT_TITLE AS 부서명
      ,TO_CHAR(E.SALARY, '999,999,999,999') AS 급여
FROM EMPLOYEE E
    ,DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID 
  AND SALARY > ANY ( SELECT SALARY FROM EMPLOYEE WHERE DEPT_CODE = 'D9' );


-- 88
SELECT NVL(E.EMP_ID, '(없음) ') AS 사원번호
      ,NVL(E.EMP_NAME, '(없음) ') AS 직원명
      ,NVL(D.DEPT_ID, '(없음') AS 부서번호
      ,NVL(D.DEPT_TITLE, '(없음)') AS 부서명
FROM EMPLOYEE E 
     LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);
     
     
--89
SELECT NVL(E.EMP_ID, '(없음)') AS 사원번호
      ,NVL(E.EMP_NAME, '(없음)') AS 직원명
      ,NVL(D.DEPT_ID, '(없음') AS 부서번호
      ,NVL(D.DEPT_TITLE, '(없음)') AS 부서명
FROM EMPLOYEE E RIGHT JOIN DEPARTMENT D
     ON E.DEPT_CODE = D.DEPT_ID
;


--90
SELECT NVL(E.EMP_ID, '(없음)') AS 사원번호
      ,NVL(E.EMP_NAME, '(없음)') AS 직원명
      ,NVL(D.DEPT_ID, '(없음') AS 부서번호
      ,NVL(D.DEPT_TITLE, '(없음)') AS 부서명
FROM EMPLOYEE E FULL JOIN DEPARTMENT D
     ON E.DEPT_CODE = D.DEPT_ID
;
 
 
     
--91
SELECT E.EMP_ID AS 사원번호 
      ,E.EMP_NAME AS 직원명
      ,D.DEPT_ID AS 부서번호
      ,D.DEPT_TITLE AS 부서명
      ,L.LOCAL_NAME AS 지역명
      ,N.NATIONAL_NAME AS 국가명
      ,E.SALARY AS 급여
      ,E.HIRE_DATE AS 입사일자
FROM EMPLOYEE E 
     LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
     LEFT JOIN LOCATION L ON (D.LOCATION_ID = L.LOCAL_CODE)
     LEFT JOIN NATIONAL N USING (NATIONAL_CODE)
     ;

     
-- 92
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      ,'매니저' AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN(SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL);


-- 93
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      ,'사원'구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
LEFT JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN(SELECT DISTINCT MANAGER_ID
                    FROM EMPLOYEE
                    WHERE MANAGER_ID IS NOT NULL);



--94
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      ,'매니저' AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN(SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      ,'사원'구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN(SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL);





--95
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      ,
    CASE 
    WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                    FROM EMPLOYEE
                    WHERE MANAGER_ID IS NOT NULL)
    THEN '매니저'
    ELSE '사원'
    END AS 구분
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);



--96
SELECT EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      , CASE WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '매니저'
            ELSE '사원' END AS 구분
      , CASE WHEN SUBSTR(EMP_NO, 8, 1) IN ('1', '3') THEN '남자'
             ELSE '여자' END AS 성별
      , EXTRACT(YEAR FROM SYSDATE) 
        - ((CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','2','5','6') THEN '19'
                 WHEN SUBSTR(EMP_NO,8,1) IN ('3','4','7','8') THEN '20'
                 WHEN SUBSTR(EMP_NO,8,1) IN ('9','0') THEN '18' END)
            || SUBSTR(EMP_NO,1,2)) +1  AS 현재나이
      
      , RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*' ) AS 주민등록번호
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);



--97
SELECT ROWNUM AS 순번
      ,EMP_ID AS 사원번호
      ,EMP_NAME AS 직원명
      ,DEPT_TITLE AS 부서명
      ,JOB_NAME AS 직급
      , CASE WHEN EMP_ID IN(SELECT DISTINCT MANAGER_ID
                            FROM EMPLOYEE
                            WHERE MANAGER_ID IS NOT NULL) THEN '매니저'
            ELSE '사원' END AS 구분
      , CASE WHEN SUBSTR(EMP_NO, 8, 1) IN ('1', '3') THEN '남자'
             ELSE '여자' END AS 성별
      , EXTRACT(YEAR FROM SYSDATE) 
        - ((CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','2','5','6') THEN '19'
                 WHEN SUBSTR(EMP_NO,8,1) IN ('3','4','7','8') THEN '20'
                 WHEN SUBSTR(EMP_NO,8,1) IN ('9','0') THEN '18' END)
            || SUBSTR(EMP_NO,1,2)) + 1  AS 현재나이
      , FLOOR(MONTHS_BETWEEN(sysdate, TO_DATE(((CASE WHEN SUBSTR(EMP_NO,8,1) IN ('1','2','5','6') THEN '19'
                 WHEN SUBSTR(EMP_NO,8,1) IN ('3','4','7','8') THEN '20'
                 WHEN SUBSTR(EMP_NO,8,1) IN ('9','0') THEN '18' END)
            || SUBSTR(EMP_NO,1,2)) ||  SUBSTR(EMP_NO,3,2) || SUBSTR(EMP_NO,5,2),'yyyymmdd'))/12) AS 만나이
      
      , EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS 근속년수
      , RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*' ) AS 주민등록번호
      , TO_CHAR(HIRE_DATE, 'YYYY.MM.DD') AS 입사일자
      , TO_CHAR( (SALARY + NVL((SALARY*BONUS),0)) * 12 , '999,999,999,999,999') AS 연봉
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE)
;

--98
DROP VIEW VE_EMP_DEPT;
CREATE VIEW VE_EMP_DEPT
AS 
SELECT E.EMP_ID
      ,E.EMP_NAME
      ,D.DEPT_ID
      ,D.DEPT_TITLE
      ,E.EMAIL
      ,E.PHONE
      ,RPAD(SUBSTR(EMP_NO, 1, 8), 14, '*' ) AS EMP_NO
      ,TO_CHAR(HIRE_DATE, 'YYYY.MM.DD') AS HIRE_DATE
      ,TO_CHAR( SALARY, '999,999,999,999,999' ) AS SALARY
      ,TO_CHAR( (SALARY + NVL((SALARY*BONUS),0)) * 12 , '999,999,999,999,999') AS YR_SALARY
FROM EMPLOYEE E
     LEFT JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID);
     

SELECT * FROM VE_EMP_DEPT;


--99
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


--100
SELECT SEQ_MS_USER.nextval FROM dual;
SELECT SEQ_MS_USER.currval FROM dual;


--101 
DROP SEQUENCE SEQ_MS_USER;
CREATE SEQUENCE SEQ_MS_USER
       START WITH 1
       INCREMENT BY 1
       MAXVALUE 1000000;

--102
INSERT INTO MS_USER ( USER_NO,USER_ID,USER_PW,USER_NAME,BIRTH,TEL,ADDRESS,CTZ_NO,GENDER )
        VALUES (SEQ_MS_USER.nextval, 'ALOHA', '123456', '스무디', '1992/10/07', '01020099072', '서울', '921007-1******', '기타');
;
SELECT * FROM HR.MS_USER WHERE USER_NO = 1;
--DELETE FROM MS_USER;
--COMMIT;

--103
ALTER SEQUENCE SEQ_MS_USER MAXVALUE 100000000;


--104
SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS;

--105
SELECT USER_ID, USER_NAME
FROM HR.MS_USER;

DROP INDEX IDX_MS_USER_NAME;
CREATE INDEX IDX_MS_USER_NAME ON HR.MS_USER(USER_NAME);

SELECT USER_ID, USER_NAME
FROM HR.MS_USER;


--106
--107
--108
--109
--110
--111
