create database myDB;

use myDB;

create table Customer(
	customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    email TEXT,
    customer_password VARCHAR(100)
);


create table Products(
	product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL (5,2),
    product_description VARCHAR(50),
    stock_quantity INT
);

create table Cart(
    cart_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY(product_id) REFERENCES  Products(product_id)
);

create table Orders(
	order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(5,2),
    shipping_address VARCHAR(100),
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id)
);

create table Order_items(
	order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id),
    FOREIGN KEY(product_id) REFERENCES  Products(product_id)
);

select * from Customer;
select * from Orders;

ALTER TABLE Customer DROP COLUMN customer_name;
alter table Customer drop column customer_password;

alter table Customer add column first_name VARCHAR(50);
alter table Customer add column last_name varchar(50);
ALTER TABLE Customer add column address VARCHAR(100);

insert into Customer values
(1, 'John', 'Doe', 'johndoe@gmail.com', '123Main St, City'),
(2, 'Jane', 'Smith', 'janesmith@gmail.com', '123Main St, City'),
(3, 'Robert', 'Johnson', 'robert@gmail.com', '123Main St, City'),
(4, 'Sarah', 'Brown', 'sarah@gmail.com', '123Main St, City'),
(5, 'David', 'Lee', 'david@gmail.com', '123Main St, City'),
(6, 'Laura', 'Hall', 'laura@gmail.com', '123Main St, City'),
(7, 'Michael', 'Davis', 'micheal@gmail.com', '123Main St, City'),
(8, 'Emma', 'Wilson', 'emma@gmail.com', '123Main St, City'),
(9, 'William', 'Taylor', 'william@gmail.com', '123Main St, City'),
(10, 'Olivia', 'Adams', 'olivia@gmail.com', '123Main St, City');


insert into Products (product_id, product_name, product_description, price, stock_quantity) values
(1, 'Laptop', 'High-performance Laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable table', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave ', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

ALTER TABLE Orders DROP COLUMN shipping_address;
ALTER TABLE Orders MODIFY COLUMN total_price DECIMAL (8,2);

insert into Orders values
(1, 1, '2023-01-05', 1200.00),
(2, 2, '2023-02-05', 900.00),
(3, 3, '2023-03-05', 300.00),
(4, 4, '2023-04-05', 150.00),
(5, 5, '2023-05-05', 18000.00),
(6, 6, '2023-06-05', 400.00),
(7, 7, '2023-07-05', 700.00),
(8, 8, '2023-08-05', 1600.00),
(9, 9, '2023-09-05', 1400.00),
(10, 10, '2023-10-05', 1400.00);

alter table Order_items add column item_amount DECIMAL(10,2);

insert into Order_items values
(1, 1, 1, 2, 1600.00),
(2, 1, 3, 1, 300.00),
(3, 2, 2, 3, 1800.00),
(4, 3, 5, 2, 1800.00),
(5, 1, 4, 4, 600.00),
(6, 4, 6, 1, 50.00),
(7, 4, 1, 1, 800.00),
(8, 5, 2, 2, 1200.00),
(9, 6, 10, 2, 240.00),
(10, 6, 9, 3, 210.00);


insert into Cart values
(1, 1, 1, 2),
(2, 1, 3, 1),
(3, 2, 2, 3),
(4, 3, 4, 4),
(5, 3, 5, 2),
(6, 4, 6, 1),
(7, 5, 1, 1),
(8, 6, 10, 2),
(9, 6, 9, 3),
(10, 7, 7, 2);

select * from Customer;
select * from Products;
select * from Cart;
select * from Orders;
select * from Order_items;

-- 1.Update refrigerator product price to 800.
update Products
set price = 800
where product_name = 'Refrigerator';

-- 2.Remove all cart items for a specific customer.
DELETE FROM Cart
WHERE customer_id = 1;

-- 3.Retrieve Products Priced Below $100.
SELECT product_name FROM Products
WHERE price < 100;

-- 4.Find Products with Stock Quantity Greater Than 5.
SELECT product_name FROM Products
WHERE stock_quantity >5;

-- 5. Retrieve Orders with Total Amount Between $500 and $1000.
select order_id from Orders
where total_price between 500 and 1000;

-- 6.Find Products which name end with letter ‘r’.
select product_name from Products
where product_name like '%r';

-- 7. Retrieve Cart Items for Customer 5.
select * from Cart;
select cart_id from Cart
where customer_id = 5;

-- 8.Find Customers Who Placed Orders in 2023.
select c.first_name from Customer as c
inner join Orders as o on c.customer_id = o.customer_id
where YEAR(o.order_date) = 2023; 

-- 9.Determine the Minimum Stock Quantity for Each Product Category.
select min(stock_quantity) from Products
group by product_name;

select * from Products;

-- 10. Calculate the Total Amount Spent by Each Customer.
select sum(total_price), customer_id from Orders group by customer_id;

-- 11. Find the Average Order Amount for Each Customer.
select customer_id, avg(total_price) as avg_price from Orders
GROUP BY customer_id;

-- 12. Count the Number of Orders Placed by Each Customer.
select customer_id, count(order_id) as no_orders from Orders
group by customer_id;

-- 13. Find the Maximum Order Amount for Each Customer.
select customer_id, max(total_price) as max_price from Orders
group by customer_id;

-- 14. Get Customers Who Placed Orders Totaling Over $1000.
select customer_id from Orders
group by customer_id
having sum(total_price) > 1000;

-- 15. Subquery to Find Products Not in the Cart.
select product_name from Products
where product_id not in (select product_id from Cart);

-- 16. Subquery to Find Customers Who Haven't Placed Orders.
select first_name from Customer 
where customer_id not in (select customer_id from Orders);

-- 17. Subquery to Calculate the Percentage of Total Revenue for a Product.
select product_id, sum(item_amount)*100.0 / (select sum(item_amount) from Order_items) as revenue_percentage
from Order_items
group by product_id;

-- 18. Subquery to Find Products with Low Stock.
select product_name, stock_quantity from Products
where stock_quantity < (select avg(stock_quantity) from Products);

-- 19. Subquery to Find Customers Who Placed High-Value Orders.
select c.first_name from Customer as c
inner join Orders as o
on c.customer_id = o.customer_id
where o.total_price > (select avg(total_price) from Orders);

 