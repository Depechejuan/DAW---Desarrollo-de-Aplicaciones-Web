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