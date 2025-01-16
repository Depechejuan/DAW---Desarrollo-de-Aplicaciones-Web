USE TIENDA
GO
SELECT *
  FROM FABRICANTE

SELECT nombre
  FROM FABRICANTE

SELECT codigo, nombre, codigo
  FROM FABRICANTE

  -- Se pueden hacer operaciones matemáticas con los campos
SELECT codigo * 3
  FROM FABRICANTE

SELECT codigo * 3 AS Codigox3
  FROM FABRICANTE

SELECT codigo * 3 Codigox3
  FROM FABRICANTE

  -- PRECIO * IVA devuelve una nueva columna con esa operación.

SELECT *
  FROM PRODUCTO;


USE JARDINERIA
GO
SELECT *
  FROM CLIENTES

SELECT 'Hola Mundo'

SELECT CONCAT('Mr/Mrs ', nombre_contacto,
			', ', apellido_contacto) AS FullName
  FROM CLIENTES


SELECT 'Hola Mundo', 
	CONCAT('Mr/Mrs ', nombre_contacto,
		', ', apellido_contacto) AS FullName
  FROM CLIENTES

SELECT LOWER(UPPER('Hola Mundo')) -- Como una cebolla, primero lo de dentro de los paréntesis y luego lo de fuera

SELECT 'Hola Mundo', 
	UPPER(CONCAT('Mr/Mrs ', nombre_contacto,
		', ', apellido_contacto)) AS FullName
  FROM CLIENTES

SELECT 'Hola Mundo', 
	CONCAT('Mr/Mrs ', nombre_contacto,
		', ', UPPER(apellido_contacto)) AS FullName
  FROM CLIENTES

SELECT TRIM(' Hola   Mundo  ')
SELECT RTRIM(' Hola   Mundo  ')
SELECT LTRIM(' Hola   Mundo  ')

-- No está en los apuntes
SELECT *
  FROM CLIENTES

SELECT LEFT(nombre_cliente, 4) -- Los 4 primeros caráteres de "nombre_cliente")
  FROM CLIENTES 

SELECT RIGHT(nombre_cliente, 4) -- Los 4 últimos carácteres de "nombre_cliente")
  FROM CLIENTES


-- SUBSTRING()
SELECT SUBSTRING(nombre_cliente, 3, 4) -- columna, desde donde empiezo, Cuantos carácteres añado
  FROM CLIENTES

  -- Longitud de la cadena (INT)
SELECT LEN(nombre_cliente)
  FROM CLIENTES

SELECT REPLACE('Hola Mundo', 'Hola', 'Adios')

SELECT REPLACE(pais, 'Spain', 'España')
  FROM CLIENTES


SELECT REPLACE(REPLACE(pais, 'Spain', 'España'), 'USA', 'Estados Unidos') AS Pais
  FROM CLIENTES


SELECT 56.987
SELECT FLOOR(56.987) -- redondeo a la baja
SELECT ROUND(56.987, 2) -- el numero a redondear, y cuantos decimales - Usa redondeo positivo (Siempre)

SELECT POWER(2, 8) -- Numero, y elevado a 

SELECT RAND()
SELECT FLOOR(RAND()*10)

-- FECHAS
USE JARDINERIA
GO
SELECT *
  FROM PEDIDOS

SELECT '2020-07-21'
SELECT YEAR('2020-02-31') -- Solo fechas válidas y en formato YYYY-MM-DD
-- MONTH Y DAY para fechas de mes/dia -> devuelve INT, por lo que el mes 09,devuelve 9 (dia =)

SELECT DATEADD(year, 1, '20191230'); -->  Suma X a la fecha.
SELECT DATEADD(day, 15, '20191230');  --> Caso: 15 días para devolver el libro

SELECT DATEDIFF(year, '20060730', '20100830'); --> Diferencia de días entre una fecha y otra. Influye el orden. Pon primero la menor y luego mayor
SELECT DATEDIFF(day, '1986-07-21', '2024-11-19')





-- WHERE

