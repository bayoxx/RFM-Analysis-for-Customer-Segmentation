  --Query for Frequnecy & Monetary
WITH
  F_M_CTE AS (
  SELECT
    CustomerID,
    Country,
    MAX(InvoiceDate) AS last_purchase_date,
    COUNT(DISTINCT InvoiceNo) AS frequency,
    SUM(Quantity*UnitPrice) AS monetary
  FROM
    `tc-da-1.turing_data_analytics.rfm`
  WHERE
    InvoiceDate BETWEEN '2010-12-01'
    AND '2011-11-30'
    AND CustomerID IS NOT NULL
  GROUP BY
    CustomerID,
    Country),
  --Query for recency
  recency_CTE AS (
  SELECT
    *,
    DATE_DIFF('2011-12-01', CAST(last_purchase_date AS DATE), DAY) AS recency
  FROM
    F_M_CTE 
WHERE last_purchase_date IS NOT NULL
AND frequency IS NOT NULL
AND last_purchase_date IS NOT NULL),
  --Quintiles for RFM
  RFM_quintile AS(
  SELECT
    recency_CTE.*,
    monetary_quintile.percentiles[
  OFFSET
    (25)] AS m25,
    monetary_quintile.percentiles[
  OFFSET
    (50)] AS m50,
    monetary_quintile.percentiles[
  OFFSET
    (75)] AS m75,
    monetary_quintile.percentiles[
  OFFSET
    (100)] AS m100,
    frequency_quintile.percentiles[
  OFFSET
    (25)] AS f25,
    frequency_quintile.percentiles[
  OFFSET
    (50)] AS f50,
    frequency_quintile.percentiles[
  OFFSET
    (75)] AS f75,
    frequency_quintile.percentiles[
  OFFSET
    (100)] AS f100,
    recency_quintile.percentiles[
  OFFSET
    (25)] AS r25,
    recency_quintile.percentiles[
  OFFSET
    (50)] AS r50,
    recency_quintile.percentiles[
  OFFSET
    (75)] AS r75,
    recency_quintile.percentiles[
  OFFSET
    (100)] AS r100
  FROM
    recency_CTE,
    (
    SELECT
      APPROX_QUANTILES(monetary, 100) percentiles
    FROM
      Recency_CTE) AS monetary_quintile,
    (
    SELECT
      APPROX_QUANTILES(frequency, 100) percentiles
    FROM
      recency_CTE) frequency_quintile,
    (
    SELECT
      APPROX_QUANTILES(recency, 100) percentiles
    FROM
      recency_CTE) AS recency_quintile ),
  --Assigning scores for R and combined FM
  scores AS (
  SELECT
    *,
    CAST(ROUND((f_score + m_score) / 2, 0) AS INT64) AS fm_score
  FROM (
    SELECT
      *,
      CASE
        WHEN monetary <= m25 THEN 1
        WHEN monetary <= m50
      AND monetary > m25 THEN 2
        WHEN monetary <= m75 AND monetary > m50 THEN 3
        WHEN monetary <= m100
      AND monetary > m75 THEN 4
    END
      AS m_score,
      CASE
        WHEN frequency <= f25 THEN 1
        WHEN frequency <= f50
      AND frequency > f25 THEN 2
        WHEN frequency <= f75 AND frequency > f50 THEN 3
        WHEN frequency <= f100
      AND frequency > f75 THEN 4
    END
      AS f_score,
      --Recency scoring is reversed
      CASE
        WHEN recency <= r25 THEN 4
        WHEN recency <= r50
      AND recency > r25 THEN 3
        WHEN recency <= r75 AND recency > r50 THEN 2
        WHEN recency <= r100
      AND recency > r75 THEN 1
    END
      AS r_score,
    FROM
      RFM_quintile ) ),
  --RFM segments
  RFM_segments AS (
  SELECT
    CustomerID,
    Country,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    fm_score,
    CASE
      WHEN (r_score = 4 AND fm_score = 4) THEN 'Best Customers'
      WHEN (r_score = 3
      AND fm_score =4) THEN 'Big Spenders'
      WHEN (r_score = 4 AND fm_score = 3) OR (r_score = 3 AND fm_score = 3) THEN 'Loyal Customers'
      WHEN (r_score = 4
      AND fm_score = 2)
    OR (r_score = 3
      AND fm_score = 2)
    OR (r_score = 3
      AND fm_score = 1) THEN 'Promising'
      WHEN r_score = 4 AND fm_score = 1 THEN 'Recent Customers'
      WHEN (r_score = 2
      AND fm_score = 3)
    OR (r_score = 2
      AND fm_score = 2) THEN 'Customers Needing Attention'
      WHEN (r_score = 2 AND fm_score = 4) THEN 'At Risk'
      WHEN (r_score = 2
      AND fm_score = 1) THEN 'About to Sleep'
      WHEN (r_score = 1 AND fm_score = 4) OR (r_score = 1 AND fm_score = 3) THEN 'Cant Loose Them'
      WHEN r_score = 1
    AND fm_score = 2 THEN 'Hibernating'
      WHEN r_score = 1 AND fm_score = 1 THEN 'Lost'
  END
    AS rfm_seg
  FROM
    scores )
SELECT
  *
FROM
  RFM_segments;





