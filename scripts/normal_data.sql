
ALTER TABLE car_models RENAME TO car_years;

DROP TABLE IF EXISTS car_makes;

CREATE TABLE car_makes (
  make_code VARCHAR(125) NOT NULL,
  make_title VARCHAR(125) NOT NULL,
  id SERIAL PRIMARY KEY
);  -- id must be last so inserting from car_years will create a default value for id;

INSERT INTO car_makes SELECT make_code, make_title FROM car_years
  GROUP BY make_code, make_title ORDER BY make_code;
-- each field used in SELECT clause must also be in GROUP BY clause;
-- id will be a serial integer since it's last in car_model's schema and insert increments it by default;

DROP TABLE IF EXISTS car_models;

CREATE TABLE car_models (
  model_code VARCHAR(125) NOT NULL,
  model_title VARCHAR(125) NOT NULL,
  car_makes_id INTEGER REFERENCES car_makes,
  id SERIAL PRIMARY KEY
);  -- id must be last so inserting from car_years will create a default value for id;

INSERT INTO car_models SELECT model_code, model_title FROM car_years
  GROUP BY model_code, model_title ORDER BY model_code;
-- each field used in SELECT clause must also be in GROUP BY clause;
-- id will be a serial integer since it's last in car_model's schema and insert increments it by default;

ALTER TABLE car_years ADD COLUMN id SERIAL UNIQUE PRIMARY KEY;
ALTER TABLE car_years ADD COLUMN car_models_id INTEGER REFERENCES car_models;
ALTER TABLE car_years ADD COLUMN car_makes_id INTEGER REFERENCES car_makes;

UPDATE car_years SET id = DEFAULT, car_models_id =
  (SELECT car_models.id FROM car_models WHERE car_models.model_title = car_years.model_title AND car_models.model_code = car_years.model_code);

-- DO NOT set id again;
UPDATE car_years SET car_makes_id =
  (SELECT car_makes.id FROM car_makes WHERE car_makes.make_code = car_years.make_code AND car_makes.make_title = car_years.make_title);

UPDATE car_models SET car_makes_id =
  (SELECT car_makes_id FROM car_years WHERE car_models.model_code = car_years.model_code AND car_models.model_title = car_years.model_title
  GROUP BY car_years.car_makes_id);

-- drop columns last since UPDATE SQL depends on them;
ALTER TABLE car_years DROP COLUMN make_code;
ALTER TABLE car_years DROP COLUMN make_title;
ALTER TABLE car_years DROP COLUMN model_code;
ALTER TABLE car_years DROP COLUMN model_title;
