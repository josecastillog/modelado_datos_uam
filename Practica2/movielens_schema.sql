CREATE TYPE "movie_status" AS ENUM (
  'Canceled',
  'In Production',
  'Planned',
  'Post Production',
  'Released',
  'Rumored',
  ''
);
 

CREATE TYPE "gender_id" AS ENUM (
  '0',
  '1',
  '2'
);

CREATE TABLE "movie_basics" (
  "id" integer PRIMARY KEY,
  "title" varchar,
  "original_title" varchar,
  "release_date" date,
  "collection" integer,
  "original_language" char(2),
  "adult" boolean,
  "status" movie_status
);

CREATE TABLE "movie_additional" (
  "id" integer PRIMARY KEY,
  "imdb_id" varchar,
  "homepage" varchar,
  "budget" bigint,
  "overview" varchar,
  "popularity" float,
  "vote_average" float,
  "vote_count" integer,
  "poster_path" varchar,
  "tagline" varchar,
  "video" boolean,
  "revenue" bigint,
  "runtime" float
);

CREATE TABLE "movie_spoken_languages" (
  "movie_id" integer,
  "language_code" char(2)
);

CREATE TABLE "movie_production_countries" (
  "movie_id" integer,
  "country_code" char(2)
);

CREATE TABLE "movie_production_companies" (
  "movie_id" integer,
  "company_id" integer
);

CREATE TABLE "movie_genres" (
  "movie_id" integer,
  "genre_id" integer
);

CREATE TABLE "keywords" (
  "keyword_id" integer PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "link_ids" (
  "movie_id" integer PRIMARY KEY,
  "imdb_id" varchar,
  "tmpdb_id" int
);

CREATE TABLE "ratings" (
  "user_id" int,
  "movie_id" int,
  "rating" float,
  "timestamp" timestamp
);

CREATE TABLE "movie_cast" (
  "credit_id" varchar PRIMARY KEY,
  "movie_id" integer,
  "person_id" integer,
  "character" varchar,
  "cast_id" integer,
  "order" integer
);

CREATE TABLE "movie_crew" (
  "credit_id" varchar PRIMARY KEY,
  "movie_id" integer,
  "person_id" integer,
  "department" varchar,
  "job" varchar,
  "profile_path" varchar
);

CREATE TABLE "languages" (
  "iso_639_1" char(2) PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "countries" (
  "iso_3166_1" char(2) PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "production_companies" (
  "company_id" integer PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "genres" (
  "genre_id" integer PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "collections" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "poster_path" varchar,
  "backdrop_path" varchar
);

CREATE TABLE "movie_keywords" (
  "movie_id" integer,
  "keyword_id" integer
);

CREATE TABLE "people" (
  "id" integer PRIMARY KEY,
  "name" varchar,
  "gender" gender_id,
  "profile_path" varchar
);

CREATE TABLE "gender" (
  "id" gender_id PRIMARY KEY,
  "name" varchar
);

CREATE UNIQUE INDEX ON "movie_spoken_languages" ("movie_id", "language_code");

CREATE UNIQUE INDEX ON "movie_production_countries" ("movie_id", "country_code");

CREATE UNIQUE INDEX ON "movie_production_companies" ("movie_id", "company_id");

CREATE UNIQUE INDEX ON "movie_genres" ("movie_id", "genre_id");

CREATE UNIQUE INDEX ON "ratings" ("user_id", "movie_id");

CREATE UNIQUE INDEX ON "movie_keywords" ("movie_id", "keyword_id");

ALTER TABLE "movie_basics" ADD FOREIGN KEY ("collection") REFERENCES "collections" ("id");

-- Aqui
ALTER TABLE "movie_basics" ADD FOREIGN KEY ("original_language") REFERENCES "languages" ("iso_639_1");

ALTER TABLE "movie_additional" ADD FOREIGN KEY ("id") REFERENCES "movie_basics" ("id");

ALTER TABLE "movie_spoken_languages" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

-- Aqui
ALTER TABLE "movie_spoken_languages" ADD FOREIGN KEY ("language_code") REFERENCES "languages" ("iso_639_1");

ALTER TABLE "movie_production_countries" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

-- Aqui
ALTER TABLE "movie_production_countries" ADD FOREIGN KEY ("country_code") REFERENCES "countries" ("iso_3166_1");

ALTER TABLE "movie_production_companies" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

ALTER TABLE "movie_production_companies" ADD FOREIGN KEY ("company_id") REFERENCES "production_companies" ("company_id");

ALTER TABLE "movie_genres" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

ALTER TABLE "movie_genres" ADD FOREIGN KEY ("genre_id") REFERENCES "genres" ("genre_id");

ALTER TABLE "ratings" ADD FOREIGN KEY ("movie_id") REFERENCES "link_ids" ("movie_id");

ALTER TABLE "movie_cast" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

ALTER TABLE "movie_cast" ADD FOREIGN KEY ("person_id") REFERENCES "people" ("id");

ALTER TABLE "movie_crew" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

ALTER TABLE "movie_crew" ADD FOREIGN KEY ("person_id") REFERENCES "people" ("id");

ALTER TABLE "movie_keywords" ADD FOREIGN KEY ("movie_id") REFERENCES "movie_basics" ("id");

-- Aqui
ALTER TABLE "movie_keywords" ADD FOREIGN KEY ("keyword_id") REFERENCES "keywords" ("keyword_id");

-- Aqui
ALTER TABLE "people" ADD FOREIGN KEY ("gender") REFERENCES "gender" ("id");
