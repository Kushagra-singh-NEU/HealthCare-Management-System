# HealthCare-Management-System


## Overview

Welcome to our Hospital Management System project! This system aims to streamline hospital operations, providing an organized platform for managing patient information, appointments, billing, and more. This README will guide you through what we did, how we did it, and the results we achieved.


### Challenges Addressed:

1. **Management of Patient Information:**
   - Centralizing patient data to facilitate easy access and updates for authorized healthcare providers.
   - Transitioning from paper-based records to an online storage system to reduce expenses.

2. **Limited Access to Patient Data:**
   - Enhancing healthcare providers' accessibility to patient data, crucial for rapid clinical decisions.

3. **Fragmented Healthcare System:**
   - Facilitating the sharing of patient information between different healthcare centers.

4. **Inefficient Appointment Scheduling:**
   - Implementing an automated appointment scheduling system to reduce administrative burden.

### Business Rules:

- Each patient needs to be registered.
- Each patient has an assigned address.
- Each patient can or cannot have an insurance plan.
- Each patient can have multiple medical records.
- Each department can have multiple doctors.
- Each department can have multiple nurses.
- Each hospital can have multiple departments.
- A doctor can add a diagnosis to a medical record for a patient.
- A doctor can prescribe medicines to a patient.
- A doctor can prescribe tests to a patient.
- A patient can be admitted to the hospital.
- Nurse will be assigned to the admitted patient.
- Each bill will be assigned for a medical record.
- Each medical record will have vital signs.

### Design Decisions:

#### Entities and Attributes:

1. **Hospital:**
   - HospitalID, HospitalName, Address, Zipcode, Phone, Email, State, City

2. **Hospital Department:**
   - HospitalID, DepartmentID

3. **Department:**
   - DepartmentID, DepartmentName, DepartmentHead

4. **Patient:**
   - PatientID, InsuranceID, PatientFName, PatientLName, DateofBirth, Phone, Email, Gender, Age

5. **Address:**
   - PatientID, StreetAddress, City, State, Zipcode

6. **Insurance Plan:**
   - InsuranceID, PlanCode, CompanyName, Phone, Email, Date

7. **Billing:**
   - BillingID, RecordID, BillingDate, RoomCost, OtherCharges, Total, PaymentMode

8. **Medical Record:**
   - RecordID, DoctorID, PatientID, Diagnosis, Prescription, AppointmentCost, RecordDate

9. **Testing:**
   - TestID, RecordID, Result

10. **Tests:**
    - TestID, TestName, Description, Cost

11. **Vital Sign:**
    - RecordID, Temperature, RespirationRate, PulseRate, BloodPressure, Weight, Height

12. **Doctor:**
    - DoctorID, DoctorFName, DoctorLName, DepartmentID, HospitalID

13. **Nurse:**
    - NurseID, NurseFName, NurseLName, DepartmentID, HospitalID

14. **Medicine:**
    - MedID, Name, Brand, Description, Cost

15. **Medication:**
    - MedID, RecordID

16. **Admit:**
    - AdmitID, RecordID, NurseID, AdmitDate, DischargeDate


## Database Design and Implementation

We designed a comprehensive relational database to store hospital-related data. The SQL script for creating the database, including tables for hospitals, departments, doctors, nurses, patients, medical records, tests, medications, billing, and more.


## Patient Information Management

Efficient management of patient information is a core feature of the system. It includes functionalities for handling patient records, medical history, testing, medications, and billing.

## Billing and Financial Management

The system incorporates features for billing and financial management. It tracks and manages financial transactions related to patient services, providing transparency and accuracy.

## Technologies Used

- **Database:** Microsoft SQL Server


## Purpose

The project serves multiple purposes:

- **Efficiency:** Streamline hospital operations by digitizing and centralizing information.
- **Accuracy:** Reduce errors and discrepancies in patient records and billing.
- **Accessibility:** Provide an easy-to-use web interface for hospital staff to interact with the system.
- **Comprehensive Management:** Cover all aspects of hospital management, from patient data to financial transactions.


## Results

- **Comprehensive Hospital Management System:** Covering various aspects of hospital operations.
- **User-Friendly Web Interface:** Making it easy for hospital staff to interact with the system.
- **Improved Efficiency:** Streamlining processes, reducing errors, and enhancing overall efficiency.
- **Transparent Financial Management:** Providing clarity in billing and financial transactions.











