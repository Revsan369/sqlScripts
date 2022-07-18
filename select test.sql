-- HR스키마를 이용해서 조인과 group by를 포함해서 SELECT 로 검색하는 문제를 10개 만들기
-- GROUP by 결과로도 조인을 할 수 있음. 예시 : 부서 인원이 가장 많은 부서는?


-- 1. JOB_ID 가 같은 직원의 jobs 테이블컬럼, employee 테이블컬럼 조회
SELECT * FROM EMPLOYEES e 
		 JOIN JOBS j 
		 ON e.JOB_ID = j.JOB_ID;
		
-- 2. 부서 테이블과 지점테이블에 공존하는 지점id의 지점id,부서명,해당도시 조회
SELECT l.LOCATION_ID, DEPARTMENT_NAME, CITY
FROM DEPARTMENTS d
JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID;

-- 3. 매니저id가 같은 부서,직원 테이블의 매니저id,지점명,전화번호,업무id 조회
SELECT d.MANAGER_ID, DEPARTMENT_NAME, phone_number, job_id
FROM DEPARTMENTS d, EMPLOYEES e
WHERE d.MANAGER_ID = e.MANAGER_ID;

-- 4. 부서 테이블과 지점테이블에 공존하는 지점id가 1700인 모든 지점id,부서명,해당도시 조회
SELECT l.LOCATION_ID, DEPARTMENT_NAME, CITY
FROM DEPARTMENTS d
JOIN LOCATIONS l
ON d.LOCATION_ID = l.LOCATION_ID AND d.LOCATION_ID = 1700;

-- 5. 직원id의 종료날짜가 '2005-01-01' 이후 인것만 조회
SELECT EMPLOYEE_ID, COUNT(*) 
FROM JOB_HISTORY jh 
WHERE END_DATE >= '2005-01-01'
GROUP BY EMPLOYEE_ID;

-- 6. 급여가 10000이상인 직원이 속한 부서의 매니저ID 조회
SELECT e.MANAGER_ID FROM EMPLOYEES e , DEPARTMENTS d 
WHERE e.MANAGER_ID = d.MANAGER_ID AND SALARY >= 10000;

-- 7. 국가id가 us인것의 지점id 몇개인지 조회
SELECT LOCATION_ID, count(*) cnt 
FROM LOCATIONS l
WHERE COUNTRY_ID = 'US'
GROUP BY LOCATION_ID
ORDER BY cnt;

-- 8. 업무id 별 최대 연봉 조회 (중복제외)
SELECT DISTINCT e.JOB_ID, j.MAX_SALARY FROM EMPLOYEES e , JOBS j 
WHERE e.JOB_ID  = j.JOB_ID;

-- 9. 급여가 10000보다 적고, 고용일이 2006-01-01 전인 직원의 부서ID
SELECT e.DEPARTMENT_ID FROM EMPLOYEES e 
JOIN JOB_HISTORY jh 
ON e.EMPLOYEE_ID = jh.EMPLOYEE_ID 
AND SALARY < 10000 
AND HIRE_DATE <= '2006-01-01';

-- 10. 급여가 10000보다 많고, 고용일이 2003-01-01 이후인 직원의 업무id
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