SELECT *
  FROM CLIENTES
 WHERE codCliente = 1 OR codCliente = 5

 -- Si no quieres usar mil "OR"

 SELECT *
  FROM CLIENTES
 WHERE codCliente IN (1, 5, 15, 30, 40) -- Usas el "IN" para marcar OR y dentro del paréntesis los códigos deseados


  SELECT *
  FROM CLIENTES
 WHERE codCliente BETWEEN 5 AND 10 -- codCliente >= 5 AND codCliente <= 10;


SELECT *
  FROM CLIENTES
 WHERE codCliente BETWEEN 5 AND 10
   AND LEFT(nombre_cliente, 1) = 'N'

SELECT *
  FROM CLIENTES
 WHERE codCliente BETWEEN 5 AND 10 -- codCliente >= 5 AND codCliente <= 10;
   AND LEFT(nombre_cliente, 2) = 'Na'



SELECT *
  FROM CLIENTES
 WHERE codCliente BETWEEN 5 AND 10  --> No es necesario en esta consulta, solo por jugar
ORDER BY nombre_cliente, nombre_contacto DESC -- Orden DESCENDENTE, prioriza el primero


SELECT *
  FROM CLIENTES
 WHERE codCliente BETWEEN 5 AND 10
ORDER BY nombre_cliente DESC, nombre_contacto ASC


-------------
--  día 2  --
-------------


--- TOP / LIKE / ORDER BY

SELECT TOP(5)*
  FROM PRODUCTO

  SELECT TOP 5*
  FROM PRODUCTO

SELECT *
  FROM PRODUCTO
ORDER BY precio ASC
-- Si no pones nada en ORDER BY, es asc
SELECT *
  FROM PRODUCTO
ORDER BY precio DESC


SELECT TOP(1) *
  FROM PRODUCTO
ORDER BY precio DESC
SELECT TOP(1) *
  FROM PRODUCTO
ORDER BY precio


SELECT *
  FROM PRODUCTO
ORDER BY nombre ASC, precio DESC

-- Cadena que empieza por...
SELECT *
  FROM PRODUCTO
  WHERE LOWER(LEFT(nombre, 5)) = 'disco'
  -- Primero sacas LOS 5 PRIMEROS y luego LOWER a esos 5, es más óptimo (así no conveirtes TODO 'nombre')

-- Cadena que acaba por...
SELECT *
  FROM PRODUCTO
  WHERE LOWER(RIGHT(nombre, 3)) = '1tb'

-- Uso de "LIKE", no sabes por dónde está el caracter que quieres buscar.
 -- A la base de datos le cuesta el LIKE
 -- Cadena que contenga....
SELECT *
  FROM PRODUCTO
 WHERE nombre LIKE '%HP%'

 -- % comodín indefinido (como cex)
 -- _ comodín sólo 1 
 -- EJEMPLO: '_TB'

 SELECT * 
   FROM FABRICANTE
 WHERE nombre LIKE '____'


 ---
 -- Obtener el count de todos los productos
 SELECT COUNT(*)
   FROM PRODUCTO

SELECT MIN(precio)
  FROM PRODUCTO

  
SELECT MAX(precio)
  FROM PRODUCTO

  
SELECT AVG(precio)
  FROM PRODUCTO


SELECT SUM(precio)
  FROM PRODUCTO


SELECT MAX(precio), MIN(precio), COUNT(precio)
  FROM PRODUCTO

-- Si usas count,es preferible pasar la PK. Si pasas precio y hay 2 iguales, sólo contaría 1. 
SELECT COUNT(codigo)
  FROM PRODUCTO


  --- NULLS

-- Muestra clientes que NO TENGAN Dirección 2
SELECT *
  FROM CLIENTES
 WHERE linea_direccion2 IS NULL

 -- Muestra clientes que SI TENGAN dirección 2
SELECT *
 FROM CLIENTES
WHERE linea_direccion2 IS NOT NULL

-- No usar el igual (=)

SELECT COUNT(codCliente)
  FROM CLIENTES

SELECT AVG(limite_credito)
  FROM CLIENTES

SELECT SUM(limite_credito)
  FROM CLIENTES

