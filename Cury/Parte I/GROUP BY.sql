-- Databricks notebook source
--A ideia de agregações é resumir muitas linhas em uma só medida.
--Os cálculos mais comuns para agregar os dados são: 

--COUNT() é a contagem de linhas NÃO NULAS, podendo agregar pela dimensão de alguma coluna.

SELECT count(*) as Contagem
FROM silver.olist.produto

--O resultado equivale à quantidade de linhas não nulas (32951 produtos).


-- COMMAND ----------

--Para confirmar, é possível contar também pela coluna ID (contagem de linhas com ID não nulo)

SELECT count(*) as Contagem,
      count(idProduto) as IdNaonulo,
      count(DISTINCT idProduto)
FROM silver.olist.produto

--Aparentemente este conjunto de dados está íntegro.


-- COMMAND ----------

--Outras agregações e agrupamentos
SELECT descCategoria,
  avg(vlPesoGramas),
  min(vlPesoGramas),
  max(vlPesoGramas),
  std(vlPesoGramas),
  median(vlPesoGramas),
  percentile(vlPesoGramas, 0.25)
FROM silver.olist.produto
GROUP BY descCategoria

-- COMMAND ----------

select *
from silver.olist.produto

-- COMMAND ----------

 --Com o HAVING podemos inserir um filtro DEPOIS DO AGRUPAMENTO (GROUP By), com base nas estatísticas de agrupamento.

SELECT
  descCategoria,
  count(idProduto) as qtdProduto,
  avg(vlPesoGramas) as avgPeso,
  avg(vlAlturaCm) as avgAltura
FROM silver.olist.produto
GROUP BY descCategoria
HAVING qtdProduto >= 500
ORDER BY qtdProduto DESC

-- COMMAND ----------

--qual estado tem mais vendedores?
SELECT 
  descUF
FROM silver.olist.vendedor
GROUP BY (descUF)
ORDER BY count(DISTINCT idVendedor) desc
LIMIT 1

-- COMMAND ----------

--filtro data relativa

SELECT * 
FROM silver.olist.pedido
WHERE dtPedido >= current_date() - INTERVAL 6 years
AND descSituacao <> 'canceled'


