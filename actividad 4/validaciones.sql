USE DatamartJardineria

/* Validaciones de la tabla cliente: número de registros */
SELECT COUNT(*) AS cantidad_dm FROM DatamartJardineria.dbo.dim_cliente

/* Validaciones de la tabla empleado: número de registros */
SELECT COUNT(*) AS cantidad_dm FROM  DatamartJardineria.dbo.dim_empleado

/* Validaciones de la tabla fecha: número de registros */
SELECT COUNT(*) AS cantidad_dm FROM DatamartJardineria.dbo.dim_fecha

/* Validaciones de la tabla geografia: número de registros */
SELECT COUNT(*) AS cantidad_st FROM DatamartJardineria.dbo.dim_geografia

/* Validaciones de la tabla oficina: número de registros */
SELECT COUNT(*) AS cantidad_st FROM DatamartJardineria.dbo.dim_oficina

/* Validaciones de la tabla producto: número de registros */
SELECT COUNT(*) AS cantidad_st FROM DatamartJardineria.dbo.dim_producto

/* Validaciones de la tabla ventas: número de registros */
SELECT COUNT(*) AS cantidad_dm
		,SUM(cantidad) AS unidades_vendidas_dm
		,SUM(cantidad * precio_unidad) AS valor_total_venta_dm
FROM DatamartJardineria.dbo.fac_ventas


/* ======================================================================= */

USE StagingJardineria

/* Validaciones de la tabla empleado: número de registros */
SELECT COUNT(*) AS cantidad_dm FROM  StagingJardineria.dbo.dim_empleado_st

/* Validaciones de la tabla empleado: número de registros */
SELECT COUNT(*) AS cantidad_dm FROM  StagingJardineria.dbo.dim_empleado_st

/* Validaciones de la tabla fecha: número de registros */
SELECT COUNT(*) AS cantidad_st FROM StagingJardineria.dbo.dim_fecha_st

/* Validaciones de la tabla geografia: número de registros */
SELECT COUNT(*) AS cantidad_st FROM StagingJardineria.dbo.dim_geografia_st

/* Validaciones de la tabla oficina: número de registros */
SELECT COUNT(*) AS cantidad_st FROM StagingJardineria.dbo.dim_oficina_st

/* Validaciones de la tabla producto: número de registros */
SELECT COUNT(*) AS cantidad_st FROM StagingJardineria.dbo.dim_producto_st

/* Validaciones de la tabla ventas: número de registros */
SELECT COUNT(*) AS cantidad_st 
		,SUM(cantidad) AS unidades_vendidas_st
		,SUM(cantidad * precio_unidad) AS valor_total_venta_st
FROM StagingJardineria.dbo.fac_ventas_st


/* ======================================================================= */

/* Productos con mas ventas en la tabla de datamart, staging y jardinería */

SELECT TOP 1 id_dim_producto, SUM(cantidad) AS cantidad_dm FROM DatamartJardineria.dbo.fac_ventas GROUP BY id_dim_producto ORDER BY cantidad_dm DESC

SELECT TOP 1  id_dim_producto, SUM(cantidad) AS cantidad_st FROM StagingJardineria.dbo.fac_ventas_st GROUP BY id_dim_producto ORDER BY cantidad_st DESC

SELECT TOP 1 
    dp.ID_producto,
    sum(dp.cantidad) AS cantidad_jard

FROM 
    Jardineria.dbo.pedido p
JOIN 
    Jardineria.dbo.detalle_pedido dp ON p.ID_pedido = dp.ID_pedido
JOIN 
    Jardineria.dbo.cliente c ON p.ID_cliente = c.ID_cliente
JOIN 
    StagingJardineria.dbo.dim_fecha_st f ON p.fecha_pedido = f.fecha
JOIN 
    Jardineria.dbo.empleado e ON c.ID_empleado_rep_ventas = e.ID_empleado
LEFT JOIN 
    StagingJardineria.dbo.dim_geografia_st g ON c.pais = g.pais AND c.region = g.region AND c.ciudad = g.ciudad
JOIN
	Jardineria.dbo.oficina o ON o.ID_oficina = e.ID_oficina
LEFT JOIN 
    StagingJardineria.dbo.dim_geografia_st gof ON o.pais = gof.pais AND o.region = gof.region AND o.ciudad = gof.ciudad
GROUP BY ID_producto
ORDER BY cantidad_jard desc;