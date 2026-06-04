-- IMDB schema: directors_genres table
-- Source: extracted from original MySQL dump file imdb_directors_genres.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `directors_genres` (
  `index` bigint DEFAULT NULL,
  `director_id` bigint DEFAULT NULL,
  `genre` text,
  `prob` double DEFAULT NULL,
  KEY `ix_imdb_ijs_directors_genres_index` (`index`),
  KEY `director_id` (`director_id`),
  CONSTRAINT `directors_genres_ibfk_1` FOREIGN KEY (`director_id`) REFERENCES `directors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
