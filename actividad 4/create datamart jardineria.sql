USE [DatamartJardineria]

GO

/* crear tabla de fac_ventas */

DROP TABLE IF EXISTS fac_ventas

CREATE TABLE fac_ventas (
    id_fac_ventas INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    id_dim_empleado INT,
    id_dim_fecha INT,
    id_dim_oficina INT,
    id_dim_cliente INT,
    id_dim_geo_empleado INT,
    id_dim_geo_cliente INT,
    id_dim_geo_oficina INT,
    id_dim_producto INT,
    cantidad INT,
    precio_unidad NUMERIC(18, 2),
    valor_total NUMERIC(18, 2)
);

/* ========================================================================== */

/* crear tabla de dim_fecha*/

DROP TABLE IF EXISTS dim_fecha

CREATE TABLE dim_fecha (
    id_dim_fecha INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fecha date,
    año INT,
    mes INT,
    dia INT,
    semestre INT,
    num_semana INT
);

/* ========================================================================== */

/* crear tabla de dim_geografia*/

DROP TABLE IF EXISTS dim_geografia

CREATE TABLE dim_geografia (
    id_dim_geografia INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ciudad VARCHAR(255),
    pais VARCHAR(255),
    region VARCHAR(255)
);

/* ========================================================================== */

/* crear tabla de dim_producto*/

DROP TABLE IF EXISTS dim_producto

CREATE TABLE dim_producto (
    id_dim_producto INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre VARCHAR(255),
    precio_venta NUMERIC(18, 2),
    desc_categoria VARCHAR(MAX)
);

/* ========================================================================== */

/* crear tabla de dim_empleoado*/

DROP TABLE IF EXISTS dim_empleado

CREATE TABLE dim_empleado (
    id_dim_empleado INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre VARCHAR(255),
    puesto VARCHAR(255),
    nombre_jefe VARCHAR(255)
);

/* ========================================================================== */

/* crear tabla de dim_oficina*/

DROP TABLE IF EXISTS dim_oficina

CREATE TABLE dim_oficina (
    id_dim_oficina INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    descripcion VARCHAR(255)
);

/* ========================================================================== */

/* crear tabla de dim_cliente*/

DROP TABLE IF EXISTS dim_cliente

CREATE TABLE dim_cliente (
    id_dim_cliente INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    nombre VARCHAR(255),
    telefono VARCHAR(255)
);