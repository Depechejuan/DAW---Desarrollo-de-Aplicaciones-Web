/*
	PROCEDIMIENTOS Y FUNCIONES
*/

-- Cómo crear estas cosas pueden ser diferentes en oracle o sql server.
-- Todo lo que empiece por SP es "Store Procedure", un procedimiento almacenado.
-- USE JARDINERIA

CREATE OR ALTER PROCEDURE saludo (@nombre VARCHAR(100))
AS
BEGIN
	PRINT CONCAT('Hola ', @nombre)
END


-- forma correcta de llamarlo // Como puedes ver, no tiene que llamarse igual la variable.
DECLARE @name VARCHAR(100) = 'Juan'
EXEC saludo @name
-- forma menos correcta
EXEC saludo 'Juan'

-- NO crees y ejecutes todo el bloque de creación/edición y ejecución, entra en  bucle infinito (recursividad),
-- Ya que entraría dentro del procedimiento la llamada.


-- Si quieres crear varios procedimientos, añade el GO y elimina el procedimiento
GO 

-- adivina numero (int n 1-10) devuelve "has ganado" o "has perdido" en función de si hemos adivinado el número.
CREATE OR ALTER PROCEDURE adivinanza (@numUser INT)
AS
BEGIN
	DECLARE @randomNum INT = RAND() * 10 + 1
	IF @randomNum = @numUser
		BEGIN
			PRINT CONCAT('¡Has adivinado el número! era el ', @numUser)
		END
	ELSE
		BEGIN
			PRINT CONCAT('¡Oh No! No has acertado. El número era ', @randomNum)
			RETURN -1
		END
END

DECLARE @num INT = 7,
				@r INT
EXEC @r = adivinanza @num
IF @r <> 0
	BEGIN
		PRINT 'Procedimiento finalizado con errores'
		RETURN
	END

PRINT 'EXEC crearFactura 2025-03'

-- Los procedimientos siempre devuelven un INT
-- Si devuelve 0, ha salido bien, si devuelve otro número, está mal
-- IF @return <> 0 -- MAL!!! 

-- OJO CON LOS INPUT DE LOS PROCEDIMIENTOS!!
-- Si hay valores por defecto, no puedes introducir sólo el segundo vlaor.
-- Si quieres hacerlo, tienes que declararlos como NULL
-- Ejemplo: INT 5 VARCHAR HOLA ✅
-- VARCHAR HOLA ❌
-- NULL VARCHAR HOLA ✅

-------
GO
CREATE OR ALTER PROCEDURE division	  (@dividendo INT, 
																	@divisor INT,
																	@result DECIMAL(9,2) OUTPUT)
AS
BEGIN

PRINT CONCAT('El resultado previo a operar es: ', @result)

	IF @divisor = 0
		BEGIN
			PRINT 'NO SE PUEDE DIVIDIR POR 0'
			RETURN -1
		END
		ELSE
			BEGIN
			SET @result = @dividendo / @divisor
			END
END

DECLARE @resultado DECIMAL(9,2) = 75, 
				@check INT, 
				@dividendo INT = 10, 
				@divisor INT = 2

EXEC @check = division @dividendo, @divisor, @resultado OUTPUT

IF @check <> 0
BEGIN
	PRINT 'Error inesperado'
	RETURN
END
PRINT CONCAT('El resultado es: ', @resultado)

-- Eliminar procedimiento
DROP PROCEDURE division
-- también puedes poner dbo.division





