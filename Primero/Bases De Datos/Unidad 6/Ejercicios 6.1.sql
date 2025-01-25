USE JARDINERIA

---------------------------
-- Actividad. Jardinería --
---------------------------

-- 1. Inserta una nueva oficina en Alicante.
INSERT INTO OFICINAS
		VALUES('ALC-ES', 'Alicante', 'España', 
					03005, '+34 633 127 448',' C/Carlota Pasarón 43',
					'3º Izquierda')


-- 2. Inserta un nuevo empleado para la oficina de Alicante que sea representante de ventas.
DECLARE @NextCodEmp AS INT
SET @NextCodEmp = (SELECT MAX(codEmpleado)+1 FROM EMPLEADOS)
INSERT INTO EMPLEADOS(codEmpleado, nombre, apellido1, 
											apellido2, tlf_extension_ofi, email, 
											puesto_cargo, codOficina, salario)
		VALUES (@NextCodEmp, 'Juan', 'León', 
						'Medina', '101', 'depechejuan@gmail.com', 
						'Representante Ventas', 'ALC-ES', 2000);


--3. Inserta un cliente que tenga como representante de ventas el empleado que creamos en el paso anterior.
DECLARE @NextCodCli AS INT
SET @NextCodCli = (SELECT MAX(codCliente)+1 FROM CLIENTES)
DECLARE @CodEmpJuan AS INT
SET @CodEmpJuan = (SELECT codEmpleado FROM EMPLEADOS WHERE email = 'depechejuan@gmail.com')
INSERT INTO CLIENTES
		VALUES(@NextCodCli, 'Jardines León', 'Gabriel', 
						' Leon', '666123456', 'gleon@jardinesleon.es',
						'C/ Calle Nº 5', null, 'Alicante',
						'Spain', '03001', @CodEmpJuan, 20000)

-- 4. Inserta un pedido que contenga al menos tres productos para el cliente que acabamos de crear.

-- Crear el pedido (sin productos)
DECLARE @JardinesLeon AS INT
SET @JardinesLeon = (SELECT codCliente FROM CLIENTES WHERE email = 'gleon@jardinesleon.es')
DECLARE @NextCodPed AS INT
SET @NextCodPed = (SELECT MAX(codPedido)+1 FROM PEDIDOS)
 INSERT INTO PEDIDOS
			VALUES(@NextCodPed, GETDATE(), DATEADD(day, 15, GETDATE()), 
			null, 'P', 'Cliente Prioritario',
			@JardinesLeon)

-- Insertar los productos en DETALLE_PEDIDOS
DECLARE @CodProduct1 AS INT
SET @CodProduct1 = 87
DECLARE @PrecioUnidad1 AS FLOAT
SET @PrecioUnidad1 = (SELECT precio_proveedor FROM PRODUCTOS WHERE codProducto = @CodProduct1)
DECLARE @CodProduct2 AS INT
SET @CodProduct2 = 17
DECLARE @PrecioUnidad2 AS FLOAT
SET @PrecioUnidad2 = (SELECT precio_proveedor FROM PRODUCTOS WHERE codProducto = @CodProduct2)
DECLARE @CodProduct3 AS INT
SET @CodProduct3 = 104
DECLARE @PrecioUnidad3 AS FLOAT
SET @PrecioUnidad3 = (SELECT precio_proveedor FROM PRODUCTOS WHERE codProducto = @CodProduct3)
DECLARE @UltimoPedidoJardinesLeon AS INT
SET @UltimoPedidoJardinesLeon = (SELECT MAX(codPedido) FROM PEDIDOS WHERE codCliente = @JardinesLeon)

INSERT INTO DETALLE_PEDIDOS
			VALUES (@UltimoPedidoJardinesLeon, @CodProduct1, 10, @PrecioUnidad1, 1),
						(@UltimoPedidoJardinesLeon, @CodProduct2, 5, @PrecioUnidad2, 2),
						(@UltimoPedidoJardinesLeon, @CodProduct3, 20, @PrecioUnidad3, 3)


--5. Actualiza y/o borra el código del cliente que creamos en el paso anterior. ¿Ha sido posible
--actualizarlo o borrarlo? ¿Por qué? Averigua si hubo cambios en las tablas relacionadas.

