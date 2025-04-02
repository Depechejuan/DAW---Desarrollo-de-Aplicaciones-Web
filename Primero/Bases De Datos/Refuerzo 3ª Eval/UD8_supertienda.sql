USE SUPERTIENDA
GO
				---------------------------
				--   UD8  -  PROC & FUNC -- 
				---------------------------
-------------------------------------------------------------------------------------------
-- NOTA: Recuerda cuidar la limpieza del código (tabulaciones, nombres de tablas en mayúscula,
--		nombres de variables en minúscula, poner comentarios sin excederse, código organizado y fácil de seguir, etc.)
--
--	Si alguna tabla fuera IDENTITY y haces una inserción, puedes obtener el id llamando a la función SCOPE_IDENTITY()
--
-------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------
--			**** NOTAS *****
-- En esta sección previa a los ejercicios, incluiré procedimientos a los que llamaré de forma recurrente
-- Encontraremos procedimientos generalmente de formateo de textos y demás
-- Se toma esta decisión para obtener más práctica y soltura en la creación de estos procesos 
---------------------------------------------------------------------------------
GO
CREATE OR ALTER FUNCTION formatearTextoCorrecto (@texto VARCHAR(200))
RETURNS VARCHAR(200)
AS BEGIN
	-- No habrá comprobación de NULLS, puesto que este procedimiento sólo será invocado
	-- tras las comprobaciones de los procedimientos donde se llamará.
	RETURN UPPER(LEFT(@texto, 1)) + LOWER(RIGHT(@texto, LEN(@texto) - 1))
END


-------------------------------------------------------------------------------------------
-- 1. Implementa un procedimiento llamado 'crearCategoria' que inserte una nueva categoría de productos.
--		Parámetros de entrada: codCategoria, nombreCategoria
--		Parámetros de salida: <ninguno>
--		Tabla: CATEGORIAS
--		
--		# Se debe comprobar que todos los parámetros obligatorios están informados, sino devolver -1 y finalizar
--		# Se debe comprobar que el codCategoria no exista en la tabla, y si así fuera, 
--			imprimir un mensaje indicándolo, devolver -1 y finalizar
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--	
--	  * Comprueba que el funcionamiento es correcto realizando una desde un script
--		y comprobando la finalización del mismo
-------------------------------------------------------------------------------------------
-- exec sp_columns CATEGORIAS
GO
CREATE OR ALTER PROCEDURE crearCategoria (@codCateogoria CHAR(2), 
											@nombreCategoria VARCHAR(100))
AS BEGIN
	-- Comprobación de NULL
	IF @codCateogoria IS NULL
		OR @nombreCategoria IS NULL
	BEGIN
		PRINT 'No puedes introducir datos NULL'
		RETURN -1
	END

	-- Formateo de los códigos correctos
	SET @codCateogoria = UPPER(@codCateogoria)
	SET @nombreCategoria = dbo.formatearTextoCorrecto (@nombreCategoria)

 -- Comprobación del código y nombres
	IF @codCateogoria IN (SELECT codCategoria FROM CATEGORIAS WHERE codCategoria = @codCateogoria)
	BEGIN
		PRINT 'El código de categoría ya existe'
		RETURN -1
	END
	IF @nombreCategoria IN (SELECT nombre FROM CATEGORIAS WHERE nombre = @nombreCategoria)
	BEGIN
		PRINT 'El nombre de categoría ya existe'
		RETURN -1
	END

	--Insertamos los datos en CATEOGIRAS
	INSERT INTO CATEGORIAS
		VALUES	(@codCateogoria, @nombreCategoria)
END



-- Llamamos al procedimiento con diferentes valores para ver su respuesta
DECLARE @r INT
-- Confirmar que hace bien la conversión de letras
EXEC @r = crearCategoria 'mV', 'moviLeS'
IF @r <> 0
	PRINT 'Hubo un error en la inserción'
ELSE
	PRINT 'Categoría añadida con éxito'

-- Categoría que ya existe
EXEC @r = crearCategoria 'TV', 'Teles'
IF @r <> 0
	PRINT 'Hubo un error en la inserción'
ELSE
	PRINT 'Categoría añadida con éxito'

-- nombre que ya existe.
EXEC @r = crearCategoria 'TE', 'Televisión'
IF @r <> 0
	PRINT 'Hubo un error en la inserción'
