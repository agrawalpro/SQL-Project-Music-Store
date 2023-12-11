-- Music Store Data Analysis Project

create schema music_playlist;
use music_playlist;
select * from album2;

-- who is the senior most employee based on job title
select * from employee 
order by levels DESC
limit 1;

-- Which countries have the most invoices?
select count(billing_country),billing_country from invoice
group by billing_country
order by count(billing_country) desc
limit 1;
-- Result: 131 - USA

-- What are top 3 values of total invoice
select total from invoice
order by total desc
limit 3;
-- Result : 23.759999999999998, 19.8, 19.8

--  Which city has the best customers? We would like to throw a promotional Music Festival in 
-- the city we made the most money. Write a query that returns one city that has the highest sum 
-- of invoice totals. Return both the city name & sum of all invoice totals
select sum(total) as sum,billing_city from invoice
group by billing_city
order by sum desc
limit 1;
-- Result: 273.24000000000007	Prague

-- Who is the best customer? The customer who has spent the most money will be declared
-- the best customer. Write a query that returns the person who has spent the most money.
SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(invoice.total) AS total_purchases
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY total_purchases desc
limit 1;
-- Result: 5	FrantiÅ¡ek	WichterlovÃ¡	144.54000000000002

-- Write query to return the email, first name, last name, & Genre of all Rock Music listeners.
-- Return your list ordered alphabetically by email starting with A
select customer.email,customer.first_name,customer.last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
where genre.name = "Rock" 
order by customer.email;

-- Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands
select artist.name, count(track.track_id) as number_of_songs
from artist
join album2 on artist.artist_id = album2.artist_id
join track on track.album_id = album2.album_id
join genre on track.genre_id = genre.genre_id
where genre.name = "Rock"
group by artist.name 
order by number_of_songs desc
limit 10;

-- Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.
select name, milliseconds as length
from track
where milliseconds > (select avg(milliseconds) from track)
order by length desc;

-- Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent
-- Not Solved
select customer.first_name, artist.name, invoice.total
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join album2 on track.album_id = album2.album_id
join artist on album2=artist_id = artist.artist_id;

-- We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases.
-- Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres.
-- Not solved
select customer.country,max(count(genre.genre_id))
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
join track on invoice_line.track_id = track.track_id
join genre on track.genre_id = genre.genre_id
group by customer.country;








