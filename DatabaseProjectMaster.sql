#############################################################################################
################################## Begin Forward Engineering ################################
#############################################################################################

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema TourOrganizer
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TourOrganizer
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TourOrganizer` DEFAULT CHARACTER SET utf8 ;
USE `TourOrganizer` ;

-- -----------------------------------------------------
-- Table `TourOrganizer`.`Company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Company` (
  `ID_Company` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Phone` VARCHAR(45) NULL DEFAULT NULL,
  `Password` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_Company`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Branch` (
  `ID_Branch` INT(11) NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `City` VARCHAR(45) NULL DEFAULT NULL,
  `Company_ID_Company` INT(11) NOT NULL,
  PRIMARY KEY (`ID_Branch`),
  INDEX `fk_Branch_Company1_idx` (`Company_ID_Company` ASC),
  CONSTRAINT `fk_Branch_Company1`
    FOREIGN KEY (`Company_ID_Company`)
    REFERENCES `TourOrganizer`.`Company` (`ID_Company`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Discount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Discount` (
  `ID_Discount` INT(11) NOT NULL AUTO_INCREMENT,
  `Start_Age` INT(11) NOT NULL DEFAULT '0',
  `End_Age` INT(11) NOT NULL DEFAULT '199',
  `Status` ENUM('All', 'Unemployed', 'Veteran', 'Student', 'Teacher') NOT NULL DEFAULT 'All',
  `Number_Of_People` INT(11) NOT NULL DEFAULT '1',
  `Start_Date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `End_Date` DATETIME NOT NULL DEFAULT '9999-12-31 23:59:59',
  `Branch_ID_Branch` INT(11) NULL DEFAULT NULL,
  `Amount` DECIMAL(6,2) NOT NULL,
  `1_Fixed_0_Percent` BINARY(1) NOT NULL,
  PRIMARY KEY (`ID_Discount`),
  INDEX `fk_Discount_Branch1_idx` (`Branch_ID_Branch` ASC),
  CONSTRAINT `fk_Discount_Branch1`
    FOREIGN KEY (`Branch_ID_Branch`)
    REFERENCES `TourOrganizer`.`Branch` (`ID_Branch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Person` (
  `ID_Person` INT(11) NOT NULL AUTO_INCREMENT,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Birthday` DATETIME NULL DEFAULT NULL,
  `Status` ENUM('Unemployed', 'Veteran', 'Student', 'Teacher') NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Person`))
ENGINE = InnoDB
AUTO_INCREMENT = 16
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Employee` (
  `Person_ID_Person` INT(11) NOT NULL,
  `Branch_ID_Branch` INT(11) NOT NULL,
  `Language` ENUM('English', 'French', 'Spanish', 'Italian', 'Polish', 'Danish', 'Swedish', 'Finnish') NULL DEFAULT NULL,
  PRIMARY KEY (`Person_ID_Person`),
  INDEX `fk_Employee_Branch1_idx` (`Branch_ID_Branch` ASC),
  CONSTRAINT `fk_Employee_Branch1`
    FOREIGN KEY (`Branch_ID_Branch`)
    REFERENCES `TourOrganizer`.`Branch` (`ID_Branch`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Person1`
    FOREIGN KEY (`Person_ID_Person`)
    REFERENCES `TourOrganizer`.`Person` (`ID_Person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Tour`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Tour` (
  `ID_Tour` INT(11) NOT NULL AUTO_INCREMENT,
  `Employee_Person_ID_Person` INT(11) NOT NULL,
  `Start_Time` DATETIME NULL DEFAULT NULL,
  `End_Time` DATETIME NULL DEFAULT NULL,
  `Language` ENUM('English', 'French', 'Spanish', 'Italian', 'Polish', 'Danish', 'Swedish', 'Finnish') NULL DEFAULT NULL,
  `Method` VARCHAR(45) NULL DEFAULT NULL,
  `Starting_Location` VARCHAR(90) NULL DEFAULT NULL,
  `Base_Price` DECIMAL(4,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Tour`),
  INDEX `fk_Tour_Employee1_idx` (`Employee_Person_ID_Person` ASC),
  CONSTRAINT `fk_Tour_Employee1`
    FOREIGN KEY (`Employee_Person_ID_Person`)
    REFERENCES `TourOrganizer`.`Employee` (`Person_ID_Person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Discount_Tour_List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Discount_Tour_List` (
  `Discount_ID_Discount` INT(11) NOT NULL,
  `Tour_ID_Tour` INT(11) NOT NULL,
  PRIMARY KEY (`Discount_ID_Discount`, `Tour_ID_Tour`),
  INDEX `fk_Discount_has_Tour_Tour1_idx` (`Tour_ID_Tour` ASC),
  INDEX `fk_Discount_has_Tour_Discount1_idx` (`Discount_ID_Discount` ASC),
  CONSTRAINT `fk_Discount_has_Tour_Discount1`
    FOREIGN KEY (`Discount_ID_Discount`)
    REFERENCES `TourOrganizer`.`Discount` (`ID_Discount`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discount_has_Tour_Tour1`
    FOREIGN KEY (`Tour_ID_Tour`)
    REFERENCES `TourOrganizer`.`Tour` (`ID_Tour`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Reservations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Reservations` (
  `ID_Reservations` INT(11) NOT NULL AUTO_INCREMENT,
  `Tour_ID_Tour` INT(11) NOT NULL,
  `Amount_Paid` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`ID_Reservations`),
  INDEX `fk_Reservations_Tour1_idx` (`Tour_ID_Tour` ASC),
  CONSTRAINT `fk_Reservations_Tour1`
    FOREIGN KEY (`Tour_ID_Tour`)
    REFERENCES `TourOrganizer`.`Tour` (`ID_Tour`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Reservations_Old`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Reservations_Old` (
  `ID_Reservations` INT(11) NOT NULL AUTO_INCREMENT,
  `Tour_ID_Tour` INT(11) NOT NULL,
  `Amount_Paid` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`ID_Reservations`))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Reservations_Person_List`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Reservations_Person_List` (
  `Reservations_ID_Reservations` INT(11) NOT NULL,
  `Person_ID_Person` INT(11) NOT NULL,
  PRIMARY KEY (`Reservations_ID_Reservations`, `Person_ID_Person`),
  INDEX `fk_Reservations_has_Person_Person1_idx` (`Person_ID_Person` ASC),
  INDEX `fk_Reservations_has_Person_Reservations1_idx` (`Reservations_ID_Reservations` ASC),
  CONSTRAINT `fk_Reservations_has_Person_Person1`
    FOREIGN KEY (`Person_ID_Person`)
    REFERENCES `TourOrganizer`.`Person` (`ID_Person`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reservations_has_Person_Reservations1`
    FOREIGN KEY (`Reservations_ID_Reservations`)
    REFERENCES `TourOrganizer`.`Reservations` (`ID_Reservations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Reservations_Person_List_Old`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Reservations_Person_List_Old` (
  `Reservations_ID_Reservations` INT(11) NOT NULL,
  `Person_ID_Person` INT(11) NOT NULL,
  PRIMARY KEY (`Reservations_ID_Reservations`, `Person_ID_Person`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `TourOrganizer`.`Tour_Old`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TourOrganizer`.`Tour_Old` (
  `ID_Tour` INT(11) NOT NULL AUTO_INCREMENT,
  `Employee_Person_ID_Person` INT(11) NOT NULL,
  `Start_Time` DATETIME NULL DEFAULT NULL,
  `End_Time` DATETIME NULL DEFAULT NULL,
  `Language` ENUM('English', 'French', 'Spanish', 'Italian', 'Polish', 'Danish', 'Swedish', 'Finnish') NULL DEFAULT NULL,
  `Method` VARCHAR(45) NULL DEFAULT NULL,
  `Starting_Location` VARCHAR(90) NULL DEFAULT NULL,
  `Base_Price` DECIMAL(4,2) NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Tour`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8;

USE `TourOrganizer` ;

-- -----------------------------------------------------
-- function Age
-- -----------------------------------------------------

DELIMITER $$
USE `TourOrganizer`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `Age`(vBirthday datetime) RETURNS int(11)
RETURN timestampdiff(YEAR, vBirthday, NOW())$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ArchiveTables
-- -----------------------------------------------------

DELIMITER $$
USE `TourOrganizer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ArchiveTables`()
BEGIN
	START TRANSACTION;
	
    INSERT INTO Reservations_Person_List_Old SELECT * FROM Reservations_Person_List where Reservations_ID_Reservations = (SELECT ID_Reservations from Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW());
	DELETE FROM Reservations_Person_List where Reservations_ID_Reservations = (SELECT ID_Reservations from Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW());
    
    INSERT INTO Reservations_Old SELECT * from Reservations where ID_Reservations = (select ID_Reservations FROM Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW());
    DELETE Reservations FROM Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW();
    
    INSERT INTO Tour_Old SELECT * from Tour WHERE End_Time < NOW();
	DELETE FROM Tour WHERE End_Time < NOW();
	
    COMMIT;
END$$

DELIMITER ;

-- -----------------------------------------------------
-- procedure ComputeDiscount
-- -----------------------------------------------------

DELIMITER $$
USE `TourOrganizer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ComputeDiscount`(vID_Reservations INT)
BEGIN
	DECLARE done INT DEFAULT FALSE;

	# variable declaration
	DECLARE person_id INT;
    DECLARE discount_id INT;
    DECLARE person_status VARCHAR(50);
	DECLARE finalprice INT;

	# Cursor declaration
    DECLARE curseur_persons CURSOR FOR SELECT Status FROM Reservations_Person_list NATURAL JOIN PERSON WHERE ID_PERSON = PERSON_ID_PERSON AND Reservations_ID_Reservations=  vID_Reservations;

    DECLARE curseur_discount_ID CURSOR FOR SELECT DISTINCT(DISCOUNT_ID_DISCOUNT) FROM Reservations NATURAL JOIN Tour NATURAL JOIN Discount_tour_list 
    WHERE Reservations.Tour_ID_TOUR = TOUR.ID_TOUR AND TOUR.ID_TOUR = Discount_tour_list.Tour_ID_tour AND Reservations.ID_Reservations =  vID_Reservations;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

# Set initial Final price
SET finalprice := (SELECT Amount_paid FROM Reservations WHERE ID_Reservations = vID_Reservations);

# Now lets iterate over each person
OPEN curseur_persons;
person_loop:LOOP
	FETCH curseur_persons INTO person_status;
    
    # When no more results, lets exit.
    IF done THEN
		CLOSE curseur_persons;
		LEAVE person_loop;
	END IF;
    
    # begin Block 2: prepare and execute 2nd for loop (over each discount)
    BLOCK_2: BEGIN
    
		# more variable declaration
		DECLARE BestDiscountPerson INT;
		DECLARE done2 INT DEFAULT FALSE;
		DECLARE curseur_discount_ID CURSOR FOR SELECT DISCOUNT_ID_DISCOUNT FROM Reservations NATURAL JOIN Tour NATURAL JOIN Discount_tour_list 
			WHERE Reservations.Tour_ID_TOUR = TOUR.ID_TOUR AND TOUR.ID_TOUR = Discount_tour_list.Tour_ID_tour AND Reservations.ID_Reservations =  vID_Reservations;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;
		OPEN curseur_discount_ID;
        
        # initial best discount for current person in iteration
		SET BestDiscountPerson := 0;
        
        # now lets loop over each discount
		discount_loop:LOOP
			
			FETCH curseur_discount_ID INTO discount_id;
            
            # when no more results, exit
			IF done2 THEN
				CLOSE curseur_discount_ID;
				LEAVE discount_loop;
			END IF;
            
            # Get the info we need, Status (Studen, Retired, Veteran, etc.)
			SET @v1 := (SELECT Status FROM Discount WHERE ID_Discount = discount_id);
			SET @v2 := (SELECT Amount FROM Discount WHERE ID_Discount = discount_id);

			# if Person Status matches Discount Status, we can aply this discount. or if Discount Status = 'All'
            IF(@v1 = person_status || @v1 = 'All') THEN
				
                IF (@v2 > bestDiscountPerson) THEN SET bestDiscountPerson = @v2;
				END IF;
                
			END IF;
            
		END LOOP discount_loop;
        
        # We got our bestDiscount for this person, now get new final price, and repeat for each person.
        SET finalprice := finalprice - bestDiscountPerson;
	END BLOCK_2;
	
END LOOP person_loop;

# update amount paid
UPDATE Reservations SET Amount_paid = finalprice WHERE ID_Reservations = vID_reservations;

# Lets see this new amount so the customer can pay that instead.
SELECT Amount_Paid as 'New Reservation Price' from Reservations where ID_Reservations = vID_reservations;
END$$

DELIMITER ;
USE `TourOrganizer`;

DELIMITER $$
USE `TourOrganizer`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `TourOrganizer`.`Company_Before_Insert`
BEFORE INSERT ON `TourOrganizer`.`Company`
FOR EACH ROW
BEGIN
	 IF NOT New.Email REGEXP '[@]' THEN signal sqlstate '45000' set message_text = 'Invalid email';
	 END IF;
	 IF New.Phone REGEXP '[^0-9+-]' THEN signal sqlstate '45000' set message_text = 'Invalid phone number. Ex: +45-123-456-1234';
	 END IF;
END$$

USE `TourOrganizer`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `TourOrganizer`.`Discount_Before_Insert`
BEFORE INSERT ON `TourOrganizer`.`Discount`
FOR EACH ROW
BEGIN
	 IF New.Start_Age > New.End_Age THEN signal sqlstate '45000' set message_text = 'Start age must be less than end age.';
	 END IF;
	 IF New.Start_Date > New.End_Date THEN signal sqlstate '45000' set message_text = 'Start time must be less than end time.';
	 END IF;
	IF New.Amount < 0 THEN signal sqlstate '45000' set message_text = 'Discount amount must be positive.';
	END IF;
	IF New.Number_Of_People < 0 THEN signal sqlstate '45000' set message_text = 'Number of people must be positive.';
	END IF;
END$$

USE `TourOrganizer`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `TourOrganizer`.`Tour_Before_Insert`
BEFORE INSERT ON `TourOrganizer`.`Tour`
FOR EACH ROW
BEGIN
	 IF New.Start_Time > New.End_Time THEN signal sqlstate '45000' set message_text = 'Start time is not before end time.';
	 END IF;
	 IF New.Base_Price < 0 THEN signal sqlstate '45000' set message_text = 'Tour price cannot be negative.';
	 END IF;
END$$

USE `TourOrganizer`$$
CREATE
DEFINER=`root`@`localhost`
TRIGGER `TourOrganizer`.`Reservations_Before_Insert`
BEFORE INSERT ON `TourOrganizer`.`Reservations`
FOR EACH ROW
BEGIN
	 IF New.Amount_Paid < 0  THEN signal sqlstate '45000' set message_text = 'Invalid email';
	 END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




#############################################################################################
################################## End Forward Engineering ##################################
#############################################################################################

USE TourOrganizer;

#############################################################################################
######################### Functions, Triggers, Procedurs, Events ############################
#############################################################################################


drop function if exists getDay;
drop function if exists Age;
drop event if exists UpdateOldTours;
drop trigger if exists Company_Before_Insert;
drop trigger if exists Reservations_Before_Insert;
drop trigger if exists Tour_Before_Insert;
drop trigger if exists Person_Before_Insert;
drop trigger if exists Discount_Before_Insert;
drop procedure if exists ComputeDiscount;
drop procedure if exists ArchiveTables;
drop procedure if exists getEmail;

DELIMITER //

# function used to compute age of a person. 
# Useful when calculating discount
CREATE FUNCTION Age (vBirthday datetime)
	RETURNS INT
	RETURN timestampdiff(YEAR, vBirthday, NOW()); //
 
 # getDay returns number of days before tour starts 
 # test param: 1
CREATE FUNCTION getDay (vTourID int)
	RETURNS int
	BEGIN
	DECLARE dStart_Time datetime; 
 
	SET dStart_Time = null;
	SET dStart_Time:=( SELECT Start_Time from TourOrganizer.Tour WHERE ID_Tour = vTourID);
	RETURN datediff(dStart_Time,NOW() );
END;//


# Simple input checking for Company
CREATE TRIGGER Company_Before_Insert
	 BEFORE INSERT ON Company FOR EACH ROW
	 BEGIN
	 IF NOT New.Email REGEXP '[@]' THEN signal sqlstate '45000' set message_text = 'Invalid email';
	 END IF;
	 IF New.Phone REGEXP '[^0-9+-]' THEN signal sqlstate '45000' set message_text = 'Invalid phone number. Ex: +45-123-456-1234';
	 END IF;
END; //

# Simple input checking for Reservations
CREATE TRIGGER Reservations_Before_Insert
	 BEFORE INSERT ON Reservations FOR EACH ROW
	 BEGIN
	 IF New.Amount_Paid < 0  THEN signal sqlstate '45000' set message_text = 'Invalid email';
	 END IF;
END; //

# Simple input checking for Tours
CREATE TRIGGER Tour_Before_Insert
	 BEFORE INSERT ON Tour FOR EACH ROW
	 BEGIN
	 IF New.Start_Time > New.End_Time THEN signal sqlstate '45000' set message_text = 'Start time is not before end time.';
	 END IF;
	 IF New.Base_Price < 0 THEN signal sqlstate '45000' set message_text = 'Tour price cannot be negative.';
	 END IF;
END; //

# Simple input checking for Person
CREATE TRIGGER Person_Before_Insert
	 BEFORE INSERT ON Person FOR EACH ROW
	 BEGIN
	 IF NOT New.Email REGEXP '[@]' THEN signal sqlstate '45000' set message_text = 'Invalid email';
	 END IF;
	 IF New.First_Name REGEXP '[^A-Za-z. -]' THEN signal sqlstate '45000' set message_text = 'First can only contain letters or \'-\', \' \', \'.\'';
	 END IF;
	 IF New.Phone REGEXP '[^0-9+-]' THEN signal sqlstate '45000' set message_text = 'Invalid phone number. Ex: +45-123-456-1234';
	 END IF;
	 IF New.Last_Name REGEXP '[^A-Za-z. -]' THEN signal sqlstate '45000' set message_text = 'Last can only contain letters or \'-\', \' \', \'.\'';
	 END IF;
	 IF New.Birthday > Now() THEN signal sqlstate '45000' set message_text = 'Birthday cannot be after today';
	 END IF;
END; //

# Simple input checking for Discount
CREATE TRIGGER Discount_Before_Insert
	 BEFORE INSERT ON Discount FOR EACH ROW
	 BEGIN
	 IF New.Start_Age > New.End_Age THEN signal sqlstate '45000' set message_text = 'Start age must be less than end age.';
	 END IF;
	 IF New.Start_Date > New.End_Date THEN signal sqlstate '45000' set message_text = 'Start time must be less than end time.';
	 END IF;
	IF New.Amount < 0 THEN signal sqlstate '45000' set message_text = 'Discount amount must be positive.';
	END IF;
	IF New.Number_Of_People < 0 THEN signal sqlstate '45000' set message_text = 'Number of people must be positive.';
	END IF;
END; //

# A procedure that updates the Amount_Paid feild for a reservation.
# For ID_Reservation = vID_Reservations we must perform a nested for loop.
# For each person in the reservation, we will iterate over all possible Discounts and find the best one that applies.
# Ex: Reservation = 1 Student and 1 Adult. They paid $100.
#      If there is a disocunt where student gets $10 another discount where everyone gets $5
#		Then we iterate over the two people and the two discounts in nested for loop fashion
#		And apply only one discount per person, the one which gives them most off.
#		So the new total will be $85 = $100 (original) - student discount * number of students - other discont * number of people that apply
CREATE PROCEDURE ComputeDiscount(vID_Reservations INT)
BEGIN
	DECLARE done INT DEFAULT FALSE;

	# variable declaration
	DECLARE person_id INT;
    DECLARE discount_id INT;
    DECLARE person_status VARCHAR(50);
	DECLARE finalprice INT;

	# Cursor declaration
    DECLARE curseur_persons CURSOR FOR SELECT Status FROM Reservations_Person_list NATURAL JOIN PERSON WHERE ID_PERSON = PERSON_ID_PERSON AND Reservations_ID_Reservations=  vID_Reservations;

    DECLARE curseur_discount_ID CURSOR FOR SELECT DISTINCT(DISCOUNT_ID_DISCOUNT) FROM Reservations NATURAL JOIN Tour NATURAL JOIN Discount_tour_list 
    WHERE Reservations.Tour_ID_TOUR = TOUR.ID_TOUR AND TOUR.ID_TOUR = Discount_tour_list.Tour_ID_tour AND Reservations.ID_Reservations =  vID_Reservations;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

# Set initial Final price
SET finalprice := (SELECT Amount_paid FROM Reservations WHERE ID_Reservations = vID_Reservations);

# Now lets iterate over each person
OPEN curseur_persons;
person_loop:LOOP
	FETCH curseur_persons INTO person_status;
    
    # When no more results, lets exit.
    IF done THEN
		CLOSE curseur_persons;
		LEAVE person_loop;
	END IF;
    
    # begin Block 2: prepare and execute 2nd for loop (over each discount)
    BLOCK_2: BEGIN
    
		# more variable declaration
		DECLARE BestDiscountPerson INT;
		DECLARE done2 INT DEFAULT FALSE;
		DECLARE curseur_discount_ID CURSOR FOR SELECT DISCOUNT_ID_DISCOUNT FROM Reservations NATURAL JOIN Tour NATURAL JOIN Discount_tour_list 
			WHERE Reservations.Tour_ID_TOUR = TOUR.ID_TOUR AND TOUR.ID_TOUR = Discount_tour_list.Tour_ID_tour AND Reservations.ID_Reservations =  vID_Reservations;
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 = TRUE;
		OPEN curseur_discount_ID;
        
        # initial best discount for current person in iteration
		SET BestDiscountPerson := 0;
        
        # now lets loop over each discount
		discount_loop:LOOP
			
			FETCH curseur_discount_ID INTO discount_id;
            
            # when no more results, exit
			IF done2 THEN
				CLOSE curseur_discount_ID;
				LEAVE discount_loop;
			END IF;
            
            # Get the info we need, Status (Studen, Retired, Veteran, etc.)
			SET @v1 := (SELECT Status FROM Discount WHERE ID_Discount = discount_id);
			SET @v2 := (SELECT Amount FROM Discount WHERE ID_Discount = discount_id);

			# if Person Status matches Discount Status, we can aply this discount. or if Discount Status = 'All'
            IF(@v1 = person_status || @v1 = 'All') THEN
				
                IF (@v2 > bestDiscountPerson) THEN SET bestDiscountPerson = @v2;
				END IF;
                
			END IF;
            
		END LOOP discount_loop;
        
        # We got our bestDiscount for this person, now get new final price, and repeat for each person.
        SET finalprice := finalprice - bestDiscountPerson;
	END BLOCK_2;
	
END LOOP person_loop;

# update amount paid
UPDATE Reservations SET Amount_paid = finalprice WHERE ID_Reservations = vID_reservations;

# Lets see this new amount so the customer can pay that instead.
SELECT Amount_Paid as 'New Reservation Price' from Reservations where ID_Reservations = vID_reservations;
END; //

-- getEmail returns a list of email from people in a tour
-- test parameter: 1
CREATE PROCEDURE getEmail(vTourID INT)
	BEGIN
	SELECT Email FROM RESERVATIONS NATURAL JOIN RESERVATIONS_PERSON_LIST NATURAL JOIN PERSON 
	where Reservations.Tour_ID_Tour = vTourID AND Reservations_ID_Reservations = Reservations.ID_Reservations
	and Person.ID_Person = Person_ID_Person;
END;//

# A procedure ran at midnight every night putting all old tours and corresponding reservations into _Old tables
CREATE PROCEDURE ArchiveTables()
BEGIN
	START TRANSACTION;
	
    INSERT INTO Reservations_Person_List_Old SELECT * FROM Reservations_Person_List where Reservations_ID_Reservations = (SELECT ID_Reservations from Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW());
	DELETE FROM Reservations_Person_List where Reservations_ID_Reservations = (SELECT ID_Reservations from Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW());
    
    INSERT INTO Reservations_Old SELECT * from Reservations where ID_Reservations = (select ID_Reservations FROM Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW());
    DELETE Reservations FROM Reservations natural join Tour where Tour_ID_Tour = ID_Tour and End_Time < NOW();
    
    INSERT INTO Tour_Old SELECT * from Tour WHERE End_Time < NOW();
	DELETE FROM Tour WHERE End_Time < NOW();
	
    COMMIT;
END; //

CREATE EVENT UpdateOldTours
	ON SCHEDULE EVERY 1 DAY
    STARTS '2016-04-01 00:00:00'
DO CALL ArchiveTables(); // 
SET GLOBAL event_scheduler = 1;

DELIMITER ;


#############################################################################################
########### Manipulation Section of Code (insert update delete call functions ###############
#############################################################################################

delete from Reservations_Person_List;
delete from Reservations_Person_List_Old;
delete from Reservations;
delete from Reservations_Old;
delete from Discount_Tour_List;
delete from Discount;
delete from Tour;
delete from Tour_Old;
delete from Employee;
delete from Person;
delete from Branch;
delete from Company;

# Company Insert Statements
insert into Company values (1, 'Chris\'s Tour Guides', 'chriss@gmail.com', '123-456-7890','abcdefg');
insert into Company values (2, 'Anh\'s Guided Tours', 'anh@gmail.com', '123-456-7890','password');
insert into Company values (3, 'Rahul\'s Rotating Tours', 'rh12@gmail.com', '123-456-7890','rotate');
insert into Company values (4, 'Tours by Zesty Zach', 'zesty@gmail.com', '123-456-7890','zesty');

# Branch Insert Statements
insert into Branch values (1, 'Chris\'s Paris Tours', 'Paris', 1);
insert into Branch values (2, 'Chris\'s Roaming Rome Tours', 'Rome', 1);
insert into Branch values (3, 'Anh\'s Amazing Tours', 'Paris', 2);
insert into Branch values (4, 'Anh\'s Awesome Tours', 'Munich', 2);
insert into Branch values (5, 'Rahul\'s Rotational Tours', 'Munich', 3);
insert into Branch values (6, 'Rahul\'s Romain Tours', 'Rome', 3);
insert into Branch values (7, 'Zach\'s Crazy Awesome Tours', 'Paris', 4);
insert into Branch values (8, 'Zach\'s Zesty Tours', 'Rome', 4);

# Person Insert Statements
insert into Person values (1, 'Zach', 'Vander Velden', '123-123-1234', 'zach@gmail.com', '1995-08-26', 'Student');
insert into Person values (2, 'Anh', 'From Michigan St.', '123-123-1234', 'a@gmail.com', '1994-07-04', 'Student');
insert into Person values (3, 'Rahul', 'From Illinious', '123-123-1234', 'b@gmail.com', '1992-10-11', null);
insert into Person values (4, 'Chris', 'From France', '123-123-1234', 'c@gmail.com', '1991-09-09', null);
insert into Person values (5, 'Leslie', 'Knope', '123-123-1234', 'd@gmail.com', '1981-03-21', 'Student');
insert into Person values (6, 'Ron', 'Swanson', '123-123-1234', 'e@gmail.com', '1984-06-12', null);
insert into Person values (7, 'Jason', 'Bourne', '123-123-1234', 'f@gmail.com', '1987-03-26', null);
insert into Person values (8, 'Aaron', 'Rodgers', '123-123-1234', 'g@gmail.com', '1991-02-03', null);
insert into Person values (9, 'Brett', 'Favre', '123-123-1234', 'h@gmail.com', '1999-01-02', 'Student');
insert into Person values (10, 'Tyler', 'Wilson', '123-123-1234', 'i@gmail.com', '2004-06-22', null);
insert into Person values (11, 'John', 'Smith', '123-123-1234', 'j@gmail.com', '1980-11-01', 'Student');
insert into Person values (12, 'Jake', 'Bacon', '123-123-1234', 'k@gmail.com', '1951-12-26', 'Student');
insert into Person values (13, 'Hot', 'Dog', '123-123-1234', 'l@gmail.com', '1965-08-30', null);
insert into Person values (14, 'Ronald', 'McDonold', '123-123-1234', 'm@gmail.com', '1966-05-15', 'Student');
insert into Person values (15, 'McChicken', 'Baconator', '123-123-1234', 'n@gmail.com', '1988-04-21', null);

# Employee Insert Statements
insert into Employee values (1, 7, 'English');
insert into Employee values (5, 7, 'French');
insert into Employee values (6, 8, 'Italian');
insert into Employee values (2, 3, 'French');
insert into Employee values (7, 4, 'English');
insert into Employee values (3, 5, 'English');
insert into Employee values (8, 6, 'Italian');
insert into Employee values (4, 1, 'English');
insert into Employee values (9, 2, 'Italian');

# Tour insert statements
insert into Tour values (1, 1, '2016-04-12 10:30:00', '2016-04-12 12:30:00', 'English', 'Walking', 'Central Station', 30);
insert into Tour values (2, 1, '2016-04-03 10:30:00', '2016-04-03 12:30:00', 'English', 'Walking', 'Eiffel Tower', 30);
insert into Tour values (3, 1, '2016-04-07 12:30:00', '2016-04-07 15:30:00', 'English', 'Walking', 'Court House', 40);
insert into Tour values (4, 2, '2016-04-12 10:30:00', '2016-04-12 12:30:00', 'English', 'Walking', 'Central Station', 30);
insert into Tour values (5, 2, '2016-04-14 10:30:00', '2016-04-14 12:30:00', 'English', 'Walking', 'Eiffel Tower', 30);
insert into Tour values (6, 2, '2016-04-16 12:30:00', '2016-04-16 15:30:00', 'English', 'Walking', 'Court House', 40);

# Discount insert statements
insert into Discount values (2, default, default, 'Student', default, default, default, null, 20, 1);
insert into Discount values (3, 12, 34, default, default, default, default, null, 10, 1);

# Discount_Tour_List insert statements
insert into Discount_Tour_List values (2, 1);
insert into Discount_Tour_List values (3, 1);

# Reservations insert statements
insert into Reservations values (1, 1, 90);
insert into Reservations values (2, 1, 80);
insert into Reservations values (3, 2, 120);

# Reservation_Person_List insert statements
insert into Reservations_Person_List values (1, 1);
insert into Reservations_Person_List values (1, 2);
insert into Reservations_Person_List values (1, 8);
insert into Reservations_Person_List values (2, 12);
insert into Reservations_Person_List values (3, 9);
insert into Reservations_Person_List values (3, 10);

# updates Amount_Paid for Reservation where ID = 1
# price should be updated 40. 90 - $20 discount * 2 students in reservation - $10 discount * 1 other person in reservation
CALL ComputeDiscount(1);

# reset Amount_Paid for demonstration
UPDATE Reservations SET Amount_paid = 90 WHERE ID_Reservations = 1;
UPDATE Discount SET Amount = 21 WHERE ID_Discount = 3;

# price should be updated 27. 90 - $21 discount * 3 all person in reservation. 21 is better discount than 20 for students so better discount is used
CALL ComputeDiscount(1); 

# reset Amount_Paid for demonstration
UPDATE Reservations SET Amount_paid = 90 WHERE ID_Reservations = 1;
UPDATE Discount SET Amount = 19 WHERE ID_Discount = 3;

# price should be updated 31. 90 - $20 discount * 2 students in reservation - $19 discount * 1 other person in reservation
CALL ComputeDiscount(1); 

# Get the number of days until Tour where ID_Tour = 1
SELECT getDay(1); # should return 5

# Get a list of Emails for Tour where ID_Tour = 1
# used to remind them of tour and ask for feedback afterwards
CALL getEmail(1); # should return a list of 4 emails

# Gets all the people for a particular Reservation (1), Oldest to Youngest
select CONCAT(FIRST_NAME, ' ', LAST_NAME), Age(Birthday) as Age from Person NATURAL JOIN Reservations_Person_List WHERE ID_PERSON = PERSON_ID_PERSON AND Reservations_ID_Reservations = 1 ORDER BY Age DESC;


# Gets all the people for a particular Tour (1), Oldest to Youngest
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME), Age(Birthday) as Age FROM Reservations NATURAL JOIN PERSON NATURAL JOIN Reservations_Person_List WHERE Tour_ID_Tour = 1 AND ID_PERSON = PERSON_ID_PERSON AND Reservations_ID_Reservations = ID_Reservations ORDER BY Age DESC;

# Finds all people for particular Tour, grouping them as Reservations which paid more than $100
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME), Age(Birthday) as Age, Amount_Paid FROM Reservations NATURAL JOIN PERSON NATURAL JOIN Reservations_Person_List WHERE Tour_ID_Tour = 1 AND ID_PERSON = PERSON_ID_PERSON AND Reservations_ID_Reservations = ID_Reservations GROUP BY ID_Reservations HAVING Amount_Paid >= 50 ORDER BY Age DESC;

#select * from Company;
#select * from Branch;
#select *, Age(Birthday) from Person;
#select * from Employee;
#select * from Tour;
#select * from Reservations;
#select * from Reservations_Person_List;
#select * from Discount;
#select * from Discount_Tour_List;
