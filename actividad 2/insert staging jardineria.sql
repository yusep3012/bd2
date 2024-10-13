USE [StagingJardineria]

GO

/* ========================================================================== */

/* Inserción de las fechas a la tabla dim_fecha_st */

TRUNCATE TABLE dim_fecha_st

INSERT INTO dim_fecha_st
           (fecha
		   ,año
           ,mes
           ,dia
           ,semestre
           ,num_semana)
SELECT DISTINCT
	Jardineria.dbo.pedido.fecha_pedido,
	YEAR(Jardineria.dbo.pedido.fecha_pedido) AS Año,
	MONTH(Jardineria.dbo.pedido.fecha_pedido) AS Mes,
	DAY(Jardineria.dbo.pedido.fecha_pedido) AS Dia,
	DATEPART(WEEK, Jardineria.dbo.pedido.fecha_pedido) AS NumeroDeSemana,
	DATEPART(QUARTER, fecha_pedido) AS NumeroDeSemestre
FROM Jardineria.dbo.pedido

GO

/* ========================================================================== */

/* Inserción de las ubicaciones a la tabla dim_geografia_st*/
TRUNCATE TABLE dim_geografia_st

INSERT INTO dim_geografia_st
           (ciudad
           ,pais
           ,region)


SELECT DISTINCT ciudad, pais, region FROM Jardineria.dbo.cliente
UNION
SELECT DISTINCT ciudad, pais, region FROM Jardineria.dbo.oficina

GO

/* ========================================================================== */

/* Inserción de los productos a la tabla dim_producto_st */

TRUNCATE TABLE dim_producto_st

INSERT INTO dim_producto_st
           (nombre
           ,precio_venta
           ,desc_categoria)

SELECT Jardineria.dbo.producto.nombre, 
		Jardineria.dbo.producto.precio_venta, 
		Jardineria.dbo.producto.descripcion	
FROM Jardineria.dbo.producto;
		   
GO

/* ========================================================================== */

/* Inserción de los empleados a la tabla dim_empleado_st */

TRUNCATE TABLE dim_empleado_st
SET IDENTITY_INSERT dim_empleado_st ON;

INSERT INTO dim_empleado_st
           (id_dim_empleado
		   ,nombre
           ,puesto
		   ,nombre_jefe)
SELECT e.ID_empleado, e.nombre + ' ' + e.apellido1 + ' ' + e.apellido2 AS nombre_empleado, e.puesto, j.nombre + ' ' + j.apellido1 + ' ' + j.apellido2 AS nombre_jefe
FROM Jardineria.dbo.empleado e LEFT JOIN Jardineria.dbo.empleado j
ON e.ID_jefe = j.ID_empleado;

GO

/* ========================================================================== */

/* Inserción de las oficinas a la tabla dim_oficina_st */

TRUNCATE TABLE dim_oficina_st

INSERT INTO dim_oficina_st
           (descripcion)

SELECT Jardineria.dbo.oficina.Descripcion
FROM Jardineria.dbo.oficina

GO

/* ========================================================================== */

/* Inserción de los clientes a la tabla dim_cliente_st */


INSERT INTO dim_cliente_st
           (nombre
           ,telefono)
SELECT Jardineria.dbo.cliente.nombre_cliente, Jardineria.dbo.cliente.telefono
FROM Jardineria.dbo.cliente

GO

/* ========================================================================== */

/* Inserción de las ventas a la tabla fac_ventas*/

INSERT INTO fac_ventas_st
           (id_dim_empleado
           ,id_dim_fecha
           ,id_dim_oficina
           ,id_dim_cliente
           ,id_dim_geo_empleado
           ,id_dim_geo_cliente
           ,id_dim_geo_oficina
           ,id_dim_producto
           ,cantidad
           ,precio_unidad
           ,valor_total)
SELECT 
	c.ID_empleado_rep_ventas AS id_empleado,
	f.id_dim_fecha,
	e.ID_oficina,
	p.ID_cliente,
	gof.id_dim_geografia AS id_geo_empleado,
    g.id_dim_geografia AS id_geo_cliente,
	gof.id_dim_geografia AS id_geo_oficina,
    dp.ID_producto,
    dp.cantidad,
    dp.precio_unidad,
    (dp.cantidad * dp.precio_unidad) AS valor_total
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
ORDER BY 
    3;

GO