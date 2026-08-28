  -- CREATE DATABASE 

CREATE DATABASE onlinebookstore;


-- Create table Books
 
CREATE TABLE books(
Book_ID SERIAL PRIMARY KEY,
Title VARCHAR(100),
Author VARCHAR(100),
Genre VARCHAR(50),
Published_Year int,
Price Numeric(10,2),
Stock INT);


-- Create table customers

CREATE TABLE Customers(
Customer_ID SERIAL PRIMARY KEY,
Name VARCHAR(100),
Email VARCHAR(100),
Phone VARCHAR(15),
City VARCHAR(50),
Country VARCHAR(100));


-- Create Table Orders

CREATE TABLE Orders(
Order_ID  SERIAL PRIMARY KEY,
Customer_ID INT REFERENCES Customers(Customer_ID),
Book_ID INT REFERENCES Books(Book_ID),
Order_date DATE,
Quantity INT,
Total_Amount NUMERIC(10,2));


SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;


-- Import Data into Books Table

COPY Books
FROM 'D:\SQL RAW DATA\Books.csv' CSV HEADER;


-- Import Data into Customers Table

COPY Customers
FROM 'D:\SQL RAW DATA\Customers.csv' CSV HEADER;

--Import Data into Orders Table

COPY Orders
FROM 'D:\SQL RAW DATA\Orders.csv' CSV HEADER;
 
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

   
           ----BASIC QUERY SOLVED----

  
-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM BOOKS
WHERE GENRE ='Fiction';

-- 2) Find books published after the year 1950:

SELECT * FROM BOOKS
WHERE Published_year >1950

-- 3) List all customers from the Canada:

SELECT * FROM Customers
WHERE COUNTRY ='Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE order_date BETWEEN '01-11-2023' AND '30-11-2023';

-- 5) Retrieve the total stock of books available:

SELECT SUM(STOCK) TOTAL_STOCK FROM BOOKS;

-- 6) Find the details of the most expensive book:

SELECT * FROM BOOKS
ORDER BY PRICE DESC 
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM ORDERS
WHERE Quantity > 1
ORDER BY QUANTITY ASC ;


-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM ORDERS
WHERE Total_Amount > 20
ORDER BY TOTAL_AMOUNT ASC;

-- 9) List all genres available in the Books table:

SELECT DISTINCT GENRE FROM BOOKS;


-- 10) Find the book with the lowest stock:

SELECT * FROM BOOKS
ORDER BY STOCK ASC
LIMIT 1;


-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) AS REVENUE FROM ORDERS;

          ---- ADVANCE QUERY SOLVED----

-- 1) Retrieve the total number of books sold for each genre:

SELECT B.GENRE,SUM(O.QUANTITY) AS TOTAL_BOOK_SOLD
FROM ORDERS O
JOIN BOOKS B
ON O.BOOK_ID = B.BOOK_ID
GROUP BY B. GENRE;


-- 2) Find the average price of books in the "Fantasy" genre:

SELECT AVG(PRICE) AVG_PRICE_FANTASY FROM BOOKS
WHERE GENRE ='Fantasy';

-- 3) List customers who have placed at least 2 orders:

SELECT C.NAME,COUNT(O.ORDER_ID) PLACED_ORDERS
FROM ORDERS O JOIN CUSTOMERS C
ON O.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.NAME
HAVING COUNT(O.ORDER_ID) >= 2;

-- 4) Find the most frequently ordered book:

SELECT B.TITLE,O.BOOK_ID,COUNT(O.ORDER_ID) AS FREQUENTLY_ORDERS
FROM ORDERS O JOIN BOOKS B
ON O.BOOK_ID = B.BOOK_ID
GROUP BY O.BOOK_ID,B.TITLE
ORDER BY  FREQUENTLY_ORDERS DESC
LIMIT 1;


-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

SELECT BOOK_ID, TITLE,AUTHOR,GENRE,PRICE FROM BOOKS
WHERE GENRE = 'Fantasy'
ORDER BY PRICE DESC
LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:

SELECT B.AUTHOR,SUM(O.QUANTITY) BOOK_SOLD
FROM BOOKS B JOIN ORDERS O
ON O.BOOK_ID = B. BOOK_ID 
GROUP BY B. AUTHOR
ORDER BY SUM(O.QUANTITY) DESC;

-- 7) List the cities where customers who spent over $30 are located:

SELECT DISTINCT C.CITY,O.TOTAL_AMOUNT
FROM ORDERS O JOIN CUSTOMERS C
ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE TOTAL_AMOUNT>= 30;


-- 8) Find the customer who spent the most on orders:

SELECT C.CUSTOMER_ID,C.NAME,SUM(O.ORDER_ID),SUM(O.TOTAL_AMOUNT) TOTAL_SPENT
FROM ORDERS O JOIN CUSTOMERS C
ON O.CUSTOMER_ID=C.CUSTOMER_ID
GROUP BY C.NAME,C.CUSTOMER_ID
ORDER BY SUM(TOTAL_AMOUNT) DESC
LIMIT 1;


































































