--------------------------------------------------------------

-- Database Create Script - tested version 1.0 27 February 2014

-- Hand-tuned by Ann Lawlor for consistency with Oracle and clarity of attribute names
-- Entity Model: Queen Ann Library 2014 ERD

--------------------------------------------------------------


-- We DROP any previous version of the tables before creating new ones.
-- To make that easier, we first DROP the foreign key dependencies in any previous
-- versions of the tables that exist.
-- This is necessary, since foreign key dependencies 
-- can prevent a table from being dropped.
-- The process may generate errors but that is not usually a problem

ALTER TABLE Book DROP CONSTRAINT fk1_Book_to_Genre;
ALTER TABLE Copy DROP CONSTRAINT fk1_Copy_to_Book;
ALTER TABLE Loan DROP CONSTRAINT fk1_Loan_to_Copy;
ALTER TABLE Loan DROP CONSTRAINT fk2_Loan_to_Borrower;
ALTER TABLE Reservation DROP CONSTRAINT fk1_Reservation_to_Book;
ALTER TABLE Fine DROP CONSTRAINT fk1_Fine_to_Borrower;
ALTER TABLE Fine DROP CONSTRAINT fk2_Fine_to_Loan;
ALTER TABLE Payment DROP CONSTRAINT fk1_Payment_to_Borrower;
ALTER TABLE Payment DROP CONSTRAINT fk2_Payment_to_Fine;
ALTER TABLE Borrower DROP CONSTRAINT fk1_Borrower_to_Borrower_type;
ALTER TABLE Reservation DROP CONSTRAINT fk2_Reservation_to_Borrower;

-- Now DROP the tables themselves

DROP TABLE Borrower;
DROP TABLE Loan;
DROP TABLE Reservation;
DROP TABLE Copy;
DROP TABLE Book;
DROP TABLE Fine;
DROP TABLE Payment;
DROP TABLE Borrower_type;
DROP TABLE Genre; 

--------------------------------------------------------------

-- Table Creation --

-- Now create new tables using the CREATE TABLE command
-- For each table, first the attributes are defined, including
-- primary and foreign keys.
-- Then the primary key is specified using the CONSTRAINT parameter.
-- Foreign keys that represent a one-to-one relationship
-- are also constrained to be unique, with the UNIQUE parameter.

-- Create a Database table to represent the "Borrower" entity.

CREATE TABLE Borrower(
	bor_id	CHARACTER(9) NOT NULL, -PK
	fk1_bor_type_id	CHARACTER(4) NOT NULL,
	bor_firstname	CHARACTER(20) NOT NULL,
	bor_surname	CHARACTER(20) NOT NULL,
	bor_address_1	CHARACTER(40),
	bor_address_2	CHARACTER(40),
	bor_address_3	CHARACTER(40),
	bor_tel	CHARACTER(11),
	bor_email	CHARACTER(40),
	bor_status	CHARACTER(10),
	-- Specify the PRIMARY KEY constraint for table "Borrower".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Borrower PRIMARY KEY (bor_id)
);

-- Create a Database table to represent the "Loan" entity.
CREATE TABLE Loan(
	loan_id	CHARACTER(8) NOT NULL,
	loan_issue_date	DATE NOT NULL,
	loan_due_date	DATE NOT NULL,
	loan_return_date	DATE,
	fk1_cop_barcode	CHARACTER(12) NOT NULL,
	fk2_bor_id	CHARACTER(9) NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "Loan".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Loan PRIMARY KEY (loan_id)
);

-- Create a Database table to represent the "Reservation" entity.
CREATE TABLE Reservation(
	res_id	CHARACTER(8) NOT NULL,
	res_date	DATE NOT NULL,
	res_cleared_date	DATE,
	fk2_bor_id	CHARACTER(9) NOT NULL,
	fk1_isbn	CHARACTER(13) NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "Reservation".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Reservation PRIMARY KEY (res_id)
);

-- Create a Database table to represent the "Copy" entity.
CREATE TABLE Copy(
	cop_barcode	CHARACTER(12) NOT NULL,
	cop_loan_type	CHARACTER(12),
	cop_status	CHARACTER(10),
	cop_condition	CHARACTER(40),
	fk1_isbn	CHARACTER(13) NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "Copy".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Copy PRIMARY KEY (cop_barcode)
);

CREATE TABLE Genre(
	genre_code	CHARACTER(4) NOT NULL,
	genre_descript CHARACTER(20),
	-- Specify the PRIMARY KEY constraint for table " Genre".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Genre PRIMARY KEY (genre_code)
);

-- Create a Database table to represent the "Book" entity.
CREATE TABLE Book(
	isbn	CHARACTER(13) NOT NULL, -PK
	bk_author	CHARACTER(40) NOT NULL,
	bk_title	CHARACTER(40) NOT NULL,
	bk_publisher	CHARACTER(40),
	bk_pub_yr	NUMERIC(4) NOT NULL,
	bk_shelf_no	CHARACTER(8) NOT NULL,
	bk_edition_no	INTEGER,
	fk1_genre_code	CHARACTER(4) NOT NULL,
	-- Specify the PRIMARY KEY constraint for table "Book".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Book PRIMARY KEY (isbn)
);

-- Create a Database table to represent the "Fine" entity.
CREATE TABLE Fine(
	fine_id	CHARACTER(8) NOT NULL,
	fine_date	DATE NOT NULL,
	fine_amount	NUMERIC(3,2) NOT NULL,
	fine_status	CHARACTER(4) NOT NULL,
	fk1_bor_id	CHARACTER(9) NOT NULL,
	fk2_loan_id	CHARACTER(8) NOT NULL,
	-- Specify FK as unique to maintain 1:1 relationship
	UNIQUE(fk2_loan_id),
	-- Specify the PRIMARY KEY constraint for table "Fine".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Fine PRIMARY KEY (fine_id)
);

