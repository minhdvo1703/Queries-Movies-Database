############################### ASSIGNMENT 3 ###################################
# Name: MINH VO
# Date: 10/19/2022

####### INSTRUCTIONS #######

# Read through the whole template and read each question carefully.  Make sure to follow all instructions.

# Each question should be answered with only one SQL query per question
# All queries must be written below the corresponding question number.
# Make sure to include the schema name in all table references (i.e. sakila.customer, not just customer)
# DO NOT modify the comment text or add additional comments unless asked.
# If a question asks for specific columns and/or column aliases, they must be followed.
# Pay attention to the requested column aliases for aggregations and calculations. Otherwise, do not re-alias columns from the original column names in the tables unless asked to do so.
# Do not concatenate columns together unless asked.

# Refer to the Sakila documentation for further information about the tables, views, and columns: https://dev.mysql.com/doc/sakila/en/

#########################################################################

## Desc: Manipulating, Categorizing, Sorting and Grouping & Summarizing Data

############################### PREREQUESITES ############################

# Run the following two SQL statements before beginning the questions:
SET SQL_SAFE_UPDATES=0;
UPDATE sakila.film SET language_id=6 WHERE title LIKE "%ACADEMY%";
DROP TABLE IF EXISTS sakila.payment_type;

############################### QUESTION 1 ###############################
USE SAKILA;
# 1a) Count the total number of records in the actor table.  Alias the result column as count_records.
SELECT COUNT(*) AS COUNT_RECORDS FROM SAKILA.ACTOR;
# 1b) List is the first name and last name of all the actors in the actor table.
SELECT FIRST_NAME,LAST_NAME FROM SAKILA.ACTOR;
# 1c) Insert a new record into the actors table with your first name and the first letter of your last name (not your full last name).
INSERT INTO ACTOR (`first_name`,`last_name`) VALUES
('MINH','V');

# 1d) Update the record you inserted just into the actors table, and change the first letter of your last name to your full last name.  Make sure to only update that one record.
UPDATE SAKILA.ACTOR
SET LAST_NAME = 'VO'
WHERE FIRST_NAME = 'MINH';

# 1e) Delete the record from the actor table that you just entered.  Make sure to only delete that one record.
DELETE FROM SAKILA.ACTOR
WHERE FIRST_NAME = 'MINH'
AND LAST_NAME = 'VO';

# 1f) Create a table payment_type with the following specifications and appropriate data types
## Table Name : “payment_type”
## Primary Key: "payment_type_id” (auto incrementing, not null)
## Column: “type” (not null)
CREATE TABLE `payment_type` (
	`payment_type_id` INT AUTO_INCREMENT NOT NULL,
    `type` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`payment_type_id`)
);

# 1g) Insert the following rows in to the payment_type table: 1, “Credit Card” ; 2, “Cash”; 3, “Paypal” ; 4 , “Cheque”
## Note: Make use of the auto-incrementing primary key.
INSERT INTO PAYMENT_TYPE (`payment_type_id`,`type`) VALUES 
(1,'Credit Card'),
(2,'Cash'),
(3,'Paypal'),
(4,'Cheque');

# 1h) Rename table payment_type to payment_types.
RENAME TABLE payment_type TO payment_types;

# 1i) Drop the table payment_types.
DROP TABLE PAYMENT_TYPES;

############################### QUESTION 2 ###############################

# 2a) List the title and description of all movies rated PG-13.
SELECT TITLE, DESCRIPTION FROM SAKILA.FILM
WHERE RATING = 'PG-13';

# 2b) List the title of all movies that are either PG OR PG-13, using IN operator.
SELECT TITLE 
FROM SAKILA.FILM
WHERE RATING IN ('PG','PG-13');

# 2c) Report the payment_id and payment amount for all payments greater than or equal to $2 and less than or equal to $7, using the BETWEEN operator.
SELECT PAYMENT_ID, AMOUNT 
FROM SAKILA.PAYMENT
WHERE AMOUNT BETWEEN 2 AND 7;

# 2d) List all addresses that have phone number that contain digits 589, start with 140, or end with 323.  Return all columns in the address table for the matching records.
SELECT * FROM SAKILA.ADDRESS
WHERE PHONE LIKE '%589%'
OR PHONE LIKE '140%'
OR PHONE LIKE '%323';

# 2e) List all staff members (first name, last name, email) whose password is NULL
SELECT FIRST_NAME, LAST_NAME, EMAIL
FROM SAKILA.STAFF
WHERE PASSWORD IS NULL;

# 2f) Select all films that have titles containing the word ZOO and have a rental duration greater than or equal to 4.  Return the title and rental duration.
SELECT TITLE, RENTAL_DURATION 
FROM SAKILA.FILM
WHERE TITLE LIKE '%ZOO%'
AND RENTAL_DURATION >= 4;

# 2g) What is the cost of renting the movie ACADEMY DINOSAUR for 12 days?  Aias the calculated column as rental_cost.
# Note: the rental_rate is per the number of days specified in rental_duration. See the Sakila documentation for more information about the columns.
SELECT RENTAL_RATE*12
FROM SAKILA.FILM
WHERE TITLE = 'ACADEMY DINOSAUR';

