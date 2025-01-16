		-----------------------------------------------------
		-- Ejercicio 5.5. Escribe las siguientes consultas
		--					utilizando la BD JARDINERIA
		-----------------------------------------------------

					--------------------------
					--		CONSULTAS	    --
					--------------------------

-----------------------------------
-- A) Consultas de conjuntos (4) --
-----------------------------------

-- 1. Devuelve los códigos de los clientes que realizaron pedidos en 2022 y los clientes que realizaron pagos por transferencia. 
-- Utiliza la unión.

--SELECT C.codCliente
--  FROM CLIENTES C JOIN PAGOS P ON C.codCliente = P.codCliente
-- WHERE YEAR(p.fechaHora_pago) = 2022 AND P.codFormaPago = 'T'
-- GROUP BY C.codCliente

SELECT C.CodCliente
  FROM CLIENTES C, PAGOS P
 WHERE YEAR(p.fechaHora_pago) = 2022
 UNION
SELECT C.CodCliente
  FROM CLIENTES C, PAGOS P
 WHERE P.codFormaPago = 'T'

-- 2. Devuelve los códigos de los clientes que realizaron pedidos en 2022 y que también realizaron algún pago por transferencia.
-- Utiliza la intersección.

SELECT C.CodCliente
  FROM CLIENTES C, PAGOS P
 WHERE YEAR(p.fechaHora_pago) = 2022
INTERSECT
SELECT C.CodCliente
  FROM CLIENTES C, PAGOS P
 WHERE P.codFormaPago = 'T'

-- 3. Devuelve los códigos de los clientes que realizaron pedidos en 2022 PERO QUE NO los clientes que realizaron pagos
--por transferencia. Utiliza la diferencia.

SELECT C.CodCliente
  FROM CLIENTES C, PAGOS P
 WHERE YEAR(p.fechaHora_pago) = 2022
EXCEPT
SELECT C.CodCliente
  FROM CLIENTES C, PAGOS P
 WHERE P.codFormaPago = 'T'

-- 4. Propón el enunciado de una consulta de conjuntos y escribe la consulta SQL.
-- Selecciona todos los productos que no estén en la categoría "Frutales"
SELECT  PR.codProducto, PR.descripcion,  CP.nombre
  FROM PRODUCTOS PR, CATEGORIA_PRODUCTOS CP
EXCEPT
SELECT PR.codProducto, PR.descripcion, CP.nombre
  FROM PRODUCTOS PR, CATEGORIA_PRODUCTOS CP
 WHERE CP.nombre = 'Frutales'


----------------------------------
--    B) Subconsultas (20)      --
----------------------------------
-- Con operadores básicos de comparación

-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente, limite_credito
  FROM CLIENTES
 WHERE limite_credito >= (SELECT TOP(1) limite_credito 
											FROM CLIENTES
											ORDER BY limite_credito DESC)

-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre, precio_venta
  FROM PRODUCTOS
 WHERE precio_venta >= (SELECT TOP(1) precio_venta
											FROM PRODUCTOS
											ORDER BY precio_venta DESC)

-- 3. Devuelve el producto que más unidades tiene en stock. Si salen varios, quédate solo con uno.
SELECT TOP(1) *
  FROM PRODUCTOS
 WHERE cantidad_en_stock >= (SELECT TOP(1) cantidad_en_stock
													FROM PRODUCTOS
													ORDER BY cantidad_en_stock DESC)
 ORDER BY precio_venta DESC	

-- 4. Devuelve el producto que menos unidades tiene en stock.
SELECT TOP(1) *
  FROM PRODUCTOS
 WHERE cantidad_en_stock >= (SELECT TOP(1) cantidad_en_stock
													FROM PRODUCTOS
													ORDER BY cantidad_en_stock ASC)

-- 5. Devuelve el nombre, los apellidos y el email de los empleados cuyo jefe es Alberto Soria.
SELECT nombre, apellido1, apellido2, email
  FROM EMPLEADOS
 WHERE codEmplJefe = (SELECT codEmpleado
										FROM EMPLEADOS
										WHERE nombre ='Alberto' AND apellido1 = 'Soria')

