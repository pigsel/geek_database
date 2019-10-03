-- домашнее задание к уроку 7
-- автор »горь Ѕерт€ев

-- “ема У—ложные запросыФ

-- / 1. —оставьте список пользователей users, 
-- которые осуществили хот€ бы один заказ orders в интернет магазине.
SELECT name FROM users WHERE id in (
SELECT user_id FROM orders);


-- / 2. ¬ыведите список товаров products и разделов catalogs, который соответствует товару.
SELECT description, (select name from catalogs where id = catalog_id) FROM products;

-- / 3. (по желанию) ѕусть имеетс€ таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). 
-- ѕол€ from, to и label содержат английские названи€ городов, 
-- поле name Ч русское. ¬ыведите список рейсов flights с русскими названи€ми городов.
SELECT 
(SELECT name FROM cities WHERE cities = `from`),  
(SELECT name FROM cities WHERE cities = `to`)  
FROM flights;

-- после заданий 6го урока эти кажутс€ простыми