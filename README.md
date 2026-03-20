# 🍕 Food Delivery Management System – Cassino 2025

A comprehensive **data management and analytics project** simulating a real-world food delivery service in Cassino, Italy. This project showcases **database design, SQL analysis, and Python-based data visualization**.

---

## 📌 Project Overview

This project models a complete food delivery ecosystem, including:

* 📦 Structured **relational database schema**
* 📊 Realistic **2025 transactional data**
* 🔍 **12 analytical SQL queries** for business insights
* 🐍 **Python analytics dashboard** with visualizations and KPIs

---

## 🗄️ Database Structure

The system is built on 8 interconnected tables:

| Table                    | Description                               |
| ------------------------ | ----------------------------------------- |
| `Customer`               | Customer profiles and contact information |
| `Restaurant`             | Restaurant details and cuisine categories |
| `Driver`                 | Driver data and vehicle types             |
| `Order`                  | Order transactions and status tracking    |
| `Menu_Item`              | Menu catalog with pricing                 |
| `Order_Item`             | Items within each order                   |
| `Delivery`               | Delivery logistics and ratings            |
| `Customer_Order_Summary` | Analytical view for segmentation          |

---

## 📊 SQL Analytics

Includes **12 business-focused queries**, such as:

* 📈 Restaurant revenue ranking
* 💰 Customer lifetime value (CLV)
* ⏰ Peak order hours
* 🚗 Delivery performance by vehicle
* 🍦 Seasonal demand trends
* ❌ Order cancellation insights

---

## 🐍 Python Data Analysis

The Python module provides:

### 📊 Dashboard Features

* 6 data visualizations
* Clean, business-oriented insights

### 📌 Key Metrics

* **Total Revenue:** €3,398.50
* **Average Order Value:** €24.63
* **Completion Rate:** 86.4%
* **Peak Hour:** 20:00

### 📁 Outputs

* Exported CSV datasets for reporting and reuse

---

## 📁 Project Structure

```
food-delivery-management-system/
│
├── sql/
│   └── food_delivery_schema.sql
│
├── python/
│   └── food_delivery_analysis.py
│
├── data/
│   ├── orders.csv
│   ├── restaurants.csv
│   ├── deliveries.csv
│   └── drivers.csv
│
├── README.md
├── requirements.txt
└── .gitignore
```

---

## 🚀 Getting Started

### 🔧 Prerequisites

* MySQL (or compatible SQL database)
* Python 3.7+

---

### ⚙️ Installation

#### 1. Clone the repository

```bash
git clone https://github.com/yourusername/food-delivery-management-system.git
cd food-delivery-management-system
```

#### 2. Set up the database

```bash
mysql -u root -p < sql/food_delivery_schema.sql
```

#### 3. Install dependencies

```bash
pip install -r requirements.txt
```

#### 4. Export data from MySQL

```sql
SELECT * FROM `Order` INTO OUTFILE 'data/orders.csv';
SELECT * FROM Restaurant INTO OUTFILE 'data/restaurants.csv';
SELECT * FROM Delivery INTO OUTFILE 'data/deliveries.csv';
SELECT * FROM Driver INTO OUTFILE 'data/drivers.csv';
```

#### 5. Run Python analysis

```bash
cd python
python food_delivery_analysis.py
```

---

## 📈 Sample SQL Queries

### 🔝 Top Restaurants by Revenue

```sql
SELECT r.name, SUM(o.total_amount) AS revenue
FROM Restaurant r
JOIN `Order` o ON r.restaurant_id = o.restaurant_id
WHERE o.status = 'Delivered'
GROUP BY r.name
ORDER BY revenue DESC;
```

### 👥 Customer Segmentation

```sql
SELECT customer_tier, COUNT(*) AS customer_count
FROM Customer_Order_Summary
GROUP BY customer_tier;
```

---

## 📊 Key Insights

* 💰 **Total Revenue:** €3,398.50
* 🍝 **Most Popular Cuisine:** Italian
* ⏰ **Peak Hour:** 20:00
* 📅 **Best Month:** December
* ⭐ **Average Rating:** 4.5/5
* 🥇 **Top Restaurant:** Pizzeria Regina

---

## 🛠️ Technologies Used

* **Database:** MySQL
* **Languages:** SQL, Python

### Python Libraries

* Pandas → Data manipulation
* Matplotlib → Visualization
* Seaborn → Statistical graphics

---

## 👤 Author

**Michael Tefera**
GitHub: https://github.com/michaeltefera21-ai

---

## 📅 Project Details

* 🎓 Course: Data Management
* 📍 Location: Cassino, Italy
* 📆 Year: 2025

---

## 📝 License

This project is intended for **educational purposes only**.

---

## 🔮 Future Improvements

* 🔐 User authentication system
* 📍 Real-time delivery tracking
* 🌐 Web interface (frontend + backend)
* 🤖 Machine learning predictions
* 💳 Payment system integration

---

⭐ If you found this project useful, consider giving it a star!
