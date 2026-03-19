
-- MedLedger Seed Data
-- Demo Data for Testing


-- Users
INSERT INTO users(name,email,password_hash,role)
VALUES
('Swapnil','swapnil@test.com','hashed_pw','patient'),
('Dr Smith','doctor@test.com','hashed_pw','doctor');

-- Symptoms
INSERT INTO symptoms(user_id,symptom_text)
VALUES
(1,'fever cough headache');

-- Predictions
INSERT INTO predictions(symptom_id,predicted_disease,confidence_score,model_version)
VALUES
(1,'Flu',88.5,'v1.0');

-- Medicines
INSERT INTO medicines(name,dosage,description,side_effects)
VALUES
('Paracetamol','500mg','Pain reliever','Nausea');

-- Prescription
INSERT INTO prescriptions(user_id,prediction_id,doctor_id,doctor_notes)
VALUES
(1,1,2,'Take rest and drink plenty of fluids');

-- Prescription Medicine
INSERT INTO prescription_med(prescription_id,medicine_id,dosage_instruction)
VALUES
(1,1,'Take twice daily after meals');

-- Blockchain Record
INSERT INTO blockchain_records(prescription_id,transaction_hash,block_number,network)
VALUES
(1,'0x9ab23c88d123',45678,'Hyperledger');