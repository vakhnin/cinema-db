/* Создание структуры БД, напонение данными 
*/
DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
USE cinema;


DROP TABLE IF EXISTS films;
CREATE TABLE films (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name_en VARCHAR(255) NOT NULL,
  name_ru VARCHAR(255),
  announcement TEXT,
  slogan TEXT,
  premiere_date DATE,
  INDEX(name_en),
  INDEX(name_ru)
) COMMENT = 'Данные фильмов';
 
INSERT INTO  films (id, name_en, name_ru, announcement,  slogan, premiere_date) VALUES 
	(1, "The Matrix", "Матрица", "Хакер Нео узнает, что его мир – виртуальный. Выдающийся экшен, доказавший, что зрелищное кино может быть умным", 
			"Добро пожаловать в реальный мир", "1999-03-24"),
	(2, "The Matrix Reloaded", "Матрица: Перезагрузка", NULL, 
			"Одни машины помогают нам жить, другие – пытаются нас убить", "2003-05-07"),
	(3, "Henry's Crime", "Криминальная фишка от Генри", "Киану Ривз играет в театре и грабит банки", 
			"Ну как не совершить преступление, за которое уже отсидел?", "2011-04-07"),
	(4, "Man of Tai Chi", "Мастер тай-цзи", NULL, 
			"Без правил. Без пощады. Только борьба", "2013-07-05"),
	(5, "Johnny Mnemonic", "Джонни Мнемоник", NULL, 
			"The hottest data on earth. In the coolest head in town", "1995-04-15");

/* Проверка данных фильма
SELECT * FROM films;
*/

DROP TABLE IF EXISTS persons;
CREATE TABLE persons (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  surname VARCHAR(255),
  name_en VARCHAR(255),
  surname_en VARCHAR(255),
  height DECIMAL(3,2),
  birthday DATE,
  photo VARCHAR(255) DEFAULT NULL,
  INDEX(name),
  INDEX(surname),
  INDEX(name_en),
  INDEX(surname_en)
) COMMENT = 'Данные персон';

INSERT INTO persons (id, name, surname, name_en, surname_en, height, birthday) VALUES 
	(1, "Киану", "Ривз", "Keanu", "Reeves", 1.86, "1964-09-02"),
	(2, "Лана", "Вачовски", "Lana", "Wachowski", 1.79, "1965-06-21"),
	(3, "Лилли", "Вачовски", "Lilly", "Wachowski", 1.89, "1967-12-29"),
	(4, "Хьюго", "Уивинг", "Hugo", "Weaving", 1.88, "1960-04-04"),
	(5, "Глория", "Фостер", "Gloria", "Foster", NULL, "1933-11-15"),
	(6, "Малькольм", "Венвилль", "Malcolm", "Venville", 1.88, "1962-11-05"),
	(7, "Джеймс", "Каан", "James", "Caan", 1.78, "1940-03-26"),
	(8, "Тайгер", "Чэнь", "Tiger", "Chen", NULL, "1975-03-03"),
	(9, "Роберт", "Лонго", "Robert", "Longo", NULL, "1953-01-07"),
	(10, "Дина", "Мейер", "Dina", "Meyer", 1.7, "1968-12-22");

/* Проверка данных персон
SELECT * FROM persons;
*/

DROP TABLE IF EXISTS movie_genres;
CREATE TABLE movie_genres (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
) COMMENT = 'Жанры фильмов';

INSERT INTO movie_genres (id, name) VALUES 
	(1, "боевик"),
	(2, "фантастика"),
	(3, "мелодрама"),
	(4, "комедия"),
	(5, "криминал"),
	(6, "триллер"),
	(7, "драма");

/* Проверка данных каталога жанров фильмов
SELECT * FROM movie_genres;
*/

