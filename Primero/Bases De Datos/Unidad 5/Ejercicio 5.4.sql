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
  FROM PEDIDOS P, ESTADOS_PEDIDO EP
 WHERE EP.codEstado = ''

 SELECT * FROM ESTADOS_PEDIDO

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los 
-- pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.

-- Utilizando la función DATEADD
SELECT ;

-- 11. Misma consulta pero utilizando la función DATEDIFF
SELECT ;

-- 12. Devuelve un listado de todos los pedidos que fueron rechazados en 2022
SELECT ;

-- 13. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año
SELECT ;

-- 14. Devuelve un listado con todos los pagos que se realizaron en el año 2022 mediante Paypal. Ordena el resultado de mayor a menor
SELECT ;

-- 15. Devuelve un listado con todas las formas de pago que aparecen en la tabla PAGOS. Ten en cuenta que no deben aparecer formas de pago repetidas.
SELECT ;

-- 16. Devuelve un listado con todos los productos que pertenecen a la categoría Ornamentales y que tienen más de 100 unidades en stock.
-- El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
SELECT ;

-- 17. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30
SELECT ;

----------------------------------------------------------------
-- B) Consultas de agrupación o de funciones de agregado (18) --
----------------------------------------------------------------

-- 18. ¿Cuántos empleados hay en la compañía?
SELECT ;

-- 19. ¿Cuántos clientes tiene cada país?
SELECT ;

-- 20. ¿Cuál fue el pago medio de 2022?
SELECT ;

-- 21. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT ;

-- 22. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT ;

-- 23. ¿Cuántos clientes tiene la ciudad de Madrid?
SELECT ;

-- 24. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT ;

-- 25. Devuelve el código de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT ;

-- 26. Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT ;

-- 27. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT ;

-- 28. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos
SELECT ;

-- 29. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno.
-- El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT ;

-- 30. Obtener el número de empleados por oficina, siempre que el número de empleados sea mayor que 4.
SELECT ;

-- 31. Obtener los clientes que hayan realizado más de dos pagos de mínimo 1000 euros.
-- Mostrar también el número de pagos realizados.
SELECT ;

----------------------------------------------------------------
--				C) Consultas multitabla (10)				  --
----------------------------------------------------------------

-- 32. Obtén los nombres de los productos, la cantidad y el precio para los productos incluidos en los pedidos 3 y 5. Ordénalo por número de pedido y número de producto ascendentemente.
SELECT ;

-- 33. Obtén un listado con los nombres de los clientes que han realizado algún pago. Deben aparecer los campos nombre cliente, fecha de pago y total ordenado ascendentemente por cliente y fecha.
SELECT ;

-- 34. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
SELECT ;

-- 35. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas. Solo deben aparecer una vez.
SELECT ;

-- 36. Devuelve el nombre de los clientes que han hecho pedidos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT ;

-- 37. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
SELECT ;

-- 38. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes (debes utilizar dos alias para la tabla EMPLEADOS).
SELECT ;

-- 39. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido. Si se han retrasado varios pedidos, el cliente solo debe aparecer una vez.
SELECT ;

-- 40. Muestra el nombre de los clientes y el número de pagos que han realizado.
-- Deben aparecer todos, independientemente de si han realizado un pago o no.
SELECT ;

-- 41. Muestra el nombre de los clientes y el número de pedidos que han sido Entregados.
-- Deben aparecer todos, independientemente de si han realizado un pedido o no.
SELECT ;


