CREATE TABLE lotpg.accounts
(
    id         BIGINT                      NOT NULL PRIMARY KEY,
    name       VARCHAR(150)                NOT NULL UNIQUE,
    email      VARCHAR(150)                NOT NULL UNIQUE,
    create_dt  TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    country_id VARCHAR(3)                  NOT NULL,
    is_active  BOOLEAN                     NOT NULL,
    ch_dt      TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    is_blocked BOOLEAN                     NOT NULL,
    is_del     BOOLEAN                     NOT NULL
);