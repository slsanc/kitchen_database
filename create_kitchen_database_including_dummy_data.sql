-- This MySQL script creates a database to store information about recipes, ingredients, dish types,
-- measurements, and the dates and times at which dishes were cooked. It then fills that database with dummy data.

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


START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Places_of_Origin (place_of_origin_id, place_of_origin_name) VALUES (1, 'Italy');
INSERT INTO Kitchen_Database.Places_of_Origin (place_of_origin_id, place_of_origin_name) VALUES (2, 'Mexico');
INSERT INTO Kitchen_Database.Places_of_Origin (place_of_origin_id, place_of_origin_name) VALUES (3, 'China');
INSERT INTO Kitchen_Database.Places_of_Origin (place_of_origin_id, place_of_origin_name) VALUES (4, 'Scotland');

COMMIT;



START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Dish_Types (dish_type_id, dish_type) VALUES (1, 'Does Not Contain Meat or Dairy (Vegan)');
INSERT INTO Kitchen_Database.Dish_Types (dish_type_id, dish_type) VALUES (2, 'Contains Dairy (Vegetarian but not Vegan)');
INSERT INTO Kitchen_Database.Dish_Types (dish_type_id, dish_type) VALUES (3, 'Contains Meat');
INSERT INTO Kitchen_Database.Dish_Types (dish_type_id, dish_type) VALUES (4, 'Contains Fish');

COMMIT;



START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (1, 'Thick-Crust Pizza', 2, 1);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (2, 'Oatmeal Porridge', 2, 4);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (3, 'Soy Sauce Chicken', 3, 3);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (4, 'Burritos', 2, 2);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (5, 'Lasagna', 2, 1);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (6, 'Spagetti alla Puttanesca', 4, 1);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (7, 'Eggplant Parmesan', 2, 1);
INSERT INTO Kitchen_Database.Recipes (recipe_id, recipe_name, dish_type_id, place_of_origin_id) VALUES (8, 'Lo Mein', 3, 3);

COMMIT;


