/*добавьте сюда запрос для решения задания 6*/
SELECT 
COUNT(DISTINCT c.person_name) AS persons_from_usa_count
FROM car_shop.sales s 
JOIN car_shop.clients c ON c.id = s.person_name_id 
WHERE c.phone LIKE '+1%';
