
<h2><b>DSA-2040 Practical Exam
Retail Data Warehouse, ETL Automation, OLAP Analytics & Customer Segmentation using Clustering</b></h2>

***Author: Victor Kipngeno Rotich
Course: DSA-2040 – Data Science Practical Examination***



 **1. Project Overview**

This project implements a complete Data Engineering + Data Science workflow on retail transactional data. The goal is to create a fully functional Data Warehouse (DW), automate an ETL pipeline, execute OLAP analytical operations, perform K-Means clustering, and generate meaningful insights to support business decision-making.

The project is built using:

1.Python (pandas, numpy, sklearn, matplotlib)

2.SQLite3 Data Warehouse (retail_dw.db)

3.Structured SQL OLAP queries

4.Jupyter Notebooks for exploration

5.Well-defined fact and dimension tables

This repository demonstrates practical skills in data transformation, SQL analytics, dimensional modeling, clustering, visualization, and business insights generation.



 **2. Directory Structure**
```
DSA-2040_Practical_Exam/
│
├── data/
│   ├── raw_data.csv
│   ├── recent_sales_data.csv
│   └── customer_sales_summary.csv
│
├── warehouse/
│   └── retail_dw.db
│
├── notebooks/
│   ├── clustering.ipynb
│   └── data_cleaning.ipynb
│
├── src/
│   ├── etl_pipeline.py
│   ├── olap_queries.py
│   └── utils.py
│
├── visualizations/
│   ├── sales_by_country.png
│   ├── monthly_trend.png
│   └── clusters.png
│
├── README.md
└── requirements.txt
```



**3. Data Warehouse Design**
```
✔ Dimensional Schema – Star Schema
                        ┌──────────────────────┐
                        │      DimCustomer     │
                        └─────────┬────────────┘
                                  │
                     ┌────────────┴────────────┐
                     │        FactSales        │
                     └────────────┬────────────┘
                                  │
         ┌────────────────────────┴────────────────────────┐
         │                                                │
 ┌───────────────┐                                ┌────────────────┐
 │   DimProduct   │                                │    DimTime    │
 └───────────────┘                                └────────────────┘
```

🔹 Fact Table: FactSales

Contains measurable business events (transactions):

| Column      | Description          |
| ----------- | -------------------- |
| InvoiceNo   | Transaction ID       |
| CustomerID  | Buyer                |
| StockCode   | Product              |
| InvoiceDate | Timestamp            |
| Quantity    | Units sold           |
| UnitPrice   | Price per unit       |
| TotalSales  | Quantity × UnitPrice |

🔹 Dimensional Tables

1. DimCustomer

        CustomerID

        Country

        CustomerSegment (optional)

2. DimTime

        Date

        Year

        Quarter

        Month

3. DimProduct

        StockCode

        Description

        Category (generated during transformation)



 **4. ETL Pipeline (Extract → Transform → Load)**

A full automated ETL function was implemented with row-level logging, including detailed counts at each stage.

**Extract**

-Loads raw CSV files (Online Retail dataset)

-Handles missing values & invalid rows

-Converts InvoiceDate to datetime

**Transform**

Key transformations include:

-Generating TotalSales

-Creating DimTime from InvoiceDate

-Cleaning product descriptions

-Classifying products into categories (e.g., Electronics, Household, Gifts)

-Aggregating customer sales summaries

**Load**

All tables are pushed into retail_dw.db using:
```
df.to_sql("FactSales", conn, if_exists="replace", index=False)
```
✔ Automatic Logging Example
```
2025-02-21 14:18:32 - INFO - Extracted 541,909 rows.
2025-02-21 14:18:33 - INFO - Cleaned & transformed 397,884 valid rows.
2025-02-21 14:18:34 - INFO - Loaded 397,884 rows into FactSales.
2025-02-21 14:18:34 - INFO - Loaded 4,373 rows into DimCustomer.
```


 **5. OLAP Query Operations**