START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (1, 'tomato sauce', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (2, 'sugar', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (3, 'salt', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (4, 'black pepper', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (5, 'parsley', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (6, 'basil', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (7, 'garlic', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (8, 'oregano', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (9, 'yeast', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (10, 'flour', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (11, 'vegetable oil', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (12, 'shredded mozzarella cheese', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (13, 'yellow onions', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (14, 'bell peppers', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (15, 'water', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (16, 'rolled oats', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (17, 'milk', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (18, 'chicken', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (19, 'green onions', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (20, 'soy sauce', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (21, 'cooking wine', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (22, 'ginger', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (23, 'dried black beans', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (24, 'cumin', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (25, 'rice', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (26, 'tomato', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (27, 'tortilla', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (28, 'black olives', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (29, 'avocado', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (30, 'sour cream', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (31, 'canned navy beans', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (32, 'olive oil', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (33, 'lasagna noodles', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (34, 'ricotta cheese', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (35, 'tomato puree', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (36, 'tomato paste', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (37, 'grated Parmesan cheese', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (38, 'capers', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (39, 'anchovy paste', 1);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (40, 'spaghetti noodles', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (41, 'eggplant', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (42, 'broccoli', 0);
INSERT INTO Kitchen_Database.Ingredients (ingredient_id, ingredient_name, owned) VALUES (43, 'carrots', 0);

COMMIT;



START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (1, 'ounce');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (2, 'teaspoon');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (3, 'tablespoon');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (4, 'packet');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (5, 'cup');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (6, 'gram');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (7, 'milliliter');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (8, 'package');
INSERT INTO Kitchen_Database.Units (unit_id, unit_name) VALUES (9, 'pound');

COMMIT;



START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 1, 1, 12);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 2, 2, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 3, 2, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 4, 2, 0.25);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 5, 2, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 6, 2, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 7, 2, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 8, 2, 0.25);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 9, 4, 2);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 10, 5, 6);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 11, 3, 2.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 12, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 13, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 14, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (1, 15, 5, 1.25);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (2, 15, 5, 0.75);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (2, 16, 5, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (2, 17, 5, 0.75);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 18, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 19, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 11, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 20, 3, 3);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 21, 3, 3);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 22, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 2, 2, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 15, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (3, 25, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 23, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 26, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 28, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 29, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 13, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 7, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 25, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 12, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 30, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 24, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 3, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 8, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (4, 4, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 32, 3, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 13, 5, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 31, 1, 15);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 8, 2, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 4, 2, 0.25);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 33, 8, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 34, 5, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 7, 3, 1.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 1, 5, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 35, 5, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 36, 3, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 6, 2, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 12, 1, 5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (5, 37, 5, 0.25);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 32, 3, 3);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 13, 1, 6);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 7, 3, 3);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 39, 2, 2);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 38, 2, 2);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 28, 1, 3.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 26, 1, 14);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 3, 3, 1.3);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 4, 2, 0.25);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 5, 3, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 40, 1, 7);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (6, 15, 5, 8);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 41, 9, 4);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 26, 1, 24);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 12, 9, 2);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 13, 5, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 32, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 6, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (7, 37, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 18, 5, 1);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 42, 5, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 43, 5, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 40, 1, 4);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 20, NULL, NULL);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 4, 2, 0.5);
INSERT INTO Kitchen_Database.Recipe_Measurements (recipe_id, ingredient_id, unit_id, amount) VALUES (8, 7, 3, 1);

COMMIT;


START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (1, '\'\r===Sauce===\r Makes two pizzas\r #Pour can of tomato sauce into a mixing bowl\r #Add 1 teaspoon sugar, 1 teaspoon salt, 1/4 teaspoon pepper, 1 teaspoon parsley, 1 teaspoon basil, 1/4 teaspoon oregano, and 1 tablespoon crushed garlic to bowl\r #Stir, and set aside\r \r ===Dough===\r Makes one pizza\r # Mix 1 packet of yeast with 1 1/4 cups lukewarm water. Stir\r # Pour yeast/water into bowl containing 2 1/2 cups flour. Stir\r # Spread out wax paper. Sprinkle with flour. Pour dough out of mixing bowl onto wax paper. Knead. Repeatedly add more flour until dough feels fairly dry and consistent.\r # Sprinkle bowl with flour. Roll dough into a ball, sprinkle outside with flour, and put into bowl.\r # Cover bowl with a towel. Let stand for 2 hours.\r \r ===Cooking===\r # Preheat oven to 350-375 degrees.\r # Coat bottom and sides of aluminum pan with vegetable oil (about 2-3 tablespoons)\r # Lay out wax paper, and sprinkle a layer of flour on top.\r # Flatten dough on wax paper using rolling pin\r # Put dough in pan\r # Make ridge around outside of dough\r # Add sauce, mozzarella, toppings\r # Cook in oven for 30 minutes\r \'');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (2, '\'\n==Procedure==\n#Mix oats and water, then bring to a boil covered with a lid.\n#Once bubbling, stir and reduce temperature to the lowest possible to maintain simmering. Replace lid and watch carefully to prevent boiling over.\n#Stir every minute or so. After five minutes, remove lid, stir thoroughly and add milk.\n#Mix through, and keep stirring until fully mixed.\n#Serve and add raisins, brown sugar, syrup, a pinch of salt, honey, or inverted sugar syrup to taste.\n\'');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (3, '\'\n== Procedure ==\n\n# Fry some chicken parts (such as wings and legs) in a pan with green onions and oil until the outside of the chicken parts are brown.\n# Put in soy sauce, cooking wine, chopped ginger, and at most a tablespoon of sugar.  Add enough water to cover the chicken.\n# Do not cover pot.  Simmer at low heat until most of the liquid has evaporated.\n\'');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (4, '\'\n===Beans===\n#If using dried beans, wash them and examine them for any rocks, then soak overnight in plenty of water. Discard the soak water before cooking - your pot plants will love it!\n#Cook the beans until soft:\n#*If using a stove-top method, simmer them in lots of water until they are very soft. You\'ll need to cook the beans a very long time on very low heat. You may add salt or black pepper to the water.\n#*If using a pressure cooker, place the beans and some flavoring salt in enough water to cover all the beans fully, and bring to pressure.  Keep the pressure for about 20 minutes, turn off the heat, and let the pressure fall naturally (about 15 minutes).\n\n===Rice===\n#If using rice, cook as steamed rice (usually 2 cups of water for every 1 cup of rice)\n#Rinse rice well, until the water runs clear\n#Add 2 cups of water per cup of rice, and bring to a boil, then reduce to the lowest heat and simmer for 15-20 minutes. \n#Set aside with the lid secured, for at least 5 minutes before use.\n\n===All fillings===\n#Get a large wide pot or tall-sided frying pan.\n#Saute any onion or garlic in a little oil.\n#Add uncooked meats to the pan and fry, stirring to ensure it browns all over. If using a ground (minced) meat, break it up as it cooks. Drain any excess grease. \n#Add well-cooked beans. You might want to smash the beans, perhaps with a potato masher.\n#Add spices and other flavorings as necessary.\n#Add tomatoes, and cooked rice if using it. Reduce the heat. Simmer in open pan for about 40 minutes or until the liquid from the tomatoes is gone.\n#Soften the tortillas by heating them up. Use a small amount of oil to prevent sticking, if heating in a pan that isn\'t non-stick. Cover with foil if heating them in an oven, to protect the tortillas from moisture loss.\n#Place the filling mixture onto a tortilla. Add non-cooked fillings like cheese, olives, avocados.\n#Roll up the tortilla. (and then make the next one, and so on)\n\n===Rolling===\n# Position your tortilla flat on a suitable surface such as a kitchen counter top. (12-inch tortillas are suggested. If you can find bigger tortillas, use them!)\n# Place your fillings on the flat tortilla in any order.\n# Fold the bottom flap up. Ensure that there is a sufficient amount of tortilla used for the flap. A small flap will allow the fillings to escape, possibly falling in your lap and burning you.\n# Bring the side up and over your filling. Tucking the edge of the tortilla under your filling is an excellent extra step. \n# Create a small fold with the remaining side of the tortilla. This is the \'\'key\'\' to maintaining burrito integrity. Failure is a given if you do not follow this step!  (The small, diagonal flap is an extra \"lock\" for the bottom flap of the tortilla without it, the weight of the filling has the power to force the bottom flap right out of itself.) \n# Bring the remaining tortilla flap over the filling. Eat with confidence, though the fillings may be very hot.\n');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (5, '\'\n==Procedure==\n#Cook lasagna noodles.\n#Start preheating oven for 180 C (350 F).\n#Saute garlic and onions.\n#Add the chopped beans and cook for 5 minutes.\n#Add tomato sauce, tomato puree, tomato paste, oregano, basil, and pepper and cook for 5 minutes.\n#In a 30cm x 20cm (13 x 9 in.) baking dish, form a layer using half the noodles, sauce, cottage cheese, and mozzarella.\n#Repeat to form a second layer.\n#Sprinkle top with Parmesan cheese.\n#Bake uncovered at 180c (350 degrees) for 25 minutes, until noodles are tender and sauce is bubbling.\n\n4 servings.\n\'');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (6, '\'\n===Procedure===\n#Fill a large pot with two quarts of water and add two tablespoons of salt.\n#Set heat on high to boil water.\n#Heat two tablespoons of oil in a large skillet over medium heat.\n#Add onions to skillet and cook for six minutes, stirring occasionally. Be careful not to burn the onions.\n#Add garlic and anchovies to skillet. \n#Cook for one minute maximum, stirring to break up the anchovies. \n#Add capers, chili peppers, olives, tomatoes, pepper and 1/2 teaspoon of salt to skillet.\n#Bring to a boil then reduce heat to medium-low and simmer, uncovered, for 10 minutes, stirring occasionally. \n#Boil the pasta until \'\'al dente\'\' while the sauce is simmering. This should take about 12 minutes.\n#Drain the cooked pasta in a colander and put the sauce in the bottom of the pot.\n#Top with the cooked pasta, parsley and one tablespoon of olive oil.\n#Toss until pasta is thoroughly coated with \'\'sugo\'\'.\n\'');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (7, '\'\n== Procedure ==\n\n#Cut eggplants lengthwise in slices ¼ of an inch (0.75cm) thick and put them in a plate covered by plenty of salt for about 1 hour. Wash off the excess salt and dry the slices with a paper towel.\n#Prepare a tomato sauce as follows.  Start cooking the onion slices in olive oil; when the onion is soft add drained whole tomatoes and mash them with a fork. If the tomatoes are watery, add a small can of tomato paste to thicken the sauce. Add 2 leaves of basil and simmer for about 20 minutes.\n#While the tomato sauce is cooking, fry the eggplant slices as follows.  Fill a frying pan (cast iron if you have it) with ½ inch (1 cm) of olive oil and heat. When the oil is hot, start frying the eggplant slices a few at a time so that they do not overlap in the pan. Cook until golden, flipping once. Remove the eggplants and put them in a drainer so the excess oil can drain. Repeat until all the slices are cooked. \n#To assemble the Parmigiana, start with a thin layer of sauce in the bottom of a greased oven proof baking pan or casserole. Then proceed with a layer of eggplants with their edges slightly overlapped and no voids.  Then add basil leaves and a layer of sliced mozzarella. Continue alternating layers until the eggplant is used up, and finish topping with tomato sauce and grated Parmesan or grana. Bake in the oven for about 40 minutes at 350°F (180°C). Serve really hot. If you are lucky enough to have leftovers, they taste even better the day after.\n\'');
INSERT INTO Kitchen_Database.Recipe_Instructions (recipe_id, instructions) VALUES (8, '\'\n== Procedure ==\n# Cook noodles in a pot according to directions.\n# Coat a skillet with olive oil and place on stove with medium to low heat (add garlic if desired).\n# Add meat and vegetables to skillet, season with salt and pepper, lightly coat with soy sauce, and cook everything until it\'s done; about 8-10 min. (Optional: Right before everything is finished cooking add bean sprouts and cook until they turn mildly translucent.)\n# Strain noodles and add them to the stir-fry.\n# Coat with soy sauce and cook for roughly 1 minute in order to sear in the flavor. (Tip: When adding the soy sauce, start out light...taste and then add more. It\'s much easier to add ingredients than removing them.)\n\'');

COMMIT;



START TRANSACTION;
USE Kitchen_Database;
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-03-23 20:36:13');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (7, '2020-02-22 14:03:07');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (1, '2020-01-07 12:22:55');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-03-19 18:19:12');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-03-21 12:33:57');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-01-12 16:13:11');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (8, '2020-01-21 17:54:53');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-03-12 20:39:28');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (6, '2020-02-06 20:46:50');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (1, '2020-04-06 10:55:36');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (3, '2020-04-14 11:39:52');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-03-29 10:56:28');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-04-21 17:15:48');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-02-23 17:33:02');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-01-10 14:46:04');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (1, '2020-03-23 16:55:06');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-04-13 16:57:52');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-04-05 08:45:56');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (6, '2020-02-02 18:27:46');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-02-26 12:57:34');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (1, '2020-01-02 17:54:33');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-01-18 14:00:25');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-02-29 08:08:43');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-03-05 10:18:07');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (3, '2020-01-16 13:59:03');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (8, '2020-01-05 15:03:22');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (3, '2020-03-29 16:13:22');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (5, '2020-02-27 10:48:49');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-01-07 10:56:07');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (7, '2020-03-13 19:04:58');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-04-04 15:50:47');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-02-23 11:59:18');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (6, '2020-02-12 16:16:54');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (6, '2020-03-12 18:47:03');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-04-08 13:10:52');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (8, '2020-02-23 18:30:03');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (6, '2020-04-14 19:52:21');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (1, '2020-03-29 11:23:27');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-03-09 20:38:51');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (8, '2020-04-02 18:02:50');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (7, '2020-03-26 10:46:54');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (6, '2020-03-03 18:50:42');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-04-17 19:54:18');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (2, '2020-03-17 20:27:23');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (4, '2020-02-23 19:55:23');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (7, '2020-01-20 14:00:31');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (8, '2020-01-03 16:56:11');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (8, '2020-04-20 14:56:48');
INSERT INTO Kitchen_Database.My_Cooking_History (recipe_id, datetime_cooked) VALUES (7, '2020-01-27 14:44:15');

COMMIT;