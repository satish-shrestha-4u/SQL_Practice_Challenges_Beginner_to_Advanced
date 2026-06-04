/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 7

*******************************************************************************
*******************************************************************************


In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - CASE
*/

/*******************************************************************************
CASE

https://www.w3schools.com/sql/sql_case.asp
*******************************************************************************/

/* 1. Select everything from the sales table and create a new column called 
   "sales_category" with case conditions to categorise qty:
   
		qty >= 50 high sales
		20 <= qty < 50 medium sales
		qty < 20 low sales
*/

SELECT 
    *,
    CASE
        WHEN qty >= 50 THEN 'high sales'
        WHEN qty BETWEEN 20 AND 49 THEN 'medium sales'
        WHEN qty < 20 THEN 'low sales'
    END AS sales_category
FROM
    sales;


/* 2. Given your three sales categories (high, medium, and low), 
   calculate the total number of books sold in each category. 
*/
SELECT 

    CASE
        WHEN qty >= 50 THEN 'high sales'
        WHEN qty BETWEEN 20 AND 49 THEN 'medium sales'
        WHEN qty < 20 THEN 'low sales'
    END AS categorise_qty,
    sum(qty) AS total_qty
FROM
    sales
GROUP BY categorise_qty;

/* 3. Adding to your answer from the previous questions: output only those 
   sales categories that have a SUM(qty) greater than 100, and order them in 
   descending order */

SELECT 
    CASE
        WHEN qty >= 50 THEN 'high sales'
        WHEN qty BETWEEN 20 AND 49 THEN 'medium sales'
        WHEN qty < 20 THEN 'low sales'
    END AS categorise_qty,
    SUM(qty) AS total_qty
FROM
    sales
GROUP BY categorise_qty
HAVING SUM(qty) > 100
ORDER BY SUM(qty) DESC;

/* 4. Find out the average book price, per publisher, for the following book 
    types and price categories:
		book types: business, traditional cook and psychology
		price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
        
    - When displaying the average prices, use ROUND() to hide decimals. */

SELECT 
    CASE
        WHEN price <= 5 THEN 'super low'
        WHEN price <= 10 THEN 'low'
        WHEN price <= 15 THEN 'medium'
        ELSE 'high'
    END AS price_category,
    ROUND(AVG(t.price)) AS avg_price,
    t.pub_id
FROM
    titles AS t
        LEFT JOIN
    sales AS s ON s.title_id = t.title_id
WHERE
    t.type IN ('business' , ' trad_cook', 'psychology')
GROUP BY price_category , t.pub_id
ORDER BY price_category; 


