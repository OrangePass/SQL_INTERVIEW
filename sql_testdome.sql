SQLite 3.28
-- Given the following data definition, write a query that returns the number of students whose first name is John. String comparisons should be case sensitive.

TABLE students
   id INTEGER PRIMARY KEY,
   firstName VARCHAR(30) NOT NULL,
   lastName VARCHAR(30) NOT NULL

SELECT COUNT(*) FROM students WHERE firstName = "John"

A table containing the students enrolled in a yearly course has incorrect data in records with ids between 20 and 100 (inclusive).

TABLE enrollments
  id INTEGER NOT NULL PRIMARY KEY
  year INTEGER NOT NULL
  studentId INTEGER NOT NULL

Update enrollments Set year = 2015 Where id >= 20 And id <= 100

Each item in a web shop belongs to a seller. To ensure service quality, each seller has a rating.

The data are kept in the following two tables:

TABLE sellers
  id INTEGER PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  rating INTEGER NOT NULL

TABLE items
  id INTEGER PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  sellerId INTEGER REFERENCES sellers(id)

Write a query that selects the item name and the name of its seller for each item that belongs to a seller with a rating greater than 4. The query should return the name of the item as the first column and name of the seller as the second column.

SELECT items.name, sellers.name
FROM items
inner JOIN sellers
    on items.sellerId=sellers.id
WHERE rating > 4
ORDER BY sellerId

Information about pets is kept in two separate tables:

TABLE dogs
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL

TABLE cats
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(50) NOT NULL

Write a query that select all distinct pet names.

SELECT name FROM dogs
UNION
SELECT name FROM cats


Employee Manager

Given the following data definition, write a query that selects the names of all employees and the names of their managers. If there is no manager for an employee, return NULL. Managers are considered to be employees as well.

TABLE employees
  id INTEGER NOT NULL PRIMARY KEY
  mgrId INTEGER REFERENCES employees(id)
  name VARCHAR(30) NOT NULL

SELECT
    e1.name employer,
    e2.name manager
FROM
    employees e1
LEFT JOIN employees e2 ON e2.id = e1.mgrId
ORDER BY
    manager;

Poll

The results of a poll are kept in the following table:

TABLE poll
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  answer CHAR(1)

SELECT name
FROM poll
WHERE name LIKE 'N%' AND answer LIKE '%Y%' IS NOT TRUE

Menu Items

Create a table for the main menu of a website showing menu items. The table should be called menuItems and contain following fields:

id - an integer which is also primary key
title - VARCHAR of size 30
url - VARCHAR of size 100
The following should also be true:

Each menu item is required to have both a title and URL.
There are no two menu items with the same URL.

CREATE TABLE menuItems(
  id INTEGER NOT NULL PRIMARY KEY,
  title VARCHAR(30) NOT NULL,
  url VARCHAR(100) NOT NULL UNIQUE
)

Youngest Child

Information about people and their parents are stored in the following table:

TABLE people
  id INTEGER NOT NULL PRIMARY KEY
  motherId INTEGER REFERENCES people(id)
  fatherId INTEGER REFERENCES people(id)
  name VARCHAR(30) NOT NULL
  age INTEGER NOT NULL

Write a query that selects the names of all parents together with the age of their youngest child.

id    motherId    fatherId    name    age    
-----------------------------------------
1                             Adam    50     
2                             Eve     50     
3     2           1           Cain    30     
4     2           1           Seth    20     

SELECT p.NAME      AS NAME, 
       Min(pp.age) AS age 
FROM   people AS p 
       JOIN people AS pp 
         ON ( p.id = pp.motherid 
               OR p.id = pp.fatherid ) 
GROUP  BY p.id 
ORDER  BY pp.age; 

CREATE TABLE people (
  id INTEGER NOT NULL PRIMARY KEY,
  motherId INTEGER REFERENCES people(id),
  fatherId INTEGER REFERENCES people(id),
  name VARCHAR(30) NOT NULL,
  age INTEGER NOT NULL
);

