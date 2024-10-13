/* Transformación cuando el nombre del jefe es NULL */

SELECT [id_dim_empleado]
      ,[nombre]
      ,[puesto]
      ,ISNULL([nombre_jefe], 'Sin nombre de jefe') AS nombre_jefe
  FROM [StagingJardineria].[dbo].[dim_empleado_st]

/* ============================================================ */

/* Normalización de nombres de ciudades y países */

UPDATE [dbo].[dim_geografia_st]
   SET [ciudad] = 'Londres'
 WHERE ciudad IN('London')
GO


UPDATE [dbo].[dim_geografia_st]
   SET [pais] = 'España'
 WHERE pais IN('Spain')
GO


UPDATE [dbo].[dim_geografia_st]
   SET [pais] = 'Estados Unidos'
 WHERE pais IN('EEUU', 'USA')
GO


/* Transformación cuando la región es NULL */

SELECT [id_dim_geografia]
      ,[ciudad]
      ,[pais]
      ,ISNULL([region], 'Sin región') AS region
  FROM [StagingJardineria].[dbo].[dim_geografia_st]


/* ============================================================ */

/* Transformación de todos los datos de la columna nombre a minúscula */
/* Transformación de las descripciones vacías */

SELECT [id_dim_producto]
      ,LOWER([nombre])
      ,[precio_venta]
      ,(COALESCE(NULLIF(desc_categoria, ''), 'Sin descripción')) AS desc_categoria
FROM [StagingJardineria].[dbo].[dim_producto_st]


/* ============================================================ */

/* Transformación cuando el id_dim_geo_cliente es NULL */

SELECT [id_fac_ventas]
      ,[id_dim_empleado]
      ,[id_dim_fecha]
      ,[id_dim_oficina]
      ,[id_dim_cliente]
      ,[id_dim_geo_empleado]
      ,ISNULL([id_dim_geo_cliente], -999) AS id_dim_geo_cliente
      ,[id_dim_geo_oficina]
      ,[id_dim_producto]
      ,[cantidad]
      ,[precio_unidad]
      ,[valor_total]
  FROM [StagingJardineria].[dbo].[fac_ventas_st]

/* ============================================================ */