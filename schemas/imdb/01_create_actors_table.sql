-- IMDB schema: actors table
-- Source: extracted from original MySQL dump file imdb_actors.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `actors` (
  `index` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `first_name` text,
  `last_name` text,
  `gender` text,
  PRIMARY KEY (`id`),
  KEY `ix_imdb_ijs_actors_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
