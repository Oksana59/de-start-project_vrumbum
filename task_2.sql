/*добавьте сюда запрос для решения задания 2*/
SELECT 
b.brand_name, 
EXTRACT(YEAR FROM s.date) AS year,
ROUND(AVG(s.price), 2) AS price_avg
FROM car_shop.sales s
JOIN car_shop.brands b ON b.id = s.brand_id
GROUP BY b.brand_name, year
ORDER BY b.brand_name, year;