ELSE
	PRINT 'Categoría añadida con éxito'

-- Categoría que no existe y no necesita formateo.
EXEC @r = crearCategoria 'HE', 'Helados'
IF @r <> 0
	PRINT 'Hubo un error en la inserción'
ELSE
	PRINT 'Categoría añadida con éxito'


-- Confirmamos que tenemos los datos bien introducidos con la select.
SELECT * FROM CATEGORIAS


-------------------------------------------------------------------------------------------
-- 2. Implementa un procedimiento que cree una nueva subcategoría de producto.
--		Parámetros de entrada: codCategoria, nombreSubCategoria
--		Parámetros de salida: codSubCategoria
--		Tabla: SUBCATEGORIAS

--		# Se debe comprobar que todos los parámetros obligatorios están informados, sino devolver -1 y finalizar
--		# Se debe comprobar que el idCategoria SI existe en la tabla (sino no podemos crear la subcategoria)
--			Si no existiera, imprimir un mensaje indicándolo, devolver -1 y finalizar
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--		
--	  *Comprueba que el funcionamiento es correcto realizando una desde un script y 
--		comprobando la finalización del mismo
-------------------------------------------------------------------------------------------
-- exec sp_columns SUBCATEGORIAS
GO
CREATE OR ALTER PROCEDURE crearSuBCategoria (@codCategoria CHAR(2), 
											@nombreSubCateogira VARCHAR(100),
											@codSubCategoria INT OUTPUT)
AS BEGIN
	IF @codCategoria IS NULL
	OR @nombreSubCateogira IS NULL
	BEGIN
		PRINT 'No puedes introducir datos NULL'
		RETURN -1
	END

	IF @codCategoria NOT IN (SELECT codCategoria FROM CATEGORIAS WHERE codCategoria = @codCategoria)
	BEGIN
		PRINT 'El código de categoría introducido no existe'
		RETURN -1
	END

	-- Formatear
	SET @codCategoria = UPPER(@codCategoria)
	SET @nombreSubCateogira = dbo.formatearTextoCorrecto(@nombreSubCateogira)

	-- Insertamos
	INSERT INTO SUBCATEGORIAS
		VALUES	(@codCategoria, @nombreSubCateogira)
	
	-- Usamos SCOPE_IDENTITY para obtener el digito que se acaba de insertar.
	SET @codSubCategoria = SCOPE_IDENTITY()
	
END


-- Pruebas
DECLARE @r INT,
		@codSubCategoria INT

-- Inserción normal
EXEC @r = crearSuBCategoria 'MV', 'andROId', @codSubCategoria OUTPUT
IF @r <> 0
	PRINT 'Hubo un error en la inserción'
ELSE
BEGIN
	PRINT 'Categoría añadida con éxito'
	PRINT CONCAT('El IDENTITY es: ', @codSubCategoria)
END

-- Inserción con categoria no existente
EXEC @r = crearSuBCategoria '00', 'andROId', @codSubCategoria OUTPUT
IF @r <> 0
	PRINT 'Hubo un error en la inserción'
ELSE
BEGIN
	PRINT 'Categoría añadida con éxito'
	PRINT CONCAT('El IDENTITY es: ', @codSubCategoria)
END

-- PREGUNTAR!!!!!
-- METE IDENTITY 1002 CUANDO DEBERIA SER CERCANO A 74, ¿Coge el identity más grande de la bbdd?
SELECT * FROM SUBCATEGORIAS

--
-------------------------------------------------------------------------------------------
-- 3. Implementa un procedimiento que cree un nuevo producto en la base de datos.
--		Parámetros de entrada: nombre, precioUnitario, IVA e codSubCategoria
--		Parámetros de salida: codProducto creado
--		Tabla: PRODUCTOS
--		
--		# Se debe comprobar que todos los parámetros *obligatorios* están informados, sino devolver -1 y finalizar
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--		
--	  * Comprueba que el funcionamiento es correcto realizando una desde un script y comprobando la finalización del mismo
-------------------------------------------------------------------------------------------
-- exec sp_columns PRODUCTOS
GO
CREATE OR ALTER PROCEDURE crearProducto (@nombre VARCHAR(100), 
										@precioUnitario DECIMAL(11,2),
										@IVA INT,
										@codSubCategoria CHAR(2),
										@codProducto INT OUTPUT)
