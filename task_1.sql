/*добавьте сюда запрос для решения задания 1*/
SELECT
(SELECT 
count(*) AS total
FROM car_shop.sales s
LEFT JOIN car_shop.gasoline_consumptions gc ON gc.id = s.gasoline_consumption_id
WHERE gc.id IS NULL)::real*100
/
(SELECT 
count(*) AS total
FROM car_shop.sales s) AS nulls_percentage_gasoline_consumption;
