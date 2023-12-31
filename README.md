# SQL_Music_Analysis

This project focuses on analyzing music store data with SQL. The dataset has 11 tables: Employee, Customer, Invoice, InvoiceLine, Track, MediaType, Genre, Album, Artist, PlaylistTrack, and Playlist. This project intends to answer many questions and obtain important insights into the music store's operations by applying SQL queries to the dataset.

# Introduction

The project "SQL Music Analysis" presents an in-depth examination of the store's data, aiming to enhance decision-making, detect patterns, and gain insights into customer behavior. Through the utilization of SQL queries and data exploration, this initiative furnishes valuable insights to streamline inventory management, target marketing efforts, and support well-informed business decisions.

# Dataset

The dataset for this project has 11 tables: Employee, Customer, Invoice, InvoiceLine, Track, MediaType, Genre, Album, Artist, PlaylistTrack, and Playlist, as well as their associations.

<img width="594" alt="schema_diagram" src="https://github.com/Nirbhay02-villain/SQL_Music_Analysis/assets/61178899/6055f642-3487-4098-b2a3-5f158b6ece42">

# Questions and Answers

Q1. Who is the most senior employee based on job title?

```sql
SELECT * FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1;
```

Q2. Which countries have the most Invoices?

```sql
SELECT BILLING_COUNTRY, COUNT(*) AS Most_Invoices FROM INVOICE
GROUP BY BILLING_COUNTRY
ORDER BY Most_Invoices DESC;
```

Q3. What are top 3 values of total invoice?

```sql
SELECT TOTAL FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3;
```

Q4. Which city has the best customers?

*We would like to throw a promotional Music Festival in the city we made the most money.
*Write a query that returns one city that has the highest sum of invoice totals.
*Return both the city name & sum of all invoice totals.

```sql
select sum(total) as total_invoice, billing_city from invoice
group by billing_city
order by total_invoice desc;
```

Q5. Who is the best customer?

The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent the most money.
