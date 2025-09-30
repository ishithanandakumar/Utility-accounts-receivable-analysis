# Cash Flow Optimization & Predictive Analytics

## 📊 Project Overview
A data analytics project analyzing accounts receivable data to identify and solve cash flow issues for a utility company. The analysis identifies $53,961 in late payments and provides actionable solutions to recover $29,484 through strategic initiatives.

## 🎯 Business Problem
- **Challenge**: 35.6% of customer payments are late, causing significant cash flow issues
- **Impact**: $53,961 tied up in late payments
- **Goal**: Identify root causes and develop data-driven solutions to improve collection rates

## 💡 Key Findings
1. **Paper vs Electronic Billing**: Paper bill customers pay 85% slower (4.4 days vs 2.4 days)
2. **High-Risk Customers**: 11 customers account for $14,403 in late payments
3. **Improvement Opportunity**: Converting paper to electronic billing could recover $13,458

## 🛠️ Technologies Used
- **Database**: Snowflake Cloud Data Platform
- **SQL**: Complex queries, CTEs, window functions, views
- **Visualization**: Tableau (3 interactive dashboards)
- **Analysis**: Customer segmentation, risk scoring, trend analysis

## 📁 Project Structure

├── sql/
│   ├── 01_setup.sql                 # Database, warehouse, schema creation
│   ├── 02_data_model.sql            # Table creation and data loading
│   ├── 03_exploratory.sql           # Initial data exploration queries
│   ├── 04_risk_analysis.sql         # Customer risk categorization
│   ├── 05_billing_analysis.sql      # Paper vs Electronic analysis
│   └── 06_dashboard_views.sql       # Views for Tableau dashboards
├── tableau/
│   └── AR_Dashboard.twbx            # Tableau workbook with 3 dashboards
├── data/
│   └── WA_FnUseC_AccountsReceivable.csv  # Source data (2,466 records)
└── README.md

## 📈 Dashboards Created

### 1. Executive Summary
- KPI cards showing total outstanding, collection rate, and average days late
- Risk category breakdown showing money at risk
- Monthly trend analysis
- Paper vs Electronic billing impact

### 2. Collection Targets
- Scatter plot identifying high-value, high-frequency late payers
- Customer payment heat map over time
- Focus on top-right quadrant (worst offenders)

### 3. Cash Flow Recovery Plan
- Step-by-step recovery visualization
- Paper to electronic conversion impact (40% reduction)
- Recommended actions by risk tier
- Expected ROI for each initiative

## 🔍 SQL Analysis Highlights

### Customer Risk Segmentation
```sql
CASE 
    WHEN AVG(DaysLate) > 10 THEN 'HIGH RISK'
    WHEN AVG(DaysLate) > 5 THEN 'MEDIUM RISK'
    WHEN AVG(DaysLate) > 0 THEN 'LOW RISK'
    ELSE 'NO RISK'
END AS risk_category
Key Metrics

877 late payments out of 2,466 total invoices
100 unique customers analyzed
$147,703 total revenue tracked
3.5 average days late across all payments

💼 Business Recommendations

Immediate Action: Focus collection efforts on 11 high-risk customers

Expected Recovery: $14,403
Method: Direct phone calls, payment plans


Strategic Initiative: Convert 96 paper bill customers to electronic

Expected Recovery: $13,458
Method: Incentive program ($5 credit for switching)


Long-term Monitoring: Implement automated reminders for medium-risk customers

Expected Impact: Prevent escalation to high-risk



📊 Results & Impact

Total Recoverable Amount: $29,484 (55% of current late payments)
Improved Collection Rate: From 63.47% to projected 80%
Reduced Average Days Late: From 3.5 to projected 2 days
ROI: 40% reduction in late payments through billing method optimization

🚀 How to Run
Prerequisites

Snowflake account with appropriate permissions
Tableau Desktop (2021.4 or later)
CSV data file

Setup Instructions

Execute SQL scripts in order (01-06) in Snowflake
Load the CSV data into ACCOUNTS_RECEIVABLE table
Connect Tableau to Snowflake using the created views
Open the Tableau workbook to explore dashboards

📝 Future Enhancements

 Implement predictive ML model for payment likelihood
 Add seasonal trend analysis
 Create automated alerting system for high-risk accounts
 Develop customer portal for self-service payment plans

👤 Author
Ishitha Nanda Kumar

Tableau Dashboard in Tableau Public: https://public.tableau.com/views/OptimizingUtilityAccountsReceivableACashFlowAnalysisProject/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link
LinkedIn: https://www.linkedin.com/in/-nandakumarishitha/

📄 License
This project is part of a portfolio for educational and demonstration purposes.
