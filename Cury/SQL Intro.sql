-- Databricks notebook source
select *
from silver.olist.pedido

-- COMMAND ----------

SELECT
  idPedido,
  idCliente,
  date(dtEntregue) as dataEntrega,
  date(dtEstimativaEntrega) as dataEstimada,
  date(dtEntregue) > date(dtEstimativaEntrega) as flAtraso,
  CASE datediff(dtEntregue, dtEstimativaEntrega)
    WHEN <= 1 then 0 else datediff(dtEntregue, dtEstimativaEntrega) END as QtdDiasAtraso
FROM silver.olist.pedido
