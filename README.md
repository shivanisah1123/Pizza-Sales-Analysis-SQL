## Pizza-Sales-Analysis-SQL

![image](https://github.com/user-attachments/assets/1728c88a-4662-4dbb-8643-02f36379bd7b)

### Project Overview:

This project analyzes pizza sales data to identify patterns, top-selling pizzas, and optimize sales strategies using SQL.


### Objective:

- Identify sales patterns.

- Analyze the top-selling pizzas.
  
- Optimize sales strategies based on data insights.


### Data Source :

   Pizza sales dataset containing order details and customer information.

## Tools Used:

    SQL for data analysis and insight extraction.

## Key Analysis Queries

  # Basic:
  
1. Retrieve the total number of orders placed.
   
2. Calculate the total revenue generated from pizza sales.

3. Identify the highest-priced pizza.

4. Find the most common pizza type ordered.

5. List the top 5 most ordered pizza types along with their quantities.

## Intermediate:

1. Join tables to find the total quantity of each pizza category ordered.
2. Determine the distribution of orders by hour of the day.
3. Join tables to find the category-wise distribution of pizzas.
4. Group the orders by date and calculate the average number of pizzas ordered per day.
5. Determine the top 3 most ordered pizza types based on revenue.

## Advanced:

1. Calculate the percentage contribution of each pizza type to total revenue.

2. Analyze the cumulative revenue generated for the first 10 time periods.

3. Determine the top 3 pizza types based on revenue per pizza category.

### Database Structure

# Tables:

1. orders: Contains order_id, date, time.

2. order_details: Contains order_details_id, order_id, pizza_id, quantity.

3. pizzas: Contains pizza_id, pizza_type_id, size, price.

4. pizza_types: Contains pizza_type_id, name, category, ingredients.


# Relationships:

* Orders to Order Details: One-to-many.

* Order Details to Pizzas: Many-to-one.

* Pizzas to Pizza Types: Many-to-one.

# Visualizations:
ER-Diagram 

![image](https://github.com/user-attachments/assets/799d2adf-f338-460b-ae5c-9905ec0e9aeb)

## How to Run the Queries
1. Download the pizza sales dataset and SQL files from this repository.
2. Import the dataset into your preferred SQL environment (e.g., MySQL, PostgreSQL, etc.).
3. Run the SQL queries provided in the `queries.sql` file.
4. Analyze the results using the visualizations or steps mentioned in this project.


## Technologies Used
- SQL (MySQL/PostgreSQL/SQLite)
- PowerPoint/ Canva (for presentation)
- ERDPlus/DrawSQL (for ER diagram)

## Contributor
**Shivani Sah** – Developed Pizza Sales Data Analysis Using SQL


## **Contact**  
📧 Email: shivanisah888@gmail.com  


## Closing:
Thank you for exploring this project! I hope this Pizza Sales Analysis helps you understand how to use Excel for business analytics.

If you have any feedback or suggestions, feel free to reach out.
Looking forward to improving and expanding this project further.

