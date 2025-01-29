
-- Наполнение таблицы стран
INSERT INTO car_shop.brand_country (brand_origin)
SELECT DISTINCT 
brand_origin
FROM raw_data.sales
WHERE brand_origin IS NOT NULL;


-- Наполнение таблицы брендов
INSERT INTO car_shop.brands (brand_name, brand_origin_id)
SELECT 
s.brand_name, 
bc.id
FROM (
	SELECT DISTINCT
	SPLIT_PART(auto, ' ', 1) AS brand_name,
	CASE WHEN brand_name = 'Porsche' THEN 'Germany' ELSE brand_origin END AS brand_origin
	FROM raw_data.sales 
	) s
LEFT JOIN car_shop.brand_country bc ON bc.brand_origin = s.brand_origin


-- Наполнение таблицы моделей
INSERT INTO car_shop.models (model_name, brand_id, gasoline_consumption)
SELECT 
s.model_name, 
b.id, 
s.gasoline_consumption
FROM (
	SELECT DISTINCT
	SUBSTR(SPLIT_PART(auto, ',', -2), STRPOS(auto, ' ')) AS model_name,
	SPLIT_PART(auto, ' ', 1) AS brand_name,
	gasoline_consumption
	FROM raw_data.sales
	) s
LEFT JOIN car_shop.brands b ON b.brand_name = s.brand_name;


-- Наполнение таблицы цветов
INSERT INTO car_shop.colors (color)
SELECT DISTINCT
SPLIT_PART(auto, ',', -1) AS color
FROM raw_data.sales s;


-- Наполнение таблицы клиентов
INSERT INTO car_shop.clients (person_name, phone)
SELECT DISTINCT 
person_name, 
phone
FROM raw_data.sales;


-- Наполнение таблицы продаж
INSERT INTO car_shop.sales (model_id, color_id, price, date, person_name_id, discount)
SELECT 
m.id,
c.id,
s.price,
s.date,
cl.id,
s.discount
FROM (
	SELECT 
	SUBSTR(SPLIT_PART(auto, ',', -2), STRPOS(auto, ' ')) AS model_name,
	SPLIT_PART(auto, ',', -1) AS color,
	price,
	date,
	person_name,
	discount
	FROM raw_data.sales 
	) s
LEFT JOIN car_shop.models m ON m.model_name = s.model_name
LEFT JOIN car_shop.colors c ON c.color = s.color
LEFT JOIN car_shop.clients cl ON cl.person_name = s.person_name;



