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

ALTER TABLE likes
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id),
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
    
ALTER TABLE media
  ADD CONSTRAINT media_media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);

ALTER TABLE posts
  ADD CONSTRAINT posts_communitie_id_fk 
    FOREIGN KEY (communitie_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id);
    

-- 2. По созданным связям создать ER диаграмму, используя Dbeaver (приложить графический файл к ДЗ).
-- файл приложен - vk-bert.png


-- 3. Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).

