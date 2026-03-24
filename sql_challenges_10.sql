/******************************************************************************
*******************************************************************************

SQL CHALLENGES 10

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. What's the difference between highest and lowest price of titles
    SELECT 
    MIN(price) AS lowest_price,
    MAX(price) AS highest_price,
    MAX(price) - MIN(price) AS price_difference
FROM
    titles;
    
-- 2. Find titles where the total number of books sold is an even number.
SELECT 
    t.title_id, t.title, SUM(s.qty)
FROM
    titles t
        INNER JOIN
    sales s ON s.title_id = t.title_id
GROUP BY t.title_id
HAVING SUM(s.qty) % 2 = 0;

-- 3. Calculate the total revenue by multiplying the quantity sold by the price for each title.

SELECT 
    t.title_id,
    t.title,
    SUM(s.qty) AS total_qty,
    t.price,
    SUM(s.qty * t.price) AS revenue
FROM
    titles t
        INNER JOIN
    sales s ON s.title_id = t.title_id
GROUP BY t.title_id , t.title;

-- 4. Cheryl Carson and Charlene Locksley got married, what is their collective revenue?

 SELECT 
    SUM(revenue) as total_revenue
FROM
    (SELECT 
        CONCAT(a.au_fname, ' ', a.au_lname) AS full_name,
            SUM(s.qty * t.price) as revenue
    FROM
        sales s
    INNER JOIN titles t ON t.title_id = s.title_id
    INNER JOIN titleauthor ta ON ta.title_id = s.title_id
    INNER JOIN authors a ON a.au_id = ta.au_id
    GROUP BY full_name, 
    HAVING full_name IN ('cheryl carson' , 'charlene locksley')) AS revenue;

-- 2nd method

SELECT 
    SUM(qty * price) AS total_revenue
FROM
    titles t
        JOIN
    sales s USING (title_id)
        JOIN
    titleauthor ta USING (title_id)
        JOIN
    authors a USING (au_id)
WHERE
    (au_fname = 'Cheryl' AND au_lname = 'Carson')
	OR (au_fname = 'Charlene' AND au_lname = 'Locksley');
    
-- 5. Calculate the total number of books published by the publishers '0736' and '0877':

select sum(total) as total_revenue from 
(SELECT 
    p.pub_id, COUNT(*) AS total
FROM
    publishers p
        JOIN
    titles t ON t.pub_id = p.pub_id
GROUP BY p.pub_id
HAVING p.pub_id IN ('0736' , '0877')) as total;
    
    -- 2nd method
    
    SELECT 
    (SELECT 
            COUNT(*)
        FROM
            titles
        WHERE
            pub_id = '0736') + (SELECT 
            COUNT(*)
        FROM
            titles
        WHERE
            pub_id = '0877') AS total_books_published;
            
            
       
 
-- 6. Find all of the books that are more than 10% above the average price of a book in the dataset


    
SELECT 
    title_id, title, price
FROM
    titles
WHERE
    price > (SELECT 
            AVG(price) AS avg_price
        FROM
            titles)*1.10;
            
       -- 2nd method
       
       SELECT 
    title, price
FROM
    titles
WHERE
    price > (SELECT 
				AVG(price) * 1.1
			 FROM
				titles);
            
 