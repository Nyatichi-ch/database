-- 1. Create the database
CREATE DATABASE IF NOT EXISTS salesDB;
USE salesDB;

-- 2. Create the 'customers' table
CREATE TABLE IF NOT EXISTS customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100),
  phone VARCHAR(20),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Insert sample customers
INSERT INTO customers (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '0712345678'),
('Bob Smith', 'bob@example.com', '0723456789'),
('Carol White', 'carol@example.com', '0734567890');

-- 4. Create the 'products' table
CREATE TABLE IF NOT EXISTS products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  price DECIMAL(10,2),
  stock INT
);

-- 5. Insert sample products
INSERT INTO products (name, price, stock) VALUES
('Laptop', 45000.00, 10),
('Smartphone', 20000.00, 25),
('Headphones', 2000.00, 50);

-- 6. Create the 'orders' table
CREATE TABLE IF NOT EXISTS orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  product_id INT,
  quantity INT,
  order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- 7. Insert sample orders
INSERT INTO orders (customer_id, product_id, quantity) VALUES
(1, 1, 1),  -- June buys 1 Laptop
(2, 3, 2),  -- samwek buys 2 Headphones
(3, 2, 1);  -- Carol buys 1 Smartphone