AS BEGIN
	-- Comprobación NULLS
	IF @nombre IS NULL
	OR @precioUnitario IS NULL
	OR @IVA IS NULL
	BEGIN
		PRINT 'Has introducido datos NULL'
		RETURN -1
	END


	-- Comprobación IVA
	IF @IVA NOT IN (4, 10, 21)
	BEGIN
		PRINT 'El IVA introducido no está estipulado'
		RETURN -1
	END

	-- Podrían meternos un código subcategoría que no exista, en ese caso convertimos a NULL
	IF @codSubCategoria NOT IN (SELECT codSubcategoria FROM SUBCATEGORIAS WHERE codSubcategoria = @codSubCategoria)
		SET @codSubCategoria = NULL

	-- Insreción
	INSERT INTO PRODUCTOS
		VALUES (@nombre, @precioUnitario, @IVA, @codSubCategoria)

	-- Devolver codProducto
	SET @codProducto = SCOPE_IDENTITY()
END

-- Test de Inserción
DECLARE @r INT,
		@codProducto INT
-- Correcto
EXEC @r = crearProducto 'Apple iPhone 25', 3000.00, 21, 58, @codProducto OUTPUT
IF @r <> 0
	PRINT 'Hubo un error creando el producto'
ELSE
BEGIN
	PRINT 'Se ha creado el producto con éxito'	
	SELECT * FROM PRODUCTOS WHERE codProducto = @codProducto
END

-- Correcto, con un codProducto que no existe y debería ser NULL
EXEC @r = crearProducto 'Samsung Galaxy S99', 3200.00, 10, 99, @codProducto OUTPUT
IF @r <> 0
	PRINT 'Hubo un error creando el producto'
ELSE
BEGIN
	PRINT 'Se ha creado el producto con éxito'	
	SELECT * FROM PRODUCTOS WHERE codProducto = @codProducto
END

-- error (IVA incorrecto)
EXEC @r = crearProducto 'Apple iPhone 32', 1000.00, 30, 58, @codProducto OUTPUT
IF @r <> 0
	PRINT 'Hubo un error creando el producto'
ELSE
BEGIN
	PRINT 'Se ha creado el producto con éxito'	
	SELECT * FROM PRODUCTOS WHERE codProducto = @codProducto
END

-- error (Datos NULL)
EXEC @r = crearProducto 'Apple iPhone 32', NULL, 30, 58, @codProducto OUTPUT
IF @r <> 0
	PRINT 'Hubo un error creando el producto'
ELSE
BEGIN
	PRINT 'Se ha creado el producto con éxito'	
	SELECT * FROM PRODUCTOS WHERE codProducto = @codProducto
END






-------------------------------------------------------------------------------------------
-- 4. Implementa un procedimiento que cree una nueva valoración de un cliente a un producto
--		Parámetros de entrada: codCliente, codProducto, estrellas, fechaValoracion y comentario
--		Parámetros de salida: <ninguno>
--		Tabla: VALORACIONES_PRODUCTOS
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros, transacciones si fueran necesarias, etc.
--	
--	 
--	  * Comprueba que el funcionamiento es correcto realizando una desde un script y comprobando la finalización del mismo
-------------------------------------------------------------------------------------------
-- exec sp_columns VALORACIONES_PRODUCTOS
GO
CREATE OR ALTER PROCEDURE crearValoracion (@codCliente INT,
											@codProducto INT,
											@estrellas TINYINT,
											@fechaValoracion SMALLDATETIME,
											@comentario VARCHAR(250))
AS BEGIN
	-- Comprobaciones NULL
	IF @codCliente IS NULL
	OR @codProducto IS NULL
	OR @estrellas IS NULL
	OR @comentario IS NULL
		BEGIN
			PRINT 'Has introducidos datos NULL'
			RETURN -1
		END

	-- ¿Existe el cliente?
	IF @codCliente NOT IN (SELECT codCliente FROM CLIENTES)
		BEGIN
			PRINT 'El cliente introducido no existe'
			RETURN -1
		END

	-- ¿Existe el producto?
	IF @codProducto NOT IN (SELECT codProducto FROM PRODUCTOS)
		BEGIN
			PRINT 'El producto introducido no existe'
			RETURN -1
		END

	-- Rango de estrellas - 1 a 5
	IF @estrellas > 5
	OR @estrellas < 1
		BEGIN
			PRINT 'Las estrellas están fuera de rango. Se permite de 1 a 5 estrellas'
			RETURN -1
		END

	-- Machaco la fecha a la actual para que siempre quede registrado y nadie lo edite
	SET @fechaValoracion = GETDATE()

	INSERT INTO VALORACIONES_PRODUCTOS
		VALUES	(@codCliente, @codProducto, @estrellas, @fechaValoracion, @comentario)

