---------------TEAM 9---------------
--Kushagra Sisodiya
--Shantanu Tyagi
--Jazib Javaid 
--Nadia Farsaeivahid 
--Ilia chiniforooshan esfahani 


------------------------------------

------------------------------------------CREATE DATABASE------------------------------------------

CREATE DATABASE Team9_Database;
USE Team9_Database;

------------------------------------------CREATE SCHEMA------------------------------------------

CREATE SCHEMA dbo;
---------------------------------------------------CREATE TABLE QUERIES-----------------------------------------------------
--DROP TABLE Hospital
CREATE TABLE dbo.Hospital
(
	HospitalID INT IDENTITY(1, 1) NOT NULL,
	HospitalName VARCHAR(255) NOT NULL,
	Address VARCHAR(255) NOT NULL,
	Zipcode VARCHAR(20) NOT NULL,
	ContactNo VARCHAR(20),
	Email VARCHAR(50),
	City VARCHAR(50) NOT NULL,
	State VARCHAR(50) NOT NULL,
	CONSTRAINT PK_HospitalID PRIMARY KEY(HospitalID)
)

--DROP TABLE Department
CREATE TABLE dbo.Department
(
	DepartmentID INT IDENTITY(1, 1) NOT NULL,
	DepartmentName VARCHAR(255),
	DepartmentHead VARCHAR(255),
	CONSTRAINT PK_DepartmentID PRIMARY KEY(DepartmentID)
)

--DROP TABLE HospitalDepartment
CREATE TABLE dbo.HospitalDepartment
(
	HospitalID INT NOT NULL,
	DepartmentID INT NOT NULL,
	HosDepID INT IDENTITY(1, 1) NOT NULL,
	CONSTRAINT PK_HosDepID PRIMARY KEY(HosDepID),
	CONSTRAINT FK_HospitalID FOREIGN KEY (HospitalID) REFERENCES dbo.Hospital(HospitalID),
	CONSTRAINT FK_DepartmentID FOREIGN KEY (DepartmentID) REFERENCES dbo.Department(DepartmentID)
)

--DROP TABLE Doctor
CREATE TABLE dbo.Doctor
(
	DoctorID INT IDENTITY(1, 1) NOT NULL,
	HosDepID INT NOT NULL,
	DoctorFName VARCHAR(255) NOT NULL,
	DoctorLName VARCHAR(255) NOT NULL,
	Gender char(1) NULL,
	ContactNo varchar(10) NULL,
	CONSTRAINT PK_DoctorID PRIMARY KEY(DoctorID),
	CONSTRAINT FK_HosDepID FOREIGN KEY (HosDepID) REFERENCES dbo.HospitalDepartment(HosDepID)
)

--DROP TABLE Nurse
CREATE TABLE dbo.Nurse
(
	NurseID INT IDENTITY(1, 1) NOT NULL,
	HosDepID INT NOT NULL,
	NurseFName VARCHAR(255) NOT NULL,
	NurseLName VARCHAR(255) NOT NULL,
	Gender char(1) NULL,
	ContactNo VARCHAR(10) NULL,
	CONSTRAINT PK_NurseID PRIMARY KEY(NurseID),
	CONSTRAINT FK_HosDepID_1 FOREIGN KEY (HosDepID) REFERENCES dbo.HospitalDepartment(HosDepID)
)

--DROP TABLE InsurancePlan
CREATE TABLE dbo.InsurancePlan
(
	InsuranceID int IDENTITY(1,1) NOT NULL,
	PlanCode int NOT NULL,
	CompanyName varchar(50) NOT NULL,
	ContactNo VARCHAR(10) NOT NULL,
	Email varchar(50) NOT NULL,
	InsuranceDate date NOT NULL,
	CONSTRAINT PK__Insuranc__74231BC4D8BF75DA PRIMARY KEY (InsuranceID)
);

--DROP TABLE Patient
CREATE TABLE dbo.Patient
(
	PatientID int IDENTITY(1,1) NOT NULL,
	InsuranceID int NULL,
	PatientFName varchar(30) NOT NULL,
	PatientLName varchar(30) NOT NULL,
	DateOfBirth date NOT NULL,
	ContactNo varbinary(255) NOT NULL,
	Email varbinary(255) NOT NULL,
	Gender char(1) COLLATE NOT NULL
	CONSTRAINT PK__Patient__970EC346377BB6BE PRIMARY KEY
(PatientID),
	CONSTRAINT FK__Patient__Insuran__49C3F6B7 FOREIGN KEY
(InsuranceID) REFERENCES Team9_Database.dbo.InsurancePlan
(InsuranceID)
);

--DROP TABLE Address
CREATE TABLE Team9_Database.dbo.Address
(
	PatientID int NOT NULL,
	StreetAddress varchar(50) NOT NULL,
	City varchar(30) NOT NULL,
	States varchar(30) NOT NULL,
	ZipCode varchar(10) NOT NULL,
	CONSTRAINT PK__Address__970EC346A4DE3DDE PRIMARY KEY (PatientID),
	CONSTRAINT FK__Address__Patient__4CA06362 FOREIGN KEY (PatientID) REFERENCES Team9_Database.dbo.Patient(PatientID)
);

