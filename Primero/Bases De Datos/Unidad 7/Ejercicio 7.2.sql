
						---------------------------
						-- EJERCICIOS UD7 - TSQL -- 
						---------------------------
-------------------------------------------------------------------------------------------
-- NOTA: Recuerda cuidar la limpieza del código (tabulaciones, nombres de tablas en mayúscula,
--		nombres de variables en minúscula, poner comentarios sin excederse, código organizado y fácil de seguir, etc.)
-------------------------------------------------------------------------------------------
-- 1. Crea un script que use un bucle para calcular la potencia de un número.
--		Tendremos dos variables: el número y la potencia
--
--		Ejemplo.
--		Número = 3		Potencia = 4		Resultado = 3*3*3*3 = 81
--
--		Si el número o la potencia son 0 o <0 devolverá el mensaje: “La operación no se puede realizar.
-------------------------------------------------------------------------------------------
DECLARE @numero INT = 3,
				@potencia INT = 0,
				@resultado INT,
				@cadena VARCHAR(100)
SET @resultado = @numero

IF @potencia = 0
BEGIN
	PRINT CONCAT(@numero, ' elevado a ', @potencia, '=', 1)
	RETURN
END

SET @cadena = @numero
WHILE @potencia > 1

BEGIN
		SET @cadena = CONCAT(@cadena, '*', @numero)
		SET @resultado = @resultado * @numero
		SET @potencia = @potencia - 1
END
SET @cadena = CONCAT(@cadena, '=', @resultado)
PRINT (@cadena)


-------------------------------------------------------------------------------------------
-- 2. Crea un script que calcule las soluciones de una ecuación de segundo grado ax^2 + bx + c = 0
--
--	Debes crear variables para los valores a, b y c.
--  Al principio debe comprobarse que los tres valores son positivos, en otro caso, 
--		se devolverá el mensaje 'Cálculo no implementado'
--	
--	Consulta esta página para obtener la fórmula a implementar (recuerda que habrá DOS soluciones): 
--		http://recursostic.educacion.es/descartes/web/Descartes1/4a_eso/Ecuacion_de_segundo_grado/Ecua_seg.htm#solgen

--	Salida esperada para los valores: a=3, b=-4, c=1 --> sol1= 1 y sol2= 0.33
--	
--	NOTA: Si no sale lo mismo, te recomiendo revisar bien el orden de prioridad de los operadores... ()
-------------------------------------------------------------------------------------------
DECLARE @a INT = 3,
				@b INT = 4,
				@c INT = 1,
				@res1 INT,
				@res2 INT

IF @a = 0
BEGIN
	PRINT 'No se puede dividir entre 0'
	RETURN
END

IF @a < 0 OR @c < 0
BEGIN
	PRINT 'No puedes introducir estos valores negativos'
	RETURN
END

IF SQRT(-4*@a*@c) < 0
BEGIN
	PRINT 'Número negativo'
	RETURN
END

BEGIN 
	SET @res1 = (-@b + SQRT(((@b*@b) - (4*@a*@c))) / 2*@a)
	SET @res2 = (-@b - SQRT(((@b*@b) - (4*@a*@c))) / 2*@a)
END
PRINT CONCAT('Solución A: ', @res1)
PRINT CONCAT('Solución B: ', @res2)
-------------------------------------------------------------------------------------------
-- 3. Crea un script que calcule la serie de Fibonacci para un número dado.

-- La sucesión es: 1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597...
-- Si te fijas, se calcula sumando el número anterior al siguiente:
--	Ejemplo. Si se introduce el numero 3 significa que tendremos que hacer 3 iteraciones:
--			ini = 1
--			0+1 = 1
--			1+1 = 2
--			2+1 = 3
--			3+2 = 5
--			5+3 = 8
--			...
-- 
--	Ayuda: Quizás necesites guardar en algún sitio el valor actual de la serie antes de sumarlo...
-------------------------------------------------------------------------------------------
DECLARE @cantidadNumeros INT = 10,
				@primerNum INT = 1,
				@segundoNum INT = 1,
				@AUX INT,
				@resultado VARCHAR(100),
				@count INT = 1

IF @cantidadNumeros < 1
BEGIN
	PRINT 'No se puede imprimir menos de 1 número'
	RETURN
END

IF @count = 1 
BEGIN
	SET @resultado = @primerNum
	SET @count = @count + 1
END

IF @count = 2 AND @count <= @cantidadNumeros
BEGIN
	SET @resultado = CONCAT(@resultado, ', ', @segundoNum)
	SET @count = @count + 1
END

WHILE @count <= @cantidadNumeros
BEGIN
	SET @AUX = @primerNum + @segundoNum
	SET @resultado = CONCAT(@resultado, ', ', @aux)
	SET @primerNum = @segundoNum
	SET @segundoNum = @AUX
	SET @count = @count + 1
