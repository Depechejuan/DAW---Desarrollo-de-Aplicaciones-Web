USE JARDINERIA

						---------------------------
						-- EJERCICIOS UD7 - TSQL -- 
						---------------------------
-------------------------------------------------------------------------------------------
-- NOTA: Recuerda cuidar la limpieza del código (tabulaciones, nombres de tablas en mayúscula,
--		nombres de variables en minúscula, poner comentarios sin excederse, código organizado y fácil de seguir, etc.)
-------------------------------------------------------------------------------------------
-- ¡IMPORTANTE! Siempre que sea posible deberás utilizar variables 	(no es correcto indicar directamente el valor en una SELECT)
--  Esta práctica incorrecta se conoce como "hardcoding" y genera muchos problemas en el código y en su depuración
--  Aquí tenéis más información: https://es.wikipedia.org/wiki/Hard_code
-------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
-- 1. Crea un script que obtenga el nombre de la gama que tenga más cantidad de productos diferentes
--
-- Salida: 'La gama que más productos tiene es Ornamentales'
-------------------------------------------------------------------------------------------
DECLARE @CategoriaMasAmplia VARCHAR(50),
				@codCategoria CHAR(2)

-- Obtener el código de categoría con más productos
SELECT TOP(1) @codCategoria = codCategoria
	FROM PRODUCTOS
 GROUP BY codCategoria
 ORDER BY COUNT(codProducto) DESC

 -- Obtener el nombre de categoría con más productos a partir de su código
 SELECT @CategoriaMasAmplia = nombre
   FROM CATEGORIA_PRODUCTOS
  WHERE codCategoria = @codCategoria
PRINT @CategoriaMasAmplia

-- En un unico SELECT
SELECT @CategoriaMasAmplia = nombre
	FROM CATEGORIA_PRODUCTOS
WHERE codCategoria = (SELECT TOP(1) codCategoria
						FROM PRODUCTOS
						GROUP BY codCategoria
						ORDER BY COUNT(codProducto) DESC)


-------------------------------------------------------------------------------------------
-- 2. Crea un script que obtenga el nombre del empleado con id 7 y el nombre de su jefe
--
-- Salida: 'El empleado Carlos Soria Jimenez tiene como jefe al empleado Alberto Soria Carrasco'
-------------------------------------------------------------------------------------------
DECLARE @codEmpleado7 INT = 7,
				@Empleado7 VARCHAR(152),
				@JefeEmpleado7 VARCHAR(152)

SELECT @Empleado7 = CONCAT(E.nombre, ' ', E.apellido1, ' ', E.apellido2), 
				@JefeEmpleado7 = (CONCAT(EJ.nombre, ' ', EJ.apellido1, ' ', Ej.apellido2))
  FROM EMPLEADOS E JOIN EMPLEADOS EJ 
	ON E.codEmplJefe = EJ.codEmpleado
WHERE E.codEmpleado = @codEmpleado7

-- más simple:
/*
SELECT e.nombre, j.nombre
  FROM EMPLEADOS E, EMPLEADOS J
 WHERE j.codEmplJefe = e.codEmpleado
   AND e.codEmpleado = @Empleado7
   */
PRINT CONCAT('El empleado ' , @Empleado7, ' tiene como jefe al empleado ', @JefeEmpleado7)



-------------------------------------------------------------------------------------------
-- 3. Crea un script que devuelva el número de pedidos realizados por el cliente 9
-- Salida: 'El cliente Naturagua ha realizado 5 pedido/s'
-------------------------------------------------------------------------------------------
DECLARE @codCliente9 INT = 9,
				@nombreCliente9 VARCHAR(50),
				@numPedidos INT
				
SELECT	@nombreCliente9 = C.nombre_cliente, 
				@numpedidos = COUNT(P.codCliente)
  FROM CLIENTES C JOIN PEDIDOS P
	ON c.codCliente = p.codCliente
 WHERE C.codCliente = @codCliente9
 GROUP BY P.codCliente, C.nombre_cliente

 -- HAZLO SIMPLE! Son dos consultas muy sencillas.

PRINT CONCAT('El cliente ', @nombreCliente9, ' ha realizado ' , @numPedidos, ' pedido/s' )
-- Prueba para que salga mal y veamos el error varchar to INT
PRINT 'El cliente ' + @nombreCliente9 + ' ha realizado ' + @numPedidos + ' pedido/s'
-- Salida: 'El cliente Naturagua ha realizado 5 pedido/s'


-------------------------------------------------------------------------------------------
-- 4. Crea un script que dado un codPedido en una variable, obtenga la siguiente información:
--		nombre_cliente, Fecha pedido, estado
--
-- Salida: 'El pedido XXXX realizado por el cliente YYYYYYY se realizó el ZZ/ZZ/ZZZZ y su estado es EEEEEEEE
-------------------------------------------------------------------------------------------
DECLARE @codPedido INT = NULL,
				@nombreCliente VARCHAR(50),
				@fechaPedido DATE,
				@estadoPedido VARCHAR(15)