--DROP TABLE MedicalRecord
CREATE TABLE dbo.MedicalRecord
(
	RecordID int IDENTITY(1,1) NOT NULL,
	PatientID int NOT NULL,
	DoctorID int NOT NULL,
	Diagnosis varchar(100) NULL,
	Prescription varchar(100) NULL,
	AppointmentCost decimal(10,2) NULL,
	RecordDate date NULL,
	CONSTRAINT PK__MedicalR__FBDF78C92F54CC44 PRIMARY KEY (RecordID),
	CONSTRAINT FK__MedicalRe__Docto__0A9D95DB FOREIGN KEY (DoctorID) REFERENCES Team9_Database.dbo.Doctor(DoctorID),
	CONSTRAINT FK__MedicalRe__Patie__09A971A2 FOREIGN KEY (PatientID) REFERENCES Team9_Database.dbo.Patient(PatientID)
);

--DROP TABLE Tests
CREATE TABLE dbo.Tests
(
	TestID int IDENTITY(1,1) NOT NULL,
	TestName varchar(100) NULL,
	Description varchar(100) NULL,
	Cost decimal(10,2) NULL,
	CONSTRAINT PK__Tests__8CC33100E45D05B8 PRIMARY KEY (TestID)
);

--DROP TABLE Testing
CREATE TABLE dbo.Testing
(
	RecordID int NOT NULL,
	TestID int NOT NULL,
	[Result] varchar(100) NULL,
	CONSTRAINT PKTESTING PRIMARY KEY (RecordID,TestID),
	CONSTRAINT FK__Testing__RecordI__1332DBDC FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID),
	CONSTRAINT FK__Testing__TestID__14270015 FOREIGN KEY (TestID) REFERENCES Team9_Database.dbo.Tests(TestID)
);

--DROP TABLE Admit
CREATE TABLE dbo.Admit
(
	AdmitID int IDENTITY(1,1) NOT NULL,
	RecordID int NOT NULL,
	NurseID int NOT NULL,
	AdmitDate date NOT NULL,
	DischargeDate date NULL,
	CONSTRAINT PK__Admit__93986932A0656408 PRIMARY KEY (admitID),
	CONSTRAINT FK__Admit__NurseID__5EBF139D FOREIGN KEY (NurseID) REFERENCES Team9_Database.dbo.Nurse(NurseID),
	CONSTRAINT FK__Admit__RecordID__5DCAEF64 FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID)
);

--DROP TABLE Billing
CREATE TABLE dbo.Billing
(
	BillingID int IDENTITY(1,1) NOT NULL,
	RecordID int NOT NULL,
	BillingDate date NOT NULL,
	RoomCost float NULL,
	OtherCharges float NULL,
	PaymentMode varchar(30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT PK_Billing__F1656D13C9935A99 PRIMARY KEY (BillingID),
	CONSTRAINT FK__Billing__RecordI__619B8048 FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID)
);

--DROP TABLE VitalSign
CREATE TABLE dbo.VitalSign
(
	RecordID int NOT NULL,
	Temperature float NOT NULL,
	RespirationRate float NOT NULL,
	PulseRate float NOT NULL,
	BloodPressure float NOT NULL,
	Weight float NOT NULL,
	Height float NOT NULL,
	CONSTRAINT PK_RecordID PRIMARY KEY (RecordID),
	CONSTRAINT FK_RecordID FOREIGN KEY (RecordID) REFERENCES Team9_Database.dbo.MedicalRecord(RecordID)
);

--DROP TABLE Medicine
CREATE TABLE dbo.Medicine
(
	MedID INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[Name] VARCHAR(100),
	Brand VARCHAR(100),
	[Description] VARCHAR(100),
	Cost DECIMAL(10, 2)
);

--DROP TABLE Medication
CREATE TABLE dbo.Medication
(
	RecordID INT NOT NULL
		REFERENCES dbo.MedicalRecord(RecordID),
	MedID INT NOT NULL
		REFERENCES dbo.Medicine(MedID)
		CONSTRAINT PKMEDICATION PRIMARY KEY CLUSTERED
			(RecordID, MedID)
);

----------------------------------------------CREATE FUNCTION FOR TABLE LEVEL CHECK-------------------------------------------------------

--Function to validate zipcode while data insertion
--DROP FUNCION IsValidZipcode
CREATE FUNCTION IsValidZipcode (@Zipcode VARCHAR(10))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@Zipcode LIKE '[0-9]%') -- Starts with a digit
    BEGIN
		IF (LEN(@Zipcode) = 5) -- Must be 10 digits after removing special characters
        BEGIN
			SET @IsValid = 1
		END
	END

	RETURN @IsValid
END


--Function to validate email while data insertion
--DROP FUNCION IsValidEmail
CREATE FUNCTION IsValidEmail (@email VARCHAR(255))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0
	IF CHARINDEX('@', @email) > 0
		AND RIGHT(@email, 4) = '.com'
       BEGIN
		SET @IsValid = 1
	END
	RETURN @IsValid
END;

--Function to validate contactno while data insertion
--DROP FUNCION IsValidContactNo
CREATE FUNCTION IsValidContactNo (@ContactNo VARCHAR(20))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@ContactNo LIKE '[0-9]%') -- Starts with a digit
    BEGIN
		IF (LEN(@ContactNo) = 10) -- Must be 10 digits after removing special characters
        BEGIN
			IF(ISNUMERIC(@ContactNo) = 1) -- Must contain only numeric digits
            BEGIN
				SET @IsValid = 1
			END
		END
	END

	RETURN @IsValid
END

