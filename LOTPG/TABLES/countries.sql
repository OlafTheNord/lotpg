CREATE TABLE IF NOT EXISTS lotpg.countries
(
    country_id VARCHAR(3)   NOT NULL PRIMARY KEY,
    title      VARCHAR(150) NOT NULL UNIQUE
);