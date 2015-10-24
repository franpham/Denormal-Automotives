-- must be connected to another database and user to create/ drop desired ones;
\c franpham franpham;

DROP DATABASE IF EXISTS normal_cars;

DROP USER IF EXISTS normal_user;

CREATE USER normal_user WITH ENCRYPTED PASSWORD 'ImNormalized';

CREATE DATABASE normal_cars OWNER normal_user;

\c normal_cars normal_user localhost 5432;
-- to set owner of table, must connect as owner BEFORE creating it;

\i scripts/denormal_data.sql;
-- cannot perform cross-DB SELECTS so replicate the table in normal_cars DB;

\i scripts/normal_data.sql;
