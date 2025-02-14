-- TEMA 7 --
-- Declaración de variables.

DECLARE @nombre VARCHAR(100) = 'Pepe' -- Asignar en línea
SET @nombre = 'Juan' -- Asignar a posterior.

-- Declaración de varias variables en un único DECLARE
DECLARE @numero INT = 1,
				@fecha SMALLDATETIME
SET @numero += 1 -- Como en C#
SET @fecha = GETDATE()
PRINT @nombre
PRINT @numero
PRINT @fecha
PRINT CONCAT('Nombre: ', @nombre, CHAR(13), --Char de 13 = salto de línea
						' - Número: ', @numero, CHAR(10),  --Char de 10 = salto de línea
						' - Fecha: ', @fecha)
-- No se suelen utilizar selects para esto. Se usa PRINT para que se quede en los LOGS de la API
SELECT CONCAT('Nombre: ', @nombre, CHAR(13), --Char de 13 = salto de línea
						' - Número: ', @numero, CHAR(10),  --Char de 10 = salto de línea
						' - Fecha: ', @fecha) AS Columna

						-- Se conoce como FILTRO. Algo que el usuario pone y no podemos tocar
						-- Como los filtros de precio en las páginas web
DECLARE @varPrecio DECIMAL(9,2) = 75
SELECT *
  FROM PRODUCTOS
 WHERE precio_venta >= @varPrecio
varchar
DECLARE @codCategoria CHAR(2) = 'FR', @nombreFruta VARCHAR(20) = 'Pera'
SELECT *
  FROM PRODUCTOS
 WHERE codCategoria = @codCategoria
 AND nombre LIKE CONCAT(@nombreFruta, '%')


-- Invocar un procedimiento
EXEC sp_columns PRODUCTOS
-- Devuelv euna tabla co ninformación sobre la tabla que ponemos como destino

-- Devuelve lo mismo pero más extendido.
EXEC sp_help PRODUCTOS

DECLARE @minPrecio DECIMAL(9,2),
				@maxPrecio DECIMAL(9,2),
				@codCategoria CHAR(2) = 'HR'
-- Forma 1, select de asignación. No muestra nada, sólo hace la consulta para asignarla a la variable
-- Esta es más óptima
SELECT @minPrecio = MIN(precio_venta),
			@maxPrecio = MAX(precio_venta)
  FROM PRODUCTOS
 WHERE codCategoria = @codCategoria

-- Forma 2 -> Menos óptima. Cada variable es un SET diferente.
--SET @minPrecio = (SELECT MIN(precio_venta)
--								 FROM PRODUCTOS
--								WHERE codCategoria = @codCategoria)
 PRINT @minPrecio
 PRINT @maxPrecio


DECLARE @codCategoria VARCHAR(50)
SET @codCategoria = (SELECT TOP(1) codCategoria
FROM PRODUCTOS
GROUP BY codCategoria
ORDER BY COUNT(1) DESC)

PRINT @codCategoria


-- Estructuras de Control
-- BEGIN END es lo mismo que poner { }



-- EJEMPLO
USE JARDINERIA
GO
DECLARE @codCliente INT, @numPagos INT
--devuelve un cliente al azar, no un número, sino un registro
SET @codCliente = (SELECT TOP(1) codCliente
									FROM CLIENTES	
									ORDER BY NEWID())
SELECT @numPagos = COUNT(codCliente)
	FROM PAGOS
 WHERE codCliente = @codCliente
IF @numPagos > 0
BEGIN
	PRINT CONCAT('El liente ', @codCliente, ' ha realizado ', @numPagos, ' pagos.')
END
ELSE 
BEGIN
	PRINT CONCAT('El liente ', @codCliente, ' no ha realizado pagos.')
END



-- EJEMPLO 2:
DECLARE @codCliente INT, @numPagos INT
-- Obtenemos UN cliente al azar
SET @codCliente = (SELECT TOP(1) codCliente
FROM CLIENTES
ORDER BY NEWID())
-- Obtenemos el número de pagos realizados por el cliente
SET @numPagos = (SELECT COUNT(1)
FROM PAGOS
WHERE codCliente = @codCliente)
-- Evaluamos el resultado
IF @numPagos > 0
BEGIN
PRINT CONCAT('El cliente ', @codCliente, ' ha realizado ', @numPagos, ' pago/s.')
END
ELSE
BEGIN
-- Obtenemos el número de pedidos realizados por el cliente
DECLARE @numPedidos INT
SET @numPedidos = (SELECT COUNT(1)
FROM PEDIDOS
WHERE codCliente = @codCliente)
IF @numPedidos > 0
BEGIN
PRINT CONCAT('El cliente ', @codCliente, ' ha realizado ', @numPedidos,
' pedido/s.')
END
ELSE
BEGIN
PRINT CONCAT('El cliente ', @codCliente, ' NO ha realizado ningún pedido.')
END
END



-- CURSORES
-- Ejemplo: generar facturas para cada cliente (como un for each), y por cada uno llamas a un método diferente.

