/******************************************************************************
*******************************************************************************

SQL CHALLENGES bonus 2

*******************************************************************************
*******************************************************************************/

USE publications;

-- 1. Using LEFT JOIN: in which cities has "Is Anger the Enemy?" been sold?


SELECT DISTINCT
    (st.city)
FROM
    stores AS st
        LEFT JOIN
    sales AS s ON s.stor_id = st.stor_id
        LEFT JOIN
    titles AS t ON t.title_id = s.title_id
WHERE
    t.title = 'Is Anger the Enemy?';
     


/* 2. Select all the book titles that have a link to the employee Howard Snyder 
    (he works for the publisher that has published those books). */

SELECT 
    t.title, t.title_id, e.fname,e.lname
FROM
    titles t
        LEFT JOIN
    employee e ON t.pub_id = e.pub_id
WHERE
    e.fname = 'Howard'
        AND e.lname = 'Snyder';  
        

/* 3. Using the JOIN of your choice: Select the book title with highest number of 
   sales (qty) */

SELECT 
    t.title, sum(s.qty) as total_sold
FROM
    titles t
        left JOIN
    sales s ON t.title_id = s.title_id
GROUP BY t.title
ORDER BY total_sold desc
limit 1;


/* 4. Select all book titles and the full name of their author(s).
      
      - If a book has multiple authors, all authors must be displayed (in 
      multiple rows).
      
      - Books with no authors and authors with no books should not be displayed.
*/
SELECT 
    t.title, CONCAT(au_fname, ' ', au_lname) AS full_name
FROM
    titles t
        INNER JOIN
    titleauthor ta ON ta.title_id = t.title_id
        INNER JOIN
    authors a ON a.au_id = ta.au_id;


/* 5. Select the full name of authors of Psychology books

   Bonus hint: if you want to prevent duplicates but allow authors with shared
   last names to be displayed, you can concatenate the first and last names
   with CONCAT(), and use the DISTINCT clause on the concatenated names. */

SELECT DISTINCT
    CONCAT(au_fname, ' ', au_lname) AS full_name
FROM
    authors a
        INNER JOIN
    titleauthor ta ON a.au_id = ta.au_id
        INNER JOIN
    titles t ON t.title_id = ta.title_id
WHERE
    t.type = 'psychology';
    
    

/* 6. Explore the table roysched and try to grasp the meaning of each column. 
   The notes below will help:
   
   - "Royalty" means the percentage of the sale price paid to the author(s).
   
   - Sometimes, the royalty may be smaller for the first few sales (which have
     to cover the publishing costs to the publisher) but higher for the sales 
     above a certain threshold.
     
   - In the "roysched" table each title_id can appear multiple times, with
     different royalty values for each range of sales.
     
   - Select all rows for particular title_id, for example "BU1111", and explore
	 the data. */

SELECT 
    *
FROM
    roysched
WHERE
    title_id ='BU1111';

/* 7. Select all the book titles and the maximum royalty they can reach.
    Display only titles that are present in the roysched table. */
    
SELECT 
    t.title, r.title_id, MAX(r.royalty) AS max_royalty
FROM
    roysched r
        INNER JOIN
    titles t ON t.title_id = r.title_id
GROUP BY r.title_id
ORDER BY max_royalty DESC;