SELECT MAX(limite_credito) AS MaxCredito, 
		MIN(limite_credito) AS MinCredit,
		AVG(limite_credito) AS AverageCredit,
		SUM(limite_credito) AS SumaCredito,
		COUNT(codCliente) AS TotalClientes
  FROM CLIENTES

SELECT MAX(limite_credito) AS MaxCredit
  FROM CLIENTES
 WHERE pais = 'Spain'


SELECT pais, MAX(limite_credito) AS MaxCredit
  FROM CLIENTES
 GROUP BY pais -- Agrupar por
 ORDER BY MaxCredit DESC -- Si quieres organizarlo por la columna creada, hay que darle un Alias


SELECT pais, COUNT(codCliente) AS NumClientes
  FROM CLIENTES
 WHERE linea_direccion2 IS NOT NULL
 GROUP BY pais
HAVING COUNT(codCliente) >= 4 -- Aqui NO se usa el ALIAS
 ORDER BY NumClientes DESC

 -- Having es un WHERE , pero para los campos agrupados (Despues de hacer la agrupación)

-- DISTINCT
-- Elimina aquellos registros que sean iguales.

SELECT DISTINCT pais, nombre_cliente
  FROM CLIENTES
 
USE TIENDA
GO

SELECT codigo, nombre
  FROM FABRICANTE
ORDER BY 1 ASC -- Esto es automático, igualmente NO PONGAS NUMEROS EN EL ORDER BY

SELECT codigo, nombre
  FROM FABRICANTE
 ORDER BY 7 DESC -- Esto peta


USE JARDINERIA
GO
-- Detectar duplicados. 
-- Coges todos los nombres, y agrupas por su nombre. Si hay dos iguales los muestra
SELECT nombre_cliente, COUNT(codCliente)
  FROM CLIENTES
 GROUP BY nombre_contacto
HAVING COUNT(codCliente) > 1


-----------
-- JOINS --
-----------


-- 9. Muestra el precio m�ximo, precio m�nimo, precio medio y el n�mero total de productos que tiene el fabricante Crucial.
SELECT COUNT(codigo) AS CountClientes, MAX(precio) AS MaxPrice,
		MIN(precio) AS MinPrice, AVG(precio) AS AvgPrice
  FROM PRODUCTO
 WHERE codigo_fabricante = 6

 -- No sabíamos el código de "Crucial", ahora, ¿Cómo lo hacemos sin saber qué código es "Crucial"?
SELECT F.codigo, F.nombre, COUNT(p.codigo)
  FROM PRODUCTO P,
	   FABRICANTE F
 WHERE P.codigo_fabricante = F.codigo
 GROUP BY F.codigo, f.nombre
 -- Agrupar siempre por PK + lo que quieras sacar.



USE JARDINERIA
SELECT *
  FROM CLIENTES
 WHERE linea_direccion2 IS NULL

SELECT *
  FROM CLIENTES
 WHERE linea_direccion2 IS NOT NULL

SELECT TOP(1)*
  FROM CLIENTES
 ORDER BY limite_credito DESC

SELECT MAX(limite_credito)
  FROM CLIENTES

SELECT MIN(limite_credito) AS MinCredit,
	   MAX(limite_credito) AS MaxCredit, 
	   SUM(limite_credito) AS SumCredit, 
	   AVG(limite_credito) AS AvgCredit, 
	   COUNT(codCliente) AS CodCliente,
	   pais
  FROM CLIENTES
GROUP BY pais


SELECT nombre_cliente, COUNT(p.codPedido) AS TotalPedidos
  FROM CLIENTES C,
	   PEDIDOS P
 WHERE C.codCliente = P.codCliente AND pais = 'Spain'
 GROUP BY c.nombre_cliente, c.codCliente
HAVING COUNT(p.codPedido) >= 6

-- pedidos que hay y estado en el que están codpedido, fecha pedido, cod estado

SELECT COUNT(EP.codEstado) AS Total, EP.descripcion
  FROM PEDIDOS P, ESTADOS_PEDIDO EP
 WHERE P.codEstado = EP.codEstado
 GROUP BY EP.codEstado, EP.descripcion

