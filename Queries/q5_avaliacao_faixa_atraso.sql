use olist

SELECT
    CASE
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) BETWEEN 1 AND 3 THEN '1-3 dias'
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) BETWEEN 4 AND 7 THEN '4-7 dias'
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) BETWEEN 8 AND 14 THEN '8-14 dias'
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) > 14 THEN '14+'
        END AS 'Dias de Atraso'
        ,CAST(ROUND(AVG(CAST(review_score AS DECIMAL(3,2))), 2) AS DECIMAL(4,2)) AS 'Média Avaliação'
FROM olist_orders_dataset AS O
INNER JOIN olist_order_reviews_dataset AS R ON R.order_id = O.order_id
WHERE order_status = 'delivered'
AND order_delivered_customer_date > order_estimated_delivery_date
AND DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) > 0
GROUP BY CASE
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) BETWEEN 1 AND 3 THEN '1-3 dias'
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) BETWEEN 4 AND 7 THEN '4-7 dias'
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) BETWEEN 8 AND 14 THEN '8-14 dias'
        WHEN DATEDIFF(day, order_estimated_delivery_date, order_delivered_customer_date) > 14 THEN '14+'
        END
ORDER BY AVG(CAST(review_score AS DECIMAL(3,2))) DESC