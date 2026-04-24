-- Creating database
CREATE DATABASE IF NOT EXISTS digital_library;
USE digital_library;
-- Drop old tables for re-executing
DROP TABLE IF EXISTS borrowings;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS members;
-- tables creating 
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100),
    join_date DATE DEFAULT (CURRENT_DATE),
    last_login_date DATE,
    account_status VARCHAR(20) DEFAULT 'Active'
);
CREATE TABLE books (

    book_id INT PRIMARY KEY,
    book_title VARCHAR(200) NOT NULL,
    category VARCHAR(50),
    total_copies INT
);
CREATE TABLE borrowings (
    borrow_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    checkout_date DATE NOT NULL,
    due_date DATE NOT NULL,
    returned_on DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);
-- inserting data
INSERT INTO members (member_id, full_name, email_address, join_date, last_login_date, account_status) VALUES
(1, 'Rahul Sharma', 'rahul@email.com', '2023-01-15', '2024-04-10', 'Active'),
(2, 'Sneha Patel', 'sneha@email.com', '2021-06-20', '2022-01-05', 'Inactive'),
(3, 'Amit Kumar', 'amit@email.com', '2023-11-05', '2024-01-20', 'Active'),
(4, 'Priya Singh', 'priya@email.com', '2019-03-10', '2020-08-14', 'Inactive'),
(5, 'Vikram Verma', 'vik@email.com', '2024-01-01', '2024-04-11', 'Active'),
(6, 'Kiran Rao', 'kiran@email.com', '2022-09-10', '2023-12-01', 'Active'),
(7, 'Anjali Mehta', 'anjali@email.com', '2018-05-05', '2019-06-01', 'Inactive');

INSERT INTO books (book_id, book_title, category, total_copies) VALUES
(101, 'Python Crash Course', 'Tech', 5),
(102, 'Rich Dad Poor Dad', 'Finance', 3),
(103, 'Clean Code', 'Tech', 8),
(104, 'The Alchemist', 'Fiction', 10),
(105, 'Harry Potter', 'Fiction', 7),
(106, 'Data Structures', 'Tech', 6),
(107, 'World History', 'History', 4);
INSERT INTO borrowings (borrow_id, member_id, book_id, checkout_date, due_date, returned_on) VALUES
(1001, 1, 101, CURDATE() - INTERVAL 20 DAY, CURDATE() - INTERVAL 6 DAY, NULL),
(1002, 3, 103, CURDATE() - INTERVAL 10 DAY, CURDATE() + INTERVAL 4 DAY, NULL),
(1003, 5, 104, CURDATE() - INTERVAL 25 DAY, CURDATE() - INTERVAL 11 DAY, NULL),
(1004, 2, 102, '2021-12-01', '2021-12-15', '2021-12-10'),
(1005, 3, 101, '2023-11-10', '2023-11-24', '2023-11-20'),
(1006, 6, 105, CURDATE() - INTERVAL 30 DAY, CURDATE() - INTERVAL 16 DAY, NULL),
(1007, 7, 107, '2020-01-01', '2020-01-15', '2020-01-10');

-- Analytical queries
-- overdue and report
SELECT 
    m.full_name,
    b.book_title,
    br.due_date,
    DATEDIFF(CURDATE(), br.due_date) AS days_late,
    DATEDIFF(CURDATE(), br.due_date) * 5 AS penalty_rupees
FROM borrowings br
JOIN members m ON br.member_id = m.member_id
JOIN books b ON br.book_id = b.book_id
WHERE br.returned_on IS NULL
AND br.due_date < CURDATE();
-- most popular catogery and what to buy next
SELECT 
    b.category,
    COUNT(*) AS total_borrowed,
    CONCAT('It is best to buy more ', b.category, ' books next') AS recommendation
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.category
ORDER BY total_borrowed DESC
LIMIT 1;
-- most borrowed books
SELECT 
    b.book_title,
    COUNT(*) AS times_borrowed
FROM borrowings br
JOIN books b ON br.book_id = b.book_id
GROUP BY b.book_title
ORDER BY times_borrowed DESC
LIMIT 3;
 -- shows  users last active date
 SELECT 
    full_name,
    last_login_date AS last_active_date
FROM members;
 
 -- delete inactive users
 SET SQL_SAFE_UPDATES = 0;
DELETE FROM members
WHERE account_status = 'Inactive'
AND last_login_date < '2023-01-01';
-- final check  to see  any inactive users there after deleting
SELECT member_id, full_name, account_status FROM members;








