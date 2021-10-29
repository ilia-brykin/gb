-- 1) Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
-- Выполнено

-- 2) Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example
CREATE TABLE users(
    id integer,
    description char
)

-- 3) Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
-- sudo mysqldump example > sample.sql
-- CREATE DATABASE sample;
-- sudo mysql sample < sample.sql


-- 4) (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword
-- базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.
-- sudo mysqldump mysql help_keyword --where="true limit 100" > help_keyword.sql
-- Это командой скопировали дамп. Но когда разворачиваю,
-- sudo mysql mysql_copy < help_keyword.sql
-- возникает ошибка
-- ERROR 3723 (HY000) at line 25: The table 'help_keyword' may not be created in the reserved tablespace 'mysql'.

-- Можно решить вот так, но уже без дампа.
-- CREATE DATABASE mysql_copy2;
-- USE mysql_copy2
-- CREATE TABLE help_keyword
--     SELECT *
--     FROM  mysql.help_keyword
--     LIMIT 100;