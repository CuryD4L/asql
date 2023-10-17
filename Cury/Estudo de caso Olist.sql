-- Databricks notebook source
SELECT *
FROM silver.olist.pedido

-- COMMAND ----------

SELECT count(DISTINCT idPedido), count(idPedido), count(DISTINCT idCliente), count(idCliente)
FROM silver.olist.pedido

--Os ids de pedido e de cliente não se repetem. Pode-se dizer que o idPedido é a chave primária da tabela, e que um idCliente é gerado para cada pedido. A base conta com 99441 pedidos.

-- COMMAND ----------

select count(idPedido), descSituacao
FROM silver.olist.pedido
group by descSituacao

--A maior parte dos pedidos consta como "entregue". Existem alguns pedidos com status que indicam potenciais problemas (cancelamentos, indisponibilidades. Vou agrupar, abaixo, como "regular" vs "irregular")

-- COMMAND ----------

select count(idPedido),
CASE when descSituacao in ("canceled", "unavailable") then "Irregular" else "Regular" end as Status 
FROM silver.olist.pedido
group by Status

-- COMMAND ----------

select year(dtPedido) as anoPedido, descSituacao, count(idPedido)
FROM silver.olist.pedido
group by anoPedido, descSituacao
order by anoPedido, descSituacao

--Tem alguns pedidos "parados no tempo", por exemplo, pedidos de 2016 que ainda estão como "shipped", ou "approved", ou "processing".

-- COMMAND ----------

select descSituacao,
avg(date_diff(dtAprovado, dtPedido)) as Pedido_Aprovacao,
avg(date_diff(dtEnvio, dtAprovado)) as Aprovacao_Envio,
avg(date_diff(dtEntregue, dtEnvio)) as Envio_Entrega
FROM silver.olist.pedido
group by descSituacao

-- COMMAND ----------

--Perguntar como é gerada a dtEstimativaentrega. Não está óbvio, pois há pedidos em todas as descSituação com datas de estimativa de entrega definidas. Mas também há pedidos com dtEstimativaEntrega null

select 
max(date(dtEstimativaEntrega)), 
descSituacao
FROM silver.olist.pedido
GROUP BY descSituacao



-- COMMAND ----------

SELECT count(idPedido), descSituacao
FROM silver.olist.pedido
WHERE dtEstimativaEntrega is null
GROUP BY descSituacao

-- COMMAND ----------

--Análise pedidos por ano
select year(dtPedido) as anoPedido, count(idPedido)
from silver.olist.pedido
group by anoPedido
order by anoPedido desc

-- COMMAND ----------

SELECT *
FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT
count(idPedido), count(DISTINCT idPedido), count(idProduto), count(DISTINCT idProduto), count(idVendedor), count(DISTINCT idVendedor)
FROM silver.olist.item_pedido

-- COMMAND ----------

SELECT idPedidoItem, count(idPedidoItem)
FROM silver.olist.item_pedido
group by idPedidoItem
order by idPedidoItem DESC



-- COMMAND ----------

SELECT avg(idPedidoItem)
FROM (SELECT DISTINCT idPedido, idPedidoItem FROM silver.olist.item_pedido)

-- COMMAND ----------

SELECT idPedido, count(idPedido) as qtdIdPedido, sum(idPedidoItem) as qtdIdPedidoItem, max(idPedidoItem) as maxProdutonoPedido
FROM silver.olist.item_pedido
GROUP BY idPedido
order by qtdIdPedido DESC
limit 20

-- COMMAND ----------

select * from silver.olist.item_pedido
where idPedido = "8272b63d03f5f79c56e9e4120aec44ef"

-- COMMAND ----------

select * from silver.olist.produto

-- COMMAND ----------

select count(ip.idPedido),v.idVendedor, date_trunc("MM",op.dtPedido) as mes_ano
from silver.olist.item_pedido as ip
full join silver.olist.pedido as op on ip.idPedido = op.idPedido
right join silver.olist.vendedor as v on v.idVendedor = ip.idVendedor
group by mes_ano, v.idVendedor



-- COMMAND ----------

SELECT count(DISTINCT descCategoria)
FROM silver.olist.produto

-- COMMAND ----------

SELECT *
FROM silver.olist.produto

-- COMMAND ----------

select *
FROM silver.olist.item_pedido
order by idPedido


-- COMMAND ----------

select distinct descTipoPagamento
from silver.olist.pagamento_pedido

-- COMMAND ----------

select i.idVendedor as Vendedor, count(*) as qtdVendas
from silver.olist.vendedor
join silver.olist.item_pedido i on vendedor.idVendedor = i.idVendedor
group by Vendedor
order by qtdVendas asc
