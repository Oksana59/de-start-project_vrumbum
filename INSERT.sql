/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/
INSERT INTO car_shop.auto (id, auto, gasoline_consumption, brand_origin, brand_name, model_name, color)
SELECT DISTINCT
id,
auto,
gasoline_consumption,
brand_origin,
SPLIT_PART(auto, ' ', 1) AS brand_name,
SPLIT_PART(SPLIT_PART(auto, ',', -2), ' ', -1) AS model_name,
SPLIT_PART(auto, ',', -1) AS color
FROM raw_data.sales;


INSERT INTO car_shop.brand_country (brand_origin)
SELECT DISTINCT 
brand_origin
FROM car_shop.auto
WHERE brand_origin IS NOT NULL;


INSERT INTO car_shop.clients (person_name, phone)
SELECT DISTINCT 
person_name, 
phone
FROM raw_data.sales;


INSERT INTO car_shop.brands (brand_name)
SELECT DISTINCT
brand_name
FROM car_shop.auto
WHERE brand_name IS NOT NULL; -- на всякий случай если появятся пустые


INSERT INTO car_shop.models (model_name)
SELECT DISTINCT 
model_name
FROM car_shop.auto
WHERE model_name IS NOT NULL; -- на всякий случай если появятся пустые


INSERT INTO car_shop.colors (color)
SELECT DISTINCT
color
FROM car_shop.auto
WHERE color IS NOT NULL; -- на всякий случай если появятся пустые


INSERT INTO car_shop.gasoline_consumptions (gasoline_consumption)
SELECT DISTINCT 
gasoline_consumption
FROM car_shop.auto
WHERE gasoline_consumption IS NOT NULL;


INSERT INTO car_shop.sales
SELECT 
s.id,
a.id,
b.id, 
m.id,
c.id, 
gc.id,
s.price,
s.date,
cl.id,
s.discount,
bc.id
FROM raw_data.sales s
INNER JOIN car_shop.auto a ON a.id = s.id
LEFT JOIN car_shop.brands b ON b.brand_name = a.brand_name
LEFT JOIN car_shop.models m ON m.model_name = a.model_name
LEFT JOIN car_shop.colors c ON c.color = a.color
LEFT JOIN car_shop.gasoline_consumptions gc ON gc.gasoline_consumption = s.gasoline_consumption 
LEFT JOIN car_shop.brand_country bc ON bc.brand_origin = s.brand_origin 
LEFT JOIN car_shop.clients cl ON cl.person_name = s.person_name;
