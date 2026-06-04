-- IMDB schema: movies table
-- Source: extracted from original MySQL dump file imdb_movies.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `movies` (
  `index` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `name` text,
  `year` bigint DEFAULT NULL,
  `rank` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_imdb_ijs_movies_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