/*
No se puede ni eliminar ni cambiar, ya que la PK de "CodCliente" es una FK en otras y además programada como Not Null.

Estos son los códigos que probé
UPDATE CLIENTES
		SET codCliente = 7777
  WHERE codCliente = @JardinesLeon
  UPDATE CLIENTES
		SET codCliente = null
  WHERE codCliente = @JardinesLeon

   DELETE FROM CLIENTES
  WHERE codCliente = @JardinesLeon

  */


--6. Actualiza la cantidad de unidades solicitadas en el pedido que has creado del siguiente modo:
-- para el 1er producto serán 3 unidades, para el producto 2 serán 2 unidades y el tercero 1 unidad.

UPDATE DETALLE_PEDIDOS
		SET cantidad = 3
		WHERE codPedido = @UltimoPedidoJardinesLeon
			AND codProducto = @CodProduct1
UPDATE DETALLE_PEDIDOS
		SET cantidad = 2
				WHERE codPedido = @UltimoPedidoJardinesLeon
			AND codProducto = @CodProduct2
UPDATE DETALLE_PEDIDOS
		SET cantidad = 1
				WHERE codPedido = @UltimoPedidoJardinesLeon
			AND codProducto = @CodProduct3

--7. Modifica la fecha del pedido que hemos creado a la fecha y hora actuales.
UPDATE PEDIDOS
	SET fecha_pedido = GETDATE()
 WHERE codCliente = @JardinesLeon
	AND codPedido = @UltimoPedidoJardinesLeon


--8. Incrementa en un 5% el precio de los productos que están incluidos en el pedido que has creado (solo en ese pedido).
-- Si una vez realizada la operación vieras que aparecen ceros no significativos en los decimales, podrías utilizar la función CAST (XXX as FLOAT).
UPDATE PRODUCTOS
	 SET precio_venta *=  1.05
 WHERE codProducto = @CodProduct1
 UPDATE PRODUCTOS
	 SET precio_venta *=  1.05
 WHERE codProducto = @CodProduct2
 UPDATE PRODUCTOS
	 SET precio_venta *=  1.05
 WHERE codProducto = @CodProduct3

--9. Vuelve a dejar el precio de dichos productos como estaba anteriormente.
UPDATE PRODUCTOS
	 SET precio_venta /=  1.05
 WHERE codProducto = @CodProduct1
 UPDATE PRODUCTOS
	 SET precio_venta /=  1.05
 WHERE codProducto = @CodProduct2
 UPDATE PRODUCTOS
	 SET precio_venta /=  1.05
 WHERE codProducto = @CodProduct3

--10. ¿Cuál sería la secuencia de borrado de registros de tablas hasta que finalmente se pueda borrar la oficina de Alicante que creamos en el apartado 1?
--    Una vez tengas el script, comprueba que se puede eliminar.

/*
	Primero habría que editar (relocalizar) a los empleados que trabajan en Alicante para que la PK de la oficina de Alicante no esté presente en ningún empleado
	Despues se podrá eliminar la oficina de Alicante sin problemas.
*/
UPDATE EMPLEADOS
	SET codOficina = 'MAD-ES'
 WHERE codOficina = 'ALC-ES'
	SELECT * FROM EMPLEADOS

DELETE FROM OFICINAS
		WHERE ciudad = 'Alicante'


--11. Incrementa en un 20% el precio de los productos que NO estén incluidos en ningún pedido.
-- Si una vez realizada la operación vieras que aparecen ceros no significativos en los decimales, podrías utilizar la función CAST (XXX as FLOAT).
UPDATE PRODUCTOS
	SET precio_venta *= 1.20
 WHERE codProducto NOT IN (SELECT  DISTINCT codProducto 
													FROM DETALLE_PEDIDOS)

SELECT * FROM PRODUCTOS
--12. Vuelve a dejar el precio de los productos como estaba anteriormente.
UPDATE PRODUCTOS
	SET precio_venta /= 1.20
 WHERE codProducto  IN (SELECT  DISTINCT codProducto 
													FROM DETALLE_PEDIDOS)


--13. Elimina los clientes que no hayan realizado ningún pago.
DELETE FROM CLIENTES
			WHERE codCliente NOT IN (SELECT DISTINCT codCliente FROM PAGOS)


