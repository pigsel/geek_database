-- домашнее задание к уроку 6
-- автор - Игорь Бертяев

-- Практическое задание 
-- Работаем с БД vk и тестовыми данными, которые сгененрировали ранее:

-- 1/ Проанализировать запросы, которые выполнялись на занятии, 
-- определить возможные корректировки и/или улучшения (JOIN пока не применять).
проанализировал, пока в целом понятно, кроме некоторых особенностей, 
но надеюсь со временем доразобраться


-- 2/ Пусть задан некоторый пользователь.
-- Из всех друзей этого пользователя найдите человека, 
-- который больше всех общался с нашим пользоваетелем.

-- сделал так будто нам задано имя 
-- (friendship status_id у меня сделано 0 = дружба, 1 = нет)

SELECT (SELECT CONCAT(firstname, ' ', lastname) 
      FROM users 
      WHERE id = to_user_id) AS friend, COUNT(*) as 'messages'
  FROM messages WHERE from_user_id = (
	SELECT id from users WHERE firstname = 'Christine' and lastname = 'Quitzon')
      AND to_user_id IN (
        SELECT friend_id from friendship WHERE user_id = (
		  SELECT id from users WHERE firstname = 'Christine' and lastname = 'Quitzon')
		    and status_id = 0
		UNION 
		SELECT user_id from friendship WHERE friend_id = (
		  SELECT id from users WHERE firstname = 'Christine' and lastname = 'Quitzon')
		    and status_id = 0
      )
GROUP by to_user_id
LIMIT 1
;


-- 3/ Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.
-- тут два варианта сделал - с выводом имен и количества, 
-- и просто общую сумму (в один вывод и то и то не удалось сделать)
-- (я посчитал лайки которые не получили а поставили пользователи похоже,
-- чтобы посчитать тех кто получил нужно сложнее разбираться в авторстве тех чьи вещи залайканы. 
-- но к сожалению уже не успеваю переделать)

-- вариант 1
SELECT (SELECT CONCAT(firstname, ' ', lastname) 
       FROM users 
       WHERE user_id = id) AS 'user',
       COUNT(*) as 'likes' FROM likes
         WHERE user_id IN (
          SELECT id from users ORDER BY (SELECT birthday FROM profiles WHERE id = user_id) DESC)
GROUP by user_id
limit 10
;

-- вариант 2 - тут не понял зачем в конце еще раз as su, если она есть в начале, 
-- но без нее не работает почемуто
SELECT sum(likes) as su FROM (
SELECT COUNT(*) as likes FROM likes
         WHERE user_id IN (
          SELECT id from users ORDER BY (SELECT birthday FROM profiles WHERE id = user_id) DESC)
GROUP by user_id
limit 10) as su;


-- 4/ Определить кто больше поставил лайков (всего) - мужчины или женщины?
select 'women' as 'sex', count(user_id) as li
from likes where user_id in (
select user_id from profiles WHERE sex = 'W')
UNION
select 'men' as 'sex', count(user_id) as li
from likes where user_id in (
select user_id from profiles WHERE sex = 'M')
UNION
select 'total' as 'sex', count(user_id) as li
from likes;


-- 5/ Найти 10 пользователей, которые проявляют наименьшую активность
--  в использовании социальной сети.
-- сделал самый простой вариант по количеству постов
SELECT (SELECT CONCAT(firstname, ' ', lastname) 
        FROM users 
        WHERE user_id = id) as users, count(*) as activity
from posts
GROUP BY user_id order by activity
limit 10;

-- конец