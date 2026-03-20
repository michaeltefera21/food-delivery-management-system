-- ============================================
-- FOOD DELIVERY MANAGMENT SYSTEM - CASSINO 2025
-- MICHAEL TERERA -79451
-- ============================================

-- 1. DATABASE SETUP
DROP DATABASE IF EXISTS FoodDeliveryDB;
CREATE DATABASE FoodDeliveryDB;
USE FoodDeliveryDB;

-- ============================================
-- 2. TABLE CREATION
-- ============================================

-- Customer table
CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200) NOT NULL,
    registration_date DATE DEFAULT (CURRENT_DATE)
);

-- Restaurant table
CREATE TABLE Restaurant (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50),
    address VARCHAR(200) NOT NULL,
    delivery_fee DECIMAL(5,2) DEFAULT 2.50
);

-- Driver table
CREATE TABLE Driver (
    driver_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    vehicle_type ENUM('Bicycle', 'Motorbike', 'Car') NOT NULL,
    status ENUM('Available', 'Busy', 'Offline') DEFAULT 'Available'
);

-- Order table
CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('Placed', 'Preparing', 'Out for Delivery', 'Delivered', 'Cancelled') DEFAULT 'Placed',
    delivery_address VARCHAR(200) NOT NULL,
    notes TEXT,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id),
    INDEX idx_order_date (order_date),
    INDEX idx_status (status)
);

-- Menu Item table
CREATE TABLE Menu_Item (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(8,2) NOT NULL,
    category VARCHAR(50),
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurant(restaurant_id) ON DELETE CASCADE,
    INDEX idx_category (category)
);

-- Order Item table
CREATE TABLE Order_Item (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES Menu_Item(item_id),
    INDEX idx_order_id (order_id)
);

-- Delivery table
CREATE TABLE Delivery (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    driver_id INT NOT NULL,
    pickup_time DATETIME,
    delivered_time DATETIME,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    notes VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES `Order`(order_id),
    FOREIGN KEY (driver_id) REFERENCES Driver(driver_id),
    INDEX idx_driver_id (driver_id)
);

-- ============================================
-- 3. SAMPLE DATA INSERTION
-- ============================================

-- Restaurants
INSERT INTO Restaurant (name, cuisine_type, address, delivery_fee) VALUES
('Pizzeria Regina', 'Italian', 'Via Casilina Nord, 195, Cassino', 2.00),
('McDonald''s', 'Fast Food', 'Viale Europa, 10, Cassino', 1.50),
('Old Wild West', 'Steakhouse', 'Viale Europa, Cassino', 3.00),
('Miki Sushi', 'Japanese', 'Via Casilina Nord, 159, Cassino', 2.50),
('Turkish Kebab', 'Turkish', 'Via Cesare Battisti, 48, Cassino', 2.00),
('Pizza e Baba', 'Italian', 'Corso della Repubblica, 95, Cassino', 1.50),
('I Love Poké', 'Hawaiian', 'Via Sant''Angelo in Theodice, Cassino', 2.00),
('Rub House BBQ', 'American', 'Via Casilina Nord, 180, Cassino', 2.50),
('La Piadineria', 'Italian', 'Viale Europa, 45, Cassino', 1.50),
('Settimo Gelo', 'Ice Cream', 'Via Casilina Sud, 88, Cassino', 1.50);

-- Customers
INSERT INTO Customer (name, email, phone, address, registration_date) VALUES
('Marco Rossi', 'marco@email.com', '333 1234567', 'Via Dante Alighieri, 15, Cassino', '2025-01-15'),
('Giulia Bianchi', 'giulia@email.com', '333 2345678', 'Via Roma, 42, Cassino', '2025-02-10'),
('Alessandro Verdi', 'alessandro@email.com', '333 3456789', 'Viale Europa, 88, Cassino', '2025-01-20'),
('Francesca Romano', 'francesca@email.com', '333 4567890', 'Corso della Repubblica, 33, Cassino', '2025-03-05'),
('Luca Esposito', 'luca@email.com', '333 5678901', 'Via Garibaldi, 7, Cassino', '2025-02-28'),
('Chiara Ricci', 'chiara@email.com', '333 6789012', 'Piazza De Gasperi, 12, Cassino', '2025-01-25'),
('Matteo Moretti', 'matteo@email.com', '333 7890123', 'Via Casilina Nord, 210, Cassino', '2025-03-12'),
('Maria Russo', 'maria@email.com', '333 8901234', 'Via dei Martiri, 22, Cassino', '2025-04-02'),
('Giovanni Costa', 'giovanni@email.com', '333 9012345', 'Via Montecassino, 5, Cassino', '2025-04-15'),
('Elena Ferrari', 'elena@email.com', '333 0123456', 'Viale della Libertà, 18, Cassino', '2025-03-20'),
('Roberto Greco', 'roberto@email.com', '333 1122334', 'Piazza Labriola, 9, Cassino', '2025-05-01'),
('Laura Santoro', 'laura@email.com', '333 2233445', 'Via Aquino, 31, Cassino', '2025-04-28'),
('Sofia Conti', 'sofia@email.com', '333 3344556', 'Via Cassino Vecchio, 14, Cassino', '2025-06-10'),
('Antonio Marini', 'antonio@email.com', '333 4455667', 'Piazza Mattei, 7, Cassino', '2025-05-20');

