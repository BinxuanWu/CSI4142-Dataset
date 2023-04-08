/* iceburg query: */
/* to find the top 10 expensive house with elevator and building type 1*/

SELECT id, square, price
FROM building
WHERE elevator = 1 AND building_type = 1 ORDER BY price desc LIMIT 10;


/* Using the Window clause: compare the number of trade in 2016 to that of the previous and next years. */

SELECT year, number_trade,
  LAG(number_trade) OVER (ORDER BY year) AS prev_year_trade,
  LEAD(number_trade) OVER (ORDER BY year) AS next_year_trade
FROM (
SELECT district, count(id)  AS number_trade From FACT Group by district
) as trade_count
WHERE year BETWEEN 2015 AND 2017
AND district = 7
WINDOW w AS (ORDER BY year)

/* Windowing Query: 
Display and compare the ranking of building total price with average total price in its floor level*/

SELECT b.floor_level, b.square, b.total_price, 
 AVG(b.total_price) OVER (PARTITION BY b.floor_level) ,
 RANK() OVER (PARTITION BY b.floor_level ORDER BY b.total_price) 
    FROM building b;