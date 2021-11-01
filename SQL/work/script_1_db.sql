DROP DATABASE IF EXISTS slogonator;
CREATE DATABASE slogonator;
USE slogonator;

-- Таблица заполнена
DROP TABLE IF EXISTS c_user_statuses;
CREATE TABLE c_user_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

-- Таблица заполнена
DROP TABLE IF EXISTS c_genders;
CREATE TABLE c_genders(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
DROP TABLE IF EXISTS roles;
CREATE TABLE roles(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

-- Таблица заполнена
DROP TABLE IF EXISTS permissions;
CREATE TABLE permissions(
    `key` VARCHAR(50) PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица заполнена
DROP TABLE IF EXISTS roles_permissions;
CREATE TABLE roles_permissions(
	role_id BINARY(16) NOT NULL,
	permission_key VARCHAR(50) NOT NULL,

	PRIMARY KEY (role_id, permission_key),
    FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (permission_key) REFERENCES permissions(`key`) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Таблица заполнена
DROP TABLE IF EXISTS users_roles;
CREATE TABLE users_roles(
	user_id BINARY(16) NOT NULL,
	role_id BINARY(16) NOT NULL,

	PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Таблица заполнена
DROP TABLE IF EXISTS c_notification_types;
CREATE TABLE c_notification_types(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
DROP TABLE IF EXISTS c_progress_words_statuses;
CREATE TABLE c_progress_words_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
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

-- Таблица заполнена
DROP TABLE IF EXISTS c_friend_requests_statuses;
CREATE TABLE c_friend_requests_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    KEY index_name(name)
);

-- Таблица заполнена
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

-- Таблица заполнена
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
    DECLARE is_target_initiator INT DEFAULT 0;
    SELECT COUNT(*) INTO is_target_initiator FROM friend_requests
    WHERE target_user_id = NEW.initiator_user_id AND initiator_user_id = NEW.target_user_id
    LIMIT 1;
    IF NEW.initiator_user_id =  NEW.target_user_id THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'initiator_user_id and target_user_id should not be equal.';
    ELSEIF is_target_initiator > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entry already exists.';
    END IF;
END//

DROP TRIGGER IF EXISTS check_initiator_and_target_update//
CREATE TRIGGER check_initiator_and_target_update BEFORE UPDATE ON friend_requests
FOR EACH ROW
BEGIN
    DECLARE is_target_initiator INT DEFAULT 0;
    SELECT COUNT(*) INTO is_target_initiator FROM friend_requests
    WHERE target_user_id = NEW.initiator_user_id AND initiator_user_id = NEW.target_user_id
    LIMIT 1;
    IF NEW.initiator_user_id =  NEW.target_user_id THEN
	    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'initiator_user_id and target_user_id should not be equal.';
    ELSEIF is_target_initiator > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Entry already exists.';
    END IF;
END//

DELIMITER ;

-- views
DROP VIEW IF EXISTS users_permissions;
CREATE VIEW users_permissions AS
SELECT BIN_TO_UUID(u.id) AS user_id, u.email, JSON_ARRAYAGG(p.`key`) AS permission
FROM users u
JOIN users_roles ur ON u.id = ur.user_id
JOIN roles_permissions rp on ur.role_id = rp.role_id
JOIN permissions p on rp.permission_key = p.`key`
GROUP BY u.id;

DROP VIEW IF EXISTS words_syllables;
CREATE VIEW words_syllables AS
    SELECT BIN_TO_UUID(w.id) AS word_id, w.word, w.image_preview, w.image_big, w.description, JSON_OBJECTAGG(s.number, s.syllable) AS syllables
    FROM words w
    JOIN syllables s on w.id = s.word_id
    GROUP BY w.id;