-- Drivers
INSERT INTO Driver (name, phone, vehicle_type, status) VALUES
('Paolo Ferrari', '333 1112233', 'Motorbike', 'Available'),
('Simone Russo', '333 2223344', 'Bicycle', 'Busy'),
('Andrea Lombardi', '333 3334455', 'Car', 'Available'),
('Elisa Conti', '333 4445566', 'Motorbike', 'Available'),
('Davide Marino', '333 5556677', 'Bicycle', 'Offline'),
('Sofia Gallo', '333 6667788', 'Car', 'Available'),
('Michele Rizzo', '333 7778899', 'Motorbike', 'Busy'),
('Anna Romano', '333 8889900', 'Bicycle', 'Available');

-- Menu Items
INSERT INTO Menu_Item (restaurant_id, name, price, category, is_available) VALUES
(1, 'Margherita Pizza', 9.50, 'Pizza', TRUE),
(1, 'Diavola Pizza', 11.00, 'Pizza', TRUE),
(1, 'Quattro Stagioni', 12.50, 'Pizza', TRUE),
(1, 'Bruschetta', 5.50, 'Appetizer', TRUE),
(1, 'Caprese Salad', 7.00, 'Salad', TRUE),
(1, 'Tiramisu', 6.00, 'Dessert', TRUE),
(2, 'Big Mac', 7.50, 'Burger', TRUE),
(2, 'McChicken', 6.50, 'Burger', TRUE),
(2, 'Cheeseburger', 4.50, 'Burger', TRUE),
(2, 'Fries', 3.50, 'Side', TRUE),
(2, 'Chicken McNuggets (6pz)', 5.00, 'Side', TRUE),
(2, 'McFlurry', 4.00, 'Dessert', TRUE),
(3, 'BBQ Ribs', 19.50, 'Main', TRUE),
(3, 'Texas Burger', 15.00, 'Burger', TRUE),
(3, 'Chicken Wings', 12.50, 'Main', TRUE),
(3, 'Caesar Salad', 11.00, 'Salad', TRUE),
(3, 'Onion Rings', 6.50, 'Side', TRUE),
(3, 'Chocolate Brownie', 7.50, 'Dessert', TRUE),
(4, 'Salmon Sashimi', 16.00, 'Sashimi', TRUE),
(4, 'California Roll', 9.00, 'Sushi', TRUE),
(4, 'Dragon Roll', 12.00, 'Sushi', TRUE),
(4, 'Miso Soup', 3.50, 'Soup', TRUE),
(4, 'Edamame', 4.50, 'Appetizer', TRUE),
(4, 'Tempura Shrimp', 10.50, 'Main', TRUE),
(5, 'Chicken Kebab', 7.50, 'Main', TRUE),
(5, 'Lamb Kebab', 9.50, 'Main', TRUE),
(5, 'Falafel Plate', 10.00, 'Vegetarian', TRUE),
(5, 'Hummus', 5.50, 'Appetizer', TRUE),
(5, 'Baklava', 4.50, 'Dessert', TRUE),
(5, 'Turkish Tea', 2.00, 'Drink', TRUE),
(6, 'Neapolitan Pizza', 9.50, 'Pizza', TRUE),
(6, 'Calzone', 11.00, 'Pizza', TRUE),
(6, 'Arancini', 4.00, 'Appetizer', TRUE),
(6, 'Pasta Carbonara', 12.00, 'Pasta', TRUE),
(6, 'Baba al Rum', 5.00, 'Dessert', TRUE),
(6, 'Bruschetta', 5.50, 'Appetizer', TRUE),
(7, 'Salmon Poké', 13.50, 'Bowl', TRUE),
(7, 'Tuna Poké', 14.00, 'Bowl', TRUE),
(7, 'Vegan Poké', 12.00, 'Bowl', TRUE),
(7, 'Chicken Poké', 13.00, 'Bowl', TRUE),
(7, 'Mango Salad', 6.50, 'Salad', TRUE),
(7, 'Seaweed Salad', 5.50, 'Salad', TRUE),
(8, 'Pulled Pork', 12.50, 'Sandwich', TRUE),
(8, 'BBQ Chicken', 16.00, 'Main', TRUE),
(8, 'Beef Brisket', 18.50, 'Main', TRUE),
(8, 'Mac & Cheese', 8.50, 'Side', TRUE),
(8, 'Coleslaw', 5.00, 'Side', TRUE),
(8, 'Corn Bread', 4.50, 'Side', TRUE),
(9, 'Prosciutto Piadina', 7.50, 'Piadina', TRUE),
(9, 'Vegetarian Piadina', 6.50, 'Piadina', TRUE),
(9, 'Chicken Piadina', 8.00, 'Piadina', TRUE),
(9, 'French Fries', 3.50, 'Side', TRUE),
(9, 'Soft Drink', 2.50, 'Drink', TRUE),
(10, 'Gelato al Cioccolato', 4.50, 'Gelato', TRUE),
(10, 'Gelato alla Fragola', 4.50, 'Gelato', TRUE),
(10, 'Gelato alla Vaniglia', 4.00, 'Gelato', TRUE),
(10, 'Coppa Nocciola', 6.50, 'Special', TRUE),
(10, 'Affogato al Caffè', 5.50, 'Special', TRUE),
(10, 'Sorbetto al Limone', 4.00, 'Sorbet', TRUE),
(10, 'Granita al Caffè', 4.50, 'Granita', TRUE),
(10, 'Brioche con Gelato', 7.00, 'Special', TRUE);

