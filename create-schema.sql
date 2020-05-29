
-- create the database
DROP SCHEMA IF EXISTS `drugstore1`;
CREATE SCHEMA IF NOT EXISTS `drugstore1` DEFAULT CHARACTER SET utf8 ;

-- select the database
USE `drugstore1`;

#
# TABLE STRUCTURE FOR: Doctor
#

DROP TABLE IF EXISTS `Doctor`;

CREATE TABLE `Doctor` (
  `doctor_ssn` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `experience` int(11) NOT NULL,
  `specialty` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`doctor_ssn`),
  UNIQUE KEY `SSN_UNIQUE` (`doctor_ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (923, 'nostrum', 946, 'est');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (2849, 'ut', 9689449, 'officiis');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (46167, 'ipsum', 71804804, 'nostrum');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (8076868, 'sequi', 32072116, 'ipsam');
INSERT INTO `Doctor` (`doctor_ssn`, `name`, `experience`, `specialty`) VALUES (629539399, 'dolorum', 450, 'tenetur');

DROP TABLE IF EXISTS `Patient`;

CREATE TABLE `Patient` (
  `patient_ssn` int(11) NOT NULL,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `age` int(11) DEFAULT NULL,
  `address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `doctor_ssn` int(11) NOT NULL,
  PRIMARY KEY (`patient_ssn`),
  UNIQUE KEY `SSN_UNIQUE` (`patient_ssn`),
  KEY `patient_fk_doctor_idx` (`doctor_ssn`),
  CONSTRAINT `patient_fk_doctor` FOREIGN KEY (`doctor_ssn`) REFERENCES `Doctor` (`doctor_ssn`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (0, 'reprehenderit', 0, '44502 Schuppe Views\nSouth Tracebury, LA 92978', 46167);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (2, 'alias', 62, '9172 Rafaela Lake Suite 643\nAddisonhaven, CO ', 8076868);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (5, 'est', 2703363, '9926 Orrin Cape Apt. 890\nWest Alayna, GA 9792', 2849);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (6370, 'quasi', 326866, '68854 Jerde Ridge\nDanialtown, IL 23159', 46167);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (6582, 'aut', 0, '6471 Torphy Parkways Apt. 298\nSouth Myrtie, O', 923);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (12903, 'ullam', 5, '56463 Amalia Harbor\nPort Nelda, FL 10704', 8076868);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (283018, 'architecto', 2882912, '552 Declan Mall Apt. 737\nKassulketon, KY 0123', 629539399);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (330667, 'odio', 752, '941 Swift River Apt. 910\nChamplinhaven, GA 91', 923);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (3000143, 'a', 3496272, '76920 Agustin Shoals Suite 208\nKrajcikbury, O', 2849);
INSERT INTO `Patient` (`patient_ssn`, `name`, `age`, `address`, `doctor_ssn`) VALUES (79599271, 'iure', 169538, '8974 Kariane Rue Suite 536\nLake Helena, CA 23', 629539399);

#
# TABLE STRUCTURE FOR: Pharmaceutical_Company
#

DROP TABLE IF EXISTS `Pharmaceutical_Company`;

CREATE TABLE `Pharmaceutical_Company` (
  `pharmaceutical_company_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` int(11) NOT NULL,
  PRIMARY KEY (`pharmaceutical_company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (1, 'aperiam', 1);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (2, 'non', 0);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (3, 'voluptas', 0);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (4, 'odit', 412);
INSERT INTO `Pharmaceutical_Company` (`pharmaceutical_company_id`, `name`, `phone_number`) VALUES (5, 'aut', 780968412);

#
# TABLE STRUCTURE FOR: Drug
#

DROP TABLE IF EXISTS `Drug`;

CREATE TABLE `Drug` (
  `drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `trade_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `generic_name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `pharmaceutical_company_id` int(11) NOT NULL,
  PRIMARY KEY (`drug_id`),
  UNIQUE KEY `trade_name_UNIQUE` (`trade_name`),
  KEY `drug_fk_manufacturer_idx` (`pharmaceutical_company_id`),
  CONSTRAINT `drug_fk_manufacturer` FOREIGN KEY (`pharmaceutical_company_id`) REFERENCES `Pharmaceutical_Company` (`pharmaceutical_company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (1, 'aliquid', 'dolorem', 1);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (2, 'fugiat', 'suscipit', 2);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (3, 'illum', 'ea', 3);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (4, 'expedita', 'fuga', 4);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (5, 'enim', 'voluptas', 5);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (6, 'voluptates', 'cum', 1);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (7, 'ut', 'sit', 2);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (8, 'suscipit', 'sunt', 3);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (9, 'aut', 'unde', 4);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (10, 'repellat', 'aut', 5);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (11, 'distinctio', 'dolorem', 1);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (12, 'nobis', 'dolor', 2);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (13, 'beatae', 'ratione', 3);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (14, 'id', 'quam', 4);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (15, 'non', 'vel', 5);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (16, 'est', 'ut', 1);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (17, 'architecto', 'sed', 2);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (18, 'qui', 'eaque', 3);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (19, 'laboriosam', 'et', 4);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (20, 'consequatur', 'sint', 5);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (21, 'inventore', 'provident', 1);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (22, 'blanditiis', 'aut', 2);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (23, 'dolore', 'temporibus', 3);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (24, 'tenetur', 'vero', 4);
INSERT INTO `Drug` (`drug_id`, `trade_name`, `generic_name`, `pharmaceutical_company_id`) VALUES (25, 'et', 'cupiditate', 5);

#
# TABLE STRUCTURE FOR: Pharmacy
#

DROP TABLE IF EXISTS `Pharmacy`;

CREATE TABLE `Pharmacy` (
  `pharmacy_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `phone_number` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`pharmacy_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (1, 'hic', '00896 Eliane Vista\nSouth Maiaburgh, CA 72949', '07736552178');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (2, 'nam', '7086 Kshlerin Fall Apt. 764\nFriesenville, AL ', '938-980-0912x795');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (3, 'quia', '759 Kathryne Keys Suite 366\nSouth Karleechest', '(378)008-5900');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (4, 'mollitia', '22942 Erdman Extensions Suite 995\nColtmouth, ', '653-364-4059');
INSERT INTO `Pharmacy` (`pharmacy_id`, `name`, `address`, `phone_number`) VALUES (5, 'id', '15069 Dan Corner\nPort Marcellushaven, IA 0615', '(048)620-7472x3738');

#
# TABLE STRUCTURE FOR: Pharmacy_Drug
#

DROP TABLE IF EXISTS `Pharmacy_Drug`;

CREATE TABLE `Pharmacy_Drug` (
  `pharmacy_drug_id` int(11) NOT NULL AUTO_INCREMENT,
  `drug_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `pharmacy_id` int(11) NOT NULL,
  PRIMARY KEY (`pharmacy_drug_id`),
  KEY `drug_pharmacy_fk_pharmacy_idx` (`pharmacy_id`),
  KEY `drug_pharmacy_fk_drug_idx` (`drug_id`),
  CONSTRAINT `drug_pharmacy_fk_drug` FOREIGN KEY (`drug_id`) REFERENCES `Drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `drug_pharmacy_fk_pharmacy` FOREIGN KEY (`pharmacy_id`) REFERENCES `Pharmacy` (`pharmacy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (1, 1, 3, 1);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (2, 2, 74210, 2);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (3, 3, 1, 3);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (4, 4, 3413488, 4);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (5, 5, 1041116, 5);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (6, 6, 3, 1);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (7, 7, 2, 2);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (8, 8, 27952, 3);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (9, 9, 1, 4);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (10, 10, 340, 5);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (11, 11, 1, 1);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (12, 12, 663, 2);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (13, 13, 2, 3);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (14, 14, 0, 4);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (15, 15, 184, 5);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (16, 16, 0, 1);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (17, 17, 4, 2);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (18, 18, 7752495, 3);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (19, 19, 60336, 4);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (20, 20, 46, 5);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (21, 21, 11, 1);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (22, 22, 855, 2);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (23, 23, 4142371, 3);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (24, 24, 5085, 4);
INSERT INTO `Pharmacy_Drug` (`pharmacy_drug_id`, `drug_id`, `price`, `pharmacy_id`) VALUES (25, 25, 214440, 5);

#
# TABLE STRUCTURE FOR: Contract_Supervisor
#

DROP TABLE IF EXISTS `Contract_Supervisor`;

CREATE TABLE `Contract_Supervisor` (
  `supervisor_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `pharmacy_id` int(11) NOT NULL,
  PRIMARY KEY (`supervisor_id`),
  KEY `supervisor_fk_pharmacy_idx` (`pharmacy_id`),
  CONSTRAINT `supervisor_fk_pharmacy` FOREIGN KEY (`pharmacy_id`) REFERENCES `Pharmacy` (`pharmacy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (1, 'iusto', 1);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (2, 'voluptatem', 2);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (3, 'voluptatem', 3);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (4, 'consequatur', 4);
INSERT INTO `Contract_Supervisor` (`supervisor_id`, `name`, `pharmacy_id`) VALUES (5, 'aspernatur', 5);

#
# TABLE STRUCTURE FOR: Contract
#

DROP TABLE IF EXISTS `Contract`;

CREATE TABLE `Contract` (
  `contract_id` int(11) NOT NULL AUTO_INCREMENT,
  `pharmaceutical_company_id` int(11) NOT NULL,
  `pharmacy_id` int(11) NOT NULL,
  `start` datetime DEFAULT NULL,
  `end` datetime DEFAULT NULL,
  `contract_details` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `supervisor_id` int(11) NOT NULL,
  PRIMARY KEY (`contract_id`),
  UNIQUE KEY `ID_UNIQUE` (`contract_id`),
  KEY `contract_fk_pharmacutical_company_idx` (`pharmaceutical_company_id`),
  KEY `contract_fk_pharmacy_idx` (`pharmacy_id`),
  KEY `contract_fk_supervisor_idx` (`supervisor_id`),
  CONSTRAINT `contract_fk_pharmacutical_company` FOREIGN KEY (`pharmaceutical_company_id`) REFERENCES `Pharmaceutical_Company` (`pharmaceutical_company_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `contract_fk_pharmacy` FOREIGN KEY (`pharmacy_id`) REFERENCES `Pharmacy` (`pharmacy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `contract_fk_supervisor` FOREIGN KEY (`supervisor_id`) REFERENCES `Contract_Supervisor` (`supervisor_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (1, 1, 1, '1979-10-03 01:55:10', '2018-11-21 15:33:59', '4', 1);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (2, 2, 2, '1994-11-21 23:06:21', '1992-12-31 13:08:32', '9', 2);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (3, 3, 3, '2002-08-25 13:43:58', '2007-12-04 22:27:04', '8', 3);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (4, 4, 4, '1998-06-27 17:48:39', '1981-10-11 16:45:28', '5', 4);
INSERT INTO `Contract` (`contract_id`, `pharmaceutical_company_id`, `pharmacy_id`, `start`, `end`, `contract_details`, `supervisor_id`) VALUES (5, 5, 5, '2010-01-10 02:27:16', '1997-07-13 12:11:45', '6', 5);



#
# TABLE STRUCTURE FOR: Prescription
#

DROP TABLE IF EXISTS `Prescription`;

CREATE TABLE `Prescription` (
  `prescription_id` int(11) NOT NULL AUTO_INCREMENT,
  `patient_ssn` int(11) NOT NULL,
  `drug_id` int(11) NOT NULL,
  `doctor_ssn` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `quantity` int(11) NOT NULL,
  `refills_auth` int(11) NOT NULL,
  `refills_filled` int(11) DEFAULT NULL,
  `dosage` int(11) NOT NULL,
  `pharmacy_id` int(11) NOT NULL,
  PRIMARY KEY (`prescription_id`),
  KEY `prescription_fk_patient_idx` (`patient_ssn`),
  KEY `prescription_fk_doctor_idx` (`doctor_ssn`),
  KEY `prescription_fk_drug_idx` (`drug_id`),
  KEY `fk_prescription_Pharmacy1_idx` (`pharmacy_id`),
  CONSTRAINT `fk_prescription_Pharmacy1` FOREIGN KEY (`pharmacy_id`) REFERENCES `Pharmacy` (`pharmacy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prescription_fk_doctor` FOREIGN KEY (`doctor_ssn`) REFERENCES `Doctor` (`doctor_ssn`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prescription_fk_drug` FOREIGN KEY (`drug_id`) REFERENCES `Drug` (`drug_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `prescription_fk_patient` FOREIGN KEY (`patient_ssn`) REFERENCES `Patient` (`patient_ssn`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (1, 0, 1, 923, '2002-02-26 12:08:32', 576, 5, 5, 340, 1);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (2, 2, 2, 2849, '1996-12-17 16:18:29', 41, 6, 0, 0, 2);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (3, 5, 3, 46167, '1995-02-15 06:40:19', 7, 7, 3, 5, 3);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (4, 6370, 4, 8076868, '1996-05-28 20:08:17', 451713, 3, 5, 63167, 4);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (5, 6582, 5, 629539399, '1980-10-24 23:45:36', 25, 3, 4, 435, 5);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (6, 12903, 6, 923, '1972-04-21 23:55:41', 57875271, 5, 2, 27250, 1);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (7, 283018, 7, 2849, '1983-02-18 13:06:20', 1, 6, 9, 61037495, 2);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (8, 330667, 8, 46167, '2003-03-22 04:14:53', 288076, 7, 8, 9, 3);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (9, 3000143, 9, 8076868, '2000-04-21 19:03:15', 96744260, 9, 3, 0, 4);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (10, 79599271, 10, 629539399, '1979-05-29 18:38:04', 44, 8, 2, 0, 5);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (11, 0, 11, 923, '1995-08-21 03:19:37', 1, 7, 1, 919, 1);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (12, 2, 12, 2849, '1997-10-23 18:24:11', 2, 4, 4, 7412023, 2);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (13, 5, 13, 46167, '1991-11-04 20:07:46', 323334, 4, 4, 4829, 3);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (14, 6370, 14, 8076868, '2002-12-06 00:08:38', 2894, 9, 3, 75827717, 4);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (15, 6582, 15, 629539399, '1978-08-06 05:50:49', 2341311, 5, 1, 68271652, 5);
INSERT INTO `prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (16, 12903, 16, 923, '2005-01-06 06:32:41', 14, 0, 1, 67397, 1);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (17, 283018, 17, 2849, '1971-08-15 15:12:13', 4, 7, 1, 0, 2);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (18, 330667, 18, 46167, '2002-12-05 13:46:05', 1, 5, 0, 23747, 3);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (19, 3000143, 19, 8076868, '2001-06-07 05:51:37', 59, 3, 1, 26, 4);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (20, 79599271, 20, 629539399, '2009-07-13 08:21:58', 0, 8, 7, 62436, 5);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (21, 0, 21, 923, '2009-11-05 06:47:17', 5, 5, 2, 1544118, 1);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (22, 2, 22, 2849, '2011-02-14 22:08:18', 118940, 4, 2, 6, 2);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (23, 5, 23, 46167, '2004-04-08 14:08:40', 720639, 9, 6, 1591, 3);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (24, 6370, 24, 8076868, '1970-07-24 09:34:10', 128, 2, 2, 57821707, 4);
INSERT INTO `Prescription` (`prescription_id`, `patient_ssn`, `drug_id`, `doctor_ssn`, `date`, `quantity`, `refills_auth`, `refills_filled`, `dosage`, `pharmacy_id`) VALUES (25, 6582, 25, 629539399, '1993-11-21 13:05:04', 1190652, 1, 6, 7160, 5);



