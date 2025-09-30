-- ============================================
-- 02_data_model.sql: Table Creation
-- Creates main accounts receivable table
-- ============================================

CREATE OR REPLACE TABLE ACCOUNTS_RECEIVABLE (
    countryCode INTEGER,
    customerID VARCHAR(50),
    PaperlessDate VARCHAR(50),
    invoiceNumber INTEGER,
    InvoiceDate VARCHAR(50),
    DueDate VARCHAR(50),
    InvoiceAmount DECIMAL(10,2),
    Disputed VARCHAR(10),
    SettledDate VARCHAR(50),
    PaperlessBill VARCHAR(20),
    DaysToSettle INTEGER,
    DaysLate INTEGER
);

-- Add comments for documentation
COMMENT ON TABLE ACCOUNTS_RECEIVABLE IS 'Main fact table containing invoice and payment data';
COMMENT ON COLUMN ACCOUNTS_RECEIVABLE.DaysLate IS 'Number of days payment was late (0 = on time, negative = early)';
