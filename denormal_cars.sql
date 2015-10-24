-- must be connected to another database and user to create/ drop desired ones;
\c franpham franpham;

DROP DATABASE IF EXISTS denormal_cars;

DROP USER IF EXISTS denormal_user;

CREATE USER denormal_user WITH ENCRYPTED PASSWORD 'ImDenormalized';

CREATE DATABASE denormal_cars OWNER denormal_user;

\c denormal_cars denormal_user localhost 5432;
-- to set owner of table, must connect as owner BEFORE creating it;

\i scripts/denormal_data.sql;
