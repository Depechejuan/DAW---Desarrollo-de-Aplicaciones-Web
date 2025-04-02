/*
	EJERCICIO 1:
	Necesitamos crear un trigger para cuando demos de baja un Socio en la biblioteca.

	Deberemos comprobar si éste tiene algún ejemplar sin devolver (fecha devolución nula), en
	caso de ser así, que inserte un registro en la tabla EJEMPLARES_PERDIDOS (ISBN,
	idEjemplar, estado, DNI_socio, nombre_socio, fechaBaja), donde el campo fechaBaja
	corresponde con la fecha del sistema que tenga en ese momento el ordenador.
*/

GO
CREATE OR ALTER TRIGGER TRG_CLIENTES_DEL ON SOCIOS INSTEAD OF DELETE
AS BEGIN
	DECLARE @DNI CHAR(10),
					@nombre VARCHAR(100)

	SELECT @DNI = DNI,
				@nombre = nombre
		FROM SOCIOS

	INSERT INTO EJEMPLARES_PERDIDOS
	SELECT p.ISBN, p.idEjemplar, e.estado,
				d.DNI, d.nombre, GETDATE()
		FROM PRESTAMOS p,
				DELETED d,
				EJEMPLARES e
		WHERE p.DNI = d.DNI
			AND p.ISBN = e.ISBN
			AND p.idEjemplar = e.idEjemplar
			AND p.FechaDevol IS NULL	 

			DELETE FROM PRESTAMOS
					WHERE DNI IN (SELECT DNI FROM DELETED)
			
			DELETE FROM EJEMPLARES
				WHERE CONCAT(ISBN, '-', idEjemplar) IN (SELECT CONCAT(ISBN, '-', idEjemplar) FROM EJEMPLARES_PERDIDOS)

			DELETE FROM SOCIOS
					WHERE DNI IN (SELECT DNI FROM DELETED)

END

DELETE FROM SOCIOS
		WHERE DNI = '11111111A'







/*
	2.- Disparador SERVICIO TECNICO
	Crear un disparador para que cuando demos de baja un Técnico se compruebe si la suma
	del importe de las reparaciones de este técnico es mayor que 2500 €, y si lo cumple,
	guardaremos sus datos personales en una tabla llamada TECNICOS_RESERVA con la
	misma estructura que la tabla TECNICOS más un campo FechaBaja (con la fecha en la que
	se realiza la baja, que será la fecha del sistema).
*/
USE SERVICIO_TECNICO

SELECT *
	INTO TECNICOS_RESERVA
	FROM TECNICOS
WHERE 1 = 0

ALTER TABLE TECNICOS_RESERVA
		ADD FechaBaja DATETIME NOT NULL

ALTER TABLE TECNICOS_RESERVA
ADD CONSTRAINT PK_TECNICOS_RESERVA PRIMARY KEY (DNI, FechaBaja)



GO
CREATE OR ALTER TRIGGER TGR_TECNICOS_DEL ON TECNICOS
INSTEAD OF DELETE
AS BEGIN
	DECLARE @count INT = (SELECT COUNT(*) FROM deleted),
					@DNI CHAR(10),
					@index INT = 0

	WHILE @index < @count
	BEGIN
		SELECT @DNI = DNI
			FROM deleted
		ORDER BY DNI
		OFFSET @index ROWS
		FETCH NEXT 1 ROWS ONLY
		
		DECLARE @sum INT = (SELECT SUM(importe) FROM REPARACIONES WHERE DNI_tecnico = @DNI)

		IF @sum > 2500
			INSERT INTO TECNICOS_RESERVA
			SELECT *, GETDATE()
				FROM TECNICOS
			WHERE DNI = @DNI
	
		UPDATE REPARACIONES
		SET DNI_tecnico = NULL
		WHERE DNI_tecnico = @DNI

		DELETE FROM TECNICOS
				WHERE DNI = @DNI
		
		SET @index += 1
	END
END


BEGIN TRAN
	DELETE FROM TECNICOS
			WHERE DNI = '11111111A'

	SELECT * FROM REPARACIONES
	SELECT * FROM TECNICOS
	SELECT * FROM TECNICOS_RESERVA
ROLLBACK









/*
		3.- Disparador ALMACENES
		Crear un disparador para que cuando demos de baja un Proveedor se realice lo siguiente:
		- Comprobar si ese proveedor suministra algún artículo cuyo Stock sea igual a 0, y si
		es así, que añada a la tabla ARTICULOS_INEXISTENTES esos artículos (la tabla
		ARTICULOS_INEXISTENTES tendrá los mismos campos que la tabla ARTICULOS
		más la fecha de inserción (fecha del sistema) y el nombre del proveedor que se da
		de baja).
*/
GO
USE ALMACENES

SELECT * 
	INTO ARTICULOS_INEXISTENTES
	FROM ARTICULOS
 WHERE 1 = 0

ALTER TABLE ARTICULOS_INEXISTENTES
		ADD	fechaEliminado DATETIME NOT NULL
ALTER TABLE ARTICULOS_INEXISTENTES
		ADD nombre_proveedor VARCHAR(200)
ALTER TABLE ARTICULOS_INEXISTENTES
ADD CONSTRAINT PK_ARTICULOS_INEXISTENTES PRIMARY KEY (codArticulo, fechaEliminado)

