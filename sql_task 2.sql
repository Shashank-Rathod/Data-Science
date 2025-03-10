CREATE DATABASE SalesDB;
USE SalesDB;

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT
);

-- Insert sample data into Customers table
INSERT INTO Customers (customer_name, email, phone, address) VALUES
('shashank Rathod', 'shashank@gmail.com', '1234567890', 'manekpor'),
('chintan patel', 'chintan@gmail.com', '0987654321', 'chikli'),
('kunjan patel', 'kunjan@gmail.com', '6754790654', 'algadh'),
('dipesh vashava', 'dipesh@gmail.com', '2354874904', 'songadh');

-- Create Orders table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE SET NULL
);

-- Insert sample data into Orders table
INSERT INTO Orders (customer_id, order_date, total_amount) VALUES
(1, '2024-03-01', 250.75),
(2, '2024-03-02', 100.50),
(3, '2024-03-03', 300.00),
(4, '2024-03-04', 150.25);

-- Create Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);

-- Insert sample data into Products table
INSERT INTO Products (product_name, price) VALUES
('Laptop', 1200.00),
('Smartphone', 800.00),
('Tablet', 300.00),
('Headphones', 150.00);

-- Create OrderDetails table (many-to-many relationship between Orders and Products)
CREATE TABLE OrderDetails (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

-- Insert sample data into OrderDetails table
INSERT INTO OrderDetails (order_id, product_id, quantity) VALUES
(1, 1, 1),
(1, 4, 2),
(2, 2, 1),
(3, 3, 3),
(4, 4, 1);

-- Task 1: Retrieve all customers and their orders

SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, o.total_amount  
FROM Customers c  
LEFT JOIN Orders o ON c.customer_id = o.customer_id;

-- Task 2: Retrieve all orders along with customer details
SELECT o.order_id, o.order_date, o.total_amount, c.customer_name, c.email
FROM Orders o 
RIGHT JOIN Customers c ON o.customer_id = c.customer_id;

-- Task 3: List all products and the orders they appear in
SELECT p.product_id, p.product_name, o.order_id
FROM Products p 
LEFT JOIN OrderDetails od ON p.product_id = od.product_id LEFT JOIN Orders o ON od.order_id = o.order_id;

-- Task 4: Find all customers who have never placed an order
SELECT c.customer_id, c.customer_name 
FROM Customers c 
LEFT JOIN Orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NULL;

-- Task 5: Retrieve a list of orders and their corresponding products
SELECT o.order_id, p.product_name, p.price 
FROM Orders o 
RIGHT JOIN OrderDetails od ON o.order_id = od.order_id RIGHT JOIN Products p ON od.product_id = p.product_id;

-- Task 6: Find the minimum order amount
SELECT MIN(TOTAL_amount)as min_order_amount 
from orders;

-- Task 7: Calculate the total revenue generated

select sum(total_amount) as total_revenue
from orders;

-- Task 8: Find the average price of products
select avg(price) as average_product_price 
from products;

-- Task 9: Count the number of orders each customer has placed

select customer_id,count(order_id) as total_orders
from orders 
group by customer_id;

-- Task 10: Find the customer who has spent the most money
select customer_id,sum(total_amount) as total_spent
from orders
group by customer_id order by total_spent desc limit 1;