END

PRINT 'Secuencia de Fibonachi'
PRINT @resultado


-------------------------------------------------------------------------------------------
-- 4. Utilizando la BD JARDINERIA, crea un script que realice lo siguiente:
--		Obtén el nombre del cliente con código 3 y guárdalo en una variable
--		Obtén el número de pedidos realizados por dicho cliente y guárdalo en una variable
--		Muestra por pantalla el mensaje: 'El cliente XXXX ha realizado YYYY pedidos.'
--		
--		Resultado esperado: El cliente Gardening Associates ha realizado 9 pedidos.
--
--	    Reto opcional: Implementa el script utilizando una única consulta.
-------------------------------------------------------------------------------------------
USE JARDINERIA
GO
DECLARE @nombreCliente VARCHAR(50),
				@codCliente INT = 1,
				@numPedidos INT

IF @codCliente <= 0
BEGIN
	PRINT 'El código de cliente no es válido'
	RETURN
END

SELECT @nombreCliente = nombre_cliente
  FROM CLIENTES
 WHERE codCliente = @codCliente

IF @nombreCliente IS NULL
BEGIN
	PRINT CONCAT('El cliente con código ', @codCliente, ' no existe.')
	RETURN
END

SELECT @numPedidos = COUNT(codCliente)
  FROM PEDIDOS
 WHERE codCliente = @codCliente

IF @numPedidos IS NULL
BEGIN
	SET @numPedidos = 0
END

PRINT CONCAT('El cliente ', @nombreCliente, ' ha realizado ', @numPedidos, ' pedidos.')



-------------------------------------------------------------------------------------------
-- 5. Utilizando la BD JARDINERIA, crea un script que realice lo siguiente:
--		Obtén el nombre y los apellidos de todos los empleados de la empresa
--		Deberás mostrar cada uno de ellos línea a línea utilizando PRINT
--		
--		Salida esperada:
--			Magaña Perez, Marcos
--			López Martinez, Ruben
--			Soria Carrasco, Alberto
--			Solís Jerez, Maria
--			...
--
--		Reto opcional: Modifica el script anterior para que muestre sólo los que trabajen en la oficina de Londres
--		Salida esperada:
--			Johnson , Amy
--			Westfalls , Larry
--			Walton , John
-------------------------------------------------------------------------------------------
-- Versión Original (primer punto)
USE JARDINERIA
GO
DECLARE @nombre VARCHAR(50),
				@apellidos VARCHAR(101),
				@cont INT = 0,
				@numElementos INT = (SELECT COUNT(codEmpleado) FROM EMPLEADOS)

IF ISNULL(@numElementos, 0) < 0
BEGIN
	PRINT 'Error: No se han recogido los datos de la tabla'
	RETURN
END

WHILE @numElementos > @cont
BEGIN
	SELECT @nombre = nombre, 
					@apellidos = CONCAT(apellido1, ' ', apellido2)
	  FROM EMPLEADOS
	ORDER BY codEmpleado
	OFFSET @cont ROWS
	FETCH NEXT 1 ROWS ONLY
	PRINT CONCAT(@nombre, ' ', @apellidos)
	SET @cont = @cont + 1
END


-- Versión Modificada (segundo punto)
USE JARDINERIA
GO
DECLARE @nombre VARCHAR(50),
				@apellidos VARCHAR(101),
				@cont INT = 0,
				@numElementos INT = (SELECT COUNT(codEmpleado)
														FROM EMPLEADOS E LEFT JOIN OFICINAS O 
															ON  e.codOficina = o.codOficina 
														WHERE LOWER(ciudad) = 'londres')

IF ISNULL(@numElementos, 0) < 0
BEGIN
	PRINT 'Error: No se han recogido los datos de la tabla'
	RETURN
END

WHILE @numElementos > @cont
BEGIN
	SELECT @nombre = E.nombre, 
					@apellidos = CONCAT(E.apellido1, ' ', E.apellido2)
	  FROM EMPLEADOS E LEFT JOIN OFICINAS O
			ON e.codOficina = o.codOficina
	WHERE LOWER(O.ciudad) = 'londres'
	ORDER BY codEmpleado
	OFFSET @cont ROWS
	FETCH NEXT 1 ROWS ONLY
	PRINT CONCAT(@nombre, ' ', @apellidos)
	SET @cont = @cont + 1
END

-------------------------------------------------------------------------------------------
-- 6. Utilizando la BD JARDINERIA, crea un script que realice lo siguiente:
--		Reutilizando el script del ejercicio 4, agrega la siguiente información a la salida:
--			Número de pedidos realizados por cada cliente
--			NOTA: Realízalo utilizando una consulta específica para obtener el número de pedidos de cada cliente.

