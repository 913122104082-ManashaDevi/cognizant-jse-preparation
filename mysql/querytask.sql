
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

--7
SELECT u.user_id,u.full_name,e.event_id,e.title,f.comments FROM users u
JOIN  events e
JOIN  feedback f
ON u.user_id=f.user_id AND f.event_id=e.event_id 
WHERE f.rating<3
;

--8
SELECT e.event_id , e.title ,s.totalses FROM events e 
JOIN (SELECT event_id,COUNT(*) as totalses FROM sessions
       GROUP BY (event_id)) s 
ON e.event_id=s.event_id 
WHERE e.status='upcoming';

--9
SELECT organizer_id,count(*) as NO_OF_EVENT,status 
FROM events
GROUP BY organizer_id,status;

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

--12
SELECT s.event_id,COUNT(*) AS SessionsCount FROM sessions s
GROUP BY event_id HAVING COUNT(*)=(SELECT  MAX(CNT) FROM
 ( SELECT COUNT(*) AS CNT FROM sessions GROUP BY event_id)AS sub);

--13
SELECT city , AVG(f.rating) FROM Events e 
JOIN feedback f 
on e.event_id=f.event_id
GROUP BY city;

--14
SELECT event_id,COUNT(registration_id)
FROM registration 
GROUP
 BY event_id LIMIT 3;

--15
SELECT s1.event_id,s1.session_id,s1.start_time,s2.end_time,
       s2.session_id,s2.start_time,s2.end_time
FROM sessions s1
JOIN sessions s2
on s1.event_id=s2.event_id 
AND s1.session_id  <s2.session_id
AND s1.end_time> s2.start_time AND s2.end_time >s1.start_time;

--16

SELECT * FROM users
 WHERE registration_date >= (CURRENT_DATE- INTERVAL 30 DAY)
  AND user_id NOT IN
 (SELECT user_id FROM Registration);

--17
SELECT speaker_name, COUNT(*) FROM sessions
    GROUP BY speaker_name
    HAVING  count(*)>1;

--18
SELECT event_id ,title FROM events WHERE
 event_id NOT IN 
 (SELECT event_id from resources);

--19
SELECT e.event_id,r.totalreg,f.rate FROM events e 
JOIN (SELECT event_id,COUNT(*) as totalreg FROM registration
       GROUP BY (event_id)) r 
JOIN (SELECT event_id, AVG(rating) as rate FROM feedback
       GROUP BY (event_id)) f 
ON e.event_id=r.event_id AND e.event_id=f.event_id 
WHERE e.status='completed';

--20
SELECT u.user_id ,
Count(DISTINCT r.event_id) as attended,
COUNT( DISTINCT f.feedback_id) submitted
FROM Users u 
LEFT JOIN registration r ON r.user_id=u.user_id
LEFT JOIN (SELECT event_id FROM events WHERE status='completed')e 
ON r.event_id=e.event_id 
LEFT JOIN Feedback f ON f.user_id=u.user_id
GROUP BY u.user_id ;


--21
SELECT user_id,COUNT(feedback_id) AS FBCOUNT 
FROM feedback
 GROUP BY user_id 
ORDER BY COUNT(feedback_id) DESC LIMIT 5;

--22
SELECT user_id,event_id FROM Registration
 GROUP BY event_id,user_id HAVING COUNT(*)>1 ;

--23
SELECT MONTH(registration_date)AS MONTH,COUNT(*) AS registration_count
FROM registration
WHERE TIMESTAMPDIFF(DAY,registration_date,CURRENT_DATE)<=365
GROUP BY MONTH(registration_date)
ORDER BY MONTH(registration_date) ; 

--24
SELECT event_id,
AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time)) AS avg_time_in_minutes
FROM sessions s
GROUP BY event_id
ORDER BY event_id;

--25
SELECT event_id,title
 FROM events 
 WHERE event_id NOT IN 
(SELECT event_id FROM sessions);