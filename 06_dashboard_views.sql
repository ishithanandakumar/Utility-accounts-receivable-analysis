-- ============================================
-- 06_dashboard_views.sql: Views for Tableau Dashboards
-- Creates optimized views for visualization
-- ============================================

-- Executive dashboard view
CREATE OR REPLACE VIEW CASH_FLOW_DASHBOARD AS
SELECT 
    '1. CURRENT STATE' as Analysis_Stage,
    'Total Late Payments' as Metric,
    COUNT(CASE WHEN DaysLate > 0 THEN 1 END) as Count,
    ROUND(SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END), 2) as Dollar_Impact
FROM ACCOUNTS_RECEIVABLE
UNION ALL
SELECT 
    '2. ROOT CAUSE',
    'Paper Bills (High Risk)',
    COUNT(CASE WHEN DaysLate > 10 AND PaperlessBill = 'Paper' THEN 1 END),
    ROUND(SUM(CASE WHEN DaysLate > 10 AND PaperlessBill = 'Paper' THEN InvoiceAmount ELSE 0 END), 2)
FROM ACCOUNTS_RECEIVABLE
UNION ALL
SELECT 
    '3. QUICK WIN',
    'Top 20 Collection Targets',
    20,
    16026.52
FROM (SELECT 1 as dummy)
UNION ALL
SELECT 
    '4. STRATEGIC FIX',
    'Paper→Electronic Conversion',
    96,
    13458.75
FROM (SELECT 1 as dummy);

-- Customer summary for detailed analysis
CREATE OR REPLACE VIEW CUSTOMER_SUMMARY AS
SELECT 
    customerID,
    PaperlessBill,
    COUNT(*) as invoice_count,
    ROUND(AVG(DaysLate), 1) as avg_days_late,
    MAX(DaysLate) as worst_delay,
    ROUND(SUM(InvoiceAmount), 2) as total_revenue,
    ROUND(SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END), 2) as late_amount,
    ROUND(100.0 * SUM(CASE WHEN DaysLate > 0 THEN 1 ELSE 0 END) / COUNT(*), 1) as late_rate_pct
FROM ACCOUNTS_RECEIVABLE
GROUP BY customerID, PaperlessBill;

-- Monthly trend analysis
CREATE OR REPLACE VIEW MONTHLY_TREND AS
SELECT 
    DATE_TRUNC('MONTH', TO_DATE(InvoiceDate, 'MM/DD/YYYY')) as month,
    COUNT(*) as total_invoices,
    SUM(InvoiceAmount) as total_billed,
    SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END) as late_amount,
    ROUND(AVG(DaysLate), 1) as avg_days_late
FROM ACCOUNTS_RECEIVABLE
GROUP BY month
ORDER BY month;