-- Forma más fácil
SELECT codEstado, COUNT(codPedido)
  FROM PEDIDOS
  GROUP BY codEstado



  -- Añadir nombre cliente
SELECT p.CodPedido, P.fecha_pedido, p.CodEstado,
	   e.descripcion, c.nombre_cliente
  FROM PEDIDOS p,
	   ESTADOS_PEDIDO e,
	   CLIENTES c
 WHERE p.codEstado = e.codEstado 
   AND p.codCliente = c.codCliente


--
-- pedidos -> clientes -- Join normal
--

SELECT p.codPedido, c.codCliente, c.nombre_cliente
  FROM CLIENTES C, 
		PEDIDOS P
 WHERE P.codCliente = C.codCliente

--
-- pedidos -> clientes -- Inner Join
--

SELECT p.codPedido, c.codCliente, c.nombre_cliente
  FROM CLIENTES C INNER JOIN PEDIDOS P
    ON C.codCliente = p.codCliente
   AND p.codPedido BETWEEN 1 AND 50
   -- Where no iría aquí, sino un AND para evitar historias

   -- LEFT JOIN
SELECT C.codCliente, COUNT(p.codPedido) AS numPedidos
  FROM CLIENTES C LEFT JOIN PEDIDOS P ON c.codCliente = p.codCliente
 GROUP BY c.codCliente
 -- El right join es solo cambiar de lado el FROM
 --FROM PEDIDOS P RIGHT JOIN CLIENTES C ON C.codCliente = p.codCliente

 -- NO SALDRIA TODO
SELECT p.codCliente, COUNT(p.codPedido) AS numPedidos
  FROM CLIENTES C LEFT JOIN PEDIDOS P ON c.codCliente = p.codCliente
 GROUP BY p.codCliente
 -- Hay que agrupar SIEMPRE por el lado que tenga los datos completos (En este caso, sería clientes)


 -- La suma de productos que no se hayan vendido, no da0 sino NULL- Usar ISNULL y valor 0
SELECT p.codProducto, p.nombre, ISNULL(SUM(dp.cantidad), 0) AS sumCantidad
  FROM PRODUCTOS P LEFT JOIN DETALLE_PEDIDOS DP ON P.codProducto = DP.codProducto
 GROUP BY p.codProducto, p.nombre

SELECT c.codCliente, c.nombre_cliente, c.linea_direccion1, ISNULL(c.linea_direccion2, '')
  FROM CLIENTES C
SELECT c.codCliente, c.nombre_cliente, c.linea_direccion1, ISNULL(c.linea_direccion2, 'No Adress')
  FROM CLIENTES C




-- UNION, INTERSECCIÓN Y DIFERENCIA
-- {1, 3, 5} UNION  {1, 5} -> resultado { 1, 3, 5}
-- No son números, sino registros. El registro 1 es igual al registro 1 del de abajo.
-- UNION ALL {1,3,5,1,5} <- es lo mismo como están en los dos sitios, los repite

-- INTERSECCIÓN:
-- - {1, 3, 5} INTERSECT  {1, 5} -> {1,5} tiene que ver mucho con el AND