INSERT INTO people(id, motherId, fatherId, name, age) VALUES(1, NULL, NULL, 'Adam', 50);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(2, NULL, NULL, 'Eve', 50);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(3, NULL, NULL, 'Fuxi', 50);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(4, NULL, NULL, 'Nvwa', 50);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(5, 2, 1, 'Cain', 30);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(6, 2, 1, 'Seth', 20);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(7, 2, 3, 'Seth', 10);
INSERT INTO people(id, motherId, fatherId, name, age) VALUES(8, 4, 1, 'Seth', 8);

select 
    m.name,
    f.name,
    min(y.age)
from
people y join people m
    on y.motherid=m.id
join people f
    on y.fatherid=f.id
where coalesce(y.motherid,y.fatherid) is not null
group by
    m.name,f.name

A school tracks its extracurricular activities using the following table structure:

TABLE students
  id INTEGER NOT NULL PRIMARY KEY
  name VARCHAR(30) NOT NULL

TABLE studentsActivities
  studentId INTEGER NOT NULL,
  activity VARCHAR(30) NOT NULL,
  PRIMARY KEY (studentId, activity),
  FOREIGN KEY (studentId) REFERENCES students(id)

Write a query that returns the names of students that take either the "Tennis" or "Football" activity.

SELECT NAME 
FROM   students 
WHERE  students.id IN (SELECT studentid 
                       FROM   studentsactivities 
                       WHERE  activity = 'Tennis' 
                               OR activity = 'Football'); 

Tasks
A project management tool keeps data in the following two tables:

TABLE employees
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL

TABLE tasks
  id INTEGER NOT NULL PRIMARY KEY,
  authorId INTEGER NOT NULL REFERENCES employees (id),
  assigneeId INTEGER REFERENCES employees (id)
Write a query that selects task id, author name and assignee name for each task. If there is no assignee for a task, the query should return null instead of the assignee name.

SELECT e1.id, 
       e2.NAME AS author, 
       e1.NAME AS assignee 
FROM   (SELECT tasks.id, 
               tasks.authorid, 
               employees.NAME 
        FROM   tasks 
               LEFT JOIN employees 
                      ON tasks.assigneeid = employees.id) AS e1 
       JOIN employees AS e2 
         ON e1.authorid = e2.id

Restaurant Menu
A restaurant stores its menu in the following table:

TABLE menu
  itemName VARCHAR(50) PRIMARY KEY NOT NULL,
  category VARCHAR(50) NOT NULL,  
  price DECIMAL(5,2)
Write an update statement that will increase the price of all menu items that are in either the "Soups" or "Salads" categories by 10%.

UPDATE menu
SET price = price * 1.1
WHERE category = "Soups" OR category = "Salads"

Bank Branches

A bank keeps a list of its branches in a table named branches.

Modify the provided SQLite create table statement so that:

The address and customerType fields are mandatory.
customerType must be set to either "R", "B", or "RB" (corresponding to Retail, Business, or both Retail and Business).
If openingHour is not explicitly specified when adding new branch, 8 should be used.
If closingHour is not explicitly specified when adding new branch, 19 should be used.

CREATE TABLE branches 
  ( 
     id           INTEGER PRIMARY KEY, 
     address      VARCHAR(100) NOT NULL, 
     customertype VARCHAR(2) NOT NULL CHECK (customertype IN ('R', 'B', 'RB')), 
     openinghour  INTEGER DEFAULT 8, 
     closinghour  INTEGER DEFAULT 19 
  );

 Hospital Patients

 The table patients contains general patient information. Modify the provided SQLite create table statement so that:

The id column should be the primary key.
There should be no way of adding two patients with the same social security number.
There should be no way of adding two patients with both the same family doctor and the same patient record index.

CREATE TABLE branches 
  ( 
     id           INTEGER PRIMARY KEY, 
     address      VARCHAR(100) NOT NULL, 
     customertype VARCHAR(2) NOT NULL CHECK (customertype IN ('R', 'B', 'RB')), 
     openinghour  INTEGER DEFAULT 8, 
     closinghour  INTEGER DEFAULT 19 
  ); 

Cheapest Product

Given the following data definition, write a query that selects all the product names which have the lowest price:

TABLE products
  id INTEGER NOT NULL PRIMARY KEY
  name VARCHAR(30) NOT NULL
  price INTEGER NOT NULL

