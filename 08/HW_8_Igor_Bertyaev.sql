-- домашнее задание к уроку 8
-- автор Игорь Бертяев

-- 1. Добавить необходимые внешние ключи для всех таблиц базы данных vk (приложить команды).
-- profiles и messages не показываю, т.к. они были на уроке

ALTER TABLE communities_users
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE friendship
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);


-- 2. По созданным связям создать ER диаграмму, используя Dbeaver (приложить графический файл к ДЗ).

-- 3. Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

