
-- create the database
DROP SCHEMA IF EXISTS `drugstore`;
CREATE SCHEMA IF NOT EXISTS `drugstore` DEFAULT CHARACTER SET utf8 ;

-- select the database
USE `drugstore`;

-- create tables
DROP TABLE IF EXISTS `drugstore`.`Doctor`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Doctor` 
(
  `doctor_ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `experience` INT NOT NULL,
  `specialty` VARCHAR(45) NULL,
  PRIMARY KEY (`doctor_ssn`),
  UNIQUE INDEX `SSN_UNIQUE` (`doctor_ssn` ASC) VISIBLE
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Patient`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Patient` 
(
  `patient_ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `address` VARCHAR(45) NOT NULL,
  `doctor_ssn` INT NOT NULL,
  PRIMARY KEY (`patient_ssn`),
  UNIQUE INDEX `SSN_UNIQUE` (`patient_ssn` ASC) VISIBLE,
  INDEX `patient_fk_doctor_idx` (`doctor_ssn` ASC) VISIBLE,
  CONSTRAINT `patient_fk_doctor`
    FOREIGN KEY (`doctor_ssn`)
    REFERENCES `drugstore`.`Doctor` (`doctor_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Pharmaceutical_Company`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Pharmaceutical_Company` 
(
  `pharmaceutical_company_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `phone_number` INT NOT NULL,
  PRIMARY KEY (`pharmaceutical_company_id`)
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Drug`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Drug` 
(
  `drug_id` INT NOT NULL,
  `trade_name` VARCHAR(45) NOT NULL,
  `generic_name` VARCHAR(45) NOT NULL,
  `pharmaceutical_company_id` INT NOT NULL,
  PRIMARY KEY (`drug_id`),
  INDEX `drug_fk_manufacturer_idx` (`pharmaceutical_company_id` ASC) VISIBLE,
  UNIQUE INDEX `trade_name_UNIQUE` (`trade_name` ASC) VISIBLE,
  CONSTRAINT `drug_fk_manufacturer`
    FOREIGN KEY (`pharmaceutical_company_id`)
    REFERENCES `drugstore`.`Pharmaceutical_Company` (`pharmaceutical_company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Pharmacy`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Pharmacy` 
(
  `pharmacy_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`pharmacy_id`)
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Pharmacy_Drug`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Pharmacy_Drug` (
  `pharmacy_drug_id` INT NOT NULL,
  `drug_id` INT NOT NULL,
  `price` INT NOT NULL,
  `pharmacy_id` INT NOT NULL,
  INDEX `drug_pharmacy_fk_pharmacy_idx` (`pharmacy_id` ASC) VISIBLE,
  INDEX `drug_pharmacy_fk_drug_idx` (`drug_id` ASC) VISIBLE,
  PRIMARY KEY (`pharmacy_drug_id`),
  CONSTRAINT `drug_pharmacy_fk_pharmacy`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `drugstore`.`Pharmacy` (`pharmacy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `drug_pharmacy_fk_drug`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugstore`.`Drug` (`drug_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Perscription`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Perscription` 
(
  `perscription_id` INT NOT NULL,
  `patient_ssn` INT NOT NULL,
  `drug_id` INT NOT NULL,
  `doctor_ssn` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `refills_auth` INT NOT NULL,
  `refills_filled` INT NULL,
  `dosage` INT NOT NULL,
  `pharmacy_id` INT NOT NULL,
  INDEX `perscription_fk_patient_idx` (`patient_ssn` ASC) VISIBLE,
  INDEX `perscription_fk_doctor_idx` (`doctor_ssn` ASC) VISIBLE,
  INDEX `perscription_fk_drug_idx` (`drug_id` ASC) VISIBLE,
  PRIMARY KEY (`perscription_id`),
  INDEX `fk_Perscription_Pharmacy1_idx` (`pharmacy_id` ASC) VISIBLE,
  CONSTRAINT `perscription_fk_patient`
    FOREIGN KEY (`patient_ssn`)
    REFERENCES `drugstore`.`Patient` (`patient_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `perscription_fk_doctor`
    FOREIGN KEY (`doctor_ssn`)
    REFERENCES `drugstore`.`Doctor` (`doctor_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `perscription_fk_drug`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugstore`.`Drug` (`drug_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Perscription_Pharmacy1`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `drugstore`.`Pharmacy` (`pharmacy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Contract_Supervisor`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Contract_Supervisor` 
(
  `supervisor_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `pharmacy_id` INT NOT NULL,
  PRIMARY KEY (`supervisor_id`),
  INDEX `supervisor_fk_pharmacy_idx` (`pharmacy_id` ASC) VISIBLE,
  CONSTRAINT `supervisor_fk_pharmacy`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `drugstore`.`Pharmacy` (`pharmacy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

DROP TABLE IF EXISTS `drugstore`.`Contract`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Contract` 
(
  `contract_id` INT NOT NULL AUTO_INCREMENT,
  `pharmaceutical_company_id` INT NOT NULL,
  `pharmacy_id` INT NOT NULL,
  `start` DATETIME NULL,
  `end` DATETIME NULL,
  `contract_details` VARCHAR(200) NOT NULL,
  `supervisor_id` INT NOT NULL,
  PRIMARY KEY (`contract_id`),
  UNIQUE INDEX `ID_UNIQUE` (`contract_id` ASC) VISIBLE,
  INDEX `contract_fk_pharmacutical_company_idx` (`pharmaceutical_company_id` ASC) VISIBLE,
  INDEX `contract_fk_pharmacy_idx` (`pharmacy_id` ASC) VISIBLE,
  INDEX `contract_fk_supervisor_idx` (`supervisor_id` ASC) VISIBLE,
  CONSTRAINT `contract_fk_pharmacutical_company`
    FOREIGN KEY (`pharmaceutical_company_id`)
    REFERENCES `drugstore`.`Pharmaceutical_Company` (`pharmaceutical_company_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contract_fk_pharmacy`
    FOREIGN KEY (`pharmacy_id`)
    REFERENCES `drugstore`.`Pharmacy` (`pharmacy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `contract_fk_supervisor`
    FOREIGN KEY (`supervisor_id`)
    REFERENCES `drugstore`.`Contract_Supervisor` (`supervisor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
)
ENGINE = InnoDB;

INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (4, 'Bria Klocko', 8, 'et');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (5, 'Arno Batz', 7, 'officia');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (43, 'Herman Terry', 9, 'rerum');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (388, 'Theresa Koch DDS', 8, 'ratione');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (640, 'Darrin Lakin', 1, 'voluptates');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (913, 'Mack Abshire', 5, 'molestiae');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (8491, 'Mrs. Lavada Friesen', 7, 'iusto');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (113749, 'Flossie Ratke III', 8, 'quo');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (7102503, 'Prof. Harrison Kautzer Sr.', 7, 'praesentium');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (9092705, 'Dr. Darien Welch DDS', 1, 'voluptatem');

INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (0, 'optio', 0, '02465 Maxine Keys\nWest Stoneborough, WY 52150', 4);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (30, 'occaecati', 60572, '2518 Rafael Court\nJohnsshire, VA 92280-6727', 5);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (8608, 'consectetur', 22, '37062 Klein Pine Suite 376\nHauckport, RI 7079', 913);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (43852, 'in', 4088449, '87836 Adrain Islands Apt. 785\nSchambergervill', 7102503);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (62211, 'fuga', 22791092, '53461 Keaton Mall Suite 223\nRogahntown, MS 66', 8491);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (62784, 'vel', 586, '8316 Danielle Cove Apt. 709\nNorth Lukasburgh,', 9092705);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (9025739, 'sapiente', 19655, '34141 Alivia Spring Suite 064\nMeghanton, MO 0', 113749);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (79501447, 'tenetur', 51, '9640 Mariana Row\nStantontown, KS 23386-0660', 640);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (267947479, 'porro', 120875, '9489 Heller Shores\nNorth Lelahmouth, TX 86582', 388);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (467984945, 'dolore', 88544, '7802 Mertie Forks Apt. 759\nLake Philiphaven, ', 43);

INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (0, 'tenetur', 75);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (580, 'illo', 0);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (740, 'velit', 2147483647);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (5125, 'laborum', 2147483647);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (569105905, 'aspernatur', 953720);

INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (0, 'eius', 'quia', 0);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (3, 'eligendi', 'et', 740);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (26, 'et', 'laborum', 5125);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (35, 'illo', 'voluptatem', 580);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (74, 'magnam', 'harum', 5125);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (90, 'maiores', 'id', 740);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (496, 'voluptatem', 'dolores', 5125);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (541, 'rerum', 'perferendis', 0);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (7899, 'delectus', 'omnis', 580);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (88400, 'tempore', 'repellendus', 569105905);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (200604, 'optio', 'cum', 0);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (352718, 'unde', 'sint', 580);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (636382, 'libero', 'repellendus', 569105905);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (997862, 'tempora', 'et', 740);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (1184561, 'porro', 'quo', 569105905);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (8488203, 'ut', 'omnis', 740);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (8630900, 'quod', 'laborum', 580);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (33438389, 'minus', 'nemo', 569105905);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (35553486, 'voluptatum', 'explicabo', 569105905);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (80064056, 'repellat', 'magni', 740);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (699022840, 'id', 'et', 5125);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (734173477, 'a', 'quis', 5125);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (739554806, 'quaerat', 'quam', 0);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (830905261, 'omnis', 'consectetur', 580);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (976611371, 'sit', 'incidunt', 0);

INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (0, 'nisi', '619 Stark Expressway Suite 404\nCristophershir', '1-361-352-2161');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (36, 'ipsum', '03115 Ida Flats Suite 919\nCreminfort, IL 2685', '1-075-399-1227x6010');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (556, 'cum', '408 Leanne Stream Apt. 888\nKertzmanntown, AR ', '02493314891');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (574, 'nemo', '0837 Wiley Road Suite 571\nHarberport, TN 6345', '1-083-968-6048x91930');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (21830, 'natus', '782 Vito Valley\nLake Derickchester, HI 26966', '(162)056-4606x5656');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (395736, 'animi', '064 Parker Loaf Suite 067\nLanefort, UT 24280-', '08624289967');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (450251, 'magni', '93739 Dixie Fields\nJaylenborough, KY 88465-60', '848.833.0370x049');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (9127229, 'vel', '160 Ryann Ways\nNorth Summerland, DC 25433', '+23(6)4283162983');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (519116926, 'a', '8931 Halvorson Divide\nSouth Murielside, MO 35', '(890)149-4030x1831');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (784953580, 'dolorem', '715 Shaun Parks Suite 265\nAnaismouth, NH 0813', '767-980-2719x6933');

INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (0, 3, 3771, 36);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (6, 90, 13, 395736);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (50, 8630900, 61759, 450251);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (56, 541, 529424, 9127229);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (80, 496, 15323534, 450251);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (277, 88400, 511731431, 784953580);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (723, 1184561, 9, 21830);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (774, 976611371, 22110500, 21830);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (887, 0, 293, 0);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (2873, 636382, 21370, 556);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (3818, 7899, 37505209, 519116926);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (8570, 200604, 2, 0);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (10026, 830905261, 98203, 574);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (36753, 35553486, 5007238, 519116926);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (43923, 739554806, 1817652, 556);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (91219, 26, 0, 556);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (269595, 734173477, 15, 36);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (2289592, 997862, 229698807, 574);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (5639644, 74, 0, 21830);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (6495504, 35, 994, 574);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (22773478, 699022840, 5, 0);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (38303655, 352718, 3, 36);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (186902948, 8488203, 18, 395736);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (244835196, 33438389, 16, 9127229);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (318184114, 80064056, 0, 784953580);

INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (7, 'est', 21830);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (19, 'magnam', 36);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (179, 'voluptatem', 556);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (233, 'sapiente', 0);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (97975157, 'quos', 574);

INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (1, 0, 0, '1980-05-31 00:30:48', '1987-07-14 18:00:36', 'ea', 7);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (2, 580, 36, '2019-07-22 18:18:25', '1980-10-14 22:37:31', 'omnis', 19);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (3, 740, 556, '1989-01-28 23:14:33', '1996-12-07 07:39:20', 'qui', 179);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (4, 5125, 574, '1990-02-08 15:06:12', '1988-02-13 17:23:52', 'nihil', 233);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (5, 569105905, 21830, '1994-01-18 02:38:47', '1986-02-04 21:12:52', 'ullam', 97975157);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (6, 0, 395736, '2011-09-14 12:27:44', '1983-07-13 05:58:36', 'ratione', 7);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (7, 580, 450251, '1986-03-13 03:05:14', '1989-10-06 02:54:20', 'nostrum', 19);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (8, 740, 9127229, '2013-09-29 05:53:01', '1998-05-07 15:55:51', 'ducimus', 179);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (9, 5125, 519116926, '1998-05-21 04:02:37', '1993-05-19 08:41:58', 'veniam', 233);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (10, 569105905, 784953580, '1971-08-09 18:52:22', '2013-07-31 06:34:12', 'error', 97975157);

INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (0, 8608, 26, 43, '1988-03-29 10:19:16', 11, 1, 9, 0, 556);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (1, 0, 0, 4, '2011-02-16 21:18:11', 54, 3, 5, 4594, 0);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (2, 79501447, 26, 113749, '1977-11-03 06:55:39', 367881, 9, 9, 14623, 9127229);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (4, 0, 90, 4, '1999-11-19 01:14:05', 8892, 3, 6, 31, 0);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (5, 267947479, 35, 7102503, '2003-06-18 05:55:29', 5, 2, 3, 127656254, 519116926);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (17, 30, 3, 5, '2000-11-07 00:18:35', 5, 1, 4, 0, 36);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (32, 8608, 739554806, 43, '1992-07-22 05:47:20', 19, 9, 9, 52312, 556);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (35, 62784, 200604, 913, '1983-12-31 20:05:16', 34167, 4, 3, 504921767, 395736);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (55, 62211, 976611371, 640, '1984-08-19 05:23:01', 21268294, 9, 7, 76301, 21830);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (66, 62784, 8488203, 913, '1975-02-20 14:40:30', 602, 1, 6, 193680, 395736);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (74, 62211, 80064056, 640, '2017-09-04 02:06:41', 117107, 7, 2, 40033, 21830);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (191, 0, 200604, 4, '1997-02-28 13:57:26', 98804, 4, 6, 7389260, 0);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (201, 9025739, 734173477, 8491, '1972-11-10 18:19:01', 3177, 9, 6, 84201989, 450251);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (206, 8608, 636382, 43, '1974-07-06 08:58:30', 0, 1, 6, 46976121, 556);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (268, 267947479, 830905261, 7102503, '2002-07-09 12:06:34', 805423, 4, 3, 0, 519116926);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (559, 79501447, 636382, 113749, '1986-01-21 16:31:28', 5, 5, 3, 0, 9127229);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (815, 43852, 35553486, 388, '2002-02-25 03:56:41', 0, 1, 9, 561999, 574);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (858, 8608, 33438389, 43, '1988-03-09 15:02:46', 1158, 6, 7, 90217305, 556);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (967, 43852, 35, 388, '2017-12-18 05:51:44', 154, 9, 4, 349, 574);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (1252, 43852, 7899, 388, '1982-10-03 23:38:45', 469733631, 6, 3, 28478, 574);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (2740, 267947479, 7899, 7102503, '2013-08-17 13:46:43', 7413, 4, 2, 75, 519116926);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (4424, 43852, 830905261, 388, '1978-08-17 06:33:30', 304325299, 4, 6, 3, 574);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (6870, 467984945, 74, 9092705, '2013-05-17 02:20:00', 3, 8, 1, 106005, 784953580);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (9861, 62211, 74, 640, '1992-06-29 23:09:29', 0, 3, 7, 95054179, 21830);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (28319, 9025739, 496, 8491, '2015-09-21 10:30:26', 3, 7, 6, 0, 450251);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (45906, 30, 352718, 5, '1983-02-08 21:22:07', 3309200, 9, 3, 71753851, 36);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (64397, 9025739, 352718, 8491, '1972-07-05 00:36:09', 3, 9, 5, 9822, 450251);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (66373, 30, 496, 5, '1994-02-16 20:47:46', 40, 5, 8, 2690, 36);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (82631, 79501447, 541, 113749, '1981-10-23 06:33:36', 6, 8, 7, 7300, 9127229);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (352523, 62211, 1184561, 640, '1970-10-19 11:58:18', 798, 5, 4, 20, 21830);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (446211, 62784, 0, 913, '1988-01-30 16:28:42', 195, 9, 1, 573, 395736);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (562762, 30, 734173477, 5, '2005-12-14 23:41:13', 1, 6, 1, 6, 36);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (857218, 79501447, 33438389, 113749, '1997-02-01 14:43:09', 19571, 3, 2, 871786, 9127229);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (3169660, 267947479, 997862, 7102503, '1994-03-23 12:24:30', 757115, 9, 5, 962, 519116926);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (4579491, 8608, 541, 43, '1985-02-10 21:49:12', 11, 4, 9, 468, 556);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (6285917, 467984945, 88400, 9092705, '1997-11-21 11:59:57', 585169, 1, 4, 690978946, 784953580);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (7490637, 62211, 88400, 640, '2012-06-01 13:17:38', 120972, 1, 3, 74345, 21830);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (7991892, 267947479, 35553486, 7102503, '1987-11-25 03:04:05', 1006256, 6, 9, 24, 519116926);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (8338809, 0, 8488203, 4, '2007-02-25 23:13:40', 91501, 1, 1, 148854, 0);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (9188336, 30, 8630900, 5, '2006-02-17 11:20:21', 283604, 5, 7, 89740, 36);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (25316753, 79501447, 739554806, 113749, '2015-05-13 09:16:36', 168, 6, 5, 0, 9127229);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (67282797, 467984945, 80064056, 9092705, '2001-06-27 01:34:33', 0, 1, 5, 265644, 784953580);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (80864627, 43852, 997862, 388, '1977-11-14 12:38:52', 1020, 4, 6, 3323195, 574);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (95013314, 467984945, 1184561, 9092705, '1998-05-10 08:54:45', 128154542, 6, 8, 2897521, 784953580);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (97361041, 9025739, 3, 8491, '1994-01-29 13:50:59', 9467, 1, 7, 55118, 450251);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (237301793, 0, 699022840, 4, '2015-02-26 23:15:28', 92220, 7, 7, 62099, 0);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (381383184, 467984945, 976611371, 9092705, '1974-12-04 14:35:41', 43, 4, 3, 348812245, 784953580);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (512932471, 62784, 90, 913, '1991-05-02 17:10:02', 454771, 3, 6, 0, 395736);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (555913891, 9025739, 8630900, 8491, '1989-09-03 23:37:55', 0, 8, 1, 241917, 450251);
INSERT INTO `Perscription` (`perscription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (915961782, 62784, 699022840, 913, '2016-02-19 02:24:55', 0, 8, 7, 7, 395736);