END


SELECT * FROM VALORACIONES_PRODUCTOS
-- TEST
DECLARE @r INT
-- Debería funcionar pese al NULL de fecha
EXEC @r = dbo.crearValoracion 34, 2, 5, null, 'Es una maravilla'
IF @r <> 0
	PRINT 'Hubo un error creando la valoración'
ELSE
BEGIN
	PRINT 'Se ha enviado la valoración con éxito'	
END

-- OK con fecha solo año
EXEC @r = dbo.crearValoracion 34, 20, 5, '2025', 'Es una maravilla'
IF @r <> 0
	PRINT 'Hubo un error creando la valoración'
ELSE
BEGIN
	PRINT 'Se ha enviado la valoración con éxito'	
END

-- ERROR con datos null
EXEC @r = dbo.crearValoracion null, 2, null, null, 'Es una maravilla'
IF @r <> 0
	PRINT 'Hubo un error creando la valoración'
ELSE
BEGIN
	PRINT 'Se ha enviado la valoración con éxito'	
END

-- ERROR CLIENTE NO EXISTE
EXEC @r = dbo.crearValoracion 2000, 2, 5, null, 'Es una maravilla'
IF @r <> 0
	PRINT 'Hubo un error creando la valoración'
ELSE
BEGIN
	PRINT 'Se ha enviado la valoración con éxito'	
END

-- ERROR PRODUCTO NO EXISTE
EXEC @r = dbo.crearValoracion 34, 5000 , 5, null, 'Es una maravilla'
IF @r <> 0
	PRINT 'Hubo un error creando la valoración'
ELSE
BEGIN
	PRINT 'Se ha enviado la valoración con éxito'	
END


-------------------------------------------------------------------------------------------
-- 5. Implementa un procedimiento que cree un nuevo pedido
--		Parámetros de entrada: codCliente, codVendedor, codTransportista, costeEnvio, recogidaTiendaSN
--		Parámetros de salida: codPedido
--		Tabla: PEDIDOS
--		
--		# Se debe comprobar que los parámetros codCliente e codVendedor están informados, sino devolver -1 y finalizar
--		# El resto de campos de la tabla que no se pasan como parámetro de entrada se informarán a cero en la sentencia INSERT
--		# NO hace falta comprobar que el codCliente y el codVendedor existan. Si no existieran, fallará la sentencia INSERT
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--		
--	  * Comprueba que el funcionamiento es correcto realizando una desde un script y comprobando la finalización del mismo
-------------------------------------------------------------------------------------------

GO
CREATE OR ALTER PROCEDURE crearPedido  (@codCliente INT, 
										@codVendedor INT,
										@codTransportista INT,
										@costeEnvio DECIMAL (6,2),
										@recogidaTiendaSN CHAR(1),
										@codPedido INT OUTPUT)
AS BEGIN
	IF @codCliente IS NULL
	OR @codVendedor IS NULL
	OR @codTransportista IS NULL
	OR @costeEnvio IS NULL
	OR @recogidaTiendaSN IS NULL
	BEGIN
		PRINT 'No puedes insertar datos Nulos'
		RETURN -1
	END

	IF @recogidaTiendaSN IS NULL
	BEGIN
		SET @recogidaTiendaSN = 'N'
	END

	SET @recogidaTiendaSN = UPPER(@recogidaTiendaSN)

	IF @recogidaTiendaSN NOT IN('N', 'S')
		BEGIN
			PRINT 'La recogida en tienda sólo admite valores S o N'
			RETURN -1
		END

	SET @codPedido = (SELECT MAX(codPedido) FROM PEDIDOS) + 1
	DECLARE @fechaPrevistaEntrega DATE = GETDATE() + DAY(15)


	BEGIN TRY
	-- Insert
	-- No se especifica método para decir qué tienda es la que recoge. Se podría implementar a futuro.
	INSERT INTO PEDIDOS (codPedido, codCliente, fecHoraPedido, 
						fecPrevEntrega, codVendedor, codTransportista,
						costeEnvio, recogidaTiendaSN)
		VALUES	(@codPedido, @codCliente, GETDATE(),
				@fechaPrevistaEntrega, @codVendedor, @codTransportista, 
				@costeEnvio, @recogidaTiendaSN)
	END TRY

	BEGIN CATCH
		PRINT CONCAT('Error Line: ', ERROR_LINE(),
					'Error Message: ', ERROR_MESSAGE(),
					'Error Number: ', ERROR_MESSAGE(),
					'Error Procedure: ', ERROR_PROCEDURE())
		PRINT CONCAT('Parámetros de entrada: ', @codCliente, ' - ',  
					@codVendedor, ' - ', @codTransportista, ' - ',
					@costeEnvio, ' - ', @recogidaTiendaSN, ' - ',
					@codPedido)
	END CATCH

