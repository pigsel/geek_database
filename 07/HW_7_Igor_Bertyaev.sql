-- �������� ������� � ����� 7
-- ����� ����� �������

-- ���� �������� �������� 
-- Updated ! - ��������� ������ join

-- / 1. ��������� ������ ������������� users, 
-- ������� ����������� ���� �� ���� ����� orders � �������� ��������.
SELECT name FROM users WHERE id in (
SELECT user_id FROM orders);

-- ������ � join
SELECT users.name
  FROM users
    JOIN orders
  ON users.id = orders.user_id;


-- / 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
SELECT name, (select name from catalogs where id = catalog_id) as catalog_name FROM products;

-- ������ � join
SELECT products.name as product_name, catalogs.name as catalog_name
  FROM products
    JOIN catalogs
  ON products.catalog_id = catalogs.id;



-- / 3. (�� �������) ����� ������� ������� ������ flights (id, from, to) 
-- � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, 
-- ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.
SELECT 
(SELECT name FROM cities WHERE cities = `from`) as FROM_,  
(SELECT name FROM cities WHERE cities = `to`) as TO_
FROM flights;

-- ������ � join
SELECT c1.name as name_from, c2.name as name_to
  FROM flights
    JOIN cities c1
     ON flights.from = c1.cities
    JOIN cities c2
     ON flights.to = c2.cities;

-- �����