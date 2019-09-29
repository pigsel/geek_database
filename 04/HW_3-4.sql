/* 
здесь будут задания и для 3 и для 4 уроков сразу, 
т.к. по сути одно продолжение другого.

кроме того, я не совсем понял что нужно сдавать и в каком виде, 
поэтому выложу сюда выводы из терминала при работе с моей базой данных. 

по сути тут почти то же что и в файле примера, с небольшими коментариями
*/


-- вот результат урока 3 (не раскрываю подробно, т.к. не сохранил вывод терминала): 

mysql> USE vk
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> SHOW TABLES;
+---------------------+
| Tables_in_vk        |
+---------------------+
| communities         |
| communities_users   |
| friendship          |
| friendship_statuses |
| media               |
| media_types         |
| messages            |
| profiles            |
| users               |
+---------------------+
9 rows in set (0.00 sec)

-- заполнить таблицы данными я не смог, 
-- т.к. не совсем понял как сделать копию базы на локальной машине 
-- (с помощью бобра не получилось). 
-- залить эти данные на сервер и оттуда заполнить таблицы тоже пока не разобрался как,
--  но в будущем надеюсь всё это сделать. 

-- далее я проделываю те же операции, что были обсуждены на уроке 4

-- Создаю таблицу регионов
mysql> CREATE TABLE regions (
    ->   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   name VARCHAR(150) NOT NULL,
    ->   parent_id INT unsigned DEFAULT NULL,
    ->   code INT DEFAULT NULL,
    ->   zip INT DEFAULT NULL,
    ->   created_at DATETIME DEFAULT NOW(),
    ->   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
    -> );
Query OK, 0 rows affected (0.11 sec)

-- добавляю регион в профили
mysql> ALTER TABLE profiles ADD COLUMN region_id INT unsigned DEFAULT NULL;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

-- замена  first_name, last_name
mysql> ALTER TABLE users RENAME COLUMN firstname TO first_name;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE users RENAME COLUMN lastname TO last_name;
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0

-- В communities_users нужно поле даты/времени создания строки. 
-- Важно знать когда произошло подписание конкретного пользователя.
mysql> ALTER TABLE communities_users ADD COLUMN created_at DATETIME DEFAULT CURRENT_TIMESTAMP;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0

-- Добавляю emoji
mysql> CREATE TABLE emoji (
    ->   id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ->   name VARCHAR(150) NOT NULL,
    ->   file MEDIUMBLOB NOT NULL,
    ->   PRIMARY KEY (id),
    ->   UNIQUE KEY name (name)
    -> );
Query OK, 0 rows affected (0.12 sec)

-- таблицу постов
mysql> CREATE TABLE posts (
    ->   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   user_id INT UNSIGNED NOT NULL,
    ->   communitie_id INT UNSIGNED NOT NULL,
    ->   title VARCHAR(255) NOT NULL,
    ->   body TEXT NOT NULL,
    ->   important BOOLEAN,
    ->   delivered BOOLEAN,
    ->   created_at DATETIME DEFAULT NOW(),
    ->   updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
    -> );
Query OK, 0 rows affected (0.09 sec)

-- далее про ключи - пока всё понятно по различию таблицы связи и составные ключи

-- создаем таблицы лайков 
mysql> CREATE TABLE likes (
    ->   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   user_id INT UNSIGNED NOT NULL,
    ->   target_id INT UNSIGNED NOT NULL,
    ->   target_type_id INT UNSIGNED NOT NULL,
    ->   created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.09 sec)

mysql> CREATE TABLE target_types (
    ->   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ->   name VARCHAR(255) NOT NULL UNIQUE,
    ->   created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    -> );
Query OK, 0 rows affected (0.11 sec)

-- список имеющихся таблиц
mysql> SHOW TABLES;
+---------------------+
| Tables_in_vk        |
+---------------------+
| communities         |
| communities_users   |
| emoji               |
| friendship          |
| friendship_statuses |
| likes               |
| media               |
| media_types         |
| messages            |
| posts               |
| profiles            |
| regions             |
| target_types        |
| users               |
+---------------------+
14 rows in set (0.00 sec)

