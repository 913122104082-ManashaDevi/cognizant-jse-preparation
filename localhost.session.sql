SELECT event_id ,title FROM events WHERE
 event_id NOT IN 
 (SELECT event_id from resources);