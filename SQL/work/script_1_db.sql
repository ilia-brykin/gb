-- Игра слогонатор. Планируется написать app, в ней проходишь уровни, начиная с первого.
-- Там загаданы слова, каждому слову соответствует картинка, и даны слоги, нужно из слогов составить правильное слово.
-- На поле видны 4 картинки и 20 слогов. Когда картинка угадана, она меняется и меняются слоги.
-- на одном уровне нужно угадать 20 картинок. За прохождение уровня начисляются балы, которые можно потратить на подсказки.
-- И еще эти подсказки мижно будет купить. Также будет административная часть, в которой можно будеть управлять пользователями,
-- смотреть статистику, редактировать уровни и слова.
-- Для этой базы данных выбранный первичные ключи UUID, чтобы увеличить безопасность базы данных. Храним их в бинарном виде, чтобы сэкономить место.

DROP DATABASE IF EXISTS slogonator;
CREATE DATABASE slogonator;
USE slogonator;

DROP TABLE IF EXISTS c_user_statuses;
CREATE TABLE c_user_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

DROP TABLE IF EXISTS c_genders;
CREATE TABLE c_genders(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);


DROP TABLE IF EXISTS users;
CREATE TABLE users (
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    firstname VARCHAR(100) NOT NULL,
    lastname VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash varchar(100),
    user_status_id BINARY(16),

    FOREIGN KEY (user_status_id) REFERENCES c_user_statuses(id) ON UPDATE CASCADE ON DELETE SET NULL,
    KEY index_firstname_lastname(firstname, lastname)
);


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id BINARY(16) PRIMARY KEY,
    gender_id BINARY(16),
    birthday DATE,
    phone VARCHAR(50),
    hometown VARCHAR(100),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (gender_id) REFERENCES c_genders(id) ON UPDATE CASCADE ON DELETE SET NULL,
    KEY index_birthday(birthday),
    KEY index_created_updated_at(created_at, updated_at)
);


DROP TABLE IF EXISTS roles;
CREATE TABLE roles(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);