-- Orders
INSERT INTO `Order` (customer_id, restaurant_id, total_amount, status, delivery_address, order_date, notes) VALUES
(1, 1, 25.50, 'Delivered', 'Via Dante Alighieri, 15, Cassino', '2025-01-20 19:30:00', 'Extra cheese please'),
(2, 2, 17.50, 'Delivered', 'Via Roma, 42, Cassino', '2025-01-25 12:45:00', 'No mayo'),
(3, 3, 34.50, 'Delivered', 'Viale Europa, 88, Cassino', '2025-02-10 20:15:00', 'Spicy sauce on side'),
(4, 4, 25.50, 'Delivered', 'Corso della Repubblica, 33, Cassino', '2025-02-14 19:45:00', 'Valentine''s dinner'),
(5, 5, 17.00, 'Delivered', 'Via Garibaldi, 7, Cassino', '2025-03-05 18:30:00', NULL),
(6, 6, 18.50, 'Delivered', 'Piazza De Gasperi, 12, Cassino', '2025-03-15 20:00:00', NULL),
(7, 7, 27.50, 'Cancelled', 'Via Casilina Nord, 210, Cassino', '2025-04-02 13:15:00', 'Customer cancelled'),
(8, 8, 29.00, 'Delivered', 'Via dei Martiri, 22, Cassino', '2025-04-10 18:30:00', NULL),
(9, 10, 15.50, 'Delivered', 'Via Montecassino, 5, Cassino', '2025-05-12 15:30:00', 'Afternoon treat'),
(10, 10, 21.00, 'Delivered', 'Viale della Libertà, 18, Cassino', '2025-05-20 16:45:00', 'Birthday party'),
(11, 1, 32.00, 'Delivered', 'Piazza Labriola, 9, Cassino', '2025-06-05 20:15:00', 'Family dinner'),
(12, 10, 13.50, 'Delivered', 'Via Aquino, 31, Cassino', '2025-06-18 14:00:00', 'Hot day treat'),
(13, 10, 18.00, 'Delivered', 'Via Cassino Vecchio, 14, Cassino', '2025-06-22 17:30:00', 'Weekend dessert'),
(1, 3, 45.50, 'Delivered', 'Via Dante Alighieri, 15, Cassino', '2025-07-10 20:30:00', 'Birthday dinner'),
(2, 10, 22.50, 'Delivered', 'Via Roma, 42, Cassino', '2025-07-15 16:00:00', 'Family ice cream'),
(14, 10, 9.00, 'Delivered', 'Piazza Mattei, 7, Cassino', '2025-07-25 15:45:00', 'Quick snack'),
(3, 5, 22.50, 'Delivered', 'Viale Europa, 88, Cassino', '2025-08-05 18:45:00', 'Summer dinner'),
(4, 10, 24.00, 'Delivered', 'Corso della Repubblica, 33, Cassino', '2025-08-15 19:00:00', 'Evening dessert'),
(5, 10, 13.50, 'Cancelled', 'Via Garibaldi, 7, Cassino', '2025-08-20 16:30:00', 'Out of stock'),
(6, 7, 40.50, 'Delivered', 'Piazza De Gasperi, 12, Cassino', '2025-09-03 19:30:00', 'Party order'),
(7, 8, 34.00, 'Delivered', 'Via Casilina Nord, 210, Cassino', '2025-09-20 18:15:00', NULL),
(8, 10, 8.50, 'Delivered', 'Via dei Martiri, 22, Cassino', '2025-09-25 15:15:00', 'Afternoon gelato'),
(9, 9, 18.50, 'Delivered', 'Via Montecassino, 5, Cassino', '2025-10-12 13:30:00', 'Quick lunch'),
(10, 10, 12.00, 'Delivered', 'Viale della Libertà, 18, Cassino', '2025-10-25 14:45:00', 'Weekend treat'),
(11, 1, 28.50, 'Delivered', 'Piazza Labriola, 9, Cassino', '2025-11-08 19:00:00', 'Weekend dinner'),
(12, 2, 16.00, 'Delivered', 'Via Aquino, 31, Cassino', '2025-11-15 12:45:00', 'Lunch'),
(13, 3, 38.50, 'Out for Delivery', 'Via Cassino Vecchio, 14, Cassino', '2025-12-02 19:30:00', NULL),
(14, 10, 18.50, 'Preparing', 'Piazza Mattei, 7, Cassino', '2025-12-05 20:15:00', 'Movie night dessert'),
(1, 10, 14.00, 'Placed', 'Via Dante Alighieri, 15, Cassino', '2025-12-08 18:45:00', 'Dinner dessert'),
(2, 6, 19.50, 'Delivered', 'Via Roma, 42, Cassino', '2025-12-10 19:30:00', NULL),
(3, 7, 41.00, 'Delivered', 'Viale Europa, 88, Cassino', '2025-12-12 20:00:00', 'Large order'),
(4, 10, 22.00, 'Delivered', 'Corso della Repubblica, 33, Cassino', '2025-12-15 18:15:00', 'Family gathering'),
(5, 9, 13.50, 'Out for Delivery', 'Via Garibaldi, 7, Cassino', '2025-12-18 13:00:00', 'Lunch'),
(6, 10, 27.00, 'Preparing', 'Piazza De Gasperi, 12, Cassino', '2025-12-20 19:45:00', 'Christmas party dessert'),
(7, 1, 34.50, 'Placed', 'Via Casilina Nord, 210, Cassino', '2025-12-22 20:30:00', 'Christmas dinner'),
(8, 10, 16.50, 'Cancelled', 'Via dei Martiri, 22, Cassino', '2025-12-24 18:00:00', 'Change of plans'),
(9, 10, 20.50, 'Delivered', 'Via Montecassino, 5, Cassino', '2025-12-26 15:30:00', 'Boxing Day treat'),
(10, 10, 13.00, 'Delivered', 'Viale della Libertà, 18, Cassino', '2025-12-28 16:45:00', 'Weekend dessert');