END


-- TEST
DECLARE @r INT,
		@codPedido INT

-- OK
EXEC @r =crearPedido 1, 1, 1, 20.00, 'N', @codPedido OUTPUT
IF @r <> 0
	PRINT 'Ha habido un problema con la inserción de datos'
ELSE 
	PRINT CONCAT('Se han insertado correctamente el Pedido con código: ', @codPedido)

-- NOT OK, un dato PK erroneo
EXEC @r =crearPedido 10000, 1, 1, 20.00, 'N', @codPedido OUTPUT
IF @r <> 0
	PRINT 'Ha habido un problema con la inserción de datos'
ELSE 
	PRINT CONCAT('Se han insertado correctamente el Pedido con código: ', @codPedido)

	-- NOT OK, dato NULL
EXEC @r =crearPedido 1, NULL, 1, 20.00, 'N', @codPedido OUTPUT
IF @r <> 0
	PRINT 'Ha habido un problema con la inserción de datos'
ELSE 
	PRINT CONCAT('Se han insertado correctamente el Pedido con código: ', @codPedido)




-------------------------------------------------------------------------------------------
-- 6. Implementa un procedimiento crearLineaPedido que cree una nueva línea de pedido
--		Parámetros de entrada: codPedido, codProducto y unidades
--		Parámetros de salida: <ninguno>
--		Tabla: LINEAS_PEDIDOS
--		
--		# El precio del producto (campo 'precioCompra') debes obtenerlo previamente de la tabla PRODUCTOS
--		# El campo totalLinea es un campo derivado (se actualiza automáticamente), por lo que NO hay que indicarlo en la INSERT.
--		# Se debe comprobar que los parámetros codPedido, codProducto y unidades están informados, sino devolver -1 y finalizar
--		# NO hace falta comprobar que el codPedido y el codProducto existan. Si no existieran, fallará la sentencia INSERT
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--		
--	  * Comprueba que el funcionamiento es correcto realizando una desde un script y comprobando la finalización del mismo
-------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE crearLineaPedido (@codPedido INT, @codProducto INT, @unidades TINYINT)
AS BEGIN
	IF @unidades <= 0
	BEGIN
		PRINT 'No se pueden añadir 0 o menos unidades'
		RETURN -1
	END

	DECLARE @linea INT = 1,
	@precioCompra DECIMAL(9,2) = (SELECT precioUnitario FROM PRODUCTOS WHERE codProducto = @codProducto)

	IF @precioCompra IS NULL
	BEGIN
		PRINT 'El código de producto no existe'
		RETURN -1
	END

	DECLARE @totalLineas DECIMAL(9,2) = @precioCompra * @unidades

	INSERT INTO LINEAS_PEDIDOS (codPedido, codProducto, precioCompra,
								unidades)
		VALUES	(@codPedido, @codProducto, @precioCompra,
				@unidades)

END

-- Ultimo pedido ejercicio anterior: 39630
DECLARE @r INT

-- Datos reales
EXEC @r = crearLineaPedido 39630, 1, 10

IF @r <> 0
PRINT 'Ha habido un error en la creación de la línea de pedido'
ELSE
PRINT 'Línea creada correctamente'


-- Pedido que no existe
EXEC @r = crearLineaPedido 99999, 1, 10

IF @r <> 0
PRINT 'Ha habido un error en la creación de la línea de pedido'
ELSE
PRINT 'Línea creada correctamente'


-- Producto que no existe
EXEC @r = crearLineaPedido 39630, 99999, 10

