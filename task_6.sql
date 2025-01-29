/*добавьте сюда запрос для решения задания 6*/
SELECT 
COUNT(DISTINCT person_name) AS persons_from_usa_count
FROM car_shop.clients
WHERE phone LIKE '+1%';
