# Data Warehouse Design - Star Schema

## Explanation
A star schema is chosen because it simplifies OLAP queries and improves performance by minimizing joins. 
It is ideal for analytical operations such as sales aggregation, customer demographic analysis, and trend reporting. 
Snowflake schemas introduce normalization but add complexity and slow query performance.

## Included Tables
- FactSales
- DimCustomer
- DimProduct
- DimTime
- DimStore

See the diagram and SQL script for full structure.
