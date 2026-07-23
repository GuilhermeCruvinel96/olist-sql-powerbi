use olist

SELECT
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
            AS DECIMAL(5, 2)) AS 'Percentual Atraso'
FROM olist_orders_dataset
WHERE order_status = 'delivered'