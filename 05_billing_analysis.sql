-- ============================================
-- 05_billing_analysis.sql: Paper vs Electronic Analysis
-- Analyzes impact of billing methods
-- ============================================

-- Compare payment behavior by billing method
SELECT 
    PaperlessBill,
    COUNT(*) as invoice_count,
    ROUND(AVG(DaysLate), 2) as avg_days_late,
    SUM(CASE WHEN DaysLate > 0 THEN 1 END) as count_late_payments,
    ROUND(SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END), 2) as total_late_amount,
    ROUND(100.0 * SUM(CASE WHEN DaysLate > 0 THEN 1 END) / COUNT(*), 1) as late_payment_rate
FROM ACCOUNTS_RECEIVABLE
GROUP BY PaperlessBill;

-- Risk distribution by billing method
SELECT 
    r.risk_category,
    a.PaperlessBill,
    COUNT(DISTINCT a.customerID) as customer_count,
    ROUND(SUM(CASE WHEN a.DaysLate > 0 THEN a.InvoiceAmount ELSE 0 END), 2) as money_at_risk
FROM ACCOUNTS_RECEIVABLE a
JOIN CUSTOMER_RISK_GROUPS r ON a.customerID = r.customerID
GROUP BY r.risk_category, a.PaperlessBill
ORDER BY r.risk_category, a.PaperlessBill;

-- Calculate conversion opportunity
SELECT 
    'Converting Paper to Electronic' as Initiative,
    COUNT(DISTINCT customerID) as Customers_to_Convert,
    ROUND(AVG(DaysLate), 1) as Current_Avg_Days_Late,
    2.4 as Expected_Days_Late_After,
    ROUND(SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END), 2) as Current_Money_Stuck,
    ROUND(SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END) * 0.4, 2) as Cash_Flow_Improvement
FROM ACCOUNTS_RECEIVABLE
WHERE PaperlessBill = 'Paper';
