USE [DatamartJardineria]

GO

/* ========================================================================== */

/* Inserción de las fechas a la tabla dim_fecha */

TRUNCATE TABLE dim_fecha

INSERT INTO dim_fecha
           (fecha
		   ,año
           ,mes
           ,dia
           ,semestre
           ,num_semana)
SELECT
	StagingJardineria.dbo.dim_fecha_st.fecha,
	StagingJardineria.dbo.dim_fecha_st.año,
	StagingJardineria.dbo.dim_fecha_st.mes,
	StagingJardineria.dbo.dim_fecha_st.dia,
	StagingJardineria.dbo.dim_fecha_st.semestre,
	StagingJardineria.dbo.dim_fecha_st.num_semana
FROM StagingJardineria.dbo.dim_fecha_st

GO

/* ========================================================================== */

/* Inserción de las ubicaciones a la tabla dim_geografia*/
TRUNCATE TABLE dim_geografia

INSERT INTO dim_geografia
           (ciudad
           ,pais
           ,region)

SELECT [ciudad]
      ,[pais]
      ,ISNULL([region], 'Sin región')
  FROM [StagingJardineria].[dbo].[dim_geografia_st]

GO

/* ========================================================================== */

/* Inserción de los productos a la tabla dim_producto */

TRUNCATE TABLE dim_producto

INSERT INTO dim_producto
           (nombre
           ,precio_venta
           ,desc_categoria)

SELECT LOWER([nombre])
      ,[precio_venta]
      ,(COALESCE(NULLIF(desc_categoria, ''), 'Sin descripción')) AS desc_categoria
FROM [StagingJardineria].[dbo].[dim_producto_st]
		   
GO

/* ========================================================================== */

/* Inserción de los empleados a la tabla dim_empleado */

TRUNCATE TABLE dim_empleado
SET IDENTITY_INSERT dim_empleado ON;

INSERT INTO dim_empleado
           (id_dim_empleado
		   ,nombre
           ,puesto
		   ,nombre_jefe)

SELECT [id_dim_empleado]
      ,[nombre]
      ,[puesto]
      ,ISNULL([nombre_jefe], 'Sin nombre de jefe') AS nombre_jefe
  FROM [StagingJardineria].[dbo].[dim_empleado_st]

GO

/* ========================================================================== */

/* Inserción de las oficinas a la tabla dim_oficina */

TRUNCATE TABLE dim_oficina

INSERT INTO dim_oficina
           (descripcion)

SELECT descripcion
FROM StagingJardineria.dbo.dim_oficina_st

GO

/* ========================================================================== */

/* Inserción de los clientes a la tabla dim_cliente */

TRUNCATE TABLE dim_cliente

INSERT INTO dim_cliente
           (nombre
           ,telefono)
SELECT nombre, telefono
FROM StagingJardineria.dbo.dim_cliente_st

GO

/* ========================================================================== */

/* Inserción de las ventas a la tabla fac_ventas*/
TRUNCATE TABLE fac_ventas

INSERT INTO fac_ventas
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

SELECT id_dim_empleado
           ,id_dim_fecha
           ,id_dim_oficina
           ,id_dim_cliente
           ,id_dim_geo_empleado
           ,ISNULL(id_dim_geo_cliente, -999) AS id_dim_geo_cliente
           ,id_dim_geo_oficina
           ,id_dim_producto
           ,cantidad
           ,precio_unidad
           ,valor_total
FROM 
    StagingJardineria.dbo.fac_ventas_st

GO