--Function to validate age while data insertion
--DROP FUNCION IsValidAge
CREATE FUNCTION IsValidAge (@Age INT)
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@Age > 0 AND @Age <= 100) -- Must be 10 digits after removing special characters
        BEGIN
		SET @IsValid = 1
	END

	RETURN @IsValid
END

--Function to validate gender while data insertion
--DROP FUNCION IsValidGender
CREATE FUNCTION dbo.IsValidGender (@Gender CHAR(1))
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@Gender = 'M' OR @Gender = 'F')
    BEGIN
		SET @IsValid = 1
	END

	RETURN @IsValid
END

--Function to validate discharge data greater or equal to admit date while data insertion
--DROP FUNCION IsValidDischargeDate
CREATE FUNCTION IsValidDischargeDate (@admitDate date, @dischargeDate date)
RETURNS BIT
AS
BEGIN
	DECLARE @IsValid BIT = 0

	IF (@dischargeDate IS NULL OR @dischargeDate >= admitDate) -- Either admitted or discharge greater
    BEGIN
		SET @IsValid = 1
	END

	RETURN @IsValid
END

-----------------------------------------------------CREATE FUNCTION FOR COMPUTING COLUMNS---------------------------------------------
--Function to calculate age and populate age column in patient table
--DROP FUNCION CalculateAge
CREATE FUNCTION CalculateAge (@dob DATE)
RETURNS INT
AS
BEGIN
	DECLARE @age INT

	SELECT @age = DATEDIFF(YEAR, @dob, GETDATE()) - CASE WHEN (MONTH(@dob) > MONTH(GETDATE())) OR (MONTH(@dob) = MONTH(GETDATE()) AND DAY(@dob) > DAY(GETDATE())) THEN 1 ELSE 0 END

	RETURN @age
END

