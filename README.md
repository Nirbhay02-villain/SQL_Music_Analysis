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
