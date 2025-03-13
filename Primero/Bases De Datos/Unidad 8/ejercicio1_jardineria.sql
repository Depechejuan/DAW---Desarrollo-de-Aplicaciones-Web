-------------------------------------------------------------------------------------------
-- 1. Implementa un procedimiento llamado 'getNombreCliente' que devuelva el nombre de un cliente a partir de su código.
--		Parámetros de entrada:  codCliente INT
--		Parámetros de salida:   nombreCliente VARCHAR(50)
--		Tabla:                  CLIENTES
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--	
--	  * Comprueba que el funcionamiento es correcto realizando una llamada desde un script y comprobando la finalización del mismo
--      Recuerda utilizar en el script:
--              EXEC @ret = getNombreCliente @codCliente, @nombreCliente OUTPUT
--              IF @ret <> 0 ...
-------------------------------------------------------------------------------------------

EXEC sp_columns CLIENTES
GO
CREATE OR ALTER PROCEDURE getNombreCliente (@codCliente INT,
																					@nombreCliente VARCHAR(50) OUTPUT)
AS
BEGIN
IF ISNULL(@codCliente, 0) <= 0
	BEGIN
		PRINT 'El código de cliente introducido no es un código válido'
		RETURN -1
	END

	BEGIN TRY
		SELECT @nombreCliente = nombre_cliente
		  FROM CLIENTES
		WHERE codCliente = @codCliente

		IF @nombreCliente IS NULL
			BEGIN
					PRINT CONCAT('El cliente con código ',@codCliente, ' No Existe')
					RETURN -1
			END
	END TRY
	BEGIN CATCH
		PRINT 'Se ha producido un error en el procedimiento'
		RETURN -1
	END CATCH
END

DECLARE @codCliente INT = 10,
				@nombreCliente VARCHAR(50), 
				@r INT

EXEC @r = getNombreCliente @codCliente, @nombreCliente OUTPUT
IF (@r = 0)
	PRINT CONCAT('El cliente con código ', @codCliente, ' Se llama ', @nombreCliente)
ELSE
BEGIN
	PRINT CONCAT('ERROR NUMBER: ', ERROR_NUMBER(),
								' ERROR MESSAGE: ', ERROR_MESSAGE(),
								' ERROR LINE: ', ERROR_LINE(),
								' ERROR PROCEDURE: ', ERROR_PROCEDURE())
	RETURN -1
END


-------------------------------------------------------------------------------------------
-- 2. Implementa un procedimiento llamado 'getPedidosPagosCliente' que devuelva el número de pedidos y de pagos a partir de un código de cliente.
--		Parámetros de entrada:  codCliente INT
--		Parámetros de salida:   numPedidos INT
--                              numPagos INT
--		Tabla:                  CLIENTES
--		
-------------------------------------------------------------------------------------------

GO
-- Obtiene los pedidos y los pagos de un cliente
CREATE OR ALTER PROCEDURE getPedidosPagosCliente (@codCliente INT, @numPedidos INT OUTPUT, @numPagos INT OUTPUT)
AS
BEGIN
	BEGIN TRY
		IF ISNULL(@codCliente, 0) <= 0
			BEGIN
				PRINT 'El código de cliente introducido no es válido'
				RETURN -1
			END

		SELECT @numPedidos = COUNT(*)
		  FROM PEDIDOS
		WHERE codCliente = @codCliente
		SELECT @numPagos = COUNT(*)
		  FROM PAGOS
		WHERE codCliente = @codCliente
		
		-- Controlar que @numPedidos o @numPagos no sea NULL

	END TRY
	BEGIN CATCH
		PRINT CONCAT(	'ERROR NUMBER: ', ERROR_NUMBER(),
									' ERROR MESSAGE: ', ERROR_MESSAGE(),
									' ERROR LINE: ', ERROR_LINE(),
									' ERROR PROCEDURE: ', ERROR_PROCEDURE())
		RETURN -1
	END CATCH
END


DECLARE @r INT,
				@codCliente INT = 1,
				@numPedidos INT,
				@numPagos INT

EXEC @r = getPedidosPagosCliente @codCliente, @numPedidos OUTPUT, @numPagos OUTPUT

IF (@r = 0)
	PRINT CONCAT('El cliente con código: ', @codCliente, ' Ha realizado ', @numPedidos, ' Pedidos y ha realizado ', @numPagos, ' Pagos')