DROP TABLE IF EXISTS permissions;
CREATE TABLE permissions(
    `key` VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DROP TABLE IF EXISTS roles_permissions;
CREATE TABLE roles_permissions(
	role_id BINARY(16) NOT NULL,
	permission_key VARCHAR(50) NOT NULL,

	PRIMARY KEY (role_id, permission_key),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (permission_key) REFERENCES permissions(`key`) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS users_roles;
CREATE TABLE users_roles(
	user_id BINARY(16) NOT NULL,
	role_id BINARY(16) NOT NULL,

	PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS c_notification_types;
CREATE TABLE c_notification_types(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);


DROP TABLE IF EXISTS notifications;
CREATE TABLE notifications(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	notification_type_id BINARY(16),
	user_id BINARY(16) NOT NULL,
	header VARCHAR(100) NOT NULL,
	body TEXT NOT NULL,
	additional_information JSON,
	is_read bit default 0,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (notification_type_id) REFERENCES c_notification_types(id) ON UPDATE CASCADE ON DELETE SET NULL,

    KEY index_created_updated_at(created_at, updated_at)
);


DROP TABLE IF EXISTS levels;
CREATE TABLE levels(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	number MEDIUMINT UNSIGNED NOT NULL UNIQUE,
    description VARCHAR(255),
    money_after_passing MEDIUMINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_money(money_after_passing)
);


DROP TABLE IF EXISTS words;
CREATE TABLE words(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	level_id BINARY(16),
	word VARCHAR(30) NOT NULL,
    description VARCHAR(255),
    image_preview VARCHAR(255) NOT NULL,
    image_big VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (level_id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE SET NULL,

    KEY index_word(word),
    KEY index_images(image_preview, image_big)
);


DROP TABLE IF EXISTS syllables;
CREATE TABLE syllables(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	word_id BINARY(16),
	syllable VARCHAR(8) NOT NULL,
	number TINYINT NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (word_id) REFERENCES words(id) ON UPDATE CASCADE ON DELETE CASCADE,

    KEY index_syllable(syllable)
);


DROP TABLE IF EXISTS progress;
CREATE TABLE progress(
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	user_id BINARY(16) NOT NULL UNIQUE,
	level_id BINARY(16),
	points BIGINT UNSIGNED NOT NULL,
	money BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE SET NULL,
    UNIQUE KEY user_lever (user_id,level_id),
    KEY index_points(points),
    KEY index_money(money)
);


DROP TABLE IF EXISTS c_progress_words_statuses;
CREATE TABLE c_progress_words_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);


DROP TABLE IF EXISTS progress_level_words;
CREATE TABLE progress_level_words(
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	progress_id BINARY(16) NOT NULL,
	word_id BINARY(16) NOT NULL,
	status_id BINARY(16),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (progress_id) REFERENCES progress(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES c_progress_words_statuses(id) ON UPDATE CASCADE ON DELETE SET NULL,
    FOREIGN KEY (word_id) REFERENCES words(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS c_hints;
CREATE TABLE c_hints(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    price MEDIUMINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name),
    KEY index_price(price)
);


DROP TABLE IF EXISTS user_hints;
CREATE TABLE user_hints(
	user_id BINARY(16) NOT NULL,
	hint_id BINARY(16) NOT NULL,
	count INT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, hint_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (hint_id) REFERENCES c_hints(id) ON UPDATE CASCADE ON DELETE CASCADE,

    KEY index_count(count)
);


DROP TABLE IF EXISTS c_friend_requests_statuses;
CREATE TABLE c_friend_requests_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);


DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BINARY(16) NOT NULL,
    target_user_id BINARY(16) NOT NULL,
    status_id BINARY(16) NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    PRIMARY KEY (initiator_user_id, target_user_id),
    FOREIGN KEY (initiator_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (target_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES c_friend_requests_statuses(id) ON UPDATE CASCADE ON DELETE CASCADE
);


DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	from_user_id BINARY(16) NOT NULL,
    to_user_id BINARY(16) NOT NULL,
    header VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    is_read bit default 0,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,

    KEY index_created_updated_at(created_at, updated_at)
);

-- triggers
DELIMITER //
DROP TRIGGER IF EXISTS check_initiator_and_target_insert//
CREATE TRIGGER check_initiator_and_target_insert BEFORE INSERT ON friend_requests
FOR EACH ROW
BEGIN
    DECLARE is_target_initiator BIT DEFAULT 0;
    IF NEW.initiator_user_id = NEW.target_user_id THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'initiator_user_id and target_user_id should not be equal.';
	END IF;
    SET is_target_initiator = (
        SELECT COUNT(*) FROM friend_requests
        WHERE target_user_id = NEW.initiator_user_id AND initiator_user_id = NEW.target_user_id
        LIMIT 1
    );
    IF NEW.initiator_user_id =  NEW.target_user_id THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'initiator_user_id and target_user_id should not be equal.';
    END IF;
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS check_initiator_and_target_update//
CREATE TRIGGER check_initiator_and_target_update BEFORE UPDATE ON friend_requests
FOR EACH ROW
BEGIN
    DECLARE is_target_initiator BIT DEFAULT 0;
    IF NEW.initiator_user_id = NEW.target_user_id THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'initiator_user_id and target_user_id should not be equal.';
	END IF;
    SET is_target_initiator = (
        SELECT COUNT(*) FROM friend_requests
        WHERE target_user_id = NEW.initiator_user_id AND initiator_user_id = NEW.target_user_id
        LIMIT 1
    );
    IF NEW.initiator_user_id = NEW.target_user_id THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'initiator_user_id and target_user_id should not be equal.';
    END IF;
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS check_birthday_insert//
CREATE TRIGGER check_birthday_insert BEFORE INSERT ON profiles
FOR EACH ROW
BEGIN
    IF NEW.birthday > CURDATE() THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'birthday is greater than current date';
	END IF;
END//
DELIMITER ;

DELIMITER //
DROP TRIGGER IF EXISTS check_birthday_update//
CREATE TRIGGER check_birthday_update BEFORE UPDATE ON profiles
FOR EACH ROW
BEGIN
    IF NEW.birthday > CURDATE() THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'birthday is greater than current date';
	END IF;
END//
DELIMITER ;
-- views
DROP VIEW IF EXISTS v_users_permissions;
CREATE VIEW v_users_permissions AS
    SELECT BIN_TO_UUID(u.id) AS user_id, u.email, JSON_ARRAYAGG(p.`key`) AS permission
    FROM users u
    JOIN users_roles ur ON u.id = ur.user_id
    JOIN roles_permissions rp on ur.role_id = rp.role_id
    JOIN permissions p on rp.permission_key = p.`key`
    GROUP BY u.id;

DROP VIEW IF EXISTS v_words_syllables;
CREATE VIEW v_words_syllables AS
    SELECT BIN_TO_UUID(w.id) AS word_id, w.word, w.image_preview, w.image_big, w.description, JSON_OBJECTAGG(s.number, s.syllable) AS syllables
    FROM words w
    JOIN syllables s on w.id = s.word_id
    GROUP BY w.id;

DROP VIEW IF EXISTS v_friends;
CREATE VIEW v_friends AS
    SELECT BIN_TO_UUID(u.id) AS id, u.firstname, u.lastname, u.email,
           BIN_TO_UUID(fr.initiator_user_id) AS initiator_user_id, BIN_TO_UUID(fr.target_user_id) AS target_user_id
    FROM users u
    JOIN friend_requests fr ON u.id = fr.target_user_id
    JOIN c_friend_requests_statuses cfrs on fr.status_id = cfrs.id
    WHERE cfrs.name = 'approved'
    UNION
    SELECT BIN_TO_UUID(u.id) AS id, u.firstname, u.lastname, u.email,
           BIN_TO_UUID(fr.initiator_user_id) AS initiator_user_id, BIN_TO_UUID(fr.target_user_id) AS target_user_id
    FROM users u
    JOIN friend_requests fr ON u.id = fr.initiator_user_id
    JOIN c_friend_requests_statuses cfrs on fr.status_id = cfrs.id
    WHERE cfrs.name = 'approved';

-- procedures

-- Найти текущий уровень для определенного пользователя
DROP PROCEDURE IF EXISTS current_level_for_user;
DELIMITER //
CREATE PROCEDURE current_level_for_user(IN user_uuid VARCHAR(36), OUT level INT)
BEGIN
    SELECT l.number INTO level FROM progress p
    JOIN levels l on p.level_id = l.id
    WHERE p.user_id = UUID_TO_BIN(user_uuid);
END//
DELIMITER ;

-- Найти сообщения для определенного пользователя: все(2-9), прочитанные(1) или непрочитанные(0)
DROP PROCEDURE IF EXISTS sp_get_messages_for_user;
DELIMITER //
CREATE PROCEDURE sp_get_messages_for_user(IN user_uuid VARCHAR(36), IN is_read_local INT(1))
BEGIN
    IF is_read_local = 1 OR is_read_local = 0 THEN
        SELECT * FROM messages
        WHERE to_user_id = UUID_TO_BIN(user_uuid) AND is_read = is_read_local;
    ELSE
        SELECT * FROM messages
        WHERE to_user_id = UUID_TO_BIN(user_uuid);
    END IF;
END//
DELIMITER ;

DROP PROCEDURE IF EXISTS sp_user_add;
DELIMITER //
CREATE PROCEDURE sp_user_add(
firstname varchar(100), lastname varchar(100), email varchar(100),
gender_id VARCHAR(36), birthday DATE, phone varchar(100),
hometown varchar(50), OUT tran_result TEXT)
BEGIN
	DECLARE _rollback BIT DEFAULT 0;
	DECLARE user_status_id_local BINARY(16);
	DECLARE user_id_local BINARY(16);
	DECLARE code varchar(100);
	DECLARE error_string varchar(100);

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN
 		SET _rollback = 1;
 		GET stacked DIAGNOSTICS CONDITION 1
			code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
		SET tran_result = concat('Error code: ', code, ' Text: ', error_string);
	END;

	START TRANSACTION;
	    SET user_status_id_local = (
	        SELECT id FROM c_user_statuses
	        WHERE name = 'inactive'
	        LIMIT 1
        );
        INSERT INTO users (firstname, lastname, email, user_status_id)
	    VALUES (firstname, lastname, email, user_status_id_local);

	    SET user_id_local = (
	        SELECT id FROM users u
	        WHERE u.email = email
	        LIMIT 1
        );

        INSERT INTO profiles (user_id, gender_id, birthday, phone, hometown)
        VALUES (user_id_local, UUID_TO_BIN(gender_id), birthday, phone, hometown);

	IF _rollback THEN
		ROLLBACK;
	ELSE
		SET tran_result = 'OK';
		COMMIT;
	END IF;
END//
DELIMITER ;
