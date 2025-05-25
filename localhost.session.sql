SELECT event_id,
AVG(TIMESTAMPDIFF(MINUTE,start_time,end_time)) AS avg_time_in_minutes
FROM sessions s
GROUP BY event_id
ORDER BY event_id;