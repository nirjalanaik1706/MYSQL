create database healthcare;
use healthcare;
-- 1. Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender ENUM('Male', 'Female', 'Other'),
    DOB DATE,
    ContactNumber VARCHAR(15)
);

-- 2. Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Specialty VARCHAR(100),
    ContactNumber VARCHAR(15)
);

-- 3. Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status ENUM('Scheduled', 'Completed', 'Cancelled'),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 4. Prescriptions Table
CREATE TABLE Prescriptions (
    PrescriptionID INT PRIMARY KEY AUTO_INCREMENT,
    AppointmentID INT,
    MedicineName VARCHAR(100),
    Dosage VARCHAR(50),
    Duration VARCHAR(50),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Insert Patients
INSERT INTO Patients (FirstName, LastName, Gender, DOB, ContactNumber) VALUES
('John', 'Doe', 'Male', '1985-06-15', '9876543210'),
('Jane', 'Smith', 'Female', '1990-03-22', '9876543211'),
('Alice', 'Johnson', 'Female', '1978-12-01', '9876543212');

-- Insert Doctors
INSERT INTO Doctors (FirstName, LastName, Specialty, ContactNumber) VALUES
('Dr. Raj', 'Verma', 'Cardiologist', '9123456789'),
('Dr. Neha', 'Sharma', 'Dermatologist', '9123456790');


-- Insert Appointments
INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status) VALUES
(1, 1, '2025-07-10', '10:30:00', 'Completed'),
(2, 2, '2025-07-12', '11:00:00', 'Scheduled'),
(1, 2, '2025-07-14', '14:00:00', 'Cancelled');


-- Insert Prescriptions
INSERT INTO Prescriptions (AppointmentID, MedicineName, Dosage, Duration) VALUES
(1, 'Atorvastatin', '10mg', '30 days'),
(1, 'Aspirin', '75mg', '15 days'),
(2, 'Cetirizine', '5mg', '7 days');
