DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
USE cinema;

DROP TABLE IF EXISTS films;
CREATE TABLE films (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name_en VARCHAR(255) NOT NULL,
  name_ru VARCHAR(255),
  announcement TEXT,
  production_year YEAR,
  slogan TEXT,
  premiere_date DATE,
  rating DECIMAL(3,1),
  INDEX(name_en),
  INDEX(name_ru),
  INDEX(production_year)
) COMMENT = 'Данные фильмов';
 
INSERT INTO  films (name_en, name_ru, announcement, production_year, slogan, premiere_date, rating) 
	VALUES ("The Matrix", "Матрица", "Хакер Нео узнает, что его мир – виртуальный. Выдающийся экшен, доказавший, что зрелищное кино может быть умным", 
	1999, "Добро пожаловать в реальный мир", "1999-03-24", 8.5);

SELECT * FROM films;