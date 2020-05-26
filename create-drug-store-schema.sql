
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

DROP TABLE IF EXISTS `drugstore`.`Prescription`;
CREATE TABLE IF NOT EXISTS `drugstore`.`Prescription` 
(
  `prescription_id` INT NOT NULL,
  `patient_ssn` INT NOT NULL,
  `drug_id` INT NOT NULL,
  `doctor_ssn` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `refills_auth` INT NOT NULL,
  `refills_filled` INT NULL,
  `dosage` INT NOT NULL,
  `pharmacy_id` INT NOT NULL,
  INDEX `prescription_fk_patient_idx` (`patient_ssn` ASC) VISIBLE,
  INDEX `prescription_fk_doctor_idx` (`doctor_ssn` ASC) VISIBLE,
  INDEX `prescription_fk_drug_idx` (`drug_id` ASC) VISIBLE,
  PRIMARY KEY (`prescription_id`),
  INDEX `fk_prescription_Pharmacy1_idx` (`pharmacy_id` ASC) VISIBLE,
  CONSTRAINT `prescription_fk_patient`
    FOREIGN KEY (`patient_ssn`)
    REFERENCES `drugstore`.`Patient` (`patient_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prescription_fk_doctor`
    FOREIGN KEY (`doctor_ssn`)
    REFERENCES `drugstore`.`Doctor` (`doctor_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `prescription_fk_drug`
    FOREIGN KEY (`drug_id`)
    REFERENCES `drugstore`.`Drug` (`drug_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prescription_Pharmacy1`
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


