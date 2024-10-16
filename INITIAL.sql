/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/
CREATE SCHEMA IF NOT EXISTS raw_data;

CREATE TABLE IF NOT EXISTS raw_data.sales (
    id INTEGER PRIMARY KEY, /* тип INTEGER, так как поле будет хранить только целые числовые значения, 
    									поле является первичным ключом поэтому обязательно к заполнению */
    auto VARCHAR NOT NULL, /* тип VARCHAR, так как поле совмещает и текстовые символы и числовые, поле обязательно к заполнению */
    gasoline_consumption NUMERIC(3,1), /* тип NUMERIC, так как поле хранит дробные числа 
    									и число не может иметь больше двух знаков до запятой и одного после,
    									так как поле содержит NULL значит к заполнению оно не обязательно */
    price NUMERIC NOT NULL CHECK (price>0), /* тип NUMERIC, так как цена имеет дробное значение, 
    						при этом так как цена указана в долларах и имеет более двух знаков после запятой, 
    						чтобы не потерять точность - лучше не указывать точность и масштаб, 
    						поле обязательно к заполнению, есть смысл добавить проверку на положительную цену */
    date DATE NOT NULL, /* тип DATE, так как поле содержит дату без времени, поле обязательно к заполнению */
    person_name TEXT NOT NULL, /* тип TEXT, так как поле содержит только текстовые символы, поле обязательно к заполнению */
    phone VARCHAR,  /* тип VARCHAR, так как значения в поле могут начинаться с нулей, а числовые типы нули отбрасывают 
    				и так как указание телефона при продаже может быть не обязательным допускаются NULL */
    discount NUMERIC DEFAULT 0, /* тип NUMERIC, так как скидка может иметь дробное значение, 
    					а количество знаков до запятой и после может быть разным, обычно до запятой не более двух, 
    					и после запятой тоже не более двух, но на всякий случай считаю лучше точность и масштаб не указывать,
    					по умолчанию можно поставить 0, так как NULL значений в поле нет */
    brand_origin VARCHAR /* тип VARCHAR, так как поле совмещает и тексовые символы и числовые, содержит NULL */
); 

\copy sales FROM 'C:\Temp\cars.csv' CSV HEADER DELIMITER ',' NULL AS null;