--14. Elimina los clientes que no hayan realizado un mínimo de 2 pedidos (NOTA: al ejecutar la sentencia fallará por la integridad referencial, es decir, porque hay tablas que tiene relacionado el idCliente como FK).
DECLARE @ClientsWithLessThan2Payments AS INT
SET @ClientsWithLessThan2Payments = (SELECT DISTINCT codCliente  
												  FROM PEDIDOS 
											    GROUP BY codCliente
											  HAVING COUNT(codCliente) < 2)
DELETE FROM CLIENTES
			WHERE codCliente = @ClientsWithLessThan2Payments


--15. Borra los pagos del cliente con menor límite de crédito.
DECLARE	@ClientWithLowerCreditLimit AS INT
SET @ClientWithLowerCreditLimit = (SELECT codCliente
												  FROM CLIENTES
												 WHERE limite_credito = (SELECT MIN(limite_credito)
																							FROM CLIENTES))
DELETE FROM PAGOS
			WHERE codCliente = @ClientWithLowerCreditLimit


--16. Actualiza la ciudad a Alicante para aquellos clientes que tengan un límite de crédito inferior a TODOS los precios de los productos de la categoría Ornamentales (puede que no haya ninguno).
DECLARE @Ornamentales AS VARCHAR(2)
SET @Ornamentales = (SELECT codCategoria 
										FROM CATEGORIA_PRODUCTOS
										WHERE nombre = 'Ornamentales')

DECLARE @PVPOrnamentales AS INT
SET @PVPOrnamentales = (SELECT SUM(precio_venta)
											  FROM PRODUCTOS
											 WHERE codCategoria = @Ornamentales)
UPDATE CLIENTES
		SET ciudad = 'Alicante',
				pais = 'Spain'
 WHERE limite_credito <= @PVPOrnamentales

--17. Actualiza la ciudad a Madrid para aquellos clientes que tengan un límite de crédito mensual inferior a ALGUNO de los precios de los productos de la categoría Ornamentales.
UPDATE CLIENTES
		SET ciudad = 'Madrid'
 WHERE limite_credito < ANY(SELECT precio_venta
													FROM PRODUCTOS
													WHERE codCategoria = @Ornamentales)

--18. Establece a 0 el límite de crédito del cliente que menos unidades pedidas del producto con referencia interna OR-179.
DECLARE @OR179 AS INT
SET @OR179 = (SELECT codProducto 
							FROM PRODUCTOS
						 WHERE refInterna = 'OR-179')
UPDATE CLIENTES
		SET limite_credito = 0
	WHERE codCliente = (SELECT C.codCliente
										  FROM CLIENTES C  LEFT JOIN PEDIDOS P ON c.codCliente = p.codCliente
																			LEFT JOIN DETALLE_PEDIDOS DP ON p.codPedido = DP.codPedido
										 WHERE DP.codProducto = @OR179
											   AND cantidad = (SELECT MIN(cantidad) AS cantidad
																			FROM DETALLE_PEDIDOS 
																		 WHERE codProducto = @OR179))
-- corrección:
SELECT codCliente, SUM(cantidad)
  FROM PRODUCTOS pr,
			DETALLE_PEDIDOS de,
			PEDIDOS pe
 WHERE pr.codProducto = de.codProducto
   AND pe.codPedido = de.codPedido
   AND refInterna = 'OR-179'
 GROUP BY codCliente
ORDER BY SUM(cantidad) ASC

  

  -- COrrección con TOP
  SELECT TOP(1) pr.codProducto
  FROM PRODUCTOS pr,
			DETALLE_PEDIDOS de,
			PEDIDOS pe
 WHERE pr.codProducto = de.codProducto
   AND pe.codPedido = de.codPedido
   AND refInterna = 'OR-179'

--19. Modifica la tabla DETALLE_PEDIDOS para insertar un campo numérico llamado IVA. Establece el
--valor de ese campo a 1.18 para aquellos registros cuyo pedido tenga fecha de pedido a partir de Enero de 2022
-- A continuación, actualiza el resto de pedidos estableciendo el IVA al 1.21

