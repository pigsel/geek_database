-- �������� ������� � ����� 8
-- ����� ����� �������

-- 1. �������� ����������� ������� ����� ��� ���� ������ ���� ������ vk (��������� �������).
-- profiles � messages �� ���������, �.�. ��� ���� �� �����

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


-- 2. �� ��������� ������ ������� ER ���������, ��������� Dbeaver (��������� ����������� ���� � ��).

-- 3. ���������� �������, ������� � �� ����� 6 � �������������� JOIN (������ �������).

