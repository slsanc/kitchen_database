-- This MySQL script creates an empty database to store information about recipes, ingredients, dish types,
-- measurements, and the dates and times at which dishes were cooked.

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


DROP DATABASE IF EXISTS Kitchen_Database ;


CREATE DATABASE Kitchen_Database DEFAULT CHARACTER SET utf8 ;
USE Kitchen_Database ;


CREATE TABLE IF NOT EXISTS Kitchen_Database.Places_of_Origin (
  place_of_origin_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  place_of_origin_name VARCHAR(20) NOT NULL,
  PRIMARY KEY (place_of_origin_id),
  UNIQUE INDEX place_id_UNIQUE (place_of_origin_id ASC) VISIBLE,
  UNIQUE INDEX place_of_origin_name_UNIQUE (place_of_origin_name ASC) VISIBLE)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.Dish_Types (
  dish_type_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  dish_type VARCHAR(45) NOT NULL,
  PRIMARY KEY (dish_type_id),
  UNIQUE INDEX dish_type_id_UNIQUE (dish_type_id ASC) VISIBLE,
  UNIQUE INDEX dish_type_UNIQUE (dish_type ASC) VISIBLE)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.Recipes (
  recipe_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  recipe_name VARCHAR(45) NOT NULL,
  dish_type_id INT UNSIGNED NULL,
  place_of_origin_id INT UNSIGNED NULL,
  PRIMARY KEY (recipe_id),
  UNIQUE INDEX recipe_id_UNIQUE (recipe_id ASC) VISIBLE,
  UNIQUE INDEX recipe_name_UNIQUE (recipe_name ASC) VISIBLE,
  INDEX place_of_origin_id_fk_idx (place_of_origin_id ASC) VISIBLE,
  INDEX dish_type_id_fk_idx (dish_type_id ASC) VISIBLE,
  CONSTRAINT FK_recipes_origin
    FOREIGN KEY (place_of_origin_id)
    REFERENCES Kitchen_Database.Places_of_Origin (place_of_origin_id)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT FK_recipes_types
    FOREIGN KEY (dish_type_id)
    REFERENCES Kitchen_Database.Dish_Types (dish_type_id)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.Ingredients (
  ingredient_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  ingredient_name VARCHAR(45) NOT NULL,
  owned TINYINT NULL DEFAULT 1,
  PRIMARY KEY (ingredient_id),
  UNIQUE INDEX ingredient_id_UNIQUE (ingredient_id ASC) VISIBLE,
  UNIQUE INDEX ingredient_name_UNIQUE (ingredient_name ASC) VISIBLE)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.Units (
  unit_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
  unit_name VARCHAR(10) NOT NULL,
  PRIMARY KEY (unit_id),
  UNIQUE INDEX unit_id_UNIQUE (unit_id ASC) VISIBLE,
  UNIQUE INDEX unit_name_UNIQUE (unit_name ASC) VISIBLE)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.Recipe_Measurements (
  recipe_id INT UNSIGNED NOT NULL,
  ingredient_id INT UNSIGNED NOT NULL,
  unit_id INT UNSIGNED NULL,
  amount DECIMAL(6,3) NULL,
  INDEX recipe_id_idx (recipe_id ASC) VISIBLE,
  INDEX ingredient_id_fk_idx (ingredient_id ASC) VISIBLE,
  INDEX unit_id_fk_idx (unit_id ASC) VISIBLE,
  PRIMARY KEY (recipe_id, ingredient_id),
  CONSTRAINT FK_measurements_recipes
    FOREIGN KEY (recipe_id)
    REFERENCES Kitchen_Database.Recipes (recipe_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT FK_measurements_ingredients
    FOREIGN KEY (ingredient_id)
    REFERENCES Kitchen_Database.Ingredients (ingredient_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT FK_measurements_units
    FOREIGN KEY (unit_id)
    REFERENCES Kitchen_Database.Units (unit_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.Recipe_Instructions (
  recipe_id INT UNSIGNED NOT NULL,
  instructions TEXT NOT NULL,
  PRIMARY KEY (recipe_id),
  UNIQUE INDEX recipe_id_UNIQUE (recipe_id ASC) VISIBLE,
  CONSTRAINT FK_instructions_recipes
    FOREIGN KEY (recipe_id)
    REFERENCES Kitchen_Database.Recipes (recipe_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS Kitchen_Database.My_Cooking_History (
  recipe_id INT UNSIGNED NOT NULL,
  datetime_cooked DATETIME NOT NULL,
  PRIMARY KEY (recipe_id, datetime_cooked),
  CONSTRAINT FK_history_recipes
    FOREIGN KEY (recipe_id)
    REFERENCES Kitchen_Database.Recipes (recipe_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;