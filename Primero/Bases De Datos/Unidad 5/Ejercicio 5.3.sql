		-----------------------------------------------------
		-- Ejercicio 5.3. Escribe las siguientes consultas
		--					utilizando la BD TIENDA
		-----------------------------------------------------

					--------------------------
					--		CONSULTAS	    --
					--------------------------


USE TIENDA
GO

SELECT *
  FROM PRODUCTO
SELECT *
  FROM FABRICANTE

-- 1. Calcula el n�mero total de productos que hay en la tabla productos.
SELECT COUNT(codigo) AS TotalProductos
  FROM PRODUCTO

-- 2. Calcula el n�mero de valores distintos de c�digo de fabricante aparecen en la tabla productos.
SELECT COUNT(DISTINCT codigo_fabricante)
  FROM PRODUCTO

-- 3. Calcula la media del precio de todos los productos.
SELECT AVG(precio) AS MediaPrecio
  FROM PRODUCTO

-- 4. Calcula el precio m�s barato de todos los productos.
SELECT MIN(precio) AS LowerPrice
  FROM PRODUCTO

SELECT TOP(1) *
  FROM PRODUCTO
 ORDER BY precio ASC

-- 5. Calcula el precio m�s caro de todos los productos.
SELECT MAX(precio) AS MaxPrice
  FROM PRODUCTO

SELECT TOP(1) *
  FROM PRODUCTO
 ORDER BY precio DESC

-- 6. Calcula la suma de los precios de todos los productos.
SELECT SUM(precio) AS SumaPrecio
  FROM PRODUCTO

-- 7. Calcula el precio m�s barato de todos los productos del fabricante Asus.
SELECT MIN(precio) AS LowerPrice
  FROM PRODUCTO
 WHERE codigo_fabricante = 1
 -- Se puede hacer mejor

 SELECT MIN(P.precio) AS LowerPrice, F.nombre AS Fabricante
   FROM PRODUCTO P
   JOIN FABRICANTE F ON P.codigo_fabricante = F.codigo
 GROUP BY F.nombre


-- 8. Calcula la suma de todos los productos del fabricante Asus.
SELECT SUM(precio) AS SumaPrecio
  FROM PRODUCTO
 WHERE codigo_fabricante = 1

-- 9. Muestra el precio m�ximo, precio m�nimo, precio medio y el n�mero total de productos que tiene el fabricante Crucial.
SELECT COUNT(codigo) AS CountClientes, MAX(precio) AS MaxPrice,
		MIN(precio) AS MinPrice, AVG(precio) AS AvgPrice
  FROM PRODUCTO
 WHERE codigo_fabricante = 6


-- 10. Calcula el n�mero de productos que tienen un precio mayor o igual a 180�.
SELECT COUNT(codigo)
  FROM PRODUCTO
 WHERE precio >= 180

-- 11. Calcula el n�mero de productos que tiene cada fabricante con un precio mayor o igual a 180�.
SELECT F.nombre AS Fabricante, COUNT(P.codigo)
  FROM PRODUCTO P
  JOIN FABRICANTE F ON F.codigo = P.codigo_fabricante
 WHERE P.precio >= 180
 GROUP BY F.nombre
 ORDER BY F.nombre DESC


-- 12. Lista el precio medio los productos de cada fabricante.
SELECT codigo_fabricante, AVG(precio) AS AvgPrice
  FROM PRODUCTO
 GROUP BY codigo_fabricante
 ORDER BY AvgPrice DESC

 SELECT F.nombre AS Fabricante, AVG(P.precio) AS AvgPrice
  FROM PRODUCTO P
       JOIN FABRICANTE F ON P.codigo_fabricante = F.codigo
 GROUP BY F.nombre
 ORDER BY AvgPrice DESC;

-- 13. Lista el c�digo de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150�.
SELECT F.nombre AS Fabricante, AVG(P.precio) AS AvgPrice
  FROM PRODUCTO P
  JOIN FABRICANTE F ON P.codigo_fabricante = F.Codigo
 GROUP BY F.nombre
HAVING AVG(P.Precio) >= 150
 ORDER BY AvgPrice DESC

-- 14. Devuelve un listado con los c�digos de los fabricantes que tienen 2 o m�s productos.
SELECT F.nombre AS Fabricante, COUNT(P.codigo) AS CountProductos
  FROM PRODUCTO P
 JOIN FABRICANTE F ON P.codigo_fabricante = F.codigo
 GROUP BY F.nombre
HAVING COUNT(P.codigo) >= 2
 ORDER BY F.nombre

-- 15. Devuelve un listado con los c�digos de los fabricantes
-- y el n�mero de productos que tiene cada uno con un precio superior o igual a 220 �.
-- No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condici�n.
-- Ejemplo del resultado esperado.
/*	codFabricante | NumProductos
	1				1
	2				2
	6				1			*/


SELECT F.Nombre, COUNT(P.codigo) AS NumProductos
  FROM PRODUCTO P
  JOIN FABRICANTE F ON P.codigo_fabricante = F.codigo
 WHERE precio >= 220
 GROUP BY F.nombre
HAVING COUNT(P.codigo) >= 2

/*  ARREGLA ESTO:
SELECT F.nombre AS Fabricante, COUNT(P.codigo)
  FROM PRODUCTO P
  JOIN FABRICANTE F ON P.codigo_fabricante = F.codigo
 WHERE P.precio >= 220
 GROUP BY P.codigo
 ORDER BY F.nombre 
*/


-- 16. Devuelve un listado con los c�digos de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 �.
SELECT codigo_fabricante, SUM(precio) AS SumPrecio
  FROM PRODUCTO
 GROUP BY codigo_fabricante
HAVING SUM(precio) > 1000
 ORDER BY precio

SELECT F.nombre, SUM(P.precio) AS SumPrecio
  FROM PRODUCTO P
  JOIN FABRICANTE F ON P.codigo_fabricante = F.codigo
 GROUP BY F.nombre
HAVING SUM(precio) > 1000
 ORDER BY precio


SELECT 
  FROM 
 -- con subconsulta
SELECT nombre
  FROM FABRICANTE
 WHERE codigo IN (SELECT codigo_fabricante
					FROM PRODUCTO
					GROUP BY codigo_fabricante
					HAVING SUM(precio) >800)

