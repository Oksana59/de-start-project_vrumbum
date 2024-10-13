/*добавьте сюда запрос для решения задания 3*/
SELECT  
EXTRACT(MONTH FROM date) AS month,
EXTRACT(YEAR FROM date) AS year,
ROUND(AVG(price), 2) AS price_avg
FROM car_shop.sales 
WHERE EXTRACT(YEAR FROM date) = 2022
GROUP BY month, year
ORDER BY month, year;
