/*добавьте сюда запрос для решения задания 1*/
SELECT
(SELECT 
count(*) AS total
FROM car_shop.sales
WHERE gasoline_consumption IS NULL)::real*100
/
(SELECT 
count(*) AS total
FROM car_shop.sales s) AS nulls_percentage_gasoline_consumption;