-- Order Items
INSERT INTO Order_Item (order_id, item_id, quantity, unit_price) VALUES
(1, 1, 2, 9.50), (1, 4, 1, 5.50),
(2, 7, 1, 7.50), (2, 10, 2, 3.50), (2, 12, 1, 4.00),
(3, 13, 1, 19.50), (3, 15, 1, 11.00), (3, 18, 1, 7.50),
(4, 19, 1, 16.00), (4, 22, 1, 3.50), (4, 21, 1, 9.00),
(5, 25, 2, 7.50), (5, 29, 1, 4.50),
(6, 31, 1, 9.50), (6, 33, 1, 4.00), (6, 35, 1, 5.00),
(7, 37, 2, 13.50), (7, 39, 1, 6.50),
(8, 43, 1, 12.50), (8, 44, 1, 16.00), (8, 46, 1, 8.50),
(9, 51, 2, 4.50), (9, 52, 1, 4.50),
(10, 51, 3, 4.50), (10, 54, 1, 6.50), (10, 55, 1, 5.50),
(11, 1, 1, 9.50), (11, 2, 1, 11.00), (11, 6, 1, 6.00), (11, 4, 1, 5.50),
(12, 51, 1, 4.50), (12, 52, 1, 4.50), (12, 56, 1, 4.00),
(13, 54, 2, 6.50), (13, 55, 1, 5.50),
(14, 13, 1, 19.50), (14, 14, 1, 15.00), (14, 18, 1, 7.50), (14, 16, 1, 6.50),
(15, 52, 3, 4.50), (15, 57, 1, 4.50), (15, 55, 1, 5.50),
(16, 54, 2, 6.50), (16, 55, 1, 5.50), (16, 55, 1, 5.50),
(17, 25, 1, 7.50), (17, 26, 1, 9.50), (17, 30, 1, 2.00),
(18, 54, 2, 6.50), (18, 55, 1, 5.50), (18, 55, 1, 5.50), (18, 51, 1, 4.50),
(19, 51, 3, 4.50),
(20, 37, 2, 13.50), (20, 38, 1, 14.00), (20, 42, 1, 5.50),
(21, 43, 1, 12.50), (21, 45, 1, 18.50), (21, 48, 1, 5.00),
(22, 51, 1, 4.50), (22, 53, 1, 4.00), (22, 56, 1, 4.00),
(23, 49, 1, 7.50), (23, 51, 2, 3.50), (23, 52, 1, 2.50),
(24, 51, 2, 4.50), (24, 52, 1, 4.50),
(25, 1, 1, 9.50), (25, 3, 1, 12.50), (25, 6, 1, 6.00),
(26, 7, 1, 7.50), (26, 10, 2, 3.50), (26, 12, 1, 4.00),
(27, 14, 1, 15.00), (27, 16, 1, 12.50), (27, 17, 1, 6.50), (27, 18, 1, 7.50),
(28, 54, 1, 6.50), (28, 55, 1, 5.50),
(29, 52, 2, 4.50), (29, 53, 2, 4.00),
(30, 31, 1, 9.50), (30, 34, 1, 12.00),
(31, 37, 2, 13.50), (31, 40, 1, 6.50), (31, 41, 1, 5.50),
(32, 54, 2, 6.50), (32, 55, 1, 5.50), (32, 55, 1, 5.50),
(33, 49, 1, 7.50), (33, 50, 1, 6.50), (33, 51, 1, 3.50),
(34, 54, 3, 6.50), (34, 55, 1, 5.50),
(35, 1, 2, 9.50), (35, 4, 1, 5.50), (35, 6, 1, 6.00),
(36, 51, 3, 4.50), (36, 57, 1, 4.50),
(37, 54, 1, 6.50), (37, 55, 1, 5.50),
(38, 53, 2, 4.00), (38, 56, 2, 4.00);

