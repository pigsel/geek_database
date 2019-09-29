-- �������� ������� � ����� 6
-- ����� - ����� �������

-- ������������ ������� 
-- �������� � �� vk � ��������� �������, ������� �������������� �����:

-- 1/ ���������������� �������, ������� ����������� �� �������, 
-- ���������� ��������� ������������� �/��� ��������� (JOIN ���� �� ���������).
���������������, ���� � ����� �������, ����� ��������� ������������, 
�� ������� �� �������� �������������


-- 2/ ����� ����� ��������� ������������.
-- �� ���� ������ ����� ������������ ������� ��������, 
-- ������� ������ ���� ������� � ����� ��������������.

-- ������ ��� ����� ��� ������ ��� 
-- (friendship status_id � ���� ������� 0 = ������, 1 = ���)

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


-- 3/ ���������� ����� ���������� ������, ������� �������� 10 ����� ������� �������������.
-- ��� ��� �������� ������ - � ������� ���� � ����������, 
-- � ������ ����� ����� (� ���� ����� � �� � �� �� ������� �������)
-- (� �������� ����� ������� �� �������� � ��������� ������������ ������,
-- ����� ��������� ��� ��� ������� ����� ������� ����������� � ��������� ��� ��� ���� ���������. 
-- �� � ��������� ��� �� ������� ����������)

-- ������� 1
SELECT (SELECT CONCAT(firstname, ' ', lastname) 
       FROM users 
       WHERE user_id = id) AS 'user',
       COUNT(*) as 'likes' FROM likes
         WHERE user_id IN (
          SELECT id from users ORDER BY (SELECT birthday FROM profiles WHERE id = user_id) DESC)
GROUP by user_id
limit 10
;

-- ������� 2 - ��� �� ����� ����� � ����� ��� ��� as su, ���� ��� ���� � ������, 
-- �� ��� ��� �� �������� ��������
SELECT sum(likes) as su FROM (
SELECT COUNT(*) as likes FROM likes
         WHERE user_id IN (
          SELECT id from users ORDER BY (SELECT birthday FROM profiles WHERE id = user_id) DESC)
GROUP by user_id
limit 10) as su;


-- 4/ ���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
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


-- 5/ ����� 10 �������������, ������� ��������� ���������� ����������
--  � ������������� ���������� ����.
-- ������ ����� ������� ������� �� ���������� ������
SELECT (SELECT CONCAT(firstname, ' ', lastname) 
        FROM users 
        WHERE user_id = id) as users, count(*) as activity
from posts
GROUP BY user_id order by activity
limit 10;

-- �����