--		Salida esperada:
--			El cliente GoldFish Garden ha realizado 11 pedidos.
--			El cliente Gardening Associates ha realizado 9 pedidos.
--			El cliente Gerudo Valley ha realizado 5 pedidos.
--			El cliente Tendo Garden ha realizado 5 pedidos.
--			El cliente Lasas S.A. ha realizado 0 pedidos.
--			...
--
--		Reto opcional:
--		Muestra también el coste total de todos los pedidos para cada cliente.
--
--		Salida esperada:
--			El cliente GoldFish Garden ha realizado 11 pedidos por un coste total de 10365.00.
--			El cliente Gardening Associates ha realizado 9 pedidos por un coste total de 13726.00.
--			El cliente Gerudo Valley ha realizado 5 pedidos por un coste total de 81849.00.
--			El cliente Tendo Garden ha realizado 5 pedidos por un coste total de 23794.00.
--			El cliente Lasas S.A. ha realizado 0 pedidos por un coste total de 0.00.
--			...
-------------------------------------------------------------------------------------------
USE JARDINERIA
GO
DECLARE @nombreCliente VARCHAR(50),
				@cont INT = 0,
				@numElementos INT = (SELECT COUNT(codCliente) FROM CLIENTES),
				@cantidadPedidos INT,
				@codCliente INT,
				@precioTotal DECIMAL(9,2)

IF ISNULL(@numElementos, 0) < 0
BEGIN
	PRINT 'Error: No se han recogido los datos de la tabla'
	RETURN
END

WHILE @numElementos > @cont
BEGIN
	SELECT @codCliente = c.codCliente, @nombreCliente = nombre_cliente, 
				@cantidadPedidos = COUNT(p.codPedido), @precioTotal = SUM(dp.precio_unidad)
	  FROM CLIENTES C JOIN PEDIDOS P
		ON c.codCliente = p.codCliente  JOIN DETALLE_PEDIDOS DP
		ON p.codPedido = DP.codPedido
	GROUP BY c.codCliente, nombre_cliente
	ORDER BY c.codCliente
	OFFSET @cont ROWS
	FETCH NEXT 1 ROWS ONLY
	IF @cantidadPedidos = 1
	BEGIN -- Con esto controlamos si sólo ha hecho 1 único pedido, aparezca "ha realizado 1 pedido", y no "ha realizado 1 pedidos".
		PRINT CONCAT('El cliente ', @nombreCliente, 'ha realizado ', @cantidadPedidos, ' Pedido por un coste total de ', @precioTotal)
	END
		PRINT CONCAT('El cliente ', @nombreCliente, 'ha realizado ', @cantidadPedidos, ' Pedidos por un coste total de ', @precioTotal)
	SET @cont = @cont + 1
END

SELECT c.codCliente, c.nombre_cliente, COUNT(p.codPedido) AS 'cantidad Pedidos', SUM(dp.precio_unidad)
	FROM CLIENTES C LEFT JOIN PEDIDOS P
		ON c.codCliente = p.codCliente RIGHT JOIN DETALLE_PEDIDOS DP
		ON p.codPedido = dp.codPedido
	GROUP BY c.codCliente, nombre_cliente



-------------------------------------------------------------------------------------------
-- 7. Utilizando la BD JARDINERIA, crea un script que realice las siguientes operaciones:
--	Importante: debes utilizar TRY/CATCH y Transacciones si fueran necesarias.

--		Crea una nueva oficina (datos inventados)
--		Crea un nuevo empleado con datos inventados (el codEmpleado a insertar debes obtenerlo automáticamente)
--		Crea un nuevo cliente (datos inventados) (el codCliente a insertar debes obtenerlo automáticamente)
--		Asigna como representante de ventas el cliente anterior
-------------------------------------------------------------------------------------------
USE JARDINERIA
GO
DECLARE @codEmpleado INT = (	SELECT MAX(codEmpleado)
													  FROM EMPLEADOS) + 1,
				@codCliente INT = (SELECT MAX(codCliente)
												  FROM CLIENTES) + 1,
				@codOficina CHAR(6) = 'ALC-ES',
				@ciudadOficina VARCHAR(40) = 'Alicante',
				@paisOficina VARCHAR(50) = 'España',
				@codPostalOficina CHAR(5) = '03005',
				@telefonoOficina VARCHAR(15) = '633127448',
				@lineaDireccion1Oficina VARCHAR(100) = 'Calle Falsa, 123',
				@nombreEmpleado VARCHAR(50) = 'Juan',
				@apellido1Empleado VARCHAR(50) = 'León',
				@apellido2Empleado VARCHAR(50) = 'Medina',
				@tfnExtensionOfiEmpleado CHAR(5) = '633',
				@emailEmpleado VARCHAR(100) = 'depechejuan@gmail.com',
				@puestoCargoEmpleado VARCHAR(50) = 'CEO',
				@salarioEmpleado DECIMAL(9,2) = 5000.50,
				@nombreCliente VARCHAR(50) = 'Jardineria Leon',
				@nombreContactoCliente VARCHAR(50) = 'Gabriel',
				@apellidoContactoCliente VARCHAR(50) = 'Leon Medina',
				@telefonoCliente VARCHAR(12) = '666123456',
				@emailCliente VARCHAR(100) = 'gabileon10@gmail.com',
				@lineaDireccion1Cliente VARCHAR(100) = 'Calle Verdadera 123',
				@ciudadCliente VARCHAR(50) = 'Alicante',
				@paisCliente VARCHAR(50) = 'España',
				@codPostalCliente CHAR(5) = '03001',
				@limiteCreditoCliente DECIMAL(9,2) = 10000000