-- Then insert the Delivery data (SEPARATELY)
INSERT INTO Delivery (order_id, driver_id, pickup_time, delivered_time, rating, notes) VALUES
(1, 1, '2025-01-20 19:45:00', '2025-01-20 20:10:00', 5, 'Friendly customer'),
(2, 2, '2025-01-25 13:00:00', '2025-01-25 13:25:00', 4, 'Quick delivery'),
(3, 3, '2025-02-10 20:30:00', '2025-02-10 21:00:00', 5, 'Large order, handled well'),
(4, 1, '2025-02-14 20:00:00', '2025-02-14 20:30:00', 4, 'Romantic dinner delivery'),
(5, 4, '2025-03-05 18:45:00', '2025-03-05 19:15:00', 5, NULL),
(6, 5, '2025-03-15 20:15:00', '2025-03-15 20:45:00', 4, 'Good packaging'),
(8, 6, '2025-04-10 18:45:00', '2025-04-10 19:15:00', 5, 'Perfect timing'),
(9, 3, '2025-05-12 15:45:00', '2025-05-12 16:05:00', 5, 'Ice cream arrived perfectly cold'),
(10, 4, '2025-05-20 17:00:00', '2025-05-20 17:20:00', 4, 'Birthday ice cream delivered'),
(11, 1, '2025-06-05 20:30:00', '2025-06-05 21:05:00', 5, 'Family was happy'),
(12, 5, '2025-06-18 14:15:00', '2025-06-18 14:35:00', 5, 'Hot day, used thermal bag'),
(13, 6, '2025-06-22 17:45:00', '2025-06-22 18:05:00', 4, 'Weekend dessert'),
(14, 2, '2025-07-10 20:45:00', '2025-07-10 21:20:00', 5, 'Birthday celebration'),
(15, 7, '2025-07-15 16:15:00', '2025-07-15 16:35:00', 5, 'Family loved it'),
(16, 8, '2025-07-25 16:00:00', '2025-07-25 16:20:00', 4, 'Quick snack delivery'),
(17, 3, '2025-08-05 19:00:00', '2025-08-05 19:30:00', 4, 'Summer evening'),
(18, 1, '2025-08-15 19:15:00', '2025-08-15 19:35:00', 5, 'Evening dessert'),
(20, 5, '2025-09-03 19:45:00', '2025-09-03 20:20:00', 4, 'Party order'),
(21, 6, '2025-09-20 18:30:00', '2025-09-20 19:05:00', 5, 'Well packed'),
(22, 2, '2025-09-25 15:30:00', '2025-09-25 15:50:00', 4, 'Afternoon gelato'),
(23, 4, '2025-10-12 13:45:00', '2025-10-12 14:10:00', 3, 'Rushed delivery'),
(24, 3, '2025-10-25 15:00:00', '2025-10-25 15:25:00', 3, 'Slightly melted'),
(25, 1, '2025-11-08 19:15:00', '2025-11-08 19:45:00', 4, 'Weekend dinner'),
(26, 2, '2025-11-15 13:00:00', '2025-11-15 13:25:00', 5, 'Lunch delivery'),
(30, 4, '2025-12-10 19:45:00', '2025-12-10 20:15:00', 4, 'Good delivery'),
(31, 5, '2025-12-12 20:15:00', '2025-12-12 20:50:00', 5, 'Large order delivered well'),
(32, 4, '2025-12-15 18:30:00', '2025-12-15 18:55:00', 5, 'Winter ice cream delivery'),
(37, 6, '2025-12-26 15:45:00', '2025-12-26 16:10:00', 4, 'Boxing Day treat'),
(38, 7, '2025-12-28 17:00:00', '2025-12-28 17:25:00', 5, 'Perfect weekend dessert');

