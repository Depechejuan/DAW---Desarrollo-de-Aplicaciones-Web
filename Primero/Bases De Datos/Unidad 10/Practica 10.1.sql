-- EJERCICIO #1
-- Utilizando la BD TIENDA, crea un script que recorra con cursores la tabla PRODUCTO y
-- que muestre el nombre de cada producto por pantalla.

USE TIENDA
GO
DECLARE CUR_PRODUCTS CURSOR FOR
SELECT nombre
  FROM PRODUCTO

  DECLARE @nombre VARCHAR(100);

OPEN CUR_PRODUCTS

	FETCH NEXT FROM CUR_PRODUCTS INTO @nombre

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		PRINT @nombre

		FETCH NEXT FROM CUR_PRODUCTS INTO @nombre
	END

CLOSE CUR_PRODUCTS
DEALLOCATE CUR_PRODUCTS


-- EJERCICIO #2 - Nombre y precio de productos en BD TIENDA
-- Ampliación del script anterior. Utilizando la BD TIENDA, crea un script que recorra con
-- cursores la tabla PRODUCTO y que muestre el nombre de cada producto y su precio por
-- pantalla haciendo uso de la función CONCAT.

USE TIENDA
GO
DECLARE CUR_PRODUCTS CURSOR FOR
SELECT nombre, precio
  FROM PRODUCTO

DECLARE @nombre VARCHAR(100),
				@precio DECIMAL(9,2)
OPEN CUR_PRODUCTS

	FETCH NEXT FROM CUR_PRODUCTS INTO @nombre, @precio

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		PRINT CONCAT('El producto ', @nombre, ' tiene un precio de ', @precio)

		FETCH NEXT FROM CUR_PRODUCTS INTO @nombre, @precio
	END

CLOSE CUR_PRODUCTS
DEALLOCATE CUR_PRODUCTS


-- EJERCICIO #3. Cursores anidados en BD TIENDA
-- En este script deberás utilizar un cursor que recorra la tabla FABRICANTE y dentro de éste
-- cursor otro que recorra la tabla PRODUCTO. El objetivo es que dentro de este segundo
-- cursor se acumule el precio de los productos de cada fabricante y que se muestre algo
-- similar a lo siguiente:

-- “Fabricante: nombreFabricante tiene un total de acumulado € en productos.” (siendo
-- las palabras resaltadas en rojo variables)

USE TIENDA
GO


DECLARE CUR_FABRICANTE CURSOR FOR
SELECT codigo, nombre
  FROM FABRICANTE

DECLARE @codFabricante INT,
				@nombre VARCHAR(100)
OPEN CUR_FABRICANTE

	FETCH NEXT FROM CUR_FABRICANTE INTO @codFabricante, @nombre

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @precio DECIMAL(9,2),
						@sumPrecio DECIMAL(9,2) = 0

		DECLARE CUR_PRODUCTOS CURSOR FOR
		SELECT precio
			FROM PRODUCTO
		 WHERE codigo_fabricante = @codFabricante
		OPEN CUR_PRODUCTOS

		 	FETCH NEXT FROM CUR_PRODUCTOS INTO @precio
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				SET @sumPrecio = @sumPrecio + @precio
				FETCH NEXT FROM CUR_PRODUCTOS INTO @precio
			END
		PRINT CONCAT('El fabricante ', @nombre, ' tiene un total de acumulado de ', @sumPrecio, '€ en productos ')
		CLOSE CUR_PRODUCTOS
		DEALLOCATE CUR_PRODUCTOS
		FETCH NEXT FROM CUR_FABRICANTE INTO @codFabricante, @nombre

	END

CLOSE CUR_FABRICANTE
DEALLOCATE CUR_FABRICANTE





-- EJERCICIO #4
-- Cursor de Empleados en BD JARDINERIA
-- Crea un script que recorra con cursores la tabla EMPLEADOS y que muestre los siguientes
-- datos de cada empleado: nombre, apellido1, apellido2 y email. Deberás formatearlos
-- utilizando la función CONCAT

USE JARDINERIA
GO

DECLARE @cont INT = 0,
				@nombre VARCHAR(50),
				@apellido1 VARCHAR(50),
				@apellido2 VARCHAR(50),
				@email VARCHAR(100),
				@codEmpleado INT,
				@max INT = (SELECT COUNT(codEmpleado) FROM EMPLEADOS)

IF ISNULL(@cont, 0) < 0
BEGIN
	PRINT 'Ha habido un error en el contador'
	RETURN
END

WHILE @cont < @max
BEGIN
	SELECT @codEmpleado = codEmpleado, @nombre = nombre, @apellido1 = apellido1, @apellido2 = apellido2,
					@email = email
	  FROM EMPLEADOS
	 ORDER BY codEmpleado ASC
	 OFFSET @cont ROWS
	 FETCH NEXT 1 ROWS ONLY
	 PRINT CONCAT('Empleado código: ', @codEmpleado, ' - Nombre: ', @nombre, ' Apellidos: ', @apellido1, 
								' ', @apellido2, ' - y su email es: ', @email)
	 SET @cont += 1
END



-- EJERCICIO #5.- Cursores anidados en BD JARDINERIA
-- En este script deberás utilizar un cursor que recorra la tabla PEDIDOS y dentro de éste
-- cursor otro que recorra la tabla DETALLE_PEDIDOS. El objetivo es que dentro de este
-- segundo cursor se acumule el total por línea de cada pedido y que finalmente se muestre el
-- total acumulado para cada pedido
-- “Nº Pedido XXXX tiene un coste total de XXXX €

USE JARDINERIA
GO

DECLARE @codPedido INT,
				@sumPrecio DECIMAL(9,2) = 0,
				@precio DECIMAL(9,2),
				@cantidad INT

DECLARE CUR_PEDIDOS CURSOR FOR
SELECT codPedido
  FROM PEDIDOS

OPEN CUR_PEDIDOS
	FETCH NEXT FROM CUR_PEDIDOS INTO @codPedido

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		-- Segundo Cursor
		DECLARE CUR_DETALLE_PEDIDO CURSOR FOR
		SELECT cantidad, precio_unidad
		  FROM DETALLE_PEDIDOS
		WHERE codPedido = @codPedido

		OPEN CUR_DETALLE_PEDIDO
			FETCH NEXT FROM CUR_DETALLE_PEDIDO INTO @cantidad, @precio
			
			WHILE (@@FETCH_STATUS = 0)
			BEGIN
				SET @sumPrecio = @sumPrecio + (@cantidad * @precio)
				FETCH NEXT FROM CUR_DETALLE_PEDIDO INTO @cantidad, @precio
			END

		PRINT CONCAT('El pedido con código ', @codPedido, ' - tiene un coste total de ', @sumPrecio,' €')
		FETCH NEXT FROM CUR_PEDIDOS INTO @codPedido

		CLOSE CUR_DETALLE_PEDIDO
		DEALLOCATE CUR_DETALLE_PEDIDO
	END

CLOSE CUR_PEDIDOS
DEALLOCATE CUR_PEDIDOS