-- опять повторю, что как генерировать данные с сайта я разобрался, 
-- но как именно их заливать в базу (и какую) пока не разобрался, как только разберусь - залью. 

-- далее упражнения по CRUD
mysql> DESC target_types;
+------------+------------------+------+-----+-------------------+-------------------+
| Field      | Type             | Null | Key | Default           | Extra             |
+------------+------------------+------+-----+-------------------+-------------------+
| id         | int(10) unsigned | NO   | PRI | NULL              | auto_increment    |
| name       | varchar(255)     | NO   | UNI | NULL              |                   |
| created_at | datetime         | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED |
+------------+------------------+------+-----+-------------------+-------------------+
3 rows in set (0.01 sec)

mysql> INSERT INTO target_types VALUES (1, 'media', NOW());
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM target_types;
+----+-------+---------------------+
| id | name  | created_at          |
+----+-------+---------------------+
|  1 | media | 2019-09-17 20:31:46 |
+----+-------+---------------------+
1 row in set (0.00 sec)

mysql> INSERT INTO target_types (name, created_at) VALUES ('post', NOW());
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM target_types;
+----+-------+---------------------+
| id | name  | created_at          |
+----+-------+---------------------+
|  1 | media | 2019-09-17 20:31:46 |
|  2 | post  | 2019-09-17 20:34:46 |
+----+-------+---------------------+
2 rows in set (0.00 sec)

mysql> INSERT INTO target_types (name) VALUES ('message');
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM target_types;
+----+---------+---------------------+
| id | name    | created_at          |
+----+---------+---------------------+
|  1 | media   | 2019-09-17 20:31:46 |
|  2 | post    | 2019-09-17 20:34:46 |
|  3 | message | 2019-09-17 20:37:41 |
+----+---------+---------------------+
3 rows in set (0.00 sec)

mysql> INSERT INTO target_types SET name = 'community';
Query OK, 1 row affected (0.01 sec)

mysql> SELECT * FROM target_types;
+----+-----------+---------------------+
| id | name      | created_at          |
+----+-----------+---------------------+
|  1 | media     | 2019-09-17 20:31:46 |
|  2 | post      | 2019-09-17 20:34:46 |
|  3 | message   | 2019-09-17 20:37:41 |
|  4 | community | 2019-09-17 20:43:12 |
+----+-----------+---------------------+
4 rows in set (0.00 sec)

mysql> SELECT DISTINCT YEAR(created_at) FROM target_types;
+------------------+
| YEAR(created_at) |
+------------------+
|             2019 |
+------------------+
1 row in set (0.00 sec)

mysql> SELECT created_at, name FROM target_types;
+---------------------+-----------+
| created_at          | name      |
+---------------------+-----------+
| 2019-09-17 20:31:46 | media     |
| 2019-09-17 20:34:46 | post      |
| 2019-09-17 20:37:41 | message   |
| 2019-09-17 20:43:12 | community |
+---------------------+-----------+
4 rows in set (0.00 sec)

mysql> UPDATE target_types SET id = id * 10;
Query OK, 4 rows affected (0.01 sec)
Rows matched: 4  Changed: 4  Warnings: 0

mysql> SELECT * FROM target_types;
+----+-----------+---------------------+
| id | name      | created_at          |
+----+-----------+---------------------+
| 10 | media     | 2019-09-17 20:31:46 |
| 20 | post      | 2019-09-17 20:34:46 |
| 30 | message   | 2019-09-17 20:37:41 |
| 40 | community | 2019-09-17 20:43:12 |
+----+-----------+---------------------+
4 rows in set (0.00 sec)

mysql> TRUNCATE target_types;
Query OK, 0 rows affected (0.17 sec)

mysql> SELECT * FROM target_types;
Empty set (0.00 sec)

mysql> INSERT INTO target_types VALUES (DEFAULT, 'media', NOW());
Query OK, 1 row affected (0.02 sec)

mysql> SELECT * FROM target_types;
+----+-------+---------------------+
| id | name  | created_at          |
+----+-------+---------------------+
|  1 | media | 2019-09-17 21:02:29 |
+----+-------+---------------------+
1 row in set (0.00 sec)

-- на этом пожалуй всё. 
-- спасибо. 













