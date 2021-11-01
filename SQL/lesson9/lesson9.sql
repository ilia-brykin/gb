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

-- Практическое задание по теме “Транзакции, переменные, представления”

-- 1) В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
-- Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

-- DB sample
DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample;
USE sample;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

USE shop;

START TRANSACTION;

INSERT INTO sample.users
SELECT * FROM shop.users WHERE id = 1;

DELETE FROM shop.users
    WHERE id = 1;

COMMIT;

-- 2) Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название
-- каталога name из таблицы catalogs.

DROP VIEW IF EXISTS products_catalogs;
CREATE VIEW products_catalogs AS SELECT p.name AS p_name, c.name AS c_name FROM products p
JOIN catalogs c on p.catalog_id = c.id;

-- 3) (по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены разряженые календарные записи
-- за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. Составьте запрос, который выводит полный
-- список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.

DROP TEMPORARY TABLE IF EXISTS temp_dates;
CREATE TEMPORARY TABLE temp_dates (id SERIAL PRIMARY KEY, created_at DATE);
INSERT INTO temp_dates (created_at)
VALUES
  ('2018-08-01'),
  (NULL),
  ('2018-08-16'),
  ('2018-08-17'),
  (NULL),
  ('2018-08-02'),
  (NULL),
  ('2018-08-03'),
  ('2018-08-09'),
  (NULL),
  ('2018-08-04');

SELECT created_at, IF(created_at IS NULL, 0, 1) AS date_exist FROM temp_dates;

-- 4) (по желанию) Пусть имеется любая таблица с календарным полем created_at. Создайте запрос, который удаляет устаревшие
-- записи из таблицы, оставляя только 5 самых свежих записей.

DROP TABLE IF EXISTS temp_dates_2;
CREATE TEMPORARY TABLE temp_dates_2 (id SERIAL PRIMARY KEY, created_at DATE NOT NULL);
INSERT INTO temp_dates_2 (created_at)
VALUES
  ('2018-08-01'),
  ('2020-08-01'),
  ('2018-08-16'),
  ('2018-08-17'),
  ('2019-08-01'),
  ('2018-08-02'),
  ('2017-08-01'),
  ('2018-08-03'),
  ('2018-08-09'),
  ('2018-01-09'),
  ('2018-06-01'),
  ('2018-03-02'),
  ('2018-08-04');

SELECT @total_dates := COUNT(*) FROM temp_dates_2;
IF @total_dates > 5 THEN
    SET @total_dates := @total_dates - 5;
    PREPARE delete_dates FROM 'DELETE FROM temp_dates_2 ORDER BY created_at LIMIT ?';
    EXECUTE delete_dates USING @total_dates;
END IF;


-- Практическое задание по теме “Администрирование MySQL” (эта тема изучается по вашему желанию)

-- 1) Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

CREATE USER shop_read IDENTIFIED WITH sha256_password BY 'aloha';
GRANT SELECT ON shop.* TO shop_read;
CREATE USER shop IDENTIFIED WITH sha256_password BY 'aloha';
GRANT ALL ON shop.* TO shop;

-- 2) (по желанию) Пусть имеется таблица accounts содержащая три столбца id, name, password,
-- содержащие первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющий доступ к столбца id и name. Создайте пользователя user_read, который бы не имел доступа к таблице accounts,
-- однако, мог бы извлекать записи из представления username.

DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  password varchar(100)
);

DROP VIEW IF EXISTS username;
CREATE VIEW username AS SELECT a.id, a.name FROM accounts a;

CREATE USER user_read IDENTIFIED WITH sha256_password BY 'aloha';
GRANT SELECT ON shop.username TO user_read;

-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1) Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE HOUR_NOW INT(3) DEFAULT HOUR(NOW());
    IF(HOUR_NOW >= 6 AND HOUR_NOW < 12) THEN
        RETURN 'Доброе утро';
    ELSEIF(HOUR_NOW >= 12 AND HOUR_NOW <= 18) THEN
        RETURN 'Добрый день';
    ELSEIF(HOUR_NOW >= 18 AND HOUR_NOW < 24) THEN
        RETURN 'Добрый вечер';
    ELSE
	    RETURN 'Доброй ночи';
    END IF;
END;

SELECT hello();

-- 2) В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
-- Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS check_name_and_desc_in_products_insert;
CREATE TRIGGER check_name_and_desc_in_products_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF ISNULL(NEW.name) AND ISNULL(NEW.description) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'name and description must not be empty at the same time';
  END IF;
END;

DROP TRIGGER IF EXISTS check_name_and_desc_in_products_update;
CREATE TRIGGER check_name_and_desc_in_products_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF ISNULL(NEW.name) AND ISNULL(NEW.description) THEN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'name and description must not be empty at the same time';
  END IF;
END;

INSERT INTO products (name, description, price, catalog_id)
VALUE
    (NULL, NULL, 200.00, 1);

UPDATE products
SET name = NULL, description = NULL
WHERE id = 1;

-- 3) (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.
-- 0 1 2 3 4 5 6 7  8  9  10
-- 0 1 1 2 3 5 8 13 21 34 55

DROP FUNCTION IF EXISTS FIBONACCI;
CREATE FUNCTION FIBONACCI(num INT UNSIGNED)
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE i, sum INT DEFAULT 0;
    WHILE i <= num DO
        SET sum = sum + i;
        SET i = i + 1;
    END WHILE;
    RETURN sum;
END;

SELECT FIBONACCI(10);
