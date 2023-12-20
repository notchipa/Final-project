CREATE DATABASE hospital_portal;
USE hospital_portal;
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_name VARCHAR(45) NOT NULL,
    age INT NOT NULL,
    admission_date DATE,
    discharge_date DATE
);
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(45) NOT NULL,
    specialty VARCHAR(45) NOT NULL
);

INSERT INTO doctors (doctor_name, specialty)
VALUES
    ('Dr. Smith', 'Cardiology'),
    ('Dr. Jane', 'nephrology'),
    ('Dr. Doe', 'Orthopedics');

CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time DECIMAL(5, 2) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);
INSERT INTO patients (patient_name, age, admission_date, discharge_date)
VALUES
    ('Ana Maria', 32, '2023-10-01', '2023-10-21'),
    ('John Doe', 45, '2023-10-02', '2023-10-23'),
    ('Jane Garcia', 22, '2023-10-03', '2023-12-10');
DELIMITER //

CREATE PROCEDURE scheduleAppointment(
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_date DATE,
    IN p_appointment_time DECIMAL(5, 2)
)
BEGIN
    INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time)
    VALUES (p_patient_id, p_doctor_id, p_appointment_date, p_appointment_time);
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE dischargePatient(IN p_patient_id INT)
BEGIN
    UPDATE patients
    SET discharge_date = CURDATE()
    WHERE patient_id = p_patient_id;
END //

DELIMITER ;
CREATE VIEW appointment_view AS
SELECT a.appointment_id, p.patient_name, p.age, d.doctor_name, a.appointment_date, a.appointment_time
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id;




