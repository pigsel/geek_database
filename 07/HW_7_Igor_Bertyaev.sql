-- домашнее задание к уроку 7
-- автор »горь Ѕерт€ев

-- “ема У—ложные запросыФ 
-- Updated ! - добавлены версии join

-- / 1. —оставьте список пользователей users, 
-- которые осуществили хот€ бы один заказ orders в интернет магазине.
SELECT name FROM users WHERE id in (
SELECT user_id FROM orders);

-- верси€ с join
SELECT users.name
  FROM users
    JOIN orders
  ON users.id = orders.user_id;


-- / 2. ¬ыведите список товаров products и разделов catalogs, который соответствует товару.
SELECT name, (select name from catalogs where id = catalog_id) as catalog_name FROM products;

-- верси€ с join
SELECT products.name as product_name, catalogs.name as catalog_name
  FROM products
    JOIN catalogs
  ON products.catalog_id = catalogs.id;



-- / 3. (по желанию) ѕусть имеетс€ таблица рейсов flights (id, from, to) 
-- и таблица городов cities (label, name). 
-- ѕол€ from, to и label содержат английские названи€ городов, 
-- поле name Ч русское. ¬ыведите список рейсов flights с русскими названи€ми городов.
SELECT 
(SELECT name FROM cities WHERE cities = `from`) as FROM_,  
(SELECT name FROM cities WHERE cities = `to`) as TO_
FROM flights;

-- верси€ с join
SELECT c1.name as name_from, c2.name as name_to
  FROM flights
    JOIN cities c1
     ON flights.from = c1.cities
    JOIN cities c2
     ON flights.to = c2.cities;

-- конец