SELECT NAME 
FROM   products 
WHERE  price = (SELECT Min(price) 
                FROM   products); 

Countries

The following table contains companies and the country of their headquarters:

TABLE companies
  id INTEGER PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  country VARCHAR(30) NOT NULL

Write a query that will return all countries, without duplication, in alphabetical order.

SELECT DISTINCT country 
FROM   companies 
ORDER  BY country ASC; 

Ingredients

A restaurant keeps track of the ingredients used in each recipe using the following two tables:

TABLE recipes
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL,
  cost DECIMAL(5, 2) NOT NULL

TABLE ingredients
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL,
  recipeId INTEGER NOT NULL REFERENCES recipes(id)

Write an update query that will increase by $2 the cost of all recipes, that have an ingredient whose name exactly matches "tuna".

UPDATE recipes 
SET    cost = cost + 2 
WHERE  id IN (SELECT recipeid 
              FROM   ingredients 
              WHERE  NAME = 'tuna') 


Transactions

Given the following data definition, write a query that selects all customer names together with the number of transactions that they made. Customers with no transactions should be included as customers with 0 transactions.

TABLE customers
  id INTEGER NOT NULL PRIMARY KEY
  name VARCHAR(30) NOT NULL

TABLE transactions
  id INTEGER NOT NULL PRIMARY KEY
  customerId INTEGER REFERENCES customers(id)
  amount DECIMAL(15,2) NOT NULL

SELECT c.name, 
       Count(t.customerId ) 
FROM   customers c 
       LEFT JOIN transactions t 
              ON c.id = t.customerId
GROUP  BY c.id;


Ban Users

Users of an online bulletin board are kept in table users:

TABLE users
  id INTEGER PRIMARY KEY NOT NULL,
  email VARCHAR(50) NOT NULL,
  passwordHash VARCHAR(60) NOT NULL
Site admins need to be able to ban users. Write a statement that will alter the table and add a column named banned with the following properties:

The type must be integer.
The default value is 0.
The only allowed values are 0 and 1.

ALTER TABLE users
ADD banned INTEGER DEFAULT 0 NOT NULL CHECK (banned IN (0, 1));

Delete Orders

Customers and their orders are stored in the following two tables:

TABLE customers
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(50),
  balance DECIMAL(10,2)

TABLE orders
  id INTEGER PRIMARY KEY NOT NULL,
  customerId INTEGER NOT NULL REFERENCES customers(id),
  product VARCHAR(100)

Delete the orders of any customer whose balance is negative.

DELETE FROM orders 
WHERE  customerid IN (SELECT id 
                      FROM   customers 
                      WHERE  balance < 0); 


ATM Locations

An online map of ATMs needs to store the location of each machine in a database table. Create a database table named locations that can store the data in the table below, using appropriate columns.

CREATE TABLE locations 
  ( 
     id        INTEGER PRIMARY KEY, 
     address   VARCHAR(50), 
     latitude  FLOAT NOT NULL, 
     longitude FLOAT NOT NULL 
  ) 

Department Report

A company tracks which employees are in its various departments using the following two tables:

TABLE departments
  id INTEGER PRIMARY KEY NOT NULL,
  name VARCHAR(50) NOT NULL
  
TABLE employees
  id INTEGER PRIMARY KEY NOT NULL,
  departmentId INTEGER NOT NULL REFERENCES departments(id),
  name VARCHAR(50) NOT NULL
Populate the empty table departmentReport, defined below, with the total number of employees in each department.

TABLE departmentReport
  departmentName VARCHAR(50) NOT NULL,
  employeeCount INTEGER NOT NULL

INSERT INTO departmentreport (departmentname, employeecount) 
SELECT d.NAME, 
       Count(e.departmentid ) 
FROM   departments d 
       LEFT JOIN employees e 
              ON d.id = e.departmentid
GROUP  BY d.id; 


Developers

The developers table contains a single name column. This column has been populated by hand and contains erroneous data, including inaccurate letter case, and leading/trailing whitespace. 

Executing the query should return all developers whose name contains 'John', regardless of letter case, and with all leading/trailing whitespace removed, however it currently returns no results. 

