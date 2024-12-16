		-----------------------------------------------------
		-- Ejercicio 5.4. Escribe las siguientes consultas
		--					utilizando la BD JARDINERIA
		-----------------------------------------------------

					--------------------------
					--		CONSULTAS	    --
					--------------------------

---------------------------------------
-- A) Consultas sobre una tabla (16) --
---------------------------------------
USE JARDINERIA

-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
SELECT codOficina, pais
  FROM OFICINAS
 ORDER BY pais ASC

-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas del país España.
SELECT ciudad, telefono
  FROM OFICINAS
 WHERE pais = 'España'

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
SELECT nombre, apellido1, apellido2, email
  FROM EMPLEADOS
 WHERE codEmplJefe = 7
 ORDER BY codEmplJefe ASC

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del empleado que NO tiene ningún jefe/a
SELECT puesto_cargo, nombre, apellido1, apellido2, email
  FROM EMPLEADOS
 WHERE codEmplJefe IS NULL

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
SELECT nombre, apellido1, apellido2, puesto_cargo
  FROM EMPLEADOS
 WHERE puesto_cargo <> 'Representante Ventas'



-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
SELECT nombre_cliente
  FROM CLIENTES
 WHERE pais = 'Spain'

-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
SELECT DISTINCT codEstado, descripcion
  FROM ESTADOS_PEDIDO

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2023.
-- Ten en cuenta que deberás eliminar aquellos códigos de cliente que aparezcan repetidos.
SELECT DISTINCT C.codCliente
  FROM CLIENTES C, PAGOS P
 WHERE P.fechaHora_pago < '2024'
 GROUP BY c.codCliente

-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
SELECT codPedido, codCliente, fecha_esperada, fecha_entrega
  FROM PEDIDOS
 WHERE fecha_esperada > fecha_pedido


-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los 
-- pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- Utilizando la función DATEADD
SELECT p.codPedido, p.codCliente, p.fecha_esperada, p.fecha_entrega
FROM PEDIDOS P
 WHERE p.fecha_entrega <= DATEADD(DAY, -2, p.fecha_esperada)
 ORDER BY p.codCliente

-- 11. Misma consulta pero utilizando la función DATEDIFF
SELECT p.codPedido, p.codCliente, p.fecha_esperada, p.fecha_entrega
FROM PEDIDOS P
 WHERE DATEDIFF(day, p.fecha_entrega, p.fecha_esperada) >= 2
 ORDER BY p.codCliente

-- 12. Devuelve un listado de todos los pedidos que fueron rechazados en 2022
SELECT *
  FROM PEDIDOS P
 WHERE codEstado = 'R' AND YEAR(p.fecha_pedido) <= 2022

-- 13. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año
SELECT *
  FROM PEDIDOS P
 WHERE MONTH(p.fecha_entrega) = 01

-- 14. Devuelve un listado con todos los pagos que se realizaron en el año 2022 mediante Paypal. Ordena el resultado de mayor a menor
SELECT codCliente, codFormaPago, fechaHora_pago
  FROM PAGOS
 WHERE YEAR(fechaHora_pago) = 2022 AND codFormaPago = 'P'

-- 15. Devuelve un listado con todas las formas de pago que aparecen en la tabla PAGOS. Ten en cuenta que no deben aparecer formas de pago repetidas.
SELECT DISTINCT codFormaPago 
  FROM PAGOS

-- 16. Devuelve un listado con todos los productos que pertenecen a la categoría Ornamentales y que tienen más de 100 unidades en stock.
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT *
  FROM PRODUCTOS
 WHERE codCategoria = 'OR' AND cantidad_en_stock > 100
 ORDER BY precio_venta DESC

-- 17. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30
SELECT codCliente, nombre_cliente, ciudad, codEmpl_ventas
  FROM CLIENTES C
 WHERE ciudad = 'Madrid' AND codEmpl_ventas = 11 OR codEmpl_ventas = 30

----------------------------------------------------------------
-- B) Consultas de agrupación o de funciones de agregado (18) --
----------------------------------------------------------------

-- 18. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(codEmpleado) AS TotalEmpleados
  FROM EMPLEADOS

-- 19. ¿Cuántos clientes tiene cada país?
SELECT COUNT(codCliente) AS TotalClientes, pais
  FROM CLIENTES
 GROUP BY pais
 ORDER BY pais --ASC

-- 20. ¿Cuál fue el pago medio de 2022?
SELECT ROUND(AVG(importe_pago), 2) AS Average
  FROM PAGOS
 WHERE YEAR(fechaHora_pago) = 2022


-- 21. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT COUNT(codEstado) AS TotalPedidos, codEstado
  FROM PEDIDOS
 GROUP BY codEstado
 ORDER BY TotalPedidos DESC

-- 22. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT TOP(1) precio_venta AS HigherPrice,
		(SELECT TOP(1) precio_venta 
	 	   FROM PRODUCTOS
		  ORDER BY precio_venta ASC) AS LowerPrice
  FROM PRODUCTOS
 ORDER BY HigherPrice DESC

SELECT  MAX(precio_venta) AS MaxPrecio, MIN(precio_venta) AS MinPrecio
  FROM PRODUCTOS

-- 23. ¿Cuántos clientes tiene la ciudad de Madrid?
SELECT COUNT(codCliente) TotalClientes, ciudad
  FROM CLIENTES
 WHERE ciudad = 'Madrid'
 GROUP BY ciudad

-- 24. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT COUNT(codCliente) AS TotalClientes, ciudad
  FROM CLIENTES
 WHERE ciudad LIKE 'm%'
 GROUP BY ciudad