-- ============================================

-- VIEW: Customer Order Summary
CREATE VIEW Customer_Order_Summary AS
SELECT c.customer_id, c.name, c.email,
       COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_spent,
       MIN(o.order_date) AS first_order,
       MAX(o.order_date) AS last_order,
       CASE 
           WHEN COUNT(o.order_id) >= 10 THEN 'Platinum'
           WHEN COUNT(o.order_id) >= 5 THEN 'Gold'
           WHEN COUNT(o.order_id) >= 3 THEN 'Silver'
           ELSE 'New'
       END AS customer_tier
FROM Customer c
LEFT JOIN `Order` o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered' OR o.order_id IS NULL
GROUP BY c.customer_id, c.name, c.email;

-- QUERY 1: Simple Selection - Active Orders
SELECT 'QUERY 1: ACTIVE ORDERS' AS Query_Description;
SELECT o.order_id, c.name AS customer_name, r.name AS restaurant_name,
       o.status, o.total_amount, o.order_date, o.delivery_address
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Restaurant r ON o.restaurant_id = r.restaurant_id
WHERE o.status NOT IN ('Delivered', 'Cancelled')
ORDER BY o.order_date DESC;

-- QUERY 2: JOIN + GROUP BY - Restaurant Performance
SELECT 'QUERY 2: RESTAURANT PERFORMANCE' AS Query_Description;
SELECT r.restaurant_id, r.name, r.cuisine_type,
       COUNT(o.order_id) AS total_orders,
       SUM(o.total_amount) AS total_revenue,
       ROUND(AVG(o.total_amount), 2) AS avg_order_value,
       MIN(o.total_amount) AS min_order,
       MAX(o.total_amount) AS max_order,
       RANK() OVER (ORDER BY SUM(o.total_amount) DESC) AS revenue_rank
FROM Restaurant r
LEFT JOIN `Order` o ON r.restaurant_id = o.restaurant_id AND o.status = 'Delivered'
GROUP BY r.restaurant_id, r.name, r.cuisine_type
ORDER BY total_revenue DESC;

-- QUERY 3: Aggregation with HAVING - Popular Menu Items
SELECT 'QUERY 3: POPULAR MENU ITEMS' AS Query_Description;
SELECT r.name AS restaurant_name, mi.name AS item_name, mi.category,
       SUM(oi.quantity) AS total_quantity_sold,
       SUM(oi.quantity * oi.unit_price) AS total_revenue,
       COUNT(DISTINCT oi.order_id) AS order_count
FROM Menu_Item mi
JOIN Restaurant r ON mi.restaurant_id = r.restaurant_id
JOIN Order_Item oi ON mi.item_id = oi.item_id
JOIN `Order` o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered'
GROUP BY mi.item_id, r.name, mi.name, mi.category
HAVING total_quantity_sold > 5
ORDER BY total_quantity_sold DESC;

-- QUERY 4: Multi-condition with Subquery - Best Customers
SELECT 'QUERY 4: TOP CUSTOMERS' AS Query_Description;
SELECT c.customer_id, c.name, c.email,
       COUNT(o.order_id) AS order_count,
       SUM(o.total_amount) AS total_spent,
       ROUND(AVG(o.total_amount), 2) AS avg_order_value,
       MAX(o.order_date) AS last_order_date,
       DATEDIFF('2025-12-31', MAX(o.order_date)) AS days_since_last_order
FROM Customer c
JOIN `Order` o ON c.customer_id = o.customer_id
WHERE o.status = 'Delivered'
  AND o.order_date >= '2025-06-01'
GROUP BY c.customer_id, c.name, c.email
HAVING order_count >= 3
ORDER BY total_spent DESC;

