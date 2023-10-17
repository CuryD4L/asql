-- Databricks notebook source
--DISTINCT é uma cláusula para buscar linhas distintas em uma ou mais colunas.

SELECT DISTINCT descUF, descCidade
FROM silver.olist.cliente
ORDER BY descUF


-- COMMAND ----------

SELECT *
FROM silver.olist.cliente
WHERE descUF = 'sao paulo'

SELECT *
FROM silver.olist.cliente
WHERE descCidade = 'sao paulo'

-- COMMAND ----------

--todos os vendedores paulistas e cariocas.

SELECT *
FROM silver.olist.vendedor
WHERE (descUF = 'RJ' AND descCidade = 'rio de janeiro')
OR descUF = 'SP'

-- COMMAND ----------

SELECT *
FROM silver.olist.produto
WHERE descCategoria IN ('perfumaria', 'bebes') AND vlAlturaCm > 5

