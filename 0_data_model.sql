## **Modularized SQL Files for GitHub:**

### **01_setup.sql**
```sql
-- ============================================
-- 01_setup.sql: Environment Setup
-- Creates warehouse, database, and schema
-- ============================================

-- Create compute resources
CREATE WAREHOUSE IF NOT EXISTS FINANCE_WH
WITH WAREHOUSE_SIZE = 'XSMALL'
AUTO_SUSPEND = 60
AUTO_RESUME = TRUE;

-- Create database
CREATE DATABASE IF NOT EXISTS FINANCE_DB;

-- Create schema
CREATE SCHEMA IF NOT EXISTS FINANCE_DB.PAYMENT_ANALYTICS;

-- Set context
USE WAREHOUSE FINANCE_WH;
USE DATABASE FINANCE_DB;
USE SCHEMA PAYMENT_ANALYTICS;