-- 6. Propón el enunciado de una consulta de conjuntos y escribe la consulta SQL (puede ser de cualquier tipo, con IN, NOT IN, ALL, ANY, etc).
-- Devuelve todos los Empleados que trabajen en Madrid
SELECT *
  FROM EMPLEADOS
 WHERE codOficina = (SELECT codOficina
									FROM OFICINAS 
									WHERE ciudad = 'Madrid')


--------------------------------------------------------------------
--  Subconsultas con ALL y ANY  --
--  IMPORTANTE: NO UTILIZAR MAX o MIN en las subconsultas
--------------------------------------------------------------------

-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT nombre_cliente
  FROM CLIENTES
 WHERE limite_credito >= ALL (SELECT limite_credito
												FROM CLIENTES)

-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT nombre
  FROM PRODUCTOS
 WHERE precio_venta >= ALL (SELECT precio_venta
													FROM PRODUCTOS)

-- 3. Devuelve el producto que menos unidades tiene en stock.
SELECT *
  FROM PRODUCTOS
 WHERE cantidad_en_stock <= ALL (SELECT cantidad_en_stock
															FROM PRODUCTOS)


----------------------------------
-- Subconsultas con IN y NOT IN --
----------------------------------

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT *
  FROM CLIENTES C
 WHERE C.codCliente NOT IN (SELECT P.codCliente
													FROM PAGOS P)

-- 2. Devuelve un listado que muestre solamente los clientes que han realizado algún pago.
SELECT *
  FROM CLIENTES C
 WHERE C.codCliente IN (SELECT P.codCliente
													FROM PAGOS P) 

-- 3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT *
  FROM PRODUCTOS PR
 WHERE PR.codProducto NOT IN (SELECT DP.codProducto
														FROM DETALLE_PEDIDOS DP)

-- 4. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT E.nombre, E.apellido1, E.apellido2, E.puesto_cargo, E.tlf_extension_ofi
  FROM EMPLEADOS E
 WHERE E.codEmpleado NOT IN (SELECT codEmpl_ventas
														FROM  CLIENTES)

-- 5. Devuelve las oficinas donde trabajan alguno de los empleados.
SELECT *
  FROM OFICINAS 
 WHERE codOficina IN (SELECT codOficina
										FROM EMPLEADOS)

-- 6. Devuelve un listado con los clientes que han realizado algún pedido pero no que hayan realizado ningún pago.
SELECT *
  FROM CLIENTES
 WHERE codCliente IN (SELECT codCliente
										FROM PEDIDOS)
								AND codCliente NOT IN (SELECT codCliente
																		FROM PAGOS)

------------------------------------------
-- Subconsultas con EXISTS y NOT EXISTS --
------------------------------------------

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT *
  FROM CLIENTES C
 WHERE  NOT EXISTS (SELECT P.codCliente
										FROM PAGOS P
										WHERE P.codCliente = C.codCliente)


-- 2. Devuelve un listado que muestre solamente los clientes que han realizado algún pago.
SELECT *
  FROM CLIENTES C
 WHERE  EXISTS (SELECT P.codCliente
										FROM PAGOS P
										WHERE P.codCliente = C.codCliente)

-- 3. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT *
  FROM PRODUCTOS P
 WHERE NOT EXISTS (SELECT DP.codProducto
										FROM DETALLE_PEDIDOS DP
										WHERE DP.codProducto = P.codProducto)

-- 4. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
SELECT *
  FROM PRODUCTOS P
 WHERE EXISTS (SELECT DP.codProducto
										FROM DETALLE_PEDIDOS DP
										WHERE DP.codProducto = P.codProducto)

---------------------------
--		  Vistas		 --
---------------------------

-- 1. Crea una vista que devuelva los códigos de los clientes que realizaron pedidos en 2009 y los clientes que realizaron pagos por transferencia. Utiliza la unión.
CREATE VIEW VClientesPagosTransf AS
SELECT PE.codCliente
FROM PEDIDOS PE
WHERE YEAR(PE.fecha_pedido) = 2009
UNION
SELECT  PA.codCliente
FROM PAGOS PA
WHERE PA.codFormaPago = 'T';

-- 2. Escribe el código SQL para realizar una consulta a dicha vista
SELECT * FROM VClientesPagosTransf

-- 3. Escribe el código SQL para eliminar dicha vista.
DROP VIEW VClientesPagosTransf