--Function to calculate total bill amount while data insertion in Billing table
--DROP FUNCION CalculateBillingTotal
CREATE FUNCTION dbo.CalculateBillingTotal(@RecordID INT, @RoomCost DECIMAL(10, 2), @OtherCharges DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @AppointmentCost DECIMAL(10, 2), @TestCost DECIMAL(10, 2), @MedicineCost DECIMAL(10, 2)

	SELECT @AppointmentCost = COALESCE(AppointmentCost, 0)
	FROM dbo.MedicalRecord
	WHERE RecordID = @RecordID

	SELECT @TestCost = COALESCE(SUM(Cost), 0)
	FROM dbo.Tests
		INNER JOIN dbo.Testing ON dbo.Tests.TestID = dbo.Testing.TestID
	WHERE dbo.Testing.RecordID = @RecordID

	SELECT @MedicineCost = COALESCE(SUM(Cost), 0)
	FROM dbo.Medicine
		INNER JOIN dbo.Medication ON dbo.Medicine.MedID = dbo.Medication.MedID
	WHERE dbo.Medication.RecordID = @RecordID

	RETURN @AppointmentCost + @TestCost + @MedicineCost + @RoomCost + @OtherCharges
END

----------------------------------------------ALTER TABLE QUERIES---------------------------------------------------------
--Adding constraint to HOSPITAL table based on IsValidZipcode function--
ALTER TABLE Hospital
ADD CONSTRAINT chkIsValidZipCode
CHECK (dbo.IsValidZipcode(Zipcode) = 1);

--Adding constraint to HOSPITAL table based on IsValidContactNo function--
ALTER TABLE Hospital
ADD CONSTRAINT chkIsValidContactNoHosp
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to HOSPITAL table based on IsValidEmail function--
ALTER TABLE Hospital
ADD CONSTRAINT chkIsValidEmail
CHECK (dbo.IsValidEmail(Email) = 1);

--Adding constraint to DOCTOR table based on IsValidGender function--
ALTER TABLE Doctor
ADD CONSTRAINT chkIsValidGender
CHECK (dbo.IsValidGender(Gender) = 1);

--Adding constraint to DOCTOR table based on IsValidContactNo function--
ALTER TABLE Doctor
ADD CONSTRAINT chkIsValidContactNoDoc
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to NURSE table based on IsValidGender function--
ALTER TABLE Nurse
ADD CONSTRAINT chkIsValidGenderNurse
CHECK (dbo.IsValidGender(Gender) = 1);

--Adding constraint to NURSE table based on IsValidContactNo function--
ALTER TABLE Nurse
ADD CONSTRAINT chkIsValidContactNoNurse
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to INSURANCEPLAN table based on IsValidContactNo function--
ALTER TABLE InsurancePlan
ADD CONSTRAINT chkIsValidContactNoInsurance
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to PATIENT table based on IsValidZipcode function--
ALTER TABLE Patient
ADD CONSTRAINT chkIsValidGenderPatient
CHECK (dbo.IsValidGender(Gender) = 1);

--Adding constraint to PATIENT table based on IsValidContactNo function--
ALTER TABLE Patient
ADD CONSTRAINT chkIsValidContactNoPatient
CHECK (dbo.IsValidContactNo(ContactNo) = 1);

--Adding constraint to PATIENT table based on IsValidEmail function--
ALTER TABLE Patient
ADD CONSTRAINT chkIsValidEmailPatient
CHECK (dbo.IsValidEmail(Email) = 1);

--Adding constraint to ADDRESS table based on IsValidZipcode function--
ALTER TABLE Address
ADD CONSTRAINT chkIsValidZipCodeAddress
CHECK (dbo.IsValidZipcode(Zipcode) = 1);

--Adding constraint to ADMIT table based on IsValidDischargeDate function--
ALTER TABLE Team9_Database.dbo.Admit
ADD CONSTRAINT CK_DischargeDateGreaterOrEqual 
CHECK (dbo.IsValidDischargeDate(AdmitDate, DischargeDate) = 1);

--Adding constraint to PATIENT table to create and populate age column based on CalculateAge function--
ALTER TABLE Patient
ADD Age AS dbo.CalculateAge(DATEOFBIRTH);

--Adding constraint to billing table to create and populate Total column based on CalculateBillingTotal function
ALTER TABLE Billing
ADD Total AS dbo.CalculateBillingTotal(RecordID, RoomCost, OtherCharges);


-------------------------------------------------------ENCRYPTION KEY-------------------------------------------------------------------

--CREATING SYMMETRIC KEY
CREATE SYMMETRIC KEY NewKey
WITH ALGORITHM = AES_256
ENCRYPTION BY PASSWORD = 'ThisPassword';
--OPENING SYMMETRIC KEY
OPEN SYMMETRIC KEY NewKey
DECRYPTION BY PASSWORD = 'ThisPassword';
--CLOSING SYMMETRIC KEY
CLOSE SYMMETRIC KEY NewKey

-------------------------------------------------------CREATE TRIGGER QUERIES----------------------------------------------------------- 

--Trigger to encrypt sensitive data in the patient table
--DROP TRIGGER EncryptPatientInfoTrigger
CREATE TRIGGER EncryptPatientInfoTrigger
ON Patient
AFTER INSERT
AS
BEGIN
	OPEN SYMMETRIC KEY NewKey
      DECRYPTION BY PASSWORD = 'ThisPassword';
	DECLARE @Email VARBINARY(255), @ContactNo VARBINARY(255)
	SELECT @Email = Email, @ContactNo = ContactNo
	FROM inserted

	SET @Email = EncryptByKey(Key_GUID('NewKey'),@Email)
	SET @ContactNo = EncryptByKey(Key_GUID('NewKey'),@ContactNo)

	UPDATE Patient
    SET Email = @Email, ContactNo = @ContactNo
    WHERE PatientID = (SELECT PatientID
	FROM inserted)
	CLOSE SYMMETRIC KEY NewKey;
END

-------------------------------------------------------CREATE STORED PROCEDURE QUERIES---------------------------------------------------

--Procedure to decrypt sensitive patient data 
--drop procedure PatientDetails

--EXEC PatientDetails 
CREATE PROCEDURE PatientDetails
AS
BEGIN
	OPEN SYMMETRIC KEY NewKey
      DECRYPTION BY PASSWORD = 'ThisPassword';

	SELECT p.PatientID,
		p.PatientFName,
		p.PatientLName,
		p.DateOfBirth,
		p.Gender,
		DECRYPTBYKEY(p.ContactNo) AS ContactNo,
		DECRYPTBYKEY(p.Email) AS Email,
		a.StreetAddress,
		a.City,
		a.States,
		a.ZipCode,
		p.InsuranceID,
		ip.PlanCode,
		ip.CompanyName
	FROM Patient p
		INNER JOIN InsurancePlan ip ON p.InsuranceID = ip.InsuranceID
		LEFT JOIN Address a ON p.PatientID = a.PatientID;

	CLOSE SYMMETRIC KEY NewKey;
END;

--------------------------------------------------------CREATE VIEWS-------------------------------------------------------------------
-- View for displaying patient vitals
-- DROP VIEW vw_PatientVitals	
CREATE VIEW vw_PatientVitals
AS
	SELECT CONCAT(p.PatientFName, ' ', p.PatientLName)[Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(SELECT d.DoctorFName + ' ' + d.DoctorLName
		FROM Doctor d
		WHERE d.DoctorID = mr.DoctorID) [Doctor],
		mr.Diagnosis,
		mr.Prescription,
		mr.RecordDate,
		vs.Temperature,
		vs.RespirationRate,
		vs.PulseRate,
		vs.BloodPressure,
		vs.Weight,
		vs.Height
	FROM Patient p
		INNER JOIN MedicalRecord mr
		ON p.PatientID = mr.PatientID
		INNER JOIN VitalSign vs
		ON mr.RecordID = vs.RecordID

-- View for displaying admitted patients
-- DROP VIEW vw_PatientAdmitted	
CREATE VIEW vw_PatientAdmitted
AS
	SELECT CONCAT(p.PatientFName, ' ', p.PatientLName)[Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		mr.Diagnosis,
		mr.Prescription,
		mr.RecordDate,
		(SELECT n.NurseFName + ' ' + n.NurseLName
		FROM Nurse n
		WHERE n.NurseID = a.NurseID) [Nurse Assigned],
		a.AdmitDate,
		a.DischargeDate
	FROM Patient p
		INNER JOIN MedicalRecord mr
		ON p.PatientID = mr.PatientID
		INNER JOIN Admit a
		ON mr.RecordID = a.RecordID

-- View for displaying patient test records
-- DROP VIEW vw_PatientTestRecords	
CREATE VIEW vw_PatientTestRecords
AS
	SELECT p.PatientID,
		CONCAT(p.PatientFName,' ', p.PatientLName) [Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(Select CONCAT(d.DoctorFName,' ', d.DoctorLName)
		from Team9_Database.dbo.Doctor d
		where d.DoctorID = m.DoctorID) [Doctor],
		m.Diagnosis,
		m.Prescription,
		m.RecordDate,
		t.TestID,
		t.TestName,
		t.Description,
		t.Cost,
		te.[Result]
	FROM Team9_Database.dbo.Patient p
		INNER JOIN Team9_Database.dbo.MedicalRecord m ON p.PatientID = m.PatientID
		LEFT JOIN Team9_Database.dbo.Testing te ON m.RecordID = te.RecordID
		LEFT JOIN Team9_Database.dbo.Tests t ON te.TestID = t.TestID;

-- View for displaying patient bills
-- DROP VIEW vw_PatientBills
CREATE VIEW vw_PatientBills
AS
	WITH
		TestData
		AS
		(
			SELECT t.TestName, t.Cost, mr.RecordID
			FROM Tests t
				INNER JOIN Testing te
				ON t.TestID = te.TestID
				INNER JOIN MedicalRecord mr
				ON te.RecordID = mr.RecordID
		),
		MedData
		AS
		(
			SELECT m.Name, m.Cost, mr.RecordID
			FROM Medicine m
				INNER JOIN Medication md
				ON m.MedID = md.MedID
				INNER JOIN MedicalRecord mr
				ON md.RecordID = mr.RecordID
		)
	SELECT b.BillingID,
		p.PatientID,
		CONCAT(p.PatientFName,' ', p.PatientLName) [Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(Select CONCAT(d.DoctorFName,' ', d.DoctorLName)
		from Team9_Database.dbo.Doctor d
		where d.DoctorID = m.DoctorID) [Doctor],
		m.RecordDate,
		m.AppointmentCost,
		STUFF((SELECT TOP 3
			', ' + tn.TestName + ' ($' + CAST(tn.Cost AS VARCHAR(10)) + ')'
		FROM TestData tn
		WHERE tn.RecordID = m.RecordID
		FOR XML PATH('')), 1, 2, '') AS Tests,
		STUFF((SELECT TOP 3
			', ' + md.Name + ' ($' + CAST(md.Cost AS VARCHAR(10)) + ')'
		FROM MedData md
		WHERE md.RecordID = m.RecordID
		FOR XML PATH('')), 1, 2, '') AS Medicines,
		b.RoomCost,
		b.OtherCharges,
		b.Total
	FROM Team9_Database.dbo.Patient p
		INNER JOIN Team9_Database.dbo.MedicalRecord m ON p.PatientID = m.PatientID
		INNER JOIN Team9_Database.dbo.Billing b ON m.RecordID = b.RecordID

-- View for displaying patient medicine records	
-- DROP VIEW vw_PatientMedicineRecords
CREATE VIEW vw_PatientMedicineRecords
AS
	SELECT p.PatientID,
		CONCAT(p.PatientFName,' ', p.PatientLName) [Patient],
		p.DateOfBirth,
		p.Gender,
		p.Age,
		(Select CONCAT(d.DoctorFName,' ', d.DoctorLName)
		from Team9_Database.dbo.Doctor d
		where d.DoctorID = m.DoctorID) [Doctor],
		m.Diagnosis,
		m.Prescription,
		m.RecordDate,
		md.MedID,
		md.Name,
		md.Brand,
		md.Description,
		md.Cost
	FROM Team9_Database.dbo.Patient p
		INNER JOIN Team9_Database.dbo.MedicalRecord m ON p.PatientID = m.PatientID
		LEFT JOIN Team9_Database.dbo.Medication med ON m.RecordID = med.RecordID
		LEFT JOIN Team9_Database.dbo.Medicine md ON med.MedID = md.MedID;

-- View for displaying hospital details and health force
-- DROP VIEW vw_HospitalManagement	   
CREATE VIEW vw_HospitalManagement
AS
	SELECT h.HospitalName,
		h.Address,
		h.City,
		h.State,
		h.Zipcode,
		h.ContactNo,
		h.Email,
		d.DepartmentName,
		CONCAT(dr.DoctorFName,' ',dr.DoctorLName) [Doctor],
		CONCAT(n.NurseFName,' ',n.NurseLName) [Nurse]
	FROM Hospital h
		INNER JOIN HospitalDepartment hd
		ON h.HospitalID = hd.HospitalID
		INNER JOIN Department d
		ON hd.DepartmentID = d.DepartmentID
		LEFT JOIN Doctor dr
		ON hd.HosDepID = dr.HosDepID
		LEFT JOIN Nurse n
		ON hd.HosDepID = n.HosDepID;

-- View for displaying doctor information
-- DROP VIEW vw_DoctorInfo
CREATE VIEW vw_DoctorInfo
AS
	SELECT CONCAT(dr.DoctorFName, ' ', dr.DoctorLName) AS DoctorName,
		dr.Gender,
		dr.ContactNo,
		hd.HosDepID,
		d.DepartmentName,
		d.DepartmentHead,
		h.HospitalName,
		h.Address [Hospital Address],
		h.ContactNo [Hospital ContactNo]
	FROM Doctor dr
		JOIN HospitalDepartment hd
		ON dr.HosDepID = hd.HosDepID
		JOIN Department d
		ON hd.DepartmentID = d.DepartmentID
		JOIN Hospital h
		ON hd.HospitalID = h.HospitalID

-- View for displaying nurse information
-- DROP VIEW vw_NurseInfo
CREATE VIEW vw_NurseInfo
AS
	SELECT CONCAT(n.NurseFName,' ', n.NurseLName) AS NurseName,
		n.Gender,
		n.ContactNo,
		hd.HosDepID,
		d.DepartmentName,
		d.DepartmentHead,
		h.HospitalName,
		h.Address [Hospital Address],
		h.ContactNo [Hospital ContactNo]
	FROM Nurse n
		JOIN HospitalDepartment hd
		ON n.HosDepID = hd.HosDepID
		JOIN Department d
		ON hd.DepartmentID = d.DepartmentID
		JOIN Hospital h
		ON hd.HospitalID = h.HospitalID

----------------------------------------------------INSERT STATEMENTS FOR TABLES---------------------------------------------------
-- Insert query for adding data in Hospital table

INSERT INTO dbo.Hospital
	(HospitalName, Address, Zipcode, Phone, Email, City, State)
VALUES
	('Cedar Sinai Medical Center', '8700 Beverly Blvd', '90048', '1555123456', 'info@csmc.com', 'Los Angeles', 'CA'),
	('Mount Sinai Hospital', '1500 S Fairfield Ave', '60608', '1555234567', 'info@sinai.com', 'Chicago', 'IL'),
	('Johns Hopkins Hospital', '1800 Orleans St', '21287', '1555345678', 'info@jhmi.com', 'Baltimore', 'MD'),
	('Massachusetts General Hospital', '55 Fruit St', '02114', '1555456789', 'info@mgh.harvard.com', 'Boston', 'MA'),
	('Brigham and Women''s Hospital', '75 Francis St', '02115', '1555567890', 'info@bwh.harvard.com', 'Boston', 'MA'),
	('New York-Presbyterian Hospital', '525 E 68th St', '10065', '1555678901', 'info@nyp.com', 'New York', 'NY'),
	('Mayo Clinic', '200 1st St SW', '55905', '1555789012', 'info@mayoclinic.com', 'Rochester', 'MN'),
	('Hospitals-Michigan Medicine', '1500 E Medical Center Dr', '48109', '1555901234', 'info@umich.com', 'Ann Arbor', 'MI'),
	('UCSF Medical Center', '505 Parnassus Ave', '94143', '1555012345', 'info@ucsfhealth.com', 'San Francisco', 'CA'),
	('Duke University Hospital', '2301 Erwin Rd', '27710', '1555123456', 'info@duke.com', 'Durham', 'NC');

-- Insert query for adding data in Department table-----

INSERT INTO dbo.Department
	(DepartmentName, DepartmentHead)
VALUES
	('Cardiology', 'John Smith'),
	('Neurology', 'Jane Johnson'),
	('Orthopedics', 'Robert Williams'),
	('Pediatrics', 'Sarah Lee'),
	('Oncology', 'David Davis'),
	('Dermatology', 'Michael Brown'),
	('Radiology', 'Susan Lee'),
	('Gynecology', 'Jennifer Jackson'),
	('Psychiatry', 'William Wilson'),
	('Endocrinology', 'Karen Lee');

-- Insert query for adding data in HospitalDepartment, this data is used to map hospital and department

INSERT INTO dbo.HospitalDepartment
	(HospitalID, DepartmentID)
VALUES
	(28, 1),
	(29, 1),
	(30, 1),
	(31, 1),
	(32, 1),
	(33, 1),
	(34, 1),
	(35, 1),
	(36, 1),
	(28, 2),
	(29, 2),
	(30, 2),
	(31, 2),
	(32, 2),
	(33, 2),
	(34, 2),
	(35, 2),
	(36, 2),
	(28, 3),
	(29, 3),
	(30, 3),
	(31, 3),
	(32, 4),
	(33, 4),
	(34, 4),
	(35, 4),
	(36, 4),
	(28, 5),
	(29, 5),
	(30, 5),
	(31, 5),
	(32, 5),
	(33, 6),
	(34, 6),
	(35, 6),
	(36, 6),
	(28, 7),
	(29, 7),
	(30, 7),
	(31, 7),
	(32, 8),
	(33, 8),
	(34, 8),
	(35, 9),
	(36, 9);

-- Insert query for adding data in doctor table----

INSERT INTO dbo.Doctor
	(HosDepID, DoctorFName, DoctorLName, Gender, ContactNo)
VALUES
	(1, 'John', 'Doe', 'M', '5551234567'),
	(31, 'Jane', 'Smith', 'F', '5555678901'),
	(2, 'Bob', 'Johnson', 'M', '5552468013'),
	(44, 'Sarah', 'Lee', 'F', '5551357902'),
	(18, 'Mike', 'Brown', 'M', '5557890123'),
	(12, 'Emily', 'Davis', 'F', '5553698701'),
	(7, 'Adam', 'Wilson', 'M', '5550246813'),
	(19, 'Samantha', 'Taylor', 'F', '5552468013'),
	(20, 'Peter', 'Chen', 'M', '5558023456'),
	(23, 'Lisa', 'Garcia', 'F', '5559753102');

-- Insert query for adding data in Nurse table-----

INSERT INTO dbo.Nurse
	(HosDepID, NurseFName, NurseLName, Gender, ContactNo)
VALUES
	(2 , 'Lisa', 'Brown', 'F', '8571234432'),
	(3 , 'Mark', 'Johnson', 'M', '8544234432'),
	(7 , 'Julie', 'Smith', 'F', '9971278432'),
	(9 , 'Andrew', 'Lee', 'M', '8588230909'),
	(13 , 'Emily', 'Williams', 'F', '1271234432'),
	(18 , 'Richard', 'Davis', 'M', '8881234432'),
	(21 , 'Karen', 'Wilson', 'F', '8571214432'),
	(22 , 'Jennifer', 'Garcia', 'F', '9091333432'),
	(34 , 'Thomas', 'Brown', 'M', '8577774432'),
	(41 , 'Laura', 'Clark', 'F', '2271330032');

-- Insert query for adding data in Tests table-----

INSERT INTO dbo.Tests
	(TestName, [Description], Cost)
VALUES
	('Urine Test', 'Checks various urine levels', 50.00),
	('X-Ray', 'Examines bones and organs', 200.00),
	('MRI', 'Produces detailed images of organs', 500.00),
	('Blood Test', 'Checks various blood levels', 50.00),
	('CT Scan', 'Examines bones and organs with X-rays', 400.00),
	('Echocardiogram', 'Examines the heart', 300.00),
	('Stress Test', 'Monitors the heart while exercising', 250.00),
	('Colonoscopy', 'Examines the colon and rectum', 600.00),
	('Hair Follicle', 'Examines the condition of hair follicles', 500.00),
	('Ultrasound', 'Produces images using high-frequency sound waves', 150.00);

-- Insert query for adding data in Medicine table-----

INSERT INTO dbo.Medicine
	([Name], Brand, [Description], Cost)
VALUES
	('Aspirin', 'Bayer', 'Pain reliever and fever reducer', 10.00),
	('Lisinopril', 'Zestril', 'Treats high blood pressure and heart failure', 20.00),
	('Metformin', 'Glucophage', 'Treats type 2 diabetes', 15.00),
	('Fluoxetine', 'Prozac', 'Treats depression and anxiety', 25.00),
	('Ibuprofen', 'Advil', 'Pain reliever and fever reducer', 10.00),
	('Lorazepam', 'Ativan', 'Treats anxiety and seizure disorders', 30.00),
	('Prednisone', 'Deltasone', 'Treats inflammation and autoimmune disorders', 18.00),
	('Chemotherapy', 'Various', 'Treats cancer', 100.00),
	('Dialysis', 'Various', 'Treats kidney failure', 500.00),
	('Topiramate', 'Topamax', 'Treats seizures and migraine headaches', 35.00);

--Insert query for adding data in InsurancePlan table-------

INSERT INTO Team9_Database.dbo.InsurancePlan
	(PlanCode, CompanyName, ContactNo, Email, InsuranceDate)
VALUES
	(1001, 'Acme Insurance Group', 1234567890, 'info@acmeinsurancegroup.com', '2022-01-01'),
	(1002, 'Liberty Mutual Insurance', 2345678901, 'support@libertymutual.com', '2022-02-01'),
	(1003, 'Allstate Insurance Company', 3456789012, 'contact@allstate.com', '2022-03-01'),
	(1004, 'Nationwide Mutual Insurance', 4567890123, 'customerservice@nationwide.com', '2022-04-01'),
	(1005, 'Progressive Corporation', 5678901234, 'feedback@progressive.com', '2022-05-01'),
	(1006, 'Geico Insurance', 6789012345, 'support@geico.com', '2022-06-01'),
	(1007, 'State Farm Insurance', 7890123456, 'customerservice@statefarm.com', '2022-07-01'),
	(1008, 'Travelers Insurance', 8901234567, 'contact@travelers.com', '2022-08-01'),
	(1009, 'USAA Insurance', 9012345678, 'info@usaa.com', '2022-09-01'),
	(1010, 'Chubb Insurance', 1234567890, 'feedback@chubb.com', '2022-10-01');


----Inserting 10 rows in Patient table------------------------

INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(18, 'John', 'Wick', '1998-06-25', convert(varbinary, '7899004533'), convert(varbinary, 'john@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(14, 'Jason', 'Durelo', '1993-06-19', convert(varbinary, '76000904533'), convert(varbinary, 'jason@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(18, 'David', 'Lee', '1998-06-25', convert(varbinary, '7896234533'), convert(varbinary, 'david@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(18, 'David', 'Lee', '1998-06-25', convert(varbinary, '7896234533'), convert(varbinary, 'david@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(19, 'Sarah', 'Kim', '1992-09-18', convert(varbinary, '3453452211'), convert(varbinary, 'sarah@info.com'), 'F');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(20, 'Michael', 'Garcia', '1977-07-03', convert(varbinary, '8679092211'), convert(varbinary, 'mick@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(21, 'Emily', 'Davis', '1996-11-08', convert(varbinary, '8907776555'), convert(varbinary, 'emily@info.com'), 'F');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(14, 'Alex', 'Wilson', '2001-04-22', convert(varbinary, '2349880909'), convert(varbinary, 'alex@info.com'), 'M');
INSERT INTO dbo.Patient
	(InsuranceID, PatientFName, PatientLName, DateOfBirth, ContactNo, Email, Gender)
VALUES
	(16, 'Olivia', 'Brown', '1988-08-11', convert(varbinary, '8798779090'), convert(varbinary, 'olivia@info.com'), 'F');

----Inserting 10 row in Address table----------------------------- 

INSERT INTO Address
	(PatientId, StreetAddress, City, States, ZipCode)
VALUES
	(31, '123 Main St', 'New York', 'NY', '10001'),
	(32, '456 Elm St', 'Los Angeles', 'CA', '90001'),
	(39, '789 Oak St', 'Chicago', 'IL', '60601'),
	(40, '234 Maple St', 'Houston', 'TX', '77001'),
	(41, '567 Pine St', 'Phoenix', 'AZ', '85001'),
	(42, '890 Cedar St', 'Philadelphia', 'PA', '19101'),
	(43, '123 Walnut St', 'San Francisco', 'CA', '94101'),
	(44, '456 Chestnut St', 'Boston', 'MA', '02101'),
	(50, '789 Spruce St', 'Dallas', 'TX', '75201'),
	(51, '234 Birch St', 'Atlanta', 'GA', '30301');

-----Inserting 10 row in Medical Record table------------------------------

INSERT INTO dbo.MedicalRecord
	(PatientID, DoctorID, Diagnosis, Prescription, AppointmentCost, RecordDate)
VALUES
	(31, 1, 'Asthma', 'Albuterol', 200.00, '2022-02-05'),
	(32, 2, 'Eczema', 'Hydrocortisone', 175.00, '2022-03-10'),
	(39, 3, 'Flu', 'Tamiflu', 125.00, '2022-04-15'),
	(40, 4, 'Hypertension', 'Lisinopril', 150.00, '2022-01-01'),
	(41, 5, 'Type 2 Diabetes', 'Metformin', 200.00, '2022-01-02'),
	(42, 6, 'Depression', 'Fluoxetine', 175.00, '2022-01-03'),
	(43, 2, 'Breast Cancer', 'Surgery', 500.00, '2022-01-04'),
	(44, 7, 'Migraine', 'Topiramate', 125.00, '2022-01-05'),
	(50, 9, 'Arthritis', 'Ibuprofen', 100.00, '2022-01-06'),
	(51, 10, 'Anxiety', 'Lorazepam', 225.00, '2022-01-07');

-------Inserting 10 row in Testing table------------------------------------

INSERT INTO dbo.Testing
	(RecordID, TestID, Result)
VALUES
	(1, 14, 'Abnormal'),
	(1, 15, 'Normal'),
	(2, 16, 'Abnormal'),
	(3, 17, 'Normal'),
	(3, 18, 'Abnormal'),
	(2, 19, 'Abnormal'),
	(3, 20, 'Normal'),
	(4, 21, 'Abnormal'),
	(5, 22, 'Normal'),
	(6, 23, 'Abnormal');

-------Inserting 10 row in Medication table------------------------------------

INSERT INTO dbo.Medication
	(RecordID, MedID)
VALUES
	(1, 2),
	(2, 3),
	(3, 4),
	(4, 6),
	(5, 1),
	(6, 5),
	(7, 8),
	(8, 9),
	(9, 10),
	(10, 1);

-----Inserting 10 rows in Vital Sign table--------------------------------

INSERT INTO VitalSign
	(RecordID, Temperature, RespirationRate, PulseRate, BloodPressure, Weight, Height)
VALUES
	(1, 98, 16, 80, 120, 150, 65),
	(2, 99, 18, 75, 110, 160, 68),
	(3, 100, 20, 85, 130, 170, 71),
	(4, 98, 16, 90, 140, 160, 70),
	(5, 99, 18, 78, 120, 155, 67),
	(6, 100, 20, 82, 130, 165, 72),
	(7, 98, 16, 88, 125, 158, 69),
	(8, 99, 18, 80, 115, 152, 66),
	(9, 100, 20, 90, 135, 172, 73),
	(10, 98, 16, 85, 130, 162, 68);

-----Inserting 10 rows in Billing table--------------------------------

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(1, '2023-04-07', 50.00, 10.00, 'Cash');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(2, '2023-04-08', 75.00, 20.00, 'Credit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(3, '2023-04-09', 0.00, 5.00, 'Debit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(4, '2023-04-10', 100.00, 30.00, 'Cash');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(5, '2023-04-11', 25.00, 5.00, 'Credit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(6, '2023-03-07', 150.00, 20.00, 'Debit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(7, '2023-02-07', 75.00, 10.00, 'Cash');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(8, '2023-01-07', 50.00, 15.00, 'Credit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(9, '2023-04-12', 0.00, 0.00, 'Debit Card');

INSERT INTO Team9_Database.dbo.Billing
	(RecordID, BillingDate, RoomCost, OtherCharges, PaymentMode)
VALUES
	(10, '2023-04-13', 100.00, 25.00, 'Cash');

-----Inserting 10 rows in Admit table----------------------------------

INSERT INTO Team9_Database.dbo.Admit
	(RecordID, NurseID, AdmitDate, DischargeDate)
VALUES
	(1, 2, '2022-01-01', '2022-01-05'),
	(2, 4, '2022-02-01', '2022-02-02'),
	(3, 9, '2022-03-01', '2022-03-04'),
	(4, 3, '2022-04-01', '2022-04-03'),
	(5, 5, '2022-05-01', '2022-05-01'),
	(6, 7, '2022-06-01', '2022-06-03'),
	(7, 2, '2022-07-01', '2022-07-06'),
	(8, 3, '2022-08-01', '2022-08-02'),
	(9, 8, '2022-09-01', '2022-09-04'),
	(10, 5, '2022-10-01', NULL);

