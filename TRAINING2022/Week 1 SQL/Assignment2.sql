--1.  Display all the information of the EMP table?

SELECT
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno,
    branchno
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
    
    
####################################################

--11. Display all the details of the emps whose Comm  Is more than their Sal
SELECT 
    empno, ename, job, mgr, hiredate, sal, comm, deptno, branchno
FROM
    emp
WHERE 
    comm>sal;
    
####################################################

--12. List the emps along with their Exp and Daily Sal is more than Rs 100
SELECT 
    empno, ename, job, sal, sal/30
FROM
    emp
WHERE 
    sal/30>100;


####################################################

--13.  List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order
SELECT * 
    FROM emp
WHERE 
    job = 'CLERK' 
OR
    job = 'ANALYST'
ORDER BY
    job desc;
    
 ####################################################   
--14.  List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN-80 in asc order of seniority

SELECT 
    empno, ename, hiredate
FROM 
    emp
WHERE 
    hiredate in ('01-MAY-81','3-DEC-81','17-DEC-81','19-JAN-80')
ORDER BY 
    hiredate desc;

####################################################   

--15.  List the emp who are working for the Deptno 10 or20

SELECT
    empno,
    ename,
    deptno,
    job
FROM
    emp
WHERE
    deptno = 10
    OR 
    deptno = 20
ORDER BY
    deptno;
    
####################################################   

--16.  List the emps who are joined in the year 81
SELECT
    empno,
    ename,
    hiredate
FROM 
    emp
WHERE 
    hiredate 
    BETWEEN 
    '1-JAN-81' 
    and 
    '31-DEC-81'
ORDER BY
    hiredate;
    
####################################################   

--17.  List the emps Who Annual sal ranging from 22000 and 45000
 SELECT
    empno,
    ename,
    sal,
    sal*12
FROM 
    emp
WHERE 
    sal*12 BETWEEN 
    22000 
    and
    45000
ORDER BY
    sal*12
    
####################################################   

--17.  List the Enames those are having five characters in their Names
SELECT 
    empno, ename 
FROM 
    emp
WHERE
    LENGTH(ename)= 5;
    
####################################################   

--18.  List the Enames those are starting with ‘S’ and with five characters
SELECT
    empno,
    ename
FROM 
    emp 
WHERE 
    ename like 'S%' 
    and 
    length(ename) = 5;
    
####################################################   

--18. List the emps those are having four chars and third character must be ‘r’

SELECT 
    *
FROM 
    emp
WHERE 
    length(ename)= 4 
    and 
    ename like '__R%';

    
####################################################   

--19.  List the Five character names starting with ‘S’ and ending with ‘H’

SELECT 
    ename 
from 
    emp
WHERE
    length(ename)= 5 
    and 
    ename like 'S_%_H' 
    
####################################################   

--20.  List the emps who joined in January

SELECT 
    empno, ename, hiredate 
FROM 
    emp
WHERE 
    to_char(hiredate,'MON')='JAN';
    
####################################################   

--21.  List the emps whose names having a character set ‘ll’ together
 
SELECT 
    empno, ename
FROM 
    emp
WHERE 
    ename like '%_LL_%';
    
    
####################################################    
--22. List the emps who does not belong to Deptno 20
    
SELECT 
    ename, empno, job, deptno
FROM 
    emp
WHERE 
    deptno != 20
ORDER BY 
deptno;

SELECT 
    ename, empno, job, deptno
FROM 
    emp
WHERE 
    deptno <> 20

SELECT 
    ename, empno, job, deptno
FROM 
    emp
WHERE 
    deptno NOT IN 20
    
    
####################################################    
--23.  List all the emps except ‘PRESIDENT’ & ‘MGR” in asc order of Salaries

SELECT 
    empno, ename, job, sal
FROM
    emp
WHERE
    job NOT IN ('PRESIDENT','MANAGER')
ORDER BY
    sal asc;

####################################################    
--24.  List the emps whose Empno not starting with digit78
SELECT 
    empno, ename
FROM
    emp
WHERE 
    empno NOT LIKE '%78'
ORDER BY
    empno;
    
####################################################    
--25.  List the emps who are working under ‘MGR’
--SELECT 
--    empno, ename, job
--FROM
--    emp
--WHERE 
--    job = 'MANAGER'

SELECT
    e.ename, m.ename as MANAGER
FROM
    emp e, emp m
WHERE
    e.mgr = m.empno;

####################################################    
--26.  List the emps who joined in any year but not belongs to the month of March

SELECT 
    ename, hiredate
FROM
    emp
WHERE 
    to_char(hiredate,'MON')!= 'MAR'
ORDER BY
    ename;
    
####################################################    
--26.  List all the Clerks of Deptno 20

SELECT 
    empno, ename, job, deptno 
FROM
    emp
WHERE 
    deptno = 20 and job = 'CLERK';
    
####################################################    
--26. List the emps of Deptno 30 or 10 joined in the year 1981

SELECT 
    empno, ename, deptno, hiredate
FROM 
    emp
WHERE 
    to_char(hiredate, 'YYYY') IN '1981'
    AND
    deptno = 30 
    OR
    deptno = 10
ORDER BY
    deptno

####################################################    
--27.  Display the details of SMITH

SELECT
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno,
    branchno
FROM 
    emp
WHERE
    ename = 'SMITH'
