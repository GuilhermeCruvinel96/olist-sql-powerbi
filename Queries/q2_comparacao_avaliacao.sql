SELECT
    CASE 
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) > 0
        THEN 'Atrasado' 
        ELSE 'No prazo' 
    END AS status_entrega,
    CAST(ROUND(AVG(CAST(review_score AS DECIMAL(3,2))), 2) AS DECIMAL(4,2)) AS media_avaliacao
FROM olist_orders_dataset AS O
INNER JOIN olist_order_reviews_dataset AS R ON R.order_id = O.order_id
WHERE order_status = 'delivered'
GROUP BY 
    CASE 
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) > 0
        THEN 'Atrasado' 
        ELSE 'No prazo' 
    END