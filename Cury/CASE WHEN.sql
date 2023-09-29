-- Databricks notebook source
SELECT * 
FROM silver.olist.produto
WHERE descCategoria = 'bebes'
ORDER BY vlPesoGramas DESC, vlComprimentoCm DESC --ORDER BY aparece depois de todas as cláusulas.


-- COMMAND ----------

--CASE WHEN: pode ser utilizado para construir novas variáveis a partir da esturura e dos dados existentes.
--Como se trata de criar nova coluna, ele deve ser posicionado no SELECT (antes do FROM).

SELECT *, 
  CASE WHEN descUF = 'SP' AND descCidade = 'sao paulo' THEN 'Paulistano'
  WHEN descUF = 'SC' THEN 'Catarinense'
  WHEN descUF = 'PR' THEN 'Paranaense'
  WHEN descUF IS NULL then 'Desconhecido'
  ELSE 'Outros'
  END as naturalidade
FROM silver.olist.cliente


--O END é inserido para finalizar o CASE, e, após isso, é possível informar um nome para a coluna criada (as naturalidade).

select * from 
(SELECT *, 
  CASE WHEN descUF = 'SP' THEN 'Paulista'
  WHEN descUF = 'SC' THEN 'Catarinense'
  WHEN descUF = 'PR' THEN 'Paranaense'
  WHEN descUF IS NULL then 'Desconhecido'
  ELSE 'Outros'
  END as naturalidade
FROM silver.olist.cliente)
where naturalidade = 'Paranaense'


-- COMMAND ----------