Fix the bugs.

SELECT TRIM(name) AS name 
FROM developers 
WHERE UPPER(name) LIKE '%JOHN%';

Student Max Score

Consider the following table definition:

TABLE students
  id INTEGER PRIMARY KEY
  name VARCHAR(255) NOT NULL
  score INTEGER NOT NULL
  class INTEGER NOT NULL

Write a query that, efficiently with respect to time used, returns the result with the name, score, and class of all the students who scored highest in their respective classes.

SELECT s1.NAME, 
       s1.score, 
       s1.class 
FROM   students s1 
       JOIN (SELECT score, 
                    class 
             FROM   students 
             GROUP  BY class 
             HAVING score = Max(score)) s2 
         ON s1.score = s2.score 
            AND s1.class = s2.class 

Authors

--Given the following data definition, select the name of all authors whose name starts with the letter 'N', and who've published more than 30 books or are under 30 years old:

TABLE authors
  name VARCHAR(30) NOT NULL PRIMARY KEY
  books INTEGER NOT NULL
  age INTEGER NOT NULL

SELECT name
FROM authors
WHERE name LIKE 'N%' AND (books > 30 OR age < 30);

Merge Stock Index

Two financial stock indexes, FSIA and FSIB, each contain a different, unique set of companies. Each index is stored in a separate table with different schema definitions. The FSIA provides only the market capitalization of the companies. The FSIB provides the share price and shares outstanding. Market capitalization can be calculated as follows: Share Price * Shares Outstanding.

The table schema:

TABLE fsia
  companyName VARCHAR(30) NOT NULL PRIMARY KEY
  marketCapitalization FLOAT NOT NULL
TABLE fsib
  companyName VARCHAR(30) NOT NULL PRIMARY KEY
  sharePrice FLOAT NOT NULL
  sharesOutstanding INTEGER NOT NULL

Write a query that returns the name and market capitalization of each company, ordered by market capitalization, largest to smallest. 

SELECT companyname, 
       ( shareprice * sharesoutstanding ) AS marketCapitalization 
FROM   fsib 
UNION 
SELECT companyname, 
       marketcapitalization 
FROM   fsia 
ORDER  BY marketcapitalization DESC 


Movies

Consider a large movie database with the following schema:

TABLE movies
  id INTEGER NOT NULL PRIMARY KEY
  name VARCHAR(30) NOT NULL

TABLE visitors 
  id INTEGER NOT NULL PRIMARY KEY
  name VARCHAR(30) NOT NULL

TABLE movies_visitors
  movieId INTEGER NOT NULL REFERENCES movies (id)
  visitorId INTEGER NOT NULL REFERENCES visitors (id)
  PRIMARY KEY (movieId, visitorId)
Select all queries that return movies having at least the average number of visitors.

For example, if there are three movies, A, B and C, with 1, 5 and 6 visitors, respectively, the average number of visitors is (1 + 5 + 6) / 3 = 4 and the query should return only movies B and C.

(Select all acceptable answers.)

SELECT id, COUNT(*)
FROM movies JOIN movies_visitors ON movieId = id
GROUP BY id HAVING COUNT(*) >=
 ((SELECT COUNT(*) FROM movies_visitors) * 1.0 / (SELECT COUNT(*) FROM movies));

SELECT movieId, COUNT(*)
FROM movies_visitors GROUP BY movieId HAVING COUNT(*) >=
 ((SELECT COUNT(*) FROM movies_visitors) * 1.0 / (SELECT COUNT(*) FROM movies));

Rectangles

Given the following data definition, for the given rectangles, write a query that selects each distinct value of area and the number of rectangles having that area.

TABLE rectangles
  id INTEGER NOT NULL PRIMARY KEY,
  width INTEGER NOT NULL,
  height INTEGER NOT NULL
The area of a rectangle can be calculated as width * height.

SELECT (width * height) AS area, count(id)
FROM rectangles
GROUP BY area

Autocomplete

--A website's internal search engine stores in the following table the number of times each phrase (in lower case form) was searched for:

TABLE searchedPhrases
  id INTEGER PRIMARY KEY NOT NULL,
  text VARCHAR(200) NOT NULL,
  count INTEGER NOT NULL

