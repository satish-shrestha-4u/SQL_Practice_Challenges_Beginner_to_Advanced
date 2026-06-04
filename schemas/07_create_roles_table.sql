-- IMDB schema: roles table
-- Source: extracted from original MySQL dump file imdb_roles.sql
-- Note: Full data dump is not included because of file size.

CREATE TABLE `roles` (
  `index` bigint DEFAULT NULL,
  `actor_id` bigint DEFAULT NULL,
  `movie_id` bigint DEFAULT NULL,
  `role` text,
  KEY `ix_imdb_ijs_roles_index` (`index`),
  KEY `movie_id` (`movie_id`),
  KEY `actor_id` (`actor_id`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movies` (`id`),
  CONSTRAINT `roles_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `actors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
