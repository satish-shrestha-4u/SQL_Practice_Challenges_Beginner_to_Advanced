-- IMDB schema: movies_directors table
-- Source: extracted from original MySQL dump file imdb_movies_directors.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `movies_directors` (
  `index` bigint DEFAULT NULL,
  `director_id` bigint DEFAULT NULL,
  `movie_id` bigint DEFAULT NULL,
  KEY `ix_imdb_ijs_movies_directors_index` (`index`),
  KEY `director_id` (`director_id`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `movies_directors_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `directors` (`id`),
  CONSTRAINT `movies_directors_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