DROP TABLE IF EXISTS films_movie_genres;
CREATE TABLE films_movie_genres (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  movie_genre_id BIGINT UNSIGNED,
  INDEX(film_id),
  INDEX(movie_genre_id),
  UNIQUE(film_id, movie_genre_id),
  CONSTRAINT fk__films_movie_genres__films FOREIGN KEY (film_id) REFERENCES films(id),
  CONSTRAINT fk__films_movie_genres_movie__genres FOREIGN KEY (movie_genre_id) REFERENCES movie_genres(id)
) COMMENT = 'Жанры фильмов';

INSERT INTO films_movie_genres (film_id, movie_genre_id) VALUES 
	(1, 1),
	(1, 2),
	(2, 1),
	(2, 2),
	(3, 3),
	(3, 4),
	(3, 5),
	(4, 1),
	(5, 1),
	(5, 2),
	(5, 6),
	(5, 7);
	
/* Проверка данных жанров фильмов
SELECT f.name_ru, mg.name 
	FROM films AS f
	JOIN films_movie_genres AS fmg ON f.id = fmg.film_id
	JOIN movie_genres AS mg ON mg.id = fmg.movie_genre_id;
*/

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL
) COMMENT = 'Страны';

INSERT INTO countries (id, name) VALUES 
	(1, "США"),
	(2, "Ливан"),
	(3, "Нигерия"),
	(4, "Англия"),
	(5, "Китай"),
	(6, "Гонконг"),
	(7, "Канада");

/* Проверка каталога стран
SELECT * FROM countries;
 */

DROP TABLE IF EXISTS films_countries;
CREATE TABLE films_countries (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  country_id BIGINT UNSIGNED,
  INDEX(film_id),
  INDEX(country_id),
  UNIQUE(film_id, country_id),
  CONSTRAINT fk__films_countries__films FOREIGN KEY (film_id) REFERENCES films(id),
  CONSTRAINT fk__films_countries__genres FOREIGN KEY (country_id) REFERENCES countries(id)
) COMMENT = 'Жанры фильмов';

INSERT INTO films_countries (film_id, country_id) VALUES 
	(1, 1), 
	(2, 1),
	(3, 1),
	(4, 1),
	(4, 5),
	(4, 6),
	(5, 1),
	(5, 7);
	
/* Проверка стран участвовавщих в создании фильмов
SELECT f.name_ru, c.name 
	FROM films AS f
	JOIN films_countries AS fc ON f.id = fc.film_id
	JOIN countries AS c ON c.id = fc.country_id;
*/

DROP TABLE IF EXISTS places;
CREATE TABLE places (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  country_id BIGINT UNSIGNED,
  name VARCHAR(255) NOT NULL,
  UNIQUE(country_id, name),
  CONSTRAINT fk__places__countries FOREIGN KEY (country_id) REFERENCES countries(id)
) COMMENT = 'Места';

INSERT INTO places (id, country_id, name) VALUES 
	(1, 2, "Бейрут"),
	(2, 1, "Чикаго"),
	(3, 3, "Ибадан"),
	(4, 4, "Бирмингем"),
	(5, 1, "Бронкс"),
	(6, 5, "Чэнду"),
	(7, 1, "Бруклин"),
	(8, 1, "Куинс");

/* Проверка каталога мест
SELECT p.name, c.name FROM places AS p 
	JOIN countries AS c ON c.id = p.country_id;
*/

DROP TABLE IF EXISTS persons_birth_places;
CREATE TABLE persons_birth_places (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  person_id BIGINT UNSIGNED,
  place_id BIGINT UNSIGNED,
  INDEX(person_id),
  INDEX(place_id),
  UNIQUE(person_id, place_id),
  CONSTRAINT fk__persons_birth_places__persons FOREIGN KEY (person_id) REFERENCES persons(id),  
  CONSTRAINT fk__persons_birth_places__places FOREIGN KEY (place_id) REFERENCES places(id)
) COMMENT = 'Места рождения персон';

INSERT INTO persons_birth_places (person_id, place_id) VALUES 
	(1, 1),
	(2, 2),
	(3, 2),
	(4, 3),
	(5, 2),
	(6, 4),
	(7, 5),
	(8, 6),
	(9, 7),
	(10, 8);