# 2h) List all the unique cities in the address table.
SELECT DISTINCT CITY FROM SAKILA.CITY;

# 2i) List the first name, last name, and customer ID of the top 10 newest customers across all stores.
SELECT FIRST_NAME,LAST_NAME,CUSTOMER_ID,CREATE_DATE 
FROM SAKILA.CUSTOMER
ORDER BY CREATE_DATE DESC
LIMIT 10;

############################### QUESTION 3 ###############################

# 3a) What is the minimum payment received and max payment received across all transactions?  Alias the result columns as min_payment and max_payment.
SELECT MIN(AMOUNT) AS MIN_PAYMENT, MAX(AMOUNT) AS MAX_PAYMENT 
FROM SAKILA.PAYMENT;

# 3b) How many customers rented movies between Feb 2005 & May 2005 (based on rental_date)? Alias the result column as num_customers.
SELECT  COUNT(DISTINCT CUSTOMER_ID) AS NUM_CUSTOMERS FROM SAKILA.RENTAL
WHERE RENTAL_DATE BETWEEN '2005-02-01' AND '2005-05-31';

# 3c) List all movies where replacement_cost is greater than $15 OR the rental_duration is between 6 & 10 days. Return the title, replacement_cost, and rental_duration.
SELECT TITLE,REPLACEMENT_COST,RENTAL_DURATION 
FROM SAKILA.FILM
WHERE (REPLACEMENT_COST > 15)
OR (RENTAL_DURATION BETWEEN 6 AND 10);

# 3d) What is the total amount spent by customers to rent movies in the year 2005? Alias the result column as total_spent.
SELECT SUM(AMOUNT) AS TOTAL_SPENT FROM SAKILA.PAYMENT
WHERE YEAR(PAYMENT_DATE) = 2005;

# 3e) What is the average replacement cost across all movies? Alias the result column as avg_replacement_cost.
SELECT AVG(REPLACEMENT_COST) AS AVG_REPLACEMENT_COST
FROM SAKILA.FILM;

# 3f) What is the standard deviation of rental rate across all movies? Alias the result column as std_rental_rate.
SELECT STD(RENTAL_RATE) AS STD_RENTAL_RATE
FROM SAKILA.FILM;

# 3g) What is the midrange of the rental duration for all movies? Alias the result as midrange_duration.
SELECT (MAX(RENTAL_DURATION)+MIN(RENTAL_DURATION))/2 AS MIDRANGE_DURATION
FROM SAKILA.FILM;

############################### QUESTION 4 ###############################

# 4a) List the count of movies that are either G, NC-17, PG-13, PG, or R, grouped by rating. Alias the count column as movie_count
SELECT RATING,COUNT(*) AS MOVIE_COUNT 
FROM SAKILA.FILM
GROUP BY RATING;

# 4b) Find the movies where rental rate is greater than $1 and order result set by descending order. Return the movie title and rental rate.
SELECT TITLE,RENTAL_RATE 
FROM SAKILA.FILM
WHERE RENTAL_RATE > 1
ORDER BY RENTAL_RATE DESC;

# 4c) Find the top 2 movies rated R that have the highest replacement costs.  Return the movie title, rating, and replacement cost.  If you need to break a tie between multiple movies with the same highest replacment cost, use additional alphabetical ordering by title.
SELECT TITLE,RATING,REPLACEMENT_COST 
FROM SAKILA.FILM
WHERE RATING = 'R'
ORDER BY REPLACEMENT_COST DESC, TITLE ASC
LIMIT 2;

# 4d) Find the most frequently occurring (mode) rental rate across products.  Return only the rental rate, aliased as mode_rental_rate
SELECT RENTAL_RATE AS MODE_RENTAL_RATE 
FROM SAKILA.FILM
GROUP BY RENTAL_RATE
ORDER BY COUNT(RENTAL_RATE) DESC
LIMIT 1;

# 4e) Find the top 2 longest movies with movie length greater than 50 mins AND which has commentaries as a special features. Return the movie title and length.  If you need to break a tie between multiple movies with the same length, use additional alphabetical ordering by title.
SELECT TITLE, LENGTH, SPECIAL_FEATURES
FROM SAKILA.FILM
WHERE LENGTH > 50
AND SPECIAL_FEATURES LIKE '%COMMENTARIES%'
ORDER BY LENGTH DESC, TITLE ASC
LIMIT 2;

# 4f) List the top 5 movies (in alphabetical order) whose titles start with Z, are NOT rated R, and have a rental duration less than 7 days.  Use a not-equals operator to filter the rating.  Return the movie title, rating, and rental duration.
SELECT TITLE, RATING, RENTAL_DURATION
FROM SAKILA.FILM
WHERE TITLE LIKE 'Z%'
AND RATING != 'R'
AND RENTAL_DURATION < 7
ORDER BY TITLE
LIMIT 5;