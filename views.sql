
-- MedLedger Views


CREATE VIEW patient_medical_history AS
SELECT
    u.user_id,
    u.name AS patient_name,
    s.symptom_text,
    p.predicted_disease,
    p.confidence_score,
    m.name AS medicine,
    pr.doctor_notes,
    b.transaction_hash
FROM users u
JOIN symptoms s
    ON u.user_id = s.user_id
JOIN predictions p
    ON s.symptom_id = p.symptom_id
JOIN prescriptions pr
    ON p.prediction_id = pr.prediction_id
JOIN prescription_med pm
    ON pr.prescription_id = pm.prescription_id
JOIN medicines m
    ON pm.medicine_id = m.medicine_id
LEFT JOIN blockchain_records b
    ON pr.prescription_id = b.prescription_id;