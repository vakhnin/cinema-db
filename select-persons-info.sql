/* Получение данных по персонам (типичные запросы)
*/
USE cinema;

/* Выдаем, постранично, по (5) фильмов с позиции (0)
 * для организации постраничного вывода:
 * LIMIT (размер страницы)
 * OFFSET (((номер страницы)-1)*(размер страницы))
 */
SELECT pr.*, pl.name AS city, c.name AS country 
	FROM persons AS pr
	JOIN places AS pl ON pl.id = pr.birth_place_id
	JOIN countries AS c ON c.id = pl.country_id
LIMIT 5 offset 0;

/* Получаем данные по Киану Ривзу
 */
-- Получаем id Киану
SET @part_of_name = "Киану";
SELECT id INTO @person_id
	FROM persons AS p
	WHERE (p.name LIKE concat("%", @part_of_name, "%"))
		OR (p.name_en LIKE concat("%", @part_of_name, "%"))
		OR (p.surname LIKE concat("%", @part_of_name, "%"))
		OR (p.surname_en LIKE concat("%", @part_of_name, "%"))
	LIMIT 1;

-- Общие данные
SELECT pr.*, pl.name AS city, c.name AS country 
	FROM persons AS pr
	JOIN places AS pl ON pl.id = pr.birth_place_id
	JOIN countries AS c ON c.id = pl.country_id
	WHERE pr.id = @person_id;

-- В качестве кого участвовал в фильмах
SELECT DISTINCT "Актер"
	FROM films_actors AS fa 
	WHERE fa.person_id = @person_id
UNION 
SELECT DISTINCT s.name
	FROM films_crew AS fc 
	JOIN specializations AS s ON s.id = fc.specializations_id 
		AND fc.person_id = @person_id;

-- Актерские работы
SELECT veif.id, veif.name_en, veif.name_ru, 
	veif.production_year, fa.role_name 
	FROM view_extended_info_films AS veif
	JOIN films_actors AS fa ON fa.film_id = veif.id 
		AND fa.person_id =  @person_id;
	
-- Работы в не актерской специализации
SELECT veif.id, veif.name_en, veif.name_ru, 
	veif.production_year, s.name AS specializations_id
	FROM view_extended_info_films AS veif
	JOIN films_crew AS fc  ON fc.film_id = veif.id 
		AND fc.person_id =  @person_id
	JOIN specializations AS s ON s.id = fc.specializations_id;
	
-- Лучшие актерские работы (по рейтингу фильмов)
SELECT veif.id, veif.name_en, veif.name_ru, 
	veif.production_year, veif.rating 
	FROM view_extended_info_films AS veif
	JOIN films_actors AS fa ON fa.film_id = veif.id 
		AND fa.person_id =  @person_id
	ORDER BY veif.rating DESC 
	LIMIT 5;
	
	
	
	

	

