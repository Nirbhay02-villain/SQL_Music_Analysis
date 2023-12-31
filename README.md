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

* We would like to throw a promotional Music Festival in the city we made the most money.
* Write a query that returns one city that has the highest sum of invoice totals.
* Return both the city name & sum of all invoice totals.

```sql
select sum(total) as total_invoice, billing_city from invoice
group by billing_city
order by total_invoice desc;
```

Q5. Who is the best customer?

* The customer who has spent the most money will be declared the best customer.
* Write a query that returns the person who has spent the most money.

```sql
select c.customer_id, c.first_name, c.last_name, sum(i.total) as total_money 
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_money desc
limit 1;
```

Q6. Write query to return the email, first name, last name, & Genre of all Rock Music listeners.

* Return your list ordered alphabetically by email starting with A.

```sql
select distinct c.email, c.first_name, c.last_name 
from customer c join 
invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id
join genre g on t.genre_id = g.genre_id 
where  g.name like 'Rock'
order by c.email;
```

Q7. Let's invite the artists who have written the most rock music in our dataset.

* Write a query that returns the Artist name and total track count of the top 10 rock bands.

```sql
select  artist.name, count(track.name) as number_of_songs 
from artist join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by artist.name
order by number_of_songs desc
limit 10;
```

Q8. Return all the track names that have a song length longer than the average song length.

* Return the Name and Milliseconds for each track.
* Order by the song length with the longest songs listed first.

```sql
select * from track;
select avg(milliseconds) from track;
select name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track )
order by milliseconds desc;
```

Q9. Find how much amount spent by each customer on artists?

* Write a query to return customer name, artist name and total spent.

```sql
SELECT CONCAT_WS(' ', C.first_name, C.last_name)cust_name, (A.name)artist_name, SUM(IL.unit_price * IL.quantity)total_spent
FROM customer C
INNER JOIN invoice I
ON C.customer_id = I.customer_id
INNER JOIN invoice_line IL
ON I.invoice_id = IL.invoice_id
INNER JOIN track T
ON IL.track_id = T.track_id
INNER JOIN album AL
ON T.album_id = AL.album_id
INNER JOIN artist A
ON AL.artist_id = A.artist_id
GROUP BY C.first_name, C.last_name, A.name
ORDER BY total_spent DESC;
```

Q10. We want to find out the most popular music Genre for each country.

* We determine the most popular genre as the genre with the highest amount of purchases.
* Write a query that returns each country along with the top Genre.
* For countries where the maximum number of purchases is shared return all Genres.

```sql
WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1;
```