/* Проверка мест рождения персон
SELECT pr.name, pr.surname, pl.name AS city, c.name AS country 
	FROM persons_birth_places AS pbp
	JOIN persons AS pr ON pr.id = pbp.person_id
	JOIN places AS pl ON pl.id = pbp.place_id
	JOIN countries AS c ON c.id = pl.country_id;
*/

DROP TABLE IF EXISTS specializations;
CREATE TABLE specializations (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL 
) COMMENT = 'Специализация в съемочной группе';

INSERT INTO specializations (id, name)	VALUES 
	(1, "Режиссер"),
	(2, "Сценарист"),
	(3, "Продюсер"),
	(4, "Оператор"),
	(5, "Композитор"),
	(6, "Художник"),
	(7, "Монтаж");

/* Проверка каталога специализаций в съемочной группе 
SELECT * FROM specializations;
*/

DROP TABLE IF EXISTS films_crew;
CREATE TABLE films_crew (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  role_id BIGINT UNSIGNED,
  person_id BIGINT UNSIGNED,
  INDEX(film_id),
  INDEX(role_id),
  INDEX(person_id),
  UNIQUE(film_id, role_id, person_id),
  CONSTRAINT fk__films_crew__films FOREIGN KEY (film_id) REFERENCES films(id),  
  CONSTRAINT fk__films_crew__specializations FOREIGN KEY (role_id) REFERENCES specializations(id),
  CONSTRAINT fk__films_crew__persons FOREIGN KEY (person_id) REFERENCES persons(id)
) COMMENT = 'Состав съемочной группы (без актеров)';

INSERT INTO films_crew (film_id, role_id, person_id) VALUES 
	(1, 1, 2),
	(1, 1, 3),
	(1, 2, 2),
	(1, 2, 3),
	(2, 1, 2),
	(2, 1, 3),
	(2, 2, 2),
	(2, 2, 3),
	(3, 1, 6),
	(4, 1, 1),
	(5, 1, 9);

/* Проверка составов съемочных групп фильмов (без актеров)
SELECT f.name_ru, s.name, p.name, p.surname
	FROM films_crew AS fc
	JOIN films AS f ON f.id = fc.film_id
	JOIN specializations AS s ON s.id = fc.role_id
	JOIN persons AS p ON p.id = fc.person_id;
*/

DROP TABLE IF EXISTS films_actors;
CREATE TABLE films_actors (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  person_id BIGINT UNSIGNED,
  role_name VARCHAR(255),
  INDEX(film_id),
  INDEX(person_id),
  CONSTRAINT fk__films_actors__films FOREIGN KEY (film_id) REFERENCES films(id),
  CONSTRAINT fk__films_actors__persons FOREIGN KEY (person_id) REFERENCES persons(id)
) COMMENT = 'Актерский состав';

INSERT INTO films_actors (film_id, person_id, role_name) VALUES 
	(1, 1, 'Neo'),
	(1, 4, 'Agent Smith'),
	(1, 5, 'Oracle'),
	(2, 1, 'Neo'),
	(2, 4, 'Agent Smith'),
	(2, 5, 'The Oracle'),
	(3, 1, 'Henry Torne'),
	(3, 7, 'Max Saltzman'),
	(4, 1, 'Keanu Reeves'),
	(4, 8, 'Tiger Chen'),
	(5, 1, 'Johnny Mnemonic'),
	(5, 10, 'Jane');

/* Проверка актерского состава фильмов
SELECT f.name_ru, fa.role_name, p.name, p.surname
	FROM films_actors AS fa
	JOIN films AS f ON f.id = fa.film_id
	JOIN persons AS p ON p.id = fa.person_id;
*/
	
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Пользователи';

DROP TRIGGER IF EXISTS check_birthday_before_insert;
DROP TRIGGER IF EXISTS check_birthday_before_update;

DELIMITER //
CREATE TRIGGER check_birthday_before_insert BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF NEW.birthday_at >= CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insert Canceled. Birthday must be in the past!';
    END IF;
