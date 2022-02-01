--1.  Display all the information of the EMP table?

SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno, branchno
FROM
 emp;

####################################################

--2.  Display unique Jobs from EMP table?
SELECT
    DISTINCT job
FROM
    emp;
    
####################################################

--3.  List the emps in the asc order of their Salaries?
SELECT
    empno, ename, sal
FROM 
    emp
ORDER BY
    sal;
    
####################################################

--4. List the details of the emps in asc order of the Dptnos and desc of Jobs?
SELECT 
    empno, ename, job, sal, deptno
FROM
    emp
ORDER BY
    deptno ASC,  
    job DESC;
    
####################################################

--5.  Display all the unique job groups in the descending order?
SELECT 
     DISTINCT job
FROM 
    emp
ORDER BY
    job DESC;
    
####################################################

--6.  Display all the details of all ‘Mgrs’

SELECT
    empno, ename, job
FROM 
    emp
WHERE 
    job='MANAGER';

####################################################

--7.  List the emps who joined before 1981

SELECT 
    empno, ename, hiredate
FROM
    emp
WHERE 
    hiredate < '01-01-1981';

####################################################

--8.  List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal

SELECT 
    empno, ename, sal, ROUND (sal/30) as dailysal , sal*12 as annsal
from 
    emp
ORDER BY
    annsal;

####################################################

--9.  Display the Empno, Ename, job, Hiredate, Exp of all Mgrs
--SELECT 
--    empno, ename, job, hiredate('01-01-80')- hiredate(CURRENT_DATE)
--from 
--emp;

SELECT 
    empno, ename, job, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,hiredate),2) as exp
FROM
    emp
WHERE
    empno 
IN
    (
        SELECT
            mgr
        FROM
            emp
    );
    
####################################################

--10.  List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369

SELECT 
    empno, ename, sal, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE,hiredate),2) as exp, 
FROM
    emp
WHERE
    mgr = 7369;