-------------------------------------------------------------------------------------------
-- 3. Implementa un procedimiento llamado 'crearCategoriaProducto' que inserte una nueva categoría de producto en la base de datos JARDINERIA.
--		Parámetros de entrada: codCategoria CHAR(2),
--							   nombre VARCHAR(50),
--                             descripcion_texto VARCHAR(100), 
--                             descripcion_html VARCHAR(100),
--                             imagen VARCHAR(255)

--		Parámetros de salida: <ninguno>
--		Tabla: CATEGORIA_PRODUCTOS
--		
-------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE crearCategoriaProducto (@codCategoria CHAR(2),  @nombre VARCHAR(50), 
																							@descripcion_texto VARCHAR(100), @descripcion_html VARCHAR(100),
																							@imagen VARCHAR(255))
AS
BEGIN
	BEGIN TRY

		IF @nombre IS NULL
		OR @codCategoria IS NULL
			BEGIN
				PRINT 'Debes introducir un código de categoría o un nombre para poder añadirlo'
				RETURN -1
			END

		DECLARE @nameCheck VARCHAR(50),
						@codCatCheck CHAR(2)

		SELECT @nameCheck = nombre
		  FROM CATEGORIA_PRODUCTOS
		WHERE nombre = @nombre

				IF @nameCheck IS NOT NULL
			BEGIN
				PRINT 'El nombre de esta categoría ya existe'
				RETURN -1
			END

		SELECT @codCatCheck = codCategoria
		  FROM CATEGORIA_PRODUCTOS
		WHERE codCategoria = @codCategoria		
		
		IF @codCatCheck IS NOT NULL
			BEGIN
				PRINT 'El código de esta cateogría ya existe. Prueba a insertar otro código para referenciarla'
				RETURN -1
			END

			--REFACTORIZAR UPPER Y LOWER
			INSERT INTO CATEGORIA_PRODUCTOS
			VALUES(UPPER(@codCategoria), UPPER(LEFT(@nombre, 1))+LOWER(SUBSTRING(@nombre, 2, LEN(@nombre))), @descripcion_texto, @descripcion_html, @imagen)


	END TRY
	BEGIN CATCH
		PRINT CONCAT(	'ERROR NUMBER: ', ERROR_NUMBER(),
									' ERROR MESSAGE: ', ERROR_MESSAGE(),
									' ERROR LINE: ', ERROR_LINE(),
									' ERROR PROCEDURE: ', ERROR_PROCEDURE())
		RETURN -1
	END CATCH
END

exec sp_columns	CATEGORIA_PRODUCTOS

DECLARE @codCategoria CHAR(2) = 'HO',
				@nombre VARCHAR(50) = 'HORNO', 
				@descripcion_texto VARCHAR(100),
				@descripcion_html VARCHAR(100),
				@imagen VARCHAR(255),
				@r INT


EXEC @r = crearCategoriaProducto @codCategoria, @nombre, @descripcion_texto, @descripcion_html, @imagen

IF @r <> 0
	BEGIN
		PRINT 'Se ha interrumpido el proceso!'
		RETURN
	END
ELSE
	PRINT CONCAT('Se ha añadido la categoría "', @nombre, '" a la base de datos')

	

-------------------------------------------------------------------------------------------
-- 4. Implementa un procedimiento llamado 'acuseRecepcionPedidosCliente' que actualice la fecha de entrega de los pedidos
--      a la fecha del momento actual y su estado a 'Entregado' para el codCliente pasado por parámetro y solo para los 
--      pedidos que estén en estado 'Pendiente' y no tengan fecha de entrega.

--		Parámetros de entrada: codCliente INT
--		Parámetros de salida:  numPedidosAct INT
--		Tabla: PEDIDOS

