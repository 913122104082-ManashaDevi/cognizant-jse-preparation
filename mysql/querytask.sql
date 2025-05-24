
-- 1
SET @userid = 1;
SELECT * 
FROM Events 
WHERE city = ( SELECT city FROM Users WHERE user_id= @userid) 
AND
status ='upcoming'
AND event_id in 
(SELECT event_id FROM Registration WHERE user_id= @userid)
ORDER BY start_date ASC;
-- 2
SELECT * 
FROM Events
 WHERE event_id in
  (SELECT event_id FROM Feedback 
  GROUP BY event_id 
  HAVING COUNT(*)>=1 AND 
  AVG(rating)=(SELECT AVG(rating) FROM Feedback) ;

--3
SELECT * FROM users 
WHERE user_id IN 
(SELECT user_id FROM registration 
WHERE DATEDIFF('2025-08-01',registration_date)>=90) 
OR user_id NOT IN (SELECT user_id FROM registration );

--4
SELECT  e.event_id ,e.title, s.NO_OF_SESSION
FROM events e JOIN (SELECT event_id,COUNT(*) AS NO_OF_SESSION 
FROM sessions 
WHERE TIME(start_time)>='10:00:00' AND TIME(end_time)<='12:00:00' GROUP BY event_id
) s ON e.event_id =s.event_id ;

--5
SELECT city , COUNT(user_id) AS user_count
FROM users 
WHERE user_id IN (SELECT user_id FROM registration) 
GROUP BY city 
 ORDER BY COUNT(user_id) DESC LIMIT 5;

--6
SELECT e.event_id, e.title, r.NO_OF_RESOURCE 
 FROM events e LEFT OUTER JOIN
  (SELECT event_id,COUNT(*) AS NO_OF_RESOURCE 
  FROM resources  GROUP BY event_id) r
    ON e.event_id=r.event_id;

--10
SELECT e.event_id , e.title 
FROM events e 
WHERE e.event_id IN (SELECT event_id FROM registration) 
AND e.event_id NOT IN (SELECT event_id FROM feedback)  ;

--11
SELECT  registration_date,
COUNT(DISTINCT user_id )
FROM registration 
WHERE registration_date>=(CURRENT_DATE-INTERVAL 7 DAY)
GROUP BY registration_date ;

--14
SELECT event_id,COUNT(registration_id)
FROM registration 
GROUP BY event_id LIMIT 3;

--16

SELECT * FROM users
 WHERE registration_date >= (CURRENT_DATE- INTERVAL 30 DAY)
  AND user_id NOT IN
 (SELECT user_id FROM Registration);

--21
SELECT user_id,COUNT(feedback_id) AS FBCOUNT 
FROM feedback
 GROUP BY user_id 
ORDER BY COUNT(feedback_id) DESC LIMIT 5;

--25
SELECT event_id,title
 FROM events 
 WHERE event_id NOT IN 
(SELECT event_id FROM sessions);