-- 25. Devuelve el código de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT E.codEmpleado, E.nombre, COUNT(C.codCliente) AS TotalClientes
  FROM EMPLEADOS E, CLIENTES C
 WHERE C.codEmpl_ventas = E.codEmpleado
 GROUP BY E.codEmpleado, E.nombre

-- 26. Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT *
  FROM CLIENTES
 WHERE codEmpl_ventas IS NULL

-- 27. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT codPedido, COUNT(codPedido) AS TotalProductos
  FROM DETALLE_PEDIDOS
 GROUP BY codPedido

-- 28. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos
SELECT codPedido, COUNT(codPedido) AS TotalProductos, SUM(precio_unidad) AS PrecioTotal
  FROM DETALLE_PEDIDOS
 GROUP BY codPedido

-- 29. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno.
-- El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT TOP(20) DP.codProducto, COUNT(DP.codProducto) AS VentasPorLinea, SUM(DP.cantidad) AS TotalVentas, P.nombre
  FROM PRODUCTOS P JOIN DETALLE_PEDIDOS DP ON P.codProducto = DP.codProducto
 GROUP BY DP.codProducto, P.nombre
 ORDER BY TotalVentas DESC

-- 30. Obtener el número de empleados por oficina, siempre que el número de empleados sea mayor que 4.
SELECT COUNT(E.codEmpleado) AS TotalEmpleados, O.codOficina
  FROM EMPLEADOS E JOIN OFICINAS O ON E.codOficina =  O.codOficina
 GROUP BY O.codOficina
HAVING COUNT(E.codEmpleado) > 4

-- 31. Obtener los clientes que hayan realizado más de dos pagos de mínimo 1000 euros.
-- Mostrar también el número de pagos realizados.
SELECT P.codCliente, C.nombre_cliente
  FROM PAGOS P RIGHT JOIN CLIENTES C ON c.codCliente = p.codCliente
 WHERE P.importe_pago > 1000
 GROUP BY P.codCliente, C.nombre_cliente
HAVING COUNT(P.codCliente) > 2
 ORDER BY P.codCliente ASC
----------------------------------------------------------------
--				C) Consultas multitabla (10)				  --
----------------------------------------------------------------

-- 32. Obtén los nombres de los productos, la cantidad y el precio para los productos incluidos en los pedidos 3 y 5.
-- Ordénalo por número de pedido y número de producto ascendentemente.
SELECT P.codProducto, P.nombre, DP.cantidad, P.precio_venta
  FROM PRODUCTOS P JOIN DETALLE_PEDIDOS DP ON P.codProducto = DP.codProducto
 WHERE DP.codPedido = 3 OR DP.codPedido = 5
 ORDER BY DP.codPedido, DP.codProducto ASC

SELECT d.codPedido, d.codProducto, p.nombre, p.precio_venta
  FROM DETALLE_PEDIDOS d,
			PRODUCTOS P
 WHERE d.CodProducto = P.codProducto AND d.codPedido IN (3,5)
 ORDER BY d.codPedido, d.codProducto ASC

-- 33. Obtén un listado con los nombres de los clientes que han realizado algún pago.
-- Deben aparecer los campos nombre cliente, fecha de pago y total ordenado ascendentemente por cliente y fecha.
SELECT C.nombre_cliente, P.fechaHora_pago, P.importe_pago
  FROM CLIENTES C, PAGOS P
 WHERE P.codCliente = C.codCliente
 ORDER BY C.nombre_cliente ASC, P.fechaHora_pago ASC

-- 34. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT C.nombre_cliente, E.nombre AS NombreEmpleado, E.apellido1 AS ApellidoEmpleado
  FROM CLIENTES C, EMPLEADOS E
 WHERE C.codEmpl_ventas = E.codEmpleado

-- 35. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
-- Solo deben aparecer una vez.
SELECT DISTINCT C.nombre_cliente, E.nombre
  FROM PAGOS P, CLIENTES C JOIN EMPLEADOS E ON C.codEmpl_ventas = E.codEmpleado
 WHERE P.codCliente = C.codCliente

-- 36. Devuelve el nombre de los clientes que han hecho pedidos
-- y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT DISTINCT C.nombre_cliente, E.nombre, O.ciudad AS CiudadOficina
  FROM PAGOS P, OFICINAS O, CLIENTES C JOIN EMPLEADOS E ON C.codEmpl_ventas = E.codEmpleado
 WHERE P.codCliente = C.codCliente AND E.codOficina = O.codOficina

-- 37. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT DISTINCT O.linea_direccion1
  FROM CLIENTES C JOIN EMPLEADOS E ON c.codEmpl_ventas = E.codEmpleado JOIN OFICINAS O ON E.codOficina = O.codOficina
 WHERE C.ciudad = 'Fuenlabrada'

-- 38. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes
-- (debes utilizar dos alias para la tabla EMPLEADOS).
SELECT nombre AS Empleado, (SELECT nombre FROM EMPLEADOS WHERE codEmpleado = codEmplJefe) AS Jefe
  FROM EMPLEADOS 
 
SELECT nombre AS Empleado, 
   FROM EMPLEADOS JOIN emp

-- 39. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido. Si se han retrasado varios pedidos, el cliente solo debe aparecer una vez.
SELECT ;

-- 40. Muestra el nombre de los clientes y el número de pagos que han realizado.
-- Deben aparecer todos, independientemente de si han realizado un pago o no.
SELECT ;

-- 41. Muestra el nombre de los clientes y el número de pedidos que han sido Entregados.
-- Deben aparecer todos, independientemente de si han realizado un pedido o no.
SELECT ;