Autocomplete suggestions are generated using the following SQL query (where input_text is in lower case form):

SELECT text FROM searchedPhrases WHERE text LIKE 'input_text%' ORDER BY count DESC

Write a standard SQL (or SQLite) statement to create an index that will improve the performance of this query.

CREATE INDEX idx_text ON searchedPhrases(text, count);

Retirees

Table employees contains employee data while table retired_employees contains data about retired employees.

TABLE employees
  id INTEGER PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  retired CHAR(1)

TABLE retired_employees
  id INTEGER PRIMARY KEY,
  name VARCHAR(30) NOT NULL

An employee is retired if the retired field has value 'Y'. Write a query that copies both the id and name of each retired employee from employees to retired_employees.

INSERT INTO retired_employees (id, name)
SELECT id, name FROM employees 
WHERE retired = 'Y'

SMS Messages

A service for sending SMS messages contains a log of sent messages in the following table:

TABLE smsMessage
  messageId INTEGER PRIMARY KEY NOT NULL,
  src VARCHAR(30) NOT NULL,
  dest VARCHAR(30) NOT NULL,
  status INTEGER NOT NULL
Message text is stored in a table smsMessageText. Modify the provided SQLite create table statement so that:
	--An SMS message can only have one SMS message text.
	--smsMessageText's messageId must exist in the smsMessage table.

CREATE TABLE smsMessageText (
  messageId INTEGER PRIMARY KEY REFERENCES smsMessage(messageId),
  text VARCHAR(1000) NOT NULL,
  CONSTRAINT oneText UNIQUE(messageId, text)
);

Projects

The Users table has a one-to-many relationship with the Projects table. You need to make sure that when a user is deleted, all of their projects are also deleted.

What is the valid substitute for ??? in the following statement:

ALTER TABLE Projects ADD CONSTRAINT fk_project_user
FOREIGN KEY (userId) REFERENCES Users(id) ON DELETE ???

REMOVE
SET DEFAULT
CASCADE
SET NULL
DELETE

Roads

Given the following data definition:

TABLE roads
  name VARCHAR(20) NOT NULL PRIMARY KEY
  length INTEGER NOT NULL
--Create a view, named longRoads that selects the road's name and length, which have a greater than or equal to average length.

CREATE VIEW [longRoads]
AS
  SELECT NAME,
         length
  FROM   roads
  WHERE  length >= (SELECT Avg(length)
                    FROM   roads);

Movies Live

A movie database has the following schema:

TABLE directors
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL

TABLE movies
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(30) NOT NULL,
  directorId INTEGER NOT NULL REFERENCES(directors)
--Write a query that selects each director's name and the total number of films they have directed. The results should include directors who have not directed any films.

SELECT d.name, 
       Count(m.directorId ) 
FROM   directors d 
       LEFT JOIN movies m 
              ON d.id = m.directorId
GROUP  BY d.id;


Given the following data definition, write a query that returns names of employees who have no sales.

TABLE employees
  id INTEGER NOT NULL PRIMARY KEY
  name VARCHAR(30) NOT NULL 

TABLE sales
  employeeId INTEGER NOT NULL REFERENCES employees(id) 
  value INTEGER NOT NULL CHECK(value > 0)

SELECT e.NAME 
FROM   employees e 
       LEFT JOIN sales s 
              ON e.id = s.employeeid 
WHERE  employeeid IS NULL; 

from collections import defaultdict

class RewardPoints:
    def __init__(self):
        self.customers = defaultdict(int)
        self.bonus = True
        
    def earn_points(self, customer_name, points):
        if points > 0:
            self.customers[customer_name] += points
            if self.bonus:
                self.customers[customer_name] += 500
                self.bonus = False
    
    def spend_points(self, customer_name, points):
        if customer_name in self.customers:
            if points > 0:
                if self.customers[customer_name] > points:
                    self.customers[customer_name] -= points
            return self.customers[customer_name]
        else:
            return 0
         
rewardPoints = RewardPoints()
rewardPoints.earn_points('John', 520)
print(rewardPoints.spend_points('John', 200))