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
  INDEX(name_en),
  INDEX(name_ru),
  INDEX(production_year)
) COMMENT = 'Данные фильмов';
 
INSERT INTO  films (id, name_en, name_ru, announcement, production_year, slogan, premiere_date) 
	VALUES (1, "The Matrix", "Матрица", "Хакер Нео узнает, что его мир – виртуальный. Выдающийся экшен, доказавший, что зрелищное кино может быть умным", 
			1999, "Добро пожаловать в реальный мир", "1999-03-24");

SELECT * FROM films;


DROP TABLE IF EXISTS persons;
CREATE TABLE persons (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  surname VARCHAR(255),
  name_en VARCHAR(255) NOT NULL,
  surname_en VARCHAR(255),
  height DECIMAL(3,2),
  birthday DATE
) COMMENT = 'Данные персон';

INSERT INTO persons (id, name, surname, name_en, surname_en, height, birthday)
	VALUES (1, "Киану", "Ривз", "Keanu", "Reeves", 1.86, "1964-09-02"),
		(2, "Лана", "Вачовски", "Lana", "Wachowski", 1.79, "1965-06-21"),
		(3, "Лилли", "Вачовски", "Lilly", "Wachowski", 1.89, "1967-12-29");

SELECT * FROM persons;


DROP TABLE IF EXISTS movie_genres;
CREATE TABLE movie_genres (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
) COMMENT = 'Жанры фильмов';

INSERT INTO movie_genres (id, name)
	VALUES (1, "боевик"),
		(2, "фантастика");
	
SELECT * FROM movie_genres;


DROP TABLE IF EXISTS films_movie_genres;
CREATE TABLE films_movie_genres (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  movie_genre_id BIGINT UNSIGNED,
  CONSTRAINT fk__films_movie_genres__films FOREIGN KEY (film_id) REFERENCES films(id),
  CONSTRAINT fk__films_movie_genres_movie__genres FOREIGN KEY (movie_genre_id) REFERENCES movie_genres(id)
) COMMENT = 'Жанры фильмов';

INSERT INTO films_movie_genres (film_id, movie_genre_id)
	VALUES (1, 1),
		(1, 2);
	
SELECT * FROM films_movie_genres;
SELECT f.name_ru, mg.name 
	FROM films AS f
	JOIN films_movie_genres AS fmg ON f.id = fmg.film_id
	JOIN movie_genres AS mg ON mg.id = fmg.movie_genre_id;


DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
) COMMENT = 'Страны';

INSERT INTO countries (id, name)
	VALUES (1, "США"),
		(2, "Ливан");

DROP TABLE IF EXISTS films_countries;
CREATE TABLE films_countries (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  country_id BIGINT UNSIGNED,
  CONSTRAINT fk__films_countries__films FOREIGN KEY (film_id) REFERENCES films(id),
  CONSTRAINT fk__films_countries__genres FOREIGN KEY (country_id) REFERENCES countries(id)
) COMMENT = 'Жанры фильмов';

INSERT INTO films_countries (film_id, country_id)
	VALUES (1, 1);
	
SELECT * FROM films_countries;
SELECT f.name_ru, c.name 
	FROM films AS f
	JOIN films_countries AS fc ON f.id = fc.film_id
	JOIN countries AS c ON c.id = fc.country_id;


DROP TABLE IF EXISTS places;
CREATE TABLE places (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  country_id BIGINT UNSIGNED,
  name VARCHAR(255) NOT NULL,
  CONSTRAINT fk__places__countries FOREIGN KEY (country_id) REFERENCES countries(id)
) COMMENT = 'Места';

INSERT INTO places (id, country_id, name)
	VALUES (1, 2, "Бейрут");

SELECT p.name, c.name FROM places AS p 
	JOIN countries AS c ON c.id = p.country_id;


DROP TABLE IF EXISTS roles;
CREATE TABLE roles (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL 
) COMMENT = 'Специализация в съемочной группе';

INSERT INTO roles (id, name)
	VALUES (1, "Режиссер"),
		(2, "Сценарий"),
		(3, "Актер");
	
SELECT * FROM roles;


DROP TABLE IF EXISTS films_crew;
CREATE TABLE films_crew (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  role_id BIGINT UNSIGNED,
  person_id BIGINT UNSIGNED,
  CONSTRAINT fk__films_crew__films FOREIGN KEY (film_id) REFERENCES films(id),  
  CONSTRAINT fk__films_crew__roles FOREIGN KEY (role_id) REFERENCES roles(id),
  CONSTRAINT fk__films_crew__persons FOREIGN KEY (person_id) REFERENCES persons(id)
) COMMENT = 'Состав съемочной группы';

INSERT INTO films_crew (film_id, role_id, person_id)
	VALUES (1, 3, 1),
		(1, 1, 2),
		(1, 1, 3),
		(1, 2, 2),
		(1, 2, 3);

SELECT f.name_ru, r.name, p.name, p.surname
	FROM films_crew AS fc
	JOIN films AS f ON f.id = fc.film_id
	JOIN roles AS r ON r.id = fc.role_id
	JOIN persons AS p ON p.id = fc.person_id;



DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';

INSERT INTO users (id, name, birthday_at) VALUES
  (1, 'Геннадий', '1990-10-05'),
  (2, 'Наталья', '1984-11-12'),
  (3, 'Александр', '1985-05-20'),
  (4, 'Сергей', '1988-02-14'),
  (5, 'Иван', '1998-01-12'),
  (6, 'Мария', '1992-08-29');
 
SELECT * FROM users;


DROP TABLE IF EXISTS films_votes;
CREATE TABLE films_votes (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  user_id BIGINT UNSIGNED,
  vote DECIMAL(1, 0) UNSIGNED,
  UNIQUE (film_id, user_id),
  CONSTRAINT fk__films_votes__films FOREIGN KEY (film_id) REFERENCES films(id),  
  CONSTRAINT fk__films_votes__user FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT = 'Голосование по рейтингу фильма';

INSERT INTO films_votes (film_id, user_id, vote) VALUES
	(1, 1, 9),
	(1, 2, 8),
	(1, 3, 8),
	(1, 4, 9),
	(1, 5, 9);

SELECT round(AVG(vote), 1) FROM films_votes
GROUP BY film_id;
