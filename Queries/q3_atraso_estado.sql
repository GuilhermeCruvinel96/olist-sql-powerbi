use olist

SELECT
    customer_state AS Estado,
    COUNT(*) AS 'Pedidos Entregues',
    SUM(CASE
        WHEN order_delivered_customer_date > order_estimated_delivery_date 
        THEN 1 
        ELSE 0 
        END) AS 'Pedidos Atrasados',
    CAST(
        SUM(CASE    
            WHEN order_delivered_customer_date > order_estimated_delivery_date
            THEN 1 
            ELSE 0 
            END) * 100.0 / COUNT(*)
            AS DECIMAL(5, 2)) AS 'Percentual de Atraso'
FROM olist_orders_dataset AS O
INNER JOIN olist_customers_dataset C ON C.customer_id = O.customer_id
WHERE order_status = 'delivered'
GROUP BY customer_state
ORDER BY 4 DESC