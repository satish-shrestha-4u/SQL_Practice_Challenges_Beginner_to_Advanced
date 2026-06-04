/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 8

*******************************************************************************
*******************************************************************************


In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - Subqueries

*/

USE publications;

/*******************************************************************************
Subqueries

https://dev.mysql.com/doc/refman/8.4/en/subqueries.html
*******************************************************************************/


-- 1. Find the name of the publisher with the highest advance.



SELECT 
    p.pub_name, p.pub_id, t.max_advance
FROM
    publishers p
        LEFT JOIN
    (SELECT 
        pub_id, MAX(advance) AS max_advance
    FROM
        titles AS t
    GROUP BY pub_id) AS t ON p.pub_id = t.pub_id
ORDER BY t.max_advance DESC
LIMIT 1;


-- 2. List the titles of books published by publishers based in 'Boston'.

SELECT 
    title, t.pub_id
FROM
    titles t
        left JOIN
    (SELECT 
        pub_id
    FROM
        publishers p
    WHERE
        city = 'Boston') AS p ON t.pub_id = p.pub_id;
        


-- 3. Find the authors who have written more than one book.

SELECT 
    a.au_id, concat(a.au_lname,' ',a.au_fname) as full_name
FROM
    authors a
        INNER JOIN
    (SELECT 
        t.au_id, COUNT(*) AS book_count
    FROM
        titleauthor as t
    GROUP BY t.au_id
    HAVING count(*)> 1) AS t ON a.au_id = t.au_id;
        
        

-- 4. List all authors and the number of books they have written.
SELECT 
    a.au_id,
    t.book_count,
    CONCAT(a.au_lname, ' ', a.au_fname) AS full_name
FROM
    authors a
        left JOIN
    (SELECT 
        au_id, COUNT(*) AS book_count
    FROM
        titleauthor t
    GROUP BY au_id) AS t ON a.au_id = t.au_id
    order by t.book_count Desc;
    





-- 5. Find the titles with a price higher than the average price.

SELECT 
    title_id, title, price, (select avg(price) from titles)
FROM
    titles
WHERE
    price > (SELECT 
            AVG(price)
        FROM
            titles);


-- 6. Find the name of the publisher who has published the most books.

SELECT 
    p.pub_id, p.pub_name, t.book_count
FROM
    publishers AS p
        LEFT JOIN
    (SELECT 
        ta.pub_id, COUNT(*) AS book_count
    FROM
        titles AS ta
    GROUP BY ta.pub_id) AS t ON t.pub_id = p.pub_id
ORDER BY t.book_count DESC
LIMIT 1;
    


-- 7. List the titles that have never been sold.


SELECT 
    t.title_id, t.title
FROM
    titles t
        LEFT JOIN
    sales s ON t.title_id = s.title_id
WHERE
    s.title_id IS NULL;

-- 8. List all titles along with their publisher's name.

SELECT 
    t.title_id, 
    t.title,
    t.pub_id, 
    p.pub_name
FROM
    titles t
        LEFT JOIN
    publishers p ON p.pub_id = t.pub_id;
    
  -- 2nd method
 
 SELECT 
    t.title_id,
    t.pub_id, 
    t.title,
    (
        SELECT p.pub_name
        FROM publishers p
        WHERE p.pub_id = t.pub_id
    ) AS pub_name
FROM titles t;


-- 9. List the employees who have the same job as 'Helen Bennett'.
SELECT 
    emp_id, CONCAT(fname, ' ', lname) AS full_name, job_id
FROM
    employee
WHERE
    job_id = 12;
 
 
 -- 2nd method 
   
   SELECT 
    emp_id, CONCAT(fname, ' ', lname) AS full_name, job_id
FROM
    employee
WHERE
    job_id = (SELECT 
            job_id
        FROM
            employee
        WHERE
            fname = 'Helen' AND lname = 'Bennett');

