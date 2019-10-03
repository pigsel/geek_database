-- �������� ������� � ����� 7
-- ����� ����� �������

-- ���� �������� ��������

-- / 1. ��������� ������ ������������� users, 
-- ������� ����������� ���� �� ���� ����� orders � �������� ��������.
SELECT name FROM users WHERE id in (
SELECT user_id FROM orders);


-- / 2. �������� ������ ������� products � �������� catalogs, ������� ������������� ������.
SELECT description, (select name from catalogs where id = catalog_id) FROM products;

-- / 3. (�� �������) ����� ������� ������� ������ flights (id, from, to) 
-- � ������� ������� cities (label, name). 
-- ���� from, to � label �������� ���������� �������� �������, 
-- ���� name � �������. �������� ������ ������ flights � �������� ���������� �������.
SELECT 
(SELECT name FROM cities WHERE cities = `from`),  
(SELECT name FROM cities WHERE cities = `to`)  
FROM flights;

-- ����� ������� 6�� ����� ��� ������� ��������