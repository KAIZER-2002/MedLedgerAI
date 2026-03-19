
-- MedLedger Database Schema


-- USERS TABLE
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(20) CHECK (role IN ('patient','doctor','admin')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_users_email
ON users(email);



-- SYMPTOMS TABLE
CREATE TABLE symptoms (
    symptom_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    symptom_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_symptoms_user
ON symptoms(user_id);



-- PREDICTIONS TABLE
CREATE TABLE predictions (
    prediction_id SERIAL PRIMARY KEY,
    symptom_id INT REFERENCES symptoms(symptom_id) ON DELETE CASCADE,
    predicted_disease VARCHAR(120),
    confidence_score DECIMAL(5,2),
    model_version VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_predictions_symptom
ON predictions(symptom_id);



-- MEDICINES TABLE
CREATE TABLE medicines (
    medicine_id SERIAL PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    dosage VARCHAR(100),
    description TEXT,
    side_effects TEXT
);

CREATE INDEX idx_medicine_name
ON medicines(name);



-- PRESCRIPTIONS TABLE
CREATE TABLE prescriptions (
    prescription_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    prediction_id INT REFERENCES predictions(prediction_id),
    doctor_id INT REFERENCES users(user_id),
    doctor_notes TEXT,
    blockchain_hash VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_prescription_user
ON prescriptions(user_id);

CREATE INDEX idx_prescription_prediction
ON prescriptions(prediction_id);



-- PRESCRIPTION_MED TABLE
CREATE TABLE prescription_med (
    id SERIAL PRIMARY KEY,
    prescription_id INT REFERENCES prescriptions(prescription_id) ON DELETE CASCADE,
    medicine_id INT REFERENCES medicines(medicine_id),
    dosage_instruction TEXT
);

CREATE INDEX idx_prescription_medicine
ON prescription_med(prescription_id);



-- BLOCKCHAIN RECORDS TABLE
CREATE TABLE blockchain_records (
    blockchain_id SERIAL PRIMARY KEY,
    prescription_id INT REFERENCES prescriptions(prescription_id),
    transaction_hash VARCHAR(255) UNIQUE,
    block_number INT,
    network VARCHAR(100),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_blockchain_tx
ON blockchain_records(transaction_hash);