---DIMENSION TABLES
CREATE TABLE DimCustomer (
    customer_id INTEGER PRIMARY KEY,
    full_name TEXT,
    gender TEXT,
    age INTEGER,
    location TEXT,
    income_level TEXT
);

CREATE TABLE DimProduct (
    product_id INTEGER PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    brand TEXT,
    unit_price REAL
);

CREATE TABLE DimTime (
    time_id INTEGER PRIMARY KEY,
    date TEXT,
    day INTEGER,
    month INTEGER,
    quarter INTEGER,
    year INTEGER
);

CREATE TABLE DimStore (
    store_id INTEGER PRIMARY KEY,
    store_name TEXT,
    region TEXT,
    store_type TEXT
);

-- FACT TABLE
CREATE TABLE FactSales (
    sales_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    time_id INTEGER,
    store_id INTEGER,
    quantity_sold INTEGER,
    sales_amount REAL,
    FOREIGN KEY (customer_id) REFERENCES DimCustomer(customer_id),
    FOREIGN KEY (product_id) REFERENCES DimProduct(product_id),
    FOREIGN KEY (time_id) REFERENCES DimTime(time_id),
    FOREIGN KEY (store_id) REFERENCES DimStore(store_id)
);
