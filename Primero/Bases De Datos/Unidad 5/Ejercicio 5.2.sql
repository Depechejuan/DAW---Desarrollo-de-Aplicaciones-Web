		-----------------------------------------------------
		-- Ejercicio 5.2. Escribe las siguientes consultas
		--					utilizando la BD TIENDA
		-----------------------------------------------------

					--------------------------
					--		CONSULTAS	    --
					--------------------------
USE TIENDA
GO


-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT nombre
  FROM PRODUCTO


-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio
  FROM PRODUCTO

-- 3. Lista todas las columnas de la tabla producto.
SELECT *
  FROM PRODUCTO


-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a may�scula.
SELECT UPPER(nombre), precio
  FROM PRODUCTO


-- 5. Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a min�scula.
SELECT LOWER(nombre), precio
  FROM PRODUCTO


-- 6. Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en may�sculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre, UPPER(LEFT(nombre, 2)) AS abreviatura
  FROM FABRICANTE


-- 7. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio al primer decimal.
SELECT nombre, ROUND(precio, 1) AS PrecioRedondeado
  FROM PRODUCTO

-- 8. Lista los nombres y los precios de todos los productos de la tabla producto, truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre, FLOOR(precio) AS PrecioSinDecimales
  FROM PRODUCTO

-- 9. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre
  FROM FABRICANTE
 ORDER BY nombre ASC

-- 10. Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre
  FROM FABRICANTE
 ORDER BY nombre DESC

-- 11. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio
  FROM PRODUCTO
 ORDER BY nombre ASC, precio DESC

-- 12. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT TOP(5) *
  FROM FABRICANTE

-- 13. Lista el nombre de todos los productos del fabricante cuyo c�digo de fabricante es igual a 2.
SELECT nombre
  FROM PRODUCTO
 WHERE codigo_fabricante = 2

-- 14. Lista el nombre de los productos que tienen un precio menor o igual a 120�.
SELECT nombre
  FROM PRODUCTO
 WHERE precio <= 120

-- 15. Lista el nombre de los productos que tienen un precio mayor o igual a 400�.
SELECT nombre
  FROM PRODUCTO
 WHERE precio >= 400

-- 16. Lista el nombre de los productos que no tienen un precio mayor o igual a 400�.
SELECT nombre
  FROM PRODUCTO
 WHERE precio < 400

 SELECT nombre
   FROM PRODUCTO
 WHERE NOT precio >= 400 

-- 17. Lista todos los productos que tengan un precio entre 80� y 300�. Sin utilizar el operador BETWEEN.
SELECT *
  FROM PRODUCTO
 WHERE precio >= 80 AND precio <= 300

-- 18. Lista todos los productos que tengan un precio entre 60� y 200�. Utilizando el operador BETWEEN.
SELECT *
  FROM PRODUCTO
 WHERE precio >=60 AND precio <= 200

-- 19. Lista todos los productos donde el c�digo de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT *
  FROM PRODUCTO
 WHERE codigo_fabricante = 1
	OR codigo_fabricante = 3
	OR codigo_fabricante = 5

-- 20. Lista todos los productos donde el c�digo de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT *
  FROM PRODUCTO
 WHERE codigo_fabricante IN (1,3,5)

-- 21. Lista el nombre y el precio de los productos en c�ntimos (Habr� que multiplicar por 100 el valor del precio).
--		Crea un alias para la columna que contiene el precio que se llame c�ntimos.
SELECT nombre, FLOOR(precio*100) AS centimos
  FROM PRODUCTO


-- 22. Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre
  FROM FABRICANTE
 WHERE LEFT(nombre, 1) = 'S'


-- 23. Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre
  FROM FABRICANTE
 WHERE RIGHT(nombre, 1) = 'e'

-- 24. Lista los nombres de los fabricantes cuyo nombre contenga el car�cter w.
SELECT nombre
  FROM FABRICANTE
 WHERE nombre LIKE '%w%'

-- 25. Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre
  FROM FABRICANTE
 WHERE nombre LIKE '____'


 -- Esta mejor 
SELECT nombre
  FROM FABRICANTE
 WHERE LEN(nombre) = 4


-- 26. Devuelve una lista con el nombre de todos los productos que contienen la cadena Port�til en el nombre.
SELECT nombre
  FROM PRODUCTO
 WHERE nombre LIKE '%portátil%'

 -- Más óptimo para la tilde
SELECT nombre
 FROM PRODUCTO
WHERE nombre LIKE '%portátil%'
   OR nombre LIKE '%portatil%'

-- 27. Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 �.
SELECT *
  FROM PRODUCTO
 WHERE nombre LIKE '%Monitor%'
   AND precio < 215

-- 28. Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180�. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT nombre, precio
  FROM PRODUCTO
 WHERE precio >= 180
 ORDER BY precio DESC, nombre ASC