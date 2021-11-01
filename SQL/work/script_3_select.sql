USE slogonator;
-- select

-- Показать всех активных пользователей
SELECT BIN_TO_UUID(u.id) AS user_id, u.firstname, u.lastname, u.email FROM users u
JOIN c_user_statuses cus ON cus.id = u.user_status_id
WHERE cus.name = 'active';

-- Посчитать количество пользователей в каждом статусе
SELECT BIN_TO_UUID(cus.id) AS status_id, cus.name, cus.description, COUNT(*) AS count FROM users u
JOIN c_user_statuses cus ON cus.id = u.user_status_id
GROUP BY cus.id
ORDER BY count DESC;

-- Показать информацию о пользователях
SELECT
    BIN_TO_UUID(u.id) AS user_id,
    u.firstname,
    u.lastname,
    u.email,
    p.phone,
    p.birthday,
    p.hometown,
    cg.name AS gender,
    p.created_at,
    p.updated_at
FROM users u
JOIN profiles p ON u.id = p.user_id
JOIN c_genders cg on p.gender_id = cg.id;

-- найти 10 пользователей с максимальным количеством очков для ТОП 10
SELECT BIN_TO_UUID(u.id) AS user_id, u.firstname, u.lastname, p.points from users u
JOIN progress p on u.id = p.user_id
ORDER BY p.points DESC
LIMIT 10;

-- Сумма всех очков пользователей
SELECT SUM(points) AS sum from progress;

-- Видимые картинки для первого пользователя UUID 'df4f30cb-3431-11ec-a045-d43b0469c611' на текущем уровне
SET @admin_uuid := 'df4f30cb-3431-11ec-a045-d43b0469c611';
SET @admin_uuid_bin := UUID_TO_BIN(@admin_uuid);

SELECT BIN_TO_UUID(w.id) AS word_id, w.image_preview, w.image_big, w.description FROM progress p
JOIN progress_level_words plw on p.id = plw.progress_id
JOIN words w on plw.word_id = w.id
JOIN c_progress_words_statuses cpws on plw.status_id = cpws.id
WHERE p.user_id = @admin_uuid_bin AND cpws.name = 'visible';

-- Найти всех друзей для текущего пользователя UUID 'df4f30cb-3431-11ec-a045-d43b0469c611'
SELECT vf.id, vf.firstname, vf.lastname FROM v_friends vf
WHERE (vf.initiator_user_id = @admin_uuid OR vf.target_user_id = @admin_uuid) AND vf.id != @admin_uuid;

-- тоже самое без VIEW
SELECT BIN_TO_UUID(u.id) AS id, u.firstname, u.lastname FROM users u
JOIN friend_requests fr ON u.id = fr.initiator_user_id OR u.id = fr.target_user_id
JOIN c_friend_requests_statuses cfrs on fr.status_id = cfrs.id
WHERE (fr.initiator_user_id = @admin_uuid_bin
       OR fr.target_user_id = @admin_uuid_bin)
       AND cfrs.name = 'approved'
       AND u.id != @admin_uuid_bin
GROUP BY u.id;

-- Из всех друзей этого пользователя найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT BIN_TO_UUID(u.id) AS user_id, u.firstname, u.lastname, COUNT(*) as count from users u
JOIN messages m on u.id = m.from_user_id
JOIN friend_requests fr ON u.id = fr.initiator_user_id OR u.id = fr.target_user_id
JOIN c_friend_requests_statuses cfrs on fr.status_id = cfrs.id
WHERE m.to_user_id = @admin_uuid_bin AND (fr.initiator_user_id = @admin_uuid_bin OR fr.target_user_id = @admin_uuid_bin) AND cfrs.name = 'approved'
GROUP BY m.from_user_id
ORDER BY count DESC
LIMIT 1;

-- Найти количество сообщений, которые отправлены текущему пользователю
SELECT COUNT(*) as count from messages
WHERE to_user_id = @admin_uuid_bin;
