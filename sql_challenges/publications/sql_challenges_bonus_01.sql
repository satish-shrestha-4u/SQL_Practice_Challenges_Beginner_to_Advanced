/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES bonus 1

*******************************************************************************
*******************************************************************************

In the exercises below you might need to use the any of the clauses learend so 
far.

*/

USE publications;

/* 1. Select the top 5 orders with most quantity sold between 1993-03-11 and
    1994-09-13 from the table sales */

SELECT 
    ord_num, sum(qty) as total_qty
FROM
    sales
WHERE
    ord_date BETWEEN '1993-03-11' AND '1994-09-13'
group by ord_num
ORDER BY total_qty DESC
LIMIT 5;



/* 2. How many authors have an "i" in their first name, are from Utah,
   Maryland, or Kansas? */

SELECT 
    * -- can also use count(*)
FROM
    authors
WHERE
    au_fname like '%i%'
        AND 
        state In ('ut', 'md' , 'ks');
        



/* 3. In California, how many authors are there in cities that contain an "o"
   in the name?
   - Show only results for cities with more than 1 author.
   - Sort the cities ascendingly by author count.
*/
SELECT 
    state, city, COUNT(*) AS au_count
FROM
    authors
WHERE
   state='ca' and city LIKE '%o%'
GROUP BY city
HAVING au_count > 1
ORDER BY au_count ASC;



