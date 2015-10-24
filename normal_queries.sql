
SELECT DISTINCT make_title FROM car_makes;

SELECT DISTINCT model_title FROM car_models
  INNER JOIN car_makes ON (car_makes.id = car_models.car_makes_id)
  WHERE make_code = 'VOLKS';

SELECT make_code, model_code, model_title, year FROM car_years
  INNER JOIN car_models ON (car_models.id = car_years.car_models_id)
  INNER JOIN car_makes  ON (car_makes.id = car_years.car_makes_id)
  WHERE make_code = 'LAM';

SELECT * FROM car_years
  INNER JOIN car_models ON (car_models.id = car_years.car_models_id)
  INNER JOIN car_makes  ON (car_makes.id = car_years.car_makes_id)
  WHERE year BETWEEN 2010 AND 2015;
