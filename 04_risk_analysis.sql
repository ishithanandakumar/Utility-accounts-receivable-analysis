-- ============================================
-- 04_risk_analysis.sql: Customer Risk Categorization
-- Creates risk groups and analysis
-- ============================================

-- Create customer risk groups view
CREATE OR REPLACE VIEW CUSTOMER_RISK_GROUPS AS
SELECT 
    customerID,
    AVG(DaysLate) as avg_days_late,
    SUM(CASE WHEN DaysLate > 0 THEN InvoiceAmount ELSE 0 END) as total_late_amount,
    COUNT(CASE WHEN DaysLate > 0 THEN 1 END) as count_late_payments,
    
    -- Risk categorization
    CASE 
        WHEN AVG(DaysLate) > 10 THEN 'HIGH RISK'
        WHEN AVG(DaysLate) > 5 THEN 'MEDIUM RISK'
        WHEN AVG(DaysLate) > 0 THEN 'LOW RISK'
        ELSE 'NO RISK'
    END AS risk_category
    
FROM ACCOUNTS_RECEIVABLE
GROUP BY customerID;

-- Risk summary
SELECT 
    risk_category,
    COUNT(*) as customer_count,
    ROUND(SUM(total_late_amount), 2) as money_at_risk
FROM CUSTOMER_RISK_GROUPS
GROUP BY risk_category
ORDER BY 
    CASE risk_category
        WHEN 'HIGH RISK' THEN 1
        WHEN 'MEDIUM RISK' THEN 2
        WHEN 'LOW RISK' THEN 3
        ELSE 4
    END;