IF  EXISTS(SELECT * FROM OFICINAS WHERE codOficina = @codOficina)
BEGIN
	PRINT 'ERROR: Esta oficina ya está creada'
	RETURN
END

SET IMPLICIT_TRANSACTIONS OFF
BEGIN TRY
	INSERT INTO OFICINAS
				VALUES	(@codOficina, @ciudadOficina, @paisOficina, 
								@codPostalOficina, @telefonoOficina, @lineaDireccion1Oficina, 
								NULL)

	INSERT INTO EMPLEADOS
				VALUES	(@codEmpleado, @nombreEmpleado, @apellido1Empleado,
								@apellido2Empleado, @tfnExtensionOfiEmpleado, @emailEmpleado,
								@puestoCargoEmpleado, @salarioEmpleado, @codOficina, 
								NULL)

	INSERT INTO CLIENTES
				VALUES	(@nombreCliente, @nombreContactoCliente, @apellidoContactoCliente,
								@telefonoCliente, @emailCliente, @lineaDireccion1Cliente,
								@ciudadCliente, @paisCliente, @codPostalCliente,
								NULL, @limiteCreditoCliente)

	UPDATE CLIENTES
		  SET codEmpl_ventas = @codEmpleado
	WHERE codCliente = @codCliente

	COMMIT
END TRY

BEGIN CATCH
	ROLLBACK
	PRINT ERROR_NUMBER()
	PRINT ERROR_MESSAGE()
	PRINT ERROR_LINE()
	PRINT ERROR_PROCEDURE()
END CATCH
SET IMPLICIT_TRANSACTIONS ON


EXEC sp_columns EMPLEADOS
EXEC sp_columns OFICINAS
EXEC sp_columns CLIENTES




-------------------------------------------------------------------------------------------
-- 8. Utilizando la BD JARDINERIA, crea un script que realice las siguientes operaciones:
--	Importante: debes utilizar TRY/CATCH y Transacciones si fueran necesarias.
--
--		Debes eliminar la oficina, el empleado y el cliente creados en el apartado anterior.
--		Debes crear variables con los identificadores de clave primaria para eliminar
--			todos los datos de cada una de las tablas en una sola ejecución
-------------------------------------------------------------------------------------------




-------------------------------------------------------------------------------------------
-- 9. Utilizando la BD JARDINERIA, crea un script que realice lo siguiente:
--		Crea un nuevo cliente (invéntate los datos). No debes indicar directamente el código, 
--			sino buscar cuál le tocaría con una SELECT y guardarlo en una variable.

--		Crea un nuevo pedido para dicho cliente (fechaPedido será la fecha actual, fecha esperada 10 días 
--				después de la fecha de pedido, fecha entrega y comentarios a NULL y estado PENDIENTE)
--			Dicho pedido debe constar de dos productos (los códigos de producto se declaran como variables y se utilizan después)
--			El precio de cada producto debes obtenerlo utilizando SELECT antes de insertarlo en DETALLE_PEDIDOS,
--			de tal manera que, si modificamos los códigos de producto, el script seguirá funcionando.
--			La cantidad de los productos comprados puede ser la que tú quieras.

--		Recuerda que debes utilizar TRANSACCIONES (si fueran necesarias) y TRY/CATCH

--		Reto opcional:
--			Crea también un nuevo pago para dicho cliente cuyo importe coincida con lo que cuesta el pedido completo
--				Puedes indicar directamente el idtransaccion como 'ak-std-000026', aunque es mejor que lo obtengas dinámicante
--				utilizando funciones de SQL Server (piensa que los 6 últimos caracteres son números...)
--				Forma de pago debe ser: 'PayPal' y Fechapago la del día
-------------------------------------------------------------------------------------------


