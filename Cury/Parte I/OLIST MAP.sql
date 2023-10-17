-- Databricks notebook source
--Pedido

SELECT *
FROM silver.olist.pedido

-- COMMAND ----------

--Item pedido

SELECT *
FROM  silver.olist.item_pedido

-- COMMAND ----------

--Produto

SELECT *
FROM silver.olist.produto


-- COMMAND ----------

--Cliente

SELECT *
FROM silver.olist.cliente

-- COMMAND ----------

--Pagamento pedido

SELECT *
FROM silver.olist.pagamento_pedido


-- COMMAND ----------

--vendedor

SELECT * 
FROM silver.olist.vendedor

-- COMMAND ----------

--avaliação_pedido

SELECT * 
FROM silver.olist.avaliacao_pedido

-- COMMAND ----------

--geolocalização

SELECT *
FROM silver.olist.geolocalizacao