DECLARE @i INT = 1,
				@max INT = 20

WHILE @i <= @max
BEGIN
	IF @I % 5 = 0 
	BEGIN
		PRINT @i
	END
	SET @i +=1
END




-- COMO HACER UN BACKUP SUPER RAPIDO

SELECT *
  INTO PRODUCTOS_BACKUP
  FROM PRODUCTOS

-- Crea automáticamente la tabla exacta, sin declararla con CREATE TABLE.




/*
	CURSORES
*/

DECLARE @cont INT = 1
SELECT codCliente, nombre_cliente
  FROM CLIENTES
 ORDER BY codCliente ASC
 OFFSET @cont ROWS
 FETCH NEXT 3 ROWS ONLY

 -- Offset es como una ventana. Es un desplazamiento (hacia abajo)

 DECLARE @cont  INT = 0,
				@Cliente VARCHAR(156),
				@numElementos INT =  (SELECT COUNT(codCliente) FROM CLIENTES)

IF ISNULL(@cont, 0) < 0
BEGIN
	PRINT 'ERROR'
	RETURN
END

 WHILE @cont < @numElementos
  BEGIN
		SELECT CONCAT(codCliente, ', ', nombre_cliente) AS codNombreCliente
		  FROM CLIENTES
		 ORDER BY codCliente ASC
		 OFFSET @cont ROWS -- IMPORTANTE
		FETCH NEXT 10 ROWS ONLY -- IMPORTANTE
		SET @cont = @cont + 10
END



/*
	TRY/CATCH EN SQL
*/

BEGIN TRY -- solo utilizarlo cuando hagamos cambios en la BBDD
	-- codigo TRY
	SET IMPLICIT_TRANSACTIONS OFF -- Desactiva el modo transacciones, para controlar nosotros cuándo actualizamos la base de datos.

END TRY
BEGIN CATCH
	-- codigo catch
END CATCH

-- TRANSACCIONES

BEGIN TRY
	BEGIN TRAN
	-- codigo inserts/delete/selects
	COMMIT
	END TRAN
END TRY

BEGIN CATCH
	ERROR_NUMBER(),
	ERROR_MESSAGE(),
	ERROR_LINE(),
	ERROR_PROCEDURE()
	ROLLBACK
END CATCH




DECLARE @dividendo INT, @divisor INT, @resultado INT
-- Prefijamos el dividendo a 50
SET @dividendo = 50
SET @divisor = 0

BEGIN TRY
	SET @resultado = @dividendo / @divisor
	PRINT @resultado
END TRY

BEGIN CATCH
	-- PRIMERO ROLLBACK!!!! Luego lo demás por si peta algo
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
	PRINT ERROR_LINE()
	PRINT ERROR_PROCEDURE()
	-- Mejorar 4 lineas a una:
	PRINT CONCAT('  ->   ERROR NUMBER: ', ERROR_NUMBER(), CHAR(10),
								'  ->   ERROR_MESSAGE:  ', ERROR_MESSAGE(), CHAR(10),
								'  ->   ERROR_LINE:  ', ERROR_LINE(), CHAR(10),
								'  ->   ERROR_PROCEDURE:  ', ERROR_PROCEDURE(), CHAR(10),
								'  ->   FECHA:  ', GETDATE(), CHAR(10),
								'  ->   VARIABLE DIVIDENDO:', @dividendo,';', CHAR(10),
								'  ->   VARIABLE DIVISOR:', @divisor,';', CHAR(10))
END CATCH-- DESDE YA OBLIGATORIA ESTA LINEASET IMPLICIT_TRANSACTIONS OFFBEGIN TRANUPDATE CLIENTES	SET nombre_cliente = 'Juan'WHERE codCliente = 1DELETE FROM PAGOSROLLBACKEND TRANSSELECT *
FROM SYS.MESSAGES
WHERE message_id = 8134

EXEC sp_addmessage @msgnum = 50001, -- Siempre >= 50001 para los personalizados
@severity = 11, -- Si queremos que salte en el TRY >= 11
@msgtext = 'Creación de usuarios'


EXEC sp_addmessage @msgnum = 50002, -- Siempre >= 50001 para los personalizados
@severity = 11, -- Si queremos que salte en el TRY >= 11
@msgtext = 'Modificación de Usuarios'

SELECT *
FROM SYS.MESSAGES
WHERE message_id IN (50001, 50002)

-- GESTION DE USUARIOS (CRUD)

-- Crear Usuario
-- Como un trhow new error (num Error, severidad, estado)
RAISERROR(50001, 11,0)
RAISERROR(50001, 11,1)
-- Borrar Usuario
RAISERROR(50001, 11,2)
-- Modificar Usuario
RAISERROR(50001, 11,3)
-- Consultar Usuarios
RAISERROR(50001, 11,4)

-- Sabré qué tipo de error y qué estado,y podré identificar y solucionar la incidencia mucho más rápida