SELECT
    P.product_category_name AS Categoria,
    COUNT(*) AS Total_Pedidos,
    CAST(ROUND(AVG(CASE WHEN O.order_delivered_customer_date > O.order_estimated_delivery_date THEN 100.0 ELSE 0 END), 2) AS DECIMAL(5,2)) AS 'Percentual Atraso',
    CAST(ROUND(AVG(CAST(R.review_score AS DECIMAL(3,2))), 2) AS DECIMAL(4,2)) AS 'Média Avaliacao'
FROM olist_orders_dataset AS O
INNER JOIN olist_order_reviews_dataset AS R ON R.order_id = O.order_id
INNER JOIN olist_order_items_dataset AS I ON I.order_id = O.order_id
INNER JOIN olist_products_dataset AS P ON P.product_id = I.product_id
WHERE O.order_status = 'delivered'
AND P.product_category_name IS NOT NULL
GROUP BY P.product_category_name
HAVING COUNT(*) >= 50
ORDER BY AVG(CAST(R.review_score AS DECIMAL(3,2)))