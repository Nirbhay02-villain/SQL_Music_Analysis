
# Q.1 :- Who is the senior most employee based on job title?


select * from employee
order by levels desc
limit 1;

# Q.2:- Which country have the most invoices?

select * from invoice;

select count(*) as no_of_times, billing_country from invoice
group by billing_country
order by no_of_times desc;

# Q.3 :- What are the top 3 values of total invoices

select * from invoice; 
select total from invoice
order by total desc
limit 3;

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select * from invoice;

select sum(total) as total_invoice, billing_city from invoice
group by billing_city
order by total_invoice desc;

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

select * from customer;
select * from invoice;

select c.customer_id, c.first_name, c.last_name, sum(i.total) as total_money 
from customer c
join invoice i on c.customer_id = i.customer_id
group by c.customer_id, c.first_name, c.last_name
order by total_money desc
limit 1;

/*  Q.6:- Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

select * from genre;
select distinct c.email, c.first_name, c.last_name 
from customer c join 
invoice i on c.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track t on il.track_id = t.track_id
join genre g on t.genre_id = g.genre_id 
where  g.name like 'Rock'
order by c.email;

 /*  Q.7 :- Let's invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands. */

select  artist.name, count(track.name) as number_of_songs 
from artist join album on artist.artist_id = album.artist_id
join track on album.album_id = track.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = 'Rock'
group by artist.name
order by number_of_songs desc
limit 10;

/* Q.8 :- Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select * from track;
select avg(milliseconds) from track;
select name, milliseconds from track
where milliseconds > (select avg(milliseconds) from track )
order by milliseconds desc;

/* Q9: Find how much amount spent by each customer on artists? 
Write a query to return customer name, artist name and total spent */

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

/* Q10: We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre 
with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where 
the maximum number of purchases is shared return all Genres. */  

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

