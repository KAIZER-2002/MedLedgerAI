-- MedLedger Trigger
-- Automatically log prescription to blockchain_records


CREATE OR REPLACE FUNCTION log_prescription_blockchain()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO blockchain_records(
        prescription_id,
        transaction_hash,
        block_number,
        network
    )
    VALUES(
        NEW.prescription_id,
        md5(random()::text || clock_timestamp()::text),
        FLOOR(random()*100000),
        'Hyperledger'
    );

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;



CREATE TRIGGER prescription_blockchain_trigger
AFTER INSERT ON prescriptions
FOR EACH ROW
EXECUTE FUNCTION log_prescription_blockchain();