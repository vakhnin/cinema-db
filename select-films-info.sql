/* Получение данных по фильмам (типичные запросы)
*/
USE cinema;

/* Выдаем, постранично, по (5) фильмов с позиции (0)
 * для организации постраничного вывода:
 * LIMIT (размер страницы)
 * OFFSET (((номер страницы)-1)*(размер страницы))
 */
SELECT * FROM view_extended_info_films
LIMIT 5 offset 0;

-- Выдаем топ-5 фильмов отсортированных по рейтингу 
SELECT * FROM view_top_5_films;

/* Получаем данные фильма "Матрица"
 */
-- Ищем фильм по части названия
CALL search_film_by_part_of_name("Матри", @film_id);

-- Общие данные
SELECT * FROM view_extended_info_films 
WHERE id = @film_id;

-- Жанры фильма
SELECT f.name_ru AS film_name, mg.name AS genres
	FROM films AS f
	JOIN films_movie_genres AS fmg ON f.id = fmg.film_id
	JOIN movie_genres AS mg ON mg.id = fmg.movie_genre_id
	WHERE f.id = @film_id;

-- Страны, участвовавщие в создании фильма
SELECT f.name_ru AS film_name, c.name AS counties
	FROM films AS f
	JOIN films_countries AS fc ON f.id = fc.film_id
	JOIN countries AS c ON c.id = fc.country_id
	WHERE f.id = @film_id;

-- Состав съемочной группы (без актеров)
SELECT f.name_ru AS film_name, s.name AS specializations, p.name, p.surname
	FROM films_crew AS fc
	JOIN films AS f ON f.id = fc.film_id
	JOIN specializations AS s ON s.id = fc.specializations_id
	JOIN persons AS p ON p.id = fc.person_id
	WHERE f.id = @film_id;

-- Актерский состав
SELECT f.name_ru AS film_name, fa.role_name, p.name, p.surname
	FROM films_actors AS fa
	JOIN films AS f ON f.id = fa.film_id
	JOIN persons AS p ON p.id = fa.person_id
	WHERE f.id = @film_id;
