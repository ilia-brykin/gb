DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

INSERT INTO catalogs VALUES
  (NULL, 'Процессоры'),
  (NULL, 'Материнские платы'),
  (NULL, 'Видеокарты'),
  (NULL, 'Жесткие диски'),
  (NULL, 'Оперативная память');

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '1990-10-05'),
  ('Наталья', '1984-11-12'),
  ('Александр', '1985-05-20'),
  ('Сергей', '1988-02-14'),
  ('Иван', '1998-01-12'),
  ('Мария', '1992-08-29');

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';

INSERT INTO products
  (name, description, price, catalog_id)
VALUES
  ('Intel Core i3-8100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 7890.00, 1),
  ('Intel Core i5-7400', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12700.00, 1),
  ('AMD FX-8320E', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 4780.00, 1),
  ('AMD FX-8320', 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.', 7120.00, 1),
  ('ASUS ROG MAXIMUS X HERO', 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX', 19310.00, 2),
  ('Gigabyte H310M S2H', 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX', 4790.00, 2),
  ('MSI B250M GAMING PRO', 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX', 5060.00, 2);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

DROP TABLE IF EXISTS orders_products;
CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id INT UNSIGNED,
  product_id INT UNSIGNED,
  discount FLOAT UNSIGNED COMMENT 'Величина скидки от 0.0 до 1.0',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';

DROP TABLE IF EXISTS storehouses;
CREATE TABLE storehouses (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  storehouse_id INT UNSIGNED,
  product_id INT UNSIGNED,
  value INT UNSIGNED COMMENT 'Запас товарной позиции на складе',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

-- 1) Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
    table_name VARCHAR(50) NOT NULL,
    id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL
) ENGINE=Archive;

DROP PROCEDURE IF EXISTS log_insert;
DELIMITER //
CREATE PROCEDURE log_insert(table_name VARCHAR(50), id BIGINT, name VARCHAR(255), created_at DATETIME)
BEGIN
    INSERT INTO logs (table_name, id, name, created_at)
    VALUES
    (table_name, id, name, created_at);
END//
DELIMITER ;

DROP TRIGGER IF EXISTS log_user_insert;
DELIMITER //
CREATE TRIGGER log_user_insert AFTER INSERT ON users
FOR EACH ROW
BEGIN
    CALL log_insert('users', NEW.id, NEW.name, NEW.created_at);
END//
DELIMITER ;

DROP TRIGGER IF EXISTS log_catalog_insert;
DELIMITER //
CREATE TRIGGER log_catalog_insert AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
    CALL log_insert('catalogs', NEW.id, NEW.name, NOW());
END//
DELIMITER ;

DROP TRIGGER IF EXISTS log_product_insert;
DELIMITER //
CREATE TRIGGER log_product_insert AFTER INSERT ON products
FOR EACH ROW
BEGIN
    CALL log_insert('products', NEW.id, NEW.name, NEW.created_at);
END//
DELIMITER ;

-- 2) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- Решение номер 1 долгое
DROP PROCEDURE IF EXISTS insert_users;
DELIMITER //
CREATE PROCEDURE insert_users()
BEGIN
DECLARE i INT DEFAULT 1;
WHILE (i <= 1000000) DO
    INSERT INTO users (name, birthday_at)
    VALUES
    (CONCAT('user ', i),
     date_format( -- случайная дата из диапазона 1960-01-01 - 2000-01-01
        from_unixtime(
             rand() *
                (unix_timestamp('1960-01-01') - unix_timestamp('2000-01-01')) +
                 unix_timestamp('2000-01-01')
                      ), '%Y-%m-%d'));
    SET i = i + 1;
END WHILE;
END;
DELIMITER ;

CALL insert_users();

-- Решение номер 2 более быстрое
-- Создадим таблицу с одним полем, наполним ее 1000 записей.
-- Затем заполним таблицу users используя temp_table JOIN temp_table,
-- декартово произведение 1000 * 1000 = 100000

DROP TABLE IF EXISTS temp_table;
CREATE TABLE temp_table (
  id SERIAL PRIMARY KEY
);

DROP PROCEDURE IF EXISTS insert_temp_table;
DELIMITER //
CREATE PROCEDURE insert_temp_table()
BEGIN
DECLARE i INT DEFAULT 1;
WHILE (i <= 1000) DO
    INSERT INTO temp_table (id)
    VALUES
    (NULL);
    SET i = i + 1;
END WHILE;
END;
DELIMITER ;

CALL insert_temp_table();

INSERT INTO users (name, birthday_at)
SELECT concat('user ', t1.id, '_', t2.id), NOW() from temp_table as t1
JOIN temp_table as t2;

DROP TABLE IF EXISTS temp_table;
