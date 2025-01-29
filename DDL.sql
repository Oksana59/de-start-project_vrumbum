
CREATE SCHEMA IF NOT EXISTS car_shop;


/* Без таблицы со справочником автомобилей */

-- Создание таблицы стран 
CREATE TABLE IF NOT EXISTS car_shop.brand_country (
	id SERIAL PRIMARY KEY, /* тип SERIAL, так как поле должно заполняться автоинкрементом */
	brand_origin TEXT NOT NULL UNIQUE /* тип TEXT, так как поле содержит только текстовые символы */
	);


-- Создание таблицы брендов
CREATE TABLE IF NOT EXISTS car_shop.brands (
	id SERIAL PRIMARY KEY, /* тип SERIAL, так как поле должно заполняться автоинкрементом */
	brand_name VARCHAR NOT NULL UNIQUE, /* тип VARCHAR, на всякий случай если в названии бренда появится чиловой символ к примеру, поле обязательно к заполнению */
	brand_origin_id INTEGER REFERENCES car_shop.brand_country /* поле является внешней ссылкой на таблицу brand_country */
);

   
-- Создание таблицы моделей
CREATE TABLE IF NOT EXISTS car_shop.models (
	id SERIAL PRIMARY KEY, /* тип SERIAL, так как поле должно заполняться автоинкрементом */
	model_name VARCHAR NOT NULL UNIQUE, /* тип VARCHAR, так как поле содержит и текстовые символы и числовые */
	brand_id INTEGER REFERENCES car_shop.brands, /* поле является внешней ссылкой на таблицу brands */
	gasoline_consumption NUMERIC(3,1) /* тип NUMERIC, так как поле хранит дробные числа 
    									и число не может иметь больше двух знаков до запятой и одного после,
    									так как поле содержит NULL значит к заполнению оно не обязательно */
	
);


-- Создание таблицы цветов
CREATE TABLE IF NOT EXISTS car_shop.colors (
	id SERIAL PRIMARY KEY, /* тип SERIAL, так как поле должно заполняться автоинкрементом */
	color TEXT NOT NULL UNIQUE /* тип TEXT, так как наименование цвета может содержать только текстовые символы */
);


-- Создание таблицы клиентов
CREATE TABLE IF NOT EXISTS car_shop.clients (
	id SERIAL PRIMARY KEY, /* тип SERIAL, так как поле должно заполняться автоинкрементом */
	person_name TEXT NOT NULL UNIQUE, /* тип TEXT, так как поле содержит только текстовые символы, поле обязательно к заполнению */
	phone VARCHAR  /* тип VARCHAR, так как значения в поле могут начинаться с нулей, а числовые типы нули отбрасывают 
    				и так как указание телефона при продаже может быть не обязательным допускаются NULL */
);


-- Создание таблицы фактов (продаж) sales в схеме car_shop
CREATE TABLE IF NOT EXISTS car_shop.sales (
    id SERIAL PRIMARY KEY, /* первичный ключ, тип SERIAL, так как поле должно заполняться автоинкрементом */
    -- auto VARCHAR NOT NULL,  не будет поля, чтобы оно место не занимало
    model_id INTEGER NOT NULL REFERENCES car_shop.models, /* поле является внешней ссылкой на таблицу models */
    color_id INTEGER NOT NULL REFERENCES car_shop.colors, /* поле является внешней ссылкой на таблицу colors */
    price NUMERIC NOT NULL CHECK (price>0), /* тип NUMERIC, так как цена имеет дробное значение, 
    						при этом так как цена указана в долларах и имеет более двух знаков после запятой, 
    						чтобы не потерять точность - лучше не указывать точность и масштаб, 
    						поле обязательно к заполнению, есть смысл добавить проверку на положительную цену */
    date DATE NOT NULL, /* тип DATE, так как поле содержит дату без времени, поле обязательно к заполнению */
    person_name_id INTEGER NOT NULL REFERENCES car_shop.clients, /* поле является внешней ссылкой на таблицу clients */
    discount NUMERIC DEFAULT 0 /* тип NUMERIC, так как скидка может иметь дробное значение, 
    					а количество знаков до запятой и после может быть разным, обычно до запятой не более двух, 
    					и после запятой тоже не более двух, но на всякий случай считаю лучше точность и масштаб не указывать,
    					по умолчанию можно поставить 0, так как NULL значений в поле нет */
); 
