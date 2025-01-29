/*добавьте сюда запрос для решения задания 5*/
SELECT 
bc.brand_origin,
MAX(s.price/(100-s.discount)*100) AS price_max,
MIN(s.price/(100-s.discount)*100) AS price_min
FROM car_shop.sales s
JOIN car_shop.brand_country bc ON bc.id = s.brand_origin_id 
GROUP BY bc.brand_origin;
