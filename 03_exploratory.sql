-- ============================================
-- 03_exploratory.sql: Initial Data Exploration
-- Basic queries to understand the data
-- ============================================

-- Overall summary statistics
SELECT 
    COUNT(*) as total_invoices,
    COUNT(DISTINCT customerID) as unique_customers,
    ROUND(SUM(InvoiceAmount), 2) as total_revenue,
    ROUND(AVG(InvoiceAmount), 2) as avg_invoice_amount,
    SUM(CASE WHEN DaysLate > 0 THEN 1 ELSE 0 END) as late_payments,
    ROUND(AVG(DaysLate), 2) as avg_days_late
FROM ACCOUNTS_RECEIVABLE;

-- Identify chronic late payers
SELECT 
    customerID,
    COUNT(*) as total_invoices,
    SUM(CASE WHEN DaysLate > 0 THEN 1 ELSE 0 END) as times_paid_late,
    ROUND(100.0 * SUM(CASE WHEN DaysLate > 0 THEN 1 ELSE 0 END) / COUNT(*), 1) as late_rate_pct
FROM ACCOUNTS_RECEIVABLE
GROUP BY customerID
HAVING times_paid_late > 10
ORDER BY late_rate_pct DESC
LIMIT 10;

-- Top 10 customers by late payment amount
SELECT 
    customerID,
    COUNT(*) as total_invoices,
    SUM(CASE WHEN DaysLate > 0 THEN 1 ELSE 0 END) as late_invoices,
    ROUND(SUM(InvoiceAmount), 2) as total_revenue,
    ROUND(SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END), 2) as money_from_late_invoices
FROM ACCOUNTS_RECEIVABLE
GROUP BY customerID
HAVING late_invoices > 10
ORDER BY money_from_late_invoices DESC
LIMIT 10;