END//

CREATE TRIGGER check_birthday_before_update BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    IF NEW.birthday_at >= CURRENT_DATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Update Canceled. Birthday must be in the past!';
    END IF;
END//
DELIMITER ;

/* Проверяем триггер check_birthday_before_update
INSERT INTO users (name, birthday_at) VALUES
  ('Геннадий', '2222-01-01'); -- Отклоняется, так как дата в будущем
 */

INSERT INTO users (id, name, birthday_at) VALUES
  (1, 'Геннадий', '1990-10-05'),
  (2, 'Наталья', '1984-11-12'),
  (3, 'Александр', '1985-05-20'),
  (4, 'Сергей', '1988-02-14'),
  (5, 'Иван', '1998-01-12'),
  (6, 'Мария', '1992-08-29');

/* Проверка списка пользователей
SELECT * FROM users;
*/
 
 /* Проверяем триггер check_birthday_before_insert
 UPDATE users SET birthday_at = '2222-01-01' WHERE id = 1; -- Отклоняется, так как дата в будущем
 */

DROP TABLE IF EXISTS films_votes;
CREATE TABLE films_votes (
  id BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  film_id BIGINT UNSIGNED,
  user_id BIGINT UNSIGNED,
  vote DECIMAL(1, 0) UNSIGNED,
  INDEX(film_id),
  INDEX(user_id),
  UNIQUE (film_id, user_id),
  CONSTRAINT fk__films_votes__films FOREIGN KEY (film_id) REFERENCES films(id),  
  CONSTRAINT fk__films_votes__user FOREIGN KEY (user_id) REFERENCES users(id)
) COMMENT = 'Голосование по рейтингу фильма';

INSERT INTO films_votes (film_id, user_id, vote) VALUES
	(1, 1, 9),
	(1, 2, 8),
	(1, 3, 8),
	(1, 4, 9),
	(1, 5, 9),
	(2, 1, 8),
	(2, 2, 8),
	(2, 3, 7),
	(3, 1, 7),
	(3, 2, 6),
	(3, 3, 6),
	(4, 1, 7),
	(4, 2, 6),
	(4, 3, 6),
	(4, 4, 6),
	(4, 5, 6),
	(5, 1, 7),
	(5, 2, 6),
	(5, 3, 7),
	(5, 4, 7),
	(5, 5, 7);

/* Проверка голосования по фильмам
SELECT f.name_ru, round(AVG(vote), 1) FROM films_votes AS fv
	JOIN films AS f ON f.id = fv.film_id
GROUP BY fv.film_id;
*/

CREATE OR REPLACE VIEW view_extended_info_films
AS 
	SELECT f.*, YEAR(f.premiere_date) AS production_year, 
	round(AVG(fv.vote), 1) AS rating
		FROM films AS f
		JOIN films_votes AS fv ON f.id = fv.film_id
	GROUP BY fv.film_id;

/* Проверяем представление
SELECT * FROM view_extended_info_films;
*/

CREATE OR REPLACE VIEW top_5_films
AS
	SELECT * FROM view_extended_info_films AS veif
	ORDER BY veif.rating DESC
	LIMIT 5;

/* Проверяем представление
SELECT * FROM top_5_films;
*/

DROP PROCEDURE IF EXISTS search_film_by_part_of_name;
DELIMITER //
CREATE PROCEDURE search_film_by_part_of_name
	(IN part_of_name TEXT, OUT film_id BIGINT UNSIGNED)
BEGIN
	SELECT id INTO film_id
	FROM view_extended_info_films AS f
	WHERE (f.name_ru LIKE concat("%", part_of_name, "%"))
		OR (f.name_en LIKE concat("%", part_of_name, "%"))
	ORDER BY f.rating DESC
	LIMIT 1;
END//
DELIMITER ;

/* Проверяем процедуру
CALL search_film_by_part_of_name("Матрица", @film_id);
SELECT @film_id;
CALL search_film_by_part_of_name("Matrix", @film_id);
SELECT @film_id;
*/
