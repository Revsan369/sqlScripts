-- HR��Ű���� �̿��ؼ� ���ΰ� group by�� �����ؼ� SELECT �� �˻��ϴ� ������ 10�� �����
-- GROUP by ����ε� ������ �� �� ����. ���� : �μ� �ο��� ���� ���� �μ���?


-- 1. JOB_ID �� ���� ������ jobs ���̺��÷�, employee ���̺��÷� ��ȸ
SELECT * FROM EMPLOYEES e 
		 JOIN JOBS j 
		 ON e.JOB_ID = j.JOB_ID;
		
-- 2. �μ� ���̺�� �������̺� �����ϴ� ����id�� ����id,�μ���,�ش絵�� ��ȸ
SELECT l.LOCATION_ID, DEPARTMENT_NAME, CITY
FROM DEPARTMENTS d
JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID;

-- 3. �Ŵ���id�� ���� �μ�,���� ���̺��� �Ŵ���id,������,��ȭ��ȣ,����id ��ȸ
SELECT d.MANAGER_ID, DEPARTMENT_NAME, phone_number, job_id
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.MANAGER_ID = e.MANAGER_ID;

-- 4. �μ� ���̺�� �������̺� �����ϴ� ����id�� 1700�� ��� ����id,�μ���,�ش絵�� ��ȸ
SELECT l.LOCATION_ID, DEPARTMENT_NAME, CITY
FROM DEPARTMENTS d
JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID AND d.LOCATION_ID = 1700;

-- 5. ����id�� ���ᳯ¥�� '2005-01-01' ���� �ΰ͸� ��ȸ
SELECT EMPLOYEE_ID, COUNT(*) 
FROM JOB_HISTORY jh 
WHERE END_DATE >= '2005-01-01'
GROUP BY EMPLOYEE_ID;

-- 6. �޿��� 10000�̻��� ������ ���� �μ��� �Ŵ���ID ��ȸ
SELECT e.MANAGER_ID FROM EMPLOYEES e , DEPARTMENTS d 
WHERE e.MANAGER_ID = d.MANAGER_ID AND SALARY >= 10000;

-- 7. ����id�� us�ΰ��� ����id ����� ��ȸ
SELECT LOCATION_ID, count(*) cnt 
FROM LOCATIONS l
WHERE COUNTRY_ID = 'US'
GROUP BY LOCATION_ID
ORDER BY cnt;

-- 8. ����id �� �ִ� ���� ��ȸ (�ߺ�����)
SELECT DISTINCT e.JOB_ID, j.MAX_SALARY FROM EMPLOYEES e , JOBS j 
WHERE e.JOB_ID  = j.JOB_ID;

-- 9. �޿��� 10000���� ����, ������� 2006-01-01 ���� ������ �μ�ID
SELECT e.DEPARTMENT_ID FROM EMPLOYEES e 
JOIN JOB_HISTORY jh 
ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID 
AND SALARY < 10000 
AND HIRE_DATE <= '2006-01-01';

-- 10. �޿��� 10000���� ����, ������� 2003-01-01 ������ ������ ����id
SELECT e.JOB_ID FROM EMPLOYEES e 
JOIN JOB_HISTORY jh 
ON e.JOB_ID = jh.JOB_ID
AND SALARY > 10000 
AND HIRE_DATE > '2003-01-01';

SELECT department_ID, AVG(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID ; 

SELECT * FROM  DEPARTMENTS d JOIN 
(SELECT DEPARTMENT_ID , AVG(salary) FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID  = tavg.department_ID; 

SELECT d.department_id , d.department_Name, ROUND(tavg.cavg,1)FROM DEPARTMENTS d 
JOIN
(SELECT DEPARTMENT_ID avg(salary) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
ON d.DEPARTMENT_ID = tavg.department_ID
ORDER BY tavg.cavg DESC 
FETCH FIRST 1 ROWS ONLY;

SELECT * FROM 
	(SELECT rownum rn,tcnt.*FROM
		(SELECT department_ID, COUNT(*) cnt FROM EMPLOYEES e
GROUP BY DEPARTMENT_ID ORDER BY cnt DESC) tcnt)
WHERE rn BETWEEN 5 AND 9 ;
