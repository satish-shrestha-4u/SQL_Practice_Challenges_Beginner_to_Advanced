/******************************************************************************
*******************************************************************************

SQL CHALLENGES 9

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. Add a column showing how many characters are in each author's last name
SELECT 
    au_lname, LENGTH(au_lname) AS length_car_aulname
FROM
    authors;
    
    
-- 2. What is the first name of each author in uppercase?
SELECT 
    au_fname, UPPER(au_fname) AS Cap_au_fname
FROM
    authors;

-- 3. Combine first and last names of authors into a single column.
SELECT 
    au_fname,
    au_lname,
    CONCAT(au_fname, ' ', au_lname) AS full_name
FROM
    authors;

-- 4. Show the current date in a column called 'today'.

SELECT CURRENT_DATE() AS today;

-- 5. Calculate the difference in days between a book's publication date and today's date.
SELECT 
    title,
    pubdate,
    DATEDIFF(CURRENT_DATE(), pubdate) AS days_since_published
FROM
    titles
ORDER BY days_since_published ASC;

-- 6. How many years has it been since each title was published?
    
    SELECT 
    title,
    pubdate,
    TIMESTAMPDIFF(YEAR,
        pubdate,
        CURRENT_DATE()) AS years_since_published
FROM
    titles
ORDER BY years_since_published ASC;


-- 7. Find the publication year and month of each title in 'YYYY-MM' format.   
SELECT 
   title,
   pubdate, 
   DATE_FORMAT(pubdate,'%Y-%m') AS YYYY_MM
FROM
    titles
ORDER BY YYYY_MM DESC;

-- 8. Concatenate the publisher's name and city into a single column. Separate them with a comma.
SELECT 
    pub_name, city, CONCAT(pub_name, ',', city) AS Single_column
FROM
    publishers;

-- 9. What is the longest title of a book?
SELECT 
    title, LENGTH(title) AS title_length
FROM
    titles
ORDER BY title_length DESC
LIMIT 1;

-- 2nd method
SELECT 
    MAX(LENGTH(title)) AS max_title_length
FROM
    titles;

-- 10. Display the publication date of each title in 'Day-Month-Year' format. For example, '12-June-1991'.
    SELECT 
    pubdate, title, DATE_FORMAT(pubdate, '%d-%M-%Y') as formated_pubdate
FROM
    titles;
    
-- 11. List authors whose last name starts with 'C' and show the first 5 characters of their address.
    
SELECT 
    au_lname,
    au_fname,
    LEFT(address, 5) AS five_c_address
FROM
    authors
WHERE
    au_lname LIKE 'C%';
    
    
    -- 2nd method
    
SELECT 
    au_fname,
    au_lname,
    SUBSTRING(address, 1, 5) AS address_start
FROM
    authors
WHERE
    au_lname LIKE 'C%';
-- 12. Return the difference in days between the current date and the publication date of titles where the difference is greater than 1000 days.

SELECT 
    title, pubdate, DATEDIFF(CURRENT_DATE, pubdate) AS diff
FROM
    titles
HAVING diff > 1000;

-- 13. Find the titles where the length of the title name is greater than the average length of all titles.
SELECT 
    title,
    LENGTH(title) AS title_length,
    (SELECT 
        AVG(LENGTH(title))
    FROM
        titles) as avg_value
    
FROM
    titles
having LENGTH(title) > (SELECT 
        AVG(LENGTH(title))
    FROM
        titles);
        
-- 2nd method
SELECT 
    title
FROM
    titles
WHERE
    LENGTH(title) > (SELECT 
            AVG(LENGTH(title))
        FROM
            titles);


-- 14. Get the authors whose first name length is equal to their last name length.
    SELECT 
    au_fname, au_lname, LENGTH(au_fname), LENGTH(au_lname)
FROM
    authors
WHERE
    LENGTH(au_fname) = LENGTH(au_lname);

-- 15. Find the longest city name among the authors' addresses.
SELECT 
    city, LENGTH(city), address
FROM
    authors
    order by length(city) desc
    limit 2;

-- 2nd method
 SELECT 
    city, LENGTH(city), address
FROM
    authors
WHERE
    LENGTH(city) = (SELECT 
            MAX(LENGTH(city))
        FROM
            authors);


-- 16. Display titles and their publication dates formatted as 'Day of the Week, Month Day, Year'. For example, 'Wednesday, June 12, 1991'.
    SELECT 
    title, pubdate, DATE_FORMAT(pubdate, '%W,%M %e,%Y')
FROM
    titles;

-- 17. Calculate the difference in days between the first and last publication date for each author.
SELECT 
    a.au_id,
    CONCAT(a.au_fname, ' ', a.au_lname) AS full_name,
    max(t.pubdate) as first_date,
    min(t.pubdate) as last_date,
    DATEDIFF(MAX(t.pubdate), MIN(t.pubdate)) AS diff_days
FROM
    authors a
        JOIN
    titleauthor ta ON ta.au_id = a.au_id
        JOIN
    titles t ON ta.title_id = t.title_id
GROUP BY a.au_id;