The project implements three OLAP operations:

 5.1 Roll-Up – Total Sales by Country & Year
```
SELECT fs.Country,
       strftime('%Y', fs.InvoiceDate) AS year,
       SUM(fs.TotalSales) AS total_sales
FROM fact_recent_sales fs
JOIN DimCustomer dc ON fs.CustomerID = dc.CustomerID
GROUP BY fs.Country, year
ORDER BY fs.Country, year;
```

Insights:

-UK dominates total sales volume

-Germany, France, and the Netherlands follow

-Sales gradually increase toward Q4 due to holiday season

 5.2 Drill-Down – Monthly Sales for United Kingdom
 ```
SELECT strftime('%Y-%m', fs.InvoiceDate) AS month,
       SUM(fs.TotalSales)
FROM fact_recent_sales fs
JOIN DimCustomer dc ON fs.CustomerID = dc.CustomerID
WHERE dc.Country = 'United Kingdom'
GROUP BY month
ORDER BY month;
```
Insights:

-Sales peak around November–December (holiday spikes)

-Month-to-month fluctuations reveal seasonal buying patterns

 5.3 Slice – Sales for Electronics Category
 ```
SELECT SUM(fs.TotalSales)
FROM fact_recent_sales fs
JOIN DimProduct dp ON fs.StockCode = dp.StockCode
WHERE dp.Category = 'Electronics';
```
Insights:

-Electronics represent a small but high-value segment

-Useful for targeted marketing and premium pricing strategies



 **6. Visualizations**

Stored inside /visualizations/, including:

✔ Sales by Country (Bar Chart)

Shows country-level performance.

✔ Monthly Sales Trend (Line Chart)

Illustrates seasonality and demand patterns.

✔ Customer Clusters (Scatter Plot)

Shows segmentation patterns for business intelligence.



 **7. Customer Segmentation Using K-Means**
Features Used

        Total yearly spend

        Purchase frequency

        Average basket value

Cluster Output Example
| Cluster | Description                    |
| ------- | ------------------------------ |
| 0       | Low-spending occasional buyers |
| 1       | Mid-range loyal customers      |
| 2       | High-value premium segment     |
t
Cluster Analysis

-Some misclassification occurs near cluster boundaries

-Synthetic category generation affects realism slightly

However, segments still reveal meaningful behavior patterns



 **8. Analytical Report Summary (150–200 words)**



The clustering results demonstrate clear but imperfect separation between customer groups. High-value customers show consistently larger baskets and more frequent purchases, while low-value customers exhibit sporadic buying patterns. Misclassifications occur when customers have intermediate spending patterns, placing them between cluster boundaries, which is typical in K-means clustering due to its reliance on Euclidean distance.

The OLAP analysis reveals that the United Kingdom is the highest-performing country, driven by dense retail activity and frequent purchases. Seasonal trends indicate strong sales in Q4, influenced by holiday demand. Country-level roll-ups provided meaningful insights for international strategy, while drill-down analyses showed monthly behavior essential for inventory forecasting.

Synthetic data used during transformation (e.g., product categories) slightly affects realism, as actual retail categorization is more nuanced. However, the data warehouse structure still mirrors real-world systems, enabling analytics comparable to industry setups. The warehouse greatly enhances decision-making by providing a unified source for reporting, segmentation, forecasting, and strategic planning.



**9. How to Run the Project**
1. Install dependencies
```
pip install pandas numpy matplotlib scikit-learn
```
3. Execute ETL
```
python src/etl_pipeline.py
```
5. Run OLAP
```
python src/olap_queries.py
```
7. Open notebook for clustering
```
jupyter notebook notebooks/clustering.ipynb
```



 **10. Contribution Guidelines**

Pull requests are welcome. Recommended contributions:

Improving product categorization

Adding more visualizations

Enhancing warehouse schema



 **11. Author**

Victor Kipngeno Rotich
GitHub: https://github.com/VICTOR21-A