IF @r <> 0
PRINT 'Ha habido un error en la creación de la línea de pedido'
ELSE
PRINT 'Línea creada correctamente'

-- Unidades negativas
EXEC @r = crearLineaPedido 39630, 1, -10

IF @r <> 0
PRINT 'Ha habido un error en la creación de la línea de pedido'
ELSE
PRINT 'Línea creada correctamente'


-------------------------------------------------------------------------------------------
-- 7. Implementa un script que utilice los procedimientos crearPedido y crearLineaPedido y 
--		que cree un nuevo pedido y que el pedido tenga dentro 2 productos cualesquiera.
--	
--	Recuerda la utilización de TRY/CATCH y transacciones.
--		Ejemplo. Si se llega a crear el pedido y falla la creación de una de las líneas,
--			deberá retroceder los cambios al estado inicial (ROLLBACK)
--
--  Ayuda 1: Considera quitar las transacciones de dentro de los procedimientos.
--  Ayuda 2: Utiliza una transacción que se inicie en el script de llamada
--     y que el COMMIT se haga al final
-------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE CrearPedidoConArticulos (@codCliente INT, @codProducto1 INT, 
													@unidades1 TINYINT, @codProducto2 INT,
													@unidades2 TINYINT, @codPedido INT OUTPUT)
AS BEGIN
	BEGIN TRY
		DECLARE @r INT,
				@codVendedor INT = 1, --Código vendedor por defecto para el procedimiento
				@codTransportista INT = 1, -- Código transportista por defecto
				@precioTransporrte DECIMAL(9,2) = 20.00, -- Precio por defecto
				@recogida CHAR(1) = 'N'

		
		BEGIN TRAN
			SET IMPLICIT_TRANSACTIONS ON
			-- OK
			EXEC @r = crearPedido @codCliente, @codVendedor, @codTransportista, 
								@precioTransporrte, @recogida, @codPedido OUTPUT
			IF @r <> 0
			BEGIN
				PRINT 'Ha habido un problema con la inserción de datos'
				RETURN -1
			END

			PRINT CONCAT('Pedido realizado con éxito. CodPedido = ', @codPedido)

			EXEC @r = crearLineaPedido @codPedido, @codProducto1, @unidades1

			IF @r <> 0
			BEGIN
				PRINT 'Ha habido un error en la creación de la línea de pedido'
				RETURN -1
			END
			PRINT 'Línea 1 registrada con éxito'

			EXEC @r = crearLineaPedido @codPedido, @codProducto2, @unidades2

			IF @r <> 0
			BEGIN
				PRINT 'Ha habido un error en la creación de la línea de pedido'
				RETURN -1
			END
			PRINT 'Línea 2 registrada con éxito'
			COMMIT
			SET IMPLICIT_TRANSACTIONS OFF
	END TRY

	BEGIN CATCH
		ROLLBACK
		PRINT CONCAT('ERROR LINE: ', ERROR_LINE(),
					 'ERROR MESSAGE: ', ERROR_MESSAGE(),
					 'ERROR NUMBER: ', ERROR_NUMBER(),
					 'ERROR PROCEDURE: ', ERROR_PROCEDURE())
	END CATCH

END


DECLARE @r INT,
		@codPedido INT
-- OK
EXEC @r = CrearPedidoConArticulos 1, 1, 10, 2, 5, @codPedido OUTPUT

IF @r <> 0
	PRINT 'Error en la creación de pedido + líneas'
ELSE
	PRINT CONCAT('El código de tu pedido es: ', @codPedido)

-- Inventado para error:
EXEC @r = CrearPedidoConArticulos 99999, 1, 10, 2, 5, @codPedido OUTPUT

IF @r <> 0
	PRINT 'Error en la creación de pedido + líneas'
ELSE
	PRINT CONCAT('El código de tu pedido es: ', @codPedido)

-------------------------------------------------------------------------------------------
--8. Implementa una función llamada getNumPedidos que reciba como parámetro un idCliente y devuelva
--		el número de pedidos realizados por dicho cliente.
--	
--	Recuerda que debes incluir la SELECT y comprobar el funcionamiento
--
--  Ayuda: recuerda incluir el prefijo dbo. al llamar a la función
--   En las funciones nunca debes indicar un valor directamente (es decir, "hardcodeado")
-------------------------------------------------------------------------------------------

