/*добавьте сюда запрос для решения задания 4*/
SELECT 
c.person_name AS person,
STRING_AGG(CONCAT(b.brand_name, ' ', m.model_name), ', ') AS cars
FROM car_shop.sales s
JOIN car_shop.clients c ON c.id = s.person_name_id
JOIN car_shop.brands b ON b.id = s.brand_id
JOIN car_shop.models m ON m.id = s.model_id 
GROUP BY c.person_name 
ORDER BY c.person_name;
