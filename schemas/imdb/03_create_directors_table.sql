-- IMDB schema: directors table
-- Source: extracted from original MySQL dump file imdb_directors.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `directors` (
  `index` bigint DEFAULT NULL,
  `id` bigint NOT NULL,
  `first_name` text,
  `last_name` text,
  PRIMARY KEY (`id`),
  KEY `ix_imdb_ijs_directors_index` (`index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
