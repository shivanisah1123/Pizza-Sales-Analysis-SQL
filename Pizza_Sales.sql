create database pizzasales_db;
use pizzasales_db;

create table order_details
( 
order_details_id int not null,
order_id int not null,
pizza_id text not null ,
quantity int not null,
primary key(order_details_id) 
);

select * from order_details;
-- Basic:
-- 1. Retrieve the total number of orders placed.

SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;


-- 2. Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(o.quantity * p.price), 2) AS total_revenue
FROM
    order_details AS o
        JOIN
    pizzas AS p ON o.pizza_id = p.pizza_id;
 
 -- 3. Identify the highest-priced pizza.
 
 SELECT 
    t.name, p.price
FROM
    pizza_types AS t
        JOIN
    pizzas AS p ON t.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
 
-- 4. Identify the most common pizza size ordered.

SELECT 
    p.size, COUNT(o.order_details_id) AS order_count
FROM
    pizzas AS p
        JOIN
    order_details AS o ON p.pizza_id = o.pizza_id
GROUP BY p.size
ORDER BY order_count DESC;


-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT 
    t.name, SUM(o.quantity) AS quantity
FROM
    pizza_types AS t
        JOIN
    pizzas as p ON t.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = p.pizza_id
GROUP BY t.name
ORDER BY quantity DESC
LIMIT 5;
		
 -- Intermediate:
-- 1. Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    t.category , SUM(o.quantity) AS quantity
FROM
    pizza_types AS t
        JOIN
    pizzas as p ON t.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = p.pizza_id
GROUP BY t.category
ORDER BY quantity DESC;


-- 2. Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY hour; 


-- 3. Join relevant tables to find the category-wise distribution of pizzas

SELECT 
    category, COUNT(name) AS pizza_count
FROM
    pizza_types
GROUP BY category;

-- 4.  Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(quantity), 0) AS avg_no_of_pizza_order
FROM
    (SELECT 
        orders.date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.date) AS order_quantity;
    
    -- 5. Determine the top 3 most ordered pizza types based on revenue.
    
    SELECT 
    t.name, SUM(o.quantity * p.price) AS Revenue
FROM
    pizza_types AS t
        JOIN
    pizzas AS p ON t.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS o ON o.pizza_id = p.pizza_id
GROUP BY t.name
ORDER BY Revenue DESC
LIMIT 3;

-- Advanced:
-- Calculate the percentage contributionpizza_types of each pizza type to total revenue.

SELECT 
pizza_types.category,
ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
	ROUND(SUM(order_details.quantity * pizzas.price),2) AS total_sales
		FROM order_details
			JOIN
			 pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
             2) AS Revenue
FROM pizza_types JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category ORDER BY Revenue DESC;


-- 2.Analyze the cumulative revenue generated over time.

select
      date , round(sum(Revenue) over(order by date),2)
              as Cum_Revenue
 from
	    (select orders.date,
       sum(order_details.quantity * pizzas.price ) as Revenue
 from   order_details 
				join 
        pizzas on order_details.pizza_id = pizzas.pizza_id
             join 
         orders on orders.order_id = order_details.order_id
group by
              orders.date)  as sales limit 10 ;

-- 3. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select
       name , Revenue from (select category ,
	   name, Revenue , rank() over(partition by category 
 order by 
		Revenue desc) as rn
from
(select
		pizza_types.category, pizza_types.name ,
        sum((order_details.quantity) * pizzas.price) 
             as Revenue from pizza_types 
         join
	pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
         join
			order_details on order_details.pizza_id = pizzas.pizza_id
group by
            pizza_types.category , pizza_types.name) as a ) as b
 where
                      rn <=3 ;



DESCRIBE Orders;
DESCRIBE Order_details ;
DESCRIBE pizzas;
DESCRIBE pizza_types;

ALTER TABLE Orders
ADD CONSTRAINT pk_order
PRIMARY KEY (order_id);


ALTER TABLE Order_Details
ADD CONSTRAINT fk_order
FOREIGN KEY (order_id) REFERENCES Orders(order_id);


ALTER TABLE Pizzas
ADD CONSTRAINT pk_pizza
PRIMARY KEY (pizza_id);


ALTER TABLE Order_Details
ADD CONSTRAINT fk_pizza
FOREIGN KEY (pizza_id) REFERENCES Pizzas(pizza_id);

ALTER TABLE Order_Details
MODIFY pizza_id VARCHAR(255);

ALTER TABLE Pizzas
MODIFY pizza_id VARCHAR(255);

-- Now, you can add the primary key constraint
ALTER TABLE Pizzas
ADD CONSTRAINT pk_pizza
PRIMARY KEY (pizza_id);


ALTER TABLE Pizzas
ADD CONSTRAINT pk_pizza
PRIMARY KEY (pizza_id(255)); 

ALTER TABLE Order_Details
ADD CONSTRAINT fk_pizza
FOREIGN KEY (pizza_id) REFERENCES Pizzas(pizza_id);


-- Change pizza_type_id in pizzas table to INT
ALTER TABLE pizzas MODIFY pizza_type_id INT;

-- If needed, also change pizza_type_id in pizza_type table
ALTER TABLE pizza_type MODIFY pizza_type_id INT;


ALTER TABLE pizzas
ADD CONSTRAINT fk_pizza_type_id FOREIGN KEY (pizza_type_id) REFERENCES pizza_type(pizza_type_id);


SELECT pizza_type_id FROM pizzas;

ALTER TABLE pizzas MODIFY pizza_type_id VARCHAR(255);
ALTER TABLE pizza_types MODIFY pizza_type_id VARCHAR(255);

ALTER TABLE pizzas
ADD CONSTRAINT fk_pizza_type_id FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id);

CREATE INDEX idx_pizza_type_id ON pizza_types(pizza_type_id);


ALTER TABLE pizzas
ADD CONSTRAINT fk_pizza_type_id FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id);



SELECT Pizza_name, SUM(Quantity) AS Total_Sales
FROM Order_Details
GROUP BY Pizza_name
ORDER BY Total_Sales DESC
LIMIT 1;



WITH total_revenue AS (
SELECT 
    name, 
    ROUND(SUM(price * quantity), 2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas USING (pizza_type_id)
        JOIN
    order_details USING (pizza_id)
GROUP BY name
)
SELECT 
    name,
    CONCAT(
            ROUND(100 * revenue / sum(revenue) over() ,2) ,
            '%'
              )    AS Total_Revenue
FROM
    total_revenue;
    
    
    
    WITH total_revenue AS
(
SELECT 
    order_date, 
    ROUND(SUM(price * quantity), 2) AS revenue
FROM
    orders
        JOIN
    order_details USING (order_id)
        JOIN
    pizzas USING (pizza_id)
GROUP BY order_date
)

SELECT 
        *,
ROUND(
            SUM(revenue) OVER (ORDER BY order_date),
            2
                )  AS cum_revenue
FROM total_revenue;