GO
CREATE OR ALTER FUNCTION getNumPedidos (@codCliente INT)
RETURNS INT
AS BEGIN
	DECLARE @countPedidos INT = (SELECT COUNT(codPedido)
								  FROM PEDIDOS 
								WHERE codCliente = @codCliente)		
	RETURN @countPedidos
END


-- Llamada a la función:

SELECT codCliente, dbo.getNumPedidos(codCliente) AS CountPedidos
  FROM CLIENTES;

-------------------------------------------------------------------------------------------
-- 9. Implementa una función llamada getCostePedidos que reciba como parámetro un idCliente y devuelva
--		el coste de todos los pedidos realizados por dicho cliente.
--	
--	Recuerda que debes incluir la SELECT y comprobar el funcionamiento
-------------------------------------------------------------------------------------------
GO
CREATE OR ALTER FUNCTION getCostePedidos (@codCliente INT)
RETURNS DECIMAL(9,2)
AS BEGIN
	RETURN (SELECT SUM(costeEnvio)
	  FROM PEDIDOS
	  WHERE codCliente = @codCliente)
END

SELECT codCliente, dbo.getCostePedidos(codCliente) AS CostePedidos
  FROM CLIENTES
 ORDER BY codCliente;


-------------------------------------------------------------------------------------------
-- 10. Implementa una función llamada ventasTotalesVendedor que reciba como parámetro un idVendedor y devuelva
--		el importe vendido por dicho vendedor.
--	
--	Recuerda que debes incluir la SELECT y comprobar el funcionamiento
-------------------------------------------------------------------------------------------
GO
CREATE OR ALTER FUNCTION ventasTotalesVendedor (@codVendedor INT)
RETURNS DECIMAL(11,2) -- Aumentamos el habitual decimal 9,2 por si la suma supera estas cifras.
AS BEGIN
	RETURN (SELECT SUM(totalLinea)
			  FROM VENDEDORES V LEFT JOIN PEDIDOS P
				ON V.codVendedor = P.codVendedor JOIN LINEAS_PEDIDOS LP
				ON p.codPedido = LP.codPedido
				WHERE V.codVendedor = @codVendedor)
END


SELECT codVendedor, dbo.ventasTotalesVendedor(codVendedor) AS totalVendido 
  FROM VENDEDORES
 ORDER BY codVendedor;



-------------------------------------------------------------------------------------------
-- 11. Crea un procedimiento que utilice cursores y que realice alguna acción (INSERT, UPDATE
--     DELETE o varias de ellas) sobre la tabla que recorra.
-------------------------------------------------------------------------------------------
/*
	He querido hacer un procedimiento completo y orientarlo a un caso real.
	Usando DBeaver y mirándo el gráfico de tablas de SuperTienda, he tenido esta idea:

	-- Los pedidos que tienen entrega en tienda, también tienen una fecha de entrega.
	Hay pedidos que NO tienen esta fecha de entrega y datan de años muy tardíos.

	Voy a crear una serie de procedimientos y TRIGGERS (para practicar de cara al examen)
	que eliminarán estos pedidos de la tabla original y se guardarán en un historico_pedidos
	e histórico_linea_pedidos

	Como dicen en el Final Fantasy VII -> Allé voy.
*/

-- Creación de tablas backup
SELECT *
  INTO HISTORICO_PEDIDOS
  FROM PEDIDOS
 WHERE 1 = 0

ALTER TABLE HISTORICO_PEDIDOS
	ADD fechaEliminado DATETIME NOT NULL
-- Intenté ejecutar el pack con la PK triple pero no me dejó. 
-- 	exec sp_columns HISTORICO_PEDIDOS dice que codCliente puede ser null, así que toca cambiarlo.

ALTER TABLE HISTORICO_PEDIDOS
ALTER COLUMN codCliente INT NOT NULL

ALTER TABLE HISTORICO_PEDIDOS
	ADD CONSTRAINT PK_HISTORICO_PEDIDOS 
	PRIMARY KEY (codPedido, codCliente, fechaEliminado)
-- Confirmamos que todo está bien
 exec sp_columns historico_pedidos


-- Ahora replicamos el proceso con LINEAS_PEDIDOS
SELECT *
  INTO HISTORICO_LINEAS_PEDIDOS
  FROM LINEAS_PEDIDOS
 WHERE 1 = 0

