-- IMDB schema: movies_genres table
-- Source: extracted from original MySQL dump file imdb_movies_genres.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `movies_genres` (
  `index` bigint DEFAULT NULL,
  `movie_id` bigint DEFAULT NULL,
  `genre` text,
  KEY `ix_imdb_ijs_movies_genres_index` (`index`),
  KEY `movie_id` (`movie_id`),
  CONSTRAINT `movies_genres_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
