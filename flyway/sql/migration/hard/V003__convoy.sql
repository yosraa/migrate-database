SELECT shipper_id, b.month
FROM (
	SELECT MONTH(date_time) AS month, AVERAGE(cnt) AS avgcnt
	FROM (
		SELECT shipper_id, MONTH(date_time) AS month, COUNT(*) cnt
		FROM df
		GROUP BY MONTH(date_time), shipper_id) a1
	GROUP BY month) a
JOIN (
    SELECT shipper_id, MONTH(date_time) AS month, COUNT(*) AS cnt
    FROM df
    GROUP BY MONTH(date_time), shipper_id) b
ON a.month = b.month
WHERE cnt >= (2 * avgcnt)

SELECT lane, n_shipments
FROM (
	SELECT CONCAT(IF(pickup_state >= dropoff_state, dropoff_state, pickup_state), "-",
		IF(pickup_state < dropoff_state, dropoff_state, pickup_state)) AS lane,
		MONTH(date) AS mon,
		COUNT(*) AS n_shipments
	FROM df
	GROUP BY MONTH(date), lane
	HAVING mon = 1 OR mon = 2
	ORDER BY n_shipments DESC
	LIMIT 1) sub