CREATE DATABASE PracticasSQL;
GO

USE PracticasSQL;
GO


--Creo la tabla clientes con sus respectivas columnas
CREATE TABLE clientes (
id_cliente INT,
nombre VARCHAR(100),
perfil_bio VARCHAR(MAX),
fecha_registro DATE 
);
--Para clientes uso INT ya que al ser una primary key debe ser un numero entero
-- para nombre uso VARCHAR ya que los distintos nombres tendran longitud variable
--Para perfil_bio uso texto ya que en esa columna deberia completarse con una descripcion
--En fecha registro uso DATE por ser una fecha
--Creo la tabla productos
CREATE TABLE productos (
id_producto INT,
descripcion VARCHAR(255),
precio DECIMAL(10,2),
esta_activo BIT
);
--Para id_producto use INT por ser un numero entero
--Para descripcion como tendra un largo de 255 carecteres como max, use VARCHAR (255).
--Los precios consistiran en un numero con dos decimales, de ahi mi decision.
--Como en esta_activo admitira solo dos estados decidi usar BIT.