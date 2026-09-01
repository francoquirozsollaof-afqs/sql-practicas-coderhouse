--Paso 1: Creo la base de datos
CREATE DATABASE ventas_tech_DB;
USE ventas_tech_DB;


--Paso 2: Elimino tablas en caso de que existan

DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS ubicaciones;
DROP TABLE IF EXISTS categorias;


--Creamos las tablas

CREATE TABLE categorias (
	id_categoria INT PRIMARY KEY,
	nombre_categoria VARCHAR(50) NOT NULL,
	descripcion VARCHAR(200)
);


-- DIMENSIÓN GEOGRÁFICA

CREATE TABLE ubicaciones (
	id_ubicacion INT PRIMARY KEY,
	ciudad VARCHAR(50) NOT NULL,
	provincia VARCHAR(50) NOT NULL,
	region VARCHAR(50) NOT NULL
);


CREATE TABLE clientes (
	id_cliente INT PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
	email VARCHAR(100) UNIQUE,
	id_ubicacion INT,
	fecha_registro DATE NOT NULL,

	CONSTRAINT FK_clientes_ubicaciones
	FOREIGN KEY (id_ubicacion)
	REFERENCES ubicaciones(id_ubicacion)
);


CREATE TABLE productos (
	id_producto INT PRIMARY KEY,
	nombre_producto VARCHAR(100) NOT NULL,
	id_categoria INT,
	precio DECIMAL(10,2) NOT NULL,
	stock INT DEFAULT 0,
	activo TINYINT DEFAULT 1,

	CONSTRAINT FK_productos_categorias
	FOREIGN KEY (id_categoria)
	REFERENCES categorias(id_categoria)
);


CREATE TABLE ventas (
	id_venta INT PRIMARY KEY,
	id_cliente INT,
	id_producto INT,
	cantidad INT NOT NULL,
	precio_unitario DECIMAL(10,2) NOT NULL,
	fecha_venta DATE NOT NULL,

    CONSTRAINT FK_ventas_clientes
        FOREIGN KEY (id_cliente)
        REFERENCES clientes(id_cliente),

    CONSTRAINT FK_ventas_productos
        FOREIGN KEY (id_producto)
        REFERENCES productos(id_producto)
);


--Inserto DATA


--TABLA CATEGORIAS

INSERT INTO categorias VALUES 
(1, 'Computación', 'Laptops, PCs y monitores');

INSERT INTO categorias VALUES 
(2, 'Accesorios', 'Periféricos y complementos');

INSERT INTO categorias VALUES 
(3, 'Audio', 'Auriculares y parlantes');

INSERT INTO categorias VALUES 
(4, 'Almacenamiento', 'Discos y memorias');


--TABLA UBICACIONES

INSERT INTO ubicaciones VALUES 
(1, 'Buenos Aires', 'Buenos Aires', 'Centro');

INSERT INTO ubicaciones VALUES 
(2, 'Córdoba', 'Córdoba', 'Centro');

INSERT INTO ubicaciones VALUES 
(3, 'Rosario', 'Santa Fe', 'Centro');

INSERT INTO ubicaciones VALUES 
(4, 'Mendoza', 'Mendoza', 'Cuyo');

INSERT INTO ubicaciones VALUES 
(5, 'Tucumán', 'Tucumán', 'Noroeste');


--TABLA CLIENTES

INSERT INTO clientes VALUES 
(1, 'María López', 'maria@mail.com', 1, '2024-01-05');

INSERT INTO clientes VALUES 
(2, 'Carlos Ruiz', 'carlos@mail.com', 2, '2024-01-10');

INSERT INTO clientes VALUES 
(3, 'Ana Gómez', 'ana@mail.com', 3, '2024-02-01');

INSERT INTO clientes VALUES 
(4, 'Pedro Sanz', 'pedro@mail.com', 4, '2024-02-15');

INSERT INTO clientes VALUES 
(5, 'Laura Torres', 'laura@mail.com', 5, '2024-03-01');


--TABLA PRODUCTOS

INSERT INTO productos VALUES 
(1, 'Laptop Pro 15', 1, 1200.00, 15, 1);

INSERT INTO productos VALUES 
(2, 'Mouse Inalámbrico', 2, 28.00, 80, 1);

INSERT INTO productos VALUES 
(3, 'Monitor 4K 27"', 1, 450.00, 12, 1);

INSERT INTO productos VALUES 
(4, 'Auriculares BT Pro', 3, 120.00, 35, 1);

INSERT INTO productos VALUES 
(5, 'SSD Externo 1TB', 4, 130.00, 18, 1);

INSERT INTO productos VALUES 
(6, 'Teclado Mecánico', 2, 95.00, 40, 1);


--TABLA VENTAS

INSERT INTO ventas VALUES 
(1, 1, 1, 2, 1200.00, '2024-03-05');

INSERT INTO ventas VALUES 
(2, 2, 2, 5, 28.00, '2024-03-06');

INSERT INTO ventas VALUES 
(3, 3, 3, 1, 450.00, '2024-03-07');

INSERT INTO ventas VALUES 
(4, 1, 4, 2, 120.00, '2024-03-08');

INSERT INTO ventas VALUES 
(5, 4, 5, 3, 130.00, '2024-03-10');

INSERT INTO ventas VALUES 
(6, 2, 6, 4, 95.00, '2024-03-11');

INSERT INTO ventas VALUES 
(7, 5, 1, 1, 1200.00, '2024-03-12');

INSERT INTO ventas VALUES 
(8, 3, 2, 8, 28.00, '2024-03-13');

INSERT INTO ventas VALUES 
(9, 4, 4, 1, 120.00, '2024-03-14');

INSERT INTO ventas VALUES 
(10, 5, 3, 2, 450.00, '2024-03-15');


--PASO 3: Verifico integridad

SELECT * FROM categorias;
SELECT * FROM ubicaciones;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;


--Consulta 1 — Vista base del proyecto (INNER JOIN)

SELECT 
    v.fecha_venta AS fecha,
    v.id_cliente,
    c.nombre AS cliente,
    u.ciudad,
    u.provincia,
    u.region,
    p.nombre_producto AS descripcion_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    v.cantidad * v.precio_unitario AS total_venta
FROM ventas AS v

INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente

INNER JOIN ubicaciones AS u
    ON c.id_ubicacion = u.id_ubicacion

INNER JOIN productos AS p
    ON v.id_producto = p.id_producto

INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria;

--Consulta 2 — Clientes sin ventas (LEFT JOIN) 
SELECT 
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

--Consulta 3 - Productos sin ventas (LEFT JOIN)
SELECT 
    p.nombre_producto AS producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
WHERE v.id_venta IS NULL;

--Consulta 4
SELECT 
    canal,
    SUM(total) AS total_ventas
FROM (
    SELECT 
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total,
        'Online' AS canal
    FROM ventas
    WHERE id_venta BETWEEN 1 AND 5

    UNION ALL

    SELECT 
        fecha_venta AS fecha,
        cantidad * precio_unitario AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE id_venta BETWEEN 6 AND 10
) AS consolidado
GROUP BY canal;
