SELECT s.event_id,COUNT(*) AS SessionsCount FROM sessions s
GROUP BY event_id HAVING COUNT(*)=(SELECT  MAX(CNT) FROM
 ( SELECT COUNT(*) AS CNT FROM sessions GROUP BY event_id)AS sub);