--	  * Comprueba que el funcionamiento es correcto realizando una llamada desde un script y comprobando la finalización del mismo
--
--      Ayuda: Recuerda utilizar:
--              EXEC @ret = acuseRecepcionPedidosCliente ...
--              IF @ret <> 0 ...
--
--	  * Ayuda para obtener el número de registros actualizados:
--		Se puede hacer una SELECT antes de ejecutar la sentencia de actualización o bien utilizar la variable @@ROWCOUNT
--
-------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE acuseRecepcionPedidosCliente (@codCliente INT, @numPedidosAct INT OUTPUT )
AS
BEGIN
	BEGIN TRY
		IF ISNULL(@codCliente, 0) < 1
			BEGIN
				PRINT 'El código de cliente introducido no es válido'
				RETURN -1
			END

		DECLARE @nombre VARCHAR(100)
		SELECT @nombre = nombre_cliente
		  FROM CLIENTES
	    WHERE codCliente = @codCliente
		
		IF @nombre IS NULL
		BEGIN
			PRINT 'El código de cliente no existe en la base de datos'
			RETURN -1
		END


			BEGIN TRAN
					UPDATE PEDIDOS
					SET fecha_entrega = GETDATE(), 
							codEstado = 'E'
					WHERE codCliente = @codCliente
						AND codEstado = 'P'
						AND fecha_entrega IS NULL
					SET @numPedidosAct = @@ROWCOUNT


			IF @numPedidosAct <= 0
			BEGIN
				PRINT 'El cliente no tiene pedidos pendientes'
			END
			COMMIT

	END TRY

	BEGIN CATCH
		ROLLBACK
		SET IMPLICIT_TRANSACTIONS ON
				PRINT CONCAT(	'ERROR NUMBER: ', ERROR_NUMBER(),
									' ERROR MESSAGE: ', ERROR_MESSAGE(),
									' ERROR LINE: ', ERROR_LINE(),
									' ERROR PROCEDURE: ', ERROR_PROCEDURE())
		RETURN -1
	END CATCH
END



DECLARE @r INT,
				@codCliente INT = 1,
				@numPedidosAct INT

-- SET IMPLICIT_TRANSACTIONS OFF
EXEC @r = acuseRecepcionPedidosCliente @codCliente, @numPedidosAct OUTPUT
-- ROLLBACK
-- SET IMPLICIT_TRANSACTIONS ON
 IF @r <> 0 
 	BEGIN
		PRINT 'El prodecimineto falló'
	END
ELSE
	BEGIN
		PRINT 'El procedimiento se ejecutó con éxito'
		PRINT CONCAT('Se han actualizado ', @numPedidosAct, ' Pedidos del cliente ', @codCliente)
	END


	SELECT * FROM PEDIDOS WHERE codCliente = 1
	ROLLBACK

-------------------------------------------------------------------------------------------
-- 5. Implementa un procedimiento llamado 'crearOficina' que inserte una nueva oficina en JARDINERIA.
--		Parámetros de entrada: codOficina CHAR(6)
--                             ciudad VARCHAR(40)
--                             pais VARCHAR(50)
--                             codigo_postal CHAR(5)
--                             telefono VARCHAR(15)
--                             linea_direccion1 VARCHAR(100)
--                             linea_direccion2 VARCHAR(100) (no obligatorio)

--		Parámetros de salida: <ninguno>
--		Tabla: OFICINAS
--		
--		# Se debe comprobar que todos los parámetros obligatorios están informados, sino devolver -1 y finalizar
--		# Se debe comprobar que el codOficina no exista previamente en la tabla, y si así fuera, 
--			imprimir un mensaje indicándolo y se devolverá -1
--		
--		El procedimiento devolverá 0 si finaliza correctamente.
--		Debes utilizar TRY/CATCH, validación de parámetros y transacciones si fueran necesarias.
--	
--	  * Comprueba que el funcionamiento es correcto realizando una llamada desde un script y comprobando la finalización del mismo
--
--      Ayuda: Recuerda utilizar:
--              EXEC @ret = crearOficina ...
--              IF @ret <> 0 ...
-------------------------------------------------------------------------------------------
GO
CREATE OR ALTER PROCEDURE crearOficina (@codOficina CHAR(6), 
                             @ciudad VARCHAR(40),
                             @pais VARCHAR(50),
                             @codigo_postal CHAR(5),
                             @telefono VARCHAR(15),
                             @linea_direccion1 VARCHAR(100),
                             @linea_direccion2 VARCHAR(100))