IF NOT EXISTS (SELECT *
							FROM PEDIDOS
							WHERE codPedido = @codPedido)
BEGIN 
	PRINT 'EL CODIGO DEL PEDIDO NO EXISTE'
	RETURN -- cierra el script, sin datos. Paraliza el código.
END

ELSE
BEGIN
SELECT @nombreCliente = nombre_cliente, 
			@fechaPedido = fecha_pedido,
			@estadoPedido = EP.descripcion
  FROM CLIENTES C LEFT JOIN PEDIDOS P
	ON c.codCliente = p.codCliente RIGHT JOIN ESTADOS_PEDIDO EP
	ON p.codEstado = EP.codEstado
 WHERE p.codPedido = @codPedido

 PRINT CONCAT('El pedido ' , @codPedido, 
							' realizado por el cliente ', @nombreCliente, 
							' se realizó el ', @fechaPedido, 
							' y su estado es ', @estadopedido)
 END
 -------------------------------------------------------------------------------------------
-- 5. Crea un script que dadas dos variables: porcentaje y gama
--		Incremente el precio de los productos de dicha gama en el porcentaje que se le pasa
--
-- Salida: 'Se ha aumentado el precio un XXXX% de la gama YYYY'
-------------------------------------------------------------------------------------------
DECLARE @porcentaje TINYINT = 15,
			@gama VARCHAR(50) = 'Frutales'


UPDATE PRODUCTOS
	SET precio_venta = precio_venta * ((@porcentaje / 100.0) + 1)
 WHERE codCategoria = (SELECT codCategoria
											FROM CATEGORIA_PRODUCTOS
										WHERE nombre = @gama)

PRINT CONCAT('Se ha aumentado el precio un ', @porcentaje, '% de la gama ', @gama)

SELECT * FROM PRODUCTOS

-------------------------------------------------------------------------------------------
-- 6. Crea un script que devuelva cuántos clientes han realizado algún pedido de
--   al menos 3 productos (siendo el número de productos una variable).
--	
-- Salida: 'Existen XXXX clientes en la BD que han realizado pedidos de al menos YYYY productos'
-------------------------------------------------------------------------------------------
DECLARE @MaxProductos INT = 3,
				@TotalClientes INT

--SELECT @TotalClientes = COUNT(codCliente)
--  FROM PEDIDOS P LEFT JOIN DETALLE_PEDIDOS DP
--	ON P.codPedido = DP.codPedido
--WHERE numeroLinea >= @MaxProductos
-- esto pero bien
SELECT @TotalClientes = COUNT(DISTINCT codPedido)
	FROM PEDIDOS
 WHERE codPedido IN  (SELECT codPedido 
											FROM DETALLE_PEDIDOS
										WHERE numeroLinea = @MaxProductos)

--SELECT @TotalClientes = COUNT(DISTINCT codCliente)
--  FROM PEDIDOS
--WHERE codPedido IN (SELECT codPedido
--										FROM DETALLE_PEDIDOS
--										GROUP BY codPedido
--										HAVING COUNT(*) >= 3)

PRINT CONCAT('Existen ', @TotaLClientes, ' clientes en la BD que han realizado pedidos de al menos ', @MaxProductos, ' productos')
-------------------------------------------------------------------------------------------
-- 7. Crea un script que a partir de una variable codCliente devuelva el nombre completo de su
-- 		representante de ventas y la ciudad de la oficina en la que trabaja.
--	
-- Salida: 'El cliente XXXX tiene como representante a YYYY y trabaja en la ciudad de ZZZZ'
-------------------------------------------------------------------------------------------
DECLARE @codCliente INT = 1,
				@nombreCliente VARCHAR(50),
				@nombreRepresentanteVentas VARCHAR(152),
				@ciudadOficina VARCHAR(40)
				
IF ISNULL(@codCliente, 0) < 1  
OR NOT EXISTS (SELECT 1
								FROM CLIENTES
							 WHERE codCliente = @codCliente)
BEGIN
	PRINT 'EL CLIENTE NO EXISTE'
	RETURN
END

SELECT @nombreCliente = C.nombre_cliente,
			@nombreRepresentanteVentas = CONCAT(e.nombre, ' ', e.apellido1, ' ', e.apellido2),
			@ciudadOficina = o.ciudad
  FROM CLIENTES C JOIN EMPLEADOS E
		ON c.codEmpl_ventas = e.codEmpleado JOIN OFICINAS O
		ON e.codOficina = O.codOficina
 WHERE codCliente = @codCliente

PRINT CONCAT('El cliente ',  @nombreCliente, 
						' tiene como representante a ', @nombreRepresentanteVentas, 
						' y trabaja en la ciudad de ', @ciudadOficina)


