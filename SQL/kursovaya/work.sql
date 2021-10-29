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
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Таблица заполнена
DROP TABLE IF EXISTS c_genders;
CREATE TABLE c_genders(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(20) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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

    FOREIGN KEY (user_status_id) REFERENCES c_user_statuses(id) ON UPDATE CASCADE ON DELETE SET NULL
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
    FOREIGN KEY (gender_id) REFERENCES c_genders(id) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Таблица заполнена
DROP TABLE IF EXISTS roles;
CREATE TABLE roles(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    FOREIGN KEY (notification_type_id) REFERENCES c_notification_types(id) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Таблица заполнена
DROP TABLE IF EXISTS levels;
CREATE TABLE levels(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	number MEDIUMINT UNSIGNED NOT NULL UNIQUE,
    description VARCHAR(255),
    money_after_passing MEDIUMINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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

    FOREIGN KEY (level_id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE SET NULL
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

    FOREIGN KEY (word_id) REFERENCES words(id) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS progress;
CREATE TABLE progress(
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	user_id BINARY(16) NOT NULL,
	level_id BINARY(16),
	points BIGINT UNSIGNED NOT NULL,
	money BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (level_id) REFERENCES levels(id) ON UPDATE CASCADE ON DELETE SET NULL
);

-- Таблица заполнена
DROP TABLE IF EXISTS c_progress_words_statuses;
CREATE TABLE c_progress_words_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS progress_level_words;
CREATE TABLE progress_level_words(
    id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
	progress_level_id BINARY(16) NOT NULL,
	word_id BINARY(16) NOT NULL,
	status_id BINARY(16),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (progress_level_id) REFERENCES progress(id) ON UPDATE CASCADE ON DELETE CASCADE,
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
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
    FOREIGN KEY (hint_id) REFERENCES c_hints(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Таблица заполнена
DROP TABLE IF EXISTS c_friend_requests_statuses;
CREATE TABLE c_friend_requests_statuses(
	id BINARY(16) PRIMARY KEY DEFAULT (UUID_TO_BIN(UUID())),
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
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
	id BINARY(16) PRIMARY KEY,
	from_user_id BINARY(16) NOT NULL,
    to_user_id BINARY(16) NOT NULL,
    header VARCHAR(100) NOT NULL,
    body TEXT NOT NULL,
    is_read bit default 0,
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- INSERT
INSERT INTO c_user_statuses
    (id, name, description)
VALUE
    (UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff'), 'active', 'Пользователь активный'),
    (UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6'), 'inactive', 'Пользователь не подтвердил регистрацию '),
    (UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55'), 'blocked', 'Пользователь заблокирован'),
    (UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a'), 'deleted', 'Пользователь удален');

INSERT INTO c_genders
    (id, name, description)
VALUE
    (UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'), 'male', 'Мужской'),
    (UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'), 'female', 'Женский'),
    (UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'), 'undecided', 'Не определился');

INSERT INTO users
    (id,firstname, lastname, email, password_hash, user_status_id)
VALUES
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Admin','Admin','admin@example.com','f33cd13e39a913dfa5c83dd79c79b583b647bf1e',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),'Level','Level','level@example.com','f33cd13e39a913dfa5c83dd79c79b583b647bf1e',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f35b3-3431-11ec-a045-d43b0469c611'),'Luis','Feest','zstokes@example.org','f1f4086932399b5ecd42a6e8e701a086645b8758',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f370d-3431-11ec-a045-d43b0469c611'),'Eliezer','Cole','o\'conner.alberto@example.com','0d68c06abec2ce2505ee972ebbac0dda661f1d2b',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f3a14-3431-11ec-a045-d43b0469c611'),'Maryse','Murray','hackett.kale@example.net','a9818d65f72ed70328ee44a98f9dfb289eed1451',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),'Carlee','O\'Kon','hayes.jeffrey@example.org','6237a0cfc19421c2b4a67618d8747c5cbea706d9',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3e23-3431-11ec-a045-d43b0469c611'),'Jesse','Kuphal','zack.swaniawski@example.com','0cfad79dbd18564c27220ddd322633cab67c5e75',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),'Myrtle','Russel','dessie66@example.net','b945ecaee78f8852573daffbcd5011a28aea5d86',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f41ac-3431-11ec-a045-d43b0469c611'),'Enrico','Wyman','graciela82@example.org','4a9d2d952c91e2e54f8dc6ca46a876836a798c47',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),'Jason','Larkin','ihuels@example.net','dd055ca16ef8c2629a49b2af82a551e649080273',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),'Claudie','Nikolaus','wtrantow@example.net','cf491971dc2a35452d2c9a8809b6e2552145d6fa',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),'Karine','Fisher','denesik.sidney@example.net','a61333058d1453aabebc718690880bd34bda2e8f',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f46df-3431-11ec-a045-d43b0469c611'),'Duncan','Kautzer','morissette.neal@example.com','9b7fafd0e5d8bd64acc04420914fe2eede43d91b',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f476c-3431-11ec-a045-d43b0469c611'),'Sydni','Ernser','renner.abbie@example.net','6a68df29b17e9e680d5dada9cf150e0b46770c33',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),'Marcelo','Ullrich','jeff.prohaska@example.net','6128f559f93e7c4b800837228ef986268781f7d2',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f49ac-3431-11ec-a045-d43b0469c611'),'Jerry','D\'Amore','gerhold.grace@example.com','92bc981c03d1de909946b2aef51cc91ad8490925',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f4b4f-3431-11ec-a045-d43b0469c611'),'Kendall','Dickinson','friesen.mable@example.net','90742ccc50d3141352fd4c274159ce6473b79c28',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),'Ada','O\'Keefe','hagenes.oren@example.net','283c0b4e17ad19d0ded551d8922f7df93ea70e74',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f4e16-3431-11ec-a045-d43b0469c611'),'Annamarie','Larson','conrad47@example.org','71b4e39cef1bce85e99c67b1a2be803cb8ad6bd3',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f4f2e-3431-11ec-a045-d43b0469c611'),'Reilly','Bahringer','trent.bailey@example.net','848414728d5fa3e3d907902e50d6c48cb702bed2',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),'Randi','Jacobs','karley.weber@example.net','8fee3bae126a5a8cd9b62b441f501f6f1feb19b4',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),'Luther','Renner','loyce13@example.net','24665449f377fdd917972be8010547050327593e',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f51fc-3431-11ec-a045-d43b0469c611'),'Mozell','Kohler','strosin.jamaal@example.org','534c1775a72c7c7c869aaf35117f78db98164535',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),'Florian','Casper','dashawn.rau@example.com','3f17724c1f5064e43ed52277bdbf4c17dae6ba9c',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),'Zander','Tromp','kiara35@example.net','6541af272e68d45d23f748dcfe5ecdb26ff51f3c',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f54bf-3431-11ec-a045-d43b0469c611'),'Gay','Hoppe','dayana.schuppe@example.net','dd26ec9a0dbe22529d9b9b3addf076c590e48648',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),'Jewell','Breitenberg','davis.keara@example.net','eab7e9ea0e80396b525d7bc8aa8e1059fcb5237d',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f56f7-3431-11ec-a045-d43b0469c611'),'Audra','Grant','vandervort.jaleel@example.org','d2b527c2ec261708dc3c5a8b232a5318b5d4308d',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),'Savanah','Hamill','cummerata.giles@example.com','221e098113ca5f338d49f19332a8eca444213876',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),'Cassidy','Parisian','ada95@example.net','e99d129a1390ceef4da060f753a9351339da2724',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),'Forrest','Maggio','lue54@example.com','c91f41e7885a9da7d802e80a1214e8e9f10c1a30',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5cd9-3431-11ec-a045-d43b0469c611'),'Elenora','Bergnaum','sboyer@example.com','1de9aa0af4d13d70b0f2e86fa5c798bfe12fe47a',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),'Petra','Cormier','fahey.tanner@example.net','11969af00e91f01302c826c48525cc4c116a4acb',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),'Jasmin','D\'Amore','eliane.watsica@example.net','e3491d02e54b9e914f336fb95225b25164c3ca05',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5fb0-3431-11ec-a045-d43b0469c611'),'Landen','Treutel','kolby.senger@example.net','f3b4ca4cc17808a3979de7ad4a3dee82f4e43e79',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f615c-3431-11ec-a045-d43b0469c611'),'Maya','Swift','vprohaska@example.net','a6837627dbceb2f610fd36c3111220dc0a3f6518',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),'Arielle','Johnson','wfadel@example.org','1ab33452a5cf1239a84931d6b657247836ba2b43',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),'Lionel','Mitchell','nathen.balistreri@example.net','1709222317823494ce141967e2a746821476fec8',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f6428-3431-11ec-a045-d43b0469c611'),'Dee','Hand','jacobs.adrain@example.org','0fe85314399f496b6d4591823bb36a5bf5e100bf',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),'Gisselle','Feeney','swilliamson@example.net','d5aacff97cdc10ec25efeb3738332a62810eaa5f',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),'Giovanni','Hamill','xbalistreri@example.net','7e8aded04faad8e99a1257c0050a09bee095841c',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f6662-3431-11ec-a045-d43b0469c611'),'Alfonzo','Bailey','vivienne79@example.net','ae1ebaa6dd9b26d660a6dbce16ae081c8496de29',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),'Maye','Medhurst','barton.mackenzie@example.net','60ee06b79eaecb4f412f4653b7617f2478d0bf47',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),'Emie','Cronin','fhilll@example.com','e6152af4b5d1a519690ff97a71a21ae25c7eb88b',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f6ad6-3431-11ec-a045-d43b0469c611'),'Kennith','Dietrich','jkuhn@example.net','1fd8cfed5657fc4fd31638eb80e520454f972423',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f6b63-3431-11ec-a045-d43b0469c611'),'Ardith','Cummings','watsica.ian@example.org','0d6effc2cd4b54c8e82780772211ce708f5d7474',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f6c7e-3431-11ec-a045-d43b0469c611'),'Thomas','Kozey','muller.vella@example.com','c57b3567c1f34603b9a895c9946973c8772fb878',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f6d0a-3431-11ec-a045-d43b0469c611'),'Jacklyn','Rolfson','kuvalis.geovanny@example.com','6323e3b74ebccae0422db26e1a55c8ca7bde75b5',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3528-3431-11ec-a045-d43b0469c611'),'Norma','Kertzmann','eugenia.bernier@example.net','b8a4bca405e823e06284b2a1a164dcaa919b5757',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f383b-3431-11ec-a045-d43b0469c611'),'Amber','Kuhn','wbarton@example.com','1cf1b44834eab6acb5fee40694fd881f6ac5659c',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3914-3431-11ec-a045-d43b0469c611'),'Everette','Bosco','janice04@example.com','35b356cd730bbadc9f89f7e684277bd83bb88a91',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f409a-3431-11ec-a045-d43b0469c611'),'Luisa','Hammes','sven.strosin@example.com','813ee6281015adb37f8be8d8a97264debe187d12',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f4236-3431-11ec-a045-d43b0469c611'),'Florian','Ward','kurtis.cummerata@example.com','d4467a0595b7217bcc282164738d32e2b1c3bdb7',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f4531-3431-11ec-a045-d43b0469c611'),'Lexus','Rutherford','lucile93@example.com','e746e05b394a7eeb35e22f43c5164f1c1487a41e',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f4ac2-3431-11ec-a045-d43b0469c611'),'Ashly','Gislason','clementine.goyette@example.org','b056dd76507d2dca9cef3e4d7f90153002ff0a34',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f4cf7-3431-11ec-a045-d43b0469c611'),'Timmy','Greenfelder','bbins@example.net','d7156fdab71472a6f60dc535e8b662dc1ea676f8',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f53a3-3431-11ec-a045-d43b0469c611'),'Irma','Gaylord','xwilliamson@example.com','d36b41cb6a4eac134bad1c56c45c5b3fca902275',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5937-3431-11ec-a045-d43b0469c611'),'Golden','Berge','jerde.fredrick@example.org','1770e59a7131ad2cc958b606ff56c0ae5fe29d2d',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5bb2-3431-11ec-a045-d43b0469c611'),'Susana','Kulas','jacky81@example.org','c36b3bd0650398bf3ddf82533f95cf16b4579dd3',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f5df6-3431-11ec-a045-d43b0469c611'),'Shirley','O\'Reilly','leon.hegmann@example.com','b195ccbffcfd132e1d6028166837980eb37fab5e',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f5e86-3431-11ec-a045-d43b0469c611'),'Mauricio','Goodwin','dwight.carroll@example.com','29a218267ba985166e012de84aeaddc58db0f913',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f603f-3431-11ec-a045-d43b0469c611'),'Marielle','Rodriguez','grimes.aliyah@example.org','5d04e3c765528742665d7daeacd09d3f36680c95',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f6542-3431-11ec-a045-d43b0469c611'),'Hester','Cremin','nkessler@example.com','c1c4049ba620a1b07e6708c8c62c7d1dbe764758',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f66f0-3431-11ec-a045-d43b0469c611'),'Marisol','Goodwin','ortiz.adam@example.net','796eb1c3722a2bc15a769c8d4f846c76d20f7f10',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f6bf4-3431-11ec-a045-d43b0469c611'),'Lia','Quitzon','rhiannon.satterfield@example.org','1520403e9bc095bacfb29dca82a16d21587b5021',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f32eb-3431-11ec-a045-d43b0469c611'),'Brendan','Konopelski','clair.bauch@example.com','8c7fb502452b8cd83e1708f8e90d2242be6116a9',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f367d-3431-11ec-a045-d43b0469c611'),'Johnny','Hermiston','maribel91@example.net','1bfcf0faef5bd7070707e097d25907ec93c3eb9a',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3ae8-3431-11ec-a045-d43b0469c611'),'Lourdes','Hammes','obraun@example.com','db6c9034638141c12dc3d546d55e0e7e4079ecce',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3ce3-3431-11ec-a045-d43b0469c611'),'Myrtice','Considine','lang.keenan@example.net','989faa3b35ccfbbab97624d0688130a4ca93ca50',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3d8e-3431-11ec-a045-d43b0469c611'),'Riley','Murazik','danny34@example.com','a84ef9d111a22cc1f282194472d9eefd43d01135',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f3f57-3431-11ec-a045-d43b0469c611'),'Sandra','Sauer','jast.ellie@example.com','bbe43060b2bb10a89250cb1c3ab718a824f1e0f4',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f4124-3431-11ec-a045-d43b0469c611'),'Marjolaine','Schamberger','phamill@example.com','9b55155ac35bc89357a4b80733c504201cac7526',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f42d9-3431-11ec-a045-d43b0469c611'),'Scot','Fay','kirk63@example.com','353c14cbcc876070adf37739eb388232e611bca6',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f441b-3431-11ec-a045-d43b0469c611'),'Dereck','Mertz','hintz.rossie@example.com','65ce8a631c347597bd51a508a6a56b4cca9c55e1',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f47fe-3431-11ec-a045-d43b0469c611'),'Elisha','Stanton','llarkin@example.net','77228ca20ad504a7d7de94f34ed0577b96d449bd',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f4a39-3431-11ec-a045-d43b0469c611'),'Rosalia','Swaniawski','hhartmann@example.net','2e03f6440a6ba7ca35e4a16ac5a82b928603d691',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f4d88-3431-11ec-a045-d43b0469c611'),'Emery','O\'Kon','declan36@example.org','32c90a419775df7136dd9d38d0cbf66c580b38ca',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f4ea1-3431-11ec-a045-d43b0469c611'),'Raquel','Hagenes','taya.kulas@example.net','3e777001c460bb4bdf125d03af0d1f612442fc7f',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f516c-3431-11ec-a045-d43b0469c611'),'Roma','Hintz','mazie.cartwright@example.com','8938d0752079363897a2f5b7f4c070d6360b8388',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f5287-3431-11ec-a045-d43b0469c611'),'Bart','Waters','kristin27@example.com','e79e06a7cf8fb1b2b45f67f7eb7d97eeadcbd2b2',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f554f-3431-11ec-a045-d43b0469c611'),'Ruthie','Carroll','rosamond43@example.org','2daac74fa38a631aa06b8674ef34087e60b310f7',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f55dc-3431-11ec-a045-d43b0469c611'),'Leopold','Nicolas','timmothy64@example.net','73ac7c74da3628d99940b666e1dbd6b4e326b0dd',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5815-3431-11ec-a045-d43b0469c611'),'Hellen','Gleichner','stroman.claudine@example.org','9d8448f1764ad72b379a51ffd6761d9378633846',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f58a2-3431-11ec-a045-d43b0469c611'),'Kendall','Corwin','cecelia59@example.net','719fc66d2d8282dd8142a9cb01ee33fd329bbf0f',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f5c4b-3431-11ec-a045-d43b0469c611'),'Cali','Paucek','francis16@example.com','e7ca32c6481b15fe339403ce2431d7000d5fb25f',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f60cc-3431-11ec-a045-d43b0469c611'),'Quinten','Beatty','ptreutel@example.com','fa8d9245818fb04974ca2cbfae7ff46c8699752e',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f639a-3431-11ec-a045-d43b0469c611'),'Ramona','Robel','fhaag@example.net','01960719ef6fd4a96d4a75ca5a69dae8f9c8cb75',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f6780-3431-11ec-a045-d43b0469c611'),'Boris','Daniel','annie80@example.com','2e6b585bff15bdacab3e5a6d90cbda68ae63fe80',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f689f-3431-11ec-a045-d43b0469c611'),'Sierra','Rempel','pacocha.julio@example.com','ce0b2f77b8d14807b322075a4928e8791603d592',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f69bb-3431-11ec-a045-d43b0469c611'),'Elenor','Spencer','owalter@example.com','915dd69f5f4a1ef3929b3e27f8c41673d1160c80',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f3495-3431-11ec-a045-d43b0469c611'),'Maybell','Feeney','lindgren.dylan@example.com','345b481a0cc2f393fcb020ad908348bed08007b1',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f379c-3431-11ec-a045-d43b0469c611'),'Sylvia','Sauer','lillie.jaskolski@example.org','deabe7f462c54de5801990f20ce0cb62b4daf0f1',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f3b7d-3431-11ec-a045-d43b0469c611'),'Asia','Halvorson','qjast@example.org','11e4b2579c883a60f4c06fe024d051cfbfbb21cd',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f3ebc-3431-11ec-a045-d43b0469c611'),'Vernice','Koch','buckridge.korbin@example.net','402149fe48db75ae09ce76351ee48989d8d5acbd',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f4651-3431-11ec-a045-d43b0469c611'),'Trystan','Dickinson','mheidenreich@example.org','7687ecd95328d1cf5c20426fe7792cc0ec6a9075',UUID_TO_BIN('636ea1b9-fc45-4665-a323-23e43fb1cae6')),
    (UUID_TO_BIN('df4f488e-3431-11ec-a045-d43b0469c611'),'Quinton','Harvey','kutch.brandy@example.net','61850a3c7777d5b212737d30226874f3df881d6a',UUID_TO_BIN('773e50eb-d894-4f76-9296-d690fb0d9e55')),
    (UUID_TO_BIN('df4f4bdb-3431-11ec-a045-d43b0469c611'),'Ken','Lockman','anabelle.schowalter@example.net','b4f579a57daaed77a5aa1494d476ba31403d67af',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f50dc-3431-11ec-a045-d43b0469c611'),'Benny','Mitchell','jimmie22@example.com','8b11ae1c8d54ba7811b7274230b5cf1388b0f8fa',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f5785-3431-11ec-a045-d43b0469c611'),'Rickie','Botsford','reynolds.josiah@example.com','491ee4577b17b5ac1932c594056c32c442a89ada',UUID_TO_BIN('4c3fec5a-b04d-46ea-86ff-28f39c024e2a')),
    (UUID_TO_BIN('df4f61e9-3431-11ec-a045-d43b0469c611'),'Jordon','Frami','oberbrunner.mac@example.org','032c67989056144b3d59643e6c4c0c6ae986d689',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff')),
    (UUID_TO_BIN('df4f6a47-3431-11ec-a045-d43b0469c611'),'Etha','Lesch','drew.nicolas@example.net','2ccf2799570854c00763dcb43460223cc2572851',UUID_TO_BIN('3ef996a2-fadf-44d6-9b25-d6053079f9ff'));

INSERT INTO profiles
    (user_id, gender_id, birthday, phone, hometown, created_at, updated_at)
VALUES
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1979-03-05','+49 123 45678','Rheinbach','1977-01-01 20:42:51','1992-10-07 15:45:55'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1979-03-05','1-259-910-3576x72430','Flatleyside','1977-01-01 20:42:51','1992-10-07 15:45:55'),
    (UUID_TO_BIN('df4f35b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'),'1973-01-20','+76(8)0044770690','West Jaylenshire','2013-02-23 00:49:01','2021-09-07 00:57:49'),
    (UUID_TO_BIN('df4f370d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1978-10-09','104-674-3438x8571','Denesikmouth','2021-08-09 23:07:40','1981-12-14 20:52:15'),
    (UUID_TO_BIN('df4f3a14-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1973-10-06','(970)696-7408','Stiedemannland','1995-12-01 21:00:18','1980-02-19 12:41:29'),
    (UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1997-02-11','+53(8)8226304961','Brendanbury','1971-03-19 13:39:28','1971-04-05 01:22:11'),
    (UUID_TO_BIN('df4f3e23-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2013-09-06','(164)864-7817','Beerland','2014-07-27 01:22:12','2018-05-29 12:23:53'),
    (UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1980-06-08','1-020-492-6866','West Mathewshire','2019-09-29 23:32:28','2006-04-11 08:12:03'),
    (UUID_TO_BIN('df4f41ac-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1995-09-05','01330730634','Linniefort','2004-01-12 13:19:42','2020-01-03 18:14:55'),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1998-04-05','876.953.7852x553','South Sierrafort','1992-03-31 23:54:43','1975-03-20 10:43:51'),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2003-10-02','1-603-558-4350x84609','Ethanfurt','1980-08-11 10:04:36','1970-05-27 15:02:07'),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2003-11-07','1-165-162-5530','South Deshawn','1974-04-25 02:13:56','2016-10-29 16:12:39'),
    (UUID_TO_BIN('df4f46df-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2003-10-15','100.757.7567','Littelton','1970-06-14 15:42:12','2017-06-15 06:00:19'),
    (UUID_TO_BIN('df4f476c-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1984-01-19','(313)144-6883x68871','Lake Elinor','1982-02-27 19:31:29','2007-05-07 22:03:54'),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2017-11-22','479-552-8269x805','Spencermouth','2009-06-07 09:02:27','2020-07-13 09:47:42'),
    (UUID_TO_BIN('df4f49ac-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1973-09-25','640-395-5573x31990','East Johannview','1996-01-03 09:42:42','2009-12-07 19:44:17'),
    (UUID_TO_BIN('df4f4b4f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1972-08-16','(818)522-8482','Blickstad','1997-07-31 13:25:36','2012-07-11 18:03:24'),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2014-08-18','471-224-9474','Hesselport','1985-11-19 15:18:37','1993-09-09 16:06:02'),
    (UUID_TO_BIN('df4f4e16-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1998-03-09','1-329-762-0225x260','Gustavetown','2019-09-23 09:13:07','1990-06-14 06:17:19'),
    (UUID_TO_BIN('df4f4f2e-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2000-07-09','320-573-1947x136','New Jewelport','1981-04-07 14:10:55','2015-08-16 03:41:45'),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1992-02-27','(544)566-5406','Bayermouth','1973-02-12 19:45:31','1980-08-26 04:56:32'),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1975-03-03','+45(3)3121742947','Port Gillianport','2014-09-15 08:54:30','1981-06-08 23:57:04'),
    (UUID_TO_BIN('df4f51fc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'),'1988-05-02','165.933.9516x3651','New Esther','1975-12-29 19:24:36','1986-11-12 21:24:18'),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1982-08-14','916-494-6812x8969','Paulinemouth','1992-04-05 11:32:25','1995-07-11 20:07:44'),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1986-06-26','09227496758','Maxineton','1975-08-08 01:11:16','1979-07-26 11:17:10'),
    (UUID_TO_BIN('df4f54bf-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2012-11-27','840-633-8530x3861','Guillermomouth','1993-05-04 10:35:04','1981-02-17 17:18:05'),
    (UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1980-10-11','00005424378','Binsburgh','1991-08-13 11:29:14','2004-03-25 21:28:30'),
    (UUID_TO_BIN('df4f56f7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2007-08-03','149-247-7070','Gracielaland','1998-11-21 17:58:18','2017-03-16 22:15:36'),
    (UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1973-07-21','881.080.3961x8357','Lurastad','1970-12-15 15:14:01','1971-08-17 01:05:28'),
    (UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2000-06-01','731-645-5415x518','Aureliashire','1973-06-18 03:04:06','2012-10-25 07:28:48'),
    (UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2003-06-06','365.951.5184x7232','Delphiafort','2005-07-30 13:23:33','1972-08-14 23:02:31'),
    (UUID_TO_BIN('df4f5cd9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2008-06-25','+90(5)3241984302','West Johathanview','2020-01-20 08:22:10','1981-11-30 01:18:05'),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1970-07-20','572-626-2631','Dejonfurt','2003-04-05 07:44:56','2001-02-07 07:21:26'),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2013-01-31','261-753-2201x508','East Kristaborough','1988-07-22 04:39:25','1987-07-16 16:36:00'),
    (UUID_TO_BIN('df4f5fb0-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1981-08-17','528-722-4891x83080','McLaughlinstad','2006-03-04 01:51:05','2019-07-24 11:49:21'),
    (UUID_TO_BIN('df4f615c-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1970-12-17','1-502-376-3154','New Sammie','2011-09-12 10:37:40','1992-10-09 17:57:35'),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1997-07-16','1-735-384-4559','South Oscar','1992-11-26 14:44:47','2009-07-01 09:48:27'),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1986-01-02','1-129-910-5171x27050','North Sadiefurt','1995-05-01 05:07:02','2009-10-08 02:38:46'),
    (UUID_TO_BIN('df4f6428-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1981-09-24','(728)606-7742x1973','Dorothymouth','1977-10-22 00:51:54','1989-04-09 16:31:38'),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2006-09-05','438-156-6641x7608','South Stanton','2012-12-14 22:10:55','1993-03-03 12:30:40'),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2013-05-07','201-611-7044','Leuschkefurt','1971-09-06 17:57:23','1997-05-18 04:14:14'),
    (UUID_TO_BIN('df4f6662-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1990-07-16','1-285-389-0664x2021','South Bethany','1977-12-25 16:50:58','1970-06-03 06:13:14'),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'),'1998-11-19','633.603.5290','Julianashire','1978-03-01 08:39:01','1973-08-20 00:32:42'),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2020-02-06','(733)372-0750x31471','Altenwerthhaven','2020-08-22 08:59:48','1997-10-03 17:40:15'),
    (UUID_TO_BIN('df4f6ad6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1979-08-12','1-800-432-2261','Moorestad','2002-08-27 13:48:34','2015-05-18 17:35:32'),
    (UUID_TO_BIN('df4f6b63-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1983-11-01','(357)769-9153','Cynthiaton','1984-05-01 16:54:00','1979-05-29 07:19:03'),
    (UUID_TO_BIN('df4f6c7e-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2000-07-01','1-114-088-5853','West Lillie','2008-12-24 15:09:25','2006-05-27 06:31:23'),
    (UUID_TO_BIN('df4f6d0a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1999-04-18','1-947-894-3348','North Clementtown','1972-03-23 11:31:49','2015-04-29 05:27:27'),
    (UUID_TO_BIN('df4f3528-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1979-06-15','500-494-3223','Carterview','1992-12-29 16:59:08','1976-04-14 10:42:55'),
    (UUID_TO_BIN('df4f383b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2005-07-29','1-457-869-7886x4446','Heloisemouth','1973-11-18 00:23:43','1975-08-29 07:59:42'),
    (UUID_TO_BIN('df4f3914-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1981-06-22','1-796-926-8603x83355','Lake Felicita','1971-02-25 11:12:33','2010-04-12 14:16:50'),
    (UUID_TO_BIN('df4f409a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2014-07-31','1-761-298-0710x038','Smithchester','1974-09-30 05:38:18','1970-06-15 19:05:20'),
    (UUID_TO_BIN('df4f4236-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2017-10-12','676-763-6059x317','South Justineburgh','2008-10-08 06:32:15','2002-08-29 03:43:00'),
    (UUID_TO_BIN('df4f4531-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1997-06-26','796.707.6381x35329','Ariannaberg','1995-09-29 16:17:08','1988-12-31 00:48:56'),
    (UUID_TO_BIN('df4f4ac2-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1976-03-24','572.742.0145x69191','Angelitaburgh','1993-11-02 05:14:28','1977-02-13 18:08:31'),
    (UUID_TO_BIN('df4f4cf7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1996-07-06','006.747.6537x643','Port Rhettchester','2015-05-14 22:35:59','2007-01-25 15:14:51'),
    (UUID_TO_BIN('df4f53a3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'),'1985-10-11','+83(2)4623742450','North Julianachester','1991-10-26 01:29:21','1985-02-20 06:14:02'),
    (UUID_TO_BIN('df4f5937-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1985-06-01','(353)045-1285','East Madisen','2001-06-12 16:14:41','2016-04-30 05:07:14'),
    (UUID_TO_BIN('df4f5bb2-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2011-03-13','189-161-4623x50609','North Delphiamouth','1983-02-12 10:52:35','1995-01-01 22:44:08'),
    (UUID_TO_BIN('df4f5df6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2015-11-03','217-109-9001x1781','Roobberg','2013-06-04 07:03:22','2001-05-01 03:20:35'),
    (UUID_TO_BIN('df4f5e86-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1980-12-09','1-281-768-9242x1248','Stiedemannburgh','2019-02-19 10:59:35','2015-12-12 20:32:35'),
    (UUID_TO_BIN('df4f603f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1976-01-12','855.956.7471x1566','Boganmouth','2016-02-16 14:41:38','1997-10-20 07:18:03'),
    (UUID_TO_BIN('df4f6542-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2000-11-03','1-964-523-7740','Deltaburgh','2002-01-31 14:44:16','1981-01-27 18:28:03'),
    (UUID_TO_BIN('df4f66f0-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1984-01-31','773-514-3349x08541','Elainamouth','1990-06-24 00:31:21','2021-06-30 00:22:42'),
    (UUID_TO_BIN('df4f6bf4-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2000-02-02','860.546.4790','Savionville','2006-12-12 14:06:09','1986-07-17 11:01:38'),
    (UUID_TO_BIN('df4f32eb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1991-02-12','821-375-1504x3926','South Broderickland','2008-02-17 20:05:15','1991-07-01 21:56:13'),
    (UUID_TO_BIN('df4f367d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2005-04-03','(682)256-2064x98270','Danikastad','1989-06-02 12:04:21','1972-12-26 20:59:02'),
    (UUID_TO_BIN('df4f3ae8-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1989-01-03','03126803842','Santinoborough','2009-04-30 16:31:34','2012-06-25 19:03:25'),
    (UUID_TO_BIN('df4f3ce3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2000-07-02','+21(1)2773399301','Port Blake','2020-10-06 21:59:50','1974-06-29 13:51:15'),
    (UUID_TO_BIN('df4f3d8e-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1998-10-22','+88(8)3789276965','West Dessie','1993-01-07 05:11:23','2001-05-27 20:37:49'),
    (UUID_TO_BIN('df4f3f57-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1990-08-21','1-419-793-9939','East Leslieville','2006-07-06 03:53:30','1996-06-16 07:05:15'),
    (UUID_TO_BIN('df4f4124-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1989-07-18','(068)638-6766x53082','New Andrehaven','2010-05-29 14:25:17','1976-10-07 23:17:25'),
    (UUID_TO_BIN('df4f42d9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2001-07-26','(911)214-8267','Quitzonbury','2003-03-26 05:24:41','2020-02-25 17:27:22'),
    (UUID_TO_BIN('df4f441b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1989-11-30','08002873210','Lake Joseberg','1992-04-22 05:23:50','2015-08-14 19:53:46'),
    (UUID_TO_BIN('df4f47fe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1976-12-10','506.745.9117x3509','West Ryannville','1978-02-11 11:02:55','2006-11-14 16:42:13'),
    (UUID_TO_BIN('df4f4a39-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2008-05-12','1-390-057-5208','Hansentown','2001-12-05 15:24:55','2005-05-08 22:08:13'),
    (UUID_TO_BIN('df4f4d88-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1988-07-16','05896152427','New Sabrina','1985-06-02 07:07:31','2015-08-08 08:49:47'),
    (UUID_TO_BIN('df4f4ea1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2015-04-13','+09(4)1084224017','South Marvinville','1973-01-04 07:24:12','1998-01-24 01:42:49'),
    (UUID_TO_BIN('df4f516c-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2021-08-04','1-911-494-1633x93873','Hauckview','1981-06-01 17:45:57','1975-01-21 06:23:03'),
    (UUID_TO_BIN('df4f5287-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1997-09-21','204.702.4378x631','Altenwerthton','1977-05-15 06:26:08','1989-04-04 15:18:41'),
    (UUID_TO_BIN('df4f554f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2016-05-26','(784)156-8901x95819','South Abbyside','2012-03-28 07:38:38','2008-10-12 19:02:06'),
    (UUID_TO_BIN('df4f55dc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1977-02-12','1-784-360-7855','East Laceyview','2012-04-19 23:18:21','1999-10-03 22:49:00'),
    (UUID_TO_BIN('df4f5815-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1972-05-02','950-524-1647x8677','West Eleonore','2020-01-07 02:44:45','1975-10-24 01:12:06'),
    (UUID_TO_BIN('df4f58a2-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'),'1978-12-13','04158471647','Sanfordmouth','1984-06-29 04:43:44','2017-10-09 03:08:10'),
    (UUID_TO_BIN('df4f5c4b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1997-11-18','812.487.5025','South Alvertahaven','2021-02-03 03:25:53','2007-11-11 03:41:41'),
    (UUID_TO_BIN('df4f60cc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2000-05-12','657.866.1069x45930','North Margaritaview','2008-12-01 17:59:36','2015-04-24 07:01:53'),
    (UUID_TO_BIN('df4f639a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1973-03-10','(156)320-4699x3019','Pfeffertown','2017-05-19 04:16:25','2020-12-29 01:26:36'),
    (UUID_TO_BIN('df4f6780-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1975-06-25','00983589524','South Kenya','2017-09-04 22:37:38','1970-12-24 22:36:36'),
    (UUID_TO_BIN('df4f689f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1998-12-04','(536)128-5759x76039','Lillastad','1985-06-10 16:38:51','1995-03-21 11:02:01'),
    (UUID_TO_BIN('df4f69bb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'1970-10-09','171.590.5728x0495','Lake Micheletown','2016-02-16 21:58:18','1989-05-05 20:17:33'),
    (UUID_TO_BIN('df4f3495-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2000-08-05','893.443.2616x70676','Gislasonville','1984-10-15 11:04:04','1987-12-17 16:45:38'),
    (UUID_TO_BIN('df4f379c-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2014-03-11','00562713307','Lake Chance','2012-04-03 22:49:33','2005-12-13 04:19:16'),
    (UUID_TO_BIN('df4f3b7d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1971-12-05','820.709.5253','Justineview','1993-07-09 20:23:56','2010-06-15 08:39:29'),
    (UUID_TO_BIN('df4f3ebc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2013-05-16','(382)067-3804x1005','New Michelle','1997-07-25 07:49:32','1984-10-25 01:13:56'),
    (UUID_TO_BIN('df4f4651-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1971-06-20','+00(9)7172684069','North Liana','1972-02-12 17:06:41','2007-11-20 20:03:01'),
    (UUID_TO_BIN('df4f488e-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1974-07-02','411.837.3928x6666','Thielview','1979-10-27 19:50:51','1978-10-10 06:03:41'),
    (UUID_TO_BIN('df4f4bdb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'2021-01-19','1-264-288-4123','Port Felipeshire','2005-06-28 10:48:41','1982-03-06 19:52:43'),
    (UUID_TO_BIN('df4f50dc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('d683ccc4-98db-4121-b28f-2c16e13bf94e'),'2002-01-22','655.817.4254x8470','East Austenmouth','2020-03-04 06:27:43','1995-06-11 07:16:29'),
    (UUID_TO_BIN('df4f5785-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('1b00c025-1eaa-4afd-bfc8-42e34283358a'),'1992-07-15','08817818646','North Assunta','1999-06-14 17:28:07','1974-10-21 04:26:17'),
    (UUID_TO_BIN('df4f61e9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1999-01-06','04470193081','Hamillberg','2011-10-22 08:33:08','2009-06-01 06:44:47'),
    (UUID_TO_BIN('df4f6a47-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('50f87d6a-d54b-4159-8a78-e43f23eb2da9'),'1973-12-01','(238)538-8332x597','North Clairmouth','1981-12-21 03:32:07','1979-12-13 20:48:34');

INSERT INTO roles
    (id, name, description)
VALUE
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'), 'admin', 'Администратор'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'), 'level_admin', 'Администратор уровней'),
    (UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551'), 'gamer', 'Игрок');

INSERT INTO permissions
    (`key`, description)
VALUE
    ('user.create', 'Создать нового пользователя'),
    ('user.update', 'Изменить пользователя'),
    ('user.delete', 'Удалить пользователя'),
    ('user.view', 'Посмотреть пользователя '),
    ('word.create', 'Создать новое слово'),
    ('word.update', 'Изменить слово'),
    ('word.delete', 'Удалить слово'),
    ('word.view', 'Посмотреть слово'),
    ('level.create', 'Создать новый уровень'),
    ('level.update', 'Изменить уровень'),
    ('level.delete', 'Удалить уровень'),
    ('level.view', 'Посмотреть уровень'),
    ('notification.create', 'Создать новое уведомление'),
    ('notification.update', 'Изменить уведомление'),
    ('notification.delete', 'Удалить уведомление'),
    ('notification.view', 'Посмотреть уведомление'),
    ('progress.create', 'Создать новый прогресс'),
    ('progress.update', 'Изменить прогресс'),
    ('progress.delete', 'Удалить прогресс'),
    ('progress.view', 'Посмотреть прогресс'),
    ('play', 'Играть');

INSERT INTO roles_permissions
    (role_id, permission_key)
VALUE
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'user.create'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'user.update'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'user.delete'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'user.view'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'word.create'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'word.update'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'word.delete'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'word.view'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'level.create'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'level.update'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'level.delete'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'level.view'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'notification.create'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'notification.update'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'notification.delete'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'notification.view'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'progress.create'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'progress.update'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'progress.delete'),
    (UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1'),'progress.view'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'word.create'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'word.update'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'word.delete'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'word.view'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'level.create'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'level.update'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'level.delete'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'level.view'),
    (UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c'),'notification.view'),
    (UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551'),'play');

INSERT INTO users_roles
    (user_id, role_id)
VALUE
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('96ca743c-c33d-4e54-a902-43bb536a00e1')),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7af2994c-e516-4632-ab7a-645e7e6e173c')),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f35b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3a14-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f6b63-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f6d0a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3528-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f383b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4236-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4ac2-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4cf7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f53a3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5937-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5e86-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f603f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f32eb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f367d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3ae8-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3ce3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3d8e-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4124-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f42d9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f441b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f47fe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4a39-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4d88-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4ea1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5287-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f55dc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5815-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5c4b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f60cc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f639a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f6780-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f689f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f69bb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f379c-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f3ebc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f4bdb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f50dc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f5785-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f61e9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551')),
    (UUID_TO_BIN('df4f6a47-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('79eece72-dd2a-474d-8e74-299c3b877551'));


INSERT INTO c_notification_types
    (id, name)
VALUE
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'), 'info'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'), 'warning'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'), 'danger'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'), 'system');

INSERT INTO notifications
    (notification_type_id, user_id, header, body, additional_information, created_at, updated_at)
VALUES 
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Alice said; but was dreadfully puzzled by the officers of the evening, beautiful Soup! Soup of the m','Sint neque aliquid nulla voluptatum qui et voluptate. Possimus aperiam doloremque libero non. Rerum delectus provident aut qui eaque exercitationem maxime deleniti. In ut non aliquam. Fuga rerum ut accusantium voluptatem doloremque cum.',NULL,'2015-12-08 16:23:53','2000-09-15 21:23:16'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'But they HAVE their tails fast in their mouths; and the March Hare. \'Sixteenth,\' added the March Har','Fugiat laudantium cupiditate sint et modi dolores nihil. Est nihil voluptatem possimus nihil dolores. Quisquam qui repellat nihil velit. Accusantium qui voluptas quibusdam consequuntur sapiente dignissimos nesciunt reprehenderit.',NULL,'2005-12-10 23:11:20','1998-12-03 01:11:08'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),'I said \"What for?\"\' \'She boxed the Queen\'s voice in the distance, and she went on, turning to the Qu','Et repellendus consequatur ea qui ea expedita tempore. Ex sequi repudiandae ut maxime deserunt cumque. Qui voluptas eos ipsum.',NULL,'1989-11-07 05:35:03','1995-09-30 03:32:27'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),'Bill, I fancy--Who\'s to go from here?\' \'That depends a good deal: this fireplace is narrow, to be fo','Aut aut assumenda ratione voluptatem necessitatibus et deserunt. Sequi culpa rerum aut distinctio. Aut enim dolorem explicabo id molestias enim.',NULL,'2017-01-06 17:32:44','1975-09-07 03:22:25'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'I\'m Mabel, I\'ll stay down here till I\'m somebody else\"--but, oh dear!\' cried Alice (she was rather d','Quibusdam consequatur nobis facilis atque. Dolor reprehenderit omnis blanditiis cum non illum. Iusto quia suscipit nam consequatur cum atque doloribus. Assumenda dolorem officiis quisquam.',NULL,'1994-02-08 13:39:28','2004-10-09 08:58:34'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),'Caterpillar contemptuously. \'Who are YOU?\' said the Queen, stamping on the door of which was full of','Labore ut et quaerat accusantium necessitatibus harum aliquid. In consequatur qui velit voluptatem labore labore. Commodi et quis quis delectus sunt minus. A eligendi sunt soluta eius. Vel temporibus architecto ad repellendus quia dolorum suscipit.',NULL,'1995-03-13 23:37:38','1977-12-28 02:50:39'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),'The first question of course you know what \"it\" means.\' \'I know SOMETHING interesting is sure to mak','Exercitationem in aperiam in architecto. Id corrupti nostrum hic velit voluptatem. Nihil laudantium quae placeat voluptate in. Quia odit corporis animi nam autem reprehenderit.',NULL,'2019-07-29 10:01:11','1999-07-19 15:46:29'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),'VERY turn-up nose, much more like a stalk out of the accident, all except the Lizard, who seemed rea','Quisquam neque odio doloremque sed recusandae saepe accusamus. Quam sunt impedit ex velit consequatur eius. A natus delectus rerum ea architecto. Debitis velit odit est doloremque eum quibusdam est.',NULL,'1993-01-05 18:25:00','2017-04-26 07:08:47'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),'Mock Turtle: \'why, if a fish came to the Queen, but she had to stop and untwist it. After a while, f','Fugit eveniet aut non laboriosam aperiam quaerat. Voluptas quaerat velit dolore rem reprehenderit. Autem totam commodi dolores non molestiae.',NULL,'1974-06-11 22:31:02','1974-01-12 03:20:10'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),'Lizard, who seemed to quiver all over with diamonds, and walked two and two, as the rest of the jury','Dolore odit sed assumenda beatae labore et nihil. Repellendus porro accusantium nihil dolor aliquam et a. Sed eaque natus adipisci nemo et est nisi. Reprehenderit sint fuga quis velit quasi ex aperiam. Quis velit nesciunt voluptatum dolorem saepe.',NULL,'2010-03-06 11:37:08','1989-07-05 12:39:32'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),'Alice; but she could not tell whether they were nice grand words to say.) Presently she began very c','Laudantium ullam quia dolor molestias nobis sint. Voluptatem deleniti consequatur maxime veritatis officia eum. Deserunt fugit aut aut quia ab nam est. Non enim et qui iure quisquam.',NULL,'1971-03-11 16:22:31','1974-03-24 09:02:46'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'),UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),'Gryphon, half to herself, \'I wonder what I used to call him Tortoise--\' \'Why did you begin?\' The Hat','At exercitationem dolorem dolorem eligendi. Ipsam natus consequatur distinctio voluptatibus non. Quam ut sit sed error aut enim. Facere culpa qui iusto dolorum natus beatae enim.',NULL,'1984-10-23 11:27:21','1987-04-23 03:25:40'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),'Just as she couldn\'t answer either question, it didn\'t sound at all what had become of me? They\'re d','Facere nostrum quidem commodi nostrum. Voluptatum eos quibusdam eius aut. Repellat sed porro velit delectus et. Impedit delectus neque reprehenderit necessitatibus perspiciatis.',NULL,'2000-09-13 11:49:09','1981-05-27 03:37:09'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),'Cat, as soon as she could, and waited to see that she still held the pieces of mushroom in her life;','Distinctio tenetur maxime quasi occaecati repellat. Odio cumque incidunt nihil omnis voluptate quia. Omnis quis facilis tenetur et quia officia.',NULL,'2020-11-27 16:53:17','1970-10-12 06:25:20'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),'March Hare. \'I didn\'t mean it!\' pleaded poor Alice in a languid, sleepy voice. \'Who are YOU?\' Which ','Error et et commodi eos. Nulla saepe numquam blanditiis ut est vitae.',NULL,'1985-01-27 08:41:11','1992-04-15 04:00:40'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),'So she sat still just as I used--and I don\'t believe you do either!\' And the moral of that dark hall','Et est quo aliquid. Non perspiciatis omnis saepe eos odit veniam aut. Et recusandae repellat incidunt modi est dolor et. Molestias et qui non est aut possimus aut.',NULL,'2000-02-15 18:03:50','1978-04-13 10:17:36'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'),UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),'I hadn\'t mentioned Dinah!\' she said to herself \'Now I can do no more, whatever happens. What WILL be','Reiciendis inventore cum sint occaecati odio voluptas perferendis hic. Cum velit ullam atque eum dignissimos ut est molestiae. Ut et sint dolore possimus est. Aut et consectetur eveniet.',NULL,'2014-07-21 05:28:47','1971-02-03 23:24:56'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),'I ever heard!\' \'Yes, I think it so VERY remarkable in that; nor did Alice think it was,\' the March H','Accusantium odit aut recusandae commodi. Nemo quae nam perspiciatis dolores voluptatem magnam asperiores. Vel non consequatur sit est omnis pariatur ut.',NULL,'1981-08-12 07:56:16','2013-08-02 14:30:10'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),'Mouse, in a tone of great relief. \'Call the first verse,\' said the Queen. An invitation for the Dorm','Quos exercitationem id nemo occaecati. Molestiae quia harum eaque animi nisi. Autem dolorem libero inventore totam et aut aliquam quae. Impedit expedita voluptatibus consequatur.',NULL,'1992-11-19 06:06:49','2014-03-11 00:11:57'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),'Cheshire cats always grinned; in fact, a sort of chance of this, so she went round the thistle again','Reiciendis quis voluptas harum ipsum doloribus ducimus velit itaque. Sapiente omnis est officiis quaerat quisquam. Expedita rerum recusandae facere. Omnis aperiam quia sapiente iure debitis.',NULL,'1996-07-14 19:36:21','1999-09-21 17:39:23'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),'Mock Turtle replied in an agony of terror. \'Oh, there goes his PRECIOUS nose\'; as an explanation; \'I','Qui eius repudiandae quasi et accusantium. Veritatis itaque iusto aspernatur quibusdam sequi fugiat est. A non voluptatum placeat fuga minima.',NULL,'1981-02-23 14:22:21','2017-07-03 10:54:27'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Mock Turtle, and to stand on your shoes and stockings for you now, dears? I\'m sure I don\'t take this','Aut beatae quod libero incidunt dolores enim eum. Nobis consequatur accusantium et eos ad incidunt sed. Adipisci sit ratione dolores et voluptas aut. Eius rerum optio repellendus soluta.',NULL,'1982-02-08 07:43:41','1976-01-03 03:12:19'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),'Queen of Hearts were seated on their slates, and then the Mock Turtle sighed deeply, and began, in a','Voluptatem voluptatum omnis sed suscipit neque aliquam labore commodi. Nihil ex saepe perferendis veniam sit. Aperiam optio voluptate ut libero saepe quas ut. Vitae aliquid odit enim recusandae.',NULL,'1997-01-25 07:31:44','2020-12-18 20:02:03'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),'Duchess by this very sudden change, but very politely: \'Did you speak?\' \'Not I!\' said the Cat, and v','Dolor sunt nam hic officiis repellendus et. Omnis accusantium enim ut earum ex provident earum. Laboriosam iste explicabo fugit atque velit. Consequuntur ut dolor similique quis itaque.',NULL,'1998-01-12 17:50:08','1994-06-25 20:34:13'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),'You\'re a serpent; and there\'s no harm in trying.\' So she set off at once to eat the comfits: this ca','Recusandae harum ex et voluptatum. Ut perferendis aliquam qui qui natus. Eveniet perferendis itaque minima et alias sit sint. Quis aperiam sunt quae quas repudiandae.',NULL,'1983-09-02 16:49:00','1980-08-14 04:26:09'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),'It doesn\'t look like it?\' he said, \'on and off, for days and days.\' \'But what happens when you come ','Laborum voluptas voluptatum neque tempora. Et eaque et placeat ad ipsa nihil impedit repellat. Exercitationem ea qui provident itaque.',NULL,'1991-10-19 06:53:40','1976-06-20 10:16:01'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),'Cat. \'I\'d nearly forgotten that I\'ve got back to the Gryphon. \'Of course,\' the Gryphon only answered','Hic repellat ut odio qui omnis nemo. Ex fuga et ea ut minima nisi vitae. Doloribus soluta consequatur et. Facilis libero amet magni cupiditate culpa similique hic.',NULL,'2001-07-08 01:04:09','2000-07-09 09:53:05'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'),UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),'TWO little shrieks, and more faintly came, carried on the floor: in another moment down went Alice l','Excepturi perspiciatis quaerat nihil quia beatae similique ut. Expedita occaecati est amet odio excepturi rerum impedit iusto. Dolor quo dolores nisi dolorum.',NULL,'1991-08-08 09:39:20','1991-04-13 15:00:28'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'ALL RETURNED FROM HIM TO YOU,\"\' said Alice. \'Of course it is,\' said the Hatter, \'when the Queen was ','Accusamus reiciendis dolores ratione est voluptas. Odio ad labore eum velit distinctio natus. Voluptatem et laboriosam sit delectus. Blanditiis qui cum quod omnis.',NULL,'1983-02-09 17:06:18','1991-12-25 07:51:16'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'THAT!\' \'Oh, you can\'t be civil, you\'d better leave off,\' said the Mouse, sharply and very neatly and','Non accusantium ab corrupti est dolore qui. Consectetur aut quisquam atque iusto quia. Blanditiis iure quae alias ad.',NULL,'1991-04-01 10:46:06','2013-05-04 16:15:15'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),'March Hare was said to herself, (not in a minute. Alice began telling them her adventures from the s','Animi in harum et nobis possimus consectetur est. Laboriosam omnis aut minima animi. Adipisci enim facere quisquam non aspernatur et nemo.',NULL,'2011-07-16 14:48:42','2019-09-28 03:50:17'),
    (UUID_TO_BIN('2c1a558e-d6e4-43d4-a08f-daea622c3af5'),UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),'King. (The jury all brightened up at the frontispiece if you like,\' said the King. \'It began with th','Sunt aspernatur aut et inventore et ut. Ea et harum labore voluptatem. Earum occaecati atque deserunt quia explicabo modi.',NULL,'1975-02-20 20:38:06','1977-06-16 00:28:53'),
    (UUID_TO_BIN('a7694d32-5d1c-4248-b095-b1927d2e1a0f'),UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),'I shall have somebody to talk to.\' \'How are you getting on now, my dear?\' it continued, turning to t','Beatae totam aspernatur dolorem provident labore quasi repellat. Incidunt cumque qui qui reiciendis ducimus aspernatur officia. Aut officiis distinctio itaque consequatur recusandae similique quasi. Eveniet iste fuga repellendus non et quod. Eaque at autem et ipsum officiis cupiditate.',NULL,'2002-10-08 12:05:56','1977-02-21 06:09:55'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),'King said, for about the reason and all the things being alive; for instance, there\'s the arch I\'ve ','Ut nulla ea iure enim. Assumenda a non quia quia omnis reiciendis. Sint exercitationem rerum sapiente nihil molestiae qui. Et sint id distinctio veniam hic repellendus.',NULL,'2003-11-25 04:59:05','2002-01-30 13:30:02'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),'Queen, turning purple. \'I won\'t!\' said Alice. \'Why, there they are!\' said the Duchess; \'and that\'s w','Cum pariatur officia sequi fugiat iure eum quia reprehenderit. Ratione ut aut sapiente culpa voluptatem aspernatur. Fugit inventore deserunt animi rerum tempora. Voluptatem consequatur ut voluptatem quasi nisi.',NULL,'2014-11-10 18:32:31','2007-06-11 01:24:07'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),'I\'m a hatter.\' Here the other birds tittered audibly. \'What I was going to leave off this minute!\' S','Ex a incidunt officia occaecati et quaerat similique facere. Illum distinctio molestiae reiciendis enim labore. Impedit explicabo mollitia rerum rerum tenetur.',NULL,'2017-09-29 23:38:47','2013-06-12 08:26:18'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'),UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),'Alice; \'I must be removed,\' said the Gryphon, and the m--\' But here, to Alice\'s side as she could, f','Officia eos sed accusamus quod similique qui minima ipsum. Aliquam molestiae reprehenderit nesciunt alias.',NULL,'1982-06-01 18:50:30','1999-04-28 06:10:59'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),'And he got up and beg for its dinner, and all of you, and listen to her, one on each side to guard h','Explicabo aliquam sed ea ducimus consequatur dolores quia aut. Soluta neque rerum sed aut. Incidunt accusantium itaque velit voluptas mollitia.',NULL,'2000-03-22 23:23:42','1970-08-27 23:41:34'),
    (UUID_TO_BIN('db77c6fe-76ed-4b3c-8899-945f6bf02824'),UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),'Alice. \'Did you speak?\' \'Not I!\' he replied. \'We quarrelled last March--just before HE went mad, you','Ratione velit nam quia vel placeat error. Aut eveniet inventore esse quod ipsum sit veniam. Provident et sint nostrum culpa expedita repudiandae necessitatibus nostrum. Porro omnis qui qui sed.',NULL,'1980-11-29 13:36:31','2020-05-02 16:01:10'),
    (UUID_TO_BIN('03dfa488-fa98-4a1b-91bf-ff0eeabd7799'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Has lasted the rest of it at all,\' said the Hatter. He came in sight of the crowd below, and there s','Earum non beatae sed ex deserunt. Incidunt eaque tenetur fugiat consequatur aliquid sit. Expedita fuga saepe assumenda dignissimos quis quod commodi enim.',NULL,'1987-12-21 16:29:23','1980-08-02 22:40:32');

INSERT INTO levels
    (id, number, description, money_after_passing, created_at, updated_at)
VALUE
    (UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'), 1, 'Dolor assumenda iusto modi cupiditate. Omnis voluptatem fugit nam repudiandae facilis cum iste. Quisquam sapiente et ipsa voluptatem dolor nihil consectetur. Animi consequatur temporibus non perferendis architecto laborum aut consequuntur.', 82668, '1998-06-08 09:00:57', '1985-02-25 20:00:59'),
    (UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'), 2, 'Minus aut commodi voluptatem in ut sequi ut vitae. Ducimus debitis recusandae et accusantium. Amet ipsam enim enim repellat dolores quo.', 16777215, '1999-01-06 19:48:26', '1978-01-24 15:33:24'),
    (UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'), 3, 'Quibusdam possimus dolor aut nulla sunt. Nihil sed necessitatibus provident qui iste nobis debitis. Molestias quod sit at atque consequatur incidunt omnis illum. Nihil et quam odio ipsum.', 26686, '1998-10-09 06:21:29', '1970-12-17 15:47:30'),
    (UUID_TO_BIN('0e0e005d-782d-3f44-a193-2f9939cfb299'), 4, 'Ad labore omnis quisquam delectus corporis dolor saepe aut. Et libero laborum labore ipsa est dolores. Possimus delectus aliquam dolorem at libero incidunt. Ab ab itaque culpa debitis odit perferendis.', 464824, '2017-06-17 18:32:52', '2002-04-06 14:07:49'),
    (UUID_TO_BIN('12aad9ce-2d5d-39e1-82dd-71cf070da19a'), 5, 'Ea sapiente aut voluptas quos. Laborum architecto ipsam sit reprehenderit assumenda molestias dignissimos dolores. Pariatur numquam quasi pariatur vitae aut.', 16777215, '1998-12-27 01:44:43', '1994-08-17 06:03:57'),
    (UUID_TO_BIN('13114d64-64fa-3233-be30-f868ff56d62d'), 6, 'Velit pariatur natus eligendi optio ut dolores. Mollitia ab cupiditate voluptatibus eaque reiciendis voluptatem nihil. Saepe incidunt cum architecto nisi excepturi ea molestiae. Non qui consequatur non rerum.', 0, '2014-01-13 10:45:08', '2000-11-24 18:46:20'),
    (UUID_TO_BIN('1384c326-f501-3f09-89ad-e787b87abae1'), 7, 'Minima cupiditate incidunt omnis velit. Harum officiis quia magni quam voluptate est.', 9963, '1971-09-01 15:03:23', '1991-03-31 21:38:04'),
    (UUID_TO_BIN('17b310a2-f96e-3de8-8b2c-51215c81b791'), 8, 'Placeat commodi aut sit officia minus ea. Deleniti modi optio in laboriosam. Voluptas sapiente quae modi quia soluta ea.', 6, '1997-12-19 16:02:22', '1971-06-17 17:23:10'),
    (UUID_TO_BIN('1b1942d9-03e7-326c-a61b-bdc7143eb7d5'), 9, 'Cumque maiores qui optio culpa hic quasi vel. Qui nihil et eos mollitia. Accusantium numquam incidunt asperiores consequuntur.', 2703006, '1984-08-03 03:24:29', '1988-10-18 06:34:52'),
    (UUID_TO_BIN('1df54689-aa00-343d-96c7-117021e42092'), 10, 'Dolorum nobis ut doloremque omnis iusto consequatur possimus. Similique quia placeat id labore laborum labore quia quis. Et nostrum est repudiandae sequi dolorum.', 0, '1989-03-06 08:10:06', '1979-11-30 20:59:23'),
    (UUID_TO_BIN('1f74f2e7-1af5-37fa-9d49-4484b7b3a823'), 11, 'Et qui molestiae tempore ullam. Explicabo blanditiis laborum eos voluptates architecto nobis. Mollitia incidunt est porro quis rerum reiciendis. Voluptas nulla unde et ab ut.', 16777215, '1995-10-23 20:08:41', '1986-05-04 00:18:38'),
    (UUID_TO_BIN('2458f635-c715-37ac-bb63-61b6576b1f5e'), 12, 'Adipisci est fugit voluptatem dolores. Nam maxime doloremque qui odio facilis excepturi nam. Tempore voluptatem unde impedit architecto tempore ex nihil. Tempora et ut minus tempora aut accusamus deleniti.', 280, '1995-09-07 00:25:02', '2006-11-08 11:23:43'),
    (UUID_TO_BIN('251bf632-a419-3791-9c4e-fd2087b36ce3'), 13, 'Nostrum fugiat ab esse porro omnis quam autem. Dolor omnis quo deserunt vitae. Et odit ea ratione sed delectus magni inventore minus.', 16777215, '1978-11-05 19:43:22', '1972-08-31 06:51:29'),
    (UUID_TO_BIN('27047e3c-e2a5-3013-aadf-c00651013506'), 14, 'Nam qui dolorum qui quam inventore repudiandae numquam. Et laborum quis dolorem aliquam. Porro quisquam voluptatem quo sapiente corrupti praesentium. Repellendus enim est quisquam iure porro. Reiciendis numquam totam earum nesciunt neque repudiandae cupid', 0, '2004-08-24 05:03:19', '2000-12-27 01:19:52'),
    (UUID_TO_BIN('29489b6f-cb23-3951-9c2a-c99ecd213a96'), 15, 'Et accusamus praesentium perspiciatis sint. A aliquid eveniet voluptatibus quo totam earum et. Consequatur dolore repudiandae fugiat qui odio odio.', 9637, '2010-01-25 09:49:27', '1995-07-14 20:28:00'),
    (UUID_TO_BIN('2be267e8-4338-3b02-9317-e3b9f36b6eae'), 16, 'Magni iusto at vitae et recusandae et. Ipsum porro itaque ullam deleniti. Soluta rerum aperiam alias magnam qui dolores cupiditate deserunt.', 16777215, '2019-07-18 23:25:01', '1990-10-28 10:26:15'),
    (UUID_TO_BIN('2f492b44-4627-3dfb-b0a7-0aab483343e2'), 17, 'Accusantium qui eveniet fuga sit id. Accusamus quidem quia ut praesentium et et. Temporibus dolor quam eius et eius.', 2382, '2012-02-09 19:26:14', '2006-05-11 03:28:07'),
    (UUID_TO_BIN('3100f67f-6589-3d97-86f7-85e7eb579128'), 18, 'Exercitationem nulla cumque sed doloremque unde natus odit. Aut ut magnam error nisi laboriosam cumque. Aliquid laudantium voluptate possimus est placeat.', 3873, '1979-05-30 18:32:54', '2017-11-15 21:10:02'),
    (UUID_TO_BIN('31c9f6f4-e1c8-3ff6-b18e-a952e9ad377b'), 19, 'Facere reprehenderit dolor et ex provident omnis tempora. Amet iste dolorum architecto in ut distinctio. Tenetur accusamus consequuntur voluptatibus ut.', 153, '1997-08-04 10:11:45', '1981-09-05 07:03:10'),
    (UUID_TO_BIN('33ed4601-cff3-37a5-a44f-8646a293fd6a'), 20, 'Quaerat nisi molestiae minima nihil qui corporis corporis. Tenetur saepe laborum aut est voluptas sit. Omnis harum voluptatum sint vel necessitatibus eos.', 8, '2019-07-09 14:38:49', '1979-03-27 21:19:42'),
    (UUID_TO_BIN('36788476-cf15-31d6-a241-4fa74cca3433'), 21, 'Itaque debitis ipsa tempore sit voluptate illum quis. Est sunt minus nesciunt distinctio enim. Hic est dicta vitae veritatis. Consequatur harum placeat velit ad nobis inventore.', 782646, '2021-10-09 22:39:32', '1994-10-27 15:24:23'),
    (UUID_TO_BIN('36930d4e-ecc2-3d22-84c5-cd9fcce99e03'), 22, 'Accusantium quis libero illo labore doloribus. Aut rerum ex est consequatur qui nobis saepe harum. Deserunt voluptatem voluptates mollitia. Repellat iste voluptates ratione voluptas ex.', 0, '2003-06-17 17:56:49', '1973-09-29 03:51:40'),
    (UUID_TO_BIN('371216fb-936c-3d6c-a359-4c54b0b6c19a'), 23, 'Qui ut distinctio officia. Consequatur perspiciatis iste vero veniam magni aut voluptate. Maiores commodi in iure. Beatae id est saepe enim aperiam ipsum ab.', 7, '1985-01-15 21:44:30', '1990-02-05 06:23:31'),
    (UUID_TO_BIN('3748a4ba-4621-32d5-909f-c5e6ed604792'), 24, 'Facilis voluptatem voluptatem ut atque voluptatem. Aut tempore corrupti architecto et et ex. Sapiente beatae quidem consequuntur quia eveniet. Enim hic modi eum dolorem et impedit.', 710662, '2002-01-24 23:22:55', '1989-01-16 19:02:08'),
    (UUID_TO_BIN('37892af5-b573-39af-b182-f9fe68a1e117'), 25, 'Fuga labore ratione laboriosam rem rerum. Quasi dignissimos et consequatur provident cupiditate. Sit dolorum accusamus praesentium porro ipsam animi deserunt aut.', 638601, '2019-01-19 00:38:41', '1988-10-13 22:17:57'),
    (UUID_TO_BIN('39ddec47-4c25-342f-959e-cfc19248a53d'), 26, 'Dolor voluptas aliquam saepe non. Quo minima dicta aspernatur sed praesentium molestias ea. Impedit fugiat exercitationem cum deserunt sequi consequatur culpa blanditiis. Rerum laudantium commodi temporibus reiciendis vero optio sint voluptatem.', 611647, '1983-05-21 06:54:24', '2003-10-01 06:41:00'),
    (UUID_TO_BIN('3ae7322b-8cc3-3452-8244-a512f2212855'), 27, 'Rem qui natus consectetur provident explicabo. Doloribus provident non consectetur accusantium odit voluptatibus. Aut eum aut eum repellendus doloremque ab.', 6084021, '1999-08-17 04:14:25', '2012-06-29 09:19:19'),
    (UUID_TO_BIN('3e932583-18bd-3818-8aae-2ddeb722851f'), 28, 'Unde sit odio magni. Sequi doloribus consequuntur deleniti et dolorum velit quidem qui. Quia dolores excepturi nobis esse aut aut molestiae. Est dolorum sed ipsum qui exercitationem ipsum eos. Non nihil architecto impedit aut quo nostrum dolore.', 973, '2010-08-23 18:00:24', '1984-11-28 08:17:00'),
    (UUID_TO_BIN('3ee10fb0-1ef2-34b5-9d3d-20d0a67791f0'), 29, 'Dignissimos qui aut quia omnis natus nobis. Dolorem aut eligendi pariatur deserunt sit. Nulla ex architecto harum quasi in. Consequatur eos quae nihil qui incidunt.', 0, '2012-09-02 02:51:30', '2015-05-27 10:04:42'),
    (UUID_TO_BIN('411eebc0-4675-3f6a-8944-8fe91e78a0d2'), 30, 'Aliquid velit sunt repellendus eius libero quo rerum. Consequatur aut occaecati aspernatur dicta perspiciatis nemo accusantium. Officiis illum voluptatum vero ea. Qui iure consequatur dolores vero et.', 586484, '2002-09-24 20:02:45', '2000-10-09 22:51:05'),
    (UUID_TO_BIN('429b4014-4a70-3c9d-a2ea-e663fa044751'), 31, 'Quo ipsa voluptatum possimus illo sit ex. Esse similique quasi cum est modi vitae vero. Ut accusantium doloribus repellat excepturi voluptatibus minus. Molestiae ut incidunt eaque ut repudiandae.', 5, '1990-09-02 00:16:39', '1983-07-17 07:34:04'),
    (UUID_TO_BIN('46220823-1401-32b4-9bc5-1f2e0acd5863'), 32, 'Temporibus fugit recusandae quisquam blanditiis sint dolor sint. Et quaerat quo dicta aspernatur. Nam praesentium excepturi consectetur repudiandae in dicta reprehenderit voluptatem. Aliquam sed iusto qui non consectetur aspernatur. Sunt ut quaerat placea', 1635834, '2016-09-11 14:27:09', '2012-07-27 16:31:59'),
    (UUID_TO_BIN('46500ec2-3c78-3cc9-a447-1db07be1eefd'), 33, 'Accusantium quo ad sit id ut corporis. Commodi soluta sit quia aliquam. Deleniti minima voluptatibus cumque.', 0, '1999-09-24 22:16:01', '2009-03-13 22:30:39'),
    (UUID_TO_BIN('49b4f1c8-c4a1-35b0-a263-d90ef92cd337'), 34, 'Et laborum et non ab iusto. Excepturi aliquam et exercitationem mollitia ipsa. Eos ut veniam aut aspernatur tempora nemo tempore. Quisquam nisi cupiditate nesciunt hic aut aliquid.', 1, '1982-11-17 20:08:58', '1977-09-16 08:43:00'),
    (UUID_TO_BIN('51d4ad78-6fc2-3e66-950a-8a741a272a36'), 35, 'Sunt ut consequuntur consequatur omnis perferendis aspernatur vel. Dolorum perspiciatis aut fugiat. Explicabo qui et aliquam ut quia. Ullam alias corporis enim architecto rem.', 6, '2003-09-22 17:05:34', '1976-04-17 00:11:34'),
    (UUID_TO_BIN('555b177a-0942-37d9-b00f-e1771feee3aa'), 36, 'Libero natus quisquam mollitia ut quo consequuntur. Porro distinctio excepturi quia veniam. Iure sint commodi in.', 16777215, '1971-06-15 20:51:12', '2007-06-11 10:22:36'),
    (UUID_TO_BIN('57e0b8a4-7e5a-3e8f-8879-a380ae93ea49'), 37, 'Voluptas non quasi tempora officia qui fugiat voluptatem. Non est minus non natus ea.', 81219, '1990-03-01 17:35:33', '1978-09-29 05:24:05'),
    (UUID_TO_BIN('598ee757-4070-3206-bc00-dfbbebdac8fb'), 38, 'Voluptates expedita sed sint et. Veritatis autem sapiente autem quibusdam rerum deleniti. Consequuntur magnam inventore possimus exercitationem.', 768, '1999-11-15 02:44:15', '2013-03-20 15:26:25'),
    (UUID_TO_BIN('5a3153e7-89d7-38f9-ab4b-8c5c2780f294'), 39, 'In voluptas est deleniti praesentium et consequatur. Sequi odio maiores doloremque sed non illum. Nostrum laboriosam fugit dolor et harum itaque quia.', 16777215, '1989-04-02 05:10:39', '1980-08-27 02:18:57'),
    (UUID_TO_BIN('5b48de1e-de0b-35fc-a77b-bc2107c3f45d'), 40, 'Aspernatur aut dolore autem quasi quia et. Qui sint excepturi quae voluptate ullam sit consectetur. Nihil laborum accusamus dolor tenetur cupiditate reprehenderit.', 16777215, '1972-09-28 15:12:58', '1986-07-20 10:50:19'),
    (UUID_TO_BIN('5ba04e97-d499-324a-a6b4-89ef185e8b28'), 41, 'Sapiente alias facilis eaque voluptas voluptatem accusantium ea. Et sint exercitationem iusto similique nulla itaque. Rerum magni molestias est nulla dolorem consequatur id et.', 98007, '1981-12-16 19:18:16', '2009-06-08 05:08:41'),
    (UUID_TO_BIN('5dbd1688-88e5-36e7-8d76-604e4aa34725'), 42, 'Itaque sunt est saepe voluptas sapiente. Doloribus nesciunt nesciunt enim unde eaque. Consequatur ipsa ut optio voluptatem aut ea dolorem. Perspiciatis dolores eligendi sed alias.', 0, '2007-02-08 19:35:53', '1977-03-26 03:33:19'),
    (UUID_TO_BIN('5f8caeb7-6e92-39a7-97c2-127bd8f3304e'), 43, 'Beatae id blanditiis quidem ab veniam ab consectetur reiciendis. Explicabo beatae quos non odit deleniti eaque maxime. Corrupti non adipisci ut dolores beatae et. Quod expedita consequatur porro occaecati quia.', 16777215, '1986-07-19 00:12:33', '1990-05-05 01:38:07'),
    (UUID_TO_BIN('644211cc-7d9f-33f3-841b-58873949f3ac'), 44, 'Consequuntur consequuntur ratione quo libero possimus voluptates. Porro nihil ut officia perferendis voluptatem iusto quisquam. Illum tenetur maiores sit expedita.', 16777215, '1977-09-22 07:54:01', '1996-07-16 09:26:03'),
    (UUID_TO_BIN('65e0ad64-dabf-37ea-a398-87692422bb65'), 45, 'Voluptas dolore sit et dicta itaque deserunt. Incidunt voluptas enim quas sed corrupti inventore doloremque. Ut delectus autem architecto rem qui.', 6944595, '2020-01-05 08:30:32', '2017-07-06 23:28:21'),
    (UUID_TO_BIN('66e78376-be52-3de7-bfa0-ae29bdfa4831'), 46, 'Officia nostrum eos cupiditate dolorum. Ut ut reprehenderit aspernatur inventore minima. Cum non est amet nisi.', 1187074, '2005-10-26 19:07:07', '1995-05-13 07:10:39'),
    (UUID_TO_BIN('6b472502-cdf3-399e-a591-ed2ce5ea7ebd'), 47, 'Porro eligendi eum praesentium ullam odio accusantium fugiat. Ipsa aliquid rerum in voluptatem amet sed incidunt. Quae qui repellat autem. Voluptatem sed aut et eveniet.', 3505391, '2006-11-24 20:47:36', '2003-03-01 13:31:41'),
    (UUID_TO_BIN('6df7fe75-3ad4-307e-9005-6584e0b3724c'), 48, 'Possimus dolorem eos dolore. Dolor saepe exercitationem at ad sint. Tempora enim consectetur odio rerum voluptatem molestiae voluptatibus quia.', 0, '2012-08-27 12:23:58', '1970-09-01 20:54:10'),
    (UUID_TO_BIN('6f7eff03-f155-3a50-8aa9-73404b7d4145'), 49, 'Eum nihil ipsam sit eius reprehenderit itaque est. Illum et rerum iste ut. Quia distinctio neque numquam sit ut.', 16777215, '2014-08-07 05:26:30', '1978-04-27 03:11:56'),
    (UUID_TO_BIN('737b4b2c-2a1d-3238-bb2d-0bd511c07eea'), 50, 'Sed quia laborum quos laborum magnam. Corrupti explicabo officia necessitatibus mollitia. Beatae non soluta dolorem velit sapiente. Enim ea modi ducimus velit debitis consequatur quidem.', 692, '2008-07-22 23:21:30', '1980-06-01 12:01:43'),
    (UUID_TO_BIN('75510dd6-a2d4-3e9e-af04-34147ec07745'), 51, 'Adipisci adipisci neque perspiciatis sequi laboriosam perferendis fuga. Est porro soluta eius sint sed sed molestiae. Sequi quidem reprehenderit omnis voluptas.', 913088, '2020-10-05 08:56:34', '2004-04-10 18:24:59'),
    (UUID_TO_BIN('77e0ce0d-8f7d-3c3d-ab08-cb3dc9ced720'), 52, 'Dolores omnis eos nam omnis. Suscipit autem autem voluptas molestias repellat. Voluptatem sequi sint dicta odio ut quo. Aut amet sed in veritatis adipisci deleniti sed.', 16777215, '1987-08-16 05:05:41', '2020-02-18 07:36:41'),
    (UUID_TO_BIN('77f90c07-1a04-3fa6-94da-ca122ba65fe6'), 53, 'Ipsam porro ullam sed nobis qui possimus ad. Officia veniam eaque maiores omnis.', 16777215, '2013-11-10 03:45:55', '1987-05-20 09:37:55'),
    (UUID_TO_BIN('7aaa3a36-17ca-3fbf-b703-42e8ddb44f5c'), 54, 'Commodi ut esse nemo velit itaque harum earum. Consequatur provident et corrupti nulla. Voluptates quisquam vitae laudantium harum earum necessitatibus aperiam. Corrupti animi et voluptate exercitationem quia omnis.', 0, '1994-07-07 23:31:09', '1995-06-19 12:37:24'),
    (UUID_TO_BIN('7ab3721c-e0fd-382e-b4b3-446834fae952'), 55, 'Et ut maxime numquam ipsa eum. Magnam nostrum error est deserunt blanditiis ut exercitationem. Aut voluptatum quod sunt.', 7866, '1997-12-11 16:21:42', '1992-06-22 17:34:39'),
    (UUID_TO_BIN('7ac4cf93-1932-310f-bb2d-3625787c12ba'), 56, 'Alias sunt blanditiis voluptatibus non sit eius aut. Atque qui suscipit odit dolor.', 396, '1983-10-06 16:10:15', '1979-12-31 13:38:38'),
    (UUID_TO_BIN('7b5c5450-e31f-375b-a299-65004b5c97a2'), 57, 'Natus rerum incidunt repudiandae ducimus quam. Ut voluptatem est facere ullam reprehenderit quasi. Qui magni architecto tempore incidunt.', 5933312, '1982-02-18 09:39:45', '2018-04-04 10:41:36'),
    (UUID_TO_BIN('830e7049-7bf6-3b91-bea4-e7bdba523236'), 58, 'Et nesciunt eius soluta odio sunt dolor qui. Aut accusamus quibusdam sequi vero nemo non qui. Molestiae et enim vel qui. Vero aspernatur deserunt facilis pariatur saepe quis qui. Animi perspiciatis est nostrum ut est asperiores voluptatem quam.', 0, '1980-06-30 06:59:51', '2009-09-04 16:33:39'),
    (UUID_TO_BIN('85c9d451-fa17-303e-8f00-90ae96596492'), 59, 'Illo minima maiores reprehenderit ipsa deserunt. Sit vel necessitatibus illo incidunt corrupti ut sint doloremque. Aut ullam aut quis autem dolorem saepe omnis. Sed maxime in atque nesciunt architecto nam.', 16777215, '2020-08-24 11:13:47', '1988-02-08 01:02:23'),
    (UUID_TO_BIN('87341aa3-460a-3298-a68b-c8c0c92027d1'), 60, 'Labore cum facere occaecati aut. Et ea inventore nostrum. Mollitia ea aperiam et ut praesentium.', 2862, '1995-09-03 02:48:31', '1978-07-25 00:29:22'),
    (UUID_TO_BIN('8e3469a5-9674-3220-a738-8a5f80650e1f'), 61, 'Id earum velit est occaecati. Ut aut distinctio eligendi et ut consequatur. Officia velit recusandae fugit ea consequuntur ut.', 1965, '1993-05-19 10:52:55', '2003-10-18 13:09:18'),
    (UUID_TO_BIN('8f589e51-8765-3332-ade8-af125d718c73'), 62, 'Qui iure eum sint corporis saepe consequuntur et aut. Placeat in cupiditate nesciunt consequatur ad reprehenderit vero. Vitae quos aut commodi voluptatem odit.', 0, '1992-08-19 19:33:27', '1998-05-14 19:32:24'),
    (UUID_TO_BIN('94359f2d-4c9a-32d6-88e3-74360abd7fc3'), 63, 'Enim quia molestiae consequatur ab accusantium sint repudiandae quae. Consequatur officia doloremque quaerat illo repellendus. Atque atque temporibus doloremque ad sequi. Sed fugiat et eum voluptas sit quia.', 6353, '1971-07-25 04:01:07', '1982-12-02 07:40:06'),
    (UUID_TO_BIN('95ce8def-d333-389f-9f6e-ad1ad7949d3d'), 64, 'Soluta et et occaecati vitae perferendis eos et. Alias ut iure molestiae natus. Qui cupiditate velit molestiae. Molestiae inventore debitis temporibus ratione et.', 3656, '2014-09-03 21:13:32', '2013-08-31 18:48:07'),
    (UUID_TO_BIN('97adbc3d-bdf9-3e2a-9964-99ef441d0e03'), 65, 'Voluptas voluptatem deserunt minus ad qui. Illum quis ratione qui. Ipsum assumenda pariatur ut sapiente quia eius sed.', 2, '1995-03-22 09:09:59', '2002-09-08 02:15:42'),
    (UUID_TO_BIN('987b1e4d-ebfc-3edb-b33f-498908963980'), 66, 'Ab ut aliquid sunt dicta nisi id. Temporibus sunt aut aut aut aliquid ipsa necessitatibus. Sint molestias fuga ipsa nulla quibusdam molestiae perspiciatis.', 16777215, '1992-03-26 05:19:33', '2015-09-13 03:01:23'),
    (UUID_TO_BIN('9941512b-68e7-3330-9d04-ca4e41107701'), 67, 'Soluta adipisci ipsum cumque non voluptas ad possimus. Quas officiis accusamus et est vitae consequatur aut. Quae aut dolorum voluptatem beatae aut.', 78, '2015-04-10 21:53:32', '1980-07-03 11:05:33'),
    (UUID_TO_BIN('9c5a6341-7ce2-3c6a-82cb-043d276d83c0'), 68, 'Nostrum reiciendis provident consequuntur eius qui est amet. Doloremque sequi optio atque quod ipsa. Sapiente reprehenderit id magnam aliquam eum.', 96555, '1987-04-14 11:49:07', '1998-07-26 05:49:54'),
    (UUID_TO_BIN('9d2d1b11-49f0-3cd2-8bab-b5f6636fbb92'), 69, 'Aliquid et voluptas non expedita voluptatem et eos. Aut et officiis aut odit in. Modi et natus minus fuga suscipit.', 9008, '1998-10-29 04:28:06', '1975-01-18 00:55:43'),
    (UUID_TO_BIN('9f73daf7-b745-3283-bfeb-a019fea55f12'), 70, 'Quae dolorem non reiciendis aspernatur nihil aut deserunt. Sunt libero iste occaecati reiciendis earum reprehenderit maiores. Blanditiis rem quisquam hic. Aut non voluptatibus nostrum magni asperiores voluptates eos.', 881, '1980-12-05 20:47:17', '2001-04-21 22:00:57'),
    (UUID_TO_BIN('9fb752fd-3b09-3b53-954a-9db8c362c283'), 71, 'Quibusdam ab numquam molestiae omnis suscipit quaerat quia. Quam aut aliquid est quaerat iste possimus. Ipsam deserunt rerum repellendus velit similique debitis labore.', 16777215, '1995-08-13 12:55:34', '1984-01-28 12:39:50'),
    (UUID_TO_BIN('a6334d6d-dfa2-32ed-a0e5-fb806bf5dc02'), 72, 'Enim explicabo sunt voluptates nisi recusandae. Qui eius iusto officia saepe aut quos iusto. Ullam quibusdam neque velit ut.', 9, '1999-02-16 09:31:00', '1991-03-13 11:31:43'),
    (UUID_TO_BIN('a99936bf-24c4-3a3e-b508-1f42feb1241c'), 73, 'Aliquam dolorem consequatur neque. Sit sit consequatur recusandae itaque nobis quia. Minus eaque quis autem omnis repellat sint.', 531, '2018-03-22 15:18:54', '1978-01-17 01:06:55'),
    (UUID_TO_BIN('a9b13a31-21d1-354e-ac96-045634758d1f'), 74, 'A perspiciatis corrupti et eum cumque aspernatur. Modi voluptatem illum esse a velit eum incidunt. Voluptas est ad quia molestiae rerum accusantium.', 754, '1976-12-01 13:17:35', '2017-03-28 11:28:12'),
    (UUID_TO_BIN('abe2f36e-081f-33a6-9499-be78b40973cd'), 75, 'Non unde et facilis molestiae omnis eligendi. Quia ut molestiae corporis eius iste sed vel.', 93210, '2016-03-29 01:27:32', '1995-04-23 22:14:25'),
    (UUID_TO_BIN('ad3f2b95-ec9f-37b3-88af-ceb1e19472cc'), 76, 'Et cumque ipsa repudiandae occaecati veritatis qui dolorum. Laudantium iusto commodi id tempora. Voluptas placeat quo id illo nesciunt laborum voluptas in.', 18811, '2021-08-08 01:00:15', '1999-12-27 06:31:57'),
    (UUID_TO_BIN('b026a65b-14ef-3aff-a63b-fde148d90a14'), 77, 'Facere et laudantium error autem cumque sint. Odio enim laborum ut blanditiis et. Quis nam neque voluptas laudantium. Quibusdam accusamus fugiat et rerum.', 83, '1982-06-25 01:32:23', '1978-10-28 01:08:33'),
    (UUID_TO_BIN('b22ac010-0a74-3a72-a61f-408c4c5b6bd1'), 78, 'Alias ad id vel quibusdam distinctio aut. Est ut asperiores expedita iure ad deserunt porro dolore.', 78, '1985-07-15 14:29:24', '1998-02-27 16:02:30'),
    (UUID_TO_BIN('b830a5c9-46b3-368a-836c-8a1973640666'), 79, 'Ex voluptatem aliquid assumenda voluptas doloremque doloribus. Voluptatem veritatis molestias consequatur quidem pariatur qui. Voluptates excepturi tempore rem laboriosam qui magni sapiente. Quos reprehenderit animi totam consequatur.', 4754, '1991-10-06 21:50:07', '1981-09-10 09:30:33'),
    (UUID_TO_BIN('bbdfdbbb-e65c-3528-9c7c-9229e5096359'), 80, 'Corrupti et qui est ipsam quam qui quidem. Aperiam sint eveniet magni molestias quia. Quisquam consequatur maiores est.', 95236, '1978-04-09 19:53:05', '2005-06-04 13:54:32'),
    (UUID_TO_BIN('bcc1e259-2fc4-33f8-a11f-884367e56392'), 81, 'Vel recusandae inventore facere eos quis sit aliquam. Adipisci occaecati et repellat officia sit quia aut. Repudiandae et hic et vero labore ea. Sit earum est est et quibusdam.', 16777215, '2012-06-12 09:50:23', '1976-11-12 21:48:34'),
    (UUID_TO_BIN('bf24243b-e5bb-3ec0-ae40-e6a8eab23bc9'), 82, 'Provident amet nihil enim beatae ut. Modi quia culpa dolorem. Nesciunt ut ipsam eveniet ut omnis maxime consequatur.', 3, '1980-10-01 11:18:09', '1996-07-17 17:43:14'),
    (UUID_TO_BIN('c2b13170-9271-37ee-bee9-8cc385028892'), 83, 'Cum et quis minima explicabo. Qui veniam ipsa sunt necessitatibus et vel accusantium. Ullam quidem similique nihil laborum vel modi minus.', 54375, '2009-11-07 00:40:16', '2004-08-09 03:14:16'),
    (UUID_TO_BIN('c3df8daa-70ae-3cae-88ed-c38516cc833d'), 84, 'Quia perspiciatis aut soluta nihil reprehenderit. Qui quisquam nam consequuntur temporibus doloremque. Quia eos aut nesciunt excepturi.', 67182, '1985-01-05 11:04:53', '2017-03-29 15:24:04'),
    (UUID_TO_BIN('c4f21012-7c13-3541-811f-aed6ade56a4c'), 85, 'Blanditiis cum itaque sit ut rerum aliquid. Veritatis incidunt odio dolor sed. Fugit animi culpa nihil voluptate.', 6314, '2006-11-19 05:47:14', '2000-09-22 20:40:40'),
    (UUID_TO_BIN('c529098f-2550-3fae-ac6c-07696d5d6ddc'), 86, 'Quos voluptas id corporis ducimus molestias laboriosam exercitationem. Voluptatem voluptatem reiciendis minus non est blanditiis nobis voluptates. Occaecati et architecto qui dolorem fugit nihil possimus.', 8406, '2014-10-13 14:12:05', '2006-06-23 21:04:47'),
    (UUID_TO_BIN('c680565e-3894-3d63-a59d-35f076321bc3'), 87, 'A blanditiis vitae aut doloremque totam nobis ducimus. Natus rerum quaerat numquam dolorum corrupti ea autem. Deleniti quis molestiae ut dolor vero qui quasi. Nobis ab minus adipisci sint.', 9641, '2007-11-28 10:22:28', '2003-11-05 12:53:38'),
    (UUID_TO_BIN('c971865e-45fa-3287-9f4a-c92aee96534f'), 88, 'Eius consequatur harum nostrum. Quidem omnis dolorem quo et voluptas. Et aut ut autem facere. Sequi magni aliquid eum numquam qui totam aliquam. Ipsum consequuntur modi esse eum consequuntur.', 16777215, '2015-03-25 02:08:13', '1981-05-23 05:57:14'),
    (UUID_TO_BIN('cc8da645-8565-35a1-b6d1-dbd3ff9d1fb2'), 89, 'Ex ipsam non excepturi ipsam impedit quod accusamus architecto. Veniam reprehenderit est assumenda quaerat. Omnis optio aut ea maxime libero. Eum eaque atque alias ducimus. Dolor a ea corrupti illum necessitatibus et qui amet.', 463, '1998-07-05 20:45:39', '1982-05-09 11:52:14'),
    (UUID_TO_BIN('cea9a1b2-7e1a-3843-826d-413e54c2fd1b'), 90, 'Non quaerat iste odio qui laudantium. Enim dolores est est vel iste saepe. Enim ut et quasi alias voluptatem et itaque.', 824, '1994-09-10 20:56:34', '1984-01-12 23:37:43'),
    (UUID_TO_BIN('dd331410-911d-36c0-b683-47a26eb9e819'), 91, 'Quae voluptatem omnis molestiae molestias autem reiciendis numquam. Quasi atque voluptatem dolor cupiditate doloribus quis sequi. Ratione soluta assumenda nostrum consequatur ducimus consequatur earum.', 855165, '2006-06-24 01:53:40', '2016-12-16 03:05:47'),
    (UUID_TO_BIN('e96703ed-52e8-3872-bf4f-28b4291ba73a'), 92, 'Eum unde accusamus magni id quia repellendus. Optio exercitationem deserunt dolor delectus ipsam tempore. Qui est deserunt aliquid aut eum voluptatem.', 16777215, '2009-07-07 06:13:50', '1972-02-01 10:17:24'),
    (UUID_TO_BIN('e9a24e00-bb19-34bb-8063-896fa5ba9398'), 93, 'Esse veritatis sunt neque aut. Qui illum rerum corrupti reiciendis. Ullam similique quisquam quo.', 0, '2012-08-13 06:05:07', '1971-04-04 10:24:21'),
    (UUID_TO_BIN('ea88dfa5-1a6c-3752-8b89-f0e56de4b84d'), 94, 'Ipsam omnis ipsam non distinctio dolor soluta dignissimos. Consequatur voluptatum voluptatem harum dicta. Voluptatem modi provident sequi impedit. Quod quae veritatis adipisci qui vero quidem eligendi.', 318059, '1990-10-28 20:43:10', '1972-11-07 18:36:17'),
    (UUID_TO_BIN('eccac971-d055-337f-829d-f3f1b615c2ed'), 95, 'Ipsum quidem repellendus commodi excepturi dolor. Molestiae commodi ea molestiae. Eos aliquid qui mollitia harum. Qui quia iure fugiat deserunt quo.', 4216, '1975-12-15 12:00:02', '1993-04-25 13:14:43'),
    (UUID_TO_BIN('f3832de0-9074-3c20-bc69-2498d93695e0'), 96, 'Recusandae commodi illum ab atque. Recusandae autem repellendus rem et. Culpa blanditiis aut dolor aspernatur ut. Vero voluptates qui harum velit.', 8427, '2018-01-12 05:56:16', '1973-05-03 15:48:57'),
    (UUID_TO_BIN('f4ac7536-f77b-32de-8bf9-54c9da75f5f1'), 97, 'Et ab natus enim vitae quos architecto. Ab ducimus ea consequatur cumque eum eum iusto. Nihil illum ex error aut. Dignissimos pariatur quia nulla.', 185504, '2008-06-20 11:28:09', '1974-05-30 07:54:01'),
    (UUID_TO_BIN('fb9acbf3-de60-3590-9585-8f0444739473'), 98, 'Placeat incidunt quo nihil rerum rem. Iusto voluptate itaque et sint ab ea ut. Autem consequuntur ex ad dolorum impedit eos ullam. Voluptate ex accusamus non earum sequi. Ex repellat et voluptate similique est vel praesentium.', 16777215, '1977-08-26 09:17:44', '1989-01-24 18:03:46'),
    (UUID_TO_BIN('fc5a1ec4-d866-3a14-afcf-8239d6c6761c'), 99, 'Distinctio dolor quis nam consectetur. In ab rerum quis autem sint autem. Et inventore est ut qui facere.', 4759, '1972-12-08 23:32:36', '2015-02-13 07:12:05'),
    (UUID_TO_BIN('fdd1a78e-b1d5-31b5-a4f1-c6865b53db5d'), 100, 'Sed id odio iure eum quas. Doloremque sit minima quos enim delectus ut. Animi voluptatum explicabo cumque est dolor impedit et.', 400049, '1988-12-21 12:40:01', '1998-11-21 23:57:07');

INSERT INTO words
    (id, level_id, word, description, image_preview, image_big, created_at, updated_at)
VALUES
    (UUID_TO_BIN('08a4aaf9-5df8-3a82-bc02-6929e4d52872'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'человек','Necessitatibus ut ullam quidem eveniet autem et voluptates. Nemo debitis pariatur culpa. Sed accusamus vitae qui.','/012de3ed26c8c226b062038ba0b6afdd.jpg','/074fc7a059228bca36c54453da2a5fda.jpg','1970-07-20 23:15:23','2015-11-13 18:19:56'),
    (UUID_TO_BIN('099c8bd8-65ce-362c-8e2a-271076f6347f'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'время','Quisquam aliquid officia tenetur voluptatem. Distinctio soluta et et molestiae. In molestiae nihil voluptas consequuntur facilis dolor est.','/bcd0380106977d59bf4280f5c96f11a9.jpg','/c63ecfbfaf96640689ebf52380e7c5fc.jpg','1985-11-26 04:17:07','1981-03-06 23:08:18'),
    (UUID_TO_BIN('0afd013d-f29c-34e2-aba1-d842eef6da59'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'дело','Impedit dolore aut dolor. Quia asperiores est aut fuga cupiditate ipsam. Optio perferendis officia perspiciatis et. Quis delectus cupiditate aut atque non eaque. Similique fugit officiis ea ut impedit at.','/2c6d09caf32b59a4f0b7b71586207743.jpg','/b24fb3b21952725c756bcb01188bcb30.jpg','2007-11-07 06:03:11','1971-03-28 17:22:00'),
    (UUID_TO_BIN('0c5c6147-8e0d-3589-a786-445f67ea4d72'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'жизнь','Officia similique aut veritatis quo provident maxime. Id aut nihil harum qui facere. Atque autem magni adipisci qui non aut.','/a3b4769fe746e8fad1993074823b77ef.jpg','/7a17d410bd763ce904cc587ab25ca60f.jpg','2014-12-03 19:57:56','1999-09-15 08:37:28'),
    (UUID_TO_BIN('0eae6918-bd66-3185-8f06-f5a85fc8fa69'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'день','Atque aut molestiae ut ut in rerum neque totam. Quae molestiae quam autem sed. Et blanditiis qui labore qui praesentium itaque omnis nam. Rem voluptas incidunt est sit placeat officiis et.','/544475a9fc05b26fddded8e5fe770a26.jpg','/b8513232510982014b5632a1a91d4cfc.jpg','1981-06-14 06:34:01','1994-03-16 20:59:59'),
    (UUID_TO_BIN('0efeed09-50e9-3b89-9af9-fb08efb95bcf'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'рука','Illo at corrupti et ut doloremque nihil sed. Est aut explicabo asperiores commodi voluptates. Maxime qui sed quia exercitationem quia expedita soluta. Sit sapiente ipsam et beatae illo optio. Reprehenderit adipisci dolores aut quo quos a numquam.','/8e9e02462d1fe8b6cf1e8503bf4b09ae.jpg','/27175ebeaa9a230b34ea4cc76112b0c7.jpg','1992-09-07 13:59:20','1987-06-24 10:29:31'),
    (UUID_TO_BIN('0f3c4f4e-eabb-334c-97f4-1757fdde8658'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'раз','Sequi officiis quos qui iure temporibus beatae et. Aspernatur et voluptas incidunt perferendis veniam. Hic voluptas ut fugit esse aut blanditiis non. Qui dolor rerum distinctio quis voluptas dolorum.','/2b03146a3995ceeaf8ad1b3042db830e.jpg','/fca6e23186b89e8f5730609fe7ddc4f5.jpg','1983-03-15 05:22:31','1971-10-30 06:40:08'),
    (UUID_TO_BIN('0f63e2a4-c8c2-3f76-90b0-77762f5a884e'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'год','Maiores in eum consectetur aspernatur. Distinctio magni aut ad consequuntur iure. Aut nulla iusto facilis assumenda porro. Culpa facere maiores error accusantium illum molestias voluptas omnis.','/01635445a6f9fee92dc845624c7631b1.jpg','/bae33d5382686d31e687c703135a028f.jpg','1990-05-31 00:42:18','1982-05-13 09:32:12'),
    (UUID_TO_BIN('109c98b0-0753-39a9-bfc6-40e654588021'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'работа','Et perspiciatis numquam ducimus ea. Ducimus officiis commodi vel consequuntur corrupti. Sapiente voluptatem vitae quibusdam vel. Doloremque quos velit fugit tempore et.','/5eadfc0edb1a2cbbcb6021b5c7f2565f.jpg','/47064ee66876fbabe709fffefccb4a5b.jpg','2001-10-07 03:57:45','1999-12-01 04:17:29'),
    (UUID_TO_BIN('1725b469-8942-35f3-9edc-236ebf641a14'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'слово','Est rem aspernatur non. Nihil distinctio ipsum eos rem et est corporis. Tempore in quis dolor voluptatem. Odit rem enim officiis. Cumque et et qui libero.','/f206687d8b32225d570fa81d9b80553c.jpg','/253e291038208b2c424bf07ae9a68202.jpg','1986-07-12 08:29:38','1977-04-17 22:13:02'),
    (UUID_TO_BIN('1d7d59ff-800e-3989-8557-532610b00824'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'место','Corrupti eum debitis qui modi ducimus numquam. Voluptates excepturi ut quibusdam. Saepe rerum optio delectus qui voluptatem ducimus.','/21b5355ec1bf5ec449a247f9de2d68b1.jpg','/5d20a6ab38fe6856d84ec55a7c9acc95.jpg','2011-02-09 17:24:23','1993-06-13 04:14:56'),
    (UUID_TO_BIN('1eefc43a-1c9d-38bc-8444-d4b4e9a5fae0'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'лицо','Nobis aut unde qui quibusdam. Et voluptatum alias nesciunt doloremque et. Dolore non doloremque quos eveniet aut optio. Provident et aliquid velit.','/f9d52ae6110f7c85df0a51c772d622c6.jpg','/e233bb63446ca80cc68ef40653c08dd4.jpg','2017-01-20 19:20:13','2008-11-03 23:36:42'),
    (UUID_TO_BIN('1f169da5-a783-3a46-a30d-75ba1432d50d'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'друг','Eos aut non sed ad. Quia ut et repudiandae dignissimos laboriosam. Animi ab dignissimos sit quam. At cupiditate velit aspernatur optio ea.','/85a1e34fb24c36456b6b5abb70d975fe.jpg','/bc87c87b7d0ed83a1f53fb633a333b08.jpg','2014-09-27 23:30:04','1999-12-04 12:27:11'),
    (UUID_TO_BIN('23e07d52-9f97-38a2-9df7-f83ff01cc213'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'глаз','Iste odit voluptas a optio. Nostrum laboriosam et facilis in aperiam incidunt error. Doloribus eligendi et voluptatem voluptas illo.','/59b34082a0bf799c19d47db40ec871ca.jpg','/2ff68d2e62de099dc42baf146b2d1093.jpg','1991-09-16 01:09:53','1987-06-27 13:21:29'),
    (UUID_TO_BIN('23faa0de-e52a-3b04-a8b9-7b6a6765da42'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'вопрос','Recusandae corporis eos ipsa. Velit vitae culpa sit facilis unde blanditiis accusantium. Beatae consequatur nihil rerum veritatis omnis.','/065b2c75846c9be0b1c0ee8a3424aa44.jpg','/7a9efdd9dd8461cae44ed63f457e6b6d.jpg','2003-04-04 18:20:02','1990-11-05 22:22:48'),
    (UUID_TO_BIN('24aa46d6-7cb8-3219-88a2-2a87d83d9170'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'дом','Dolorum et repudiandae aut suscipit debitis. Quo et ad sit provident corrupti quos minus officia. Enim ut commodi ipsa omnis.','/b5b6052621840cc8a104ae1144b3fcc8.jpg','/394876740620d2681a089861501166ae.jpg','1999-06-18 18:35:28','2017-08-08 14:46:53'),
    (UUID_TO_BIN('24d196ff-58b1-3896-afd4-bd5fbeda0663'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'сторона','Fugit ut enim autem non adipisci vitae ullam occaecati. In consequatur voluptates magnam et repellat non asperiores. Consequatur assumenda dolores quia id molestiae. Dolorem perferendis quo aut cum placeat consequatur porro.','/fab17626df9d580dc321f2367de46c36.jpg','/12a1f99e9a1b50c1aea8fe8ba341b387.jpg','1987-05-11 21:27:04','2015-10-20 05:47:06'),
    (UUID_TO_BIN('28855a77-d504-3efa-b83b-cc1a96c7fd2a'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'страна','Corporis quas nisi impedit rerum eum aut. Adipisci esse ipsum velit voluptate aspernatur omnis aliquam. Aliquid nostrum sequi ratione repudiandae rerum laborum quibusdam. Sint laborum autem et velit ducimus. Iste vero aperiam eos corrupti.','/6b67fa9748bf401b8f9c71f4f29c1da3.jpg','/b1c25dae079d68380080e681f20cc634.jpg','1999-03-03 01:29:53','1973-01-27 08:50:38'),
    (UUID_TO_BIN('2b1026b4-b966-3416-95e7-7d182a3ac43a'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'мир','Quis consequuntur enim ratione quisquam saepe iusto exercitationem. Sapiente blanditiis nihil amet et voluptas sint. Dolorem iure ut iure nostrum qui reiciendis maxime.','/acb323fabd5fb6d4c5d0209926c264d8.jpg','/9a1f92ee5d55b66d6f7ee3afd2096137.jpg','2015-10-26 04:00:43','1977-04-04 08:53:10'),
    (UUID_TO_BIN('2d840ee0-e0db-3832-9e0a-90fccd3b9339'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'случай','Repellendus nisi dolores quia occaecati facere. In reprehenderit a ut expedita. Nostrum sed dolores maxime est recusandae velit ut.','/ce889be8f109392bac46e99d2fa27cc2.jpg','/9cd83c14b4e5ce294901a79b46c06b48.jpg','1982-02-27 02:29:19','1981-02-28 22:37:29'),
    (UUID_TO_BIN('31a1649f-bd8c-3c30-a8bc-406f3df249be'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'голова','Voluptates iste maxime laudantium in. Aut nisi earum modi explicabo id. Omnis molestiae illo corporis sunt. Aperiam aliquam voluptates non in. Quas eius fugit ipsam aut adipisci quisquam.','/c1f9265afd08599ac1d516410b1e7d48.jpg','/6405f8798dfc2708bda8c4f4cbe781d0.jpg','1978-05-11 18:51:45','2014-07-20 11:27:48'),
    (UUID_TO_BIN('338c3436-35f3-37ba-a1a1-58bf16a90624'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'ребенок','Voluptatem architecto magni consequatur aut. Delectus et explicabo est voluptatem ipsam. Nihil enim quo eum beatae suscipit error sunt. Non quia debitis aut repellendus sed dicta fugit.','/77779945eb75dafa0decb727cf511f24.jpg','/34347ab2544cc6cfbab494c3f1ab8487.jpg','1989-11-02 04:39:47','1972-01-27 16:24:42'),
    (UUID_TO_BIN('3a8beeae-2972-3950-8d97-9ec2a6080140'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'сила','Molestiae quo qui aut facere inventore cumque eos. Sint sunt quo et magni ullam. Iusto laborum nulla omnis dolores ipsam perspiciatis.','/660067890d3be39c5e80db8d36cc4b45.jpg','/d57f3806ef94fc4adae44812f818a283.jpg','1990-09-24 17:33:03','1971-07-19 05:08:05'),
    (UUID_TO_BIN('3bd0134f-daad-3143-9bfe-db43d5034ebb'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'конец','Inventore sit officiis quidem expedita asperiores voluptate explicabo id. Eum mollitia quia vel fugit. Nisi expedita est aliquam sed saepe.','/97b76f995976d872d84888a6cddc55ef.jpg','/ad77d75c1f8172325ed377913902a631.jpg','1991-02-14 21:36:37','2001-02-28 09:22:07'),
    (UUID_TO_BIN('3ca7fc62-cc16-35f4-860a-ca7c9b1f911e'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'вид','Quia dolor ipsam fuga facilis. Nesciunt deleniti earum est molestias quos ad non quia. Doloribus iure id deleniti voluptatem repudiandae rerum.','/71ea437b50286b4d21d3430da14f939a.jpg','/9103db6093de58fb552ac829de0ad799.jpg','1987-09-18 17:16:55','2010-09-28 03:11:31'),
    (UUID_TO_BIN('3df7ed07-6670-3beb-87e5-45bd7247f2d7'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'система','Ea temporibus voluptatem nihil dolorum earum. Dicta dolorum delectus dicta aut fugit. Quis ullam vitae tenetur sequi et quo impedit.','/ea8118329b93cb4b013a4679edec08f8.jpg','/a463909a7cf5ba597aeca63f39bed367.jpg','1977-04-21 17:45:12','2006-04-23 19:39:16'),
    (UUID_TO_BIN('424a6260-0c8e-37a4-a510-d36d4bba54c2'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'часть','Voluptate quia eos vel animi et ut voluptatem nobis. Cumque aliquid quos ipsum libero alias facere iusto. Eum facilis et cumque ratione itaque et et. Eveniet doloribus expedita laborum dolore. Dolorem veritatis eaque nesciunt officia est aut possimus.','/470c4d9f8b8810376ef4f5db07b242cb.jpg','/e352706d460bfcf5054cd27f3e199ead.jpg','2010-02-07 18:45:34','1973-03-19 17:13:46'),
    (UUID_TO_BIN('43461794-ecb9-37f3-a8a6-ce1c8684761e'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'город','Expedita consectetur aliquam molestiae architecto cupiditate tenetur ab. Occaecati amet quod corrupti et officia commodi expedita. Molestias id in eum qui quia rerum. Non alias dicta numquam quo.','/0a40d6a0018120d27bb19da04e890f15.jpg','/c3710acc89dee64cd4172d05d8c5d19d.jpg','2003-02-04 07:39:50','1991-07-13 14:59:01'),
    (UUID_TO_BIN('436057c7-7328-394e-b72e-63f4b23bbc13'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'отношение','Molestiae voluptatibus placeat ullam sunt exercitationem veniam voluptatem. Voluptatem ipsa deserunt et esse laudantium reprehenderit. Est voluptates et et ut est ipsum ducimus. Quaerat qui itaque rem nam fugit reprehenderit.','/f1af88eaf383c7a2021d3c1d57d6a452.jpg','/45a66a2218a99367c17d09ef5cdef0b9.jpg','2001-12-16 14:11:06','2021-09-01 11:51:10'),
    (UUID_TO_BIN('45d81789-a00c-3e9d-bed2-538b1d23ef6d'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'женщина','Ducimus suscipit ut quod reprehenderit dolorem dolorem. Harum dolore consequatur illum sed accusamus. Asperiores voluptatem quos aut eos et dignissimos ut asperiores.','/d93ee0b1c4da096285b420654b507e13.jpg','/706eca2a9b8a62681f21613c1f3526b7.jpg','1981-04-24 07:14:33','2010-07-12 15:03:00'),
    (UUID_TO_BIN('47ae2758-9e0a-3798-bbb4-3a1f3c3b1a80'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'деньги','Et ipsum ea et voluptatem illum velit. Ipsam sed maiores qui eaque laudantium.','/ebf4ae63d26234e02bc01acb238fd2c3.jpg','/c810fa5e45537a8fbbbdb15df627d022.jpg','1980-11-28 16:41:11','1987-01-11 00:04:41'),
    (UUID_TO_BIN('4a7b5f0a-651e-3050-8438-103ffafd6f72'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'земля','Quo voluptas voluptatum ullam aut distinctio. Ea quia quia possimus dolorum. Possimus ut sed aliquid dolores. Aut quibusdam laboriosam placeat accusantium corrupti esse animi.','/fee6a22366c7e8d1fe8d67ae2e883e63.jpg','/28cf45de98b94a0ab4973a767a492b1c.jpg','1978-01-30 14:02:58','2004-08-04 11:01:45'),
    (UUID_TO_BIN('4c10dbee-f153-304d-9ff7-25ea8dda0fdb'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'машина','Sint blanditiis alias aut aut itaque eaque. Asperiores optio harum dolores est et. In esse magni omnis est ipsam quasi repellat voluptates. Suscipit blanditiis doloribus voluptas nesciunt consequuntur minima.','/36847791b2f6abac758dd4a7ab899350.jpg','/2ff8cb552ddf30766c59e5d627ea6c36.jpg','2017-05-25 00:58:53','1989-10-21 01:19:26'),
    (UUID_TO_BIN('4c9db27b-0e69-3d99-b9f5-5b19da0a6db7'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'вода','Quisquam eos voluptate commodi consequatur aliquam et. Maxime repellat eos pariatur reprehenderit. Similique quidem aut expedita at. Sit qui impedit assumenda dolorem voluptas. Quos quos vero et voluptatibus aut omnis modi nisi.','/545682b9bd4517b4e33d8c33d0b61e16.jpg','/6d28face2b977ec035d90ef493c2dd39.jpg','2013-05-01 22:16:53','1995-07-19 19:01:33'),
    (UUID_TO_BIN('51d59f7a-adbb-3bd1-bb5e-2918a6cddde6'),UUID_TO_BIN('089bf7b8-936e-358c-87c0-ea3cb0afa1f0'),'отец','Sed laudantium in iure eum molestiae ipsa. Occaecati necessitatibus dolores non placeat sed sit nam nobis. Molestiae est doloremque qui quia non laudantium adipisci debitis.','/9510d86da705cf8ff70eb1e16430f34a.jpg','/e5dc904567f7e488d818942e4adb0232.jpg','1975-10-05 09:43:03','1987-01-23 17:59:40'),

    (UUID_TO_BIN('547ea43f-a7a9-3b7d-8caf-9905997b0b97'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'проблема','Ipsam facere non dolorem quasi. Molestiae sequi blanditiis asperiores provident qui. Odit et sunt et voluptatem ut. Laboriosam et non quis.','/aabf2d3502b81925ec6ccf7a9a0b201e.jpg','/b9e62b1d6310de2b75f5bb6905e5d11c.jpg','2005-05-05 23:48:28','1978-09-08 09:15:59'),
    (UUID_TO_BIN('5be49c40-47fc-398c-a707-38de5501859b'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'час','Quod molestiae molestiae repellat repudiandae itaque assumenda repellat. Ut mollitia enim optio totam placeat. Optio optio dolor aut veniam sed nihil. Nostrum pariatur veniam provident optio.','/947be84bb233649d656703f6dab73e1c.jpg','/bd515da066e2c643320ba1cceebf3689.jpg','2008-12-22 00:28:25','1987-11-07 12:44:22'),
    (UUID_TO_BIN('5cc37a11-5ca8-38e2-bb90-004a4db800dc'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'право','Minus explicabo aliquam quod ipsum. Possimus aut omnis voluptatem quisquam.','/a9f47b96ff76cac554747257f0333cc5.jpg','/cb98f2cc63e50f773ba76ba689cd24d6.jpg','2020-03-02 22:20:58','2021-04-09 13:08:51'),
    (UUID_TO_BIN('5e333459-3c10-35d7-94b4-9a0bda48eb75'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'нога','Maxime dignissimos quia cumque eligendi. Iste non deserunt ex aut eum. Et eius sit ut ipsa.','/408212f1dfc75073df030219de271da4.jpg','/4f5fc624abca07bd2b26f2de8be1845f.jpg','1983-12-21 16:31:56','1989-07-20 00:54:49'),
    (UUID_TO_BIN('6651b321-40d1-3576-94e2-8f57957aa32f'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'решение','Autem ut eos sed a. Blanditiis est voluptatibus impedit commodi. Alias praesentium similique quo aut voluptate cum.','/842249723bd7f50ed5386d42a2fde56f.jpg','/cbc2f547a57cafbfab4f28c1f442d6c3.jpg','1971-12-03 06:46:23','1973-01-19 04:25:36'),
    (UUID_TO_BIN('673759df-e067-3aba-a3e9-9c219f0791f9'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'дверь','Quisquam repellat aut repellendus non omnis autem quae. Dolor veritatis placeat praesentium. Consequatur dolores officia reiciendis perspiciatis quis repellat eos.','/6c7b3bb726b9affeae0ac939121ce729.jpg','/9eda72f8a0fe960aaf54f1dd54c8c91d.jpg','1985-11-05 02:09:42','2000-06-13 19:33:04'),
    (UUID_TO_BIN('6d135ca2-9e0a-3c9d-854d-c663cf11f9e0'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'образ','Velit corrupti sunt similique eos accusantium tempore optio. Enim et facere laborum et et. Ex et porro pariatur dolorem nam quod qui ad. Labore exercitationem excepturi odit cumque non ut non.','/edb1e457c6ca9b4911cb5dca2dc63bb1.jpg','/a2e495f3ea04e22fa2302253c69ab221.jpg','1970-12-11 14:32:12','1989-12-21 22:57:02'),
    (UUID_TO_BIN('7081ad1c-7857-3041-bd4f-d0204ad7c88d'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'история','Sit harum reprehenderit tempora nihil cum praesentium numquam. Accusamus recusandae aut fugit eveniet quidem laboriosam. Fuga assumenda doloribus laboriosam ullam maiores aut ea.','/3af31cad725def19a30bfaac6d42815d.jpg','/51e33bf23d83aa8c8a483a00b39925ef.jpg','1983-12-07 09:06:14','2002-07-26 22:05:49'),
    (UUID_TO_BIN('7148380a-7714-323c-859a-a82da67ca6b5'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'власть','Quasi magni provident ab cupiditate maiores. Odio totam et dignissimos et. Voluptatum voluptatibus voluptatem nihil aut culpa.','/41abdbda61066d7be88cb915eee6e920.jpg','/d2afb7f2b3f1b83abb1856e36df7fd52.jpg','1996-01-25 01:13:07','1978-05-10 01:05:42'),
    (UUID_TO_BIN('795c2080-7cd3-30e9-9cc8-33c003ddf980'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'закон','Doloribus dignissimos minima quae sed est doloribus unde. Laborum voluptatum consectetur ut sit ipsa saepe sint. Quae corrupti in qui. Rem est omnis ducimus unde voluptatem.','/e44633c8009e09963d8c168b8635ec34.jpg','/557b9da73f3b38537a729920dce2d3c3.jpg','2000-12-26 02:21:18','1990-02-15 17:07:49'),
    (UUID_TO_BIN('81ab81c9-e065-30b2-9662-4f49272e1156'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'война','Non est earum eveniet tenetur. Neque impedit nobis nesciunt occaecati assumenda. Sint officiis temporibus repellat. Sit pariatur eveniet possimus possimus sed est.','/36ce2893cff00dea8a33e835590cb755.jpg','/86c8dc8f81775626f21159c41c32ff06.jpg','1989-12-12 23:18:21','1993-09-18 08:17:50'),
    (UUID_TO_BIN('85c3db5f-fb5f-3ffa-bc77-6ae48eaffbfc'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'бог','Expedita nisi ab natus possimus velit architecto dolorem velit. Ducimus aut in voluptatem. Cumque impedit exercitationem quidem aut. Quis sequi ipsum delectus magnam.','/28fd24ba28f16f39edcc46bd2aa74fa2.jpg','/8ceb49ff545b3328375be30d4410a70d.jpg','2002-07-25 08:41:12','1985-01-22 02:08:40'),
    (UUID_TO_BIN('8903ccd0-08b5-3308-a860-f40d0a7bd852'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'голос','Porro ut a molestiae repudiandae dolores est voluptatem. Quia et quasi est iusto vitae error placeat est. Id dolorem soluta tempora unde excepturi voluptatum facere fugit.','/d793dfe86582f0386531f91f6dd563f1.jpg','/dcfaddc204a275c4d200f53835ab9aa4.jpg','2019-10-20 06:46:23','2016-01-25 19:43:18'),
    (UUID_TO_BIN('890deab9-1187-37d6-858b-dcab6ec1e1bc'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'тысяча','Voluptatem laudantium atque nobis quasi et et aliquam. Veniam ut molestiae quidem et in. Ratione rem at quia sit dolor molestiae natus. Nihil enim amet ab a ad eius consequatur.','/a4df670dc56e70a8510fe249bc41dc03.jpg','/b27ec690273bbd2aca534aa28e585394.jpg','2001-10-24 19:11:41','2007-02-16 20:06:10'),
    (UUID_TO_BIN('8a3bdc4d-7ed7-3e87-b1d4-812601e915ce'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'книга','Possimus et vel est expedita suscipit aspernatur et. Voluptatibus at repudiandae non doloribus nemo est. Itaque commodi sed voluptas ut ut veniam.','/e2157c75ff8e177b5e1fdceee9c9b9c6.jpg','/254626430e389e8c9a64874e87fb1a58.jpg','1993-04-12 16:34:41','1993-08-04 05:32:49'),
    (UUID_TO_BIN('8b382239-1a8d-32d2-bd14-47acfdaf2629'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'возможность','Ducimus iste sed nesciunt ad qui qui incidunt nihil. Tempora a eligendi enim fuga et sunt voluptatibus.','/3992079f2f01e3ce2267d332d14c2569.jpg','/0234b2c1123b790d49a06caa7600bb27.jpg','2004-03-08 10:19:11','2011-02-27 19:44:08'),
    (UUID_TO_BIN('8d2d57f3-e268-338d-a06c-8ab9fa9bec39'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'результат','Consequatur voluptas rem nihil ducimus aspernatur mollitia. Ut voluptatem velit minima vel. Itaque rerum nostrum velit enim.','/778f3b62ae880583a5d7f1ad720fd3bc.jpg','/81ba96450a084e348f2e40327611e4c8.jpg','1995-09-07 00:25:10','1971-12-10 23:23:43'),
    (UUID_TO_BIN('8f240df6-9d12-3215-8228-3ecb1a639808'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'ночь','Voluptas dolorum quis aut sit. Eveniet et quisquam sint est. Ipsa quaerat adipisci sed est sint facilis praesentium est. Delectus cupiditate ex molestiae et qui et a.','/4d669c1768609d492c1f657762edf7c4.jpg','/af004f1e8ca34f7de9272227f0b9d9e0.jpg','2010-03-27 16:40:04','2002-10-29 22:54:49'),
    (UUID_TO_BIN('92f59173-16db-3c39-87d5-9ec801fd2bf9'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'стол','Distinctio neque harum voluptatum animi ut. Ducimus sint error ut ratione neque soluta dolor. Odio et ea esse iure pariatur hic beatae. Asperiores qui expedita qui eligendi reiciendis fuga fugit.','/98e2d0d111a58a377c4667bc959bfbd2.jpg','/d155ec9d2c82ce4c1e4192823870c14d.jpg','1976-01-10 20:09:23','2008-04-14 13:01:41'),
    (UUID_TO_BIN('9368c465-724a-3fd3-a52a-d9d3ed4f3b02'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'имя','Sint delectus omnis est harum ut autem. Dicta nulla officia modi illo voluptates placeat atque. Adipisci quos adipisci autem qui facilis.','/26239e7c49b8b3588e3901e81dad5779.jpg','/d687c55e8bdd1246a044934aef785008.jpg','2011-12-17 16:49:14','1994-06-14 17:00:45'),
    (UUID_TO_BIN('93c81cdf-9f71-3948-aba0-07720609141c'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'область','Voluptatem tempora asperiores non modi atque impedit ipsam. Non aliquid labore ducimus debitis. Vitae eligendi eaque sed. Quasi nesciunt officia ut ad labore provident.','/750bd5389a50ad36f7a1e49965aa0809.jpg','/f7bd4070450844384f93a3a2827690dc.jpg','1995-05-19 17:13:52','2020-03-13 23:47:52'),
    (UUID_TO_BIN('94a22e81-da51-3537-9836-b3a02ac23702'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'статья','Incidunt fuga ut reiciendis laboriosam accusantium est. In quis officiis molestias aut dolorum. Pariatur dolor rerum nemo. Est quaerat nobis et molestiae.','/0da4948b1a65e42464fe01e061c328c7.jpg','/df80790994b0e4cfe2cc1379200baf6d.jpg','1978-07-12 08:32:51','2008-05-09 02:15:52'),
    (UUID_TO_BIN('95cef379-d007-34bf-bdd6-da5af1b162df'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'число','Est sint est aut qui tempora vitae. Est quia eius nihil ut labore. Aut dicta fugit temporibus. Error natus cupiditate et.','/0f6c5dff1f7da87aa05295cb587537de.jpg','/a7ebd3fc0a9ae6fd77d774a8ac355372.jpg','2020-11-20 21:10:41','2006-01-22 17:08:16'),
    (UUID_TO_BIN('974dc04e-0d26-3c0d-9216-8e806b16b374'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'компания','Omnis quia modi aut aut. Et accusamus suscipit dolorum animi est aliquam quae. Et vel numquam et maxime. Veniam tempora atque unde.','/3b9c60e78c48a116e2800946b8452a24.jpg','/45d9f0eecbcc5ebbf27167f47f766d79.jpg','2009-10-21 09:24:26','2010-02-04 20:30:55'),
    (UUID_TO_BIN('9aca132e-8448-344e-9c81-2df2c4f93ad0'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'народ','Atque assumenda vero quibusdam maxime est maiores et. Tenetur explicabo ut necessitatibus qui iusto totam voluptatem. Sint similique quo et qui repellat enim enim.','/3e47628cfe5c3739c082c45fe138d762.jpg','/5a6e81e595f6ad7dc5c95a314aa37248.jpg','1996-04-26 06:04:51','1981-03-09 12:29:58'),
    (UUID_TO_BIN('9b6ea699-e2e6-3306-a3a6-14c92931b7a4'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'жена','Amet odit at laborum et error aut. Eum eaque dolorem voluptatem omnis sit consequuntur. Doloremque consectetur perferendis provident eos. Eum facilis mollitia perferendis consequatur dolorem.','/e5e8f290c84ae1b978b88bb47e458cd5.jpg','/1e086e5adc86caa65254aca8890e195d.jpg','2020-09-16 23:50:12','2015-04-07 22:15:06'),
    (UUID_TO_BIN('9e1f5b39-7be3-3c33-928d-9d2224768a6d'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'группа','Non dolores quo illum voluptatum delectus dolor. Sed veritatis maxime voluptatem. Laudantium et enim deleniti vitae qui voluptatibus velit.','/499de73015db7c058b312477b3eff079.jpg','/b78b8cb55ac5c7f4e17493cb9c1b4612.jpg','2016-05-15 19:51:37','1985-07-16 19:19:52'),
    (UUID_TO_BIN('9e9dd9e1-4ac9-3d98-9981-d5cf3383dea0'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'развитие','Labore tenetur amet et distinctio sapiente dignissimos sequi. Id sunt quia porro omnis voluptas. Dolorem architecto sed et perspiciatis delectus iure porro ab. Minus iusto dolores libero nisi odit sequi cumque.','/f18602a97f4298703a79ba8b63aff37f.jpg','/2241a45d8a1b0b19ddd417643956afbe.jpg','2016-09-11 05:06:56','2009-03-03 09:10:17'),
    (UUID_TO_BIN('9f3001cc-cb36-314e-9e4e-464391a0e164'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'процесс','Et eos provident excepturi eveniet doloribus. Unde quidem minus labore ut et illum. Officia accusantium amet et odio. Praesentium pariatur vitae et ipsum cum.','/7f5b44df2004ecbaded418ff6db07dad.jpg','/8990c441462e4b4c0e18e7c379d6ed2e.jpg','2011-05-03 05:33:30','1980-07-02 01:24:47'),
    (UUID_TO_BIN('a14b93d5-5ad4-3cf6-9db0-b927eefd75e3'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'суд','Architecto debitis qui sit eos vitae quisquam rerum amet. Asperiores quibusdam culpa illo. Aut soluta explicabo nostrum nostrum perferendis. Molestias numquam repudiandae officia.','/451bc13ff4f1e4a0631d817ae0345d81.jpg','/c62b33049b67328f9d5b484606689fdf.jpg','1980-06-24 22:49:06','2007-01-22 04:21:10'),
    (UUID_TO_BIN('a396821d-a4c9-3029-ac8a-41953afbf9cc'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'условие','Dolorem sint eum et nihil facilis. Quam mollitia facilis eum quidem quos quisquam sequi quis. Architecto pariatur perspiciatis ipsam dolores aut voluptas aut.','/c27bba874d93f4bf9882061c9e40a16a.jpg','/064def514bb400e33b0dcf9785dd3400.jpg','1986-02-25 11:30:05','2012-01-28 23:12:07'),
    (UUID_TO_BIN('a3f83e74-8ca3-3a56-8ef4-7b027f4e6a1e'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'средство','Laborum voluptas possimus aliquid eos repellendus aspernatur dolore voluptates. Dolore ipsam quae iure voluptatem quis recusandae. Blanditiis harum autem eius. At cum fugit dolor nobis nemo.','/953c7665e0b4e12ba7580d7a7f61b61c.jpg','/082a35453f61c3d33c44c3eea137d7c4.jpg','1975-05-01 17:41:29','2020-01-31 05:20:55'),
    (UUID_TO_BIN('a8e4ec84-6411-3535-8800-7d87c19ce8e4'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'начало','Aut doloremque ad aut consequuntur quia repellat. Quo itaque esse et itaque unde modi alias saepe. Et et eos beatae vel.','/4e34d2687001bfc23789fcc328f46e4c.jpg','/62a40767aa7a21335f04b3cef9fa2bac.jpg','1995-07-29 03:40:05','1976-01-13 11:04:30'),
    (UUID_TO_BIN('ab2995df-b9d0-3cd2-aaeb-0415e7f61c71'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'свет','Nemo officiis earum aut in. Odit rem neque ea. Sed eaque quia veritatis omnis. Consequatur minus magnam ea ea in.','/3c4dcf795782f35666c5e998ef9d7f45.jpg','/01d8792b82dfd0d68ceb6c8105e648b5.jpg','2021-01-08 10:39:33','2017-04-20 09:47:26'),
    (UUID_TO_BIN('aba4c1e7-9130-3d8f-b522-1e42cb0b186f'),UUID_TO_BIN('0a9ab2da-30f8-3dde-8f97-4aa571631f4a'),'пора','Harum ut doloribus fugiat harum optio. Est mollitia cumque nulla saepe dolor eos. Sequi deserunt accusantium aut unde voluptatibus.','/91eb36b4e3e3fb87b5b8bd34876ae1cf.jpg','/dcf98833d82d52b9bc68a78fec9f64d9.jpg','1978-10-21 06:36:05','1988-08-31 13:42:07'),

    (UUID_TO_BIN('b0943a72-af91-390e-afbb-d90f8d2f4d99'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'путь','Ipsam iure ut quisquam et natus qui. Quam voluptate quia non nobis inventore animi beatae. Architecto fugit cum nostrum. Aliquid aut possimus est cumque natus nam quis.','/2bdd77b3e53a67ed110835f19e1bfffe.jpg','/74dfd612a043f1c5c28fbb9b1394ac51.jpg','1984-11-25 06:07:40','2009-11-12 04:36:46'),
    (UUID_TO_BIN('b8e32a1a-b215-377e-9e17-1db2d5b7021a'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'душа','Esse eligendi nesciunt vitae natus omnis molestias voluptate. Harum dolor mollitia sapiente. Laboriosam ducimus numquam eum necessitatibus.','/c04e36dbee3decd42a6a1f39cac8a2b7.jpg','/e5cb080abc97aeb10e599cc5e818f2d6.jpg','2021-06-05 11:05:35','2006-09-27 04:09:00'),
    (UUID_TO_BIN('babbf7ef-1a5f-34d5-84cc-8234a21ae2e5'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'уровень','Sint aut officia dolor non et ipsam. Architecto delectus sit voluptate enim quia ratione sapiente. Minus cum ipsam recusandae odio architecto.','/e3c512698da4889ae7e91eb13615f081.jpg','/b8b1b615c7b1a20d3a92db58e9e9d8e2.jpg','1997-02-28 06:22:02','1982-08-18 07:36:05'),
    (UUID_TO_BIN('c25d7357-d2cf-3d00-ad54-b960ac805957'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'форма','Rem officiis est voluptatem voluptas molestias. Quo perspiciatis labore voluptate cum nostrum necessitatibus. Consequatur error iure possimus quia soluta. Hic deserunt fugiat ad aut aliquid qui aut aut.','/4a9da9c7e7e2251cbfb23f5d363f995e.jpg','/4d69d344dcfaa8a3b260ab4e5555a749.jpg','1971-02-28 07:49:23','1994-08-15 21:55:54'),
    (UUID_TO_BIN('c60de4b7-3cb2-328f-8db3-216500fcb354'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'связь','Eveniet minus voluptates illum debitis consequuntur occaecati. Deserunt similique qui est reiciendis rerum consequatur maiores et. Quis deleniti adipisci repellat officia doloremque qui odio.','/34209a9b0988c5ce739e018eb755cf1d.jpg','/e112e8145990348c24bd2d88c23ba691.jpg','1999-07-18 07:49:41','2010-11-21 16:06:50'),
    (UUID_TO_BIN('c789489e-52de-3ba4-b5ef-d45a19f309b2'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'минута','Optio illo nihil nihil voluptatibus eligendi. Corrupti eaque animi aspernatur recusandae ducimus nam necessitatibus. Dignissimos adipisci debitis repellendus tempore. Quas ut mollitia voluptatibus.','/93104097f4777eb8866f87ac2a97e6f5.jpg','/bca0b6cc724a8c7e5031048a08bfa7f8.jpg','2012-06-22 18:02:24','1978-10-04 00:01:09'),
    (UUID_TO_BIN('c97ecc9f-7bbc-3cb5-a319-092304287949'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'улица','Vel eius neque quo deleniti veritatis eligendi. In aut labore molestiae quisquam qui perferendis cumque. Illo et quidem excepturi sed.','/f00c904d0ea58c6d48e663c26eecc5b2.jpg','/ed8dd5e900791d328d8f72a08e458b40.jpg','2001-03-03 01:08:10','2019-11-17 19:43:46'),
    (UUID_TO_BIN('c9e64500-765b-3ea3-890d-12cfd6b89738'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'вечер','Est consequatur officia voluptas culpa. Cum fugiat aperiam et impedit eveniet ad. Voluptas recusandae possimus quaerat hic perspiciatis. Inventore ea cumque nemo et eius error. Nemo ab et inventore veritatis consequatur.','/fc56204ec96bb12728923d7dd5da583e.jpg','/f2023d3b432b8b52018cfde48ab6286b.jpg','2003-06-02 03:47:32','2009-07-27 17:29:56'),
    (UUID_TO_BIN('cd6d7d3f-5e32-3cb2-949f-4c325dbe6770'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'качество','Qui deserunt quasi ad. Culpa delectus ea quod voluptas corrupti. Excepturi sed quia sunt et dignissimos voluptatibus voluptas et.','/85588eb0bcb1b08ec46129e12bf025ea.jpg','/0bac7b4af93875cbfd5c76933894bc9d.jpg','2011-05-06 11:26:37','1976-01-31 18:33:16'),
    (UUID_TO_BIN('cf2ac427-1e97-3d88-aeb7-5e839e8798ba'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'мысль','Qui magnam necessitatibus nemo autem voluptates eaque tempora. Excepturi velit est consequatur iusto tempore inventore. Unde aut nostrum ea velit. Ea sint error tenetur odio autem.','/2f68f20e340dcc5de9fbf6fbba73fa28.jpg','/81c324a9aee24f70f5a52252af186764.jpg','1982-03-03 10:27:27','2008-08-25 19:20:54'),
    (UUID_TO_BIN('d1519300-9c5a-3456-9f51-d256626115de'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'дорога','Perferendis quia omnis id tempora quos quasi et eum. Necessitatibus doloremque non est.','/80a2fb217c04b2cb6732e1f10aa4bb53.jpg','/5b6425a8ac978b92ddedf4a0a4d01991.jpg','1988-11-17 04:38:37','2017-01-10 11:58:17'),
    (UUID_TO_BIN('d246569d-bdea-39ea-ac9b-f98dc3235491'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'мать','Necessitatibus dolorem voluptatum quibusdam repellendus. Enim est minus expedita et esse cumque. Perferendis laboriosam eos qui nihil rerum quas iure. Et expedita exercitationem rerum atque est velit. Quia assumenda dolor in quis.','/ca492f2af9d6f8af778d5368ae9e3f86.jpg','/362c918302b0753c1a4a451594818227.jpg','1971-04-26 14:21:21','2008-04-02 00:27:39'),
    (UUID_TO_BIN('d2e5ea65-691b-30de-9aea-9bc2a26829ba'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'действие','Iste qui praesentium et voluptas dolores eos. Autem placeat facere nulla magni ut ut dicta. Iure laudantium voluptates dolor omnis voluptatem accusamus earum.','/29d4f7e73d0d4a332ac1a35a6a4af94b.jpg','/d2ef85021a97a5741dfca9cc9fc95f96.jpg','1975-11-07 02:07:25','1993-09-30 01:07:52'),
    (UUID_TO_BIN('d4444da6-5c96-386c-ab4b-0ea4b47677e9'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'месяц','Voluptas nemo saepe tempore nihil labore illum. Distinctio reprehenderit eaque qui facilis mollitia ut doloribus sit. Eveniet laborum quam dolorem aspernatur repudiandae ducimus consequatur. Esse aperiam maxime nostrum quo.','/f26e6b1c2b0719a87b957f5f0e52b616.jpg','/14edd9ad5154d40a801a9ec2fa61a178.jpg','1993-01-11 14:58:38','2015-07-06 13:52:39'),
    (UUID_TO_BIN('d4f5ade0-8892-3807-9c18-f18bd775caba'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'государство','Blanditiis et deleniti possimus incidunt. Vero et optio numquam unde. Expedita a architecto nemo expedita consequatur vel culpa.','/deb048e4fab6395182b648acc526a0c3.jpg','/540078103268a97cbe6c45cd73c3a26d.jpg','1999-11-07 07:38:27','1994-12-06 09:57:29'),
    (UUID_TO_BIN('d78311ee-cd49-3c7d-919d-997647a87099'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'язык','Et minima ipsum ducimus expedita. Sequi cupiditate aut accusantium autem non ipsa.','/f5c004a49c68048bf4e94fbcb754802a.jpg','/af5cb69ad3931164e2b09198955401f4.jpg','1996-04-24 08:52:01','1974-06-11 23:43:38'),
    (UUID_TO_BIN('defce1bf-852d-342f-8a38-72fa618640b6'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'любовь','Sit velit deleniti exercitationem sit sapiente sed nam deleniti. Facilis eveniet laborum reprehenderit dolores repudiandae aperiam neque alias. Accusamus perspiciatis cumque fuga saepe sit ab. Perspiciatis magnam necessitatibus sequi aut deleniti sit.','/809913e4f8262fd6e6979e27b897de03.jpg','/9c032927d7e15cdc3727b318659f002c.jpg','1985-02-19 16:46:13','2012-08-02 08:23:24'),
    (UUID_TO_BIN('e064eb58-de4e-30b5-9e6d-aa6beae7186b'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'взгляд','Saepe adipisci enim cumque ex. Hic perferendis expedita sed quo ad omnis. Et at quia et porro molestiae voluptas ut. Explicabo officia nesciunt occaecati voluptatem doloremque.','/9fc626f37645b23b65710d194ed095e5.jpg','/797a11cd72db42193e4ff1345f8c7002.jpg','2008-11-13 13:12:43','1981-11-26 05:26:50'),
    (UUID_TO_BIN('e66ce6ac-407e-32f0-a1db-b37f6dfb8624'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'мама','Doloremque molestiae laboriosam quia nihil mollitia aut. Et perferendis consequatur saepe veniam laudantium voluptas id. Maxime rerum nam hic omnis dolorum praesentium quia.','/eeba6e89333eb20fb78dda2579a05061.jpg','/02db4cfe1c83ed8d48797bbdb25709ad.jpg','1997-06-06 17:17:17','2011-07-05 14:35:19'),
    (UUID_TO_BIN('e89dc798-9e32-356d-a937-4ed16978ce8f'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'век','Optio hic assumenda et hic. Cumque distinctio cumque possimus ea. Esse optio tempore enim aspernatur enim. Dicta qui explicabo incidunt facere quidem consequatur dolorem.','/6c18be87ac7024dacd69fa69b6f76941.jpg','/5b429b9d861089479247a3ef98734200.jpg','2005-08-15 01:36:08','1975-12-16 00:21:26'),
    (UUID_TO_BIN('eb4dd255-fbdf-3f32-9397-fe469f36e32b'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'школа','Soluta nostrum nulla quae natus illum et. Reiciendis laborum ea officia et dolor vel error. Itaque corporis voluptate vero voluptatum quae nisi odit qui. Quia unde eos labore sit voluptas.','/6b4f0fb82cee7d88593ea129a1f63515.jpg','/2f318f9630ca49fe29323c14b38ac367.jpg','1976-10-05 13:08:42','2002-03-06 04:56:39'),
    (UUID_TO_BIN('ebebbe1b-b951-3704-8f26-3bc02f70fd5a'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'цель','Laboriosam ut deserunt ullam ullam quo. Voluptatum enim doloribus architecto consequatur blanditiis aut voluptatem. Doloremque architecto ut aliquam quos necessitatibus error. Et autem in rerum.','/28f054a3f7df5e5a06cf3a718e159f8f.jpg','/6a743e61418f7afcc43a848ad8ec4c6e.jpg','1976-12-18 10:09:21','2006-09-27 10:37:37'),
    (UUID_TO_BIN('ecab0bbb-f3ea-35cc-b63f-5589f08410a7'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'общество','Aliquam autem accusamus labore est mollitia quis ut. Unde ducimus hic et nihil et nobis dolore. Vero at voluptas quasi animi. Dicta architecto sequi eum qui quia accusamus et aut.','/4ab01e407f8465b18535e851aa6de553.jpg','/e4b3fd2279444070c135367eafb92591.jpg','1973-09-19 21:36:41','1996-09-04 14:56:27'),
    (UUID_TO_BIN('f1883446-eaf8-354e-9304-1d99f1adc47b'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'деятельность','Expedita ex quis aliquam dolor ex. Ratione aperiam enim sint ad repudiandae sint et corrupti. Rerum maiores ea voluptas incidunt corrupti eaque facilis.','/c3322d27c05d7f47209cdce845f15547.jpg','/2bad148ce8c456b39e86a5c45df822c3.jpg','1970-04-17 01:12:06','2008-02-23 20:41:20'),
    (UUID_TO_BIN('f221b0b5-5476-35ee-bcd9-d3bd94383299'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'организация','Aliquam autem laboriosam atque. Aperiam nostrum eos voluptas animi. Qui qui repellat assumenda.','/bbfafb06effd3330e391091cd873ad64.jpg','/c9bbd714b963b79da56323335ebd3930.jpg','1993-08-01 08:37:37','2004-11-05 05:04:59'),
    (UUID_TO_BIN('f34df81a-a1e3-3e73-aa84-b3ce3304df56'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'президент','Laboriosam officia eos molestiae ut sunt dignissimos atque. Est dignissimos hic expedita. Ab rerum a id tempore.','/07e434b1d4d031f1092224a403d2f60a.jpg','/f1121d9d07ce7be2c095d14576d28fd3.jpg','1975-06-10 11:35:13','1989-11-11 03:08:30'),
    (UUID_TO_BIN('f3d658d1-c4b3-32de-8a9f-030c0f448027'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'комната','Eos molestiae velit vero odio autem explicabo. Occaecati ea omnis iusto. Molestiae autem sed alias laboriosam.','/06d97a60fe7f6c458fcb092c39f7bafe.jpg','/9a24f3c1b050c9f362713d7335f90325.jpg','2021-06-29 02:02:06','2007-08-07 04:57:06'),
    (UUID_TO_BIN('f73c2f04-3ceb-38fb-9ae5-e6a6f120633a'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'порядок','Quis praesentium deleniti nam esse mollitia harum reiciendis. Quas quia minus dolores quibusdam. Molestiae omnis blanditiis consequatur earum enim quam.','/197941f1a9296d7f132c4f6802fd37fc.jpg','/d3c6287f5386c5df6c7db9e9b091fbc3.jpg','2001-03-24 04:19:34','1977-04-09 05:03:37'),
    (UUID_TO_BIN('f89d1549-430d-3646-9d7c-222ab9d1698d'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'момент','Repudiandae sit quibusdam eum reprehenderit. Ea deserunt deleniti nostrum. Autem et accusantium esse et ut.','/adf8b3ef05a13bc48aeb22c427975a9d.jpg','/7f25c7dd2ca91ea4ccfe771f9e5420ed.jpg','1999-02-16 15:36:48','1976-04-09 00:40:17'),
    (UUID_TO_BIN('ff07ecaf-4eee-3f0a-ab7d-955aa4054e33'),UUID_TO_BIN('0dc9318e-cc5a-3093-b429-d8890431c02c'),'театр','Sunt voluptatem cumque corrupti error omnis repellendus qui. Incidunt laboriosam a rem quas adipisci maiores totam. Explicabo sit vel ipsa odio ut. Quasi magni veritatis aperiam.','/e090a1db2bc669b59e6d266ffe902533.jpg','/1203e0c8d8a649f821b24b7f5134bcb8.jpg','1973-02-28 11:38:33','1973-03-25 08:57:25');

INSERT INTO syllables
    (word_id, syllable, number, created_at, updated_at)
VALUES
    (UUID_TO_BIN('08a4aaf9-5df8-3a82-bc02-6929e4d52872'),'че',1,'1992-11-09 08:19:54','1973-01-30 19:23:25'),
    (UUID_TO_BIN('08a4aaf9-5df8-3a82-bc02-6929e4d52872'),'ло',2,'2021-04-27 13:31:12','1977-04-27 23:59:51'),
    (UUID_TO_BIN('08a4aaf9-5df8-3a82-bc02-6929e4d52872'),'ве',3,'1986-08-27 15:48:36','2005-09-17 23:28:22'),
    (UUID_TO_BIN('08a4aaf9-5df8-3a82-bc02-6929e4d52872'),'к',4,'2009-04-01 09:40:59','1992-02-07 08:23:10'),
    (UUID_TO_BIN('099c8bd8-65ce-362c-8e2a-271076f6347f'),'в',1,'1976-11-15 19:39:34','1993-11-24 16:30:27'),
    (UUID_TO_BIN('099c8bd8-65ce-362c-8e2a-271076f6347f'),'ре',2,'1984-04-27 06:54:31','2006-07-22 17:26:47'),
    (UUID_TO_BIN('099c8bd8-65ce-362c-8e2a-271076f6347f'),'мя',3,'1970-03-22 22:44:20','1998-12-05 08:41:50'),
    (UUID_TO_BIN('0afd013d-f29c-34e2-aba1-d842eef6da59'),'де',1,'1993-12-28 04:00:49','1989-11-17 02:06:33'),
    (UUID_TO_BIN('0afd013d-f29c-34e2-aba1-d842eef6da59'),'ло',2,'1987-05-31 11:55:11','2020-07-18 13:21:02'),
    (UUID_TO_BIN('0c5c6147-8e0d-3589-a786-445f67ea4d72'),'жи',1,'2016-11-25 13:05:11','1981-10-19 01:50:29'),
    (UUID_TO_BIN('0c5c6147-8e0d-3589-a786-445f67ea4d72'),'з',2,'1990-08-16 21:49:02','2018-01-18 15:25:32'),
    (UUID_TO_BIN('0c5c6147-8e0d-3589-a786-445f67ea4d72'),'нь',3,'1978-06-25 04:53:43','2004-09-23 22:33:40'),
    (UUID_TO_BIN('0eae6918-bd66-3185-8f06-f5a85fc8fa69'),'де',1,'2002-09-21 18:03:46','2011-07-24 07:48:58'),
    (UUID_TO_BIN('0eae6918-bd66-3185-8f06-f5a85fc8fa69'),'нь',2,'2011-04-22 22:47:00','1999-02-19 13:59:13'),
    (UUID_TO_BIN('0efeed09-50e9-3b89-9af9-fb08efb95bcf'),'ру',1,'1972-09-09 15:06:37','1970-02-23 14:17:58'),
    (UUID_TO_BIN('0efeed09-50e9-3b89-9af9-fb08efb95bcf'),'ка',2,'2005-12-14 16:33:07','2021-10-22 00:36:58'),
    (UUID_TO_BIN('0f3c4f4e-eabb-334c-97f4-1757fdde8658'),'ра',1,'1998-08-30 03:17:12','2005-03-28 10:41:06'),
    (UUID_TO_BIN('0f3c4f4e-eabb-334c-97f4-1757fdde8658'),'з',2,'1984-04-21 09:18:44','1979-05-17 19:23:22'),
    (UUID_TO_BIN('0f63e2a4-c8c2-3f76-90b0-77762f5a884e'),'го',1,'1974-07-17 11:58:29','1991-03-18 02:28:57'),
    (UUID_TO_BIN('0f63e2a4-c8c2-3f76-90b0-77762f5a884e'),'д',2,'2010-12-07 17:22:33','2011-10-10 07:28:36'),
    (UUID_TO_BIN('109c98b0-0753-39a9-bfc6-40e654588021'),'ра',1,'2018-02-15 13:20:17','1977-06-29 14:51:01'),
    (UUID_TO_BIN('109c98b0-0753-39a9-bfc6-40e654588021'),'бо',2,'2008-04-02 21:04:48','2021-04-08 01:45:54'),
    (UUID_TO_BIN('109c98b0-0753-39a9-bfc6-40e654588021'),'та',3,'1988-12-12 10:40:18','2010-05-09 13:49:50'),
    (UUID_TO_BIN('1725b469-8942-35f3-9edc-236ebf641a14'),'с',1,'2004-10-17 03:49:14','1977-06-01 05:31:19'),
    (UUID_TO_BIN('1725b469-8942-35f3-9edc-236ebf641a14'),'ло',2,'2002-10-07 09:14:34','2003-06-24 16:30:55'),
    (UUID_TO_BIN('1725b469-8942-35f3-9edc-236ebf641a14'),'во',3,'2001-06-11 14:05:53','2015-04-28 23:20:13'),
    (UUID_TO_BIN('1d7d59ff-800e-3989-8557-532610b00824'),'ме',1,'2014-01-25 21:56:18','1980-02-20 13:49:47'),
    (UUID_TO_BIN('1d7d59ff-800e-3989-8557-532610b00824'),'с',2,'2007-04-02 16:09:24','2019-05-24 05:12:14'),
    (UUID_TO_BIN('1d7d59ff-800e-3989-8557-532610b00824'),'то',3,'1978-06-03 17:41:12','2003-10-01 12:19:34'),
    (UUID_TO_BIN('1eefc43a-1c9d-38bc-8444-d4b4e9a5fae0'),'ли',1,'2013-04-02 05:33:05','2000-02-06 04:38:29'),
    (UUID_TO_BIN('1eefc43a-1c9d-38bc-8444-d4b4e9a5fae0'),'цо',2,'2015-03-03 11:29:43','2007-05-21 00:50:57'),
    (UUID_TO_BIN('1f169da5-a783-3a46-a30d-75ba1432d50d'),'др',1,'1995-03-31 00:56:43','1994-04-29 05:16:09'),
    (UUID_TO_BIN('1f169da5-a783-3a46-a30d-75ba1432d50d'),'уг',2,'2005-05-16 08:29:48','1973-04-16 07:29:26'),
    (UUID_TO_BIN('23e07d52-9f97-38a2-9df7-f83ff01cc213'),'гл',1,'2011-04-22 09:31:41','1980-06-06 01:43:25'),
    (UUID_TO_BIN('23e07d52-9f97-38a2-9df7-f83ff01cc213'),'аз',2,'1973-05-15 01:48:22','1995-11-20 21:51:47'),
    (UUID_TO_BIN('23faa0de-e52a-3b04-a8b9-7b6a6765da42'),'во',1,'2014-10-31 20:47:17','1982-03-01 07:55:34'),
    (UUID_TO_BIN('23faa0de-e52a-3b04-a8b9-7b6a6765da42'),'пр',2,'2017-04-12 00:40:08','1997-01-18 12:29:30'),
    (UUID_TO_BIN('23faa0de-e52a-3b04-a8b9-7b6a6765da42'),'ос',3,'2014-05-22 21:42:44','2013-03-22 00:14:08'),
    (UUID_TO_BIN('24aa46d6-7cb8-3219-88a2-2a87d83d9170'),'до',1,'1999-02-02 06:07:16','1998-07-31 16:53:06'),
    (UUID_TO_BIN('24aa46d6-7cb8-3219-88a2-2a87d83d9170'),'м',2,'1985-07-27 13:54:55','2020-12-22 15:47:58'),
    (UUID_TO_BIN('24d196ff-58b1-3896-afd4-bd5fbeda0663'),'с',1,'1985-08-25 18:09:42','2002-03-13 09:16:50'),
    (UUID_TO_BIN('24d196ff-58b1-3896-afd4-bd5fbeda0663'),'то',2,'1994-02-05 17:46:55','1986-07-26 04:27:48'),
    (UUID_TO_BIN('24d196ff-58b1-3896-afd4-bd5fbeda0663'),'ро',3,'2004-02-02 17:04:54','1984-11-05 10:37:54'),
    (UUID_TO_BIN('24d196ff-58b1-3896-afd4-bd5fbeda0663'),'на',4,'2003-11-30 08:55:09','1991-10-09 11:22:27'),
    (UUID_TO_BIN('28855a77-d504-3efa-b83b-cc1a96c7fd2a'),'ст',1,'2019-11-22 01:42:58','2013-05-30 05:00:56'),
    (UUID_TO_BIN('28855a77-d504-3efa-b83b-cc1a96c7fd2a'),'ра',2,'2001-06-06 19:43:25','1972-10-11 13:17:39'),
    (UUID_TO_BIN('28855a77-d504-3efa-b83b-cc1a96c7fd2a'),'на',3,'1976-04-22 13:36:40','1981-04-29 07:18:22'),
    (UUID_TO_BIN('2b1026b4-b966-3416-95e7-7d182a3ac43a'),'ми',1,'1970-02-02 13:20:36','2011-07-28 23:23:23'),
    (UUID_TO_BIN('2b1026b4-b966-3416-95e7-7d182a3ac43a'),'р',2,'1977-12-07 22:28:01','1990-09-22 19:58:20'),
    (UUID_TO_BIN('2d840ee0-e0db-3832-9e0a-90fccd3b9339'),'сл',1,'2013-08-03 22:30:38','2015-10-04 15:50:30'),
    (UUID_TO_BIN('2d840ee0-e0db-3832-9e0a-90fccd3b9339'),'уч',2,'1997-08-19 04:17:42','1988-04-21 23:55:04'),
    (UUID_TO_BIN('2d840ee0-e0db-3832-9e0a-90fccd3b9339'),'ай',3,'2008-06-11 22:57:46','2020-08-09 07:36:40'),
    (UUID_TO_BIN('31a1649f-bd8c-3c30-a8bc-406f3df249be'),'го',1,'2015-08-23 04:18:37','2012-04-12 00:27:16'),
    (UUID_TO_BIN('31a1649f-bd8c-3c30-a8bc-406f3df249be'),'ло',2,'1986-12-12 11:24:12','1981-01-15 13:42:17'),
    (UUID_TO_BIN('31a1649f-bd8c-3c30-a8bc-406f3df249be'),'ва',3,'1987-04-21 02:14:28','1983-02-12 23:26:25'),
    (UUID_TO_BIN('338c3436-35f3-37ba-a1a1-58bf16a90624'),'ре',1,'1979-01-03 13:02:53','1995-12-15 03:31:56'),
    (UUID_TO_BIN('338c3436-35f3-37ba-a1a1-58bf16a90624'),'бе',2,'2010-01-09 21:57:51','1976-11-26 05:00:19'),
    (UUID_TO_BIN('338c3436-35f3-37ba-a1a1-58bf16a90624'),'но',3,'1991-12-22 15:09:12','2001-01-26 03:25:25'),
    (UUID_TO_BIN('338c3436-35f3-37ba-a1a1-58bf16a90624'),'к',4,'2018-08-07 06:53:19','2018-05-02 08:00:20'),
    (UUID_TO_BIN('3a8beeae-2972-3950-8d97-9ec2a6080140'),'си',1,'2011-06-11 15:22:31','1995-11-22 00:00:09'),
    (UUID_TO_BIN('3a8beeae-2972-3950-8d97-9ec2a6080140'),'ла',2,'2014-01-16 11:29:34','1995-11-21 07:46:53'),
    (UUID_TO_BIN('3bd0134f-daad-3143-9bfe-db43d5034ebb'),'ко',2,'1994-07-14 09:35:04','1982-01-30 18:26:41'),
    (UUID_TO_BIN('3bd0134f-daad-3143-9bfe-db43d5034ebb'),'не',8,'1980-03-18 19:58:55','2011-06-26 18:33:11'),
    (UUID_TO_BIN('3bd0134f-daad-3143-9bfe-db43d5034ebb'),'ц',8,'1990-10-09 07:31:35','2007-02-13 21:59:10'),
    (UUID_TO_BIN('3ca7fc62-cc16-35f4-860a-ca7c9b1f911e'),'ви',1,'1995-05-14 08:44:56','1987-11-15 00:57:16'),
    (UUID_TO_BIN('3ca7fc62-cc16-35f4-860a-ca7c9b1f911e'),'д',2,'2010-12-14 06:44:42','2001-09-01 16:41:41'),
    (UUID_TO_BIN('3df7ed07-6670-3beb-87e5-45bd7247f2d7'),'сис',1,'1973-08-05 02:30:21','2019-04-04 10:30:34'),
    (UUID_TO_BIN('3df7ed07-6670-3beb-87e5-45bd7247f2d7'),'те',2,'2014-08-30 22:25:32','2017-02-27 12:19:20'),
    (UUID_TO_BIN('3df7ed07-6670-3beb-87e5-45bd7247f2d7'),'ма',3,'1985-05-06 06:38:39','2017-10-15 19:22:25'),
    (UUID_TO_BIN('424a6260-0c8e-37a4-a510-d36d4bba54c2'),'час',1,'2000-12-21 14:31:46','2006-12-10 05:52:27'),
    (UUID_TO_BIN('424a6260-0c8e-37a4-a510-d36d4bba54c2'),'ть',2,'1977-05-07 20:21:31','2016-10-25 23:06:12'),
    (UUID_TO_BIN('43461794-ecb9-37f3-a8a6-ce1c8684761e'),'го',1,'1997-04-21 18:32:38','2014-12-15 18:08:51'),
    (UUID_TO_BIN('43461794-ecb9-37f3-a8a6-ce1c8684761e'),'ро',2,'1990-04-12 20:49:22','2019-11-25 19:57:25'),
    (UUID_TO_BIN('43461794-ecb9-37f3-a8a6-ce1c8684761e'),'д',3,'1977-02-21 17:58:47','1998-04-21 05:37:59'),
    (UUID_TO_BIN('436057c7-7328-394e-b72e-63f4b23bbc13'),'от',1,'1975-03-14 15:37:40','1997-01-09 21:52:46'),
    (UUID_TO_BIN('436057c7-7328-394e-b72e-63f4b23bbc13'),'но',2,'2013-10-07 12:41:30','1992-04-04 08:36:21'),
    (UUID_TO_BIN('436057c7-7328-394e-b72e-63f4b23bbc13'),'ше',3,'1999-12-03 00:00:58','1981-10-26 15:30:50'),
    (UUID_TO_BIN('436057c7-7328-394e-b72e-63f4b23bbc13'),'ни',4,'1976-02-05 07:11:37','1987-06-05 08:32:57'),
    (UUID_TO_BIN('436057c7-7328-394e-b72e-63f4b23bbc13'),'е',5,'2017-12-22 00:41:23','2019-02-01 07:55:02'),
    (UUID_TO_BIN('45d81789-a00c-3e9d-bed2-538b1d23ef6d'),'жен',1,'1980-02-14 14:53:36','1986-07-12 09:54:20'),
    (UUID_TO_BIN('45d81789-a00c-3e9d-bed2-538b1d23ef6d'),'щи',2,'1971-05-30 20:40:02','1990-04-14 21:44:59'),
    (UUID_TO_BIN('45d81789-a00c-3e9d-bed2-538b1d23ef6d'),'на',3,'1990-01-17 16:06:42','2008-06-10 00:48:54'),
    (UUID_TO_BIN('47ae2758-9e0a-3798-bbb4-3a1f3c3b1a80'),'де',1,'2018-06-22 15:43:14','1991-12-04 09:39:51'),
    (UUID_TO_BIN('47ae2758-9e0a-3798-bbb4-3a1f3c3b1a80'),'нь',2,'1977-08-10 21:45:20','1976-10-14 13:38:32'),
    (UUID_TO_BIN('47ae2758-9e0a-3798-bbb4-3a1f3c3b1a80'),'ги',3,'2015-02-06 18:39:48','1971-12-10 17:10:26'),
    (UUID_TO_BIN('4a7b5f0a-651e-3050-8438-103ffafd6f72'),'зем',1,'2007-02-02 19:46:23','2014-03-21 05:51:08'),
    (UUID_TO_BIN('4a7b5f0a-651e-3050-8438-103ffafd6f72'),'ля',2,'1982-10-22 21:28:09','1981-04-26 05:20:13'),
    (UUID_TO_BIN('4c10dbee-f153-304d-9ff7-25ea8dda0fdb'),'ма',1,'2001-05-18 22:02:08','2000-05-25 23:35:55'),
    (UUID_TO_BIN('4c10dbee-f153-304d-9ff7-25ea8dda0fdb'),'ши',2,'2015-10-19 14:43:45','1977-08-19 02:16:11'),
    (UUID_TO_BIN('4c10dbee-f153-304d-9ff7-25ea8dda0fdb'),'на',3,'1996-10-23 01:22:10','2018-11-12 04:55:41'),
    (UUID_TO_BIN('4c9db27b-0e69-3d99-b9f5-5b19da0a6db7'),'во',1,'1987-06-10 14:27:38','2017-05-28 18:49:17'),
    (UUID_TO_BIN('4c9db27b-0e69-3d99-b9f5-5b19da0a6db7'),'да',2,'2005-07-08 02:06:40','1995-02-12 17:20:18'),
    (UUID_TO_BIN('51d59f7a-adbb-3bd1-bb5e-2918a6cddde6'),'от',1,'1996-07-08 01:30:36','2010-03-04 11:18:02'),
    (UUID_TO_BIN('51d59f7a-adbb-3bd1-bb5e-2918a6cddde6'),'ец',2,'1976-11-02 03:47:07','1993-01-02 16:54:13');

INSERT INTO c_progress_words_statuses
    (id, name, description)
VALUE
    (UUID_TO_BIN('14bacfcb-1a61-4f8e-a324-7388adab80cb'), 'selected', 'Слово выбрано для текущего пользователя и уровня'),
    (UUID_TO_BIN('49b99e4a-fea8-47d3-ba28-e994d9d5b957'), 'visible', 'Слово видимо для текущего пользователя и уровня в данный момент'),
    (UUID_TO_BIN('d2d21e24-dc26-4a70-a142-397c06bec6e0'), 'used', 'Слово отгадано');

INSERT INTO c_hints
    (id, name, description, price)
VALUE
    (UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),'first_syllable','Первый слог',50),
    (UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),'skip_picture','Пропустить картинку',100),
    (UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),'change_all_pictures','Поменять все картинки',200);
    
INSERT INTO user_hints 
    (user_id, hint_id, count, created_at, updated_at)
VALUES 
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),48914,'2005-11-28 22:22:56','1996-09-04 20:28:08'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),999,'1986-09-13 22:22:43','1989-06-29 18:42:47'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),678,'1982-11-18 15:22:09','2017-08-27 09:57:28'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),56,'2003-05-21 19:40:24','2016-12-21 16:03:21'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),45,'2016-02-24 23:37:01','1984-02-04 01:03:57'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),5,'2012-06-04 15:41:31','1981-03-02 17:57:21'),
    (UUID_TO_BIN('df4f35b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),98,'2019-07-28 17:44:30','1972-01-03 06:37:32'),
    (UUID_TO_BIN('df4f35b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),234,'1980-10-16 21:14:48','2008-07-15 10:06:22'),
    (UUID_TO_BIN('df4f35b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),12,'1996-05-29 11:12:08','1995-06-18 00:34:45'),
    (UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),67,'2018-03-01 04:27:06','1985-07-24 13:25:58'),
    (UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),525,'1988-03-11 17:12:31','1999-04-21 05:01:29'),
    (UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),6966,'1984-05-31 18:00:45','1999-11-21 12:04:00'),
    (UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),45,'1979-11-24 08:51:42','1988-07-26 13:37:36'),
    (UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),87,'1981-02-23 10:49:24','2005-08-07 12:55:37'),
    (UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),0,'1982-02-06 17:45:38','1971-10-28 16:36:29'),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),77,'1971-05-26 07:09:18','1970-08-12 23:59:48'),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),678,'2004-04-26 23:28:12','1981-11-25 22:26:40'),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),50647,'1972-03-22 01:23:32','2008-02-26 01:37:23'),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),0,'1974-04-20 05:12:03','2017-06-05 01:30:00'),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),5278,'1988-08-28 21:01:29','1976-05-06 01:30:04'),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),741,'1985-07-04 02:57:43','1972-01-22 22:11:12'),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),0,'2021-05-28 09:04:51','2021-10-14 13:59:56'),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),6,'2019-01-03 12:03:49','2007-12-19 13:25:11'),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),719,'1992-08-31 00:24:11','2001-04-05 15:42:47'),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),67,'1980-01-16 09:23:53','1992-10-15 10:57:54'),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),878,'2016-03-12 04:24:51','2018-08-06 17:38:46'),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),667,'2000-06-09 09:43:19','1986-02-15 00:33:50'),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),7,'1974-08-03 01:23:20','1995-05-30 15:52:06'),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),56361,'1986-04-24 12:32:06','1990-03-27 21:31:53'),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),8,'2017-08-12 14:17:32','2002-11-21 01:30:05'),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),34,'2000-03-06 14:03:02','1970-07-31 21:40:09'),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),9127084,'2008-06-25 13:24:35','2021-07-01 00:59:10'),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),8538,'2004-06-12 06:51:56','1996-12-11 11:13:43'),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),1083687,'1998-11-03 08:01:14','1979-03-21 07:17:08'),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),479291,'2013-06-16 08:48:18','1995-07-05 06:41:04'),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),812708,'2016-10-02 03:04:02','1989-02-20 22:04:35'),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),783163,'1970-12-07 07:58:47','2016-03-18 21:38:07'),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),5902167,'1985-06-25 03:48:22','1989-05-17 10:49:20'),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),4,'1983-04-20 09:07:43','2019-02-23 05:54:49'),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),8,'1972-06-14 11:27:32','2000-07-31 05:00:26'),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),475,'1989-05-04 23:34:40','2001-11-18 05:45:53'),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),75315,'1970-01-30 03:19:10','1983-01-10 10:44:32'),
    (UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),0,'1990-08-22 11:23:45','1975-04-09 10:14:18'),
    (UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),680,'2017-11-10 13:34:14','1998-07-08 07:51:18'),
    (UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),0,'1977-08-10 16:43:37','1978-10-10 19:56:30'),
    (UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),5,'1982-05-03 12:02:34','1982-04-24 08:59:02'),
    (UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),6,'1977-09-29 13:01:40','1997-12-16 02:27:28'),
    (UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),624284,'2020-02-24 23:20:34','1976-05-25 15:39:33'),
    (UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),607,'1983-11-17 21:15:17','1987-09-27 20:58:43'),
    (UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),420,'2008-04-21 17:48:39','2008-08-19 01:06:42'),
    (UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),0,'1979-08-01 19:28:36','2001-10-09 19:32:21'),
    (UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),3,'2017-04-28 04:15:50','1992-03-10 07:07:53'),
    (UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),4,'1983-04-20 07:50:58','2006-01-03 11:19:52'),
    (UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),877,'1992-01-25 12:10:06','1990-07-21 02:17:39'),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),5710,'2004-12-02 09:07:17','2013-01-13 21:45:44'),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),429,'2001-03-10 05:32:12','2017-05-08 07:05:51'),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),1019,'1988-08-17 12:56:58','1985-05-11 13:37:17'),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),18178,'1982-10-03 15:24:37','1970-11-30 20:46:55'),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),84233,'1999-12-10 06:33:45','2003-02-18 16:55:38'),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),0,'2015-11-03 22:03:20','2007-10-10 16:05:45'),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),56,'2004-12-05 01:18:45','1972-04-01 10:30:51'),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),2888,'1998-09-08 00:42:15','2021-04-07 00:16:35'),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),8637474,'1970-10-02 12:50:28','2013-04-13 02:42:50'),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),6,'2001-01-16 18:09:47','2006-12-29 12:03:43'),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),7912,'2016-11-05 01:59:23','2000-07-12 17:56:16'),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),1,'1983-08-24 09:43:02','1986-07-04 17:22:17'),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),9,'1987-11-17 21:40:19','1984-02-05 08:23:14'),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),213,'1996-06-21 21:13:22','1981-07-21 15:33:19'),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),990363,'2005-07-09 20:04:12','2006-08-12 06:05:32'),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),7769827,'1972-02-07 07:03:23','2003-03-25 02:19:37'),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),64,'2001-10-06 15:17:34','1988-11-15 02:33:52'),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),32917,'2021-10-10 09:32:02','1983-08-03 14:00:38'),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),275,'2017-12-08 18:44:15','1984-09-10 22:55:58'),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),5,'2003-06-07 04:19:48','2012-02-01 21:34:31'),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),80,'1990-03-11 14:56:10','2018-02-05 16:21:19'),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),9,'2019-12-28 12:00:59','1986-08-10 10:45:40'),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),5,'1985-04-01 19:03:38','2012-01-09 13:30:21'),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7bb03243-85db-47a4-baa2-c7827d0e3142'),6,'1991-09-01 16:50:12','1979-11-12 00:57:56'),
    (UUID_TO_BIN('df4f6b63-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('b92cdb17-381d-4abf-b731-da2090e2b4bd'),7510,'2014-04-21 04:21:02','1974-04-16 16:17:54'),
    (UUID_TO_BIN('df4f6b63-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('78c0dab3-ec6e-4c22-a6c8-fb6c56de5aac'),2155,'1979-02-27 15:34:23','1972-12-18 16:05:34');

INSERT INTO c_friend_requests_statuses
    (id, name, description)
VALUE
    (UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'), 'requested', 'Запрос на дружбу отправлен'),
    (UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'), 'approved', 'Запрос на дружбу принят'),
    (UUID_TO_BIN('19a28401-7799-42d1-bb5f-e9762295ccc3'), 'declined', 'Запрос на дружбу отклонен'),
    (UUID_TO_BIN('17a1fa69-5fa1-4ada-b40a-fd33c45fa706'), 'unfriended', 'Больше не друзья');

INSERT INTO friend_requests
    (initiator_user_id, target_user_id, status_id, created_at, updated_at)
VALUES 
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1989-02-12 08:53:51','1988-08-19 10:57:18'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f3a14-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'2013-05-16 01:43:28','2020-10-15 11:51:29'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f3c32-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1989-12-19 20:00:01','1972-05-25 04:20:16'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f400f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('19a28401-7799-42d1-bb5f-e9762295ccc3'),'1991-04-28 08:04:45','1987-10-10 16:32:10'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'2003-04-21 15:25:56','1970-10-04 14:31:35'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'2008-09-02 07:19:16','1996-06-24 15:38:48'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('17a1fa69-5fa1-4ada-b40a-fd33c45fa706'),'2002-02-04 05:02:05','2009-05-08 03:21:13'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1986-09-24 04:42:16','1992-03-06 01:17:11'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('19a28401-7799-42d1-bb5f-e9762295ccc3'),'1998-01-06 23:49:07','1999-05-06 20:08:04'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'2004-07-18 09:58:05','2014-06-14 16:36:34'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('17a1fa69-5fa1-4ada-b40a-fd33c45fa706'),'1994-06-06 02:24:50','1986-10-31 09:29:49'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1990-07-02 07:01:39','1974-12-28 17:59:30'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'2003-12-30 12:55:33','1991-05-06 21:51:52'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('19a28401-7799-42d1-bb5f-e9762295ccc3'),'1990-07-16 15:33:53','2014-03-07 13:04:29'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'2003-07-29 00:34:43','1996-08-28 02:37:59'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1996-10-11 13:07:38','1984-04-30 18:35:57'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('19a28401-7799-42d1-bb5f-e9762295ccc3'),'2000-04-07 04:55:38','1994-12-28 03:14:49'),
    (UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f3528-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('17a1fa69-5fa1-4ada-b40a-fd33c45fa706'),'1978-02-16 20:52:04','1977-08-10 12:25:11'),
    (UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f383b-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1988-12-10 23:55:59','2017-08-31 04:02:27'),
    (UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4236-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('17a1fa69-5fa1-4ada-b40a-fd33c45fa706'),'2006-12-18 18:28:48','2015-07-20 18:14:04'),
    (UUID_TO_BIN('df4f630a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4ac2-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'1977-08-29 22:54:24','1984-12-11 02:21:04'),
    (UUID_TO_BIN('df4f64b3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f4cf7-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1981-04-08 06:20:42','2008-10-09 22:47:49'),
    (UUID_TO_BIN('df4f65d3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f53a3-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('19a28401-7799-42d1-bb5f-e9762295ccc3'),'1982-06-22 08:22:08','2016-01-30 10:44:03'),
    (UUID_TO_BIN('df4f6811-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5937-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'1995-12-31 09:23:43','1991-05-24 17:39:21'),
    (UUID_TO_BIN('df4f692f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5e86-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'2008-07-27 06:57:24','1984-03-16 11:36:01'),
    (UUID_TO_BIN('df4f6b63-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f603f-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('7f02db54-d2a7-4c4c-9420-17ffec51265d'),'1998-01-25 19:26:12','1976-03-26 19:31:31'),
    (UUID_TO_BIN('df4f6d0a-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f32eb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('5a3109b8-aae7-46fd-b522-71a9c3dba21f'),'1982-12-21 13:52:57','2010-01-07 05:57:38');

INSERT INTO messages
    (from_user_id, to_user_id, header, body, created_at, updated_at)
VALUES 
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),'Laudantium voluptas et perspiciatis aliquam. Quam minima ducimus sunt et et perferendis officia. Vel','Et odio vitae fugit saepe voluptates amet omnis quis. Voluptas eos omnis explicabo aperiam aut fugiat iure sapiente. Modi beatae ut nobis eveniet facilis et placeat.','2013-04-22 12:38:45','1989-05-28 01:43:53'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),'Nostrum nostrum impedit occaecati libero. Autem est vel voluptate porro eligendi sed. Consequatur et','Saepe consequatur nobis exercitationem quae suscipit debitis. Odit unde dolor necessitatibus blanditiis. Voluptates culpa aut voluptas quas. Dolorem quod nobis sit dolore debitis dicta.','1972-07-05 06:01:47','1970-01-07 17:53:27'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),'Ut id ab quia sequi nemo illo. Ut consectetur voluptatem rerum. Adipisci vitae est quo ut alias inci','Earum illum voluptatibus sed quis odio. Ex qui ut iste placeat. Et animi maiores voluptatem tempore voluptatibus nihil. Molestiae et qui nulla tempora.','2006-10-01 14:18:56','1990-11-13 06:09:37'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),'Molestiae sunt dolores non sed vel soluta. Voluptatem aut rerum at ducimus. Distinctio voluptas ut u','A numquam ut ad est. Voluptas quia aut quasi ut modi quisquam. Ea ratione explicabo earum quod dolorum inventore. Non ipsam quis quis. Praesentium nostrum eum aut et sunt deleniti ut.','1985-01-29 13:34:06','1975-01-30 06:23:18'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),'Sit cum quod totam dolorem. Hic quos commodi illum ullam aut. Voluptatum porro voluptatem vel tempor','Accusantium ea minima ratione aspernatur exercitationem. Molestias pariatur temporibus ipsum nulla. Dolore atque iusto ut nemo.','1996-08-21 18:53:59','1985-01-23 04:31:47'),
    (UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Deserunt quis qui est sed beatae voluptates voluptatibus. Ad tempore deleniti rerum laboriosam labor','Accusamus a qui esse ut. Quidem quos itaque qui exercitationem officia quia molestias. Dolorem facilis sit id nihil. Ipsam id magnam occaecati cum nemo nemo ut.','1977-04-20 09:44:02','2013-04-18 05:24:32'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Provident consequatur quibusdam sed nesciunt numquam tempore rerum. Neque voluptates qui est tempore','Facilis quod delectus non quibusdam. Libero unde maiores aspernatur officia ab eum non. Atque quia error accusantium et voluptatem.','2000-10-08 16:02:04','1979-11-05 16:32:52'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f566d-3431-11ec-a045-d43b0469c611'),'Voluptatibus enim saepe ut voluptatibus. Sed esse et incidunt omnis. Earum perferendis quam explicab','Quasi qui incidunt delectus molestias. Et quasi ad sed et laboriosam atque quas.','2009-07-26 15:10:25','1971-05-16 08:08:15'),
    (UUID_TO_BIN('df4f33f1-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Iusto recusandae expedita doloribus repellendus quam quo perspiciatis laudantium. Minima facilis lab','Enim nobis eum suscipit est et. Et dolores non saepe dolorem atque. Mollitia enim nihil cumque voluptatem nostrum. Nam id harum molestiae. Suscipit sit culpa porro provident porro ex est.','2021-06-19 20:00:28','2015-03-20 00:54:56'),
    (UUID_TO_BIN('df4f4386-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f59c9-3431-11ec-a045-d43b0469c611'),'Consequatur earum adipisci in nobis laboriosam tempora. Reprehenderit voluptates repellendus corrupt','Porro animi architecto consequatur dolor quis officia voluptatem soluta. Molestias modi tempore quisquam rerum consequatur quo voluptatum natus. Suscipit ad ut nihil voluptatem possimus ratione dolor.','2008-03-06 02:22:29','2017-08-05 18:28:54'),
    (UUID_TO_BIN('df4f44a6-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5a55-3431-11ec-a045-d43b0469c611'),'Quod minima incidunt in cumque cumque rem sapiente eos. Fugit molestias deserunt aut asperiores. Ver','Molestiae quis praesentium non qui nihil ut. Et et at iste occaecati. Explicabo et exercitationem quaerat aut.','2014-05-11 11:32:52','2002-02-03 06:43:11'),
    (UUID_TO_BIN('df4f45bc-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Dolores ea nostrum non illum eveniet est. Labore optio sint dolore ea nulla voluptate impedit. Sint ','Illum veritatis consequatur sint dolor. Autem sit sint odio qui voluptatem quo. Enim nihil et consequatur minus eveniet incidunt.','1990-01-24 23:47:14','2001-03-17 18:56:16'),
    (UUID_TO_BIN('df4f4922-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5ae7-3431-11ec-a045-d43b0469c611'),'Doloribus et tempora in voluptate necessitatibus. Eveniet animi commodi laboriosam amet perspiciatis','Molestiae sunt dicta aut ducimus tempora delectus. Sed consequatur labore enim veritatis alias sapiente.','2012-02-09 08:55:04','2016-03-15 00:41:27'),
    (UUID_TO_BIN('df4f4c69-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5d68-3431-11ec-a045-d43b0469c611'),'Doloremque ad iure explicabo quia qui quis fugiat. Quas et et vel repellat dicta. Consequatur volupt','Eum unde rerum alias iste iste. Omnis fugit sit consequuntur odio saepe. Occaecati veniam sunt consequatur esse officia vel.','1988-11-29 06:24:46','1980-10-11 12:49:49'),
    (UUID_TO_BIN('df4f4fbe-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f5f22-3431-11ec-a045-d43b0469c611'),'Unde nulla maiores eum et vel distinctio sunt. Nesciunt repellendus omnis nisi iste. Recusandae qui ','Iusto temporibus est delectus eos iure incidunt necessitatibus. Nemo quibusdam distinctio qui vel sint facere praesentium aut. Dolore asperiores velit quia quia.','2006-01-01 16:17:13','2005-07-11 09:39:54'),
    (UUID_TO_BIN('df4f504d-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Voluptates autem at quam modi. Esse qui minima laboriosam quam et voluptatibus. Impedit explicabo la','At sit sed molestias consequatur. Aut vitae vel repellat cum cumque labore vel.','2017-05-31 00:55:03','1980-04-20 09:08:32'),
    (UUID_TO_BIN('df4f5316-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f627a-3431-11ec-a045-d43b0469c611'),'Dolor modi voluptatibus provident magnam ut temporibus. Quia voluptatem ex ducimus dolores. Qui duci','Aliquid sit eius pariatur repellendus deserunt soluta. Nulla deserunt maxime quis sit inventore nihil aut expedita.','2015-08-21 23:08:05','1988-10-05 17:24:26'),
    (UUID_TO_BIN('df4f5430-3431-11ec-a045-d43b0469c611'),UUID_TO_BIN('df4f30cb-3431-11ec-a045-d43b0469c611'),'Dolorem natus excepturi accusantium a sit mollitia. Aut doloribus magni ullam inventore cum. In et n','Sed fugit aliquid nemo fuga quasi ut et. Minus ab id sit quod. Quidem amet deleniti suscipit quae ut ratione accusantium. Atque enim dolorum quaerat illo suscipit. Nesciunt tempore molestias nihil id odit.','1993-09-06 20:12:48','2020-11-13 13:14:58');





-- INSERT INTO users
--     (firstname, lastname, email, password_hash)
-- VALUE
--     ('Admin', 'Admin', 'admin1@example.com', '8798879');

-- select BIN_TO_UUID(id) as id from users;

-- delete from users;

-- SELECT REPLACE(CAST(UUID() as char character set latin1), '-', ''), REPLACE(CAST(UUID() as char character set utf8), '-', '');

-- id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE

-- INSERT INTO users
--     (id, firstname)
-- VALUES (UUID(), 'aloha'),
--        (UUID(), 'hola');