-- QUERY 5: Monthly Revenue Trend
SELECT 'QUERY 5: MONTHLY REVENUE TREND' AS Query_Description;
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(order_id) AS order_count,
       SUM(total_amount) AS total_revenue,
       ROUND(AVG(total_amount), 2) AS avg_order_value,
       ROUND(SUM(total_amount) / COUNT(DISTINCT DAY(order_date)), 2) AS avg_daily_revenue
FROM `Order`
WHERE status = 'Delivered'
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- QUERY 6: Driver Performance Analysis
SELECT 'QUERY 6: DRIVER PERFORMANCE' AS Query_Description;
SELECT d.driver_id, d.name, d.vehicle_type,
       COUNT(del.delivery_id) AS deliveries_completed,
       ROUND(AVG(del.rating), 2) AS avg_rating,
       ROUND(AVG(TIMESTAMPDIFF(MINUTE, del.pickup_time, del.delivered_time)), 1) AS avg_delivery_time_minutes,
       SUM(CASE WHEN del.rating = 5 THEN 1 ELSE 0 END) AS perfect_ratings
FROM Driver d
JOIN Delivery del ON d.driver_id = del.driver_id
WHERE del.delivered_time IS NOT NULL
GROUP BY d.driver_id, d.name, d.vehicle_type
ORDER BY deliveries_completed DESC;

-- QUERY 7: Complex JOIN - Order Details with Delivery Info
SELECT 'QUERY 7: RECENT ORDER DETAILS' AS Query_Description;
SELECT o.order_id, c.name AS customer, r.name AS restaurant,
       GROUP_CONCAT(CONCAT(mi.name, ' (x', oi.quantity, ')') SEPARATOR ', ') AS items,
       o.total_amount, o.status,
       d.name AS driver,
       del.pickup_time, del.delivered_time,
       del.rating AS delivery_rating,
       TIMESTAMPDIFF(MINUTE, del.pickup_time, del.delivered_time) AS delivery_time_minutes
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Restaurant r ON o.restaurant_id = r.restaurant_id
LEFT JOIN Order_Item oi ON o.order_id = oi.order_id
LEFT JOIN Menu_Item mi ON oi.item_id = mi.item_id
LEFT JOIN Delivery del ON o.order_id = del.order_id
LEFT JOIN Driver d ON del.driver_id = d.driver_id
WHERE o.order_date >= '2025-12-01'
GROUP BY o.order_id, c.name, r.name, o.total_amount, o.status, d.name, del.pickup_time, del.delivered_time, del.rating
ORDER BY o.order_date DESC
LIMIT 10;

-- QUERY 8: Ice Cream Sales Analysis (Seasonal Trend)
SELECT 'QUERY 8: ICE CREAM SEASONAL ANALYSIS' AS Query_Description;
SELECT 
    MONTH(o.order_date) AS month_num,
    MONTHNAME(o.order_date) AS month_name,
    COUNT(o.order_id) AS ice_cream_orders,
    SUM(o.total_amount) AS ice_cream_revenue,
    ROUND(AVG(o.total_amount), 2) AS avg_ice_cream_order,
    SUM(oi.quantity) AS ice_cream_items_sold,
    ROUND(SUM(o.total_amount) / COUNT(DISTINCT DAY(o.order_date)), 2) AS avg_daily_revenue
FROM `Order` o
JOIN Order_Item oi ON o.order_id = oi.order_id
JOIN Menu_Item mi ON oi.item_id = mi.item_id
WHERE o.restaurant_id = 10
    AND o.status = 'Delivered'
    AND mi.category IN ('Gelato', 'Special', 'Sorbet', 'Granita')
GROUP BY MONTH(o.order_date), MONTHNAME(o.order_date)
ORDER BY month_num;

-- QUERY 9: Busiest Hours Analysis
SELECT 'QUERY 9: BUSIEST HOURS' AS Query_Description;
SELECT 
    HOUR(order_date) AS hour_of_day,
    COUNT(order_id) AS order_count,
    ROUND(AVG(total_amount), 2) AS avg_order_value,
    GROUP_CONCAT(DISTINCT r.cuisine_type ORDER BY r.cuisine_type SEPARATOR ', ') AS popular_cuisines,
    ROUND(COUNT(order_id) * 100.0 / (SELECT COUNT(*) FROM `Order` WHERE status = 'Delivered'), 1) AS percentage_of_orders
FROM `Order` o
JOIN Restaurant r ON o.restaurant_id = r.restaurant_id
WHERE status = 'Delivered'
GROUP BY HOUR(order_date)
ORDER BY order_count DESC;