-- Create a Database table to represent the "Payment" entity.
CREATE TABLE Payment(
	pmt_id	CHARACTER(8) NOT NULL,
	pmt_date	DATE NOT NULL,
	pmt_amount	NUMERIC(3,2) NOT NULL,
	fk1_bor_id	CHARACTER(9) NOT NULL,
	fk2_fine_id	CHARACTER(8) NOT NULL,
	-- Specify FK as unique to maintain 1:1 relationship
	UNIQUE(fk2_fine_id),
	-- Specify the PRIMARY KEY constraint for table "Payment".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Payment PRIMARY KEY (pmt_id)
);

-- Create a Database table to represent the "Borrower_type" entity.
CREATE TABLE Borrower_type(
	bor_type_id	CHARACTER(4) NOT NULL,
	bor_type_name	CHARACTER(25),
	AV_max_loans	INTEGER,
	normal_max_loans	INTEGER,
	normal_loan_period	INTEGER,
	-- Specify the PRIMARY KEY constraint for table "Borrower_type".
	-- This indicates which attribute(s) uniquely identify each row of data.
	CONSTRAINT	pk_Borrower_type PRIMARY KEY (bor_type_id)
);

--------------------------------------------------------------

-- Alter Tables to add fk constraints --

-- Now the ALTER TABLE command is used to define additional
-- constraints.  These associate the values of foreign keys 
-- with the values of primary keys in the related tables.  

-- Alter table to add new constraints required to implement the "belongs to" relationship

-- This constraint ensures that the foreign key of table "Book"
-- correctly references the primary key of table "Genre"

ALTER TABLE Book ADD CONSTRAINT fk1_Book_to_Genre FOREIGN KEY(fk1_genre_code) REFERENCES Genre(genre_code) ;

-- Alter table to add new constraints required to implement the "is_of_a" relationship

-- This constraint ensures that the foreign key of table "Copy"
-- correctly references the primary key of table "Book"

ALTER TABLE Copy ADD CONSTRAINT fk1_Copy_to_Book FOREIGN KEY(fk1_isbn) REFERENCES Book(isbn) ;

-- Alter table to add new constraints required to implement the "is_for_a" relationship

-- This constraint ensures that the foreign key of table "Loan"
-- correctly references the primary key of table "Copy"

ALTER TABLE Loan ADD CONSTRAINT fk1_Loan_to_Copy FOREIGN KEY(fk1_cop_barcode) REFERENCES Copy(cop_barcode) ;

-- Alter table to add new constraints required to implement the "has" relationship

-- This constraint ensures that the foreign key of table "Loan"
-- correctly references the primary key of table "Borrower"

ALTER TABLE Loan ADD CONSTRAINT fk2_Loan_to_Borrower FOREIGN KEY(fk2_bor_id) REFERENCES Borrower(bor_id) ;

-- Alter table to add new constraints required to implement the "is_for" relationship

-- This constraint ensures that the foreign key of table "Reservation"
-- correctly references the primary key of table "Book"

ALTER TABLE Reservation ADD CONSTRAINT fk1_Reservation_to_Book FOREIGN KEY(fk1_isbn) REFERENCES Book(isbn) ;

-- Alter table to add new constraints required to implement the "incurs" relationship

-- This constraint ensures that the foreign key of table "Fine"
-- correctly references the primary key of table "Borrower"

ALTER TABLE Fine ADD CONSTRAINT fk1_Fine_to_Borrower FOREIGN KEY(fk1_bor_id) REFERENCES Borrower(bor_id) ;

-- Alter table to add new constraints required to implement the "relates_to" relationship

-- This constraint ensures that the foreign key of table "Fine"
-- correctly references the primary key of table "Loan"

ALTER TABLE Fine ADD CONSTRAINT fk2_Fine_to_Loan FOREIGN KEY(fk2_loan_id) REFERENCES Loan(loan_id) ;

-- Alter table to add new constraints required to implement the "pays" relationship

-- This constraint ensures that the foreign key of table "Payment"
-- correctly references the primary key of table "Borrower"

ALTER TABLE Payment ADD CONSTRAINT fk1_Payment_to_Borrower FOREIGN KEY(fk1_bor_id) REFERENCES Borrower(bor_id) ;

-- Alter table to add new constraints required to implement the "relates_to_a" relationship

-- This constraint ensures that the foreign key of table "Payment"
-- correctly references the primary key of table "Fine"

ALTER TABLE Payment ADD CONSTRAINT fk2_Payment_to_Fine FOREIGN KEY(fk2_fine_id) REFERENCES Fine(fine_id) ;

-- Alter table to add new constraints required to implement the "applies_to" relationship

-- This constraint ensures that the foreign key of table "Borrower"
-- correctly references the primary key of table "Borrower_type"

ALTER TABLE Borrower ADD CONSTRAINT fk1_Borrower_to_Borrower_type FOREIGN KEY(fk1_bor_type_id) REFERENCES Borrower_type(bor_type_id) ;

-- Alter table to add new constraints required to implement the "makes_a" relationship

-- This constraint ensures that the foreign key of table "Reservation"
-- correctly references the primary key of table "Borrower"

ALTER TABLE Reservation ADD CONSTRAINT fk2_Reservation_to_Borrower FOREIGN KEY(fk2_bor_id) REFERENCES Borrower(bor_id) ;

--------------------------------------------------------------

-- End of DDL file auto-generation

--------------------------------------------------------------