ALTER TABLE HISTORICO_LINEAS_PEDIDOS
		ADD fechaEliminado DATETIME NOT NULL

ALTER TABLE HISTORICO_LINEAS_PEDIDOS
ADD CONSTRAINT PK_HISTORICO_LINEAS_PEDIDOS 
PRIMARY KEY (codPedido, codProducto, fechaEliminado)
-- Confirmamos
exec sp_columns historico_lineas_pedidos

-- Trigger encargado de guardar la línea de pedido 
GO
CREATE OR ALTER TRIGGER TRG_HISTORICO_LINEAS_PEDIDOS_DELETE ON LINEAS_PEDIDOS
INSTEAD OF DELETE
AS BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO HISTORICO_LINEAS_PEDIDOS
		SELECT *, GETDATE()
		  FROM deleted
		  
		DELETE LINEAS_PEDIDOS
		  FROM LINEAS_PEDIDOS LP JOIN deleted d
		  ON LP.codPedido = d.codPedido
		  AND LP.codProducto = d.codProducto

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		PRINT CONCAT('ERROR LINE: ', ERROR_LINE(), CHAR(10),
					'ERROR MESSAGE: ', ERROR_MESSAGE(), CHAR(10),
					'ERROR NUMBER: ', ERROR_NUMBER(), CHAR(10),
					'ERROR PROCEDURE: ', ERROR_PROCEDURE(), CHAR(10))
	END CATCH

END


-- Ahora, el trigger de backup/delete de PEDIDOS
GO
CREATE OR ALTER TRIGGER TRG_PEDIDOS_DELETE ON PEDIDOS
INSTEAD OF DELETE
AS BEGIN
	BEGIN TRY
		BEGIN TRAN
		INSERT INTO HISTORICO_PEDIDOS
		SELECT *, GETDATE()
		  FROM deleted

		DELETE PEDIDOS
		  FROM PEDIDOS P JOIN deleted d
		  ON P.codPedido = d.codPedido

		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
		PRINT CONCAT('ERROR LINE: ', ERROR_LINE(), CHAR(10),
					'ERROR MESSAGE: ', ERROR_MESSAGE(), CHAR(10),
					'ERROR NUMBER: ', ERROR_NUMBER(), CHAR(10),
					'ERROR PRODECURE: ', ERROR_PROCEDURE(), CHAR(10))
	END CATCH
END


-- Ahora si, Creamos el procedimiento que elimina los productos olvidados en tienda
-- Haciendo que primero elimine sus lineas y luego los pedidos.
GO
CREATE OR ALTER PROCEDURE deletePedidosOlvidadosEnTiendaDelAnyo (@year INT)
AS BEGIN

	BEGIN TRY
		BEGIN TRAN
		DECLARE @count INT = (SELECT COUNT(*) 
								FROM PEDIDOS
								WHERE fecEntrega IS NULL
								AND recogidaTiendaSN = 'N'
								AND YEAR(fecPrevEntrega) < @year),
				@index INT = 0,
				@codPedido INT

		-- Cursor para pedidos
		WHILE @index < @count
		BEGIN
			SELECT @codPedido = codPedido
			  FROM PEDIDOS
			 WHERE fecEntrega IS NULL
				AND recogidaTiendaSN = 'N'
				AND YEAR(fecPrevEntrega) < @year --2006
			ORDER BY codPedido
			OFFSET @index ROWS
			FETCH NEXT 1 ROWS ONLY
		
			DELETE FROM LINEAS_PEDIDOS
				WHERE codPedido = @codPedido

			SET @index += 1
		END

		COMMIT
	END TRY

	BEGIN CATCH
		ROLLBACK
		PRINT CONCAT('ERROR LINE: ', ERROR_LINE(), CHAR(10),
					'ERROR MESSAGE: ', ERROR_MESSAGE(), CHAR(10),
					'ERROR NUMBER: ', ERROR_NUMBER(), CHAR(10),
					'ERROR PRODECURE: ', ERROR_PROCEDURE(), CHAR(10))
	END CATCH

END


-- Lo probamos con el año 2006, que tiene ~500 registros
DECLARE @year INT = 2006,
		@r INT

EXEC @r = dbo.deletePedidosOlvidadosEnTiendaDelAnyo @year

IF @r <> 0
	PRINT ' EL PROCEDIMIENTO FALLÓ'
ELSE
	PRINT 'Todo salió bien.'