-- QUERY 10: Cancellation Analysis
SELECT 'QUERY 10: CANCELLATION ANALYSIS' AS Query_Description;
SELECT 
    o.order_id,
    c.name AS customer,
    r.name AS restaurant,
    o.total_amount,
    o.order_date,
    o.notes AS cancellation_reason,
    DATEDIFF('2025-12-31', o.order_date) AS days_since_cancellation
FROM `Order` o
JOIN Customer c ON o.customer_id = c.customer_id
JOIN Restaurant r ON o.restaurant_id = r.restaurant_id
WHERE o.status = 'Cancelled'
ORDER BY o.order_date DESC;

-- QUERY 11: Customer Lifetime Value Analysis
SELECT 'QUERY 11: CUSTOMER LIFETIME VALUE' AS Query_Description;
SELECT 
    cos.customer_tier,
    COUNT(*) AS customer_count,
    ROUND(AVG(cos.total_orders), 1) AS avg_orders_per_customer,
    ROUND(AVG(cos.total_spent), 2) AS avg_spent_per_customer,
    ROUND(SUM(cos.total_spent), 2) AS total_revenue_by_tier,
    ROUND(SUM(cos.total_spent) * 100.0 / (SELECT SUM(total_amount) FROM `Order` WHERE status = 'Delivered'), 1) AS percentage_of_total_revenue
FROM Customer_Order_Summary cos
WHERE cos.total_orders > 0
GROUP BY cos.customer_tier
ORDER BY 
    CASE cos.customer_tier
        WHEN 'Platinum' THEN 1
        WHEN 'Gold' THEN 2
        WHEN 'Silver' THEN 3
        ELSE 4
    END;

-- QUERY 12: Delivery Time Analysis by Vehicle Type
SELECT 'QUERY 12: DELIVERY TIME BY VEHICLE TYPE' AS Query_Description;
SELECT 
    d.vehicle_type,
    COUNT(del.delivery_id) AS total_deliveries,
    ROUND(AVG(TIMESTAMPDIFF(MINUTE, del.pickup_time, del.delivered_time)), 1) AS avg_delivery_time_minutes,
    ROUND(MIN(TIMESTAMPDIFF(MINUTE, del.pickup_time, del.delivered_time)), 1) AS min_delivery_time,
    ROUND(MAX(TIMESTAMPDIFF(MINUTE, del.pickup_time, del.delivered_time)), 1) AS max_delivery_time,
    ROUND(AVG(del.rating), 2) AS avg_rating
FROM Delivery del
JOIN Driver d ON del.driver_id = d.driver_id
WHERE del.delivered_time IS NOT NULL
GROUP BY d.vehicle_type
ORDER BY avg_delivery_time_minutes;

-- ============================================
-- 5. DATABASE STATISTICS SUMMARY
-- ============================================

SELECT 'DATABASE STATISTICS SUMMARY' AS Summary;
SELECT 
    (SELECT COUNT(*) FROM Customer) AS total_customers,
    (SELECT COUNT(*) FROM Restaurant) AS total_restaurants,
    (SELECT COUNT(*) FROM Driver) AS total_drivers,
    (SELECT COUNT(*) FROM `Order`) AS total_orders,
    (SELECT COUNT(*) FROM `Order` WHERE status = 'Delivered') AS delivered_orders,
    (SELECT COUNT(*) FROM `Order` WHERE status = 'Cancelled') AS cancelled_orders,
    (SELECT ROUND(SUM(total_amount), 2) FROM `Order` WHERE status = 'Delivered') AS total_revenue,
    (SELECT ROUND(AVG(total_amount), 2) FROM `Order` WHERE status = 'Delivered') AS avg_order_value,
    (SELECT ROUND(AVG(rating), 2) FROM Delivery WHERE rating IS NOT NULL) AS avg_delivery_rating,
    (SELECT COUNT(*) FROM Menu_Item) AS total_menu_items;

-- ============================================
-- 6. CLEANUP AND VALIDATION QUERIES
-- ============================================

-- Check for data integrity
SELECT 'DATA INTEGRITY CHECK' AS Check_Type;
SELECT 'Orders without customers' AS Check_Description,
       COUNT(*) AS Problem_Count
FROM `Order` o
LEFT JOIN Customer c ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL
UNION ALL
SELECT 'Orders without restaurants' AS Check_Description,
       COUNT(*) AS Problem_Count
FROM `Order` o
LEFT JOIN Restaurant r ON o.restaurant_id = r.restaurant_id
WHERE r.restaurant_id IS NULL
UNION ALL
SELECT 'Deliveries without valid orders' AS Check_Description,
       COUNT(*) AS Problem_Count
FROM Delivery d
LEFT JOIN `Order` o ON d.order_id = o.order_id
WHERE o.order_id IS NULL;




-- ============================================
-- END OF SQL SCRIPT
-- ============================================
