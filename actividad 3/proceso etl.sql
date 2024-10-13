/* Transformaci�n cuando el nombre del jefe es NULL */

SELECT [id_dim_empleado]
      ,[nombre]
      ,[puesto]
      ,ISNULL([nombre_jefe], 'Sin nombre de jefe') AS nombre_jefe
  FROM [StagingJardineria].[dbo].[dim_empleado_st]

/* ============================================================ */

/* Normalizaci�n de nombres de ciudades y pa�ses */

UPDATE [dbo].[dim_geografia_st]
   SET [ciudad] = 'Londres'
 WHERE ciudad IN('London')
GO


UPDATE [dbo].[dim_geografia_st]
   SET [pais] = 'Espa�a'
 WHERE pais IN('Spain')
GO


UPDATE [dbo].[dim_geografia_st]
   SET [pais] = 'Estados Unidos'
 WHERE pais IN('EEUU', 'USA')
GO


/* Transformaci�n cuando la regi�n es NULL */

SELECT [id_dim_geografia]
      ,[ciudad]
      ,[pais]
      ,ISNULL([region], 'Sin regi�n') AS region
  FROM [StagingJardineria].[dbo].[dim_geografia_st]


/* ============================================================ */

/* Transformaci�n de todos los datos de la columna nombre a min�scula */
/* Transformaci�n de las descripciones vac�as */

SELECT [id_dim_producto]
      ,LOWER([nombre])
      ,[precio_venta]
      ,(COALESCE(NULLIF(desc_categoria, ''), 'Sin descripci�n')) AS desc_categoria
FROM [StagingJardineria].[dbo].[dim_producto_st]


/* ============================================================ */

/* Transformaci�n cuando el id_dim_geo_cliente es NULL */

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