AS
BEGIN
	BEGIN TRY

	IF @codOficina NOT LIKE '___-__'
		BEGIN
			PRINT 'El código de oficina no sigue el patrón CIUDAD-PAIS'
			PRINT 'Ejemplo: MAD-ES'
			RETURN -1
		END

	IF @telefono NOT LIKE '+%'
		BEGIN
			PRINT 'El teléfono introducido no sigue el patrón "+_______"'
			RETURN -1
		END

		-- check por nulls
		IF @codOficina IS NULL
			OR @ciudad IS NULL
			OR @pais IS NULL
            OR @codigo_postal IS NULL
			OR LEN(@codigo_postal) <> 5
            OR @telefono IS NULL
            OR @linea_direccion1 IS NULL
		BEGIN
			PRINT 'Los datos introducidos NO pueden ser NULL a excepción de la Línea de Dirección 2'
			RETURN -1
		END

		-- Check si el codOficina ya existe
		DECLARE @checkOfi CHAR(6)
		SELECT @checkOfi = codOficina
		  FROM OFICINAS
		WHERE codOficina = @codOficina

		IF @checkOfi IS NOT NULL
			BEGIN
				PRINT CONCAT('El código de oficina ', @codOficina, ' ya existe')
				RETURN -1
			END

		INSERT INTO OFICINAS
		VALUES (@codOficina, @ciudad, @pais, @codigo_postal, @telefono, @linea_direccion1, @linea_direccion2)
		END TRY

		BEGIN CATCH
			PRINT CONCAT(	'ERROR NUMBER: ', ERROR_NUMBER(),
									' ERROR MESSAGE: ', ERROR_MESSAGE(),
									' ERROR LINE: ', ERROR_LINE(),
									' ERROR PROCEDURE: ', ERROR_PROCEDURE())
			RETURN -1
		END CATCH
END

DECLARE @r INT,
				@codOficina CHAR(6) = 'ALC-ES', 
                @ciudad VARCHAR(40) = 'Alicante',
                @pais VARCHAR(50) = 'España',
                @codigo_postal CHAR(5) = '03005',
                @telefono VARCHAR(15) = '+34633127448',
                @linea_direccion1 VARCHAR(100) = 'C/ Falsa 123',
                @linea_direccion2 VARCHAR(100)

EXEC @r = crearOficina @codOficina, @ciudad, @pais, @codigo_postal, @telefono, @linea_direccion1, @linea_direccion2

 IF @r <> 0 
 	BEGIN
		PRINT 'El prodecimineto falló'
	END
ELSE
	BEGIN
		PRINT 'El procedimiento se ejecutó con éxito'
		PRINT CONCAT('Se ha creado la oficina de', @ciudad, ' - ', @pais, ' con éxito. ')
	END




-------------------------------------------------------------------------------------------
-- 6. Implementa un procedimiento llamado 'cambioJefes' que actualice el jefe/a de los empleados/as del
--      que tuvieran inicialmente (ant_codEmplJefe) al nuevo/a (des_codEmplJefe)
--    NOTA: Es un proceso que ocurre si alguien asciende de categoría.

--		Parámetros de entrada: ant_codEmplJefe INT
--                             des_codEmplJefe INT

--		Parámetros de salida: numEmpleados INT (número de empleados que han actualizado su jefe)
--		Tabla: EMPLEADOS

--	  * Comprueba que el funcionamiento es correcto realizando una llamada desde un script y comprobando la finalización del mismo
--
--      Ayuda: Recuerda utilizar:
--              EXEC @ret = cambioJefes ...
--              IF @ret <> 0 ...
-------------------------------------------------------------------------------------------


GO
CREATE OR ALTER PROCEDURE cambioJefes (@ant_codEmplJefe INT, @des_codEmplJefe INT, @numEmpleados INT OUTPUT)
AS
BEGIN
	BEGIN TRY
		IF  ISNULL(@ant_codEmplJefe, 0) < 1
			OR ISNULL(@des_codEmplJefe, 0) <1
			BEGIN
				PRINT 'El código de empleado introducido no es válido'
				RETURN -1
			END

			DECLARE @cont INT = (SELECT *
													  FROM EMPLEADOS
													WHERE codEmplJefe = 2)

			IF @cont IS NULL
			BEGIN
				PRINT 'El código de empleado introducidos no tenía personas a su cargo'
				RETURN -1
			END

			UPDATE EMPLEADOS
			SET codEmplJefe = @des_codEmplJefe
			WHERE codEmplJefe = @ant_codEmplJefe
	END TRY
	BEGIN CATCH
				PRINT CONCAT(	'ERROR NUMBER: ', ERROR_NUMBER(),
									' ERROR MESSAGE: ', ERROR_MESSAGE(),
									' ERROR LINE: ', ERROR_LINE(),
									' ERROR PROCEDURE: ', ERROR_PROCEDURE())
			RETURN -1
	END CATCH
END