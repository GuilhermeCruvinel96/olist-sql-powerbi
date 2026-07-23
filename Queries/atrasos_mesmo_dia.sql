SELECT COUNT(*) AS Atrasos_Mesmo_Dia
FROM olist_orders_dataset
WHERE order_status = 'delivered'
AND order_delivered_customer_date > order_estimated_delivery_date
AND DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) = 0