ALTER TABLE DETALLE_PEDIDOS
ADD IVA DECIMAL(3,2)

 UPDATE DETALLE_PEDIDOS
		SET IVA = 1.18
 WHERE codPedido IN (SELECT DISTINCT DP.codPedido
  FROM DETALLE_PEDIDOS DP LEFT JOIN PEDIDOS P ON dp.codPedido = p.codPedido
 WHERE fecha_pedido >= '2022.01.01')

UPDATE DETALLE_PEDIDOS
		SET IVA = 1.21
  WHERE IVA IS NULL


-- Extra: Pon una restricción que solo permita actualizar el valor de la columna IVA a 1.04, 1.10, 1.18 o 1.21

ALTER TABLE DETALLE_PEDIDOS
ADD CONSTRAINT CHK_IVA_VALUES
CHECK (IVA IN (1.04, 1.10, 1.18, 1.21));


--20. Modifica la tabla DETALLE_PEDIDOS para incorporar un campo numérico llamado total_linea y
--actualiza todos sus registros para calcular su valor con la fórmula:
--total_linea = precio_unidad * cantidad * IVA

ALTER TABLE DETALLE_PEDIDOS
ADD total_linea AS precio_unidad * cantidad * IVA

--21. Crea una tabla llamada HISTORICO_CLIENTES que tenga la misma estructura que CLIENTES y además un campo llamado fechaAlta de tipo DATE.
--Deberás insertar en una única sentencia los clientes cuyo nombre contenga la letra ‘s’ e informar el campo fechaAlta como la fecha/hora del momento en el que se inserta.
CREATE TABLE HISTORICO_CLIENTES(
	codHistorico INT,
	nombre_cliente VARCHAR(50) NOT NULL,
	nombre_contacto VARCHAR(50) NOT NULL,
	apellido_contacto VARCHAR(50) NULL,
	telefono VARCHAR(15) NOT NULL,
	email VARCHAR(100),
	linea_direccion1 VARCHAR(100) NOT NULL,
	linea_direccion2 VARCHAR(100) NULL,
	ciudad VARCHAR(50) NOT NULL,
	pais VARCHAR(50),
	codPostal CHAR(5),
	codEmpl_ventas INT,
	limite_credito DECIMAL(9, 2),
	fechaAlta DATE,
	CONSTRAINT PK_HISTORICO_CLIENTES
		PRIMARY KEY (codHistorico),
	CONSTRAINT FK_EMPLEADO_VENTAS 
		FOREIGN KEY (codEmpl_ventas)
		REFERENCES EMPLEADOS(codEmpleado)
)

INSERT INTO HISTORICO_CLIENTES (codHistorico, nombre_cliente, nombre_contacto,
																	apellido_contacto, telefono, email,
																	linea_direccion1, linea_direccion2, ciudad,
																	pais, codPostal, codEmpl_ventas,
																	limite_credito, fechaAlta)
			SELECT codCliente, nombre_cliente, nombre_contacto, apellido_contacto, telefono, email, linea_direccion1, linea_direccion2, 
							ciudad, pais, codPostal, codEmpl_ventas, limite_credito, GETDATE()
			  FROM CLIENTES
			WHERE nombre_cliente LIKE '%s%'



--22. Actualiza a NULL los campos region, pais y codigo_postal en la tabla CLIENTES para todos los registros. 
-- Utiliza una sentencia de actualización en la que se actualicen estos 3 campos a partir de los datos existentes en la tabla HISTORICO_CLIENTES.
-- Comprueba que los datos se han trasladado correctamente.
SELECT codCliente, nombre_cliente, ciudad, pais, codPostal FROM CLIENTES
SELECT codHistorico, nombre_cliente, ciudad, pais, codPostal FROM HISTORICO_CLIENTES


ALTER TABLE CLIENTES
ALTER COLUMN ciudad VARCHAR(50) NULL

UPDATE CLIENTES
		SET ciudad = NULL,
				pais = NULL,
				codPostal = NULL

-- Utiliza una sentencia de actualización en la que se actualicen estos 3 campos a partir de los datos existentes en la tabla HISTORICO_CLIENTES.
UPDATE C
		SET C.ciudad = HC.ciudad,
				C.pais = HC.pais,
				C.codPostal = HC.codPostal
		FROM CLIENTES C INNER JOIN HISTORICO_CLIENTES HC ON C.codCliente = HC.codHistorico