-- DIFERENCIA (En Oracle se utiliza "Minus"
-- No es una resta, sino la diferencia de elementos entre dos conjuntos
 -- - {1, 3, 5} EXCEPT  {1, 5} ->  {3} -> si está en ambas, se quita.

 SELECT codCliente
   FROM CLIENTES
 WHERE codCliente IN (1,3,5)
--UNION 
-- UNION ALL 
--INTERSECT
-- EXCEPT
SELECT codCliente
  FROM CLIENTES
 WHERE codCliente IN (1,5)


 -- esto falla, ¿por qué?
-- ARRIBA TENEMOS LA MUESTRA GRANDE Y ABAJO EL FILTRAJE.
SELECT codCliente
  FROM CLIENTES
 WHERE codCliente IN (1,5)
-- UNION 
-- UNION ALL 
-- INTERSECT
EXCEPT
SELECT codCliente
  FROM CLIENTES
 WHERE codCliente IN (1,3,5)

 -- Si la consulta de arriba no es igual que la consulta de abajo, va a petar.
 SELECT codCliente, nombre_cliente
   FROM CLIENTES
 WHERE codCliente IN (1,3,5)
EXCEPT
SELECT codCliente
  FROM CLIENTES
 WHERE codCliente IN (1,5)

 -- Esto si funciona porque es lo mismo. son las mismas tablas
  SELECT *
   FROM CLIENTES
 WHERE codCliente IN (1,3,5)
EXCEPT
SELECT *
  FROM CLIENTES
 WHERE codCliente IN (1,5)


SELECT codCliente
  FROM CLIENTES
 EXCEPT
SELECT codCliente
  FROM PEDIDOS

  -- Clientes que NO han hecho pagos
SELECT codCliente
  FROM CLIENTES
EXCEPT
SELECT codCliente
  FROM PAGOS

 -- Que han hecho pedidos pero NO han hecho pagos.
SELECT codCliente
  FROM PEDIDOS
EXCEPT
SELECT codCliente
  FROM PAGOS


-- SUBCONSULTAS
SELECT * 
  FROM CLIENTES
 WHERE codCliente IN (1,3,5)
--- 1, 3, 5 son numeros magicos, pero y si quiero los clientes que han hecho pedidos?

SELECT *
  FROM CLIENTES
 WHERE codCliente IN (SELECT codCliente
										FROM PEDIDOS)

SELECT DISTINCT C.*
  FROM PEDIDOS P, CLIENTES C
 WHERE p.codCliente = c.codCliente

 SELECT DISTINCT C.*
  FROM PEDIDOS P JOIN CLIENTES C 
	  ON p.codCliente = c.codCliente


-- Ahora clientes que NO han hecho pedidos, tan fácil
SELECT *
  FROM CLIENTES
 WHERE codCliente NOT IN (SELECT codCliente
										FROM PEDIDOS)

SELECT c.codCliente
  FROM CLIENTES C LEFT JOIN PEDIDOS P ON c.codCliente = P.codCliente
GROUP BY c.codCliente
HAVING COUNT(p.CodPedido) = 0


-- Clientes que han hecho pedidos pero aún no han pagado
SELECT *
  FROM CLIENTES
 WHERE codCliente  IN (SELECT codCliente
										FROM PEDIDOS)
		AND codCliente NOT IN (SELECT codCliente FROM PAGOS)


-- 
SELECT AVG(importe_pago) AS importe
  FROM PAGOS;

 SELECT *
   FROM PAGOS
 WHERE importe_pago >= (SELECT AVG(importe_pago)
  FROM PAGOS)

  -- No funciona porque no hay agrupación/having
SELECT * FROM PAGOS WHERE importe_pago >= AVG(importe_pago)

-- todos los pagos mayores que el menor de los pagos
 SELECT *
   FROM PAGOS
 WHERE importe_pago > (SELECT MIN(importe_pago)
  FROM PAGOS)

-- El pago mayor
 SELECT *
   FROM PAGOS
 WHERE importe_pago >= (SELECT MAX(importe_pago)
  FROM PAGOS)


-- ALL y ANY
-- Consultas que devuelven varios registros y comparamos los de SELECT A y el SELECT B
-- ALL sería un AND y ANY es un OR.

 -- ALL = Si cumple la condición, aparece, sino, no aparece, de uno en uno del primero al último.
 -- Ejemplo: ¿Es 1000 mayor que ALL los valores? si o no? siguiente.... ¿Es X mayor que ALL los valores? si no? siguiente...

SELECT *
  FROM CLIENTES
 WHERE limite_credito > ANY (SELECT importe_pago
													FROM PAGOS
												  WHERE YEAR(fechaHora_pago) = 2022)
 -- Se utilizan cuando hay varios registros numéricos a comparar

-- Subconsultas con EXISTS
SELECT DISTINCT C.codCliente
   FROM CLIENTES C
 WHERE EXISTS (SELECT * FROM PEDIDOS P WHERE P.codCliente = c.CodCliente)