GO
CREATE OR ALTER TRIGGER TGR_PROVEEDORES_DEL ON PROVEEDORES
INSTEAD OF DELETE
AS BEGIN
	PRINT 'EMPEZAMOS EL TRIGGER'
	DECLARE @codProveedor INT,
					@index INT = 0,
					@count INT = (SELECT COUNT(*) FROM deleted)
	PRINT @count
	WHILE @index >= @count
	PRINT 'Empezamos el bucle'
		SELECT @codProveedor = codProveedor
			FROM deleted
		ORDER BY codProveedor
		OFFSET @index ROWS
		FETCH NEXT 1 ROWS ONLY
		PRINT @count
		PRINT @index
		PRINT @codProveedor
		PRINT 'Llamamos al borrado de artículos con stock 0'
		EXEC dbo.DeleteAndSetArticuloToPerdidosWithStock0 @codProveedor
		PRINT 'Borrado terminado'


		PRINT 'Set a NULL los articulos del proveedor que se eliminará'
		EXEC dbo.SetArticuloToNullDeProveedorBorrado @codProveedor
		-- ¿Dónde se utiliza codProveedor?
		PRINT 'Todo Nullado'

		PRINT 'Borramos el proveedor'
		DELETE FROM PROVEEDORES
				WHERE codProveedor = @codProveedor
		PRINT 'Proveedor borrado'
		SET @index += 1
END

GO
CREATE OR ALTER PROCEDURE SetArticuloToNullDeProveedorBorrado (@codProveedor INT)
AS BEGIN
	DECLARE @count INT = (SELECT COUNT(*) FROM ARTICULOS WHERE codProveedor = @codProveedor)

	UPDATE ARTICULOS
	SET codProveedor = NULL
	WHERE codProveedor = @codProveedor
END


GO
CREATE OR ALTER PROCEDURE DeleteAndSetArticuloToPerdidosWithStock0 (@codProveedor INT)
AS BEGIN
	DECLARE @count INT = (SELECT COUNT(*)
												FROM ARTICULOS
											WHERE codProveedor = @codProveedor
												AND stock = 0)

	IF @count = 0
	BEGIN
		PRINT 'El cliente no tiene artículos que eliminar'
		RETURN 0
	END

	DECLARE @index INT = @count - 1,
					@codArticulo INT,
					@nombreProveedor VARCHAR(200) = (SELECT nombre FROM PROVEEDORES WHERE codProveedor = @codProveedor)
	
	WHILE @index >= 0
	BEGIN
		SELECT @codArticulo = codArticulo
		  FROM ARTICULOS
		 WHERE codProveedor = @codProveedor
			AND stock = 0
		ORDER BY codArticulo
		OFFSET @index ROWS
		FETCH NEXT 1 ROWS ONLY

		INSERT INTO ARTICULOS_INEXISTENTES
		SELECT *, GETDATE(), @nombreProveedor
		  FROM ARTICULOS
		 WHERE codArticulo = @codArticulo

		DELETE FROM ARTICULOS
				WHERE codArticulo = @codArticulo

		SET @index -= 1
	END

END



-- ELIMINACIÓN DEL PROVEEDOR 3, EL CUAL TIENE 2 ARTICULOS A BORRAR Y 1 A CONVERTIR A NULL
BEGIN TRAN
delete from PROVEEDORES
 where codProveedor = 3

 SELECT * FROM PROVEEDORES
 SELECT * FROM ARTICULOS_INEXISTENTES
 SELECT * FROM ARTICULOS
 ROLLBACK




/*
	4.- Auditoría de usuarios en la tabla CLIENTES de la BD JARDINERIA.
	Por motivos legales, cada vez que se realiza la actualización de un cliente en la tabla
	CLIENTES queremos que se almacenen todos sus datos en la tabla
	CLIENTES_HISTORICO (tendrá la misma estructura que la tabla CLIENTES más un campo
	con la fecha en la que se realiza la modificación).
	NOTA: La fechaModificacion deberá formar parte de la PK de la tabla para permitir que
	puedan realizarse varias actualizaciones de un mismo Cliente.
*/

SELECT * 
	INTO CLIENTES_HISTORICO
	FROM CLIENTES
 WHERE 1 = 0

ALTER TABLE CLIENTES_HISTORICO
				ADD fechaModificado DATETIME NOT NULL

ALTER TABLE CLIENTES_HISTORICO
		ADD CONSTRAINT PK_CLIENTES_HISTORICO PRIMARY KEY (codCliente, fechaModificado)

 SELECT * FROM CLIENTES_HISTORICO

GO
USE JARDINERIA
GO
CREATE OR ALTER TRIGGER TRG_UPDATE_CLIENTES_UPD ON CLIENTES
AFTER UPDATE
AS BEGIN
	DECLARE @count INT = (SELECT COUNT(*) FROM DELETED),
					@index INT = 0

	WHILE @index < @count
	BEGIN
		SELECT *
			FROM deleted
		ORDER BY codCliente
		OFFSET @index ROWS
		FETCH NEXT 1 ROWS ONLY

		INSERT INTO CLIENTES_HISTORICO
		SELECT *, GETDATE() FROM deleted

		PRINT 'Cliente actualizado y registrado su histórico'
		SET @index += 1
	END
END

SELECT * FROM CLIENTES

UPDATE CLIENTES
	SET linea_direccion2 = 'True Street 123'
 WHERE codCliente = 1

SELECT * FROM CLIENTES_HISTORICO
SELECT * FROM CLIENTES





0 2
1 3
2 
